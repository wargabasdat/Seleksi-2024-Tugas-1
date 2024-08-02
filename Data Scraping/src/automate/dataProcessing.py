import json
from unidecode import unidecode


# PROCESSING FUNCTIONS
def process_player_info(data):
    player_data = []

    playerId = 1

    for d in data:
        playerinfo = d['player_info']
        playerinfo['player_id'] = playerId
        player_data.append(playerinfo)

        playerId += 1

    return player_data



def process_current_contract(data):
    contract_data = []
    
    playerId = 1
    
    for d in data:
        contract = d['current_contract']
        contract['contract_id'] = playerId
        contract['player_id'] = playerId
        
        
        contract_data.append(contract)

        playerId += 1

    return contract_data



def process_player_value(data):
    player_id = 1
    value_id = 1

    value_data = []

    for d in data:
        marketvalue = d['current_value']
        
        value_data.append({
            "value_id": value_id,
            "player_id": player_id,
            "market_value": marketvalue['current_value'],
            "update_date": marketvalue['last_update_date']
        })
        
        player_id += 1
        value_id += 1

    return value_data



def process_player_stats(data):
    field_player_stats = []
    goalkeeper_stats = []

    player_id = 1
    stats_id = 1
    
    for d in data:

        playerinfo = d['player_info']
        statsinfo = d['stats']
        
        if statsinfo:
            # Process Null Values
            for stat in statsinfo:
                for attribute, value in stat.items():
                    if value != 'Season' and (value is None or value == 0):
                        stat[attribute] = 0

            # Separating data

            # Add to the goalkeeper stats
            if playerinfo['position'] == 'Goalkeeper':
                for stats in statsinfo:
                    goalkeeper_stats.append({
                        "stats_id": stats_id,
                        "player_id": player_id,
                        "season": stats['season'],
                        "match_played": stats['matches_played'],
                        "minutes_played": stats['minutes_played'],
                        "goals_conceded": stats['goals_conceded'],
                        "clean_sheets": stats['clean_sheets'],
                    })
                    stats_id += 1
            
            else:
                for stats in statsinfo:
                    field_player_stats.append({
                        "stats_id": stats_id,
                        "player_id": player_id,
                        "season": stats['season'],
                        "match_played": stats['matches_played'],
                        "minutes_played": stats['minutes_played'],
                        "goals": stats['goals'],
                        "assists": stats['assists'],
                    })
                    stats_id += 1
                
        player_id += 1

    
    return field_player_stats, goalkeeper_stats



def process_player_transfer(data):
    transfer_data = []

    playerId = 1
    transferId = 1

    for d in data:
        transfers = d['transfer_history']
        
        for transfer in transfers:
            for attribute, value in transfer.items():
                if (attribute == 'market_value' or attribute == 'fee') and value is None:
                    transfer[attribute] = 0

            transfer['transfer_id'] = transferId
            transfer['player_id'] = playerId
            transferId += 1

        for transfer in transfers:
            transfer_data.append(transfer)
        
        playerId += 1

    return transfer_data



def process_player_awards(data):
    award_data = []
    player_award_data = []
    temp_award_names = []

    player_index = 1
    award_index = 1

    for d in data:
        
        awardinfo = d['awards']
        
        # Normalize year and organizer
        if awardinfo:
            for award in awardinfo:
                for attribute, value in award.items():
                    if attribute == "details":
                        for year in value:
                            year['year'] = normalize_year(year['year'])
                
                award['organizer'] = getOrganizer(award['award_name'])

            for award in awardinfo:
                if award['award_name'] not in temp_award_names:
                    # add to the awards list
                    award_data.append({
                        "award_id": award_index,
                        "name": award['award_name'],
                        "organizer": getOrganizer(award['award_name']),
                    })
                    
                    temp_award_names.append(award['award_name'])
                    
                    # replace in the players data
                    award['award_name'] = award_index
                    
                    award_index += 1
                
                else:
                    for a in award_data:
                        if award['award_name'] == a['name']:
                            award['award_name'] = a['award_id']
                
                for details in award['details']:
                    player_award_data.append({
                        "player_id": player_index,
                        "award_id": award['award_name'],
                        "year": details['year'],
                    })

        player_index += 1
    
    # Remove duplicates from player_award
    player_award_data = remove_player_award_duplicates(player_award_data)

    return award_data, player_award_data



# PARSING FUNCTIONS
def normalize_unicode(data):
    if isinstance(data, str):
        return unidecode(data)
    elif isinstance(data, dict):
        return {key: normalize_unicode(value) for key, value in data.items()}
    elif isinstance(data, list):
        return [normalize_unicode(item) for item in data]
    else:
        return data
    

def normalize_year(year):
    year_str = f"{year}"
    if len(year_str) == 2:
        year_str = '20' + year_str.zfill(2)
    return int(year_str)


def remove_player_award_duplicates(save_player_award):
  res = []
  for i in range(len(save_player_award)):
    found_duplicate = False
    for j in range(i + 1, len(save_player_award)):
      if save_player_award[i]['player_id'] == save_player_award[j]['player_id'] and \
         save_player_award[i]['award_id'] == save_player_award[j]['award_id'] and \
         save_player_award[i]['year'] == save_player_award[j]['year']:
        found_duplicate = True
        break
    if not found_duplicate:
      res.append(save_player_award[i])
  return res


def getOrganizer(award):
    award = award.lower()
    
    if 'uefa' in award:
        return 'UEFA'
    elif 'champions league' in award:
        return 'UEFA'
    elif 'fifa' in award:
        return 'FIFA'
    elif 'world cup' in award:
        return 'FIFA'
    elif 'fa' in award:
        return 'The Football Association'
    elif 'european' in award or 'euro' in award or 'europa' in award:
        return 'UEFA'
    elif 'premier' in award or 'epl' in award:
        return 'EPL'
    elif 'english' in award:
        return 'England'
    elif 'german' in award:
        return 'Germany'
    elif 'austrian' in award:
        return 'Austria'
    elif 'argen' in award:
        return 'Argentina'
    elif 'portug' in award:
        return 'Portugal'
    elif 'croat' in award:
        return 'Croatia'
    elif 'asia' in award:
        return "AFC"
    elif 'olympi' in award:
        return 'Olympics'
    elif 'copa' in award:
        return 'Copa America'
    else:
        return None



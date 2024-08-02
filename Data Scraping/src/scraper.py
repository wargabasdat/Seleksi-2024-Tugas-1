from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
import re
from datetime import datetime
import time
import json


# URLS
BASE_URL = "https://www.transfermarkt.com"

page_urls = [
    "https://www.transfermarkt.com/premier-league/marktwerte/wettbewerb/GB1",
    "https://www.transfermarkt.com/premier-league/marktwerte/wettbewerb/GB1/page/2",
    "https://www.transfermarkt.com/premier-league/marktwerte/wettbewerb/GB1/page/3",
    "https://www.transfermarkt.com/premier-league/marktwerte/wettbewerb/GB1/page/4",
]

clubs_url = "https://www.transfermarkt.com/premier-league/startseite/wettbewerb/GB1"

currentClub = '''
                    Current club:
                '''


# SCRAPER FUNCTION
def getPlayerSoup(url):
    driver = webdriver.Edge()
    driver.get(url)
    content = driver.page_source
    driver.quit()
    return BeautifulSoup(content, 'html.parser')


# SCRAPE PLAYER DATA
def scrape_player_data():
    player_data = []

    player_urls = getPlayerUrl()

    for i in range(1, len(player_urls) + 1):
        url = player_urls[i-1]
        
        # Prevention for info soup extraction error
        player_soup = getPlayerSoup(url)
        player_info, current_contract, current_market_value = getPlayerInfo(player_soup)
        
        # Prevention for stats soup extraction error
        player_stats_soup = getPlayerSoup(parse_url_to_stats(url))
        player_epl_stats = getPlayerEPLStats(player_stats_soup)
        
        # Prevention for transfer soup extraction error
        player_transfer_soup = getPlayerSoup(parse_url_to_transfer_history(url))
        player_transfer_history = getPlayerTransferHistory(player_transfer_soup)
        
        # Prevention for awards soup extraction error
        player_awards_soup = getPlayerSoup(parse_url_to_awards(url))
        player_awards = getPlayerAwards(player_awards_soup) 
        
        
        player_data.append({
            "player_info": player_info,
            "current_contract": current_contract,
            "current_value": current_market_value,
            "stats": player_epl_stats,
            "transfer_history": player_transfer_history,
            "awards": player_awards,
        })
        
        print(f"{i}. {url.split('.com/')[1].split('/profil')[0]} INFO EXTRACTION SUCCESS")
        
        # Avoid overloading the server
        time.sleep(5)

    return player_data


# SCRAPE PLAYER URL
def getPlayerUrl():
    soups = []
    player_urls = []

    for url in page_urls:
        driver = webdriver.Edge()
        driver.get(url)
        content = driver.page_source
        
        soups.append(BeautifulSoup(content, 'html.parser'))
        driver.quit()

    for soup in soups:
        table = soup.find('table', class_='items')
        for td in table.find_all('td', 'hauptlink'):
            a_tag = td.find('a')
            if a_tag and 'href' in a_tag.attrs:
                player_url = a_tag['href']
                player_url = BASE_URL + player_url
                if "/profil/spieler/" in player_url:
                    player_urls.append(player_url)

    return player_urls


# Player Soup Data Extract Functions
def getPlayerInfo(soup):
    
    # FIND NAME AND NUMBER
    name_number = soup.find('h1', class_='data-header__headline-wrapper').text
    name_number = ' '.join(name_number.split())
    player_number = int(name_number.split()[0][1:]) 
    player_name = " ".join(name_number.split()[1:]) 
    
    # FIND FULL PERSONAL DATA
    if soup.find('div', class_='info-table info-table--right-space'):
        table = soup.find('div', class_='info-table info-table--right-space')
    elif soup.find('div', class_='info-table info-table--right-space min-height-audio'):
        table = soup.find('div', class_='info-table info-table--right-space min-height-audio')
    
    # Parse the birthdate to remove the age value
    birth_date = table.find(text="Date of birth/Age:").find_next("span").get_text(strip=True)
    birth_date = datetime.strptime(birth_date.split(' (')[0], '%b %d, %Y')
    
    birth_place = table.find(text="Place of birth:").find_next("span").get_text(strip=True).split('  ')[0]
    
    # Parse the height into float
    height = (table.find(text="Height:").find_next("span").get_text(strip=True))
    height = float(height.replace(',', '.').replace(' ', '').replace('m', ''))
    
    nationality = table.find(text="Citizenship:").find_next("span").get_text(strip=True).split()[-1]
    position = table.find(text="Position:").find_next("span").get_text(strip=True)
    preffered_foot = table.find(text="Foot:").find_next("span").get_text(strip=True)
    
    # Handle if player has no agent
    if table.find(text="Player agent:"):
        if table.find(text="Player agent:").find_next("span").find('a'):
            player_agent = table.find(text="Player agent:").find_next("span").find('a').get_text(strip=True) 
        elif table.find(text="Player agent:").find_next("span").find('span'):
            player_agent = table.find(text="Player agent:").find_next("span").find('span').get_text(strip=True)
        else:
            player_agent = None
    else:
        player_agent = None

    current_club = table.find(text=currentClub).find_next('span').find_next('a').find_next('a').get_text(strip=True)
    
    # Parse into datetime format
    joined_club = table.find(text="Joined:").find_next("span").get_text(strip=True)
    joined_club = datetime.strptime(joined_club, '%b %d, %Y')
    contract_expired = table.find(text="Contract expires:").find_next("span").get_text(strip=True)
    contract_expired = datetime.strptime(contract_expired, '%b %d, %Y')
    
    # Handle if player has no oufitter
    outfitter = table.find(text="Outfitter:").find_next("span").get_text(strip=True) if table.find(text="Outfitter:") else None
    
    # Parse current value and last update date
    current_value = soup.find('a', class_='data-header__market-value-wrapper').get_text(strip=True)
    date_string = current_value.split('Last update: ')[1]
    
    # Parse the last update to datetime value
    last_update = datetime.strptime(date_string, '%b %d, %Y')
    current_value = float(current_value.split('€')[1].split('m')[0])
    
    # Return values for table Player, Player Current club, Player Market value
    return {
        "name": player_name,
        "player_number": player_number,
        "birth_date": birth_date,
        "birth_place": birth_place, 
        "height": height,
        "nationality": nationality,
        "position": position,
        "preffered_foot": preffered_foot,
        "player_agent": player_agent,
        "outfitter": outfitter,
    }, {
        "current_club": current_club,
        "date_joined":joined_club,
        "contract_expired": contract_expired,
    }, {
        "current_value": current_value,
        "last_update_date": last_update,
    }



def extractTrStats(tr):
    tds = tr.find_all('td')
    
    # Parse to int and remove unwanted text
    # Handle if player has no match played, goals, assist, or minutes played
    season = tds[0].get_text(strip=True) if tds[0].get_text(strip=True) != '-' else None
    matches_played = int(tds[4].get_text(strip=True)) if tds[4].get_text(strip=True) != '-' else None
    goals = int(tds[5].get_text(strip=True)) if tds[5].get_text(strip=True) != '-' else None
    assists = int(tds[6].get_text(strip=True)) if tds[6].get_text(strip=True) != '-' else None
    minutes_played = int(tds[8].get_text(strip=True).replace("'", "").replace(".", "")) if tds[8].get_text(strip=True).replace("'", "").replace(".", "") != '-' else None

    return {
        "season": season,
        "matches_played": matches_played,
        "goals": goals,
        "assists": assists,
        "minutes_played": minutes_played
    }


# Extract stats for goalkeeper
def extractGKTrStats(tr):
    tds = tr.find_all('td')
    
    # Parse to int and remove unwanted text
    # Handle if player has no match played, goals, assist, or minutes played
    season = tds[0].get_text(strip=True) if tds[0].get_text(strip=True) != '-' else None
    matches_played = int(tds[4].get_text(strip=True)) if tds[4].get_text(strip=True) != '-' else 0
    goals_conceded = int(tds[7].get_text(strip=True)) if tds[7].get_text(strip=True) != '-' else 0
    clean_sheets = int(tds[8].get_text(strip=True)) if tds[8].get_text(strip=True) != '-' else 0
    minutes_played = int(tds[9].get_text(strip=True).replace("'", "").replace(".", "")) if tds[9].get_text(strip=True).replace("'", "").replace(".", "") != '-' else 0

    return {
        "season": season,
        "matches_played": matches_played,
        "goals_conceded": goals_conceded,
        "clean_sheets": clean_sheets,
        "minutes_played": minutes_played
    }


def getPlayerEPLStats(soup):
    stats = []
    table = soup.find('table', class_='items').find('tbody')
    
    # Check if a player is a field player or a goalkeeper
    position = None
    positionBox = soup.find('div', class_='data-header__info-box').find('div', class_='data-header__details').find_all('ul')[1]
    positionBox = positionBox.find_all('li')[1].find('span').get_text(strip=True)
    # If a player is a field player
    if positionBox != 'Goalkeeper':
        for tr in table.find_all('tr'):
            leagueName = tr.find('td', class_='hauptlink no-border-links').find('a').get_text(strip=True)
            if leagueName and leagueName == "Premier League" :
                stats.append(extractTrStats(tr))
        return stats
    
    else:
        for tr in table.find_all('tr'):
            leagueName = tr.find('td', class_='hauptlink no-border-links').find('a').get_text(strip=True)
            if leagueName and leagueName == "Premier League" :
                stats.append(extractGKTrStats(tr))
        return stats



def getPlayerTransferHistory(soup):
    table = soup.find('div', class_='tm-transfer-history box')
    transfer = []
    for grid in table.find_all('div', class_='grid tm-player-transfer-history-grid'):
        # Parse into correct values and remove unwanted text
        season = grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__season').get_text(strip=True)
        transfer_date = grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__date').get_text(strip=True)
        transfer_date =  datetime.strptime(transfer_date, '%b %d, %Y')
        # Handle unwanted None on club left and joined
        club_left = None
        club_joined = None
        if grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__old-club').find('a', class_='tm-player-transfer-history-grid__club-link'):
            club_left = grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__old-club').find('a', class_='tm-player-transfer-history-grid__club-link').get_text(strip=True)
        elif grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__old-club').find('span', class_='tm-player-transfer-history-grid__club-link'):
            club_left = None
        if grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__new-club').find('a', class_='tm-player-transfer-history-grid__club-link'):
            club_joined = grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__new-club').find('a', class_='tm-player-transfer-history-grid__club-link').get_text(strip=True)
        elif grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__new-club').find('span', class_='tm-player-transfer-history-grid__club-link'):
            club_joined = None
        
        market_value = grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__market-value').get_text(strip=True) 
        # Process all possible values from transfermarkt
        market_value = None if market_value == '-' else parse_to_million(market_value)
        fee = grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__fee').get_text(strip=True)
        isLoan = False
        if fee:
            if 'loan' in fee or 'Loan' in fee:
                if fee == 'End of loan' or fee == 'loan transfer':
                    fee = 0
                elif 'Loan fee:' in fee:
                    fee = parse_to_million(grid.find('div', class_='grid__cell grid__cell--center tm-player-transfer-history-grid__fee').find('i').get_text(strip=True))   
                isLoan = True
            elif '-' in fee:
                fee = 0
            elif '?' in fee:
                fee = None
            elif fee == 'free transfer':
                fee = None
            else:
                fee = parse_to_million(fee)
        else:
            fee = None
        
        transfer.append({
            "season": season,
            "transfer_date": transfer_date,
            "club_left": club_left,
            "club_joined": club_joined,
            "market_value": market_value,
            "fee": fee,
            "is_loan": isLoan,
        }) 
    return transfer



def getPlayerAwards(soup):
    allTitles = '''
                    All titles                '''
    awards = []
    current_award = None

    # Return None if player does not have awards
    if soup.find('h2', text=allTitles):
        tableBody = soup.find('h2', text=allTitles).find_next('table').find('tbody')
    else:
        return None
    
    for tr in tableBody.find_all('tr'):
        if 'bg_Sturm' in tr.get('class', []):
            award_name = tr.find('td', class_='hauptlink').get_text(strip=True)
            award_name = ' '.join(award_name.split(' ')[1:])
            current_award = {
                "award_name": award_name,
                "details": []
            }
            awards.append(current_award)
        else:
            if current_award:
                year = (tr.find('td', class_='erfolg_table_saison zentriert').get_text(strip=True))
                # Parse year where year is the season format to year of season end
                year = int(year.split('/')[1]) if '/' in year else year
                
                current_award['details'].append({
                    "year": year,
                })
    
    return awards




# URL PARSER
def parse_url_to_stats(url):
    parts = url.split('/')
    parts[4] = 'leistungsdatendetails'
    new_url = '/'.join(parts)
    return new_url


def parse_url_to_transfer_history(url):
    parts = url.split('/')
    parts[4] = 'transfers'
    new_url = '/'.join(parts)
    return new_url


def parse_url_to_awards(url):
    parts = url.split('/')
    parts[4] = 'erfolge'
    new_url = '/'.join(parts)
    return new_url

# PARSING FUNCTIONS
def parse_to_million(value):
    if 'bn' in value:
        value = float(value.split('€')[1].split('bn')[0].strip()) * 1000
    elif 'm' in value:
        return float(value.split('€')[1].split('m')[0].strip())
    elif 'k' in value:
        return float(value.split('€')[1].split('k')[0].strip()) / 1000
    elif '-' in value:
        return None
    else:
        raise ValueError("Value Undefined")
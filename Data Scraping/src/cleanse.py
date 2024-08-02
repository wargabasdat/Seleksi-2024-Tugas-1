import json


with open('../data/heroes.json', 'r') as file:
    heroes = json.load(file)


for hero in heroes:
    # Convert hero_category to an array
    hero['hero_category'] = [category.strip() for category in hero['hero_category'].split(',')]
    
    hero['hero_win_rate'] = hero['hero_win_rate'].split('%')[0]
    # extract str, agi, int base values
    hero['strength'] = hero['strength'].split(' ')[0]
    hero['agility'] = hero['agility'].split(' ')[0]
    hero['intelligence'] = hero['intelligence'].split(' ')[0]
    
    # use only the first value for sight range and damage
    hero['sight_range'] = hero['sight_range'].split('/')[0]
    hero['damage'] = hero['damage'].split(' ')[0]

    #clean items
    for item in hero['items']:
        
        item['matches_played'] = item['matches_played'].replace(",","")
        item['win_rate'] = item['win_rate'].split('%')[0]
    
    #clean counters
    for counter in hero['counters']:
        counter['disadvantage'] = counter['disadvantage'].split('%')[0]
        counter['win_rate'] = counter['win_rate'].split('%')[0]
        counter['match_played'] = counter['match_played'].replace(",","")


with open('../data/processed_heroes.json', 'w') as file:
    json.dump(heroes, file, indent=4)
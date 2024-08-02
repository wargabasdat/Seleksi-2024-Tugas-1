import json
import pymysql

with open('../../Data Scraping/data/processed_heroes.json', 'r') as file:
    heroes = json.load(file)

with open('../../Data Scraping/data/items.json', 'r') as file:
    items = json.load(file)

connection = pymysql.connect(
    host='localhost',
    user='root',
    password='',
    database='dota2'
)

with connection.cursor() as cursor:
    item_map = dict()
    for item in items:
        sql_item = """
            INSERT INTO item (
                name, price, lore, item_image
            ) VALUES (%s, %s, %s, %s)
        """
        cursor.execute(sql_item, (
            item.get('name'),
            item.get('price', 0),
            item.get('lore', None),
            item.get('item_image', None) 

        ))
        item_map[item['name']] = cursor.lastrowid

    for item in items:
        for build in item['build']:
            sql_build = """
                INSERT INTO item_component (
                    id_item, id_component
                ) VALUES (%s, %s)
            """
            item_id = item_map[item['name']]
            if build in item_map:
                component_id = item_map[build]
                cursor.execute(sql_build, (item_id, component_id))
            else:
                print(f"Item {build} not found")

    hero_map = dict()
    for hero in heroes:
        sql_hero = """
            INSERT INTO hero (
                    name, win_rate, strength, agility, intelligence,
                    movement_speed, sight_range, armor, base_attack_time, damage,
                    facet1, facet2, attack_point, hero_image
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
        cursor.execute(sql_hero, (
                hero['hero_name'],
                float(hero['hero_win_rate']),
                int(hero['strength']),
                int(hero['agility']),
                int(hero['intelligence']), 
                int(hero['movement_speed']), 
                int(hero['sight_range']), 
                float(hero['armor']), 
                float(hero['base_attack_time']), 
                int(hero['damage']), 
                hero['facet1'], 
                hero['facet2'], 
                float(hero['attack_point']),
                hero['hero_image']
            ))
        hero_map[hero['hero_name']] = cursor.lastrowid
        hero_id = cursor.lastrowid

        for category in hero['hero_category']:
            sql_category = """
                INSERT INTO hero_category (
                    id_hero, category
                ) VALUES (%s, %s)
            """
            cursor.execute(sql_category, (hero_id, category))
        
        for item in hero['items']:
            sql_item = """
                INSERT INTO hero_item (
                    id_hero, id_item, win_rate, match_played
                ) VALUES (%s, %s, %s, %s)
            """
            item_id = item_map[item['name']]
            cursor.execute(sql_item, (hero_id, item_id, float(item['win_rate']), int(item['matches_played'])))

        for talent in hero['talents']:
            sql_talent = """
                INSERT INTO talent (
                    id_hero, description, level, is_left
                ) VALUES (%s, %s, %s, %s)
            """
            cursor.execute(sql_talent, (hero_id, talent['left'], int(talent['level']), 1))
            cursor.execute(sql_talent, (hero_id, talent['right'], int(talent['level']), 0))

        for ability in hero['abilities']:
            sql_ability = """
                INSERT INTO ability (
                    id_hero, name, description, notes, lore, ability_image
                ) VALUES (%s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql_ability, (
                hero_id,
                ability['name'],
                ability.get('description', None),  
                ability.get('notes', None),        
                ability.get('lore', None),         
                ability['image']
            ))
    
    for hero in heroes:
        for counter in hero['counters']:
            sql_counter = """
                INSERT INTO hero_versus (
                    id_hero, id_hero_opponent, win_rate, match_played, disadvantage
                ) VALUES (%s, %s, %s, %s, %s)
            """
            
            hero_id = hero_map[hero['hero_name']]
            hero_opponent_id = hero_map[counter['hero']]
            cursor.execute(sql_counter, (hero_id, hero_opponent_id, float(counter['win_rate']), int(counter['match_played']), float(counter['disadvantage'])))

    connection.commit()
    connection.close()

print("Data inserted successfully")
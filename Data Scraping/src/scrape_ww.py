import os
import time
import json
import re
import psycopg2
import nltk
from nltk.tokenize import word_tokenize
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.edge.service import Service as EdgeService
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.edge.options import Options as EdgeOptions
from selenium.webdriver.safari.webdriver import WebDriver as SafariDriver
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from bs4 import BeautifulSoup
from dotenv import load_dotenv

# Load environment variables from credentials.env
load_dotenv('./credentials.env')

# Database credentials from environment variables
db_name = os.getenv('DB_NAME')
db_user = os.getenv('DB_USER')
db_pass = os.getenv('DB_PASS')
db_host = os.getenv('DB_HOST')
db_port = os.getenv('DB_PORT')

base_url = 'https://www.prydwen.gg'
characters_url = f'{base_url}/wuthering-waves/characters'
echoes_url = f'{base_url}/wuthering-waves/echoes'
weapons_url = f'{base_url}/wuthering-waves/weapons'

nltk.download('punkt')

def get_driver(browser='chrome'):
    options = ChromeOptions()
    options.headless = True
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-software-rasterizer')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--no-sandbox')
    options.add_argument('--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')
    
    service = ChromeService(executable_path=os.getenv('CHROMEDRIVER_PATH'))
    return webdriver.Chrome(service=service, options=options)



def get_soup(url, driver):
    driver.get(url)
    time.sleep(3)  # Wait for the page to load
    html = driver.page_source
    return BeautifulSoup(html, 'html.parser')

def clean_material_name(material, remove_prefix=False):
    parts = material.split('x', 1)
    if len(parts) > 1:
        material_name = parts[1].strip()
        if remove_prefix and 'LF ' in material_name:
            material_name = material_name.replace('LF ', '', 1).strip()
        return material_name
    return material

def extract_materials(soup, title):
    materials = []
    stats_div = soup.find('h5', string=lambda text: text and title in text)
    if stats_div:
        ul_element = stats_div.find_next('ul')
        if ul_element:
            materials = [li.get_text(strip=True) for li in ul_element.find_all('li')]
    return materials

def scrape_characters(soup, driver):
    characters_data = []
    for character in soup.select('.avatar-card.card'):
        link_element = character.find('a')
        if link_element and 'href' in link_element.attrs:
            detail_url = base_url + link_element['href']
            detail_soup = get_soup(detail_url, driver)

            combined_div = detail_soup.find('div', class_='combined')
            name = combined_div.find('strong').text.strip() if combined_div else "N/A"
            rarity = combined_div.find('strong').find_next_sibling('strong').text.strip()[0] if combined_div else "N/A"
            element = combined_div.find('strong').find_next_sibling('strong').find_next_sibling('strong').text.strip() if combined_div else "N/A"
            weapon = combined_div.find('strong').find_next_sibling('strong').find_next_sibling('strong').find_next_sibling('strong').text.strip() if combined_div else "N/A"
            
            if element == "unknown" and weapon == "unknown":
                element = "N/A"
                weapon = "N/A"

            stats_div = detail_soup.find('div', class_='ww-stats')
            stats = [div.find('div', class_='details').text.strip() if len(stats_div.find_all('div', class_='info-list-row')) > idx else "N/A" for idx, div in enumerate(stats_div.find_all('div', class_='info-list-row'))] if stats_div else ["N/A"] * 8
            
            ascension_mats = extract_materials(detail_soup, "Character Ascension (total)")
            skill_upgrades_mats = extract_materials(detail_soup, "Skill Upgrades (total)")
            mats = ascension_mats + skill_upgrades_mats

            ws_mats = clean_material_name(mats[0], remove_prefix=True) if len(mats) > 0 else "N/A"
            ra_mats = clean_material_name(mats[4]) if len(mats) > 4 else "N/A"
            a_mats = clean_material_name(mats[5]) if len(mats) > 5 else "N/A"
            w_mats = clean_material_name(mats[11]) if len(mats) > 11 else "N/A"
            su_mats = clean_material_name(mats[15]) if len(mats) > 15 else "N/A"

            if a_mats == "? ? ?":
                a_mats = "Terraspawn Fungus"

            best_weapon_div = detail_soup.find('div', class_='build-tips')
            weapon_name = best_weapon_div.find('div', class_='single-item').find('span', class_='ww-weapon-name').text.strip().split(' (')[0] if best_weapon_div else "N/A"
            weapon_s_level = re.search(r'\(S(\d+)\)', best_weapon_div.find('div', class_='single-item').find('span', class_='ww-weapon-name').text.strip()).group(1) if best_weapon_div else "N/A"

            best_echo_set_div = detail_soup.find('div', class_='ww-set-accordion accordion')
            best_echo_set = best_echo_set_div.find('div', class_='ww-set-image').get('class')[1] if best_echo_set_div else "N/A"
            best_echo_set = 'Lingering' if best_echo_set == 'Endless' else best_echo_set

            best_main_echo_div = detail_soup.find('div', class_='ww-echo-cost')
            best_main_echo = best_main_echo_div.find_next('span', class_='ww-echo-name').text.strip() if best_main_echo_div else "N/A"

            characters_data.append({
                'Name': name,
                'Rarity': rarity,
                'Element': element,
                'HP': stats[0],
                'ATK': stats[1],
                'DEF': stats[2],
                'Max Energy': stats[3],
                'CRIT Rate': stats[4],
                'CRIT DMG': stats[5],
                'Healing Bonus': stats[6],
                'Element DMG': stats[7],
                'WS_Mats': ws_mats if ws_mats else ["N/A"],
                'RA_Mats': ra_mats if ra_mats else ["N/A"],
                'A_Mats': a_mats if a_mats else ["N/A"],
                'W_Mats': w_mats if w_mats else ["N/A"],
                'SU_Mats': su_mats if su_mats else ["N/A"],
                'Weapon Name': weapon_name,
                'Weapon S Level': weapon_s_level,
                'Best Echo Set': best_echo_set,
                'Best Main Echo': best_main_echo,
                'detail_url': detail_url
            })
            time.sleep(1)
    return characters_data

def scrape_echoes(soup):
    elements = ["Aero", "Electro", "Fusion", "Glacio", "Havoc", "Spectro"]
    echoes_data = []
    for echo in soup.select('.ww-echo-box.box'):
        name = echo.select_one('.ww-data h4').text.strip() if echo.select_one('.ww-data h4') else "N/A"
        class_name = echo.select_one('.ww-info p strong').text.strip() if echo.select_one('.ww-info p strong') else "N/A"
        cost = echo.select_one('.ww-info p strong').find_next('strong').text.strip() if echo.select_one('.ww-info p strong') else "N/A"
        content_element = echo.select_one('.ww-content .skill-with-coloring')
        
        element_dmg = next((element for element in elements if element in content_element.text), "N/A") if content_element else "N/A"
        cooldown = re.search(r'CD:\s*(\d+)s', content_element.text).group(1) if content_element and re.search(r'CD:\s*(\d+)s', content_element.text) else "N/A"
        
        sets = ['Lingering' if cls == 'Endless' else cls for cls in [div['class'][1] for div in echo.select('div.single-set')]] if echo.select('div.single-set') else []

        echoes_data.append({
            'Name': name,
            'Class': class_name,
            'Cost': cost,
            'Element DMG': element_dmg,
            'Cooldown (s)': cooldown,
            'Sets': sets
        })
        time.sleep(1)
    return echoes_data

def scrape_weapons(soup):
    weapons_data = []
    for weapon in soup.select('.ww-weapon-box.box'):
        name = weapon.select_one('.ww-data h4').text.strip() if weapon.select_one('.ww-data h4') else "N/A"
        rarity = ''.join(filter(str.isdigit, weapon.select_one('.ww-info p strong.rarity-ww').text.strip())) if weapon.select_one('.ww-info p strong.rarity-ww') else "N/A"
        type_name = weapon.select_one('.ww-info p:nth-of-type(2) strong').text.strip() if weapon.select_one('.ww-info p:nth-of-type(2) strong') else "N/A"
        atk = weapon.select_one('.ww-stats p strong').text.strip() if weapon.select_one('.ww-stats p strong') else "N/A"
        substat_percent = weapon.select_one('.ww-stats p + p strong').text.strip() if weapon.select_one('.ww-stats p + p strong') else "N/A"
        substat = weapon.select_one('.ww-stats p + p').text.split(':')[0].strip().replace("Energy Reg.", "energy regen").replace(" (Lv.90)", "").strip() if weapon.select_one('.ww-stats p + p') else "N/A"

        weapons_data.append({
            'Name': name,
            'Rarity': rarity,
            'Type': type_name,
            'Atk': atk,
            'Substat': substat,
            'Substat%': substat_percent,
        })
        time.sleep(1)
    return weapons_data

def preprocess_text(text):
    if text is None or text == "N/A":
        return "NULL"
    text = text.lower()
    if text == "n/a":
        return "NULL"
    text = re.sub(r'new!', '', text)
    tokens = word_tokenize(text)
    return ' '.join(tokens)

def preprocess_data(data):
    for character in data['characters']:
        character['Rarity'] = int(character['Rarity']) if character['Rarity'].isdigit() else None
        character['HP'] = int(character['HP']) if character['HP'].isdigit() else None
        character['ATK'] = int(character['ATK']) if character['ATK'].isdigit() else None
        character['DEF'] = int(character['DEF']) if character['DEF'].isdigit() else None
        character['Max Energy'] = int(character['Max Energy']) if character['Max Energy'].isdigit() else None
        character['CRIT Rate'] = int(character['CRIT Rate'].replace('%', '')) if '%' in character['CRIT Rate'] else None
        character['CRIT DMG'] = int(character['CRIT DMG'].replace('%', '')) if '%' in character['CRIT DMG'] else None
        character['Healing Bonus'] = int(character['Healing Bonus'].replace('%', '')) if '%' in character['Healing Bonus'] else None
        character['Element DMG'] = int(character['Element DMG'].replace('%', '')) if '%' in character['Element DMG'] else None
        
        character['Name'] = preprocess_text(character['Name'])
        character['Element'] = preprocess_text(character['Element'])
        character['WS_Mats'] = preprocess_text(character['WS_Mats'])
        character['RA_Mats'] = preprocess_text(character['RA_Mats'])
        character['A_Mats'] = preprocess_text(character['A_Mats'])
        character['W_Mats'] = preprocess_text(character['W_Mats'])
        character['SU_Mats'] = preprocess_text(character['SU_Mats'])
        character['Best Echo Set'] = preprocess_text(character['Best Echo Set'])
        character['Best Main Echo'] = preprocess_text(character['Best Main Echo'])
        character['Weapon Name'] = preprocess_text(character['Weapon Name'])
        character['Weapon S Level'] = int(character['Weapon S Level']) if character['Weapon S Level'].isdigit() else None

    for echo in data['echoes']:
        echo['Cost'] = int(echo['Cost']) if echo['Cost'].isdigit() else None
        echo['Cooldown (s)'] = int(echo['Cooldown (s)']) if echo['Cooldown (s)'].isdigit() else None
        echo['Name'] = preprocess_text(echo['Name'])
        echo['Class'] = preprocess_text(echo['Class'])
        echo['Element DMG'] = preprocess_text(echo['Element DMG'])
        echo['Sets'] = [preprocess_text(set_name) for set_name in echo['Sets']]
    
    for weapon in data['weapons']:
        weapon['Rarity'] = int(weapon['Rarity']) if weapon['Rarity'].isdigit() else None
        weapon['Atk'] = int(weapon['Atk']) if weapon['Atk'].isdigit() else None
        weapon['Substat%'] = float(weapon['Substat%'].replace('%', '')) if '%' in weapon['Substat%'] else None
        weapon['Name'] = preprocess_text(weapon['Name'])
        weapon['Type'] = preprocess_text(weapon['Type'])
        weapon['Substat'] = preprocess_text(weapon['Substat'])

def insert_data_to_db(data):
    conn = None
    try:
        conn = psycopg2.connect(
            dbname=db_name,
            user=db_user,
            password=db_pass,
            host=db_host,
            port=db_port
        )
        cur = conn.cursor()

        for character in data['characters']:
            cur.execute("""
                INSERT INTO element (element_name)
                VALUES (%s)
                ON CONFLICT (element_name) DO NOTHING;
            """, (character['Element'],))

        for weapon in data['weapons']:
            cur.execute("""
                INSERT INTO weapon (name, rarity, weapon_type, atk, substat, substat_value)
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (name) DO UPDATE SET
                rarity = EXCLUDED.rarity,
                weapon_type = EXCLUDED.weapon_type,
                atk = EXCLUDED.atk,
                substat = EXCLUDED.substat,
                substat_value = EXCLUDED.substat_value;
            """, (weapon['Name'], weapon['Rarity'], weapon['Type'], weapon['Atk'], weapon['Substat'], weapon['Substat%']))

        for echo in data['echoes']:
            cur.execute("""
                INSERT INTO echo (echo_name, class, cost, cooldown, element_id)
                VALUES (%s, %s, %s, %s, 
                        (SELECT element_id FROM element WHERE element_name = %s))
                ON CONFLICT (echo_name) DO UPDATE SET
                class = EXCLUDED.class,
                cost = EXCLUDED.cost,
                cooldown = EXCLUDED.cooldown,
                element_id = EXCLUDED.element_id;
            """, (echo['Name'], echo['Class'], echo['Cost'], echo['Cooldown (s)'], echo['Element DMG']))

            for set_name in echo['Sets']:
                cur.execute("""
                    INSERT INTO echo_set (set_name)
                    VALUES (%s)
                    ON CONFLICT (set_name) DO NOTHING;
                """, (set_name,))
                
                cur.execute("""
                    INSERT INTO part_of (set_id, echo_id)
                    VALUES (
                        (SELECT set_id FROM echo_set WHERE set_name = %s),
                        (SELECT echo_id FROM echo WHERE echo_name = %s)
                    )
                    ON CONFLICT DO NOTHING;
                """, (set_name, echo['Name']))

        for character in data['characters']:
            cur.execute("""
                INSERT INTO character (char_name, char_rarity, element_id, best_echo_set_id, best_main_echo_id)
                VALUES (%s, %s, 
                        (SELECT element_id FROM element WHERE element_name = %s),
                        (SELECT set_id FROM echo_set WHERE set_name = %s),
                        (SELECT echo_id FROM echo WHERE echo_name = %s))
                ON CONFLICT (char_name) DO UPDATE SET
                char_rarity = EXCLUDED.char_rarity,
                element_id = EXCLUDED.element_id,
                best_echo_set_id = EXCLUDED.best_echo_set_id,
                best_main_echo_id = EXCLUDED.best_main_echo_id
                RETURNING char_id;
            """, (character['Name'], character['Rarity'], character['Element'], character['Best Echo Set'], character['Best Main Echo']))
            char_id = cur.fetchone()[0]

            cur.execute("""
                INSERT INTO char_stats (char_id, hp, char_atk, def, max_energy, crit_rate, crit_dmg, healing_bonus, element_dmg)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (char_id) DO UPDATE SET
                hp = EXCLUDED.hp,
                char_atk = EXCLUDED.char_atk,
                def = EXCLUDED.def,
                max_energy = EXCLUDED.max_energy,
                crit_rate = EXCLUDED.crit_rate,
                crit_dmg = EXCLUDED.crit_dmg,
                healing_bonus = EXCLUDED.healing_bonus,
                element_dmg = EXCLUDED.element_dmg;
            """, (char_id, character['HP'], character['ATK'], character['DEF'], character['Max Energy'], character['CRIT Rate'], character['CRIT DMG'], character['Healing Bonus'], character['Element DMG']))

            cur.execute("""
                INSERT INTO char_material (char_id, ws_mats, ra_mats, a_mats, w_mats, su_mats)
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (char_id) DO UPDATE SET
                ws_mats = EXCLUDED.ws_mats,
                ra_mats = EXCLUDED.ra_mats,
                a_mats = EXCLUDED.a_mats,
                w_mats = EXCLUDED.w_mats,
                su_mats = EXCLUDED.su_mats;
            """, (char_id, character['WS_Mats'], character['RA_Mats'], character['A_Mats'], character['W_Mats'], character['SU_Mats']))

            weapon_name = character['Weapon Name'] if character['Weapon Name'] != "NULL" else None
            weapon_s_level = character['Weapon S Level'] if character['Weapon S Level'] != "NULL" else None
            if weapon_name is not None:
                try:
                    cur.execute("""
                        INSERT INTO weapon_level (char_id, weapon_id, s_level)
                        VALUES (%s, 
                                (SELECT weapon_id FROM weapon WHERE name = %s),
                                %s)
                        ON CONFLICT (char_id, weapon_id) DO UPDATE SET
                        s_level = EXCLUDED.s_level;
                    """, (char_id, weapon_name, weapon_s_level))
                except psycopg2.DatabaseError as e:
                    print(f"Failed to insert weapon level for character {character['Name']}: {e}")

        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

def main():
    browser_choice = 'chrome'  # Change to 'chrome' or 'edge'
    driver = get_driver(browser_choice)

    characters_soup = get_soup(characters_url, driver)
    characters_data = scrape_characters(characters_soup, driver)

    echoes_soup = get_soup(echoes_url, driver)
    echoes_data = scrape_echoes(echoes_soup)

    weapons_soup = get_soup(weapons_url, driver)
    weapons_data = scrape_weapons(weapons_soup)

    data = {
        'characters': characters_data,
        'echoes': echoes_data,
        'weapons': weapons_data
    }

    preprocess_data(data)

    with open('./Data Scraping/data/wuthering_waves_data.json', 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)

    with open('./Data Scraping/data/wuthering_waves_data.json', 'r', encoding='utf-8') as f:
        data = json.load(f)
        insert_data_to_db(data)

    driver.quit()

if __name__ == '__main__':
    main()

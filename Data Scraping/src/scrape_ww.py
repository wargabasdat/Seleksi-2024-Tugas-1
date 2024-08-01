from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.edge.service import Service as EdgeService
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.webdriver.edge.options import Options as EdgeOptions
from selenium.webdriver.safari.webdriver import WebDriver as SafariDriver
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from bs4 import BeautifulSoup
from nltk.tokenize import word_tokenize
import psycopg2
import nltk
import json
import time
import re

# Base URL
base_url = 'https://www.prydwen.gg'

# URLs for characters and weapons
characters_url = f'{base_url}/wuthering-waves/characters'
echoes_url = f'{base_url}/wuthering-waves/echoes'
weapons_url = f'{base_url}/wuthering-waves/weapons'

# Header for request
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}

def get_driver(browser='chrome'):
    if browser == 'chrome':
        options = ChromeOptions()
        options.headless = True  # Run in headless mode
        options.add_argument('--ignore-certificate-errors')  # Ignore SSL errors
        options.add_argument('--disable-gpu')  # Disable GPU
        options.add_argument('--disable-software-rasterizer')  # Disable software rasterizer
        options.add_argument('--disable-dev-shm-usage')  # Disable /dev/shm usage
        options.add_argument('--no-sandbox')  # No sandbox
        options.add_argument('--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')  # Set a custom user-agent
        service = ChromeService(ChromeDriverManager().install())
        driver = webdriver.Chrome(service=service, options=options)
    elif browser == 'firefox':
        options = FirefoxOptions()
        options.headless = True  # Run in headless mode
        options.accept_insecure_certs = True  # Ignore SSL errors
        options.add_argument('--disable-gpu')  # Disable GPU
        options.add_argument('--disable-software-rasterizer')  # Disable software rasterizer
        service = FirefoxService(GeckoDriverManager().install())
        driver = webdriver.Firefox(service=service, options=options)
    elif browser == 'edge':
        options = EdgeOptions()
        options.headless = True  # Run in headless mode
        options.add_argument('--ignore-certificate-errors')  # Ignore SSL errors
        options.add_argument('--disable-gpu')  # Disable GPU
        options.add_argument('--disable-software-rasterizer')  # Disable software rasterizer
        service = EdgeService(EdgeChromiumDriverManager().install())
        driver = webdriver.Edge(service=service, options=options)
    elif browser == 'safari':
        driver = SafariDriver()  # Safari does not support headless mode
    else:
        raise ValueError(f"Unsupported browser: {browser}")
    return driver


def get_soup(url, driver):
    driver.get(url)
    time.sleep(3)  # Wait for the page to load
    html = driver.page_source
    return BeautifulSoup(html, 'html.parser')

# Initialize WebDriver
browser_choice = 'edge'  # Change to 'chrome', 'firefox', 'edge', or 'safari' as needed
driver = get_driver(browser_choice)

# Function to clean material names by removing quantities and prefixes
def clean_material_name(material, remove_prefix=False):
    parts = material.split('x', 1)
    if len(parts) > 1:
        material_name = parts[1].strip()
        if remove_prefix and 'LF ' in material_name:
            material_name = material_name.replace('LF ', '', 1).strip()
        return material_name
    return material

# Function to extract materials from the HTML based on the section title
def extract_materials(soup, title):
    materials = []
    stats_div = soup.find('h5', string=lambda text: text and title in text)
    if stats_div:
        ul_element = stats_div.find_next('ul')
        if ul_element:
            for li in ul_element.find_all('li'):
                materials.append(li.get_text(strip=True))
    return materials
    
def scrape_characters(soup):
    characters_data = []
    for character in soup.select('.avatar-card.card'):
        link_element = character.find('a')
        if link_element and 'href' in link_element.attrs:
            detail_url = base_url + link_element['href']
            detail_soup = get_soup(detail_url, driver)
            
            combined_div = detail_soup.find('div', class_='combined')
            if combined_div:
                name_element = combined_div.find('strong')
                name = name_element.text.strip() if name_element else "N/A"
                
                rarity_element = name_element.find_next_sibling('strong') if name_element else None
                rarity = rarity_element.text.strip()[0] if rarity_element and rarity_element.text.strip() else "N/A"
                
                element_element = rarity_element.find_next_sibling('strong') if rarity_element else None
                element = element_element.text.strip() if element_element else "N/A"

                weapon_element = element_element.find_next_sibling('strong') if element_element else None
                weapon = weapon_element.text.strip() if weapon_element else "N/A"

            else:
                name = "N/A"
                rarity = "N/A"
                element = "N/A"
                weapon = "N/A"
            
            if element == "unknown" and weapon == "unknown":
                    element = "N/A"
                    weapon = "N/A"
                    
            # Extract stats
            stats_div = detail_soup.find('div', class_='ww-stats')
            if stats_div:
                stat_elements = stats_div.find_all('div', class_='info-list-row')
                hp = stat_elements[0].find('div', class_='details').text.strip() if len(stat_elements) > 0 else "N/A"
                atk = stat_elements[1].find('div', class_='details').text.strip() if len(stat_elements) > 1 else "N/A"
                deff = stat_elements[2].find('div', class_='details').text.strip() if len(stat_elements) > 2 else "N/A"
                max_energy = stat_elements[3].find('div', class_='details').text.strip() if len(stat_elements) > 3 else "N/A"
                crit_rate = stat_elements[4].find('div', class_='details').text.strip() if len(stat_elements) > 4 else "N/A"
                crit_dmg = stat_elements[5].find('div', class_='details').text.strip() if len(stat_elements) > 5 else "N/A"
                healb = stat_elements[6].find('div', class_='details').text.strip() if len(stat_elements) > 6 else "N/A"
                elementdmg = stat_elements[7].find('div', class_='details').text.strip() if len(stat_elements) > 7 else "N/A"
            else:
                hp = "N/A"
                atk = "N/A"
                deff = "N/A"
                max_energy = "N/A"
                crit_rate = "N/A"
                crit_dmg = "N/A"
                healb = "N/A"
                elementdmg = "N/A"
            
            # Extract materials for Character Ascension and Skill Upgrades
            ascension_mats = extract_materials(detail_soup, "Character Ascension (total)")
            skill_upgrades_mats = extract_materials(detail_soup, "Skill Upgrades (total)")

            # Combine the materials lists
            mats = ascension_mats + skill_upgrades_mats

            # Clean and classify the materials
            ws_mats = clean_material_name(mats[0], remove_prefix=True) if len(mats) > 0 else "N/A"
            ra_mats = clean_material_name(mats[4]) if len(mats) > 4 else "N/A"
            a_mats = clean_material_name(mats[5]) if len(mats) > 5 else "N/A"
            w_mats = clean_material_name(mats[11]) if len(mats) > 11 else "N/A"
            su_mats = clean_material_name(mats[15]) if len(mats) > 15 else "N/A"

            if a_mats == "? ? ?":
                    a_mats = "Terraspawn Fungus"

            # Extract Best Weapon
            best_weapon_div = detail_soup.find('div', class_='build-tips')
            weapon_name = "N/A"
            weapon_s_level = "N/A"
            if best_weapon_div:
                single_item_div = best_weapon_div.find('div', class_='single-item')
                if single_item_div:
                    weapon_name_element = single_item_div.find('span', class_='ww-weapon-name')
                    if weapon_name_element:
                        weapon_name = weapon_name_element.text.strip()
                        s_level_match = re.search(r'\(S(\d+)\)', weapon_name)
                        weapon_s_level = s_level_match.group(1) if s_level_match else "N/A"
                        weapon_name = weapon_name.split(' (')[0]  # Remove the (S1) part from the name

            # Extract Best Echo Set
            best_echo_set = "N/A"
            best_echo_set_div = detail_soup.find('div', class_='ww-set-accordion accordion')
            if best_echo_set_div:
                ww_set_image = best_echo_set_div.find('div', class_='ww-set-image')
                if ww_set_image:
                    best_echo_set = ww_set_image.get('class')[1]
                    best_echo_set = 'Lingering' if best_echo_set == 'Endless' else best_echo_set


            # Extract Best Main Echo
            best_main_echo = "N/A"
            best_main_echo_div = detail_soup.find('div', class_='ww-echo-cost')
            if best_main_echo_div:
                ww_echo_name = best_main_echo_div.find_next('span', class_='ww-echo-name')
                if ww_echo_name:
                    best_main_echo = ww_echo_name.text.strip()

            characters_data.append({
                'Name': name,
                'Rarity': rarity,
                'Element': element,
                # 'Weapon': weapon,
                'HP': hp,
                'ATK': atk,
                'DEF': deff,
                'Max Energy': max_energy,
                'CRIT Rate': crit_rate,
                'CRIT DMG': crit_dmg,
                'Healing Bonus': healb,
                'Element DMG': elementdmg,
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
            time.sleep(1)  # Avoid too many requests in a short period
    return characters_data

def scrape_echoes(soup):
    echoes_data = []
    for echo in soup.select('.ww-echo-box.box'):
        # Extract echo name
        name_element = echo.select_one('.ww-data h4')
        name = name_element.text.strip() if name_element else "N/A"
        
        # Extract class and cost
        class_element = echo.select_one('.ww-info p strong')
        class_name = class_element.text.strip() if class_element else "N/A"
        cost_element = class_element.find_next('strong')
        cost = cost_element.text.strip() if cost_element else "N/A"
        
        # Define the possible elements
        elements = ["Aero", "Electro", "Fusion", "Glacio", "Havoc", "Spectro"]

        # Extract element damage and cooldown
        content_element = echo.select_one('.ww-content .skill-with-coloring')
        if content_element:
            element_dmg = "N/A"
            for element in elements:
                if re.search(rf'\b{element}\b', content_element.text):
                    element_dmg = element
                    break

            # Extract the cooldown
            cooldown_match = re.search(r'CD:\s*(\d+)s', content_element.text)
            cooldown = cooldown_match.group(1) if cooldown_match else "N/A"
        else:
            element_dmg = "N/A"
            cooldown = "N/A"
        
        # Extract sets
        sets = []
        set_div = echo.select_one('div.ww-sets')
        if set_div:
            for single_set_div in set_div.find_all('div', class_='single-set'):
                class_names = single_set_div['class']
                set_name = " ".join(cls for cls in class_names if cls != 'single-set')
                set_name = 'Lingering' if set_name == 'Endless' else set_name
                sets.append(set_name)
        
        echoes_data.append({
            'Name': name,
            'Class': class_name,
            'Cost': cost,
            'Element DMG': element_dmg,
            'Cooldown (s)': cooldown,
            'Sets': sets
        })
        time.sleep(1)  # Avoid too many requests in a short period

    return echoes_data


def scrape_weapons(soup):
    weapons_data = []
    for weapon in soup.select('.ww-weapon-box.box'):
        # Extract weapon name
        name_element = weapon.select_one('.ww-data h4')
        name = name_element.text.strip() if name_element else "N/A"

        # Extract rarity
        rarity_element = weapon.select_one('.ww-info p strong.rarity-ww')
        rarity = ''.join(filter(str.isdigit, rarity_element.text.strip())) if rarity_element else "N/A"
        
        # Extract type
        type_element = weapon.select_one('.ww-info p:nth-of-type(2) strong')
        type_name = type_element.text.strip() if type_element else "N/A"
        
        # Extract atk
        atk_element = weapon.select_one('.ww-stats p strong')
        atk = atk_element.text.strip() if atk_element else "N/A"

        # Extract substat and substat%
        substat_element = weapon.select_one('.ww-stats p + p strong')
        substat_percent = substat_element.text.strip() if substat_element else "N/A"

        # Correct substat extraction
        substat_text = weapon.select_one('.ww-stats p + p')
        substat = substat_text.text.split(':')[0].strip() if substat_text else "N/A"

        # Remove " (lv.90 )" from substat if present
        if " (Lv.90)" in substat:
            substat = substat.replace(" (Lv.90)", "").strip()

        # Change "energy reg ." to "energy regen"
        if "Energy Reg." in substat:
            substat = substat.replace("Energy Reg.", "energy regen").strip()

        weapons_data.append({
            'Name': name,
            'Rarity': rarity,
            'Type': type_name,
            'Atk': atk,
            'Substat': substat,
            'Substat%': substat_percent,
        })
        
        time.sleep(1)  # Avoid too many requests in a short period

    return weapons_data


nltk.download('punkt')

def preprocess_text(text):
    # Case folding
    if text is None or text == "N/A":
        return "NULL"
    text = text.lower()
    
    # Handle "n/a"
    if text == "n/a":
        return "NULL"
    
    # Remove "new!" tags
    text = re.sub(r'new!', '', text)
    
    # Tokenizing
    tokens = word_tokenize(text)
    
    return ' '.join(tokens)


def preprocess_data(data):
    for character in data['characters']:
        # Convert numeric fields to integers or None, then to NULL for MySQL
        character['Rarity'] = int(character['Rarity']) if character['Rarity'].isdigit() else None
        character['HP'] = int(character['HP']) if character['HP'].isdigit() else None
        character['ATK'] = int(character['ATK']) if character['ATK'].isdigit() else None
        character['DEF'] = int(character['DEF']) if character['DEF'].isdigit() else None
        character['Max Energy'] = int(character['Max Energy']) if character['Max Energy'].isdigit() else None
        character['CRIT Rate'] = int(character['CRIT Rate'].replace('%', '')) if '%' in character['CRIT Rate'] else None
        character['CRIT DMG'] = int(character['CRIT DMG'].replace('%', '')) if '%' in character['CRIT DMG'] else None
        character['Healing Bonus'] = int(character['Healing Bonus'].replace('%', '')) if '%' in character['Healing Bonus'] else None
        character['Element DMG'] = int(character['Element DMG'].replace('%', '')) if '%' in character['Element DMG'] else None
        
        # Preprocess text fields
        character['Name'] = preprocess_text(character['Name'])
        character['Element'] = preprocess_text(character['Element'])
        # character['Weapon'] = preprocess_text(character['Weapon'])
        character['WS_Mats'] = preprocess_text(character['WS_Mats'])
        character['RA_Mats'] = preprocess_text(character['RA_Mats'])
        character['A_Mats'] = preprocess_text(character['A_Mats'])
        character['W_Mats'] = preprocess_text(character['W_Mats'])
        character['SU_Mats'] = preprocess_text(character['SU_Mats'])
        character['Best Echo Set'] = preprocess_text(character['Best Echo Set'])
        character['Best Main Echo'] = preprocess_text(character['Best Main Echo'])
        
        # Process Best Weapon fields
        character['Weapon Name'] = preprocess_text(character['Weapon Name'])
        character['Weapon S Level'] = int(character['Weapon S Level']) if character['Weapon S Level'].isdigit() else None

    for echo in data['echoes']:
        # Convert numeric fields to integers or None, then to NULL for MySQL
        echo['Cost'] = int(echo['Cost']) if echo['Cost'].isdigit() else None
        echo['Cooldown (s)'] = int(echo['Cooldown (s)']) if echo['Cooldown (s)'].isdigit() else None
        
        # Preprocess text fields
        echo['Name'] = preprocess_text(echo['Name'])
        echo['Class'] = preprocess_text(echo['Class'])
        echo['Element DMG'] = preprocess_text(echo['Element DMG'])
        echo['Sets'] = [preprocess_text(set_name) for set_name in echo['Sets']]
    
    for weapon in data['weapons']:
        # Convert numeric fields to integers or None, then to NULL for MySQL
        weapon['Rarity'] = int(weapon['Rarity']) if weapon['Rarity'].isdigit() else None
        weapon['Atk'] = int(weapon['Atk']) if weapon['Atk'].isdigit() else None
        weapon['Substat%'] = float(weapon['Substat%'].replace('%', '')) if '%' in weapon['Substat%'] else None

        # Preprocess text fields
        weapon['Name'] = preprocess_text(weapon['Name'])
        weapon['Type'] = preprocess_text(weapon['Type'])
        weapon['Substat'] = preprocess_text(weapon['Substat'])




# Scrape characters data
characters_soup = get_soup(characters_url, driver)
characters_data = scrape_characters(characters_soup)

# Scrape echoes data
echoes_soup = get_soup(echoes_url, driver)
echoes_data = scrape_echoes(echoes_soup)

# Scrape weapons data
weapons_soup = get_soup(weapons_url, driver)
weapons_data = scrape_weapons(weapons_soup)

# Combine the data
data = {
    'characters': characters_data,
    'echoes': echoes_data,
    'weapons': weapons_data
}

# PRE PROCESSING
# Assuming 'data' is the combined data dictionary from the scraping code
# Add this at the end of your script after the data scraping is done
preprocess_data(data)

# Save the preprocessed data to a JSON file
with open('data/wuthering_waves_data.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)

def get_credentials():
    db_name = input("Enter your database name: ")
    db_user = input("Enter your database user: ")
    db_pass = input("Enter your database password: ")
    db_host = input("Enter your database host: ")
    db_port = input("Enter your database port: ")
    return db_name, db_user, db_pass, db_host, db_port

db_name, db_user, db_pass, db_host, db_port = get_credentials()

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

        # Insert into element table
        for character in data['characters']:
            cur.execute("""
                INSERT INTO element (element_name)
                VALUES (%s)
                ON CONFLICT (element_name) DO NOTHING;
            """, (character['Element'],))

        # Insert into weapon table
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

        # Insert into echo table
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

        # Insert into character table
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

            # Insert into char_stats table
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

            # Insert into char_material table
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

            # Insert into weapon_level table
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

# Load JSON data and call the function
with open('data/wuthering_waves_data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    insert_data_to_db(data)

# Close the WebDriver
driver.quit()
import requests
from bs4 import BeautifulSoup
import json
import re

def clean_value(value):
    return re.sub(r'\(.*?\)', '', value).strip() if value else None

def translate_attribute(attr):
    translations = {
        'bld-atk': 'bleed-attack',
        'psn-atk': 'poison-attack',
        'fst-atk': 'frost-attack',
        'phy-atk': 'physical-attack',
        'mag-atk': 'magic-attack',
        'fire-atk': 'fire-attack',
        'ltn-atk': 'lightning-attack',
        'dark-atk': 'dark-attack',
        'phys-def': 'physical-defense',
        'mag-def': 'magic-defense',
        'fire-def': 'fire-defense',
        'ltn-def': 'lightning-defense',
        'dark-def': 'dark-defense',
        'str-bonus': 'strength-bonus',
        'dex-bonus': 'dexterity-bonus',
        'int-bonus': 'intelligence-bonus',
        'fth-bonus': 'faith-bonus',
        'str-req': 'strength-requirement',
        'dex-req': 'dexterity-requirement',
        'int-req': 'intelligence-requirement',
        'fth-req': 'faith-requirement',
    }
    return translations.get(attr, attr)

def convert_value(value):
    if value in [None, 'N/A', '-', '']:
        return None
    return value

# URL
url = "https://darksouls.fandom.com/wiki/Weapons_(Dark_Souls_III)"

response = requests.get(url)
response.raise_for_status()

soup = BeautifulSoup(response.text, 'html.parser')

# Main div to get
content_divs = soup.find_all('div', class_='mw-parser-output')

weapons = []

# Get all data
for content_div in content_divs:
    for header in content_div.find_all(['h3', 'h4']):
        weapon_type = header.get_text(strip=True).split('[')[0] 
        
        if weapon_type == "Explore properties":
            break
        
        next_sibling = header.find_next_sibling()
        if next_sibling and next_sibling.name == 'table':
            continue
        
        if weapon_type == "Talismans":
            continue
        
        ul = header.find_next_sibling('ul')
        if ul:
            for link in ul.find_all('a', href=True):
                href = link['href']
                full_url = f"https://darksouls.fandom.com{href}"
                
                weapon_response = requests.get(full_url)
                weapon_response.raise_for_status()
                weapon_soup = BeautifulSoup(weapon_response.text, 'html.parser')
                
                aside = weapon_soup.find('aside', {'role': 'region'})
                if aside:
                    weapon_data = {}
                    weapon_data['name'] = aside.find('h2', {'data-source': 'name'}).text.strip() if aside.find('h2', {'data-source': 'name'}) else None
                    image_tag = aside.find('figure', {'data-source': 'image'}).find('a')['href'] if aside.find('figure', {'data-source': 'image'}) else None
                    weapon_data['image_url'] = image_tag if image_tag else None

                    for data in aside.find_all('div', class_='pi-data'):
                        attribute = data['data-source']
                        value = clean_value(data.find('div', class_='pi-data-value').text.strip())
                        translated_attribute = translate_attribute(attribute)
                        weapon_data[translated_attribute] = convert_value(value)
                    
                    for section in aside.find_all('section', class_='pi-group'):
                        for table in section.find_all('table', class_='pi-horizontal-group'):
                            caption = table.find('caption').text.strip() if table.find('caption') else ''
                            for row in table.find_all('tr'):
                                for cell in row.find_all('td'):
                                    attribute = cell['data-source']
                                    value = clean_value(cell.text.strip())
                                    translated_attribute = translate_attribute(attribute)
                                    weapon_data[translated_attribute] = convert_value(value)

                    weapon_data['weapon_type'] = weapon_type

                    weapon_data = {k: (v if v is not None else None) for k, v in weapon_data.items() if v is not None}
                    weapons.append(weapon_data)

weapons_json = json.dumps(weapons, indent=4)

# Save to JSON
with open('../../data/Weapons.json', 'w') as json_file:
    json_file.write(weapons_json)
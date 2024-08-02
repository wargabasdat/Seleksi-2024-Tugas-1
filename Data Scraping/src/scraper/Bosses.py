import requests
from bs4 import BeautifulSoup
import json
import re

def clean_value(value):
    return value.strip()

# Remove contents in brackets
def remove_brackets(text):
    return re.sub(r'\[.*?\]', '', text).strip()

# Extract drop section
def extract_drops(drops_section):
    drops = []
    for a_tag in drops_section.find_all('a', href=True, recursive=False):
        drop_text = a_tag.get_text(strip=True)
        if drop_text:
            drops.append(drop_text)
    return drops

def translate_value(value):
    if value == 'R':
        return 'Resistance'
    elif value == 'I':
        return 'Immunity'
    elif value == 'W':
        return 'Weakness'
    else:
        return None

# Extract other data
def fetch_boss_details(url):
    page = requests.get(url)
    soup = BeautifulSoup(page.text, 'lxml')
    
    boss_info = {}
    
    # Name
    name_tag = soup.find('h2', class_='pi-item pi-item-spacing pi-title pi-secondary-background')
    name = clean_value(name_tag.text) if name_tag else None
    # Special case for the best boss in the game
    if name == "Lorian, Elder Prince":
        name = "Twin Princes"
    boss_info['name'] = name
    
    # Image (if needed)
    image_tag = soup.find('figure', class_='pi-item pi-image')
    if image_tag and image_tag.find('img'):
        boss_info['image'] = clean_value(image_tag.find('img')['src'])
    else:
        boss_info['image'] = None
    
    aside = soup.find('aside', class_='portable-infobox')
    if aside:
        for section in aside.find_all('div', class_='pi-item pi-data pi-item-spacing pi-border-color'):
            label_tag = section.find('h3')
            if label_tag:
                label = label_tag.text.strip().lower()
                if label == "location":
                    values = [clean_value(a.text.strip()) for a in section.find_all('a')]
                    boss_info[label] = values
                elif label == "drops":
                    drops_section = section.find('div', class_='pi-data-value pi-font')
                    if drops_section:
                        boss_info[label] = extract_drops(drops_section)
                else:
                    values = [clean_value(value.get_text(strip=True, separator=' ').split(' ')[0]) for value in section.find_all('div', 'pi-data-value pi-font')]
                    boss_info[label] = values

        # HP and Souls
        for table in aside.find_all('table', class_='pi-horizontal-group'):
            caption_tag = table.find('caption')
            if caption_tag:
                caption = caption_tag.text.strip().lower()
                headers = [th.text.strip().lower() for th in table.find_all('th')]
                rows = table.find_all('tr')
                data = {header: [] for header in headers}
                ng_values = {}
                for row in rows:
                    values = row.find_all('td')
                    for i, header in enumerate(headers):
                        if i < len(values):
                            raw_values = values[i].find_all(text=True, recursive=False)
                            cleaned_values = []
                            for value in raw_values:
                                cleaned_value = remove_brackets(value.strip())
                                if cleaned_value:
                                    cleaned_values.append(cleaned_value)
                            if header == 'ng+' and not cleaned_values:
                                cleaned_values = ng_values.get('ng', [])
                            elif header == 'ng':
                                ng_values['ng'] = cleaned_values
                            elif cleaned_values and cleaned_values[0].lower() == 'Varies':
                                cleaned_values = ['10000']
                            data[header].extend(cleaned_values)
                boss_info[caption] = data

        attributes = {
            'phy-atk': 'physical',
            'mag-atk': 'magic',
            'fire-atk': 'fire',
            'ltn-atk': 'lightning',
            'dark-atk': 'dark',
            'bld-atk': 'bleed',
            'psn-atk': 'poison',
            'fst-atk': 'frost'
        }

        for table in aside.find_all('table', class_='pi-horizontal-group'):
            caption_tag = table.find('caption')
            if caption_tag and caption_tag.text.strip().lower() == "weaknesses, resistances, immunities":
                headers = [th['data-source'] for th in table.find_all('th')]
                values = [td.text.strip() for td in table.find_all('td')]
                for i, header in enumerate(headers):
                    if i < len(values):
                        value = clean_value(values[i])
                        translated_value = translate_value(value)
                        if header in attributes:
                            attribute_name = attributes[header]
                            if translated_value:
                                boss_info[attribute_name] = translated_value
                            else:
                                boss_info[attribute_name] = None
    
    if 'weaknesses, resistances, immunities' in boss_info:
        del boss_info['weaknesses, resistances, immunities']
    
    return boss_info

# URL
main_url = 'https://darksouls.fandom.com/wiki/Boss_(Dark_Souls_III)'

page = requests.get(main_url)
soup = BeautifulSoup(page.text, 'lxml')

# Main div to get
div_class_name = 'wikia-gallery wikia-gallery-caption-below wikia-gallery-position-center wikia-gallery-spacing-medium wikia-gallery-border-small wikia-gallery-captions-center wikia-gallery-caption-size-medium'

specific_divs = soup.find_all('div', class_=div_class_name)

boss_links = []

for specific_div in specific_divs:
    gallery_items = specific_div.find_all('div', class_='wikia-gallery-item')
    
    for item in gallery_items:
        # Link for each boss
        link = item.find('a', href=True)
        
        if link:
            # Append
            boss_links.append(f"https://darksouls.fandom.com{link['href']}")

boss_details = []

for link in boss_links:
    boss_info = fetch_boss_details(link)
    boss_details.append(boss_info)

# Save to JSON
with open('../../data/Bosses.json', 'w') as file:
    json.dump(boss_details, file, indent=4)
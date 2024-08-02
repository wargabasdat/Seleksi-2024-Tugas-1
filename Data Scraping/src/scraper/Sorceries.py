import requests
from bs4 import BeautifulSoup
import json

# URL
url = "https://darksouls.fandom.com/wiki/Sorcery_(Dark_Souls_III)"

response = requests.get(url)
response.raise_for_status()

soup = BeautifulSoup(response.text, 'html.parser')

# Main table to fetch
table = soup.find('table', class_='article-table article-table-selected')

rows = table.find_all('tr')[1:]

sorceries = []

# Get all data
for row in rows:
    cols = row.find_all('td')
    sorcery_name = cols[0].find_all('a')[1].text.strip()
    effect = cols[1].text.strip()
    fp_cost = cols[2].text.strip()
    slots = cols[3].text.strip()
    intelligence = cols[4].text.strip()
    
    availability_td = cols[5]
    availability = []
    for content in availability_td.contents:
        if content.name == 'a':
            availability.append(content.text.strip())
        elif content.name == 'br':
            continue
    
    sorcery_data = {
        "name": sorcery_name,
        "effect": effect,
        "fp_cost": int(fp_cost) if fp_cost.isdigit() else None,
        "slots": int(slots) if slots.isdigit() else None,
        "intelligence": int(intelligence) if intelligence.isdigit() else None,
        "availability": availability
    }
    
    sorceries.append(sorcery_data)

sorceries_json = json.dumps(sorceries, indent=2)

# Save to JSON
with open('../../data/Sorceries.json', 'w') as json_file:
    json_file.write(sorceries_json)
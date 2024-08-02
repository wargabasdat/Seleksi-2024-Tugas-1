import requests
from bs4 import BeautifulSoup
import json
import re

# URL
url = "https://darksouls.fandom.com/wiki/Miracle_(Dark_Souls_III)"

response = requests.get(url)

soup = BeautifulSoup(response.content, 'html.parser')

# Main table to get
table = soup.find('table', {'class': 'article-table article-table-selected'})

def extract_first_int(text):
    match = re.search(r'\d+', text)
    return int(match.group()) if match else None

headers = []
for th in table.find_all('th'):
    headers.append(th.text.strip())

# Extract all data
data = []
for row in table.find_all('tr')[1:]:
    cells = row.find_all('td')
    miracle = cells[0].find_all('a')[1].text.strip()
    item_effect = cells[1].text.strip()
    fp_cost = extract_first_int(cells[2].text.strip()) if cells[2].text.strip() != '-' else None
    slots = extract_first_int(cells[3].text.strip()) if cells[3].text.strip() != '-' else None
    faith = extract_first_int(cells[4].text.strip()) if cells[4].text.strip() != '-' else None
    location = []
    current_location = ""
    for content in cells[5].contents:
        if content.name == "a":
            current_location = content.text.strip()
        elif content.name == "br":
            if current_location:
                location.append(current_location)
            current_location = ""
    if current_location:
        location.append(current_location)
    
    data.append({
        "miracle": miracle,
        "item_effect": item_effect,
        "fp_cost": fp_cost,
        "slots": slots,
        "faith": faith,
        "location": location
    })

# Save to JSON
with open('../../data/Miracles.json', 'w') as json_file:
    json.dump(data, json_file, indent=4)

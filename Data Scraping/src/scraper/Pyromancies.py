import requests
from bs4 import BeautifulSoup
import json

def parse_int(value):
    try:
        return int(value.strip())
    except ValueError:
        return None

# URL
url = "https://darksouls.fandom.com/wiki/Pyromancy_(Dark_Souls_III)"

response = requests.get(url)

soup = BeautifulSoup(response.content, 'html.parser')

table = soup.find('table', {'class': 'article-table article-table-selected'})

headers = []
for th in table.find_all('th'):
    headers.append(th.text.strip())

# Extract all data
data = []
for row in table.find_all('tr')[1:]:
    cells = row.find_all('td')
    if len(cells) < 7:
        continue
    pyromancy = cells[0].find_all('a')[1].text.strip()
    item_effect = cells[1].text.strip()
    fp_cost = parse_int(cells[2].text.strip())
    slots = parse_int(cells[3].text.strip())
    intelligence = parse_int(cells[4].text.strip())
    faith = parse_int(cells[5].text.strip())
    location = []
    current_location = ""
    for content in cells[6].contents:
        if content.name == "a":
            current_location = content.text.strip()
        elif content.name == "br":
            if current_location:
                location.append(current_location)
            current_location = ""
    if current_location:
        location.append(current_location)
    
    data.append({
        "pyromancy": pyromancy,
        "item_effect": item_effect,
        "fp_cost": fp_cost,
        "slots": slots,
        "intelligence": intelligence,
        "faith": faith,
        "location": location
    })

# Save to JSON
with open('../../data/Pyromancies.json', 'w') as json_file:
    json.dump(data, json_file, indent=4)
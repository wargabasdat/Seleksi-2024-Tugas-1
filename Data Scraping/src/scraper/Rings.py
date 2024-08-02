import requests
from bs4 import BeautifulSoup
import json

# URL
url = "https://darksouls.fandom.com/wiki/Rings_(Dark_Souls_III)"

response = requests.get(url)
response.raise_for_status()

soup = BeautifulSoup(response.text, 'html.parser')

# Main table to get
table = soup.find('table', class_='article-table rounded')

rings = []

# Take the first <a> after <br>
def extract_locations(td):
    locations = []
    current_a = None
    
    for element in td.contents:
        if element.name == 'a':
            if current_a is None:
                current_a = element.get_text(strip=True)
        elif element.name == 'br':
            if current_a is not None:
                locations.append(current_a)
                current_a = None
    
    if current_a is not None:
        locations.append(current_a)
    
    return locations

for row in table.find('tbody').find_all('tr')[1:]:
    columns = row.find_all('td')
    
    ring_name = columns[0].find_all('a')[-1].text.strip()
    effect = columns[1].text.strip()
    weight = columns[2].text.strip()
    
    try:
        weight = float(weight)
    except ValueError:
        weight = None
    
    location_td = columns[3]
    locations = extract_locations(location_td)
    
    ring_data = {
        'name': ring_name,
        'effect': effect,
        'weight': weight,
        'locations': locations
    }
    
    rings.append(ring_data)

rings_json = json.dumps(rings, indent=4)

# Save to JSON
with open('../../data/Rings.json', 'w') as json_file:
    json_file.write(rings_json)

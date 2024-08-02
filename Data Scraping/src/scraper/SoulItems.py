import requests
from bs4 import BeautifulSoup
import json

def parse_cost(cost_str):
    try:
        return int(cost_str.replace(',', '').strip())
    except ValueError:
        return None

# URL
url = 'https://darksouls.fandom.com/wiki/Boss_Soul_Items_(Dark_Souls_III)'
response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

# Main table to get
table = soup.find('table', {'class': 'article-table'})

data = []

rows = table.find_all('tr')[1:] 

# Get all data
i = 0
while i < len(rows):
    row = rows[i]
    cells = row.find_all('td')

    if len(cells) == 3 and 'rowspan' in cells[0].attrs:
        rowspan = int(cells[0]['rowspan'])
        
        item_name = cells[0].find_all('a')[1].text.strip()

        transpositions = []

        for j in range(rowspan):
            if i + j >= len(rows):
                break

            current_row = rows[i + j]
            cells = current_row.find_all('td')

            if len(cells) == 3:
                transposition_name = cells[2].find_all('a')[1].text.strip()
                transposition_cost = parse_cost(cells[1].text.strip())
            elif len(cells) == 2:
                transposition_name = cells[1].find_all('a')[1].text.strip()
                transposition_cost = parse_cost(cells[0].text.strip())

            transpositions.append({
                'name': transposition_name,
                'cost': transposition_cost
            })

        data.append({
            'item': {
                'name': item_name
            },
            'transpositions': transpositions
        })

        i += rowspan
    else:
        i += 1

# Save to JSON
with open('../../data/SoulItems.json', 'w') as file:
    json.dump(data, file, indent=4)


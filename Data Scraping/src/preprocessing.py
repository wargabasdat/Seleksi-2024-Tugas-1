import json
import pandas as pd

with open('Data Scraping/data/billionaires.json', 'r') as file:
    data = json.load(file)

for item in data:
    item['net_worth'] = float(item['net_worth'].replace('$', '').replace(',', '').replace(' B', ''))

with open('Data Scraping/data/processed_billionaires.json', 'w') as file:
    json.dump(data, file, indent=4)
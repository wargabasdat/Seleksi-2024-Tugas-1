import requests
from bs4 import BeautifulSoup
import json

url = 'https://ceoworld.biz/2024/01/12/richest-billionaires-2024/'
response = requests.get(url)
page_content = response.content

soup = BeautifulSoup(page_content, 'html.parser')

table = soup.find('table', id='tablepress-738') 

if table is None:
    print("Table not found.")
    exit()

billionaires = []

for row in table.find_all('tr')[1:]:
        cols = row.find_all('td')
        if len(cols) == 5:
            rank = cols[0].text.strip()
            company = cols[1].text.strip()
            exe_name = cols[2].text.strip()
            net_worth = cols[3].text.strip()
            country = cols[4].text.strip()

            billionaires.append({
                "rank": rank,
                "company": company,
                "executive_name": exe_name,
                "net_worth": net_worth,
                "country": country
            })

json_data = json.dumps(billionaires, indent=4)

with open('Data Scraping/data/billionaires.json', 'w') as json_file:
    json_file.write(json_data)



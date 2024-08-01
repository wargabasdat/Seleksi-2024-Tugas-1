import requests
from bs4 import BeautifulSoup
import json

main_url = 'https://www.theworlds50best.com/list/1-50'
response = requests.get(main_url)
soup = BeautifulSoup(response.content, 'html.parser')

target_div = soup.find('div', class_='row list visible-list')

links = target_div.find_all('a', href=True)

data = []

for link in links:
    href = link['href']
    full_url = requests.compat.urljoin(main_url, href)
    
    page_response = requests.get(full_url)
    page_soup = BeautifulSoup(page_response.content, 'html.parser')
    
    name_tag = page_soup.find('div', class_='content profile')
    if name_tag:
        details = {}
        name = name_tag.find('h1')
        details['name'] = name.get_text(strip=True)

    details_div = page_soup.find('div', class_='details')
    if details_div:
        location = details_div.find('p', class_='location')
        telephone = details_div.find('a', class_='telephone')
        website = details_div.find('a', class_='website restaurant-bar-link')
        instagram = details_div.find('a', class_='instagram')
        facebook = details_div.find('a', class_='facebook')
        
        details['location'] = location.get_text(strip=True).replace('−', '-') if location else 'null'
        details['telephone'] = telephone.get_text(strip=True).replace(' ', '').replace ('-', '').replace('(', '').replace(')', '') if telephone else 'null'
        details['website'] = website['href'] if website else 'null'
        details['instagram'] = instagram['href'] if instagram else 'null'
        details['facebook'] = facebook['href'] if facebook else 'null'
        
        data.append(details)

output_json = json.dumps(data, indent=4, ensure_ascii=False)

with open('output1.json', 'w', encoding='utf-8') as json_file:
    json_file.write(output_json)
print('Scraping finished. Data saved to output.json')
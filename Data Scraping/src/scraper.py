import requests
from bs4 import BeautifulSoup
import json
import time

headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, seperti Gecko) Chrome/58.0.3029.110 Safari/537.36'
}

base_url = 'https://infokost.id'
search_url = 'https://infokost.id/search-results/?location_search=Bandung%2C+Bandung+City%2C+West+Java%2C+Indonesia&search_city=bandung&search_area=bandung-city&search_country=indonesia&lat=-6.9174639&lng=107.6191228&radius=5'

# Function to extract room details from a kost page
def extract_room_details(soup):
    room_details = []
    room_sections = soup.find_all('div', class_='item-wrap infobox_trigger homey-matchHeight')

    for room in room_sections:
        try:
            room_name = room.find('h2', class_='title roomtitle').get_text(strip=True)
        except AttributeError:
            room_name = None

        if room_name:
            try:
                room_size = room.find('address', class_='item-address').get_text(strip=True)
            except AttributeError:
                room_size = None

            try:
                room_info = [li.get_text(strip=True) for li in room.find('ul', class_='item-amenities').find_all('li')]
            except AttributeError:
                room_info = []

            try:
                room_facilities = [li.get_text(strip=True) for li in room.find('ul', class_='detail-list-disc no-pad').find_all('li')]
            except AttributeError:
                room_facilities = []

            try:
                room_price = room.find('span', class_='item-price').get_text(strip=True)
            except AttributeError:
                room_price = None

            room_details.append({
                'room_name': room_name,
                'room_size': room_size,
                'room_info': room_info,
                'room_facilities': room_facilities,
                'room_price': room_price
            })

    return room_details

# Function to extract kost details from a detailed page
def extract_kost_detail(kost_url):
    response = requests.get(kost_url, headers=headers)
    soup = BeautifulSoup(response.content, 'html.parser')

    try:
        name = soup.find('h1', class_='listing-title').get_text(strip=True)
    except AttributeError:
        name = None

    if name:
        try:
            address = soup.find('address', class_='item-address').get_text(strip=True)
        except AttributeError:
            address = None

        try:
            gender = soup.find('div', class_='gender-box').find('strong').get_text(strip=True)
        except AttributeError:
            gender = None

        try:
            furnished = soup.find('img', src='https://infokost.id/wp-content/themes/homey-child/assets/images/icon-furnished.svg').find_next('strong').get_text(strip=True)
        except AttributeError:
            furnished = 'Not Fully Furnished'

        try:
            price = soup.find('div', class_='sidebar-price').get_text(strip=True)
        except AttributeError:
            price = None

        try:
            facilities = [li.get_text(strip=True) for li in soup.find('ul', class_='detail-list detail-list-2-cols').find_all('li')]
        except AttributeError:
            facilities = []

        try:
            description = soup.find('div', class_='buildingdesc').get_text(strip=True)
        except AttributeError:
            description = None

        room_details = extract_room_details(soup)

        return {
            'name': name,
            'address': address,
            'gender': gender,
            'furnished': furnished,
            'price': price,
            'facilities': facilities,
            'description': description,
            'rooms': room_details
        }

    return {}

# Function to extract kost data from a page
def extract_kost_data(page_url, existing_names):
    response = requests.get(page_url, headers=headers)
    soup = BeautifulSoup(response.content, 'html.parser')
    kost_data = []
    kost_list = soup.find_all('h2', class_='title')[:16]  # Limit to first 16 kosts

    for kost in kost_list:
        try:
            kost_link = kost.find('a')
            if kost_link:
                kost_url = kost_link['href']
                if not kost_url.startswith('http'):
                    kost_url = base_url + kost_url
                kost_detail = extract_kost_detail(kost_url)
                if kost_detail and kost_detail['name'] not in existing_names and 'Bandung' in kost_detail.get('address', ''):
                    kost_data.append(kost_detail)
                    existing_names.add(kost_detail['name'])
        except AttributeError:
            continue

    return kost_data

# Function to scrape multiple pages
def scrape_kost_bandung(pages=1):
    all_kost_data = {}
    existing_names = set()
    index = 0

    for page in range(1, pages + 1):
        print(f'Scraping page {page}...')
        if page == 1:
            page_url = search_url
        else:
            page_url = f'https://infokost.id/search-results/page/{page}/?location_search=Bandung%2C%20Bandung%20City%2C%20West%20Java%2C%20Indonesia&search_city=bandung&search_area=bandung-city&search_country=indonesia&lat=-6.9174639&lng=107.6191228&radius=5'
        kost_data = extract_kost_data(page_url, existing_names)
        for kost in kost_data:
            all_kost_data[str(index)] = kost
            index += 1
        time.sleep(2)  # Avoid overwhelming the server

    return all_kost_data

# Scraping 68 pages 
kost_data = scrape_kost_bandung(pages=68)

# Save the data to a JSON file
output_file = '../data/data_kost.json'
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(kost_data, f, ensure_ascii=False, indent=4)

print(f'Scraping completed. Data saved to {output_file}')
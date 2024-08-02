import requests
from bs4 import BeautifulSoup
import json
import re
import math
import time
from typing import Tuple
from datetime import datetime
import traceback
from requests import HTTPError
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

from phone_page_scrap import *

headers = {
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
    'From' : 'sandiyusufardian@gmail.com'
}

def fetch_page(url, headers):
    session = requests.Session()
    retries = Retry(total=5, backoff_factor=1, status_forcelist=[429, 500, 502, 503, 504])
    session.mount('https://', HTTPAdapter(max_retries=retries))
    
    try:
        response = session.get(url, headers=headers, timeout=30)  # 10 seconds timeout
        response.raise_for_status()  # Raise an exception for HTTP errors
        return response
    except requests.exceptions.RequestException as e:
        print(f"Failed to fetch page: {url}. Error: {e}")
        raise

def iterate_brand_pages(all_brand_url:str, headers:dict) -> Tuple[list, list, list]:
    base_url = 'https://www.gsmarena.com/'

    phones_data = []
    dimensions = []
    resolutions = []

    response = requests.get(all_brand_url, headers=headers)
    time.sleep(1)
    brands_page = BeautifulSoup(response.content, 'html.parser')

    brands_table = brands_page.find('div', class_='st-text')

    # Find all anchor tags within the brands_table
    anchor_tags = brands_table.find_all('a')
    
    # Extract href attribute from each anchor tag (brand_links is a list of brand links where each link have phone links)
    # brand_links = [a['href'] for a in anchor_tags if 'href' in a.attrs]

    # Read brand_links1.txt and brand_links2.txt
    with open('brand_links2.txt', 'r') as f:
        brand_links = f.readlines()
        brand_links = [link.strip() for link in brand_links]

    # with open('brand_links2.txt', 'r') as f:
    #     brand_links2 = f.readlines()
    #     brand_links2 = [link.strip() for link in brand_links2]

    # Write the brand links to a file
    # first half of brand_links to brand_links1.txt
    # with open('brand_links1.txt', 'w') as f:
    #     for link in brand_links[:math.ceil(len(brand_links)/2)]:
    #         f.write(link + '\n')

    # second half of brand_links to brand_links2.txt
    # with open('brand_links2.txt', 'w') as f:
    #     for link in brand_links[math.ceil(len(brand_links)/2):]:
    #         f.write(link + '\n')
    
    # Go to every brand page
    for brand_link in brand_links:
        response = requests.get(base_url + brand_link, headers=headers)
        time.sleep(1)
        brand_page = BeautifulSoup(response.content, 'html.parser')

        print(f"Scraping {base_url + brand_link}...")

        phones_table = brand_page.find('div', class_='makers')

        # Find all anchor tags within the phones_table
        anchor_tags = phones_table.find_all('a')
        
        # Extract href attribute from each anchor tag (tab and pad filtered)
        # filter so release date >= 2020
        year_filter = re.compile(r'.*Announced \w+ (2019|2020|2021|2022|2023|2024)\..*')
        # have to iterate to not only page 1, but page 2, 3, etc. (server side pagination)
        filtered_phone_links = []

        # Exclude amazon brand beacuse it is not a phone brand
        if 'amazon' in brand_link.lower():
            pass
        else:
            while True:
                # Go to every phone page
                for a in anchor_tags:
                    if 'href' in a.attrs and \
                    'tab' not in a.text.lower() and \
                    'pad' not in a.text.lower() and \
                    'watch' not in a.text.lower():
                        img_tag = a.find('img')
                        if img_tag and 'title' in img_tag.attrs and year_filter.match(img_tag['title']) and 'vivo iqoo 7 (india)' not in img_tag['title'].lower():
                            # if the brand is Doogee, then filter product with "T", "R", and "U" because it is not a phone
                            if 'doogee' in brand_link.lower() and \
                                (re.search(r'T\d+', img_tag['title']) or \
                                 re.search(r'R\d+', img_tag['title']) or \
                                 re.search(r'U\d+', img_tag['title'])):
                                continue

                            filtered_phone_links.append(a['href'])

                            phone_data, phone_dimension, phone_resolution = get_phone_spec(base_url + a['href'], headers)
                            time.sleep(1)
                            if phone_data and phone_dimension and phone_resolution:
                                phones_data.append(phone_data)
                                dimensions.append(phone_dimension)
                                resolutions.append(phone_resolution)
                            else:
                                continue
                        else:
                            break  # Exit the loop if the title does not match the year_filter

                # Check if there is a next page
                if brand_page.find('div', class_='nav-pages'):
                    next_page = brand_page.find('a', title='Next page')
                    # If there is a next page, go to the next page
                    if next_page:
                        try:
                            response = fetch_page(base_url + next_page['href'], headers=headers)
                            time.sleep(1)
                            brand_page = BeautifulSoup(response.content, 'html.parser')
                            phones_table = brand_page.find('div', class_='makers')
                            anchor_tags = phones_table.find_all('a')
                        except Exception as e:
                            print(f"Error fetching next page: {e}")
                            break
                    else:
                        break
                else:
                    break

        print(f"Scraped {len(filtered_phone_links)} phones from {base_url + brand_link}\n")
    return phones_data, dimensions, resolutions

# Main function
start = time.time()

try:
    all_brand_url = 'https://www.gsmarena.com/makers.php3'

    # Get all phone data
    phones_data, dimensions, resolutions = iterate_brand_pages(all_brand_url, headers)

    # Save to JSON
    with open('../data/phones_data2.json', 'w') as json_file:
        json.dump(phones_data, json_file, indent=4) 

    with open('../data/dimensions2.json', 'w') as json_file:
        json.dump(dimensions, json_file, indent=4)

    with open('../data/resolutions2.json', 'w') as json_file:
        json.dump(resolutions, json_file, indent=4)   

except Exception as e:
    print(f"ERROR OCCURRED: {e}")
    # print bug position
    traceback.print_exc()

print(f"Counted {len(phones_data)} data phones successfully scraped and saved to phones_data.json, dimensions.json, and resolutions.json")

total_seconds = time.time() - start
minutes = int(total_seconds // 60)
seconds = total_seconds % 60
print(f"Time taken: {minutes} minutes and {seconds:.2f} seconds")

import requests
from bs4 import BeautifulSoup
import re
from typing import Tuple
from datetime import datetime
import time
from requests import HTTPError
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

# def fetch_page(url, headers, retries=3, backoff_factor=1):
#     for i in range(retries):
#         try:
#             response = requests.get(url, headers=headers)
#             response.raise_for_status()
#             return response
#         except (ConnectionError, HTTPError) as e:
#             if i < retries - 1:
#                 wait_time = backoff_factor * (2 ** i)
#                 print(f"Error occurred: {e}. Retrying in {wait_time} seconds...")
#                 time.sleep(wait_time)
#             else:
#                 print(f"Failed to fetch page after {retries} attempts.")
#                 raise

def fetch_page(url, headers):
    session = requests.Session()
    retries = Retry(total=5, backoff_factor=1, status_forcelist=[429, 500, 502, 503, 504])
    session.mount('https://', HTTPAdapter(max_retries=retries))
    
    try:
        response = session.get(url, headers=headers, timeout=10)  # 10 seconds timeout
        response.raise_for_status()  # Raise an exception for HTTP errors
        return response
    except requests.exceptions.RequestException as e:
        print(f"Failed to fetch page: {url}. Error: {e}")
        raise

def parse_release_date(date_str):
    # Extract the date part using regular expression
    match = re.search(r'Released (\d{4}), (\w+) (\d{1,2})', date_str)
    if match:
        year = match.group(1)
        month = match.group(2)
        day = match.group(3)
        
        # Create a datetime object from the extracted parts
        date_obj = datetime.strptime(f"{year} {month} {day}", "%Y %B %d")
        
        # Format the datetime object into the desired string format
        return date_obj.strftime("%Y-%m-%d")
    return None

def get_dimension(overall_str:str)->str:
    if 'folded' in overall_str:
        match = re.search(r'Folded: (\d+\.?\d* x \d+\.?\d* x \d+\.?\d*) mm', overall_str)
        if match:
            return match.group(1)
        else:
            return None  # or handle the case where no match is found
    else:
        match = re.search(r'(\d+\.?\d*) x (\d+\.?\d*) x (\d+\.?\d*) mm', overall_str)
        if match:
            return match.group(0)
        else:
            return None  # or handle the case where no match is found

def get_phone_spec(phone_url, headers) -> Tuple[dict, dict, dict]:
    response = fetch_page(phone_url, headers=headers)
    soup = BeautifulSoup(response.content, 'html.parser')

    # Extract data
    phone_data = {}
    phone_dimension = {}
    phone_resolution = {}

    phone_data['name'] = soup.find('h1', class_='specs-phone-name-title').text.strip()
    phone_dimension['name'] = phone_data['name']
    phone_resolution['name'] = phone_data['name']
    if not phone_data['name']:
        raise Exception('Cannot h1 with class "specs-phone-name-title"')

    specs_table = soup.find('div', id='specs-list')
    if not specs_table:
        raise Exception('Cannot find div with class "specs-list"')
    
    # Check if this phone is already released
    status = specs_table.find('td', class_='nfo', attrs={'data-spec': 'status'})

    print("Scraping", phone_data['name'], "...")

    if not('available' in status.text.lower()):
        return None, None, None

    # Find brand
    phone_data['brand'] = phone_data['name'].split()[0]

    # Extracting specifications
    spec_keys = {
        "battery": "batdescription1",               # mAh
        "storage": "internalmemory",               # GB
        "ram": "internalmemory",                       # GB
        "weight": "weight",                 # g
        "dimensions": "dimensions",         # mm
        "release": "status",
        "os": "os",
        "nfc": "nfc",
        "display_resolution": "displayresolution", # px
        "display_size": "displaysize",             # inch
        "price": "price"                            # USD
    }
    for key, value in spec_keys.items():
        element = specs_table.find('td', class_='nfo', attrs={'data-spec': value})
        if element:
            # Special case for ram, storage, dimensions, and resolution
            if key == 'ram' or key == 'storage':
                # Take the last storage and ram info
                overall_str = [ram_storage_info.strip() for ram_storage_info in element.text.split(',')]
                phone_data[key] = overall_str[-1]
                continue
            elif key == 'dimensions':
                overall_str = get_dimension(element.text.strip())                
                if overall_str:
                    raw_str = overall_str.split(' x ')
                    phone_dimension['height'] = float(raw_str[0])
                    phone_dimension['width'] = float(raw_str[1])
                    phone_dimension['depth'] = float(raw_str[2].split(' ')[0])
                else:
                    phone_dimension['height'] = None
                    phone_dimension['width'] = None
                    phone_dimension['depth'] = None
                continue
            elif key == 'display_resolution':
                raw_str = element.text.strip().split(' x ')
                phone_resolution['width'] = int(raw_str[0])
                phone_resolution['height'] = int(raw_str[1].split(' ')[0])
                continue
            phone_data[key] = element.text.strip()
        else:
            phone_data[key] = None

    # Specific extraction
    if not phone_data.get('battery'):
        phone_data['battery'] = None
    elif 'mAh' in phone_data.get('battery', ''):
        phone_data['battery'] = int(re.search(r'(\d+) mAh', phone_data.get('battery', '')).group(1)) if phone_data.get('battery') else None

    if not phone_data.get('ram'):
        phone_data['ram'] = None
    elif 'GB RAM' in phone_data.get('ram', ''):
        phone_data['ram'] = int(re.search(r'(\d+)\s*GB RAM', phone_data.get('ram', '')).group(1)) if phone_data.get('ram') else None
    elif 'MB RAM' in phone_data.get('ram', ''):
        phone_data['ram'] = int(re.search(r'(\d+)\s*MB RAM', phone_data.get('ram', '')).group(1)) / 1024 if phone_data.get('ram') else None
    else:
        phone_data['ram'] = None

    if not phone_data.get('storage'):
        phone_data['storage'] = None
    elif 'TB' in phone_data.get('storage', ''):
        phone_data['storage'] = int(re.search(r'(\d+)\s*TB', phone_data.get('storage', '')).group(1)) * 1024 if phone_data.get('storage') else None
    elif 'GB' in phone_data.get('storage', ''):
        phone_data['storage'] = int(re.search(r'(\d+)\s*GB', phone_data.get('storage', '')).group(1)) if phone_data.get('storage') else None
    elif 'MB' in phone_data.get('storage', ''):
        phone_data['storage'] = int(re.search(r'(\d+)\s*MB', phone_data.get('storage', '')).group(1)) / 1024 if phone_data.get('storage') else None
    else:
        phone_data['storage'] = None
    
    if not phone_data.get('weight'):
        phone_data['weight'] = None
    elif ' g' in phone_data.get('weight', ''):
        phone_data['weight'] = int(re.search(r'(\d+) g', phone_data.get('weight', '')).group(1)) if phone_data.get('weight') else None
    else:
        phone_data['weight'] = None
    
    phone_data['release'] = parse_release_date(phone_data.get('release'))
    
    if not phone_data.get('os'):
        phone_data['os'] = None
    elif phone_data.get('os'):
        match = re.search(r'(\w+)\s*(\d*)', phone_data.get('os', ''))
        phone_data['os'] = match.group(1) if match else None

    if not phone_data.get('nfc'):
        phone_data['nfc'] = None
    elif phone_data.get('nfc'):
        match = re.search(r'yes|no', phone_data.get('nfc', ''), re.IGNORECASE)
        phone_data['nfc'] = match.group(0) if match else None

    if not phone_data.get('display_size'):
        phone_data['display_size'] = None
    elif phone_data.get('display_size'):
        match = re.search(r'(\d+\.?\d*) inches', phone_data.get('display_size', ''))
        phone_data['display_size'] = float(match.group(1)) if match else None

    if not phone_data.get('price'):
        phone_data['price'] = None
    # "About XXX EUR" case
    elif phone_data.get('price') and 'EUR' in phone_data.get('price', ''):
        match = re.search(r'About (\d+) EUR', phone_data.get('price', ''))
        phone_data['price'] = float(match.group(1)) * 1.08 if match else None       # Convert EUR to USD 
    # "$ 1,899.99 / € 1,999.00 / £ 1,762.20 / ₹ 164,999" case
    elif phone_data.get('price'):
        price_str = phone_data.get('price', '')
        match = re.search(r'\$\s*([\d,]+(?:\.\d{2})?)', price_str)
        if match:
            price = match.group(1).replace(',', '')
            phone_data['price'] = float(price)
        else:
            phone_data['price'] = None

    return phone_data, phone_dimension, phone_resolution

# Test Driver
if __name__ == '__main__':
    headers = {
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36',
        'From' : 'sandiyusufardian@gmail.com'
    }
    phone_url = 'https://www.gsmarena.com/doogee_v10-11805.php'
    phone_data, phone_dimension, phone_resolution = get_phone_spec(phone_url, headers)
    time.sleep(1)
    print("Phone Data:")
    print(phone_data, "\n")
    print("Phone Dimension:")
    print(phone_dimension, "\n")
    print("Phone Resolution:")
    print(phone_resolution, "\n")
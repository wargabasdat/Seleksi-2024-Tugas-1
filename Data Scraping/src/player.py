import datetime
import requests
from bs4 import BeautifulSoup
import re
import mysql.connector
from jsonfile import save_to_json

# mengubah bentuk tanggal ke bentuk yang sesuai di mysql
def convert_date(date_str):
    match = re.search(r"(\w+ \d{1,2}, \d{4})", date_str)
    if match:
        date_part = match.group(1)
        return datetime.datetime.strptime(date_part, '%B %d, %Y').date()
    return None

# mengubah tinggi ke cm (metrik)
def convert_height(height_string):
    if height_string:
        parts = height_string.split("-")
        feet = int(parts[0])
        inches = int(parts[1])
        return int((feet * 12 + inches) * 2.54)
    return None

# mengubah berat ke kg (metrik)
def convert_weight(weight_string):
    if weight_string:
        parts = weight_string.split(" ")
        return int(int(parts[0])*0.453592)

# mengambil list player top 150 (atp, wta)
def scrape_ranking_data(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }
    response = requests.get(url, headers=headers)
    data = []
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
    
        rows = soup.find_all('tr', class_='Table__TR Table__TR--sm Table__even')
        for row in rows:
            player_info = row.find('a', class_='AnchorLink')
            player_url = player_info['href']
            player_id = re.search(r'/id/(\d+)/', player_url).group(1) if re.search(r'/id/(\d+)/', player_url) else "ID not found"

            # connect database
            connection = mysql.connector.connect(
                host='localhost',
                user='root',
                password='shzyt2929',
                database='tennis_database'
            )
            
            data.append(scrape_player_profile(player_url, connection, player_id))
    else:
        print("Failed to retrieve the ranking page. Status code:", response.status_code)
    return data

# memasukkan data player ke database
def insert_player_data(connection, player_id, player_name, country, playing_hand, year_turned_pro, birth_date, height, weight, hometown):
    cursor = connection.cursor()
    query = """
    INSERT INTO Player (player_id, player_name, country, playing_hand, year_turned_pro, birth_date, height, weight, hometown)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    cursor.execute(query, (player_id, player_name, country, playing_hand, year_turned_pro, birth_date, height, weight, hometown))
    connection.commit()

# mengupdate data player pada database
def update_player_data(connection, player_id, player_name, country, playing_hand, year_turned_pro, birth_date, height, weight, hometown):
    cursor = connection.cursor()
    query = """
    UPDATE Player
    SET player_name = %s, country = %s, playing_hand = %s, year_turned_pro = %s, birth_date = %s, height = %s, weight = %s, hometown = %s
    WHERE player_id = %s
    """

    cursor.execute(query, (
        player_name, country, playing_hand, year_turned_pro, birth_date, height, weight, hometown,
        player_id
    ))
    connection.commit()

def scrape_player_profile(url, connection, player_id):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }
    # request ke website
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        player_details = {'Name': soup.find('h1').text.strip() if soup.find('h1') else "Name not found"}
        bio_info = soup.find('div', class_='player-bio')
        if bio_info:
            general_info = bio_info.find('ul', class_='general-info')
            for li in general_info.find_all('li'):
                text = li.get_text(strip=True)
                country = general_info.find_all('li', class_='first')
                if "Plays:" in text:
                    # informasi bermain dengan tangan apa
                    player_details['Hand'] = text.split(': ')[1]
                elif "Turned Pro:" in text:
                    # informasi tahun menjadi pro
                    player_details['Turned Pro'] = text.split(': ')[1]
                elif li in country:
                    # informasi negara
                    player_details['Country'] = li.get_text(strip=True)

            metadata_sections = soup.find_all('ul', class_='player-metadata')
            for section in metadata_sections:
                items = section.find_all('li')
                for item in items:
                    key = item.find('span').text.strip()
                    value = item.get_text(strip=True).replace(item.find('span').text, '').strip()
                    player_details[key] = value
            
            # jika kosong diisi dengan null
            player_name = player_details.get('Name', None)
            country = player_details.get('Country', None)
            playing_hand = player_details.get('Hand', None)
            year_turned_pro = player_details.get('Turned Pro', None)
            birth_date = convert_date(player_details.get('Birth Date')) if 'Birth Date' in player_details else None
            height = convert_height(player_details.get('Height')) if 'Height' in player_details else None
            weight = convert_weight(player_details.get('Weight')) if 'Weight' in player_details else None
            hometown = player_details.get('Hometown', None)

            data = ({
                "player_id": player_id,
                "player_name": player_name,
                "country": country,
                "playing_hand": playing_hand,
                "year_turned_pro": year_turned_pro,
                "birth_date": birth_date.strftime('%Y-%m-%d') if birth_date else None,
                "height": height,
                "weight": weight,
                "hometown": hometown
            })

            try:
                insert_player_data(connection, player_id, player_name, country, playing_hand, year_turned_pro, birth_date, height, weight, hometown)
            except:
                update_player_data(connection, player_id, player_name, country, playing_hand, year_turned_pro, birth_date, height, weight, hometown)
                pass
        return data
import requests
from bs4 import BeautifulSoup
import re
import mysql.connector
from jsonfile import save_to_json

# memasukkan data ke PlayerStats
def insert_stats_data(connection, player_id, year, singles_title, doubles_title, singles_win, singles_lose, prize_money):
    cursor = connection.cursor()
    query = """
    INSERT INTO PlayerStats (player_id, year, singles_title, doubles_title, singles_win, singles_lose, prize_money)
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    cursor.execute(query, (
        player_id, year, singles_title, doubles_title, singles_win, singles_lose, prize_money
    ))
    connection.commit()

# update data pada PlayerStats
def update_stats_data(connection, player_id, year, singles_title, doubles_title, singles_win, singles_lose, prize_money):
    cursor = connection.cursor()
    query = """
    UPDATE PlayerStats
    SET singles_title = %s, doubles_title = %s, singles_win = %s, singles_lose = %s, prize_money = %s
    WHERE player_id = %s AND year = %s
    """
    cursor.execute(query, (
        singles_title, doubles_title, singles_win, singles_lose, prize_money, 
        player_id, year
    ))
    connection.commit()

# mengambil data stats
def scrape_stats_from_url(connection, url, player_id):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }

    response = requests.get(url, headers=headers)
    datas = []
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        # mencari table stats
        tables = soup.find_all('table', class_='tablehead')
        table = tables[1]
        # mencari setiap row pada tabel
        headers = [th.get_text() for th in table.find('tr', class_='colhead').find_all('th')]
        rows = table.find_all('tr', class_='oddrow') + table.find_all('tr', class_='evenrow')

        for row in rows:
            if 'total' not in row.get('class', []):
                cols = row.find_all('td')
                row_data = {headers[i]: cols[i].get_text().strip() for i in range(len(cols))}
                # tahun data
                year = int(row_data['YEAR'])
                # uang yang dihasilkan pada tahun tersebut
                prize_money = float(row_data['PRIZE MONEY'].replace('$', '').replace(',', ''))
                # banyak title singles pada tahun tersebut
                singles_title = int(row_data['SINGLES TITLES'])
                # banyak title doubles pada tahun tersebut
                doubles_title = int(row_data['DOUBLES TITLES'])
                # jumlah win dan lose pada tahun tersebut
                singles_win, singles_lose = map(int, row_data['SINGLES W-L'].split('-'))

                data = ({
                    "player_id": player_id,
                    "year": year,
                    "singles_title": singles_title,
                    "doubles_title": doubles_title,
                    "singles_win": singles_win,
                    "singles_lose": singles_lose,
                    "prize_money": prize_money
                })

                datas.append(data)

                # memasukkan data pada database
                try:
                    insert_stats_data(connection, player_id, year, singles_title, doubles_title, singles_win, singles_lose, prize_money)
                except:
                    update_stats_data(connection, player_id, year, singles_title, doubles_title, singles_win, singles_lose, prize_money)
                    continue
                
    else:
        print("Failed to fetch data. HTTP Status Code:", response.status_code)
    return datas
    
def scrape_main_link(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }
    # request ke website
    response = requests.get(url, headers=headers)
    data = []
    # connect database
    connection = mysql.connector.connect(
        host='localhost',
        user='root',
        password='shzyt2929',
        database='tennis_database'
    )
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')

        rows = soup.find_all('tr', class_='Table__TR Table__TR--sm Table__even')
        # iterasi untuk semua rank
        for row in rows:
            player_info = row.find('a', class_='AnchorLink')
            player_url = player_info['href']
            player_id = re.search(r'/id/(\d+)/', player_url).group(1) if re.search(r'/id/(\d+)/', player_url) else "ID not found"
            try:
                data.append(scrape_stats_from_url(connection, player_url, player_id))
            except:
                continue

    else:
        print("Failed to retrieve the ranking page. Status code:", response.status_code)
    return data
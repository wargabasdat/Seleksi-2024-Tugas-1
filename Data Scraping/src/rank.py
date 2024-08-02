import datetime
import requests
from bs4 import BeautifulSoup
import re
import mysql.connector
from jsonfile import save_to_json

# mengubah bentuk tanggal
def convert_date(date_string):
    return datetime.datetime.strptime(date_string, '%B %d, %Y').date()

# memasukkan data ranking
def insert_rank_data(connection, player_id, date, rank, points, change_in_rank, rank_type):
    cursor = connection.cursor()
    query = """
    INSERT INTO Rank (player_id, date, rank, points, change_in_rank, rank_type)
    VALUES (%s, %s, %s, %s, %s, %s)
    """

    cursor.execute(query, (
        player_id, date, rank, points, change_in_rank, rank_type
    ))
    connection.commit()

# mengupdate data ranking pada database
def update_rank_data(connection, player_id, date, rank, points, change_in_rank, rank_type):
    cursor = connection.cursor()
    query = """
    UPDATE Rank
    SET player_id = %s, points = %s, change_in_rank = %s
    WHERE date = %s AND rank = %s AND rank_type = %s
    """

    cursor.execute(query, (
        player_id, points, change_in_rank,
        date, rank, rank_type
    ))
    connection.commit()

# mengambil data ranking
def scrape_rank_data(url, rank_type):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }
    # request ke website
    response = requests.get(url, headers=headers)
    ranking_data = []

    # connect ke mysql
    connection = mysql.connector.connect(
        host='localhost',
        user='root',
        password='shzyt2929',
        database='tennis_database'
    )
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        last_updated_note = soup.find('p', class_='rankings__specialNote')
        # tanggal updated
        if last_updated_note:
            last_updated_text = last_updated_note.get_text(strip=True)
            date_pattern = r"(\w+ \d{1,2}, \d{4})"
            match = re.search(date_pattern, last_updated_text)
            if match:
                date_str = match.group(1)
            date = convert_date(date_str)
        # iterasi untuk semua rank
        rows = soup.find_all('tr', class_='Table__TR Table__TR--sm Table__even')
        for row in rows:
            # ranking
            rank = row.find('span', class_='rank_column').text.strip()
            # perubahan pada ranking
            trend = row.find('div', class_='trend')
            if 'positive' in trend['class']:
                number = int(trend.get_text(strip=True))
            elif 'negative' in trend['class']:
                number = int(trend.get_text(strip=True))
                number = -1 * number
            else:
                number = 0
            player_info = row.find('a', class_='AnchorLink')
            player_url = player_info['href']
            # player id
            player_id = re.search(r'/id/(\d+)/', player_url).group(1) if re.search(r'/id/(\d+)/', player_url) else "ID not found"
            # point player
            points = row.find_all('td')[3].text.strip()
            points = points.replace(',', '')

            ranking_data.append({
                "rank": int(rank),
                "date": date.strftime('%Y-%m-%d') if date else None,
                "rank_type": rank_type,
                "player_id": int(player_id),
                "points": int(points),
                "change_in_rank": int(number)
            })

            # memasukkan data ke tabel Rank
            try:
                insert_rank_data(connection, int(player_id), date, int(rank), int(points), int(number), rank_type)
            except:
                update_rank_data(connection, player_id, date, int(rank), int(points), int(number), rank_type)
                continue
    else:
        print("Failed to retrieve the ranking page. Status code:", response.status_code)
    return ranking_data
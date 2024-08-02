import requests
from bs4 import BeautifulSoup
import re
import datetime
import mysql.connector
from jsonfile import save_to_json

# mengubah bentukan tanggal ke bentuk yang sesuai dengan mysql
def convert_date(date_string):
    return datetime.datetime.strptime(date_string, '%B %d, %Y').date()

def extract_event(text):
    pattern = r"^(.*?)\s-\sPartner:\s(.*)$"
    
    match = re.search(pattern, text)
    
    if match:
        event_type = match.group(1)
        return event_type
    else:
        return text

# memasukkan data tournament ke PlayerTournament
def insert_tournament_data(connection, tournament_id, event, player_id, player_result):
    cursor = connection.cursor()
    query = """
    INSERT INTO PlayerTournament (tournament_id, event, player_id, player_result)
    VALUES (%s, %s, %s, %s)
    """
    cursor.execute(query, (
        tournament_id, event, player_id, player_result
    ))
    connection.commit()

# update data tournament pada PlayerTournament
def update_tournament_data(connection, tournament_id, event, player_id, player_result):
    cursor = connection.cursor()
    query = """
    UPDATE PlayerTournament
    SET player_result = %s
    WHERE tournament_id = %s AND player_id = %s AND event = %s
    """
    cursor.execute(query, (
        player_result, 
        tournament_id, player_id, event
    ))
    connection.commit()

# memasukkan data tournament ke Tournament
def insert_tour_data(connection, tournament_id, event, tournament_name, location, start_date, end_date):
    cursor = connection.cursor()
    query = """
    INSERT INTO Tournament (tournament_id, event, tournament_name, location, start_date, end_date)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    cursor.execute(query, (
        tournament_id, event, tournament_name, location, start_date, end_date
    ))
    connection.commit()

# update data tournament pada Tournament
def update_tour_data(connection, tournament_id, event, tournament_name, location, start_date, end_date):
    cursor = connection.cursor()
    query = """
    UPDATE Tournament
    SET tournament_name = %s, location = %s, start_date = %s, end_date = %s
    WHERE tournament_id = %s AND event = %s
    """
    cursor.execute(query, (
        tournament_name, location, start_date, end_date,
        tournament_id, event
    ))
    connection.commit()

def scrape_tournament_results(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }
    # melakukan request
    response = requests.get(url, headers=headers)
    datas = []
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        # connect ke database
        connection = mysql.connector.connect(
        host='localhost',
        user='root',
        password='shzyt2929',
        database='tennis_database'
        )
        # mencari bagian yang berisi tabel tournament dengan html parsing
        tournament_blocks = soup.find_all('div', class_='gradient-container')
        for block in tournament_blocks:
            details = block.find('div', class_='game-details')
            if details:
                text = ' '.join(details.find('p').stripped_strings)
                regex_pattern = re.compile(r'^(.*?) - (.*?), ([\w\s\'-]+) (\w+ \d{1,2}, \d{4}) to (\w+ \d{1,2}, \d{4})')
                match = regex_pattern.search(text)
                # nama tournament
                name_info = details.find('strong')
                
                if name_info:
                    # link tournament
                    tournament_link = name_info.find('a')['href'] if name_info.find('a') else "No link available"
                    # id tournament
                    tournament_id = re.search(r'/tournamentId/(\d+)/', tournament_link).group(1) if re.search(r'/tournamentId/(\d+)/', tournament_link) else "ID not found"

                if match:
                    tournament_name = match.group(1).strip().lstrip('*').strip()
                    location = match.group(2).strip() + ', ' + match.group(3).strip()
                    start_date = match.group(4)
                    end_date = match.group(5)
                
                current_event = None
                event_results = []
                previous_round = None

                player_id = re.search(r'/id/(\d+)/', url).group(1) if re.search(r'/id/(\d+)/', url) else "ID not found"

                match_table = block.find_next('table', class_='tablehead')
                if match_table:
                    rows = match_table.find_all('tr')
                    for i, row in enumerate(rows):
                        if 'total' in row.get('class', []):
                            if event_results:
                                for result in event_results:
                                    if result[4]:
                                        data = ({
                                            "tournament_id": tournament_id,
                                            "player_id": player_id,
                                            "event": current_event,
                                            "tournament_name": tournament_name,
                                            "start_date": convert_date(start_date).strftime('%Y-%m-%d') if convert_date(start_date) else None,
                                            "end_date": convert_date(end_date).strftime('%Y-%m-%d') if convert_date(end_date) else None,
                                            "player_result": result[4]
                                        })
                                        datas.append(data)
                                        current_event = extract_event(current_event)
                                        # memasukkan data ke database table Tournament
                                        try:
                                            insert_tour_data(connection, tournament_id, current_event, tournament_name, location, convert_date(start_date), convert_date(end_date))
                                        except:
                                            update_tour_data(connection, tournament_id, current_event, tournament_name, location, convert_date(start_date), convert_date(end_date))
                                        # memasukkan data ke database table PlayerTournament
                                        try:
                                            insert_tournament_data(connection, tournament_id, current_event, player_id, result[4])
                                        except:
                                            update_tournament_data(connection, tournament_id, current_event, player_id, result[4])
                            current_event = row.find('td').text.strip()
                            event_results = []
                            previous_round = None
                        elif 'colhead' not in row.get('class', []):
                            cells = row.find_all('td')
                            # mencari final result dari tournament (round terakhir yang dimainkan, jika round terakhir berupa final dan resultnya win, maka Winner)
                            if len(cells) >= 4:
                                round_played = cells[0].text.strip() or previous_round or "Qualifications"
                                opponent = cells[1].text.strip()
                                result = cells[2].text.strip()
                                score = cells[3].text.strip()
                                final_result = None
                                if i == len(rows) - 1 or 'total' in rows[i + 1].get('class', []) or 'colhead' in rows[i + 1].get('class', []):
                                    if "Final" in round_played and "W" in result:
                                        final_result = "Winner"
                                    else:
                                        final_result = f"{round_played} Round"
                                event_results.append((round_played, opponent, result, score, final_result))
                                previous_round = round_played
                    if event_results:
                        for result in event_results:
                            if result[4]:
                                data = ({
                                    "tournament_id": tournament_id,
                                    "player_id": player_id,
                                    "event": current_event,
                                    "tournament_name": tournament_name,
                                    "start_date": convert_date(start_date).strftime('%Y-%m-%d') if convert_date(start_date) else None,
                                    "end_date": convert_date(end_date).strftime('%Y-%m-%d') if convert_date(end_date) else None,
                                    "player_result": result[4]
                                })
                                datas.append(data)
                                current_event = extract_event(current_event)
                                # memasukkan data ke database table Tournament
                                try:
                                    insert_tour_data(connection, tournament_id, current_event, tournament_name, location, convert_date(start_date), convert_date(end_date))
                                except:
                                    update_tour_data(connection, tournament_id, current_event, tournament_name, location, convert_date(start_date), convert_date(end_date))
                                # memasukkan data ke database table PlayerTournament
                                try:
                                    insert_tournament_data(connection, tournament_id, current_event, player_id, result[4])
                                except:
                                    update_tournament_data(connection, tournament_id, current_event, player_id, result[4])
    else:
        print("Failed to retrieve the webpage. Status code:", response.status_code)
    return datas

def scrape_list(url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }
    # membuat request ke laman utama yang berisi ranking
    response = requests.get(url, headers=headers)
    data = []
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        # melakukan pencarian match untuk semua rank
        rows = soup.find_all('tr', class_='Table__TR Table__TR--sm Table__even')
        for row in rows:
            player_info = row.find('a', class_='AnchorLink')
            player_url = player_info['href']
            
            results_url = player_url.replace("/player/_/", "/player/results/_/")
            data.append(scrape_tournament_results(results_url))
    else:
        print("Failed to retrieve the ranking page. Status code:", response.status_code)
    return data
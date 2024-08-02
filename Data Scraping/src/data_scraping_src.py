# Importing Used Library
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
import time
import pandas as pd
from bs4 import BeautifulSoup
import re
import json
import mariadb
import os

def scrape_and_preprocess_data():
   
    # DATA SCRAPING

    # Setup Chrome options
    chrome_options = Options()
    chrome_options.add_argument("--headless")  # Ensure GUI is off
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    # Manually set the path to the ChromeDriver executable
    chrome_driver_path = r'C:\Users\USER\Downloads\chromedriver-win64 (1)\chromedriver-win64\chromedriver.exe'
    webdriver_service = Service(chrome_driver_path)

    # Initialize the Chrome WebDriver
    driver = webdriver.Chrome(service=webdriver_service, options=chrome_options)

    # Set window size
    driver.set_window_size(1920, 1080)
    # URL of the MLB prospects page
    url = 'https://www.mlb.com/prospects'

    # Open the website
    driver.get(url)

    # Wait for the page to load and display the data
    time.sleep(5)

    # Accept the cookie consent banner if it appears
    try:
        accept_cookies_button = driver.find_element(By.ID, "onetrust-accept-btn-handler")
        accept_cookies_button.click()
        # Wait for the banner to disappear
        time.sleep(2)
    except:
        print("Cookie consent banner not found.")

    # Click the "Show Full List" button
    show_full_list_button = driver.find_element(By.XPATH, "//button[contains(text(), 'Show Full List')]")
    show_full_list_button.click()

    # Wait for the additional data to load
    time.sleep(5)

    # Get the page source and parse it with BeautifulSoup
    soup = BeautifulSoup(driver.page_source, 'html.parser')

    # Close the browser
    driver.quit()

    # Make data frame 
    table = soup.find_all('table')[0]
    header = table.find_all('th')
    headers = [title.text for title in header]

    df = pd.DataFrame(columns=headers)
    row_data = table.find_all('tr')[1:]
    for row in row_data:
        rows_data = row.find_all('td')
        individual_row = [data.text.strip() for data in rows_data]
        length = len(df)
        df.loc[length] = individual_row

    # DATA PREPROCESSING

    # Function to parse height and weight, convert height to cm and weight to kg
    def parse_height_weight(height_weight):
        height_weight_match = re.match(r"(\d+)' (\d+)\" / (\d+) lbs", height_weight)
        if height_weight_match:
            feet = int(height_weight_match.group(1))
            inches = int(height_weight_match.group(2))
            weight = int(height_weight_match.group(3))
            total_inches = feet * 12 + inches
            height_cm = total_inches * 2.54  # Convert inches to cm
            weight_kg = weight * 0.453592  # Convert lbs to kg
            return height_cm, weight_kg
        else:
            return None, None

    # Apply the function to the DataFrame
    df['Height (cm)'], df['Weight (kg)'] = zip(*df['Height / Weight'].map(parse_height_weight))

    # Delete the original "Height / Weight" column
    df.drop(columns=['Height / Weight'], inplace=True)

    # Convert DataFrame to JSON using 'index' orientation
    json_str = df.to_json(orient='index')

    # Parse the JSON string
    parsed_json = json.loads(json_str)

    # Pretty-print the parsed JSON
    formatted_json = json.dumps(parsed_json, indent=4)

    # Directory to save the JSON file
    json_save_directory = r'C:\Users\USER\OneDrive\Documents\GitHub\Seleksi-2024-Tugas-1\Data Scraping\data'
    json_file_name = 'top100mlbprospects.json'

    # Create the directory if it doesn't exist
    os.makedirs(json_save_directory, exist_ok=True)

    # Full path for the JSON file
    json_file_path = os.path.join(json_save_directory, json_file_name)

    # Write the formatted JSON to a file
    try:
        with open(json_file_path, 'w') as file:
            file.write(formatted_json)
        print("JSON file successfully written.")
    except Exception as e:
        print(f"Error writing JSON file: {e}")

def store_data() :
    # DATA STORING

    # Directory where the JSON file is saved
    json_save_directory = r'C:\Users\USER\OneDrive\Documents\GitHub\Seleksi-2024-Tugas-1\Data Scraping\data'
    json_file_name = 'top100mlbprospects.json'

    # Full path for the JSON file
    json_file_path = os.path.join(json_save_directory, json_file_name)

    # Load JSON data from the file
    try:
        with open(json_file_path, 'r') as file:
            data = json.load(file)
        print("JSON file successfully loaded.")
    except Exception as e:
        print(f"Error loading JSON file: {e}")

    # Connect to the MariaDB server
    conn = mariadb.connect(
        host='localhost',  # e.g., 'localhost'
        user='root',  # e.g., 'root'
        password='praktikum'  # e.g., 'password'
    )
    cursor = conn.cursor()

    # Create the database if it doesn't exist
    cursor.execute("CREATE DATABASE IF NOT EXISTS baseball")
    cursor.execute("USE baseball")

    # Create tables to store the data (adjust column names and types as needed)
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Division_League (
            league_id INT,
            division_id INT,
            league_name VARCHAR(255),
            division_name VARCHAR(255),
            PRIMARY KEY (league_id, division_id)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Team (
            team_name VARCHAR(255) PRIMARY KEY,
            contact_number VARCHAR(13),
            address VARCHAR(255),
            wins INT,
            loses INT,
            official_website VARCHAR(255),
            league_id INT,
            division_id INT,
            CONSTRAINT FK_Team_Division_League FOREIGN KEY (league_id, division_id) REFERENCES Division_League(league_id, division_id)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Coach (
            coach_id INT PRIMARY KEY,
            coach_name VARCHAR(255),
            team_name VARCHAR(255),
            CONSTRAINT FK_Coach_Team FOREIGN KEY (team_name) REFERENCES Team (team_name)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Coach_Per_Type (
            coach_id INT,
            coach_type VARCHAR(255),
            PRIMARY KEY (coach_id, coach_type),
            CONSTRAINT FK_Coach_CoachType FOREIGN KEY (coach_id) REFERENCES Coach (coach_id)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Player (
            player_name VARCHAR(255) PRIMARY KEY,
            rank INT,
            position VARCHAR(255),
            team_name VARCHAR(255),
            level VARCHAR(255),
            eta VARCHAR(255),
            age INT,
            bats VARCHAR(5),
            throws VARCHAR(5),
            height_cm FLOAT,
            weight_kg FLOAT,
            CONSTRAINT FK_Player_Team FOREIGN KEY (team_name) REFERENCES Team(team_name)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Stadium (
            stadium_id INT PRIMARY KEY,
            stadium_name VARCHAR(255),
            capacity INT,
            city VARCHAR(255),
            states VARCHAR(255),
            zip_code INT
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Season (
            season_id INT PRIMARY KEY,
            season_year INT
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Regular_Season (
            season_id INT PRIMARY KEY,
        CONSTRAINT FK_Season_Regular FOREIGN KEY (season_id) REFERENCES Season(season_id)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Playoff (
            season_id INT PRIMARY KEY,
            round_series VARCHAR(255),
        CONSTRAINT FK_Season_Playoff FOREIGN KEY (season_id) REFERENCES Season(season_id)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Game (
            game_id INT PRIMARY KEY,
            stadium_id INT,
            season_id INT,
            date DATE,
            start_time TIME,
            end_time TIME,
            home_team_name VARCHAR(255),
            away_team_name VARCHAR(255),
            home_score INT,
            away_score INT,
            CONSTRAINT FK_Game_Stadium FOREIGN KEY (stadium_id) REFERENCES Stadium(stadium_id),
            CONSTRAINT FK_Game_Season FOREIGN KEY (season_id) REFERENCES Season(season_id),
            CONSTRAINT FK_Game_Home_Team FOREIGN KEY (home_team_name) REFERENCES Team(team_name),
            CONSTRAINT FK_Game_Away_Team FOREIGN KEY (away_team_name) REFERENCES Team(team_name),
            CONSTRAINT chk_team_names_different CHECK (home_team_name <> away_team_name)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS Player_Stats (
            player_stats_id INT,
            game_id INT,
            player_name VARCHAR(255),
            hits INT,
            strikeouts INT,
            at_bats INT,
            PRIMARY KEY (player_stats_id, game_id, player_name),
            CONSTRAINT FK_Stats_Game FOREIGN KEY (game_id) REFERENCES Game(game_id),
            CONSTRAINT FK_Stats_Player FOREIGN KEY (player_name) REFERENCES Player(player_name)
        )
    ''')

    conn.commit()

    # Dummy Data Division_League to be inserted (otherwise errors will occur when inserting data to the 'Player' table)
    division_league = [
    (1, 1, "American League", "East"),
    (1, 2, "American League", "West"),
    (1, 3, "American League", "Central"),
    (2, 1, "National League", "East"),
    (2, 2, "National League", "West"),
    (2, 3, "National League", "Central")
    ]

    # Insert data into `Division_League` table
    for league_id, division_id, league_name, division_name in division_league:
        cursor.execute('''
            INSERT INTO Division_League (league_id, division_id, league_name, division_name)
            VALUES (?, ?, ?, ?)
    ''', (league_id, division_id, league_name, division_name))

    conn.commit()

    # Insert data from data scraping into the 'Team' table
    cursor.execute("SELECT league_id, division_id FROM Team")
    team_names = [row[0] for row in cursor.fetchall()]
    for key, value in data.items():
        
        cursor.execute('''            
            INSERT INTO Team (team_name, contact_number, address, wins, loses, official_website, league_id, division_id)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE team_name = VALUES(team_name)
        ''', (
            value['Team'], None, None, None, None, None, None, None
        ))

    conn.commit()

    # Insert data from data scraping into the 'Player' table
    for key, value in data.items():
        cursor.execute('''            
            INSERT INTO Player (player_name, rank, position, team_name, level, eta, age, bats, throws, height_cm, weight_kg)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            value['Player'],
            value['Rank'],
            value['Position'],
            value['Team'],
            value['Level'],
            value['eta'],
            value['Age'],
            value['Bats'],
            value['Throws'],
            value['Height (cm)'],
            value['Weight (kg)']
        ))

    # Commit the transaction
    conn.commit()

    # Create views that incorporates derived attributes from ERD
    cursor.execute('''
        CREATE VIEW Win_Percentage AS
        SELECT team_name, wins, loses, (wins/(wins+loses)) AS win_percentage
        FROM Team
        GROUP BY team_name, wins, loses; 
    ''')

    # Close the connection
    cursor.close()
    conn.close()

    print("Data has been successfully inserted into the MariaDB database.")

# Call the function
scrape_and_preprocess_data()
store_data()
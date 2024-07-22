import mysql.connector
import json
import os
import datetime
from cleaner import parse_date_flown

config = {
    'user': 'root',
    'password': 'password',
    'host': 'localhost',
    'database': 'airline_reviews'
    }

def create_schema():
    '''
    Query to create database table if not exist yet
    '''
    try:
        connection = mysql.connector.connect(**config)
        cursor = connection.cursor()

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS Airline (
                airline_id INT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                star INT
            );
        ''')

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS Reviewer (
                reviewer_id INT AUTO_INCREMENT PRIMARY KEY,
                fullname VARCHAR(255) NOT NULL,
                country VARCHAR(255),
                email VARCHAR(255) UNIQUE,
                password VARCHAR(255),
                membership_type VARCHAR(50),
                CONSTRAINT check_membership_type CHECK (membership_type IN ('elite', 'flyer', 'hiflyer', 'globetrotter', 'nonmember'))
            );
        ''')

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS Flight (
                flight_id INT AUTO_INCREMENT PRIMARY KEY,
                airline_id INT,
                route VARCHAR(255),
                date DATE,
                time TIME,
                aircraft_type VARCHAR(255),
                FOREIGN KEY (airline_id) REFERENCES Airline(airline_id)
            );
        ''')

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS Airline_Staff (
                staff_id INT AUTO_INCREMENT PRIMARY KEY,
                airline_id INT,
                fullname VARCHAR(255),
                email VARCHAR(255) UNIQUE,
                password VARCHAR(255),
                position VARCHAR(255),
                FOREIGN KEY (airline_id) REFERENCES Airline(airline_id)
            );
        ''')

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS Response (
                response_id INT AUTO_INCREMENT PRIMARY KEY,
                staff_id INT,
                response_content TEXT,
                response_date DATE,
                FOREIGN KEY (staff_id) REFERENCES Airline_Staff(staff_id)
            );
        ''')

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS Review (
                review_id INT AUTO_INCREMENT PRIMARY KEY,
                reviewer_id INT,
                flight_id INT,
                response_id INT,
                review_text VARCHAR(255),
                review_date DATE,
                overall_rating INT,
                seat_comfort_rating INT,
                cabin_staff_service_rating INT,
                food_beverage_rating INT,
                ground_service_rating INT,
                inflight_entertainment_rating INT,
                value_for_money_rating INT,
                wifi_and_connectivity_rating INT,
                is_recommended BOOLEAN,
                traveller_type VARCHAR(255),
                seat_type VARCHAR(255),
                inserted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (reviewer_id) REFERENCES Reviewer(reviewer_id),
                FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
                FOREIGN KEY (response_id) REFERENCES Response(response_id)
            );
        ''')

        cursor.execute('''
            CREATE TRIGGER prevent_downgrade
            BEFORE UPDATE ON Reviewer
            FOR EACH ROW
            BEGIN
                IF NEW.membership_type = 'nonmember' AND OLD.membership_type != 'nonmember' THEN
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot downgrade to nonmember!';
                END IF;
            END;
        ''')

        connection.commit()
        cursor.close()
        connection.close()
        print("\nSchema created successfully.\n")
    except mysql.connector.Error as err:
        print(f"Error: {err}")

def fetch_existing_data(cursor):
    cursor.execute('SELECT airline_id, name FROM Airline')
    airlines = {name: airline_id for airline_id, name in cursor.fetchall()}

    cursor.execute('SELECT reviewer_id, fullname, country FROM Reviewer')
    reviewers = {(fullname, country): reviewer_id for reviewer_id, fullname, country in cursor.fetchall()}

    cursor.execute('SELECT * FROM Flight')
    flights = {(airline_id, route, date, aircraft_type): flight_id for flight_id, airline_id, route, date, time, aircraft_type in cursor.fetchall()}

    return airlines, reviewers, flights

def insert_airline(cursor, airline, cache):
    if airline['Name'] in cache:
        return cache[airline['Name']]

    # if record not yet exists, insert to db
    cursor.execute('''
        INSERT INTO Airline (name, star)
        VALUES (%s, %s)
    ''', (airline['Name'], airline['Star']))
    airline_id = cursor.lastrowid
    cache[airline['Name']] = airline_id
    return airline_id

def insert_reviewer(cursor, reviewer, cache):
    key = (reviewer['Name'], reviewer['Country'])
    if key in cache:
        return cache[key]

    cursor.execute('''
        INSERT INTO Reviewer (fullname, country, membership_type)
        VALUES (%s, %s, %s)
    ''', (reviewer['Name'], reviewer['Country'], reviewer['Type']))
    reviewer_id = cursor.lastrowid
    cache[key] = reviewer_id
    return reviewer_id

def insert_flight(cursor, flight, airline_id, cache):
    flight_date = parse_date_flown(flight['Date Flown'])
    key = (airline_id, flight['Route'], flight_date, flight['Aircraft'])
    if key in cache:
        return cache[key]

    cursor.execute('''
        INSERT INTO Flight (airline_id, route, date, aircraft_type)
        VALUES (%s, %s, %s, %s)
    ''', (airline_id, flight['Route'], flight_date, flight['Aircraft']))
    flight_id = cursor.lastrowid
    cache[key] = flight_id
    return flight_id

def insert_review(cursor, review, reviewer_id, flight_id):
    review_date = datetime.datetime.strptime(review['Review Date'], '%Y-%m-%d').date()
    cursor.execute('''
        INSERT INTO Review (reviewer_id, flight_id, review_text, review_date, overall_rating, seat_comfort_rating, cabin_staff_service_rating, food_beverage_rating, ground_service_rating, inflight_entertainment_rating, value_for_money_rating, wifi_and_connectivity_rating, is_recommended, traveller_type, seat_type)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    ''', (reviewer_id, flight_id, review['Review Text'], review_date, review['Overall Rating'], review['Seat Comfort'], review['Cabin Staff Service'], review['Food & Beverages'], review['Ground Service'], review['Inflight Entertainment'], review['Value For Money'], review['Wifi & Connectivity'], review['Recommended'], review['Type Of Traveller'], review['Seat Type']))

def load_data():
    '''
    Load scraped data from json format to load to mysql
    '''
    try:
        connection = mysql.connector.connect(**config)
        cursor = connection.cursor()

        cwd = os.getcwd()
        with open(cwd[:-3] +"data/airline_reviews.json", "r") as f:
            data = json.load(f)

        airline_cache, reviewer_cache, flight_cache = fetch_existing_data(cursor)

        for review in data:
            airline_id = insert_airline(cursor, review['Airline'], airline_cache)
            reviewer_id = insert_reviewer(cursor, review['Reviewer'], reviewer_cache)
            flight_id = insert_flight(cursor, review['Flight'], airline_id, flight_cache)
            insert_review(cursor, review['Review Details'], reviewer_id, flight_id)
            
        connection.commit()
        cursor.close()
        connection.close()
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        
# if __name__ == "__main__":
#     config = {
#     'user': 'root',
#     'password': 'password',
#     'host': 'localhost',
#     'database': 'airline_reviews'
#     }
#     airlines = ["garuda-indonesia", "batik-air"]
#     create_schema(config)
#     load_data(config, airlines)
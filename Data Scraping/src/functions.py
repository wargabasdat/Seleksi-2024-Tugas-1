import os
import time
from dotenv import load_dotenv
import mysql.connector
from mysql.connector import errorcode

# Load environment variables from .env file
load_dotenv()

# Retrieve environment variables
db_host = os.getenv('DB_HOST')
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')
db_name = os.getenv('DB_NAME')

# Establish a connection to MySQL
def create_connection():
    try:
        connection = mysql.connector.connect(
            host=db_host,
            user=db_user,
            password=db_password
        )
        if connection.is_connected():
            print("Successfully connected to MySQL")
            return connection
    except mysql.connector.Error as err:
        print(err)

create_database_statements = """
DROP DATABASE IF EXISTS kdrama_db;
CREATE DATABASE kdrama_db;
USE kdrama_db;
"""

create_table_crew = """
DROP TABLE IF EXISTS Crew;
CREATE TABLE Crew (
    name VARCHAR(255) NOT NULL PRIMARY KEY,
    date_of_birth DATE,
    gender ENUM('Female', 'Male')
);
"""

create_table_screenwriter = """
DROP TABLE IF EXISTS Screenwriter;
CREATE TABLE Screenwriter (
    screenwriter_name VARCHAR(255) NOT NULL PRIMARY KEY,
    pen_name VARCHAR(255),
    FOREIGN KEY (screenwriter_name) REFERENCES Crew(name) ON DELETE CASCADE
);
"""

create_table_director = """
DROP TABLE IF EXISTS Director;
CREATE TABLE Director (
    director_name VARCHAR(255) NOT NULL PRIMARY KEY,
    signature_genre VARCHAR(255),
    FOREIGN KEY (director_name) REFERENCES Crew(name) ON DELETE CASCADE
);
"""

create_table_agency = """
DROP TABLE IF EXISTS Agency;
CREATE TABLE Agency (
    agency_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    ceo VARCHAR(255),
    founded_year INT,
    address VARCHAR(255)
);
"""

create_table_actor = """
DROP TABLE IF EXISTS Actor;
CREATE TABLE Actor (
    actor_name VARCHAR(255) NOT NULL PRIMARY KEY,
    stage_name VARCHAR(255),
    agency_id INT,
    FOREIGN KEY (actor_name) REFERENCES Crew(name) ON DELETE CASCADE,
    FOREIGN KEY (agency_id) REFERENCES Agency(agency_id) ON DELETE SET NULL
);
"""

create_table_network = """
DROP TABLE IF EXISTS Network;
CREATE TABLE Network (
    network_name VARCHAR(255),
    drama_name VARCHAR(255),
    PRIMARY KEY(network_name,drama_name),
    FOREIGN KEY (drama_name) REFERENCES Drama(drama_name) ON DELETE CASCADE
);
"""


create_table_genre = """
DROP TABLE IF EXISTS Genre;
CREATE TABLE Genre (
    genre_name VARCHAR(255),
    drama_name VARCHAR(255),
    PRIMARY KEY(genre_name,drama_name),
    FOREIGN KEY (drama_name) REFERENCES Drama(drama_name) ON DELETE CASCADE
);
"""

create_table_drama = """
DROP TABLE IF EXISTS Drama;
CREATE TABLE Drama (
    drama_name VARCHAR(255) NOT NULL PRIMARY KEY,
    year INT,
    rating FLOAT CHECK (rating > 0),
    description VARCHAR(255),
    episodes INT,
    duration INT,
    watchers INT,
    start_date DATE,
    end_date DATE
);
"""

create_table_episode = """
DROP TABLE IF EXISTS Episode;
CREATE TABLE Episode (
    drama_name VARCHAR(255) NOT NULL,
    episode_number INT NOT NULL,
    rating FLOAT,
    title VARCHAR(255),
    PRIMARY KEY (drama_name, episode_number),
    FOREIGN KEY (drama_name) REFERENCES Drama(drama_name) ON DELETE CASCADE
);
"""

create_table_character = """
DROP TABLE IF EXISTS `Character`;
CREATE TABLE `Character` (
    character_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    role ENUM('Main', 'Side'),
    backstory VARCHAR(255)
);
"""

create_table_wrote = """
DROP TABLE IF EXISTS Wrote;
CREATE TABLE Wrote (
    screenwriter_name VARCHAR(255) NOT NULL,
    drama_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (screenwriter_name, drama_name),
    FOREIGN KEY (screenwriter_name) REFERENCES Screenwriter(screenwriter_name) ON DELETE CASCADE,
    FOREIGN KEY (drama_name) REFERENCES Drama(drama_name) ON DELETE CASCADE
);
"""

create_table_directed = """
DROP TABLE IF EXISTS Directed;
CREATE TABLE Directed (
    director_name VARCHAR(255) NOT NULL,
    drama_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (director_name, drama_name),
    FOREIGN KEY (director_name) REFERENCES Director(director_name) ON DELETE CASCADE,
    FOREIGN KEY (drama_name) REFERENCES Drama(drama_name) ON DELETE CASCADE
);
"""

create_table_acted = """
DROP TABLE IF EXISTS Acted;
CREATE TABLE Acted (
    actor_name VARCHAR(255) NOT NULL,
    character_id INT NOT NULL,
    drama_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (actor_name, character_id, drama_name),
    FOREIGN KEY (actor_name) REFERENCES Actor(actor_name) ON DELETE CASCADE,
    FOREIGN KEY (character_id) REFERENCES `Character`(character_id) ON DELETE CASCADE,
    FOREIGN KEY (drama_name) REFERENCES Drama(drama_name) ON DELETE CASCADE
);
"""


create_table_award = """
DROP TABLE IF EXISTS Award;
CREATE TABLE Award (
    award_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    year INT,
    country VARCHAR(255)
);
"""

create_table_wins = """
DROP TABLE IF EXISTS Wins;
CREATE TABLE Wins (
    award_id INT NOT NULL,
    drama_name VARCHAR(255) NOT NULL,
    year INT,
    category VARCHAR(255),
    PRIMARY KEY (award_id, drama_name),
    FOREIGN KEY (award_id) REFERENCES Award(award_id) ON DELETE CASCADE,
    FOREIGN KEY (drama_name) REFERENCES Drama(drama_name) ON DELETE CASCADE
);
"""





def execute_commands(cursor, statements):
    for statement in statements.split(';'):
        if statement.strip():
            cursor.execute(statement)
            print(f"Executed statement: {statement[:50]}...")

def create_database(connection):
    cursor = connection.cursor()
    try:
        execute_commands(cursor, create_database_statements)
        connection.commit()
        print("Database and schema created successfully.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()

def create_tables(connection):
    cursor = connection.cursor()
    try:
        create_tables = [
            create_table_crew,
            create_table_screenwriter,
            create_table_director,
            create_table_agency,
            create_table_actor,
            create_table_drama,
            create_table_network,
            create_table_genre,
            create_table_episode,
            create_table_character,
            create_table_wrote,
            create_table_directed,
            create_table_acted,
            create_table_award,
            create_table_wins
        ]

        for command in create_tables:
            execute_commands(cursor,command)
            print(f"Executed command: {command[:50]}...")  # Print the first 50 chars for clarity
        connection.commit()
        print("All tables created successfully.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        cursor.close()


def insert_drama_data(cursor,data):

    drama_query = """
    INSERT INTO Drama (drama_name,year,rating,description,episodes,duration,watchers,start_date,end_date) 
    VALUES (?,?,?,?,?,?,?,?,?)
    """
    drama_values = (
        data['Drama_title'],
        data['Drama_year'],
        data['Drama_Rating'],
        data['Description'],
        data['Episodes'],
        data['Duration'],
        data['Watchers'],
        data['Start_date'],
        data['End_date']
    )

    cursor.execute(drama_query, drama_values)
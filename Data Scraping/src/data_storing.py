import json
from functions import *

connection = create_connection()

create_database(connection)
create_tables(connection)


cursor = connection.cursor()

# Load JSON data
with open('cleaned_korean_dramas.json', 'r') as file:
    data = json.load(file)

# Get unique values for screenwriter and director
screenwriters = set()
directors = set()

# Get values for directed and wrote
directed = []
wrote = []

for drama in data:
    # Collect unique screenwriters and directors
    if drama.get("Screenwriter"):
        screenwriters.update(drama["Screenwriter"])
    if drama.get("Director"):
        directors.update(drama["Director"])
    
    # Collect relationships for Directed and Wrote tables
    for screenwriter in drama.get("Screenwriter", []):
        wrote.append((screenwriter, drama["Drama_title"]))

    for director in drama.get("Director", []):
        directed.append((director, drama["Drama_title"]))

    # Insert Drama data
    cursor.execute("""
        INSERT INTO Drama (drama_name, year, rating, description, episodes, duration, watchers, start_date, end_date)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (
        drama["Drama_title"], drama["Drama_year"], drama["Drama_Rating"], drama["Description"],
        drama["Episodes"], drama["Duration"], drama["Watchers"], drama["Start_date"], drama["End_date"]
    ))

    # Insert into Genre table
    for genre in drama.get("Genre", []):
        cursor.execute("INSERT INTO Genre (genre_name, drama_name) VALUES (%s, %s)", (genre, drama["Drama_title"]))

    # Insert into Network table
    for network in drama.get("Original_Network", []):
        cursor.execute("INSERT INTO Network (network_name, drama_name) VALUES (%s, %s)", (network, drama["Drama_title"]))

# Insert unique values into Crew table using INSERT IGNORE
for name in screenwriters.union(directors):
    cursor.execute("INSERT IGNORE INTO Crew (name) VALUES (%s)", (name,))

connection.commit()

# Insert into Screenwriter and Director tables using INSERT IGNORE
for screenwriter in screenwriters:
    cursor.execute("INSERT IGNORE INTO Screenwriter (screenwriter_name) VALUES (%s)", (screenwriter,))

for director in directors:
    cursor.execute("INSERT IGNORE INTO Director (director_name) VALUES (%s)", (director,))

connection.commit()

# Insert into Wrote and Directed tables with INSERT IGNORE
for screenwriter, drama_name in wrote:
    cursor.execute("INSERT IGNORE INTO Wrote (screenwriter_name, drama_name) VALUES (%s, %s)", (screenwriter, drama_name))

for director, drama_name in directed:
    cursor.execute("INSERT IGNORE INTO Directed (director_name, drama_name) VALUES (%s, %s)", (director, drama_name))

connection.commit()

# Close connection
cursor.close()
connection.close()
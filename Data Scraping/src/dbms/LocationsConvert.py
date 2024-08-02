import pymysql
import json

# Database
def load_db_config(config_file='dbconfig.json'):
    with open(config_file) as file:
        return json.load(file)
db_config = load_db_config()    

# db_config = {
#     'host': 'localhost',
#     'user': 'root',
#     'password': 'SealedVessel',
#     'port': 1234,
#     'database': 'basdat2'
# }

# Exlude some non location names
excluded_names = {
    "Burial Gift",
    "Shrine Handmaid",
    "Irina of Carim",
    "Blade of the Darkmoon",
    "Starting equipment",
    "Orbeck of Vinheim",
    "Anri of Astora",
    "Hawkwood the Deserter",
    "Unbreakable Patches",
    "Sirris of the Sunless Realms",
    "Rosaria's Fingers",
    "Yuria of Londor",
    "Ludleth of Courland",
    "Consumed King's Knight",
    "Greirat of the Undead Settlement",
    "Watchdogs of Farron"
}

def is_excluded(location):
    """Check if the location should be excluded."""
    return (
        location in excluded_names or
        location.startswith("Soul of")
    )

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(255) UNIQUE NOT NULL
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE Locations;"
cursor.execute(truncate_table_query)

# To make sure the locations are unique
def insert_location(location):
    if location and not is_excluded(location):
        try:
            cursor.execute("INSERT INTO Locations (location_name) VALUES (%s);", (location,))
        except pymysql.IntegrityError:
            pass

with open('../../data/Bosses.JSON') as file:
    bosses_data = json.load(file)

with open('../../data/Rings.JSON') as file:
    rings_data = json.load(file)

for boss in bosses_data:
    locations = boss.get('location', [])
    for location in locations:
        insert_location(location)

for ring in rings_data:
    locations = ring.get('locations', [])
    for location in locations:
        insert_location(location)

connection.commit()
cursor.close()
connection.close()

print("Locations done")

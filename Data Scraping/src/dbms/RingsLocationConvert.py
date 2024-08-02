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

def clean_value(value):
    return value.strip() if value else None

def fetch_data(file_path):
    with open(file_path) as file:
        return json.load(file)

# Get location id based on location name
def get_location_id(cursor, location_name):
    cursor.execute("SELECT location_id FROM Locations WHERE location_name = %s", (location_name,))
    result = cursor.fetchone()
    return result[0] if result else None

# Get ring id based on ring name
def get_ring_id(cursor, ring_name):
    cursor.execute("SELECT ring_id FROM Rings WHERE ring_name = %s", (ring_name,))
    result = cursor.fetchone()
    return result[0] if result else None

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS RingLocation (
    loot_id INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT,
    ring_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id),
    FOREIGN KEY (ring_id) REFERENCES Rings(ring_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE RingLocation;"
cursor.execute(truncate_table_query)

# Insert data
def insert_ring_location(data):
    ring_name = clean_value(data.get('name'))
    locations = data.get('locations', [])
    
    ring_id = get_ring_id(cursor, ring_name)
    if ring_id is None:
        return
    
    for location in locations:
        location_id = get_location_id(cursor, location)
        if location_id:
            try:
                cursor.execute("""
                INSERT INTO RingLocation (location_id, ring_id)
                VALUES (%s, %s);
                """, (location_id, ring_id))
            except pymysql.IntegrityError:
                pass

ring_data = fetch_data('../../data/Rings.JSON')
if isinstance(ring_data, list):
    for ring in ring_data:
        insert_ring_location(ring)
else:
    insert_ring_location(ring_data)

connection.commit()
cursor.close()
connection.close()

print("RingLocation done")

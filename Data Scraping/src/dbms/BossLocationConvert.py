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

def get_location_id(cursor, location_name):
    cursor.execute("SELECT location_id FROM locations WHERE location_name = %s", (location_name,))
    result = cursor.fetchone()
    return result[0] if result else None

def get_boss_id(cursor, boss_name):
    cursor.execute("SELECT boss_id FROM Bosses WHERE boss_name = %s", (boss_name,))
    result = cursor.fetchone()
    return result[0] if result else None

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS BossLocation (
    arena_id INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT,
    boss_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (boss_id) REFERENCES Bosses(boss_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE BossLocation;"
cursor.execute(truncate_table_query)

# Insert
def insert_boss_location(boss_name, locations):
    boss_id = get_boss_id(cursor, boss_name)
    if not boss_id:
        return
    
    for location in locations:
        location_id = get_location_id(cursor, location)
        if location_id:
            try:
                cursor.execute("""
                INSERT INTO BossLocation (location_id, boss_id)
                VALUES (%s, %s);
                """, (location_id, boss_id))
            except pymysql.IntegrityError:
                pass

boss_data = fetch_data('../../data/Bosses.JSON')
if isinstance(boss_data, list):
    for boss in boss_data:
        boss_name = clean_value(boss.get('name'))
        locations = boss.get('location', [])
        insert_boss_location(boss_name, locations)
else:
    boss_name = clean_value(boss_data.get('name'))
    locations = boss_data.get('location', [])
    insert_boss_location(boss_name, locations)

connection.commit()
cursor.close()
connection.close()

print("BossLocation done")

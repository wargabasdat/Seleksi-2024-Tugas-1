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

def get_boss_id(cursor, boss_name):
    cursor.execute("SELECT boss_id FROM Bosses WHERE boss_name = %s", (boss_name,))
    result = cursor.fetchone()
    return result[0] if result else None

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS soulItems (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    boss_id INT,
    item_name VARCHAR(255),
    FOREIGN KEY (boss_id) REFERENCES Bosses(boss_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE soulItems;"
cursor.execute(truncate_table_query)

# Insert data
def insert_soul_item(boss_id, item_name):
    cursor.execute("""
    INSERT INTO soulItems (boss_id, item_name)
    VALUES (%s, %s);
    """, (boss_id, item_name))

boss_data = fetch_data('../../data/Bosses.JSON')

# Filter drop, that started with "Soul of" to mark the rememberance bosses
for boss in boss_data:
    boss_name = clean_value(boss.get('name'))
    boss_id = get_boss_id(cursor, boss_name)
    if boss_id:
        drops = boss.get('drops', [])
        for drop in drops:
            if drop.startswith("Soul of"):
                insert_soul_item(boss_id, clean_value(drop))

connection.commit()
cursor.close()
connection.close()

print("SoulItems done")

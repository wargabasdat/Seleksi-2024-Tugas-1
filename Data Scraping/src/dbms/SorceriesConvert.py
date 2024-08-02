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

def convert_to_int(value):
    if value is None:
        return None
    try:
        return int(value)
    except (ValueError, AttributeError):
        return None

def clean_value(value):
    return value.strip() if value else None

def fetch_data(file_path):
    with open(file_path) as file:
        return json.load(file)

# Get magic_id based on magic_name
def get_magic_id(cursor, magic_name):
    cursor.execute("SELECT magic_id FROM Magic WHERE magic_name = %s", (magic_name,))
    result = cursor.fetchone()
    return result[0] if result else None

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS Sorceries (
    magic_id INT PRIMARY KEY,
    int_req INT,
    FOREIGN KEY (magic_id) REFERENCES Magic(magic_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE Sorceries;"
cursor.execute(truncate_table_query)

sorceries_data = fetch_data('../../data/Sorceries.JSON')

# INsert data
def insert_sorcery(data):
    sorcery_name = clean_value(data.get('name'))
    int_req = convert_to_int(data.get('intelligence'))
    
    magic_id = get_magic_id(cursor, sorcery_name)
    
    if magic_id is not None:
        cursor.execute("""
        INSERT INTO Sorceries (magic_id, int_req)
        VALUES (%s, %s);
        """, (magic_id, int_req))

for sorcery in sorceries_data:
    insert_sorcery(sorcery)

connection.commit()
cursor.close()
connection.close()

print("Sorceries done")

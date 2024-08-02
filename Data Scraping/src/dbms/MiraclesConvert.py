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
CREATE TABLE IF NOT EXISTS Miracles (
    magic_id INT PRIMARY KEY,
    fth_req INT,
    FOREIGN KEY (magic_id) REFERENCES Magic(magic_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE Miracles;"
cursor.execute(truncate_table_query)

miracles_data = fetch_data('../../data/Miracles.JSON')

# Insert data
def insert_miracle(data):
    miracle_name = clean_value(data.get('miracle'))
    fth_req = convert_to_int(data.get('faith'))
    
    magic_id = get_magic_id(cursor, miracle_name)
    
    if magic_id is not None:
        cursor.execute("""
        INSERT INTO Miracles (magic_id, fth_req)
        VALUES (%s, %s);
        """, (magic_id, fth_req))

for miracle in miracles_data:
    insert_miracle(miracle)

connection.commit()
cursor.close()
connection.close()

print("Miracles done")

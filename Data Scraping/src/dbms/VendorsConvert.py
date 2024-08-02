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

# Prevents anything that exist in the Locations relation
def get_location_id(cursor, location_name):
    cursor.execute("SELECT location_id FROM locations WHERE location_name = %s", (location_name,))
    result = cursor.fetchone()
    return result[0] if result else None

# Prevent anything that stars with "Soul of"
def should_exclude(location_name):
    return location_name.startswith("Soul of")

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS vendor (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_name VARCHAR(255) UNIQUE NOT NULL
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE vendor;"
cursor.execute(truncate_table_query)

# INsert data
def insert_vendor(vendor_name):
    try:
        cursor.execute("""
        INSERT INTO vendor (vendor_name)
        VALUES (%s);
        """, (vendor_name,))
    except pymysql.IntegrityError:
        pass

# 4 source file JSON
file_paths = ['../../data/Rings.JSON', '../../data/Miracles.JSON', '../../data/Pyromancies.JSON', '../../data/Sorceries.JSON']
for file_path in file_paths:
    data = fetch_data(file_path)
    
    # Different attributes names, requires multiple section to extract
    if 'locations' in data[0]:
        for item in data:
            for location in item['locations']:
                location_name = clean_value(location)
                if not should_exclude(location_name) and not get_location_id(cursor, location_name):
                    insert_vendor(location_name)
    elif 'location' in data[0]:
        for item in data:
            for location in item['location']:
                location_name = clean_value(location)
                if not should_exclude(location_name) and not get_location_id(cursor, location_name):
                    insert_vendor(location_name)
    elif 'availability' in data[0]:
        for item in data:
            for location in item['availability']:
                location_name = clean_value(location)
                if not should_exclude(location_name) and not get_location_id(cursor, location_name):
                    insert_vendor(location_name)

connection.commit()
cursor.close()
connection.close()

print("Vendors done")

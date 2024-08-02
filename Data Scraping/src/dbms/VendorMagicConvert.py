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

def fetch_data(file_path):
    with open(file_path) as file:
        return json.load(file)

def clean_value(value):
    return value.strip() if value else None

# Get magic_id based on magic_name
def get_magic_id(cursor, magic_name):
    cursor.execute("SELECT magic_id FROM Magic WHERE magic_name = %s", (magic_name,))
    result = cursor.fetchone()
    return result[0] if result else None

# Get vendor_id by vendor_name
def get_vendor_id(cursor, vendor_name):
    cursor.execute("SELECT vendor_id FROM Vendor WHERE vendor_name = %s", (vendor_name,))
    result = cursor.fetchone()
    return result[0] if result else None

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS VendorCatalogMagic (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_id INT,
    magic_id INT,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id),
    FOREIGN KEY (magic_id) REFERENCES Magic(magic_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE VendorCatalogMagic;"
cursor.execute(truncate_table_query)

# Insert data
def insert_vct(magic_name, vendor_name):
    magic_id = get_magic_id(cursor, magic_name)
    vendor_id = get_vendor_id(cursor, vendor_name)
    
    if magic_id is not None and vendor_id is not None:
        cursor.execute("""
        INSERT INTO VendorCatalogMagic (vendor_id, magic_id)
        VALUES (%s, %s);
        """, (vendor_id, magic_id))

files = [
    ('../../data/Miracles.JSON', 'miracle'),
    ('../../data/Pyromancies.JSON', 'pyromancy'),
    ('../../data/Sorceries.JSON', 'name')
]

for file_name, magic_type in files:
    data = fetch_data(file_name)
    for item in data:
        magic_name = clean_value(item.get(magic_type))
        vendors = item.get('location') or item.get('locations') or item.get('availability')
        if isinstance(vendors, list):
            for vendor in vendors:
                insert_vct(magic_name, clean_value(vendor))

connection.commit()
cursor.close()
connection.close()

print("VendorCatalogMagic done")

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

# Get ring_id by ring_name
def get_ring_id(cursor, ring_name):
    cursor.execute("SELECT ring_id FROM Rings WHERE ring_name = %s", (ring_name,))
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
CREATE TABLE IF NOT EXISTS VendorCatalogRings (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_id INT,
    ring_id INT,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id),
    FOREIGN KEY (ring_id) REFERENCES Rings(ring_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE VendorCatalogRings;"
cursor.execute(truncate_table_query)

# Insert data
def insert_vcr(ring_name, vendor_name):
    ring_id = get_ring_id(cursor, ring_name)
    vendor_id = get_vendor_id(cursor, vendor_name)
    
    if ring_id is not None and vendor_id is not None:
        try:
            cursor.execute("""
            INSERT INTO VendorCatalogRings (vendor_id, ring_id)
            VALUES (%s, %s);
            """, (vendor_id, ring_id))
        except pymysql.IntegrityError as e:
            print(f"Error inserting ({vendor_id}, {ring_id}): {e}")

file_name = '../../data/Rings.JSON'
data = fetch_data(file_name)

for item in data:
    ring_name = clean_value(item.get('name'))
    vendors = item.get('locations')
    if isinstance(vendors, list):
        for vendor in vendors:
            insert_vcr(ring_name, clean_value(vendor))

connection.commit()
cursor.close()
connection.close()

print("VendorCatalogRings done")

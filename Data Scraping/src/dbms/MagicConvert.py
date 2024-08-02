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

# Get location_id based on location name
def get_location_id(cursor, location_name):
    cursor.execute("SELECT location_id FROM Locations WHERE location_name = %s", (location_name,))
    result = cursor.fetchone()
    return result[0] if result else None

# Get soul id based on soul transpose name
def get_item_id(cursor, item_name):
    cursor.execute("SELECT item_id FROM SoulItems WHERE item_name = %s", (item_name,))
    result = cursor.fetchone()
    return result[0] if result else None

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS Magic (
    magic_id INT AUTO_INCREMENT PRIMARY KEY,
    magic_name VARCHAR(255) NOT NULL,
    effect VARCHAR(255),
    fp_cost INT,
    slots INT,
    location_id INT,
    item_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id),
    FOREIGN KEY (item_id) REFERENCES SoulItems(item_id)
);
"""
cursor.execute(create_table_query)

truncate_table_query = "TRUNCATE TABLE Magic;"
cursor.execute(truncate_table_query)

# Insert data
def insert_magic(data, magic_type):
    magic_name = clean_value(data.get(magic_type))
    effect = clean_value(data.get('item_effect')) or clean_value(data.get('effect'))
    fp_cost = convert_to_int(data.get('fp_cost'))
    slots = convert_to_int(data.get('slots'))
    locations = data.get('location') or data.get('locations') or data.get('availability')
    
    location_id = None
    item_id = None
    
    if isinstance(locations, list):
        for location in locations:
            if location.startswith('Soul of'):
                item_id = get_item_id(cursor, location)
            else:
                location_id = get_location_id(cursor, location)
    
    try:
        cursor.execute("""
        INSERT INTO Magic (magic_name, effect, fp_cost, slots, location_id, item_id)
        VALUES (%s, %s, %s, %s, %s, %s);
        """, (magic_name, effect, fp_cost, slots, location_id, item_id))
    except pymysql.IntegrityError:
        pass

files = [
    ('../../data/Miracles.JSON', 'miracle'),
    ('../../data/Pyromancies.JSON', 'pyromancy'),
    ('../../data/Sorceries.JSON', 'name')
]

for file_name, magic_type in files:
    magic_data = fetch_data(file_name)
    if isinstance(magic_data, list):
        for magic in magic_data:
            insert_magic(magic, magic_type)
    else:
        insert_magic(magic_data, magic_type)

# Trigger to make sure no item_id appears more than 3 times
# The number of items transposition a soul can have is 3 at max
create_trigger_query = """
CREATE TRIGGER check_item_id_count_magic
BEFORE INSERT ON Magic
FOR EACH ROW
BEGIN
    DECLARE item_count INT;
    IF NEW.item_id IS NOT NULL THEN
        SELECT COUNT(*) INTO item_count FROM Magic WHERE item_id = NEW.item_id;
        IF item_count >= 3 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No soul can have more than 3 transposition';
        END IF;
    END IF;
END;
"""
cursor.execute(create_trigger_query)

connection.commit()
cursor.close()
connection.close()

print("Magic done")

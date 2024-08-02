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

def convert_to_float(value):
    try:
        return float(value)
    except (ValueError, AttributeError):
        return None

def clean_value(value):
    return value.strip() if value else None

def fetch_data(file_path):
    with open(file_path) as file:
        return json.load(file)

# Get item_id based on soul name
def get_item_id(cursor, soul_name):
    cursor.execute("SELECT item_id FROM SoulItems WHERE item_name = %s", (soul_name,))
    result = cursor.fetchone()
    return result[0] if result else None

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS Rings (
    ring_id INT AUTO_INCREMENT PRIMARY KEY,
    ring_name VARCHAR(255) NOT NULL,
    effect VARCHAR(255),
    weight FLOAT,
    item_id INT,
    FOREIGN KEY (item_id) REFERENCES SoulItems(item_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE Rings;"
cursor.execute(truncate_table_query)

# Insert data
def insert_ring(data):
    ring_name = clean_value(data.get('name'))
    effect = clean_value(data.get('effect'))
    weight = convert_to_float(data.get('weight'))
    locations = data.get('locations', [])

    item_id = None
    for location in locations:
        if location.startswith("Soul of"):
            item_id = get_item_id(cursor, location)
            break
    
    try:
        cursor.execute("""
        INSERT INTO Rings (ring_name, effect, weight, item_id)
        VALUES (%s, %s, %s, %s);
        """, (ring_name, effect, weight, item_id))
    except pymysql.IntegrityError:
        pass

ring_data = fetch_data('../../data/Rings.JSON')
if isinstance(ring_data, list):
    for ring in ring_data:
        insert_ring(ring)
else:
    insert_ring(ring_data)

# Trigger to make sure no item_id appears more than 3 times
# The number of items transposition a soul can have is 3 at max
create_trigger_query = """
CREATE TRIGGER check_item_id_count_rings
BEFORE INSERT ON Rings
FOR EACH ROW
BEGIN
    DECLARE item_count INT;
    IF NEW.item_id IS NOT NULL THEN
        SELECT COUNT(*) INTO item_count FROM Rings WHERE item_id = NEW.item_id;
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

print("Rings done")

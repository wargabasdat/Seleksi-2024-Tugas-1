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
        return int(value.replace(',', ''))
    except (ValueError, AttributeError):
        return None

def convert_to_float(value):
    try:
        return float(value)
    except (ValueError, AttributeError):
        return None

def clean_value(value):
    return value.strip() if value else None

def fetch_json_data(file_path):
    with open(file_path) as file:
        return json.load(file)

# Get item_id of the item_name (soul items)
def get_item_id(cursor, item_name):
    cursor.execute("SELECT item_id FROM soulItems WHERE item_name = %s", (item_name,))
    result = cursor.fetchone()
    return result[0] if result else None

# Get the weapon_id
def get_weapon_id(cursor, weapon_name):
    cursor.execute("SELECT weapon_id FROM Weapons WHERE weapon_name = %s", (weapon_name,))
    result = cursor.fetchone()
    return result[0] if result else None

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS Weapons (
    weapon_id INT AUTO_INCREMENT PRIMARY KEY,
    weapon_name VARCHAR(255) UNIQUE NOT NULL,
    type VARCHAR(255),
    price INT,
    special_atk VARCHAR(255),
    weight FLOAT,
    str_bonus CHAR,
    dex_bonus CHAR,
    fth_bonus CHAR,
    int_bonus CHAR,
    str_req INT,
    dex_req INT,
    fth_req INT,
    int_req INT,
    item_id INT,
    FOREIGN KEY (item_id) REFERENCES soulItems(item_id)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE Weapons;"
cursor.execute(truncate_table_query)

# Trigger to make sure no item_id appears more than 3 times
# The number of items transposition a soul can have is 3 at max
create_trigger_query = """
CREATE TRIGGER check_item_id_count
BEFORE INSERT ON Weapons
FOR EACH ROW
BEGIN
    DECLARE item_count INT;
    IF NEW.item_id IS NOT NULL THEN
        SELECT COUNT(*) INTO item_count FROM Weapons WHERE item_id = NEW.item_id;
        IF item_count >= 3 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No soul have more than 3 transposition';
        END IF;
    END IF;
END;
"""
cursor.execute("DROP TRIGGER IF EXISTS check_item_id_count;")
cursor.execute(create_trigger_query)

# Insert data
def insert_weapon(data):
    item_name = clean_value(data.get('item_name'))
    item_id = get_item_id(cursor, item_name) if item_name else None
    
    try:
        cursor.execute("""
        INSERT INTO Weapons (
            weapon_name, type, price, special_atk, weight, str_bonus, dex_bonus,
            fth_bonus, int_bonus, str_req, dex_req, fth_req, int_req, item_id
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
        """, (
            clean_value(data.get('name')),
            clean_value(data.get('weapon-type')) or clean_value(data.get('weapon_type')),
            convert_to_int(data.get('price')) or convert_to_int(data.get('buy-price')),
            clean_value(data.get('spc-atk')),
            convert_to_float(data.get('weight')),
            clean_value(data.get('strength-bonus')),
            clean_value(data.get('dexterity-bonus')),
            clean_value(data.get('faith-bonus')) or clean_value(data.get('fth-bonus')),
            clean_value(data.get('intelligence-bonus')) or clean_value(data.get('int-bonus')),
            convert_to_int(data.get('strength-requirement')) or convert_to_int(data.get('str_req')),
            convert_to_int(data.get('dexterity-requirement')) or convert_to_int(data.get('dex_req')),
            convert_to_int(data.get('faith-requirement')) or convert_to_int(data.get('fth_req')),
            convert_to_int(data.get('intelligence-requirement')) or convert_to_int(data.get('int_req')),
            item_id
        ))
    except pymysql.IntegrityError:
        pass

weapon_data = fetch_json_data('../../data/Weapons.JSON')
if isinstance(weapon_data, list):
    for weapon in weapon_data:
        insert_weapon(weapon)
else:
    insert_weapon(weapon_data)

shield_data = fetch_json_data('../../data/Shields.JSON')
if isinstance(shield_data, list):
    for shield in shield_data:
        insert_weapon(shield)
else:
    insert_weapon(shield_data)

soul_items_data = fetch_json_data('../../data/SoulItems.JSON')

# get item id based on soul transposition
for soul_item in soul_items_data:
    item_name = clean_value(soul_item['item']['name'])
    item_id = get_item_id(cursor, item_name)
    
    if item_id:
        for transposition in soul_item['transpositions']:
            weapon_name = clean_value(transposition['name'])
            weapon_id = get_weapon_id(cursor, weapon_name)
            
            if weapon_id:
                try:
                    cursor.execute("""
                    UPDATE Weapons
                    SET item_id = %s
                    WHERE weapon_id = %s;
                    """, (item_id, weapon_id))
                except pymysql.IntegrityError:
                    pass

connection.commit()
cursor.close()
connection.close()

print("Weapons done")

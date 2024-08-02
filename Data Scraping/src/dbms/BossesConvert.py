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

connection = pymysql.connect(**db_config)
cursor = connection.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS Bosses (
    boss_id INT AUTO_INCREMENT PRIMARY KEY,
    boss_name VARCHAR(255) NOT NULL,
    hp INT,
    souls INT,
    magic_eff VARCHAR(50),
    fire_eff VARCHAR(50),
    lightning_eff VARCHAR(50),
    dark_eff VARCHAR(50),
    bleed_eff VARCHAR(50),
    poison_eff VARCHAR(50),
    frost_eff VARCHAR(50)
);
"""
cursor.execute(create_table_query)

# For reset purposes
truncate_table_query = "TRUNCATE TABLE Bosses;"
cursor.execute(truncate_table_query)

with open('../../data/Bosses.JSON') as file:
    bosses_data = json.load(file)

# Insert data
insert_query = """
INSERT INTO Bosses (boss_name, hp, souls, magic_eff, fire_eff, lightning_eff, dark_eff, bleed_eff, poison_eff, frost_eff)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
"""

for boss in bosses_data:
    name = boss.get('name')
    health_ng = boss.get('health', {}).get('ng', [None])[0]
    souls_ng = boss.get('souls', {}).get('ng', [None])[0]
    magic_eff = boss.get('magic')
    fire_eff = boss.get('fire')
    lightning_eff = boss.get('lightning')
    dark_eff = boss.get('dark')
    bleed_eff = boss.get('bleed')
    poison_eff = boss.get('poison')
    frost_eff = boss.get('frost')
    
    # Handle int and string
    if isinstance(health_ng, str):
        try:
            hp = int(health_ng.replace(',', '')) if health_ng else None
        except (ValueError, TypeError):
            hp = None
    elif isinstance(health_ng, int):
        hp = health_ng
    else:
        hp = None
    
    if isinstance(souls_ng, str):
        try:
            souls = int(souls_ng.replace(',', '')) if souls_ng else None
        except (ValueError, TypeError):
            souls = None
    elif isinstance(souls_ng, int):
        souls = souls_ng
    else:
        souls = None

    cursor.execute(insert_query, (name, hp, souls, magic_eff, fire_eff, lightning_eff, dark_eff, bleed_eff, poison_eff, frost_eff))

connection.commit()
cursor.close()
connection.close()

print("Bosses done")

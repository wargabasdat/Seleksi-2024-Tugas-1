import pandas as pd
import json
import mariadb

# Load the JSON data
with open('/Users/azulsuhada/Documents/BASDAT/TUGAS_SELEKSI_2_13522070/Data Scraping/data/kost.json', 'r', encoding='utf-8') as f:
    kost_data = json.load(f)

with open('/Users/azulsuhada/Documents/BASDAT/TUGAS_SELEKSI_2_13522070/Data Scraping/data/kost_room.json', 'r', encoding='utf-8') as f:
    kost_room_data = json.load(f)

with open('/Users/azulsuhada/Documents/BASDAT/TUGAS_SELEKSI_2_13522070/Data Scraping/data/facility.json', 'r', encoding='utf-8') as f:
    facility_data = json.load(f)

# Connect to MariaDB database
conn = mariadb.connect(
    host='localhost', 
    user='root',       
    password='mockingjay07',  
    database='kost'  
)
cursor = conn.cursor()

# Create tables (if not already created)
cursor.execute('''
CREATE TABLE IF NOT EXISTS Owner (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255)
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Kost (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    street VARCHAR(255),
    subdistrict VARCHAR(255),
    district VARCHAR(255),
    description TEXT,
    owner_id INT,
    gender VARCHAR(255),
    furnished VARCHAR(255),
    FOREIGN KEY (owner_id) REFERENCES Owner(id)
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Room (
    id INT PRIMARY KEY,
    kost_id INT,
    name VARCHAR(255),
    size FLOAT,
    including_electricity VARCHAR(255),
    bathroom VARCHAR(255),
    bed_size VARCHAR(255),
    facilities TEXT,
    price INT,
    FOREIGN KEY (kost_id) REFERENCES Kost(id)
)
''')

cursor.execute('''
CREATE TABLE IF NOT EXISTS Facility (
    id INT PRIMARY KEY,
    parking_area VARCHAR(255),
    kitchen VARCHAR(255),
    wifi VARCHAR(255),
    guest_room VARCHAR(255),
    laundry VARCHAR(255)
)
''')

# Insert data into Kost table
for kost in kost_data:
    cursor.execute('''
    INSERT INTO Kost (id, name, street, subdistrict, district, description, gender, furnished)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    ''', (
        kost['id'], kost['name'], kost['street'], kost['subdistrict'], kost['district'], kost['description'], kost['gender'], kost['furnished']
    ))

# Insert data into Room table
for room in kost_room_data:
    cursor.execute('''
    INSERT INTO Room (id, kost_id, name, size, including_electricity, bathroom, bed_size, facilities, price)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    ''', (
        room['id_room'], room['kost_id'], room['name'], room['size'], room['including_electricity'], room['bathroom'], room['bedsize'], room['facilities'], room['price']
    ))

# Insert data into Facility table
for facility in facility_data:
    cursor.execute('''
    INSERT INTO Facility (id, parking_area, kitchen, wifi, guest_room, laundry)
    VALUES (%s, %s, %s, %s, %s, %s)
    ''', (
        facility['id'], facility['parking_area'], facility['kitchen'], facility['wifi'], facility['guest_room'], facility['laundry']
    ))

# Commit the changes and close the connection
conn.commit()
conn.close()

print("Data successfully inserted into MariaDB.")
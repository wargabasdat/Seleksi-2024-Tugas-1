import json
import mysql.connector

# Load JSON data
# json_data = '''
# {
#     "users": [
#         {"id_user": 1, "name": "John Doe", "address": "123 Main St", "total_screentime": 100, "avg_screentime_perday": 2},
#         {"id_user": 2, "name": "Jane Smith", "address": "456 Elm St", "total_screentime": 200, "avg_screentime_perday": 4}
#     ],
#     "phones": [
#         {"name": "Phone A", "brand": "Brand X", "battery_mah": 3000, "ram_gb": 4, "storage_gb": 64, "weight_gr": 150, "release_date": "2020-01-01", "os": "OS 1", "nfc": true, "display_size_inch": 6.1, "price": 699.99},
#         {"name": "Phone B", "brand": "Brand Y", "battery_mah": 4000, "ram_gb": 6, "storage_gb": 128, "weight_gr": 180, "release_date": "2021-06-15", "os": "OS 2", "nfc": false, "display_size_inch": 6.5, "price": 799.99}
#     ]
# }
# '''
# data = json.loads(json_data)
with open('../Data Scraping/data/phones_data.json') as json_file:
    phones_data = json.load(json_file)
with open('../Data Scraping/data/dimensions.json') as json_file:
    dimensions = json.load(json_file)
with open('../Data Scraping/data/resolutions.json') as json_file:
    resolutions = json.load(json_file)

# Connect to the MySQL database (replace with your database credentials)
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    database='tugas_seleksi'
)
cursor = conn.cursor()

# Insert users
# for user in data['users']:
#     cursor.execute('''
#         INSERT INTO users (id_user, name, address, total_screentime, avg_screentime_perday) 
#         VALUES (%s, %s, %s, %s, %s)
#     ''', (user['id_user'], user['name'], user['address'], user['total_screentime'], user['avg_screentime_perday']))

# Insert phones
for phone in phones_data:
    # print(phone)
    cursor.execute('''
        INSERT INTO phones (name, brand, battery_mah, ram_gb, storage_gb, weight_gr, release_date, os, nfc, display_size_inch, price) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    ''', (phone['name'], phone['brand'], phone['battery'], phone['ram'], phone['storage'], phone['weight'], phone['release'], phone['os'], phone['nfc'], phone['display_size'], phone['price']))

# Insert phone dimensions
for dimension in dimensions:
    cursor.execute('''
        INSERT INTO dimensions (name, height_mm, width_mm, thickness_mm) 
        VALUES (%s, %s, %s, %s)
    ''', (dimension['name'], dimension['height'], dimension['width'], dimension['depth']))

# Insert phone resolutions
for resolution in resolutions:
    cursor.execute('''
        INSERT INTO resolutions (name, width_px, height_px) 
        VALUES (%s, %s, %s)
    ''', (resolution['name'], resolution['width'], resolution['height']))

# Commit the transaction and close the connection
conn.commit()
conn.close()

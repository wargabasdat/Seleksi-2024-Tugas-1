import pymysql
import json

with open('restaurant.json', 'r', encoding='utf-8') as file:
    restaurants = json.load(file)

config = {
    'host': 'host',   
    'user': 'user',    
    'password': 'password',
    'database': 'database',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}

connection = pymysql.connect(**config)
cursor = connection.cursor()

insert_query = """
INSERT INTO Restaurant (Nama, Alamat, Telepon, Website, Instagram, Facebook)
VALUES (%s, %s, %s, %s, %s, %s)
ON DUPLICATE KEY UPDATE 
    Alamat=VALUES(Alamat), Telepon=VALUES(Telepon), Website=VALUES(Website), 
    Instagram=VALUES(Instagram), Facebook=VALUES(Facebook);
"""

try:
    for restaurant in restaurants:
        values = (
            restaurant['name'],
            restaurant['location'],
            restaurant['telephone'] if restaurant['telephone'] != 'null' else None,
            restaurant['website'] if restaurant['website'] != 'null' else None,
            restaurant['instagram'] if restaurant['instagram'] != 'null' else None,
            restaurant['facebook'] if restaurant['facebook'] != 'null' else None,
        )
        cursor.execute(insert_query, values)
    connection.commit() 
    print("Data inserted successfully")

except Exception as e:
    print("An error occurred:", e)
    connection.rollback() 

finally:
    cursor.close()
    connection.close()

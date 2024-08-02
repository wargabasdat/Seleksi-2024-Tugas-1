import json
import mariadb

# establish connection
conn = mariadb.connect(
    host="localhost",
    user="root",
    password="overunderunderover",
    database="artworkdb"
)
cur = conn.cursor()

# create tables
cur.execute(""" CREATE TABLE IF NOT EXISTS department (
            name VARCHAR(255) PRIMARY KEY,
            begin_date DATE NOT NULL
        ); 
""")
cur.execute(""" CREATE TABLE IF NOT EXISTS gallery (
             id INT PRIMARY KEY,
             name VARCHAR(255),
             department VARCHAR(255),
             FOREIGN KEY (department) REFERENCES department(name)
         ); 
""")
cur.execute("""  CREATE TABLE IF NOT EXISTS artwork (
            id INT PRIMARY KEY,
            title VARCHAR(255),
            gallery INT,
            date VARCHAR(255),
            geography VARCHAR(255),
            culture VARCHAR(255),
            medium VARCHAR(255),
            accnum VARCHAR(255),
            credit VARCHAR(255),
            year INT,
            FOREIGN KEY (gallery) REFERENCES gallery(id)
        );
""")
cur.execute("""  CREATE TABLE IF NOT EXISTS constituent (
            name VARCHAR(255) PRIMARY KEY,
            begin_date DATE,
            end_date DATE
        );
""")
cur.execute("""  CREATE TABLE IF NOT EXISTS art_constituent (
            id INT,
            name VARCHAR(255),
            role VARCHAR(255) NOT NULL,
            PRIMARY KEY (id, name),
            FOREIGN KEY (id) REFERENCES artwork(id),
            FOREIGN KEY (name) REFERENCES constituent(name)
        );
""")
cur.execute("""  CREATE TABLE IF NOT EXISTS art_classification (
            id INT,
            classification VARCHAR(255),
            PRIMARY KEY (id, classification),
            FOREIGN KEY (id) REFERENCES artwork(id)
        );
""")

# load json
with open('Data Scraping/data/data.json', 'r') as f:
    data = json.loads(f.read())

for art in data["artworks"]:
    # insert gallery ids
    cur.execute("""
            INSERT IGNORE INTO gallery (id)
            VALUES (?);
    """, (art["gallery"],))

    # insert artwork data
    cur.execute("""
            INSERT IGNORE INTO artwork (id, title, gallery, date, geography, culture, medium, accnum, credit, year)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    """, (art["id"], art["title"], art["gallery"], art["date"], art["geography"], art["culture"], art["medium"], art["accnum"], art["credit"], art["year"],))
    
    # insert art classifications
    for c in art["classifications"]:
        cur.execute("""
                INSERT IGNORE INTO art_classification (id, classification)
                VALUES (?, ?);
        """, (art["id"], c,))
    
    # insert art constituents
    for c in art["constituents"]:
        cur.execute("""
                INSERT IGNORE INTO constituent (name)
                VALUES (?);
        """, (c["name"],))

        cur.execute("""
                INSERT IGNORE INTO art_constituent (id, name, role)
                VALUES (?, ?, ?);
        """, (art["id"], c["name"], c["role"],))
    

conn.commit()

cur.close()
conn.close()
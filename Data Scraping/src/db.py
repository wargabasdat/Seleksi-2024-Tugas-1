from typing import Dict
import json
import os
from dotenv import load_dotenv
import psycopg2
import sys

load_dotenv()

class DB:
    def __init__(self):
        self.DB_NAME: str = os.getenv("DB_NAME")
        self.DB_USER: str = os.getenv("DB_USER")
        self.DB_PASSWORD = os.getenv("DB_PASSWORD")
        self.DB_USERNAME = os.getenv("DB_USERNAME")
        self.DB_NAME = os.getenv("DB_NAME")
        self.DB_PORT = os.getenv("DB_PORT")
        self.DB_HOST = os.getenv("DB_HOST")
        self.DB_TYPE = os.getenv("DB_TYPE")

        self.conn = psycopg2.connect(
            database=self.DB_NAME,
            host=self.DB_HOST,
            user=self.DB_USER,
            password=self.DB_PASSWORD,
            port=self.DB_PORT
        )

    def create_tables(self):
        print("Creating tables...")

        cursor = self.conn.cursor()
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "image"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "width" INT NOT NULL,
    "height" INT NOT NULL
);""")   
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "character"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL,
    "description" TEXT NOT NULL,
    "detail_url" TEXT NOT NULL,
    "image_id" INT NOT NULL REFERENCES image(id)
);""")    
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "pc"(
    "id" SERIAL PRIMARY KEY REFERENCES character(id)
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "npc"(
    "id" SERIAL PRIMARY KEY REFERENCES character(id)
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "enemy"(
    "id" SERIAL PRIMARY KEY REFERENCES character(id),
    "points" INT NOT NULL
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "item"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL,
    "description" TEXT NOT NULL,
    "detail_url" TEXT NOT NULL,
    "image_id" INT NOT NULL REFERENCES image(id)
);""")    
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "obstacle"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL,
    "description" TEXT NOT NULL,
    "detail_url" TEXT NOT NULL,
    "image_id" INT NOT NULL REFERENCES image(id)
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "object"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL,
    "description" TEXT NOT NULL,
    "detail_url" TEXT NOT NULL,
    "image_id" INT NOT NULL REFERENCES image(id)
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "power_up"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE,
    "description" TEXT NOT NULL,
    "detail_url" TEXT,
    "image_id" INT REFERENCES image(id)
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "form"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL,
    "detail_url" TEXT NOT NULL,
    "image_id" INT NOT NULL REFERENCES image(id),
    "power_up_id" INT NOT NULL REFERENCES power_up(id),
    "pc_id" INT NOT NULL REFERENCES pc(id)
);""")
        cursor.execute("""
DO $$ BEGIN
    CREATE TYPE reference_type AS ENUM ('to_other_games', 'in_other_games', 'in_later_games');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;
""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "reference"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "detail_url" TEXT NOT NULL,
    "type" reference_type NOT NULL
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "version"(
    "id" SERIAL PRIMARY KEY,
    "year" INT NOT NULL,
    "description" TEXT NOT NULL
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "setting"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL
);""")
        cursor.execute("""     
CREATE TABLE IF NOT EXISTS "level"(
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE NOT NULL,
    "detail_url" TEXT NOT NULL,
    "setting_id" INT NOT NULL REFERENCES setting(id),
    "image_id" INT NOT NULL REFERENCES image(id),
    "course_map_image_id" INT NOT NULL REFERENCES image(id)
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "level_item"(
    "level_id" INT NOT NULL REFERENCES level(id),
    "item_id" INT NOT NULL REFERENCES item(id),
    "count" INT NOT NULL
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "level_obstacle"(
    "level_id" INT NOT NULL REFERENCES level(id),
    "obstacle_id" INT NOT NULL REFERENCES obstacle(id),
    "count" INT NOT NULL
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "level_enemy"(
    "level_id" INT NOT NULL REFERENCES level(id),
    "enemy_id" INT NOT NULL REFERENCES enemy(id),
    "count" INT NOT NULL
);""")
        cursor.execute("""
CREATE TABLE IF NOT EXISTS "level_power_up"(
    "level_id" INT NOT NULL REFERENCES level(id),
    "power_up_id" INT NOT NULL REFERENCES power_up(id),
    "count" INT NOT NULL
);""")

        self.conn.commit()

        print("Tables created.")

    def insert_image(self, image: Dict) -> psycopg2.extensions.cursor:
        cursor = self.conn.cursor()
        cursor.execute("INSERT INTO image (name, url, width, height) VALUES (%s, %s, %s, %s) RETURNING id", (image["name"], image["url"], image["width"], image["height"]))
        return cursor

    def insert_tables(self, data: Dict):
        print("Inserting data...")
        cursor = self.conn.cursor()

        obstacle_list = data["obstacle"]
        for obstacle in obstacle_list:
            image_cursor = self.insert_image(obstacle["image"])
            image_id = image_cursor.fetchone()[0]

            cursor.execute("""INSERT INTO obstacle (name, description, detail_url, image_id) VALUES (%s, %s, %s, %s)""", (obstacle["name"], obstacle["description"], obstacle["detail_url"], image_id))

        item_list = data["item"]
        for item in item_list:
            image_cursor = self.insert_image(item["image"])
            image_id = image_cursor.fetchone()[0]
            cursor.execute("INSERT INTO item (name, description, detail_url, image_id) VALUES (%s, %s, %s, %s)", (item["name"], item["description"], item["detail_url"], image_id))

        object_list = data["object"]
        for object in object_list:
            image_cursor = self.insert_image(object["image"])
            image_id = image_cursor.fetchone()[0]

            cursor.execute("INSERT INTO object (name, description, detail_url, image_id) VALUES (%s, %s, %s, %s)", (object["name"], object["description"], object["detail_url"], image_id))


        # character
        pc_list = data["character"]["pc"]
        for pc in pc_list:
            image_cursor = self.insert_image(pc["image"])
            image_id = image_cursor.fetchone()[0]

            cursor.execute("INSERT INTO character (name, description, detail_url, image_id) VALUES (%s, %s, %s, %s) RETURNING id", (pc["name"], pc["description"], pc["detail_url"], image_id))
            cursor.execute("INSERT INTO pc (id) VALUES (%s)", (cursor.fetchone()[0],))
        
        npc_list = data["character"]["npc"]
        for npc in npc_list:
            image_cursor = self.insert_image(npc["image"])
            image_id = image_cursor.fetchone()[0]

            cursor.execute("INSERT INTO character (name, description, detail_url, image_id) VALUES (%s, %s, %s, %s) RETURNING id", (npc["name"], npc["description"], npc["detail_url"], image_id))
            cursor.execute("INSERT INTO npc (id) VALUES (%s)", (cursor.fetchone()[0],))

        enemy_list = data["character"]["enemy"]
        for enemy in enemy_list:
            image_cursor = self.insert_image(enemy["image"])
            image_id = image_cursor.fetchone()[0]

            cursor.execute("INSERT INTO character (name, description, detail_url, image_id) VALUES (%s, %s, %s, %s) RETURNING id", (enemy["name"], enemy["description"], enemy["detail_url"], image_id))
            cursor.execute("INSERT INTO enemy (id, points) VALUES (%s, %s)", (cursor.fetchone()[0], enemy["points"]))

        
        cursor.execute("""
SELECT pc.id FROM pc
INNER JOIN character ON pc.id = character.id
WHERE name = 'Mario'
""")
        mario_id: int = cursor.fetchone()[0]
        cursor.execute("""
SELECT pc.id FROM pc
INNER JOIN character ON pc.id = character.id
WHERE name = 'Luigi'
""")
        luigi_id: int = cursor.fetchone()[0]

        power_up_list = data["power_up"]
        for power_up in power_up_list:
            image_id = None
            if power_up["image"] is not None:
                image_cursor = self.insert_image(power_up["image"])
                image_id = image_cursor.fetchone()[0]

            cursor.execute("INSERT INTO power_up (name, description, detail_url) VALUES (%s, %s, %s) RETURNING id", (power_up["name"], power_up["description"], power_up["detail_url"]))
            power_up_id = cursor.fetchone()[0]

            mario_form = power_up["mario_form"]
            image_cursor = self.insert_image(mario_form["image"])
            image_id = image_cursor.fetchone()[0]
            cursor.execute("INSERT INTO form (name, detail_url, image_id, power_up_id, pc_id) VALUES (%s, %s, %s, %s, %s)", (mario_form["name"], mario_form["detail_url"], image_id, power_up_id, mario_id))


            luigi_form = power_up["luigi_form"]
            image_cursor = self.insert_image(luigi_form["image"])
            image_id = image_cursor.fetchone()[0]
            cursor.execute("INSERT INTO form (name, detail_url, image_id, power_up_id, pc_id) VALUES (%s, %s, %s, %s, %s)", (luigi_form["name"], luigi_form["detail_url"], image_id, power_up_id, luigi_id))


        # setting
        level_list = data["level"]
        setting_set = set()
        for level in level_list:
            setting_set.add(level["setting"])
        for setting in setting_set:
            cursor.execute("INSERT INTO setting (name) VALUES (%s)", (setting,))
        
        
        reference_list = data["reference"]
        for reference in reference_list:
            cursor.execute("INSERT INTO reference (name, description, detail_url, type) VALUES (%s, %s, %s, %s)", (reference["name"], reference["description"], reference["detail_url"], reference["type"]))  

        version_list = data["version"]
        for version in version_list:
            cursor.execute("INSERT INTO version (year, description) VALUES (%s, %s)", (version["year"], version["description"]))

        # level
        for level in level_list:
            image_cursor = self.insert_image(level["image"])
            image_id = image_cursor.fetchone()[0]

            course_map_image_cursor = self.insert_image(level["course_map_image"])
            course_map_image_id = course_map_image_cursor.fetchone()[0]

            cursor.execute("SELECT id FROM setting WHERE name = %s", (level["setting"],))
            setting_id = cursor.fetchone()[0]

            cursor.execute("INSERT INTO level (name, detail_url, setting_id, image_id, course_map_image_id) VALUES (%s, %s, %s, %s, %s) RETURNING id", (level["name"], level["detail_url"], setting_id, image_id, course_map_image_id))
            level_id = cursor.fetchone()[0]


            # level_item
            level_item_list = level["item"]
            for level_item in level_item_list:
                cursor.execute("SELECT id FROM item WHERE name = %s", (level_item["name"],))
                item_cursor = cursor.fetchone()
                if item_cursor is None: # try in power up
                    cursor.execute("SELECT id FROM power_up WHERE name = %s", (level_item["name"],))
                    power_up_cursor = cursor.fetchone()
                    if power_up_cursor is not None:
                        cursor.execute("INSERT INTO level_power_up (level_id, power_up_id, count) VALUES (%s, %s, %s)", (level_id, power_up_cursor[0], level_item["count"]))
                        pass
                    else:
                        print("Power up not found in item", level_item["name"])
                else:
                    item_id = item_cursor[0]
                    cursor.execute("INSERT INTO level_item (level_id, item_id, count) VALUES (%s, %s, %s)", (level_id, item_id, level_item["count"]))

            # level_obstacle
            if "enemies_and_obstacle" in level:
                enemy_obstacle_list = level["enemies_and_obstacle"]
                for enemy_obstacle in enemy_obstacle_list: # fix this part
                    cursor.execute("SELECT id FROM obstacle WHERE name = %s", (enemy_obstacle["name"],))
                    res = cursor.fetchone()
                    if res is not None:
                        obstacle_id = res[0]
                        cursor.execute("INSERT INTO level_obstacle (level_id, obstacle_id, count) VALUES (%s, %s, %s)", (level_id, obstacle_id, enemy_obstacle["count"]))
                    else:
                        cursor.execute("SELECT enemy.id FROM enemy INNER JOIN character ON enemy.id = character.id WHERE name = %s", (enemy_obstacle["name"],))
                        res = cursor.fetchone()
                        if res is None:
                            print("Enemy not found", enemy_obstacle["name"])
                        else:
                            enemy_id = res[0]
                            cursor.execute("INSERT INTO level_enemy (level_id, enemy_id, count) VALUES (%s, %s, %s)", (level_id, enemy_id, enemy_obstacle["count"]))

            elif "enemies" in level:
                level_enemy_list = level["enemies"]
                for level_enemy in level_enemy_list:
                    cursor.execute("SELECT enemy.id FROM enemy INNER JOIN character ON enemy.id = character.id WHERE name = %s", (level_enemy["name"],))
                    enemy_id = cursor.fetchone()[0]
                    cursor.execute("INSERT INTO level_enemy (level_id, enemy_id, count) VALUES (%s, %s, %s)", (level_id, enemy_id, level_enemy["count"]))

        self.conn.commit()
        print("Data inserted.")

    def query(self, query: str):
        cursor = self.conn.cursor()
        cursor.execute(query)
        return cursor.fetchall()
    

    def truncate_tables(self):
        cursor = self.conn.cursor()
        cursor.execute("TRUNCATE TABLE reference")
        cursor.execute("TRUNCATE TABLE version")
        cursor.execute("TRUNCATE TABLE level_item")
        cursor.execute("TRUNCATE TABLE level_enemy")
        cursor.execute("TRUNCATE TABLE level_obstacle")
        cursor.execute("TRUNCATE TABLE level_power_up")
        cursor.execute("TRUNCATE TABLE pc CASCADE")
        cursor.execute("TRUNCATE TABLE npc")
        cursor.execute("TRUNCATE TABLE enemy CASCADE")
        cursor.execute("TRUNCATE TABLE character CASCADE")
        cursor.execute("TRUNCATE TABLE item CASCADE")
        cursor.execute("TRUNCATE TABLE obstacle CASCADE")
        cursor.execute("TRUNCATE TABLE object")
        cursor.execute("TRUNCATE TABLE level CASCADE")
        cursor.execute("TRUNCATE TABLE setting CASCADE")
        cursor.execute("TRUNCATE TABLE power_up CASCADE")
        cursor.execute("TRUNCATE TABLE form CASCADE")
        cursor.execute("TRUNCATE TABLE image CASCADE")
        self.conn.commit()

    def drop_tables(self):
        cursor = self.conn.cursor()
        cursor.execute("DROP TABLE IF EXISTS reference")
        cursor.execute("DROP TABLE IF EXISTS version")
        cursor.execute("DROP TABLE IF EXISTS transformation")
        cursor.execute("DROP TABLE IF EXISTS level_item")
        cursor.execute("DROP TABLE IF EXISTS level_enemy")
        cursor.execute("DROP TABLE IF EXISTS level_obstacle")
        cursor.execute("DROP TABLE IF EXISTS level_power_up")
        cursor.execute("DROP TABLE IF EXISTS pc CASCADE")
        cursor.execute("DROP TABLE IF EXISTS npc")
        cursor.execute("DROP TABLE IF EXISTS enemy")
        cursor.execute("DROP TABLE IF EXISTS character")
        cursor.execute("DROP TABLE IF EXISTS item")
        cursor.execute("DROP TABLE IF EXISTS obstacle")
        cursor.execute("DROP TABLE IF EXISTS object")
        cursor.execute("DROP TABLE IF EXISTS level")
        cursor.execute("DROP TABLE IF EXISTS setting")
        cursor.execute("DROP TABLE IF EXISTS power_up CASCADE")
        cursor.execute("DROP TABLE IF EXISTS form")
        cursor.execute("DROP TABLE IF EXISTS image")
        self.conn.commit()

def create_db(json: Dict):
    db = DB()
    db.drop_tables()
    db.create_tables()
    db.insert_tables(json)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        db = DB()
        db.drop_tables()
        db.create_tables()
        db.truncate_tables()
        db.insert_tables(json.loads(open("json/data.json", "r").read()))
    else:
        db = DB()
        print(db.query(sys.argv[1]))
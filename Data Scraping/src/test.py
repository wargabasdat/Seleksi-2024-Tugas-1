import psycopg2
import json

def get_credentials():
    db_name = input("Enter your database name: ")
    db_user = input("Enter your database user: ")
    db_pass = input("Enter your database password: ")
    db_host = input("Enter your database host: ")
    db_port = input("Enter your database port: ")
    return db_name, db_user, db_pass, db_host, db_port

db_name, db_user, db_pass, db_host, db_port = get_credentials()

def insert_data_to_db(data):
    conn = None
    try:
        conn = psycopg2.connect(
            dbname=db_name,
            user=db_user,
            password=db_pass,
            host=db_host,
            port=db_port
        )
        cur = conn.cursor()

        # Insert into element table
        for character in data['characters']:
            cur.execute("""
                INSERT INTO element (element_name)
                VALUES (%s)
                ON CONFLICT (element_name) DO NOTHING;
            """, (character['Element'],))

        # Insert into weapon table
        for weapon in data['weapons']:
            cur.execute("""
                INSERT INTO weapon (name, rarity, weapon_type, atk, substat, substat_value)
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (name) DO UPDATE SET
                rarity = EXCLUDED.rarity,
                weapon_type = EXCLUDED.weapon_type,
                atk = EXCLUDED.atk,
                substat = EXCLUDED.substat,
                substat_value = EXCLUDED.substat_value;
            """, (weapon['Name'], weapon['Rarity'], weapon['Type'], weapon['Atk'], weapon['Substat'], weapon['Substat%']))

        # Insert into echo table
        for echo in data['echoes']:
            cur.execute("""
                INSERT INTO echo (echo_name, class, cost, cooldown, element_id)
                VALUES (%s, %s, %s, %s, 
                        (SELECT element_id FROM element WHERE element_name = %s))
                ON CONFLICT (echo_name) DO UPDATE SET
                class = EXCLUDED.class,
                cost = EXCLUDED.cost,
                cooldown = EXCLUDED.cooldown,
                element_id = EXCLUDED.element_id;
            """, (echo['Name'], echo['Class'], echo['Cost'], echo['Cooldown (s)'], echo['Element DMG']))

            for set_name in echo['Sets']:
                cur.execute("""
                    INSERT INTO echo_set (set_name)
                    VALUES (%s)
                    ON CONFLICT (set_name) DO NOTHING;
                """, (set_name,))
                
                cur.execute("""
                    INSERT INTO part_of (set_id, echo_id)
                    VALUES (
                        (SELECT set_id FROM echo_set WHERE set_name = %s),
                        (SELECT echo_id FROM echo WHERE echo_name = %s)
                    )
                    ON CONFLICT DO NOTHING;
                """, (set_name, echo['Name']))

        # Insert into character table
        for character in data['characters']:
            cur.execute("""
                INSERT INTO character (char_name, char_rarity, element_id, best_echo_set_id, best_main_echo_id)
                VALUES (%s, %s, 
                        (SELECT element_id FROM element WHERE element_name = %s),
                        (SELECT set_id FROM echo_set WHERE set_name = %s),
                        (SELECT echo_id FROM echo WHERE echo_name = %s))
                ON CONFLICT (char_name) DO UPDATE SET
                char_rarity = EXCLUDED.char_rarity,
                element_id = EXCLUDED.element_id,
                best_echo_set_id = EXCLUDED.best_echo_set_id,
                best_main_echo_id = EXCLUDED.best_main_echo_id
                RETURNING char_id;
            """, (character['Name'], character['Rarity'], character['Element'], character['Best Echo Set'], character['Best Main Echo']))
            char_id = cur.fetchone()[0]

            # Insert into char_stats table
            cur.execute("""
                INSERT INTO char_stats (char_id, hp, char_atk, def, max_energy, crit_rate, crit_dmg, healing_bonus, element_dmg)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (char_id) DO UPDATE SET
                hp = EXCLUDED.hp,
                char_atk = EXCLUDED.char_atk,
                def = EXCLUDED.def,
                max_energy = EXCLUDED.max_energy,
                crit_rate = EXCLUDED.crit_rate,
                crit_dmg = EXCLUDED.crit_dmg,
                healing_bonus = EXCLUDED.healing_bonus,
                element_dmg = EXCLUDED.element_dmg;
            """, (char_id, character['HP'], character['ATK'], character['DEF'], character['Max Energy'], character['CRIT Rate'], character['CRIT DMG'], character['Healing Bonus'], character['Element DMG']))

            # Insert into char_material table
            cur.execute("""
                INSERT INTO char_material (char_id, ws_mats, ra_mats, a_mats, w_mats, su_mats)
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (char_id) DO UPDATE SET
                ws_mats = EXCLUDED.ws_mats,
                ra_mats = EXCLUDED.ra_mats,
                a_mats = EXCLUDED.a_mats,
                w_mats = EXCLUDED.w_mats,
                su_mats = EXCLUDED.su_mats;
            """, (char_id, character['WS_Mats'], character['RA_Mats'], character['A_Mats'], character['W_Mats'], character['SU_Mats']))

            # Insert into weapon_level table
            weapon_name = character['Weapon Name'] if character['Weapon Name'] != "NULL" else None
            weapon_s_level = character['Weapon S Level'] if character['Weapon S Level'] != "NULL" else None
            if weapon_name is not None:
                try:
                    cur.execute("""
                        INSERT INTO weapon_level (char_id, weapon_id, s_level)
                        VALUES (%s, 
                                (SELECT weapon_id FROM weapon WHERE name = %s),
                                %s)
                        ON CONFLICT (char_id, weapon_id) DO UPDATE SET
                        s_level = EXCLUDED.s_level;
                    """, (char_id, weapon_name, weapon_s_level))
                except psycopg2.DatabaseError as e:
                    print(f"Failed to insert weapon level for character {character['Name']}: {e}")

        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

# Load JSON data and call the function
with open('data/wuthering_waves_data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    insert_data_to_db(data)

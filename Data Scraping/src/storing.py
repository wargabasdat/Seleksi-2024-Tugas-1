import psycopg2
import json
import os

# Establish a connection to the PostgreSQL database
data_folder = r"C:\Users\Jihan Aurelia\Documents\LabBasdat\Scrapping\Data Scraping\data"

produk_file_path = os.path.join(data_folder, "produk.json")
diskonProd_file_path = os.path.join(data_folder, "diskon_prod.json")
normalProd_file_path = os.path.join(data_folder, "normal_prod.json")
promo_file_path = os.path.join(data_folder, "promo.json")
potonganProm_file_path = os.path.join(data_folder, "potongan_prom.json")
normalProm_file_path = os.path.join(data_folder, "normal_prom.json")

# Load JSON data from the files
with open(produk_file_path) as file:
    produk_info = json.load(file)

with open(diskonProd_file_path) as file:
    diskonProd_info = json.load(file)

with open(normalProd_file_path) as file:
    normalProd_info = json.load(file)

with open(promo_file_path) as file:
    promo_info = json.load(file)

with open(potonganProm_file_path) as file:
    potonganProm_info = json.load(file)

with open(normalProm_file_path) as file:
    normalProm_info = json.load(file)

# Connect to the PostgreSQL database
try:
    conn = psycopg2.connect(
        host="localhost",
        user="postgres",
        password="@EgojihJiau02",
        dbname="borma_dago",
        port=5432
    )
    cursor = conn.cursor()
    print("Connection to the database was successful.")
except psycopg2.Error as err:
    print(f"Error: {err}")
    conn = None

if conn:
    # Define schema
    schema = """ CREATE TABLE IF NOT EXISTS produk (
            id_prod VARCHAR(15) PRIMARY KEY,
            nama_prod VARCHAR(200) NOT NULL,
            harga_prod INT NOT NULL,
            terjual_prod INT,
            kat_prod VARCHAR(200),
            nama_sup VARCHAR(200)
        );

        CREATE TABLE IF NOT EXISTS promo (
            nama_prom VARCHAR(100) PRIMARY KEY,
            rentang_prom DATE NOT NULL
        );

        CREATE TABLE IF NOT EXISTS potongan_prom (
            nama_prom VARCHAR(100) PRIMARY KEY,
            FOREIGN KEY (nama_prom) REFERENCES promo(nama_prom)
        );

        CREATE TABLE IF NOT EXISTS diskon_prod (
            id_prod VARCHAR(15),
            nama_prom VARCHAR(100),
            harga_disc INT NOT NULL,
            PRIMARY KEY (id_prod, nama_prom),
            FOREIGN KEY (id_prod) REFERENCES produk(id_prod),
            FOREIGN KEY (nama_prom) REFERENCES potongan_prom(nama_prom)
        );

        CREATE TABLE IF NOT EXISTS normal_prod (
            id_prod VARCHAR(15) PRIMARY KEY,
            FOREIGN KEY (id_prod) REFERENCES produk(id_prod)
        );

        CREATE TABLE IF NOT EXISTS normal_prom (
            nama_prom VARCHAR(100) PRIMARY KEY,
            sisa_prom INT,
            jumlah_prom INT,
            kode_prom VARCHAR(100),
            FOREIGN KEY (nama_prom) REFERENCES promo(nama_prom)
        );

        CREATE TABLE IF NOT EXISTS digunakan (
            id_prod VARCHAR(15),
            nama_prom VARCHAR(100),
            PRIMARY KEY (id_prod, nama_prom),
            FOREIGN KEY (id_prod) REFERENCES produk(id_prod),
            FOREIGN KEY (nama_prom) REFERENCES promo(nama_prom)
        );

        CREATE TABLE IF NOT EXISTS pelanggan (
            id_pel VARCHAR(15) PRIMARY KEY,
            nama_pel VARCHAR(100) NOT NULL,
            nomor_pel VARCHAR(15) NOT NULL,
            email VARCHAR(100)
        );

        CREATE TABLE IF NOT EXISTS alamat_pel (
            id_pel VARCHAR(15),
            al_jalan VARCHAR(100),
            al_NoR VARCHAR(100),
            PRIMARY KEY (id_pel, al_jalan, al_NoR),
            FOREIGN KEY (id_pel) REFERENCES pelanggan(id_pel)
        );

        CREATE TABLE IF NOT EXISTS keranjang (
            id_ker VARCHAR(15) PRIMARY KEY,
            date_ker DATE NOT NULL,
            time_ker TIME NOT NULL
        );

        CREATE TABLE IF NOT EXISTS transaksi (
            id_tran VARCHAR(15) PRIMARY KEY,
            jenis_tran VARCHAR(100) NOT NULL,
            id_ker VARCHAR(15) NOT NULL,
            FOREIGN KEY (id_ker) REFERENCES keranjang(id_ker)
        );

        CREATE TABLE IF NOT EXISTS pesanan (
            id_prod VARCHAR(15),
            id_ker VARCHAR(15),
            id_pel VARCHAR(15) NOT NULL,
            PRIMARY KEY (id_prod, id_ker),
            FOREIGN KEY (id_prod) REFERENCES produk(id_prod),
            FOREIGN KEY (id_ker) REFERENCES keranjang(id_ker),
            FOREIGN KEY (id_pel) REFERENCES pelanggan(id_pel)
        );

        CREATE TABLE IF NOT EXISTS orders (
            id_ker VARCHAR(15),
            urutan VARCHAR(15),
            kuantitas INT NOT NULL,
            id_prod VARCHAR(15) NOT NULL,
            PRIMARY KEY (id_ker, urutan),
            FOREIGN KEY (id_prod) REFERENCES produk(id_prod)
        );

    """

    # Execute the schema creation query
    cursor.execute(schema)
    conn.commit()

    # Insert data into the tables
    insert_produk_query = "INSERT INTO produk (id_prod, nama_prod, harga_prod, terjual_prod, kat_prod, nama_sup) VALUES (%s, %s, %s, %s, %s, %s)"
    for item in produk_info:
        values = (
            item["ID_prod"],
            item["nama_prod"],
            item["harga_prod"],
            item["terjual_prod"],
            item["kat_prod"],
            item["nama_sup"]
        )
        cursor.execute(insert_produk_query, values)

    for item in diskonProd_info:
        values = (
            item["ID_prod"],
            item["nama_prod"],
            item["harga_prod_norm"],
            item["terjual_prod"],
            item["kat_prod"],
            item["nama_sup"]
        )
        cursor.execute(insert_produk_query, values)

    insert_diskon_prod_query = "INSERT INTO diskon_prod (id_prod, harga_disc, nama_prom) VALUES (%s, %s, %s)"
    for item in diskonProd_info:
        values = (
            item["ID_prod"],
            item["harga_prod_disc"],
            item["nama_prom"]
        )
        cursor.execute(insert_diskon_prod_query, values)

    insert_promo_query = "INSERT INTO promo (nama_prom, rentang_prom) VALUES (%s, %s)"
    for item in promo_info:
        values = (
            item["nama_prom"],
            item["rentang_prom"]
        )
        cursor.execute(insert_promo_query, values)

    insert_potongan_prom_query = "INSERT INTO potongan_prom (nama_prom) VALUES (%s)"
    for item in potonganProm_info:
        cursor.execute(insert_potongan_prom_query, (item["nama_prom"],))

    insert_normal_prod_query = "INSERT INTO normal_prod (id_prod) VALUES (%s)"
    for item in normalProd_info:
        cursor.execute(insert_normal_prod_query, (item["ID_prod"],))

    insert_normal_prom_query = "INSERT INTO normal_prom (nama_prom, sisa_prom, jumlah_prom, kode_prom) VALUES (%s, %s, %s, %s)"
    for item in normalProm_info:
        values = (
            item["nama_prom"],
            item["sisa_prom"],
            item["jumlah_prom"],
            item["kode_prom"]
        )
        cursor.execute(insert_normal_prom_query, values)

    insert_digunakan_query = "INSERT INTO digunakan (id_prod, nama_prom) VALUES (%s, %s)"
    for item in produk_info:
        for prom in promo_info:
            values = (
                item["ID_prod"],
                prom["nama_prom"]
            )
            cursor.execute(insert_digunakan_query, values)

    # Commit the changes
    conn.commit()

    # Close the cursor and connection
    cursor.close()
    conn.close()
    print("Database connection closed.")

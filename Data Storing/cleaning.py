import mysql.connector

# Connect to the MySQL database without a password (replace with your database details)
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    database='tugas_seleksi'
)
cursor = conn.cursor()

# List of tables and their columns
tables_columns = {
    "users_phones": ["id_user", "phone_name", "purchase_date"],
    "dimensions": ["name", "height_mm", "width_mm", "thickness_mm"],
    "resolutions": ["name", "height_px", "width_px"],
    "users": ["id_user", "name", "address", "total_screentime", "avg_screentime_perday"],
    "phones": ["name", "brand", "battery_mah", "ram_gb", "storage_gb", "weight_gr", "release_date", "os", "nfc", "display_size_inch", "price"]
}

# Function to delete rows with NULL values
def delete_null_rows(table, columns):
    conditions = " OR ".join([f"{column} IS NULL" for column in columns])
    query = f"DELETE FROM {table} WHERE {conditions}"
    cursor.execute(query)

# Perform the cleanup in the correct order
for table, columns in tables_columns.items():
    delete_null_rows(table, columns)

# Commit the transaction and close the connection
conn.commit()
conn.close()

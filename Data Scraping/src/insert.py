import os
import json
import mysql.connector
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Get database credentials from environment variables
db_host = os.getenv('DB_HOST')
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')
db_name = os.getenv('DB_NAME')


# Initial connection to MySQL server (without specifying a database)
initial_db = mysql.connector.connect(
    host=db_host,
    user=db_user,
    password=db_password
)

initial_cursor = initial_db.cursor()

# Create the database if it does not exist
initial_cursor.execute(f"CREATE DATABASE IF NOT EXISTS {db_name}")
initial_cursor.close()
initial_db.close()

# Connect to the newly created (or existing) database
db = mysql.connector.connect(
    host=db_host,
    user=db_user,
    password=db_password,
    database=db_name
)

cursor = db.cursor()

# Create tables
create_table_queries = [
    """
    DROP TABLE IF EXISTS Stock_Category
    """,
    """
    DROP TABLE IF EXISTS Company_Performance
    """,
    """
    DROP TABLE IF EXISTS Stock
    """,
    """
    DROP TABLE IF EXISTS Company
    """,
    """
    DROP TABLE IF EXISTS Country
    """,
    """
    DROP TABLE IF EXISTS Category
    """,
    """
    CREATE TABLE IF NOT EXISTS Category (
        category_name VARCHAR(255) PRIMARY KEY,
        category_description VARCHAR(255)
    )DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
    """,
    """
    CREATE TABLE IF NOT EXISTS Country (
        country_name VARCHAR(255) PRIMARY KEY
    )DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
    """,
    """
    CREATE TABLE IF NOT EXISTS Company (
        company_name VARCHAR(255) PRIMARY KEY,
        description TEXT,
        country_name VARCHAR(255),
        FOREIGN KEY (country_name) REFERENCES Country(country_name)
    )DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
    """,
    """
    CREATE TABLE IF NOT EXISTS Stock (
        stock_code VARCHAR(255) PRIMARY KEY,
        current_price DECIMAL(10, 2),
        current_marketcap DECIMAL(20, 2),
        company_name VARCHAR(255),
        FOREIGN KEY (company_name) REFERENCES Company(company_name)
    )DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
    """,
    """
    CREATE TABLE IF NOT EXISTS Stock_Category (
        category_name VARCHAR(255),
        stock_code VARCHAR(255),
        PRIMARY KEY (category_name, stock_code),
        FOREIGN KEY (category_name) REFERENCES Category(category_name),
        FOREIGN KEY (stock_code) REFERENCES Stock(stock_code)
    )DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
    """,
    """
    CREATE TABLE IF NOT EXISTS Company_Performance (
        company_name VARCHAR(255),
        year INT,
        earning DECIMAL(20, 2),
        revenue DECIMAL(20, 2),
        PRIMARY KEY (company_name, year),
        FOREIGN KEY (company_name) REFERENCES Company(company_name)
    )DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
    """
]

for query in create_table_queries:
    cursor.execute(query)

# Load JSON data
with open('Data Scraping/data/categories.json') as f:
    categories = json.load(f)

with open('Data Scraping/data/countries.json') as f:
    countries = json.load(f)

with open('Data Scraping/data/stocks.json') as f:
    stocks = json.load(f)

with open('Data Scraping/data/performances.json') as f:
    performances = json.load(f)

with open('Data Scraping/data/companies.json') as f:
    companies = json.load(f)

with open('Data Scraping/data/stock_categories.json') as f:
    stock_categories = json.load(f)

print("Inserting data into the database...")

# Insert data into Category
for category in categories:
    cursor.execute("INSERT INTO Category (category_name, category_description) VALUES (%s, %s) ON DUPLICATE KEY UPDATE category_description = VALUES(category_description)",
                   (category['category_name'], category['category_description']))

# Insert data into Country
for country in countries:
    cursor.execute("INSERT INTO Country (country_name) VALUES (%s) ON DUPLICATE KEY UPDATE country_name = country_name", 
                   (country['country_name'],))

# Insert data into Company
for company in companies:
    cursor.execute("INSERT INTO Company (company_name, description, country_name) VALUES (%s, %s, %s) ON DUPLICATE KEY UPDATE description = VALUES(description), country_name = VALUES(country_name)",
                   (company['company_name'], company['description'], company['country_name']))

# Insert data into Stock
for stock in stocks:
    cursor.execute("INSERT INTO Stock (stock_code, current_price, current_marketcap, company_name) VALUES (%s, %s, %s, %s) ON DUPLICATE KEY UPDATE current_price = VALUES(current_price), current_marketcap = VALUES(current_marketcap), company_name = VALUES(company_name)",
                   (stock['stock_code'], stock['current_price'], stock['current_marketcap'], stock['company_name']))

# Insert data into Stock_Category
for stock_category in stock_categories:
    cursor.execute("INSERT INTO Stock_Category (category_name, stock_code) VALUES (%s, %s) ON DUPLICATE KEY UPDATE category_name = VALUES(category_name), stock_code = VALUES(stock_code)",
                   (stock_category['category_name'], stock_category['stock_code']))

# Insert data into Company_Performance
for performance in performances:
    cursor.execute("INSERT INTO Company_Performance (company_name, year, earning, revenue) VALUES (%s, %s, %s, %s) ON DUPLICATE KEY UPDATE earning = VALUES(earning), revenue = VALUES(revenue)",
                   (performance['company_name'], performance['year'], performance['earning'], performance['revenue']))

# Commit changes and close the connection
db.commit()
cursor.close()
db.close()

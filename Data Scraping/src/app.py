# Automated Scraping
from flask import Flask
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np
from sqlalchemy import create_engine, text
from datetime import datetime
import threading
import time

chrome_options = Options()
chrome_options.add_argument("--log-level=3")  # Mengurangi logging ke level minimum
chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
chrome_options.add_argument('--headless')  # Menambahkan opsi headless (tidak membuka chrome)
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--disable-dev-shm-usage')
chrome_options.add_argument('--disable-gpu')

app = Flask(__name__)

# Fungsi untuk membersihkan tanda baca numerik
def clean_numeric(value):
    if isinstance(value, str):
        return value.replace('.', '').replace(',', '.')
    else:
        return value

# Fungsi untuk mengubah tipe data
def convert_to_numeric(value):
    try:
        return float(value)
    except ValueError:
        return value

def get_percentage(value):
    if isinstance(value, str):
        if value == "":
            return 0
        b = value.replace("(", "").replace(")", "").replace("%", "").replace(",", ".").split()[1]
        try:
            return float(b)
        except ValueError:
            clean = b.replace("+", "").replace("-", "")
            if value.startswith("-"):
                return -float(clean)
            else:
                return float(clean)
    else:
        return value

def get_change(value):
    if isinstance(value, str):
        if value == "":
            return 0
        a = value.split()[0].replace(",", ".")
        try:
            return float(a)
        except ValueError:
            clean = a.replace("+", "").replace("-", "")
            if value.startswith("-"):
                return -float(clean)
            else:
                return float(clean)
    else:
        return value

def remove_na(value):
    if isinstance(value, str) and (value.lower() == "n/a" or value == ""):
        return 0
    else:
        return value

all_data = []

@app.route("/")
def home():
    return "<p>Hello</p>"

def scrape():
    # Import konten pada halaman yang akan di-scrape
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)
    driver.get("https://www.idnfinancials.com/company")
    html_content = driver.page_source
    soup = BeautifulSoup(html_content, "html.parser")
    driver.quit()

    # Scrape seluruh data sektor yang ada
    elements = soup.find("select", id="company-filter-sectors")
    sectors = elements.find_all("option")

    # Menyimpan data sektor dalam list
    sectors_name = []

    # Mulai iterasi dari elemen kedua dan hanya ambil yang memiliki value
    for i, sector in enumerate(sectors):
        value = sector.get("value")
        if value:  # Harus ada value, kalau tidak ada di-skip
            sector_name = sector.text.strip()
            sectors_name.append(sector_name)

    # Scrape data sesuai URL
    def scrape_sector_data(sector_name, sector_url):
        driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)
        driver.get(sector_url)
        html_content = driver.page_source
        soup = BeautifulSoup(html_content, "html.parser")
        driver.quit()

        # Scrape seluruh data sektor yang ada
        holdings = soup.find_all("div", class_="table-row")

        # Menyimpan data dalam list
        data = []
        for holding in holdings:
            entry = {}
            code_element = holding.find("span", class_="code")
            name_element = holding.find("span", class_="name")
            market_cap_element = holding.find("div", class_="tc-market-cap")
            price_element = holding.find("div", class_="tc-price")
            change_element = holding.find("div", class_="tc-change")
        
            entry["Code"] = code_element.get_text(strip=True) if code_element else ""
            entry["Company Name"] = name_element.get_text(strip=True) if name_element else ""
            entry["Sector"] = sector_name
            entry["Market Cap"] = market_cap_element.get_text(strip=True) if market_cap_element else ""
            entry["Price"] = price_element.get_text(strip=True) if price_element else ""
            entry["Change"] = change_element.get_text(strip=True) if change_element else ""
            
            net_profits = holding.find("div", class_="tc-net-profit").find_all("div", class_="tp-item")
            profits = {
                "Profit 2019": "",
                "Profit 2020": "",
                "Profit 2021": "",
                "Profit 2022": "",
                "Profit 2023": ""
            }
            for profit in net_profits:
                year = profit.find("div", class_="asof").get_text(strip=True)
                value = profit.find("div", class_="val").get_text(strip=True)
                if year == "2019":
                    profits["Profit 2019"] = value
                elif year == "2020":
                    profits["Profit 2020"] = value
                elif year == "2021":
                    profits["Profit 2021"] = value
                elif year == "2022":
                    profits["Profit 2022"] = value
                elif year == "2023":
                    profits["Profit 2023"] = value
            
            entry.update(profits)
            data.append(entry)
        return data
    
    # URL setiap sektor
    sector_url_back = {
        'Energy': 'energy-a',
        'Basic Materials': 'basic-materials-b',
        'Industrials': 'industrials-c',
        'Consumer Non-Cyclicals': 'consumer-non-cyclicals-d',
        'Consumer Cyclicals': 'consumer-cyclicals-e',
        'Healthcare': 'healthcare-f',
        'Financials': 'financials-g',
        'Properties and Real Estate': 'properties-and-real-estate-h',
        'Technology': 'technology-i',
        'Infrastructure': 'infrastructure-j',
        'Transportation and Logistics': 'transportation-and-logistics-k',
        'Listed Investment Products': 'listed-investment-products-l'
    }

    # Base URL
    base_url = 'https://www.idnfinancials.com/company/sector/'

    # Menyimpan seluruh data dalam satu list
    all_data = []

    # Iterasi seluruh sektor untuk scrape data
    for sector_name in sectors_name:
        sector_url = f"{base_url}{sector_url_back[sector_name]}"
        sector_data = scrape_sector_data(sector_name, sector_url)
        print(sector_data)
        all_data.extend(sector_data)
    
    df = pd.DataFrame(all_data)

    # Menghilangkan data yang kosong
    df = df[df['Code'] != '']
        
    # Mendapatkan kolom persentase
    percentage_columns = {
        "Change": "Change %"
    }

    for column in percentage_columns.keys():
        df[percentage_columns[column]] = df[column].apply(get_percentage)
        df[column] = df[column].apply(get_change)

    # Membersihkan dan mengkonversi kolom numerik
    numerical_columns = ["Price", "Change", "Market Cap"]
    for column in numerical_columns:
        df[column] = df[column].apply(clean_numeric).apply(convert_to_numeric)

    # N/A menjadi 0
    for col in numerical_columns:
        df[col] = df[col].apply(remove_na)

    for col in percentage_columns.keys():
        df[percentage_columns[col]] = df[percentage_columns[col]].apply(remove_na)

    # Tabel pricehistory
    pricehistory = df[['Code', 'Price', 'Change', 'Change %']].rename(
        columns={'Code': 'company_code', 'Price': 'price', 'Change': 'change', 'Change %': 'change_percentage'}
    )
    pricehistory['date'] = datetime.today().strftime('%Y-%m-%d')
    print(pricehistory)

    # Tabel companies
    companies = df[['Code', 'Company Name', 'Market Cap', 'Sector']].rename(
        columns={'Code': 'company_code', 'Company Name': 'company_name', 'Market Cap': 'market_cap', 'Sector': 'sector_name'}
    )

    # Menambahkan sector_id ke tabel companies
    sector_map = {
        'Energy': 1,
        'Basic Materials': 2,
        'Industrials': 3,
        'Consumer Non-Cyclicals': 4,
        'Consumer Cyclicals': 5,
        'Healthcare': 6,
        'Financials': 7,
        'Properties and Real Estate': 8,
        'Technology': 9,
        'Infrastructure': 10,
        'Transportation and Logistics': 11,
        'Listed Investment Products': 12
    }

    companies['sector_id'] = companies['sector_name'].map(sector_map)

    # Connect ke database PostgreSQL
    engine = create_engine('postgresql+psycopg2://postgres:postgres@localhost:5432/titans')

    with engine.connect() as connection:
        for index, row in companies.iterrows():
            insert_stmt = text("""
                INSERT INTO companies (company_code, sector_id, company_name, market_cap)
                VALUES (:company_code, :sector_id, :company_name, :market_cap)
                ON CONFLICT (company_code) DO NOTHING
            """)
            print(f"Inserting into companies: {row['company_code']}, {row['sector_id']}, {row['company_name']}, {row['market_cap']}")
            connection.execute(insert_stmt, {
                'company_code': row['company_code'],
                'sector_id': row['sector_id'],
                'company_name': row['company_name'],
                'market_cap': row['market_cap']
            })

        for index, row in pricehistory.iterrows():
            insert_stmt = text("""
                INSERT INTO pricehistory (company_code, price, change, change_percentage, date)
                VALUES (:company_code, :price, :change, :change_percentage, :date)
                ON CONFLICT (company_code, date) DO NOTHING
            """)
            print(f"Inserting into pricehistory: {row['company_code']}, {row['price']}, {row['change']}, {row['change_percentage']}, {row['date']}")
            connection.execute(insert_stmt, {
                'company_code': row['company_code'],
                'price': row['price'],
                'change': row['change'],
                'change_percentage': row['change_percentage'],
                'date': row['date']
            })
        
            connection.commit()

def daily_scraping_task():
    while True:
        scrape()
        time.sleep(86400)  # Sleep untuk 24 jam (86400 detik)

if __name__ == '__main__':
    threading.Thread(target=daily_scraping_task).start()
    app.run(debug=True)

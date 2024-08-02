import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import re
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
import json
import os
from dateutil import parser as dateparser

bulan_mapping = {
    'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
    'Mei': '05', 'Jun': '06', 'Jul': '07', 'Agu': '08',
    'Sep': '09', 'Okt': '10', 'Nov': '11', 'Des': '12'
}

# Fungsi untuk mengatur dan memulai driver
def start_driver():
    options = Options()
    options.add_experimental_option("detach", True)
    chromedriver_path = r'C:\Users\Jihan Aurelia\Downloads\chromedriver-win64\chromedriver.exe'
    service = Service(chromedriver_path)
    driver = webdriver.Chrome(service=service, options=options)
    return driver


# Fungsi untuk memproses HTML dengan BeautifulSoup
def process_page_produk(html_content, data, data_normal, driver):
    soup = BeautifulSoup(html_content, 'lxml')
    products = soup.find_all('ts-catalogue-product-ui')
    for prod in products:
        prod_name = prod.find('div', class_='title')
        title_text = prod_name['title']
        name_data = extract_name_data(title_text)

        # Klik pada nama produk untuk mengambil data detil produk
        prod_name_link = prod.find('a')
        product_url = prod_name_link['href']
        driver.execute_script("window.open(arguments[0]);", product_url)
        driver.switch_to.window(driver.window_handles[-1])
        time.sleep(2)
        category = extract_product_category(driver.page_source)
        company = extract_product_company(driver.page_source, False)
        driver.close()
        driver.switch_to.window(driver.window_handles[0])

        # Mengambil data harga produk
        prod_price = prod.find('ts-money-ui')
        class_name = prod_price.get('class', [])
        if 'price--discounted' in class_name:
            prod_price_norm = prod.find('ts-money-ui', class_='obsolete')
            prod_price_disc = prod.find('ts-money-ui', class_='price price--discounted')
            if prod_price_norm and prod_price_disc:
                data.append({
                    'ID_prod': name_data['kode produk'],
                    'nama_prod': name_data['nama produk'],
                    'harga_prod': prod_price_norm.text.replace("Rp", "").replace(".", ""),
                    'terjual_prod': extract_product_terjual(prod),
                    'kat_prod': category,
                    'nama_sup': company,
                })
        elif 'price' in class_name:
            prod_price_nor = prod.find('ts-money-ui', class_='price')
            if prod_price_nor:
                data.append({
                    'ID_prod': name_data['kode produk'],
                    'nama_prod': name_data['nama produk'],
                    'harga_prod': prod_price_nor.text.replace("Rp", "").replace(".", ""),
                    'terjual_prod': extract_product_terjual(prod),
                    'kat_prod': category,
                    'nama_sup': company,
                })
                data_normal.append({
                    'ID_prod': name_data['kode produk'],
                })

# Fungsi untuk mengekstrak data nama produk
def extract_name_data(title_text):
    try:
        if "(" in title_text and ")" in title_text:
            title_text = re.sub(r'\(.*?\)', '', title_text).strip()
        match = re.search(r'^(.*?)\s+\[\d+\]', title_text)
        if match:
            product_name = match.group(1).strip()
            product_code = re.search(r'\[(\d+)\]', title_text).group(1)
            size_match = re.search(r'(\d+\s*\w+)$', product_name)
            if size_match:
                product_name = product_name[:size_match.start()].strip()

            return {
                'nama produk': product_name,
                'kode produk': product_code,
            }
        else:
            return None
    except Exception as e:
        print(f"Terjadi kesalahan: {e}")
        return None

def extract_product_terjual(prod):
    try:
        terjual_prod = prod.find('ion-text', class_='ion-color ion-color-medium md hydrated')
        number = re.search(r'\d+', terjual_prod.get_text()).group()
        return number
    except:
        return 0

# Fungsi untuk mengekstrak tinggi produk
def extract_product_category(html_content):
    try : 
        soup = BeautifulSoup(html_content, 'lxml')
        category_link = soup.find('a', href=re.compile(r'/shop/category/detail/'))
        return category_link.text.strip()
    except: 
        return 0

def extract_product_company(html_content, isPromo):
    soup = BeautifulSoup(html_content, 'lxml')
    company_link = soup.find_all('td', class_ = 'table-column-1')
    if isPromo:
        return company_link[3].text.strip()
    else:
        return company_link[2].text.strip()


def age_confirmation(driver, age_confirmation_xpath):
    # Cek dan klik elemen konfirmasi umur jika ada
    age_confirmation_button = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, age_confirmation_xpath))
    )
    age_confirmation_button.click()
    age_confirmation_clicked = True
    print("Clicked on age confirmation button successfully.")
    time.sleep(2)  # Penundaan tambahan setelah mengklik konfirmasi umur
    return age_confirmation_clicked

# Fungsi untuk mengklik tombol "Berikutnya" dan memproses halaman
def click_next_and_process(driver, num_clicks):
    data = []
    data_normal = []

    age_confirmation_xpath = '//span[contains(normalize-space(text()), "Saya konfirmasi bahwa saya berumur 21 tahun ke atas")]'
    age_confirmation_clicked = False

    try:
        for i in range(num_clicks):
            try:
                if not age_confirmation_clicked:
                    try:
                        age_confirmation_clicked = age_confirmation(driver, age_confirmation_xpath)
                    except Exception as e:
                        print(f"Age confirmation button not found or already clicked: {str(e)}")

                html_content = driver.page_source
                process_page_produk(html_content, data, data_normal, driver)

                next_button_xpath = '//ion-button[contains(normalize-space(text()), "Berikutnya")]'
                next_button = WebDriverWait(driver, 10).until(
                    EC.presence_of_element_located((By.XPATH, next_button_xpath))
                )

                driver.execute_script("arguments[0].scrollIntoView(true);", next_button)

                WebDriverWait(driver, 10).until(EC.element_to_be_clickable((By.XPATH, next_button_xpath))).click()

                print(f"Clicked on 'Berikutnya' button {i+1} times successfully.")
                time.sleep(2)

                html_content = driver.page_source
                process_page_produk(html_content, data, data_normal, driver)

            except Exception as e:
                print(f"Failed to click 'Berikutnya' button at attempt {i+1}: {str(e)}")
                driver.save_screenshot(f'error_screenshot_{i+1}.png')

    except Exception as e:
        print(f"An error occurred: {str(e)}")
    finally:
        driver.quit()
    
    return data, data_normal

# Fungsi untuk proses halaman promo
def process_page_promo(html, promo, normal_prom, potongan_prom, diskon_prod, driver):
    soup = BeautifulSoup(html, 'html.parser')
    discounts = soup.find_all('ts-promo-card-ui')

    if not discounts:
        print("No promo cards found.")
        return

    for disc in discounts:
        disc_title = disc.find('ts-promo-name-ui').get_text().strip()
        disc_range = disc.find('ts-timestamp-ui').span['title'].strip()
        
        # Loop untuk mengganti nama bulan dalam string tanggal
        for nama, angka in bulan_mapping.items():
            disc_range = disc_range.replace(nama, angka)

        # Coba parse dengan dateparser
        try:
            tanggal_obj = dateparser.parse(disc_range, fuzzy_with_tokens=False, dayfirst=True)
            tanggal_formatted = tanggal_obj.strftime("%Y-%m-%d")
        except ValueError as e:
            print(f"Error: {e}")
            tanggal_formatted = disc_range  # Jika parse gagal, gunakan string asli

        disc_remaining = disc.find('div', class_='remaining-uses')
        if disc_remaining:
            disc_amount = disc.find('span', class_='amount').get_text().strip()
            disc_code = disc.find('div', class_='promo-code').get_text().strip()
            promo.append({
                'nama_prom': disc_title,
                'rentang_prom': tanggal_formatted
            })
            normal_prom.append({
                'nama_prom': disc_title,
                'sisa_prom': disc_remaining.get_text().strip().split()[-1],
                'jumlah_prom': disc_amount.replace(".", ""),
                'kode_prom': disc_code.split()[-1]
            })
        else:
            promo.append({
                'nama_prom': disc_title,
                'rentang_prom': tanggal_formatted,
            })

            # Klik link jika tidak ada 'disc_remaining'
            prom_name_link = disc.find('a')
            if prom_name_link:
                promo_url = prom_name_link['href']
                driver.execute_script("window.open(arguments[0]);", promo_url)
                driver.switch_to.window(driver.window_handles[-1])
                print(f"Opened promo tab: {driver.window_handles}")

                time.sleep(2)
                
                # Pastikan halaman baru dimuat dengan benar
                html_content = driver.page_source
                soup = BeautifulSoup(html_content, 'lxml')
                products = soup.find_all('ts-catalogue-product-ui')
                
                for i, prod in enumerate(products):
                    prod_price_norm = prod.find('ts-money-ui', class_='obsolete')
                    prod_price_disc = prod.find('ts-money-ui', class_='price price--discounted')
                    prod_name = prod.find('div', class_='title')
                    if prod_name:
                        title_text = prod_name['title']
                        name_data = extract_name_data(title_text)

                        prod_name_link = prod.find('a')
                        if prod_name_link:
                            product_url = prod_name_link['href']
                            driver.execute_script("window.open(arguments[0]);", product_url)
                            driver.switch_to.window(driver.window_handles[-1])
                            print(f"Opened product tab {i+1}: {driver.window_handles}")
                            time.sleep(2)
                            
                            # Ekstrak kategori dan perusahaan
                            category = extract_product_category(driver.page_source)
                            company = extract_product_company(driver.page_source, True)
                            
                            # Tambahkan informasi produk ke daftar
                            potongan_prom.append({
                                'nama_prom': disc_title
                            })
                            diskon_prod.append({
                                'ID_prod': name_data['kode produk'],
                                'nama_prod': name_data['nama produk'],
                                'harga_prod_norm': prod_price_norm.text.replace("Rp", "").replace(".", "") if prod_price_norm else "N/A",
                                'harga_prod_disc': prod_price_disc.text.replace("Rp", "").replace(".", "") if prod_price_disc else "N/A",
                                'terjual_prod': extract_product_terjual(prod),
                                'kat_prod': category,
                                'nama_sup': company,
                                'nama_prom': disc_title
                            })
                            driver.close()
                            driver.switch_to.window(driver.window_handles[-1])  # Kembali ke tab promo
                        else:
                            print("Product link not found")
                    else:
                        print("Product name not found")
                    
                # Tutup jendela promo dan kembali ke jendela utama
                driver.close()
                print(f"Closed promo tab: {driver.window_handles}")
                if len(driver.window_handles) > 0:
                    driver.switch_to.window(driver.window_handles[0])
                else:
                    print("No more tabs to switch back to. Check if tabs are correctly managed.")


# Fungsi untuk mengklik tombol "Berikutnya"
def click_next(driver, num_clicks):
    promo = []
    normal_prom = []
    potongan_prom = []
    diskon_prod = []

    for i in range(num_clicks):
        try:
            html_content = driver.page_source
            process_page_promo(html_content, promo, normal_prom, potongan_prom, diskon_prod, driver)
            next_button_xpath = '//ion-button[contains(normalize-space(text()), "Berikutnya")]'
            next_button = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, next_button_xpath))
            )
            driver.execute_script("arguments[0].scrollIntoView(true);", next_button)
            WebDriverWait(driver, 10).until(EC.element_to_be_clickable((By.XPATH, next_button_xpath))).click()

            print("Clicked on 'Berikutnya' button successfully.")
            time.sleep(2)

            html_content = driver.page_source
            process_page_promo(html_content, promo, normal_prom, potongan_prom, diskon_prod, driver)

        except Exception as e:
            print(e)
            print(f"Failed to click 'Berikutnya' button: {str(e)}")
            driver.quit()
            return promo, normal_prom, potongan_prom, diskon_prod

    driver.quit()

    return promo, normal_prom, potongan_prom, diskon_prod

# Fungsi untuk menyimpan data ke format JSON
def save_to_json(data, filename):
    # Create data directory if it doesn't exist
    if not os.path.exists('data'):
        os.makedirs('data')

    # Menyimpan data produk ke format JSON
    with open(f'data/{filename}', 'w') as f:
        json.dump(data, f, indent=4)

# Fungsi utama untuk memproses data dan menyimpannya ke JSON
def convert_to_json_produk(url, num_clicks, filename1, filename2):
    # Menjalankan proses scraping dari fungsi yang sudah ada
    driver = start_driver()
    driver.get(url)
    data, data_normal = click_next_and_process(driver, num_clicks)
    
    # Menyimpan data ke format JSON
    save_to_json(data, filename1)
    save_to_json(data_normal, filename2)

# Fungsi utama untuk memproses data dan menyimpannya ke JSON
def convert_to_json_promo(url, num_clicks, filename1, filename2, filename3, filename4):
    # Menjalankan proses scraping dari fungsi yang sudah ada
    driver = start_driver()
    driver.get(url)
    promo, normal_prom, potongan_prom, diskon_prod = click_next(driver, num_clicks)
    
    # Menyimpan data ke format JSON
    save_to_json(promo, filename1)
    save_to_json(normal_prom, filename2)
    save_to_json(potongan_prom, filename3)
    save_to_json(diskon_prod, filename4)
        
# Contoh pemanggilan fungsi utama untuk konversi ke JSON
convert_to_json_produk('https://www.bormadago.com/shop/product/list', 40, 'produk.json', 'normal_prod.json')
convert_to_json_promo('https://www.bormadago.com/shop/promo/list', 2, 'promo.json', 'normal_prom.json', 'potongan_prom.json', 'diskon_prod.json')


print("Data has been stored in JSON format!")
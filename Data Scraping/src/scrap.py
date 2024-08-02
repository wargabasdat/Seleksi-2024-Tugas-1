import time
from selenium import webdriver
from bs4 import BeautifulSoup
import pandas as pd
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
import json
from datetime import datetime
import re

options = webdriver.ChromeOptions()
options.add_argument("start-maximized")
url = 'https://www.olx.co.id/items/q-Mobil'

driver = webdriver.Chrome(options=options)
driver.maximize_window()
driver.get(url)


#untuk pagination (membuka semua halaman)
for i in range(20):
    time.sleep(1.5)
    try:
        driver.find_element(By.CSS_SELECTOR, "div._38O09 > button").click()
        time.sleep(1.5)
    except NoSuchElementException:
        break
time.sleep(1.5)

#fungsi mengambil teks
def getText(soup_element, selector, attribute=None):
    element = soup_element.select_one(selector)
    return element.get_text(strip=True) if element else ''

#fungsi mengambil tanggal
def convertDate(date_text):
    date_text = date_text.replace('Anggota sejak', '').strip()
    return date_text

# fungsi mengambil numeric
def getNumeric(teks):
    try:
        angka = re.findall(r'\d+', teks)
        return angka[0] 
    except IndexError:
        return '0'

def splitLokasi(teks):
    try:
        kota, provinsi = teks.split(', ')
        return kota, provinsi
    except ValueError:
        return '', '' 

def getHarga(teks):
    try:
        result = ''.join(filter(str.isdigit, teks))
        return int(result)
    except ValueError:
        return teks

def getHargaCicilan(teks):
    try:
        result = ''.join(filter(str.isdigit, teks.split('x')[0]))
        return int(result)
    except ValueError:
        return teks
    
produk = []
soup = BeautifulSoup(driver.page_source, "html.parser")
baselink = 'https://www.olx.co.id'

for item in soup.findAll('li', class_='_1DNjI'):
    link = item.find('a', href=True)['href'] if item.find('a', href=True) else ''
    judul = getText(item, 'span._2poNJ')
    newlink = baselink + link
    tahun = getText(item, 'span.YBbhy')

    # masuk ke link produk yang dijual
    driver.get(newlink)
    time.sleep(0.5)
    soup2 = BeautifulSoup(driver.page_source, "html.parser")

    nama_mobil = getText(soup2, 'h1._2iMMO')
    keterangan = getText(soup2, 'div.BxCeR')
    bahan_bakar = getText(soup2, 'h2[data-aut-id="itemAttribute_fuel"]')
    km = getText(soup2, 'div[data-aut-id="itemAttribute_mileage"]')
    transmisi = getText(soup2, 'h2[data-aut-id="itemAttribute_transmission"]')
    harga = getHarga(getText(soup2, 'div._1uqlc'))

    temp_elemen1 = soup2.find_all('div', class_='_3dS7E')
    jenis_penjual = temp_elemen1[0].find('div', class_='_3VRXh').get_text(strip=True) if len(temp_elemen1) > 0 else ''
    kota, provinsi = splitLokasi(temp_elemen1[1].find('div', class_='_3VRXh').get_text(strip=True)) if len(temp_elemen1) > 1 else ('', '')
    kapasitas_mesin = temp_elemen1[2].find('div', class_='_3VRXh').get_text(strip=True) if len(temp_elemen1) > 2 else ''

    temp_elemen2 = soup2.find_all('div', class_='_1jm7b')
    dp = getHarga(temp_elemen2[0].find('div', class_='_15PAr').get_text(strip=True)) if len(temp_elemen2) > 0 else ''
    cicilan = getHargaCicilan(temp_elemen2[1].find('div', class_='_15PAr').get_text(strip=True)) if len(temp_elemen2) > 1 else ''

    # masuk ke profil jenis_penjual
    if soup2.find('div', class_ = 'UHvQk'):
        if soup2.find('div', class_ = 'UHvQk').find('a', href=True):
            link_akun = soup2.find('div', class_ = '_3w6Zk undefined').find('a', href=True)['href']
            driver.get(baselink + link_akun)
            time.sleep(0.5)
            soup3 = BeautifulSoup(driver.page_source, "html.parser")
            nama_penjual = soup3.find('div', class_='_31kC9').get_text(strip=True) if soup3.find('div', class_='_31kC9') else ''
            ket_penjual = soup3.find('div', class_='_9zPI3').get_text(strip=True) if soup3.find('div', class_='_9zPI3') else '-'
            jumlah_iklan = getNumeric(soup3.find('div', class_='_12olb').get_text(strip=True)) if soup3.find('div', class_='_12olb') else '0'

    else:
        nama_penjual = soup2.find('div', class_='_31kC9').get_text(strip=True) if soup2.find('div', class_='_31kC9') else ''
        ket_penjual = 'Dikelola oleh OLX Mobbi'
        jumlah_iklan = '0'
    

    # produk.append((newlink, judul, waktu, nama_mobil,  keterangan, bahan_bakar, km, transmisi, tahun, kapasitas_mesin, lokasi_detail, harga, dp, cicilan, jenis_penjual))
    produk.append((newlink, judul, nama_mobil,  keterangan, bahan_bakar, km, transmisi, tahun, kapasitas_mesin, kota, provinsi, harga, dp, cicilan, jenis_penjual, nama_penjual, ket_penjual, jumlah_iklan))
# Cbuat data frame
# df = pd.DataFrame(produk, columns=['link', 'nama', 'waktu_post', 'judul',  'keterangan', 'bahan_bakar', 'km', 'transmisi', 'tahun', 'kapasitas_mesin', 'lokasi_detail', 'harga', 'dp', 'cicilan', 'jenis_penjual'])
df = pd.DataFrame(produk, columns=['link', 'judul', 'nama_mobil',  'keterangan', 'bahan_bakar', 'km', 'transmisi', 'tahun', 'kapasitas_mesin', 'kota', 'provinsi', 'harga', 'dp', 'cicilan', 'jenis_penjual', 'nama_penjual', 'ket_penjual', 'jumlah_iklan'])

# proses cleansing
df = df[df['km'] != '']
df = df[df['jenis_penjual'] != '--']
df = df[df['kapasitas_mesin'] != '--']
df = df[df['nama_penjual'] != '']
df.drop_duplicates(inplace=True)

# Save to JSON
df.to_json('hasil.json', orient='records', indent=4)

print("tersimpan")
driver.quit()
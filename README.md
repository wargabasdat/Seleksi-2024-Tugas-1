<h1 align="center">
  <br>
  Discover the Titans: Top Companies Dominating Each Sector in Indonesia
  <br>
</h1>

<h2 align="left">
  <br>
  Author
  <br>
</h2>
Anindita Widya Santoso (18222128)
<br>

## Deskripsi Singkat
<p align="justify">
Topik yang saya pilih untuk proyek ETL ini berhubungan dengan <strong>pasar saham</strong>. Saya memilih topik ini karena investasi adalah aktivitas yang penting untuk dilakukan. Namun, sebagai orang awam yang tidak mengenal pasar saham secara mendalam, seringkali saya merasa ragu ketika ingin terjun ke dunia saham. Saya khawatir tidak dapat melakukan analisis yang menyeluruh, sehingga saham yang saya pilih mungkin ternyata kurang menguntungkan. Untuk itu, saya melakukan <em>web scraping</em> terhadap data saham terkemuka di Indonesia dengan riwayat lima tahun terakhir. Tujuan saya adalah membantu para pemuda yang ingin mempelajari investasi untuk mencoba saham yang lebih <em><strong>low risk</strong></em> sebelum akhirnya mereka memiliki kepercayaan diri yang cukup untuk memasuki pasar saham yang lebih <em><strong>high risk</strong></em>.

<p align="justify">
Data yang dikumpulkan berasal dari situs web <strong><a href="https://www.idnfinancials.com">IDN Financials</a></strong>, yang menyediakan informasi mengenai kode perusahaan, nama perusahaan, kapitalisasi pasar (<em>market cap</em>), dan profitabilitasnya selama beberapa tahun terakhir. Sistem Basis Data Manajemen (DBMS) yang digunakan dalam proyek ini adalah PostgreSQL. Saya memilih PostgreSQL karena kemampuannya dalam menangani data dalam skala besar dengan efisien dan kemampuan untuk menjalankan query yang kompleks secara cepat.

## Cara Menggunakan Scraper
1. Install seluruh library yang dibutuhkan dengan menggunakan perintah `pip install`. Lakukan instalasi pada library `notebook`,`selenium`, `webdriver-manager`,`beautifulsoup4`,`pandas`,`sqlalchemy`,`psycopg2-binary`,`pipreqs`.
    ```bash
    pip install notebook selenium webdriver-manager beautifulsoup4 pandas sqlalchemy psycopg2-binary pipreqs
    ```
2. Clone repository ini untuk menggunakan scraper
    ```bash
    git clone https://github.com/aninditaws/Seleksi-2024-Tugas-1
    ```
3. Buka path `Data Scrapping\src`
4. Buat server PostgreSQL pada terminal
    ```bash
    > psql -U postgres
    Password: # Masukkan password PostgreSQL Anda
    ```
    ```bash
    CREATE DATABASE titans;
    ```
5. Ubah kredensial PostgreSQL yang ada pada file `scraping.ipynb` bagian `engine` SQL File
    ```bash
    'postgresql://<username>:<password>@localhost:<port>/titans'
    ```
6. Jalankan script `scraping.ipynb` dengan perintah `jupyter nbconvert --to notebook --execute scraping.ipynb` atau lakukan Run All pada file tersebut
7. Apabila ingin melakukan dump file SQL. Jalankan perintah berikut.
    ```bash
    > pg_dump -U postgres -d titans > titans.sql
    ```

## Struktur File JSON
Terdapat 3 file JSON yang dihasilkan dengan strukturnya yang berbeda-beda.

**sectors_name.json** </p>
  ```bash
  {
    "sectors-name": [
      "Energy",
      "Basic Materials",
      "Industrials",
      "Consumer Non-Cyclicals",
      "Consumer Cyclicals",
      "Healthcare",
      "Financials",
      "Properties and Real Estate",
      "Technology",
      "Infrastructure",
      "Transportation and Logistics",
      "Listed Investment Products"
    ]
  }
  ```

**sectors_data.json** </p>
  ```bash
  {
    "Code":"VKTR",
    "Company Name":"PT. VKTR Teknologi Mobilitas Tbk",
    "Sector":"Consumer Cyclicals",
    "Market Cap":"5.687.500,00",
    "Price":"130",
    "Change":"-5 (-4,00%)",
    "Profit 2019":"n\/a",
    "Profit 2020":"n\/a",
    "Profit 2021":"n\/a",
    "Profit 2022":"n\/a",
    "Profit 2023":"5.428(0.51%)"
  }
  ```

**all_data.json** </p>
  ```bash
  {
    "Code":"VKTR",
    "Company Name":"PT. VKTR Teknologi Mobilitas Tbk",
    "Sector":"Consumer Cyclicals",
    "Market Cap":5687500.0,
    "Price":129.0,
    "Change":-1.0,
    "Profit 2019":0.0,
    "Profit 2020":0.0,
    "Profit 2021":0.0,
    "Profit 2022":0.0,
    "Profit 2023":5428.0,
    "Profit 2019 %":0.0,
    "Profit 2020 %":0.0,
    "Profit 2021 %":0.0,
    "Profit 2022 %":0.0,
    "Profit 2023 %":0.51,
    "Change %":-1.0
  }
  ```

## Struktur ERD dan Diagram Relasional RDBMS
Berikut merupakan perancangan database dalam bentuk ERD dan relasional.

**Entity Relationship Diagram </p>**
![ERD](Data%20Storing/design/ERD.png)

Berdasarkan ERD di atas, saya mentranslasikan diagram relasional yang menjadi basis dari pembuatan tabel SQL </p>

**Diagram Relasional </p>**
![Relasional](Data%20Storing/design/Relasional.png)

## Translasi ERD menjadi Relasional
Berikut merupakan pemetaan entitas berdasarkan tipenya menjadi relasi.

**Pemetaan <em> strong entity </em> menjadi relasi </p>**
![Strong Entity](Data%20Storing/design/strong_entity.png)

**Pemetaan <em> weak entity </em> menjadi relasi </p>**
![Weak Entity](Data%20Storing/design/weak_entity.png)

***Foreign Keys***
- companies(sector_id) → sectors(sector_id)
- pricehistory(company_code) → companies(company_code)
- profit(company_code) → companies(company_code)

**Relasi**
- companies(<u>company_code</u>, sector_id, company_name, market_cap)
- sectors(<u>sector_id</u>, sector_name)
- profit(<u>year</u>, <u>company_code</u>, profit_value, profit_percentage)
- pricehistory(<u>date</u>, <u>company_code</u>, price, change, change_percentage)

***Trigger***
- trigger_pricehistory_insert (tabel pricehistory)

## Screenshot Program
Berikut merupakan *screenshot* yang berhubungan dengan *scraping website* IDN Financials. 

**Tampilan Website </p>**
![Tampilan Website](Data%20Scraping/screenshot/website_sectors.png)
![Tampilan Website](Data%20Scraping/screenshot/website_holdings.png)

**Kode untuk Scrape Sectors </p>**
![Scrape Sectors](Data%20Scraping/screenshot/scrape_sectors.png)

**Kode untuk Scrape Holdings </p>**
![Scrape Holdings](Data%20Scraping/screenshot/scrape_holdings1.png)
![Scrape Holdings](Data%20Scraping/screenshot/scrape_holdings2.png)

**Isi SQL </p>**
**Daftar Tabel SQL </p>**
![Daftar Tabel](Data%20Storing/screenshot/daftar_tabel.png)

**Tabel Companies </p>**
![Tabel Companies](Data%20Storing/screenshot/tabel_companies.png)
![Isi Tabel Companies](Data%20Storing/screenshot/isi_companies.png)

**Tabel Sectors </p>**
![Tabel Sectors](Data%20Storing/screenshot/tabel_sectors.png)
![Isi Tabel Sectors](Data%20Storing/screenshot/isi_sectors.png)

**Tabel Profit </p>**
![Tabel Profit](Data%20Storing/screenshot/tabel_profit.png)
![Isi Tabel Profit](Data%20Storing/screenshot/isi_profit.png)

**Tabel PriceHistory </p>**
![Tabel PriceHistory](Data%20Storing/screenshot/tabel_pricehistory.png)
![Isi Tabel PriceHistory](Data%20Storing/screenshot/isi_pricehistory.png)

## Automated Scraping
<p align="justify">
Saat ini, fitur automated scraping yang saya rancang baru bisa <strong> bekerja di lokal </strong>. Sehingga, harus terdapat terminal yang selalu terbuka untuk merealisasikan fitur ini. </p>

<p align="justify">
Fitur ini dirancang untuk melakukan scraping setiap 24 jam guna mengambil data perubahan harga harian. Kode yang digunakan pada fitur ini dapat ditemukan pada <code>Data Scraping/src/app</code></p>

**Data <m> batch </m> pertama**
![Batch 1](Data%20Storing/screenshot/automated1.png)

**Data <m> batch </m> kedua**
![Batch 2](Data%20Storing/screenshot/automated2.png)

## Referensi
  - [selenium](https://selenium-python.readthedocs.io/)
  - [beautifulsoup4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
  - [pandas](https://pandas.pydata.org/pandas-docs/stable/index.html)
  - [sqlalchemy](https://docs.sqlalchemy.org/en/14/)
  - [psycopg2-binary](https://www.psycopg.org/docs/)
  - [pipreqs](https://pypi.org/project/pipreqs/)
  - [IDN Financials](https://www.idnfinancials.com/)
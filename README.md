<h2 align="center">
  <br>
  Seleksi Warga Basdat 2024 <br>
  ETL Project : Data Scraping, Database Modeling, and Data Storing <br>
  from Top 100 Baseball Prospects | MLB.com
  <br>
  <br>
</h2>

## Author
Yovanka Sandrina Maharaja
<br>
18222094
<br>
Sistem dan Teknologi Informasi
<br>
Institut Teknologi Bandung

## Table of Contents
- [Table of Contents](https://github.com/yovankas/Seleksi-2024-Tugas-1#table-of-contents)
- [Description](https://github.com/yovankas/Seleksi-2024-Tugas-1#description)
- [How to Use the Scraper](https://github.com/yovankas/Seleksi-2024-Tugas-1#how-to-use-the-scraper)
- [JSON File Structure](https://github.com/yovankas/Seleksi-2024-Tugas-1#json-file-structure)
- [Entity-Relationship Diagram (ERD)](https://github.com/yovankas/Seleksi-2024-Tugas-1#entity-relationship-diagram-erd)
- [Translating Entity-Relationship Diagram (ERD) to Relational Diagram](https://github.com/yovankas/Seleksi-2024-Tugas-1#translating-entity-relationship-diagram-erd-to-relational-diagram)
- [Relational Diagram](https://github.com/yovankas/Seleksi-2024-Tugas-1#relational-diagram)
- [Screenshots](https://github.com/yovankas/Seleksi-2024-Tugas-1#screenshots)
- [Reference](https://github.com/yovankas/Seleksi-2024-Tugas-1#reference)
  
## Description
Data _scraping_ dilakukan pada halaman MLB Prospects, yang mencantumkan [100 Prospek Terbaik Major League Baseball (MLB) 2024](https://www.mlb.com/prospects). Prospek adalah pemain muda yang diharapkan menjadi atlet profesional sukses. Data mencakup informasi seperti nama pemain, peringkat, posisi, tim, level, _ETA_ (tahun perkiraan masuk liga utama), usia, _bats_ (cara memukul), _throws_ (cara melempar), tinggi, dan berat pemain.
<br> <br>
Topik "100 Prospek Terbaik MLB 2024" dipilih sebagai bahan _web scraping_ karena daftar ini selalu menarik perhatian penggemar yang ingin mengikuti perkembangan pemain muda berbakat yang berpotensi di masa depan. Mengumpulkan dan menganalisis data prospek ini membantu memetakan tren baru dalam rekrutmen dan pengembangan bakat, serta memberikan wawasan berharga bagi komunitas _baseball_.
<br> <br>
DBMS yang digunakan untuk menyimpan hasil _web scraping_ adalah MariaDB berbasis SQL. Pemilihan MariaDB didasarkan pada kinerja yang cepat, fleksibilitas, dan keandalannya. MariaDB merupakan sistem basis data relasional _open-source_ yang kompatibel dengan MySQL, memungkinkan penyimpanan data yang terstruktur dengan baik dan mendukung berbagai operasi _query_. Selain itu, MariaDB juga menyediakan berbagai fitur keamanan dan skalabilitas yang memadai.
<br> <br>
Skema basis data mencakup tabel-tabel utama seperti _Division_League_ (informasi tentang divisi dan liga baseball), _Team_ (informasi tentang tim MLB), _Coach_ (informasi tentang pelatih tim), _Coach_Per_Type_ (jenis pelatih dan asosiasi mereka dengan tim), _Player_ (informasi rinci tentang setiap pemain), _Stadium_ (informasi tentang stadion MLB), _Season_ (informasi tentang musim MLB), _Regular_Season_ (statistik musim reguler), _Playoff_ (statistik _playoff_), _Game_ (informasi tentang pertandingan), dan _Player_Stats_ (data statistik pemain). Basis data juga memiliki suatu tabel _view_ yaitu _Win_Percentage_ yang berisi informasi tentang persentase kemenangan setiap tim MLB.

## How to Use the Scraper
1. _Clone repository_ ini ke _directory_ lokal Anda melalui Github atau dengan menjalankan perintah berikut di terminal:
```
git clone https://github.com/yovankas/draft-seleksi-basdat
```
2. _Install_ semua _library_ yang digunakan dalam menjalankan program ini dengan menjalankan perintah berikut di _Command Prompt (as Administrator)_:
```
pip install selenium pandas beautifulsoup4 mariadb
```
3. _Install Chrome Webdriver_ dengan mengikuti langkah-langkah pada tautan berikut [Tutorial _Install Chrome Webdriver_](https://katekuehl.medium.com/installation-guide-for-google-chrome-chromedriver-and-selenium-in-a-python-virtual-environment-e1875220be2f).
4. Buka _file_ data_scraping_src.py pada folder [_Data Scraping Source Code_](https://github.com/yovankas/Seleksi-2024-Tugas-1/tree/main/Data%20Scraping/src) di aplikasi _editor_ pilihan Anda seperti Visual Studio Code, PyCharm, atau _editor_ teks lainnya.
5. Ganti variabel _chrome_driver_path_ pada _file source_ menjadi _path_ dari aplikasi _Chrome Webdriver_ yang sudah diunduh sebelumnya.
6. _Set up_ basis data di MariaDB dan ganti variabel _host, user,_ dan _password_ pada _file source_ sesuai dengan milik Anda.
7. Jalankan fungsi scrape_and_store_prospects() dalam _file_ data_scraping_src.py pada aplikasi _editor_ yang Anda pilih.

## JSON File Structure
Berikut merupakan struktur dari file JSON yang dihasilkan dari _Data Scraping_ yaitu  `top100mlbprospects.json`:
```
{
    "0": {
        "Player": Nama Pemain (Primary Key),
        "Rank": Ranking Pemain pada Prospek,
        "Position": Posisi Pemain dalam Tim,
        "Team": Tim Pemain,
        "Level": Level Pemain,
        "eta": Tahun Perkiraan Pemain memasuki Liga Utama,
        "Age": Usia Pemain,
        "Bats": Cara Memukul oleh Pemain,
        "Throws": Cara Melempar oleh Pemain,
        "Height (cm)": Tinggi Pemain dalam cm,
        "Weight (kg)": Berat Badan Pemain dalam kg
    }
}
```
Berikut merupakan contoh salah satu _tuple_ pada data hasil.
```
{
    "0": {
        "Player": "Jackson Holliday",
        "Rank": 1,
        "Position": "2B/SS",
        "Team": "Baltimore Orioles",
        "Level": "AAA",
        "eta": "2024",
        "Age": 20,
        "Bats": "L",
        "Throws": "R",
        "Height (cm)": 182.88,
        "Weight (kg)": 83.91452
    }
}
```

## Entity-Relationship Diagram (ERD)
Berikut merupakan Entity-Relationship Diagram (ERD) dari basis data yang telah dirancang beserta dengan asumsi dan penjelasannya.
![ERD](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/design/erd.png)

## Translating Entity-Relationship Diagram (ERD) to Relational Diagram
Berikut merupakan langkah-langkah translasi ERD ke Relational Diagram.
### Pemetaan _entity_ menjadi relasi 
1. _Strong Entity_ <br>
Untuk setiap _strong entity_ dilakukan pemetaan dengan membuat tabel (relasi) berisi seluruh atribut, dengan salah satu atribut menjadi _primary key_. <br>
  - Player = (_player_name_, rank, position, level, eta, age, bats, throws, height (cm), weight (cm))
  - Team = (_team_name_, contact_number, address, wins, loses, official_website)
  - Division_League = (league_id, division_id, league_name, division_type)
  - Coach = (_coach_id_, coach_name)
  - Game = (_game_id_, date, start_time, end_time, home_team_name, away_team_name, home_score, away_score)
  - Season = (_season_id_, season_year)
  - Stadium = (_stadium_id_, stadium_name, capacity, area)
2. _Weak Entity_ <br>
Untuk setiap _weak entity_, dilakukan pemetaan dengan membuat tabel (relasi) berisi seluruh atribut, dengan dua atribut _primary key_, yaitu _primary key_ dari _weak entity_ tersebut, dan _primary key_ dari _strong entity_ yang berelasi dengannya. <br>
  - Player_Stats = (_player_stats_id, game_id, player_name_, hits, strikeouts, at_bats)
### Pemetaan _multivalued attributes_ 
Pemetaan _multivalued attributes_ dilakukan dengan membuat tabel (relasi) baru berisi dua _primary key_, yaitu _primary key_ dari _entity_ yang berisi _multivalued attribute_ tersebut, serta _multivalued attribute_ itu sendiri.
  - Coach_Per_Type = (_coach_id, coach_type_) <br>
### Pemetaan _derived attributes_ menjadi _view_
Pemetaan _derived attributes_ tidak dilakukan saat pembuatan relasi, sehingga atribut-atribut tersebut tidak dimasukkan ke dalam relasi. Pemetaan _derived attributes_ selanjutnya akan diimplementasikan sebagai tabel _view_.
  - Win_Percentage = (_team_name_, wins, loses, win_percentage)<br>
### Pemetaan _composite attributes_
Pemetaan _composite attributes_ dilakukan dengan membuat komponen _composite
attribute_, yaitu _simple attributes_, menjadi atribut tersendiri. 
  - Stadium = (_stadium_id_, stadium_name, capacity, city, states, zip_code)<br>
### Pemetaan _relationship_ menjadi relasi
1. _One-to-many relationship and many-to-one relationship_ <br>
Untuk setiap _relationship one-to-many_ dan _many-to-one_, akan ditambahkan atribut _primary key_ dari sisi "one" ke sisi "many". <br>
  - Player = (_player_name_, team_name, rank, position, level, eta, age, bats, throws, height (cm), weight (cm))
  - Team = (_team_name_, contact_number, address, wins, loses, official_website, league_id, division_id)
  - Coach = (_coach_id_, coach_name, team_name)
  - Game = (_game_id_, stadium_id, season_id, date, start_time, end_time, home_team_name, away_team_name, home_score, away_score)

### Pemetaan _specialization_ menjadi relasi
Untuk _specialization_, pemetaan dilakukan dengan membentuk 3 relasi, yaitu _higher-level entity set_, dan dua _lower-level entity set_. _Primary key_ dari _higher-level entity set_ akan ditambahkan sebagai _primary key_ ke relasi yang terbentuk dari _lower-level entity set_. 
  - Regular_Season = (_season_id_)
  - Playoff = (_season_id_, round_series)

## Relational Diagram
Berikut merupakan Relational Diagram yang diperoleh dari hasil translasi ERD basis data yang telah dirancang.
![rel](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/design/relationalmodel.png)

## Screenshots
- _Website_ yang di-_scrape_ ![website](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/website_scraping.jpg)
- _Source code scraping data_ ![src1](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/src_code(1).png)
  ![src2](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/src_code(2).png)
- _Source code preprocessing data_ ![pre1](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/preprocess_src_code.png)
- _Source code storing data_ ![stor1](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Scraping/screenshot/store_src_code.png)
- _Query Show Tables_ pada _database_ ![show1](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/tables_in_database.jpg)
- _Describe database_ hasil _data storing_ ![des1](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/describe_table(1).jpg)
  ![des2](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/describe_table(2).jpg)
  ![des3](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/describe_table(3).jpg)
  ![des4](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/describe_table(4).jpg)
- _Query Select From Where_ pada _database_ ![quer1](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/query_select(1).jpg)
  ![quer2](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/query_select(2).jpg)
  ![quer3](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/query_select_where.jpg)
  ![quer4](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/query_select_where(2).jpg)
- _Data Visualization_ ![vis1](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/visualization(1).jpg)
  ![vis2](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/visualization(2).jpg)
  ![vis3](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/visualization(3).jpg)
  ![vis4](https://github.com/yovankas/Seleksi-2024-Tugas-1/blob/main/Data%20Visualization/visualization(4).jpg)

## Reference
1. _Library_ yang digunakan :
   - Pandas
   - JSON
   - Selenium
   - BS4
   - RE
   - OS
   - MariaDB
   - Time
2. Halaman _web_ yang di-_scrape_ : [100 Prospek Terbaik Major League Baseball (MLB) 2024](https://www.mlb.com/prospects)
3. Referensi lainnya : [Major League Baseball from Wikipedia](https://en.wikipedia.org/wiki/Major_League_Baseball)

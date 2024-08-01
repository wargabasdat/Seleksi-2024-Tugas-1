<h1 align="center"><br>
  Seleksi Laboratorium Basis Data (Tugas 1)<br>
  ETL Project<br>
</h1>

## Author
|          Nama             |      NIM      |
| ------------------------- | ------------- |
| Dhafin Fawwaz Ikramullah  |    13522084   |

## Deskripsi
<!-- - Deskripsi singkat mengenai data dan DBMS yang telah dibuat + mengapa kalian memilih topik tersebut -->
DBMS yang dibuat merupakan data dari game [Super Mario Bros](https://www.mariowiki.com/Super_Mario_Bros.) yang data-datanya merupakan hasil web scrapping. Topik ini dipilih karena akan cocok untuk dijadikan sebuah sistem basis data relasional dengan adanya hal-hal seperti character yang memiliki beberapa tipe, level yang berisikan item-item dengan jumlah tertentu, hubungan antara power up, playable character, dan form power up, dan sebagainya. Dengan adanya DBMS ini kita dapat dengan mudah memperoleh sebuah insight untuk game ini.

## Cara Menggunakan
<!-- - Cara menggunakan scraper yang telah dibuat dan menggunakan hasil output-nya -->
Pastikan untuk membuka folder `DataScraping/src` di terminal.

### Docker
Jika ingin menggunakan docker, jalankan ini
```
docker-compose up
```
Program akan secara otomatis melakukan web scraping dan menyimpannya di `json/data.json` serta memasukkan data-data ke basis data.

### Dump
jalankan command berikut untuk melakukan dump database
```
docker exec -it mariodb pg_dump mariodb > dump/dump.sql
```


### Manual
Jika tidak menggunakan docker, anda bisa mengikuti ini. Pastikan Python dan PostgreSQL terinstall.
Jalankan
```
python main.py
```
Dan akan otomatis web scraping dan memasukkan data ke basis data.

Jika hanya ingin web scraping saja maka jalankan
```
python scrape.py
```

Jika hanya ingin memasukkan ke database saja maka jalankan
```
python db.py
```

Contoh jika ingin menjalankan sebuah query dari code adalah sebagai berikut.
```
python db.py "SELECT * FROM item"
```


## Struktur File Hasil Scrapping
- Penjelasan struktur dari file JSON yang dihasilkan scraper

## Struktur ERD dan diagram relasional RDBMS 
- Struktur ERD dan diagram relasional RDBMS

## Translasi ERD Menjadi diagram relasional
- Penjelasan mengenai proses translasi ERD menjadi diagram relasional

## Screenshot
- Beberapa screenshot dari program yang dijalankan (image di-upload sesuai folder-folder yang tersedia, di README tinggal ditampilkan)


## Referensi
- Bahasa Pemrograman: Python
- Library:
    - asyncio: web request secara konkuren
    - BeautifulSoup: scrapping html website
    - psycopg2: driver database
- DBMS: PostgreSQL 
- URL Website yang discrape: 
    - https://www.mariowiki.com/Super_Mario_Bros
    - https://www.mariowiki.com/World_1-1_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_1-2_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_1-3_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_1-4_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_2-1_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_2-2_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_2-3_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_2-4_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_3-1_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_3-2_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_3-3_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_3-4_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_4-1_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_4-2_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_4-3_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_4-4_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_5-1_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_5-2_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_5-3_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_5-4_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_6-1_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_6-2_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_6-3_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_6-4_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_7-1_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_7-2_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_7-3_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_7-4_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_8-1_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_8-2_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_8-3_(Super_Mario_Bros.)
    - https://www.mariowiki.com/World_8-4_(Super_Mario_Bros.)
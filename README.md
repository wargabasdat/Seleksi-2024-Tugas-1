# FIT HUB Class Schedule Analytics

## Author
<table>
    <tr>
        <td>Nama</td>
        <td>NIM</td>
    </tr>
    <tr>
        <td>Muhammad Neo Cicero Koda</td>
        <td>13522108</td>
    </tr>
</table>

## Deskripsi Singkat Data
Data yang di-scrape pada proyek ini adalah data jadwal kelas dari FIT HUB, khususnya pada cabang-cabang daerah Bandung. FIT HUB adalah salah satu commercial gym di Indonesia yang memiliki lebih dari 80 cabang di seluruh Indonesia dan lebih dari 20 jenis kelas yang bervariasi. Selain data jadwal kelas, proyek ini juga melakukan scraping terhadap data cabang FIT HUB di seluruh Indonesia serta informasi kelas yang disediakan oleh FIT HUB.

Pada DBMS yang telah dibuat, terdapat 6 tabel, yaitu:
- branches: Berisi informasi tentang daftar cabang FIT HUB di seluruh Indonesia
- classes: Berisi informasi tentang daftar kelas yang diselenggarakan oleh FIT HUB
- schedule: Berisi informasi tentang jadwal penyelenggaraan kelas pada suatu cabang FIT HUB
- instructors: Berisi informasi tentang instruktur yang mengajar pada suatu jadwal kelas
- member: Berisi informasi tentang daftar member yang memiliki membership di FIT HUB (tabel tambahan, tidak diisi)
- schedule_attendants: Berisi informasi tentang daftar member yang hadir dalam suatu jadwal kelas

Alasan saya memilih topik tersebut adalah agar dapat mengetahui variasi kelas yang diadakan di tiap cabang, kategori kelas yang sering diadakan di setiap cabang, lokasi dan jumlah cabang di setiap wilayah, waktu yang populer untuk mengadakan kelas, dan insight mengenai jadwal kelas lainnya. Dengan informasi tersebut, seseorang dapat lebih mudah menentukan lokasi cabang dan waktu yang tepat untuk mengikuti kelas tertentu. Selain itu, topik tersebut merupakan topik yang saya minati karena tempat ini merupakan tempat saya berolahraga. Informasi tentang jadwal kelas juga mudah didapatkan di situs resmi FIT HUB. Situs tersebut juga boleh ditelusuri oleh bot berdasarkan robots.txt situs.

## Program Requirements
1. Python 3.11.9
2. python-dotenv
3. selenium
4. mysql-connector-python
5. logging
6. MariaDB 11.3

Jalankan perintah berikut untuk menginstall semua dependencies:

```bash
pip install mysql-connector-python python-dotenv selenium requests beautifulsoup4 logging
```

Jika terdapat beberapa modul yang belum terinstall, install modul tersebut dengan menjalankan perintah:
```bash 
pip install <NAMA_MODUL>
```

## Cara Menggunakan Scraper
1. Clone repositori ini

2. Pada root folder, tambahkan file .env yang berisi variabel berikut:
```env
DB_HOST=localhost # Ganti dengan nama host pada perangkat Anda
DB_USER=root # Ganti dengan nama pengguna pada perangkat Anda
DB_PASSWORD=12345 # Ganti dengan password pada perangkat Anda
DB_DATABASE=fhbdg # Nama basis data default untuk menyimpan data scraping
```

3. Untuk melakukan scraping, jalankan ketiga perintah berikut pada root folder repositori ini:
```bash
python "./Data Scraping/src/branch_scraper.py"
```
```bash
python "./Data Scraping/src/class_scraper.py"
```
```bash
python "./Data Scraping/src/schedule_scraper.py"
```

4. Hasil scraping akan disimpan ke file JSON. Untuk menyimpan hasil output ke dalam DBMS, buatlah database terlebih dahulu di dalam MariaDB dan muatkan schema yang terdapat dalam ./Data Storing/src/schema.sql. Di dalam MariaDB, jalankan perintah-perintah berikut:
```
create database fhbdg;
```
```
use fhbdg;
```
```
source <ABSOLUTE_PATH_TO_SCHEMA.SQL_FILE>
```

5. Dalam root folder, jalankan perintah tersebut untuk menyimpan hasil output ke dalam DBMS:
```bash
python "./Data Storing/src/data_storer.py"
```                                                                           
6. Hasil output tersimpan dalam DBMS. Data dapat dilihat dengan menjalankan query pada DBMS:
```
SELECT * FROM schedule;
```           

## Penjelasan struktur file JSON

### File branches.json
File ini berisi data cabang FIT HUB di seluruh Indonesia. Data yang tersimpan pada file tersebut adalah nama cabang (branch_name), alamat cabang (address), dan wilayah cabang (region).

```json
[
    {
        "branch_name": "FIT HUB BendunganHilir",
        "address": "Jl. Bendungan Hilir No.10, RT.1/RW.4, Jakarta Pusat, Daerah KhususIbukota Jakarta 10210",
        "region": "Jakarta"
    },
    {
        "branch_name": "FIT HUB MenaraDuta",
        "address": "Jalan H. R. Rasuna Said No.Kav B/09, RT.5/RW.1, Kuningan, Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12910",
        "region": "Jakarta"
    },
    ...
]
```

### File classes.json
File ini berisi data kelas yang disediakan oleh FIT HUB. Data yang tersimpan pada file tersebut meliputi nama kelas, kategori kelas (Strength, Dance, Cardio, Mind & Body), tingkat kesusahan kelas, dan durasi kelas.

```json
[
    {
        "category": "STRENGTH",
        "class_name": "Hiit",
        "difficulty": "MODERATE",
        "duration": 60
    },
    {
        "category": "STRENGTH",
        "class_name": "Core",
        "difficulty": "MODERATE",
        "duration": 60
    },
    ...
]
```

### File schedule.json
File ini berisi data jadwal kelas yang diselenggarakan pada FIT HUB daerah Bandung. File tersebut mengelompokkan jadwal berdasarkan hari. Hari tersebut berkorespondensi dengan hari pada minggu ketika scraping dilakukan. Pada setiap hari, disimpan jadwal masing-masing kelas yang berisi waktu kelas, nama kelas, kategori, instruktur, cabang tempat penyelenggaraan kelas, tingkat kesusahan kelas, dan durasi kelas.

Dapat terlihat bahwa scraping informasi kelas dilakukan dua kali, yaitu pada classes.json dan schedule.json. Hal tersebut dilakukan karena terdapat beberapa kelas pada schedule.json yang tidak terdapat pada classes.json. Jika kelas tersebut sudah ada pada classes.json, data yang disimpan adalah data pada classes.json. Jika belum, data baru dari schedule.json akan tersimpan.

```json
{
    "Monday": [
        {
            "class_time": "08:00",
            "class_name": "Poundfit",
            "category": "Cardio",
            "instructor": "Gina",
            "branch_name": "FIT HUB BuahBatu",
            "difficulty": "MEDIUM",
            "duration": 60
        },
        {
            "class_time": "08:00",
            "class_name": "Poundfit",
            "category": "Cardio",
            "instructor": "Feby",
            "branch_name": "FIT HUB SuryaSumantri",
            "difficulty": "MEDIUM",
            "duration": 60
        },
        ...
    ],
    "Tuesday": [
        {
            "class_time": "08:00",
            "class_name": "Zumba",
            "category": "Mind & Body",
            "instructor": "Lia",
            "branch_name": "FIT HUB SuryaSumantri",
            "difficulty": "EASY",
            "duration": 60
        },
        {
            "class_time": "08:00",
            "class_name": "Zumba",
            "category": "Mind & Body",
            "instructor": "Restiany",
            "branch_name": "FIT HUB Lengkong",
            "difficulty": "EASY",
            "duration": 60
        },
    ],
    ...
}
```

## Struktur ERD dan Diagam Relasional RDBMS

### Struktur ERD
| ERD                                                                                                       |
| ----------------------------------------------------------------------------------------------------------|
| ![ERD](https://raw.githubusercontent.com/neokoda/Seleksi-2024-Tugas-1/main/Data%20Storing/design/erd.png) |

### Diagram Relasional
| Diagram Relasional                                                                                                       |
| -------------------------------------------------------------------------------------------------------------------------|
| ![Relational Diagram](https://raw.githubusercontent.com/neokoda/Seleksi-2024-Tugas-1/main/Data%20Storing/design/relational_diagram.png) |

## Proses Translasi ERD Menjadi Diagram Relasional
Pertama-tama, semua entitas dikonversi menjadi suatu tabel yang memiliki atribut yang sama dengan atribut pada entitas. Untuk entitas schedule yang merupakan weak entity, ditambahkan atribut branch_id dari identifying entity set-nya (entitas branch) primary key dari tabel schedule menjadi (branch_id, class_datetime).

Setelah itu, masing-masing relationship akan dikonversi menjadi bentuk relasional. Relationship branch-schedule merupakan identifying relationship dan sudah ditranslasikan ketika menambahkan atribut branch_id ke tabel schedule. Relationship schedule_instructor dan schedule_class dapat ditranslasikan dengan masing-masing menambahkan atribut instructor_id dan instructor_class ke tabel schedule (sisi many dari one-to-many). Relationship home_branch ditranslasikan dengan menambahkan atribut home_branch ke tabel member (sisi many dari one-to-many). Relationship schedule_attendants dapat ditranslasikan dengan menambahkan tabel schedule_attendants yang berisi primary key dari tabel schedule dan member (branch_id, class_datetime, member_id).

## Screenshot Program

### Schedule Scraper
| Schedule Scraper Source Code                                                                                                                       |
| ---------------------------------------------------------------------------------------------------------------------------------------------------|
| ![schedule-source-1](https://raw.githubusercontent.com/neokoda/Seleksi-2024-Tugas-1/main/Data%20Scraping/screenshot/schedule_scraper/source-1.png) |
| ![schedule-source-2](https://raw.githubusercontent.com/neokoda/Seleksi-2024-Tugas-1/main/Data%20Scraping/screenshot/schedule_scraper/source-2.png) |
| ![schedule-source-3](https://raw.githubusercontent.com/neokoda/Seleksi-2024-Tugas-1/main/Data%20Scraping/screenshot/schedule_scraper/source-3.png) |


| Schedule Scraper Output Log                                                                                                                          |
| -----------------------------------------------------------------------------------------------------------------------------------------------------|
| ![schedule-output-log](https://raw.githubusercontent.com/neokoda/Seleksi-2024-Tugas-1/main/Data%20Scraping/screenshot/schedule_scraper/output-log.png) |

### Schedule Table
| Schedule Table                                                                                                                  |
| --------------------------------------------------------------------------------------------------------------------------------|
| ![schedule-table-1](https://raw.githubusercontent.com/neokoda/Seleksi-2024-Tugas-1/main/Data%20Storing/screenshot/schedule-1.png) |
| ![schedule-table-2](https://raw.githubusercontent.com/neokoda/Seleksi-2024-Tugas-1/main/Data%20Storing/screenshot/schedule-2.png) |

## Referensi
- [FIT HUB Official Website](https://fithub.id/)
- [FIT HUB Class Schedules](https://schedules.fithub.id/)
- [Selenium Unofficial Docs](https://selenium-python.readthedocs.io/)

<h1 align="center">
  <br>
  Seleksi Asisten Basdat 2024 <br>
  ETL Project
  <br>
  <br>
</h1>

<h3 align="left">
  <br>
  Angelica Kierra Ninta Gurning - 13522048
  <br>
</h3>

# Deskripsi Singkat
## Data dan Database
Database yang dibuat merupakan data yang berisi <b>Top 100 Drama Korea</b> yang merupakan hasil dari <i>web scraping</i>. Data berisi komponen pembentuk suatu drama korea, seperti judul, tanggal tayang, rating, genre, penulis, sutradara,jumlah penonton, durasi tiap episode, dan deskripsi dari drama itu sendiri

Drama korea telah mendominasi industri <i>entertainment</i> dalam beberapa waktu kebelakang sehingga data-data yang diperoleh dapat digunakan untuk analisis bisnis. Data-data yang disajikan juga berguna untuk memahami tren pasar dan juga apa yang disukai oleh penggemar sehingga dapat membantu industri dalam menyesuaikan drama yang ditawarkan

# Cara Menggunakan Scraper
## Dependencies
1. Memiliki Python 3.10.5
2. Meng-<i>install dependecies</i>yang digunakan
```bash
pip install -r requirements.txt

```
3. Apabila gagal menggunakan file txt, lakukan secara manual
```bash
pip install beautifulsoup4
pip install dash
pip install mysql-connector-repackaged
pip install pandas
pip install plotly
pip install python-dotenv
pip install requests

```
## Menjalankan Program
1. Setelah meng-<i>install dependecies</i>yang digunakan, pastikan berada di folder Data Scraping/src
```bash
cd Data Scraping
cd src
```
2. Jalankan program dengan cara:
```bash
python data_scraper.py
```
3. Apabila program telah selesai dijalankan, maka terdapat file 'korean_dramas.json', namun data tersebut masih belum bersih

4. Untuk melakukan <i>cleaning</i> data, jalankan data_clean.py (pastikan berada di folder Data Scraping/src)
```bash
python data_clean.py
```
Berikut merupakan <i>data cleaning</i> yang dilakukan:
1. **Mengganti Nilai `None`**
   - Semua nilai `None` dalam data diganti dengan `'unknown'`.

2. **Membersihkan Data Director dan Screenwriter**
   - Memisahkan nama-nama dalam field `Director` dan `Screenwriter` yang dipisahkan koma menjadi list nama.

3. **Membersihkan Original Network**
   - Mengubah nama field dari `Original Network` menjadi `Original_Network` dan memisahkan nama-nama jaringan yang dipisahkan koma menjadi list.

4. **Menentukan Tahun**
   - Mengekstrak tahun dari field `Drama_year`. Jika tidak ada, mengganti dengan `'unknown'`.

5. **Mengkonversi Durasi**
   - Mengubah durasi dari format `X hr Y min` atau `Y min` ke dalam menit total.

6. **Mengkonversi Jumlah Penonton**
   - Menghapus koma dalam jumlah penonton dan mengubahnya menjadi integer.

7. **Mengekstrak Tanggal Mulai dan Akhir**
   - Mengambil tanggal mulai dan akhir dari field `Aired`, kemudian mengubahnya ke format `YYYY-MM-DD`.

8. **Mengkonversi Jumlah Episode**
   - Mengubah jumlah episode menjadi integer jika ada.

9. **Mengkonversi Rating**
   - Mengubah rating menjadi float jika ada.

10. **Mengganti Nilai `'unknown'`**
    - Setelah membersihkan data, mengganti semua nilai `'unknown'` dengan list yang berisi `'unknown'`.


# Struktur JSON
### Contoh JSON

```json
{
    "Drama_title": "Move to Heaven",
    "Drama_year": 2021,
    "Drama_Rating": 9.1,
    "Description": "Han Geu Roo is an autistic 20-year-old. He works for his father\u2019s business \u201cMove To Heaven,\u201d a company that specializes in crime scene cleanup, where they also collect and arrange items left by deceased people,\u2026",
    "Screenwriter": [
        "Yoon Ji Ryun"
    ],
    "Director": [
        "Kim Sung Ho"
    ],
    "Episodes": 10,
    "Duration": 52,
    "Watchers": 99403,
    "Genre": [
        "Life",
        "Drama"
    ],
    "Original_Network": [
        "Netflix"
    ],
    "Start_date": "2021-05-14",
    "End_date": "2021-05-14"
}
```
### Penggambaran Format JSON

| **Field**         | **Tipe**            | **Deskripsi**                                            |
|-------------------|----------------------|----------------------------------------------------------|
| `Drama_title`     | String               | Judul drama                                             |
| `Drama_year`      | Integer              | Tahun rilis drama                                      |
| `Drama_Rating`    | Float                | Rating drama                                           |
| `Description`     | String               | Deskripsi singkat tentang drama                        |
| `Screenwriter`    | Array of Strings     | Daftar penulis drama                                |
| `Director`        | Array of Strings     | Daftar sutradara.                                       |
| `Episodes`        | Integer              | Jumlah episode dalam drama                             |
| `Duration`        | Integer              | Durasi per episode dalam menit.                         |
| `Watchers`        | Integer              | Jumlah penonton drama                                  |
| `Genre`           | Array of Strings     | Daftar genre drama                                     |
| `Original_Network`| Array of Strings     | Daftar jaringan tempat drama ditayangkan.               |
| `Start_date`      | String (Format: YYYY-MM-DD) | Tanggal mulai tayang drama                         |
| `End_date`        | String (Format: YYYY-MM-DD) | Tanggal akhir tayang drama                          |

# Struktur ERD dan Diagram Relasional
## ERD
### Entitas
1. Crew : menyimpan data Screenwriter,director,actor
- name : nama crew
- date_of_birth : tanggal lahir
- gender : perempuan atau laki-laki
2. Screenwriter : spesialisasi dari Crew
- pen_name : nama alias saat menulis
3. Director : spesialisasi dari Crew
- signature_genre : genre yang biasa digarap
4. Actor : spesialisasi dari Crew
- stage_name : nama alias saat akting
5. Drama : entitas utama drama (penjelasan attribut sama seperti di JSON)
6. Agency : perusahaan agen aktor
- agency_id : id perusahaan
- name : nama
- ceo : nama ceo
- founded_year : tahun berdiri
- address : alamat
7. Character : karakter dalam drama
- character_id : id karakter
- name : nama
- peran : figuran atau utama
- backstory : latar belakang karakter
8. Episode (weak entity) : episode pada suatu drama
- episode_number : nomor episode
- title : judul
- rating
9. Award : penghargaan drama
- award_id
- name : nama
- country : penyelenggara

### Hubungan
1. Hubungan is A : spesialisasi Crew menjadi Screenwriter, Director, Aktor
2. wrote : many to many antara Screenwriter dan Drama dengan Drama full participation
3. directed : many to many Director dan Drama dengan Drama full participation
4. acted : many to many Actor dan Drama dengan Drama full participation
5. join : many to one Actor dan Agency dengan Actor full participation
6. wins : many to many Award dan Drama dengan attribut tambahan year, category dengan Drama full participation
7. appears : many to many antar agregat Actor-Drama dan Character, dengan keduanya full participation
8. has : hubungan one to many Drama dengan weak entity Episode

## Relasional
### Daftar Tabel
1. Crew
- name VARCHAR(255) : PRIMARY KEY
- date_of_birth DATE
- gender ENUM {"Female,"Male}
2. Screenwriter
- screenwriter_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke tabel Crew(name)
- pen_name VARCHAR(255)
3. Director
- director_name VARCHAR(255) : PRIMARY KEY , FOREIGN KEY ke tabel Crew(name)
- signature_genre VARCHAR(255)
4. Actor
- actor_name VARCHAR(255) : PRIMARY KEY , FOREIGN KEY ke tabel Crew(name)
- stage_name VARCHAR(255)
- agency_id INT : FOREIGN KEY ke table Agency(agency_id)
5. Agency
- agency_id INT AUTO INCREMENT : PRIMARY KEY
- name VARCHAR(255)
- ceo VARCHAR(255)
- founded_year INT
- address VARCHAR(255)
6. Wrote
- screenwriter_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Screenwriter(screenwriter_name)
- drama_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Drama(drama_name)
7. Directed
- director_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Director(director_name)
- drama_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Drama(drama_name)
8. Acted
- actor_name VARCHAR(255) : PRIMARY KEY,
FOREIGN KEY ke Actor(actor_name)
- drama_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Drama(drama_name)
- character_id INT : PRIMATY KEY, FOREIGN KEY ke Character(character_id)
9. Character
- character_id INT AUTO INCREMENT : PRIMARY KEY
- name VARCHAR(255)
- role ENUM {"Main","Side"}
- backstory VARCHAR(255)
10. Network
- network_name VARCHAR(255) : PRIMARY KEY
- drama_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Drama(drama_name)
11. Genre
- genre_name VARCHAR(255) : PRIMARY KEY
- drama_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Drama(drama_name)
12. Drama
- drama_name VARCHAR(255) : PRIMARY KEY
- year INT
- rating FLOAT
- description TEXT
- episodes INT
- duration INT
- watchers INT
- start_date DATE
- end_date DATE
13. Wins
- award_id INT : PRIMARY KEY ,FOREIGN KEY ke Award(award_id)
- drama_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Drama(drama_name)
- year INT
- category VARCHAR(255)
14. Award
- award_id INT AUTO INCREMENT : PRIMARY KEY
- name VARCHAR(255)
- year INT
- country VARCHAR(255)
15. Episode
- drama_name VARCHAR(255) : PRIMARY KEY, FOREIGN KEY ke Drama(drama_name)
- episode_number INT : PRIMARY KEY
- rating FLOAT
- title VARCHAR(255)

# Proses translasi ERD - Relasional
1. <b>Entitas biasa menjadi tabel</b>
Entitas Crew, Drama,Agency,Character,Award menjadi satu tabel pada database relasional
2. <b>Weak Entity</b>
Episode menjadi table dan ditambahkan foreign key attribute ke drama_name karena merupakan weak entity dan relasi one to many
3. <b>Spesialisasi</b>
Screenwriter, Director, dan Actor menjadi 3 tabel berbeda dengan tambahan attribute 'name' yang merupakan foreign key ke tabel Creq
4. <b>Hubungan many to many</b>
Hubungan wrote, directed, acted menjadi sebuah tabel baru dengan primary key komposit yang merupakan primary key dari kedua tabel terkait
5. <b>Hubungan one to many</b>
Hubungan join tidak menjadi tabel sendiri namun ditambahkan attribut agency_id pada tabel Actor
6. <b>Hubungan agregat</b>
Menjadi satu tabel dengan primary key komposit ketiga tabel terkait
7. <b>Hubungan dengan attribut</b>
Hubungan wins menjadi satu tabel dengan tambahan attribut year dan kategori

# Bonus
## Visualisasi data
### Teknis
Visualisasi data dilakukan dengan menggunakan <i>libary</i> Dash. Data akan ditampilkan dalam bentuk bar graph. Data yang akan ditampilkan melainkan:
1. Top 10 Drama Korea (berdasarkan rating)
2. Top 5 Drama Korea berdasarkan genre (dihitung dengan rating) , pengguna dapat memilih genre yang ditampilkan
3. Top 5 Network Drama Korea 
4. Top 5 Director Drama Korea
5. Top 5 Screenwriter Drama Korea
6. Top 5 Genre Drama Korea

### Cara menjalankan
1. Pastikan berasa pada folder  "/Data Visualisasi/src
```bash
cd Data Visualisasi
cd src
```
2. Jalankan program dengan cara:
```bash
python visualization.py
```
3. Masuk ke local host link
```bash
http://127.0.0.1:8050/
```
# Screenshot
## Data Scraping
![scrape basdat](https://github.com/user-attachments/assets/a1c73dc0-6ce0-494a-a2ab-ec3c91c1f825)


## Data Storing
![drama-1](https://github.com/user-attachments/assets/047eb61b-eb2c-456d-8cc8-3da25e10b69a)
![drama-2](https://github.com/user-attachments/assets/72f6ef82-c94d-4eb8-82ee-984cdc904704)

## Data Visualization
![visualization-1](https://github.com/user-attachments/assets/49c6fc8e-85e4-4383-a793-f03d93a66318)
![visualization-2](https://github.com/user-attachments/assets/49caaf69-72fd-4985-b598-0ff24142a759)

# Referensi
1. Website Scraping: 
2. Library yang digunakan :
- beautifulsoup4, version 4.12.3
- dash, version 2.17.1
- mysql_connector_repackaged, version 0.3.1
- pandas, version 1.5.1
- plotly, version 5.23.0
- python-dotenv, version 1.0.1
- Requests, version 2.32.3




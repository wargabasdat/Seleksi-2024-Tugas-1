# SELEKSI ASISTEN BASIS DATA 2024
Clement Nathanael Lim / 18222032

## TOP 100 DISNEY MOVIES ON DISNEYPLUS BY ROTTENTOMATOES
Data Top 100 Disney Movies dari Rottentomatoes merupakan suatu list berisi 100 film Disney terbaik yang ada di DisneyPlus berdasarkan hasil review dari para criticus dan audience yang terdaftar di Rottentomatoes. List ini dirilis dan diperbaharui setiap bulan, dan versi yang dihasilkan diupdate terakhir pada awal bulan Agustus 2024. List ini menampilkan nama film, tahun perilisan, artis yang memainkan, serta sutradara yang men-direct list tersebut.

Alasan saya memilih topik ini adalah: <br>
- Sebagai acuan ketika ingin menonton film dari Disneyplus; <br>
- Visualisasi data yang memadai yang sekiranya dapat memprediksi film mana yang masuk ke dalam list tersebut; <br>
- Data yang cukup akurat untuk membantu menganalisis film Disney kedepannya. <br>

## CARA MENGGUNAKAN SCRAPER & STRUKTUR JSON
Clone repository ini dengan command
```shell
Git clone https://github.com/clementnathanael/TUGAS_SELEKSI_2_18222032.git
```
Ubah directory 
```shell
cd Data Scraping/src
```
Run the scrapper with the command 
```shell
python3 Scrap.py
```

Output dari scraper ini adalah json file yang berisi data rank, nama film, tahun, rating, artis yang memainkan film tersebut, serta sutradara dari film tersebut. Untuk memudahkan pencarian, saya hanya menggunakan 1 nama orang saja di tabel artis dan sutradara. Saya juga menggunakan converter dari JSON ke NDJSON agar format json dapat dimasukkan ke dalam PostgreSQL. Hasil dari data scraping yang dibuat akan ditampilkan di dalam tabel Disney_Dashboard_Rating. 

## STRUKTUR ERD DAN DIAGRAM RELASIONAL DBMS
Pada ERD, terdiri atas 9 entitas yang menggambarkan data tersebut: <br>
- Movies_Rottentomatoes : moviert_id, moviert_name, rating, release_year, duration, synopsis, {genre} <br>
- Movies_Disneyplus : moviedp_id, moviedp_name, age_rating, release_year, season, synopsis, duration, {genre}, {language} <br>
- Disney_Dashboard_Rating : rank, movie_name, score, year, artist, director <br>
- Actor : actor_id, actor_name, actor_bod, highest_rating, movie_highest_rating, lowest_rating, movie_lowest_rating <br>
- Director : director_id, director_name, director_bod, highest_rating, movie_highest_rating, lowest_rating, movie_lowest_rating <br>
- Rating : rating_id, score, review <br>
- Users: email, password, date_birth_user, username, status <br>
- Criticus : criticus_give_review, tomato_score <br>
- Audience : audience_give_review, audience_score <br>

ERD tersebut dibuat dengan asumsi : <br>
- Terdapat suatu database yang berisi semua film yang berada di DisneyPlus, sehingga ketika terdapat film ditambahkan di DisneyPlus, akan otomatis ditambahkan ke dalam database RottenTomatoes. <br>
- User yang terdapat di dalam RottenTomatoes, dibagi menjadi 2, yakni criticus dan audience. Criticus merupakan orang yang sudah lebih profesional dalam melakukan review, dan dapat menentukan nilai Tomatometer. Audience merupakan orang biasa yang dapat memberikan review berupa nilai antara 1 sampai 5. Setiap kali melakukan review dan memberikan score, review dan score akan terdapat suatu rating_id yang unik. Tabel rating bisa terdiri atas rating audience maupun criticus (sama seperti di Rottentomatoes). <br>
- Data yang dihasilkan dari proses scraping ditaruh pada tabel Disney_Dashboard_Rating, yang sudah berisi gabungan dari ranking film tersebut, nama film, score Tomatometer, tahun rilis film tersebut, sutradara, dan aktor yang memainkan film tersebut. Untuk director dan artist yang memainkan hanya terdapat 1 nama untuk memudahkan pencarian. <br>
- Setiap criticus dapat menentukan apakah film tersebut fresh / rotten, yang merupakan isi dari tomato_score. Penentuan nilai tomatometer untuk setiap film ditentukan berdasarkan total kritik, dan sebagainya. <br>
- Disebabkan dashboard tersebut cukup sering diakses, maka saya membuat relasi sendiri (seperti materialized view) yang datanya diambil dari hasil proses scraping yang dilakukan. Hal tersebut disebabkan karena untuk melakukan proses query satu per satu tidaklah efisien dan mahal, sehingga ada baiknya untuk menambahkan relasi sendiri yang dapat memuat data dashboard yang dihasilkan dari proses scraping. <br>


Pemetaan dari ERD ke diagram relasional menghasilkan 16 tabel / relasi, yakni: <br>
- Movies_Disneyplus : moviedp_id, moviedp_name, age_rating, release_year, season, synopsis, duration, moviert_id <br>
- Users: email, password, date_birth_user, username, status <br>
- MovieDP_genre : moviedp_id, genre <br>
- MovieDP_language : moviedp_id, language <br>
- User_criticus : email, criticus_give_review, tomato_score <br>
- User_audience : email, audience_give_review, audience_score <br>
- Rating : rating_id, score, review <br>
- Giving_rate = rating_id, email, movie_id <br>
- Disney_Dashboard_Rating : rank, movie_name, score, year, artist, director <br>
- Movie_dashboard : moviert_id, rank <br>
- Movies_Rottentomatoes : moviert_id, moviert_name, rating, release_year, duration, synopsis <br>
- MovieRT_Genre : moviert_id, genre <br>
- Actor : actor_id, actor_name, actor_bod, highest_rating, movie_highest_rating, lowest_rating, movie_lowest_rating <br>
- Movie_actor : moviert_id, actor_id <br>
- Director : director_id, director_name, director_bod, highest_rating, movie_highest_rating, lowest_rating, movie_lowest_rating <br>
- Movie_director : moviert_id, director_id <br>

Untuk lebih lengkapnya, dapat melihat dari folder Data Storing.

Proses translasi dari ERD ke relasional mengikuti seperti yang diajarkan dari perkuliahan Basis Data, antara lain: <br>
- Strong entity dibuat relasi dengan attributenya masing-masing. <br>
- Multivalued attribute dibuat relasi terpisah dengan attribute primary key dan nilai attribute yang multivalued. <br>
- Many-to-many relationship dibuat relasi baru dengan atribut kedua primary key dari masing-masing relasi. <br>
- Many-to-one relationship dapat direpresentasikan dengan menambahkan primary key sisi "one" ke relasi "many" <br>
- Ternary relationship dibuat dengan menambahkan relasi baru yang berisi primary key dari masing-masing relasi ternary. <br>

## SCREENSHOT PROGRAM

## REFERENSI
- BeautifulSoup4
- Python3
- PostgreSQL
- [JSON to NDJSON Converter](https://konbert.com/convert/ndjson/to/json)
- [The 100 Best Movies on Disney+ (August 2024)](https://editorial.rottentomatoes.com/guide/best-disney-movies-to-watch-now/)












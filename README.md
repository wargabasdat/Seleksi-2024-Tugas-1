<h1 align="center">
  <br>
  Lab Basis Data Recruitment 2024
  <br>
  <br>
</h1>

<h2 align="center">
  <br>
  Regular Season IBL 2023/2024
  <br>
  <br>
</h2>

## Deskripsi Data dan DBMS yang dipilih
#### Data
Pada proyek ini, *scraping* dilakukan terhadap website Indonesian Basketball League (IBL) yaitu pada laman https://iblindonesia.com/, khususnya untuk **regular season IBL season 2023/2024**. Data yang diambil meliputi **nama tim**, **team info**, **jumlah pertandingan**, **statistik pertandingan**, **statistik pemain**, **klasemen regular season**, **total poin**, **official**, dan **venue**. Data ini bertujuan untuk memberikan gambaran yang komprehensif mengenai performa tim-tim yang bertanding di IBL, sehingga dapat dimanfaatkan oleh manajemen tim, pelatih, pemain, serta penggemar untuk melakukan analisis performa dan strategi pengembangan ke depan.

Saya memilih topik basket IBL karena memiliki ketertarikan pribadi terhadap olahraga basket dan liga IBL khususnya. Data yang dikumpulkan dari regular season IBL season 2023/2024 dapat memberikan wawasan berharga mengenai performa setiap tim, yang nantinya bisa digunakan sebagai bahan evaluasi untuk menghadapi season berikutnya. Dengan menganalisis data seperti statistik pemain, jumlah kemenangan, kekalahan, persentase kemenangan, dan posisi peringkat, tim-tim dapat memahami kekuatan dan kelemahan mereka, serta merencanakan strategi yang lebih baik untuk meningkatkan performa di masa mendatang.


#### DBMS
Pada proyek ini, data-data yang diperoleh dari hasil scraping akan diolah dan disimpan dalam sebuah basis data menggunakan **DBMS PostgreSQL**. PostgreSQL dipilih karena beberapa alasan yang sangat menguntungkan, seperti mudah digunakan dan *user-friendly*. Dengan memilih PostgreSQL, diharapkan proses pengelolaan data dalam proyek ini dapat berjalan dengan efisien dan efektif, mendukung analisis data pada proyek ini.


## Spesifikasi Program
#### Data Scraping




#### Data Storing
Proses penyimpanan data dilakukan pada proyek ini dengan memasukkan data hasil _scraping_ ke dalam RDBMS sesuai dengan desain ERD dan diagram relasional yang telah dibuat. RDBMS yang dihasilkan terdiri dari delapan relasi, yaitu `team`, `team_standings`, `venue`, `player_stats`, dan `info`. Relasi `player`, `player_stats`, `team`, `team_standings`, `venue`, `match_stats`, dan `official` yang diambil dari hasil _scraping_ telah dimasukkan ke dalam sistem. Sementara itu, relasi `official_phone`, yang merupakan pengembangan dari ERD, belum memiliki data di dalamnya, tetapi telah diatur dengan _constraint_ yang sesuai..

## How to use

## Melakukan *Scraping* Data
1. Lakukan *clone repository*
```sh
  $ git clone https://github.com/rickywijayaaa/TUGAS_SELEKSI_2_18222043.git
```
2. Buka folder hasil *clone*
```sh
  $ cd TUGAS_SELEKSI_2_18222043
```
3. buka "Data Scraping" dan src folder
```sh
  $ cd "Data Scraping"
  $ cd src
```
4. Jalankan scraping program code
```sh
  $ scraping_ibl_18222043.ipynb
```
## Untuk menggunakan database yang sudah ada
1. Lakukan *clone repository*
```sh
  $ git clone https://github.com/rickywijayaaa/TUGAS_SELEKSI_2_18222043.git
```
2. Buka folder hasil *clone*
```sh
  $ cd TUGAS_SELEKSI_2_18222043
```
3. Menuju Data Storing > Export
```sh
  $ download ibl_data.sql
```
4. Buka postgreSQL dan masukkan password
```sh
  $ psql -U <username>;
```
5. Buat *database*
```sh
  $ CREATE DATABASE {nama database};
```
6. import file sql dengan
```sh
  $ psql -U {username} -d {nama database} < ibl_data.sql
```

## JSON Structure
Data hasil _scraping_ disimpan dalam format `JSON`, yaitu pada folder `Data Scraping` > data. Struktur dari `file` JSON tersebut adalah sebagai berikut. Sebagai contoh, salah satu _file_ yang disimpan adalah `player_stats.json`, yang menunjukkan statistik pemain.
```
[
    {
        "Player": "Stevan Wilfredo Neno",
        "Game Played": "12",
        "Minutes per game": "257:36",
        "Field Goal Percentage": "29.6",
        "3 Points Percentage": "24.6",
        "2 Points Percentage": "45.0",
        "Free Throw Percentage": "64",
        "Rebounds per game": "1.67",
        "Assists per game": "2.75",
        "Blocks per game": "0.17",
        "Steals per game": "0.58",
        "Points per game": "5.83"
    },
    {
        "Player": "Gunawan Gunawan",
        "Game Played": "14",
        "Minutes per game": "157:13",
        "Field Goal Percentage": "21.8",
        "3 Points Percentage": "21.4",
        "2 Points Percentage": "23.1",
        "Free Throw Percentage": "67",
        "Rebounds per game": "1.07",
        "Assists per game": "0.29",
        "Blocks per game": "0",
        "Steals per game": "0.21",
        "Points per game": "2.79"
    },
  {
```

Struktur `JSON` tersebut dibuat dengan format judul:value, di mana setiap entri terdiri dari pasangan judul dan nilai. Format ini memastikan bahwa data tersusun secara terorganisir, dengan setiap judul mewakili kolom dan nilai yang sesuai dengan entri di dalam baris.
## Database Structure
#### ERD (Entity Relationship Diagram)
<div align="center">
<img src="Data Storing/design/ERD IBL.png" alt="ERD IBL" width="500">
</div>

Dari gambar tersebut dapat dilihat terdapat 6 *entity* dan terdapat 2 *entity* sebagai *weak entity*. ERD tersebut dirancang dengan asumsi bahwa setiap pemain hanya dapat berada pada satu tim, selain itu setiap *official* juga hanya dapat berada pada satu tim, dan yang terakhir setiap tim hanya bisa memiliki satu buah venue yang ditetapkan sebagai markas/kandang.

#### Diagram Relasional
<div align="center">
<img src="Data Storing/design/Diagram Relasional IBL.png" alt="Relasional Diagram IBL" width="500">
</div>

Dari hasil perancangan ERD yang telah dibuat maka dilakukan transformasi ke diagram relasional, dapat dilihat hasil transformasi tersebut menghasilkan 8 relasi dengan *foreign key* dan *primary key* yang dapat dilihat pada gambar.

## Transformasi dari ERD ke Diagram Relasional
Transformasi dari ERD ke diagram relasional melibatkan beberapa tahap yang dilakukan sebagai berikut : 
1. __one-to-many relationship__
   Pada ERD, _relationship_ `terdapat` antara _entity official_ dengan _team_ berjenis _one-to-many_, selain itu `terdapat` antara _entity pemain_ dengan _team_. Untuk itu, proses translasi yang dilakukan adalah menambahkan __primary key__ _entity one_ pada relasi _entity many_. Maka atribut Name dari relasi team ditambahkan pada relasi pemain.
<div align="center">
<img src="Data Storing/design/translasi one-to-many.png" alt="Translasi 1" width="350">
</div>

2. __one-to-one relationship__
   Dari ERD, relationship one-to-one terdapat pada entitas`venue` dengan `team`. Untuk itu, proses translasi yang dilakukan adalah menambahkan primary key pada relasi pasangannya dengan membebaskan primary key milik siapa yang ingin ditambahkan di antara keduanya. Namun, apabila terdapat relasi yang memiliki kardinalitas total dan parsial, maka primary key parsial ditambahkan ke relasi dengan kardinalitas total. Karena relationship antara venue dan team memiliki kardinalitas total, maka dibebaskan. Namun, saya memilih untuk menambahkan primary key `team` ke `venue`.
<div align="center">
  <img src="Data Storing/design/translasi one-to-one.png" alt="Translasi 2" width="350"/>
</div>

3. __weak entity__
   Pada ERD tersebut terdapat 2 weak entity yaitu `pemain_statistik` dengan  `pemain` dan `team_standings` dengan `team`. Proses translasi dilakukan dengan menambahkan primary key *strong entity* ke dalam relasi weak entity. Primary key dari relasi tersebut ialah gabungan antara primary key strong entity dengan diskriminator dari weak entity tersebut.

   Dalam kasus ini, contoh pada `pemain_statistik` akan mendapatkan atribut `name` dari relasi `pemain` dengan primary key nya ialah (name, team_name) karena team_name ialah diskriminator pada `pemain_statistik`.
<div align="center">
  <img src="Data Storing/design/translasi weak entity.png" alt="Translasi 2" width="350"/>
</div>

4. __multivalue variable__
   Dalam entity `official` terdapat **multivalue variable** yaitu pada atribut `phone_number`. Oleh karena itu, tranlasi dilakukan dengan membuat relasi baru yang berisi primary key dan attribute tersebut dengan primary key dari relasi tersebut ialah gabungan keduanya. Dalam kasus ini, akan dibuat relasi `official_phone` dengan primary key **(name,phone_number)**
<div align="center">
  <img src="Data Storing/design/translasi multivalue variable.png" alt="Translasi 2" width="350"/>
</div>

5. __unary relationship__
   Pada ERD, entitas `team` memiliki relasi `bertanding` yang merupakan **many-to-many relationship**. Proses translasi dilakukan dengan membuat relasi baru yang berisi primary key dari entitas tersebut. Karena ini adalah relasi unary, relasi baru akan berisi dua primary key dari entitas yang sama dengan nama atribut yang berbeda. Dalam kasus ini, relasi `bertanding` diubah menjadi relasi `match_stats` dengan primary key (Home_team, Away_team), yang merupakan foreign key ke relasi `team`.
<div align="center">
  <img src="Data Storing/design/translasi unary relationship.png" alt="Translasi 2" width="350"/>
</div>

Setelah pemetaan ERD IBL, didapatkan hasil diagram relasional sebagai berikut : 
<div align="center">
  <img src="Data Storing/design/Diagram Relasional IBL.png" alt="Translasi 2" width="500"/>
</div>

## Screenshot program

Berikut adalah screenshot program scraping data IBL saya beserta penjelasannya.

#### Website yang digunakan:
<div align="center">
  <a href="https://iblindonesia.com/">
    <img src="Data Scraping/screenshot/website.jpg" alt="Webometrics" width="600">
  </a>
</div>

#### Penjelasan Code Data scraping :

1. Mengambil statistik pemain IBL
Indonesian Basketball League (IBL) merupakan liga basket professional di Indonesia yang mewadahi 14 tim dengan 200-an pemain untuk berkompetisi. Untuk mengambil data statistik pemain tersebut, perlu dilakukan click *profile button* > *Statistics* pada setiap tim. Oleh karena itu, scraping dilakukan dengan meng-*click profile* dan *statistik button* terlebih dahulu pada setiap tim dan datanya diambil

<div align="center">
  <img src="Data Scraping/screenshot/player_stats_code.jpg" width="400"/>
</div>

2. Mengambil info pemain IBL
Untuk mengambil data informasi dari setiap pemain IBL, halaman harus melakukan *click button* pada *profile* dan *click* pada *roster*. Setelah itu, detail data dari setiap pemain IBL didapatkan, termasuk tinggi badan, nomor punggung, dan posisi. Code scraping dibuat untuk mengklik setiap profil untuk setiap tim pada halaman tersebut, sehingga seluruh data pemain IBL dapat diperoleh.

<div align="center">
  <img src="Data Scraping/screenshot/player_info_code.jpg" width="400"/>
</div>

3. Mengambil data venue team IBL
Saya menggunakan sumber bantuan untuk mengambil data venue, yaitu wikipedia. Scrape dilakukan dengan mencari table yang berisi data venua dan kemudian data tersebut disimpan dalam array

<div align="center">
  <img src="Data Scraping/screenshot/venue_code.jpg" width="400"/>
</div>

4. Mengambil data team standings IBL
Pada website IBL, terdapat data tim pada halaman *Game* > *Standings*. Proses pengambilan data dilakukan dengan mengiterasi setiap *team*, mengambil data yang diperlukan, dan memasukkannya ke dalam array. Data yang diambil mencakup informasi **klasemen regular season IBL 2023/2024** yang kemudian untuk analisis lebih lanjut. Dengan cara ini, seluruh informasi tim dapat diakses dan diorganisir secara efisien.

<div align="center">
  <img src="Data Scraping/screenshot/team_stats_code.jpg" width="400"/>
</div>

5. Mengambil data match pertandingan IBL Season 2023/2024
Pada website IBL, data pertandingan terdapat pada halaman *Schedule*. Namun, data tersebut disimpan per-hari, sehingga diperlukan iterasi untuk setiap hari. Regular season IBL berlangsung dari 13 Januari 2024 sampai 07 Juli 2024, sehingga diperlukan pengambilan data secara harian dalam rentang tanggal tersebut. HTML input pada tanggal tersebut dilakukan setiap hari, dan data yang diambil mencakup skor tim tuan rumah (home score), skor tim tamu (away score), lokasi pertandingan (venue), dan tanggal pertandingan (date). Dengan melakukan iterasi harian pada rentang waktu yang telah ditentukan, seluruh data pertandingan dapat dikumpulkan secara lengkap. Informasi ini kemudian dapat digunakan untuk berbagai analisis, seperti performa tim, statistik satu season, dan lainnya. Pendekatan ini memastikan bahwa semua data pertandingan dari regular season IBL terdokumentasi dengan baik.

<div align="center">
  <img src="Data Scraping/screenshot/match_stats_code.jpg" width="400"/>
</div>

6. Meng-*export* data yang sudah di-*scrape* ke JSON
Setelah semua data yang diperlukan maka data di *export* dengan JSON format

<div align="center">
  <img src="Data Scraping/screenshot/export_JSON_code.jpg" width="400"/>
</div>

#### Penjelasan Data Storing :

Setelah itu, data yang sudah diambil dibuat ke dalam database postgreSQL, berikut detail dari setiap table : 

<div align="center">
  <img src="Data Storing/screenshot/match_stats_screenshot.jpg" width="375"/>
</div>
<div align="center">
  <img src="Data Storing/screenshot/player_screenshot.jpg" width="375"/>
</div>
<div align="center">
  <img src="Data Storing/screenshot/player_stats_screenshot.jpg" width="375"/>
</div>
<div align="center">
  <img src="Data Storing/screenshot/team_screenshot.jpg" width="375"/>
</div>
<div align="center">
  <img src="Data Storing/screenshot/team_standings_screenshot.jpg" width="375"/>
</div>
<div align="center">
  <img src="Data Storing/screenshot/venue_screenshot.jpg" width="375"/>
</div>
<div align="center">
  <img src="Data Storing/screenshot/official_screenshot.jpg" width="375"/>
</div>



## Data Visualization
### Hasil visualisasi

Dilakukan beberapa visualisasi data hasil analisis untuk mengambil *insight* dari **Regular Season IBL 2023/2024** yang dapat berguna untuk bahan evaluasi bagi pihak tim, manajemen, maupun IBL itu sendiri untuk meningkatkan mutu kompetisi kedepannya.

### 1. Rata-rata *point per game* dari setiap posisi
<div align="center">
  <img src="Data Visualization/Visualization 6.jpg" width="475"/>
</div>

Insight dari visualisasi tersebut menunjukkan bahwa posisi **Forward / Guard** memiliki PPG (points per game) tertinggi. Posisi ini diikuti oleh **Small Forward** dan **Guard** yang berada di peringkat kedua dan ketiga. Temuan ini memberikan pembelajaran penting bagi tim, yaitu bahwa posisi `Guard` sangat berbahaya dan efektif dalam mencetak poin. Memahami tren ini dapat membantu tim dalam menyusun strategi defensif yang lebih baik dan mengidentifikasi pemain kunci yang perlu diwaspadai selama pertandingan. Insight ini juga bisa menjadi dasar untuk pengembangan pemain di posisi tersebut agar dapat memaksimalkan potensi mereka dalam mencetak poin.

### 2. Distribusi *player* dari setiap posisi
<div align="center">
  <img src="Data Visualization/Visualization 5.jpg" width="475"/>
</div>

Insight : Dari hasil analisis tersebut, kita dapat ketahui bahwa pada IBL Season 2023/2024 posisi **Guard** menjadi posisi dengan player terbanyak pada season ini. Dilain hal, posisi **Small Forward** sangat sedikit pada season ini dengan hanya 9% dari total pemain IBL. Hal ini bisa menjadi evaluasi bagi IBL maupun team untuk melakukan penyetaraan bagi pemain dari setiap posisi

### 3. Distribusi Persentasi 3 Point 
<div align="center">
  <img src="Data Visualization/Visualization 4.jpg" width="475"/>
</div>

Insight : Dari hasil analisis tersebut, kita dapat ketahui bahwa pada IBL Season 2023/2024 persentase 3 point para pemain berkisar pada `30%`. Hal ini dapat menjadi bahan pembelajaran bagi tim dan pemain untuk meningkatkan hal tersebut.

### 4. Rata-rata score dari waktu ke waktu (per bulan) 
<div align="center">
  <img src="Data Visualization/Visualization 3.jpg" width="475"/>
</div>

Insight : Pada visualisasi line chart tersebut, terlihat bahwa pada bulan `April 2024`, tim-tim di IBL mencatat skor tertinggi dibandingkan dengan bulan-bulan lainnya. Sebaliknya, pada bulan `Februari 2024`, tim-tim di IBL mencatat skor terendah sepanjang IBL Season 2023/2024. Perbedaan signifikan dalam skor ini menunjukkan adanya fluktuasi performa yang mungkin dipengaruhi oleh berbagai faktor, seperti kondisi fisik tim, strategi pelatihan, atau perubahan dalam komposisi tim selama musim tersebut. Analisis lebih mendalam terhadap faktor-faktor ini dapat memberikan wawasan tambahan mengenai tren performa tim sepanjang musim.

### 5. Jumlah kemenangan antara *home* dan *away*
<div align="center">
  <img src="Data Visualization/Visualization 2.jpg" width="475"/>
</div>

Insight : Dari hasil analisis tersebut, dapat disimpulkan bahwa pada Regular Season IBL 2023/2024, tim yang bermain sebagai tamu lebih sering meraih kemenangan dibandingkan dengan tim tuan rumah. Temuan ini cukup menarik dan tidak sesuai dengan pola umum yang sering terjadi dalam olahraga, di mana biasanya tim yang bermain di kandang (home game) memiliki keuntungan dan lebih sering keluar sebagai pemenang. Faktor-faktor seperti dukungan suporter, familiaritas dengan lapangan, dan pengaruh lingkungan biasanya memberikan keunggulan bagi tim tuan rumah. Namun, data menunjukkan bahwa pada musim ini, tim tamu justru lebih unggul dalam pertandingan, yang mungkin mengindikasikan adanya faktor-faktor baru atau perubahan dinamika dalam kompetisi yang perlu diteliti lebih lanjut.

### 6. Jumlah kemenangan *home* dan *away* game dari setiap tim
<div align="center">
  <img src="Data Visualization/Visualization 1.jpg" width="475"/>
</div>

Insight dari visualisasi tersebut menunjukkan total skor yang dicetak oleh setiap tim, baik saat bermain di kandang (home) maupun saat bertandang (away). Analisis ini memberikan evaluasi penting bagi setiap tim. Sebagai contoh, Dewa United tampaknya mencetak lebih banyak skor ketika bermain di kandang, menunjukkan kekuatan mereka saat memiliki dukungan suporter dan familiaritas dengan lapangan. Sebaliknya, Pacific Caesar menunjukkan performa yang lebih baik saat bertandang, mengindikasikan kemampuan mereka untuk tampil optimal dalam situasi away. Insight ini bisa membantu tim dalam merencanakan strategi dan penyesuaian untuk meningkatkan performa di masa mendatang.

## Reference 
1. [Website IBL](https://iblindonesia.com/)
2. [Website Wikipedia](https://en.wikipedia.org/wiki/2024_IBL_Indonesia)
3. [Dokumentasi PostgreSQL](https://www.postgresql.org/)
4. [Dokumentasi Selenium](https://selenium-python.readthedocs.io/)

## Author
Ricky Wijaya - 18222043  
Sistem dan Teknologi Informasi  
Institut Teknologi Bandung  

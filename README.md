<a name="readme-top"></a>

<div align="center">
  <h1 align="center">Seleksi Lab Basdat Stage 2 2024</h1>

  <p align="center">
    <h3>Database Tennis Ranking: Scraping from  <a href="https://www.espn.com/tennis/rankings">ESPN</a></h3>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#author">Author</a></li>
    <li><a href="#deskripsi-data-dan-dbms">Deskripsi Data dan DBMS</a></li>
    <li><a href="#cara-menggunakan">Cara Menggunakan</a></li>
    <li><a href="#struktur-json">Struktur JSON</a></li>
    <li><a href="#struktur-database">Struktur Database</a></li>
    <li><a href="#translasi-erd-menjadi-relational-diagram">Translasi ERD menjadi Relational Diagram</a></li>
    <li><a href="#bonus">Bonus</a></li>
    <li><a href="#screenshot">Screenshot</a></li>
    <li><a href="#referensi">Referensi</a></li>
  </ol>
</details>

<!-- CONTRIBUTOR -->
## Author
<div align="center" id="contributor">
  <strong>
    <table align="center">
      <tr>
        <td>NIM</td>
        <td>Nama</td>
      </tr>
      <tr>
        <td>13522063</td>
        <td>Shazya Audrea Taufik</td>
      </tr>
    </table>
  </strong>
</div>

## Deskripsi Data dan DBMS

### Data
Data yang digunakan dalam tugas ini berasal dari data tenis milik ESPN yang berisi informasi mengenai pemain tenis, peringkat mereka, statistik karir, serta turnamen yang mereka ikuti. Berikut adalah tabel yang ada dalam database:

- Player: Tabel ini berisi informasi dasar tentang pemain tenis.
- Rank: Tabel ini mencatat peringkat pemain (baik ATP maupun WTA) pada berbagai tanggal.
- PlayerStats: Tabel ini menyimpan statistik pemain pada setiap tahun aktifnya.
- CareerStats: Tabel ini menyimpan statistik karir pemain, seperti jumlah kemenangan dan kekalahan dalam pertandingan tunggal. 
- Tournament: Tabel ini menyimpan data turnamen.
- PlayerTournament: Tabel ini mencatat partisipasi pemain dalam berbagai turnamen.
- Matches: Tabel ini berisi data match yang ada.
- PlayerMatch: Tabel ini mencatat partisipasi pemain dalam suatu permainan beserta hasilnya.
- Coach: Tabel ini berisi informasi dasar tentang pelatih tenis.
- PlayerCoach: Tabel ini mencatat hubungan pelatih dengan pemain (kapan mulai dan kapan selesai).
- Injury: Tabel ini mencatat cidera pemain.

### DBMS
Data yang diperoleh dari ESPN disimpan menggunakan DBMS `mysql`. Skema database terdiri dari 11 tabel dan yang memiliki isi dari scraping ada 6 tabel:

1. `Player` Table:
   - player_id (Primary Key): ID pemain tenis.
   - player_name: Nama pemain tenis.
   - country: kewarganegaraan pemain tenis
   - playing_hand: tangan dominan bermain milik pemain tenis.
   - year_turned_pro: tahun pemain menjadi pemain pro.
   - birth_date: tanggal lahir pemain tenis.
   - height: tinggi pemain tenis dalam cm.
   - weight: berat pemain tenis dalam kg.
   - hometown: daerah asal pemain.

2. `Rank` Table:
   - rank (Primary Key): urutan pemain tenis berdasarkan poin.
   - date (Primary Key): tanggal ranking diperbaharui.
   - rank_type (Primary Key): WTA atau ATP.
   - player_id (Foreign Key): ID pemain tenis. mereferensikan player_id pada tabel `Player`.
   - points: poin milik pemain pada rank tertentu.
   - change_in_rank: perubahan rank dari data sebelumnya.

3. `PlayerStats` Table:
   - player_id (Primary Key, Foreign Key): ID pemain tenis. mereferensikan player_id pada tabel `Player`.
   - year (Primary Key): tahun stats tertentu.
   - singles_title: jumlah gelar singles pada tahun tertentu.
   - doubles_title: jumlah gelar doubles pada tahun tertentu.
   - singles_win: jumlah kemenangan pada permainan singles pada tahun tertentu.
   - doubles_win: jumlah kemenangan pada permainan doubles pada tahun tertentu.
   - prize_money: pendapatan pada tahun tertentu (dalam us dollar).

4. `CareerStats` Table:
   - player_id (Primary Key, Foreign Key): ID pemain tenis. mereferensikan player_id pada tabel `Player`.
   - total_singles_title: jumlah gelar singles selama karir.
   - total_doubles_title: jumlah gelar doubles selama karir.
   - total_singles_win: jumlah kemenangan pada permainan singles selama karir.
   - total_doubles_win: jumlah kemenangan pada permainan doubles selama karir.
   - total_prize_money: pendapatan selama karir (dalam us dollar).

5. `Tournament` Table:
   - tournament_id (Primary Key): ID turnament.
   - event (Primary Key): jenis permainan pada turnamen (singles, doubles, team)
   - tournament_name: nama turnamen.
   - location: lokasi turnamen.
   - start_date: tanggal mulainya turnamen.
   - end_date: tanggal berakhirnya turnamen.

6. `PlayerTournament` Table:
   - tournament_id (Primary Key, Foreign Key): ID turnament. mereferensikan tournament_id pada tabel `Tournament`.
   - event (Primary Key, Foreign Key): jenis permainan pada turnamen (singles, doubles, team). mereferensikan event pada tabel `Tournament`.
   - player_id (Primary Key, Foreign Key): ID pemain tenis. mereferensikan player_id pada tabel `Player`.
   - player_result: hasil pemain dalam turnamen.

### Pemilihan Topik
Topik dipilih karena penulis memiliki ketertarikan dengan olahraga tenis. Penulis telah sering menonton turnamen tenis, sehingga penulis tertarik untuk menggunakan data ini pada tugas ini.

## Cara Menggunakan
1. Clone repository
```
git clone https://github.com/zyaaa-aaa/Seleksi-2024-Tugas-1.git
```
2. Pindah ke direktori terkait
```
cd "Data Scraping"
cd src
```
3. Ubah direktori pada file `Data Scraping/src/jsonfile.py` line 5 menjadi direktori absolut untuk folder `Data Scraping/data`
4. Ubah host, username, dan password mysql pada file `Data Scraping/src/player.py`, `Data Scraping/src/rank.py`, `Data Scraping/src/stats.py`, `Data Scraping/src/tournament.py`
5. Jalankan program scraping beserta storing
```
python3 main.py
```
6. Buka mysql dan export database
```
mysqldump -u <Username> -p --column-statistics=0 tennis_database > <filename.sql>
```
7. Untuk menjalankan dashboard visualisasi
```
cd ..
cd ..
cd "Data Visualization"
python3 visualization.py
```

## Struktur JSON
1. `players.json`
```json
{
    "player_id": "3623",
    "player_name": "Jannik Sinner",
    "country": "Italy",
    "playing_hand": "Right",
    "year_turned_pro": "2018",
    "birth_date": "2001-08-16",
    "height": 190,
    "weight": 77,
    "hometown": "San Candido, Italy"
}
```
2. `ranks.json`
```json
{
    "rank": 1,
    "date": "2024-07-29",
    "rank_type": "ATP",
    "player_id": 3623,
    "points": 9570,
    "change_in_rank": 0
}
```
3. `stats.json`
```json
{
    "player_id": "3623",
    "year": 2024,
    "singles_title": 4,
    "doubles_title": 0,
    "singles_win": 42,
    "singles_lose": 4,
    "prize_money": 5623601.0
}
```
4. `tournament.json`
```json
{
    "tournament_id": "188",
    "player_id": "3623",
    "event": "Men's Singles",
    "tournament_name": "WIMBLEDON",
    "start_date": "2024-06-24",
    "end_date": "2024-07-14",
    "player_result": "Quarterfinals Round"
}
```

## Struktur Database
### Entity Relationship Diagram
<img src="Data Storing/design/ERD.png"/>

### Relational Model
<img src="Data Storing/design/Relational Diagram.png" />

## Translasi ERD menjadi Relational Diagram
1. Setiap entity dijadikan relasi. Untuk strong entity, semua atribut tetap dengan adanya primary key. Untuk weak entity, atribut ditambahkan primary key dari strong
2. Relasi one to many antara tabel `rank` dan `player` menjadi tabel `rank` dengan primary key rank, date, rank_type dan foreign key player_id yang merujuk kepada player_id pada tabel player serta tabel `player` dengan primary key player_id.
3. Relasi many to many antara tabel `player` dan `coach` menjadi tabel `player`, `coach`, dan `playercoach` sebagai tabel penghubung. Tabel `coach` memiliki primary key coach_id. Tabel `playercoach` memiliki primary key player_id (merujuk ke tabel player), coach_id (merujuk ke tabel coach), dan start_date (dengan asumsi 1 pemain hanya memiliki 1 coach pada suatu waktu).
4. Relasi one to many antara tabel `player` dan `playerstats` menjadi tabel `player` dan `playerstats`. Tabel `playerstats` memiliki primary key player_id (merujuk ke tabel player) dan year.
5. Relasi one to many antara tabel `player` dan `injury` menjadi tabel `player` dan `injury`. Tabel `injury` memiliki primary key player_id (merujuk ke tabel player) dan injury_id.
6. Relasi one to one antara tabel `player` dan `careerstats` menjadi tabel `player` dan `careerstats`. Tabel `careerstats` memiliki primary key player_id (merujuk ke tabel player).
7. Relasi many to many antara tabel `player` dan `tournament` menjadi tabel `player`, `tournament`, dan `playertournament`. Tabel `tournament` memiliki primaru key tournament_id dan event. Tabel `PlayerTournament` memiliki primary key player_id (merujuk ke tabel player), tournament_id (merujuk ke tabel tournament), dan event (merujuk ke tabel tournament).
8. Relasi one to many antara tabel `tournament` dan `matches` menjadi tabel `tournament` dan `matches`. Tabel `matches` memiliki primary key tournament_id (merujuk ke tabel tournament), event (merujuk ke tabel tournament), dan match_id.
9. Relasi many to many antara tabel `player` dan `matches` menjadi tabel `player`, `matches`, dan `playermatch`. Tabel `playermatch` memiliki primary key tournament_id (merujuk ke tabel matches), event (merujuk ke tabel matches), match_id (merujuk ke tabel matches), dan player_id (merujuk ke tabel player).

## Bonus
### Visualisasi
Dashboard Visualisasi dibuat dengan library `dash`. Hasilnya adalah sebagai berikut:
#### Hasil
##### Visualisasi 1
Dari sini, kita bisa memperoleh top 10 pemain tenis ATP berdasarkan poin yang dia miliki.
<img src="Data Visualization/screenshot/visualisasi1.png" />

##### Visualisasi 2
Dari sini, kita bisa memperoleh top 10 pemain tenis WTA berdasarkan poin yang dia miliki.
<img src="Data Visualization/screenshot/visualisasi2.png" />

##### Visualisasi 3
Dari sini, kita bisa memperoleh top 10 pemain tenis berdasarkan win rate selama karirnya.
<img src="Data Visualization/screenshot/visualisasi3.png" />

##### Visualisasi 4
Dari sini, kita bisa memperoleh top 10 pemain tenis tertua.
<img src="Data Visualization/screenshot/visualisasi4.png" />

##### Visualisasi 5
Dari sini, kita bisa memperoleh top 10 pemain tenis berdasarkan poin yang dia miliki.
<img src="Data Visualization/screenshot/visualisasi5.png" />

##### Visualisasi 6
Dari sini, kita bisa memperoleh top 10 pemain tenis berdasarkan banyaknya turnamen yang ia ikuti.
<img src="Data Visualization/screenshot/visualisasi6.png" />

##### Visualisasi 7
Dari sini, kita bisa memperoleh data perubahan rank top 10 pemain tenis pada tanggal awal database (ATP).
<img src="Data Visualization/screenshot/visualisasi7.png" />

##### Visualisasi 8
Dari sini, kita bisa memperoleh data perubahan rank top 10 pemain tenis pada tanggal awal database (WTA).
<img src="Data Visualization/screenshot/visualisasi8.png" />

#### Source Code
Source code nya dapat dilihat disini:
<img src="Data Visualization/screenshot/code1.png" />
<img src="Data Visualization/screenshot/code2.png" />
<img src="Data Visualization/screenshot/code3.png" />
<img src="Data Visualization/screenshot/code4.png" />
<img src="Data Visualization/screenshot/code5.png" />

### Automated Scheduling
Scheduling dilakukan dengan menggunakan crontab
```
30 20 * * * /Library/Frameworks/Python.framework/Versions/3.12/bin/python3 /Users/shazyataufik/Documents/Seleksi/Basdat/Stage2/Seleksi-2024-Tugas-1/Data\ Scraping/src/main.py >> /Users/shazyataufik/main.log 2>&1

0 21 * * * /opt/homebrew/bin/mysqldump -u root -pshzyt2929 --column-statistics=0 tennis_database > /Users/shazyataufik/Documents/Seleksi/Basdat/Stage2/Seleksi-2024-Tugas-1/Data\ Storing/export/tennis_database.sql
```
Diperlukan absolute path untuk python3, file main.py, mysqldump, file export sql. Automated scheduling dilakukan setiap hari pada pukul 20.30 (main.py) dan 21.00 (mysqldump). Hal ini dilakukan agar dapat terus memperbarui data turnamen dan ranking. Data ranking pada website ini diupdate setiap 7 hari. Penulis memilih jam tersebut dengan pertimbangan waktu run main.py membutuhkan waktu sehingga dump dilakukan 30 menit setelahnya.
<img src="Data Scraping/screenshot/automatedscheduling.png" />

#### Hasil
Bukti jalannya adalah sebagai berikut:
<img src="Data Scraping/screenshot/schedule1.png" />
<img src="Data Scraping/screenshot/schedule2.png" />
<img src="Data Scraping/screenshot/hasilschedule1.png" />
<img src="Data Scraping/screenshot/hasilschedule2.png" />
<img src="Data Scraping/screenshot/hasilschedule3.png" />
<img src="Data Scraping/screenshot/hasilschedule4.png" />

## Screenshot
### Data Scraping
#### Database
<img src="Data Scraping/screenshot/database1.png" />
<img src="Data Scraping/screenshot/database2.png" />
<img src="Data Scraping/screenshot/database3.png" />
<img src="Data Scraping/screenshot/database4.png" />
<img src="Data Scraping/screenshot/database5.png" />

#### Player
<img src="Data Scraping/screenshot/player1.png" />
<img src="Data Scraping/screenshot/player2.png" />
<img src="Data Scraping/screenshot/player3.png" />
<img src="Data Scraping/screenshot/player4.png" />

#### Rank
<img src="Data Scraping/screenshot/rank1.png" />
<img src="Data Scraping/screenshot/rank2.png" />

#### Stats
<img src="Data Scraping/screenshot/stats1.png" />
<img src="Data Scraping/screenshot/stats2.png" />
<img src="Data Scraping/screenshot/stats3.png" />

#### Tournament
<img src="Data Scraping/screenshot/tournament1.png" />
<img src="Data Scraping/screenshot/tournament2.png" />
<img src="Data Scraping/screenshot/tournament3.png" />
<img src="Data Scraping/screenshot/tournament4.png" />
<img src="Data Scraping/screenshot/tournament5.png" />

#### Main
<img src="Data Scraping/screenshot/main.png" />

#### Json
<img src="Data Scraping/screenshot/json.png" />

### Data Storing
#### Database
<img src="Data Storing/screenshot/database.png" />

#### Player
<img src="Data Storing/screenshot/playertable1.png" />
<img src="Data Storing/screenshot/playertable2.png" />

#### Rank
<img src="Data Storing/screenshot/ranktable1.png" />
<img src="Data Storing/screenshot/ranktable2.png" />

#### PlayerStats
<img src="Data Storing/screenshot/playerstats1.png" />
<img src="Data Storing/screenshot/playerstats2.png" />

#### CareerStats
<img src="Data Storing/screenshot/careerstats1.png" />
<img src="Data Storing/screenshot/careerstats2.png" />

#### Tournament
<img src="Data Storing/screenshot/tournamenttable1.png" />
<img src="Data Storing/screenshot/tournamenttable2.png" />

#### PlayerTournament
<img src="Data Storing/screenshot/playertournament1.png" />
<img src="Data Storing/screenshot/playertournament2.png" />

#### Tabel Lainnya (Coach, PlayerCoach, Injury, Matches, PlayerMatch)
<img src="Data Storing/screenshot/othertables.png" />

## Referensi
### Library
1. JSON
2. requests
3. BeautifulSoup
4. re
5. mysql.connector
6. datetime
7. os
8. dash
9. pandas

### Link Scraping
```
https://www.espn.com/tennis/rankings
https://www.espn.com/tennis/rankings/_/type/wta
```

<br>
<h3 align="center"> THANK YOU! </h3>
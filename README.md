<h1 align="center">
  <br>
    TranserMarkt Scrape
  <br>
  <br>
</h1>

### Raizan Iqbal Resi - 18222068

## Project Description
Transfermarkt adalah web didedikasikan untuk informasi football. Platform ini menyediakan basis data yang sangat luas yang berisi informasi tentang pemain, tim, transfer, nilai pasar, dan hasil pertandingan dari liga-liga di seluruh dunia. 

Projek ini dirancang untuk mengekstrak data yang berhubungan dengan informasi pemain dari Top 100 Pemain EPL berdasarkan dari Transfermarkt.com. Dengan proses pengumpulan data, projek ini bertujuan untuk mengumpulkan insights mengenai statistik pemain, nilai pasar, sejarah transfer, dan informasi relevan lainnya. Data ini dapat digunakan untuk berbagai tujuan, termasuk analisis data dan lain-lain.

## Scraping Process
### WebScrape
1. Install all dependencies
```
pip install selenium
pip install pyscopg2
pip install beautifulsoup4
pip install unidecode
```
2. Clone this repository
>
    git clone https://github.com/Qibaal/Seleksi-2024-Tugas-1.git

3. Change directory
>
    cd /Data Scraping/src

4. Run the scraper
> 
    python main.py

5. Get the JSON file

### Data Processing and Storing
To automate the scraping, processing and inserting data to the PSQL database, here are the steps to follow:

1. Create a new database on PostgreSQL

2. Save the SQL file from the Data Storing/export directory and place it on users directory on windows. Then, insert the SQL file. You can do this by:
> 
    psql -U uname -d dbname -f C:\Users\{user}\transfermarkt.sql

3. Go to the automate directory
>
    cd Data Scraping/automate

4. Run the python script, this will automatically scrape, clean, and insert new data to the database
>
    python main.py

### Automatic Scheduling
In getting the most updated data, we can utilize auto scheduling by creating jobs on Windows task scheduler. To schedule jobs on the whole process (scraping, processing, and inserting) here are the steps to follow:
1. Open Windows Task Scheduler

2. Go to the actions task and select create task

3. In the General Tab, Insert name to be TransferMarkt Scrape, below, select Run whether user is logged in or not, and select Run with highest privileges.

<img src="Data Scraping\src\automate\screenshot\general.png">

4. Then go to the Triggers Tab. create a new trigger, select the start date to be the last date on this month (example: 30). Dont forget to enable the trigger (default is enabled) 

<img src="Data Scraping\src\automate\screenshot\trigger.png">

5. Go to actions tab. Create a new action. On program/script, paste the python.exe path. to see your python.exe file, here are the steps:
    - Go to command prompt
    - Write ‘where python’
    - Copy your python.exe path

<img src="Data Scraping\src\automate\screenshot\action.png">

6. On Conditions tab, unselect the "Start the task only if the computer is on AC Power". 

<img src="Data Scraping\src\automate\screenshot\condition.png">



### JSON Structure
Setiap elemen dari JSON array merepresent player information. Informasi antara lain yaitu player info berupa nama, informasi pribadi, posisi, dll. Lalu ada current contract dan current value. Lalu ada stats berupa array yang merepresentasikan stats setiap season pemain di premier league. transfer history berupa array untuk informasi historis transfer pemain. dan array awards berisi awards yang didapatkan para pemain dan tahun didapatkan (Sebuah player memiliki null awards jika tidak pernah mendapatkan penghargaan) 
```
[
    {
        "player_info": {
            "name": "Erling Haaland",
            "player_number": 9,
            "birth_date": "2000-07-21T00:00:00",
            "birth_place": "Leeds",
            "height": 1.95,
            "nationality": "Norway",
            "position": "Attack - Centre-Forward",
            "preffered_foot": "left",
            "player_agent": "Rafaela Pimenta",
            "outfitter": "Nike"
        },
        "current_contract": {
            "current_club": "Manchester City",
            "date_joined": "2022-07-01T00:00:00",
            "contract_expired": "2027-06-30T00:00:00"
        },
        "current_value": {
            "current_value": 180.0,
            "last_update_date": "2024-05-27T00:00:00"
        },
        "stats": [
            {
                "season": "23/24",
                "matches_played": 31,
                "goals": 27,
                "assists": 5,
                "minutes_played": 2558
            },

        ],
        "transfer_history": [
            {
                "season": "22/23",
                "transfer_date": "2022-07-01T00:00:00",
                "club_left": "Bor. Dortmund",
                "club_joined": "Man City",
                "market_value": 150.0,
                "fee": 60.0,
                "is_loan": false
            },
        ],
        "awards": [
            {
                "award_name": "UEFA Best Player in Europe",
                "details": [
                    {
                        "year": "2023"
                    }
                ]
            },
        ]
    },
]
```

## Struktur ERD
### Entity Relationship Diagram
<img src="Data Storing/design/TransferMarkt-ER.png">

### Relation Diagram
<img src="Data Storing/design/TransferMarkt-Relation.png">

## Penjelasan dan proses translasi ERD
ERD yang dibuat memiliki beberapa entity, seperti player dan awards yang merupakan strong entity. Contract, Stats, Player Value, dan Transfer merupakan weak entity karena existancenya bergantung pada entity player. Berikut adalah keterangan mengenai ERD:
- Stats (weak entity) memiliki specialization entity yang dikategorikan berdasarkan posisi player (Field player atau Goalkeeper). Stats memiliki full participation relation dengan IS A, dan one to one cardinality untuk tiap tipe stats. Player dan stats memiliki one to many relation dengan full participation dari stats ke player dan partial participation dari player ke stats. Proses translasi dilakukan dengan penambahan player id sebagai foreign key pada kedua tabel stats
- Player dan transfer (weak entity) memiliki relation one to many. Proses translasi dilakukan dengan penambahan player id sebagai foreign key pada tabel transfer
- Player dan Player Value (weak entity) memiliki relation one to many. Player value menyimpan data current value dan data historis untuk value. Proses translasi dilakukan dengan penambahan player id sebagai foreign key pada tabel player value
- Player dan contract (weak entity) memiliki relation one to many. contract menyimpan data current contract dan contract history. Proses translasi dilakukan dengan penambahan player id sebagai foreign key pada tabel contract
- Player dan awards memiliki relation many to many. Proses translasi dilakukan dengan menambahkan junction table dengan penambahan atribut year. 


## Screenshots
### PSQL Queries
<img src="Data Storing\screenshot\player-screenshot.png">
<br>
<img src="Data Storing\screenshot\award-screenshot.png">
<br>
<img src="Data Storing\screenshot\contract-screenshot.png">
<br>
<img src="Data Storing\screenshot\field-player-stats-screenshot.png">
<br>
<img src="Data Storing\screenshot\goalkeeper-stats-screenshot.png">
<br>
<img src="Data Storing\screenshot\player-value-screenshot.png">
<br>
<img src="Data Storing\screenshot\player-award-screenshot.png">
<br>
<img src="Data Storing\screenshot\transfer-screenshot.png">
<br>

### Scripts
<img src="Data Scraping\screenshot\scraper.png">
<br>

## Referensi
- DBMS: PostgreSQL

- Library:
    - Selenium      (WebScrape)
    - pyscopg2       (DB Driver)
    - BeautifulSoup4 (WebScrape)
    - Unidecode     (Character normalization)

- URLS:
    - https://www.transfermarkt.com/premier-league/marktwerte/wettbewerb/GB1
    - https://www.transfermarkt.com/premier-league/marktwerte/wettbewerb/GB1/page/2
    - https://www.transfermarkt.com/premier-league/marktwerte/wettbewerb/GB1/page/3
    - https://www.transfermarkt.com/premier-league/marktwerte/wettbewerb/GB1/page/4






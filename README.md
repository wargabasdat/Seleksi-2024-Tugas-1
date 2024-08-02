<h1 align="center">
  <br>
  Seleksi Warga Basdat 2024 <br>
  ETL Project
  <br>
  <br>
</h1>

## Deskripsi

Data yang digunakan untuk membuat DBMS ini adalah hasil scrapping data - data dari web game [Dark Souls III](https://darksouls.fandom.com/wiki/Dark_Souls_III). Topik ini melibatkan banyak data - data yang cocok untuk dibuatkan sebuah model basis data relasional, seperti Bosses, yang dapat memiliki drop Souls, yang dapat ditukar menjadi Weapons, Pyromancies, dan banyak fitur lain yang masih dapat ditambahkan. Banyaknya fitur yang bervariasi dan cukup kompleks, sehingga dengan dibuatnya DBMS ini, dapat mempermudah user untuk mencari informasi tertentu dalam game Dark Souls III.

## Cara Menggunakan

1. Pastikan Python dan MariaDB terinstall
2. Masuk dalam directory file scraper, dan jalankan scraper

```cmd
cd '.\Data Scraping\'
cd src
cd scraper
python scraper.py
```

3. Setelah scraper selesai, pastikan terdapat database available
4. Jika belum membuat sebuah database dapat mengikuti cara berikut

### Log in dalam MariaDB server dan masukkan password

```cmd
cd ../../..
mariadb -u <username> -p -P <port>
```

### Create database

```cmd
create database <database>
```

5. Masuk dalam directory file config

```cmd
cd '.\Data Scraping\'
cd src
cd dbms
```

6. Ubah file dbconfig.json sesuai dengan config database yang dimiliki.
7. Jalankan file db.py

```cmd
python db.py
```

## Struktur File JSON

### Bosses.json

```
{
        "name": "Iudex Gundyr",
        "image": "https://static.wikia.nocookie.net/darksouls/images/8/85/Iudex_Gundyr_-_01.jpg/revision/latest/scale-to-width-down/350?cb=20170524133508",
        "location": [
            "Cemetery of Ash"
        ],
        "drops": [
            "Coiled Sword"
        ],
        "health": {
            "ng": [
                "1,037"
            ],
            "ng+": [
                "3,561"
            ]
        },
        "souls": {
            "ng": [
                "3,000"
            ],
            "ng+": [
                "15,000"
            ]
        },
        "magic": null,
        "fire": null,
        "lightning": null,
        "dark": "Resistance",
        "bleed": "Resistance",
        "poison": "Immunity",
        "frost": "Weakness"
    },
```

- name : Nama boss
- location : Array location letak boss dapat ditemukan
- drops : Array drop dari sebuah boss
- health : HP dari boss
- souls : Souls drop dari sebuah boss
- magic - frost : Atribut boss

### Miracles.json

```
{
        "miracle": "Heal Aid",
        "item_effect": "Slightly restore HP",
        "fp_cost": 27,
        "slots": 1,
        "faith": 8,
        "location": [
            "Herald",
            "Shrine Handmaid"
        ]
    },
```

- miracle : Nama miracle
- item_effect : Deskripsi effect miracle
- fp_cost : Konsumsi fp miracle
- slots : Slot yang digunakan
- faith : Faith requirement miracle
- location : Array di mana miracle dapat ditemukan

### Pyromancies.json

```
{
        "pyromancy": "Fireball",
        "item_effect": "Hurls fireball",
        "fp_cost": 10,
        "slots": 1,
        "intelligence": 6,
        "faith": 6,
        "location": [
            "Cornyx of the Great Swamp"
        ]
    },
```

- pyromancy : Nama pyromancy
- item_effect : Deskripsi effect pyromancy
- fp_cost : Konsumsi fp pyromancy
- slots : Slot yang digunakan
- intelligence : Intelligence requirement pyromanct
- faith : Faith requirement pyromancy
- location : Array di mana pyromancy dapat ditemukan

### Sorceries.json

```
{
    "name": "Soul Arrow",
    "effect": "Fire soul arrow",
    "fp_cost": 7,
    "slots": 1,
    "intelligence": 10,
    "availability": [
      "Sorcerer",
      "Shrine Handmaid",
      "Yoel of Londor",
      "Yuria of Londor",
      "Orbeck of Vinheim"
    ]
  },
```

- name : Nama sorcery
- effect : Deskripsi effect sorcery
- fp_cost : Konsumsi fp sorcery
- slots : Slot yang digunakan
- intelligence : Intelligence requirement pyromanct
- availability : Array di mana sorcery dapat ditemukan

### Rings.json

```
{
        "name": "Life Ring",
        "effect": "Raises maximum HP",
        "weight": 0.3,
        "locations": [
            "Burial Gift",
            "Shrine Handmaid",
            "Undead Settlement",
            "Lothric Castle",
            "Untended Graves"
        ]
    },
```

- name : Nama ring
- effect : Deskripsi effect ring
- weight : Berat ring
- locations : Array di mana ring dapat ditemukuan

### Shields.json dan Weapons.json

```
{
        "name": "Claymore",
        "image_url": "https://static.wikia.nocookie.net/darksouls/images/e/e9/Claymore_%28DSIII%29.png/revision/latest?cb=20160612044933",
        "weapon-type": "Greatsword",
        "atk-type": "Standard/Thrust",
        "price": "100",
        "spc-atk": "Stance",
        "phys-atk": "138",
        "magic-attack": "0",
        "fire-attack": "0",
        "lightning-attack": "0",
        "dark-attack": "0",
        "counter": "100",
        "physical-defense": "50.0",
        "magic-defense": "35.0",
        "fire-defense": "30.0",
        "lightning-defense": "30.0",
        "dark-defense": "35.0",
        "stability": "35",
        "durability": "75",
        "weight": "9.0",
        "strength-bonus": "D",
        "dexterity-bonus": "D",
        "strength-requirement": "16",
        "dexterity-requirement": "13",
        "weapon_type": "Greatswords"
    },
```

- name : Nama weapon
- weapon_type : Tipe weapon
- price : Harga weapon
- spc-atk : Special attack
- weight : Berat weapon
- bonuses : Scaling stats weapon
- requrements : Requirement stats weapon

### SoulItems.json

```
{
        "item": {
            "name": "Soul of Boreal Valley Vordt"
        },
        "transpositions": [
            {
                "name": "Vordt's Great Hammer",
                "cost": 0
            },
            {
                "name": "Pontiff's Left Eye",
                "cost": 0
            }
        ]
    },
```

- item, name : Nama soul item
- transposition, name : Nama item yang dapat ditranspose dari soul item

## Struktur ERD dan Relational

### ERD

<img src="Data Storing/design/ERD-Final ERD.drawio.png"/>

### Relational

<img src="Data Storing/design/ERD-Final Relational.drawio.png"/>

## Translasi ERD ke Relational

Cara mengubah ERD menjadi relational diagram adalah dengan mengubah seluruh entity, dan relationship tertentu menjadi relasi atau tabel pada database. Entity seperti Rings dan Location yang memiliki relasi many to many akan dibuatkan relasi baru yang memiliki kedua primary key dari relasi tersebut, hal ini diterapkan juga pada seluruh entity lain yang berelasi many to many. Untuk entity yang berelasi many to one seperti Magic dan Location, maka Magic (entity many) akan ditambahkan atribut Foreign Key dari Location. Dapat dilihat terdapat relasi many to one dengan full participation dan tidak, kedua tipe ini akan ditranslasi dengan sama, hanya saja untuk relasi yang partial participation akan memiliki null value dalam atribut yang ditambahkan. Untuk Magic yang memiliki relasi ISA pada Pyromancies, Sorceries, Miracles akan memiliki tabel turunan yang memiliki Primary Key yang juga adalah Foreign Key dari Magic, beserta atribut tambahan yang membedakan mereka.

## Screenshot

### Query

<img src="Data Storing/screenshot/Query.png"/>

### Scraping

<img src="Data Scraping/screenshot/Bosses.png"/>
<img src="Data Scraping/screenshot/Miracles.png"/>
<img src="Data Scraping/screenshot/Pyromancies.png"/>
<img src="Data Scraping/screenshot/Rings.png"/>
<img src="Data Scraping/screenshot/Shields.png"/>
<img src="Data Scraping/screenshot/Sorceries.png"/>
<img src="Data Scraping/screenshot/SoulItems.png"/>
<img src="Data Scraping/screenshot/Weapons.png"/>

## Referensi

- Bahasa Pemrograman : Python
- DBMS : MariaDB
- Library : BeautifulSoup, pymysql
- URL:
  - https://darksouls.fandom.com/wiki/Boss_(Dark_Souls_III)
  - https://darksouls.fandom.com/wiki/Miracle_(Dark_Souls_III)
  - https://darksouls.fandom.com/wiki/Pyromancy_(Dark_Souls_III)
  - https://darksouls.fandom.com/wiki/Rings_(Dark_Souls_III)
  - https://darksouls.fandom.com/wiki/Shields_(Dark_Souls_III)
  - https://darksouls.fandom.com/wiki/Sorcery_(Dark_Souls_III)
  - https://darksouls.fandom.com/wiki/Boss_Soul_Items_(Dark_Souls_III)
  - https://darksouls.fandom.com/wiki/Weapons_(Dark_Souls_III)
  - Setiap page Bosses, Weapons, Shields.

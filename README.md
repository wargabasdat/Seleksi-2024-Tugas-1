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

### Environtment Variables
Buat file `.env` di dalam folder [Data Scraping/src](Data%20Scraping/src) dengan isi dapat mengikuti examplenya pada file [Data Scraping/src/.env.example.docker](Data%20Scraping/src/.env.example.docker) atau [Data Scraping/src/.env.example.localhost](Data%20Scraping/src/.env.example.localhost). Atau langsung saja rename yang [Data Scraping/src/.env.example.localhost](Data%20Scraping/src/.env.example.localhost) menjadi `Data Scraping/src/.env`.


### Docker
Jika ingin menggunakan docker, jalankan ini
```
docker-compose up
```
Program akan secara otomatis melakukan web scraping dan menyimpannya di [Data Scraping/src/json/data.json](Data%20Scraping/src/json/data.json) serta memasukkan data-data ke basis data.

Jika hanya ingin menghidupkan database, jalankan ini
```
docker-compose up database
```

Jika hanya ingin menjalankan web scraping, jalankan ini
```
docker-compose up scrape
```

Jika ingin query sql ke database, buka terminal baru dan jalankan ini
```
docker exec -it <CONTAINER_NAME> psql -U <DB_USERNAME> <DB_NAME>
<QUERY_SQL>;
```
Misalnya
```
docker exec -it mariodb psql -U user mariodb
SELECT * FROM image;
```

### Cek Last Updated
Jika ingin mengecek kapan terakhir kali data diupdate, bisa dengan query berikut
```
SELECT pg_xact_commit_timestamp(xmin) FROM <TABLE_NAME> LIMIT 1;
```
Misalnya
```
SELECT pg_xact_commit_timestamp(xmin) FROM obstacle LIMIT 1;
```

### Dump
jalankan command berikut untuk melakukan dump database
```
docker exec -it mariodb pg_dump mariodb > dump/dump.sql
```
Hasil dump ada di [Data Scraping/src/dump/dump.sql](Data%20Scraping/src/dump/dump.sql)

### Restore Dump
jalankan command berikut untuk melakukan restore database
```
docker exec -i mariodb psql -U user -d mariodb < dump/dump.sql
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

Contoh jika ingin menjalankan sebuah sql query dari code adalah sebagai berikut.
```
python db.py "SELECT * FROM item"
```


## Struktur File Hasil Scrapping
<!-- - Penjelasan struktur dari file JSON yang dihasilkan scraper -->

```
{
  "character": {

    // array of playable characters, keunikannya punya relasi dengan form (misal mario menjadi fiery mario)
    "pc": {
      "name": string,
      "description": string,
      "image": {
        "name": string,
        "url": string,
        "width": number,
        "height": number
      },
      "detail_url": string
    }[],


    // array of non playable characters
    "npc": {
      "name": string,
      "description": string,
      "image": {
        "name": string,
        "url": string,
        "width": number,
        "height": number
      },
      "detail_url": string,
    }[],


    // array of enemies, keunikannya punya points
    "enemy": {
      "name": string,
      "description": string,
      "image": {
        "name": string,
        "url": string,
        "width": number,
        "height": number
      },
      "detail_url": string,
      "points": number,
    }[]
  },

  // array of obstacles yang ada di game
  "obstacle": {
    "name": string,
    "description": string,
    "image": {
      "name": string,
      "url": string,
      "width": number,
      "height": number
    },
    "detail_url": string,
  }[],

  // array of item yang ada di game
  "item": {
    "name": string,
    "description": string,
    "image": {
      "name": string,
      "url": string,
      "width": number,
      "height": number
    },
    "detail_url": string,
  }[],

  // array of power up yang ada di game, dapat membuat playable character berubah form
  "power_up": {

    // ada yang N/A karena state saat playable character sedang tidak menggunakan power up
    "name": null || string,
    "description": string,

    // ada yang N/A karena state saat playable character sedang tidak menggunakan power up
    "image": null || {
      "name": string,
      "url": string,
      "width": number,
      "height": number
    },

    // ada yang N/A karena state saat playable character sedang tidak menggunakan power up
    "detail_url": null || string,

    // khusus untuk playable character bernama 'mario'
    "mario_form": {
      "name": string,
      "image": {
        "name": string,
        "url": string,
        "width": number,
        "height": number
      },
      "detail_url": string
    },

    // khusus untuk playable character bernama 'luigi'
    "luigi_form": {
      "name": string,
      "image": {
        "name": string,
        "url": string,
        "width": number,
        "height": number
      },
      "detail_url": string
    },
  }[],

  // array of object yang ada di game. tiap object memiliki typenya masing-masing, namun tidak ada keunikan dari tiap type, hanya sebagai penamaan saja. Lalu tiap 4 level memiliki image yang sama.
  "object": {
    "name": string,
    "description": string,
    "image": Image,
    "detail_url": string,
    "type": string
  }[],

  // array of reference yang ada pada game
  "reference": {
    "name": string,
    "description": string,
    "detail_url": string,
    "type": string
  }[],

  // array of version yang ada pada game
  "version": {
    "year": string,
    "description": string,
  }[],

  // array of level yang ada pada game. Tiap level memiliki item, power_up, enemies, dan obstacle dengan jumlah tertentu. Namun website sering tidak konsisten. Misal dalam item ada power_up. Kadang enemies dicampur dengan obstacle.
  "level": {
    "name": string,
    "image": {
      "name": string,
      "url": string,
      "width": number,
      "height": number
    },
    "detail_url": string,
    "setting": string,

    // Saat scraping juga memiliki id html yang tidak konsisten. Bisa beda-beda antara Level_map, Level_maps, Course_map, Map
    "course_map_image": {
      "name": string,
      "url": string,
      "width": number,
      "height": number
    },

    // Website sering tidak konsisten. Di dalam ini bisa ada power_up
    "item": { 
      "name": string;
      "count": number;
      "detail_url": string;
      "description": string;
    }[],

    // Website sering tidak konsisten. Kadang enemies, kadang campuran enemies dan obstacle, kadang tidak ada sama sekali
    "enemies": null || {
      "name": string,
      "count": number,
      "detail_url": string
    }[],
    "enemies_and_obstacle": null || {
      "name": string,
      "count": number,
      "detail_url": string
    }[],
  }[]
}
```

## Struktur ERD dan diagram relasional RDBMS 
<!-- - Struktur ERD dan diagram relasional RDBMS -->
### Entity Relationship Diagram
<img src="Data Storing/design/Mario-DB-ER.drawio.png"/>

### Relational Diagram
<img src="Data Storing/design/Mario-DB-R.drawio.png"/>

## Translasi ERD Menjadi diagram relasional
<!-- - Penjelasan mengenai proses translasi ERD menjadi diagram relasional -->
Proses translasi ERD menjadi diagram relasional dilakukan dengan cara mengubah setiap entitas dan relasi yang ada pada ERD menjadi tabel-tabel pada database. Setiap atribut cpada entitas akan menjadi kolom pada tabel. Setiap relasi akan menjadi foreign key pada tabel yang berelasi. Entity character memiliki relasi ISA dengan cardinality one to one dengan entity pc, npc, dan enemy. Ini diubah menjadi tabel character, pc, npc, dan enemy. Setiap tabel turunannya memiliki id primary key yang sekalian foreign key yang sama dengan character. Untuk entity pc memiliki hubungan many to many dengan entity power_up dan memiliki relasi form yang memiliki atribut relasi yang atribut relasi itu juga berelasi dengan image. Setelah ditransformasi maka menjadi tabel pc, form, dan power_up yang dihubungkan melalui primary key dan foreign key. Untuk tabel form terdapat atribut tambahan sesuai dengan relasi form. Terdapat sebuah entity level yang berelasi dengan entity item, object, enemy, dan power_up dengan cardinality one to many. Maka level akan menjadi tabel, yang akan dihubungkan ke tabel item, object, enemy, dan power_up melalui tabel level_item, level_object, level_enemy, dan level_power_up dengan primary key dan foreign keynya dan memiliki tambahan atribut count. Reference dan version tidak memiliki relasi dengan entity lain sehingga langsung diubah menjadi tabel. Kemudian untuk masing-masing entity yang memiliki relasi dengan image akan memiliki atribut image_id untuk dihubungkan ke tabel image. Untuk setting level yang berelasi dengan entity level akan diubah menjadi tabel setting_level yang berelasi dengan level yang dihubungkan melalui primary key dan foreign key.


## Automated Scheduling Update
Proses web scraping dapat diupdate dalam jangka waktu tertentu. Dalam program ini, proses web scraping akan dijalankan setiap 2 menit. Konfigurasi ini bisa diubah dari main.py pada variabel wait_time. Nilainya dalam detik. File json hasil scraping akan disimpan di [Data Scraping/src/json/data.json](Data%20Scraping/src/json/data.json).

## Screenshot
<!-- - Beberapa screenshot dari program yang dijalankan (image di-upload sesuai folder-folder yang tersedia, di README tinggal ditampilkan) -->

### Query SQL
Contoh login dan query SELECT ke tabel obstacle.
<img src="Data Storing/screenshot/query-sql.png"/>

### Scheduling
Contoh mengambil timestamp untuk mengetahui kapan terakhir kali obstacle diupdate.
Yang bawah merupakan setelah ditunggu sekitar 2 menit.
<br>
<img src="Data Storing/screenshot/scheduling.png"/>

### Web Scrapping
<img src="Data Scraping/screenshot/main.py.png"/>
<img src="Data Scraping/screenshot/table.py.png"/>
<img src="Data Scraping/screenshot/character.py.png"/>
<img src="Data Scraping/screenshot/item.py.png"/>
<img src="Data Scraping/screenshot/level.py.png"/>
<img src="Data Scraping/screenshot/object.py.png"/>
<img src="Data Scraping/screenshot/obstacle.py.png"/>
<img src="Data Scraping/screenshot/power_up.py.png"/>
<img src="Data Scraping/screenshot/reference.py.png"/>
<img src="Data Scraping/screenshot/table.py.png"/>
<img src="Data Scraping/screenshot/version.py.png"/>


## Referensi
- Bahasa Pemrograman: Python
- Library:
    - asyncio: web request secara konkuren sekalian untuk scheduling
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
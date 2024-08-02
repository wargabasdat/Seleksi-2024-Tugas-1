Author
Muhammad Rafly 18222067

Deskripsi singkat mengenai data dan DBMS yang telah dibuat + mengapa kalian memilih topik tersebut
Genshin Impact karakter dan weapon. Secara singkat, ini menjadi salah satu database yang pertama aku pikirkan ketika diberi tugas ini dan karena pernah main (sudah pensiun), paham dengan istilah-istilah terkait database ini

Cara menggunakan scraper yang telah dibuat dan menggunakan hasil output-nya
file src.py bisa di-run, dengan memastikan library yang dibutuhkan sudah diinstall. hasil dari scraper adalaha file-file json.

Penjelasan struktur dari file JSON yang dihasilkan scraper
file json yang dihasilkan berdasarkan list/array yang diperoleh dari scraping yaitu sebagai berikut
character = []
element = []
weapon_type = []
role = []
materials_item = []
weapon = []
talent = []
passive = []
constellation = []

Struktur ERD dan diagram relasional RDBMS
Penjelasan ERD dan diagram relasional cukup standar. Terdapat beberapa karakter dengan attribut-atribut tertentu, seperti nama, dan raritynya. Pada awalnya Element dan Role dijadikan entity sendiri dikarenakan pada database yang lebih luas, dapat dimanfaatkan, namun karena pada skala ini hanya dipake namanya, maka ditranslasi menjadi suatu atribut. Selain itu terdapat Weapon dan Weapon Type. Weapon berhubungan dengan Character dikarenakan character-character memiliki "recommended" weapons dari websitenya.

Penjelasan mengenai proses translasi ERD menjadi diagram relasional
Dilakukan translasi secara standar dari ERD menjadi Relasional, namun ada beberapa hal yang bisa dibahaskan. Yang pertama adalah penghapusan tipe-tipe skills dikarenakan perbedaannya tidak terlalu relevan selain efisiensi query pada postgresql. Ada beberapa entity juga yang seharusnya bisa dijadikan tabel sendiri, namun dikarenakan datanya sangat minim dan tidak relevan, data tersebut dimasukkan pada tabel yang memiliki relasi dengannya.

Referensi (library yang digunakan, halaman web yang di-scrape, etc)
https://genshin.gg/
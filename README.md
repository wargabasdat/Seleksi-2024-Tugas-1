## Author
Nama: Micky Valentino
NIM: 18222093 

## Data dan DMBS
Data yang diambil adalah richest people in the world dengan company - company yang dipegang oleh orang tersebut serta net_worth dari company tersebut. Saya memilih topik ini karena saya ingin mengetahui company - company seperti apa yang sukses dan letak company tersebut.

## Scraper
Scraper yang dibuat dapat langsung digunakan dengan run file scraping lalu run file preprocessing untuk melakukan preprocessing data tersebut

## JSON File
Dalam JSON File, terdapat 5 data, yaitu rank yang merupakan urutan orang terkaya, company yang merupakan perusahaan tempat orang terkaya tersebut menjadi CEO, executive_name yang merupakan nama orang terkaya sekaligus CEO tersebut, net_worth yang merupakan kekayaan bersih perusahaan, dan country yang merupakan tempat perusahaan tersebut berada 

## Struktur ERD dan Diagram Relational
Struktur ERD dapat dilihat sebagai berikut:
![ERD](Seleksi-2024-Tugas-1\Data Storing\design\ERD.png)
![Gambar contoh query dalam database]

Diagram Relational dapat dilihat sebagai berikut:
![Relational database](Seleksi-2024-Tugas-1\Data Storing\design\relational.png)

## Translasi ERD Menjadi Diagram Relasional
Pertama2, saya membuat semua entity yang ada di ERD, lalu Pada ERD, terdapat relationship one-to-many sehingga pada diagram relational, diubah menjadi atribut foreign key dari many mengacu ke one. Selain itu terdapat relationship many-to-many sehingga saya membaut relasi baru dari kedua primary key tersebut.

![Scraping dan Preprocessing](Seleksi-2024-Tugas-1\Data Scraping\screenshot\Scraping and Preprocessing.png)
![Query berdasarkan database](Seleksi-2024-Tugas-1\Data Storing\screenshot\Query.png)

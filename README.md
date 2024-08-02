<h1 align="center">
  <br>
  Seleksi Warga Basdat 2024 <br>
  ETL Project
  <br>
  <br>
</h1>

<h2 align="left">
  <br>
  DATA SCRAPING, STORING, AND VISUALIZATION OF CONVINIENCE STORE AT <a
  href="https://www.bormadago.com/shop"> Borma Dago</a>
  <br>
  <br>
</h2>



DAFTAR ISI
- System Description
- Program Specification
- How To Use
  - Data Scraping
  - Data Storing
- JSON Structure
- Database Structure
  - Entity Relationship Diagram
  - Relational Diagram
  - Convertion Explanation
    - Pemetaan *entity* menjadi relasi
    - Pemetaan *relationship* menjadi relasi
    - Pemetaan *specialization/ generalization* menjadi relasi
    - Pemetaan *composit attributes* menjadi relasi
- Screenshot
  - Tampilan *Website*
  - Data Scrapping & Pre-processing
  - Data Storing
- Data Visualization (BONUS)
- Reference
- Author



## System Description
Borma adalah salah satu toko serba ada (__*toserba*__) yang cukup terkenal di Kota Bandung. Toserba ini terkenal karena toko nya yang cukup luas dengan barang yang beragam dan murah dengan berbagai penawaran promo. Borma memiliki website pada laman bormadago.com yang mampu menampilkan informasi produk dan promosi yang ada. Website ini hanya tersedia untuk melakukan pemesanan dari Borma Dago.

Untuk menyempurnakan modelling dari website Borma, dalam pembuatan *ETL Project* ini saya menambahkan beberapa tabel yang relevan, yaitu Pelanggan, Supplier, Transaksi, Keranjang, dan orders.

Alasan saya memilih website ini sebagai objek dalam *web scrapping* adalah data-data produk yang beragam dan sangat variatif. Hasil analisis yang saya lakukan diharapkan bisa memberikan informasi bagi perusahaan terkait hubungan antara promo yang ditawarkan dengan jumlah penjualan produk agar perusahaan bisa menggunakan strategi pemasaran yang lebih baik untuk target pasar di sekitar Dago.

## Program Specification
Bahasa pemrograman __Python__ saya gunakan untuk melakukan *Data Scraping* dan *Data Storing* dengan library berikut,
- `Selenium`
    - __Pertimbangan__ : website Borma memiliki elemen website yang dinamis seperti adanya tombol dan gulir untuk mengakses informasi produk sehingga library ini digunakan untuk menangkap informasi produk yang tercantum di beberapa halaman yang berbeda. 
- `Beautifulsoup4`
    - __Pertimbangan__ : Beautiful Soup relatif ringan dan cepat untuk pemrosesan string HTML dibandingkan dengan Selenium. Selain itu, memungkinkan pengambilan data yang lebih spesifik dan terstruktur berdasarkan parsing HTML yang sudah dimuat.
- `psycopg2`
    - __Pertimbangan__ : Library ini berguna agar bisa menciptakan dan memasukkan data yang ada di file JSON secara otomatis ke database PSQL yang ada
- `JSON`
    - __Pertimbangan__ : memenuhi kriteria output yang diharapkan dalam format ".json"
- `re`
    - __Pertimbangan__ : library ini berguna untuk kebutuhan parsing data yang diambil dari website ekstraksi ID_Prod dari judul produk, mengambil informasi jumlah produk yang terjual, kategori produk, dan mengganti format rentang waktu (contoh dari "31 Jan 2024" menjadi "2024-01-31").
- `time`
    - __Pertimbangan__ : untuk menunda eksekusi agar memastikan halaman web telah dimuat atau elemen-elemen tertentu telah tersedia sebelum dilakukan *scrapping*.
- `os`
    - __Pertimbangan__ : untuk memastikan bahwa direktori untuk menyimpan file JSON ada, dan jika tidak maka akan membuatnya.
- `dateparser`
    __Pertimbangan__ : digunakan untuk parsing dan konversi string tanggal menjadi objek tanggal yang dapat diformat dan digunakan dengan lebih mudah.


## How To Use
### Data Scraping
1. Clone repository
```sh
    $ git clone 
```

2. Intall library di cmd
```sh
    $ pip install selenium
    $ pip install beutifulsoup4
```

3. Intall ChromeDriver
    - Intall pada halaman (https://chromedriver.chromium.org/downloads)
    - Pastikan bahwa __Chrome, ChromeDriver, dan Python__ memiliki versi yang sama (64 bit/ 32 bit)
    - Masukkan path ChromeDriver tersebut ke dalam *Environment Variables*
    - Ikuti langkah-langkah pada video berikut jika menemui bug : <a href="https://www.youtube.com/watch?v=ijT2sLVdnPM"> Fix Selenium</a>

4. Buka folder hasil cloning
```sh
    $ cd Seleksi-2024-Tugas-1/Data Scraping/src
```

5. Jalankan program 
```sh
    $ scraping.py
```

### Data Storing
1. Buat database pada __PostgreSQL__, contoh:
```sh
    host="localhost",
    user="postgres",
    password="@EgojihJiau02",
    dbname="borma_dago",
    port=5432
```

2. Intall library di cmd
```sh
    $ pip install psycopg2
```

3. Buka folder hasil cloning
```sh
    $ cd Seleksi-2023-Tugas-1/Data Scraping/src
```

4. Jalankan program 
```sh
    $ storing.py
```

5. Export database tersebut dalam formal SQL
```sh
    $ pg_dump -U <username> -d <database_name> -s > <output_file.sql>
```

## JSON Structure
Berikut adalah *6 instance* data JSON yang dihasilkan:
1. `produk.json`
```json
{
    "ID_prod": "8992761136208",
    "nama_prod": "Pulpy Orange",
    "harga_prod": "13600",
    "terjual_prod": "50",
    "kat_prod": "Minuman Rasa Buah",
    "nama_sup": "PT COCA-COLA BOTTLING INDONESIA"
}
```

2. `diskon_prod.json`
```json
{
    "ID_prod": "8995151170042",
    "nama_prod": "Mustika Ratu Gula Asem B",
    "harga_prod_norm": "7100",
    "harga_prod_disc": "4970",
    "terjual_prod": 0,
    "kat_prod": "Minuman Dalam Kemasan",
    "nama_sup": "PT MUSTIKA RATU TBK",
    "nama_prom": "Diskon Produk Sidomuncul Rtd"
}
```

3. `normal_prod.json`
```json
{
    "ID_prod": "089686010947"
}
```

4. `promo.json`
```json
{
    "nama_prom": "Free Ongkir (Min. 300,000)",
    "rentang_prom": "2024-12-31"
}
```

5. `potongan_prom.json`
```json
{
    "nama_prom": "Diskon Produk Ashitaki Mi"
}
```

6. `normal_prom.json`
```json
{
    "nama_prom": "Free Ongkir (Min. 300,000)",
    "sisa_prom": "253",
    "jumlah_prom": "10000",
    "kode_prom": "FREESHIPPING2024"
}
```

## Database Structure
### Entity Relationship Diagram
<div align="center">
  <img src="Data Storing/design/ERD.png" width="600"/>
</div>

### Relational Diagram
<div align="center">
  <img src="Data Storing/design/Diagram Relational.png" width="600"/>
</div>

### Convertion Explanation
#### __1. Pemetaan *entity* menjadi relasi__

Pemetaan entitas menjadi relasi berarti mengubah representasi entitas dalam model data menjadi tabel dalam database relasional.

a) *Strong Entity*

*Strong Entity* adalah entitas yang bisa berdiri sendiri dan memiliki *Primary Key* sendiri.
- *Produk* = (__id_prod__, nama_prod, harga_prod, terjual_prod, kat_prod, berat_prod, nama_sup)
- *Pelanggan* = (__id_pel__, nama_pel, nomor_pel, email)
- *Promo* = (__nama_prom__, rentang_prom)
- *Keranjang* = (__id_ker__, date_ker, time_ker)

`one-to-one Relationship`

Cara translasi nya adalah dengan membawa PK dari salah satu sisi sebagai FK di sisi lain yang paling sesuai (bebas)
<div align="center">
  <img src="Data Storing/design/one-to-one.png" width="600"/>
</div>

- *Transaksi* = (__id_tran__, jenis_tran, id_ker)

FK:
- *Transaksi*(id_ker) --> *Keranjang*(id_ker)

b) *Weak Entity*

*Weak Entity* adalah entitas yang tidak bisa berdiri sendiri dan bergantung pada entitas lain, serta memiliki __*diskriminator*__ (contohnya adalah atribut "Urutan" pada tabel "Orders").
<div align="center">
  <img src="Data Storing/design/Weak-Entity.png" width="600"/>
</div>


- *Orders* = (__id_ker__, __urutan__, kuantitas, id_prod)

FK:
- *Orders*(id_ker) --> *Keranjang*(id_ker)
- *Orders*(id_prod) --> *Produk*(id_prod) (*One-to-many*)

#### __2. Pemetaan *relationship* menjadi relasi__

Pemetaan relationship menjadi relasi berarti mengubah representasi hubungan antar entitas dalam model data menjadi tabel dalam database relasional.

a) Pemetaan `many-to-many relationship` menjadi relasi

Cara translasi nya adalah dengan membuat relationship antara kedua tabel menjadi entitas baru yang mengandung PK dari kedua belah sisi
<div align="center">
  <img src="Data Storing/design/many-to-many.png" width="600"/>
</div>

- *Digunakan* = (__id_prod__, __nama_prom__)

FK:
- *Digunakan*(id_prod) --> *Produk*(id_prod)
- *Digunakan*(nama_prom) --> *Promo*(nama_prom)

b) Pemetaan *ternary relationship* menjadi relasi

Relasi ternary melibatkan tiga entitas dan direpresentasikan dengan tabel yang mencakup ketiga entitas tersebut. Hubungan antara ketiga entitas tersebut akan dibuat menjadi entitas baru yang memiliki PK dari entitas denngan sisi many dan FK dari ketiga entitas.

<div align="center">
  <img src="Data Storing/design/ternary.png" width="600"/>
</div>

- *Pesanan* = (__id_prod__, __id_ker__, id_pel)

FK:
- *Pesanan*(id_prod) --> *Produk*(id_prod)
- *Pesanan*(id_ker) --> *Keranjang*(id_ker)
- *Pesanan*(id_pel) --> *Pelanggan*(id_pel)

#### __3. Pemetaan *specialization/ generalization* menjadi relasi__

Specialization/generalization adalah konsep di mana entitas dapat dibagi menjadi sub-entitas yang lebih spesifik atau digabungkan menjadi entitas yang lebih umum.

<div align="center">
  <img src="Data Storing/design/specialization.png" width="600"/>
</div>

- *Diskon_prod* = (__id_prod__, nama_prom, harga_disc)
- *Normal_prom* = (__nama_prom__, sisa_prom, jumlah_prom, kode_prom)

`One-To-Many Relationship`

Cara translasi nya adalah dengan membawa PK dari sisi One sebagai FK di sisi Many

<div align="center">
  <img src="Data Storing/design/one-to-many.png" width="600"/>
</div>

- *Normal_prod* = (__id_prod__)
- *Potongan_prom* = (__nama_prom__)

FK:
- *Diskon_prod*(id_prod) --> *Produk*(id_prod)
- *Diskon_prod*(nama_prom) --> *Potongan_prom*(nama_prom) (*One-to-many*)
- *Normal_prod*(id_prod) --> *Produk*(id_prod)
- *Potongan_prom*(nama_prom) --> *Promo*(nama_prom)
- *Normal_prom*(nama_prom) --> *Promo*(nama_prom)

__4. Pemetaan *composit attributes* menjadi relasi__

Atribut multivalued adalah atribut yang dapat memiliki lebih dari satu nilai untuk satu entitas. Dalam database relasional, atribut ini biasanya dipecah menjadi tabel terpisah.

<div align="center">
  <img src="Data Storing/design/composit.png" width="600"/>
</div>

- *Alamat_pel* = (__id_pel__, __al_jalan__, __al_NoR__)

FK:
- *Alamat_pel*(id_pel) --> *Pelanggan*(id_pel)


## Screenshot
### Tampilan *Website*
<div align="center">
  <img src="Data Scraping/screenshot/ss_website.png" width="600"/>
</div>

### Data Scrapping & Pre-processing
`Ekstraksi Data`

Program akan dijalankan dengan menggunakan parameter link website, jumlah *click* yang menentukan banyaknya halaman website yang ingin diambil datanya, dan nama file output yang diinginkan.
<div align="center">
  <img src="Data Scraping/screenshot/ss_running.png" width="600"/>
</div>

Data id dan nama produk bisa didapatkan pada halaman pertama website. untuk mendapatkan informasi tambahan seperti perusahaan dan kategori produk maka kita harus melakukan *click* pada *card* produk yang ingin di lihat (__2 kali *click*__).
<div align="center">
  <img src="Data Scraping/screenshot/ss_scraping_produk.png" width="600"/>
</div>

Selanjutnya, untuk mengakses lebih banyak produk, kita harus menggunakan *button* '__berikutnya__'.
<div align="center">
  <img src="Data Scraping/screenshot/ss_process_produk.png" width="600"/>
</div>

untuk data promo, setelah kita *click* promo tersebut, maka harus melakukan langkah yang sama dengan *scrapping* data produk __(3 kali *click*)__.
<div align="center">
  <img src="Data Scraping/screenshot/ss_scraping_potongan_info.png" width="600"/>
</div>

`Preprocessing Data`

Selanjutnya, data yang didapatkan harus diberihkan agar bisa meng-ekstrak informasi yang dibutuhkan, seperti harga dalam bentuk integer, nama produk, perusahaan, dan kategori produk
<div align="center">
  <img src="Data Scraping/screenshot/ss_data_preprocessing.png" width="600"/>
</div>

`Schema Tuning - Vertical Splitting`

Di *website* Borma terdapat produk yang memiliki diskon dan yang tidak memiliki diskon. Pengguna diasumsikan lebih sering mengakses diskon dengan produk sehingga tidak perlu menyimpan data yang jarang diakses dan untuk meminimalisir *null value* pada atribut __harga_disc__ di tabel __produk__.

Selain itu, di *website* Borma juga terdapat 2 jenis diskon, yaitu normal diskon yang bisa digunakan pada seluruh pembelian dan potongan diskon yang hanya bisa digunakan untuk produk tertentu. Karena normal diskon memiliki lebih banyak atribut daripada potonagn diskon, maka dengan alasan yang sama dengan sebelumnya kedua jenis diskon ini dipisah pada 2 tabel yang berbeda yaitu __potongan_prom__ dan __normal_prom__.
<div align="center">
  <img src="Data Scraping/screenshot/ss_scraping_promo_normal.png" width="600"/>
</div>

`Cleaning Redundancy Tuple`

Ada beberapa produk yang berulang pada data yang saya *scrapping* oleh karena itu saya membersihkannya dengan 2 cara,
1. membersihkan *redudancy* di tabel yang sama
<div align="center">
  <img src="Data Scraping/screenshot/ss_data_cleaning_1.png" width="600"/>
</div>

2. Memastikan foreign key constraint antara __diskon_prod__ dengan __prod__
<div align="center">
  <img src="Data Scraping/screenshot/ss_data_cleaning_2.png" width="600"/>
</div>

### Data Storing

Pada database borma_dago, saya melakukan *create table* dengan menggunakan psycopg2 sebagai berikut
<div align="center">
  <img src="Data Scraping/screenshot/ss_create_table.png" width="600"/>
</div>

informasi produk diskon didapatkan melalui halaman promo. Ketika proses *scrapping*, informasi produk tersebut justru terdapat di file __potongan_promo.json__ padahal seharusnya ada di __produk.json__. Cara saya menyiasatinya adalah ketika melalukan *eksport* ke __SQL__ sayang memasukkan beberapa atribut pada dari __potongan_promo.json__ ke __produk.json__
<div align="center">
  <img src="Data Scraping/screenshot/ss_storing.png" width="600"/>
</div>

## Data Visualization (BONUS)

Setelah berhasil mengumpulkan data melalui web scraping, langkah selanjutnya adalah menyajikan informasi tersebut dalam bentuk yang mudah dipahami melalui visualisasi data. Visualisasi data memungkinkan kita untuk mengidentifikasi pola, membandingkan berbagai kategori, dan menyederhanakan data kompleks sehingga lebih mudah dipahami. 

Berikut adalah hasil visualisasi yang didapatkan untuk memenuhi tujuan awal *scraping* website ini yaitu untuk membandingkan hubungan antara promo yang ditawarkan dengan jumlah penjualan produk.
<div align="center">
  <img src="Data Visualization/Visualization/1.png" width="600"/>
</div>

Data yang ada juga memberikan kesimpulan perusahaan mana saja yang paling banyak memberikan diskon, produk paling variatif, dan penjualan produk yang paling tinggi.

<div align="center">
  <img src="Data Visualization/Visualization/2.png" width="600"/>
</div>


## Reference
1. [Borma Dago Website](https://www.bormadago.com/)
2. [Dokumentasi Selenium](https://selenium-python.readthedocs.io/)
3. [Dokumentasi Beautifulsoup4](https://beautiful-soup-4.readthedocs.io/)
4. [Dokumentasi psycopg2](https://pypi.org/project/psycopg2/)
5. [Dokumentasi PostgreSQL](https://www.postgresql.org/)

## Author
Jihan Aurelia - 18222001
<div align="center">
  <h1>ETL Project: Data Scraping, Database Modeling, and Data Storing</h1>
</div>

## Author
|Nama|NIM|
|-|-|
|Naufal Adnan|13522116|

## Overview
|           |                                       |
|-----------|---------------------------------------|
|**Sumber Data** | [Rumah123](https://www.rumah123.com/) |
|**Judul**  | Data Hunian Rumah dan Apartemen di Jakarta Pusat|
|**Bahasa** | [Python](https://www.python.org/)     |
|**DBMS**   |[MariaDB](https://mariadb.org/)|
## Deskripsi
<div style="text-align: justify;">

ETL Project ini dibuat dengan mengambil informasi dari [Rumah123](https://www.rumah123.com/). Informasi yang diperoleh dikumpulkan menjadi data yang memuat informasi mengenai hunian, yaitu rumah dan apartemen di Jakarta Pusat. Data hunian tersebut mencakup berbagai aspek penting seperti harga, ukuran, lokasi, jumlah kamar, dan fasilitas yang tersedia, hingga agen pengiklan dan perusahaan afiliasinya.

### Mengapa Memilih Data Ini?
Jakarta Pusat adalah salah satu daerah yang sangat penting dan padat di Ibu Kota Indonesia. Permintaan untuk hunian, baik rumah maupun apartemen, terus meningkat karena pertumbuhan populasi dan urbanisasi. Hunian telah menjadi kebutuhan primer bagi manusia sebagai tempat berlindung, beristirahat, sekaligus tempat berpulang dari segala aktivitas. Meskipun merupakan kebutuhan primer, nyatanya semakin hari semakin sulit generasi berikutnya untuk mendapatkan hunian ([Gejolak Kawula Muda yang Makin Sulit Beli Rumah](https://www.bloombergtechnoz.com/detail-news/21037/gejolak-kawula-muda-yang-makin-sulit-beli-rumah)).

Data hunian dapat memberikan wawasan mendalam tentang tren harga, ketersediaan unit, dan perbandingan antara berbagai jenis hunian seperti rumah dan apartemen. Hal ini sangat berguna bagi pembeli, penyewa, dan investor yang ingin membuat keputusan berdasarkan informasi terkini. Lebih lanjut, pemahaman yang lebih baik mengenai data hunian dapat mempengaruhi kebijakan perumahan, perencanaan kota, dan pengembangan infrastruktur, dengan harapan dapat berdampak pada kesejahteraan sosial dan pertumbuhan ekonomi di Jakarta Pusat.

## Cara Menggunakan Scraper dan Menggunakan Hasil Outputnya
Program untuk melakukan scraping, preprocessing, hingga menyimpan data ke DBMS dibuat dalam `.ipynb` agar lebih _readable_ dan terstruktur. Mekanisme scraping dimulai dengan mengumpulkan data dari laman hunian yang dijual (https://www.rumah123.com/jual/jakarta-pusat/residensial/) dan disewakan (https://www.rumah123.com/sewa/jakarta-pusat/residensial/). Proses scraping akan dimulai dari halaman acak yang dipilih antara halaman 1 hingga halaman maksimum. Pada setiap halaman, akan dilakukan pencarian tautan (href) yang mengarah ke iklan hunian spesifik. Setelah tautan tersebut terkumpul, tautan tersebut akan dikunjungin dan di-_scraping_ untuk mendapatkan informasi hunian yang lebih rinci. Selanjutnya, sistem akan mencari tautan ke halaman agen dari informasi hunian yang telah diambil. Tautan ke halaman agen akan diakses dan di-_scraping_ untuk mendapatkan informasi lengkap mengenai agen dan perusahaan agen tersebut.

Library utama yang digunakan untuk _scraping_ adalah `bs4` dan `selenium`. `bs4` digunakan untuk _scraping_ atribut hunian secara langsung dengan mem-_parsing_ HTML untuk ekstraksi data. Sementara `selenium` digunakan untuk _scraping_ atribut agen yang memerlukan interaksi yang dinamis untuk memuat konten melalui javascript. Kombinasi ini dilakukan agar proses _scraping_ lebih cepat dan efektif sesuai kegunaan library tersebut.

**Berikut panduan penggunaannya:**
1. Clone repository
``` sh
    git clone https://github.com/nanthedom/Seleksi-2024-Tugas-1
```
2. Menjalankan
    </br>Baca petunjuk instalasi di setiap file ipynb jika ada.
    1. *Scraping*
        </br>Buka `'Data Scrapping\src\scraping.ipynb'`, lalu lakukan `Run All` sehingga semua cell di _notebook_ berhasil dijalankan. _Scraping_ membutuhkan waktu sekitar 30 hingga 1 jam untuk mendapatkan 200 data (tergantung pada sumber daya yang digunakan). Output dari proses ini adalah mendapatkan data mentah yang tersimpan di `'Data Scrapping\data\data_raw.json'`
    3. *Preprocessing*
        </br>Setelah proses _scraping_ selesai data akan di-_preprocessing_ untuk memastikan data yang diterima tidak sepenuh-penuhnya mentah sehingga dapat dipahami dengan mudah. Buka `'Data Scrapping\src\preprocessing.ipynb'`, lalu lakukan `Run All` sehingga semua cell di _notebook_ berhasil dijalankan. Output dari proses ini adalah 6 buah file yang tersimpan di folder `'Data Scrapping\data\'`, yaitu `data_clean.json`, `hunian.json`, `rumah.json`, `apartemen.json`, `agen.json`, dan `perusahaan.json`.
    4. *Storing* 
        </br>Setelah proses _preprocessing_ selesai data akan disimpan ke dalam DBMS. Buka `'Data Scrapping\src\storing.ipynb'`. Ubah variabel berikut dan sesuaikan dengan device Anda.
        ``` sh
            __HOST__        = "localhost"
            __USER__        = "root"
            __PASSWORD__    = "1234"
            __DATABASE__    = "property" 
        ```
        Lalu lakukan `Run All` sehingga semua cell di _notebook_ berhasil dijalankan. Output dari proses ini adalah sebuah file sql yang tersimpan di folder `'Data Storing\export\'`

Berikut adalah penjelasan dari masing-masing atribut yang dihasilkan oleh scraper:
|atribut|deskripsi|
|-|-|
|**id_iklan**| ID unik untuk setiap iklan properti |
|**tipe_properti**| Jenis properti yang diiklankan (Rumah dan Apartemen) |
|**luas_bangunan**| Luas bangunan dalam meter persegi |
|**kamar_tidur**| Jumlah kamar tidur tersedia |
|**kamar_mandi**| Jumlah kamar mandi tersedia |
|**lokasi**| Lokasi di mana properti berada |
|**sertifikat**| Jenis sertifikat kepemilikan properti |
|**tipe_iklan**| Jenis transaksi yang ditawarkan (jual, sewa) |
|**periode_kepemilikan**| Periode kepemilikan properti (Harian, Bulanan, Tahunan, Pemilik) |
|**harga**| Harga properti yang diiklankan |
|**diperbarui**| Tanggal terakhir kali iklan diperbarui |
|**luas_tanah**| Luas tanah dalam meter persegi |
|**carport**| Jumlah tempat parkir (carport) yang tersedia |
|**taman**| Informasi apakah properti memiliki taman atau tidak |
|**kondisi_properti**| Kondisi properti (_e.g._ Baru, Bagus, Sudah Renovasi, Butuh Renovasi, dll) |
|**kondisi_perabotan**| Kondisi perabotan yang ada di properti (_e.g._ Unfurnished, Semi Furnished, Furnished dll) |
|**id_agen**| ID unik agen yang mengiklankan properti |
|**nama_agen**| Nama agen yang mengiklankan properti |
|**nomor_telepon**| Nomor telepon agen yang bisa dihubungi |
|**terjual**| Jumlah iklan yang berhasil dijual oleh agen |
|**tersewa**| Jumlah iklan yang berhasil disewakan oleh agen |
|**nama_perusahaan**| Nama perusahaan yang menaungi agen |
|**alamat**| Alamat perusahaan properti dari agen yang mengiklankan |
|**timestamp**| Waktu saat data diambil atau di-_update_ oleh _scraper_ |

## Struktur JSON
### 1. *data_raw.json* dan *data_clean.json*
File ini berisikan data universal yang dihasilkan dari proses _scraping_. `data_raw.json` berisi data mentah, sementara `data_clean.json` berisi `data_raw` yang telah melalui _preprocessing_ sehingga siap dipakai.

- *data_raw.json*
```json
[
    {
        "id_iklan":"hos17494219",
        "tipe_properti":"Rumah",
        "luas_bangunan":"450 m\u00b2",
        "kamar_tidur":"3",
        "kamar_mandi":"3",
        "lokasi":"Menteng",
        "sertifikat":"SHM - Sertifikat Hak Milik",
        "tipe_iklan":"jual",
        "periode_kepemilikan":-1,
        "harga":"20 Miliar",
        "diperbarui":"19 Juli 2024",
        "luas_tanah":"312 m\u00b2",
        "carport":null,
        "taman":"Tidak",
        "kondisi_properti":-1,
        "kondisi_perabotan":-1,
        "id_agen":"2027871",
        "nama_agen":"Zulhana ",
        "nomor_telepon":"628179134443",
        "terjual":0,
        "tersewa":0,
        "nama_perusahaan":"BAITA PROPERTI",
        "alamat":"Jl Kemang timur no 39, Kemang Jakarta Selatan",
        "timestamp":"2024-07-25 21:08:00"
    }
]
```
- *data_clean.json*
```json
[
    {
        "id_iklan":"hos17494219",
        "tipe_properti":"Rumah",
        "luas_bangunan":450,
        "kamar_tidur":3,
        "kamar_mandi":3,
        "lokasi":"Menteng",
        "sertifikat":"SHM - Sertifikat Hak Milik",
        "tipe_iklan":"jual",
        "periode_kepemilikan":"Pemilik",
        "harga":20000000000,
        "diperbarui":"2024-07-19",
        "luas_tanah":312,
        "carport":0,
        "taman":"Tidak",
        "kondisi_properti":-1,
        "kondisi_perabotan":-1,
        "id_agen":2027871,
        "nama_agen":"Zulhana ",
        "nomor_telepon":628179134443,
        "terjual":0,
        "tersewa":0,
        "nama_perusahaan":"BAITA PROPERTI",
        "alamat":"Jl Kemang timur no 39, Kemang Jakarta Selatan",
        "timestamp":"2024-07-25 21:08:00"
    }
]
```
### 2. *hunian.json*
File ini berisikan data hunian yang dihasilkan dari `data_clean.json` dengan mengambil atribut-atribut yang merupakan bagian dari `hunian`.
```json
[
    {
        "id_iklan":"hos17494219",
        "tipe_properti":"Rumah",
        "luas_bangunan":450,
        "kamar_tidur":3,
        "kamar_mandi":3,
        "lokasi":"Menteng",
        "sertifikat":"SHM - Sertifikat Hak Milik",
        "tipe_iklan":"jual",
        "periode_kepemilikan":"Pemilik",
        "harga":20000000000,
        "diperbarui":"2024-07-19",
        "id_agen":2027871
    }
]
```
### 3. *rumah.json*
File ini berisikan data rumah yang dihasilkan dari `data_clean.json` dengan mengambil atribut-atribut yang merupakan bagian dari `rumah`.
```json
[
    {
        "id_iklan":"hos17494219",
        "luas_tanah":312,
        "carport":0,
        "taman":"Tidak"
    }
]
```
### 4. *apartemen.json*
File ini berisikan data apartemen yang dihasilkan dari `data_clean.json` dengan mengambil atribut-atribut yang merupakan bagian dari `apartemen`.
```json
[
    {
        "id_iklan":"aps3379689",
        "kondisi_properti":"Bagus",
        "kondisi_perabotan":"Furnished"
    }
]
```
### 5. *agen.json*
File ini berisikan data agen yang dihasilkan dari `data_clean.json` dengan mengambil atribut-atribut yang merupakan bagian dari `agen`.
```json
[
    {
        "id_agen":2027871,
        "nama_agen":"Zulhana ",
        "nomor_telepon":628179134443,
        "terjual":0,
        "tersewa":0,
        "nama_perusahaan":"BAITA PROPERTI"
    }
]
```
### 5. *perusahaan.json*
File ini berisikan data perusahaan yang dihasilkan dari `data_clean.json` dengan mengambil atribut-atribut yang merupakan bagian dari `perusahaan`.
```json
[
    {
        "nama_perusahaan":"BAITA PROPERTI",
        "alamat":"Jl Kemang timur no 39, Kemang Jakarta Selatan"
    }
]
```
</div>


## Struktur ERD dan Diagram Relasional
1. **ERD**
<div style="text-align: justify;">
<img src="Data Storing\design\ERD.png"> 

- Entitas
    
    1. hunian
        </br> Entitas hunian merupakan sebuah entitas yang merepresentasikan tempat tinggal yang diiklankan. Entitas hunian memiliki atribut id_iklan, tipe_properti, luas_bangunan, kamar_tidur, kamar_mandi, lokasi, sertifikat, tipe_iklan, periode_kepemilikan, harga, dan diperbarui.
    2. rumah
        </br> Entitas rumah merupakan turunan dari entitas hunian yang memiliki `tipe_properti`: `Rumah`. Entitas rumah memiliki atribut yang diturunkan dari entitas hunian dengan tiga tambahan atribut, yaitu luas_tanah, carport, dan taman.
    3. apartemen
        </br> Entitas apartemen merupakan turunan dari entitas hunian yang memiliki `tipe_properti`: `Apartemen`. Apartemen sendiri adalah jenis hunian yang berupa unit apartemen dalam sebuah gedung atau kompleks. Entitas apartemen memiliki atribut yang diturunkan dari entitas hunian dengan dua tambahan atribut, yaitu kondisi_properti dan kondisi_perabotan.
    4. agen
        </br> Entitas agen merupakan entitas yang merepresentasikan orang yang mengiklankan suatu hunian spesifik. Entitas agen memiliki atribut id_agen, nama_agen, nomor_telepon, terjual, dan tersewa.
    5. perusahaan
        </br> Entitas perusahaan merupakan entitas yang merepresentasikan perusahaan di mana agen terafiliasi dengannya. Entitas perusahaan memiliki atribut nama_perusahaan dan alamat.
    6. customer
        </br> Entitas customer merupakan entitas yang merepresentasikan pengguna yang bisa membeli atau menyewa sebuah iklan hunian spesifik. Entitas customer memiliki atribut id_customer, nama_customer, nomor_telepon, pekerjaan, pendapatan.

- Relationship

    1. ISA
        </br> Relasi ISA merupakan spesialisasi yang membagi entitas hunian menjadi dua, yaitu rumah dan apartemen berdasarkan `tipe_properti`. Setiap hunian pasti merupakan rumah atau apartemen, namun tidak bisa sekaligus keduanya sehingga memiliki _total_participation_ dan _disjoint_.
    2. mengiklankan
        </br> Hubungan mengiklankan merupakan hubungan yang menggambarkan bahwa sebuah iklan tersebut diiklankan oleh seorang agen spesifik. Setiap sebuah iklan hunian pasti diiklankan oleh satu agen dan hanya dapat diiklankan oleh satu agen. Setiap agen bisa saja mengiklankan nol atau lebih dari satu iklan hunian. Dengan begitu kardinalitas dari entity hunian dengan agen yang dihubungkan oleh mengiklankan adalah _many to one_ dengan _total participation_ di _many side_-nya.
    3. terafiliasi
        </br> Hubungan terafiliasi merupakan hubungan yang menggambarkan bahwa seorang agen terafiliasi dengan suatu perusahaan spesifik. Setiap agen hanya terafiliasi ke satu perusahaan tempat dia bekerja dan tidak ada agen yang bekerja di lebih dari satu perusahaan. Setiap perusahaan memiliki setidaknya satu agen yang terafiliasi dengannya. Dengan begitu kardinalitas dari entity agen dengan perusahaan yang dihubungkan oleh terafiliasi adalah _many to one_ dengan _total participation_ di _one side_-nya.
    4. membeli
        </br> Hubungan membeli merupakan hubungan yang menggambarkan bahwa seorang customer dapat melakukan pembelian (membeli atau menyewa) suatu iklan hunian spesifik. Setiap customer dapat membeli atau menyewa nol atau lebih sebuah iklan hunian. Setiap hunian dapat dibeli atau disewa nol atau lebih oleh seorang customer. Dengan begitu kardinalitas dari entity customer dengan hunian yang dihubungkan oleh membeli adalah _many to many_. Selain itu, setiap pembelian yang dilakukan oleh customer akan dicatat waktu dan metode pembayarannya.

- Asumsi

    1. Sebuah iklan hunian hanya dapat diiklankan oleh seorang agen dan seorang agen dapat mengiklankan nol atau lebih iklan hunian.
    2. Setiap agen hanya terafiliasi ke satu perusahaan tempat dia bekerja dan tidak ada agen yang bekerja di lebih dari datu perusahaan.
    3. Setiap perusahaan memiliki setidaknya satu agen yang terafiliasi dengannya.
</div>

2. **Relational Model**
<div style="text-align: justify;">
<img src="Data Storing\design\Relational Model.png"> 

Dari diagram relational model diperoleh tabel sebagai berikut.

- Relations:
    1. hunian(<u>id_iklan</u>, tipe_properti, luas_bangunan, kamar_tidur, kamar_mandi, lokasi, sertifikat, tipe_iklan, periode_kepemilikan, harga, diperbarui, id_agen)
    2. rumah(<u>id_iklan</u>, luas_tanah, carport, taman)
    3. apartemen(<u>id_iklan</u>, kondisi_properti, kondisi_perabotan)
    4. agen(<u>id_agen</u>, nama_agen, nomor_telepon, terjual, tersewa, nama_perusahaan)
    4. perusahaan(<u>id_agen</u>, nama_perusahaan, alamat)
    4. customer(<u>id_customer</u>, nama_customer, nomor_telepon, pekerjaan, pendapatan)
    4. membeli(<u>id_iklan, id_customer</u>, waktu, metode_pembayaran)

- Foreign Keys:
    
    1. hunian(id_agen) -> agen(id_agen)
    2. rumah(id_iklan) -> hunian(id_iklan)
    3. apartemen(id_iklan) -> hunian(id_iklan)
    4. agen(nama_perusahaan) -> perusahaan(nama_perusahaan)
    5. membeli(id_iklan) -> hunian(id_iklan)
    6. membeli(id_customer) -> customer(id_customer)

## Proses translasi ERD Menjadi Diagram Relasional
Translasi dari ER diagram menjadi relational model dilakukan dengan prosedur yang tetap mempertahankan kardinalitas dan constraint untuk masing-masing entity dan relasinya. Dari hasil translasi diperoleh 7 _relation_ sebagai berikut.

1. hunian
    </br> Relasi hunian merupakan relasi hasil dari translasi _strong entity_ hunian. Relasi hunian memiliki atribut id_iklan sebagai _primary key_, tipe_properti, luas_bangunan, kamar_tidur, kamar_mandi, lokasi, sertifikat, tipe_iklan, periode_kepemilikan, harga, diperbarui. _Entity hunian_ terhubung dengan agen oleh hubungan mengiklankan memiliki kardinalitas _many to one_ dengan _total participation_ di _many side_-nya sehingga relasi hunian memiliki tambahan atribut id_agen. Atribut id_agen ini merefer ke atribut id_agen pada relasi agen.
2. rumah
    </br> Relasi rumah merupakan relasi yang merepresentasikan hunian pada dengan `tipe_properti`: `Rumah`. Relasi ini ditranslasikan dari _entity rumah_ yang merupakan specialization dari _entity hunian_. Relasi ini memiliki atribut id_iklan sebagai _primary key_ yang merefer kepada atribut id_iklan pada relasi hunian. Selain itu, relasi rumah memiliki atribut tambahan, yaitu luas_tanah, carport, dan taman.

3. apartemen
    </br> Relasi apartemen merupakan relasi yang merepresentasikan hunian pada dengan `tipe_properti`: `Apartemen`. Relasi ini ditranslasikan dari _entity apartemen_ yang merupakan specialization dari _entity hunian_. Relasi ini memiliki atribut id_iklan sebagai _primary key_ yang merefer kepada atribut id_iklan pada relasi hunian. Selain itu, relasi apartemen memiliki atribut tambahan, yaitu kondisi_property dan kondisi_perabotan.

4. agen
    </br> Relasi agen merupakan relasi hasil dari translasi _strong entity_ agen. Relasi agen memiliki atribut id_agen sebagai _primary key_, nama_agen, nomor_telepon, terjual, tersewa, nama_perusahaan. _Entity agen_ terhubung dengan perusahaan oleh hubungan terafiliasi yang memiliki kardinalitas _many to one_ dengan _total participation_ di _one side_-nya sehingga relasi agen memiliki tambahan atribut nama_perusahaan. Atribut nama_perusahaan ini merefer ke atribut nama_perusahaan pada relasi perusahaan.

5. perusahaan
    </br> Relasi perusahaan merupakan relasi hasil dari translasi _strong entity_ perusahaan. Relasi perusahaan memiliki atribut nama_perusahaan sebagai _primary key_ dan alamat. 

6. customer
    </br> Relasi customer merupakan relasi hasil dari translasi _strong entity_ customer. Relasi customer memiliki atribut id_customer sebagai _primary key_, nama_customer, nomor_telepon, pekerjaan, pendapatan.
    
7. membeli
    </br> Relasi membeli merupakan relasi yang menggambarkan hubungan antara customer dan iklan hunian yang dibeli atau disewanya. Relasi ini merupakan hasil dari translasi relationship membeli. Pada relatonship membeli ini memiliki kardinalitas many to many antara customer dengan hunian sehingga relasi membeli yang dihasilkan mengandung atribut yang diambil dari _primary key_ customer dan hunian. Relasi membeli memiliki atribut id_iklan, id_customer, waktu, dan metode_pembayaran. _Primary key_ pada relasi ini adalah id_iklan dan id_customer. Atribut id_iklan merefer ke atribut id_iklan pada relasi hunian. Sementara Atribut customer merefer ke atribut customer pada relasi customer.

Seluruh relasi yang dihasilkan telah memenuhi bentuk normal form `BCNF`. Sebuah relasi R berada dalam Boyce-Codd Normal Form (BCNF) jika dan hanya jika untuk setiap ketergantungan fungsional X → Y yang berlaku dalam R,  maka X → Y adalah trivial atau X adalah superkey dari R.

## Scheduling
Seiring berkembangnya waktu, mungkin saja informasi iklan hunian yang ada di [Rumah123](https://www.rumah123.com/) memiliki pembaruan. Oleh karena itu, perlu dibuat adanya program yang mengotomatisasi keseluruhan proses tersebut, mulai dari scraping, preprocessing, hingga storing ke DBMS.

Implementasi penjadwalan keseluruhan proses dilakukan menggunakan packages `nbformat` untuk mengeksekusi notebook dan `schedule` untuk membuat job dan mengeksekusi job. Fungsi job mencakup penetapan direktori kerja saat ini, pengeksekusian notebook untuk scraping, preprocessing, dan storing, serta mencetak timestamp saat job mulai dijalankan. 

Untuk mengatasi redundansi akibat adanya informasi yang sama yang ter-_scraping_ kembali, maka dilakukan penanganan di bagian _scraping_ (`scraping.ipynb`) dan _storing_ (`storing.ipynb`) ke DBMS-nya. 
1. Pada _scraping_, setelah informasi telah selesai di-_scraping_, maka hasil _scraping_ tersebut akan dilakukan _merging_ terhadap data yang sudah di-_scraping_ sebelumnya (jika ada). _Merging_ dilakukan berdasarkan id_iklan yang mengidentifikasi unik satu baris data universal tersebut. Jika terdapat id_iklan yang sama, _merging_ dilakukan dengan mempertahankan data dengan timestamp yang terbaru dan timestamp yang lama akan dihapus. Dengan begitu, maka hasil _scraping_ merupakan gabungan dari hasil _scraping_ sebelumnya yang telah ter-_update_ ditambah hasil _scraping_ yang terbaru.
2. Pada _storing_, penanganan dilakukan ketika data hasil _scraping_ yang telah di-_preprocessing_ siap dimasukkan. Pada saat melakukan insert, penanganan diimplementasikan untuk melakukan update menggunakan `ON DUPLICATE KEY UPDATE`. _Key_ tiap tabelnya pun berbeda-beda sesuai dengan _primary key_ yang mengidentifikasi unik baris tiap tabelnya.

</div>

## Screenshot
### scraping.ipynb

<img src="Data Scraping\screenshot\scraping\1_definisi_global.png"> 
<img src="Data Scraping\screenshot\scraping\2_get_function.png"> 
<img src="Data Scraping\screenshot\scraping\3_get_property.png"> 
<img src="Data Scraping\screenshot\scraping\4_get_agen.png"> 
<img src="Data Scraping\screenshot\scraping\5_display_status.png"> 
<img src="Data Scraping\screenshot\scraping\6_scraping.png"> 
<img src="Data Scraping\screenshot\scraping\7_merging.png"> 
<img src="Data Scraping\screenshot\scraping\8_main.png"> 

### preprocessing.ipynb
<img src="Data Scraping\screenshot\preprocessing\1_definisi_global.png"> 
<img src="Data Scraping\screenshot\preprocessing\2_functions.png"> 
<img src="Data Scraping\screenshot\preprocessing\3_preprocessing.png"> 
<img src="Data Scraping\screenshot\preprocessing\4_storing_to_json.png"> 
<img src="Data Scraping\screenshot\preprocessing\5_main_preprocessing.png"> 
<img src="Data Scraping\screenshot\preprocessing\6_show_result.png"> 

### storing.ipynb
<img src="Data Scraping\screenshot\storing\1_definisi_global.png"> 
<img src="Data Scraping\screenshot\storing\2_create_schema.png"> 
<img src="Data Scraping\screenshot\storing\3_insert_query.png"> 
<img src="Data Scraping\screenshot\storing\4_execute_create_n_insert.png"> 
<img src="Data Scraping\screenshot\storing\5_constraints.png"> 
<img src="Data Scraping\screenshot\storing\6_triggers.png"> 
<img src="Data Scraping\screenshot\storing\7_dump_database.png"> 

### DBMS

**- Tabel**

<img src="Data Storing\screenshot\tables\tables.png"> 
<img src="Data Storing\screenshot\tables\hunian.png"> 
<img src="Data Storing\screenshot\tables\rumah.png"> 
<img src="Data Storing\screenshot\tables\apartemen.png"> 
<img src="Data Storing\screenshot\tables\agen.png"> 
<img src="Data Storing\screenshot\tables\perusahaan.png"> 
<img src="Data Storing\screenshot\tables\customer.png"> 
<img src="Data Storing\screenshot\tables\membeli.png"> 

**- Insert**

<img src="Data Storing\screenshot\insert\hunian.png"> 
<img src="Data Storing\screenshot\insert\rumah.png"> 
<img src="Data Storing\screenshot\insert\apartemen.png"> 
<img src="Data Storing\screenshot\insert\agen.png"> 
<img src="Data Storing\screenshot\insert\perusahaan.png"> 

**- Constraints**

<img src="Data Storing\screenshot\constraints\key_constraints.png"> 
<img src="Data Storing\screenshot\constraints\unique_n_check_constraints.png"> 

**- Triggers**

<img src="Data Storing\screenshot\triggers\list_triggers.png"> 
<img src="Data Storing\screenshot\triggers\trigger_diperbarui_date.png"> 
<img src="Data Storing\screenshot\triggers\trigger_insert_apartemen.png"> 
<img src="Data Storing\screenshot\triggers\trigger_insert_rumah.png"> 
<img src="Data Storing\screenshot\triggers\trigger_update_agen.png"> 

## Referensi
| Website |  URL  |
|--------------|----|
| Rumah123     |https://www.rumah123.com/|


| Libraries | |
|----------|----------|
| Scraping | BeautifulSoup (bs4), selenium, request, re, os, pandas, json, IPython, math, time, random, datetime |
| Preprocessing | pandas, locale, re, os, datetime |
| Storing | MySQLdb, os, json, subprocess |
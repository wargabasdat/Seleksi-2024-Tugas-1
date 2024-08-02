# Seleksi Asisten Basis Data

## Author:
Keanu Amadius Gonza Wrahatno		(13522082)


## Table of Contents
* [Deskripsi](#Deskripsi)
* [Scraper](#Scraper)
* [Struktur JSON](#Struktur-JSON)
* [Struktur ERD](#Struktur-ERD)
* [Struktur Relational Database](#Struktur-Relational-Database)
* [Proses translasi](#Proses-translasi)
* [Website](#Website)
* [Data RDBMS](#Data-RDBMS)


## Deskripsi
Data ini dibuat pada MySQL berisikan data mobil bekas di marketplace OLX. Topik ini diambil karena ingin mengetahui data apa saja yang disampaikan kepada pembeli di web olx. Saya ingin mengetahui mobil mana yang paling worth it untuk dibeli melihat dari harga, spesifikasi yang ditawarkan, dan penjual. Selain itu saya juga ingin mengetahui apakah data yang didapat dari web olx dapat diaplikasikan pada RDBMS. Saya menggunakan MySQL untuk mengimplementasikan tugas ini.


## Scraper
Scraper dilakukan menggunakan bahasa python dengan BeautifulSoup dan selenium. </br>
![pagination](Data%20Scraping/screenshot/forREADME/pagination.png)

- Pertama webdriver akan membuka web 'https://www.olx.co.id/items/q-Mobil'. 
- Lalu webdriver akan klik tombol muat lainnya sampai 20 kali. Pada tiap halaman akan discrap semua link produk mobil, nama postingan, dan tahun. 

![link Produk](Data%20Scraping/screenshot/forREADME/linkProduk.png)
Setiap link produk yang di scrap akan dibuka lagi menggunakan web driver dan diambil informasi berupa judul, bbm, km, transmisi, harga, dp, dan cicilan. 

![link Profil](Data%20Scraping/screenshot/forREADME/linkProfil.png)
Setelah itu, apabila penjualnya bukan dari OLX Mobbi, akan dibuka profilnya dan diambil informasi berupa nama penjual, keterangan, dan jumlah iklan. </br>
Lalu dilakukan preprocessing pada data:
![preprocessing](Data%20Scraping/screenshot/forREADME/preprocessing.png)

- Data lokasi didapat dengan format <Kota, Provinsi>, sehingga perlu dilakukan parsing untuk memisahkan kota dan provinsi </br>
- Untuk data harga cicilan dan dp masih dengan format Rp xx.xxx.xxx, maka kita lakukan parsing sehingga yang diambil hanya angkanya saja. </br>
- Lalu data yang sudah didapat difilter dengan mengahpus data yang tidak memiliki km atau nama_penjual. Hal ini dilakukan agar adata yang diambil menjadi bagus. Karena jikadata km tidak ada, kemungkinna produk yang dijual bukanlah mobil melainkan aksesoris nya. </br>
- Setelah itu kita lakukan cleansing kembali dengan menghapus data yang jenis_penjual atau kapasistas_mesin bernilai '--' </br>
- Terakhir hapus data duplikat

![pandas](Data%20Scraping/screenshot/pandas.png)
Data yang didapatkan disimpan terlebih dahulu pada pandas lalu diubah ke file JSON.

## Struktur JSON
Hasil scrap hanya dibuat pada 1 file JSON saja. Dengan struktur seperti berikut: </br>
- link = merupakan link postingan produk mobil bekas
- nama = nama postingan produk mobil bekas
- judul = judul merupakan nama mobil yang dijual
- keterangan = keterangan tambahan untuk mobil yang dijual
- bbm = jenis bahan bakar yang digunakan
- km = jarak tempuh mobil yang telah digunakan
- transmisi = jenis transmisi mobil (Automatic / Manual)
- tahun = tahun keluaran mobil
- kapasitas_mesin = kapasitas mesin mobil
- kota = kota tempat mobil dijual
- provinsi = provinsi tempat mobil dijual
- harga = harga produk mobil yang dijual
- dp = dp tidak selalu ada, dp merupakan harga yang dibayarkan sebelum cicilan
- cicilan = cicilan mobil
- penjual = jenis penjual (Diler / Pribadi)
- nama_penjual = nama penjual
- ket_penjual = keterangan tambahan penjual
- penjual_sejak = tanggal bergabung penjual
- jumlah_iklan = iklan yang diposting oleh penjual

## Struktur ERD <a href="erd"></a>
ERD yang saya buata ada 2 macam yaitu:
- ERD hasil scraping
- ERD dengan entity tambahan sebagai pelengkap </br>

![ERD](Data%20Storing/design/ERD.png)
Untuk ERD hasil Scraping, strukturnya hanya ada 3 tabel yaitu penjual, mobil, dan cicilan.
- Entity penjual menyimpan informasi nama penjual, keterangan, jenis_penjual, dan jumlah_iklan. Primary key entity ini adalah nama_penjual karena nama_penjual tidak bisa sama. 
- Entity post_mobil menyimpan informasi link, judul post, nama mobil, keterangan mobil, bahan bakar, km, jenis transmisi, tahun keluaran mobil, kapasitas mesin, harga, dan lokasi. Karenalink untuk tiap post unik, maka link menjadi primary key. 
- Entity cicilan merupakan weak entitiy karena tiap mobil belum tentu bisa dicicil dan tiap mobil yang bisa dicicil kemungkinan memiliki besar yang sama dengan mobil lain, sehingga entity cicilan harus menempel dengan entity mobil. Entity ini menyimpan informasi berupa dp, total bulan selama melakukan cicilan, dan besar cicilan. Diskriminan dari entity ini adalah dp dan total_bulan karena dp dan banyaknya total bulan menentukan jumlah cicilan nantinya.
- Relationship 'memposting' merupakan relasi one to many antara entity penjual dan entity mobil karena satu penjual bisa post banyak postingan namun satu postingan hanya dapat di post satu penjual. Penjual tidak harus memposting mobil sehingga partial participation dan postingan mobil harus diposting oleh penjual sehingga total participation.
- Relationship 'dapat_cicil' merupakan relasi one to many dari mobil ke cicilan karena satu mobil bisa memiliki banyak opsi cicilan dan satu opsi cicilan hanya dapat dimiliki 1 mobil. Mobil tidak harus dapat dicicil sehingga partial participation dan cicilan harus dimiliki oleh mobil sehingga total participation. </br>

![ERD](Data%20Storing/design/ERD%20tambahan.png)
Untuk ERD dengan pelengkap tamahan memiliki entity tambahan sebagai berikut:
- Entity pembeli yang menyimpan informasi nama pembeli, no telp, email, tanggal mendaftar, dan lamanya mendaftar. Pembeli dapat memiliki banyak no telp sehingga multivalued, dan lamanya mendaftar dihitung dari hari ini dikurang tanggal mendaftar sehingga merupaka  derived attribute.
- Entity diler merupakan turunan dari entity penjual yang merepresentasikan panjual dengan jenis diler. Entity ini mempunyai atribut ttambahan yaitu reputasi penjual.
- Entity pribadi merupakan turunan dari entity penjual yang merepresentasikan panjual dengan jenis pribadi. Entity ini mempunyai atribut ttambahan yaitu nomor telepon penjual.
- Relationship 'chat' merupakan relasi many to many antara penjual dan pembeli karena satu penjual dapat chat banyak pembeli dan satu pembeli dapat chat banyak penjual. Pembeli tidak harus chat penjual dan penjual tidak harus chat oembeli sehingga keduanya partial participation.
- Relationship 'like' merupakan relasi many to many antara pembeli dan mobil karena satu pembeli dapat like banyak mobil dan satu mobil dapat di-like banyak pembeli. Pembeli tidak harus like mobil dan mobil tidak harus di-like pembeli sehingga keduanya partial participation.
- Relationship 'IS A'  membagi penjual menjadi dua jenis, yaitu diler dan pribadi berdasarkan atribut jenis.Semua penjual merupakan salah satu dari diler atau pribadi sehingga penjual memiliki total participation terhadap IS A. Penjual hanya boleh menjadi salah satu dari diler atau pribadi sehingga merupakan disjoint.  

## Struktur Relational Database <a href="relational"></a>
![Relational](Data%20Storing/design/Relational.png)
Struktur ini memiliki 9 relasi yaitu :
- Relasi penjual dengan primary key nama_penjual
- Relasi diler dengan primary key nama_penjual. Atribut nama_penjual foreign key ke nama_penjual pada relasi penjual
- Relasi pribadi dengan primary key nama_penjual. Atribut nama_penjual foreign key ke nama_penjual pada relasi penjual
- Relasi postingan_mobil dengan primary key nama_penjual dan nama_mobil. nama_penjual foreign key ke nama_penjual pada relasi penjual
- Relasi cicilan dengan primary key nama_penjual, nama_mobil, dp, total_bulan. nama_penjual foreign key ke nama_penjual pada relasi penjual. nama_mobil foreign key ke nama_mobil pada relasi postingan_mobil
- Relasi pembeli memiliki primary key nama_pembeli
- Relasi telp_pembeli dengan primary key nama_pembeli dan no_telp. nama_pembeli foreign key ke nama_pembeli pada relasi pembeli.
- relasi chat dengan primary key nama_mobil, nama_penjual, dan nama_pembeli. nama_mobil foreign key ke nama_mobil pada relasi postingan_mobil. nama_pejual foreign key ke nama_penjual pada relasi penjual. nama_pembeli foreign key ke nama_pemeli pada relasi pembeli.
- relasi like dengan primary key nama_mobil, nama_penjual, dan nama_pembeli. nama_mobil foreign key ke nama_mobil pada relasi postingan_mobil. nama_pejual foreign key ke nama_penjual pada relasi penjual. nama_pembeli foreign key ke nama_pemeli pada relasi pembeli.


## Proses translasi <a href="translasi"></a>
- Buat relasi penjual dengan mentranslasi entity penjual di ERD
- Setelah itu buat relasi diler dengan primary key sekaligus foreign key pada primary key di entity penjual (nama_penjual) dengan tambahan atribut reputasi.
- Setelah itu buat relasi pribadi dengan primary key sekaligus foreign key pada primary key di entity penjual (nama_penjual) dengan tambahan atribut no_telp.
- Karena entity mobil merupakan weak entity, sehingga diskriminator menjadi primary key dan perlu menambahakan primary key di penjual (nama_penjual). Tambahkan foreighn key pada nama_penjual. Transalasinya yaitu relasi postingan_mobil.
- Entity cicilan merupakan weak entity ke mobil yang juga weak entity ke penjual sehingga pada translasinya diskriminator entity cicilan (dp, total_bulan) dan diskriminator mobil (nama_mobil) menjadi primary key. Tambahkan juga primary key pada entity penjual. Tambahkan foreign key pada nama_penjual dan nama_mobil.Transalasinya yaitu relasi cicilan.
- Buat relasi pembeli dengan mentranslasi entity pembeli di ERD
- Atribut no_telp pada entity pembeli merupakan multivalued sehingga perlu dibuat relasi sendiri bernama telp_pembeli yang memiliki primary key no_telp dan nama_pembeli. Tambahkan foreign key pada nama_pembeli
- Karena relationship chat merupakan many to many dari pembeli ke gabungan penjual dan mobil, sehingga translasikan dengan membentuk relasi chat dan menambahkan primary key sekaligus foreign key pada pembeli, penjual, dan mobil. Tambahkan juga atribut waktu dan isi_teks
- Karena relationship chat merupakan many to many dari pembeli ke gabungan penjual dan mobil, sehingga translasikan dengan membentuk relasi chat dan menambahkan primary key sekaligus foreign key pada pembeli, penjual, dan mobil. Tambahkan juga atribut waktu dan isi_teks
- Karena relationship like merupakan many to many dari pembeli ke mobil, sehingga translasikan dengan membentuk relasi like dan menambahkan primary key sekaligus foreign key pada pembeli dan mobil. Dikarenakan mobil meruakan weak entity sehingga tambahkan juga primary key dari entity penjual.

## Website
Website yang saya scraping yaitu olx
### Bagian halaman penjualan mobil bekas
![mainWeb](Data%20Scraping/screenshot/forREADME/ssWeb_main.png)
### Bagian Produk
![produkWeb](Data%20Scraping/screenshot/forREADME/ssWeb_produk.png)
### Bagian Profil
![profilWeb](Data%20Scraping/screenshot/forREADME/ssWeb_profil.png)

## Data RDBMS
### Melihat isi data
- Tabel penjual
![data](Data%20Storing/screenshot/tabel_penjual_atas.png)
![data](Data%20Storing/screenshot/tabel_penjual_bawah.png)

- Tabel cicilan
![data](Data%20Storing/screenshot/tabel_cicilan_atas.png)
![data](Data%20Storing/screenshot/tabel_cicilan_bawah.png)

- Tabel post_mobil
![data](Data%20Storing/screenshot/tabel_post_mobil_atas.png)
![data](Data%20Storing/screenshot/tabel_post_mobil_bawah.png)

</br>

Selaian itu saya juga menambahkan trigger sehingga harga pada post_mobil, dp pada cicilan, dan cicilan pada cicilan tidak boleh bernilai negatif
![trigger](Data%20Storing/screenshot/trigger.png)

</br>

### Constraint
- tabel penjual
![trigger](Data%20Storing/screenshot/show_penjual.png)
- tabel post_mobil
![trigger](Data%20Storing/screenshot/show_post_mobil.png)
disini ditambahkan foreign key apabila nama_penjual di penjual dihapus, maka nama_penjual di post_mobil juag dihapus. Untuk atribut judul juga tidak boleh null
- tabel cicilan
![trigger](Data%20Storing/screenshot/show_cicilan.png)
disini ditambahkan foreign key apabila link pada post mobil dihapus, maka link pada cicilan juga dihapus (on delete cascade). 

### Describe
![trigger](Data%20Storing/screenshot/describe_all_tables.png)

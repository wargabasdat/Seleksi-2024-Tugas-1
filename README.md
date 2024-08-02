<h1 align="center">
  <br>
  Seleksi Warga Basdat 2024 <br>
  Stage 2 <br>
  Topik : Spesialis Gizi Klinik di Halodoc
  <br>
  <br>
</h1>

<h2 align="left">
  <br>
  Author
  <br>
</h2>

|          Nama             |      NIM      |
| ------------------------- | ------------- |
| Shabrina Maharani         |    13522134   |

<h2 align="left">
  <br>
  Deskripsi Data
  <br>
</h2>
Pada tahap kedua Seleksi Warga Basdat 2024, saya memilih topik mengenai dokter spesialis gizi klinik di platform kesehatan online Halodoc. Topik ini berfokus pada para ahli gizi yang dapat melakukan konsultasi secara online melalui Halodoc. Data yang dikumpulkan mencakup informasi penting seperti nama dan gelar, pengalaman kerja (dalam hitungan tahun), lokasi praktik offline, riwayat pendidikan, nomor STR sebagai bukti legalitas, angka rating konsultasi, serta harga konsultasi selama 30 menit. 
  <br>
Proses pengumpulan data dilakukan dengan metode web scraping, yang memungkinkan saya mendapatkan data yang akurat dan terkini. Saya memilih topik ini karena memiliki ketertarikan dalam bidang kesehatan, khususnya gizi, yang semakin relevan dan penting dalam beberapa tahun terakhir. Saya ingin mengetahui lebih dalam tentang para profesional yang menyediakan layanan konsultasi gizi, mengingat meningkatnya kesadaran masyarakat akan pentingnya pola makan yang sehat. 
  <br>
Selain itu, pengalaman positif saya berkonsultasi tentang gizi di Halodoc mendorong saya untuk mengeksplorasi lebih lanjut dan menganalisis data ini secara sistematis. Dengan membuat basis data (DBMS) untuk topik ini, akan memudahkan untuk melihat detail informasi mengenai masing-masing dokter tanpa harus mencari dan memeriksa halaman web satu per satu secara manual. Ini tidak hanya memudahkan akses informasi, tetapi juga meningkatkan efisiensi dalam mencari layanan konsultasi gizi yang tepat.
  <br>

## Step 1: Data Scraping
### A. Technologies Used
- MariaDB v11.3
- Go v1.22
- VSCode
### B. Panduan Penggunaan Scraper
1. Clone Repository
    - Buka terminal
    - Pastikan Anda berada di direktori tempat Anda ingin menyimpan repository ini
    - Jalankan perintah berikut untuk meng-clone repository:
        ```
        git clone https://github.com/Maharanish/TUGAS_SELEKSI_2_13522134
        ```

2. Pindah ke Direktori Data Scraping/src
    ```
    cd TUGAS_SELEKSI_2_13522134/Data\ Scraping/src
    ```
3. Setup Lingkungan Go
    - Sebelum menjalankan scraper, pastikan Go sudah terinstall di komputer Anda. Jika belum, ikuti [petunjuk instalasi Go](https://go.dev/doc/install) sesuai sistem operasi yang Anda gunakan.  
    - Setelah Go terinstall, unduh semua dependency yang diperlukan dengan perintah:
        ```
        go mod tidy
        ```
4. Jalankan Program Scraper dengan menggunakan perintah berikut:
    ```
    go run scraper.go
    ```
5. Output
    Setelah menjalankan program, akan dihasilkan output berupa data-data dokter spesialis gizi klinik dari platform Halodoc yang akan ditampilkan pada terminal. Data ini secara otomatis akan disimpan dalam format JSON pada folder data.

### B. Penjelasan struktur file JSON
Struktur file JSON dari hasil scraping terdiri dari array objek, di mana setiap objek mewakili seorang dokter spesialis gizi klinik. Berikut adalah penjelasan detail mengenai setiap elemen dalam objek:

- **Name**: Nama lengkap dokter beserta gelar akademisnya.
- **DoctorURL**: URL untuk halaman profil dokter di platform Halodoc.
- **Experience**: Jumlah tahun pengalaman dokter bekerja sebagai dokter.
- **Rating**: Rating yang diberikan kepada dokter berdasarkan ulasan pasien, dinyatakan dalam persentase.
- **Price**: Biaya konsultasi dokter untuk durasi 30 menit, dinyatakan dalam satuan mata uang rupiah.
- **Education**: Array objek yang berisi informasi mengenai riwayat pendidikan dokter. Setiap objek dalam array ini memiliki dua properti:
  - **University**: Nama universitas tempat dokter memperoleh gelar.
  - **Year**: Tahun kelulusan dari universitas tersebut.
- **PracticeLocation**: Array objek yang berisi informasi mengenai lokasi praktik dokter. Setiap objek memiliki dua properti:
  - **City**: Nama kota tempat dokter berpraktik.
  - **Province**: Nama provinsi tempat dokter berpraktik.
- **StrNumber**: Nomor Surat Tanda Registrasi (STR) yang menunjukkan legalitas praktik dokter.

Data dalam file JSON yang sudah ada pada folder _Data Scraping/data_ merupakan hasil scraping dari platform Halodoc pada tanggal **02 Agustus 2024 pukul 01.00 WIB**. Penting untuk dicatat bahwa informasi dalam file ini adalah snapshot dari waktu scraping tersebut, sehingga jika dilakukan scraping ulang, hasilnya mungkin akan berbeda dengan file JSON yang ada, karena adanya pembaruan informasi dari platform Halodoc.

## Step 2: Data Modeling + Data Storing
### A. Struktur ERD
<div align="center">
  <img src="Data Storing/design/ERD.png" alt="ERD" />
</div>

ERD (Entity-Relationship Diagram) untuk dokter spesialis gizi klinik di Halodoc terdiri dari beberapa tabel yaitu Doctor, Education, City, dan Province. Tabel **Doctor** menyimpan informasi penting tentang dokter, seperti `idDoctor` sebagai _primary key_, `price` untuk harga konsultasi selama 30 menit, `str_number` sebagai nomor STR yang merupakan bukti legalitas dokter, `doctor_name` yang mencakup nama dan gelar dokter, `rating` yang menunjukkan angka rating konsultasi, `experience` yang menggambarkan pengalaman kerja dalam hitungan tahun, dan `doctor_url` sebagai URL halaman dokter di platform Halodoc. Tabel ini dibuat menjadi _strong entity_ karena entitas ini dapat dibedakan dengan entitas lainnya dan tidak saling bergantung dengan entitas lainnya.

Tabel **Education** menyimpan informasi tentang riwayat pendidikan dokter dengan atribut seperti `idEducation` sebagai _discriminator_, `graduate_year` yang menunjukkan tahun lulus, dan `univ_name` yang mencantumkan nama universitas. Entitas merupakan _weak entity_ karena data pendidikan ini bergantung pada `idDoctor` (entitas Doctor) untuk memberikan konteks tentang siapa yang memiliki pendidikan tersebut.

Tabel **City** menyimpan informasi tentang kota tempat praktik dokter, dengan atribut `idCity` sebagai _primary key_ dan `city_name` sebagai nama kota. Tabel ini merupakan strong entity karena entitas ini dapat dibedakan dengan entitas lainnya dan tidak saling bergantung dengan entitas lainnya.

Tabel **Province** menyimpan informasi tentang provinsi tempat kota berada, dengan atribut `idProvince` sebagai _primary key_ dan `province_name` sebagai nama provinsi. Seperti tabel City, tabel Province juga merupakan strong entity.

Relasi antar tabel dalam ERD ini mencakup beberapa jenis hubungan. Relasi **educate** antara Doctor dan Education adalah one-to-many, yang berarti satu dokter dapat memiliki beberapa (minimal 1) riwayat pendidikan, tetapi satu riwayat pendidikan hanya dimiliki oleh satu dokter. Relasi **practice** antara Doctor dan City adalah many-to-many, yang memungkinkan satu dokter untuk berpraktik di beberapa (minimal 0) kota, dan satu kota bisa memiliki beberapa (minimal 1) dokter yang berpraktik di sana. Relasi **locate** antara City dan Province adalah many-to-one, yang berarti satu kota hanya berada di satu provinsi, tetapi satu provinsi dapat memiliki banyak (minimal 1) kota. 

### B. Translasi Struktur ERD ke Diagram Relasional RDBMS

<div align="center">
  <img src="Data Storing/design/Model_Relasional_Hasil_Reducing_ERD.png" alt="hasil transformasi" />
</div>

Translasi dari ERD ke diagram relasional melibatkan beberapa langkah penting untuk mengonversi struktur data dari diagram menjadi tabel yang dapat diimplementasikan dalam sistem basis data relasional. Translasi ini dilakukan sesuai dengan konsep yang diajarkan pada mata kuliah basis data terutama pada materi _"Reducing E-R Diagrams to Relational Schemas_

Entitas `Doctor` pada ERD merupakan _strong entity_ sehingga pada diagram relasional entitas `Doctor` ini menjadi sebuah relasi tersendiri yaitu relasi `Doctor` yang memiliki _primary key_ berupa idDoctor. Entitas `Education`pada ERD merupakan _weak entity_ sehingga pada diagram relasional entitas Doctor ini menjadi sebuah relasi tersendiri yaitu relasi `Education` dimana diskriminator berupa idEducation akan menjadi _primary key_ dan karena entitas ini bergantung pada entitas `Doctor`, maka idDoctor akan ditambahkan ke relasi `Education` sebagai _primary key_ sekaligus _foreign key_ yang menunjuk pada idDoctor pada relasi `Doctor`.

Entitas `City` pada ERD merupakan _strong entity_ sehingga pada diagram relasional entitas `City` ini menjadi sebuah relasi tersendiri yaitu relasi `City` yang memiliki _primary key_ berupa idCity dan ditambahkan atribut `idProvince` sebagai _Foreign Key_ (FK) untuk menunjukkan hubungan dengan tabel `Province`. Entitas `Province` pada ERD merupakan _strong entity_ sehingga pada diagram relasional entitas `Province` ini menjadi sebuah relasi tersendiri yaitu relasi `Doctor` yang memiliki _primary key_ berupa idProvince.

Hubungan `practice` antara `Doctor` dan `City` dalam ERD merupakan hubungan many-to-many sehingga ditranslasi menjadi relasi baru `Practice` dengan atribut `idDoctor` (FK1) dan `idCity` (FK2) sebagai PK sekaligus FK. Namun, karena keterbatasan pada MariaDB, terdapat beberapa konsep yang tidak dapat diimplementasikan seperti, PK yang lebih dari ataupun PK yang berperan sekaligus menjadi FK. Oleh karena itu, terjadi penyesuaian terhadap model relasional tersebut yang dapat dilihat pada bagian C.

### C. Diagram Relasional 

<div align="center">
  <img src="Data Storing/design/Model_Relasional_Disesuaikan_dengan_Batasan_SQL_dan_Tabel_Tambahan.png" alt="fix diagram relasional" />
</div>

Diagram relasional tersebut sudah disesuaikan agar dapat diimplementasikan dalam MariaDB dan terdapat beberapa tambahan tabel lain yang relevam berupa Patient, Contact, dan Checkup. Relasi `Patient` menyimpan informasi tentang data `Patient`. Relasi `Contact` menyimpan informasi tentang kontak dokter dan pasien. Terakhir, relasi `Checkup` menyimpan informasi tentang pencatatan dokter memeriksa pasien.

## Bonus:
Task-task berikut merupakan bonus yang **TIDAK WAJIB** dilakukan oleh peserta seleksi. Penyelesaian satu atau lebih dari task bonus akan membawa nilai tambahan bagi peserta yang menyelesaikannya. Peserta dibolehkan untuk mengerjakan sebagian atau seluruh dari task bonus yang tersedia
1. Buatlah visualisasi data dalam bentuk _dashboard_ dari data yang didapatkan dari proses data scraping. Berikan penjelasan mengenai _insight_ yang didapatkan dari visualisasi data tersebut. Tools yang digunakan untuk membuat dashboard dibebaskan pada peserta.

## Hasil Program


## Referensi/Library
- [Go Documentations](https://go.dev/doc/)
- [goquery](https://pkg.go.dev/github.com/PuerkitoBio/goquery)
- [MariaDB Documentations](https://mariadb.com/kb/en/documentation/)
- [PPT Mata Kuliah Basis Data 2024](https://drive.google.com/drive/u/0/folders/1i-abemxg0DqXBvhx6oIScHGqFraqo47E)






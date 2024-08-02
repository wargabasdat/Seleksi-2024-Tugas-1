
# Astra Honda Motor: Data Scraping, Processing, and Management with Python and PostgreSQL

Projek ini dikerjakan sebagai tugas kedua seleksi asisten lab. Di dalam projek ini, saya menggunakan web (https://www.hondacengkareng.com/). Saya memilih menggunakan web ini karena saya tertarik untuk melihat data-data peralatan / aksesoris motor yang digunakan oleh web serta saya ingin mengetahui perbandingan data aksesoris motor bila diklasifikasikan sesuai dengan kategorinya. 

Untuk projek ini sendiri, saya menggunakan tools berupa python dan PostgreSQL. Saya menggunakan python karena akses menggunakan selenium untuk kepentingan scraping. Saya juga menggunakan PostgreSQL dalam projek ini karena merupakan database relasional dan memiliki fitur constraints seperti trigger, primary key, dan foreign key. 


## Penjelasan Resource

### Pengambilan Data dengan Selenium dan Python

Script ini memanfaatkan Selenium, sebuah framework otomatisasi web populer, untuk mengambil data dari situs web. Berikut adalah komponen-komponennya:

- Selenium WebDriver: Mengontrol browser web (misalnya, Chrome, Firefox) untuk menavigasi dan berinteraksi dengan halaman web.
- Pandas: Sebuah pustaka manipulasi data yang kuat digunakan untuk menyimpan dan memproses data yang diambil.
- OS: Menyediakan fungsionalitas untuk berinteraksi dengan sistem operasi, seperti operasi file dan direktori.

### Fitur Utama : 

- Interaksi Browser Otomatis: Selenium WebDriver digunakan untuk membuka halaman web, mengisi formulir, mengklik tombol, dan melakukan interaksi otomatis lainnya.
- Penanganan Konten Dinamis: Script ini dapat menunggu elemen tertentu untuk dimuat menggunakan WebDriverWait dan expected_conditions, memastikan bahwa konten dinamis yang mungkin memerlukan waktu untuk muncul dapat diambil.
- Ekstraksi Data: Data yang diambil diorganisir dan disimpan menggunakan Pandas, memudahkan pemrosesan dan analisis data lebih lanjut.

### Data Processing menggunakan pustaka 'np(numpy' dan 'pd(pandas)'

1. Pandas ('pd) : 
- Fungsi: Mempermudah manipulasi data, seperti mengonversi tipe data dan membersihkan nilai kosong.
- Penggunaan: Mengganti nilai kosong dengan NaN, dan mengonversi kolom ke tipe data yang sesuai (seperti string atau numerik).

2. numpy ('np')
- Fungsi: Menyediakan dukungan untuk data numerik dan operasi matematika.
- Penggunaan: Menggunakan np.nan untuk mengganti nilai kosong, memastikan data yang hilang ditandai dengan benar.

## Database Structure



![ER Diagram]("https://github.com/bastianns/TUGAS_SELEKSI_2_18222053/blob/243f485c7344d62c82f88d5c5c13eea0f9fcb182/Data%20Storing/design/Relation%20Diagram%20astra.png?raw=true")


1. Transformasi one to many : 
    - Pesanan = (ID_Pesanan (pk), Nama_Produk, Jumlah, Harga, ID_Akun(pk))
2. Transformasi One to One : 
    - Transaksi = (ID_Transaksi, Jenis_Pembayaran, Konfirmasi_Pembayaran, ID_Pembelian)
    - Pesanan = (ID_Pesanan, Nama_Produk, Jumlah, Harga, ID_Akun)
    - Pembelian = (ID_Pembelian, Nama_Produk, Harga_Total, ID_Pesanan)

3. Transformasi Many to Many : 
    - Pesan = (kode_Produk, ID_Pesanan)
    - Cek_Diskon = (Nama_Produk, Kode_Produk)

4. Transformasi Spesialisasi : 
    - Peralatan_Motor = (Kode_Produk, Warna, Dimensi, Motor_Implementasi)
    - Motor = (Kode_Produk, Fitur)
    - Oli = (Kode_Produk, Spesifikasi)

## Data Scrapping

### Langkah Utama
1. Inisialisasi webdriver : 
-  Selenium memerlukan WebDriver untuk berinteraksi dengan browser. Kami menggunakan ChromeDriver dalam contoh ini.
- WebDriver diinisialisasi dan diarahkan ke URL situs web yang akan di-scrape.

2. Navigaso dan Interaksi dengan Halam Web : 
- Akses Halaman: Mengarahkan WebDriver ke halaman yang ditargetkan.
- Menunggu Elemen: Selenium menggunakan WebDriverWait untuk menunggu elemen-elemen tertentu muncul di halaman, memastikan bahwa elemen yang diperlukan sudah tersedia sebelum diakses.
- Klik dan Ambil Data: Mengklik elemen-elemen seperti thumbnail produk atau link untuk mengakses detail produk. Data seperti nama produk, harga, kategori, dan fitur diambil dari elemen-elemen yang relevan.

3. Pengambilan Data : 
 - Mengambil semua atribut yang diinginkan dan dibutuhkan sesuai konteks dan kategori 

4. Navigasi Halaman : 
- Kembali ke Halaman Sebelumnya: Setelah data diambil, WebDriver kembali ke halaman sebelumnya untuk mengakses produk berikutnya.
- Navigasi Antar Halaman: Jika ada beberapa halaman, WebDriver dapat berpindah ke halaman berikutnya dengan mengklik tombol navigasi.
5. Penanganan Kesalahan : 
- Pengelolaan Kesalahan: Menangani berbagai kemungkinan kesalahan selama proses scraping, seperti elemen yang tidak ditemukan atau masalah dengan navigasi.
6. Simpan Data : 
- Kumpulkan dan Cetak Data: Data yang dikumpulkan selama proses scraping dicetak untuk verifikasi dan analisis lebih lanjut.

### Persyaratan 

- Selenium : pastikan paket Python Selenium sudah terinstal
- WebDriver: Download dan konfigurasi WebDriver yang sesuai untuk browser yang digunakan (misalnya, ChromeDriver untuk Google Chrome).

## Data Visualization

Dalam memvisualisasikan data motor Honda yang diambil dari file CSV. Saya menggunakan tiga jenis hasil grafik utama : 

- Box Plot untuk menunjukkan distribusi harga berdasarkan Warna
- Bar Chart yang digunakan untuk menampilkan rata-rata harga setiap warna 
- Scatter Plot unutk menggambarkan hubungan antara harga dan berat berdasarkan warna

### Langkah- langkah 

1. Memuat data : Skrip membaca data dari file CSV yang dipisahkan oleh titik koma (';').
2. Menampilkan Data : Menampilkan beberapa barus pertama dari data untuk mmemastikan data telah dimuat dengan benar.
3. Membuat grafik : 
    - Box Plot
    - Bar Chart
    - Scatter Plot
4. Menyimpan Grafik : Setiap garik disimpan sebagai file PNG di direktori.



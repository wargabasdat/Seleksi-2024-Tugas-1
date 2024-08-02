

### **Author**
- **Nama**: Nasywaa Anggun Athiefah
- **NIM**: 18222021

### **Deskripsi Singkat Mengenai Data dan DBMS**
- **Data**: Data New and Trending Product di https://www.worldmarket.com/c/new-and-trending/
- **DBMS**: PostgreSQL
- **Alasan Pemilihan Topik**: Karena melihat struktur produk saat inspect element yang masih dapat dibaca dan rapih. Selain itu juga saya tertarik untuk melihat dalamnya.

### **Cara Menggunakan Scraper dan Output-nya**
1. **Instalasi**: Pastikan semua dependensi yang diperlukan sudah terinstal.
2. **Menjalankan Scraper**: Jalankan file script dengan perintah
3. **Output**: Hasil scraping disimpan dalam folder `data` sebagai file JSON [contoh: `data/products.json` dan `data/shipping_info.json`].

### **Penjelasan Struktur File JSON yang Dihasilkan Scraper**
- **`products.json`**:
  - `Nama`: Nama produk
  - `Harga`: Harga produk
- **`shipping_info.json`**:
  - `Nama`: Nama pengirim
  - `Pick Up`: Waktu pengambilan
  - `Arrive`: Waktu kedatangan

### **Struktur ERD dan Diagram Relasional RDBMS**
- **ERD**: Data Storing/Design/ERD World Market.jpg
- **Diagram Relasional**: Data Storing/Design/Relational Diagram World Market.jpg

### **Penjelasan Translasi ERD ke Diagram Relasional**
- **ERD ke Diagram Relasional**: Diawali terlebih dahulu dengan melihat tabel category dan product, jika dilihat hubungan keduanya yaitu many to many sehingga melalui hal tersebut akan dibentuk relasi baru bernama discover yang didalamnya terdapat primary key dari product maupun category. Lalu melihat dari tabel product dan cart akan dilakukan hal yang sama. Berbeda dengan tabel product dan delivery, dikarenakan terdapat hubungan one to many dengan salah satu partial maka primary key dari delivery akan dimasukkan pada product sebagai foreign key. Terakhir karena terdapat is A maka seluruhnya akan dijadikan tabel dengan primary key yaitu id_delivery (foreign key dari id_delivery pada delivery).

### **Screenshot Program yang Dijalankan**
- **Screenshot**: [Tangkapan layar dari kode program scraping dan output-nya, disimpan di folder `screenshots`]

### **Referensi**
- **Library**: "BeautifulSoup, Requests, ssl, urllib.request, pandas, json"
- **Halaman Web yang Discrape**: (https://www.worldmarket.com/c/new-and-trending/)
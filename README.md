# STACKOVERFLOW ETL

## 13522115 - Derwin Rustanly

## Deskripsi Data dan DBMS

Stack Overflow adalah platform tanya jawab populer yang berfokus pada pemrograman dan pengembangan perangkat lunak. Didirikan pada tahun 2008 oleh Jeff Atwood dan Joel Spolsky, situs ini memungkinkan pengembang untuk mengajukan pertanyaan, memberikan jawaban, dan berbagi pengetahuan mengenai berbagai topik teknis. Stack Overflow memiliki komunitas yang aktif dan merupakan sumber utama untuk solusi dan diskusi terkait masalah pemrograman. Pada proses ETL ini, dilakukan pengolahan data pertanyaan, jawaban, komentar, pengguna serta tags yang tersedia di situs yang berkaitan dengan bahasa pemrograman Go. Penyimpanan data dilakukan dengan menggunakan local database dengan platform DBMS MariaDB.

## Cara menggunakan scraper

1. Jalankan perintah berikut untuk masuk ke directory ./Data Scraping/src dari root directory

   ```
       cd "./Data Scraping/src"
   ```

2. Jalankan perintah berikut untuk menginstalasi package dan dependensi Go yang diperlukan dan menjalankan scraper
   ```
       go mod tidy
       go mod download
       go run main.go
   ```

## Cara menggunakan converter JSON

1. Jalankan perintah berikut untuk masuk ke directory ./Data Storing/src dari root directory

   ```
       cd "./Data Storing/src"
   ```

2. Pastikan DDL telah dipersiapkan di dalam RDBMS MariaDB, jika belum jalankan perintah berikut di terminal
   ```
       $ mariadb -u root -p
   ```
3. Buatlah sebuah database untuk menyimpan skema yang berasal dari DDL yang telah disediakan

   ```
    [MariaDB] create database stackoverflow;
    [MariaDB] use stackoverflow;
    [MariaDB] source ddl.sql;
   ```

4. Jalankan perintah berikut untuk menginstalasi package dan dependensi Go yang diperlukan dan menjalankan converter

   ```
       go mod tidy
       go mod download
       go run main.go
   ```

5. Apabila terdapat unicode error, pastikan character-set dan collate pada MariaDB menggunakan encoding utf-8, jika belum jalankan perintah berikut, dan jalankan kembali converter
   ```
       ALTER DATABASE [nama database] CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
   ```

## Struktur file JSON

Secara garis besar, data dibagi menjadi 3 bagian utama, yakni questions, tags, dan users (karena diambil dari page /users, /tags, dan /questions). Adapun, struktur lengkapnya dapat diamati lebih lanjut pada bagian src/models/models.go

## Struktur ERD dan Diagram RDBMS

ERD dan Diagram Relasional dapat diamati pada folder Data Storing/design. Adapun pertimbangan dari pembuatan ERD dan Diagram Relasional tersebut adalah sebagai berikut

1. Suatu pengguna dapat mengajukan lebih dari 1 pertanyaan.
2. Suatu pertanyaan dapat memiliki lebih dari 1 jawaban, tapi mungkin bagi suatu pertanyaan untuk belum memiliki jawaban.
3. Suatu pengguna dapat mengirimkan lebih dari 1 komentar terhadap suatu pertanyaan maupun jawaban.
4. Suatu pengguna ataupun pertanyaan dapat memiliki 1 tag.

## Screenshot Program

![OutputScraper](./Data%20Scraping/screenshot/result.png)
![ss1](./Data%20Storing/screenshot/ss1.png)
![ss2](./Data%20Storing/screenshot/ss2.png)
![ss3](./Data%20Storing/screenshot/ss3.png)
![ss4](./Data%20Storing/screenshot/ss4.png)
![ss5](./Data%20Storing/screenshot/ss5.png)
![ss6](./Data%20Storing/screenshot/ss6.png)

## Referensi

1. [GoColly](https://github.com/gocolly/colly/v2)
2. [Stackoverflow](https://stackoverflow.com)

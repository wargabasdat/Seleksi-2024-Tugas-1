<h1 align="center">
  Restaurant ETL Project
</h1>

<h2 align="left">
  William Glory Henderson - 13522113
</h2>

## Deskripsi 
Restoran merupakan tempat dimana kita dapat menikmati makanan yang merupakan kebutuhan primer setiap manusia. Alasan memilih restoran dikarenakan saya sangat suka makan dan tentu saja setiap orang ingin mencoba makanan yang enak. Saya juga tertarik untuk mencoba makanan baru dari berbagai negara. Database ini berisi top 50 restoran di dunia.

## Cara Menggunakan Scraper
1. Masuk ke directory scraper
    ```
    cd Data Scraping/src
    ```
2. Jalankan perintah 
    ```
    python main.py
    ```

## Cara Menggunakan Hasil Output JSON
1. Masuk ke directory inserter
    ```
    cd Data Storing/src
    ```
2. Pastikan database (mysql) sudah dibuat

3. Buka file inserter.py

4. Ubah nama file .json sesuai nama file anda dan jangan lupa masukan juga pathnya

5. Ubah host, user, password, database sesuai dengan host, user, password, dan nama database anda

6. Jalankan perintah 
    ```
    python inserter.py
    ```

## Struktur File JSON
File JSON berjumlah 50 data restoran dan di setiap datanya memiliki 6 kolom yaitu nama, alamat, nomor telepon, website, instagram, dan facebook dari masing-masing restoran. Null pada file JSON menandakan bahwa restoran tidak memiliki data pada kolom tersebut. Untuk struktur lengkapnya dapat dilihat pada folder data yang terletak di dalam folder Data Storing

## Struktur ERD dan Diagram RDBMS
1. Seorang pemilik dapat memiliki lebih dari 1 restoran dan suatu restoran dapat memiliki lebih dari 1 pemilik.

2. Seorang pelanggan hanya dapat memberikan 1 review ke setiap restoran

3. Suatu restoran wajib memiliki satu menu. Suatu restoran dapat memiliki banyak menu tetapi suatu menu hanya bisa terdapat di satu restoran saja (mempertimbangkan resep yang berbeda antar restoran)

SS ERD <br>
![ERD](./Data%20Storing/design/ERD.png) <br>

SS RM <br>
![RM](./Data%20Storing/design/RM.png) <br>

## Proses Translasi ERD ke Diagram Relational
1. Untuk relasi many to many, dibuat relasi baru dan primary keynya diambil dari primary key kedua relasi

2. Untuk relasi one to many, menambahkan foreign key di bagian many yang merujuk ke primary key si one

3. Untuk relasi dengan atribut tambahan, dibuat relasi baru dan primary keynya diambil dari primary key kedua relasi serta menambahkan atribut tambahan pada relasi baru tersebut

## Screenshot Hasil Program
1. SS kode scraper <br>
![code](./Data%20Scraping/screenshot/code.png) <br>
2. SS jumlah data <br> 
![ss1](./Data%20Storing/screenshot/ss1.png) <br>
3. SS Data JSON yang masuk ke database <br>
![ss2](./Data%20Storing/screenshot/ss2.png) <br>
4. SS Data JSON yang masuk ke database <br> 
![ss3](./Data%20Storing/screenshot/ss3.png) <br>
5. SS Data JSON yang masuk ke database <br>
![ss4](./Data%20Storing/screenshot/ss4.png)

## Link Referensi
1. [The World's 50 Best Restaurants](https://www.theworlds50best.com/list/1-50)

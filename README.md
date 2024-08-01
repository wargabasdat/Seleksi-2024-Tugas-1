<h1 align="center">
  <br>
  The Amazing World of Gumball Episodes <br>
  By: Marvin Scifo Y. Hutahaean - 13522110
  <br>
  <br>
</h1>

## Deskripsi
Ini adalah data-data yang berisi tentang daftar-daftar episode dari sebuah serial kartun yang bernama The Amazing World of Gumball. Pada data ini, terdapat konten berupa nama dari serial kartun tersebut, musim-musim atau miniseries yang ada di kartun tersebut, dan episode-episode yang ada di kartun tersebut beserta detil-detilnya. Topik ini saya pilih karena saya selalu menyukai melihat daftar-daftar episode seperti ini dan akan mempermudah orang juga jika ingin melihat rilis sebuah episode secara langsung menggunakan sistem DBMS dan kakas seperti MariaDB.

## Cara Menggunakan Scraper
Scraper yang digunakan untuk mengambil data tersebut adalah BeautifulSoup dengan menggunakan bahasa pemrograman Python. Scraper digunakan dengan pertama membuat objek BeautifulSoup dengan membuka dan membaca url dari halaman page yang di scrape lalu di parse oleh BeautifulSoup. Setelah itu, Beautiful mencari elemen berupa table karena episode, musim, dan informasi lainnya terdapat di table tersebut. Simpan semua informasi ke dalam array sementara terlebih dahulu karena urutan informasinya banyak yang tidak beraturan. Lakukan perpindahan array ke array yang baru setelah melakukan pemrosesan array agar informasi yang dimasukkan tidak salah karena urutan informasinya yang tidak beraturan. Setelah itu, pindahkan ke JSON dengan struktur yang sudah ditentukan.

## Struktur JSON
Tingkat 1: Nama Kartun (The Amazing World of Gumball) dan Daftar Musim dari TAWOG
Tingkat 2 (Ekspansi dari Daftar Musim dari TAWOG): Nama Musim, Jumlah Episode, Tanggal Mulai dan Berakhirnya Musim, dan Daftar Episode dari Musim
Tingkat 3 (Ekspansi dari Daftar Episode): Nomor Episode Keseluruhan, Nomor Episode dalam Musim, Judul Episode, Daftar Direktur, Daftar Penulis, Daftar Pembuat Cerita, Tanggal Rilis, Kode Produksi, dan Penonton di Amerika dalam Jutaan
Tingkat 4: Direktur-Direktur (Ekspansi dari Daftar Direktur), Penulis-Penulis (Ekspansi dari Daftar Penulis), dan Pembuat-Pembuat Cerita (Ekspansi dari Pembuat-Pembuat Cerita)

## ERD, Relasional dan Penjelasan
![alt text](https://github.com/scifo04/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/design/ERDGumball.png)

Ini adalah struktur ERD dari Daftar Episode Gumball

![alt text](https://github.com/scifo04/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/design/RelationalGumball.png)

Ini adalah struktur Relasional dari Daftar Episode Gumball

Proses konversi ERD ke Relasional dimulai dengan menambahkan atribut ShowID ke tabel season dan memasang foreign key disitu karena relasinya yang one to many dan full participation. Setelah itu, SeasonID juga ditambahkan ke Episodes dan dijadikan foreign key karena relasinya juga one to many dan full participation. Pada relasinya dari Episodes ke Writers, Storyboarders, dan Directors, relasi baru dibuat dengan atribut EpisodeID dan WriterID/DirectorID/StoryboarderID terdapat di relasi tersebut dan menjadi primary key dan foreign key ke Episodes dan Writers/Storyboarders/Directors karena relasinya many to many partial participation.

## Screenshot RDBMS
![alt text](https://github.com/scifo04/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/SELECT_Episode.png)

Gambar pemilihan episode

![alt text](https://github.com/scifo04/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/SELECT_Season.png)

Gambar pemilihan musim

![alt text](https://github.com/scifo04/Seleksi-2024-Tugas-1/blob/main/Data%20Storing/screenshot/SELECT_Director.png)

Gambar pemilihan direktur

## Referensi
https://pypi.org/project/beautifulsoup4/
Referensi ke BeautifulSoup (Scraper Python)

https://en.wikipedia.org/wiki/List_of_The_Amazing_World_of_Gumball_episodes
Referensi ke data yang di scrape

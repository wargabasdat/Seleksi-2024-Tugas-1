# Seleksi Asisten Basis Data - 2024

Nama : Farah Aulia

NIM : 18222096

## Largest Companies in the United States (US) by Revenue

### Deskripsi Data dan DBMS

Data yang digunakan dalam perancangan database ini adalah informasi mengenai 100 perusahaan terbesar di US (Amerika Serikat) berdasarkan pendapatannya. Tabel data tersebut mencakup atribut-atribut seperti rank, name, industry, revenue (USD millions), revenue growth, employees, city, dan state.

Database Management System (DBMS) yang dirancang memiliki empat tabel, yaitu:

| Tabel | Keterangan |
| --- | --- |
| State | Menyimpan data mengenai negara bagian di mana perusahaan berada.  |
| City | Menyimpan data mengenai kota di mana perusahaan berada.  |
| Industry | Menyimpan data mengenai industri di mana perusahaan beroperasi. |
| Company | Menyimpan data mengenai perusahaan itu sendiri.  |

Alasan memilih topik ini adalah untuk memahami ekonomi dan industri dari perusahaan di Amerika Serikat. Seperti industri mana yang menyumbang ekonomi di Amerika ataupun perusahaannya. Selain itu data-data ini juga dapat digunakan untuk analisis mendalam mengenai kinerja perusahaan, tren pendapatan, maupun pertumbuhan rata-rata tiap industri.

### Cara Menggunakan Scraper

1. Buka https://colab.research.google.com/drive/1kMSNPaqg7B57yxpN-ewhvGVud9A8kE27?authuser=1#scrollTo=2f34ad4e , dan jalankan tiap code seperti biasa.
2. Atau gunakan Visual Studio Code untuk menjalankan kodenya.

### Struktur File JSON

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/fb23990a-f5fc-441f-8a45-83ad52076085/e575e1e4-1be5-49c3-b8e8-7c202133112f/Untitled.png)

1. **Rank**: Peringkat perusahaan berdasarkan pendapatan.
2. **Name**: Nama perusahaan.
3. **Industry**: Industri tempat perusahaan beroperasi.
4. **Revenue (USD millions)**: Pendapatan perusahaan dalam jutaan dolar AS.
5. **Revenue growth**: Persentase pertumbuhan pendapatan perusahaan.
6. **Employees**: Jumlah karyawan perusahaan.
7. **City**: Kota tempat kantor pusat perusahaan berada.
8. **State**: Negara bagian tempat kantor pusat perusahaan berada.

### Struktur ERD dan Diagram Relasional RDBMS

1. ER Diagram

![ER Seleksi Asisten-ER.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/fb23990a-f5fc-441f-8a45-83ad52076085/11b47a9d-97b6-4ff2-a566-463290c15d09/ER_Seleksi_Asisten-ER.jpg)

1. Diagram Relasional

![ER Seleksi Asisten-Copy of ER.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/fb23990a-f5fc-441f-8a45-83ad52076085/0a4d3b6a-5d29-43c0-82ff-78ddc34ed98c/ER_Seleksi_Asisten-Copy_of_ER.jpg)

### Translasi ERD Menjadi Diagram Relasional

1. Pemetaan menjadi relasi

a. String entity

Company = **CompanyID**, Name, Revenue, RevenueGrowth, Employees

City = **CityID**, CityName

State = **StateID**, StateName

Industry = **IndustryID**, Name

1. Pemetaan Relationship menjadi relasi

a. One to Many / Many to One

Tidak terjadi penambahan *entity*, namun atribut dari relasi *one* dititipkan ke relasi *many*.

- Relationship **tergabung** antara Company(many) dan Industry(one), terjadi penambahan IndustryID ke Company
- Relationship **terletak** antara Company(many) dan City(one), terjadi penambahan CityID ke Company
- Relationship **berada** antara State(one) dan City(many), terjadi penambahan StateID ke City
1. Foreign Key yang Terbentuk dari Hasil Pemetaan
- Company(IndustryID) → Industry(IndustryID)
- Company(CityID) → City(CityID)
- City(StateID) → State(StateID)
1. Hasil Pemetaan

Company = **CompanyID, IndustryID, CityID** Name, Revenue, RevenueGrowth, Employees

City = **CityID, StateID,** CityName

State = **StateID**, StateName

Industry = **IndustryID**, Name

### Screenshot

Gambar lebih lengkap bisa dilihat di bagian masing-masing folder.

1. Scrapping

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/fb23990a-f5fc-441f-8a45-83ad52076085/dcbc98a6-19d7-4df1-a1ab-ff86c9170235/Untitled.png)

1. Storing

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/fb23990a-f5fc-441f-8a45-83ad52076085/8da8b5e2-733b-4c4c-8820-d000f3e6abb2/Untitled.png)

1. Visualisasi

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/fb23990a-f5fc-441f-8a45-83ad52076085/82cde0bd-9c8e-4bf6-a407-c1dae29f209b/Untitled.png)

### Referrensi / Library / Tools

1. Link data: https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue 
2. BeautifulSoup
3. Pandas
4. GoogleColab
5. Tableau
6. MySQL
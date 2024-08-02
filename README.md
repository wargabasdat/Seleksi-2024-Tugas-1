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

![FileJSON](Data%20Scraping/screenshot/json.png)

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

![ERDiagram](Data%20Storing/design/ER%20Diagram.png)

2. Diagram Relasional

![Relasional](Data%20Storing/design/Diagram%20Relasional.png)

### Translasi ERD Menjadi Diagram Relasional

1. Pemetaan menjadi relasi

a. String entity

Company = **CompanyID**, Name, Revenue, RevenueGrowth, Employees

City = **CityID**, CityName

State = **StateID**, StateName

Industry = **IndustryID**, Name

2. Pemetaan Relationship menjadi relasi

a. One to Many / Many to One

Tidak terjadi penambahan *entity*, namun atribut dari relasi *one* dititipkan ke relasi *many*.

- Relationship **tergabung** antara Company(many) dan Industry(one), terjadi penambahan IndustryID ke Company
- Relationship **terletak** antara Company(many) dan City(one), terjadi penambahan CityID ke Company
- Relationship **berada** antara State(one) dan City(many), terjadi penambahan StateID ke City
3. Foreign Key yang Terbentuk dari Hasil Pemetaan
- Company(IndustryID) → Industry(IndustryID)
- Company(CityID) → City(CityID)
- City(StateID) → State(StateID)
4. Hasil Pemetaan

Company = **CompanyID, IndustryID, CityID** Name, Revenue, RevenueGrowth, Employees

City = **CityID, StateID,** CityName

State = **StateID**, StateName

Industry = **IndustryID**, Name

### Screenshot

Gambar lebih lengkap bisa dilihat di bagian masing-masing folder.

1. Scrapping

![Scraping1](Data%20Scraping/screenshot/Sc1.png)
![Scraping2](Data%20Scraping/screenshot/Sc2.png)
![Scraping3](Data%20Scraping/screenshot/Sc3.png)
![Scraping4](Data%20Scraping/screenshot/Sc4.png)

2. Storing
Dilakukan dengan mendefinisikan masing-masing tabel dengan dependenciesnya.
![Data1](Data%20Storing/screenshot/CreateTable1png.png)
![Data2](Data%20Storing/screenshot/CreateTable2.png)

Tampilan semua data seperti yang ada di website.
![AllData](Data%20Storing/screenshot/All%20Data.png)
Tampilan tabel city
![TabelCity](Data%20Storing/screenshot/Tabel%20City.png)
Tampilan tabel company
![TabelCompany](Data%20Storing/screenshot/Tabel%20Company.png)
Tampilan tabel industry
![Industry](Data%20Storing/screenshot/Tabel%20Industry.png)
Tampilan tabel state
![State](Data%20Storing/screenshot/Tabel%20State.png)


4. Visualisasi

![Dashboard](Data%20Visualization/Screenshot/Dashboard.png)
![Geography](Data%20Visualization/Screenshot/Data%20Geography.png)
Persebaran perusahaan besar paling banyak berada di New York sebanyak 15. 
![PerbandinganRevenueDenganJumlahKaryawan](Data%20Visualization/Screenshot/Perbandingan%20Revenue%20dan%20Jumlah%20Karyawan.png)
Hasil analisis ini mengindikasikan bahwa terdapat korelasi positif yang signifikan secara statistik antara jumlah karyawan dan pendapatan perusahaan. Dengan nilai analisis regresi sebagai berikut:
Employees = 1,72865*Revenue (USD millions) +-35164,2
R-Squared: 0,412157
P-value: < 0,0001
![PersebaranIndustry](Data%20Visualization/Screenshot/Persebaran%20Industry.png)
Perusahaan besar di Amerika paling banyak bergerak di bidang Financials yaitu sebanyak 11 perusahaan.

### Referrensi / Library / Tools

1. Link data: https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue 
2. BeautifulSoup
3. Pandas
4. GoogleColab
5. Tableau
6. MySQL

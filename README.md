comm# Seleksi Asisten Basis Data - 2024 - Tugas 1
| NIM | Nama Anggota |
| --- | --- |
| 18222096 | Farah Aulia |
## Largest Companies in the United States (US) by Revenue
### Deskripsi Data dan DBMS
Data yang digunakan dalam perancangan database ini adalah informasi mengenai 100 perusahaan terbesar di US (Amerika Serikat) berdasarkan pendapatannya. Tabel data tersebut mencakup atribut-atribut seperti:
1. Rank: Peringkat perusahaan berdasarkan pendapatan.
2. Name: Nama perusahaan.
3. Industry: Industri di mana perusahaan beroperasi.
4. Revenue (USD millions): Pendapatan perusahaan dalam jutaan dolar.
5. Revenue growth: Persentase pertumbuhan pendapatan.
6. Employees: Jumlah karyawan.
7. City: Kota tempat kantor pusat perusahaan berada.
8. State: Negara bagian tempat kota tersebut berada.
<br>
Database Management System (DBMS) yang dirancang memiliki empat tabel: <br>
1. State <br>
Mengelola data mengenai negara bagian di mana perusahaan berada. <br>
Atribut: StateID, StateName. <br>
2. City <br>
Mengelola data mengenai kota di mana perusahaan berada.<br>
Atribut: CityID, CityName, StateID (Foreign Key). <br>
3. Industry <br>
Mengelola data mengenai industri di mana perusahaan beroperasi. <br>
Atribut: IndustryID, IndustryName. <br>
4. Company<br>
Mengelola data mengenai perusahaan itu sendiri. <br>
Atribut: CompanyID, Name, IndustryID (Foreign Key), Revenue, RevenueGrowth, Employees, CityID (Foreign Key). <br>

### Cara Menggunakan Scraper


### Struktur File JSON


### Struktur ERD dan Diagram Relasional RDBMS


### Translasi ERD Menjadi Diagram Relasional


### Screenshot


### Referensi

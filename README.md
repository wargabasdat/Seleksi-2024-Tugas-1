<h2 align="center">
  <br>
  DATA SCRAPING, DATA MODELLING DAN DATA STORING
  <br>
  THE MOST POPULAR PERFUMES FOR WOMEN BERDASARKAN PARFUMO
  <br>
  Seleksi Tahap 2 Asisten Basdat 2024
  <br>
  Tamara Mayranda Lubis - 18222026
  <br>
  <br>
</h2>

### Deskripsi Data dan DBMS
Berdasarkan Encyclopaedia Britannica, kata *perfume* berasal dari bahasa Latin yaitu per fumum yang berarti '*through smoke*'. Parfum merupakan kombinasi unik dari berbagai bahan aromatik yang digunakan untuk memberikan wangi yang menyenangkan pada tubuh atau lingkungan. Setiap parfum memiliki tiga komposisi yang terdiri dari *top note* yaitu aroma segar dan cepat menguap yang tercium pertama kali. Lalu terdapat *middle note* atau *heart note* yang memberikan karakter utama dan kuat pada parfum serta yang terakhir adalah *base note* yang merupakan aroma yang bertahan paling lama. Keahlian dalam membuat parfum telah diketahui oleh berbagai peradaban kuno, termasuk bangsa Cina, Hindu, Mesir, Israel, Kartago, Arab, Yunani, dan Romawi. Pengetahuan dan teknik pembuatan parfum yang diwariskan oleh peradaban kuno ini menjadi dasar bagi industri parfum modern yang kita kenal sekarang.

Dalam project ini, DBMS yang digunakan adalah MySQL. Dalam *database*, terdapat 12 tabel yang mencakup *Brand*, *Perfumer*, *Perfume*, *Perfume Accord*, *Fragrance*, *User*, *Store*, *Available*, *Review*, *Top Note*, *Heart Note*, dan *Base Note*.

Pada *Project* ini menggunakan data yang berasal dari Parfumo dan berfokus terhadap 100 parfum yang popular di antara wanita. *Dataset* yang diperoleh dari Parfumo ini mencakup atribut seperti:
1. *Perfume name*: Nama dari parfum.
2. *Brand*: Merek atau perusahaan yang memproduksi parfum.
3. *Type*: Jenis parfum berdasarkan konsentrasi minyak esensial yang terkandung di dalamnya.
4. *Year*: Tahun di mana parfum tersebut pertama kali dirilis atau diluncurkan ke pasar.
5. *Ranking*: Posisi atau peringkat pada The Most Popular Perfumes for Women.
6. *Main accords*: Kumpulan aroma utama yang membentuk karakter dari parfum.
7. *Perfumer*: Nama ahli parfum yang menciptakan komposisi parfum tersebut.
8. *Rating Value*: Nilai rata-rata rating yang diberikan oleh pengguna atau reviewer terhadap parfum tersebut.
9. *Rating Score*: Jumlah total rating yang diterima oleh parfum tersebut.

Dalam *database*, terdapat 12 tabel yang mencakup *Brand*, *Perfumer*, *Perfume*, *Perfume Accord*, *Fragrance*, *User*, *Store*, *Available*, *Review*, *Top Note*, *Heart Note*, dan *Base Note*.

Menurut Fortune Business Insight, pasar parfum global bernilai USD 48,05 miliar pada tahun 2023 dan diperkirakan akan meningkat dari USD 50,45 miliar pada tahun 2024 menjadi USD 77,52 miliar pada tahun 2032, dengan laju pertumbuhan tahunan gabungan (CAGR) sebesar 5,51% selama periode tersebut. Dengan meningkatnya nilai pasar parfum global, maka analisis terhadap data parfum juga semakin penting. Analisis ini dilakukan untuk memberikan wawasan kepada pembuat parfum, pemasar, dan konsumen tentang tren, preferensi, dan emosi yang berhubungan dengan berbagai jenis parfum. Dengan mengelola data parfum yang komprehensif, seperti atribut parfum, merek, pembuat parfum, dan ulasan pengguna, dapat disediakan platform yang bermanfaat untuk analisis pasar, *e-commerce*, dan peningkatan pengalaman konsumen.

### Cara Menggunakan
**1. Clone Repositori**
   ```sh
   $ git clone [https://github.com/](https://github.com/tamaramyrn/Seleksi-2024-Tugas-1.git)
```
**2. Install Library yang Diperlukan**
   ```sh
   pip install requests beautifulsoup4 mysql-connector-python
```

**3. Buka Folder yang telah Di-clone**
   ```sh
   $ cd Seleksi-2024-Tugas-1
 ```

**4. Buka Folder yang telah Di-clone**
   ```sh
   $ cd Data Scraping
   $ cd src
 ```

**5. Modifikasi Host, Username, dan Password Connection pada data.py**
   ```sh
   connection = create_connection("localhost", "root", "*******", "100_Perfume")
 ```

**6. Jalankan Program**
   ```sh
   $ scrapping.ipynb
 ```

**7. Export Database ke File SQL**
   ```sh
   $ mysqldump -u username -p database_name > output_file.sql
 ```

### Struktur File JSON
Struktur file JSON yang dihasilkan dari hasil scraping adalah sebagai berikut:
 ```sh
1. Perfume name: Nama dari parfum.
2. Brand: Merek atau perusahaan yang memproduksi parfum.
3. Type: Jenis parfum berdasarkan konsentrasi minyak esensial yang terkandung di dalamnya.
4. Year: Tahun di mana parfum tersebut pertama kali dirilis atau diluncurkan ke pasar.
5. Ranking: Posisi atau peringkat pada The Most Popular Perfumes for Women.
6. Main accords: Kumpulan aroma utama yang membentuk karakter dari parfum.
7. Perfumer: Nama ahli parfum yang menciptakan komposisi parfum tersebut.
8. Rating Value: Nilai rata-rata rating yang diberikan oleh pengguna atau reviewer terhadap parfum tersebut.
9. Rating Score: Jumlah total rating yang diterima oleh parfum tersebut.
 ```

Berikut adalah contoh satu entri JSON untuk parfum "Mon Guerlain" oleh Guerlain:
 ```sh
    "Perfume Name": "Mon Guerlain",
    "Brand": "Guerlain",
    "Type": "Eau de Parfum",
    "Year": "2017",
    "Ranking": "1",
    "Main Accords": "Sweet, Floral, Powdery, Creamy, Gourmand",
    "Perfumer": "Thierry Wasser",
    "Rating Value": "8.2",
    "Rating Count": "1635"
 ```

### Struktur ERD dan Diagram Relasional RDBMS
Berikut merupakan struktur dari ER Diagram:
<br>
<img src="Data%20Storing/design/ER%20Diagram.png" alt="ER Diagram" />

Berikut merupakan struktur dari Diagram Relasional:
<br>
<img src="Data%20Storing/design/Diagram%20Relasional.png" alt="Diagram Relasional" />

### Proses Translasi ERD menjadi Diagram Relasional
Berdasarkan ER Diagram yang telah dibuat, terdapat beberapa tahapan dalam mengubah ke dalam bentuk Diagram Relasional agar kemudian dapat diimplementasikan ke *database*.

#### 1. Pemetaan *Entity* menjadi Relasi
##### a. *Strong Entity*

- brand = (**brand_name**, country_of_origin, founded_year, founder)
- perfumer = (**perfumer_name**, date_of_birth, nationality)
- perfume = (**perfume_ID**, perfume_name, type, release_year, price, gender, bottle_size, rating_score, total_rating, ranking)
- fragrance = (**fragrance_ID**, fragrance_name)
- store = (**store_ID**, store_name, store_address, store_contact)
- user = (**user_ID**, username, user_first_name, user_last_name, phone_number, email, password)

##### b. *Weak Entity*
Relasi *review* merupakan *weak entity* yang memiliki hubungan *many-to-one* dengan relasi *perfume* dan relasi *user* yang mana *many* dan *total participation* berada pada sisi relasi *review*. Sehingga, *primary key* dari relasi *perfume* yaitu *perfume_ID* dan relasi *user* yaitu *user_ID* akan dimasukkan ke dalam relasi *review*.

- review = (**review_ID**, **perfume_ID**, **user_ID**, review)

#### 2. Pemetaan *Relationship* menjadi Relasi
##### a. *Produced by Relationship*
Relasi *brand* berhubungan *one to many*, dengan *many* dan *total participation* pada sisi relasi *perfume*. Sehingga, *primary key* dari relasi *brand* yaitu **brand_name** akan dimasukkan ke dalam relasi *perfume* sebagai foreign key.

- perfume = (**perfume_ID**, **brand_name**, perfume_name, type, release_year, price, gender, bottle_size, rating_score, total_rating, ranking)

##### b. *Made by Relationship*
Relasi *perfumer* berhubungan *one to many*, dengan *many* dan *total participation* pada sisi relasi *perfume*. Sehingga, *primary key* dari relasi *perfumer* yaitu **perfumer_name** akan dimasukkan ke dalam relasi *perfume* sebagai foreign key.

- perfume = (**perfume_ID**, **brand_name**, **perfumer_name**, perfume_name, type, release_year, price, gender, bottle_size, rating_score, total_rating, ranking)

##### c. *Available at Relationship*
Relasi *store* dan *perfume* berhubungan *many-to-many*, sehingga akan dibentuk relasi baru yaitu *available* dengan *primary key* dari relasi *store* yaitu **store_ID** dan relasi *perfume* yaitu **perfume_ID**.

- available = (**perfume_ID**, **store_ID**)

##### d. *Is top note Relationship*
Relasi *perfume* dan *fragrance* berhubungan *many-to-many*, sehingga akan dibentuk relasi baru yaitu *top_note* dengan *primary key* dari relasi *perfume* yaitu **perfume_ID** dan relasi *fragrance* yaitu **fragrance_ID**.

- top_note = (**fragrance_ID**, **perfume_ID**)

##### e. *Is heart note Relationship*
Relasi *perfume* dan *fragrance* berhubungan *many-to-many*, sehingga akan dibentuk relasi baru yaitu *heart_note* dengan *primary key* dari relasi *perfume* yaitu **perfume_ID** dan relasi *fragrance* yaitu **fragrance_ID**.

- heart_note = (**fragrance_ID**, **perfume_ID**)

##### f. *Is base note Relationship*
Relasi *perfume* dan *fragrance* berhubungan *many-to-many*, sehingga akan dibentuk relasi baru yaitu *base_note* dengan *primary key* dari relasi *perfume* yaitu **perfume_ID** dan relasi *fragrance* yaitu **fragrance_ID**.

- base_note = (**fragrance_ID**, **perfume_ID**)

#### 3. Pemetaan *Multivalue* menjadi Relasi
##### a. *Multivalue* pada Relasi *Perfume*
Relasi *perfume* memiliki *multivalue* berupa *main_accords*. *Multivalue* tersebut akan dibentuk menjadi relasi baru dengan *primary key* berupa *primary key* relasi *perfume* yaitu **perfume_ID** dan *multivalue* itu sendiri yaitu *main_accords*.

- perfume_accord = (**perfume_ID**, **main_accords**)

#### 4. *Foreign Keys*
##### a. Penyisipan Atribut akibat *Weak Entity*
- review(perfume_ID) -> perfume(perfume_ID)
- review(user_ID) -> user(user_ID)

##### b. Penyisipan Atribut akibat *One-to-many Relationship* atau *Many-to-one Relationship*
- perfume(brand_name) -> brand(brand_perfume)
- perfume(perfumer_name) -> perfumer(perfumer_name)

##### c. Penyisipan Atribut akibat *Many-to-many Relationship*
- available(perfume_ID) -> perfume(perfume_ID)
- available(store_ID) -> store(store_ID)
- top_note(fragrance_ID) -> fragrance(fragrance_ID)
- top_note(perfume_ID) -> perfume(perfume_ID)
- heart_note(fragrance_ID) -> fragrance(fragrance_ID)
- heart_note(perfume_ID) -> perfume(perfume_ID)
- base_note(fragrance_ID) -> fragrance(fragrance_ID)
- base_note(perfume_ID) -> perfume(perfume_ID)

##### d. Penyisipan Atribut akibat *Multivalue*
- perfume_accord(perfume_ID) -> perfume(perfume_ID)

#### 5. Hasil Pemetaan
- brand = (**brand_name**, country_of_origin, founded_year, founder)
- perfumer = (**perfumer_name**, date_of_birth, nationality)
- perfume = (**perfume_ID**, **brand_name**, **perfumer_name**, perfume_name, type, release_year, price, gender, bottle_size, rating_score, total_rating, ranking)
- perfume_accord = (**perfume_ID**, **main_accords**)
- fragrance = (**fragrance_ID**, fragrance_name)
- top_note = (**fragrance_ID**, **perfume_ID**)
- heart_note = (**fragrance_ID**, **perfume_ID**)
- base_note = (**fragrance_ID**, **perfume_ID**)
- store = (**store_ID**, store_name, store_address, store_contact)
- available = (**perfume_ID**, **store_ID**)
- user = (**user_ID**, username, user_first_name, user_last_name, phone_number, email, password)
- review = (**review_ID**, **perfume_ID**, **user_ID**, review)
  
### Screenshot Program
#### 1. Data Scraping
##### a. Akses URL
<img src="Data%20Scraping/screenshot/ss_accessing_url.png" alt="ss_accessing_url" />

##### b. Import Library
<img src="Data%20Scraping/screenshot/ss_import_library.png" alt="ss_import_library" />

##### c. Scraping Detail Parfum
<img src="Data%20Scraping/screenshot/ss_scraping_detail_perfume.png" alt="ss_scraping_detail_perfume" />

##### d. Scraping dan Parsing Nama Parfum serta Tipe
<img src="Data%20Scraping/screenshot/ss_scraping_name_type.png" alt="ss_scraping_name_type" />

##### e. Proses Semua Informasi
<img src="Data%20Scraping/screenshot/ss_scraping_processing_perfume.png" alt="ss_scraping_processing_perfume" />

##### f. Penyimpanan ke JSON
<img src="Data%20Scraping/screenshot/ss_scraping_save_json.png" alt="ss_scraping_save_json" />

#### 2. Data Storing
##### a. Connect ke MYSQL
<img src="Data%20Scraping/screenshot/ss_storing_connect_MYSQL.png" alt="ss_storing_connect_MYSQL" />

##### b. Membuat Tabel
<img src="Data%20Scraping/screenshot/ss_storing_query_create_table_1.png" alt="ss_storing_query_create_table_1" />

##### c. Memasukkan Data ke dalam Tabel
<img src="Data%20Scraping/screenshot/ss_storing_query_insert_data_1.png" alt="ss_storing_query_insert_data_1" />

#### 3. Data Visualization
##### a. Distribusi Parfum berdasarkan Tahun Rilis
<img src="Data%20Visualization/ss_visualization_distribusi_tahun_rilis.png" alt="ss_visualization_distribusi_tahun_rilis" />

##### b. Distribusi Tipe Parfum
<img src="Data%20Visualization/ss_visualization_distribusi_tipe_parfum.png" alt="ss_visualization_distribusi_tipe_parfum" />

##### c. Top 10 Frekuensi Main Accords pada Parfum
<img src="Data%20Visualization/ss_visualization_frekuensi_accord_parfum.png" alt="ss_visualization_frekuensi_accord_parfum" />

##### d. Distribusi Parfum berdasarkan Perfumer
<img src="Data%20Visualization/ss_visualization_parfum_berdasarkan_perfumer.png" alt="ss_visualization_parfum_berdasarkan_perfumer" />

##### e. Top 10 Parfum
<img src="Data%20Visualization/ss_visualization_top_10_parfum.png" alt="ss_visualization_top_10_parfum" />

### Referensi
#### a. Library
- requests
- mysql.connector
- pandas
- matpotlib
- numpy
- BeautifulSoup (bs4)
- WordCloud
- json
- re (regular expression)
- time, random, Counter (from collections)
  
#### b. Link
1. https://www.parfumo.com/Perfumes/Tops/Women
2. https://www.britannica.com/art/perfume
3. https://www.fortunebusinessinsights.com/perfume-market-102273

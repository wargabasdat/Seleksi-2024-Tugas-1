# Seleksi Tahap 2 Asisten Basis Data 2024

## ETL Project

### Author
**Nama:** Favian Izza Diasputra  
**NIM:** 18222070

### Deskripsi Singkat
Database Management System (DBMS) ini dibuat dari hasil web scraping data dari permainan [Wuthering Waves](https://www.prydwen.gg/wuthering-waves/). Wuthering Waves adalah game yang memberikan pengalaman eksplorasi _open world_ dengan narasi yang kaya dan beragam serta kebebasan bertempur yang tinggi. Pemain dari game ini dapat memilih beragam karakter yang akan digunakan untuk pertempuran melawan entitas jahat dengan menggunakan berbagai variasi senjata dan echoes (semacam perlengkapan tempur). Dengan adanya DBMS ini, pemain diharapkan mendapatkan kemudahan dalam menguasai hal-hal yang ada di game ini.

### Cara Menggunakan Scraper
1. Clone repository ini di dalam direktorimu:
    ```sh
    git clone https://github.com/IlllIllIIIlIlIll/TUGAS_SELEKSI_2_18222070.git
    ```

2. Buka command prompt dan sesuaikan path sehingga berada pada repository tersebut.
3. Edit file `credentials.env` dan sesuaikan dengan environment Anda agar data dapat disimpan pada database Anda.
4. Jalankan program dengan perintah berikut:
    ```sh
    python "Data Scraping/src/scrape_ww.py"
    ```

### Penjelasan Struktur File JSON
Struktur file JSON yang dihasilkan oleh scraper berisi tiga bagian utama: "characters", "echoes", dan "weapons". Berikut penjelasan singkat dari setiap bagian:

#### Characters (Karakter)
Setiap karakter memiliki atribut seperti:
- **Name:** Nama karakter.
- **Rarity:** Kelangkaan karakter (integer 4 atau 5).
- **Element:** Elemen karakter (misalnya, "aero", "glacio").
- **HP, ATK, DEF:** Statistik darah, besar kerusakan akibat serangan, dan ketahanan karakter.
- **Max Energy:** Energi maksimum karakter.
- **CRIT Rate:** Persentase kerusakan kritikal.
- **CRIT DMG:** Persentase kerusakan tambahan akibat kritikal.
- **Healing Bonus, Element DMG:** Bonus darah pada penyembuhan dan kerusakan akibat serangan elemen.
- **WS_Mats, RA_Mats, A_Mats, W_Mats, SU_Mats:** Material yang dibutuhkan untuk peningkatan. Terdiri dari Weapon & Skill (WS), Resonator Ascension (RA), Ascension (A), Weapon (W), dan Skill Upgrade (SU).
- **Weapon Name:** Nama senjata utama karakter.
- **Weapon S Level:** Level senjata utama karakter.
- **Best Echo Set, Best Main Echo:** Set dan echo terbaik untuk karakter.
- **detail_url:** URL untuk detail lebih lanjut tentang karakter.

#### Echoes
Setiap echo memiliki atribut seperti:
- **Name:** Nama echo.
- **Class:** Kelas echo (misalnya, "calamity", "overlord").
- **Cost:** Biaya penggunaan echo.
- **Element DMG:** Kerusakan akibat serangan elemen.
- **Cooldown (s):** Waktu tunggu penggunaan echo dalam detik.
- **Sets:** Daftar set di mana echo termasuk.

#### Weapons (Senjata)
Setiap senjata memiliki atribut seperti:
- **Name:** Nama senjata.
- **Rarity:** Kelangkaan senjata.
- **Type:** Tipe senjata (misalnya, "sword", "broadblade").
- **Atk:** Statistik besar kerusakan akibat serangan senjata.
- **Substat:** Atribut tambahan yang ditingkatkan oleh senjata.
- **Substat%:** Persentase peningkatan dari atribut tambahan.

### Struktur ERD dan Diagram Relasional RDBMS
#### Asumsi:
- Setiap character hanya dapat menggunakan satu weapon dan menggunakan weapon apapun dengan wp_type yang sama, tetapi setiap character hanya memiliki satu best_weapon dalam level s_level tertentu.
- Setiap character dapat menggunakan berbagai echo_set yang terdiri dari berbagai echo, tetapi setiap character hanya memiliki satu best_echo_set.
- Setiap echo dapat menjadi bagian dari beberapa echo_set.
- Setiap character dapat menggunakan berbagai echo untuk dijadikan main echo, tetapi setiap character hanya memiliki satu best_main_echo.
- Setiap character dan echo hanya memiliki satu jenis element.
- Setiap character memiliki value char_material dan char_stat yang berbeda.

#### Hal yang Tidak Dapat Ditulis dalam E-R:
- Setiap character memiliki level dan setiap level dapat meningkatkan atribut character seperti hp, atk, def, max_energy, cr_rate, cr_dmg, healing_bonus, dan element_dmg.
- Setiap weapon memiliki level dan setiap level dapat meningkatkan atribut weapon seperti atk dan substat%. Level tersebut berbeda dengan s_level yang merupakan superimpose level, dimana s_level dapat ditingkatkan dengan menggabungkan weapon yang identik.
- Entitas Weapon_Level memiliki atribut s_level yang tersirat.

### Penjelasan Proses Translasi ERD Menjadi Diagram Relasional
1. **Pemetaan Entity menjadi Relasi:**
    - **Strong Entity:**
        - `Character` = (char_id, char_name, char_rarity, best_echo_set_id, best_main_echo_id, detail_url)
        - `Char_Stats` = (hp, char_atk, def, max_energy, crit_rate, crit_dmg, healing_bonus, element_dmg)
        - `Char_Material` = (ws_mats, ra_mats, a_mats, w_mats, su_mats)
        - `Element` = (element_id, element_name)
        - `Echo` = (echo_id, echo_name, class, cost, cooldown, element_id)
        - `Echo_Set` = (set_id, set_name)
        - `Weapon` = (weapon_id, name, rarity, weapon_type, atk, substat, substat_value)
    - **Weak Entity:**
        - `Weapon_Level`
    
2. **Pemetaan Relationship menjadi Relasi:**
    - **One-to-One Relationship:**
        - Pemetaan one-to-one relationship menjadi relasi dilakukan dengan salah satu entity menjadi foreign key pada entity lain. Primary key yang ditambahkan diutamakan berasal dari entity yang memiliki total participation untuk menghindari adanya nilai NULL pada entity. Pemetaan ini tidak membentuk entity baru.
        - Contoh one-to-one relationship pada ERD adalah relationship `has` antara entity `Character`, `Char_Stats`, dan `Char_Material`. Primary key yang ditambahkan pada relationship `has` dapat berasal dari salah satu entitas (Character atau Char_Stats dan Char_Material) karena kedua entitas ini memiliki total participation. Dalam ERD, diambil primary key entity `Character`, `char_id`, untuk dijadikan foreign key pada entity `Char_Stats` dan `Char_Material`.
            - `Char_Stats(char_id)` → `Character(char_id)`
            - `Char_Material(char_id)` → `Character(char_id)`
    
    - **One-to-Many Relationship atau Many-to-One Relationship:**
        - Pemetaan one-to-many atau many-to-one relationship menjadi relasi dilakukan dengan menambahkan atribut primary key pada sisi one menjadi foreign key pada sisi many.
        - Contoh pada ERD adalah relationship `has` pada entity `Character` dan `Element`. Dalam relationship `has`, entity `Element` berada pada sisi one, maka atribut primary key `Element`, `element_id`, menjadi atribut foreign key di entity `Character`. Begitu juga dengan relationship lainnya berikut:
            - `Character(element_id)` → `Element(element_id)`
            - `Character(best_echo_set_id)` → `Echo_Set(set_id)`
            - `Character(best_main_echo_id)` → `Echo(echo_id)`
            - `Echo(element_id)` → `Element(element_id)`
            - `Weapon_Level(char_id)` → `Character(char_id)`
            - `Weapon_Level(weapon_id)` → `Weapon(weapon_id)`

    - **Many-to-Many Relationship:**
        - Pemetaan many-to-many relationship menjadi relasi dilakukan dengan membentuk relasi baru. Atribut dari relasi baru terdiri dari atribut relationship (jika ada) dan primary key dari entity yang bersangkutan dengan relationship tersebut. Dalam ERD yang dibuat, relationship `Part_Of` merupakan many-to-many relationship. Oleh karena itu, dibentuk relasi `Part_Of` yang berisi atribut `set_id` dan `echo_id`. Relasi yang dipetakan adalah sebagai berikut:
            - `Part_Of(set_id, echo_id)`

3. **Foreign Keys:**
    - Foreign keys didefinisikan sebagai atribut dari suatu entity yang diambil dari primary key entity lain. Foreign key dapat terbentuk karena:
        - Penyisipan atribut akibat one-to-one relationship:
            - `Char_Stats(char_id)` → `Character(char_id)`
            - `Char_Material(char_id)` → `Character(char_id)`
        - Penyisipan atribut akibat one-to-many relationship atau many-to-one relationship:
            - `Character(element_id)` → `Element(element_id)`
            - `Character(best_echo_set_id)` → `Echo_Set(set_id)`
            - `Character(best_main_echo_id)` → `Echo(echo_id)`
            - `Echo(element_id)` → `Element(element_id)`
            - `Weapon_Level(char_id)` → `Character(char_id)`
            - `Weapon_Level(weapon_id)` → `Weapon(weapon_id)`
        - Penyisipan atribut akibat many-to-many relationship:
            - `Part_Of(set_id, echo_id)` → `Echo_Set(set_id)`, `Echo(echo_id)`

4. **

Hasil Pemetaan:**
    - Berdasarkan hasil pemetaan entity, relationship, dan specialization menjadi relasi di atas, didapatkan relasi sebagai berikut:
        - `Character` = (char_id, char_name, char_rarity, element_id, best_echo_set_id, best_main_echo_id, detail_url)
        - `Char_Stats` = (char_id, hp, char_atk, def, max_energy, crit_rate, crit_dmg, healing_bonus, element_dmg)
        - `Char_Material` = (char_id, ws_mats, ra_mats, a_mats, w_mats, su_mats)
        - `Element` = (element_id, element_name)
        - `Echo` = (echo_id, echo_name, class, cost, cooldown, element_id)
        - `Echo_Set` = (set_id, set_name)
        - `Weapon` = (weapon_id, name, rarity, weapon_type, atk, substat, substat_value)
        - `Weapon_Level` = (char_id, weapon_id, s_level)
        - `Part_Of` = (set_id, echo_id)

### Screenshot Program yang Dijalankan
Beberapa screenshot dari program yang dijalankan (image di-upload sesuai folder-folder yang tersedia, di README tinggal ditampilkan).

### Referensi
#### Library yang Digunakan:
- **os:** Menyediakan fungsi untuk berinteraksi dengan sistem operasi.  
  [os library documentation](https://docs.python.org/3/library/os.html)
- **time:** Menyediakan berbagai fungsi terkait waktu.  
  [time library documentation](https://docs.python.org/3/library/time.html)
- **json:** Menyediakan fungsi untuk parsing JSON.  
  [json library documentation](https://docs.python.org/3/library/json.html)
- **re:** Menyediakan dukungan untuk ekspresi reguler.  
  [re library documentation](https://docs.python.org/3/library/re.html)
- **psycopg2:** Adapter PostgreSQL untuk Python.  
  [psycopg2 library documentation](https://www.psycopg.org/docs/)
- **nltk:** Toolkit Bahasa Alami, digunakan untuk bekerja dengan data bahasa manusia.  
  [nltk library documentation](https://www.nltk.org/)
- **selenium:** Alat otomatisasi browser.  
  [selenium library documentation](https://selenium-python.readthedocs.io/)
- **BeautifulSoup:** Library untuk parsing dokumen HTML dan XML.  
  [BeautifulSoup library documentation](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
- **dotenv:** Memuat variabel lingkungan dari file `.env`.  
  [dotenv library documentation](https://pypi.org/project/python-dotenv/)
- **webdriver_manager:** Library untuk mengelola web driver untuk Selenium.  
  [webdriver_manager library documentation](https://pypi.org/project/webdriver-manager/)

#### Halaman Web yang Di-scrape:
- **Prydwen.gg Wuthering Waves Characters Page**  
  URL: http://www.prydwen.gg/wuthering-waves/characters
- **Prydwen.gg Wuthering Waves Echoes Page**  
  URL: http://www.prydwen.gg/wuthering-waves/echoes
- **Prydwen.gg Wuthering Waves Weapons Page**  
  URL: http://www.prydwen.gg/wuthering-waves/weapons

### File Docker dan Docker Compose
#### Dockerfile:
- Menggunakan gambar resmi Python dari Docker Hub.
- Menginstal dependensi sistem dan paket Python yang diperlukan.
- Menginstal Google Chrome dan ChromeDriver untuk Selenium.

#### Docker Compose:
- Mendefinisikan layanan untuk scraper dan database PostgreSQL.
- Mengatur volume dan jaringan untuk komunikasi antar kontainer.

### Variabel Lingkungan
#### credentials.env:
- Menyimpan kredensial database dan informasi sensitif lainnya.
- Dimuat menggunakan library dotenv.
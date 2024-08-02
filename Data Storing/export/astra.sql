--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: check_kode_produk_nama_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_kode_produk_nama_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Cek apakah Kode_Produk dan Nama_Produk cocok di tabel produk
    IF NOT EXISTS (
        SELECT 1 
        FROM produk 
        WHERE Kode_Produk = NEW.Kode_Produk 
        AND Nama_Produk = (SELECT Nama_Produk FROM Pesanan WHERE ID_Pesanan = NEW.ID_Pesanan)
    ) THEN
        RAISE EXCEPTION 'Kode_Produk % tidak cocok dengan Nama_Produk di tabel produk', NEW.Kode_Produk;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_kode_produk_nama_produk() OWNER TO postgres;

--
-- Name: check_nama_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_nama_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Cek apakah Nama_Produk ada di tabel produk
    IF NOT EXISTS (SELECT 1 FROM produk WHERE Nama_Produk = NEW.Nama_Produk) THEN
        RAISE EXCEPTION 'Nama_Produk % tidak ada di tabel produk', NEW.Nama_Produk;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_nama_produk() OWNER TO postgres;

--
-- Name: revert_produk_harga(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.revert_produk_harga() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Kembalikan harga di tabel produk ke harga sebelumnya dari produk_diskon
    UPDATE produk
    SET Harga = OLD.Harga_Sebelumnya
    WHERE Nama_Produk = OLD.Nama_Produk;
    
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.revert_produk_harga() OWNER TO postgres;

--
-- Name: update_produk_harga(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_produk_harga() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Perbarui harga di tabel produk dengan harga terbaru dari produk_diskon
    UPDATE produk
    SET Harga = NEW.Harga_Sekarang
    WHERE Nama_Produk = NEW.Nama_Produk;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_produk_harga() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Akun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Akun" (
    "ID_Akun" character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    nama_depan character varying(100),
    nama_belakang character varying(100),
    "Provinsi" character varying(100),
    "Kecamatan" character varying(100),
    "Kota" character varying(100),
    "Jalan" character varying(255),
    "No_Rumah" character varying(20)
);


ALTER TABLE public."Akun" OWNER TO postgres;

--
-- Name: Pembelian; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Pembelian" (
    "ID_Pembelian" character varying(50) NOT NULL,
    "Nama_Produk" character varying(255),
    "Harga_Total" numeric(10,1),
    "ID_Pesanan" character varying(50)
);


ALTER TABLE public."Pembelian" OWNER TO postgres;

--
-- Name: Pesan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Pesan" (
    "Kode_Produk" character varying(50) NOT NULL,
    "ID_Pesanan" character varying(50) NOT NULL
);


ALTER TABLE public."Pesan" OWNER TO postgres;

--
-- Name: Pesanan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Pesanan" (
    "ID_Pesanan" character varying(50) NOT NULL,
    "Nama_Produk" character varying(255) NOT NULL,
    "Jumlah" integer NOT NULL,
    "Harga" numeric(10,1) NOT NULL,
    "ID_Akun" character varying(50) NOT NULL
);


ALTER TABLE public."Pesanan" OWNER TO postgres;

--
-- Name: Telepon_Pelanggan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Telepon_Pelanggan" (
    "ID_Akun" character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    no_telp character varying(15) NOT NULL
);


ALTER TABLE public."Telepon_Pelanggan" OWNER TO postgres;

--
-- Name: Transaksi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaksi" (
    "ID_Transaksi" character varying(50) NOT NULL,
    "Jenis_Pembayaran" character varying(255),
    "Konfirmasi_Pembayaran" boolean,
    "ID_Pembelian" character varying(50)
);


ALTER TABLE public."Transaksi" OWNER TO postgres;

--
-- Name: cek_diskon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cek_diskon (
    nama_produk character varying(500) NOT NULL,
    kode_produk character varying(50) NOT NULL
);


ALTER TABLE public.cek_diskon OWNER TO postgres;

--
-- Name: motor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motor (
    kode_produk character varying(50) NOT NULL,
    fitur character varying(2644)
);


ALTER TABLE public.motor OWNER TO postgres;

--
-- Name: oli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oli (
    kode_produk character varying(50) NOT NULL,
    spesifikasi character varying(23) NOT NULL
);


ALTER TABLE public.oli OWNER TO postgres;

--
-- Name: peralatan_motor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peralatan_motor (
    kode_produk character varying(50) NOT NULL,
    motor_implementasi character varying(1092),
    berat character varying(9),
    warna character varying(27),
    dimensi character varying(25)
);


ALTER TABLE public.peralatan_motor OWNER TO postgres;

--
-- Name: produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produk (
    kode_produk character varying(50) NOT NULL,
    nama_produk character varying(500) NOT NULL,
    kategori character varying(100) NOT NULL,
    harga numeric(10,1) NOT NULL
);


ALTER TABLE public.produk OWNER TO postgres;

--
-- Name: produk_diskon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produk_diskon (
    nama_produk character varying(500) NOT NULL,
    harga_sebelumnya numeric(7,1) NOT NULL,
    harga_sekarang numeric(7,1) NOT NULL,
    kategori character varying(3) NOT NULL
);


ALTER TABLE public.produk_diskon OWNER TO postgres;

--
-- Data for Name: Akun; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Akun" ("ID_Akun", email, nama_depan, nama_belakang, "Provinsi", "Kecamatan", "Kota", "Jalan", "No_Rumah") FROM stdin;
\.


--
-- Data for Name: Pembelian; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Pembelian" ("ID_Pembelian", "Nama_Produk", "Harga_Total", "ID_Pesanan") FROM stdin;
\.


--
-- Data for Name: Pesan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Pesan" ("Kode_Produk", "ID_Pesanan") FROM stdin;
\.


--
-- Data for Name: Pesanan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Pesanan" ("ID_Pesanan", "Nama_Produk", "Jumlah", "Harga", "ID_Akun") FROM stdin;
\.


--
-- Data for Name: Telepon_Pelanggan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Telepon_Pelanggan" ("ID_Akun", email, no_telp) FROM stdin;
\.


--
-- Data for Name: Transaksi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaksi" ("ID_Transaksi", "Jenis_Pembayaran", "Konfirmasi_Pembayaran", "ID_Pembelian") FROM stdin;
\.


--
-- Data for Name: cek_diskon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cek_diskon (nama_produk, kode_produk) FROM stdin;
AHM Oil SPX2 - 0.8 L	082342MBK0LZ0
Oli Gardan Transmission Gear Oil (Fully Synthetic)	08234M99K8LZ0
Oli Gardan - Transmission Gear Oil	08294M99Z8YN1
AHM Oil MPX2 - 0.8 L 10W-30	08232M99K0LN5
AHM Oil SPX2 - 0.65 L 10W-30	082342MBK8LZ0
AHM Oil MPX2 - 0.65 L 10W-30	082322MBK3LN9
AHM Oil MPX1 - 0.8 L 10W-30	08234M99K0LN9
AHM Oil SPX1 - 0.8 L 10W-30	08234M99K0LN9
AHM Oil SPX1 - 1 L 10W-30	08234M99K1LN9
AHM Oil MPX3 - 0.8 L NIP	082322MAU0JN3
AHM Oil MPX1 - 1 L 10W-30 IDE	082322MAK1LN1
AHM Oil MPX3 - 1 L	082322MAU1JN3
AHM Oil MPX1 - 1.2 L 10W-30	082322MAK8LZ0
\.


--
-- Data for Name: motor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motor (kode_produk, fitur) FROM stdin;
Q6KZ53B7	Mesin injeksi tangguh & irit teknologi PGM-FI, membuat New Honda Revo FI lebih bertenaga, mudah dirawat., Bagasi serba guna berkapasitas 7 liter., Front disk brake yang membantu pengereman., Secure key shutter ? pengaman kunci kontak bermagnet (magnetic key shutter) yang efektif mengurangi resiko pencurian motor.
W6V9VKB7	Mesin 125cc ? 4 tak SOHC dengan PGM-FI., Charging port untuk handphone anda., Pengaman kunci kontak bermagnet (secure key shutter) untuk mengurangi resiko pencurian., Sistem pembuka kunci jok  yang berada di rumah kunci utama di depan., Fitur gantungan barang dengan pengaman pada bagian leher motor., Speedometer sporty & informatif dengan combined Analog ? Digital panel meter., Rem cakram ganda ? Front & Rear disk brake yang meningkatkan aspek keselamatan dengan sistem pengereman yang lebih optimal (khusus Supra X 125 CW. Fitur ini tidak hadir di Supra X 125 STD)., Konsumsi bahan bakar hingga 61,8 km/liter (pengujian internal).
USDH47JT	\N
W445GZJA	\N
1NJVNSS8	\N
EBS5G7G6	Motor Paling Irit Kategori Skutik 110 ? 115 cc di Otomotif Award 2010, Motor Paling Irit Kategori Skutik 110 ? 115 cc di Otomotif Award 2009, Performa Terbaik Kategori Skutik 110 ? 115 cc di Otomotif Award 2009, Skuter Matik No. 1 paling banyak dibicarakan dan dipromosikan di antara masyarakat Indonesia ? No. 1 Word of Mouth 2009 Award Majalah SWA
3BGBUUXW	\N
0L3GJEES	Pembayaran bisa dilakukan pada saat anda menerima motor atau via transfer., Saat ini Honda Cengkareng hanya dapat melayani pembelian untuk KTP Jakarta & Tangerang., Untuk KTP Tangerang dikenakan biaya pelanggaran wilayah sebesar Rp. 200,000., Untuk KTP Jakarta & Tangerang pengiriman Bekasi & Depok dikenakan biaya tambahan sebesar Rp. 250,000. (belum termasuk biaya pelanggaran wilayah Tangerang), Untuk KTP Bekasi & Depok dikenakan biaya tambahan sebesar Rp. 250,000, Harga yang tertera belum termasuk pajak progresif motor dimana untuk pembelian ke 2, 3, 4 dan seterusnya maka biaya pajak progresif akan dikenakan ke konsumen., Lihat disini untuk pemberitahuan lama proses STNK., Harga Sepeda motor Honda yang tertera disini tidak mengikat dan dapat berubah sewaktu waktu tanpa pemberitahuan terlebih dahulu.
UQ5S5I7A	Honda Vario 125 CBS MMC, Honda Vario 125 CBS ISS MMC
PBY5BIF1	Grande Matte Red, Grande Matte Black, Active Black
Y3IKXQFX	Royal Matte Black, Royal Matte White, Royal Green
BPPKJNK8	Full digital panel meter yang menghadirkan multi informasi., Smart Key System baru terintegrasi dengan alarm dan Answer Back System. Tombol pembuka tangki dan jok juga terintegrasi dengan kunci kontak, Desain velg baru dan ban yang lebih lebar, depan 110/70-14 dan belakang 130/70-13, Wheelbase yang lebih pendek berukuran 1.313mm sehingga semakin memudahkan pengendalian bagi pengendara., Fitur Anti Lock Braking System (ABS) pada variant ABS., Sistem Combi Brake System pada variant CBS., Rear Disc Brake, Lampu LED pada semua sistem pencahayaan., Teknologi Enhanced Smart Power (eSP) teknologi minim gesekan dan efisiensi pendinginan mesin, serta transmisi yang menghadirkan performa mesin terbaik., Socket untuk power charger yang disematkan di konsol box sisi depan, Kapasitas tanki BBM terbesar di kelasnya yaitu 8,1 liter.
1AUAKCTW	Tipe Mesin 4-Langkah, 4-Valves, eSP+, Tipe Pendinginan Pendingin Cairan, Khusus tipe ABS Di sematkan teknologi Honda Selectable Torque Control (HSTC). Fitur yang biasa disematkan pada big bike dan motor-motor premium, Sistem Suplain Bahan Bakar PGM-FI (Programmed Fuel Injection), ESS (Emergency Stop Signal) Secara otomatis akan mengaktifkan lampu hazard saat melakukan pengereman mendadak, ACG starter Tetap halus saat mesin dinyalakan, ISS (Idling Stop System) Membuat mesin mati otomatis saat berhenti, dan menyala kembali hanya dengan memutar tuas gas, Pengereman Di lengkapi dengan Anti-lock Braking System (ABS) dan Combi Brake System (CBS), USB Charger Daya max 5V 2,1A, Menggantikan power charger model lama, Full Digital Panel Meter Informatif & Modern dengan indikator pergatian oli mesin serta indikator suhu luar (yang pertama di kelasnya), Honda Smart Key dan alarm system Tetap aman dan nyaman, Extra Large Luggage Box Lebih nyaman dalam membawa barang bawaan
IK3M1135	Electricalli Adjustable Wind Screen ? Wind Screen yang pengaturan ketinggiannya dapat diatur sesuai dengan keinginan penggunanya., Body Mounted Back Mirror integrated With LED Winker ? Spion yang menyatu dengan body depan dan terintegrasi dengan lampu sein LED, Honda Selectable Torque Control ? Fitur untuk mengontrol sepeda motor, sehingga putaran roda depan dan belakang dapat dikontrol untuk mencegah terjadinya ban slip, Combined Digital Panel Meter ? Kombinasi panel meter digital dan analog yang informatif (Speed, RPM, HSTC Indicator, Fuel Consumption Meter, Maintenance Indicator, Trip Meter) semakin mewah dengan pemberian warna chrome dipinggiran panel meter, Power Charging ? Honda Forza dilengkapi dengan power charger * Penggunaan daya maksimal 12 W (12V 1A), Smart Key Sistem ? Sebuah teknologi canggih yang dikendalikan oleh remote dimana tidak lagi memerlukan kunci mekanis untuk menghidupkan mesin & mengunci stang. Terintegrasi dengan immobilizer, sistem keamanan Anti Theft Alarm & Answer Back System untuk mempermudah mencari posisi motor dilokasi parkiran, LED Headlight ? Lampu depan dengan teknologi LED yang memberikan kesan prestisius dan canggih, Anti Lock Braking System (ABS) ? Sistem pengereman canggih yang meningkatkan kestabilan & keselamatan dalam pengereman terutama saat pengereman mendadak, Extra Large U Box ? Bagasi yang sangat lega, dapat menyimpan 2 helm, LED Tailight With Hazard Lamp ? Lampu belakang dengan teknologi LED yang memberikan kesan prestisius dan canggih, Powerfull 250 cc Engine, Rear Disc Brake ? Sistem pengereman canggih yang berfungsi untuk meningkatkan performa pengereman yang lebih nyaman & stabil
3W0MIY6F	New Modern Round Headlamp ? Desain lampu bulat yang modern dilengkapi multireflector, menghasilkan pencahayaan yang maksimal dan menjadikan kamu lebih berkarakter., New Full Digital Panelmeter ? Panelmeter full digital dengan desain yang modern. tampil lebih informatif dan fungsional., Secure Key Shutter ? Sistem kunci dengan cover bermagnet dengan cover yang kuat untuk mengurangi resiko pencurian., New Tough Fuel Cap ? Tampil lebih tangguh dengan desain tutup tanki terbaru yang aman dan fungsional., New Muscular Shroud ? Tampil dengan desain shroud baru yang lebih keren & maskulin, menyempurnakan ketangguhan dan lebih percaya diri., Sistem 150cc PGM-FI yang lebih tangguh dan responsif ? Mesin 150cc yang lebih tangguh & repsonsif berstandar emisi Euro-3 lebih irit bahan bakar, ramah lingkungan dan hemat biaya perawatan., Adjustable Dual Rear Suspension ? Suspensi ganda yang dapat diatur tingkat kelembutannya agak lebih nyaman meredam setiap guncangan., New Sporty Muffler ? Desain cover muffler terbaru berwarna hitam, tampil semakin macho & keren.
6ITJCEPI	Mesin generasi terbaru DOHC 6 kecepatan dengan teknologi injeksi PGM-FI., Bodi ringan untuk kelincahan berkendara dengan desain sudut dan garis tajam., Desain lampu depan sporty dan tajam dilengkapi dengan lampu LED pada lampu utama & lampu senja. Teknologi LED memberikan pencahayaan lebih terang, futuristik, tahan lama serta lebih hemat energi., Panel indikator digital., Desain velg aluminimum., Rem cakram depan., Ban tubeless., Mampu berakselerasi 10,6 detik untuk jarak 0-200m., Mampu dipacu hingga 124,1 km / jam., Rangka tipe twin tube erimeter untuk mendukung performa optimal, bermanuver dan akselerasi yang cepat., Sudut putar yang lebar., Rear monoshock ? suspensi belakang tunggal untuk peredaman optimal, manuver lincah dan tampil lebih sporty.
CQ6HNG4W	Desain agresif., Penggunaan lampu LED pada seluruh sistem pencahayaan memberikan tampilan lebih futuristik, intensitas cahaya lebih terang, daya tahan lebih lama dan lebih hemat energi., Panel indikator digital yang futuristik dan fungsional menampilkan informasi lengkap seperti kecepatan, putaran mesin, jam digital dan trip meter., Akselerasi lebih agresif mencapai 10,5 detik (0-200m)., Mampu dipacu hingga 125 km/jam dengan tetap menghasilkan tingkat konsumsi bahan bakar yang efisien., Mesin generasi terbaru 150cc, DOHC 4 katup, 6 kecepatan, berpendingin cairan (liquid-cooled) dengan teknologi injeksi PGM-FI., Rangka Trelis yang memberi keseimbangan tinggi antara kekuatan dan kelenturan., Kapasitas tanki bensin 12 liter., Penggunaan ban yang lebih besar untuk memberikan rasa aman pada saat menikung maupun pada kecepatan tinggi., Rem cakram depan dan belakang., Ban tubeless., Suspensi belakang dengan sistem Pro-Link (fitur ini digunakan juga oleh motor Honda CBR 250R dimana dengan fitur ini tempat duduk terasa lebih lembut, stabil dan nyaman karena suspensi mampu menyesuaikan diri dengan berbagai kondisi jalan)., Teknologi Secure Key Shutter., Bank Angle Sensor ? sensor rebah yang melindungi pengendara pada saat terjatuh (mesin akan mati secara otomatis ketika sepeda motor berada pada sudut kemiringan 60? atau lebih.
9H74D4C4	Tapered Handlebar ? Memberikan image sporty dan kenyamanan dalam berkendara di perkotaan atau jarak jauh., High Windscreen ? Dilengkapi dengan High Windscreen untuk kenyamanan dan perlindungan dari terpaan angin saat berkendara., Full Digital Panelmeter ? Teknologi panel indikator full digital terbaru yang menyajikan informasi kendaraan dengan tampilan lebih sporty dan modern., LED Headlight ? Sistem pencahayaan LED pada headlight untuk kemampuan penerangan yang lebih baik., Inverted Front Suspension ? Suspensi bagian depan menambah kestabilan dan penuh kontrol, serta menambah kesan gagah., Adventure Style Undercowl ? Memberikan pelindungan terhadap mesin ketika berkendara., LED Taillight ? Sistem pencahayaan LED pada taillight untuk kemampuan penerangan yang lebih baik.
95QB93MJ	Penyematan disc brake yang bergelombang semakin menambah kesan sporty dan stylish, Desain baru pada cast wheel yang semakin modern memberikan kesan racing sesungguhnya, Disematkan Anti-lock Braking System (khusus untuk tipe ABS) di mana pengendara akan lebih nyaman dan aman saat melakukan pengereman., Emergency Stop Signal (ESS) pada tipe ABS. ESS secara otomatis akan mengaktifkan lampu hazard saat rem dioperasikan., Visor yang lebih tinggi sehingga memberikan kenyamanan pada pengendara., Tampilan warna baru digital panelmeter yang semakin canggih dan mudah dilihat, All LED Lighting System yang menghadirkan kesan canggih dan modern., Pengaturan 5 level pada masing masing suspensi depan dan belakang.
0JD2KD8W	Powerful Engine 150CC PGM-FI ? Mesin 150cc yang paling bertenaga dikelasnya, dilengkapi dengan sistem injeksi yang memberikan performa off-road tinggi tanpa kompromi saat melakukan eksplorasi di alam bebas., Digital Panel Meter ? Tampilan Speedometer yang lebih compact dan akurat membuat informasi berkendara lebih mudah terbaca., Compact Headlight ? Desain headlight yang membentuk sudut tajam sehingga memberikan kesan petarung, fearless dan siap menaklukan semua medan., Ban Dual Purpose ? Ukuran ban dan velg yang besar (21 inch bagian depan & 18 inch bgian belakang) dapat diandalkan diberbagai kondisi jalan., Alumunium Rims ? Penggunaan velg alumunium memberikan bobot yang ringan dan kekuatan optimal untuk terus berpetualang dalam semua kondisi., Long Travel Inverted Front Fork ? Suspensi depan Inverted terbesar dikelasnya dengan ukuran diameter pipa 37mm dan panjang stroke 225mm, memberikan performa handling maksimal dan lebih stabil saat melewati berbagai medan jalan. Tampilan juga menjadi semakin gagah dan berkelas dengan adanya gold color anodize pada tabung suspensi., Wavy Disc Brake ? Penggunaan rem cakram wavy depan 240mm dan belakang 220mm yang lebih besar dikelasnya memberikan performa pengereman yang optiomal di segala kondisi., New Taillight ? Desain lampu belakang yang tajam, sporty dan compact memberikan kesan agresif.
PE31W7XC	\N
T6H2Y65M	Digital Panel Meter
1RXPQ5CV	Mesin 250cc liquid-cooled single-cylinder DOHC, Dual Asymmetry LED Headlight with Floating Wind Screen, Digital panel Meter, Alumunium Swing Arm & Pro Link Rear Suspension (Showa), 43 mm Inverted Front Fork (Showa), Floating Wavy Disk Brake, Penyematan side panels dan posisi jok / tangki, Tangki bahan bakar yaitu 10,1L (termasuk 1,6L cadangan), Konsumsi bahan bakar 33,4 km/l (mode WMTC), Suspensi belakang Pro-Link dengan panjang langkah 265mm
3W5VOC2L	Mesin berkapasitas 500 CC ? DOHC Parallel ? Twin Engine ? Liquid-Cooled, 4-Stroke, 8-Valve, 6-Speed, PGM-FI (Programmed Fuel Injection)., Wavy Disc Brakes ? Kekuatan pengereman prima dengan rem cakram depan berdesain wavy yang stylish dengan diameter 320mm., Honda Ignition ? Security System (H.I.S.S) ? Immobilizer Honda ciptakan kenyamanan kelas dunia dengan kunci kontak canggih yang terhubung pada sistem elektronik., Pro-Link Rear Suspension ? Kenyamanan berkendara tiada tertandingi dari suspensi belakang tunggal dengan 9 posisi pengaturan didukung oleh sistem suspensi belakang Pro-Link., Enjoy Riding Position ? Kenyamanan naked sportbike tiada terbandingkan dengan posisi duduk lebih tegap tanpa membebankan berat pada tangan., Newly Designed Shroud & Undercowl ? Perlihatkan kegagahanmu dengan tampilan mesin baru berkarakter muscular. Perpaduan antara shroud dan undercowl yang lebih kecil dengan cover mesin berwarna bronze memberi sentuhan mechanical yang hanya dimiliki CB500F, New LED Tail Light ? Tampil semakin mengagumkan dengan lampu LED belakang dengan bentuk tajam di setiap sisinya, didukung intensitas penerangan maksimal. Dilengkapi spakbor yang dapat dilepas dan dipasang sesuai keinginan., ABS Braking System With Wave Pattern Disc Front & Rear ? melakukan pengereman di kondisi jalan menantang bukan lagi masalah. Kombinasi front 320mm dan rear 240mm wavy style disc brake menjadikan kekuatan pengereman semakin optimal., New Muffler Design ? Melajulah dengan gaya lebih maskulin dengan knalpot two chambers baru dengan desain lebih pendek. Lubang pada pipa di cahnmber kedua menjadikan suara dari knalpot terdengar lebih nyaring dan berkarakter., Adjustable Front Suspension ? Postur berkendara tetap nyaman di segala posisi dengan suspensi depan yang dapat disesuaikan di segala kondisi jalan., LCD Multi Meter ? Tampilan panel meter LCD yang sporti dan modern, menyajikan informasi yang lengkap (termasuk speedometer, tachometer, jam, trip meter dan pengukur bahan bakar)., European Manly-Sport Naked Design ? Desain naked-sport gagah bergaya Eropa modern didukung desain shroud khusus yang telah dipatenkan menawarkan kenyamanan tingkat tinggi dalam posisi berkendara., Rear Suspension System ? Kenyamanan berkendara tiada tertandingi dari suspensi belakangtunggal dengan 9 posisi pengaturan didukung sistem suspensi belakang Pro-Link., Brake Type ? Pengereman optimal di berbagai kondidi berkendara dengan cakram depan dan belakang berdesain ?wavy? memberi tampilan sporti., Adjustable Brake Lever ? Sesuaikan posisi rem tangan dengan 5 posisi pengaturan, membuat genggaman menjadi lebih nyaman bagi pengendara.
19HESTN3	New Stylish LED Head Light ? Ubah penampilanmu dengan penerangan tajam dari lampu LED depan berdesain stylish., Mesin berkapasitas 500 CC ? DOHC Parallel ? Twin Engine ? Liquid-Cooled, 4-Stroke, 8-Valve, 6-Speed, PGM-FI (Programmed Fuel Injection)., New LED Tail Light ? Tampil semakin mengagumkan dengan lampu LED belakang dengan bentuk tajam di setiap sisinya, didukung intensitas penerangan maksimal. Dilengkapi spakbor yang dapat dilepas dan dipasang sesuai keinginan., Adjustable Front Suspension ? Postur berkendara tetap nyaman di segala posisi dengan suspensi depan yang dapat disesuaikan di segala kondisi jalan., ABS Braking System With Wave Pattern Disc Front & Rear ? melakukan pengereman di kondisi jalan menantang bukan lagi masalah. Kombinasi front 320mm dan rear 240mm wavy style disc brake menjadikan kekuatan pengereman semakin optimal., New Muffler Design ? Berani tampil gagah dengan desain knalpot baru berlapis stainless steel. Dirancang khusus dengan two chambers dan lubang pada pipa chamber kedua didalamnya, menjadikan suara CBR500RR semakin nyaring dan berkarakter., Adjustable Brake Lever ? Sesuaikan posisi rem tangan dengan 5 posisi pengaturan, membuat genggaman menjadi lebih nyaman bagi pengendara., LCD Multi Meter ? Tampilan panel meter LCD yang sporti dan modern, menyajikan informasi yang lengkap (termasuk speedometer, tachometer, jam, trip meter dan pengukur bahan bakar).
JTX933LX	ABS Braking System With Wave Pattern Disc Front & Rear ? melakukan pengereman di kondisi jalan menantang bukan lagi masalah. Kombinasi front 320mm dan rear 240mm wavy style disc brake menjadikan kekuatan pengereman semakin optimal., Dual Purpose Tire ? Dukung pengendalian berkendara dengan daya cengkeram optimal di segala medan dengan alur ban yang didesain dengan dua karakter., Enjoy Riding Position ? Jelajahi dunia baru dengann posisi berkendara nyaman serta kebebasan gerak lebih maksimal dan nikmat berkendara alami di perkotaan hingga off-road., Mesin berkapasitas 500 CC ? DOHC Parallel ? Twin Engine ? Liquid-Cooled, 4-Stroke, 8-Valve, 6-Speed, PGM-FI (Programmed Fuel Injection)., Long Travel Suspension ? Rasakan sensasi kenyamanan menjelajah di segala medan jalan raya dan mudahnya pengendalian setang kemudi dengan suspensi teleskopik tipe Long-Travel berdiameter 41mm., Adjustable Front Suspension ? Inilah kenyamanan berkendara tiada tandingan dengan suspensi depan yang dapat disesuaikan. Postur berkendara jadi lebih nyaman di segala kondisi jalanan., New LED Tail Light ? Tampil semakin mengagumkan dengan lampu LED belakang dengan bentuk tajam di setiap sisinya, didukung intensitas penerangan maksimal., Newly Designed Side Fairing ? Sang motor petualang kini tampil dengan sisi fairing baru lebih tajam. Dilengkapi striping Bold New Graphic yang perlihatkan sisi petualangmu., Adjustable Wind Screen ? Hadapi segala tantangan cuaca dengan kaca pelindung yang lebih tinggi dan dapat diatur sesuai keinginan. Desain barunya juga mengurangi turbulensi di sekitar helm., Adjustable Brake Lever ? Sesuaikan posisi rem tangan dengan 5 posisi pengaturan, membuat genggaman menjadi lebih nyaman bagi pengendara.
I73QRBND	New Muffler Design With ?Four-Into-One? Exhaust System ? Dapatkan power, gaya dan raungan berkelas dari sistem knalpot ?Four-Into-One? CB650F., New LED Headlight ? Nyalakan keberanian dalam diri dengan headlight berpenampilan tajam dan masif yang terintegrasi dengan lampu LED, LCD Multi Meter ? Tampilan panel meter LCD sporti dan modern menyajikan informasi lengkap (termasuk speedometer, tachometer, jam, trip meter dan pengukur bahan bakar)., The Latest SDVB Front Fork ? Dual Front Disk Brake with 2 channel ABS, Aluminium Swing Arm ? Didesain khusus menggunakan alumunium untuk performa terbaik dan penampilan optimal., Honda Ignition Security System (H.I.S.S) ? Immobilizer Honda ciptakan keamanan kelas dunia dengan kunci kontak canggih yang terhubung pada sistem elektronik., New DOHC Inline 4 Cylinder ? with more powerful performance.
SATQOPVG	Rem ABS dengan ban lebar dan tubeless, 500cc, Parallel Twin ? eight valve, liquid cooled parallel twin with strong bottom and torque and a smooth, linear power delivery., Digital Panel Meter ? equipped with negative LCD display and blue backlight, its very striking, modern and effective when riding in all condition., Iconic Fuel Tank ? express offbeat individuality from every angle, Iconic Headlamp ? evocative round headlight sits up high in a die-cast aluminium mount, describes a strong classic & individualistic, Brakings System ? Using double disc brake with twin piston caliper and single piston rear disc brake, fitted with ABS 2 channel.
N6XT5PEK	Dual Clutch Transmission (DCT), Mesin 1000cc parallel-twin dengan 4 katup Unicam head, Penyematan besi baja dengan frame semi-double cradle, Dual kaliper Nissin 4 piston kaliper dan 310mm wave floating disc brake, Suspensi belakang Showa dengan spring preload yang dapat diatur, Sistem elektrik Selectable Torque Control (HSTC), Dual LED Headlight, Alumunium Swing Arm & Pro Link Rear Suspension (Showa), 43 mm Inverted Front Fork (Showa), Floating Wavy Disk Brake, Tangki bahan bakar yaitu 18,8L, Large Spoke Wheel 21/19 Alumunium & Swing Arm
OX9LL564	Mesin berkapasitas 1000 CC ? DOHC Inline ? Four Engine. ? Liquid-Cooled, 4-Stroke, 16-Valve, 6-Speed, PGM-DSFI (Programmed Dual Sequential Fuel Injection) with Assist Sliper Clutch (same type as applied on RCV 212V) and Piston & Con-Rod Grading by Weight., Suspension System ? Suspensi depan upside down OHLINS NIX30 dan suspensi belakang OHLINS TTX36 berkolaborasi dengan swingarm tipe ?Gul-Wing? berbahan alumunium untuk menghasilkan Balance-Free Rear Cushion (pertama di dunia)., Bracking System ? Sistem pengereman canggih Combined-ABS dikontrol secara elektronis, dilengkapi dengan kaliper rem depan BREMBO Monobloc 4 piston (pertama di dunia), teknologi eC-ABS untuk supersport bike., Special Tire ? Siap melesat cepat di sirkuit maupun jalan raya dengan daya cengkeram tinggi dari ban Pirelli Diablo Supercorsa SC Premium., Honda Electronic Steering Damper (H.E.S.D) ? Teknologi canggih yang secara elektronis mengontrol karakteristik damping force berdasarkan kecepatan dan akseslerasi untuk menghasilkan handling kuat dan stabil (pertama di dunia, Hydraulic Steering Damper yang dikontrol secara elektronis)., Lightweight Alumunium Frame ? Jadilah sang juara dengan kelincahan dan pengendalian traksi tak terbandingkan dari rangka ringan bertipe alumunium kembar komposit 4 bagian yang dirancang khusus menyesuaikan suspensi Ohlins., Honda Ignition Security System (H.I.S.S) ? Immobilizer Honda ciptakan keamana kelas dunia dengan kunci kontak canggih yang terhubung pada sistem elektronik., Ohlins Suspension ? Taklukkan medan didepan matamu dengan performa superior suspensi dengan upside down Ohlins NIX30 dan suspensi belakang OhlinsTTX36 yang mampu menyesuaikan diri di berbagai kondisi., Brembo Monobloc Front Caliper ? Pengereman kelas dunia dengan cengkraman pakem pada rem cakram dengan kaliper rem depan Brembo monobloc 4 piston., Revolutionary ec-ABS ? Tantang segala medan bersama sportbike pertama dunia dengan pengereman revolusioner, Combined-ABS yang dikontrol secara elektronis sehingga mampu mendistribusi dan menyesuaikan hentakan pengereman pada ban motor., LCD Instruments ? Tampilkan informasi akurat dari instrumentasi LCD layar penuh lengkap dengan pengukur kecepatan putaran, penghitung perjalanan dan konsumsi bahan bakar, indikator perpindahan 5 tingkat yang dapat disesuaikan, indikator letak gigi dan fungsi memori peak-rpm
\.


--
-- Data for Name: oli; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oli (kode_produk, spesifikasi) FROM stdin;
082342MBK0LZ0	10W-30, API:SJ, JASO:MB
08234M99K8LZ0	nan
08294M99Z8YN1	nan
08CLAH50500	nan
HBF50ML	nan
ACG10GR	nan
08232M99K0LN5	10W-30, API:SJ, JASO:MB
SS8175ML	nan
082342MBK8LZ0	nan
082322MBK3LN9	nan
082322MAK0LN5	10W-30, API:SJ, JASO:MA
ACL70ML	nan
08234M99K8LN9	10W-30, API:SJ, JASO:MA
08234M99K0LN9	nan
CC200ML	nan
OSC70ML	nan
TBC500ML	nan
08234M99K1LN9	10W-30, API:SJ, JASO:MA
082322MAU0JN3	20W-40, API:SJ, JASO:MA
082322MAK1LN1	nan
082322MAU1JN3	10W-30, API:SJ, JASO:MA
082322MAK8LZ0	10W-30, API:SJ, JASO:MA
\.


--
-- Data for Name: peralatan_motor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peralatan_motor (kode_produk, motor_implementasi, berat, warna, dimensi) FROM stdin;
81132GAH000YV	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nGenio (2019 - 2022)\nScoopy eSP K16R (2015 - 2017)\nScoopy eSP K93 (2017 - 2020)\nScoopy FI K16G (2013 - 2015)\nSpacy Karburator (2011 - 2013)\nVario 110 CW (2006 - 2014)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60 (2015 - 2018)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59 (2015 - 2018)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.05 kg	Hitam	\N
50732K97T00ZA	PCX 150 K97 (2017 - 2021)	0.1 kg	Hitam	\N
81137K0WN00ZB	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	0.0002 kg	Hitam	10.0 cmx 10.0 cmx 10.0 cm
80102K59A10	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.8 kg	Hitam	\N
64600K56N00	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Hitam	\N
81265K97T00	PCX 150 K97 (2017 - 2021)	0.1 kg	Hitam	\N
8010EK59A10	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	1 kg	Hitam	\N
8010DK59A10	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Hitam	\N
80103K97T00	PCX 150 K97 (2017 - 2021)	5 kg	Hitam	\N
6130BK56N00	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
81145K59A70ZB	Stylo 160 (2024 - Sekarang)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)	0.05 kg	Hitam	\N
50742K97T00ZA	PCX 150 K97 (2017 - 2021)	0.1 kg	Hitam	\N
61311K56N00	Sonic 150R K56 (2015 - Sekarang)	1 kg	Hitam	\N
19642K66V00	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.2 kg	Hitam	\N
6430CK56N10	Supra GTR K56F (2016 - 2019)	6 kg	Hitam	\N
64308K59A70ZB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Hitam	\N
53207K81N30ZA	BeAT Sporty eSP K81 (2016 - 2020)	0.5 kg	Hitam	\N
80103K59A70ZB	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)	0.5 kg	Hitam	\N
64303K59A10ZA	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	4 kg	Hitam	\N
18318K59A70	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	\N
64271K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	1 kg	Hitam	\N
64241K45N40	CBR 150R K45G (2016 - 2018)	3 kg	Hitam	\N
4051AK41N00	Blade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	0.6 kg	Hitam	\N
64337K97T00ZA	PCX 150 K97 (2017 - 2021)	1.5 kg	Hitam	\N
81141K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	8 kg	Hitam	\N
64261K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	1 kg	Hitam	\N
64305K81N00ZA	BeAT Sporty eSP K81 (2016 - 2020)	1 kg	Hitam	\N
64336K97T00ZA	PCX 150 K97 (2017 - 2021)	3 kg	Hitam	\N
64332K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Hitam	27 cmx 22 cmx 15 cm
64308K59A10ZB	Vario 125 eSP K60 (2015 - 2018)	5 kg	Hitam	\N
6430DK59A10ZB	Vario 150 eSP K59 (2015 - 2018)	8 kg	Hitam	\N
40510K56N00	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
80115K59A10	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.4 kg	Hitam	\N
81141K59A10ZB	Vario 125 eSP K60 (2015 - 2018)	13 kg	Hitam	67 cmx 39 cmx 30 cm
64310K59A70ZB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	8.7 kg	Hitam	\N
8114AK59A10ZB	Vario 150 eSP K59 (2015 - 2018)	15 kg	Hitam	\N
6434AK59A10ZB	Vario 150 eSP K59 (2015 - 2018)	8 kg	Hitam	\N
17234K97T00	ADV 150 (2019 - 2022)\nPCX 150 K97 (2017 - 2021)	0.8 kg	Hitam	\N
19640K97T00	PCX 150 K97 (2017 - 2021)	1.5 kg	Hitam	\N
61302K84900	CRF150L K84 (2017 - Sekarang)	3 kg	Hitam	\N
81131K97T00ZA	PCX 150 K97 (2017 - 2021)	9 kg	Hitam	\N
64420K59A70ZD	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.8 kg	Hitam	\N
61306K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
64310K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	7 kg	Hitam	\N
53206K59A10ZB	Vario 150 eSP K59 (2015 - 2018)	4 kg	Hitam	\N
64405K97T00ZA	PCX 150 K97 (2017 - 2021)	0.1 kg	Hitam	\N
6470AK56N00	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
5320DK59A10ZA	Vario 150 eSP K59 (2015 - 2018)	3.3 kg	Hitam	\N
80101K97N00	PCX 150 K97 (2017 - 2021)	7 kg	Hitam	\N
64350K60B60ZB	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)	3 kg	Hitam	\N
8010AK59A10	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	17 kg	Hitam	\N
64410K97T00ZA	PCX 150 K97 (2017 - 2021)	3 kg	Hitam	\N
64340K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	6 kg	Hitam	\N
61310K15930	CB150R StreetFire K15M (2018 - 2021)	0.7 kg	Hitam	\N
80104K59A10	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60 (2015 - 2018)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59 (2015 - 2018)\nVario 150 eSP K59J (2018 - 2022)	0.1 kg	Hitam	\N
61305K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	0.5 kg	Hitam	\N
6431AK59A10ZB	Vario 150 eSP K59 (2015 - 2018)	8.7 kg	Hitam	\N
83520K59A10ZB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
64420K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	26 cmx 20 cmx 5 cm
80131K97T00	PCX 150 K97 (2017 - 2021)	0.3 kg	Hitam	\N
80115K97T00	PCX 150 K97 (2017 - 2021)	0.3 kg	Hitam	\N
8016AK61900	BeAT POP eSP K61 (2014 - 2019)\nSonic 150R K56 (2015 - Sekarang)	1 kg	Hitam	\N
17235K97N00	PCX 150 K97 (2017 - 2021)	2 kg	Hitam	\N
6422AK45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.3 kg	Hitam	\N
19642K2FN10	Scoopy K2F (2020 - Sekarang)	0.4 kg	Hitam	20 cmx 19 cmx 4 cm
64308K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	6 kg	Hitam	\N
83650K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	3 kg	Hitam	\N
64320K59A70ZD	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	\N
6452AK56N00	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Hitam	\N
64320K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	0.4 kg	Hitam	27 cmx 20 cmx 5 cm
64303K59A10ZE	Vario 150 eSP K59 (2015 - 2018)	4 kg	Merah	\N
64340K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	6 kg	Hitam	\N
80105K59A70	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)	2 kg	Hitam	40 cmx 20 cmx 15 cm
64360K60B60ZB	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)	3 kg	Hitam	\N
8010BK56N00	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
19642K59A10	Sonic 150R K56 (2015 - Sekarang)\nVario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	1 kg	Hitam	\N
64460K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	0.5 kg	Hitam	\N
83550K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	3 kg	Hitam	\N
64303K59A70ZD	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	\N
19610K44V00	BeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nScoopy eSP K16R (2015 - 2017)\nScoopy eSP K93 (2017 - 2020)\nVario 110 eSP (2015 - 2019)	2 kg	Hitam	\N
64312K93N00	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Hitam	20 cmx 15 cmx 3 cm
81141K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	10 kg	Hitam	50 cmx 40 cmx 30 cm
83700K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	0.2 kg	Hitam	\N
81141K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
64320K46N20	Vario 110 eSP (2015 - 2019)	3 kg	Hitam	\N
80106K59A10	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	\N
64230K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2 kg	Hitam	\N
64311K93N00	Scoopy eSP K93 (2017 - 2020)	0.05 kg	Hitam	14 cmx 8 cmx 2 cm
64330K46N00	Vario 110 FI (2014 - 2015)	3 kg	Hitam	\N
5325BK25600	BeAT Sporty eSP K25G (2014 - 2016)	8 kg	Hitam	\N
81143K93N00	Scoopy eSP K93 (2017 - 2020)	0.7 kg	Hitam	\N
64330K56N00	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
81131K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	6 kg	Hitam	\N
50410K93N00ZE	Scoopy eSP K93 (2017 - 2020)	2 kg	Silver	\N
64302K59A10ZC	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	1 kg	Hitam	\N
64308K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	7.3 kg	Hitam	43 cmx 30 cmx 34 cm
8010AK15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	5 kg	Hitam	\N
64326K97T00	PCX 150 K97 (2017 - 2021)	0.5 kg	Hitam	\N
64503K0WN00	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	4 kg	Hitam	\N
64303K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	5 kg	Hitam	34 cmx 44 cmx 20 cm
64302K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	3 kg	Hitam	\N
64231K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.3 kg	Hitam	\N
64308K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	5 kg	Hitam	50 cmx 40 cmx 15 cm
80151K59A10ZB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Hitam	\N
80104K59A70	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)	1.7 kg	Hitam	\N
50741K97T00ZA	PCX 150 K97 (2017 - 2021)	0.2 kg	Hitam	\N
6455AK56N00	Sonic 150R K56 (2015 - Sekarang)	6 kg	Hitam	\N
64310K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	8 kg	Hitam	\N
11350K97T00	PCX 150 K97 (2017 - 2021)	0.2 kg	Hitam	\N
5062AK25600	BeAT Sporty eSP K25G (2014 - 2016)	5 kg	Hitam	\N
53206K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	3 kg	Hitam	\N
61304K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	0.5 kg	Hitam	\N
61200K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	4 kg	Hitam	\N
64308K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	6.6 kg	Hitam	50 cmx 36 cmx 20 cm
81141K60B60ZA	Vario 125 eSP K60R (2018 - 2022)	6 kg	Hitam	\N
80110K56N10	Supra GTR K56F (2016 - 2019)	2.5 kg	Hitam	\N
64340K2FN00ZB	Scoopy K2F (2020 - Sekarang)	12 kg	\N	67 cmx 38 cmx 29 cm
64325K97T00	PCX 150 K97 (2017 - 2021)	0.5 kg	Hitam	\N
64223K2SN00	Vario 160 K2S (2022 - Sekarang)	1.7 kg	Hitam	28 cmx 25 cmx 15 cm
50280K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	1.6 kg	Hitam	\N
83620K59A10ZB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
53206K60B00ZB	Vario 125 eSP K60 (2015 - 2018)	4 kg	Hitam	\N
81141K59A70ZA	Vario 150 eSP K59J (2018 - 2022)	15 kg	Hitam	\N
53205K59A10ZB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
50285K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	1.6 kg	Hitam	\N
81131K59A10ZJ	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Hitam	\N
64460K59A10ZB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.3 kg	Hitam	\N
8010CK81N00	BeAT Sporty eSP K81 (2016 - 2020)	15 kg	Hitam	68 cmx 38 cmx 35 cm
81131K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	\N	\N
64221K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.3 kg	Hitam	\N
64301K1AN00MGB	BeAT dan BeAT Street K1A (2020 - 2024)	15 kg	Hitam	\N
80151K59A70ZD	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Hitam	\N
61101K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.2 kg	Hitam	14 cmx 12 cmx 4 cm
6432AK56N10	Supra GTR K56F (2016 - 2019)	3 kg	Hitam	\N
80151K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	6 kg	Hitam	\N
50731K97T00ZA	PCX 150 K97 (2017 - 2021)	0.2 kg	Hitam	\N
53206K81N10ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	3 kg	Hitam	\N
6423AK45N40	CBR 150R K45G (2016 - 2018)	1.6 kg	Hitam	\N
81141K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	10 kg	Hitam	\N
64521K97T00	PCX 150 K97 (2017 - 2021)	10 kg	Hitam	\N
64430K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	10 kg	Hitam	\N
53205K56NJ0	Supra GTR K56W (2019 - Sekarang)	5 kg	Hitam	\N
53206K59A10ZA	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Hitam	\N
80121K97T00	PCX 150 K97 (2017 - 2021)	0.3 kg	Hitam	\N
64460K25600	BeAT Sporty eSP K25G (2014 - 2016)	0.4 kg	Hitam	\N
64310K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Hitam	50 cmx 38 cmx 15 cm
64450K15920	CB150R StreetFire K15G (2015 - 2018)	3.1 kg	Hitam	\N
53206K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	3 kg	Hitam	\N
64340K59A10ZB	Vario 125 eSP K60 (2015 - 2018)	13 kg	Hitam	\N
53204K59A10ZB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.3 kg	Hitam	\N
40510K84900	CRF150L K84 (2017 - Sekarang)	5 kg	Hitam	\N
64321K97T00ZA	PCX 150 K97 (2017 - 2021)	15 kg	Hitam	\N
61200K56N00	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
64320K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	3 kg	Hitam	\N
64360K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Hitam	\N
80103K0WN00	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
81131K25900ZB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	8 kg	Hitam	\N
64305K81H00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	2 kg	Hitam	\N
6443AK45N40	CBR 150R K45G (2016 - 2018)	10 kg	Hitam	\N
64310K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	4.5 kg	Hitam	58 cmx 44 cmx 10 cm
81141K1AN10ZA	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
64340K93N00ZB	Scoopy eSP K93 (2017 - 2020)	17 kg	Hitam	65 cmx 39 cmx 40 cm
6432AK56N40	Supra GTR K56F (2016 - 2019)	4 kg	Merah	\N
83520K59A70ZB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Hitam	\N
6430CK56N40	Supra GTR K56F (2016 - 2019)	6 kg	Merah	\N
6410AK56N00	Sonic 150R K56 (2015 - Sekarang)	5 kg	Hitam	\N
53206K59A70ZB	Vario 150 eSP K59J (2018 - 2022)	1.5 kg	Hitam	\N
64330K59A70ZC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.2 kg	Hitam	\N
67111K45N40	CBR 150R K45G (2016 - 2018)	2 kg	Putih	\N
80151K59A10ZC	Vario 150 eSP K59 (2015 - 2018)	3 kg	Merah	\N
83650K84900ZB	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	\N
64350K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Hitam	\N
8015AK56N00	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	60 cmx 20 cmx 12 cm
53216K56NJ0ZA	Supra GTR K56W (2019 - Sekarang)	5 kg	Hitam	\N
64301K25900FMB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	14 kg	Hitam	52 cmx 36 cmx 46 cm
83620K59A70ZB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Hitam	\N
80105K93N00	Scoopy eSP K93 (2017 - 2020)	12 kg	Hitam	78 cmx 37 cmx 25 cm
64330K61900ZA	BeAT POP eSP K61 (2014 - 2019)	5 kg	Hitam	\N
53205K97T00	PCX 150 K97 (2017 - 2021)	0.5 kg	Silver	\N
64325K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	3 kg	Hitam	\N
50315K15920ZA	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)	1 kg	Hitam	\N
61100K59A10AFB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	7 kg	Hitam	\N
80160K81N00	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.93 kg	Hitam	35 cmx 20 cmx 8 cm
8010BK25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	8 kg	Hitam	\N
81131K59A10ZG	Vario 150 eSP K59 (2015 - 2018)	1.6 kg	Putih	\N
64430K56N00	Sonic 150R K56 (2015 - Sekarang)	7 kg	Hitam	\N
83400K15600ZA	CB150R StreetFire K15M (2018 - 2021)	0.5 kg	Hitam	\N
17235K1ZN20	ADV 160 (2022 - Sekarang)\nPCX 160 K1Z (2021 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	1.5 kg	Hitam	45 cmx 19 cmx 12 cm
64320K61900ZA	BeAT POP eSP K61 (2014 - 2019)	5 kg	Hitam	\N
81131K59A10ZF	Vario 150 eSP K59 (2015 - 2018)	1.6 kg	Hitam	\N
6433AK45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	\N
81141K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Hitam	\N
6450AK56N00	Sonic 150R K56 (2015 - Sekarang)	6 kg	Hitam	\N
64320K46N00	Vario 110 FI (2014 - 2015)	3 kg	Hitam	\N
80110K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	17 kg	Hitam	79 cmx 38 cmx 35 cm
80110GN5830	Grand Impressa (1991 - 2000)\nLegenda (2001 - 2004)	0.2 kg	Hitam	\N
64311K97T00ZA	PCX 150 K97 (2017 - 2021)	15 kg	Hitam	\N
80105K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	1 kg	Hitam	\N
64202K93N00ZN	Scoopy eSP K93 (2017 - 2020)	3 kg	Coklat	\N
6430BK25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Hitam	\N
6131BK15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	2 kg	Hitam	\N
64630K56N10	Sonic 150R K56 (2015 - Sekarang)\nSupra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	2.5 kg	Hitam	\N
50325K15920ZA	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)	1 kg	Hitam	\N
64615K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	0.2 kg	Hitam	\N
83141K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	1 kg	Merah	37 cmx 21 cmx 7 cm
64340K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Hitam	\N
61302K56N00ZD	Sonic 150R K56 (2015 - Sekarang)	0.2 kg	Putih	\N
5320AK61900	BeAT POP eSP K61 (2014 - 2019)	3 kg	Hitam	\N
17575K81N00	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.35 kg	Hitam	\N
83550K84900ZB	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	\N
64430K59A70ZC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.5 kg	Hitam	\N
83610K84920ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	\N
64301K25900PFW	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	11 kg	Putih	\N
64530K97T00	PCX 150 K97 (2017 - 2021)	3 kg	Hitam	\N
53216K56N10ZA	Supra GTR K56F (2016 - 2019)	3 kg	Hitam	\N
17575K93N00	Scoopy eSP K93 (2017 - 2020)	0.2 kg	Hitam	\N
83650K84900ZA	CRF150L K84 (2017 - Sekarang)	6 kg	Putih	\N
64301K93N00ZL	Scoopy eSP K93 (2017 - 2020)	6 kg	Coklat	\N
64310K59A10ZB	Vario 125 eSP K60 (2015 - 2018)	8 kg	Hitam	\N
80100K56N10	Supra GTR K56F (2016 - 2019)	3 kg	Hitam	60 cmx 20 cmx 12 cm
64340K0JN00ZB	Genio (2019 - 2022)\nGenio K0JN (2022 - Sekarang)	11 kg	Hitam	65 cmx 40 cmx 25 cm
81140K97N00ZA	PCX 150 K97 (2017 - 2021)	0.25 kg	Hitam	\N
64340K59A70ZB	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	8 kg	Hitam	\N
64330K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	\N
64440K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Hitam	\N
80104KVB900	Vario 110 CW (2006 - 2014)	0.3 kg	Hitam	\N
61304K56N00ZA	Sonic 150R K56 (2015 - Sekarang)	0.6 kg	Putih	\N
6452BK56N10	Supra GTR K56F (2016 - 2019)	3 kg	Hitam	\N
81141K0JN00ZC	Genio (2019 - 2022)	8 kg	Hitam	\N
64311K0WN00ZB	ADV 150 (2019 - 2022)	7 kg	Hitam	\N
61104KC6000	\N	0.3 kg	Hitam	\N
64308K46N00	Vario 110 FI (2014 - 2015)	5.5 kg	Hitam	\N
64601K59A10AFB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	4 kg	Hitam	\N
50260K15920MGB	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
80101K0WN00	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	3 kg	Hitam	\N
64501K97T00YD	PCX 150 K97 (2017 - 2021)	15 kg	Putih	\N
61100K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	3 kg	Hitam	\N
64501K59A10AFB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	4 kg	Hitam	\N
80105K0JN00ZB	Genio (2019 - 2022)	8 kg	Hitam	\N
64310K93N00ZB	Scoopy eSP K93 (2017 - 2020)	11 kg	Coklat	\N
80121K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	2 kg	Hitam	\N
83760K0WN00ZA	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
61303K18960	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	1.2 kg	Hitam	\N
83550K46N00ZA	Vario 110 FI (2014 - 2015)	2.5 kg	Hitam	\N
50607K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	1 kg	Hitam	\N
64501K59A10MGB	Vario 150 eSP K59 (2015 - 2018)	4 kg	Hitam	\N
17570K84900	CRF150L K84 (2017 - Sekarang)	8 kg	Hitam	\N
61100K81N00ZC	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	3 kg	Putih	\N
64601K59A10MGB	Vario 150 eSP K59 (2015 - 2018)	4 kg	Hitam	\N
61100K25900ZD	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Hitam	\N
61100K59A10MGB	Vario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
64501K59A10PFW	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	4 kg	Putih	\N
64431K0WN00ZB	ADV 150 (2019 - 2022)	4 kg	Silver	54 cmx 34 cmx 24 cm
1757AK61900	Sonic 150R K56 (2015 - Sekarang)	1 kg	Hitam	\N
64201K93N00ZK	Scoopy eSP K93 (2017 - 2020)	3 kg	Hitam	\N
61100K93N00ZK	Scoopy eSP K93 (2017 - 2020)	8 kg	Coklat	\N
64301K81N00FMB	BeAT Sporty eSP K81 (2016 - 2020)	11 kg	Hitam	\N
64223K1AN01	BeAT dan BeAT Street K1A (2020 - 2024)	1 kg	Hitam	\N
87586KTM780	Revo 110 FI (2014 - Sekarang)\nSonic 150R K56 (2015 - Sekarang)\nSuper Cub C125 (2018 - Sekarang)\nSupra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)\nSupra X 125 FI New (2014 - Sekarang)	0.2 kg	Hitam	\N
81250K59A10	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	8.6 kg	Hitam	\N
53205K2VN30ZC	Vario 125 eSP K2V (2022 - Sekarang)	1.7 kg	Hitam	36 cmx 17 cmx 16 cm
64302K1AM00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	0.3 kg	Hitam	26 cmx 20 cmx 5 cm
64434K97T00ZA	PCX 150 K97 (2017 - 2021)	1 kg	Hitam	\N
08R80K18H00	Verza 150 (2013 - 2018)	2 kg	Hitam	\N
64202K93N00ZK	Scoopy eSP K93 (2017 - 2020)	3 kg	Hitam	\N
50270K15920ZA	CB150R StreetFire K15G (2015 - 2018)	0.2 kg	Merah	\N
64311K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	7.5 kg	Hitam	100 cmx 30 cmx 15 cm
81131K1AN10ZA	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
80151K46N00ZA	Vario 110 FI (2014 - 2015)	3 kg	Hitam	\N
8010BK25600	BeAT Sporty eSP K25G (2014 - 2016)	8 kg	Hitam	\N
5070AK56N10	Supra GTR K56F (2016 - 2019)	6 kg	Hitam	\N
64321K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	7.5 kg	Hitam	100 cmx 30 cmx 15 cm
8114AK25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	6 kg	Hitam	\N
50265K15920MGB	CB150R StreetFire K15G (2015 - 2018)	2 kg	Hitam	\N
80104K93N00	Scoopy eSP K93 (2017 - 2020)	0.2 kg	Hitam	\N
61100K1AN00MGB	BeAT dan BeAT Street K1A (2020 - 2024)	6 kg	Hitam	\N
81143K97T00ZA	PCX 150 K97 (2017 - 2021)	1 kg	Hitam	\N
6451BK56N10	Supra GTR K56F (2016 - 2019)	3 kg	Hitam	\N
81131K59A10ZH	Vario 150 eSP K59 (2015 - 2018)	1.6 kg	Hitam	\N
19641K2FN10	Scoopy K2F (2020 - Sekarang)	0.4 kg	Hitam	\N
64308K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Hitam	\N
64601K59A70ZC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	8 kg	Hitam	\N
8352AK56N10	Supra GTR K56F (2016 - 2019)	3 kg	Hitam	\N
50275K15920ZA	CB150R StreetFire K15G (2015 - 2018)	0.2 kg	Merah	\N
64310K2FN00ZC	Scoopy K2F (2020 - Sekarang)	5.1 kg	Hitam	55 cmx 40 cmx 14 cm
64501K59A70ZC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	8 kg	Hitam	\N
5325BK25610	BeAT Sporty eSP K25G (2014 - 2016)	2 kg	Hitam	\N
5320CK46N20	Vario 110 eSP (2015 - 2019)	3 kg	Hitam	\N
50280K15600	CB150R StreetFire K15M (2018 - 2021)	1.5 kg	Hitam	46 cmx 20 cmx 10 cm
64301K25600RSW	BeAT Sporty eSP K25G (2014 - 2016)	8 kg	Putih	36 cmx 35 cmx 52 cm
64201K93N00ZN	Scoopy eSP K93 (2017 - 2020)	3 kg	Coklat	\N
17575K61900	BeAT POP eSP K61 (2014 - 2019)	0.35 kg	Hitam	23 cmx 22 cmx 12 cm
80103K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	1 kg	Hitam	\N
64460K93N00ZB	Scoopy eSP K93 (2017 - 2020)	0.2 kg	Coklat	\N
64301K93N00ZN	Scoopy eSP K93 (2017 - 2020)	8.6 kg	Putih	\N
80151K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	4.6 kg	Hitam	\N
61100K59A10PFW	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Putih	\N
64321K0WN00ZB	ADV 150 (2019 - 2022)	8 kg	Hitam	\N
64521K0WN00	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
64501K97T00ZR	PCX 150 K97 (2017 - 2021)	15 kg	Hitam	\N
64337K1ZJ10ZC	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	3 kg	Hitam	44 cmx 26 cmx 15 cm
64350K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	4.3 kg	Hitam	75 cmx 35 cmx 10 cm
61100K56N10ZD	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	5 kg	Hitam	\N
64251K45NL0	CBR 150R K45R (2021 - Sekarang)	2 kg	Hitam	23 cmx 34 cmx 14 cm
8114AK46N20	Vario 110 eSP (2015 - 2019)	8 kg	Hitam	\N
64601K59A10PFW	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	4 kg	Putih	\N
64202K2FN00ZQ	Scoopy K2F (2020 - Sekarang)	2 kg	Putih	60 cmx 20 cmx 10 cm
64336K1ZJ10ZC	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	3 kg	Hitam	44 cmx 46 cmx 8 cm
64380K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2 kg	Hitam	\N
64211K45N40ZD	CBR 150R K45G (2016 - 2018)	3 kg	Hitam	\N
81141K2FN10ZE	Scoopy K2F (2020 - Sekarang)	10 kg	Hitam	60 cmx 40 cmx 20 cm
83610K84920ZB	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	\N
64501K2SN00ZD	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Hitam	40 cmx 27 cmx 6 cm
64310K2FN00ZB	Scoopy K2F (2020 - Sekarang)	7 kg	Coklat	56 cmx 40 cmx 15 cm
61300K84920ZD	CRF150L K84 (2017 - Sekarang)	3 kg	Putih	\N
83141K45N40ZD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.2 kg	Hitam	\N
8013AK45N40	CBR 150R K45G (2016 - 2018)	3 kg	Hitam	\N
80110K56NJ0	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	1 kg	Hitam	\N
61100K1AN00FMB	BeAT dan BeAT Street K1A (2020 - 2024)	6 kg	Hitam	\N
64405K0WN00ZB	ADV 150 (2019 - 2022)	0.2 kg	Hitam	\N
61304K15900	CB150R StreetFire K15 (2012 - 2015)	0.4 kg	Hitam	\N
64431K97T00YA	PCX 150 K97 (2017 - 2021)	10 kg	Putih	\N
18318K0WNA0	ADV 160 (2022 - Sekarang)	0.4 kg	Hitam	40 cmx 20 cmx 10 cm
17575K59A70	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	2.5 kg	Hitam	\N
50285K15600	CB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
64502K96V00ZU	PCX 150 K97 (2017 - 2021)	15 kg	Putih	\N
83550K84900ZA	CRF150L K84 (2017 - Sekarang)	5 kg	Putih	\N
64450K15600	CB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
83620KZR600ZB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	5 kg	Hitam	\N
50260K15920WRD	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	3 kg	Merah	\N
80115K0JN00ZB	Genio (2019 - 2022)	0.15 kg	Hitam	11 cmx 10 cmx 5 cm
80106K0WN00	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	1 kg	Hitam	\N
81132K97N00	PCX 150 K97 (2017 - 2021)	2.5 kg	Hitam	\N
8011AK45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	\N
17234K1ZJ10	ADV 160 (2022 - Sekarang)\nPCX 160 K1Z (2021 - Sekarang)\nStylo 160 (2024 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	18 cmx 10 cmx 4 cm
50270K15920ZB	CB150R StreetFire K15G (2015 - 2018)	0.2 kg	Hitam	\N
83640K18960ZA	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	4 kg	Hitam	\N
64510K46N00	Vario 110 FI (2014 - 2015)	6 kg	Hitam	\N
64370K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2 kg	Hitam	\N
64310K93N00ZC	Scoopy eSP K93 (2017 - 2020)	11 kg	Hitam	\N
64301K59A10ZF	Vario 150 eSP K59 (2015 - 2018)	3 kg	Hitam	\N
64340K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	4.5 kg	Hitam	50 cmx 36 cmx 14 cm
64223K2FN00	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
67100K97N00ZA	PCX 150 K97 (2017 - 2021)	8 kg	Hitam	\N
64302K59A70ZA	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	4 kg	Hitam	\N
83700K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.3 kg	Hitam	\N
64360K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	3 kg	Hitam	74 cmx 25 cmx 10 cm
80104K81N00	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.2 kg	Hitam	\N
61100K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Merah	\N
50260K15920FMB	CB150R StreetFire K15G (2015 - 2018)	3 kg	Hitam	\N
64301K81N00WRD	BeAT Sporty eSP K81 (2016 - 2020)	11 kg	Merah	\N
53204K81N00FMB	BeAT Sporty eSP K81 (2016 - 2020)	1.5 kg	Hitam	\N
16305K84900	CRF150L K84 (2017 - Sekarang)	0.5 kg	Hitam	\N
64301K1AN00MCS	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Silver	\N
64530K0WN00	ADV 150 (2019 - 2022)	6 kg	Hitam	\N
64231K45NL0	CBR 150R K45R (2021 - Sekarang)	2 kg	Hitam	\N
5320CK46N30	Vario 110 eSP (2015 - 2019)	2 kg	Hitam	\N
53205K25900FMB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	3 kg	Hitam	\N
19742KZL930	Spacy Karburator (2011 - 2013)	2 kg	Hitam	\N
17560K84900	CRF150L K84 (2017 - Sekarang)	8 kg	Hitam	\N
61100K93N00ZN	Scoopy eSP K93 (2017 - 2020)	5 kg	Hitam	\N
83520K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	5 kg	Hitam	\N
61100K15920ZA	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	5 kg	Merah	\N
8125CK59A10	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.3 kg	Hitam	\N
81131K59A70YA	Vario 125 eSP K60R (2018 - 2022)	3 kg	Hitam	\N
53206K0WN00	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	0.4 kg	Hitam	\N
61300K56N00ZA	Sonic 150R K56 (2015 - Sekarang)	2 kg	Hitam	\N
64431K0WN00ZA	ADV 150 (2019 - 2022)	4 kg	Hitam	\N
64310K0JN00ZA	Genio (2019 - 2022)	8 kg	Coklat	\N
8114AK81N00	BeAT Sporty eSP K81 (2016 - 2020)	9.2 kg	Hitam	\N
64241K45NA0	CBR 150R K45N (2018 - 2020)	1.5 kg	Hitam	\N
64301K25900CSR	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	11 kg	Merah	\N
64432K97T00YA	PCX 150 K97 (2017 - 2021)	7 kg	Putih	\N
64301K59A10ZH	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Hitam	\N
64201K2FN00ZQ	Scoopy K2F (2020 - Sekarang)	2 kg	Putih	60 cmx 20 cmx 10 cm
64502K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	18 kg	Biru	90 cmx 62 cmx 20 cm
64432K0WN00ZA	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
64202K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	3 kg	Putih	\N
64330K25900ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	3 kg	Hitam	\N
8351AK64N00	CBR 250RR K64 (2016 - 2020)	3 kg	Hitam	\N
64110K64N00	CBR 250RR K64 (2016 - 2020)	3 kg	Putih	\N
80106K59A70	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.2 kg	Hitam	\N
61100K59A70ZF	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Hitam	\N
80105K2FN00	Scoopy K2F (2020 - Sekarang)	8.5 kg	Hitam	80 cmx 42 cmx 15 cm
83700K61900ZA	BeAT POP eSP K61 (2014 - 2019)	0.2 kg	Hitam	25 cmx 20 cmx 10 cm
64224K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Hitam	\N
83640K15920	CB150R StreetFire K15G (2015 - 2018)	3 kg	Hitam	\N
81132K2VN30	Vario 125 eSP K2V (2022 - Sekarang)	1.2 kg	Hitam	20 cmx 21 cmx 16 cm
64337K0WN00ZB	ADV 150 (2019 - 2022)	2 kg	Hitam	\N
53205K25900PFW	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	3 kg	Putih	\N
6431AK25600	BeAT Sporty eSP K25G (2014 - 2016)	7 kg	Hitam	\N
61100K25900ZC	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Putih	\N
64301K93N00ZP	Scoopy eSP K93 (2017 - 2020)	5 kg	Hitam	\N
50275K15920ZB	CB150R StreetFire K15G (2015 - 2018)	0.2 kg	Hitam	\N
64301K81N00VBM	BeAT Sporty eSP K81 (2016 - 2020)	11 kg	Biru	\N
17218K84900	CRF150L K84 (2017 - Sekarang)	0.1 kg	Hitam	\N
64201K93N00ZP	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
8010BK61900	BeAT POP eSP K61 (2014 - 2019)	6 kg	Hitam	\N
64202K93N00ZG	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
8352AK64N00	CBR 250RR K64 (2016 - 2020)	3 kg	Hitam	\N
81131K93N00	Scoopy eSP K93 (2017 - 2020)	1.6 kg	Hitam	\N
18356K56N00	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Hitam	\N
61100K15920ZB	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	5 kg	Hitam	\N
50270K15920ZC	CB150R StreetFire K15G (2015 - 2018)	0.2 kg	Putih	\N
50275K15920ZD	CB150R StreetFire K15G (2015 - 2018)	0.2 kg	Hitam	\N
83450K15920ZB	CB150R StreetFire K15G (2015 - 2018)	0.4 kg	Hitam	\N
83141K45N40ZB	CBR 150R K45G (2016 - 2018)	1 kg	Putih	37 cmx 21 cmx 7 cm
8321AK45N40	CBR 150R K45G (2016 - 2018)	0.3 kg	Hitam	\N
64301K59A10ZG	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Putih	\N
64320K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	0.1 kg	Hitam	20 cmx 6 cmx 4 cm
64310K0JN00ZC	Genio (2019 - 2022)	5.5 kg	Hitam	40 cmx 40 cmx 20 cm
83520K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
64301K1AN00FMB	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Hitam	47 cmx 39 cmx 40 cm
81250K97T00	PCX 150 K97 (2017 - 2021)	18 kg	Hitam	\N
80103K84900	CRF150L K84 (2017 - Sekarang)	5 kg	Hitam	\N
80107KVY900	BeAT Karburator KVY (2008 - 2012)	0.3 kg	Hitam	\N
83680K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	1 kg	Hitam	\N
64460K93N00ZC	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Hitam	\N
17245K0JN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nGenio (2019 - 2022)\nScoopy K2F (2020 - Sekarang)	3 kg	Hitam	\N
81131K0WN00ZB	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	5 kg	Hitam	\N
40510K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)	7 kg	Hitam	\N
83620K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	5 kg	Hitam	\N
40510K45N40	CB150X (2021 - Sekarang)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	3 kg	Hitam	\N
80101K1ZN20	PCX 160 K1Z (2021 - Sekarang)	4 kg	Hitam	50 cmx 26 cmx 15 cm
64432K1ZJ10ZJ	PCX 160 K1Z (2021 - Sekarang)	10 kg	Biru	92 cmx 35 cmx 20 cm
64410K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	0.8 kg	Hitam	31 cmx 20 cmx 6 cm
61100K84900ZD	CRF150L K84 (2017 - Sekarang)	5 kg	Hitam	\N
53205K25600CSR	BeAT Sporty eSP K25G (2014 - 2016)	4 kg	Merah	\N
64502K96V00ZV	PCX 150 K97 (2017 - 2021)	15 kg	Hitam	\N
64301K59A70ZC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Hitam	\N
81322K97T00	ADV 150 (2019 - 2022)\nPCX 150 K97 (2017 - 2021)	0.5 kg	Hitam	\N
80111K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	\N
83670K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	1 kg	Hitam	\N
40510K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	2 kg	Hitam	\N
64202K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	1.5 kg	Hitam	50 cmx 15 cmx 7 cm
61302K18960	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.4 kg	Hitam	\N
64201K93N00ZG	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
50410K93N00ZD	Scoopy eSP K93 (2017 - 2020)	2 kg	Silver	\N
61100K56N10ZC	Supra GTR K56F (2016 - 2019)	5 kg	Biru	\N
50270K15920ZD	CB150R StreetFire K15G (2015 - 2018)	0.2 kg	Hitam	\N
83540K15920	CB150R StreetFire K15G (2015 - 2018)	3 kg	Hitam	\N
53208K59A10PFW	Vario 150 eSP K59 (2015 - 2018)	2 kg	Putih	\N
64521K0WNA0	ADV 160 (2022 - Sekarang)	10 kg	Hitam	55 cmx 50 cmx 22 cm
64201K2FN00ZK	Scoopy K2F (2020 - Sekarang)	1.5 kg	Coklat	59 cmx 19 cmx 7 cm
53204K1AN00FMB	BeAT dan BeAT Street K1A (2020 - 2024)	3 kg	Hitam	\N
19640K0WN00	ADV 150 (2019 - 2022)	2 kg	Hitam	\N
64202K93N00ZP	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
64431K97T00ZS	PCX 150 K97 (2017 - 2021)	7 kg	Hitam	\N
83610K64N00ZB	CBR 250RR K64 (2016 - 2020)	0.5 kg	Hitam	\N
53205K93N00ZL	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Hitam	\N
64460K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.15 kg	Hitam	18 cmx 17 cmx 3 cm
83121K45N40ZB	CBR 150R K45G (2016 - 2018)	8 kg	Putih	\N
64302K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	0.7 kg	Hitam	27 cmx 27 cmx 6 cm
64501K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	18 kg	Hitam	90 cmx 62 cmx 20 cm
19640K1ZJ10	ADV 160 (2022 - Sekarang)\nPCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.8 kg	Hitam	42 cmx 15 cmx 5 cm
64432K0WN00ZB	ADV 150 (2019 - 2022)	4 kg	Silver	\N
51620K84900ZC	CRF150L K84 (2017 - Sekarang)	2 kg	Hitam	\N
83540K18960ZA	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	5 kg	Hitam	\N
53205K25600FMB	BeAT Sporty eSP K25G (2014 - 2016)	3 kg	Hitam	\N
8113BK61900	BeAT POP eSP K61 (2014 - 2019)	9 kg	Hitam	\N
53206K81N30MAG	BeAT Sporty eSP K81 (2016 - 2020)	0.5 kg	Hitam	\N
64210K64N00ZC	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Hitam	\N
53216K56N40ZA	Supra GTR K56F (2016 - 2019)	5 kg	Merah	\N
5060AK56N10	Supra GTR K56F (2016 - 2019)	5 kg	Hitam	\N
83141K45N40ZC	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	1 kg	Putih	37 cmx 21 cmx 7 cm
19640K2SN00	Stylo 160 (2024 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.4 kg	Hitam	17 cmx 18 cmx 7 cm
64201K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	1.5 kg	Hitam	50 cmx 15 cmx 7 cm
61200K2SN00	Vario 160 K2S (2022 - Sekarang)	3 kg	Hitam	43 cmx 28 cmx 14 cm
83700K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	0.6 kg	Hitam	\N
80100K59A10	Vario 125 eSP K60 (2015 - 2018)	16 kg	Hitam	37 cmx 74 cmx 35 cm
64601K59A70ZR	Vario 125 eSP K60R (2018 - 2022)	6 kg	Hitam	\N
83640K15600ZA	CB150R StreetFire K15M (2018 - 2021)	4 kg	Hitam	\N
6431AK46N20ZA	Vario 110 eSP (2015 - 2019)	8 kg	Hitam	\N
50275K15600ZA	CB150R StreetFire K15M (2018 - 2021)	1 kg	Merah	\N
64501K59A70ZR	Vario 125 eSP K60R (2018 - 2022)	6 kg	Hitam	\N
83650K61900ZA	BeAT POP eSP K61 (2014 - 2019)	1 kg	Hitam	\N
1964AK25600	BeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nVario 110 eSP (2015 - 2019)	1 kg	Hitam	\N
5061AK25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	3 kg	Hitam	\N
61100K59A10RSW	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Putih	\N
64421K93N00ZK	Scoopy eSP K93 (2017 - 2020)	2 kg	Hitam	\N
53206K93N00ZL	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Hitam	\N
64420K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	0.1 kg	Hitam	20 cmx 6 cmx 4 cm
81141K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	9 kg	Hitam	60 cmx 45 cmx 20 cm
64432K1ZJ10ZT	PCX 160 K1Z (2021 - Sekarang)	10 kg	Hitam	90 cmx 40 cmx 18 cm
61102K18900	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.5 kg	Silver	\N
80100K56NJ0	Supra GTR K56W (2019 - Sekarang)	3 kg	Hitam	\N
81138K0WN00ZB	ADV 150 (2019 - 2022)	6 kg	Hitam	\N
81141K46N30	Vario 110 eSP (2015 - 2019)	6 kg	Hitam	\N
64502K96V00ZT	PCX 150 K97 (2017 - 2021)	14 kg	Merah	\N
77230K18960ZA	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.8 kg	Hitam	\N
80105K97T00	ADV 150 (2019 - 2022)\nPCX 150 K97 (2017 - 2021)	3 kg	Hitam	\N
64421K93N00ZN	Scoopy eSP K93 (2017 - 2020)	3 kg	Coklat	\N
53250K97T00	PCX 150 K97 (2017 - 2021)	0.7 kg	Silver	\N
53210K56N10ZA	Supra GTR K56F (2016 - 2019)	4 kg	Hitam	\N
50265K15920FMB	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	2.3 kg	Hitam	\N
81200K81N00	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	2 kg	Hitam	\N
83121K45N40WRD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Merah	\N
64302K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	1.8 kg	Hitam	35 cmx 27 cmx 12 cm
64501K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	18 kg	Biru	90 cmx 62 cmx 20 cm
53205K1AN00ZE	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
81131K46N00ZA	Vario 110 FI (2014 - 2015)	4 kg	Hitam	\N
5320CK46N00	Vario 110 FI (2014 - 2015)	2 kg	Hitam	\N
53205K81N00ZB	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	3 kg	Hitam	\N
64301K93N00ZM	Scoopy eSP K93 (2017 - 2020)	5 kg	Merah	\N
64301K93N00ZR	Scoopy eSP K93 (2017 - 2020)	5 kg	Putih	\N
64431K93N00ZN	Scoopy eSP K93 (2017 - 2020)	3 kg	Coklat	\N
50186K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)\nSonic 150R K56 (2015 - Sekarang)	0.8 kg	Hitam	\N
64301K93N00ZK	Scoopy eSP K93 (2017 - 2020)	5 kg	Cream	\N
61302K56N00ZB	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Merah	\N
64301K81N00SMM	BeAT Sporty eSP K81 (2016 - 2020)	11 kg	Magenta / Ungu / Pink	\N
64304K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	0.5 kg	Hitam	26 cmx 18 cmx 4 cm
64301K2FN00ZQ	Scoopy K2F (2020 - Sekarang)	8 kg	Putih	60 cmx 40 cmx 20 cm
50312K97N00	PCX 150 K97 (2017 - 2021)	3 kg	Hitam	\N
81142K1AN10ZA	BeAT dan BeAT Street K1A (2020 - 2024)	3 kg	Hitam	\N
50311K0WN00	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
6431AK25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	8 kg	Hitam	\N
64501K97T00YC	PCX 150 K97 (2017 - 2021)	15 kg	Merah	\N
53205K81N30ZA	BeAT Sporty eSP K81 (2016 - 2020)	0.2 kg	Hitam	\N
61100K64N00ZB	CB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)\nCBR 150R K45R (2021 - Sekarang)\nCBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	8 kg	Hitam	\N
64211K45N40WRD	CBR 150R K45G (2016 - 2018)	3 kg	Merah	\N
8322AK45N40	CBR 150R K45G (2016 - 2018)	0.3 kg	Hitam	\N
64502K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	18 kg	Putih	90 cmx 62 cmx 20 cm
64202K2FN00ZK	Scoopy K2F (2020 - Sekarang)	2 kg	Hitam	60 cmx 20 cmx 10 cm
64510K56N10	Sonic 150R K56 (2015 - Sekarang)\nSupra GTR K56F (2016 - 2019)	5 kg	\N	\N
51610K84900ZC	CRF150L K84 (2017 - Sekarang)	2 kg	Hitam	\N
83650K46N00ZA	Vario 110 FI (2014 - 2015)	3 kg	Hitam	\N
81137K97T00ZT	PCX 150 K97 (2017 - 2021)	0.1 kg	Merah	\N
61303K56N00ZD	Sonic 150R K56 (2015 - Sekarang)	0.2 kg	Putih	\N
61100K59A10WRD	Vario 125 eSP K60 (2015 - 2018)	5 kg	Merah	\N
53208K59A10MIB	Vario 150 eSP K59 (2015 - 2018)	2 kg	Biru	\N
81131K2VN30ZM	Vario 125 eSP K2V (2022 - Sekarang)	3 kg	Hitam	40 cmx 30 cmx 14 cm
64223K2FN80	Scoopy K2F (2020 - Sekarang)	0.25 kg	Hitam	28 cmx 12 cmx 8 cm
53280K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Hitam	32 cmx 25 cmx 15 cm
64502K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	18 kg	Hitam	90 cmx 62 cmx 20 cm
64301K2FN00ZK	Scoopy K2F (2020 - Sekarang)	5 kg	Coklat	50 cmx 30 cmx 20 cm
64601K2SN00ZD	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Hitam	40 cmx 27 cmx 6 cm
5061AK46N20ZA	Vario 110 eSP (2015 - 2019)	3 kg	Hitam	\N
11360K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	0.6 kg	Hitam	\N
17546K84920ZA	CRF150L K84 (2017 - Sekarang)	3 kg	Hitam	\N
64460K59A70ZB	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.5 kg	Hitam	\N
81133K97T00	PCX 150 K97 (2017 - 2021)	3 kg	Putih	\N
6430BK61900	BeAT POP eSP K61 (2014 - 2019)	4 kg	Hitam	\N
83610K84901ZB	CRF150L K84 (2017 - Sekarang)	6 kg	Hitam, Merah, Putih	\N
6131BK15900	CB150R StreetFire K15 (2012 - 2015)	3 kg	Hitam	\N
6431AK46N00ZA	Vario 110 FI (2014 - 2015)	11 kg	Hitam	\N
1974AK25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	2 kg	Hitam	\N
6130AK18900	Verza 150 (2013 - 2018)	3 kg	Hitam	\N
61304K56N00ZF	Sonic 150R K56 (2015 - Sekarang)	0.6 kg	Hitam	\N
83630K64N00ZB	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Hitam	\N
83610K15920MGB	CB150R StreetFire K15G (2015 - 2018)	3 kg	Hitam	\N
83111K45N40WRD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Merah	\N
64501K59A10MJB	Vario 150 eSP K59 (2015 - 2018)	4 kg	Coklat	\N
81141K2VN40ZB	Vario 125 eSP K2V (2022 - Sekarang)	11 kg	Hitam	55 cmx 42 cmx 30 cm
81142K2SN00ZD	Vario 160 K2S (2022 - Sekarang)	5.5 kg	Hitam	50 cmx 38 cmx 17 cm
64431K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	8 kg	Merah	92 cmx 40 cmx 12 cm
50311K97N00	PCX 150 K97 (2017 - 2021)	4 kg	Hitam	\N
64202K0JN00ZC	Genio (2019 - 2022)	3 kg	Hitam	\N
80110K18960	CB150 Verza (2018 - Sekarang)	6 kg	Hitam	\N
61100K25900ZJ	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Biru	\N
83221K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.3 kg	Hitam	\N
61100K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	5 kg	Putih	\N
64305K97T00YA	PCX 150 K97 (2017 - 2021)	7 kg	Putih	\N
81134K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Putih	\N
50400K56N10ZA	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	2 kg	Hitam	\N
83131K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.4 kg	Merah	\N
53208K59A10AFB	Vario 150 eSP K59 (2015 - 2018)	2 kg	Hitam	\N
64223K0JN00	Genio (2019 - 2022)	0.65 kg	Hitam	25 cmx 15 cmx 10 cm
64301K1AN00VRD	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Merah	47 cmx 39 cmx 40 cm
81141K0WN00ZB	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	3 kg	Hitam	\N
80104K0JN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nGenio (2019 - 2022)\nScoopy K2F (2020 - Sekarang)	0.2 kg	Hitam	\N
81141K0JN00ZA	Genio (2019 - 2022)	5 kg	Coklat	\N
83540K15600ZA	CB150R StreetFire K15M (2018 - 2021)	6 kg	Hitam	\N
83211K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	3 kg	Hitam	\N
80131K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	5 kg	Hitam	\N
61100K84900ZB	CRF150L K84 (2017 - Sekarang)	8 kg	Merah	\N
64320K15930ZA	CB150R StreetFire K15G (2015 - 2018)	2 kg	Grey	\N
64411K45N40WRD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Merah	60 cmx 57 cmx 15 cm
83750K59A10ZK	Vario 150 eSP K59 (2015 - 2018)	0.4 kg	Putih	\N
64503K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Putih	20 cmx 8 cmx 3 cm
64502K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	18 kg	\N	90 cmx 62 cmx 20 cm
50312K1ZJ10	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	2 kg	Hitam	32 cmx 20 cmx 16 cm
53208K46N00ZC	Vario 110 eSP (2015 - 2019)	1 kg	Merah	\N
64432K97T00ZY	PCX 150 K97 (2017 - 2021)	10 kg	Merah	\N
50621K25600ZA	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Karburator KVY (2008 - 2012)\nBeAT POP eSP K61 (2014 - 2019)	3 kg	Hitam	\N
80110KVB930	Vario 110 CW (2006 - 2014)	6 kg	Hitam	\N
80101K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)	9 kg	Hitam	\N
83500K93N00ZK	Scoopy eSP K93 (2017 - 2020)	8 kg	Coklat	\N
50275K15920ZC	CB150R StreetFire K15G (2015 - 2018)	0.2 kg	Putih	\N
64311K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	60 cmx 57 cmx 15 cm
64311K45N40WRD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Merah	60 cmx 57 cmx 15 cm
64303K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	4.18 kg	Hitam	38 cmx 30 cmx 22 cm
64601K2SN00ZM	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Hitam	40 cmx 27 cmx 6 cm
64521K1ZJ10	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	10 kg	Hitam	62 cmx 43 cmx 22 cm
83650K84900ZC	CRF150L K84 (2017 - Sekarang)	5 kg	Hitam	\N
64501K59A70YD	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	6 kg	Hitam	\N
81139K0WN00ZA	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
64434K0WN00ZB	ADV 150 (2019 - 2022)	1 kg	Hitam	\N
81255K59A70	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	1 kg	Hitam	\N
83500K59A70ZC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	6 kg	Hitam	\N
83141K45N40ZE	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.5 kg	Hitam	\N
64301K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	5 kg	Merah	\N
81250K25600	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Hitam	\N
64501K97T00YB	PCX 150 K97 (2017 - 2021)	15 kg	Gold	\N
40510K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	8 kg	Hitam	\N
64201K93N00ZH	Scoopy eSP K93 (2017 - 2020)	3 kg	Putih	\N
81134K93N00ZL	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Hitam	\N
50260K15920RSW	CB150R StreetFire K15G (2015 - 2018)	3 kg	Putih	\N
83710K15920MGB	CB150R StreetFire K15G (2015 - 2018)	3 kg	Hitam	\N
61303K15920ZA	CB150R StreetFire K15G (2015 - 2018)	0.3 kg	Merah	\N
64211K45N40ZC	CBR 150R K45G (2016 - 2018)	3 kg	Putih	\N
84100K59A10ZE	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Hitam	\N
50706K56N10	Supra GTR K56F (2016 - 2019)	3.4 kg	Hitam	71 cmx 36 cmx 8 cm
81136K2SN00	Vario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	20 cmx 15 cmx 10 cm
64501K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	18 kg	Hitam	90 cmx 62 cmx 20 cm
64421K0JN00ZC	Genio (2019 - 2022)	3 kg	Hitam	\N
64431K93N00ZP	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
53206K41N00ZA	Supra X 125 FI New (2014 - Sekarang)	5 kg	Hitam, Silver	\N
8125AK25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	5 kg	Hitam	\N
64432K97T00ZS	PCX 150 K97 (2017 - 2021)	7 kg	Hitam	\N
64503K97T00ZX	PCX 150 K97 (2017 - 2021)	0.3 kg	Merah	\N
64310K25600ZA	BeAT Karburator KVY (2008 - 2012)\nBeAT Sporty eSP K25G (2014 - 2016)	11 kg	Hitam	\N
83620K64N00ZB	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Hitam	\N
50265K15920WRD	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	2 kg	Merah	\N
6431AK81N00	BeAT Sporty eSP K81 (2016 - 2020)	7 kg	Hitam	\N
64301K81N00RSW	BeAT Sporty eSP K81 (2016 - 2020)	11 kg	Putih	\N
64321K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Hitam	\N
83750K59A10ZM	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.4 kg	Hitam	\N
53208K59A10MGB	Vario 150 eSP K59 (2015 - 2018)	2 kg	Hitam	\N
64301K1AN00MBS	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Silver	47 cmx 39 cmx 40 cm
80104KVY870	BeAT Karburator KVY (2008 - 2012)	0.05 kg	Hitam	10 cmx 5 cmx 2 cm
64432K2SN00ZL	Vario 160 K2S (2022 - Sekarang)	0.6 kg	Putih	38 cmx 22 cmx 5 cm
64501K2SN00ZK	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Merah	40 cmx 27 cmx 6 cm
64305K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	2 kg	Putih	41 cmx 48 cmx 7 cm
64326K1ZJ10	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.5 kg	Hitam	68 cmx 10 cmx 5 cm
64325K1ZJ10	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.5 kg	Hitam	68 cmx 10 cmx 5 cm
50311K1ZJ10	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	1.6 kg	Hitam	33 cmx 20 cmx 15 cm
81131K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	8 kg	\N	60 cmx 30 cmx 20 cm
64421K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	2 kg	Hitam	\N
61100K59A70ZY	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Hitam	\N
11350K0WN00	ADV 150 (2019 - 2022)	0.7 kg	Hitam	\N
83620K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
81140K0WN00ZA	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
61100K81N00ZE	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	6 kg	Hitam	\N
67111K45NA0	CBR 150R K45N (2018 - 2020)	3.5 kg	Putih	\N
32112K97T00	ADV 150 (2019 - 2022)\nPCX 150 K97 (2017 - 2021)	0.4 kg	Hitam	\N
80110K84920ZC	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	\N
17556K84920ZA	CRF150L K84 (2017 - Sekarang)	3 kg	Hitam	\N
83610K15600MGB	CB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
53205K81N00ZE	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	3 kg	Putih	\N
50275K15600ZC	CB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
64305K97T00ZX	PCX 150 K97 (2017 - 2021)	7 kg	Merah	\N
80104K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2 kg	Hitam	\N
64211K45N40ZB	CBR 150R K45G (2016 - 2018)	3 kg	Merah	\N
83600K93N00ZK	Scoopy eSP K93 (2017 - 2020)	8 kg	Coklat	\N
64421K93N00ZG	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
83610K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.3 kg	Merah	\N
83620K56N00FMB	Sonic 150R K56 (2015 - Sekarang)	5 kg	Hitam	\N
61302K15920ZB	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
64411K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	60 cmx 57 cmx 15 cm
64211K45N40NOR	CBR 150R K45G (2016 - 2018)	3 kg	Oranye	\N
53208K59A10CSR	Vario 150 eSP K59 (2015 - 2018)	2 kg	Merah	\N
83155K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.6 kg	Hitam	35 cmx 20 cmx 5 cm
64431K2SN00ZD	Vario 160 K2S (2022 - Sekarang)	0.6 kg	Hitam	38 cmx 22 cmx 5 cm
53280K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	2 kg	Hitam	32 cmx 25 cmx 15 cm
53206K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
11340K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.8 kg	Hitam	\N
50400KVY900	BeAT Karburator KVY (2008 - 2012)	5 kg	Hitam	\N
53205K59A70ZB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	\N
64421K93N00ZP	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
53205K41N00ZA	Supra X 125 FI New (2014 - Sekarang)	5 kg	Hitam	\N
64431K97T00ZY	PCX 150 K97 (2017 - 2021)	10 kg	Merah	\N
83450K15920ZA	CB150R StreetFire K15G (2015 - 2018)	0.4 kg	Merah	\N
83600K93N00ZN	Scoopy eSP K93 (2017 - 2020)	8 kg	Hitam	\N
50265K15920RSW	CB150R StreetFire K15G (2015 - 2018)	2.3 kg	Putih	\N
61302K15920ZA	CB150R StreetFire K15G (2015 - 2018)	0.3 kg	Merah	\N
64341K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	3 kg	Putih	\N
64601K59A10WRD	Vario 125 eSP K60 (2015 - 2018)	4 kg	Merah	\N
64601K59A10MIB	Vario 150 eSP K59 (2015 - 2018)	4 kg	Biru	\N
53207K07900ZB	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nSupra X 125 FI New (2014 - Sekarang)	0.4 kg	Hitam	25 cmx 24 cmx 4 cm
64501K2VN30MPC	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Putih	36 cmx 36 cmx 10 cm
64310K2FN80ZA	Scoopy K2F (2020 - Sekarang)	5.1 kg	Coklat	55 cmx 40 cmx 14 cm
64501K0WNA0ZB	ADV 160 (2022 - Sekarang)	12 kg	Hitam	65 cmx 50 cmx 20 cm
61100K1ZN20PFW	PCX 160 K1Z (2021 - Sekarang)	5.2 kg	Putih	50 cmx 25 cmx 25 cm
64301K2FN00ZR	Scoopy K2F (2020 - Sekarang)	5 kg	Hitam	50 cmx 30 cmx 20 cm
64431K1ZJ10ZT	PCX 160 K1Z (2021 - Sekarang)	10 kg	Hitam	90 cmx 40 cmx 18 cm
64601K2SN00ZK	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Merah	40 cmx 27 cmx 6 cm
64202K2FN00ZP	Scoopy K2F (2020 - Sekarang)	3 kg	Biru	60 cmx 16 cmx 5 cm
64312K2FN00	Scoopy K2F (2020 - Sekarang)	0.5 kg	Hitam	20 cmx 15 cmx 3 cm
80151K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	0.5 kg	Silver	\N
53250K1AN20ZB	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
64520K56N10	Sonic 150R K56 (2015 - Sekarang)\nSupra GTR K56F (2016 - 2019)	5 kg	Hitam	\N
83600K1AN00MGB	BeAT dan BeAT Street K1A (2020 - 2024)	8 kg	Hitam	\N
19631K0JN00	Genio (2019 - 2022)	3 kg	Hitam	\N
64560K0WN00ZA	ADV 150 (2019 - 2022)	3 kg	Silver	\N
80111K45NA0	CBR 150R K45N (2018 - 2020)	6 kg	Hitam	\N
84100K97T00	PCX 150 K97 (2017 - 2021)	4 kg	Hitam	\N
61300K18960ZA	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	2 kg	Hitam	\N
8114AK46N00ZA	Vario 110 FI (2014 - 2015)	8 kg	Hitam	\N
64503K97T00ZN	PCX 150 K97 (2017 - 2021)	0.2 kg	Hitam	\N
84151K97T00ZN	PCX 150 K97 (2017 - 2021)	7 kg	Hitam	\N
80160K61900	BeAT POP eSP K61 (2014 - 2019)	1 kg	Hitam	\N
51610K84900ZB	CRF150L K84 (2017 - Sekarang)	3 kg	Merah	\N
61304K56N00ZC	Sonic 150R K56 (2015 - Sekarang)	0.6 kg	Silver	\N
53206K93N00ZG	Scoopy eSP K93 (2017 - 2020)	0.6 kg	Coklat	\N
64430K64N00MGB	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	12 kg	Hitam	\N
64330K64N00MGB	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	12 kg	Hitam	\N
61302K56N00ZF	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Hitam	\N
83620K56N00RSW	Sonic 150R K56 (2015 - Sekarang)	5 kg	Putih	\N
64620K56N10MGB	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	8 kg	Hitam	\N
83450K15920ZC	CB150R StreetFire K15G (2015 - 2018)	0.4 kg	Putih	\N
61302K15920ZD	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
61302K15920ZC	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	0.3 kg	Putih	\N
83121K45N40ROW	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Putih	\N
53208K59A10FMB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	2 kg	Hitam	\N
64601K59A10MJB	Vario 150 eSP K59 (2015 - 2018)	4 kg	Coklat	\N
64601K2VN30MPC	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Putih	36 cmx 36 cmx 10 cm
64501K2VN30FMB	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Hitam	36 cmx 36 cmx 10 cm
64301K2VN30ZN	Vario 125 eSP K2V (2022 - Sekarang)	5.75 kg	Putih	50 cmx 46 cmx 15 cm
81141K2FN00ZG	Scoopy K2F (2020 - Sekarang)	10 kg	Hitam	60 cmx 40 cmx 20 cm
61303K56N00ZE	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Hitam	\N
64301K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	5 kg	Hitam	42 cmx 45 cmx 15 cm
64301K2SN00ZM	Vario 160 K2S (2022 - Sekarang)	8 kg	Hitam	55 cmx 50 cmx 15 cm
61100K2SN00PBL	Vario 160 K2S (2022 - Sekarang)	3 kg	Hitam	37 cmx 20 cmx 22 cm
64431K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	10 kg	Hitam	90 cmx 40 cmx 18 cm
64201K2FN00ZN	Scoopy K2F (2020 - Sekarang)	2 kg	Merah	60 cmx 20 cmx 10 cm
80103K1ZJ10	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.4 kg	Hitam	29 cmx 20 cmx 5 cm
81134K2FN00ZK	Scoopy K2F (2020 - Sekarang)	0.1 kg	Coklat	19 cmx 18 cmx 2 cm
81141KVY960	BeAT Karburator KVY (2008 - 2012)	8 kg	Grey, Hitam	\N
64460K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	2 kg	Hitam	\N
19621K0JN00	Genio (2019 - 2022)	3 kg	Hitam	\N
80102KVY960	BeAT Karburator KVY (2008 - 2012)	0.4 kg	Hitam	\N
8010BK46N00ZA	Vario 110 FI (2014 - 2015)	6 kg	Hitam	\N
53207K93N00MSR	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Merah	\N
64421K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	3 kg	Putih	\N
53207K93N00PFW	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Putih	\N
61100K97T00YD	PCX 150 K97 (2017 - 2021)	8 kg	Putih	\N
6431AK61900	BeAT POP eSP K61 (2014 - 2019)	7 kg	Hitam	\N
8010CK15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	7 kg	Hitam	\N
6434AKZR600ZB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	5 kg	Hitam	\N
31501KC5000	\N	1 kg	Hitam	\N
53207K93N00RSW	Scoopy eSP K93 (2017 - 2020)	0.4 kg	Putih	\N
64431K93N00ZK	Scoopy eSP K93 (2017 - 2020)	2 kg	Hitam	\N
83610K15920WRD	CB150R StreetFire K15G (2015 - 2018)	3 kg	Merah	\N
53205K81N00WRD	BeAT Sporty eSP K81 (2016 - 2020)	3 kg	Merah	\N
53205K81N00FMB	BeAT Sporty eSP K81 (2016 - 2020)	2 kg	Hitam	\N
64342K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	3 kg	Hitam	\N
64311K45N40ROW	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Oranye	60 cmx 57 cmx 15 cm
64601K59A10CSR	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	4 kg	Merah	\N
61100K59A10MIB	Vario 150 eSP K59 (2015 - 2018)	5 kg	Biru	\N
81131K59A10ZL	Vario 150 eSP K59 (2015 - 2018)	1.6 kg	Biru	\N
64321K0WNA0ZB	ADV 160 (2022 - Sekarang)	9.5 kg	Hitam	78 cmx 36 cmx 20 cm
81141K2FN00ZF	Scoopy K2F (2020 - Sekarang)	10 kg	Cream	26 cmx 38 cmx 66 cm
64202K2FN00ZN	Scoopy K2F (2020 - Sekarang)	2 kg	Merah	60 cmx 20 cmx 10 cm
64431K1ZJ10ZU	PCX 160 K1Z (2021 - Sekarang)	10 kg	Putih	90 cmx 40 cmx 18 cm
50732K1ZJ10ZB	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.05 kg	Hitam	18 cmx 6 cmx 2 cm
64501K2SN00ZM	Vario 160 K2S (2022 - Sekarang)	2 kg	Hitam	40 cmx 28 cmx 7 cm
19200K1NV00	ADV 160 (2022 - Sekarang)\nPCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	1 kg	Silver	25 cmx 17 cmx 7 cm
64432K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	8 kg	Merah	92 cmx 40 cmx 12 cm
64431K2FN00ZL	Scoopy K2F (2020 - Sekarang)	3 kg	Merah	60 cmx 16 cmx 5 cm
64201K2FN00ZR	Scoopy K2F (2020 - Sekarang)	1.5 kg	Hitam	60 cmx 20 cmx 8 cm
64601K59A70YD	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	4 kg	Hitam	\N
64325K0WN00	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
64202K0JN00ZB	Genio (2019 - 2022)	3 kg	Merah	\N
83700K0WN00ZB	ADV 150 (2019 - 2022)	4 kg	Hitam	\N
64301K59A70ZR	Vario 125 eSP K60R (2018 - 2022)	6 kg	Hitam	\N
64301K25900VBM	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	11 kg	Biru	\N
81131K59A70ZC	Vario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	\N
64311K0WNA0ZB	ADV 160 (2022 - Sekarang)	9.5 kg	Hitam	78 cmx 36 cmx 20 cm
64308KVB901	Vario 110 CW (2006 - 2014)	12 kg	Hitam	\N
51620K84900ZB	CRF150L K84 (2017 - Sekarang)	3 kg	Merah	\N
83500K93N00ZN	Scoopy eSP K93 (2017 - 2020)	8 kg	Hitam	\N
61303K56N00ZB	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Merah	\N
83450K15920ZD	CB150R StreetFire K15G (2015 - 2018)	0.4 kg	Hitam	\N
83610K15920RSW	CB150R StreetFire K15G (2015 - 2018)	3 kg	Putih	\N
83710K15920WRD	CB150R StreetFire K15G (2015 - 2018)	3 kg	Merah	\N
61303K15920ZC	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	0.3 kg	Putih	\N
83600K81N00FMB	BeAT Sporty eSP K81 (2016 - 2020)	3 kg	Hitam	\N
64441K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	3 kg	Putih	\N
53204KYZ900ZA	Supra X 125 Helm-In FI (2011 - 2018)\nSupra X 125 Helm-in Karburator (2011)	0.25 kg	Hitam	25 cmx 13 cmx 2 cm
80101K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Hitam	80 cmx 25 cmx 15 cm
64432K0WNA0ZB	ADV 160 (2022 - Sekarang)	0.3 kg	Silver	46 cmx 20 cmx 10 cm
64405K0WNA0ZB	ADV 160 (2022 - Sekarang)	0.2 kg	Hitam	17 cmx 15 cmx 3 cm
50312K0WNA0	ADV 160 (2022 - Sekarang)	2 kg	Hitam	32 cmx 20 cmx 16 cm
64301K2SN00ZD	Vario 160 K2S (2022 - Sekarang)	8 kg	Hitam	55 cmx 50 cmx 15 cm
64301K2SN00ZK	Vario 160 K2S (2022 - Sekarang)	8 kg	Merah	55 cmx 50 cmx 15 cm
64502K1ZJ10ZJ	PCX 160 K1Z (2021 - Sekarang)	18 kg	Grey	90 cmx 62 cmx 20 cm
61100K1ZN20MGB	PCX 160 K1Z (2021 - Sekarang)	5.2 kg	Hitam	50 cmx 25 cmx 25 cm
61100K1ZN20MIB	PCX 160 K1Z (2021 - Sekarang)	5.2 kg	Biru	50 cmx 25 cmx 25 cm
64431K1ZJ10ZJ	PCX 160 K1Z (2021 - Sekarang)	10 kg	Biru	90 cmx 40 cmx 18 cm
81133K2SN00MGB	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	13 cmx 11 cmx 8 cm
81137K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	0.1 kg	Hitam	15 cmx 8 cmx 4 cm
81146K2FN10ZE	Scoopy K2F (2020 - Sekarang)	0.1 kg	Hitam	\N
64301K2FN00ZP	Scoopy K2F (2020 - Sekarang)	8 kg	Biru	\N
80107K0WN00	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
19642K0JN00	BeAT dan BeAT Street K1A (2020 - 2024)\nGenio (2019 - 2022)\nScoopy K2F (2020 - Sekarang)	0.5 kg	Hitam	\N
64100K0WN00ZA	ADV 150 (2019 - 2022)	6 kg	Putih	\N
50312K97T00	PCX 150 K97 (2017 - 2021)	2 kg	Hitam	\N
80101K15600	CB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)	4 kg	Hitam	\N
64431K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	3 kg	Putih	\N
8011AK64N00	CBR 250RR K64 (2016 - 2020)	2 kg	Hitam	\N
83650K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Merah	\N
83610K64N00ZC	CBR 250RR K64 (2016 - 2020)	0.5 kg	Silver	\N
81141K93N00ZK	Scoopy eSP K93 (2017 - 2020)	10 kg	Putih	\N
64202K93N00ZH	Scoopy eSP K93 (2017 - 2020)	3 kg	Putih	\N
83175K64N00MGB	CBR 250RR K64 (2016 - 2020)	3 kg	Hitam	\N
61303K56N00ZF	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Hitam	\N
83710K15920RSW	CB150R StreetFire K15G (2015 - 2018)	3 kg	Putih	\N
83500K81N00FMB	BeAT Sporty eSP K81 (2016 - 2020)	3 kg	Hitam	\N
80110K81N00	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.3 kg	Hitam	\N
83111K45N40ZB	CBR 150R K45G (2016 - 2018)	8 kg	Putih	\N
64501K59A10WRD	Vario 125 eSP K60 (2015 - 2018)	4 kg	Merah	\N
83750K59A10ZL	Vario 150 eSP K59 (2015 - 2018)	0.4 kg	Hitam	\N
64501K59A10MIB	Vario 150 eSP K59 (2015 - 2018)	4 kg	Biru	\N
35112KVGV41	Vario 150 eSP K59 (2015 - 2018)	0.01 kg	Hitam	4 cmx 4 cmx 2 cm
83620K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	3 kg	Hitam	60 cmx 30 cmx 10 cm
81137K97T00ZV	PCX 150 K97 (2017 - 2021)	0.3 kg	Putih	\N
84100K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	5.7 kg	Grey	45 cmx 40 cmx 12 cm
64221K45NL0	CBR 150R K45R (2021 - Sekarang)	1.6 kg	Hitam	48 cmx 20 cmx 10 cm
64501K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	18 kg	Merah	90 cmx 62 cmx 20 cm
50731K1ZJ10ZB	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.1 kg	Hitam	17 cmx 6 cmx 2 cm
64241K45NL0MGB	CBR 150R K45R (2021 - Sekarang)	3 kg	Hitam	\N
64431K45NL0	CBR 150R K45R (2021 - Sekarang)	6 kg	Hitam	\N
81141KZL930ZA	Spacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)	8 kg	Hitam	\N
37610K15921	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	0.7 kg	Hitam, Silver	\N
64565K0WN00ZA	ADV 150 (2019 - 2022)	3 kg	Silver	\N
83110K45N60ZA	CBR 150R K45G (2016 - 2018)	4 kg	Merah	\N
50280K15900	CB150R StreetFire K15 (2012 - 2015)	3 kg	Hitam	\N
64321K15600	CB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
53205K81N00ZF	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	3 kg	Biru	\N
64210K45N60ZA	CBR 150R K45G (2016 - 2018)	5 kg	Merah	\N
83131K45N40MGB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.4 kg	Hitam	\N
6432CK15930	CB150R StreetFire K15G (2015 - 2018)	2 kg	Hitam	\N
83750K93N00ZK	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Hitam	\N
53207K93N00MJB	Scoopy eSP K93 (2017 - 2020)	0.4 kg	Coklat	\N
50325K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Hitam	\N
61100K93N00ZM	Scoopy eSP K93 (2017 - 2020)	4 kg	Putih	\N
83510K56N10MGB	Supra GTR K56F (2016 - 2019)	5 kg	Hitam	\N
80150K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	4 kg	Hitam	\N
83600K81N00RSW	BeAT Sporty eSP K81 (2016 - 2020)	3 kg	Putih	\N
83121K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	\N
61100K15920ZD	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	5 kg	Hitam	\N
64501K59A10CSR	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	4 kg	Merah	\N
67101K1ZN40	PCX 160 K1Z (2021 - Sekarang)	5 kg	Hitam	45 cmx 47 cmx 14 cm
33708K03N50ZA	Revo 110 FI (2014 - Sekarang)	0.2 kg	Hitam	22 cmx 15 cmx 6 cm
50606K56N10	Supra GTR K56F (2016 - 2019)	1.381 kg	Hitam	78 cmx 24 cmx 8 cm
61300K84600ZA	CRF150L K84 (2017 - Sekarang)	3.12 kg	Merah, Putih	39 cmx 40 cmx 12 cm
64502K0WNA0ZH	ADV 160 (2022 - Sekarang)	12 kg	Putih	65 cmx 50 cmx 20 cm
81265K1ZJ10	PCX 160 K1Z (2021 - Sekarang)\nStylo 160 (2024 - Sekarang)	0.022 kg	Hitam	16 cmx 6 cmx 2 cm
67110K3BN10ZA	CB150X (2021 - Sekarang)	2 kg	Putih	36 cmx 25 cmx 5 cm
64421K2FN00ZQ	Scoopy K2F (2020 - Sekarang)	3 kg	Putih	60 cmx 16 cmx 5 cm
61100K2FN00ZQ	Scoopy K2F (2020 - Sekarang)	5 kg	Putih	56 cmx 25 cmx 18 cm
64311K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	8 kg	Hitam	\N
64301K1AN00HSM	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Silver	\N
64431K0JN00ZC	Genio (2019 - 2022)	3 kg	Hitam	\N
81131K0JN00ZC	Genio (2019 - 2022)	5 kg	Hitam	\N
64201K0JN00ZC	Genio (2019 - 2022)	3 kg	Hitam	\N
61100K0WN00MGB	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
83120K45NH0ZA	CBR 150R K45G (2016 - 2018)	4 kg	Hitam	\N
61300K84920ZC	CRF150L K84 (2017 - Sekarang)	3 kg	Hitam	\N
83710K15600MGB	CB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
8010BK46N20	Vario 110 eSP (2015 - 2019)	6.2 kg	Hitam	79 cmx 34 cmx 14 cm
80101K59A70	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	4 kg	Hitam	\N
61100K93N00ZP	Scoopy eSP K93 (2017 - 2020)	6 kg	Merah	\N
53210K56NJ0ZA	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	2 kg	Hitam	48 cmx 22 cmx 20 cm
80151K61900ZA	BeAT POP eSP K61 (2014 - 2019)	3 kg	Hitam	\N
61304K56N00ZD	Sonic 150R K56 (2015 - Sekarang)	0.6 kg	Putih	\N
53205K93N00ZK	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Silver	\N
64202K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	3 kg	Silver	\N
81132K93N00	Scoopy eSP K93 (2017 - 2020)	1.6 kg	Hitam	\N
80110K93N00	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Hitam	\N
83500K81N00RSW	BeAT Sporty eSP K81 (2016 - 2020)	3 kg	Putih	\N
64411K45N40ROW	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	12 kg	Oranye	\N
61100K59A10MJB	Vario 150 eSP K59 (2015 - 2018)	5 kg	Coklat	\N
53208K59A10MJB	Vario 150 eSP K59 (2015 - 2018)	2 kg	Coklat	\N
81131K59A10ZK	Vario 150 eSP K59 (2015 - 2018)	1.6 kg	Coklat	\N
83750K59A10ZJ	Vario 150 eSP K59 (2015 - 2018)	0.4 kg	Hitam	\N
64380K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	10 kg	Hitam	80 cmx 50 cmx 15 cm
83680K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.6 kg	Hitam	40 cmx 12 cmx 8 cm
64202K2FN00YG	Scoopy K2F (2020 - Sekarang)	2 kg	Hijau	60 cmx 20 cmx 10 cm
81142K2FN80ZK	Scoopy K2F (2020 - Sekarang)	0.3 kg	Hitam	22 cmx 15 cmx 5 cm
50311K0WNA0	ADV 160 (2022 - Sekarang)	0.4 kg	Hitam	29 cmx 18 cmx 12 cm
83141K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	1 kg	Merah	37 cmx 21 cmx 7 cm
61306K15710	CB150R StreetFire K15P (2021 - Sekarang)	0.15 kg	Hitam	24 cmx 11 cmx 4 cm
83630K2SN00ZE	Vario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	39 cmx 12 cmx 5 cm
53207K2SN10FMB	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	3 cmx 17 cmx 27 cm
64302K56N10ZB	Supra GTR K56F (2016 - 2019)	4.5 kg	Hitam	43 cmx 40 cmx 16 cm
64351K3BN00	CB150X (2021 - Sekarang)	6.5 kg	Hitam	82 cmx 30 cmx 16 cm
64601K2SN00ZL	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Putih	40 cmx 27 cmx 6 cm
64502K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	18 kg	Hitam	90 cmx 62 cmx 20 cm
64503K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Biru	19 cmx 8 cmx 3 cm
64503K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Hitam	19 cmx 8 cmx 3 cm
83600K2FN00MJB	Scoopy K2F (2020 - Sekarang)	8 kg	Coklat	80 cmx 38 cmx 15 cm
64202K2FN00ZM	Scoopy K2F (2020 - Sekarang)	3 kg	Merah	60 cmx 16 cmx 5 cm
64211K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	6 kg	Oranye	\N
37230K25901	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)	0.5 kg	Hitam	20 cmx 20 cmx 5 cm
81144K93N00ZB	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Hitam	\N
81132K2FN00	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
67111K45NL0	CBR 150R K45R (2021 - Sekarang)	7 kg	Silver	\N
64501K0WN01ZE	ADV 150 (2019 - 2022)	12 kg	Putih	65 cmx 50 cmx 20 cm
53205KYZ900ZK	Supra X 125 Helm-in Karburator (2011)	2 kg	Hitam	\N
64501K97T00YL	PCX 150 K97 (2017 - 2021)	15 kg	Coklat	\N
81141K93N00ZY	Scoopy eSP K93 (2017 - 2020)	11 kg	Hitam	\N
53205K1AN00ZG	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
64410K0WN00ZB	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
61000K0WN10ZB	ADV 150 (2019 - 2022)	3 kg	Merah	\N
64300K45NH0ZC	CBR 150R K45N (2018 - 2020)	2 kg	Hitam	\N
39602K41N21	ADV 150 (2019 - 2022)\nBeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nGenio (2019 - 2022)\nPCX 150 K97 (2017 - 2021)\nScoopy eSP K93 (2017 - 2020)\nSupra X 125 FI New (2014 - Sekarang)	0.1 kg	Hitam	\N
50260K15600FMB	CB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
64501K46N00MAG	Vario 110 eSP (2015 - 2019)	3 kg	Grey	\N
50265K15600FMB	CB150R StreetFire K15M (2018 - 2021)	2.5 kg	Hitam	\N
61100K46N00ZC	Vario 110 FI (2014 - 2015)	4 kg	Hitam	\N
64341K45N40MGB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	4 kg	Hitam	\N
50260K15600WRD	CB150R StreetFire K15M (2018 - 2021)	3 kg	Merah	\N
50265K15600MGB	CB150R StreetFire K15M (2018 - 2021)	2 kg	Hitam	\N
53205K81N00ZG	BeAT Sporty eSP K81 (2016 - 2020)	3 kg	Magenta / Ungu / Pink	\N
64501K59A70ZS	Vario 150 eSP K59J (2018 - 2022)	7 kg	Silver	\N
64360K59A70ZA	Vario 150 eSP K59J (2018 - 2022)	6 kg	Hitam	\N
64601K59A70ZP	Vario 150 eSP K59J (2018 - 2022)	9 kg	Putih	60 cmx 53 cmx 16 cm
53206K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Putih	\N
84152K97T00ZD	PCX 150 K97 (2017 - 2021)	0.3 kg	Hitam	\N
64441K45N40MGB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	4 kg	Hitam	\N
64308K61900	BeAT POP eSP K61 (2014 - 2019)	5 kg	Hitam	\N
80110K50T00	BeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)	1 kg	Hitam	\N
61300K84900ZA	CRF150L K84 (2017 - Sekarang)	5 kg	Putih	\N
6432BK15930	CB150R StreetFire K15G (2015 - 2018)	2 kg	Hitam	\N
53205K25900CSR	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	3 kg	Merah	\N
53204KZR600FMB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.5 kg	Hitam	\N
64421K93N00ZH	Scoopy eSP K93 (2017 - 2020)	2 kg	Putih	\N
61100K93N00ZL	Scoopy eSP K93 (2017 - 2020)	4 kg	Merah	\N
61100K93N00ZA	Scoopy eSP K93 (2017 - 2020)	5 kg	Cream	\N
81141K93N00ZM	Scoopy eSP K93 (2017 - 2020)	10 kg	Hijau	\N
61100K64N00ZA	CBR 150R K45R (2021 - Sekarang)\nCBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Merah	\N
83610K56N00RSW	Sonic 150R K56 (2015 - Sekarang)	5 kg	Putih	\N
64320K56N00RSW	Sonic 150R K56 (2015 - Sekarang)	4 kg	Putih	\N
53207K56N10ZE	Supra GTR K56F (2016 - 2019)	0.5 kg	Putih	\N
81250K81N00	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	8 kg	Hitam	\N
64411K45N40ZB	CBR 150R K45G (2016 - 2018)	8 kg	Putih	60 cmx 57 cmx 15 cm
81131K59A10ZE	Vario 150 eSP K59 (2015 - 2018)	1.6 kg	Merah	\N
81131K2FN80	Scoopy K2F (2020 - Sekarang)	1.5 kg	Hitam	28 cmx 20 cmx 15 cm
64201K2FN00YG	Scoopy K2F (2020 - Sekarang)	2 kg	Hijau	60 cmx 20 cmx 10 cm
64350K41N00	Supra GTR K56F (2016 - 2019)\nSupra X 125 FI New (2014 - Sekarang)	2.3 kg	Hitam	45 cmx 25 cmx 12 cm
64301K2SN00ZL	Vario 160 K2S (2022 - Sekarang)	8 kg	Putih	55 cmx 50 cmx 15 cm
83500K2FN00MPC	Scoopy K2F (2020 - Sekarang)	8 kg	Putih	80 cmx 38 cmx 15 cm
80151K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	20 cmx 17 cmx 7 cm
64301K2FN00ZM	Scoopy K2F (2020 - Sekarang)	5.5 kg	Merah	55 cmx 30 cmx 20 cm
83610K1ZJ10MGB	PCX 160 K1Z (2021 - Sekarang)	11 kg	Hitam	108 cmx 30 cmx 20 cm
61100K2SN00MSR	Vario 160 K2S (2022 - Sekarang)	3 kg	Merah	37 cmx 20 cmx 22 cm
64434K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Hitam	24 cmx 12 cmx 3 cm
64361K3BN00	CB150X (2021 - Sekarang)	3 kg	Hitam	43 cmx 40 cmx 10 cm
81142K2SN00ZK	Vario 160 K2S (2022 - Sekarang)	10.4 kg	Merah	55 cmx 38 cmx 30 cm
81140K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	1.6 kg	Putih	36 cmx 20 cmx 14 cm
81132K1ZN20	PCX 160 K1Z (2021 - Sekarang)	0.8 kg	Hitam	28 cmx 15 cmx 12 cm
64421K2FN00ZM	Scoopy K2F (2020 - Sekarang)	3 kg	Merah	60 cmx 16 cmx 5 cm
64301K2FN00ZN	Scoopy K2F (2020 - Sekarang)	5 kg	Merah	42 cmx 45 cmx 15 cm
64201K2FN00ZM	Scoopy K2F (2020 - Sekarang)	3 kg	Merah	60 cmx 16 cmx 5 cm
61100K2FN00ZK	Scoopy K2F (2020 - Sekarang)	5 kg	Coklat	56 cmx 25 cmx 18 cm
61100K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	6 kg	Hitam	\N
81141K46N20ZA	Vario 110 eSP (2015 - 2019)	5 kg	Hitam	\N
81200K1AN00	BeAT dan BeAT Street K1A (2020 - 2024)	1.3 kg	Hitam	32 cmx 32 cmx 8 cm
50270K15600ZA	CB150R StreetFire K15M (2018 - 2021)	1 kg	Merah	\N
44610K84900	CRF150L K84 (2017 - Sekarang)	0.5 kg	Hitam	\N
64502K0WN01ZC	ADV 150 (2019 - 2022)	12 kg	Merah	65 cmx 50 cmx 20 cm
64502K96V00YC	PCX 150 K97 (2017 - 2021)	12 kg	Silver	\N
64201K93N00ZX	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
64330K64N00MSR	CBR 250RR K64 (2016 - 2020)	12 kg	Merah	\N
83630K64N00ZJ	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Hitam	\N
64430K64N00MSR	CBR 250RR K64 (2016 - 2020)	10 kg	Merah	\N
83710K15600MSR	CB150R StreetFire K15M (2018 - 2021)	0.6 kg	Merah	\N
50275K15600ZD	CB150R StreetFire K15M (2018 - 2021)	0.6 kg	Hitam	\N
83750K46N00ZC	Vario 110 FI (2014 - 2015)	0.8 kg	Hitam	\N
83750K59A70ZD	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)	1 kg	Hitam	\N
64350K59A70ZA	Vario 150 eSP K59J (2018 - 2022)	6 kg	Hitam	\N
64601K59A70ZL	Vario 150 eSP K59J (2018 - 2022)	5 kg	Merah	\N
64501K59A70ZL	Vario 150 eSP K59J (2018 - 2022)	4 kg	Merah	\N
37620K45N41	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	1 kg	Hitam	\N
84152K97T00YA	PCX 150 K97 (2017 - 2021)	0.7 kg	Putih	\N
64411K45N40MGB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	60 cmx 57 cmx 15 cm
64330K64N00NOR	CBR 250RR K64 (2016 - 2020)	12 kg	Oranye	\N
64601K59A10RSW	Vario 125 eSP K60 (2015 - 2018)	3 kg	Putih	\N
83165K64N00MGB	CBR 250RR K64 (2016 - 2020)	3 kg	Hitam	\N
61100K56N00WRD	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
61100K56N00SMM	Sonic 150R K56 (2015 - Sekarang)	3 kg	Magenta / Ungu / Pink	\N
64610K56N10MGB	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	8 kg	Hitam	\N
61100K15920ZC	CB150R StreetFire K15G (2015 - 2018)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	5 kg	Putih	\N
64341K45N40ZC	CBR 150R K45G (2016 - 2018)	3 kg	Putih	\N
64441K45N40ZC	CBR 150R K45G (2016 - 2018)	3 kg	Putih	\N
64421K45N40ZB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Hitam	\N
83750K59A10ZP	Vario 150 eSP K59 (2015 - 2018)	0.4 kg	Biru	\N
64302KZR600FMB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	1.5 kg	Hitam	45 cmx 25 cmx 8 cm
83610K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.1 kg	Hitam	17 cmx 12 cmx 3 cm
64224K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2 kg	Hitam	23 cmx 34 cmx 14 cm
81135K2FN80	Scoopy K2F (2020 - Sekarang)	0.02 kg	Hitam	10 cmx 2 cmx 2 cm
83600K2VN30FMB	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Hitam	85 cmx 25 cmx 15 cm
81141K2FN90ZD	Scoopy K2F (2020 - Sekarang)	10 kg	Coklat	60 cmx 40 cmx 20 cm
64601K2VN30FMB	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Hitam	36 cmx 36 cmx 10 cm
64301K2VN30ZK	Vario 125 eSP K2V (2022 - Sekarang)	5.75 kg	Biru	50 cmx 46 cmx 15 cm
64301K2FN00YG	Scoopy K2F (2020 - Sekarang)	5 kg	Hitam	42 cmx 45 cmx 15 cm
64310K2FN80ZB	Scoopy K2F (2020 - Sekarang)	5.1 kg	Hitam	55 cmx 40 cmx 14 cm
61100K0WNA0MGB	ADV 160 (2022 - Sekarang)	6 kg	Hitam	60 cmx 30 cmx 20 cm
83400K15710ZA	CB150R StreetFire K15P (2021 - Sekarang)	0.2 kg	Hitam	22 cmx 18 cmx 4 cm
80111K45NL0	CBR 150R K45R (2021 - Sekarang)	7.3 kg	Hitam	87 cmx 34 cmx 15 cm
81265K0WNA0	ADV 160 (2022 - Sekarang)	0.04 kg	Hitam	16 cmx 10 cmx 2 cm
64100K0WNA0ZA	ADV 160 (2022 - Sekarang)	4 kg	Putih	55 cmx 35 cmx 7 cm
83530K2SN00ZE	Vario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	39 cmx 12 cmx 5 cm
83620K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Hitam	40 cmx 27 cmx 7 cm
83600K2SN00PBL	Vario 160 K2S (2022 - Sekarang)	5 kg	Grey	80 cmx 20 cmx 15 cm
61305K15710	CB150R StreetFire K15P (2021 - Sekarang)	0.25 kg	Hitam	26 cmx 11 cmx 5 cm
11360K84900	CRF150L K84 (2017 - Sekarang)	0.5 kg	Hitam	\N
61100K59A70YE	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)	3.5 kg	Putih	48 cmx 24 cmx 18 cm
64431K2SN00ZK	Vario 160 K2S (2022 - Sekarang)	0.7 kg	Merah	38 cmx 22 cmx 5 cm
64432K1ZJ10ZK	PCX 160 K1Z (2021 - Sekarang)	10 kg	Grey	90 cmx 40 cmx 18 cm
50741K1ZJ10ZB	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.1 kg	Hitam	17 cmx 6 cmx 2 cm
61100K2FN00ZN	Scoopy K2F (2020 - Sekarang)	5 kg	Merah	56 cmx 25 cmx 18 cm
83111K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	6 kg	Merah	\N
64501K97T00YM	PCX 150 K97 (2017 - 2021)	15 kg	Grey, Hitam	\N
81200K0JN00ZA	Genio (2019 - 2022)	3 kg	Hitam	\N
61100K1AN00MCS	BeAT dan BeAT Street K1A (2020 - 2024)	6 kg	Silver	\N
64400K0WN10ZB	ADV 150 (2019 - 2022)	12 kg	Merah	65 cmx 50 cmx 20 cm
64421K0JN00ZD	Genio (2019 - 2022)	3 kg	Putih	\N
64431K0JN00ZB	Genio (2019 - 2022)	3 kg	Merah	\N
64431K0JN00ZG	Genio (2019 - 2022)	3 kg	Hitam	\N
61100K0WN00RSW	ADV 150 (2019 - 2022)	3 kg	Putih	\N
64310K45NA0ZA	CBR 150R K45N (2018 - 2020)	6 kg	Hitam	\N
80151K0JN00ZA	Genio (2019 - 2022)	3 kg	Coklat	\N
83120K45N60ZA	CBR 150R K45G (2016 - 2018)	4 kg	Merah	\N
64302K59A70ZB	Vario 150 eSP K59J (2018 - 2022)	2.5 kg	Hitam	\N
61100K59A70ZX	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	4 kg	Biru	\N
64301K81N00MGB	BeAT Sporty eSP K81 (2016 - 2020)	11 kg	Hitam	\N
83640K15900ZA	CB150R StreetFire K15 (2012 - 2015)	4 kg	Hitam	\N
83620K64N00ZJ	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Hitam	\N
61100K46N00ZB	Vario 110 FI (2014 - 2015)	3 kg	Putih	\N
64301K46N00FMB	Vario 110 FI (2014 - 2015)	8 kg	Hitam	\N
83750K46N00ZG	Vario 110 eSP (2015 - 2019)	0.8 kg	Grey	\N
53208K59A70ZP	Vario 125 eSP K60R (2018 - 2022)	0.8 kg	Hitam	\N
83750K59A70ZB	Vario 125 eSP K2V (2022 - Sekarang)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	\N
81131K59A70ZL	Vario 150 eSP K59J (2018 - 2022)	3 kg	Merah	\N
64210K64N00ASB	CBR 250RR K64 (2016 - 2020)	6 kg	Hitam	\N
64305K97T00ZD	PCX 150 K97 (2017 - 2021)	7 kg	Hitam	\N
64601K46N00FMB	Vario 110 FI (2014 - 2015)	3 kg	Hitam	\N
64506K97T00ZX	PCX 150 K97 (2017 - 2021)	0.5 kg	Merah	\N
84152K97T00ZX	PCX 150 K97 (2017 - 2021)	0.7 kg	Merah	\N
83610K97T00ZN	PCX 150 K97 (2017 - 2021)	10 kg	Hitam	\N
64506K97T00YA	PCX 150 K97 (2017 - 2021)	0.5 kg	Putih	\N
61100K97T00YA	PCX 150 K97 (2017 - 2021)	10 kg	Gold	\N
83510K84901ZB	CRF150L K84 (2017 - Sekarang)	6 kg	Hitam, Merah, Putih	\N
64455KYZ900	Supra X 125 Helm-in Karburator (2011)	3 kg	Hitam	\N
8113AKVB930	Vario 110 CW (2006 - 2014)	7 kg	Hitam	\N
54302K16900FMB	Scoopy FI K16G (2013 - 2015)	6 kg	Hitam	\N
61302K56N00ZE	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Hitam	\N
53205KZR600FMB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	3 kg	Hitam	\N
64431K93N00ZH	Scoopy eSP K93 (2017 - 2020)	2 kg	Putih	\N
83650K93N00ZN	Scoopy eSP K93 (2017 - 2020)	0.2 kg	Hitam	\N
64431K93N00ZG	Scoopy eSP K93 (2017 - 2020)	2 kg	Merah	\N
53207K93N00FMB	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Hitam	\N
81141K93N00ZL	Scoopy eSP K93 (2017 - 2020)	10 kg	Silver	\N
64501K1ZJ10ZJ	PCX 160 K1Z (2021 - Sekarang)	18 kg	Grey	90 cmx 62 cmx 20 cm
83610K56N00FMB	Sonic 150R K56 (2015 - Sekarang)	5 kg	Hitam	\N
64440K56N00FMB	Sonic 150R K56 (2015 - Sekarang)	5 kg	Hitam	\N
61303K56N00NOR	Sonic 150R K56 (2015 - Sekarang)	0.5 kg	Oranye	28 cmx 15 cmx 4 cm
53207K56N10ZC	Supra GTR K56F (2016 - 2019)	0.5 kg	Biru	\N
53205K81N00RSW	BeAT Sporty eSP K81 (2016 - 2020)	2 kg	Putih	\N
64301K59A10ZK	Vario 125 eSP K60 (2015 - 2018)	3 kg	Merah	\N
53206KVY960	BeAT Karburator KVY (2008 - 2012)	1.7 kg	Hitam	45 cmx 15 cmx 15 cm
81141K2FN90ZE	Scoopy K2F (2020 - Sekarang)	10 kg	Hitam	60 cmx 40 cmx 20 cm
11360K15900	CB150R StreetFire K15 (2012 - 2015)\nCBR 150R K45A (2014 - 2016)	0.4 kg	Hitam	20 cmx 17 cmx 6 cm
83610K84610ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	50 cmx 22 cmx 5 cm
81132K2FN80	Scoopy K2F (2020 - Sekarang)	1.5 kg	Hitam	30 cmx 20 cmx 15 cm
64501K2VN30MIB	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Biru	36 cmx 36 cmx 10 cm
64220K03N30	Revo 110 FI (2014 - Sekarang)	0.2 kg	Hitam	18 cmx 14 cmx 8 cm
64421K2FN00ZK	Scoopy K2F (2020 - Sekarang)	3 kg	Coklat	60 cmx 16 cmx 5 cm
83560K84600ZA	CRF150L K84 (2017 - Sekarang)	1.5 kg	Putih	55 cmx 23 cmx 7 cm
11341K2SN00	Stylo 160 (2024 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	3 kg	Hitam	46 cmx 22 cmx 10 cm
83610K0WNA0ASB	ADV 160 (2022 - Sekarang)	4 kg	Hitam	80 cmx 20 cmx 15 cm
64501K0WNA0ZF	ADV 160 (2022 - Sekarang)	12 kg	Putih	65 cmx 50 cmx 20 cm
83141K45NL0ZE	CBR 150R K45R (2021 - Sekarang)	4 kg	Hitam	\N
64211K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	6 kg	Merah	\N
64460K46N20ZA	Vario 110 eSP (2015 - 2019)	0.15 kg	Hitam	18 cmx 17 cmx 3 cm
53205K2FN00MGB	Scoopy K2F (2020 - Sekarang)	1.1 kg	Hitam	22 cmx 20 cmx 15 cm
80107K2SN00	Stylo 160 (2024 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	1.5 kg	Hitam	27 cmx 17 cmx 5 cm
83520K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Hitam	40 cmx 27 cmx 7 cm
53205K2SN10FMB	Vario 160 K2S (2022 - Sekarang)	0.4 kg	Hitam	3 cmx 17 cmx 17 cm
83610K1ZJ10PFW	PCX 160 K1Z (2021 - Sekarang)	9.68 kg	Putih	110 cmx 24 cmx 22 cm
64501K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	18 kg	Putih	90 cmx 62 cmx 20 cm
53206K2FN00ZL	Scoopy K2F (2020 - Sekarang)	0.2 kg	Hitam	20 cmx 19 cmx 8 cm
61100K1ZN20MDG	PCX 160 K1Z (2021 - Sekarang)	5.2 kg	Hitam	50 cmx 25 cmx 25 cm
64432K2SN00ZD	Vario 160 K2S (2022 - Sekarang)	0.6 kg	Hitam	38 cmx 22 cmx 5 cm
64432K2SN00ZM	Vario 160 K2S (2022 - Sekarang)	0.6 kg	Hitam	38 cmx 22 cmx 5 cm
64431K1ZJ10ZK	PCX 160 K1Z (2021 - Sekarang)	10 kg	Grey	90 cmx 40 cmx 18 cm
83500K2SN00MGB	Vario 160 K2S (2022 - Sekarang)	4 kg	Hitam	80 cmx 20 cmx 15 cm
81134K2FN00ZM	Scoopy K2F (2020 - Sekarang)	0.5 kg	Grey	\N
81250K2FN00	Scoopy K2F (2020 - Sekarang)	10 kg	Hitam	56 cmx 33 cmx 32 cm
53205K2FN00FMB	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	22 cmx 20 cmx 15 cm
64301K2FN00ZL	Scoopy K2F (2020 - Sekarang)	5 kg	Cream	\N
83750K2FN00ZQ	Scoopy K2F (2020 - Sekarang)	5 kg	Putih	\N
64301K1AN00ARB	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Biru	47 cmx 39 cmx 40 cm
86650K93NB0ZC	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Merah	\N
64502K96V00YH	PCX 150 K97 (2017 - 2021)	18 kg	Hitam	90 cmx 62 cmx 20 cm
64410K45NE0ZA	CBR 150R K45N (2018 - 2020)	6 kg	Merah	\N
81134K0JN00ZC	Genio (2019 - 2022)	0.25 kg	Hitam	\N
64201K0JN00ZB	Genio (2019 - 2022)	3 kg	Merah	\N
83600K0WN00ZB	ADV 150 (2019 - 2022)	4 kg	Hitam	\N
83110K45NH0ZA	CBR 150R K45G (2016 - 2018)	4 kg	Hitam	\N
83750K59A70ZN	Vario 150 eSP K59J (2018 - 2022)	0.6 kg	Biru	\N
64330K64N00AGM	CBR 250RR K64 (2016 - 2020)	12 kg	Silver	\N
30405KZR600	Vario 125 eSP K60 (2015 - 2018)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59 (2015 - 2018)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	1 kg	Hitam	\N
64322K15600	CB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
61303K15920ZB	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	0.3 kg	Hitam	\N
53208K46N00ZB	Vario 110 eSP (2015 - 2019)	0.8 kg	Merah	\N
64501K46N00FMB	Vario 110 FI (2014 - 2015)	3 kg	Hitam	\N
50265K15600WRD	CB150R StreetFire K15M (2018 - 2021)	3 kg	Merah	\N
50270K15600ZC	CB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
64301K25900NOR	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	11 kg	Oranye	\N
53208K59A70ZC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	\N
83610K97T00ZX	PCX 150 K97 (2017 - 2021)	10 kg	Merah	\N
83121K45N40MGB	CBR 150R K45G (2016 - 2018)	8 kg	Hitam	\N
83600K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	8 kg	Putih	\N
61100K97T00YB	PCX 150 K97 (2017 - 2021)	5 kg	Merah	\N
83550K61900ZA	BeAT POP eSP K61 (2014 - 2019)	1 kg	Hitam	\N
80102K84900	CRF150L K84 (2017 - Sekarang)	7 kg	Hitam	\N
61100K56N00RSW	Sonic 150R K56 (2015 - Sekarang)	3 kg	Putih	\N
6131AK18900	Verza 150 (2013 - 2018)	5 kg	Hitam	\N
83155K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.5 kg	Hitam	\N
64501K59A10RSW	Vario 125 eSP K60 (2015 - 2018)	3 kg	Putih	\N
64301K59A10ZP	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Putih	\N
64421K45N40ZC	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Merah	\N
81250K93N00	Scoopy eSP K93 (2017 - 2020)	8 kg	Hitam	\N
50315K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2 kg	Hitam	\N
83650K64N00ZC	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	1 kg	Putih	\N
64330K64N00WRD	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	12 kg	Merah	\N
64610K56N10MIB	Supra GTR K56F (2016 - 2019)	8 kg	Biru	\N
61100K56N10ZE	Supra GTR K56F (2016 - 2019)	5 kg	Putih	\N
53208K56N10ZC	Supra GTR K56F (2016 - 2019)	0.5 kg	Biru	\N
83710K15920FMB	CB150R StreetFire K15G (2015 - 2018)	3 kg	Hitam	\N
64511K45N40ZB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.4 kg	Merah	\N
64511K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.4 kg	Oranye	\N
83600K59A10PFW	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Putih	\N
64301KZR600CSR	Vario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	9 kg	Merah	60 cmx 50 cmx 18 cm
83500K2VN30FMB	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Hitam	85 cmx 25 cmx 15 cm
64601K2VN30VRD	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Merah	36 cmx 36 cmx 10 cm
61100K2FN00YK	Scoopy K2F (2020 - Sekarang)	5 kg	Hijau	56 cmx 25 cmx 18 cm
53208K2VN30VRD	Vario 125 eSP K2V (2022 - Sekarang)	0.2 kg	Merah	24 cmx 20 cmx 8 cm
81141K2FN80ZD	Scoopy K2F (2020 - Sekarang)	10 kg	Cream	60 cmx 40 cmx 20 cm
80151K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	4.3 kg	Hitam	46 cmx 31 cmx 18 cm
64502K0WNA0ZB	ADV 160 (2022 - Sekarang)	18 kg	Hitam	90 cmx 62 cmx 20 cm
80110K16900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nScoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.25 kg	Hitam	16 cmx 15 cmx 8 cm
64320K3BN00ZC	CB150X (2021 - Sekarang)	4 kg	Merah	50 cmx 48 cmx 10 cm
83610K0WNA0MGB	ADV 160 (2022 - Sekarang)	4 kg	Hitam	80 cmx 20 cmx 15 cm
83111K45NL0ZE	CBR 150R K45R (2021 - Sekarang)	5 kg	Hitam	\N
80103K0WNA0	ADV 160 (2022 - Sekarang)	1.16 kg	Hitam	35 cmx 20 cmx 10 cm
64560K0WNA0ZB	ADV 160 (2022 - Sekarang)	0.3 kg	Silver	38 cmx 36 cmx 10 cm
64326K0WNA0	ADV 160 (2022 - Sekarang)	0.25 kg	Hitam	55 cmx 10 cm
64320K15600MGB	CB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
80100K15920ZA	CB150R StreetFire K15 (2012 - 2015)\nCB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)	5 kg	Hitam	\N
83500K2SN00PBL	Vario 160 K2S (2022 - Sekarang)	5 kg	Hitam	80 cmx 20 cmx 15 cm
64305K64NA0ZB	CBR 250RR K64 (2016 - 2020)	12 kg	Hitam	60 cmx 60 cmx 20 cm
86201K3BN00ZA	CB150X (2021 - Sekarang)	0.1 kg	Hitam	16 cmx 5 cmx 5 cm
61100K2SN00MPC	Vario 160 K2S (2022 - Sekarang)	3 kg	Putih	37 cmx 20 cmx 22 cm
64431K2FN00ZN	Scoopy K2F (2020 - Sekarang)	3 kg	Hitam	60 cmx 16 cmx 5 cm
81140K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	1 kg	Hitam	35 cmx 21 cmx 10 cm
80110K1ZJ10ZA	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	2 kg	Hitam	32 cmx 34 cmx 10 cm
81141K2FN10ZF	Scoopy K2F (2020 - Sekarang)	10 kg	Silver	60 cmx 40 cmx 20 cm
64420K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Putih	19 cmx 8 cmx 5 cm
64431K2FN00ZE	Scoopy K2F (2020 - Sekarang)	3 kg	Hitam	60 cmx 16 cmx 5 cm
64431K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	3 kg	Coklat	60 cmx 16 cmx 5 cm
83111K45N40ZD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	2 kg	Merah	\N
64502K0WN01ZB	ADV 150 (2019 - 2022)	12 kg	Merah	65 cmx 50 cmx 20 cm
33722KWN901	CRF150L K84 (2017 - Sekarang)\nPCX 125 CBU (2010 - 2012)\nPCX 150 CBU (2012 - 2014)\nScoopy K2F (2020 - Sekarang)\nSpacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)\nSupra GTR K56F (2016 - 2019)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	1 kg	Hitam	\N
64501K0WN01ZC	ADV 150 (2019 - 2022)	12 kg	Merah	65 cmx 50 cmx 20 cm
83520K56NJ0	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	5 kg	Hitam	\N
83121K45N40ZE	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	5 kg	Grey, Hitam	\N
53204K41N00ZA	Supra X 125 FI New (2014 - Sekarang)	1.5 kg	Hitam	\N
83620KZL930ZA	Spacy Karburator (2011 - 2013)	3 kg	Hitam	\N
64301K1AN00RSW	BeAT dan BeAT Street K1A (2020 - 2024)	8 kg	Putih	\N
83500K1AN00MGB	BeAT dan BeAT Street K1A (2020 - 2024)	8 kg	Hitam	\N
64400K0WN10ZA	ADV 150 (2019 - 2022)	12 kg	Putih	65 cmx 50 cmx 20 cm
64326K0WN00	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
64431K0JN00ZA	Genio (2019 - 2022)	3 kg	Coklat	\N
64301K0JN00FMB	Genio (2019 - 2022)	5 kg	Hitam	\N
64336K0WN00ZB	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	3.5 kg	Merah	\N
64301K0JN00MGB	Genio (2019 - 2022)	5 kg	Hitam	\N
83510K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Hitam	\N
83120K45N50ZA	CBR 150R K45N (2018 - 2020)	6 kg	Oranye, Putih	\N
64410K45NA0ZA	CBR 150R K45N (2018 - 2020)	14 kg	Hitam	\N
83510K84920ZA	CRF150L K84 (2017 - Sekarang)	3 kg	Hitam	\N
50270K15600ZB	CB150R StreetFire K15M (2018 - 2021)	2 kg	Merah	\N
53208K46N00ZA	Vario 110 FI (2014 - 2015)	0.8 kg	Silver	\N
64601K59A70ZM	Vario 125 eSP K60R (2018 - 2022)	8 kg	Merah	\N
83600K59A70ZC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	6 kg	Hitam	\N
83750K59A70ZA	Vario 150 eSP K59J (2018 - 2022)	3 kg	Merah	\N
64501K59A70ZP	Vario 150 eSP K59J (2018 - 2022)	5 kg	Putih	\N
64301K59A70ZP	Vario 150 eSP K59J (2018 - 2022)	3 kg	Putih	\N
64210K64N00NOR	CBR 250RR K64 (2016 - 2020)	6 kg	Oranye	\N
83111K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	\N
81138K97T00ZN	PCX 150 K97 (2017 - 2021)	3 kg	Hitam	\N
64305K97T00ZW	PCX 150 K97 (2017 - 2021)	7 kg	Gold	\N
83111K45N40MGB	CBR 150R K45G (2016 - 2018)	8 kg	Hitam	\N
61301K15900	CB150R StreetFire K15 (2012 - 2015)	3 kg	Hitam	\N
64500K41N00ZA	Supra X 125 FI New (2014 - Sekarang)	5 kg	Hitam	\N
6431AKVB930	Vario 110 CW (2006 - 2014)	6 kg	Hitam	\N
64460K46N00	Vario 110 FI (2014 - 2015)	0.2 kg	Hitam	18 cmx 16 cmx 3 cm
81142K93N00ZG	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Hitam	\N
83500K59A10ZV	Vario 150 eSP K59 (2015 - 2018)	5 kg	Biru	\N
64430K64N00AGM	CBR 250RR K64 (2016 - 2020)	12 kg	Silver	\N
64340K56N00WRD	Sonic 150R K56 (2015 - Sekarang)	5 kg	Merah	\N
53207K56N10ZD	Supra GTR K56F (2016 - 2019)	0.5 kg	Hitam	\N
64301K56N10ZD	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	6 kg	Hitam	\N
64301K56N10ZC	Supra GTR K56F (2016 - 2019)	6 kg	Biru	\N
61303K15920ZD	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	3 kg	Hitam	\N
53205K81N00VBM	BeAT Sporty eSP K81 (2016 - 2020)	2 kg	Biru	\N
83750K59A10ZH	Vario 150 eSP K59 (2015 - 2018)	0.4 kg	Merah	\N
83600K59A10CSR	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Merah	\N
83500K59A10CSR	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Merah	\N
64301K59A10ZE	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	3 kg	Merah	\N
64301K59A10ZJ	Vario 150 eSP K59 (2015 - 2018)	3 kg	Coklat	\N
53206KYZ900ZH	Supra X 125 Helm-In FI (2011 - 2018)\nSupra X 125 Helm-in Karburator (2011)	5 kg	Hitam	55 cmx 30 cmx 15 cm
80108KYT900	Scoopy Karburator KYT (2010 - 2013)	0.15 kg	Hitam	8 cmx 8 cmx 3 cm
80107KYT900	Scoopy Karburator KYT (2010 - 2013)	0.15 kg	Hitam	8 cmx 8 cmx 3 cm
81131K16900ZV	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	2 kg	Hitam	40 cmx 20 cmx 15 cm
64350K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4.5 kg	Hitam	82 cmx 40 cmx 8 cm
64430K64NP0WRD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.5 kg	Merah	55 cmx 30 cmx 20 cm
64330K64N00ASB	CBR 250RR K64 (2016 - 2020)	15 kg	Hitam	\N
64501K2VN30MGB	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Hitam	36 cmx 36 cmx 10 cm
53208K2VN30MPC	Vario 125 eSP K2V (2022 - Sekarang)	0.2 kg	Putih	24 cmx 20 cmx 8 cm
64201K2FN00YF	Scoopy K2F (2020 - Sekarang)	2 kg	Silver	60 cmx 20 cmx 10 cm
83500K2FN00YE	Scoopy K2F (2020 - Sekarang)	8 kg	Hijau	80 cmx 36 cmx 15 cm
64501K59A70YB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	4 kg	Merah	\N
50285KYE940	Mega Pro FI (2014 - 2018)	2.2 kg	Hitam	45 cmx 29 cmx 10 cm
81130K2FN00ZK	Scoopy K2F (2020 - Sekarang)	0.3 kg	Hitam	22 cmx 12 cmx 5 cm
83520K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	3 kg	Hitam	60 cmx 30 cmx 10 cm
83610K84620ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam, Kuning	50 cmx 22 cmx 5 cm
81130K2VN30ZA	Vario 125 eSP K2V (2022 - Sekarang)	0.1 kg	Hitam	13 cmx 15 cmx 9 cm
81131K2FN00	Scoopy K2F (2020 - Sekarang)	0.25 kg	Hitam	28 cmx 18 cmx 6 cm
53205K2FN00MJB	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	22 cmx 20 cmx 15 cm
81139K0WN00ZK	ADV 160 (2022 - Sekarang)	0.25 kg	Hitam	28 cmx 27 cmx 4 cm
80102K0WNA0	ADV 160 (2022 - Sekarang)	0.25 kg	Hitam	29 cmx 31 cmx 4 cm
64325K0WNA0	ADV 160 (2022 - Sekarang)	0.25 kg	Hitam	55 cmx 10 cmx 3 cm
81140K0WN00ZK	ADV 160 (2022 - Sekarang)	1.5 kg	Hitam	30 cmx 26 cmx 10 cm
64502K0WNA0ZJ	ADV 160 (2022 - Sekarang)	12 kg	Putih	65 cmx 50 cmx 20 cm
64502K0WNA0ZF	ADV 160 (2022 - Sekarang)	12 kg	Putih	65 cmx 50 cmx 20 cm
19641KZR600	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.15 kg	Hitam	13 cmx 7 cmx 3 cm
81200K46N00ZA	Vario 110 eSP (2015 - 2019)\nVario 110 FI (2014 - 2015)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)	1.5 kg	Grey	32 cmx 32 cmx 8 cm
53205K2SN00FMB	Vario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	3 cmx 17 cmx 17 cm
61000K64610ZA	CBR 250RR K64 (2016 - 2020)	6 kg	Hitam	60 cmx 30 cmx 20 cm
50742K1ZJ10ZB	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.05 kg	Hitam	18 cmx 6 cmx 2 cm
83500K2FN00MSR	Scoopy K2F (2020 - Sekarang)	8 kg	Merah	80 cmx 38 cmx 15 cm
64503K97T00YW	PCX 150 K97 (2017 - 2021)	0.2 kg	Hitam	20 cmx 8 cmx 3 cm
64503K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Merah	20 cmx 8 cmx 3 cm
81142K2SN00ZL	Vario 160 K2S (2022 - Sekarang)	5.5 kg	Putih	50 cmx 38 cmx 17 cm
50400K56N00ZA	Sonic 150R K56 (2015 - Sekarang)	2 kg	Hitam	\N
81134K2FN00ZL	Scoopy K2F (2020 - Sekarang)	0.1 kg	Hitam	19 cmx 18 cmx 2 cm
80106K2FN00	Scoopy K2F (2020 - Sekarang)	0.4 kg	Hitam	20 cmx 15 cmx 8 cm
64460K2FN00ZC	Scoopy K2F (2020 - Sekarang)	1 kg	\N	30 cmx 25 cmx 5 cm
53206K1AN10ZA	BeAT dan BeAT Street K1A (2020 - 2024)	3 kg	Hitam	40 cmx 25 cmx 15 cm
83520KZR600ZB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	3 kg	Hitam	\N
64241K45NL0FMB	CBR 150R K45R (2021 - Sekarang)	3 kg	Hitam	\N
64441K45NL0ZE	CBR 150R K45R (2021 - Sekarang)	7 kg	Hitam	\N
11341K1AN00	BeAT dan BeAT Street K1A (2020 - 2024)\nScoopy K2F (2020 - Sekarang)	5 kg	\N	\N
83121K45N40ZD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	5 kg	Merah	\N
64432K97T00YY	PCX 150 K97 (2017 - 2021)	6 kg	Hitam	\N
53250K03N30ZA	Revo 110 FI (2014 - Sekarang)	3 kg	Hitam	\N
81265K0WN00	ADV 150 (2019 - 2022)	0.2 kg	Hitam	\N
64305K97T00YK	PCX 150 K97 (2017 - 2021)	5 kg	Silver	\N
81141K0JN00ZB	Genio (2019 - 2022)	8 kg	Hitam	\N
53205K1AN00ZH	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Silver	\N
64301K1AN00EMM	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Magenta / Ungu / Pink	\N
64500K0WN10ZA	ADV 150 (2019 - 2022)	12 kg	Putih	65 cmx 50 cmx 20 cm
77244K0JN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nGenio (2019 - 2022)\nScoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
64310K45NH0ZB	\N	12 kg	Hitam	77 cmx 60 cmx 15 cm
53204K46N20MAG	Vario 110 eSP (2015 - 2019)	0.5 kg	Grey	\N
81134K0JN00ZE	Genio (2019 - 2022)	3 kg	Hitam	\N
64336K0WN00ZD	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	3.5 kg	Hitam	\N
64301K0JN00VRD	Genio (2019 - 2022)	5 kg	Merah	\N
83500K59A70YB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Biru	\N
83750K59A70ZM	Vario 150 eSP K59J (2018 - 2022)	0.8 kg	Coklat	\N
81256KVY700	BeAT Karburator KVY (2008 - 2012)	1.5 kg	Hitam	\N
64211K45NA0ZC	CBR 150R K45N (2018 - 2020)	4 kg	Grey	\N
64211K45NA0ZB	CBR 150R K45N (2018 - 2020)	6 kg	Merah	\N
83630K64N00ZH	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Merah	\N
83620K64N00ZH	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Merah	\N
64310K64N00ZD	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Hitam	\N
83610K64N00FMB	CBR 250RR K64 (2016 - 2020)	1.5 kg	Hitam	\N
64430K64N00FMB	CBR 250RR K64 (2016 - 2020)	12 kg	Hitam	\N
64320K64N00ZB	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Hitam	\N
50275K15600ZB	CB150R StreetFire K15M (2018 - 2021)	2 kg	Merah	\N
83751K46N00ZE	Vario 110 FI (2014 - 2015)	0.8 kg	Biru	\N
83750K46N00ZE	Vario 110 FI (2014 - 2015)	0.8 kg	Biru	\N
83710K15600FMB	CB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
83610K15600FMB	CB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
50270K15600ZD	CB150R StreetFire K15M (2018 - 2021)	0.6 kg	Hitam	\N
83600K46N00RSW	Vario 110 eSP (2015 - 2019)	6 kg	Putih	\N
50260K15600MGB	CB150R StreetFire K15M (2018 - 2021)	2 kg	Hitam	\N
54303K16900FMB	Scoopy FI K16G (2013 - 2015)	6 kg	Hitam	\N
17235K46N20	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nScoopy eSP K93 (2017 - 2020)\nVario 110 eSP (2015 - 2019)	0.5 kg	Hitam	\N
64601K59A70ZS	Vario 150 eSP K59J (2018 - 2022)	4 kg	Silver	\N
64301K59A70ZL	Vario 150 eSP K59J (2018 - 2022)	3 kg	Merah	\N
81141K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Hitam	23 cmx 15 cmx 9 cm
17546K84901ZB	CRF150L K84 (2017 - Sekarang)	6 kg	Hitam, Merah, Putih	\N
83610K15920FMB	CB150R StreetFire K15G (2015 - 2018)	3 kg	Hitam	\N
64520K97T00ZA	PCX 150 K97 (2017 - 2021)	0.7 kg	Silver	\N
81200K61900	BeAT POP eSP K61 (2014 - 2019)	1.3 kg	Hitam	\N
64505K97T00YA	PCX 150 K97 (2017 - 2021)	0.2 kg	Putih	\N
83510K97T00YA	PCX 150 K97 (2017 - 2021)	10 kg	Putih	\N
83510K97T00ZX	PCX 150 K97 (2017 - 2021)	10 kg	Merah	\N
53205K61900ZA	BeAT POP eSP K61 (2014 - 2019)	3 kg	Hitam	\N
64311K45N40MGB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Hitam	60 cmx 57 cmx 15 cm
64210K45N50ZA	CBR 150R K45G (2016 - 2018)	5 kg	Hitam, Merah, Oranye, Putih	\N
64520KVY900	BeAT Karburator KVY (2008 - 2012)	5 kg	Hitam	\N
50400K56N00ZB	Sonic 150R K56 (2015 - Sekarang)	2 kg	Silver	\N
83630K64N00AGM	CBR 250RR K64 (2016 - 2020)	3 kg	Grey	\N
83620K64N00AGM	CBR 250RR K64 (2016 - 2020)	5 kg	Grey	\N
64620K56N10FMB	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	8 kg	Hitam	\N
61100K56N10ZM	Supra GTR K56F (2016 - 2019)	5 kg	Merah	\N
64201K93N00ZM	Scoopy eSP K93 (2017 - 2020)	3 kg	Biru	\N
53207K93N00VSM	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Silver	\N
83630K64N00WRD	CBR 250RR K64 (2016 - 2020)	4 kg	Merah	\N
64201K93N00ZL	Scoopy eSP K93 (2017 - 2020)	3 kg	Hijau	\N
83500K93N00ZM	Scoopy eSP K93 (2017 - 2020)	6 kg	Putih	\N
64440K56N00NOR	Sonic 150R K56 (2015 - Sekarang)	4 kg	Oranye	\N
64210K64N00AGM	CBR 250RR K64 (2016 - 2020)	3 kg	Silver	\N
64440K56N00WRD	Sonic 150R K56 (2015 - Sekarang)	5 kg	Merah	\N
64420K56N00RSW	Sonic 150R K56 (2015 - Sekarang)	4 kg	Putih	\N
64620K56N10MIB	Supra GTR K56F (2016 - 2019)	6 kg	Biru	\N
61100K56N10ZA	Supra GTR K56F (2016 - 2019)	5 kg	Merah	\N
64341K45N40ZB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	3 kg	Hitam	\N
64421K45N40ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Hitam	\N
83131K45N40ZC	CBR 150R K45G (2016 - 2018)	0.4 kg	Putih	\N
64321K45N40ZB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Hitam	\N
83131K45N40ROW	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.4 kg	Merah, Putih	\N
83500K59A10MGB	\N	5 kg	Hitam	\N
83500K59A10PFW	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	7 kg	Putih	\N
53204K59A10FMB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.3 kg	Hitam	\N
81251KYT900	Scoopy Karburator KYT (2010 - 2013)	1.2 kg	Hitam	35 cmx 25 cmx 8 cm
64200K45A60ZB	CBR 150R K45R (2021 - Sekarang)	5.2 kg	Merah	45 cmx 47 cmx 15 cm
6434AK16A00	Scoopy FI K16G (2013 - 2015)	11 kg	Hitam	65 cmx 40 cmx 25 cm
81141K2FN10ZL	Scoopy K2F (2020 - Sekarang)	10 kg	Coklat	60 cmx 40 cmx 20 cm
64510KYZ900	Supra X 125 Helm-In FI (2011 - 2018)\nSupra X 125 Helm-in Karburator (2011)	5 kg	Hitam	25 cmx 20 cmx 10 cm
61110K2VN10ZG	Vario 125 eSP K60R (2018 - 2022)	3 kg	Merah	37 cmx 20 cmx 22 cm
81131K2VN30ZK	Vario 125 eSP K2V (2022 - Sekarang)	3 kg	Biru	40 cmx 30 cmx 14 cm
64301K1AN00MSG	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Hijau	47 cmx 39 cmx 40 cm
83610K84620ZB	CRF150L K84 (2017 - Sekarang)	3 kg	Hitam	\N
64501K2VN30VRD	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Merah	36 cmx 36 cmx 10 cm
64421K2FN00ZL	Scoopy K2F (2020 - Sekarang)	3 kg	Cream	65 cmx 15 cmx 5 cm
53208K2VN30FMB	Vario 125 eSP K2V (2022 - Sekarang)	0.2 kg	Hitam	24 cmx 20 cmx 8 cm
83600K93N00ZP	Scoopy eSP K93 (2017 - 2020)	8 kg	Merah	\N
83510K0WNA0MGB	ADV 160 (2022 - Sekarang)	4 kg	Hitam	80 cmx 40 cmx 15 cm
83685K64NA0ZA	CBR 250RR K64 (2016 - 2020)	0.875 kg	Hitam	35 cmx 30 cmx 5 cm
50280KYE940	Mega Pro FI (2014 - 2018)	2.2 kg	Hitam	45 cmx 29 cmx 10 cm
64211K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	5.2 kg	Merah	45 cmx 47 cmx 15 cm
83610K0WNA0PFW	ADV 160 (2022 - Sekarang)	4 kg	Putih	80 cmx 20 cmx 15 cm
64502K0WNA0ZL	ADV 160 (2022 - Sekarang)	12 kg	Hitam	65 cmx 50 cmx 20 cm
64337K0WNA0ZB	ADV 160 (2022 - Sekarang)	0.55 kg	Hitam	30 cmx 21 cmx 5 cm
83700K0WNA0	ADV 160 (2022 - Sekarang)	2 kg	Hitam	60 cmx 20 cmx 10 cm
83610K0WNA0MSR	ADV 160 (2022 - Sekarang)	4 kg	Merah	80 cmx 40 cmx 15 cm
64400K64NA0ZB	CBR 250RR K64 (2016 - 2020)	12 kg	Hitam	\N
64220K64NA0ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.5 kg	Hitam, Merah	40 cmx 30 cmx 5 cm
81130K2FN00ZL	Scoopy K2F (2020 - Sekarang)	0.3 kg	Hitam	22 cmx 15 cmx 5 cm
83500K2FN00ASB	Scoopy K2F (2020 - Sekarang)	8 kg	Hitam	80 cmx 38 cmx 15 cm
50410K2FN00ZF	Scoopy K2F (2020 - Sekarang)	1.5 kg	Silver	32 cmx 28 cmx 8 cm
64202K2FN00ZR	Scoopy K2F (2020 - Sekarang)	2 kg	Hitam	60 cmx 20 cmx 10 cm
64431K2SN00ZM	Vario 160 K2S (2022 - Sekarang)	0.75 kg	Hitam	36 cmx 20 cmx 6 cm
64431K2FN00ZP	Scoopy K2F (2020 - Sekarang)	3 kg	Putih	60 cmx 16 cmx 5 cm
64432K1ZJ10ZU	PCX 160 K1Z (2021 - Sekarang)	10 kg	Putih	90 cmx 40 cmx 18 cm
83600K2FN00MPC	Scoopy K2F (2020 - Sekarang)	8 kg	Putih	80 cmx 38 cmx 15 cm
53209K2SN10ZH	Vario 160 K2S (2022 - Sekarang)	0.08 kg	Putih	19 cmx 8 cmx 4 cm
5070AKYZ900	Supra X 125 Helm-in Karburator (2011)	0.3 kg	Hitam	28 cmx 27 cmx 4 cm
64211K3BN00ZA	CB150X (2021 - Sekarang)	0.435 kg	Silver	29 cmx 18 cmx 5 cm
53206K2SN10ZA	Vario 160 K2S (2022 - Sekarang)	2 kg	Hitam	32 cmx 25 cmx 15 cm
81265K2SN00	Vario 160 K2S (2022 - Sekarang)	0.05 kg	Hitam	18 cmx 10 cmx 2 cm
81253K2SN00	Stylo 160 (2024 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.05 kg	Coklat	13 cmx 9 cmx 5 cm
83610K1ZJ10ASB	PCX 160 K1Z (2021 - Sekarang)	11 kg	Hitam	108 cmx 30 cmx 20 cm
84100K1ZJ10	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	6 kg	Hitam	55 cmx 45 cmx 15 cm
64432K2SN00ZK	Vario 160 K2S (2022 - Sekarang)	0.7 kg	Merah	38 cmx 22 cmx 5 cm
64451K3BN00	CB150X (2021 - Sekarang)	10 kg	Hitam	52 cmx 16 cmx 75 cm
64431K2SN00ZL	Vario 160 K2S (2022 - Sekarang)	0.6 kg	Putih	38 cmx 22 cmx 5 cm
64305K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	2 kg	Biru	41 cmx 48 cmx 7 cm
64250K3BN00	CB150X (2021 - Sekarang)	2 kg	Hitam	23 cmx 34 cmx 14 cm
83510K1ZJ10ASB	PCX 160 K1Z (2021 - Sekarang)	11 kg	Hitam	108 cmx 30 cmx 20 cm
81142K2SN00ZM	Vario 160 K2S (2022 - Sekarang)	5.5 kg	Hitam	50 cmx 38 cmx 17 cm
83600K2FN00FMB	Scoopy K2F (2020 - Sekarang)	8 kg	Hitam	80 cmx 38 cmx 15 cm
64420K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Hitam	19 cmx 8 cmx 3 cm
84152K97T00YX	PCX 150 K97 (2017 - 2021)	0.3 kg	Hitam	15 cmx 15 cmx 4 cm
80151K2FN00ZL	Scoopy K2F (2020 - Sekarang)	6 kg	Hitam	45 cmx 40 cmx 20 cm
64502K0WN01ZA	ADV 150 (2019 - 2022)	12 kg	Coklat	65 cmx 50 cmx 20 cm
64441K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	5 kg	Hitam	\N
83121K45NL0ZE	CBR 150R K45R (2021 - Sekarang)	6 kg	Hitam	\N
64421K45NL0	CBR 150R K45R (2021 - Sekarang)	3 kg	Hitam	\N
64400K45NZ0ZA	CBR 150R K45R (2021 - Sekarang)	6 kg	\N	\N
81141K93N00ZX	Scoopy eSP K93 (2017 - 2020)	8 kg	\N	\N
64301K1AN00MNB	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Biru	47 cmx 39 cmx 40 cm
35191K27V01	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nPCX 150 CBU K36J (2014 - 2017)\nPCX 160 K1Z (2021 - Sekarang)\nScoopy eSP K16R (2015 - 2017)\nScoopy eSP K93 (2017 - 2020)\nScoopy FI K16G (2013 - 2015)\nScoopy K2F (2020 - Sekarang)\nSupra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)\nVario 110 FI (2014 - 2015)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60 (2015 - 2018)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59 (2015 - 2018)	1 kg	Hitam	\N
83111K45N40ZE	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Hitam	\N
64202K2FN00YF	Scoopy K2F (2020 - Sekarang)	2 kg	Silver	60 cmx 20 cmx 10 cm
64431K97T00YK	PCX 150 K97 (2017 - 2021)	5 kg	Grey	\N
80115K0JN00ZA	Genio (2019 - 2022)	0.5 kg	Hitam	\N
17245K1AN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)	3 kg	Hitam	\N
64460K0JN00ZB	Genio (2019 - 2022)	3 kg	Hitam	\N
77340K0WN00ZA	ADV 150 (2019 - 2022)	2 kg	Hitam	\N
81134K93N00ZY	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Hitam	\N
83610K0WN00MGB	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
83510K0WN00MGB	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
81140K0WN00ZB	ADV 150 (2019 - 2022)	3 kg	Silver	\N
64202K0JN00ZG	Genio (2019 - 2022)	3 kg	Hitam	\N
64202K0JN00ZA	Genio (2019 - 2022)	3 kg	Coklat	\N
81131K0JN00ZB	Genio (2019 - 2022)	5 kg	Merah	\N
81131K0JN00ZE	Genio (2019 - 2022)	5 kg	Hitam	\N
64201K0JN00ZE	Genio (2019 - 2022)	3 kg	Hitam	\N
61100K0JN00MGB	Genio (2019 - 2022)	5 kg	Hitam	\N
80151K0JN00ZB	Genio (2019 - 2022)	3 kg	Hitam	\N
61355K56NG0ZA	Sonic 150R K56 (2015 - Sekarang)	0.8 kg	Merah	\N
64750K56N00ZA	Sonic 150R K56 (2015 - Sekarang)	2 kg	Hitam	\N
64440K45NH0ZA	CBR 150R K45N (2018 - 2020)	3 kg	Hitam	\N
64330K64N00FMB	CBR 250RR K64 (2016 - 2020)	8 kg	Hitam	\N
77210K18960FMB	CB150 Verza (2018 - Sekarang)	4 kg	Hitam	\N
61100K64N00ZE	CBR 250RR K64 (2016 - 2020)	5 kg	Hitam	\N
50260K18960PFR	CB150 Verza (2018 - Sekarang)	1.5 kg	Merah	\N
83750K46N00ZK	Vario 110 eSP (2015 - 2019)	0.5 kg	Merah	\N
83751K46N00ZC	Vario 110 FI (2014 - 2015)	0.8 kg	Hitam	\N
61100K46N00ZG	Vario 110 eSP (2015 - 2019)	4 kg	Grey	\N
50260K15600MSR	CB150R StreetFire K15M (2018 - 2021)	2.5 kg	Merah	\N
83750K46N00ZH	Vario 110 eSP (2015 - 2019)	0.8 kg	Putih	\N
64301K46N00MAG	Vario 110 eSP (2015 - 2019)	8 kg	Grey	\N
50265K15600MSR	CB150R StreetFire K15M (2018 - 2021)	2.5 kg	Merah	\N
81131K59A70ZR	Vario 125 eSP K60R (2018 - 2022)	1.5 kg	Hitam	\N
64501K59A70ZM	Vario 125 eSP K60R (2018 - 2022)	8 kg	Merah	\N
84100K59A70ZH	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	2 kg	Hitam	\N
81131K59A70ZP	Vario 150 eSP K59J (2018 - 2022)	3 kg	Putih	\N
64430K64N00NOR	CBR 250RR K64 (2016 - 2020)	12 kg	Oranye	\N
81142K93N00ZH	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Merah	\N
64601K46N00RSW	Vario 110 eSP (2015 - 2019)	3 kg	Putih	\N
64510K97T00ZA	PCX 150 K97 (2017 - 2021)	0.7 kg	Silver	\N
81137K97T00ZD	PCX 150 K97 (2017 - 2021)	0.1 kg	Hitam	\N
84151K97T00YA	PCX 150 K97 (2017 - 2021)	7 kg	Putih	\N
64432K97T00ZX	PCX 150 K97 (2017 - 2021)	12 kg	Gold	\N
64201K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	3 kg	Putih	\N
64431K97T00ZX	PCX 150 K97 (2017 - 2021)	10 kg	Gold	\N
61100K56N10ZL	Supra GTR K56F (2016 - 2019)	5 kg	Oranye	\N
81131KZR600ZK	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	6 kg	Hitam	\N
81131KVY900	BeAT Karburator KVY (2008 - 2012)	4 kg	Hitam	\N
64211K45N40ZE	CBR 150R K45G (2016 - 2018)	3 kg	Putih	\N
6433AK41N00	Supra X 125 FI New (2014 - Sekarang)	12 kg	Hitam	\N
83600K59A10ZJ	Vario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
83620K64N00WRD	CBR 250RR K64 (2016 - 2020)	3 kg	Merah	\N
83600K93N00ZM	Scoopy eSP K93 (2017 - 2020)	6 kg	Putih	\N
83610K56N00WRD	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
83510K56N10CPR	Supra GTR K56F (2016 - 2019)	8 kg	Merah	\N
83620K56N00SMM	Sonic 150R K56 (2015 - Sekarang)	5 kg	Magenta / Ungu / Pink	\N
53208K56N10ZE	Supra GTR K56F (2016 - 2019)	0.5 kg	Putih	\N
53208K56N10ZD	Supra GTR K56F (2016 - 2019)	0.5 kg	Hitam	\N
64441K45N40ZB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	3 kg	Hitam	\N
83131K45N40ZB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.4 kg	Hitam	\N
64311K45N40ZB	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Putih	60 cmx 57 cmx 15 cm
61100K59A10CSR	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Merah	\N
6431AKZR600ZD	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	5 kg	Hitam	55 cmx 40 cmx 14 cm
83611KCJ660	Tiger Revolution A (2006 - 2012)\nTiger Revolution B (2010 - 2012)	0.2 kg	Silver	20 cmx 10 cmx 3 cm
81144K0JN60ZA	Genio K0JN (2022 - Sekarang)	0.04 kg	Coklat	5 cmx 4 cmx 2 cm
80100KEV880	Supra (1997 - 2002)\nSupra FIT (2006 - 2007)	8 kg	Hitam	80 cmx 40 cmx 15 cm
81141K2FN80ZG	Scoopy K2F (2020 - Sekarang)	14 kg	Hitam	69 cmx 44 cmx 29 cm
64470K07900ZA	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nSupra X 125 FI New (2014 - Sekarang)	0.2 kg	Hitam	48 cmx 7 cmx 5 cm
64201K2FN00ZL	Scoopy K2F (2020 - Sekarang)	3 kg	Cream	60 cmx 16 cmx 5 cm
64360K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4.5 kg	Hitam	82 cmx 40 cmx 8 cm
83630K64NP0ZD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Merah	50 cmx 25 cmx 15 cm
83521K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.83 kg	Hitam	48 cmx 13 cmx 8 cm
64330K64NP0WRD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.5 kg	Merah	55 cmx 30 cmx 20 cm
64301K2VN30ZL	Vario 125 eSP K2V (2022 - Sekarang)	8 kg	Hitam	55 cmx 52 cmx 15 cm
64201K2FN00YA	Scoopy K2F (2020 - Sekarang)	1.5 kg	Oranye	59 cmx 19 cmx 7 cm
61311K15920	CB150R StreetFire K15 (2012 - 2015)\nCB150R StreetFire K15G (2015 - 2018)	0.4 kg	Hitam	22 cmx 20 cmx 10 cm
83650K2FN00MSG	Scoopy K2F (2020 - Sekarang)	0.25 kg	Hijau	18 cmx 12 cmx 5 cm
64460K2FN80ZB	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	30 cmx 25 cmx 5 cm
64431K2FN00YM	Scoopy K2F (2020 - Sekarang)	3 kg	Hijau	65 cmx 15 cmx 5 cm
64421K2FN00YL	Scoopy K2F (2020 - Sekarang)	3 kg	Hijau	65 cmx 15 cmx 5 cm
83750K2FN00YC	Scoopy K2F (2020 - Sekarang)	0.4 kg	Hijau	20 cmx 15 cmx 5 cm
83600K2FN00YE	Scoopy K2F (2020 - Sekarang)	8 kg	Hijau	80 cmx 36 cmx 15 cm
64202K0JN00MJB	Genio (2019 - 2022)	2 kg	Coklat	60 cmx 20 cmx 10 cm
83510K0WNA0ASB	ADV 160 (2022 - Sekarang)	4 kg	Hitam	80 cmx 20 cmx 15 cm
17546K84600ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Merah	55 cmx 25 cmx 15 cm
81136K2VN30	Vario 125 eSP K2V (2022 - Sekarang)	0.1 kg	Hitam	18 cmx 15 cmx 9 cm
83660K84600ZA	CRF150L K84 (2017 - Sekarang)	1.5 kg	Putih	55 cmx 23 cmx 7 cm
80103KSPB00	Mega Pro New (2010 - 2014)	0.05 kg	Hitam	10 cmx 7 cmx 4 cm
83510K0WNA0PFW	ADV 160 (2022 - Sekarang)	4 kg	Putih	80 cmx 20 cmx 15 cm
83750K0WNA0	ADV 160 (2022 - Sekarang)	3 kg	Hitam	37 cmx 37 cmx 5 cm
83500K2FN00ZX	Scoopy K2F (2020 - Sekarang)	8 kg	Hitam	80 cmx 38 cmx 15 cm
64502K0WNA0ZG	ADV 160 (2022 - Sekarang)	12 kg	Merah	65 cmx 50 cmx 20 cm
80115KZR600ZB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.074 kg	Hitam	20 cmx 12 cmx 5 cm
19610K0JN01	BeAT dan BeAT Street K1A (2020 - 2024)\nGenio (2019 - 2022)\nScoopy K2F (2020 - Sekarang)	2 kg	Hitam	25 cmx 18 cmx 8 cm
83510K84960ZA	CRF150L K84 (2017 - Sekarang)	3 kg	Hitam	50 cmx 33 cmx 10 cm
83500K2FN00MJB	Scoopy K2F (2020 - Sekarang)	8 kg	Coklat	80 cmx 38 cmx 15 cm
81130K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	0.3 kg	Cream	22 cmx 15 cmx 5 cm
83500K59A10ZL	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
83141K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	1 kg	Merah	37 cmx 21 cmx 7 cm
64370K47N00ZA	Blade 125 FI K47 (2014 - 2018)	0.2 kg	Hitam	10 cmx 10 cmx 5 cm
83685K64NA0ZB	CBR 250RR K64 (2016 - 2020)	1 kg	Hitam	\N
83675K64NA0ZB	CBR 250RR K64 (2016 - 2020)	1 kg	Hitam	\N
64200K64NA0ZB	CBR 250RR K64 (2016 - 2020)	3.5 kg	Hitam	55 cmx 44 cmx 8 cm
61100K84900ZC	CRF150L K84 (2017 - Sekarang)	5 kg	Putih	60 cmx 18 cmx 20 cm
61311K15710	CB150R StreetFire K15P (2021 - Sekarang)	1.3 kg	Hitam	30 cmx 26 cmx 10 cm
81134K2FN00ZV	Scoopy K2F (2020 - Sekarang)	0.05 kg	Coklat	10 cmx 9 cmx 2 cm
64405K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	0.15 kg	Hitam	5 cmx 5 cmx 2 cm
86649K93NB0ZC	Scoopy eSP K93 (2017 - 2020)	0.02 kg	Hitam, Merah	10 cmx 5 cmx 5 cm
84151K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	4 kg	Hitam	60 cmx 40 cmx 10 cm
83650K64N00ZK	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.15 kg	Hitam	38 cmx 20 cmx 5 cm
53208K2SN00ZC	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 9 cmx 3 cm
53209K2SN00ZC	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 9 cmx 3 cm
61100K1ZN20ASB	PCX 160 K1Z (2021 - Sekarang)	5.2 kg	Hitam	50 cmx 25 cmx 25 cm
61100K2SN00MGB	Vario 160 K2S (2022 - Sekarang)	3 kg	Hitam	37 cmx 20 cmx 22 cm
64420K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Biru	19 cmx 8 cmx 5 cm
64341K3BN00ZA	CB150X (2021 - Sekarang)	2 kg	Silver	47 cmx 18 cmx 15 cm
64305K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	2 kg	Merah	41 cmx 48 cmx 7 cm
64200K45NZ0ZB	CBR 150R K45R (2021 - Sekarang)	5.2 kg	Merah	45 cmx 47 cmx 15 cm
83600K2FN00ASB	Scoopy K2F (2020 - Sekarang)	8 kg	Hitam	80 cmx 38 cmx 15 cm
83510K84970ZA	CRF150L K84 (2017 - Sekarang)	3 kg	Hijau	50 cmx 33 cmx 10 cm
83510K1ZJ10MIB	PCX 160 K1Z (2021 - Sekarang)	11 kg	Biru	108 cmx 30 cmx 20 cm
83510K1ZJ10MGB	PCX 160 K1Z (2021 - Sekarang)	11 kg	Hitam	108 cmx 30 cmx 20 cm
81140K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	1 kg	Hitam	35 cmx 21 cmx 10 cm
83600K2SN00MGB	Vario 160 K2S (2022 - Sekarang)	5 kg	Hitam	80 cmx 20 cmx 15 cm
17556K84960ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	\N
11341K1ZJ10	ADV 160 (2022 - Sekarang)\nPCX 160 K1Z (2021 - Sekarang)	5 kg	Silver	50 cmx 20 cmx 12 cm
84152K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Putih	15 cmx 15 cmx 4 cm
81137K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	0.1 kg	Biru	15 cmx 8 cmx 4 cm
83610K1ZJ10MSR	PCX 160 K1Z (2021 - Sekarang)	4 kg	Merah	40 cmx 20 cmx 10 cm
17225K1ZN80	PCX 160 e:HEV (2021 - 2023)	1.5 kg	Hitam	45 cmx 20 cmx 9 cm
64431K2FN00ZM	Scoopy K2F (2020 - Sekarang)	3 kg	Biru	60 cmx 16 cmx 5 cm
5060AKYZ900	Supra X 125 Helm-in Karburator (2011)	0.3 kg	Hitam	26 cmx 19 cmx 4 cm
53207K2FN00MCS	Scoopy K2F (2020 - Sekarang)	0.2 kg	Silver	\N
61100K84900ZE	CRF150L K84 (2017 - Sekarang)	10 kg	Hitam	\N
80110K84920ZE	CRF150L K84 (2017 - Sekarang)	1 kg	Merah	\N
81134K2FN00ZN	Scoopy K2F (2020 - Sekarang)	0.4 kg	Silver	\N
81134K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	0.4 kg	Cream	\N
83121K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	5 kg	Putih	\N
83121K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	\N
83141K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	4 kg	Hitam	\N
83750K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
50534K84900	CRF150L K84 (2017 - Sekarang)	0.05 kg	\N	7 cmx 5 cmx 2 cm
64411K45N40ZE	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	7 kg	Hitam	\N
64501K0WN01ZD	ADV 150 (2019 - 2022)	12 kg	Hitam	65 cmx 50 cmx 20 cm
64333K1AN00	BeAT dan BeAT Street K1A (2020 - 2024)	2 kg	Hitam	\N
53205K1AN00ZQ	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Biru	\N
53173GFM900	BeAT FI CBS K25 (2012 - 2014)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nVario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)\nVario Techno 125 FI CBS ISS (2013 - 2015)	0.5 kg	Hitam	\N
50400K18900ZB	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	6 kg	Grey	\N
53280K59A70ZB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Hitam	\N
64211K45NA0ZG	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	2 kg	Hitam	\N
53206KZLA00ZA	Spacy Karburator (2011 - 2013)	3 kg	Hitam	\N
8010BK18900	Verza 150 (2013 - 2018)	4 kg	Hitam	\N
64432K97T00YK	PCX 150 K97 (2017 - 2021)	7 kg	Silver	\N
61100K97T00YJ	PCX 150 K97 (2017 - 2021)	6 kg	Silver	\N
81142K93N00ZK	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Hitam	\N
64502K96V00YB	PCX 150 K97 (2017 - 2021)	10 kg	Coklat	\N
83600K1AN00FMB	BeAT dan BeAT Street K1A (2020 - 2024)	7 kg	Hitam	\N
53205K1AN00ZB	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Merah	\N
50312K0WN00	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
81132K0WN00	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	3 kg	Hitam	\N
83550K0WN10ZB	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
64340K0JN00ZA	Genio (2019 - 2022)	8 kg	Hitam	\N
83600K0JN00MGB	Genio (2019 - 2022)	8 kg	Hitam	\N
83610K0WN00ARE	ADV 150 (2019 - 2022)	5 kg	Merah	\N
64421K0JN00ZE	Genio (2019 - 2022)	3 kg	Hitam	\N
64350K0WN00ZC	ADV 150 (2019 - 2022)	4 kg	Silver	\N
64202K0JN00ZE	Genio (2019 - 2022)	3 kg	Hitam	\N
64360K0WN00ZB	ADV 150 (2019 - 2022)	4 kg	Putih	\N
61100K0JN00VRD	Genio (2019 - 2022)	3 kg	Merah	\N
64336K0WN00ZC	ADV 150 (2019 - 2022)	3.5 kg	Merah	\N
53205K0JN00ZA	Genio (2019 - 2022)	0.5 kg	Coklat	\N
81141K61900ZA	BeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)	3 kg	Hitam	\N
64501K59A70YC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	6 kg	Biru	\N
81131K59A70YB	Vario 150 eSP K59J (2018 - 2022)	2.5 kg	Coklat	\N
17235KVY900	Scoopy Karburator KYT (2010 - 2013)	2 kg	Hitam	\N
50260K18960INS	CB150 Verza (2018 - Sekarang)	2 kg	Silver	\N
64210K64N00ZB	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	8 kg	Merah	\N
81250KZR600	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	9 kg	Hitam	\N
83710K15600WRD	CB150R StreetFire K15M (2018 - 2021)	1 kg	Merah	\N
61100K46N00ZJ	Vario 110 eSP (2015 - 2019)	3 kg	Grey	\N
83610K15600WRD	CB150R StreetFire K15M (2018 - 2021)	0.6 kg	Merah	\N
83610K15600MSR	CB150R StreetFire K15M (2018 - 2021)	0.6 kg	Merah	\N
64601K46N00ARM	Vario 110 eSP (2015 - 2019)	3 kg	Merah	\N
871X0K25610ZAR	BeAT Sporty eSP K25G (2014 - 2016)	0.6 kg	Hitam	\N
64430K64N00ASB	CBR 250RR K64 (2016 - 2020)	12 kg	Hitam	\N
83600K59A70ZP	Vario 150 eSP K59J (2018 - 2022)	8 kg	Putih	\N
61100K59A70ZK	Vario 150 eSP K59J (2018 - 2022)	5 kg	Silver	\N
83500K25900CSR	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	8 kg	Merah	\N
83500K59A70ZL	Vario 150 eSP K59J (2018 - 2022)	6 kg	Merah	\N
8010AK41N00ZA	Supra X 125 FI New (2014 - Sekarang)	13 kg	Hitam	\N
81139K97T00ZX	PCX 150 K97 (2017 - 2021)	1 kg	Merah	\N
81141K97T00ZL	PCX 150 K97 (2017 - 2021)	0.5 kg	Merah	\N
81138K97T00ZT	PCX 150 K97 (2017 - 2021)	3 kg	Merah	\N
53205K1AN20ZB	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
64505K97T00ZX	PCX 150 K97 (2017 - 2021)	0.2 kg	Merah	\N
61100K97T00ZR	PCX 150 K97 (2017 - 2021)	8 kg	Hitam	\N
64503K97T00YA	PCX 150 K97 (2017 - 2021)	0.2 kg	Putih	\N
61316K36N10	PCX 150 CBU K36J (2014 - 2017)\nPCX 150 K97 (2017 - 2021)\nPCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.7 kg	Hitam	\N
81141K97T00ZD	PCX 150 K97 (2017 - 2021)	0.3 kg	Hitam	\N
61100K61900ZA	BeAT POP eSP K61 (2014 - 2019)	5 kg	Merah	\N
61100K61900ZB	BeAT POP eSP K61 (2014 - 2019)	5 kg	Putih	\N
64301K61900VBM	BeAT POP eSP K61 (2014 - 2019)	10 kg	Biru	\N
64320K15930ZB	CB150R StreetFire K15G (2015 - 2018)	2 kg	Putih	\N
80101K84900	CRF150L K84 (2017 - Sekarang)	7 kg	Hitam	\N
64511K45N40ZD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.3 kg	Hitam	\N
6431BK16A40ZA	Scoopy eSP K16R (2015 - 2017)	11 kg	Coklat	\N
64450KYZ900ZD	Supra X 125 Helm-in Karburator (2011)	12 kg	Silver	\N
61100K16A00ZD	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	5 kg	Hitam	\N
64301K61900FMB	BeAT POP eSP K61 (2014 - 2019)	6 kg	Hitam	\N
53208K59A10WRD	Vario 150 eSP K59 (2015 - 2018)	2 kg	Merah	\N
83600K59A10ZM	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
83500K59A10RSW	Vario 125 eSP K60 (2015 - 2018)	5 kg	Putih	\N
64610K56N10FMB	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	8 kg	Hitam	\N
64321K45N40ZC	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Merah	\N
53206K93N00ZH	Scoopy eSP K93 (2017 - 2020)	0.6 kg	Merah	\N
83600K93N00ZA	Scoopy eSP K93 (2017 - 2020)	9 kg	Cream	\N
83650K93N00ZL	Scoopy eSP K93 (2017 - 2020)	0.25 kg	Putih	20 cmx 15 cmx 4 cm
64430K64N00WRD	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	12 kg	Merah	\N
83610K56N00MGB	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
64340K56N00RSW	Sonic 150R K56 (2015 - Sekarang)	5 kg	Putih	\N
64340K56N00FMB	Sonic 150R K56 (2015 - Sekarang)	5 kg	Hitam	\N
64320K56N00FMB	Sonic 150R K56 (2015 - Sekarang)	7 kg	Hitam	\N
64490K56N10DSM	Supra GTR K56F (2016 - 2019)	3 kg	Silver	\N
64301K56N10ZA	Supra GTR K56F (2016 - 2019)	6 kg	Merah	\N
53205K81N00SMM	BeAT Sporty eSP K81 (2016 - 2020)	4 kg	Magenta / Ungu / Pink	\N
64511K45N40PFW	CBR 150R K45G (2016 - 2018)	0.4 kg	Putih	\N
83750K59A10ZN	Vario 150 eSP K59 (2015 - 2018)	0.4 kg	Coklat	\N
64301K59A10ZL	Vario 150 eSP K59 (2015 - 2018)	3 kg	Biru	\N
83760K3VN00ZF	Stylo 160 (2024 - Sekarang)	0.075 kg	Hitam	18 cmx 5 cmx 5 cm
64502K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	18 kg	Silver	90 cmx 62 cmx 20 cm
81134K16900YG	Scoopy eSP K16R (2015 - 2017)	0.1 kg	Putih	12 cmx 8 cmx 3 cm
64301K1AN00MJB	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Coklat	47 cmx 39 cmx 40 cm
64202K2FN00ZL	Scoopy K2F (2020 - Sekarang)	3 kg	Cream	60 cmx 20 cmx 10 cm
83750K16900ZE	Scoopy FI K16G (2013 - 2015)	2 kg	Hitam	33 cmx 28 cmx 16 cm
83640KYT940	Scoopy Karburator KYT (2010 - 2013)	0.1 kg	Hitam	22 cmx 8 cmx 4 cm
81142K0JN60ZB	Genio K0JN (2022 - Sekarang)	0.15 kg	Hitam	10 cmx 8 cmx 4 cm
81144K0JN60ZB	Genio K0JN (2022 - Sekarang)	0.02 kg	Hitam	3 cmx 2 cmx 2 cm
81141K16A40IBM	Scoopy eSP K16R (2015 - 2017)	10 kg	Coklat	60 cmx 40 cmx 20 cm
8010AKZR600	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	8.5 kg	Hitam	80 cmx 42 cmx 15 cm
64301KZR600PFW	Vario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	9 kg	Putih	60 cmx 50 cmx 18 cm
64301K16A00FMB	Scoopy FI K16G (2013 - 2015)	4 kg	Hitam	45 cmx 25 cmx 15 cm
81139K97T00ZN	PCX 150 K97 (2017 - 2021)	0.7 kg	Hitam	\N
61000K45A90ZB	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	50 cmx 30 cmx 20 cm
64300K45A60ZA	CBR 150R K45R (2021 - Sekarang)	8 kg	Merah	60 cmx 57 cmx 15 cm
64502K1ZJ10YH	PCX 160 K1Z (2021 - Sekarang)	18 kg	Merah	90 cmx 62 cmx 20 cm
8010AKTM850	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	16 kg	Hitam	80 cmx 40 cmx 30 cm
81141K2FN00ZN	Scoopy K2F (2020 - Sekarang)	10 kg	Hitam	60 cmx 40 cmx 20 cm
64475K07900ZA	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nSupra X 125 FI New (2014 - Sekarang)	0.2 kg	Hitam	48 cmx 7 cmx 5 cm
64431K2FN00ZK	Scoopy K2F (2020 - Sekarang)	3 kg	Cream	65 cmx 15 cmx 5 cm
64380K47N00ZA	Blade 125 FI K47 (2014 - 2018)	0.4 kg	Hitam	50 cmx 10 cmx 5 cm
83600K1AN00MBS	BeAT dan BeAT Street K1A (2020 - 2024)	4 kg	Silver	82 cmx 27 cmx 10 cm
64600K64NP0ZA	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	10 kg	Hitam	80 cmx 50 cmx 15 cm
64500K64NP0ZA	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	10 kg	Hitam	80 cmx 50 cmx 15 cm
64200K45A50ZB	CBR 150R K45R (2021 - Sekarang)	5.2 kg	Hitam	45 cmx 47 cmx 15 cm
53205K1AN00ZU	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hijau	55 cmx 30 cmx 15 cm
81131K2VN30ZL	Vario 125 eSP K2V (2022 - Sekarang)	3 kg	Hitam	40 cmx 30 cmx 14 cm
64225K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.3 kg	Hitam	22 cmx 15 cmx 7 cm
83670K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.6 kg	Hitam	40 cmx 12 cmx 8 cm
77237K56N00	Sonic 150R K56 (2015 - Sekarang)	0.02 kg	Hitam	10 cmx 6 cmx 4 cm
64501K1ZJ10YJ	PCX 160 K1Z (2021 - Sekarang)	18 kg	Biru	90 cmx 62 cmx 20 cm
64301K2VN30ZM	Vario 125 eSP K2V (2022 - Sekarang)	8 kg	Hitam	55 cmx 52 cmx 15 cm
64210K64NP0ZD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.2 kg	Merah	45 cmx 47 cmx 15 cm
64100K64NP0ZA	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2 kg	Putih	36 cmx 25 cmx 5 cm
64500K2SH00ZC	Vario 160 K2S (2022 - Sekarang)	2 kg	Putih	40 cmx 28 cmx 7 cm
83500K2VN30MGB	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Hitam	85 cmx 25 cmx 15 cm
64601K2VN30MIB	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Biru	36 cmx 36 cmx 10 cm
64301K2FN00YH	Scoopy K2F (2020 - Sekarang)	5 kg	Hijau	42 cmx 45 cmx 15 cm
61300K84920ZB	CRF150L K84 (2017 - Sekarang)	3.12 kg	Grey	39 cmx 40 cmx 12 cm
53208K2VN30MIB	Vario 125 eSP K2V (2022 - Sekarang)	0.2 kg	Biru	24 cmx 20 cmx 8 cm
11360K18900	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.261 kg	Hitam	22 cmx 16 cmx 5 cm
50400K18900ZA	Verza 150 (2013 - 2018)	0.8 kg	Silver	30 cmx 25 cmx 10 cm
64421K2FN00YJ	Scoopy K2F (2020 - Sekarang)	3 kg	Hitam	65 cmx 15 cmx 5 cm
64390K47N00	Blade 125 FI K47 (2014 - 2018)	0.15 kg	Hitam	20 cmx 10 cmx 3 cm
61304K56N00ZJ	Sonic 150R K56 (2015 - Sekarang)	0.2 kg	Merah	25 cmx 22 cmx 5 cm
53207K2FN00MPC	Scoopy K2F (2020 - Sekarang)	0.2 kg	Putih	20 cmx 10 cmx 4 cm
80104K25600	BeAT Karburator KVY (2008 - 2012)\nBeAT Sporty eSP K25G (2014 - 2016)	0.1 kg	Hitam	21 cmx 11 cmx 2 cm
64395K47N00	Blade 125 FI K47 (2014 - 2018)	0.15 kg	Hitam	20 cmx 10 cmx 3 cm
37213KZR601	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.005 kg	Hitam	4 cmx 2 cmx 1 cm
64420K3BN00ZC	CB150X (2021 - Sekarang)	4 kg	Merah	50 cmx 48 cmx 10 cm
83610K0WNA0MPC	ADV 160 (2022 - Sekarang)	4 kg	Putih	80 cmx 20 cmx 15 cm
83610K0WNA0ARE	ADV 160 (2022 - Sekarang)	4 kg	Merah	80 cmx 20 cmx 15 cm
64400K0WNA0ZH	ADV 160 (2022 - Sekarang)	12 kg	Merah	65 cmx 50 cmx 20 cm
17546K84620ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hijau, Kuning	55 cmx 25 cmx 15 cm
64336K0WN00ZX	ADV 160 (2022 - Sekarang)	2 kg	Putih	38 cmx 32 cmx 10 cm
64415K0WNA0ZB	ADV 160 (2022 - Sekarang)	0.15 kg	Hitam	10 cmx 5 cmx 2 cm
64421K2FN00YA	Scoopy K2F (2020 - Sekarang)	0.3 kg	Oranye	65 cmx 15 cmx 5 cm
83510K0WNA0MPC	ADV 160 (2022 - Sekarang)	4 kg	Putih	80 cmx 20 cmx 15 cm
83510K0WNA0MSR	ADV 160 (2022 - Sekarang)	4 kg	Merah	80 cmx 40 cmx 15 cm
64501K0WNA0ZH	ADV 160 (2022 - Sekarang)	12 kg	Hitam	65 cmx 50 cmx 20 cm
64320K41N00	Supra X 125 FI New (2014 - Sekarang)	7.7 kg	Hitam	55 cmx 35 cmx 24 cm
83500K2FN00FMB	Scoopy K2F (2020 - Sekarang)	8 kg	Hitam	80 cmx 38 cmx 15 cm
83121K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	\N
80105K59A10	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.05 kg	Hitam	26 cmx 12 cmx 2 cm
53205K1AN00ZP	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Coklat	\N
81260K2SN00	Vario 160 K2S (2022 - Sekarang)	2.3 kg	Hitam	36 cmx 25 cmx 15 cm
83600K59A70YA	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	11.2 kg	Merah	80 cmx 26 cmx 15 cm
61302K15710ZA	CB150R StreetFire K15P (2021 - Sekarang)	0.2 kg	Hitam	24 cmx 10 cmx 5 cm
53208K2SN10ZH	Vario 160 K2S (2022 - Sekarang)	0.15 kg	Putih	20 cmx 9 cmx 3 cm
61100K84900ZF	CRF150L K84 (2017 - Sekarang)	5 kg	Hijau	60 cmx 18 cmx 20 cm
61100K1ZN20MSR	PCX 160 K1Z (2021 - Sekarang)	5 kg	\N	50 cmx 30 cmx 20 cm
61100K64N00ZT	CB150R StreetFire K15P (2021 - Sekarang)	5 kg	Hitam	50 cmx 30 cmx 20 cm
61303K15710ZB	CB150R StreetFire K15P (2021 - Sekarang)	0.1 kg	Hitam	20 cmx 9 cmx 3 cm
53205K1ZJ10	PCX 160 K1Z (2021 - Sekarang)	0.05 kg	Silver	15 cmx 6 cmx 2 cm
53206K2FN00ZU	Scoopy K2F (2020 - Sekarang)	0.3 kg	Grey	20 cmx 15 cmx 5 cm
83160K64NA0ZA	CBR 250RR K64 (2016 - 2020)	6 kg	Hitam	50 cmx 20 cmx 10 cm
64333K2SN00	Vario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	56 cmx 11 cmx 5 cm
84151K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	4 kg	Biru	60 cmx 40 cmx 10 cm
84151K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	4 kg	Hitam	60 cmx 40 cmx 10 cm
83600K2SN00MPC	Vario 160 K2S (2022 - Sekarang)	5.2 kg	Putih	80 cmx 26 cmx 15 cm
83750K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	1.5 kg	Hitam	30 cmx 30 cmx 10 cm
53206K2FN00ZK	Scoopy K2F (2020 - Sekarang)	0.2 kg	Hitam	20 cmx 19 cmx 8 cm
53206K2FN00ZN	Scoopy K2F (2020 - Sekarang)	0.2 kg	Silver	20 cmx 19 cmx 8 cm
53290K59A70ZA	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	2 kg	Hitam	4 cmx 3 cmx 2 cm
61100K0WN00PFW	ADV 150 (2019 - 2022)	5.2 kg	Putih	50 cmx 25 cmx 25 cm
64501K0WN01ZB	ADV 150 (2019 - 2022)	12 kg	Merah	65 cmx 50 cmx 20 cm
64171K3BN00	CB150X (2021 - Sekarang)	0.8 kg	Hitam	52 cmx 15 cmx 5 cm
64431K97T00YY	PCX 150 K97 (2017 - 2021)	10 kg	Hitam	90 cmx 40 cmx 18 cm
64421K2FN00ZP	Scoopy K2F (2020 - Sekarang)	3 kg	Hitam	60 cmx 16 cmx 5 cm
64321K3BN00MGB	CB150X (2021 - Sekarang)	6 kg	Hitam	57 cmx 42 cmx 16 cm
64321K3BN00MSG	CB150X (2021 - Sekarang)	6 kg	Hijau	57 cmx 42 cmx 16 cm
64441K3BN00ZA	CB150X (2021 - Sekarang)	2 kg	Silver	47 cmx 18 cmx 15 cm
64331K45NL0	CBR 150R K45R (2021 - Sekarang)	7.8 kg	Hitam	60 cmx 60 cmx 13 cm
64400K45A40ZA	CBR 150R K45R (2021 - Sekarang)	8 kg	Hitam	\N
83510K1ZJ10MSR	PCX 160 K1Z (2021 - Sekarang)	11 kg	Merah	108 cmx 30 cmx 20 cm
81141K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Putih	23 cmx 15 cmx 9 cm
67110K3BN00ZA	CB150X (2021 - Sekarang)	1.5 kg	Putih	34 cmx 25 cmx 7 cm
64601K59A70YB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	7.5 kg	Merah	50 cmx 45 cmx 20 cm
83510K1ZJ10MDG	PCX 160 K1Z (2021 - Sekarang)	11 kg	Grey	108 cmx 30 cmx 20 cm
11341K97N00	PCX 150 K97 (2017 - 2021)	5 kg	Silver	50 cmx 20 cmx 12 cm
53205K2FN00VBE	Scoopy K2F (2020 - Sekarang)	1 kg	Kuning	22 cmx 20 cmx 15 cm
64305K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	2 kg	Hitam	41 cmx 45 cmx 5 cm
64201K0JN00MJB	Genio (2019 - 2022)	2 kg	Coklat	60 cmx 15 cmx 8 cm
50410K2FN00ZC	Scoopy K2F (2020 - Sekarang)	2 kg	Hitam	30 cmx 27 cm
86103K60B90ZB	Vario 125 eSP K60R (2018 - 2022)	0.1 kg	Hitam	20 cmx 13 cmx 1 cm
53207K2FN00VRD	Scoopy K2F (2020 - Sekarang)	0.2 kg	Merah	\N
61100K2FN00ZM	Scoopy K2F (2020 - Sekarang)	5 kg	\N	56 cmx 25 cmx 18 cm
64301K56N10ZR	Supra GTR K56F (2016 - 2019)	4 kg	Merah	46 cmx 40 cmx 8 cm
81130K2FN00ZN	Scoopy K2F (2020 - Sekarang)	0.3 kg	Silver	22 cmx 15 cmx 5 cm
64321K45NL0	CBR 150R K45R (2021 - Sekarang)	5 kg	Hitam	\N
61100K59A70ZJ	Vario 150 eSP K59J (2018 - 2022)	6 kg	Putih	\N
83750K2FN00ZN	Scoopy K2F (2020 - Sekarang)	1 kg	Biru	\N
83750K2FN00ZK	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
64211K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	6 kg	Hitam	\N
83750K2FN00ZM	Scoopy K2F (2020 - Sekarang)	5 kg	Merah	\N
64501K0WN01ZA	ADV 150 (2019 - 2022)	12 kg	Coklat	65 cmx 50 cmx 20 cm
80160K25900	BeAT FI K25 (2012 - 2014)	0.5 kg	Hitam	\N
64211K45NA0ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	3 kg	Oranye	\N
64502K0WN01ZE	ADV 150 (2019 - 2022)	12 kg	Silver	65 cmx 50 cmx 20 cm
37212K46N01	Vario 110 eSP (2015 - 2019)\nVario 110 FI (2014 - 2015)	1 kg	Silver	\N
17546K84960ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	\N
61100K59A70ZE	Vario 125 eSP K60R (2018 - 2022)	5 kg	Merah	\N
81138K97T00YE	PCX 150 K97 (2017 - 2021)	3 kg	Silver	\N
80105K0JN00ZA	Genio (2019 - 2022)	8 kg	Hitam	\N
64331K0JN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nGenio (2019 - 2022)	0.5 kg	Hitam	\N
77251K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	0.5 kg	Hitam	\N
81137K97T00YE	PCX 150 K97 (2017 - 2021)	0.5 kg	Silver	\N
83510K97T00YJ	PCX 150 K97 (2017 - 2021)	12 kg	Silver	\N
83610K97T00YJ	PCX 150 K97 (2017 - 2021)	12 kg	Silver	\N
83610K97T00YH	PCX 150 K97 (2017 - 2021)	12 kg	Coklat	\N
37102K0WN01	ADV 150 (2019 - 2022)	2 kg	Hitam	\N
64460K0JN00ZA	Genio (2019 - 2022)	4 kg	Coklat	\N
53206K93N00ZS	Scoopy eSP K93 (2017 - 2020)	3 kg	Hitam	\N
17225K0JN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nGenio (2019 - 2022)\nScoopy K2F (2020 - Sekarang)	5 kg	Hitam	\N
64405K56H20ZB	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
83610K0WN00MMB	ADV 150 (2019 - 2022)	5 kg	Coklat	\N
83510K0WN00FMB	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
83510K0WN00DSM	ADV 150 (2019 - 2022)	5 kg	Silver	\N
83750K0JN00MGB	Genio (2019 - 2022)	4 kg	Hitam	\N
64421K0JN00ZG	Genio (2019 - 2022)	3 kg	Hitam	\N
64421K0JN00ZA	Genio (2019 - 2022)	3 kg	Coklat	\N
83500K0JN00MGB	Genio (2019 - 2022)	8 kg	Hitam	\N
64431K0JN00ZE	Genio (2019 - 2022)	3 kg	Hitam	\N
64202K93N00ZX	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
61100K0WN00WRD	ADV 150 (2019 - 2022)	3 kg	Merah	\N
64201K0JN00ZA	Genio (2019 - 2022)	3 kg	Coklat	\N
64301K93N00ZY	Scoopy eSP K93 (2017 - 2020)	5 kg	Merah	\N
64301K0JN00PBL	Genio (2019 - 2022)	9 kg	Hitam	\N
53205K0JN00ZE	Genio (2019 - 2022)	0.5 kg	Hitam	\N
64350K0WN00ZB	ADV 150 (2019 - 2022)	4 kg	Putih	\N
64310K0JN00ZB	Genio (2019 - 2022)	8 kg	Hitam	\N
64410K45NH0ZA	CBR 150R K45G (2016 - 2018)	6 kg	Hitam	\N
83130K45NH0ZB	CBR 150R K45G (2016 - 2018)	0.4 kg	Merah	\N
61305K56NG0ZA	Sonic 150R K56 (2015 - Sekarang)	0.8 kg	Merah	\N
83110K45N50ZA	CBR 150R K45N (2018 - 2020)	4 kg	Putih	\N
64350K59A70ZL	Vario 150 eSP K59J (2018 - 2022)	4 kg	Coklat	\N
80106KZR600	PCX 150 CBU K36J (2014 - 2017)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.4 kg	Hitam	\N
61100K56N10ZR	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	5 kg	Merah	\N
64210K64N00ZK	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Hitam	\N
64490K56N10ZJ	Supra GTR K56F (2016 - 2019)	2 kg	Hitam	\N
64480K56N10ZJ	Supra GTR K56F (2016 - 2019)	2 kg	Hitam	\N
64320K15600RSW	CB150R StreetFire K15M (2018 - 2021)	1.5 kg	Putih	\N
64310K64N00ZA	CBR 250RR K64 (2016 - 2020)	4 kg	Hitam	\N
50270K18960INS	CB150 Verza (2018 - Sekarang)	1.5 kg	Silver	\N
50270K18960PFR	CB150 Verza (2018 - Sekarang)	1.5 kg	Merah	\N
80120K18900	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	4 kg	Hitam	\N
83450K64K00RED	CBR 250RR K64 (2016 - 2020)	4 kg	Merah	\N
83600K46N00VBM	Vario 110 FI (2014 - 2015)	6 kg	Biru	\N
64301K46N00VBM	Vario 110 FI (2014 - 2015)	6 kg	Biru	\N
61100K46N00ZE	Vario 110 FI (2014 - 2015)	3 kg	Biru	\N
83500K46N00MAG	Vario 110 eSP (2015 - 2019)	4 kg	Grey	\N
83750K46N00ZF	Vario 110 eSP (2015 - 2019)	0.5 kg	Merah	\N
83600K46N00VRD	Vario 110 eSP (2015 - 2019)	3 kg	Merah	\N
64501K46N00ARM	Vario 110 eSP (2015 - 2019)	3 kg	Merah	\N
83751K46N00ZG	Vario 110 eSP (2015 - 2019)	0.8 kg	Grey	\N
83600K46N00MAG	Vario 110 eSP (2015 - 2019)	6 kg	Grey	\N
64601K46N00MAG	Vario 110 eSP (2015 - 2019)	3 kg	Grey	\N
64301K46N00RSW	Vario 110 eSP (2015 - 2019)	8 kg	Putih	\N
83600K25900PCB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	4 kg	Biru, Hitam	\N
64501K59A70ZQ	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	8 kg	Putih	\N
81131K59A70ZS	Vario 150 eSP K59J (2018 - 2022)	2 kg	Silver	\N
64350K59A70ZD	Vario 150 eSP K59J (2018 - 2022)	15 kg	Merah	\N
53208K59A70ZM	Vario 150 eSP K59J (2018 - 2022)	3 kg	Putih	\N
53208K59A70ZK	Vario 150 eSP K59J (2018 - 2022)	3 kg	Merah	\N
83500K93N00ZP	Scoopy eSP K93 (2017 - 2020)	8 kg	Merah	\N
17556K84901ZB	CRF150L K84 (2017 - Sekarang)	6 kg	Hitam, Merah, Putih	\N
81139K97T00ZW	PCX 150 K97 (2017 - 2021)	0.5 kg	Gold	\N
64503K97T00ZW	PCX 150 K97 (2017 - 2021)	0.2 kg	Gold	\N
64601K59A10FMB	Vario 125 eSP K60 (2015 - 2018)	4 kg	Hitam	\N
83610K97T00YA	PCX 150 K97 (2017 - 2021)	10 kg	Putih	\N
77237K35V00	ADV 160 (2022 - Sekarang)\nCBR 150R K45G (2016 - 2018)\nCBR 250RR K64 (2016 - 2020)\nForza 250 (2018 - Sekarang)\nPCX 150 K97 (2017 - 2021)\nPCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	0.3 kg	Hitam	\N
83650K93N00ZP	Scoopy eSP K93 (2017 - 2020)	0.2 kg	Coklat	\N
53207K97T00ZA	PCX 150 K97 (2017 - 2021)	1 kg	Hitam	\N
83500K61900RSW	BeAT POP eSP K61 (2014 - 2019)	6 kg	Putih	\N
64301K61900RSW	BeAT POP eSP K61 (2014 - 2019)	10 kg	Putih	\N
61100K61900ZD	BeAT POP eSP K61 (2014 - 2019)	5 kg	Biru	\N
53205K61900RSW	BeAT POP eSP K61 (2014 - 2019)	3 kg	Putih	\N
83600K61900RSW	BeAT POP eSP K61 (2014 - 2019)	6 kg	Putih	\N
53206KYZ900ZJ	Supra X 125 Helm-in Karburator (2011)	3 kg	Hitam	\N
61100K15900ZB	CB150R StreetFire K15 (2012 - 2015)	5 kg	Putih	\N
83450K15900ZA	CB150R StreetFire K15 (2012 - 2015)	2 kg	Putih	\N
81131K59A10ZM	Vario 150 eSP K59 (2015 - 2018)	1.6 kg	Merah	\N
53205KPH730FMB	Karisma (2002 - 2005)	3 kg	Hitam	\N
64301KVB930SBM	Vario 110 CW (2006 - 2014)	8 kg	Biru	\N
50400K03N30	Revo 110 FI (2014 - Sekarang)	2 kg	Hitam	\N
6430AKVB900	Vario 110 CW (2006 - 2014)	3 kg	Hitam	\N
64520K41N00	Supra X 125 FI New (2014 - Sekarang)	0.3 kg	Hitam	\N
83600K59A10ZW	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Merah	\N
61100K61900ZC	BeAT POP eSP K61 (2014 - 2019)	5 kg	Hitam	\N
83600K59A10RSW	Vario 125 eSP K60 (2015 - 2018)	5 kg	Putih	\N
53207K56N10ZM	Supra GTR K56F (2016 - 2019)	0.3 kg	Merah	\N
53208K56N10ZL	Supra GTR K56F (2016 - 2019)	0.3 kg	Merah	\N
83510K56N10FMB	Supra GTR K56F (2016 - 2019)	5 kg	Hitam	\N
83600K59A10ZV	Vario 150 eSP K59 (2015 - 2018)	5 kg	Biru	\N
64431K93N00ZM	Scoopy eSP K93 (2017 - 2020)	3 kg	Biru	\N
64202K93N00ZM	Scoopy eSP K93 (2017 - 2020)	3 kg	Biru	\N
83750K93N00ZG	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Merah	\N
80151K93N00ZL	Scoopy eSP K93 (2017 - 2020)	5 kg	Silver	\N
83750K93N00ZH	Scoopy eSP K93 (2017 - 2020)	1 kg	Putih	\N
77244K16A00	Scoopy eSP K93 (2017 - 2020)	0.2 kg	Hitam	\N
83620K56N00WRD	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
83165K64N00WRD	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Merah	\N
83620K56N00MGB	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
83610K56N00SMM	Sonic 150R K56 (2015 - Sekarang)	5 kg	Magenta / Ungu / Pink	\N
64420K56N00FMB	Sonic 150R K56 (2015 - Sekarang)	4 kg	Hitam	\N
64610K56N10PFW	Supra GTR K56F (2016 - 2019)	8 kg	Putih	\N
53207K56N10ZA	Supra GTR K56F (2016 - 2019)	0.5 kg	Merah	\N
61100K15920ZE	CBR 150R K45G (2016 - 2018)	5 kg	Putih	\N
18355KCJ660	Tiger Revolution B (2010 - 2012)	0.6 kg	Silver	\N
64336K0WN00ZV	ADV 160 (2022 - Sekarang)	2 kg	Coklat	38 cmx 32 cmx 10 cm
83610K1ZJ10MCO	PCX 160 K1Z (2021 - Sekarang)	11 kg	Silver	108 cmx 30 cmx 20 cm
64501K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	18 kg	Silver	90 cmx 62 cmx 20 cm
64501K0WNA0ZJ	ADV 160 (2022 - Sekarang)	12 kg	Coklat	65 cmx 50 cmx 20 cm
64302KZLA00VBM	Spacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)	4 kg	Biru	45 cmx 25 cmx 15 cm
53206KEV880ZA	Supra (1997 - 2002)	3 kg	Hitam	38 cmx 25 cmx 20 cm
81141K0JN60ZB	Genio K0JN (2022 - Sekarang)	6.2 kg	Hitam	46 cmx 41 cmx 20 cm
83540KYT940	Scoopy Karburator KYT (2010 - 2013)	0.1 kg	Hitam	22 cmx 8 cmx 4 cm
81142K0JN60ZA	Genio K0JN (2022 - Sekarang)	0.15 kg	Coklat	10 cmx 8 cmx 4 cm
64420K41N00ZC	Supra X 125 FI New (2014 - Sekarang)	5 kg	Hitam	85 cmx 25 cmx 15 cm
83711KCJ660	Tiger Revolution A (2006 - 2012)\nTiger Revolution B (2010 - 2012)	0.2 kg	Silver	20 cmx 10 cmx 3 cm
83520KVB900	Vario 110 CW (2006 - 2014)	2.4 kg	Hitam	80 cmx 20 cmx 9 cm
81141K16A40RSW	Scoopy eSP K16R (2015 - 2017)	10 kg	Putih	60 cmx 40 cmx 20 cm
64320KPH700	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	1.9 kg	Hitam	37 cmx 26 cmx 12 cm
81250KVB930	Vario 110 CW (2006 - 2014)	4 kg	Hitam	40 cmx 28 cmx 20 cm
64421K0JN00ZM	Genio K0JN (2022 - Sekarang)	3 kg	Biru	60 cmx 16 cmx 5 cm
80110KYE900	Mega Pro New (2010 - 2014)	16 kg	Hitam	80 cmx 40 cmx 30 cm
64501K1ZJ10YH	PCX 160 K1Z (2021 - Sekarang)	18 kg	Merah	90 cmx 62 cmx 20 cm
64475K03N50ZA	Revo 110 FI (2014 - Sekarang)	0.15 kg	Hitam	30 cmx 10 cmx 3 cm
64202K0JN00ZM	Genio K0JN (2022 - Sekarang)	3 kg	Biru	60 cmx 16 cmx 5 cm
61100K0JN60MIB	Genio K0JN (2022 - Sekarang)	5 kg	Biru	56 cmx 25 cmx 18 cm
40510KWWC00	Revo 110 FI (2014 - Sekarang)\nSupra X 125 FI New (2014 - Sekarang)	1 kg	Hitam	55 cmx 10 cmx 10 cm
83160K45A50ZA	CBR 150R K45R (2021 - Sekarang)	5.5 kg	Hitam	60 cmx 36 cmx 15 cm
53206KZR600ZK	Vario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	3 kg	Hitam	\N
61100K1AN00MSG	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hijau	50 cmx 30 cmx 20 cm
61100K1AN00MBS	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Silver	50 cmx 30 cmx 20 cm
64320K64NP0ZD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Merah	81 cmx 35 cmx 10 cm
83620K64NP0ZD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Merah	50 cmx 25 cmx 15 cm
83511K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.83 kg	Hitam	48 cmx 13 cmx 8 cm
83510K1ZJ10MZB	PCX 160 K1Z (2021 - Sekarang)	11 kg	Biru	108 cmx 30 cmx 20 cm
64440K64NP0ZA	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3.5 kg	Merah	55 cmx 25 cmx 15 cm
64431K1ZJ10YN	PCX 160 K1Z (2021 - Sekarang)	10 kg	Biru	92 cmx 35 cmx 20 cm
64340K64NP0ZB	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Hitam	55 cmx 25 cmx 15 cm
64340K64NP0ZA	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Merah	55 cmx 25 cmx 15 cm
64431K0JN00ZM	Genio (2019 - 2022)\nGenio K0JN (2022 - Sekarang)	3 kg	Biru	65 cmx 15 cmx 5 cm
11341K1ZN40	PCX 160 K1Z (2021 - Sekarang)	3 kg	Hitam	50 cmx 20 cmx 12 cm
83750K59A70ZW	Vario 125 eSP K2V (2022 - Sekarang)	0.7 kg	Merah	32 cmx 30 cmx 5 cm
83600K2VN30MPC	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Putih	85 cmx 25 cmx 15 cm
83600K2VN30MGB	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Hitam	85 cmx 25 cmx 15 cm
83500K2VN30MPC	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Putih	85 cmx 25 cmx 15 cm
83500K2VN30MIB	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Biru	85 cmx 25 cmx 15 cm
64601K2VN30MGB	Vario 125 eSP K2V (2022 - Sekarang)	2 kg	Hitam	36 cmx 36 cmx 10 cm
64460K61900ZA	BeAT POP eSP K61 (2014 - 2019)	0.2 kg	Hitam	21 cmx 16 cmx 2 cm
64411K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	8 kg	Hitam	60 cmx 57 cmx 15 cm
53208K2VN30MGB	Vario 125 eSP K2V (2022 - Sekarang)	0.2 kg	Hitam	24 cmx 20 cmx 8 cm
5038AK03N30	Blade 125 FI K47 (2014 - 2018)\nRevo 110 FI (2014 - Sekarang)	0.45 kg	Hitam	20 cmx 23 cmx 5 cm
64460K2FN80ZA	Scoopy K2F (2020 - Sekarang)	1 kg	Coklat	30 cmx 25 cmx 5 cm
61100K2FN00YJ	Scoopy K2F (2020 - Sekarang)	5 kg	Silver	56 cmx 25 cmx 18 cm
81255K2VN30	Vario 125 eSP K2V (2022 - Sekarang)	0.4 kg	Hitam	20 cmx 10 cmx 10 cm
81142K2FN80ZJ	Scoopy K2F (2020 - Sekarang)	0.3 kg	Biru	22 cmx 15 cmx 5 cm
81141K2FN80ZE	Scoopy K2F (2020 - Sekarang)	10 kg	Hitam	60 cmx 40 cmx 20 cm
8016AK47N00	Blade 125 FI K47 (2014 - 2018)	0.08 kg	Hitam	10 cmx 9 cmx 5 cm
17546K84620ZB	CRF150L K84 (2017 - Sekarang)	4 kg	Putih	55 cmx 25 cmx 15 cm
83675K64NA0ZA	CBR 250RR K64 (2016 - 2020)	0.875 kg	Hitam	35 cmx 30 cmx 5 cm
83720K3BN00ZB	CB150X (2021 - Sekarang)	2.08 kg	Hitam	60 cmx 26 cmx 8 cm
83160K3BN00ZC	CB150X (2021 - Sekarang)	5.5 kg	Merah	60 cmx 36 cmx 15 cm
53207K2FN00MSR	Scoopy K2F (2020 - Sekarang)	0.2 kg	Merah	20 cmx 10 cmx 4 cm
77340K0WNA0ZA	ADV 160 (2022 - Sekarang)	0.6 kg	Hitam	44 cmx 13 cmx 6 cm
53209K2SN10ZJ	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 9 cmx 3 cm
64501K0WNA0ZE	ADV 160 (2022 - Sekarang)	12 kg	Merah	65 cmx 50 cmx 20 cm
83510K0WNA0ARE	ADV 160 (2022 - Sekarang)	4 kg	Merah	80 cmx 20 cmx 15 cm
64410K0WNA0ZB	ADV 160 (2022 - Sekarang)	0.7 kg	Hitam	32 cmx 20 cmx 5 cm
64336K0WN00YA	ADV 160 (2022 - Sekarang)	1.9 kg	Hitam	36 cmx 32 cmx 10 cm
83600K2FN00ZX	Scoopy K2F (2020 - Sekarang)	8 kg	Hitam	80 cmx 38 cmx 15 cm
83600K0WNA0	ADV 160 (2022 - Sekarang)	2 kg	Hitam	60 cmx 20 cmx 10 cm
64501K0WNA0ZL	ADV 160 (2022 - Sekarang)	12 kg	Putih	65 cmx 50 cmx 20 cm
8011AK25600	BeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)	0.4 kg	Hitam	\N
84100K41N00ZA	Supra X 125 FI New (2014 - Sekarang)	2 kg	Hitam	32 cmx 32 cmx 6 cm
53250K81N30ZA	BeAT Sporty eSP K81 (2016 - 2020)	0.3 kg	Grey	\N
50285K15710	CB150R StreetFire K15P (2021 - Sekarang)	4 kg	Hitam	70 cmx 34 cmx 10 cm
80151K0JN00ZC	Genio (2019 - 2022)	2 kg	Hitam	40 cmx 24 cmx 10 cm
61100K64N00ZV	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	50 cmx 30 cmx 20 cm
83750K2FN00ZV	Scoopy K2F (2020 - Sekarang)	2 kg	Hitam	33 cmx 28 cmx 16 cm
83161K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	5 kg	Hitam	66 cmx 22 cmx 20 cm
80151K2FN00YC	Scoopy K2F (2020 - Sekarang)	6 kg	Coklat	45 cmx 40 cmx 20 cm
11346KVB900	Vario 110 CW (2006 - 2014)	0.02 kg	Hitam	5 cmx 2 cmx 2 cm
83131K45NL0ZE	CBR 150R K45R (2021 - Sekarang)	0.25 kg	Hitam	20 cmx 20 cmx 5 cm
83131K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	0.25 kg	Hitam	20 cmx 20 cmx 5 cm
53206K2FN00ZM	Scoopy K2F (2020 - Sekarang)	0.5 kg	Silver	20 cmx 15 cmx 10 cm
61110K59A80ZF	Vario 150 eSP K59J (2018 - 2022)	3.5 kg	Hitam	48 cmx 24 cmx 18 cm
64200K64NC0ZA	CBR 250RR K64 (2016 - 2020)	3.5 kg	Merah, Putih	55 cmx 48 cmx 8 cm
64301K2FN00YA	Scoopy K2F (2020 - Sekarang)	5 kg	Hitam	42 cmx 45 cmx 15 cm
83610K84960ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	50 cmx 22 cmx 5 cm
81255K2SN00	Stylo 160 (2024 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 14 cmx 7 cm
77210KSPB00	Mega Pro New (2010 - 2014)	2 kg	Hitam	44 cmx 12 cmx 5 cm
83610K1ZJ10MIB	PCX 160 K1Z (2021 - Sekarang)	11 kg	Biru	108 cmx 30 cmx 20 cm
83600K2SN00MSR	Vario 160 K2S (2022 - Sekarang)	5.2 kg	Merah	80 cmx 26 cmx 15 cm
53208K2SN00ZG	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 9 cmx 3 cm
53208K2SN10ZB	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 9 cmx 3 cm
64301K59A70YK	Vario 125 eSP K60R (2018 - 2022)	2.5 kg	Putih	50 cmx 40 cmx 7 cm
64231K3BN00	CB150X (2021 - Sekarang)	0.85 kg	Hitam	25 cmx 25 cmx 8 cm
64202K0JN00ZL	Genio (2019 - 2022)	2 kg	Silver	60 cmx 20 cmx 10 cm
64311K2FN00	Scoopy K2F (2020 - Sekarang)	0.15 kg	Hitam	20 cmx 7 cmx 2 cm
64161K3BN00	CB150X (2021 - Sekarang)	0.8 kg	Hitam	52 cmx 15 cmx 5 cm
64411K3BN00MCS	CB150X (2021 - Sekarang)	1.5 kg	Silver	35 cmx 28 cmx 10 cm
64421K3BN00MGB	CB150X (2021 - Sekarang)	6 kg	Hitam	57 cmx 42 cmx 16 cm
64421K3BN00MSG	CB150X (2021 - Sekarang)	6 kg	Hijau	57 cmx 42 cmx 16 cm
64221K3BN00	CB150X (2021 - Sekarang)	2 kg	Hitam	32 cmx 28 cmx 14 cm
64305K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	2 kg	Hitam	41 cmx 48 cmx 7 cm
64100K0WN20ZA	ADV 150 (2019 - 2022)	2 kg	Putih	48 cmx 34 cmx 7 cm
83550K1ZN30ZF	PCX 160 K1Z (2021 - Sekarang)	11 kg	Hitam	108 cmx 30 cmx 20 cm
83520K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	1 kg	Hitam	60 cmx 10 cmx 10 cm
83171K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	5 kg	Hitam	66 cmx 22 cmx 20 cm
81141K2FN00ZH	Scoopy K2F (2020 - Sekarang)	10 kg	Silver	60 cmx 40 cmx 20 cm
81133K1ZJ10	PCX 160 K1Z (2021 - Sekarang)	0.15 kg	Hitam	18 cmx 13 cmx 3 cm
64501K2SN00ZL	Vario 160 K2S (2022 - Sekarang)	2 kg	Putih	40 cmx 28 cmx 7 cm
83550K1ZA00ZP	PCX 160 K1Z (2021 - Sekarang)	11 kg	Putih	108 cmx 30 cmx 20 cm
53208K59A70YJ	Vario 125 eSP K60R (2018 - 2022)	0.4 kg	Putih	32 cmx 21 cmx 5 cm
84152K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Hitam	15 cmx 15 cmx 4 cm
64530K1ZJ10	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	5 kg	Hitam	50 cmx 25 cmx 8 cm
81137K1ZJ10ZJ	PCX 160 K1Z (2021 - Sekarang)	0.05 kg	Grey	15 cmx 7 cmx 3 cm
81140K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	0.5 kg	Merah	35 cmx 21 cmx 10 cm
81141K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Hitam	23 cmx 15 cmx 9 cm
84152K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Hitam	15 cmx 15 cmx 4 cm
83500K2FN00MIB	Scoopy K2F (2020 - Sekarang)	8 kg	Biru	80 cmx 38 cmx 15 cm
64460K2FN00ZB	Scoopy K2F (2020 - Sekarang)	1 kg	Coklat	30 cmx 25 cmx 5 cm
61100K2FN00ZR	Scoopy K2F (2020 - Sekarang)	5 kg	Hitam	56 cmx 25 cmx 18 cm
64502K96V00ZS	PCX 150 K97 (2017 - 2021)	7 kg	Gold	\N
64411K45N40ZC	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Putih	\N
64411K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	8 kg	Hitam	\N
81142K2FN00ZK	Scoopy K2F (2020 - Sekarang)	0.5 kg	Hitam	\N
81142K2FN00ZL	Scoopy K2F (2020 - Sekarang)	0.5 kg	Hitam	\N
81142K2FN00ZN	Scoopy K2F (2020 - Sekarang)	0.4 kg	Silver	\N
83161K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	6 kg	Merah	\N
83111K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	5 kg	Putih	\N
83111K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	\N
83750K2FN00ZP	Scoopy K2F (2020 - Sekarang)	5 kg	Hitam	\N
83550K84900ZC	CRF150L K84 (2017 - Sekarang)	3 kg	\N	\N
64300K45NZ0ZA	CBR 150R K45R (2021 - Sekarang)	6 kg	\N	\N
81142K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	1 kg	Cream	\N
83131K45N40ZE	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.5 kg	Hitam	\N
64311K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	8 kg	Merah	\N
64502K0WN01ZD	ADV 150 (2019 - 2022)	12 kg	Hitam	65 cmx 50 cmx 20 cm
53205K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	5 kg	Hitam	\N
35108K64N00	CBR 250R K33A (2014 - 2016)\nCBR 250R KYJ (2011 - 2014)\nCBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)\nCRF250 Rally (2018 - Sekarang)	5 kg	Hitam	\N
8010AKYT940	Scoopy Karburator KYT (2010 - 2013)	10 kg	Hitam	83 cmx 45 cmx 17 cm
64320KEV790	Supra (1997 - 2002)\nSupra FIT (2006 - 2007)	2 kg	Hitam	\N
81139K97T00YJ	PCX 150 K97 (2017 - 2021)	3 kg	Silver	\N
81141K97T00ZW	PCX 150 K97 (2017 - 2021)	3 kg	Silver	\N
64431K97T00YJ	PCX 150 K97 (2017 - 2021)	7 kg	Coklat	\N
81133K0WN00	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	0.2 kg	Hitam	\N
81138K97T00YD	PCX 150 K97 (2017 - 2021)	3 kg	Coklat	\N
81137K97T00YD	PCX 150 K97 (2017 - 2021)	0.5 kg	Coklat	\N
84151K97T00YK	PCX 150 K97 (2017 - 2021)	5 kg	Silver	\N
64503K97T00YJ	PCX 150 K97 (2017 - 2021)	0.5 kg	Silver	\N
64503K97T00YH	PCX 150 K97 (2017 - 2021)	0.5 kg	Coklat	\N
83600K1AN00MCS	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Silver	\N
83500K1AN00MCS	BeAT dan BeAT Street K1A (2020 - 2024)	8 kg	Silver	\N
83500K1AN00FMB	BeAT dan BeAT Street K1A (2020 - 2024)	8 kg	Hitam	\N
53205K1AN00ZF	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Putih	\N
83650K0WN10ZB	ADV 150 (2019 - 2022)	6 kg	Hitam	\N
64405KYZ900	Supra X 125 Helm-in Karburator (2011)	3 kg	Hitam	\N
19610K0JN00	BeAT dan BeAT Street K1A (2020 - 2024)\nGenio (2019 - 2022)	2 kg	Hitam	\N
19642K44V00	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nScoopy eSP K93 (2017 - 2020)	0.5 kg	Hitam	\N
64305K56H20ZB	Sonic 150R K56 (2015 - Sekarang)	3 kg	Putih	\N
64210K45NC0ZA	CBR 150R K45N (2018 - 2020)	5 kg	Merah	\N
83600K0JN00VRD	Genio (2019 - 2022)	8 kg	Merah	\N
83510K0WN00ARE	ADV 150 (2019 - 2022)	5 kg	Merah	\N
83510K0WN00MMB	ADV 150 (2019 - 2022)	5 kg	Coklat	\N
64421K93N00ZY	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
64431K93N00ZY	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
64201K0JN00ZF	Genio (2019 - 2022)	3 kg	Silver	\N
83500K0JN00FMB	Genio (2019 - 2022)	8 kg	Hitam	\N
64431K0JN00ZD	Genio (2019 - 2022)	3 kg	Putih	\N
64202K0JN00ZF	Genio (2019 - 2022)	3 kg	Silver	\N
64502K0WN00ZF	ADV 150 (2019 - 2022)	12 kg	Silver	65 cmx 50 cmx 20 cm
81134K0JN00ZB	Genio (2019 - 2022)	3 kg	Merah	\N
83110K45NZ0ZA	CBR 150R K45R (2021 - Sekarang)	2 kg	Biru, Merah	\N
64201K0JN00ZD	Genio (2019 - 2022)	3 kg	Putih	\N
53206K0JN00MGB	Genio (2019 - 2022)	0.5 kg	Hitam	\N
53206K0JN00MBM	Genio (2019 - 2022)	0.5 kg	Coklat	\N
53205K0JN00ZG	Genio (2019 - 2022)	0.5 kg	Hitam	\N
83650K64N00ZH	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	1 kg	Hitam	\N
64100K45NC0ZA	CBR 150R K45N (2018 - 2020)	2.5 kg	Putih	\N
83120K45N40ZA	CBR 150R K45G (2016 - 2018)	4 kg	Hitam	\N
64310K45N50ZA	CBR 150R K45N (2018 - 2020)	14 kg	Oranye, Putih	\N
83600K59A70YB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Biru	\N
64350K59A70ZM	Vario 150 eSP K59J (2018 - 2022)	4 kg	Biru	\N
64360K59A70ZL	Vario 150 eSP K59J (2018 - 2022)	4 kg	Coklat	\N
61100K59A70ZV	Vario 150 eSP K59J (2018 - 2022)	5 kg	Coklat	46 cmx 28 cmx 23 cm
61100K56N10ZS	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	5 kg	Merah	\N
64210K64N00ZJ	CBR 250RR K64 (2016 - 2020)	6 kg	Merah	\N
17556K84920ZB	CRF150L K84 (2017 - Sekarang)	3 kg	Merah	\N
64440K45N40ZA	CBR 150R K45N (2018 - 2020)	1.5 kg	Putih	\N
64320K64N00ZD	CBR 250RR K64 (2016 - 2020)	4 kg	Hitam	\N
61100K64N00ZK	CB150R StreetFire K15P (2021 - Sekarang)\nCBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Merah	\N
83620K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Merah	\N
83630K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Merah	\N
83500K46N00VBM	Vario 110 FI (2014 - 2015)	6 kg	Biru	\N
64601K46N00VBM	Vario 110 FI (2014 - 2015)	3 kg	Biru	\N
64501K46N00VBM	Vario 110 FI (2014 - 2015)	3 kg	Biru	\N
83500K46N00VRD	Vario 110 eSP (2015 - 2019)	6 kg	Merah	\N
61100K15920ZF	CB150R StreetFire K15M (2018 - 2021)\nCBR 150R K45G (2016 - 2018)	3 kg	Merah	\N
64501K46N00VRD	Vario 110 eSP (2015 - 2019)	3 kg	Merah	\N
64301K46N00ZK	Vario 110 eSP (2015 - 2019)	8 kg	Merah	\N
61100K46N00ZF	Vario 110 eSP (2015 - 2019)	3 kg	Merah	\N
53205K46N20FMB	Vario 110 eSP (2015 - 2019)	3 kg	Hitam	\N
64601K59A70ZQ	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	6 kg	Putih	\N
61100K25900ZH	BeAT FI K25 (2012 - 2014)	3 kg	Hijau	\N
83500K59A70ZQ	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	6 kg	Putih	\N
64350K59A70ZF	Vario 150 eSP K59J (2018 - 2022)	4 kg	Silver	\N
64510KWN930ZE	PCX 125 CBU (2010 - 2012)	8 kg	Gold	\N
64301K59A70ZM	Vario 125 eSP K60R (2018 - 2022)	3 kg	Merah	\N
64301K25900AFB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	11 kg	Hitam	\N
83500K25600RSW	BeAT Sporty eSP K25G (2014 - 2016)	3 kg	Hitam	\N
83600K25600RSW	BeAT Sporty eSP K25G (2014 - 2016)	3 kg	Putih	\N
64350K59A70ZE	Vario 150 eSP K59J (2018 - 2022)	8 kg	Putih	\N
83600K25900FMB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	8 kg	Hitam	\N
83175K64N00ASB	CBR 250RR K64 (2016 - 2020)	3 kg	Hitam	\N
83620K64N00RSW	CBR 250RR K64 (2016 - 2020)	5 kg	Putih	\N
61100K59A70ZG	Vario 150 eSP K59J (2018 - 2022)	7 kg	Merah	\N
64320K15930ZC	CB150R StreetFire K15G (2015 - 2018)	2 kg	Hitam	\N
83750K93N00ZM	Scoopy eSP K93 (2017 - 2020)	0.4 kg	Merah	\N
64308KZR600ZB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	6 kg	Hitam	\N
84152K97T00ZW	PCX 150 K97 (2017 - 2021)	0.7 kg	Gold	\N
64301K0JN00HSM	Genio (2019 - 2022)	5 kg	Silver	\N
64321K45N40ZE	CBR 150R K45G (2016 - 2018)	6 kg	Hitam	\N
83500K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	9 kg	Putih	\N
81141K97T00ZN	PCX 150 K97 (2017 - 2021)	0.5 kg	Putih	\N
83510K97T00ZW	PCX 150 K97 (2017 - 2021)	10 kg	Gold	\N
84151K97T00ZX	PCX 150 K97 (2017 - 2021)	10 kg	Merah	\N
84151K97T00ZW	PCX 150 K97 (2017 - 2021)	7 kg	Gold	\N
64421K45N40ZE	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	6 kg	Hitam	\N
64511K45N40ZE	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.4 kg	Hitam	\N
64301K61900WRD	BeAT POP eSP K61 (2014 - 2019)	10 kg	Merah	\N
64320K64N00RSW	CBR 250RR K64 (2016 - 2020)	8 kg	Putih	\N
83630K64N00RSW	CBR 250RR K64 (2016 - 2020)	6 kg	Putih	\N
83165K64N00NOR	CBR 250RR K64 (2016 - 2020)	5 kg	Oranye	\N
64400KVLN00FMB	Supra X 125 (2007 - 2014)	7 kg	Hitam	\N
64110K45N20ZA	CBR 150R K45A (2014 - 2016)	2 kg	Putih	\N
81142K93N00ZA	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Cream	\N
8010AK03N30ZA	Revo 110 FI (2014 - Sekarang)	7 kg	Hitam	\N
83620KVB900	Vario 110 CW (2006 - 2014)	5 kg	Hitam	\N
53205KTL880FMB	Supra FIT (2006 - 2007)	3 kg	Hitam	\N
53205K61900FMB	BeAT POP eSP K61 (2014 - 2019)	3 kg	Hitam	\N
64420KYZ900ZC	Supra X 125 Helm-in Karburator (2011)	6 kg	Biru	\N
64421K16900FMB	Scoopy FI K16G (2013 - 2015)	6 kg	Hitam	\N
77220K18900PFW	Verza 150 (2013 - 2018)	6 kg	Putih	\N
5061AKZLA00ZC	Spacy Karburator (2011 - 2013)	3 kg	Hitam	\N
64400KYZ900ZE	Supra X 125 Helm-in Karburator (2011)	6 kg	Hitam	\N
53205K25900PCB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	3 kg	Hitam	\N
83500K59A10ZW	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Merah	\N
61000K07900ZB	Blade 110 K07A (2011 - 2014)	5 kg	Putih	\N
61100KVY720SBM	BeAT Karburator KVY (2008 - 2012)	5 kg	Biru	\N
83600K59A10YC	Vario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
61302K56N00ZC	Sonic 150R K56 (2015 - Sekarang)	0.2 kg	Magenta / Ungu / Pink	\N
61303K56N00ZC	Sonic 150R K56 (2015 - Sekarang)	0.2 kg	Magenta / Ungu / Pink	\N
64301K56N10ZM	Supra GTR K56F (2016 - 2019)	6 kg	Merah	\N
83510K56N10MIB	Supra GTR K56F (2016 - 2019)	5 kg	Biru	\N
83500K59A10ZJ	Vario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
81141K93N00ZN	Scoopy eSP K93 (2017 - 2020)	16 kg	Biru	\N
53206K93N00ZN	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Biru	\N
83750K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Silver	\N
64431K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	2 kg	Silver	\N
83750K93N00ZA	Scoopy eSP K93 (2017 - 2020)	0.6 kg	Cream	\N
83500K93N00ZA	Scoopy eSP K93 (2017 - 2020)	9 kg	Cream	\N
81134K93N00ZK	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Silver	\N
64431K93N00ZL	Scoopy eSP K93 (2017 - 2020)	2 kg	Hijau	\N
64320K64N00AGM	CBR 250RR K64 (2016 - 2020)	6 kg	Silver	\N
64202K93N00ZL	Scoopy eSP K93 (2017 - 2020)	3 kg	Hijau	\N
83510K56N10PFW	Supra GTR K56F (2016 - 2019)	8 kg	Putih	\N
83175K64N00WRD	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Merah	\N
64210K64N00WRD	CBR 250RR K64 (2016 - 2020)	3 kg	Merah	\N
64501K59A10FMB	Vario 125 eSP K60 (2015 - 2018)	4 kg	Hitam	\N
64480K56N10DSM	Supra GTR K56F (2016 - 2019)	3 kg	Silver	\N
64620K56N10PFW	Supra GTR K56F (2016 - 2019)	8 kg	Putih	\N
64620K56N10CPR	Supra GTR K56F (2016 - 2019)	8 kg	Merah	\N
64610K56N10CPR	Supra GTR K56F (2016 - 2019)	8 kg	Merah	\N
53208K56N10ZA	Supra GTR K56F (2016 - 2019)	0.5 kg	Merah	\N
64511K45N40FMB	CBR 150R K45G (2016 - 2018)	0.3 kg	Hitam	\N
83111K45N40ROW	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	8 kg	Putih	\N
83600K59A10WRD	Vario 125 eSP K60 (2015 - 2018)	5 kg	Merah	\N
83600K59A10MGB	Vario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
83600K59A10AFB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
83751KVB930FMB	Vario 110 CW (2006 - 2014)	\N	Hitam	\N
53207KVLN01AGM	Supra X 125 (2007 - 2014)	0.5 kg	Silver	\N
64333K3VN00	Stylo 160 (2024 - Sekarang)	1.8 kg	Hitam	60 cmx 15 cmx 12 cm
81130K2SN00ZV	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Biru	13 cmx 11 cmx 8 cm
64432K1ZJ10YM	PCX 160 K1Z (2021 - Sekarang)	10 kg	Merah	92 cmx 35 cmx 20 cm
64340K64N00AA	CBR 250RR K64N (2022 - Sekarang)	4 kg	Hitam	55 cmx 25 cmx 15 cm
64302K3VN00ASB	Stylo 160 (2024 - Sekarang)	1.1 kg	Hitam	38 cmx 22 cmx 8 cm
64220K64NP0ZA	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.6 kg	Hitam	40 cmx 30 cmx 7 cm
61100K3VN00ZF	Stylo 160 (2024 - Sekarang)	5.6 kg	Hitam	50 cmx 26 cmx 26 cm
83650K1ZN40ZE	PCX 160 K1Z (2021 - Sekarang)	11 kg	Merah	108 cmx 30 cmx 20 cm
83550K1ZN40ZE	PCX 160 K1Z (2021 - Sekarang)	11 kg	Merah	108 cmx 30 cmx 20 cm
64500K64NS0ZA	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	10 kg	Hitam	80 cmx 50 cmx 15 cm
83610K0WNA0MFB	ADV 160 (2022 - Sekarang)	8 kg	Coklat	80 cmx 40 cmx 15 cm
64301K2VN30ZJ	Vario 125 eSP K2V (2022 - Sekarang)	5.75 kg	Merah	50 cmx 46 cmx 15 cm
84151K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	4 kg	Silver	60 cmx 40 cmx 10 cm
83510K0WNA0MDG	ADV 160 (2022 - Sekarang)	8 kg	Grey	80 cmx 40 cmx 15 cm
84152K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Silver	15 cmx 15 cmx 4 cm
84151K1ZJ10YH	PCX 160 K1Z (2021 - Sekarang)	4 kg	Coklat	60 cmx 40 cmx 10 cm
64502K0WNA0ZK	ADV 160 (2022 - Sekarang)	12 kg	Grey	65 cmx 50 cmx 20 cm
64502K0WNA0ZE	ADV 160 (2022 - Sekarang)	12 kg	Coklat	65 cmx 50 cmx 20 cm
6430BKVB900	Vario 110 CW (2006 - 2014)	2 kg	Hitam	57 cmx 20 cmx 10 cm
64302KZLA00FMB	Spacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)	4 kg	Hitam	45 cmx 25 cmx 15 cm
61100K0WN000AA	ADV 150 (2019 - 2022)	6 kg	Hitam	60 cmx 30 cmx 20 cm
61301KSPB00MTB	Mega Pro New (2010 - 2014)	4.9 kg	Hitam	35 cmx 35 cmx 24 cm
61100K1AN00MJB	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Coklat	50 cmx 30 cmx 20 cm
61100K1AN00MIB	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Biru	50 cmx 30 cmx 20 cm
80100GF62A0	\N	4 kg	Hitam	46 cmx 36 cmx 15 cm
6431AKZLC30ZC	Spacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)	5.1 kg	Hitam	55 cmx 40 cmx 14 cm
80151K16900YH	Scoopy eSP K16R (2015 - 2017)	4 kg	Putih	31 cmx 25 cmx 20 cm
64410K41N00ZC	Supra X 125 FI New (2014 - Sekarang)	5 kg	Hitam	85 cmx 25 cmx 15 cm
64202K2FN00ZY	Scoopy K2F (2020 - Sekarang)	3 kg	Oranye	60 cmx 20 cmx 10 cm
83600KVB930PFW	Vario 110 CW (2006 - 2014)	8 kg	Putih	80 cmx 38 cmx 15 cm
83600K16900VBM	Scoopy FI K16G (2013 - 2015)	8 kg	Biru	80 cmx 38 cmx 15 cm
83500KVB930PFW	Vario 110 CW (2006 - 2014)	8 kg	Putih	80 cmx 38 cmx 15 cm
83500K16900VBM	Scoopy FI K16G (2013 - 2015)	8 kg	Biru	80 cmx 38 cmx 15 cm
54303K16900PMC	Scoopy FI K16G (2013 - 2015)	5.2 kg	Cream	75 cmx 28 cmx 15 cm
53205KYZ900ZD	Supra X 125 Helm-In FI (2011 - 2018)\nSupra X 125 Helm-in Karburator (2011)	5 kg	Hijau	55 cmx 30 cmx 15 cm
64440K56N00SMM	Sonic 150R K56 (2015 - Sekarang)	5 kg	Magenta / Ungu / Pink	\N
64440K64N00AA	CBR 250RR K64N (2022 - Sekarang)	1.5 kg	Hitam	57 cmx 16 cmx 8 cm
64370K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	7 kg	Hitam	74 cmx 47 cmx 12 cm
64370K41N00ZC	Supra X 125 FI New (2014 - Sekarang)	4 kg	Hitam	70 cmx 25 cmx 15 cm
83600K16900WRD	Scoopy FI K16G (2013 - 2015)	5 kg	Merah	80 cmx 25 cmx 15 cm
83500K16900WRD	Scoopy FI K16G (2013 - 2015)	5 kg	Merah	80 cmx 25 cmx 15 cm
83500K16900RSW	Scoopy eSP K16R (2015 - 2017)	5 kg	Putih	80 cmx 25 cmx 15 cm
8125AKYZ900	Supra X 125 Helm-in Karburator (2011)	5 kg	Hitam	43 cmx 30 cmx 23 cm
8010BKCJ660	Tiger Revolution A (2006 - 2012)\nTiger Revolution B (2010 - 2012)	8.5 kg	Hitam	80 cmx 42 cmx 15 cm
54302K16900VBM	Scoopy FI K16G (2013 - 2015)	5.2 kg	Biru	75 cmx 28 cmx 15 cm
50260K15900ZE	CB150R StreetFire K15 (2012 - 2015)	1.2 kg	Merah	35 cmx 24 cmx 8 cm
6431BK16A40ZB	Scoopy eSP K16R (2015 - 2017)	8 kg	Hitam	70 cmx 41 cmx 17 cm
8114AKVBN50	Vario 110 Techno A (2009 - 2010)	5 kg	Hitam	46 cmx 42 cmx 15 cm
8010AK16A00	Scoopy FI K16G (2013 - 2015)	10.5 kg	Hitam	70 cmx 30 cmx 30 cm
83130K45A50ZB	CBR 150R K45R (2021 - Sekarang)	0.2 kg	Hitam	22 cmx 18 cmx 4 cm
81130K2FN80ZH	Scoopy K2F (2020 - Sekarang)	0.3 kg	Coklat	22 cmx 15 cmx 5 cm
81130K2FN00ZW	Scoopy K2F (2020 - Sekarang)	0.3 kg	Coklat	22 cmx 15 cmx 5 cm
61100K1ZJ10YF	PCX 160 K1Z (2021 - Sekarang)	5 kg	Merah	50 cmx 30 cmx 20 cm
64341K45NL0MBS	CBR 150R K45R (2021 - Sekarang)	6.56 kg	Silver	82 cmx 48 cmx 10 cm
8364AK18900	Verza 150 (2013 - 2018)	4 kg	Hitam	48 cmx 48 cmx 10 cm
64350K07900ZB	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nSupra X 125 FI New (2014 - Sekarang)	0.5 kg	Hitam	54 cmx 11 cmx 5 cm
83121K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	6 kg	Grey	\N
80100KTM850	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	11 kg	Hitam	80 cmx 25 cmx 35 cm
64470K03N50ZA	Revo 110 FI (2014 - Sekarang)	0.15 kg	Hitam	30 cmx 10 cmx 3 cm
64431K2FN00YC	Scoopy K2F (2020 - Sekarang)	3 kg	Oranye	65 cmx 15 cmx 5 cm
53206K0JN00MIB	Genio K0JN (2022 - Sekarang)	0.4 kg	Biru	29 cmx 30 cmx 5 cm
8010BKZLA00	Spacy Karburator (2011 - 2013)	2.4 kg	Hitam	48 cmx 20 cmx 15 cm
83130K45A50ZC	CBR 150R K45R (2021 - Sekarang)	0.4 kg	Hitam	20 cmx 10 cmx 5 cm
64460K16900ZC	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.2 kg	Coklat	18 cmx 16 cmx 3 cm
64400K45A80ZA	CBR 150R K45R (2021 - Sekarang)	9 kg	Hitam	60 cmx 35 cmx 25 cm
64360K07900ZB	Blade 110 K07A (2011 - 2014)\nSupra X 125 FI New (2014 - Sekarang)	5.5 kg	Hitam	54 cmx 12 cmx 5 cm
64300K45A80ZA	CBR 150R K45R (2021 - Sekarang)	9 kg	Hitam	60 cmx 35 cmx 25 cm
64240K45A50ZB	CBR 150R K45R (2021 - Sekarang)	0.5 kg	Hitam	40 cmx 30 cmx 7 cm
64201K0JN00ZM	Genio K0JN (2022 - Sekarang)	3 kg	Biru	60 cmx 16 cmx 5 cm
84100K59A70ZU	Vario 125 eSP K2V (2022 - Sekarang)	3 kg	Coklat	35 cmx 35 cmx 15 cm
83600K1AN00MSG	BeAT dan BeAT Street K1A (2020 - 2024)	4 kg	Hijau	82 cmx 27 cmx 10 cm
83500K1AN00MBS	BeAT dan BeAT Street K1A (2020 - 2024)	4 kg	Silver	82 cmx 27 cmx 10 cm
83120K45A50ZA	CBR 150R K45R (2021 - Sekarang)	6 kg	Hitam	60 cmx 20 cmx 10 cm
83110K45A50ZA	CBR 150R K45R (2021 - Sekarang)	6 kg	Hitam	60 cmx 20 cmx 10 cm
64431K0WNA0ZB	ADV 160 (2022 - Sekarang)	10 kg	Silver	92 cmx 35 cmx 20 cm
64400K45A50ZA	CBR 150R K45R (2021 - Sekarang)	8 kg	Hitam	60 cmx 57 cmx 15 cm
64340K45A50ZD	CBR 150R K45R (2021 - Sekarang)	6.56 kg	Grey	82 cmx 48 cmx 10 cm
64230K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2.5 kg	Hitam	42 cmx 23 cmx 15 cm
61000K45A90ZD	CBR 150R K45R (2021 - Sekarang)	3 kg	Hitam	37 cmx 20 cmx 22 cm
86642K1ANC0ZC	BeAT dan BeAT Street K1A (2020 - 2024)	0.05 kg	Hitam, Merah	28 cmx 10 cmx 1 cm
64704K0WN00	ADV 160 (2022 - Sekarang)	0.04 kg	Hitam	10 cmx 5 cmx 3 cm
64330K64NP0MZB	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.5 kg	Biru	55 cmx 30 cmx 20 cm
64330K64NP0MGB	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.5 kg	Hitam	55 cmx 30 cmx 20 cm
64450KTM850FMX	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	6.3 kg	Putih	60 cmx 42 cmx 15 cm
83650K64NP0ZC	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.93 kg	Merah	35 cmx 20 cmx 8 cm
81140K1ZJ10YM	PCX 160 K1Z (2021 - Sekarang)	1.3 kg	Biru	35 cmx 21 cmx 10 cm
81131K0JN60ZB	Genio K0JN (2022 - Sekarang)	4 kg	Biru	40 cmx 30 cmx 20 cm
64503K1ZJ10YM	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Biru	20 cmx 8 cmx 3 cm
64502K1ZJ10YJ	PCX 160 K1Z (2021 - Sekarang)	18 kg	Biru	90 cmx 62 cmx 20 cm
64440K64NP0ZB	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Hitam	55 cmx 25 cmx 15 cm
61100K64NP0ZF	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Hitam	60 cmx 30 cmx 20 cm
83600K2VN30MIB	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Biru	85 cmx 25 cmx 15 cm
83141K45NL0ZN	CBR 150R K45R (2021 - Sekarang)	1.5 kg	Putih	36 cmx 22 cmx 5 cm
81134K2FN00YB	Scoopy K2F (2020 - Sekarang)	0.1 kg	Putih	12 cmx 8 cmx 3 cm
81130K2FN80ZJ	Scoopy K2F (2020 - Sekarang)	0.3 kg	Biru	22 cmx 12 cmx 5 cm
64500K2SH00ZA	Vario 160 K2S (2022 - Sekarang)	2 kg	Merah	40 cmx 28 cmx 7 cm
64431K2FN00YL	Scoopy K2F (2020 - Sekarang)	3 kg	Putih	65 cmx 15 cmx 5 cm
53207K2FN00MIB	Scoopy K2F (2020 - Sekarang)	0.2 kg	Biru	20 cmx 10 cmx 4 cm
53205K2FN00RSW	Scoopy K2F (2020 - Sekarang)	1 kg	Putih	22 cmx 20 cmx 15 cm
17575K25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	0.3 kg	Hitam	25 cmx 22 cmx 3 cm
64500K0WNB0ZE	ADV 160 (2022 - Sekarang)	12 kg	Hitam	65 cmx 50 cmx 20 cm
64500K0WNB0ZC	ADV 160 (2022 - Sekarang)	12 kg	Putih	65 cmx 50 cmx 20 cm
64431K2FN00YK	Scoopy K2F (2020 - Sekarang)	3 kg	Hitam	65 cmx 15 cmx 5 cm
64400K0WNA0ZJ	ADV 160 (2022 - Sekarang)	12 kg	Hitam	65 cmx 50 cmx 20 cm
64400K0WNA0ZG	ADV 160 (2022 - Sekarang)	12 kg	Putih	65 cmx 50 cmx 20 cm
80104K25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	0.1 kg	Hitam	21 cmx 11 cmx 2 cm
37230K46N01	Vario 110 eSP (2015 - 2019)\nVario 110 FI (2014 - 2015)	0.15 kg	Hitam	21 cmx 13 cmx 3 cm
37213KPH701	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	0.01 kg	Hitam	2 cmx 2 cmx 1 cm
17225K41N00	Supra X 125 FI New (2014 - Sekarang)	1.111 kg	Hitam	29 cmx 23 cmx 10 cm
83720K3BN10ZA	CB150X (2021 - Sekarang)	2.08 kg	Hitam	60 cmx 28 cmx 8 cm
83600K3BN00ZB	CB150X (2021 - Sekarang)	2.1 kg	Hitam	60 cmx 28 cmx 8 cm
83170K3BN00ZC	CB150X (2021 - Sekarang)	5 kg	Merah	60 cmx 36 cmx 15 cm
64420K3BN10ZA	CB150X (2021 - Sekarang)	4 kg	Hitam	50 cmx 48 cmx 10 cm
64320K3BN10ZA	CB150X (2021 - Sekarang)	4 kg	Hitam	50 cmx 48 cmx 10 cm
64310K3BN00ZA	CB150X (2021 - Sekarang)	1.5 kg	\N	35 cmx 28 cmx 10 cm
77220KYE900	Mega Pro New (2010 - 2014)	0.5 kg	Hitam	46 cmx 13 cmx 5 cm
53207K0JN00ZB	Genio (2019 - 2022)	0.2 kg	Hitam	15 cmx 18 cmx 6 cm
17575K03N30	Revo 110 FI (2014 - Sekarang)	0.5 kg	Hitam	22 cmx 20 cmx 8 cm
83650K0WNA0ZC	ADV 160 (2022 - Sekarang)	4 kg	Putih	80 cmx 20 cmx 15 cm
83550K0WNA0ZC	ADV 160 (2022 - Sekarang)	4 kg	Putih	80 cmx 20 cmx 15 cm
64311K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	8 kg	Hitam	60 cmx 57 cmx 15 cm
83510K84620ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam, Kuning	50 cmx 22 cmx 5 cm
83510K84620ZB	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	50 cmx 22 cmx 5 cm
83510K84610ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam	50 cmx 22 cmx 5 cm
53208K59A70YB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.4 kg	Merah	32 cmx 21 cmx 5 cm
17556K84620ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hijau	55 cmx 25 cmx 15 cm
17556K84600ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Merah	55 cmx 25 cmx 15 cm
83450K2SH00ZB	Vario 160 K2S (2022 - Sekarang)	5.2 kg	Putih	80 cmx 26 cmx 15 cm
77330K0WNA0ZA	ADV 160 (2022 - Sekarang)	0.6 kg	Hitam	44 cmx 13 cmx 6 cm
53208K2SN10ZJ	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 9 cmx 3 cm
81138K0WNA0ZB	ADV 160 (2022 - Sekarang)	0.3 kg	Hitam	32 cmx 21 cmx 8 cm
61100K64NP0ZD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.2 kg	Merah	52 cmx 24 cmx 25 cm
80107K0WNA0	ADV 160 (2022 - Sekarang)	0.6 kg	Hitam	37 cmx 19 cmx 5 cm
64501K0WNA0ZK	ADV 160 (2022 - Sekarang)	12 kg	Merah	65 cmx 50 cmx 20 cm
61110K2SN00ZC	Vario 160 K2S (2022 - Sekarang)	3 kg	Merah	37 cmx 20 cmx 22 cm
17231KVB900	Vario 110 Techno A (2009 - 2010)\nVario 110 Techno B (2010 - 2012)	0.5 kg	Hitam	\N
61110K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	3 kg	Putih	37 cmx 20 cmx 22 cm
83650K1ZA00ZP	PCX 160 K1Z (2021 - Sekarang)	11 kg	Putih	158 cmx 30 cmx 20 cm
64220K64NA0ZB	CBR 250RR K64 (2016 - 2020)	0.5 kg	Hitam, Merah	40 cmx 30 cmx 5 cm
83450K15900ZD	CB150R StreetFire K15 (2012 - 2015)	0.3 kg	Merah	20 cmx 18 cmx 2 cm
83131K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	0.4 kg	Merah	\N
83650K1ZN30ZC	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	11 kg	Putih	108 cmx 30 cmx 20 cm
64441K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	5 kg	Putih	50 cmx 50 cmx 10 cm
64431K2FN00YD	Scoopy K2F (2020 - Sekarang)	3 kg	Merah	65 cmx 15 cmx 5 cm
64421K2FN00YB	Scoopy K2F (2020 - Sekarang)	3 kg	Merah	65 cmx 15 cmx 5 cm
64301K59A70YD	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	53 cmx 38 cmx 8 cm
61100K59A70ZL	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3.5 kg	Putih	48 cmx 24 cmx 18 cm
64341K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	5 kg	Biru	58 cmx 35 cmx 15 cm
83650K2FN00MPC	Scoopy K2F (2020 - Sekarang)	0.25 kg	Putih	18 cmx 12 cmx 5 cm
83650K2FN00MJB	Scoopy K2F (2020 - Sekarang)	0.25 kg	Coklat	18 cmx 12 cmx 5 cm
81146K2FN10ZL	Scoopy K2F (2020 - Sekarang)	0.02 kg	Coklat	5 cmx 3 cmx 2 cm
77237K59A10	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.03 kg	Hitam	12 cmx 7 cmx 4 cm
83121K45N40ZC	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	2.5 kg	Putih	50 cmx 20 cmx 15 cm
80101K2SN00	Vario 160 K2S (2022 - Sekarang)	4 kg	Hitam	65 cmx 37 cmx 10 cm
53207K2FN00PBL	Scoopy K2F (2020 - Sekarang)	0.2 kg	Hitam	\N
64330K03N50ZB	Revo 110 FI (2014 - Sekarang)	3.2 kg	Hitam	56 cmx 44 cmx 8 cm
81130K2FN00ZX	Scoopy K2F (2020 - Sekarang)	0.3 kg	Oranye	22 cmx 15 cmx 5 cm
61304K15710	CB150R StreetFire K15P (2021 - Sekarang)	0.3 kg	Hitam	22 cmx 15 cmx 7 cm
83450K15900ZC	CB150R StreetFire K15 (2012 - 2015)\nCB150R StreetFire K15P (2021 - Sekarang)	0.2 kg	Hitam	20 cmx 15 cmx 5 cm
61302K15710ZB	CB150R StreetFire K15P (2021 - Sekarang)	0.2 kg	Hitam	24 cmx 10 cmx 5 cm
64460K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	1 kg	Hitam	22 cmx 22 cmx 12 cm
84151K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	3.7 kg	Putih	58 cmx 48 cmx 8 cm
11360KWWA80	Revo 110 FI (2014 - Sekarang)\nRevo 110 New (2010 - 2014)	0.3 kg	Hitam	19 cmx 13 cmx 7 cm
53208K2SN00ZE	Vario 160 K2S (2022 - Sekarang)	0.15 kg	Merah	20 cmx 9 cmx 3 cm
83635K64N60ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Merah	90 cmx 37 cmx 10 cm
83170K64NA0ZA	CBR 250RR K64 (2016 - 2020)	6 kg	Hitam	50 cmx 20 cmx 10 cm
83160K64N20ZA	CBR 250RR K64 (2016 - 2020)	6 kg	Merah	50 cmx 20 cmx 10 cm
64440K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	5 kg	Grey	50 cmx 50 cmx 10 cm
64400K64NA0ZA	CBR 250RR K64 (2016 - 2020)	12 kg	Merah	60 cmx 60 cmx 20 cm
84151K97T00YW	PCX 150 K97 (2017 - 2021)	4 kg	Biru	60 cmx 40 cmx 10 cm
84151K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	4 kg	Merah	60 cmx 40 cmx 10 cm
83600K59A70YC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5.2 kg	Hitam	80 cmx 26 cmx 15 cm
83610K1ZJ10MDG	PCX 160 K1Z (2021 - Sekarang)	11 kg	Grey	108 cmx 30 cmx 20 cm
84152K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Biru	15 cmx 15 cmx 4 cm
84152K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Merah	15 cmx 15 cmx 4 cm
53206K1ZJ10	PCX 160 K1Z (2021 - Sekarang)	0.1 kg	Putih	15 cmx 10 cmx 3 cm
53209K2SN00ZE	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Merah	20 cmx 9 cmx 3 cm
53209K2SN10ZB	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 9 cmx 3 cm
61100K0JN00MJB	Genio (2019 - 2022)	3.5 kg	Coklat	48 cmx 24 cmx 18 cm
83151K3BN00	CB150X (2021 - Sekarang)	4.8 kg	Hitam	60 cmx 24 cmx 20 cm
64336K0WN00ZK	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	1.2 kg	Putih	37 cmx 33 cmx 5 cm
64432K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	12 kg	Hitam	99 cmx 41 cmx 18 cm
64431K0JN00MJB	Genio (2019 - 2022)	3 kg	Coklat	60 cmx 16 cmx 5 cm
64320K56N10ZD	Supra GTR K56F (2016 - 2019)	5.5 kg	Hitam	42 cmx 40 cmx 20 cm
64440K56N00VRD	Sonic 150R K56 (2015 - Sekarang)	5.5 kg	Merah	107 cmx 20 cmx 15 cm
64341K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	6 kg	Merah	\N
64305K1ZJ10ZJ	PCX 160 K1Z (2021 - Sekarang)	2 kg	Grey	41 cmx 48 cmx 7 cm
64300K45A40ZA	CBR 150R K45R (2021 - Sekarang)	8 kg	Hitam	\N
83510K1ZJ10PFW	PCX 160 K1Z (2021 - Sekarang)	11 kg	Putih	108 cmx 30 cmx 20 cm
83500K59A70YC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	4 kg	Hitam	80 cmx 20 cmx 15 cm
83500K2SN00MSR	Vario 160 K2S (2022 - Sekarang)	4 kg	Merah	80 cmx 20 cmx 15 cm
83171K3BN00ZD	CB150X (2021 - Sekarang)	5.5 kg	Hijau	60 cmx 36 cmx 15 cm
83171K3BN00ZC	CB150X (2021 - Sekarang)	5.5 kg	Hitam	60 cmx 36 cmx 15 cm
83161K3BN00ZD	CB150X (2021 - Sekarang)	5.5 kg	Hijau	60 cmx 36 cmx 15 cm
64506K97T00YY	PCX 150 K97 (2017 - 2021)	0.15 kg	Hitam	30 cmx 6 cmx 3 cm
83600K2FN00MSR	Scoopy K2F (2020 - Sekarang)	8 kg	Merah	80 cmx 38 cmx 15 cm
83510K97T00YW	PCX 150 K97 (2017 - 2021)	11 kg	Hitam	108 cmx 30 cmx 20 cm
53207K2FN00ASB	Scoopy K2F (2020 - Sekarang)	0.2 kg	Hitam	\N
81137K1ZJ10ZS	PCX 160 K1Z (2021 - Sekarang)	0.1 kg	Putih	15 cmx 8 cmx 4 cm
81134K0JN00ZG	Genio (2019 - 2022)	0.1 kg	Coklat	12 cmx 8 cmx 3 cm
64503K1ZJ10ZJ	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Grey	19 cmx 8 cmx 3 cm
81140K1ZJ10ZQ	PCX 160 K1Z (2021 - Sekarang)	0.5 kg	Biru	35 cmx 21 cmx 10 cm
83500K59A70YA	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Merah	82 cmx 25 cmx 12 cm
64503K1ZJ10ZN	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Hitam	19 cmx 8 cmx 3 cm
64421K0JN00MJB	Genio (2019 - 2022)	3 kg	Biru	60 cmx 16 cmx 5 cm
61100K2FN00ZP	Scoopy K2F (2020 - Sekarang)	5 kg	Biru	56 cmx 25 cmx 18 cm
61100K2FN00ZL	Scoopy K2F (2020 - Sekarang)	5 kg	Cream	56 cmx 25 cmx 18 cm
50400K16910ZA	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	4.5 kg	Hitam	40 cmx 44 cmx 15 cm
83111K45N40ZC	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	5.1 kg	Putih	82 cmx 3 cmx 15 cm
53205K1AN00ZC	BeAT dan BeAT Street K1A (2020 - 2024)	3 kg	Magenta / Ungu / Pink	\N
83120K45NZ0ZA	CBR 150R K45R (2021 - Sekarang)	2 kg	Biru, Merah	\N
83141K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	4 kg	Oranye	\N
83161K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	7 kg	Merah	\N
83171K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	6 kg	Merah	\N
83151K45NL0FMB	CBR 150R K45R (2021 - Sekarang)	4 kg	Hitam	\N
17255K45NL0	CBR 150R K45R (2021 - Sekarang)	0.5 kg	Hitam	\N
61100K59A70ZQ	Vario 125 eSP K60 (2015 - 2018)\nVario 125 eSP K60R (2018 - 2022)	6 kg	Silver	\N
61100KVY960FMB	BeAT Karburator KVY (2008 - 2012)	1 kg	Hitam	\N
64501K0WN01ZF	ADV 150 (2019 - 2022)	5 kg	\N	\N
83120K45NE0ZA	CBR 150R K45G (2016 - 2018)	4 kg	Merah	\N
64211K45NA0ZE	CBR 150R K45G (2016 - 2018)	5 kg	Hitam	\N
83121K45N40ZH	CBR 150R K45G (2016 - 2018)	5 kg	Merah	\N
64311K45N40ZE	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	5 kg	Grey, Hitam	\N
64320KYZ900	Supra X 125 Helm-in Karburator (2011)	3 kg	Hitam	\N
61100K97T00YH	PCX 150 K97 (2017 - 2021)	3.5 kg	Coklat	\N
64421K0JN00ZF	Genio (2019 - 2022)	2 kg	Silver	\N
64565K03N30ZB	Revo 110 FI (2014 - Sekarang)	1.5 kg	Hitam	\N
64420K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Hitam	19 cmx 8 cmx 5 cm
64310K64N00ZB	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	7 kg	Hitam	\N
77330K0WN00ZA	ADV 150 (2019 - 2022)	2 kg	Hitam	\N
81139K97T00YH	PCX 150 K97 (2017 - 2021)	2 kg	Coklat	\N
64333K0JN00	Genio (2019 - 2022)\nScoopy K2F (2020 - Sekarang)	2 kg	Hitam	\N
80102K0WN00	ADV 150 (2019 - 2022)	3 kg	Hitam	\N
64305K97T00YJ	PCX 150 K97 (2017 - 2021)	5 kg	Coklat	\N
64432K97T00YJ	PCX 150 K97 (2017 - 2021)	8 kg	Coklat	\N
83500K1AN00RSW	BeAT dan BeAT Street K1A (2020 - 2024)	8 kg	Putih	\N
64500K0WN10ZB	ADV 150 (2019 - 2022)	12 kg	Merah	65 cmx 50 cmx 20 cm
81134K93N00ZX	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Merah	\N
16305K0JN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nGenio (2019 - 2022)\nScoopy K2F (2020 - Sekarang)	0.5 kg	Hitam	\N
53206K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	3 kg	Putih	\N
64620K56N10MSR	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	8 kg	Merah	\N
64610K56N10MSR	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	8 kg	Merah	\N
64200K0JN10ZE	Genio (2019 - 2022)	5 kg	Merah	\N
64502K0WN00ZE	ADV 150 (2019 - 2022)	12 kg	Putih	65 cmx 50 cmx 20 cm
81142K93N00ZL	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Merah	\N
83600K56H30ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Putih	\N
64405K56H40ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
83500K0JN00PBL	Genio (2019 - 2022)	8 kg	Hitam	\N
81142K93N00ZM	Scoopy eSP K93 (2017 - 2020)	1 kg	Putih	\N
64421K0JN00ZB	Genio (2019 - 2022)	3 kg	Merah	\N
64201K0JN00ZG	Genio (2019 - 2022)	3 kg	Hitam	\N
64201K0JN00ZH	Genio (2019 - 2022)	3 kg	Biru	\N
64501K0WN00ZE	ADV 150 (2019 - 2022)	12 kg	Putih	65 cmx 50 cmx 20 cm
64431K0JN00ZF	Genio (2019 - 2022)	3 kg	Silver	\N
64202K0JN00ZD	Genio (2019 - 2022)	3 kg	Putih	\N
64360K0WN00ZA	ADV 150 (2019 - 2022)	4 kg	Merah	\N
64360K0WN00ZC	ADV 150 (2019 - 2022)	4 kg	Silver	\N
81134K0JN00ZD	Genio (2019 - 2022)	3 kg	Hitam	\N
81131K0JN00ZA	Genio (2019 - 2022)	5 kg	Coklat	\N
81131K0JN00ZD	Genio (2019 - 2022)	5 kg	Hitam	\N
61100K0JN00PBL	Genio (2019 - 2022)	3 kg	Hitam	\N
64350K0WN00ZA	ADV 150 (2019 - 2022)	4 kg	Merah	\N
61100K0JN00FMB	Genio (2019 - 2022)	3 kg	Hitam	\N
64336K0WN00ZE	ADV 150 (2019 - 2022)	3.5 kg	Putih	\N
83650K56NH0ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
64340K45N40ZB	CBR 150R K45G (2016 - 2018)	2.5 kg	Hitam	\N
64310K45NH0ZA	CBR 150R K45G (2016 - 2018)	6 kg	Hitam	\N
83110K45NA0ZA	CBR 150R K45N (2018 - 2020)	4 kg	Hitam	\N
64301K64N00ZA	CBR 250RR K64 (2016 - 2020)	4 kg	Hitam	\N
64440K45N50ZA	CBR 150R K45N (2018 - 2020)	2.5 kg	Putih	\N
64220K64N00ZA	CBR 250RR K64 (2016 - 2020)	1.2 kg	Hitam	\N
61305K56N20ZA	Sonic 150R K56 (2015 - Sekarang)	1.5 kg	Oranye	\N
64601K59A70YC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	6 kg	Biru	\N
64601K59A70YA	Vario 150 eSP K59J (2018 - 2022)	5 kg	Coklat	\N
64501K59A70YA	Vario 150 eSP K59J (2018 - 2022)	5 kg	Gold, Grey	\N
83110K45NE0ZA	CBR 150R K45N (2018 - 2020)	7 kg	Hitam, Merah, Putih	\N
64420K56N00WRD	Sonic 150R K56 (2015 - Sekarang)	2 kg	Merah	\N
53207K56N10ZR	Supra GTR K56F (2016 - 2019)	3 kg	Merah	\N
53208K56N10ZS	Supra GTR K56F (2016 - 2019)	1.5 kg	Merah	\N
53208K56N10ZR	Supra GTR K56F (2016 - 2019)	1.5 kg	Merah	\N
83610K64N00MSR	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.8 kg	Merah	\N
64506K97T00ZE	PCX 150 K97 (2017 - 2021)	1 kg	Hitam	\N
83650K64N00ZG	CBR 250RR K64 (2016 - 2020)	3 kg	Merah	\N
83510K84920ZB	CRF150L K84 (2017 - Sekarang)	3 kg	Merah	\N
77210K18960PFR	CB150 Verza (2018 - Sekarang)	4 kg	Merah	\N
77220K18960INS	CB150 Verza (2018 - Sekarang)	4 kg	Silver	\N
83175K64N00FMB	CBR 250RR K64 (2016 - 2020)	3 kg	Hitam	\N
64320K64N00ZA	CBR 250RR K64 (2016 - 2020)	3 kg	Hitam	\N
61100K64N00ZD	CB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)\nCBR 150R K45R (2021 - Sekarang)\nCBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	4 kg	Hitam	\N
64490K56N10ZG	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	3 kg	Merah	\N
64480K56N10ZG	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	3 kg	Merah	\N
64301K46N00ARM	Vario 110 eSP (2015 - 2019)	8 kg	Merah	\N
53205K46N20MAG	Vario 110 eSP (2015 - 2019)	3 kg	Grey	\N
83751K46N00ZK	Vario 110 eSP (2015 - 2019)	0.5 kg	Merah	\N
83750K46N00ZA	Vario 110 FI (2014 - 2015)	0.5 kg	Merah	\N
64601K46N00PFW	Vario 110 FI (2014 - 2015)	3 kg	Putih	\N
64601K46N00CSR	Vario 110 FI (2014 - 2015)	3 kg	Merah	\N
64501K46N00RSW	Vario 110 eSP (2015 - 2019)	3 kg	Putih	\N
83600K46N00PFW	Vario 110 FI (2014 - 2015)	4 kg	Putih	\N
83500K46N00PFW	Vario 110 FI (2014 - 2015)	4 kg	Putih	\N
64601K46N00VRD	Vario 110 eSP (2015 - 2019)	3 kg	Merah	\N
53204K46N20FMB	Vario 110 eSP (2015 - 2019)	0.5 kg	Hitam	\N
83751K46N00ZF	Vario 110 eSP (2015 - 2019)	0.5 kg	Merah	\N
83600K46N00ARM	Vario 110 eSP (2015 - 2019)	4 kg	Merah	\N
83500K46N00ARM	Vario 110 eSP (2015 - 2019)	6 kg	Merah	\N
83751K46N00ZH	Vario 110 eSP (2015 - 2019)	0.8 kg	Putih	\N
53208K59A70ZN	Vario 125 eSP K60R (2018 - 2022)	1 kg	Putih	\N
83600K59A70ZR	Vario 125 eSP K60R (2018 - 2022)	6 kg	Hitam	\N
81131K59A70ZQ	Vario 125 eSP K60R (2018 - 2022)	1.5 kg	Putih	\N
83500K59A70ZR	Vario 125 eSP K60R (2018 - 2022)	6 kg	Hitam	\N
64301K59A70ZQ	Vario 125 eSP K60R (2018 - 2022)	3 kg	Putih	\N
53205K25600VBM	BeAT Sporty eSP K25G (2014 - 2016)	3 kg	Biru	\N
83500K25900PFW	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	8 kg	Putih	\N
83600K25900PFW	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	8 kg	Putih	\N
83500K59A70ZP	Vario 150 eSP K59J (2018 - 2022)	8 kg	Putih	\N
83500K25900FMB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	8 kg	Hitam	\N
83750K59A70ZC	Vario 150 eSP K59J (2018 - 2022)	0.8 kg	Putih	\N
83600K59A70ZL	Vario 150 eSP K59J (2018 - 2022)	6 kg	Merah	\N
64360K59A70ZF	Vario 150 eSP K59J (2018 - 2022)	8 kg	Silver	\N
83500K59A70ZS	Vario 150 eSP K59J (2018 - 2022)	6 kg	Silver	\N
61100K59A70ZH	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Putih	\N
83165K64N00ASB	CBR 250RR K64 (2016 - 2020)	3 kg	Hitam	\N
64320K64N00ASB	CBR 250RR K64 (2016 - 2020)	6 kg	Hitam	\N
83500K81N00MGB	BeAT Sporty eSP K81 (2016 - 2020)	3.5 kg	Hitam	\N
64310K64N00RSW	CBR 250RR K64 (2016 - 2020)	6 kg	Putih	\N
64310K64N00ASB	CBR 250RR K64 (2016 - 2020)	6 kg	Hitam	\N
61100K46N00ZH	Vario 110 eSP (2015 - 2019)	5 kg	Putih	\N
83650K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Merah	\N
64401KZL930ZD	Spacy Karburator (2011 - 2013)	7 kg	Hitam	\N
61100K56N00FMB	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
33708K03N30ZC	Revo 110 FI (2014 - Sekarang)	3 kg	Hitam	\N
83610K97T00ZW	PCX 150 K97 (2017 - 2021)	10 kg	Gold	\N
81138K97T00ZS	PCX 150 K97 (2017 - 2021)	3 kg	Gold	\N
81139K97T00YA	PCX 150 K97 (2017 - 2021)	0.7 kg	Putih	\N
80151K93N00ZQ	Scoopy eSP K93 (2017 - 2020)	6 kg	Merah	\N
81138K97T00ZV	PCX 150 K97 (2017 - 2021)	3 kg	Putih	\N
53205K61900ZF	BeAT POP eSP K61 (2014 - 2019)	3 kg	Merah	\N
53205K61900WRD	BeAT POP eSP K61 (2014 - 2019)	3 kg	Merah	\N
80102K18900	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	2 kg	Hitam	\N
53205KVY910SBM	BeAT Karburator KVY (2008 - 2012)	3 kg	Biru	\N
53205KVR600DSM	Revo (2007 - 2009)	3 kg	Silver	\N
64340KYT900	Scoopy Karburator KYT (2010 - 2013)	7 kg	Hitam	\N
64410KTL690FMX	Revo (2007 - 2009)\nSupra FIT (2006 - 2007)	6 kg	Putih	\N
64410KVLN20FMB	Supra X 125 (2007 - 2014)	6 kg	Hitam	\N
64420KTL690FMX	Revo (2007 - 2009)\nSupra FIT (2006 - 2007)	6 kg	Putih	\N
83510KPH720FMB	\N	0.7 kg	Hitam	\N
83600KZL930ZD	Spacy Karburator (2011 - 2013)	6 kg	Merah	\N
83500KVB930FMB	Vario 110 CW (2006 - 2014)	6 kg	Hitam	\N
61302KSPB00FMB	Mega Pro New (2010 - 2014)	3 kg	Hitam	\N
64385KWC900AFB	CS1 KWC (2008 - 2013)	3 kg	Hitam	\N
64500KTL690FMX	Revo (2007 - 2009)\nSupra FIT (2006 - 2007)	1 kg	Putih	\N
8010AK16A40	Scoopy eSP K16R (2015 - 2017)	6 kg	Hitam	\N
64400K41N00ZC	Supra X 125 FI New (2014 - Sekarang)	6 kg	Hitam	\N
53205KYZ900ZB	Supra X 125 Helm-in Karburator (2011)	3 kg	Hitam	\N
53205KTM860FMB	Supra X 125 (2007 - 2014)	3 kg	Hitam	\N
54303K16900CSR	Scoopy FI K16G (2013 - 2015)	6 kg	Merah	\N
61100KVR600PEO	Revo (2007 - 2009)	5 kg	Oranye	\N
81141K16A20PMC	Scoopy FI K16G (2013 - 2015)	6 kg	Putih	\N
64301KVY960CSR	BeAT Karburator KVY (2008 - 2012)	6 kg	Merah	\N
64320K64N00MGB	CBR 250RR K64 (2016 - 2020)	5 kg	Hitam	\N
61100KVB930FMB	Vario 110 CW (2006 - 2014)	5 kg	Hitam	\N
53205K46N00FMB	Vario 110 FI (2014 - 2015)	3 kg	Hitam	\N
61100K07900ZE	Blade 110 K07A (2011 - 2014)\nSupra X 125 FI New (2014 - Sekarang)	5 kg	Hitam	\N
83500K59A10YC	Vario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
64490K56N10RSW	Supra GTR K56F (2016 - 2019)	1 kg	Putih	\N
64301K56N10ZL	Supra GTR K56F (2016 - 2019)	6 kg	Oranye	\N
83650K64N00AGM	CBR 250RR K64 (2016 - 2020)	4 kg	Silver	\N
64421K93N00ZM	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Biru	\N
83600K93N00ZL	Scoopy eSP K93 (2017 - 2020)	9 kg	Merah	\N
64201K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	3 kg	Silver	\N
64310K64N00AGM	CBR 250RR K64 (2016 - 2020)	6 kg	Silver	\N
64340K56N00NOR	Sonic 150R K56 (2015 - Sekarang)	4 kg	Oranye	\N
83175K64N00AGM	CBR 250RR K64 (2016 - 2020)	3 kg	Silver	\N
83165K64N00AGM	CBR 250RR K64 (2016 - 2020)	3 kg	Silver	\N
64320K64N00AFB	CBR 250RR K64 (2016 - 2020)	6 kg	Silver	\N
61100K64N00ZC	CBR 250RR K64 (2016 - 2020)	5 kg	Silver	\N
64320K56N00MGB	Sonic 150R K56 (2015 - Sekarang)	4 kg	Hitam	\N
64440K56N00RSW	Sonic 150R K56 (2015 - Sekarang)	5 kg	Putih	\N
64340K56N00SMM	Sonic 150R K56 (2015 - Sekarang)	5 kg	Magenta / Ungu / Pink	\N
61302K56N00NOR	Sonic 150R K56 (2015 - Sekarang)	0.2 kg	Oranye	\N
64301K56N10ZE	Supra GTR K56F (2016 - 2019)	6 kg	Putih	\N
83500K59A10WRD	Vario 125 eSP K60 (2015 - 2018)	5 kg	Merah	\N
83500K59A10AFB	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	5 kg	Hitam	\N
83750KVB930FMB	Vario 110 CW (2006 - 2014)	0.1 kg	Hitam	\N
53206K16900ZP	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.5 kg	Merah	\N
53205K16A00ZE	Scoopy FI K16G (2013 - 2015)	0.5 kg	Hitam	\N
53205KYT940DBM	Scoopy Karburator KYT (2010 - 2013)	1 kg	Biru	22 cmx 20 cmx 15 cm
83450K2VN50ZB	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Hitam	85 cmx 25 cmx 15 cm
84100K3VN00ZB	Stylo 160 (2024 - Sekarang)	2.3 kg	Hitam	37 cmx 38 cmx 10 cm
83750K3VN00ASB	Stylo 160 (2024 - Sekarang)	2.5 kg	Hitam	35 cmx 31 cmx 14 cm
64302K2VN30ZB	Vario 125 eSP K2V (2022 - Sekarang)	0.4 kg	Hitam	26 cmx 20 cmx 5 cm
53207K3VN00ASB	Stylo 160 (2024 - Sekarang)	1.4 kg	Hitam	27 cmx 24 cmx 13 cm
5061AKZLC30ZD	Spacy FI (2013 - 2018)	5 kg	Hitam	25 cmx 20 cmx 10 cm
83760K3VN00ZG	Stylo 160 (2024 - Sekarang)	0.075 kg	Hijau	18 cmx 5 cmx 5 cm
83760K3VN00ZE	Stylo 160 (2024 - Sekarang)	0.075 kg	Putih	18 cmx 5 cmx 5 cm
83760K3VN00ZB	Stylo 160 (2024 - Sekarang)	0.075 kg	Merah	18 cmx 5 cmx 5 cm
83760K3VN00ZA	Stylo 160 (2024 - Sekarang)	0.075 kg	Cream	18 cmx 5 cmx 5 cm
83610K3VN00ARE	Stylo 160 (2024 - Sekarang)	9.4 kg	Merah	95 cmx 33 cmx 18 cm
83550K1ZN40ZG	PCX 160 K1Z (2021 - Sekarang)	11 kg	Hitam	108 cmx 30 cmx 20 cm
83510K3VN00ARE	Stylo 160 (2024 - Sekarang)	9.4 kg	Merah	95 cmx 33 cmx 18 cm
81141K3VN00MPC	Stylo 160 (2024 - Sekarang)	10 kg	Putih	60 cmx 40 cmx 20 cm
81141K3VN00CGM	Stylo 160 (2024 - Sekarang)	10 kg	Hijau	60 cmx 40 cmx 20 cm
80151K3VN00ZA	Stylo 160 (2024 - Sekarang)	4 kg	Cream	31 cmx 25 cmx 20 cm
64601K3VN00ZE	Stylo 160 (2024 - Sekarang)	10 kg	Putih	80 cmx 32 cmx 25 cm
64601K3VN00ZD	Stylo 160 (2024 - Sekarang)	10 kg	Hitam	80 cmx 32 cmx 25 cm
64601K2SN00ZN	Vario 160 K2S (2022 - Sekarang)	2 kg	Biru	40 cmx 28 cmx 7 cm
64501K3VN00ZE	Stylo 160 (2024 - Sekarang)	10 kg	Putih	80 cmx 32 cmx 25 cm
64501K3VN00ZD	Stylo 160 (2024 - Sekarang)	10 kg	Hitam	80 cmx 32 cmx 25 cm
64501K2SN00ZN	Vario 160 K2S (2022 - Sekarang)	2 kg	Biru	40 cmx 28 cmx 7 cm
64400K64NR0ZA	CBR 250RR K64N (2022 - Sekarang)	8 kg	Biru, Merah	60 cmx 57 cmx 15 cm
64350K3VN00ZD	Stylo 160 (2024 - Sekarang)	3 kg	Hitam	65 cmx 15 cmx 6 cm
64302K3VN00MGB	Stylo 160 (2024 - Sekarang)	1.1 kg	Hitam	38 cmx 22 cmx 8 cm
64302K3VN00ARE	Stylo 160 (2024 - Sekarang)	1.1 kg	Merah	38 cmx 22 cmx 8 cm
61100K3VN00ZB	Stylo 160 (2024 - Sekarang)	5.6 kg	Merah	50 cmx 26 cmx 26 cm
61100K3VN00ZG	Stylo 160 (2024 - Sekarang)	5.6 kg	Hijau	50 cmx 26 cmx 26 cm
61100K3VN00ZE	Stylo 160 (2024 - Sekarang)	5.6 kg	Putih	50 cmx 26 cmx 26 cm
61000K1ZN30ZC	PCX 160 K1Z (2021 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	5 kg	Merah	50 cmx 30 cmx 20 cm
53205K3VN10ZB	Stylo 160 (2024 - Sekarang)	6.4 kg	Hitam	50 cmx 31 cmx 25 cm
53205K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	0.4 kg	Putih	\N
81130K2SN00ZL	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Putih	13 cmx 11 cmx 8 cm
84151K1ZJ10YJ	PCX 160 K1Z (2021 - Sekarang)	3.7 kg	Merah	58 cmx 48 cmx 8 cm
83615K64NA0ZC	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64N (2022 - Sekarang)	0.4 kg	Hitam	20 cmx 10 cmx 5 cm
83610K1ZJ10CAR	PCX 160 K1Z (2021 - Sekarang)	11 kg	Merah	108 cmx 30 cmx 20 cm
83510K1ZJ10MCO	PCX 160 K1Z (2021 - Sekarang)	11 kg	Silver	108 cmx 30 cmx 20 cm
83500K1AN00MJB	BeAT dan BeAT Street K1A (2020 - 2024)	4 kg	Coklat	82 cmx 27 cmx 10 cm
64431K1ZJ10YM	PCX 160 K1Z (2021 - Sekarang)	10 kg	Merah	92 cmx 35 cmx 20 cm
8114AKZR600ZB	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	4 kg	Hitam	46 cmx 44 cmx 12 cm
61200KWW640	Revo 110 FI (2014 - Sekarang)\nRevo 110 New (2010 - 2014)\nSupra X 125 FI New (2014 - Sekarang)	3.3 kg	Hitam	51 cmx 22 cmx 18 cm
81141K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Silver	23 cmx 15 cmx 9 cm
83510K0WNA0MFB	ADV 160 (2022 - Sekarang)	8 kg	Coklat	80 cmx 40 cmx 15 cm
81140K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	1.6 kg	Silver	36 cmx 20 cmx 14 cm
64420K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Silver	19 cmx 8 cmx 5 cm
61100KZL930ZH	Spacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)	5 kg	Hitam	56 cmx 25 cmx 18 cm
83610K0WNA0MDG	ADV 160 (2022 - Sekarang)	4 kg	Grey	80 cmx 20 cmx 15 cm
83510K1ZJ10MJB	PCX 160 K1Z (2021 - Sekarang)	11 kg	Coklat	108 cmx 30 cmx 20 cm
81140K1ZJ10YK	PCX 160 K1Z (2021 - Sekarang)	1.6 kg	Coklat	36 cmx 20 cmx 14 cm
81137K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	0.1 kg	Silver	15 cmx 8 cmx 4 cm
80151KVY900	BeAT Karburator KVY (2008 - 2012)	2 kg	Hitam	40 cmx 24 cmx 10 cm
64503K1ZJ10ZC	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Silver	20 cmx 8 cmx 3 cm
64501K1ZJ10YG	PCX 160 K1Z (2021 - Sekarang)	18 kg	Coklat	90 cmx 62 cmx 20 cm
64501K0WNA0ZG	ADV 160 (2022 - Sekarang)	12 kg	Grey	65 cmx 50 cmx 20 cm
64336K0WN00ZY	ADV 160 (2022 - Sekarang)	2 kg	Grey	38 cmx 32 cmx 10 cm
81141K1ZJ10YL	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Merah	23 cmx 15 cmx 9 cm
81139K0WN001AA	ADV 150 (2019 - 2022)	0.25 kg	Hitam	28 cmx 27 cmx 6 cm
61110K2VN10ZE	Vario 125 eSP K60R (2018 - 2022)	5 kg	Putih	50 cmx 30 cmx 20 cm
54302K16900PMC	Scoopy FI K16G (2013 - 2015)	5.2 kg	Cream	75 cmx 28 cmx 15 cm
81137K1ZJ10YL	PCX 160 K1Z (2021 - Sekarang)	0.05 kg	Merah	15 cmx 7 cmx 3 cm
64450K07900ZC	Blade 110 K07A (2011 - 2014)	4 kg	Hijau	70 cmx 40 cmx 10 cm
64431K0WN000AA	ADV 150 (2019 - 2022)	4 kg	Hitam	60 cmx 32 cmx 14 cm
61304KSPB00MTB	Mega Pro New (2010 - 2014)	1 kg	Hitam	27 cmx 20 cmx 12 cm
83450K2SH10ZC	Vario 160 K2S (2022 - Sekarang)	5.2 kg	Hitam	80 cmx 26 cmx 15 cm
64600K2SH10ZC	Vario 160 K2S (2022 - Sekarang)	2 kg	Hitam	40 cmx 25 cmx 7 cm
64600K2SH10ZB	Vario 160 K2S (2022 - Sekarang)	2 kg	Putih	40 cmx 28 cmx 7 cm
64480K07900ZD	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	0.2 kg	Hitam	10 cmx 11 cmx 8 cm
64330K47N00ZA	Blade 125 FI K47 (2014 - 2018)	5.7 kg	Putih	60 cmx 47 cmx 12 cm
50265KYE940ZD	Mega Pro FI (2014 - 2018)	2.2 kg	Silver	45 cmx 29 cmx 10 cm
61100K03N30ZF	Revo 110 FI (2014 - Sekarang)	6 kg	Hitam	60 cmx 30 cmx 20 cm
61100K41N00ZC	Supra X 125 FI New (2014 - Sekarang)	6 kg	Hitam	60 cmx 30 cmx 20 cm
61303K18900ZA	Verza 150 (2013 - 2018)	0.2 kg	Silver	24 cmx 10 cmx 3 cm
64301K16A00PMC	Scoopy FI K16G (2013 - 2015)	1.5 kg	Cream	45 cmx 25 cmx 8 cm
64325K07900ZC	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	5.7 kg	Putih	60 cmx 47 cmx 12 cm
17231KZLA00	Spacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)	0.85 kg	Hitam	42 cmx 15 cmx 8 cm
83500K1AN00MIB	BeAT dan BeAT Street K1A (2020 - 2024)	4 kg	Biru	82 cmx 27 cmx 10 cm
81140K0WN002AA	ADV 160 (2022 - Sekarang)	1.5 kg	Hitam	30 cmx 26 cmx 10 cm
64565K0WN000AA	ADV 150 (2019 - 2022)	1.2 kg	Hitam	37 cmx 25 cmx 8 cm
64421K0JN00MSG	Genio K0JN (2022 - Sekarang)	3 kg	Hijau	60 cmx 20 cmx 10 cm
53205K3VN00ZA	Stylo 160 (2024 - Sekarang)	6.4 kg	Cream	50 cmx 31 cmx 25 cm
64202K0JN00MSG	Genio K0JN (2022 - Sekarang)	3 kg	Hijau	60 cmx 20 cmx 10 cm
53208KYT900PFW	Scoopy Karburator KYT (2010 - 2013)	0.05 kg	Putih	10 cmx 3 cmx 2 cm
53205KZLA00ZE	Spacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)	7.2 kg	Hitam	48 cmx 45 cmx 20 cm
83750K16900ZD	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	2 kg	Cream	33 cmx 28 cmx 16 cm
83600K16900RSW	Scoopy eSP K16R (2015 - 2017)	8 kg	Putih	80 cmx 38 cmx 15 cm
83600K16900CSR	Scoopy FI K16G (2013 - 2015)	8 kg	Merah	80 cmx 38 cmx 15 cm
81141K0JN60ZA	Genio K0JN (2022 - Sekarang)	6.2 kg	Coklat	46 cmx 41 cmx 20 cm
81134K0JN00ZJ	Genio K0JN (2022 - Sekarang)	0.1 kg	Biru	12 cmx 8 cmx 3 cm
81131K0JN60ZC	Genio K0JN (2022 - Sekarang)	4 kg	Hitam	42 cmx 32 cmx 20 cm
64320K07900ZJ	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nBlade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	0.75 kg	Merah	35 cmx 26 cmx 5 cm
61100K18900ZA	Verza 150 (2013 - 2018)	6 kg	Merah	60 cmx 30 cmx 20 cm
61100K64N0020	CBR 250RR K64 (2016 - 2020)	6 kg	Hitam	60 cmx 30 cmx 20 cm
61100K16A00VBM	Scoopy FI K16G (2013 - 2015)	6 kg	Biru	60 cmx 30 cmx 20 cm
54303K16900RSW	Scoopy eSP K16R (2015 - 2017)	5.2 kg	Putih	75 cmx 28 cmx 15 cm
64400KYZ900ZA	Supra X 125 Helm-in Karburator (2011)	15.4 kg	Putih	60 cmx 77 cmx 20 cm
64400K41N00ZB	Supra X 125 FI New (2014 - Sekarang)	6.3 kg	Putih	60 cmx 42 cmx 15 cm
77250KYE900FMB	Mega Pro New (2010 - 2014)	1 kg	Hitam	45 cmx 12 cmx 10 cm
77240KSPB00FMB	Mega Pro New (2010 - 2014)	1 kg	Hitam	45 cmx 12 cmx 10 cm
64500K07900ZC	Blade 110 K07A (2011 - 2014)	3.5 kg	Putih	50 cmx 40 cmx 10 cm
64450K07900NOR	Blade 125 FI K47 (2014 - 2018)	4 kg	Oranye	70 cmx 40 cmx 10 cm
64431K16A40RSW	Scoopy eSP K16R (2015 - 2017)	3 kg	Putih	65 cmx 15 cmx 5 cm
64421K16900RSW	Scoopy eSP K16R (2015 - 2017)	3 kg	Putih	65 cmx 15 cmx 5 cm
64420K07900ZF	Blade 110 K07A (2011 - 2014)	5 kg	Hitam	85 cmx 25 cmx 15 cm
64410K07900ZF	Blade 110 K07A (2011 - 2014)	5 kg	Grey	85 cmx 25 cmx 15 cm
64410K07900ZB	Blade 110 K07A (2011 - 2014)	5 kg	Hitam	85 cmx 25 cmx 15 cm
64400K07900NOR	Blade 125 FI K47 (2014 - 2018)	4 kg	Oranye	70 cmx 40 cmx 10 cm
64380K41N00ZC	Supra X 125 FI New (2014 - Sekarang)	4 kg	Hitam	70 cmx 25 cmx 15 cm
64330K07900ZC	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	5.7 kg	Putih	60 cmx 47 cmx 12 cm
64330K03N30ZC	Revo 110 FI (2014 - Sekarang)	4 kg	Silver	55 cmx 42 cmx 10 cm
61100KYZ900ZF	Supra X 125 Helm-in Karburator (2011)	5 kg	Grey	60 cmx 21 cmx 18 cm
61316KYT940	Scoopy Karburator KYT (2010 - 2013)	0.250 kg	Hitam	26 cmx 12 cmx 2 cm
61314KCJ640	Tiger Revolution C (2012 - 2014)	0250 kg	Silver	22 cmx 20 cmx 5 cm
61313KCJ640	Tiger Revolution C (2012 - 2014)	0.250 kg	Putih	22 cmx 20 cmx 5 cm
53209K07900ZB	Blade 110 K07A (2011 - 2014)\nBlade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	0.364 kg	Silver	26 cmx 14 cmx 6 cm
53204K07900ZE	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	0.3 kg	Hijau	26 cmx 9 cmx 3 cm
53203K07900ZD	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	0.3 kg	Grey	26 cmx 9 cmx 3 cm
50260KYE940ZD	Mega Pro FI (2014 - 2018)	2.5 kg	Silver	43 cmx 32 cmx 10 cm
50260KYE940ZC	Mega Pro FI (2014 - 2018)	2.5 kg	Grey	43 cmx 32 cmx 10 cm
17220KCJ690	Tiger 2000 (1993 - 2006)	0.5 kg	Hitam	30 cmx 18 cmx 5 cm
83750K16900WRD	Scoopy FI K16G (2013 - 2015)	2 kg	Merah	34 cmx 23 cmx 14 cm
83650K1ZN40ZH	PCX 160 K1Z (2021 - Sekarang)	11 kg	Putih	100 cmx 30 cmx 20 cm
83500K16900CSR	Scoopy FI K16G (2013 - 2015)	5 kg	Merah	80 cmx 25 cmx 15 cm
77210K18900ZA	Verza 150 (2013 - 2018)	4 kg	Grey	75 cmx 25 cmx 10 cm
64560K03N30ZB	Revo 110 FI (2014 - Sekarang)	2 kg	Hitam	54 cmx 30 cmx 7 cm
64450K07900ZB	Blade 110 K07A (2011 - 2014)\nSupra X 125 FI New (2014 - Sekarang)	4 kg	Hitam	70 cmx 40 cmx 10 cm
64430K45N00WRD	CBR 150R K45A (2014 - 2016)	5.5 kg	Merah	55 cmx 30 cmx 20 cm
64400K07900ZC	Blade 110 K07A (2011 - 2014)	4 kg	Hijau	70 cmx 40 cmx 10 cm
64301K0JN60MIB	Genio K0JN (2022 - Sekarang)	5 kg	Biru	50 cmx 30 cmx 20 cm
64301K0JN60MJB	Genio K0JN (2022 - Sekarang)	5 kg	Coklat	50 cmx 30 cmx 20 cm
61100KZL930YB	Spacy Karburator (2011 - 2013)	5 kg	Biru	56 cmx 25 cmx 18 cm
61100KTM850FMX	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	5 kg	Putih	56 cmx 25 cmx 18 cm
61100K16A00WRD	Scoopy FI K16G (2013 - 2015)	5 kg	Merah	56 cmx 25 cmx 18 cm
53205K16900WRD	Scoopy FI K16G (2013 - 2015)	0.3 kg	Merah	22 cmx 14 cmx 9 cm
53204K07900ZD	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	0.3 kg	Grey	26 cmx 9 cmx 3 cm
53203K07900ZE	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	0.3 kg	Hijau	26 cmx 9 cmx 3 cm
84152K1ZJ10YJ	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Merah	15 cmx 15 cmx 4 cm
64430K41N00	Supra X 125 FI New (2014 - Sekarang)	0.8 kg	Hitam	44 cmx 27 cmx 4 cm
64200K45NX0ZB	CBR 150R K45R (2021 - Sekarang)	5.2 kg	Oranye	45 cmx 47 cmx 15 cm
61000K56H20ZB	Sonic 150R K56 (2015 - Sekarang)	5 kg	Magenta / Ungu / Pink	50 cmx 30 cmx 20 cm
53280K1AN00ZA	BeAT dan BeAT Street K1A (2020 - 2024)	0.4 kg	Hitam	22 cmx 20 cmx 15 cm
64210K64NP0ZF	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.2 kg	Hitam	45 cmx 47 cmx 15 cm
83110K45A60ZA	CBR 150R K45R (2021 - Sekarang)	3 kg	Merah	72 cmx 26 cmx 10 cm
64300K1AN00ZE	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Biru	47 cmx 39 cmx 40 cm
8010AKYZ910ZA	Supra X 125 Helm-in Karburator (2011)	16 kg	Hitam	80 cmx 40 cmx 30 cm
5320CK47N00ZA	Blade 125 FI K47 (2014 - 2018)	2.2 kg	Hitam	43 cmx 25 cmx 12 cm
64510K07900ZB	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nSupra X 125 FI New (2014 - Sekarang)	3 kg	Hitam	35 cmx 35 cmx 15 cm
64400K45NX0ZB	CBR 150R K45R (2021 - Sekarang)	8 kg	Oranye	60 cmx 57 cmx 15 cm
64310K64NP0ZD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Merah	81 cmx 35 cmx 10 cm
64350KYZ900	Supra X 125 Helm-In FI (2011 - 2018)\nSupra X 125 Helm-in Karburator (2011)	1.75 kg	Hitam	26 cmx 27 cmx 15 cm
8010AK07900	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nSupra X 125 FI New (2014 - Sekarang)	2.4 kg	Hitam	48 cmx 20 cmx 15 cm
6431AKZLA00ZA	Spacy Karburator (2011 - 2013)	5.1 kg	Hitam	55 cmx 40 cmx 15 cm
64320KWB920	Blade 110 KWB (2008 - 2011)	9.4 kg	Hitam	46 cmx 36 cmx 34 cm
6431BK47N00ZA	Blade 125 FI K47 (2014 - 2018)	14 kg	Hitam	70 cmx 40 cmx 30 cm
50280KSPB00	Mega Pro New (2010 - 2014)	1.5 kg	Hitam	41 cmx 20 cmx 14 cm
83130K45A50ZA	CBR 150R K45R (2021 - Sekarang)	0.4 kg	Hitam	20 cmx 10 cmx 5 cm
83110K45A80ZA	CBR 150R K45R (2021 - Sekarang)	6 kg	Hitam	60 cmx 20 cmx 10 cm
64701K0WN00	ADV 160 (2022 - Sekarang)	1.5 kg	Hitam	35 cmx 18 cmx 12 cm
64440K45A50ZD	CBR 150R K45R (2021 - Sekarang)	6.56 kg	Grey	82 cmx 48 cmx 10 cm
64300K45A50ZA	CBR 150R K45R (2021 - Sekarang)	8 kg	Hitam	60 cmx 57 cmx 15 cm
64200K45A50ZA	CBR 150R K45R (2021 - Sekarang)	5.2 kg	Merah	45 cmx 47 cmx 15 cm
53290K2SN00ZA	Vario 160 K2S (2022 - Sekarang)	2 kg	Hitam	25 cmx 20 cmx 10 cm
53205K1AN00ZT	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Silver	55 cmx 30 cmx 15 cm
83630K64NP0ZE	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Biru	50 cmx 25 cmx 15 cm
83165K64N00MAG	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	6 kg	Coklat	50 cmx 20 cmx 10 cm
81131K2VN30ZN	Vario 125 eSP K2V (2022 - Sekarang)	3 kg	Putih	40 cmx 30 cmx 14 cm
81131K2VN30ZJ	Vario 125 eSP K2V (2022 - Sekarang)	3 kg	Merah	40 cmx 30 cmx 14 cm
64320K64NP0ZF	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Putih	81 cmx 35 cmx 10 cm
64320K64NP0ZE	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Biru	81 cmx 35 cmx 10 cm
64320K64NP0ZC	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Hitam	81 cmx 35 cmx 10 cm
64310K64NP0ZF	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Putih	81 cmx 35 cmx 10 cm
64310K64NP0ZE	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Biru	81 cmx 35 cmx 10 cm
64310K64NP0ZC	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5 kg	Hitam	81 cmx 35 cmx 10 cm
61100K64NP0ZE	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.2 kg	Biru	52 cmx 24 cmx 25 cm
50400K16900	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.875 kg	Silver	30 cmx 35 cmx 5 cm
84151K1ZJ10YK	PCX 160 K1Z (2021 - Sekarang)	4 kg	Biru	60 cmx 40 cmx 10 cm
64330K47N00ZB	Blade 125 FI K47 (2014 - 2018)	5.7 kg	Silver	60 cmx 47 cmx 12 cm
83630K64NP0ZG	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Hitam	50 cmx 25 cmx 15 cm
83630K64NP0ZF	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Coklat	50 cmx 25 cmx 15 cm
83500K1AN00MSG	BeAT dan BeAT Street K1A (2020 - 2024)	4 kg	Hijau	82 cmx 27 cmx 10 cm
64432K1ZJ10YN	PCX 160 K1Z (2021 - Sekarang)	10 kg	Biru	92 cmx 35 cmx 20 cm
64420K1ZJ10YM	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Biru	19 cmx 8 cmx 5 cm
64240K45NZ0ZA	CBR 150R K45R (2021 - Sekarang)	0.7 kg	Hitam	\N
64330K64NP0MAG	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.5 kg	Hitam	55 cmx 30 cmx 20 cm
64305K1ZJ10YN	PCX 160 K1Z (2021 - Sekarang)	2 kg	Biru	41 cmx 45 cmx 5 cm
64210K64NP0ZH	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.2 kg	Hitam	45 cmx 47 cmx 15 cm
64210K64NP0ZG	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.2 kg	Hitam	45 cmx 47 cmx 15 cm
64210K64NP0ZE	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	5.2 kg	Biru	45 cmx 47 cmx 15 cm
64600K2SH00ZA	Vario 160 K2S (2022 - Sekarang)	2 kg	Merah	40 cmx 28 cmx 7 cm
81130K2FN80ZK	Scoopy K2F (2020 - Sekarang)	0.3 kg	Hitam	22 cmx 12 cmx 5 cm
83650K2FN00NOR	Scoopy K2F (2020 - Sekarang)	0.25 kg	Oranye	18 cmx 12 cmx 5 cm
83650K2FN00MGB	Scoopy K2F (2020 - Sekarang)	0.25 kg	Hitam	18 cmx 12 cmx 5 cm
83600K2VN30VRD	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Merah	85 cmx 25 cmx 15 cm
83500K2VN30VRD	Vario 125 eSP K2V (2022 - Sekarang)	5 kg	Merah	85 cmx 25 cmx 15 cm
83131K45NL0MGB	CBR 150R K45R (2021 - Sekarang)	0.25 kg	Hitam	17 cmx 18 cmx 4 cm
81142K2FN80ZL	Scoopy K2F (2020 - Sekarang)	0.3 kg	Putih	22 cmx 15 cmx 5 cm
81142K2FN80ZH	Scoopy K2F (2020 - Sekarang)	0.3 kg	Coklat	22 cmx 15 cmx 5 cm
64441K45NL0MBS	CBR 150R K45R (2021 - Sekarang)	5 kg	Silver	58 cmx 35 cmx 15 cm
64321K3BN00MMB	CB150X (2021 - Sekarang)	6 kg	Coklat	57 cmx 42 cmx 16 cm
53206K2FN00YA	Scoopy K2F (2020 - Sekarang)	0.2 kg	Putih	20 cmx 19 cmx 8 cm
40510KYE940	Mega Pro FI (2014 - 2018)	0.4 kg	Hitam	60 cmx 24 cmx 8 cm
35191KVG901	PCX 125 CBU (2010 - 2012)\nPCX 150 CBU (2012 - 2014)\nScoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.01 kg	Hitam	6 cmx 4 cmx 2 cm
50280K15710	CB150R StreetFire K15P (2021 - Sekarang)	2.2 kg	Hitam	45 cmx 29 cmx 10 cm
61000K45NM0ZA	CBR 150R K45R (2021 - Sekarang)	5 kg	Hitam	50 cmx 30 cmx 20 cm
53207K2FN00MSG	Scoopy K2F (2020 - Sekarang)	0.2 kg	Hijau	20 cmx 10 cmx 4 cm
84100KVB900ZA	Vario 110 CW (2006 - 2014)	1.5 kg	Silver	32 cmx 28 cmx 8 cm
77237KVBN50	Vario 110 Techno A (2009 - 2010)\nVario 110 Techno B (2010 - 2012)	0.1 kg	Hitam	10 cmx 8 cmx 3 cm
64340K47N00ZA	Blade 125 FI K47 (2014 - 2018)	2.5 kg	Hitam	48 cmx 27 cmx 10 cm
64300K1AN00ZG	BeAT dan BeAT Street K1A (2020 - 2024)	12 kg	Putih	47 cmx 39 cmx 40 cm
83751K46N00ZJ	Vario 110 eSP (2015 - 2019)	0.25 kg	Merah	26 cmx 14 cmx 4 cm
83600K3BN10ZA	CB150X (2021 - Sekarang)	2.08 kg	Hitam	60 cmx 26 cmx 8 cm
64440K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	5 kg	Hitam	50 cmx 50 cmx 10 cm
64340K56N00VRD	Sonic 150R K56 (2015 - Sekarang)	4 kg	Merah	50 cmx 48 cmx 10 cm
64380K07900ZB	Blade 110 K07A (2011 - 2014)	0.416 kg	Hitam	50 cmx 10 cmx 5 cm
61302K56N00ZG	Sonic 150R K56 (2015 - Sekarang)	0.3 kg	Merah	26 cmx 12 cmx 4 cm
84100KVBN50SBM	Vario 110 Techno A (2009 - 2010)\nVario 110 Techno B (2010 - 2012)	3 kg	Biru	35 cmx 35 cmx 15 cm
81130K2FN00ZM	Scoopy K2F (2020 - Sekarang)	0.3 kg	Silver	22 cmx 15 cmx 5 cm
64800K56N00	Sonic 150R K56 (2015 - Sekarang)	0.03 kg	Hitam	18 cmx 7 cmx 3 cm
17575K46N00	Vario 110 FI (2014 - 2015)	0.85 kg	Hitam	26 cmx 28 cmx 7 cm
64500K0WNB0ZD	ADV 160 (2022 - Sekarang)	12 kg	Merah	65 cmx 50 cmx 20 cm
17556K84610ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam, Merah	55 cmx 25 cmx 15 cm
17546K84610ZA	CRF150L K84 (2017 - Sekarang)	4 kg	Hitam, Merah	55 cmx 25 cmx 15 cm
83160K45A20ZA	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	66 cmx 22 cmx 20 cm
81131K59A70YF	Vario 150 eSP K59J (2018 - 2022)	3 kg	Hitam	40 cmx 30 cmx 14 cm
83450K2SH00ZC	Vario 160 K2S (2022 - Sekarang)	5.2 kg	Hitam	80 cmx 26 cmx 15 cm
83650K64NP0ZD	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.93 kg	Putih	35 cmx 20 cmx 8 cm
61100K59A70ZW	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	5 kg	Merah	56 cmx 25 cmx 18 cm
64350K0WNA0ZC	ADV 160 (2022 - Sekarang)	4.5 kg	Hitam	60 cmx 25 cmx 18 cm
64565K0WNA0ZB	ADV 160 (2022 - Sekarang)	0.3 kg	Silver	38 cmx 36 cmx 10 cm
64336K0WN00ZW	ADV 160 (2022 - Sekarang)	1.9 kg	Merah	36 cmx 32 cmx 10 cm
64530K0WNA0	ADV 160 (2022 - Sekarang)	5 kg	Hitam	50 cmx 25 cmx 8 cm
81142K2FN00ZX	Scoopy K2F (2020 - Sekarang)	0.3 kg	Oranye	22 cmx 15 cmx 5 cm
18612K64N00	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.06 kg	Hitam	13 cmx 7 cmx 2 cm
17234KVB900	Vario 110 CW (2006 - 2014)	0.2 kg	Hitam	19 cmx 13 cmx 10 cm
50265K15900ZE	CB150R StreetFire K15 (2012 - 2015)	1.2 kg	Merah	\N
64100K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	2 kg	Putih	40 cmx 40 cmx 8 cm
61110K1AN00ZH	BeAT dan BeAT Street K1A (2020 - 2024)	5.5 kg	Putih	52 cmx 25 cmx 25 cm
84100KVB900ZB	Vario 110 CW (2006 - 2014)	6 kg	Grey	55 cmx 45 cmx 15 cm
61110K1AN00ZJ	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	50 cmx 30 cmx 20 cm
61100K2FN00YB	Scoopy K2F (2020 - Sekarang)	5 kg	Hitam	56 cmx 25 cmx 18 cm
83120K45A40ZA	CBR 150R K45R (2021 - Sekarang)	6 kg	Grey	\N
61100K2FN00YC	Scoopy K2F (2020 - Sekarang)	5 kg	Hitam	56 cmx 25 cmx 18 cm
83650K2FN00VBE	Scoopy K2F (2020 - Sekarang)	0.25 kg	Cream	18 cmx 12 cmx 5 cm
83605K1AN00ZC	BeAT dan BeAT Street K1A (2020 - 2024)	4 kg	Hitam	82 cmx 27 cmx 10 cm
80100K15900	CB150R StreetFire K15 (2012 - 2015)\nCB150R StreetFire K15G (2015 - 2018)	9.1 kg	Hitam	76 cmx 30 cmx 40 cm
64411K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	8 kg	Merah	\N
64360K59A70ZP	Vario 150 eSP K59J (2018 - 2022)	3 kg	Merah	90 cmx 20 cmx 10 cm
64350K59A70ZP	Vario 150 eSP K59J (2018 - 2022)	3 kg	Merah	90 cmx 20 cmx 10 cm
64321K15720	CB150R StreetFire K15P (2021 - Sekarang)	1.4 kg	Hitam	37 cmx 18 cmx 12 cm
83151K45NL0MGB	CBR 150R K45R (2021 - Sekarang)	4.8 kg	Hitam	60 cmx 24 cmx 20 cm
64301K59A70YB	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	3 kg	Merah	53 cmx 38 cmx 8 cm
77230KSPB00	Mega Pro New (2010 - 2014)	0.08 kg	Hitam	13 cmx 11 cmx 2 cm
17225K50T00	BeAT Sporty eSP K25G (2014 - 2016)	0.423 kg	Hitam	23 cmx 19 cmx 19 cm
61303K15710ZA	CB150R StreetFire K15P (2021 - Sekarang)	0.2 kg	Hitam	24 cmx 10 cmx 5 cm
61100K59A70ZS	Vario 150 eSP K59J (2018 - 2022)	5 kg	Silver	56 cmx 25 cmx 18 cm
83750K0JN00MJB	Genio (2019 - 2022)	0.4 kg	Coklat	40 cmx 20 cmx 10 cm
64550K41N00	Supra X 125 FI New (2014 - Sekarang)	0.2 kg	Hitam	10 cmx 10 cmx 5 cm
86504K15710ZA	CB150R StreetFire K15P (2021 - Sekarang)	0.1 kg	Hitam, Merah	40 cmx 13 cmx 1 cm
86502K15710ZA	CB150R StreetFire K15P (2021 - Sekarang)	0.1 kg	Merah, Putih	40 cmx 13 cmx 1 cm
84151K1ZJ10ZJ	PCX 160 K1Z (2021 - Sekarang)	5 kg	Biru	55 cmx 40 cmx 8 cm
64301K64NA0ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3.2 kg	Hitam	80 cmx 30 cmx 8 cm
64301K64N61ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3.2 kg	Grey	80 cmx 30 cmx 8 cm
64302K64NB0ZB	CBR 250RR K64 (2016 - 2020)	6.56 kg	Hitam	82 cmx 48 cmx 10 cm
61000K45NM0ZB	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	50 cmx 30 cmx 20 cm
61000K1ZN30ZD	PCX 160 K1Z (2021 - Sekarang)	5 kg	Hitam	50 cmx 30 cmx 20 cm
64201K0JN00ZL	Genio (2019 - 2022)	1.5 kg	Putih	50 cmx 15 cmx 7 cm
83170K64N20ZA	CBR 250RR K64 (2016 - 2020)	6 kg	Merah	50 cmx 20 cmx 10 cm
64431K97T00YX	PCX 150 K97 (2017 - 2021)	10 kg	Biru	92 cmx 35 cmx 20 cm
64340K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	5 kg	Grey	50 cmx 50 cmx 10 cm
17576K2SN00	Vario 160 K2S (2022 - Sekarang)	0.007 kg	Hitam	9 cmx 9 cmx 5 cm
84151K97T00YX	PCX 150 K97 (2017 - 2021)	4 kg	Hitam	60 cmx 40 cmx 10 cm
83610K0WN00PFW	ADV 150 (2019 - 2022)	4 kg	Putih	85 cmx 22 cmx 11 cm
83600K59A10ZD	Vario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	4.3 kg	Putih	85 cmx 22 cmx 14 cm
83111K45NL0ZC	CBR 150R K45R (2021 - Sekarang)	6 kg	Grey	\N
53205K0JN00ZJ	Genio (2019 - 2022)	0.2 kg	Coklat	20 cmx 16 cmx 6 cm
53209K2SN00ZG	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam	20 cmx 9 cmx 3 cm
61100K97T00YS	PCX 150 K97 (2017 - 2021)	3 kg	Biru	37 cmx 20 cmx 22 cm
64432K97T00YX	PCX 150 K97 (2017 - 2021)	10 kg	Biru	90 cmx 40 cmx 18 cm
64301K0JN00MJB	Genio (2019 - 2022)	5 kg	Coklat	50 cmx 30 cmx 20 cm
64202K0JN00VWH	Genio (2019 - 2022)	2 kg	Putih	60 cmx 20 cmx 10 cm
64431K0JN00ZL	Genio (2019 - 2022)	3 kg	Silver	60 cmx 16 cmx 5 cm
64421K0JN00ZL	Genio (2019 - 2022)	3 kg	Silver	60 cmx 16 cmx 5 cm
64311K3BN00MCS	CB150X (2021 - Sekarang)	1.5 kg	Silver	35 cmx 28 cmx 10 cm
64421K3BN00VRD	CB150X (2021 - Sekarang)	6 kg	Merah	57 cmx 42 cmx 16 cm
64321K3BN00VRD	CB150X (2021 - Sekarang)	6 kg	Merah	57 cmx 42 cmx 16 cm
64441K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	58 cmx 35 cmx 15 cm
64341K45NL0ZD	CBR 150R K45R (2021 - Sekarang)	5 kg	Putih	58 cmx 35 cmx 15 cm
64305K97T00YX	PCX 150 K97 (2017 - 2021)	2 kg	Biru	44 cmx 45 cmx 5 cm
64305K97T00YY	PCX 150 K97 (2017 - 2021)	2 kg	Hitam	44 cmx 45 cmx 5 cm
83510K0WN00PFW	ADV 150 (2019 - 2022)	4 kg	Putih	80 cmx 25 cmx 15 cm
83500K2SN00MPC	Vario 160 K2S (2022 - Sekarang)	4 kg	Putih	80 cmx 20 cmx 15 cm
83151K45NL0WRD	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	65 cmx 25 cmx 18 cm
83110K45A40ZA	CBR 150R K45R (2021 - Sekarang)	3 kg	Grey	72 cmx 26 cmx 10 cm
81138K97T00YS	PCX 150 K97 (2017 - 2021)	0.6 kg	Hitam	27 cmx 17 cmx 8 cm
81137K1ZJ10ZR	PCX 160 K1Z (2021 - Sekarang)	0.08 kg	Hitam	8 cmx 4 cmx 3 cm
81137K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	0.08 kg	Merah	8 cmx 4 cmx 3 cm
81133K2SN00MSR	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Merah	13 cmx 11 cmx 8 cm
81133K2SN00MPC	Vario 160 K2S (2022 - Sekarang)	0.2 kg	Putih	13 cmx 11 cmx 8 cm
81131K0JN00ZG	Genio (2019 - 2022)	3 kg	Coklat	40 cmx 30 cmx 14 cm
80100K64N00ZA	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	1 kg	Hitam	30 cmx 20 cmx 10 cm
77210K18960MGB	CB150 Verza (2018 - Sekarang)	4 kg	Hitam	\N
64502K96V00YG	PCX 150 K97 (2017 - 2021)	18 kg	Biru	90 cmx 62 cmx 20 cm
64501K97T00A2	PCX 150 K97 (2017 - 2021)	18 kg	Hitam	90 cmx 62 cmx 20 cm
53205K2FN00MIB	Scoopy K2F (2020 - Sekarang)	1 kg	Biru	22 cmx 20 cmx 15 cm
83650K2FN00ASB	Scoopy K2F (2020 - Sekarang)	0.25 kg	Hitam	18 cmx 12 cmx 5 cm
83650K2FN00MSR	Scoopy K2F (2020 - Sekarang)	0.25 kg	Merah	18 cmx 12 cmx 5 cm
53207K1ZJ10FMB	PCX 160 K1Z (2021 - Sekarang)	0.05 kg	Hitam	10 cmx 10 cmx 4 cm
84152K97T00YW	PCX 150 K97 (2017 - 2021)	0.3 kg	Biru	15 cmx 15 cmx 4 cm
53205K2FN00MSS	Scoopy K2F (2020 - Sekarang)	1 kg	Silver	22 cmx 20 cmx 15 cm
53207K2FN00MJB	Scoopy K2F (2020 - Sekarang)	0.2 kg	Coklat	\N
64420K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Merah	19 cmx 8 cmx 5 cm
83131K45N40ZD	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.3 kg	Putih	20 cmx 16 cmx 4 cm
81141K1ZJ10ZP	PCX 160 K1Z (2021 - Sekarang)	0.3 kg	Merah	23 cmx 15 cmx 9 cm
81137K97T00YR	PCX 150 K97 (2017 - 2021)	0.05 kg	Biru	15 cmx 7 cmx 3 cm
81139K97T00YV	PCX 150 K97 (2017 - 2021)	0.2 kg	Biru	28 cmx 15 cmx 5 cm
83600K2FN00MIB	Scoopy K2F (2020 - Sekarang)	8 kg	Biru	80 cmx 38 cmx 15 cm
80151K2FN00ZP	Scoopy K2F (2020 - Sekarang)	6 kg	Silver	45 cmx 40 cmx 20 cm
80151K2FN00ZM	Scoopy K2F (2020 - Sekarang)	6 kg	Silver	45 cmx 40 cmx 20 cm
80151K2FN00ZK	Scoopy K2F (2020 - Sekarang)	6 kg	Merah	45 cmx 40 cmx 20 cm
80151K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	6 kg	Kuning	45 cmx 40 cmx 20 cm
64421K2FN00ZN	Scoopy K2F (2020 - Sekarang)	3 kg	Biru	60 cmx 16 cmx 5 cm
83650K1ZN30ZF	PCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)	11 kg	Hitam	108 cmx 30 cmx 20 cm
80103KVB900	Vario 110 CW (2006 - 2014)	0.1 kg	Hitam	20 cmx 13 cmx 2 cm
81200K25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	2 kg	Hitam	30 cmx 30 cmx 4 cm
80100K56N00	Sonic 150R K56 (2015 - Sekarang)	4 kg	Hitam	\N
64301K81N00MCS	BeAT Sporty eSP K81 (2016 - 2020)	11 kg	Silver	\N
53206K2FN00ZJ	Scoopy K2F (2020 - Sekarang)	1.5 kg	Cream	\N
81142K2FN00ZM	Scoopy K2F (2020 - Sekarang)	1 kg	Silver	\N
83171K45NL0ZB	CBR 150R K45R (2021 - Sekarang)	5 kg	Merah	\N
83171K45NL0ZA	CBR 150R K45R (2021 - Sekarang)	5 kg	Oranye	\N
83151K45NL0RSW	CBR 150R K45R (2021 - Sekarang)	6 kg	Putih	\N
50211KREG00	CRF150L K84 (2017 - Sekarang)	0.3 kg	Hitam	\N
17556K84970ZA	CRF150L K84 (2017 - Sekarang)	5 kg	Hijau	\N
17546K84970ZA	CRF150L K84 (2017 - Sekarang)	5 kg	Hijau	\N
83120K45NA0ZA	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	4 kg	Hitam	\N
64310K46N20ZA	Vario 110 FI (2014 - 2015)	11 kg	Hitam	\N
53205K1AN00ZJ	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Biru	\N
53207K1AN20ZA	BeAT dan BeAT Street K1A (2020 - 2024)	5 kg	Hitam	\N
80100K81N00ZA	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	5 kg	Hitam	\N
37241K18960	CB150 Verza (2018 - Sekarang)	0.5 kg	Hitam	\N
53140KEH600	Mega Pro Advance (2006 - 2010)	0.5 kg	Hitam	\N
61100K81N00ZH	BeAT Sporty eSP K81 (2016 - 2020)	6 kg	Silver	\N
64502K0WN01ZF	ADV 150 (2019 - 2022)	12 kg	Silver	65 cmx 50 cmx 20 cm
61100K16A00ZA	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	3 kg	Silver	\N
64340KVY700	BeAT Karburator KVY (2008 - 2012)	5 kg	Hitam	\N
8010AK15900	CB150R StreetFire K15 (2012 - 2015)	4 kg	Hitam	\N
50260K15600RSW	CB150R StreetFire K15G (2015 - 2018)	2 kg	Putih	40 cmx 40 cmx 10 cm
53207K0JN00ZA	Genio (2019 - 2022)	0.5 kg	Hitam	\N
8125AKYT940	Scoopy Karburator KYT (2010 - 2013)	6 kg	Hitam	\N
64505K97T00YK	PCX 150 K97 (2017 - 2021)	0.6 kg	Hitam	\N
84151K97T00YJ	PCX 150 K97 (2017 - 2021)	4 kg	Coklat	\N
64500K07900ZB	Blade 110 K07A (2011 - 2014)\nBlade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	5 kg	Hitam	\N
64601K46N00WRD	Vario 110 eSP (2015 - 2019)	3 kg	Merah	\N
64450K41N00ZC	Supra X 125 FI New (2014 - Sekarang)	5 kg	Hitam	\N
53250K0JN00ZB	Genio (2019 - 2022)	3 kg	Merah	\N
50202K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	0.5 kg	Hitam	\N
64223K1AN00	BeAT dan BeAT Street K1A (2020 - 2024)	2 kg	Hitam	\N
64505K97T00YL	PCX 150 K97 (2017 - 2021)	0.7 kg	Silver	\N
64506K97T00YK	PCX 150 K97 (2017 - 2021)	0.7 kg	Coklat	\N
83510K97T00YH	PCX 150 K97 (2017 - 2021)	12 kg	Coklat	\N
81141K97T00ZV	PCX 150 K97 (2017 - 2021)	1 kg	Coklat	\N
84152K97T00YK	PCX 150 K97 (2017 - 2021)	0.5 kg	Silver	\N
61100K0JN00VWH	Genio (2019 - 2022)	6 kg	Putih	\N
5032BK56N00	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
35191K44V01	Genio (2019 - 2022)\nVario 110 eSP (2015 - 2019)	0.2 kg	Hitam	\N
83520K0JN00ZF	Genio (2019 - 2022)	3 kg	Merah	\N
61000K0WN10ZA	ADV 150 (2019 - 2022)	5 kg	Putih	\N
53206K93N00ZR	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
8015BK07900	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	0.5 kg	Hitam	\N
64250K0JN10ZE	Genio (2019 - 2022)	6 kg	Merah	\N
5033AK56N00	Sonic 150R K56 (2015 - Sekarang)	0.8 kg	Hitam	\N
50311K97T00	PCX 150 K97 (2017 - 2021)	4 kg	Hitam	\N
64502K0WN00ZC	ADV 150 (2019 - 2022)	12 kg	Merah	65 cmx 50 cmx 20 cm
64502K0WN00ZA	ADV 150 (2019 - 2022)	12 kg	Coklat	65 cmx 50 cmx 20 cm
53205KVLN00WRD	Supra X 125 (2007 - 2014)	3 kg	Merah	\N
83650K56H30ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Putih	\N
83650K0WN10ZA	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
83550K0WN10ZA	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
83130K45NA0ZA	\N	0.5 kg	Hitam	\N
83600K0JN00HSM	Genio (2019 - 2022)	8 kg	Silver	\N
83600K0JN00PBL	Genio (2019 - 2022)	8 kg	Hitam	\N
83600K0JN00RSW	Genio (2019 - 2022)	8 kg	Putih	\N
83610K0WN00FMB	ADV 150 (2019 - 2022)	5 kg	Hitam	\N
83610K0WN00DSM	ADV 150 (2019 - 2022)	5 kg	Silver	\N
83500K0JN00RSW	Genio (2019 - 2022)	8 kg	Putih	\N
83500K0JN00VRD	Genio (2019 - 2022)	8 kg	Merah	\N
83650K93N00ZR	Scoopy eSP K93 (2017 - 2020)	1 kg	Putih	\N
83750K0JN00MBM	Genio (2019 - 2022)	4 kg	Coklat	\N
83750K0JN00PBL	Genio (2019 - 2022)	4 kg	Hitam	\N
83750K0JN00RSW	Genio (2019 - 2022)	4 kg	Putih	\N
83750K0JN00VRD	Genio (2019 - 2022)	4 kg	Merah	\N
81139K0WN00ZB	ADV 150 (2019 - 2022)	3 kg	Silver	\N
64501K0WN00ZC	ADV 150 (2019 - 2022)	12 kg	Merah	65 cmx 50 cmx 20 cm
64501K0WN00ZA	ADV 150 (2019 - 2022)	12 kg	Coklat	65 cmx 50 cmx 20 cm
64431K0JN00ZH	Genio (2019 - 2022)	3 kg	Biru	\N
64202K0JN00ZH	Genio (2019 - 2022)	3 kg	Biru	\N
81134K0JN00ZA	Genio (2019 - 2022)	3 kg	Coklat	\N
81131K0JN00ZF	Genio (2019 - 2022)	5 kg	Biru	\N
80151K93N00YB	Scoopy eSP K93 (2017 - 2020)	4 kg	Hitam	\N
61100K93N00ZY	Scoopy eSP K93 (2017 - 2020)	3 kg	Merah	\N
61100K0JN00RSW	Genio (2019 - 2022)	3 kg	Putih	\N
64301K0JN00RSW	Genio (2019 - 2022)	5 kg	Putih	\N
53206K0JN00VRD	Genio (2019 - 2022)	0.5 kg	Merah	\N
53206K0JN00PBL	Genio (2019 - 2022)	0.5 kg	Hitam	\N
53206K0JN00ARB	Genio (2019 - 2022)	0.5 kg	Biru	\N
53205K0JN00ZB	Genio (2019 - 2022)	0.5 kg	Merah	\N
53205K0JN00ZD	Genio (2019 - 2022)	0.5 kg	Putih	\N
64336K0WN00ZA	ADV 150 (2019 - 2022)	3.5 kg	Coklat	\N
64336K0WN00ZF	ADV 150 (2019 - 2022)	3.5 kg	Silver	\N
64310K56NF0ZA	Sonic 150R K56 (2015 - Sekarang)	4 kg	Merah	\N
83130K45N40ZB	CBR 150R K45G (2016 - 2018)	0.3 kg	Hitam	\N
64410K56NH0ZA	Sonic 150R K56 (2015 - Sekarang)	4 kg	Hitam	\N
64310K56NH0ZA	Sonic 150R K56 (2015 - Sekarang)	4 kg	Hitam	\N
64310K56H90ZB	Sonic 150R K56 (2015 - Sekarang)	4 kg	Hitam	\N
64410K56H90ZB	Sonic 150R K56 (2015 - Sekarang)	4 kg	Hitam	\N
64410K45N60ZA	CBR 150R K45G (2016 - 2018)	6 kg	Merah	\N
64306K0WN10ZB	ADV 150 (2019 - 2022)	6 kg	Merah	\N
64310K45N60ZA	CBR 150R K45G (2016 - 2018)	6 kg	Merah	\N
64310K45N40ZA	CBR 150R K45G (2016 - 2018)	6 kg	Hitam	\N
64405K56NG0ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
64305K56NG0ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
83130K45NH0ZA	CBR 150R K45G (2016 - 2018)	0.4 kg	Hitam	\N
83650K56NF0ZB	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
83650K56NF0ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
83600K56NH0ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
83600K56NF0ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
64305K56H60ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
61100K59A10FMB	Vario 125 eSP K60 (2015 - 2018)	3.5 kg	Hitam	\N
83650K56H00ZC	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
83600K56H00ZB	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
64440K45N40ZB	CBR 150R K45G (2016 - 2018)	6.56 kg	Hitam	82 cmx 48 cmx 10 cm
64410K56N70ZA	Sonic 150R K56 (2015 - Sekarang)	4 kg	Hitam	\N
64410K56N20ZA	Sonic 150R K56 (2015 - Sekarang)	4 kg	Oranye	\N
61000K56N20ZA	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
61000K56N00ZB	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
64340K45N50ZA	CBR 150R K45G (2016 - 2018)	3 kg	Putih	\N
64410K45N50ZA	CBR 150R K45N (2018 - 2020)	14 kg	Oranye, Putih	\N
83175K64N00NOR	CBR 250RR K64 (2016 - 2020)	1.5 kg	Oranye	\N
83130K45N50ZA	CBR 150R K45N (2018 - 2020)	0.6 kg	Putih	\N
64310K56N20ZA	Sonic 150R K56 (2015 - Sekarang)	5 kg	Oranye	\N
81131K59A70YC	Vario 150 eSP K59J (2018 - 2022)	1.5 kg	Biru	\N
64360K59A70ZM	Vario 150 eSP K59J (2018 - 2022)	4 kg	Biru	\N
53208K59A70YC	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.6 kg	Biru	\N
83600K59A70ZY	Vario 150 eSP K59J (2018 - 2022)	4.5 kg	Coklat	\N
83500K59A70ZY	Vario 150 eSP K59J (2018 - 2022)	4.5 kg	Coklat	\N
64301K59A70YA	Vario 150 eSP K59J (2018 - 2022)	3 kg	Coklat	\N
61304K56N00ABM	Sonic 150R K56 (2015 - Sekarang)	1.5 kg	Hitam	\N
53208K59A70YA	Vario 150 eSP K59J (2018 - 2022)	0.6 kg	Coklat	\N
61100K25600ZC	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	5 kg	Biru	\N
83600K81N00MGB	BeAT Sporty eSP K81 (2016 - 2020)	3.5 kg	Hitam	\N
64320K56N00WRD	Sonic 150R K56 (2015 - Sekarang)	2 kg	Merah	\N
61100K56N00ZE	Sonic 150R K56 (2015 - Sekarang)	3 kg	Hitam	\N
64420K56N00VRD	Sonic 150R K56 (2015 - Sekarang)	3 kg	Merah	\N
83165K64N00MSR	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	3 kg	Merah	\N
77237K59A70	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.4 kg	Hitam	\N
64300K45N40ZA	CBR 150R K45N (2018 - 2020)	2.5 kg	Putih	\N
77210K18960INS	CB150 Verza (2018 - Sekarang)	4 kg	Silver	\N
61100K18900ZD	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	4 kg	Hitam	\N
50270K18960FMB	CB150 Verza (2018 - Sekarang)	1.5 kg	Hitam	\N
50260K18960FMB	CB150 Verza (2018 - Sekarang)	1.5 kg	Hitam	\N
83165K64N00FMB	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)	3 kg	Hitam	\N
83450K64K00BGL	CBR 250RR K64 (2016 - 2020)	4 kg	Hitam	\N
83500K46N00RSW	Vario 110 eSP (2015 - 2019)	6 kg	Putih	\N
64501K46N00PFW	Vario 110 FI (2014 - 2015)	3 kg	Putih	\N
64410K45N40ZA	CBR 150R K45G (2016 - 2018)	6 kg	Hitam	\N
83750K46N00ZB	Vario 110 FI (2014 - 2015)	0.5 kg	Putih	\N
83600K46N00CSR	Vario 110 FI (2014 - 2015)	4 kg	Merah	\N
83500K46N00CSR	Vario 110 FI (2014 - 2015)	4 kg	Merah	\N
53205K46N20ARM	Vario 110 eSP (2015 - 2019)	3 kg	Merah	\N
83500K46N00FMB	Vario 110 FI (2014 - 2015)	6 kg	Hitam	\N
53205K46N20RSW	Vario 110 eSP (2015 - 2019)	3 kg	Putih	\N
83600K59A70ZQ	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	4 kg	Putih	\N
53205K25900VBM	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	3 kg	Biru	\N
83500KVY960FMB	BeAT Karburator KVY (2008 - 2012)	6 kg	Hitam	\N
83600KVY960FMB	BeAT Karburator KVY (2008 - 2012)	6 kg	Hitam	\N
83500K59A70ZM	Vario 125 eSP K60R (2018 - 2022)	6 kg	Merah	\N
83600K59A70ZM	Vario 125 eSP K60R (2018 - 2022)	6 kg	Merah	\N
53208K59A70ZL	Vario 125 eSP K60R (2018 - 2022)	1.5 kg	Merah	\N
83600K25900AFB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	8 kg	Hitam	\N
83500K25900AFB	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	3 kg	Hitam	\N
64301K25900BLG	BeAT FI K25 (2012 - 2014)	11 kg	Hijau	\N
64301K59A70ZS	Vario 150 eSP K59J (2018 - 2022)	2 kg	Silver	\N
64360K59A70ZD	Vario 150 eSP K59J (2018 - 2022)	15 kg	Merah	\N
83600K59A70ZS	Vario 150 eSP K59J (2018 - 2022)	6 kg	Silver	\N
53205K61900ZD	BeAT POP eSP K61 (2014 - 2019)	5 kg	Biru	\N
81142K93N00ZJ	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Putih	\N
64506K97T00ZW	PCX 150 K97 (2017 - 2021)	0.5 kg	Gold	\N
81137K97T00ZS	PCX 150 K97 (2017 - 2021)	0.1 kg	Gold	\N
81141K97T00ZK	PCX 150 K97 (2017 - 2021)	0.5 kg	Gold	\N
83510K97T00ZN	PCX 150 K97 (2017 - 2021)	10 kg	Hitam	\N
83750K93N00ZN	Scoopy eSP K93 (2017 - 2020)	0.4 kg	Putih	\N
83500K61900FMB	BeAT POP eSP K61 (2014 - 2019)	6 kg	Hitam	\N
53205K61900VBM	BeAT POP eSP K61 (2014 - 2019)	3 kg	Biru	\N
83600K61900FMB	BeAT POP eSP K61 (2014 - 2019)	6 kg	Hitam	\N
80110K84900ZB	CRF150L K84 (2017 - Sekarang)	7 kg	Merah	\N
83600KZL930ZE	Spacy Karburator (2011 - 2013)	6 kg	Hitam	\N
64421K16900VBM	Scoopy FI K16G (2013 - 2015)	3 kg	Biru	\N
61302K15900ZA	CB150R StreetFire K15 (2012 - 2015)	1 kg	Silver	\N
80121KC5010	\N	0.5 kg	Hitam	\N
53205KEV830FMB	Supra (1997 - 2002)	3 kg	Hitam	\N
53205KPH890FMH	Karisma (2002 - 2005)	3 kg	Silver	\N
53205KVLN00POV	Supra X 125 Injection (2007 - 2014)	3 kg	Hitam	\N
53205KZLA00ZA	Spacy Karburator (2011 - 2013)	3 kg	Hijau	\N
53205KFVB50FMB	Legenda (2001 - 2004)	3 kg	Hitam	\N
53205KTM860FMH	Supra X 125 (2007 - 2014)	3 kg	Hitam, Silver	\N
64301KVB930JGM	Vario 110 CW (2006 - 2014)	8 kg	Hijau	\N
64301KVBN50AFB	Vario 110 Techno A (2009 - 2010)	8 kg	Hitam	\N
50260KBW900BNS	Tiger 2000 (1993 - 2006)	3 kg	Biru, Hitam	\N
8010AKWB920	Blade 110 KWB (2008 - 2011)	7 kg	Hitam	\N
64410KTL690FMH	Revo (2007 - 2009)\nSupra FIT (2006 - 2007)	6 kg	Silver	\N
64420KTL690FMH	Revo (2007 - 2009)\nSupra FIT (2006 - 2007)	6 kg	Silver	\N
64420KYZ900ZA	Supra X 125 Helm-in Karburator (2011)	6 kg	Hitam	\N
53205K46N00CSR	Vario 110 FI (2014 - 2015)	3 kg	Merah	\N
64450KTL690FMT	Revo (2007 - 2009)	6 kg	Biru	\N
64455KPH700	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	0.7 kg	Silver	\N
64470KWWA60	Revo 110 New (2010 - 2014)	2 kg	Hitam	\N
35194K35V31	ADV 150 (2019 - 2022)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nPCX 150 K97 (2017 - 2021)\nScoopy K2F (2020 - Sekarang)\nVario 150 eSP K59J (2018 - 2022)	0.1 kg	Hitam, Silver	\N
35121K59A71	Vario 150 eSP K59J (2018 - 2022)	0.2 kg	Hitam	\N
35111K59A71	Scoopy K2F (2020 - Sekarang)\nVario 150 eSP K59J (2018 - 2022)	0.2 kg	Hitam	\N
35010K81N00	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.5 kg	Hitam	\N
35121K84901	CRF150L K84 (2017 - Sekarang)	0.2 kg	Hitam	\N
35111K2SN01	Vario 160 K2S (2022 - Sekarang)	0.1 kg	Hitam	5 cmx 4 cmx 3 cm
3501AK60B00	Vario 125 eSP K60 (2015 - 2018)	1 kg	Silver	\N
3501AK59A10	Vario 150 eSP K59 (2015 - 2018)	0.6 kg	Hitam	\N
35010K25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)	0.5 kg	Hitam, Silver	\N
3501AKZR600	Vario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	1 kg	Silver	\N
35010K1AN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nScoopy K2F (2020 - Sekarang)	2 kg	Hitam	\N
35101K97T01	ADV 150 (2019 - 2022)\nPCX 150 K97 (2017 - 2021)	0.6 kg	Hitam	\N
35115K59A11	Vario 150 eSP K59 (2015 - 2018)	0.1 kg	Hitam, Silver	\N
35100K84901	CRF150L K84 (2017 - Sekarang)	2 kg	Silver	\N
35100K59A71	Vario 150 eSP K59J (2018 - 2022)	0.7 kg	Hitam	\N
35010K56N00	Sonic 150R K56 (2015 - Sekarang)	0.5 kg	Silver	\N
35100K1AN01	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nScoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
35010K25610	BeAT Sporty eSP K25G (2014 - 2016)	1 kg	Silver	\N
3501AK93N00	Scoopy eSP K93 (2017 - 2020)	0.8 kg	Hitam	\N
3501AKZRB20	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)	0.5 kg	Hitam, Silver	\N
35141K59A71	Vario 150 eSP K59J (2018 - 2022)	0.7 kg	Hitam	\N
35121KVY900	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nPCX 125 CBU (2010 - 2012)\nScoopy eSP K93 (2017 - 2020)	0.2 kg	Hitam	\N
35101K59A71	Vario 150 eSP K59J (2018 - 2022)	1 kg	Hitam, Silver	\N
35010K41N00	Supra X 125 FI New (2014 - Sekarang)	0.5 kg	Hitam, Silver	\N
35010K56N10	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	0.5 kg	Hitam	\N
35010K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	0.6 kg	Hitam	\N
35010K45N00	CBR 150R K45A (2014 - 2016)	0.6 kg	Hitam, Silver	\N
35141K2FN11	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
72147K93N02	Scoopy eSP K93 (2017 - 2020)\nScoopy K2F (2020 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)	0.3 kg	Hitam	\N
35010KVB930	Vario 110 CW (2006 - 2014)	0.3 kg	Hitam	\N
35010K45N40	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.6 kg	Hitam	\N
35100K59A72	Vario 150 eSP K59J (2018 - 2022)	0.7 kg	Hitam, Silver	15 cmx 12 cmx 8 cm
35121K97N00	PCX 150 K97 (2017 - 2021)	0.6 kg	Hitam	\N
35010KVLN00	Supra X 125 (2007 - 2014)	0.3 kg	Hitam	\N
35141K97N00	PCX 150 K97 (2017 - 2021)	0.5 kg	Hitam	\N
35010K25600	BeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)	0.6 kg	Hitam, Silver	23 cmx 20 cmx 5 cm
35194K53D01	Vario 150 eSP K59J (2018 - 2022)	0.1 kg	Hitam, Silver	\N
35010GN5830	Grand Impressa (1991 - 2000)\nLegenda (2001 - 2004)	0.3 kg	Hitam	\N
35110K0JN01	Genio (2019 - 2022)	0.3 kg	Hitam	\N
35121K45N40	CB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	0.2 kg	Hitam	\N
35010KWWA60	Revo 110 New (2010 - 2014)	1 kg	Silver	\N
3510AK46N00	Vario 110 FI (2014 - 2015)	1 kg	Silver	\N
35010KVBN50	Vario 110 Techno A (2009 - 2010)	0.3 kg	Hitam	\N
35141K2SN01	Vario 160 K2S (2022 - Sekarang)	0.12 kg	Hitam	10 cmx 4 cmx 2 cm
35010KTM780	Supra X 125 Injection (2007 - 2014)	1 kg	Silver	\N
35194K1ZJ11	ADV 160 (2022 - Sekarang)\nPCX 160 K1Z (2021 - Sekarang)\nScoopy K2F (2020 - Sekarang)\nStylo 160 (2024 - Sekarang)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.05 kg	Silver	10 cmx 10 cmx 3 cm
35121K1AN00	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nScoopy K2F (2020 - Sekarang)	0.1 kg	Hitam	\N
35100GN5830	Grand Impressa (1991 - 2000)	0.6 kg	Silver	\N
3501AK16A40	Scoopy eSP K16R (2015 - 2017)	0.5 kg	Hitam	\N
35111K0WN02	ADV 150 (2019 - 2022)	0.04 kg	Hitam	7 cmx 3 cmx 2 cm
35100K2SN01	Scoopy K2F (2020 - Sekarang)\nStylo 160 (2024 - Sekarang)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.6 kg	Hitam	16 cmx 9 cmx 8 cm
3510AK46N20	Vario 110 eSP (2015 - 2019)	0.5 kg	Hitam	\N
3501AKZRB11	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)	0.5 kg	Hitam, Silver	\N
35010KYT940	Scoopy Karburator KYT (2010 - 2013)	0.5 kg	Hitam, Silver	\N
64315KWW660	Revo 110 FI (2014 - Sekarang)\nRevo 110 New (2010 - 2014)	0.02 kg	Hitam	7 cmx 6 cmx 2 cm
35100K1ZU11	PCX 160 K1Z (2021 - Sekarang)	0.6 kg	Hitam	16 cmx 9 cmx 8 cm
35110K46N01	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Hitam	\N
35101K2SN01	BeAT dan BeAT Street K1AL (2024 - Sekarang)\nScoopy K2F (2020 - Sekarang)\nStylo 160 (2024 - Sekarang)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.48 kg	Hitam	27 cmx 9 cmx 5 cm
35101K1ZU11	PCX 160 K1Z (2021 - Sekarang)	0.52 kg	Hitam	14 cmx 8 cmx 8 cm
35101K46N01	Scoopy eSP K93 (2017 - 2020)\nVario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.3 kg	Hitam	\N
35010KVY960	BeAT Karburator KVY (2008 - 2012)	0.5 kg	Hitam	\N
35010K03N31	Revo 110 FI (2014 - Sekarang)	0.5 kg	Hitam, Silver	\N
35010K64N00	CBR 250RR K64 (2016 - 2020)	1 kg	Hitam	\N
35012K45N40	CB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)\nCBR 150R K45N (2018 - 2020)	0.4 kg	Hitam	\N
35010KEV650	Supra (1997 - 2002)\nSupra FIT (2006 - 2007)	0.3 kg	Hitam	\N
35010KZLA00	Spacy Karburator (2011 - 2013)	0.3 kg	Hitam	\N
35141K0WNA0	ADV 160 (2022 - Sekarang)	0.2 kg	Hitam	17 cmx 15 cmx 5 cm
35101K2FN11	Scoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
35010K15921	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam, Silver	\N
35010K15901	CB150R StreetFire K15 (2012 - 2015)	0.5 kg	Silver	\N
35110K60B61	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)	0.26 kg	Hitam	9 cmx 9 cmx 5 cm
35010K84901	CRF150L K84 (2017 - Sekarang)	1 kg	Hitam	22 cmx 10 cmx 13 cm
35010KWB920	Blade 110 KWB (2008 - 2011)\nRevo 110 New (2010 - 2014)	0.5 kg	Hitam	\N
35010KYZ710	Supra X 125 Helm-in Karburator (2011)	0.5 kg	Hitam	\N
35010KWWA00	Revo 110 (2009 - 2010)\nRevo 110 New (2010 - 2014)	0.5 kg	Hitam, Silver	\N
35012K59A11	Vario 150 eSP K59 (2015 - 2018)	0.6 kg	Hitam	15 cmx 10 cmx 5 cm
35141K1ZN20	PCX 160 K1Z (2021 - Sekarang)	0.2 kg	Hitam	17 cmx 15 cmx 5 cm
35100K64N01	CBR 250RR K64 (2016 - 2020)	0.4 kg	Hitam	\N
35100K45N41	CBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	1 kg	Hitam	\N
38420K46N01	Vario 110 FI (2014 - 2015)	0.15 kg	Hitam	5 cmx 3 cmx 2 cm
35010KVR600	Revo (2007 - 2009)	0.5 kg	Hitam	\N
35010K41N20	Supra X 125 FI New (2014 - Sekarang)	0.5 kg	Hitam, Silver	\N
35141K2VN40	Vario 125 eSP K2V (2022 - Sekarang)	0.15 kg	Hitam	9 cmx 7 cmx 3 cm
35121K56N00	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150X (2021 - Sekarang)\nSonic 150R K56 (2015 - Sekarang)	0.035 kg	Hitam	9 cmx 4 cmx 2 cm
35121K1ZN20	PCX 160 K1Z (2021 - Sekarang)	0.1 kg	Hitam	5 cmx 3 cmx 2 cm
35110K59A12	Supra GTR K56F (2016 - 2019)\nVario 125 eSP K60 (2015 - 2018)	0.25 kg	Hitam	11 cmx 12 cmx 5 cm
77240KTM851	BeAT FI K25 (2012 - 2014)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nBlade 110 KWB (2008 - 2011)\nCB150 Verza (2018 - Sekarang)\nRevo 110 FI (2014 - Sekarang)\nSupra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)\nVerza 150 (2013 - 2018)	0.15 kg	Silver	\N
35110K81N01	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	1 kg	Hitam	\N
35010KCJ690	Tiger 2000 (1993 - 2006)	0.5 kg	Hitam	\N
35010K18901	Verza 150 (2013 - 2018)	0.6 kg	Hitam, Silver	\N
35121K46N00	Scoopy eSP K93 (2017 - 2020)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59 (2015 - 2018)	0.03 kg	Hitam	8 cmx 3 cmx 1 cm
35100K2FN12	Scoopy K2F (2020 - Sekarang)	0.7 kg	Hitam, Silver	16 cmx 12 cmx 8 cm
35010K41N21	Supra X 125 FI New (2014 - Sekarang)	0.8 kg	Hitam	20 cmx 14 cmx 7 cm
17620K84902	CB150 Verza (2018 - Sekarang)\nCRF150L K84 (2017 - Sekarang)	0.4 kg	Hitam	11 cmx 11 cmx 7 cm
35010K03N50	Revo 110 FI (2014 - Sekarang)	0.5 kg	Hitam	\N
35010KPH900	Karisma (2002 - 2005)	0.3 kg	Hitam	\N
35110KWWA01	Revo 110 FI (2014 - Sekarang)\nScoopy Karburator KYT (2010 - 2013)\nVario 110 Techno A (2009 - 2010)\nVario 110 Techno B (2010 - 2012)	0.2 kg	Hitam, Silver	9 cmx 9 cmx 5 cm
35121K0WNA0	ADV 160 (2022 - Sekarang)\nPCX 160 K1Z (2021 - Sekarang)	0.05 kg	Hitam	8 cmx 3 cmx 2 cm
35110K1AN01	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nScoopy K2F (2020 - Sekarang)	2 kg	Hitam	\N
35010K0JN00	Genio (2019 - 2022)	1 kg	Hitam	\N
35110K56N02	CB150R StreetFire K15M (2018 - 2021)	1 kg	Hitam	\N
35010KEV950	Supra (1997 - 2002)\nSupra FIT (2006 - 2007)	0.5 kg	Hitam	\N
35141K97N32	PCX 150 K97 (2017 - 2021)	0.2 kg	Hitam	17 cmx 15 cmx 5 cm
35111K97N02	PCX 150 K97 (2017 - 2021)	0.04 kg	Hitam, Putih	7 cmx 5 cmx 2 cm
17620KEH601	Mega Pro Advance (2006 - 2010)	0.264 kg	Hitam, Silver	9 cmx 9 cmx 5 cm
35010KYZ900	Supra X 125 Helm-in Karburator (2011)	0.5 kg	Hitam, Silver	\N
3501AK16A00	Scoopy FI K16G (2013 - 2015)	0.5 kg	Hitam, Silver	\N
35141K2VV10	Vario 125 eSP K2V (2022 - Sekarang)	0.13 kg	Hitam	10 cmx 7 cmx 4 cm
35141K1ZN40	PCX 160 K1Z (2021 - Sekarang)	0.15 kg	Hitam	14 cmx 12 cmx 4 cm
35010KYE940	Mega Pro FI (2014 - 2018)\nRevo 110 FI (2014 - Sekarang)	0.6 kg	Hitam, Silver	21 cmx 17 cmx 15 cm
35121K2VN40	Vario 125 eSP K2V (2022 - Sekarang)	0.035 kg	Hitam	7 cmx 3 cmx 2 cm
35011KVY900	BeAT Karburator KVY (2008 - 2012)\nSpacy Karburator (2011 - 2013)	0.25 kg	Hitam, Silver	9 cmx 9 cmx 4 cm
35010K18900	Verza 150 (2013 - 2018)	0.9 kg	Silver	22 cmx 9 cmx 14 cm
35121KWWA00	Revo 110 FI (2014 - Sekarang)\nScoopy FI K16G (2013 - 2015)\nVario 110 Techno A (2009 - 2010)\nVario 110 Techno B (2010 - 2012)	0.03 kg	Hitam	9 cmx 4 cmx 2 cm
35101K1ZJ11	ADV 160 (2022 - Sekarang)	0.52 kg	Hitam	14 cmx 8 cmx 8 cm
35121K59A10	Vario 150 eSP K59 (2015 - 2018)	0.05 kg	Hitam	9 cmx 4 cmx 2 cm
35141K0WN02	ADV 150 (2019 - 2022)	0.2 kg	Hitam	17 cmx 15 cmx 5 cm
77239KVB900	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)\nCBR 150R CBU KPP (2011 - 2013)\nCBR 150R K45A (2014 - 2016)\nCBR 250R K33A (2014 - 2016)\nCS1 KWC (2008 - 2013)\nSupra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)\nVario 110 CW (2006 - 2014)	0.5 kg	Hitam	\N
35101K1AN01	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nScoopy K2F (2020 - Sekarang)	1 kg	Hitam	\N
35101K0JN01	Genio (2019 - 2022)	3 kg	Hitam	\N
3510AK46N30	Vario 110 eSP (2015 - 2019)	0.6 kg	Hitam, Silver	\N
35010K47N00	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nBlade 125 FI K47 (2014 - 2018)	0.5 kg	Hitam, Silver	\N
3501AK16A20	Scoopy FI K16G (2013 - 2015)	1 kg	Hitam, Silver	\N
35100KZLA00	Spacy Karburator (2011 - 2013)	0.5 kg	Hitam	15 cmx 10 cmx 5 cm
35141K2FN91	Scoopy K2F (2020 - Sekarang)	0.13 kg	Hitam	10 cmx 8 cmx 2 cm
35012K45NL0	ADV 150 (2019 - 2022)\nCB150X (2021 - Sekarang)\nCBR 150R K45R (2021 - Sekarang)	0.25 kg	Hitam	9 cmx 9 cmx 4 cm
35113K27V51	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)\nVario 150 eSP K59 (2015 - 2018)\nVario 150 eSP K59J (2018 - 2022)	0.01 kg	Hitam	3 cmx 3 cmx 2 cm
35110K25901	BeAT FI K25 (2012 - 2014)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)	0.2 kg	Silver	9 cmx 9 cmx 5 cm
35010K15710	CB150R StreetFire K15P (2021 - Sekarang)	1.15 kg	Hitam	22 cmx 9 cmx 14 cm
35010K64N04	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.81 kg	Hitam, Silver	22 cmx 10 cmx 13 cm
35100K1ZJ11	ADV 160 (2022 - Sekarang)	0.65 kg	Hitam, Silver	12 cmx 14 cmx 9 cm
35010K45NL0	CBR 150R K45R (2021 - Sekarang)	1.1 kg	Hitam, Silver	20 cmx 10 cmx 13 cm
35110KZR601	PCX 150 CBU (2012 - 2014)\nScoopy FI K16G (2013 - 2015)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.25 kg	Putih, Silver	11 cmx 12 cmx 5 cm
35010KVLN20	Supra X 125 Injection (2007 - 2014)	0.6 kg	Hitam, Silver	23 cmx 20 cmx 5 cm
35010K45N41	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	1 kg	Hitam	\N
35010K18961	CB150 Verza (2018 - Sekarang)	0.5 kg	Hitam	\N
35121K0WN00	ADV 150 (2019 - 2022)	0.3 kg	Hitam	\N
35100KEV650	Supra (1997 - 2002)	0.6 kg	Hitam, Silver	\N
77239K45N41	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	1 kg	Silver	\N
35111K2FN91	Scoopy K2F (2020 - Sekarang)\nStylo 160 (2024 - Sekarang)	0.03 kg	Hitam	7 cmx 2 cmx 2 cm
35010K64NP0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.82 kg	Hitam, Silver	22 cmx 9 cmx 3 cm
35101KZR601	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.32 kg	Hitam	14 cmx 5 cmx 4 cm
35100K15711	CB150R StreetFire K15P (2021 - Sekarang)	0.31 kg	Hitam, Silver	15 cmx 10 cmx 5 cm
35101K03N31	Revo 110 FI (2014 - Sekarang)	0.3 kg	Hitam	13 cmx 8 cmx 4 cm
35100K60B62	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)	0.6 kg	Hitam	14 cmx 10 cmx 6 cm
35101K97A01	Vario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)	0.25 kg	Hitam, Silver	12 cmx 5 cmx 5 cm
38410K60B61	Vario 125 eSP K60R (2018 - 2022)	0.06 kg	Hitam	12 cmx 8 cmx 4 cm
35100K64N02	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.402 kg	Hitam	16 cmx 10 cmx 8 cm
35010K3BN00	CB150X (2021 - Sekarang)	1.5 kg	Hitam	22 cmx 10 cmx 13 cm
17620KREG02	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	0.6 kg	Hitam	\N
77239K64N01	CBR 250RR K64 (2016 - 2020)	0.4 kg	Hitam	\N
35121K97N01	PCX 150 K97 (2017 - 2021)	0.1 kg	\N	5 cmx 4 cmx 2 cm
35011KYE900	CB150 Verza (2018 - Sekarang)\nMega Pro New (2010 - 2014)\nVerza 150 (2013 - 2018)	0.7 kg	Hitam	\N
35121KYE900	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.5 kg	Hitam	\N
35010GN5781	\N	0.7 kg	Hitam	\N
35111K97N23	PCX 150 K97 (2017 - 2021)	0.15 kg	Hitam	10 cmx 5 cmx 2 cm
35100K64NP1	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.42 kg	Hitam	15 cmx 8 cmx 4 cm
35121KYZ900	Supra X 125 FI New (2014 - Sekarang)	0.03 kg	Hitam	10 cmx 4 cmx 2 cm
35101K25901	BeAT Sporty eSP K25G (2014 - 2016)	0.3 kg	Hitam	14 cmx 5 cmx 4 cm
77110KCJ660	Tiger Revolution A (2006 - 2012)\nTiger Revolution B (2010 - 2012)\nTiger Revolution C (2012 - 2014)	0.2 kg	Hitam, Silver	12 cmx 10 cmx 6 cm
77239K64N03	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.12 kg	Hitam	10 cmx 9 cmx 3 cm
35121K0WN01	ADV 150 (2019 - 2022)	0.05 kg	Hitam	6 cmx 3 cmx 2 cm
35121K2FN11	Scoopy K2F (2020 - Sekarang)\nVario 150 eSP K59J (2018 - 2022)	0.2 kg	Hitam	\N
77239K64N02	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.15 kg	Hitam, Silver	10 cmx 8 cmx 2 cm
35100K3BN01	CB150X (2021 - Sekarang)	0.4 kg	Hitam	17 cmx 16 cmx 4 cm
35141K97N02	PCX 150 K97 (2017 - 2021)	0.2 kg	Hitam	17 cmx 15 cmx 5 cm
35100K2FN11	Scoopy K2F (2020 - Sekarang)	0.7 kg	Hitam	15 cmx 15 cmx 8 cm
35100K60B61	Vario 125 eSP K60R (2018 - 2022)	1 kg	Hijau	\N
35141K0WN01	ADV 150 (2019 - 2022)	0.7 kg	Hitam	\N
35101K81N01	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	1 kg	Hitam	\N
35100K81N01	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	1 kg	Hitam	\N
88110KCJ660	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nTiger Revolution B (2010 - 2012)	0.3 kg	Hitam	\N
88120KZR600	Vario 150 eSP K59 (2015 - 2018)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.3 kg	Hitam	\N
88110KZR600	Vario 150 eSP K59 (2015 - 2018)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.3 kg	Hitam	\N
88210K97N01	PCX 150 K97 (2017 - 2021)\nPCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	\N
88220K97N01	PCX 150 K97 (2017 - 2021)\nPCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)\nVario 160 K2S (2022 - Sekarang)	0.3 kg	Hitam	\N
88120KCJ660	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nTiger Revolution B (2010 - 2012)	0.3 kg	Hitam	\N
88120K25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	0.3 kg	Hitam	\N
88110KWWA40	Revo 110 New (2010 - 2014)\nSupra X 125 FI New (2014 - Sekarang)	0.3 kg	Hitam	\N
88120KWWA40	Revo 110 New (2010 - 2014)\nSupra X 125 FI New (2014 - Sekarang)	0.3 kg	Hitam	\N
88110K25900	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	0.001 kg	Hitam	10.0 cmx 20.0 cmx 30.0 cm
33400KZR601	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.3 kg	Putih	\N
33652K93N01	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Putih	\N
33600K45NA1	CBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	0.2 kg	Hitam	\N
33400K84901	CRF150L K84 (2017 - Sekarang)	0.3 kg	Putih	\N
33600K64N01	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.2 kg	Hitam, Putih	\N
33650K45NA1	CBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)	0.3 kg	Hitam	\N
33450K61901	BeAT POP eSP K61 (2014 - 2019)	0.5 kg	Putih	\N
88115KWN980	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)\nBeAT dan BeAT Street K1A (2020 - 2024)\nBeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nCBR 250R K33A (2014 - 2016)\nCRF250 Rally (2018 - Sekarang)\nPCX 125 CBU (2010 - 2012)\nPCX 150 CBU (2012 - 2014)\nPCX 150 CBU K36J (2014 - 2017)\nPCX 150 K97 (2017 - 2021)\nPCX 160 e:HEV (2021 - 2023)\nPCX 160 K1Z (2021 - Sekarang)\nScoopy eSP K16R (2015 - 2017)\nScoopy eSP K93 (2017 - 2020)\nSpacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)\nSupra (1997 - 2002)\nSupra FIT (2006 - 2007)\nSupra X 125 FI New (2014 - Sekarang)\nSupra X 125 Injection (2007 - 2014)\nVario 110 CW (2006 - 2014)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60 (2015 - 2018)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59 (2015 - 2018)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.01 kg	Hitam	\N
45517K81N30	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nGenio (2019 - 2022)\nScoopy eSP K93 (2017 - 2020)\nScoopy K2F (2020 - Sekarang)\nStylo 160 (2024 - Sekarang)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)	0.1 kg	Hitam	\N
88210K59A70	Vario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)	0.3 kg	Hitam	\N
88211K93N00ZB	Scoopy eSP K93 (2017 - 2020)\nScoopy K2F (2020 - Sekarang)	0.5 kg	Coklat	\N
33400K15921	CB150R StreetFire K15G (2015 - 2018)\nCBR 150R K45G (2016 - 2018)	0.15 kg	Hitam	\N
33450K15921	CB150R StreetFire K15G (2015 - 2018)\nCBR 150R K45G (2016 - 2018)	0.15 kg	Hitam	\N
33452K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)\nCBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)\nSupra GTR K56F (2016 - 2019)	0.1 kg	Hitam	\N
34908GA7701	BeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nRevo 110 FI (2014 - Sekarang)\nScoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)\nSpacy Karburator (2011 - 2013)\nSupra X 125 FI New (2014 - Sekarang)\nVario 110 eSP (2015 - 2019)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.05 kg	Putih	\N
33412K15920	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)\nCBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)\nCBR 150R K45R (2021 - Sekarang)\nCBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)\nSupra GTR K56F (2016 - 2019)	0.1 kg	Hitam	\N
34905KANW01	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nCB150 Verza (2018 - Sekarang)\nGenio (2019 - 2022)\nRevo 110 FI (2014 - Sekarang)\nScoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)\nScoopy K2F (2020 - Sekarang)\nSupra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)\nSupra X 125 FI New (2014 - Sekarang)\nVario 110 eSP (2015 - 2019)\nVario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)\nVerza 150 (2013 - 2018)	0.1 kg	Oranye	\N
34905GM9003	Grand Impressa (1991 - 2000)\nVario 110 CW (2006 - 2014)\nVario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.1 kg	Putih	\N
33450K81N01	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.4 kg	Hitam, Putih	30 cmx 22 cmx 8 cm
33400K81N01	BeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)	0.4 kg	Hitam, Putih	30 cmx 22 cmx 8 cm
33402K1AN01	BeAT dan BeAT Street K1A (2020 - 2024)	0.6 kg	Silver	\N
33600K15921	CB150R StreetFire K15G (2015 - 2018)	0.15 kg	Hitam	\N
33650K15921	CB150R StreetFire K15G (2015 - 2018)	0.15 kg	Hitam	\N
33400K45NA1	CBR 150R K45N (2018 - 2020)	0.3 kg	Hitam	\N
33452K1AN01	BeAT dan BeAT Street K1A (2020 - 2024)	3 kg	Silver	\N
33650K59A71	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)	0.2 kg	Putih	\N
33450K25901	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	0.3 kg	Putih	\N
33650K84901	CRF150L K84 (2017 - Sekarang)	0.3 kg	Putih	\N
33450K45NA1	CBR 150R K45N (2018 - 2020)	0.6 kg	Hitam	\N
33400K0WN01	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	0.4 kg	Hitam	\N
33450K0WN01	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)	0.4 kg	Hitam	\N
33450K84901	CRF150L K84 (2017 - Sekarang)	0.3 kg	Putih	\N
33400K25901	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	0.3 kg	Putih	\N
33600K59A71	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)	0.2 kg	Hitam, Putih	\N
33404K0JN01	Genio (2019 - 2022)	0.5 kg	Putih	\N
34910KZLA01	Spacy FI (2013 - 2018)\nSpacy Karburator (2011 - 2013)	0.1 kg	Oranye	\N
33410K2FN01	Scoopy K2F (2020 - Sekarang)	0.2 kg	Hitam	22 cmx 11 cmx 5 cm
33400K93N01	Scoopy eSP K93 (2017 - 2020)	0.7 kg	Putih	\N
33602K93N01	Scoopy eSP K93 (2017 - 2020)	0.5 kg	Putih	\N
33450KVLN01	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	0.6 kg	Hitam, Silver	22 cmx 20 cmx 8 cm
33400KVLN01	Supra X 125 (2007 - 2014)\nSupra X 125 Injection (2007 - 2014)	0.15 kg	Hitam, Putih	25 cmx 22 cmx 8 cm
33650K45N41	CBR 150R K45G (2016 - 2018)	0.2 kg	Hitam	\N
33454K0JN01	Genio (2019 - 2022)	0.5 kg	Putih	\N
33402K0JN01	Genio (2019 - 2022)	0.8 kg	Hitam	\N
33600K84901	CRF150L K84 (2017 - Sekarang)	0.3 kg	Putih	\N
33452K0JN01	Genio (2019 - 2022)	0.8 kg	Hitam	\N
33410K56N11	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	1 kg	Hitam, Putih	\N
33460K56N11	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	1 kg	Hitam, Putih	\N
33602K2FN01	Scoopy K2F (2020 - Sekarang)	0.25 kg	Hitam, Silver	20 cmx 18 cmx 8 cm
33455K0JN01	Genio (2019 - 2022)	0.7 kg	Putih	\N
33400K61901	BeAT POP eSP K61 (2014 - 2019)	0.5 kg	Putih	\N
34905KSSC02	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nBeAT Sporty eSP K81 (2016 - 2020)\nSonic 150R K56 (2015 - Sekarang)	0.05 kg	Oranye	\N
33420K93N01	Scoopy eSP K93 (2017 - 2020)	0.2 kg	Putih	\N
33460K41N01	Supra X 125 FI New (2014 - Sekarang)	0.3 kg	Putih	\N
33420K2FN01	Scoopy K2F (2020 - Sekarang)	0.5 kg	Hitam, Silver	26 cmx 20 cmx 7 cm
33650K64N01	CBR 250RR K64 (2016 - 2020)\nCBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.2 kg	Hitam, Putih	\N
33113K20901	BeAT dan BeAT Street K1A (2020 - 2024)\nBeAT dan BeAT Street K1AL (2024 - Sekarang)\nBeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nCRF150L K84 (2017 - Sekarang)\nGenio (2019 - 2022)\nRevo 110 FI (2014 - Sekarang)\nScoopy eSP K93 (2017 - 2020)\nSupra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)\nSupra X 125 FI New (2014 - Sekarang)\nVario 125 eSP K60 (2015 - 2018)\nVario 150 eSP K59 (2015 - 2018)	0.15 kg	\N	\N
33650KYT901	Scoopy Karburator KYT (2010 - 2013)	0.4 kg	Silver	\N
33450KVB931	Vario 110 CW (2006 - 2014)	0.6 kg	Hitam, Putih	\N
33652K2FN01	Scoopy K2F (2020 - Sekarang)	2 kg	Hitam	\N
33450KZR601	Vario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.4 kg	Putih	\N
33452KZZJ00	ADV 150 (2019 - 2022)\nADV 160 (2022 - Sekarang)\nCRF250 Rally (2018 - Sekarang)\nVario 125 eSP K2V (2022 - Sekarang)\nVario 125 eSP K60R (2018 - 2022)\nVario 150 eSP K59J (2018 - 2022)\nVario 160 K2S (2022 - Sekarang)	0.1 kg	Hitam	\N
33410K41N01	Supra X 125 FI New (2014 - Sekarang)	0.3 kg	Putih	\N
33410K93N01	Scoopy eSP K93 (2017 - 2020)	0.6 kg	Silver	\N
33652K0JN01	Genio (2019 - 2022)	0.8 kg	Putih	\N
33460K07901	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nBlade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	0.3 kg	Putih	\N
33113KVBT01	PCX 125 CBU (2010 - 2012)\nPCX 150 CBU (2012 - 2014)\nRevo 110 FI (2014 - Sekarang)\nSupra X 125 FI New (2014 - Sekarang)\nVario 110 Techno A (2009 - 2010)\nVario 110 Techno B (2010 - 2012)\nVario Techno 125 FI CBS ISS (2013 - 2015)\nVario Techno 125 FI STD (2013 - 2015)\nVario Techno 125 Helm-In FI (2012 - 2013)\nVario Techno 125 Helm-In FI CBS (2012 - 2013)	0.002 kg	Hitam	3 cmx 1 cmx 2 cm
33600K18961	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.3 kg	Hitam	\N
33400KVB931	Vario 110 CW (2006 - 2014)	0.8 kg	Hitam, Putih	\N
33113MAT611	CB150 Verza (2018 - Sekarang)\nCS1 KWC (2008 - 2013)\nVario 110 CW (2006 - 2014)\nVerza 150 (2013 - 2018)	0.01 kg	Hitam	2 cmx 1 cmx 1 cm
33650K18961	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.2 kg	Silver	\N
33400K41N01	Supra X 125 FI New (2014 - Sekarang)	0.3 kg	Putih	\N
33400K18961	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.4 kg	Silver	\N
33450K18961	CB150 Verza (2018 - Sekarang)\nVerza 150 (2013 - 2018)	0.3 kg	Hitam	\N
33752K03N31	Revo 110 FI (2014 - Sekarang)	0.08 kg	Putih	20 cmx 10 cmx 4 cm
33402K16901	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	1 kg	Putih	\N
33400K16901	Scoopy FI K16G (2013 - 2015)	0.3 kg	Putih	\N
33450KCJ651	Tiger Revolution B (2010 - 2012)	0.3 kg	Oranye	\N
33651K25901	BeAT FI CBS K25 (2012 - 2014)\nBeAT FI K25 (2012 - 2014)\nBeAT Sporty eSP K25G (2014 - 2016)	0.06 kg	Putih	16 cmx 10 cmx 4 cm
33401KCJ661	Tiger 2000 (1993 - 2006)	0.05 kg	Hitam	11 cmx 4 cmx 4 cm
33650K15601	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)	0.05 kg	Hitam	8 cmx 5 cmx 5 cm
33600K15601	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)	0.2 kg	Hitam	17 cmx 7 cmx 5 cm
33450KYE901	Mega Pro New (2010 - 2014)	0.2 kg	Oranye, Putih	15 cmx 12 cmx 5 cm
33657K93N01	Scoopy eSP K93 (2017 - 2020)	0.3 kg	Hitam	\N
33604K0JN01	Genio (2019 - 2022)	0.4 kg	Putih	\N
33602K0JN01	Genio (2019 - 2022)	0.8 kg	Putih	\N
33450KYZ901	Supra X 125 Helm-in Karburator (2011)	1.5 kg	Hitam, Putih	\N
33452K16901	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	2 kg	Putih	\N
33410K07901	Blade 110 K07A (2011 - 2014)\nBlade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	0.3 kg	Putih	\N
33450KWC901	CS1 KWC (2008 - 2013)	0.3 kg	Putih	\N
33702K03N31	Revo 110 FI (2014 - Sekarang)	0.08 kg	Putih	20 cmx 10 cmx 4 cm
33452K3BH00	CBR 150R K45R (2021 - Sekarang)	0.01 kg	Hitam	4 cmx 2 cmx 2 cm
34908KVE900	BeAT Karburator KVY (2008 - 2012)\nBeAT POP eSP K61 (2014 - 2019)\nBeAT Sporty eSP K25G (2014 - 2016)\nRevo 110 (2009 - 2010)\nRevo 110 FI (2014 - Sekarang)\nScoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)\nSpacy Karburator (2011 - 2013)\nSupra X 125 FI New (2014 - Sekarang)\nVario 110 eSP (2015 - 2019)	0.03 kg	Merah, Putih	3 cmx 3 cmx 2 cm
33453K18961	CB150 Verza (2018 - Sekarang)\nSupra GTR K56F (2016 - 2019)\nVerza 150 (2013 - 2018)	0.2 kg	Silver	\N
33654K0JN01	Genio (2019 - 2022)	0.4 kg	Putih	\N
33150K56N01	Sonic 150R K56 (2015 - Sekarang)	0.4 kg	Hitam	\N
34905KSSC01	Supra X 125 Helm-in Karburator (2011)	0.05 kg	Oranye	\N
33412K3BH00	CBR 150R K45R (2021 - Sekarang)	0.01 kg	Hitam	4 cmx 2 cmx 2 cm
33453KVB931	Vario 110 CW (2006 - 2014)	0.2 kg	Hitam, Silver	30 cmx 6 cmx 5 cm
33600K45N41	CBR 150R K45G (2016 - 2018)	0.1 kg	Hitam	\N
33455K41N01	Supra X 125 FI New (2014 - Sekarang)	0.05 kg	Hitam	13 cmx 10 cmx 2 cm
33450K15601	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)	0.05 kg	Hitam, Putih	22 cmx 14 cmx 6 cm
33410K07971	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nBlade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	0.45 kg	Hitam, Kuning, Putih	4 cmx 25 cmx 15 cm
33460K03N31	Revo 110 FI (2014 - Sekarang)	1 kg	Putih	\N
33400KYE901	Mega Pro New (2010 - 2014)	0.3 kg	Oranye	\N
33650KYE901	Mega Pro New (2010 - 2014)	0.3 kg	Putih	\N
33600K56NJ1	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	0.13 kg	Hitam	15 cmx 9 cmx 5 cm
33403KVB931	Vario 110 CW (2006 - 2014)	0.2 kg	Hitam, Silver	30 cmx 6 cmx 5 cm
33600K15901	CB150R StreetFire K15 (2012 - 2015)	0.2 kg	Hitam	17 cmx 7 cmx 5 cm
33650K15901	CB150R StreetFire K15 (2012 - 2015)	0.2 kg	Oranye, Putih	15 cmx 12 cmx 5 cm
33455K07901	Blade 110 K07A (2011 - 2014)\nBlade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	0.1 kg	Hitam	15 cmx 14 cmx 3 cm
33400K15901	CB150R StreetFire K15 (2012 - 2015)	0.15 kg	Hitam, Putih	18 cmx 16 cmx 8 cm
33403K18961	CB150 Verza (2018 - Sekarang)\nSupra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)\nVerza 150 (2013 - 2018)	0.3 kg	Silver	\N
33400KZLA01	Spacy Karburator (2011 - 2013)	1 kg	Hitam	\N
33600KCJ651	Tiger Revolution B (2010 - 2012)	0.4 kg	Hitam, Kuning	\N
33410K03N31	Revo 110 FI (2014 - Sekarang)	3 kg	Putih	\N
33450K41N01	Supra X 125 FI New (2014 - Sekarang)	1.5 kg	Putih, Silver	\N
33450KZLA01	Spacy Karburator (2011 - 2013)	3 kg	Silver	\N
33450K93N01	Scoopy eSP K93 (2017 - 2020)	0.7 kg	Putih	\N
33600KFE701	\N	0.3 kg	Oranye	\N
33400KWB921	Blade 110 KWB (2008 - 2011)	0.3 kg	Putih	\N
33652K16901	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.2 kg	Hitam	19 cmx 12 cmx 5 cm
33650K56NJ1	Supra GTR K56F (2016 - 2019)\nSupra GTR K56W (2019 - Sekarang)	0.13 kg	Hitam	15 cmx 9 cmx 5 cm
33602K16901	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.13 kg	Hitam	15 cmx 9 cmx 5 cm
33650K18901	Verza 150 (2013 - 2018)	0.2 kg	Hitam	17 cmx 6 cmx 8 cm
33400K18901	Verza 150 (2013 - 2018)	0.15 kg	Hitam	18 cmx 16 cmx 8 cm
33400K15601	CB150R StreetFire K15G (2015 - 2018)\nCB150R StreetFire K15M (2018 - 2021)\nCB150R StreetFire K15P (2021 - Sekarang)\nCB150X (2021 - Sekarang)	0.05 kg	Hitam	8 cmx 5 cmx 5 cm
33457K16901	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.05 kg	Hitam	10 cmx 7 cmx 2 cm
33600KYE901	Mega Pro New (2010 - 2014)	0.2 kg	Hitam	17 cmx 7 cmx 5 cm
33607K16901	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.05 kg	\N	10 cmx 7 cmx 2 cm
33657K16901	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.05 kg	Hitam	10 cmx 7 cmx 2 cm
33450K15901	CB150R StreetFire K15 (2012 - 2015)	0.5 kg	Hitam, Oranye	20 cmx 15 cmx 4 cm
33403K84901	CRF150L K84 (2017 - Sekarang)	0.2 kg	Silver	\N
33450KYT901	Scoopy Karburator KYT (2010 - 2013)	0.4 kg	Silver	\N
33450KVBN51	Vario 110 Techno A (2009 - 2010)	0.8 kg	Hitam	\N
33400KYZ901	Supra X 125 Helm-in Karburator (2011)	2 kg	Putih, Silver	\N
33400KVBN51	Vario 110 Techno A (2009 - 2010)	0.6 kg	Putih	\N
33450K16901	Scoopy FI K16G (2013 - 2015)	2 kg	Putih	\N
33650KCJ661	Tiger 2000 (1993 - 2006)	0.5 kg	Putih	\N
33450KPH881	Karisma (2002 - 2005)	0.3 kg	Putih	\N
33400KCJ651	Tiger Revolution B (2010 - 2012)	0.3 kg	Hitam	\N
33650KEH601	Mega Pro Advance (2006 - 2010)	0.3 kg	Oranye	\N
33450KVR602	Revo (2007 - 2009)	0.3 kg	Putih	\N
33450K3VN01	Stylo 160 (2024 - Sekarang)	0.8 kg	Hitam	22 cmx 22 cmx 10 cm
33450K45TA1	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.06 kg	Hitam	15 cmx 6 cmx 3 cm
33400K45TA1	CBR 150R K45G (2016 - 2018)\nCBR 150R K45N (2018 - 2020)	0.06 kg	Hitam	15 cmx 6 cmx 3 cm
33451KCJ661	Tiger 2000 (1993 - 2006)	0.05 kg	Hitam	11 cmx 4 cmx 4 cm
33403KVY961	BeAT Karburator KVY (2008 - 2012)	0.2 kg	Hitam, Silver	30 cmx 6 cmx 5 cm
33452K64TG0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.025 kg	Hitam	5 cmx 4 cmx 3 cm
33412K64TG0	CBR 250RR K64J (2020 - 2022)\nCBR 250RR K64N (2022 - Sekarang)	0.025 kg	Hitam	5 cmx 4 cmx 3 cm
33453KVY961	BeAT Karburator KVY (2008 - 2012)	0.3 kg	Hitam	27 cmx 8 cmx 5 cm
33113GCCB50	Scoopy eSP K16R (2015 - 2017)\nScoopy FI K16G (2013 - 2015)	0.005 kg	Hitam	1 cmx 1 cmx 1 cm
33650K16901	Scoopy FI K16G (2013 - 2015)	0.2 kg	Hitam, Silver	24 cmx 12 cmx 5 cm
33403KVBN51	Vario 110 Techno A (2009 - 2010)	0.25 kg	Hitam	30 cmx 6 cmx 5 cm
33453KVBN51	Vario 110 Techno A (2009 - 2010)	0.25 kg	Hitam, Silver	30 cmx 6 cmx 5 cm
33600KYE941	Mega Pro FI (2014 - 2018)	0.15 kg	Hitam, Putih	16 cmx 6 cmx 3 cm
33450K07971	Blade 110 K07A (2011 - 2014)\nBlade 125 FI K47 (2014 - 2018)	0.45 kg	\N	45 cmx 25 cmx 7 cm
33600KEH601	Mega Pro Advance (2006 - 2010)	0.2 kg	Oranye, Putih	15 cmx 12 cmx 5 cm
33650KCJ651	Tiger 2000 (1993 - 2006)\nTiger Revolution B (2010 - 2012)	0.5 kg	Hitam	20 cmx 15 cmx 5 cm
33460K07971	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)\nBlade 125 FI K47 (2014 - 2018)\nSupra X 125 FI New (2014 - Sekarang)	2 kg	Hitam, Oranye	40 cmx 20 cmx 15 cm
33450K07901	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	0.45 kg	Hitam, Putih	4 cmx 25 cmx 15 cm
33400K07901	Blade 110 K07A (2011 - 2014)\nBlade 110 S K07J (2012-2014)	0.45 kg	Hitam, Putih	45 cmx 25 cm
34905KYJ901	CBR 150R CBU KPP (2011 - 2013)\nCBR 150R K45A (2014 - 2016)\nCBR 250R K33A (2014 - 2016)	0.5 kg	Kuning	\N
33400KYT901	Scoopy eSP K16R (2015 - 2017)\nScoopy Karburator KYT (2010 - 2013)	0.5 kg	Hitam	\N
33450KVY961	BeAT Karburator KVY (2008 - 2012)	0.6 kg	Hitam	\N
33453K84901	CRF150L K84 (2017 - Sekarang)	0.2 kg	Silver	\N
33605K0JN01	Genio (2019 - 2022)	0.7 kg	Hitam	\N
33655K0JN01	Genio (2019 - 2022)	0.7 kg	Hitam	\N
33450KEH601	Mega Pro Advance (2006 - 2010)	0.4 kg	Hitam, Kuning	\N
33400KVY961	BeAT Karburator KVY (2008 - 2012)	0.8 kg	Hitam, Putih	\N
33400KEH601	Mega Pro Advance (2006 - 2010)	0.4 kg	Kuning	\N
33600KCJ661	Tiger 2000 (1993 - 2006)	0.3 kg	Putih	\N
34908GA7008	\N	0.1 kg	Putih	\N
33400KVR601	Revo (2007 - 2009)	0.3 kg	Putih	\N
33450KTL690	Revo (2007 - 2009)	0.3 kg	Putih	\N
33400K07971	Blade 110 K07A (2011 - 2014)	0.3 kg	Oranye	\N
\.


--
-- Data for Name: produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produk (kode_produk, nama_produk, kategori, harga) FROM stdin;
81132GAH000YV	Hook Luggage - Kait Bagasi	Bagasi (Luggage), Cover Body	8000.0
50732K97T00ZA	Cover R P Step Arm Outer - PCX 150 K97	Cover Body	12500.0
81137K0WN00ZB	LID Smart EMG - ADV 150	Cover Body	32500.0
80102K59A10	Cover Reserve Tank - Vario 125 eSP K60R, Vario 150 eSP New K59J	Cover Body	13000.0
64600K56N00	Cover Combination Light Upper - Sonic 150R	Cover Body	28500.0
81265K97T00	Tahanan Lumpur (Guard Splash RR) - PCX 150 K97 & PCX Hybrid	Cover Body	20500.0
8010EK59A10	Cover Assy Reserve Tank - Vario 125 eSP & Vario 150 eSP	Cover Body	21000.0
8010DK59A10	Fender Assy Rear Inner - Vario 125 eSP & Vario 150 eSP	Cover Body	47000.0
80103K97T00	Fender C RR - PCX 150 K97	Cover Body	44000.0
6130BK56N00	Cover Lampu Depan Honda Sonic 150R	Cover Body	41000.0
81145K59A70ZB	Cover Emergency (Lid Smart Emergency) - New Vario 150 eSP K59J	Cover Body	6500.0
50742K97T00ZA	Cover L P Step - PCX 150 K97	Cover Body	12500.0
61311K56N00	Dudukan lampu Depan Honda Sonic 150R	Cover Body	52000.0
19642K66V00	Cap L Cover - Vario 125 eSP K60R, Vario 150eSP K59J	Cover Body, Tutup Mesin (Crank Case Cover)	12500.0
6430CK56N10	Cover Front Assy - Supra GTR 150	Cover Body	66000.0
64308K59A70ZB	Cover, FR Lower - New Vario 150 K59J & New Vario 125 K60R	Cover Body	92000.0
53207K81N30ZA	Cover Meter Lower - BeAT eSP	Cover Body	15500.0
80103K59A70ZB	Cover, Rear Fender Upper - New Vario 150 K59J & New Vario 125 K60R	Cover Body	18500.0
64303K59A10ZA	Garnish Front Hitam - Vario 125 eSP & Vario 150 eSP	Cover Body	46000.0
18318K59A70	Cover Knalpot (Protector Muffler) - New Vario 150 K59J & New Vario 125 K60R	Cover Body, Cover Knalpot	30500.0
64271K45N40	Cowl Left Front Inner - New CBR 150R K45G & New CBR 150R K45N	Cover Body	32500.0
64241K45N40	Cowl Front Lower - New CBR 150R K45G	Cover Body	44500.0
4051AK41N00	Case Assy Drive Chain ( Tutup Rantai ) - New Blade FI & Supra X 125 FI	Cover Body	13500.0
64337K97T00ZA	Cover Dashboard (Panel RR Meter) - PCX 150 K97 & PCX Hybrid	Cover Body	24000.0
81141K81N00ZA	Cover Inner Lower - New BeAT eSP	Cover Body	63000.0
64261K45N40	Cowl Right Front Inner - New CBR 150R K45G & New CBR 150R K45N	Cover Body	32500.0
64305K81N00ZA	Cover Front Top - New BeAT eSP	Cover Body	25500.0
64336K97T00ZA	Panel FR Meter - PCX 150 K97	Cover Body	20500.0
64332K45N40	Cowl Center Inner Lower - New CBR 150R K45G	Cover Body	23000.0
64308K59A10ZB	Cover Front Lower - Vario 125 eSP	Cover Body	68500.0
6430DK59A10ZB	Cover Front Lower - Vario 125 eSP & Vario 150 eSP	Cover Body	67000.0
40510K56N00	Case Drive Chain (Tutup Rantai) - Sonic 150R	Cover Body	30500.0
80115K59A10	Base License Light - Vario 125 eSP & Vario 150 eSP	Cover Body	15500.0
81141K59A10ZB	Cover Inner Lower Font Seat - Honda Vario 125 eSP	Cover Body	91500.0
64310K59A70ZB	Step, Floor - New Vario 150 K59J & New Vario 125 K60R	Cover Body	91500.0
8114AK59A10ZB	Cover Inner Lower - Vario 125 eSP & Vario 150 eSP	Cover Body	96500.0
6434AK59A10ZB	Cover Under - Vario 125 eSP & Vario 150 eSP	Cover Body	77500.0
17234K97T00	Cover Air C Duct - Honda PCX 150 (K97)	Cover Body, Saringan Udara (Filter)	18500.0
19640K97T00	Duct Comp L Cover - PCX 150 K97 & PCX Hybrid	Cover Body	23500.0
61302K84900	Dudukan Lampu Depan Honda CRF 150L	Cover Body	41000.0
81131K97T00ZA	Cover Inner - PCX 150 K97	Cover Body	85000.0
64420K59A70ZD	Garnish L FR - New Vario 125 eSP (K60R), Nev Vario 150 eSP (K59J)	Cover Body	22000.0
61306K15920	Cover Depan Kiri Honda CB150R StreetFire K15G	Cover Body	22500.0
64310K1AN00ZA	Step,Floor (Black) - BeAT K1A	Cover Body	66500.0
53206K59A10ZB	Cover Batok Belakang Honda Vario 150 eSP K59	Cover Body	49000.0
64405K97T00ZA	Lid, Fuel - PCX 150 K97	Cover Body	16500.0
6470AK56N00	Cover Combination Light Lower - Sonic 150R	Cover Body	39000.0
5320DK59A10ZA	Cover Batok Depan Honda Vario 125 eSP	Cover Body	36000.0
80101K97N00	Fender, A RR - PCX 150 K97	Cover Body	96500.0
64350K60B60ZB	Cover R Under Side - New vario 125 eSP (K60R)	Cover Body	46000.0
8010AK59A10	Fender Assy Rear - Vario 125 eSP & Vario 150 eSP	Cover Body	127000.0
64410K97T00ZA	Cover, Center - PCX 150 K97	Cover Body	16500.0
64340K81N00ZA	Cover Under - New BeAT eSP	Cover Body	68000.0
61310K15930	Cover Meter Honda CB150R Streetfire K15M	Cover Body	20500.0
80104K59A10	Tahanan Lumpur (Guard Splash) - Vario 125 eSP & Vario 150 eSP	Cover Body	14500.0
61305K15920	Cover Depan Kanan Honda CB150R StreetFire K15G	Cover Body	22500.0
6431AK59A10ZB	Step Floor - Vario 125 eSP & Vario 150 eSP	Cover Body	108000.0
83520K59A10ZB	Cover Right Body Side - Vario 125 eSP & Vario 150 eSP	Cover Body	39000.0
64420K2SN00ZA	Garnish Depan Kiri Hitam Honda Vario 160 K2S	Cover Body	18500.0
80131K97T00	Cover L W/L - PCX 150 K97	Cover Body	21500.0
80115K97T00	Cover License Light - PCX 150 K97	Cover Body	18500.0
8016AK61900	Cover Seat Lock Assy Honda BeAT POP eSP K61	Cover Body, Jok	7500.0
17235K97N00	Cover Sub Assy Air C - PCX 150 K97	Cover Body, Saringan Udara (Filter)	66000.0
6422AK45N40	Cowl Assy Right Front Side - New CBR 150R K45G	Cover Body	28500.0
19642K2FN10	Cover CVT Honda Scoopy K2F	Cover Body, Tutup Mesin (Crank Case Cover)	15500.0
64308K1AN00ZA	Cover Front Lower Hitam - Honda BeAT K1A	Cover Body	81500.0
83650K25900ZA	Cover Kiri Belakang (Cover Left Rear Side) - BeAT K25	Cover Body	18000.0
64320K59A70ZD	Garnish Right Front - New Vario 150 K59J & New Vario 125 K60R	Cover Body	22000.0
6452AK56N00	Cover Battery Set - Sonic 150R	Cover Body	29000.0
64320K2SN00ZA	Garnish Depan Kanan Hitam Honda Vario 160 K2S	Cover Body	18500.0
64303K59A10ZE	Garnish Front Merah - Vario 125 eSP & Vario 150 eSP	Cover Body	102000.0
64340K1AN00ZA	Cover,Under (Black) - BeAT K1A	Cover Body	83500.0
80105K59A70	Spakbor Belakang (Fender A Rear) - New Vario 150 (K59)	Cover Body	50000.0
64340K59A10ZB	Cover Under Cowl - New Vario 125 eSP	Cover Body	67500.0
64360K60B60ZB	Cover L Under Side - New Vario 125 eSP (K60R)	Cover Body	44000.0
8010BK56N00	Fender A RR Assy - Sonic 150R	Cover Body	61000.0
19642K59A10	Cap L Cover - Sonic 150R, Vario 125 eSP & Vario 150 eSP	Cover Body, Tutup Mesin (Crank Case Cover)	12000.0
64460K25900ZA	Tutup Battery (Lid Battery) - BeAT FI, BeAT CBS FI (K25)	Cover Body	17000.0
83550K25900ZA	Cover Kanan Bawah (Cover Right Rear Side) - BeAT eSP	Cover Body	33000.0
64303K59A70ZD	Garnish Front - New Vario 150 K59J & New Vario 125 K60R	Cover Body	26000.0
19610K44V00	Cover Comp Fan - BeAT POP eSP, Scoopy eSP (K93) & Vario 110 eSP	Cover Body, Kipas (Fan)	29000.0
64312K93N00	Cover L Pillion Step - Scoopy eSP K93	Cover Body	9500.0
81141K2SN00ZA	Cover Inner Lower Black Honda Vario 160 K2S	Cover Body	135000.0
83700K25900ZA	Cover Belakang (Cover Rear Center) - BeAT FI, BeAT eSP K25	Cover Body	19000.0
81141K1AN00ZA	Cover Inner Lower (Black) - Honda BeAT K1A	Cover Body	82000.0
64320K46N20	Cover R Floor Side - Vario 110 eSP	Cover Body	36500.0
80106K59A10	Fender Assy, RR Inner - New Vario 150 K59J & New Vario 125 K60R	Cover Body	30500.0
64230K64N00	Cowl FR Lower - CBR 250RR	Cover Body	49000.0
64311K93N00	Cover R Pillion Step - Scoopy eSP K93	Cover Body	9500.0
64330K46N00	Cover Left Floor Side - Vario 110 FI	Cover Body	33000.0
5325BK25600	Cover Batok Belakang Honda BeAT Sporty eSP K25	Cover Body	44000.0
81143K93N00	Lid Inner L Pocket - Scoopy eSP (K93 New)	Cover Body	36000.0
64330K56N00	Cover R Under - Sonic 150R	Cover Body	40000.0
81131K81N00ZA	Cover Inner Upper - New BeAT eSP	Cover Body	72500.0
50410K93N00ZE	Behel (Rail RR Grab) - Scoopy eSP K93	Cover Body	175500.0
64302K59A10ZC	Cover Front Top - Vario 125 eSP & Vario 150 eSP	Cover Body	120000.0
64308K81N00ZA	Cover Front Lower - New BeAT eSP	Cover Body	81500.0
8010AK15920	Fender, Rear Assy - New CB150R Streetfire K15G & New CB150R Streetfire K15M	Cover Body	56000.0
64326K97T00	Mat, L Floor - PCX 150 K97	Cover Body, Suku Cadang Resmi Motor Honda	34000.0
64503K0WN00	Cover FR Center - ADV 150	Cover Body	46500.0
64303K2SN00ZA	Garnish Front Hitam Honda Vario 160 K2S	Cover Body	53000.0
64302K1AN00ZA	Cover Front Top (Black) - BeAT K1A	Cover Body	20500.0
64231K45N40	Cowl L FR Side - New CBR 150R K45G	Cover Body	24000.0
64308K2SN00ZA	Cover Front Lower Hitam Honda Vario 160 K2S	Cover Body	66000.0
80151K59A10ZB	Cover Center Hitam - Vario 125 eSP & Vario 150 eSP	Cover Body	40000.0
80104K59A70	Cover, Rear Fender Lower - New Vario 150 K59J & New Vario 125 K60R	Cover Body	16500.0
50741K97T00ZA	Cover L Step Arm Inner - PCX 150 K97	Cover Body	14500.0
6455AK56N00	Cover Assy L Side - Sonic 150R	Cover Body	44000.0
64310K81N00ZA	Step Floor - New BeAT eSP	Cover Body	117000.0
11350K97T00	Cover Comp L Rear - PCX 150 K97 & PCX Hybrid	Cover Body	10000.0
5062AK25600	Cover Bawah Honda BeAT POP eSP	Cover Body	41500.0
53206K25900ZA	Cover Batok Belakang Honda BeAT FI CBS k25	Cover Body	27500.0
61304K15920	Cover Meter Honda New CB150R StreetFire K15G	Cover Body	24500.0
61200K56N10	Spakbor Depan B Honda Supra GTR 150	Cover Body	35000.0
64308K2VN30ZA	Cover Bawah Depan Hitam Honda Vario 125 eSP K2V	Cover Body	85000.0
81141K60B60ZA	Cover Inner Lower - New Vario 125 eSP	Cover Body	118000.0
80110K56N10	Fender RR Lower - Supra GTR 150	Cover Body	80500.0
64340K2FN00ZB	Cover Under - Honda Scoopy K2F	Cover Body	98500.0
64325K97T00	Mat, R Floor - PCX 150 K97	Cover Body, Suku Cadang Resmi Motor Honda	34000.0
64223K2SN00	Cover Dudukan Panel Tameng Depan Honda Vario 160 K2S	Cover Body	102000.0
50280K15920	Cover Body Depan Bawah Kanan Honda New CB150R StreetFire K15G	Cover Body	109000.0
83620K59A10ZB	Cover Left Body Side - Vario 125 eSP & Vario 150 eSP	Cover Body	39000.0
53206K60B00ZB	Cover Batok Belakang Honda Vario 125 eSP K60	Cover Body	41000.0
81141K59A70ZA	Cover, Inner Lower - New Vario 150 K59J	Cover Body	118000.0
53205K59A10ZB	Cover Batok depan Honda Vario 150 eSP	Cover Body	51000.0
50285K15920	Cover Body Depan Bawah Kiri Honda New CB150R StreetFire K15G	Cover Body	109000.0
81131K59A10ZJ	Cover Rack Hitam Metallic - Vario 125 eSP & Vario 150 eSP	Cover Body	127000.0
64460K59A10ZB	Lid Battery - Vario 125 eSP & Vario 150 eSP	Cover Body	21000.0
8010CK81N00	Fender Assy Rear - New BeAT eSP	Cover Body	98500.0
81131K1AN00ZA	Cover Inner Upper (BLACK) - Honda BeAT K1A	Cover Body	56500.0
64221K45N40	Cowl Assy R FR Side - New CBR 150R K45G	Cover Body	25000.0
64301K1AN00MGB	Cover Tameng Depan (Cover,Front) Hitam Doff - BeAT K1A	Cover Body	207500.0
80151K59A70ZD	Cover, Center - New Vario 150 K59J & New Vario 125 K60R	Cover Body	46000.0
61101K15920	Stay Front Fender - CBR 150R K45G, New CB150R StreetFire K15G & New CB150R Streetfire K15M	Cover Body	26000.0
6432AK56N10	Cover Assy FR Main Pipe Black - Supra GTR 150	Cover Body	89000.0
80151K25900ZA	Cover Center Hitam - BeAT FI, BeAT CBS FI, BeAT Sporty eSP K25	Cover Body, Saringan Udara (Filter)	57500.0
50731K97T00ZA	Cover R Step Arm Inner - PCX 150 K97	Cover Body	14500.0
53206K81N10ZA	Cover Batok Belakang Honda New BeAT eSP K81	Cover Body	25500.0
6423AK45N40	Cowl Assy Left Front Side - New CBR 150R K45G	Cover Body	36000.0
81141K93N00ZJ	Cover Inner R Seat Black - Scoopy eSP K93	Cover Body	371500.0
64521K97T00	Cover FR Lower - PCX 150 K97	Cover Body	49000.0
64430K45N40	Cowl Assy L Inner Middle - New CBR 150R K45G & New CBR 150R K45N	Cover Body	122000.0
53205K56NJ0	tr	Cover Body	51000.0
53206K59A10ZA	Cover Batok Belakang Honda Vario 125 eSP	Cover Body	50000.0
80121K97T00	Cover R W/L - PCX 150 K97	Cover Body	21500.0
64460K25600	Tutup Aki (Lid Battery) - BeAT Sporty eSP	Cover Body	20500.0
64310K2VN30ZA	Step Floor Hitam Honda Vario 125 eSP K2V	Cover Body	118000.0
64450K15920	Cover Fuel Tank Center - New CB150R StreetFire K15G	Cover Body	48000.0
53206K81N00ZA	Cover Batok Belakang Honda New BeAT eSP K81	Cover Body	36000.0
53204K59A10ZB	Visor Hitam Honda Vario 125 eSP K60	Cover Body	79500.0
40510K84900	Case Drive Chain (Tutup Rantai) - CRF 150L	Cover Body	22500.0
64321K97T00ZA	Step Floor Kiri - PCX 150 K97	Cover Body	82500.0
61200K56N00	Spakbor Depan B Honda Sonic 150R	Cover Body	30500.0
64320K25900ZA	Cover Kanan Bawah (Cover Right Floor Side) - BeAT FI, BeAT FI CBS & BeAT Sporty eSP	Cover Body	34500.0
64360K64N00	Cowl L Inner Middle - New CBR 250RR	Cover Body	83500.0
80103K0WN00	Fender C Rear - ADV 150	Cover Body	50000.0
81131K25900ZB	Cover Inner Upper - BeAT FI	Cover Body	61500.0
64305K81H00ZA	Cover FR Top Green - BeAT eSP New	Cover Body	31500.0
6443AK45N40	Cowl Assy Left Inner Middle - New CBR 150R K45G	Cover Body	102000.0
64310K2SN00ZA	Step Floor Hitam Honda Vario 160 K2S	Cover Body	81500.0
81141K1AN10ZA	Cover Inner Lower (Black) - Honda BeAT K1A	Cover Body	82000.0
64340K93N00ZB	Cover Under - Scoopy eSP K93	Cover Body	97500.0
6432AK56N40	Cover Assy FR Main Pipe - Supra GTR 150	Cover Body	71500.0
83520K59A70ZB	Cover Right Body Side - New Vario 150 K59J & New Vario 125 K60R	Cover Body	51000.0
6430CK56N40	Cover FR Assy Merah - Supra GTR 150	Cover Body	102000.0
6410AK56N00	Cover Center Honda Sonic 150R	Cover Body	56000.0
53206K59A70ZB	Cover Batok Belakang Honda New Vario 150 eSP K59J	Cover Body	21500.0
64330K59A70ZC	Garnish R, Inner - New Vario 150 K59J & New Vario 125 K60R	Cover Body	8500.0
67111K45N40	Windscreen - CBR 150R K45G	Cover Body	79500.0
80151K59A10ZC	Cover Center Merah - Vario 125 eSP & Vario 150 eSP	Cover Body	97500.0
83650K84900ZB	Cover L Side B Black - Honda CRF 150L K84	Cover Body	59000.0
64350K64N00	Cowl R Inner Middle - New CBR 250RR	Cover Body	83500.0
8015AK56N00	Fender Belakang B - Sonic 150R	Cover Body	62500.0
53216K56NJ0ZA	Cover Batok Belakang Supra GTR 150 K56W	Cover Body	48000.0
64301K25900FMB	Cover Body Depan (Cover Front) Hitam - BeAT FI	Cover Body	274000.0
83620K59A70ZB	Cover Left Body Side - New Vario 150 K59J & New Vario 125 K60R	Cover Body	49000.0
80105K93N00	Spakbor (Fender) Belakang - Scoopy eSP K93	Cover Body	96500.0
64330K61900ZA	Cover Kiri Bawah (Cover, Left Floor Side) - BeAT POP eSP	Cover Body	34500.0
53205K97T00	Cover, Handle FR - PCX 150 K97	Cover Body	51000.0
64325K56N10	Cover RR Main Pipe - Supra GTR 150	Cover Body	29500.0
50315K15920ZA	Grip Right Rear - New CB150R StreetFire K15G	Cover Body	96500.0
61100K59A10AFB	Spakbor Depan Grey Honda Vario 150 eSP	Cover Body	202500.0
80160K81N00	Cover Seat Lock - New BeAT eSP	Cover Body, Jok	11000.0
8010BK25900ZA	Spakbor Belakang (Fender Rear Assy) - BeAT FI, BeAT FI CBS (K25)	Cover Body	91500.0
81131K59A10ZG	Cover Rack Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	142500.0
64430K56N00	Cover L Under - Sonic 150R	Cover Body	40000.0
83400K15600ZA	Set RR Cowl Center - New CB150R StreetFire K15M	Cover Body	30500.0
17235K1ZN20	Tutup Cover Saringan Udara Honda Vario 160 K2S, ADV 160, PCX 160 K1Z	Cover Body, Saringan Udara (Filter)	76500.0
64320K61900ZA	Cover Kanan Bawah (Cover, Right Floor Side) - BeAT POP eSP	Cover Body	34500.0
81131K59A10ZF	Cover Rack Hitam Doff - Vario 125 eSP & Vario 150 eSP	Cover Body	144000.0
6433AK45N40	Cowl Assy Right Inner Middle - New CBR 150R K45G	Cover Body	102000.0
81141K25900ZA	Cover Inner Lower Hitam - Honda BeAT FI, BeAT FI CBS	Cover Body	65500.0
6450AK56N00	Cover Assy R Side - Sonic 150R	Cover Body	60000.0
64320K46N00	Cover Right Floor Side - Honda Vario 110 FI	Cover Body	42500.0
80110K1AN00ZA	Spakbor Blakang (Fender,Rear (Black)) - BeAT K1A	Cover Body	138500.0
80110GN5830	Tahanan Lumpur (Mudguard RR) - Grand Inpresa & Legenda	Cover Body	6000.0
64311K97T00ZA	Step Floor Kanan - PCX 150 K97	Cover Body	81500.0
80105K1AN00ZA	Cover Belakang (Set Illus Light Cover Type 1) - Honda BeAT K1A	Cover Body	20500.0
64202K93N00ZN	Cover Depan Kiri Coklat Doff Honda Scoopy eSP K93	Cover Body	138500.0
6430BK25900	Cover Front Lower Assy - BeAT FI & BeAT FI CBS	Cover Body	86500.0
6131BK15920	Dudukan Lampu Depan Honda CB150R StreetFire K15G	Cover Body	64000.0
64630K56N10	Cover Lower - Supra GTR 150	Cover Body	26500.0
50325K15920ZA	Grip Left Rear - New CB150R StreetFire K15G	Cover Body	96500.0
64615K56N10	Cover Reserve Tank - Supra GTR 150	Cover Body	7500.0
83141K45N40ZA	Cover Seat Lock Merah - New CBR 150R K45G & New CBR 150R K45N	Cover Body	134000.0
64340K64N00ZA	Cover R FR Side - All New CBR 250RR	Cover Body	228500.0
61302K56N00ZD	Garnis Kanan Putih Honda Sonic 150R	Cover Body	77500.0
5320AK61900	Cover Batok Belakang Hitam Honda BeAT POP eSP K61	Cover Body	44000.0
17575K81N00	Cover Fuel Tank - New BeAT eSP	Cover Body, Tangki Bensin (Fuel Tank)	12500.0
83550K84900ZB	Cover R Side B Black - CRF 150L K84	Cover Body	91500.0
64430K59A70ZC	Garnish L Inner - New Vario 125 eSP & New vario 150 eSP	Cover Body	8500.0
83610K84920ZA	Set Illust L Sid A Cover T2 Hitam - CRF 150L	Cover Body	171000.0
64301K25900PFW	Cover Tameng Depan (Cover Front White) - BeAT FI, BEAT CBS FI (K25)	Cover Body	276000.0
64530K97T00	Cover, Under - PCX 150 K97	Cover Body	50000.0
53216K56N10ZA	Cover Batok Belakang Honda Supra GTR 150	Cover Body	66000.0
17575K93N00	Cover Fuel Tank - Scoopy eSP K93	Cover Body, Tangki Bensin (Fuel Tank)	15500.0
83650K84900ZA	Cover L Side B - CRF 150L	Cover Body	86500.0
64301K93N00ZL	Cover FR Top Brown - Scoopy eSP K93	Cover Body	274500.0
64310K59A10ZB	Pijakan Kaki (Steep Floor) - Vario 125 eSP K60	Cover Body	95500.0
80100K56N10	Fender RR Upper - Supra GTR 150	Cover Body	38000.0
64340K0JN00ZB	Cover Under Hitam Honda Genio	Cover Body	91500.0
81140K97N00ZA	Outer Inner Cover - New PCX 150 K97	Cover Body	27500.0
64340K59A70ZB	Cover Under - New Vario 150 (K59J), New Vario 125 (60R)	Cover Body	56000.0
64330K45N40	Cowl Assy R Inner Middle - New CBR 150R K45G & New CBR 150R K45N	Cover Body	122000.0
64440K64N00ZA	Cover L FR Side - All New CBR 250RR	Cover Body	225500.0
80104KVB900	Tahanan Lumpur (Guard Splash) - Vario Karbu	Cover Body	6500.0
61304K56N00ZA	Garnis Bawah Merah Honda Sonic 150R	Cover Body	89500.0
6452BK56N10	Cover Assy L Main Pipe Side - Supra GTR 150	Cover Body	66000.0
81141K0JN00ZC	Cover Inner Hitam Honda Genio	Cover Body	81500.0
64311K0WN00ZB	Step Floor Kanan - ADV 150	Cover Body	102000.0
61104KC6000	Mudguard Depan - GL MAX	Cover Body	3000.0
64308K46N00	Cover Front Lower - Vario 110 FI	Cover Body	53500.0
64601K59A10AFB	Cover Left Front Hitam Metallic - Vario 125 eSP & Vario 150 eSP	Cover Body	228500.0
50260K15920MGB	Cover Body Depan Kanan Hitam Raptor Honda New CB150R StreetFire K15G	Cover Body	146500.0
80101K0WN00	Fender A,Rear - ADV 150	Cover Body	56000.0
64501K97T00YD	Cover Right Front Sid Cowl Putih - PCX 150 K97	Cover Body	460000.0
61100K81N00ZA	Spakbor Depan Hitam Honda BeAT eSP K81	Cover Body	146500.0
64501K59A10AFB	Cover Right Front Hitam Metallic - Vario 125 eSP & Vario 150 eSP	Cover Body	228500.0
80105K0JN00ZB	Spakbor Belakang Hitam Honda Genio	Cover Body	123000.0
64310K93N00ZB	Step Floor Sid Brown - Scoopy eSP K93	Cover Body	102000.0
80121K45N40	Fender A Rear Upper - New CBR 150R K45G & New CBR 150R K45N	Cover Body	46500.0
83760K0WN00ZA	Set Illst,RR Center Cover Type 1 - ADV 150	Cover Body	25500.0
61303K18960	Cowl L FR Side - CB 150 Verza	Cover Body	25500.0
83550K46N00ZA	Cover Body Kanan (Right Body Side) - Vario 110 FI	Cover Body	56500.0
50607K56N10	Cover Battery Maintenance - Supra GTR 150	Cover Body	15500.0
64501K59A10MGB	Cover Right Front Hitam Doff - Vario 125 eSP & Vario 150 eSP	Cover Body	228500.0
17570K84900	Cover Body Tengah Kiri Honda CRF 150L	Cover Body	71500.0
61100K81N00ZC	Spakbor Depan Putih Honda BeAT eSP K81	Cover Body	161500.0
64601K59A10MGB	Cover Left Front Hitam Doff - Vario 125 eSP & Vario 150 eSP	Cover Body	228500.0
61100K25900ZD	Spakbor Depan Hitam Honda BeAT FI K25	Cover Body	113000.0
61100K59A10MGB	Spakbor Depan Hitam Doff Honda Vario 150 eSP	Cover Body	199000.0
64501K59A10PFW	Cover Right Front Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	228500.0
64431K0WN00ZB	Cover R Floor Side Silver - ADV 150	Cover Body	173000.0
1757AK61900	Cover Assy, Fuel Tank - BeAT POP eSP & Sonic 150R	Cover Body, Tangki Bensin (Fuel Tank)	14000.0
64201K93N00ZK	Cover Depan Kanan Hitam Honda Scoopy eSP K93	Cover Body	162500.0
61100K93N00ZK	Spakbor Depan Coklat Honda Scoopy eSP K93	Cover Body	277500.0
64301K81N00FMB	Cover Tameng Depan Hitam - New BeAT eSP	Cover Body	454000.0
64223K1AN01	Cover Depan (Stay Comp Front Cover) - Honda BeAT K1A	Cover Body	71500.0
87586KTM780	Label Fuel Caution - Sonic 150R, Supra GTR 150,New Supra X 125 FI	Cover Body	1500.0
81250K59A10	Box Assy Luggage (Box Bagasi) - Vario 125 eSP & Vario 150 eSP	Bagasi (Luggage), Cover Body	118000.0
53205K2VN30ZC	Cover Batok Kepala Depan Hitam Doff Honda Vario 125 eSP K2V	Cover Body	87000.0
64302K1AM00ZA	Cover Front Top Hitam Honda BeAT K1A	Cover Body	20500.0
64434K97T00ZA	Lid Plug Maintenance - PCX 150 K97 & PCX Hybrid	Cover Body	7500.0
08R80K18H00	Visor CB Verza	Aksesoris Resmi Motor Honda, Cover Body	152500.0
64202K93N00ZK	Cover Depan Kiri Hitam Honda Scoopy eSP K93	Cover Body	162500.0
50270K15920ZA	Cover Body Depan Atas Kanan Merah Honda New CB150R StreetFire K15G	Cover Body	80500.0
64311K1ZJ10ZC	Step Floor Kanan Honda PCX 160 K1Z	Cover Body	76500.0
81131K1AN10ZA	Cover Inner Upper (Black) - Honda BeAT K1A	Cover Body	56500.0
80151K46N00ZA	Cover Tutup Mesin Bawah (Center) - Vario 110 FI	Cover Body	38500.0
8010BK25600	Spakbor Belakang (Fender RR Assy) Hitam - BeAT FI	Cover Body	64000.0
5070AK56N10	Cover Body samping Kiri Honda Supra GTR 150	Cover Body	87500.0
64321K1ZJ10ZC	Pijakan Kaki Kiri Honda PCX 160 K1Z	Cover Body	71500.0
8114AK25900	Cover Inner Lower Assy - BeAT FI & BeAT FI CBS	Cover Body	67500.0
50265K15920MGB	Cover Body Depan Kiri Hitam Raptor Honda New CB150R StreetFire K15G	Cover Body	146500.0
80104K93N00	Tahanan Lumpur (Guard Splash) - Scoopy eSP K93	Cover Body	7500.0
61100K1AN00MGB	Spakbor Depan Hitam Doff Honda BeAT K1A	Cover Body	123000.0
81143K97T00ZA	Base Inner Pocket Lid - PCX 150 K97 & PCX Hybrid	Cover Body	10500.0
6451BK56N10	Cover Assy R Main Pipe Side - Supra GTR 150	Cover Body	65000.0
81131K59A10ZH	Cover Rack Grey - Vario 125 eSP & Vario 150 eSP	Cover Body	127000.0
19641K2FN10	Duct Cover - Honda Scoopy eSP K2F	Cover Body	10500.0
64308K25900ZA	Cover Depan Bawah (Cover Front Lower Hitam) - BeAT FI, BeAT FI CBS	Cover Body	164000.0
64601K59A70ZC	Cover L FR Hitam Doff - Vario 150 eSP (K59J)	Cover Body	259000.0
8352AK56N10	Cover Assy Taillight - Supra GTR 150	Cover Body	41000.0
50275K15920ZA	Cover Body Depan Atas Kiri Merah Honda New CB150R StreetFire K15G	Cover Body	80500.0
64310K2FN00ZC	Cover Pijakan Kaki Hitam Honda Scoopy K2F	Cover Body	74500.0
64501K59A70ZC	Cover R FR Hitam Doff - Vario 150 eSP K59J	Cover Body	259000.0
5325BK25610	Cover Batok Belakang Honda BeAT eSP K25 ISS	Cover Body	44000.0
5320CK46N20	Cover Batok Belakang Honda Vario 110 eSP Non ISS	Cover Body	53000.0
50280K15600	Cover Body Depan Bawah Kanan Honda New CB150R StreetFire K15M	Cover Body	43000.0
64301K25600RSW	Body Depan (Cover Front White) Putih - BeAT Sporty eSP (K25)	Cover Body	306000.0
64201K93N00ZN	Cover Depan Kanan Coklat Honda Scoopy eSP K93	Cover Body	138500.0
17575K61900	Cover Fuel Tank - BeAT POP eSP	Cover Body, Tangki Bensin (Fuel Tank)	10500.0
80103K64N00	Cover RR Fender Upper - All New CBR 250RR	Cover Body	20500.0
64460K93N00ZB	Lid Battery (CA BR) - Scoopy eSP K93	Cover Body	24000.0
64301K93N00ZN	Cover Front Top White - Scoopy eSP K93	Cover Body	274500.0
80151K81N00ZA	Cover Center - New BeAT eSP	Cover Body	27500.0
61100K59A10PFW	Spakbor Depan Putih Mutiara Honda Vario 150 eSP	Cover Body	211500.0
64321K0WN00ZB	Step Floor Kiri - ADV 150	Cover Body	102000.0
64521K0WN00	Cover FR Lower - ADV 150	Cover Body	98500.0
64501K97T00ZR	Cover R FR Side Hitam - PCX 150 K97	Cover Body	415000.0
64337K1ZJ10ZC	Cover Speedometer Belakang Hitam Honda PCX 160 K1Z	Cover Body	32500.0
64350K2SN00ZA	Cover Samping Bawah Kanan Honda Vario 160 K2S	Cover Body	46000.0
61100K56N10ZD	Spakbor Depan A Hitam Honda Supra GTR 150	Cover Body	202500.0
64251K45NL0	Panel Meter Honda CBR 150R K45R	Cover Body	71500.0
8114AK46N20	Cover Lower Assy - Vario 110 eSP	Cover Body	69000.0
64601K59A10PFW	Cover Left Front Putih (White) - Vario 125 eSP & Vario 150 eSP	Cover Body	228500.0
64202K2FN00ZQ	Cover Depan Kiri Putih Honda Scoopy K2F	Cover Body	168000.0
64336K1ZJ10ZC	Panel Front Meter Hitam Honda PCX 160 K1Z e:HEV	Cover Body	37000.0
64380K64N00	Inner B L Middle Cowl - New CBR 250RR	Cover Body	51000.0
64211K45N40ZD	Cover Tameng Depan Hitam Honda New CBR 150R K45G	Cover Body	512000.0
81141K2FN10ZE	Cover Inner (MT GN BL) Hitam Doff - Scoopy K2F	Cover Body	294500.0
83610K84920ZB	Cover Body (Set Illust L Side A Cover T1) - CRF 150L K84	Cover Body	171000.0
64501K2SN00ZD	Cover Right Front Hitam Doff Honda Vario 160 K2S	Cover Body	250000.0
64310K2FN00ZB	Step Floor Matte Brown (CA BR) - Honda Scoopy K2F	Cover Body	92500.0
61300K84920ZD	Cover Depan Putih Honda CRF 150L K84	Cover Body	81500.0
83141K45N40ZD	Cover Seat Lock Hitam - New CBR 150R K45G & New CBR 150R K45N	Cover Body	133000.0
8013AK45N40	Fender A Assy Rear Lower - New CBR 150R K45G	Cover Body	112000.0
80110K56NJ0	Cover Body Fender Rear Lower (Bawah) Honda Supra GTR 150	Cover Body	61000.0
61100K1AN00FMB	Spakbor Depan Hitam Metalik Honda BeAT K1A	Cover Body	110000.0
64405K0WN00ZB	Lid Fuel - Honda ADV 150	Cover Body	15500.0
61304K15900	Cover Meter Honda CB 150R StreetFire K15 (Old)	Cover Body	16500.0
64431K97T00YA	Cover R Floor Putih - PCX 150 K97	Cover Body	407000.0
18318K0WNA0	Tutup Knalpot Honda ADV 160	Cover Body	81500.0
17575K59A70	Cover Fuel Tank - New Vario 125 eSP K60R & New Vario 150 eSP K59J	Cover Body	13500.0
50285K15600	Cover Body Depan Bawah Kiri Honda New CB150R StreetFire K15M	Cover Body	59000.0
64502K96V00ZU	Cover L FR Side Putih - PCX 150 K97	Cover Body	460000.0
83550K84900ZA	Cover R Side B - CRF 150L	Cover Body	86500.0
64450K15600	Cover Fuel Tank - New CB150R StreetFire K15M	Cover Body	25500.0
83620KZR600ZB	Cover Body Kiri Side - Vario 125 FI	Cover Body	45500.0
50260K15920WRD	Cover Body Depan Kanan Merah Honda New CB150R StreetFire K15G	Cover Body	175000.0
80115K0JN00ZB	Base Licence Light Hitam Honda Genio	Cover Body	11000.0
80106K0WN00	Cover,Rear Fender Upper ADV 150	Cover Body	25500.0
81132K97N00	Pocket Inner - PCX 150 K97 & PCX Hybrid	Cover Body	21500.0
8011AK45N40	Fender B Assy Rear Honda New CBR 150R K45G	Cover Body	152500.0
17234K1ZJ10	Cover Air C Duct Honda PCX 160 K1Z	Cover Body, Saringan Udara (Filter)	16500.0
50270K15920ZB	Cover Body Depan Atas Kanan Hitam Raptor Honda New CB150R StreetFire K15G	Cover Body	73500.0
83640K18960ZA	Cover L Side Hitam - CB150 Verza	Cover Body	62500.0
64510K46N00	Garnish Front - Vario 110 FI	Cover Body	36000.0
64370K64N00	Inner B R Middle Cowl - New CBR 250RR	Cover Body	52000.0
64310K93N00ZC	Step Floor SID - Scoopy eSP K93	Cover Body	122000.0
64301K59A10ZF	Cover Front Hitam Doff - Vario 125 eSP & Vario 150 eSP	Cover Body	281500.0
64340K2SN00ZA	Cover Bawah Hitam Honda Vario 160 K2S	Cover Body	53000.0
64223K2FN00	Cover Depan (Stay Comp Front Cover) - Honda Scoopy eSP K2F	Cover Body	87000.0
67100K97N00ZA	Visor (Meter Set) - Honda New PCX 150 K97	Cover Body	228500.0
64302K59A70ZA	Cover Front Top NH 1 - Vario 125 eSP (K60R) & Vario 150 eSP (K59J)	Cover Body	149500.0
83700K81N00ZA	Cover Rear Center - New BeAT eSP	Cover Body	15500.0
64360K2SN00ZA	Cover Body Bawah Kiri Hitam Honda Vario 160 K2S	Cover Body	39000.0
80104K81N00	Tahanan Lumpur (Guard Splash) Honda BeAT eSP K81	Cover Body	12500.0
61100K25900ZA	Spakbor Depan Merah Honda BeAT FI K25	Cover Body	140500.0
50260K15920FMB	Cover Body Depan Kanan Hitam Honda New CB150R StreetFire K15G	Cover Body	158500.0
64301K81N00WRD	Cover Tameng Depan Merah (Red) - New BeAT eSP	Cover Body	486500.0
53204K81N00FMB	Cover Speedometer Honda BeAT eSP K81	Cover Body	172000.0
16305K84900	Cover Throttle - Honda CRF 150L	Cover Body	25500.0
64301K1AN00MCS	Cover Depan Tameng Silver (Cover Front) - Honda BeAT K1A	Cover Body	206500.0
64530K0WN00	Cover Under - ADV 150	Cover Body	73500.0
64231K45NL0	Cover Depan Kiri (Cover Left Front Side) - Honda CBR 150R K45R	Cover Body	38000.0
5320CK46N30	Cover Batok Belakang Honda Vario 110 Esp ISS	Cover Body	66000.0
53205K25900FMB	Cover Batok Kepala Depan Hitam Honda BeAT FI (K25)	Cover Body	97500.0
19742KZL930	Cap Cover Kiri - Spacy	Cover Body	30500.0
17560K84900	Cover Body Tengah Kanan Honda CRF 150L	Cover Body	71500.0
61100K93N00ZN	Spakbor Depan Hitam Honda Scoopy eSP K93	Cover Body	263000.0
83520K81N00ZA	Cover Right Body Side - New BeAT eSP	Cover Body	64000.0
61100K15920ZA	Spakbor Depan Merah Honda New CB150R Streetfire K15G	Cover Body	268000.0
8125CK59A10	Cover Assy Battery - Vario 125 eSP & Vario 150 eSP	Cover Body	28500.0
81131K59A70YA	Cover Rack Black - Honda New Vario 125 eSP K60R	Cover Body	132000.0
53206K0WN00	Cover Stang Honda ADV 150	Cover Body	12500.0
61300K56N00ZA	Cover Lampu Depan Honda Sonic 150R	Cover Body	40000.0
64431K0WN00ZA	Cover R Floor Side Hitam Doff - ADV 150	Cover Body	173000.0
64310K0JN00ZA	Step Floor CA BR - Honda Genio	Cover Body	71500.0
8114AK81N00	Cover Inner Lower Assy - New BeAT Sporty eSP K81	Cover Body	70500.0
64241K45NA0	Cowl FR Lower - CBR 150R K45N	Cover Body	53500.0
64301K25900CSR	Cover Body Depan (Cover Front ) Merah - BeAT FI (K25)	Cover Body	320000.0
64432K97T00YA	Cover L Floor Putih - PCX 150 K97	Cover Body	407000.0
64301K59A10ZH	Cover Front Hitam - Vario 125 eSP & Vario 150 eSP	Cover Body	283500.0
64201K2FN00ZQ	Cover Depan Kanan Putih Doff Honda Scoopy K2F	Cover Body	168000.0
64502K1ZJ10ZQ	Cover Depan Kiri Biru Doff Honda PCX 160 K1Z	Cover Body	458000.0
64432K0WN00ZA	Cover L Floor Side Hitam Doff - ADV 150	Cover Body	173000.0
64202K93N00ZQ	Cover Depan Kiri Putih Honda Scoopy eSP (K93)	Cover Body	127000.0
64330K25900ZA	Cover Kiri Bawah BeAT FI, BeAT FI CBS BeAT Sporty eSP	Cover Body	34500.0
8351AK64N00	Cover Set Samping Kanan - CBR 250RR	Cover Body	71500.0
64110K64N00	Wind Screen Honda CBR 250RR	Cover Body	122000.0
80106K59A70	Tahanan Lumpur (Guard Duct) - New Vario 125 eSP K60R & New Vario 150 eSP K59J	Cover Body	6000.0
61100K59A70ZF	Spakbor Depan Hitam Doff Honda Vario 150 K59J	Cover Body	278500.0
80105K2FN00	Spakbor Belakang (Fender RR) - Honda Scoopy K2F	Cover Body	133000.0
83700K61900ZA	Cover Belakang (Cover, Rear Cente) - BeAT POP eSP	Cover Body	13500.0
64224K64N00	Panel Meter - CBR 250RR	Cover Body	45000.0
83640K15920	Cowl Left Side - New CB150R StreetFire K15G	Cover Body	38000.0
81132K2VN30	Cover Kantong Bawah Kiri Honda Vario 125 eSP K2V	Cover Body	31000.0
64337K0WN00ZB	Cover Indicator - ADV 150	Cover Body	25500.0
53205K25900PFW	Cover Batok Kepala Depan Putih Honda BeAT FI, BeAT CBS FI (K25)	Cover Body	104000.0
6431AK25600	Step Assy Floor - BeAT eSP New (K25)	Cover Body	106000.0
61100K25900ZC	Spakbor Depan Putih Honda BeAT FI CBS K25	Cover Body	112000.0
64301K93N00ZP	Cover Tameng Depan Hitam - Scoopy eSP K93	Cover Body	253000.0
50275K15920ZB	Cover Body Depan Atas Kiri Hitam Raptor Honda New CB150R StreetFire K15G	Cover Body	73500.0
64301K81N00VBM	Cover Tameng Depan Biru - New BeAT eSP	Cover Body	499500.0
17218K84900	Cover Mud Guard T Set - Honda CRF 150L	Cover Body	20500.0
64201K93N00ZP	Cover Depan Kanan Merah Honda Scoopy eSP K93	Cover Body	132000.0
8010BK61900	Cover Spakbor Belakang (Fender, Rear Assy) - BeAT POP eSP	Cover Body	92500.0
64202K93N00ZG	Cover Depan Kiri Merah Honda Scoopy eSP K93	Cover Body	163500.0
8352AK64N00	Cover Set Samping Kiri (WL) - CBR 250RR	Cover Body	71500.0
81131K93N00	Pocket R Inner - Scoopy eSP K93	Cover Body	38000.0
18356K56N00	Protector Muffler - Sonic 150R	Cover Body	46000.0
61100K15920ZB	Spakbor Depan Hitam Honda New CB150R Streetfire K15M	Cover Body	223500.0
50270K15920ZC	Cover Body Depan Atas Kanan Putih Honda New CB150R StreetFire K15G	Cover Body	79500.0
50275K15920ZD	Cover Body Depan Atas Kiri Hitam Honda New CB150R StreetFire K15G	Cover Body	77500.0
83450K15920ZB	Cowl Rear Center Hitam (Raptor Black) - New CB150R StreetFire K15G	Cover Body	57000.0
83141K45N40ZB	Cover Seat Lock Putih - New CBR 150R K45G	Cover Body	156500.0
8321AK45N40	Cover Assy Right Side - New CBR 150R K45G	Cover Body	28000.0
64301K59A10ZG	Cover Front Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	271500.0
64320K2VN30ZA	Garnish Kanan Depan Hitam Honda Vario 125 eSP K2V	Cover Body	10000.0
64310K0JN00ZC	Cover Step Floor Honda Genio	Cover Body	86500.0
83520K1AN00ZA	Cover,Right Body Side (Black) - BeAT K1A	Cover Body	44000.0
64301K1AN00FMB	Cover Tameng Depan (Cover ,Front(Black) Hitam Metalik - Honda BeAT K1A	Cover Body	203500.0
81250K97T00	Box Bagasi (Box Luggage) - PCX 150 K97	Bagasi (Luggage), Cover Body	230500.0
80103K84900	Cover Duct - CRF 150L	Cover Body	20500.0
80107KVY900	Guard Heat - BeAT Karbu	Cover Body	5000.0
83680K64N00	Cowl L RR Inner - CBR 250RR	Cover Body	41000.0
64460K93N00ZC	Lid Battery R - Scoopy eSP K93	Cover Body	96500.0
17245K0JN00	Cover Sub Assy, Air/C - Genio & BeAT K1A	Cover Body, Saringan Udara (Filter)	39000.0
81131K0WN00ZB	Cover,Inner - ADV 150	Cover Body	56500.0
40510K15920	Tutup Rantai Honda New CB150R StreetFire K15G	Cover Body	46500.0
83620K81N00ZA	Cover Left Body Side - New BeAT eSP	Cover Body	74000.0
40510K45N40	Case Drive Chain - New CBR 150R K45G & New CBR 150R K45N	Cover Body	56000.0
80101K1ZN20	Spakbor Belakang Honda PCX 160 K1Z	Cover Body	99500.0
64432K1ZJ10ZJ	Cover Body Bawah Kiri Biru Doff Honda PCX 160 K1Z	Cover Body	368000.0
64410K1ZJ10ZC	Cover A Center Black - Honda PCX 160	Cover Body	30500.0
61100K84900ZD	Spakbor Depan Hitam Honda CRF 150L K84	Cover Body	203500.0
53205K25600CSR	Cover Batok Kepala Depan Merah Honda BeAT Sporty eSP (K25)	Cover Body	147500.0
64502K96V00ZV	Cover L FR Side Hitam - PCX 150 K97	Cover Body	415000.0
64301K59A70ZC	Cover Front Hitam Doff - New Vario 150 K59J	Cover Body	253000.0
81322K97T00	Cover Battery - PCX 150 K97	Cover Body	9000.0
80111K45N40	Fender B, RR. - New CBR 150R K45G & New CBR 150R K45N	Cover Body	152500.0
83670K64N00	Cowl R RR Inner - CBR 250RR	Cover Body	41000.0
40510K56N10	Case Drive Chain (Tutup Rantai) - Supra GTR 150	Cover Body	48000.0
64202K2FN00ZJ	Cover Depan Kiri Hitam Honda Scoopy K2F	Cover Body	137500.0
61302K18960	Cowl R FR Side - CB150 Verza	Cover Body	25500.0
64201K93N00ZG	Cover Depan Kanan Merah Scoopy eSP K93	Cover Body	163500.0
50410K93N00ZD	Behel (Rail RR Grab Axis Gray) - Scoopy eSP K93	Cover Body	172500.0
61100K56N10ZC	Spakbor Depan A Biru Honda Supra GTR 150	Cover Body	198000.0
50270K15920ZD	Cover Body Depan Atas Kanan Hitam Honda New CB150R StreetFire K15G	Cover Body	77500.0
83540K15920	Cowl Right Side - New CB150R StreetFire K15G	Cover Body	52000.0
53208K59A10PFW	Cover Speedometer Putih Honda Vario 150 eSP	Cover Body	113000.0
64521K0WNA0	Cover Tutup Depan Bawah Honda ADV 160	Cover Body	152000.0
64201K2FN00ZK	Cover Depan Kanan Brown Honda Scoopy K2F	Cover Body	162500.0
53204K1AN00FMB	Cover Speedometer Hitam Metalik Honda BeAT K1A	Cover Body	71500.0
19640K0WN00	Cover Saluran Udara CVT (Duct Comp L Cover) honda ADV 150	Cover Body	46000.0
64202K93N00ZP	Cover Depan Kiri Merah Honda Scoopy eSP K93	Cover Body	132000.0
64431K97T00ZS	Cover R Floor Hitam - PCX 150 K97	Cover Body	383000.0
83610K64N00ZB	Set RR Center Cowl (Black) - New CBR 250RR	Cover Body	110000.0
53205K93N00ZL	Cover A Speedometer Black - Scoopy eSP K93	Cover Body	101000.0
64460K81N00ZA	Lid Battery - New BeAT eSP	Cover Body	25000.0
83121K45N40ZB	Cowl Left Rear Putih - New CBR 150R K45G	Cover Body	313000.0
64302K2SN00ZA	Cover Tameng depan Hitam Honda Vario 160 K2S	Cover Body	240000.0
64501K1ZJ10ZR	Cover Depan Kanan Hitam Doff Honda PCX 160 K1Z	Cover Body	464000.0
19640K1ZJ10	Duct Comp L Cover Honda PCX 160 K1Z	Cover Body	32500.0
64432K0WN00ZB	Cover L Floor Side Silver - ADV 150	Cover Body	173000.0
51620K84900ZC	Cover Shock Depan (Protector FR Fork L) Black - CRF 150L K84	Cover Body	58000.0
83540K18960ZA	Cover Samping Kanan (Cover R Side) - CB 150 Verza	Cover Body	62000.0
53205K25600FMB	Cover Batok Kepala Depan Hitam Honda BeAT Sporty eSP (K25)	Cover Body	105000.0
8113BK61900	Dek Kunci Tengah (Cover, Inner Assy) - BeAT POP eSP	Cover Body	116000.0
53206K81N30MAG	Cover Stang Honda BeAT Street K81	Cover Body	126000.0
64210K64N00ZC	Cover Tameng Depan Hitam Honda CBR 250RR	Cover Body	793000.0
53216K56N40ZA	Cover Batok Belakang Merah Honda Supra GTR	Cover Body	85500.0
5060AK56N10	Cover Body Samping Kanan Supra GTR 150	Cover Body	81500.0
83141K45N40ZC	Cover Seat Lock Putih Repsol - New CBR 150R K45G & New CBR 150R K45N	Cover Body	159500.0
19640K2SN00	Cover Saluran Udara CVT (Duct Comp L Cover) Honda Vario 160 K2S	Cover Body	28000.0
64201K2FN00ZJ	Cover Samping Kanan Hitam Honda Scoopy K2F	Cover Body	137500.0
61200K2SN00	Spakbor Depan B Honda Vario 160 K2S	Cover Body	70500.0
83700K1AN00ZA	Cover Belakang (Cover Rear Center MBNH-1) - Honda BeAT K1A	Cover Body	20500.0
80100K59A10	Spakbor Belakang (Fender Rear) - Vario 125 eSP K60	Cover Body	193500.0
64601K59A70ZR	Cover L FR Hitam Metalik- New vario 125 eSP K60R	Cover Body	295500.0
83640K15600ZA	Cowl L Side - New CB150R StreetFire K15M	Cover Body	43000.0
6431AK46N20ZA	Pinjakan Kaki (Step Assy Floor) - Vario 110 eSP	Cover Body	82500.0
50275K15600ZA	Cover Body Depan Atas Kiri Merah Doff Honda New CB150 StreetFire K15M	Cover Body	77500.0
64501K59A70ZR	Cover R FR (AF BL ME) - New Vario 125 eSP (K60R)	Cover Body	295500.0
83650K61900ZA	Cover Kiri Belakang (Cover, Left Rear Side) - BeAT POP eSP	Cover Body	23000.0
1964AK25600	Duct Assy L Cover - BeAT POP eSP, BeAT Sporty eSP & Vario 110 eSP	Cover Body, Tutup Mesin (Crank Case Cover)	22500.0
5061AK25900	Cover Bawah Honda BeAT FI K25	Cover Body	50500.0
61100K59A10RSW	Spakbor Depan Putih Honda Vario 150 eSP	Cover Body	273500.0
64421K93N00ZK	Cover Kanan Bawah (Under Right Side) Hiatm- Scoopy eSP K93	Cover Body	137500.0
53206K93N00ZL	Cover B Speedometer Black - Scoopy eSP K93	Cover Body	90500.0
64420K2VN30ZA	Garnish Kiri Depan Hitam Honda Vario 125 eSP K2V	Cover Body	10000.0
81141K2VN30ZA	Cover Inner Hitam Honda Vario 125 eSP K2V	Cover Body	124000.0
64432K1ZJ10ZT	Cover Left Floor Side Hitam Doff Honda PCX 160 K1Z	Cover Body	379000.0
61102K18900	Stay Front Fender - Honda CB150 Verza, Verza 150	Cover Body	21000.0
80100K56NJ0	Fender,Rear Upper Honda Supra GTR 150 K56W	Cover Body	53000.0
81138K0WN00ZB	Outer R Inner Cover - ADV 150	Cover Body	25500.0
81141K46N30	Cover Lower - New Vario 110 eSP	Cover Body	61500.0
64502K96V00ZT	Cover L FR Side Red - New PCX 150 K97	Cover Body	456000.0
77230K18960ZA	Cowl Tengah Belakang (Cowl RR Center) - CB 150 Verza	Cover Body	19500.0
80105K97T00	Fender C Assy Rear Top - PCX 150 K97	Cover Body	44000.0
64421K93N00ZN	Cover Under Side Kanan Coklat - Scoopy eSP K93	Cover Body	132000.0
53250K97T00	Cover Stang Belakang Honda PCX 150 K97	Cover Body	64000.0
53210K56N10ZA	Cover Batok Depan Supra GTR 150	Cover Body	63000.0
50265K15920FMB	Cover Body Depan Kiri Hitam Honda New CB150R StreetFire K15G	Cover Body	158500.0
81200K81N00	Rail Rear Grab - New BeAT eSP	Cover Body	193000.0
83121K45N40WRD	Cowl Left Rear Merah - New CBR 150R K45G & New CBR 150R K45N	Cover Body	269500.0
64302K2VN30ZA	Cover Tameng Depan Hitam Doff Honda Vario 125 eSP K2V	Cover Body	152000.0
64501K1ZJ10ZQ	Cover Kanan Depan Biru Doff Honda PCX 160 K1Z	Cover Body	458000.0
53205K1AN00ZE	Cover Batok Kepala Depan Hitam Doff Honda BeAT K1A	Cover Body	104000.0
81131K46N00ZA	Cover Inner Upper - Vario 110 FI	Cover Body	74000.0
5320CK46N00	Cover Batok Belakang (Handle Rear Assy) - Vario 110 FI	Cover Body	21500.0
53205K81N00ZB	Cover Batok Depan Black Honda BeAT Sporty eSP K81	Cover Body	105000.0
64301K93N00ZM	Cover Front Top Red - Scoopy eSP K93	Cover Body	274500.0
64301K93N00ZR	Cover, FR. Top Putih - Scoopy eSP (K93)	Cover Body	238000.0
64431K93N00ZN	Cover Left Under Sid Coklat Doff - Scoopy eSP (K93)	Cover Body	132000.0
50186K45N40	Bracket Rear Fender New CBR 150R	Breket (Bracket), Cover Body	113000.0
64301K93N00ZK	Cover Front Top Cream - Scoopy eSP K93	Cover Body	274500.0
61302K56N00ZB	Cowl R FR Side Merah - Sonic 150R	Cover Body	81500.0
64301K81N00SMM	Cover Tameng Depan Magenta - New BeAT eSP	Cover Body	442000.0
64304K2SN00ZA	Inner Front Top Hitam Honda Vario 160 K2S	Cover Body	25000.0
64301K2FN00ZQ	Cover Tameng Depan Putih Honda Scoopy K2F	Cover Body	330000.0
50312K97N00	Cover Dudukan Lampu Depan Kiri PCX 150 K97	Cover Body	113500.0
81142K1AN10ZA	Lid,Inner Pocket (Black) - BeAT K1A	Cover Body	21000.0
50311K0WN00	Cover Dudukan Lampu Depan Kanan Honda ADV 150	Cover Body	147500.0
6431AK25900	Step Floor Assy - BeAT FI, BeAT FI CBS	Cover Body	99500.0
64501K97T00YC	Cover R FR Sid Cowl Merah - PCX 150 K97	Cover Body	456000.0
53205K81N30ZA	Cover Stang Depan Honda BeAT Street eSP K81	Cover Body	81500.0
61100K64N00ZB	Spakbor Depan Hitam Honda CBR 250RR	Cover Body	276500.0
64211K45N40WRD	Cover Tameng Depan Merah Honda New CBR 150R K45G	Cover Body	508000.0
8322AK45N40	Cover Assy Left Side - New CBR 150R K45G	Cover Body	28000.0
64502K1ZJ10ZS	Cover Depan Kiri Putih Honda PCX 160 K1Z	Cover Body	485000.0
64202K2FN00ZK	Cover Depan Kiri Brown Honda Scoopy K2F	Cover Body	162500.0
64510K56N10	Cover Right Main Pipe Rear Honda New Sonic 150R Supra GTR 150	Cover Body	61000.0
51610K84900ZC	Cover Shock Depan (Protector FR Fork R) Black - CRF 150L K84	Cover Body	58000.0
83650K46N00ZA	Cover Body Kiri (Cover Left Body Side) - Vario 110 FI	Cover Body	31500.0
81137K97T00ZT	Lid Smart Emg Merah - PCX 150 K97	Cover Body	204000.0
61303K56N00ZD	Garnis Kiri Putih Honda Sonic 150R	Cover Body	77500.0
61100K59A10WRD	Spakbor Depan Merah Honda Vario 150 eSP	Cover Body	220500.0
53208K59A10MIB	Cover Speedometer Biru Honda Vario 150 eSP	Cover Body	111000.0
81131K2VN30ZM	Cover Rack Hitam Honda Vario 125 eSP	Cover Body	155000.0
64223K2FN80	Stay Comp Front Cover Honda Scoopy K2F	Cover Body	68000.0
53280K2VN30ZA	Cover Batok Belakang Honda Vario 125 eSP K2V	Cover Body	37000.0
64502K1ZJ10ZR	Cover Depan Samping Kiri Hitam Doff Honda PCX 160 K1Z	Cover Body	464000.0
64301K2FN00ZK	Cover Tameng Depan Brown Honda Scoopy K2F	Cover Body	279500.0
64601K2SN00ZD	Cover Left Front Hitam Doff Honda Vario 160 K2S	Cover Body	250000.0
5061AK46N20ZA	Cover Bawah Honda Vario 110 eSP	Cover Body	106000.0
11360K56N10	Cover Comp L Rear - Supra GTR 150 K56F	Cover Body	49000.0
17546K84920ZA	Cover Body Set Kanan Hitam Type 2 - CRF 150L K84	Cover Body	173000.0
64460K59A70ZB	Lid, Battery - New Vario 150 K59J & New Vario 125 K60R	Cover Body	21000.0
81133K97T00	Cover Hinge - PCX 150 K97	Cover Body	7500.0
6430BK61900	Cover Depan Bawah (Cover Assy, Front Lower) - BeAT POP eSP	Cover Body	69500.0
83610K84901ZB	Cover Set A L Side (WL) - CRF 150L	Cover Body	157500.0
6131BK15900	Dudukan Lampu Depan Honda CB150R StreetFire (Old)	Cover Body	75000.0
6431AK46N00ZA	Pinjakan Kaki (Step Floor Assy) - Vario 110 FI	Cover Body	100000.0
1974AK25900	Duct Set L Cover - BeAT FI & BeAT FI CBS	Cover Body	17500.0
6130AK18900	Cover Lampu Depan Honda Verza 150	Cover Body	46000.0
61304K56N00ZF	Garnis Bawah Hitam Doff Honda Sonic 150R	Cover Body	86500.0
83630K64N00ZB	Body Belakng Kiri Cowl L Rear (Doft) - New CBR 250RR K64	Cover Body	283500.0
83610K15920MGB	Cowl Right Rear Hitam (Raptor Black) - New CB150R StreetFire K15G	Cover Body	122000.0
83111K45N40WRD	Cowl Right Rear Merah - New CBR 150R K45G & New CBR 150R K45N	Cover Body	269500.0
64501K59A10MJB	Cover Right Front Coklat (Brown) - Vario 125 eSP & Vario 150 eSP	Cover Body	241000.0
81141K2VN40ZB	Cover Inner Lower Hitam Honda Vario 125 eSP K2V	Cover Body	133000.0
81142K2SN00ZD	Cover Inner Upper Hitam Doff Honda Vario 160 K2S	Cover Body	304000.0
64431K1ZJ10ZS	Cover R Floor Sid Merah Doff Kanan Honda PCX 160 K1Z	Cover Body	436000.0
50311K97N00	Cover Dudukan Lampu Depan Kanan Honda PCX 150 K97	Cover Body	125500.0
64202K0JN00ZC	Cover Depan Kiri Hitam Doff Honda Genio	Cover Body	147500.0
80110K18960	Spakbor Belakang (Fender A Rear) - CB 150 Verza	Cover Body	87000.0
61100K25900ZJ	Spakbor Depan Biru Honda BeAT FI K25	Cover Body	126000.0
83221K45N40	Cover Samping Kiri (Hitam Doff) - New CBR 150R K45G & New CBR 150R K45N	Cover Body	28000.0
61100K93N00ZQ	Spakbor Depan Putih Honda Scoopy eSP K93	Cover Body	258000.0
64305K97T00YA	Garnish FR Putih - PCX 150 K97	Cover Body	306000.0
81134K93N00ZJ	Cover Inner Upper Cush White - Scoopy eSP K93	Cover Body	64000.0
50400K56N10ZA	Grip RR - Supra GTR 150	Cover Body	191000.0
83131K45N40ZA	Cowl Rear Center Merah - New CBR 150R K45G & New CBR 150R K45N	Cover Body	132000.0
53208K59A10AFB	Cover Speedometer Hitam Metallic Honda Vario 125 eSP	Cover Body	108000.0
64223K0JN00	Stay Comp Front Cover Honda Genio	Cover Body	76500.0
64301K1AN00VRD	Cover Tameng Depan Merah Metalik - Honda BeAT K1A	Cover Body	232500.0
81141K0WN00ZB	Lid,Inner Pocket - ADV 150	Cover Body	20500.0
80104K0JN00	Tahanan Lumpur (Guard,Splash) - BeAT K1A & Genio	Cover Body	11000.0
81141K0JN00ZA	Cover,Inner Coklat - Honda Genio	Cover Body	87000.0
83540K15600ZA	Cowl R Side - New CB150R StreetFire (K15M)	Cover Body	39000.0
83211K45N40	Cover R Side Hitam Doff - New CBR 150R K45G & New CBR 150R K45N	Cover Body	31000.0
80131K45N40	Fender A, RR. Lower - New CBR 150R K45G & New CBR 150R K45N	Cover Body	132000.0
61100K84900ZB	Spakbor Depan Merah Honda CRF 150L	Cover Body	193000.0
64320K15930ZA	Cowl Under Center NH-167M - New CB150R Streetfire K15G	Cover Body	104000.0
64411K45N40WRD	Cowl Left Middle A Merah - New CBR 150R K45G & New CBR 150R K45N	Cover Body	659000.0
83750K59A10ZK	Cover Rear Center Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	70500.0
64503K1ZJ10ZS	Cover Front Center Putih Honda PCX 160 K1Z	Cover Body	183000.0
64502K1ZJ10ZP	Cover Depan Kiri Merah Doff Honda PCX 160 K1Z	Cover Body	521000.0
50312K1ZJ10	Stay Left Front Cover Honda PCX 160 K1Z	Cover Body	153000.0
53208K46N00ZC	Cover Speedometer Merah Maroon Honda Vario 110 eSP	Cover Body	68500.0
64432K97T00ZY	Cover Floor Sid Kiri Merah - PCX 150 K97	Cover Body	414000.0
50621K25600ZA	Cover Bawah Honda BeAT eSP K25	Cover Body	48500.0
80110KVB930	Spakbor Belakang (Fender Assy RR) - Vario Karbu	Cover Body	89500.0
80101K64N00	Fender B Rear - New CBR 250RR	Cover Body	223500.0
83500K93N00ZK	Cover R Body Brown - Scoopy eSP K93	Cover Body	434500.0
50275K15920ZC	Cover Body Depan Atas Kiri Putih Honda New CB150R StreetFire K15G	Cover Body	79500.0
64311K45N40ZA	Cowl Right Middle A Hitam (Black) - New CBR 150R K45G CBR 150R K45N	Cover Body	631500.0
64311K45N40WRD	Cowl Right Middle A Merah - New CBR 150R K45G & New CBR 150R K45N	Cover Body	659000.0
64303K2VN30ZA	Garnish Depan Hitam Honda Vario 125 eSP K2V	Cover Body	49000.0
64601K2SN00ZM	Cover Left Front Hitam Honda Vario 160 K2S	Cover Body	254000.0
64521K1ZJ10	Cover Front Lower Hitam - Honda PCX 160 K1Z,PCX 160 e:HEV	Cover Body	49000.0
83650K84900ZC	Cover L Side B (BAS GR) - Honda CRF 150L	Cover Body	86500.0
64501K59A70YD	Body Depan Kanan (Cover R FR Black) - Honda Vario 125 eSP K60R 64501K59A70YD	Cover Body	254000.0
81139K0WN00ZA	Garnish Lower Inner Cover Hitam Doff - ADV 150	Cover Body	86500.0
64434K0WN00ZB	Lid Plug Maintenance - ADV 150	Cover Body	18500.0
81255K59A70	Tutup Accu (Cover Battery) - New Vario 125 eSP & New Vario 150 eSP	Cover Body, Suku Cadang Resmi Motor Honda	11500.0
83500K59A70ZC	Cover Body Kanan Hitam - New Vario 150 eSP K59J	Cover Body	459000.0
83141K45N40ZE	Cover Seat Lock Hitam Doff - New CBR 150R K45G & New CBR 150R K45N	Cover Body	152500.0
64301K93N00ZQ	Cover, FR. Top Merah - Scoopy eSP K93	Cover Body	248000.0
81250K25600	Box Bagasi (Box Luggage) - BeAT FI	Bagasi (Luggage), Cover Body	134000.0
64501K97T00YB	Cover R FR Sid Cowl Gold - PCX 150 K97	Cover Body	539000.0
40510K64N00	Case Drive Chain - New CBR 250RR	Cover Body	102000.0
64201K93N00ZH	Cover Depan Kanan Putih Honda Scoopy eSP K93	Cover Body	163500.0
81134K93N00ZL	Cover Inner Upper Cush Black - Scoopy eSP K93	Cover Body	64000.0
50260K15920RSW	Cover Body Depan Kanan Putih Honda New CB150R StreetFire K15G	Cover Body	162500.0
83710K15920MGB	Cowl Left Rear Hitam (Raptor Black) - New CB150R StreetFire K15G	Cover Body	122000.0
61303K15920ZA	Cowl Left Front Side Merah (Red) - New CB150R StreetFire K15G	Cover Body	111000.0
64211K45N40ZC	Cover Tameng Depan Putih Honda New CBR 150R K45G	Cover Body	603000.0
84100K59A10ZE	Rail Rear Grab - Vario 125 eSP & Vario 150 eSP	Cover Body	201500.0
50706K56N10	Cover Kiri Pivot Honda Supra GTR K56F	Cover Body	49000.0
81136K2SN00	Box Inner Upper Honda Vario 160 K2S	Cover Body	17500.0
64501K1ZJ10ZN	Cover Kanan Depan Hitam Metalic Honda PCX 160 K1Z	Cover Body	467000.0
64421K0JN00ZC	Cover Bawah Kanan (Cover Right Under Side) Hitam Doff - Honda Genio	Cover Body	147500.0
64431K93N00ZP	Cover Under Side Kiri Merah - Scoopy eSP K93	Cover Body	127000.0
53206K41N00ZA	Cover Batok Belakang Honda Supra X 125 FI	Cover Body	174000.0
8125AK25900	Box Bagasi (Box, Luggage Set) - BeAT FI	Bagasi (Luggage), Cover Body	85500.0
64432K97T00ZS	Cover L Floor Side Hitam - PCX 150 K97	Cover Body	383000.0
64503K97T00ZX	Cover FR Center Merah Doff PCX 150 K97	Cover Body	216000.0
64310K25600ZA	Step Floor - BeAT Sporty eSP K25G	Cover Body	112000.0
83620K64N00ZB	Cover Body Belakang Kanan Cowl R Rear (Doft) - New CBR 250RR K64	Cover Body	284500.0
50265K15920WRD	Cover Body Depan Kiri Merah Honda New CB150R StreetFire K15	Cover Body	175000.0
6431AK81N00	Step Assy Floor - BeAT eSP New	Cover Body	90500.0
64301K81N00RSW	Cover Tameng Depan (Cover Front White) Putih - New BeAT eSP	Cover Body	466000.0
64321K45N40ZA	Cowl B Right Middle Hitam - New CBR 150R K45G & New CBR 150R K45N	Cover Body	624500.0
83750K59A10ZM	Cover Rear Center Hitam (Black) - Vario 125 eSP & Vario 150 eSP	Cover Body	70500.0
53208K59A10MGB	Cover Speedometer Hitam Doff Honda Vario 125 eSP	Cover Body	110000.0
64301K1AN00MBS	Cover Tameng Depan Dark Silver Honda BeAT K1A	Cover Body	183000.0
80104KVY870	Tahanan Lumpur Honda BeAT Karburator KVY	Cover Body	5500.0
64432K2SN00ZL	Cover Left Floor Side Putih Honda Vario 160 K2S	Cover Body	152500.0
64501K2SN00ZK	Cover Right Front Merah Doff Honda Vario 160 K2S	Cover Body	289500.0
64305K1ZJ10ZS	Garnish Front Putih Mutiara Honda PCX 160 K1Z	Cover Body	240000.0
64326K1ZJ10	Mat Left Floor Honda PCX 160 K1Z	Cover Body, Suku Cadang Resmi Motor Honda	34000.0
64325K1ZJ10	Mat Right Floor Honda PCX 160 K1Z	Cover Body, Suku Cadang Resmi Motor Honda	34000.0
50311K1ZJ10	Stay Right Front Cover Honda PCX 160 K1Z	Cover Body	138000.0
81131K1ZJ10ZC	Cover,Inner Hitam - Honda PCX 160 K1Z	Cover Body	88500.0
64421K2FN00ZJ	Cover Bawah (Cover Under SID AS BK MT) - Honda Scoopy eSP K2F	Cover Body	137500.0
61100K59A70ZY	Spakbor Depan Hitam Honda Vario 150 eSP K59J	Cover Body	233500.0
11350K0WN00	Tutup Rantai (Cover Comp,L Rear) - ADV 150	Cover Body	20500.0
83620K1AN00ZA	Cover,Left Body Side Hitam - BeAT K1A	Cover Body	44000.0
81140K0WN00ZA	Garnish Upper Inner Cover Hitam Doff - ADV 150	Cover Body	86500.0
61100K81N00ZE	Spakbor Depan Hitam Doff Honda BeAT eSP K81	Cover Body	142500.0
67111K45NA0	Screen Win - New CBR 150R K45N	Cover Body	112000.0
32112K97T00	Cover Sensor (Protector Speed Sensor) - PCX 150 k97 & PCX Hybrid	Cover Body	11500.0
80110K84920ZC	Spakbor Belakang (Set Illust RR Fender Comp T3) - CRF 150L K84	Cover Body	355500.0
17556K84920ZA	Cover Body Set Kiri Hitam Type 2 CRF 150L K84	Cover Body	173000.0
83610K15600MGB	Cowl R Rear Hitam - New CB150R StreetFire K15M	Cover Body	149000.0
53205K81N00ZE	Cover Batok Depan Putih Honda BeAT Sporty eSP K81	Cover Body	105000.0
50275K15600ZC	Cover Body Depan Atas Kiri Hitam Doff Honda New CB150R StreetFire K15M	Cover Body	67000.0
64305K97T00ZX	Garnish FR Merah - PCX 150 K97	Cover Body	313000.0
80104K64N00	Cover RR Fender Lower - All New CBR 250RR	Cover Body	32000.0
64211K45N40ZB	Cover Tameng depan Merah Honda New CBR 150R K45G	Cover Body	758500.0
83600K93N00ZK	Cover Body Kiri Brown Honda Scoopy eSP K93	Cover Body	434500.0
64421K93N00ZG	Cover Under R Side Red - Scoopy eSP K93	Cover Body	138500.0
83610K64N00ZA	Set Rear Center Cowl Red - CBR 250RR	Cover Body	125000.0
83620K56N00FMB	Cover L Body Hitam - Sonic 150R	Cover Body	128000.0
61302K15920ZB	Cover Depan Samping Kanan Hitam Doff Honda CB150R K15G	Cover Body	96500.0
64411K45N40ZA	Cowl Left Middle A Hitam - New CBR 150R K45G & New CBR 150R K45N	Cover Body	631500.0
64211K45N40NOR	Cover Tameng Depan Repsol Honda New CBR 150R K45G	Cover Body	549500.0
53208K59A10CSR	Cover Speedometer Merah Honda Vario 125 eSP	Cover Body	133000.0
83155K64NP0	Cover Center Tank Hitam Honda CBR 250RR K64J	Cover Body	39000.0
64431K2SN00ZD	Cover Samping Bawah Kanan Hitam Doff Honda Vario 160 K2S	Cover Body	152500.0
53280K2SN00ZA	Cover Batok Belakang Honda Vario 160 K2S	Cover Body	37000.0
53206K1AN00ZA	Cover Batok Belakang Honda BeAT K1A	Cover Body	36000.0
11340K64N00	Cover Assy Kiri Belakang Honda All New CBR 250RR	Cover Body	458000.0
50400KVY900	Behel (Rail RR Grab) - BeAT Karburator	Cover Body	193000.0
53205K59A70ZB	Cover Batok Depan Honda New Vario 150 K59J	Cover Body	116000.0
64421K93N00ZP	Cover Under Side Kanan Merah - Scoopy eSP K93	Cover Body	127000.0
53205K41N00ZA	Cover Batok Kepala Depan Honda Supra X 125 FI	Cover Body	146500.0
64431K97T00ZY	Cover R Floor Merah - PCX 150 K97	Cover Body	414000.0
83450K15920ZA	Cowl Rear Center Merah - New CB150R StreetFire K15G	Cover Body	65000.0
83600K93N00ZN	Cover L Body Black - Scoopy eSP K93	Cover Body	417500.0
50265K15920RSW	Cover Body Depan Kiri Putih Honda New CB150R StreetFire K15G	Cover Body	162500.0
61302K15920ZA	Cover Depan Samping Kanan Merah Honda CB150R StreetFire K15G	Cover Body	111000.0
64341K45N40ZA	Cowl Right Under Putih (White) - New CBR 150R K45G & New CBR 150R K45N	Cover Body	376000.0
64601K59A10WRD	Cover Left Front Merah (WRD) - Vario 125 eSP & Vario 150 eSP	Cover Body	251000.0
64601K59A10MIB	Cover Left Front Biru - Vario 125 eSP & Vario 150 eSP	Cover Body	227500.0
53207K07900ZB	Visor Depan Honda Supra X 125 FI	Cover Body	45000.0
64501K2VN30MPC	Cover Depan Kanan Putih Doff Honda Vario 125 eSP K2V	Cover Body	180000.0
64310K2FN80ZA	Cover Pijakan Kaki Coklat Honda Scoopy K2F	Cover Body	91000.0
64501K0WNA0ZB	Cover Body Samping Kanan Hitam Doff Honda ADV 160	Cover Body	185000.0
61100K1ZN20PFW	Spakbor Depan Putih Mutiara Honda PCX 160 K1Z	Cover Body	283000.0
64301K2FN00ZR	Cover Tameng Depan Grey Honda Scoopy K2F	Cover Body	233500.0
64431K1ZJ10ZT	Cover Right Floor Side Hitam Doff Honda PCX 160 K1Z	Cover Body	379000.0
64601K2SN00ZK	Cover Left Front Merah Doff Honda Vario 160 K2S	Cover Body	289500.0
64202K2FN00ZP	Cover Depan Kiri Biru Doff Honda Scoopy K2F	Cover Body	142500.0
64312K2FN00	Cover L P Step - Honda Scoopy K2F	Cover Body	10500.0
80151K1AN00ZA	Cover Center (Black) - Honda BeAT K1A	Cover Body	48000.0
53250K1AN20ZB	Cover Stang Grey Honda BeAT Street K1A	Cover Body	76500.0
64520K56N10	Cover Left Main Pipe Rear Honda New Sonic 150R Supra GTR 150	Cover Body	61000.0
83600K1AN00MGB	Cover Body Kiri (Cover,Left Body) Hitam Doff - BeAT K1A	Cover Body	115000.0
19631K0JN00	Cover Mesin Bawah Honda Genio	Cover Body	24000.0
64560K0WN00ZA	Cover R Body Lower Silver - ADV 150	Cover Body	91500.0
80111K45NA0	Fender Bawah Belakang Honda CBR 150R K45N	Cover Body	174000.0
84100K97T00	Behel (Rail RR Grab) - PCX 150 K97 & PCX Hybrid	Cover Body	378500.0
61300K18960ZA	Cover Lampu Depan Honda CB150 Verza	Cover Body	114000.0
8114AK46N00ZA	Cover Inner Lower Assy - Vario 110 FI	Cover Body	98000.0
64503K97T00ZN	Cover FR Center Hitam - PCX 150 K97	Cover Body	186000.0
84151K97T00ZN	Cover Behel Hitam Metalic Honda PCX 150 K97	Cover Body	303000.0
80160K61900	Cover, Seat Lock - BeAT POP eSP	Cover Body, Jok	5500.0
51610K84900ZB	Protector R FR Fork - CRF 150L	Cover Body	51000.0
61304K56N00ZC	Garnis Bawah Silver Honda Sonic 150R	Cover Body	88500.0
53206K93N00ZG	Cover B Speedometer Brown - Scoopy eSP K93	Cover Body	90500.0
64430K64N00MGB	Cowl L Middle (Hitam) - CBR 250RR	Cover Body	1249000.0
64330K64N00MGB	Cowl R Middle (Hitam) - CBR 250RR	Cover Body	1244000.0
61302K56N00ZF	Cowl R FR Side Hitam Doff - Sonic 150R	Cover Body	90500.0
83620K56N00RSW	Cover L Body Putih - Sonic 150R	Cover Body	135500.0
64620K56N10MGB	Cover L Side Hitam - Supra GTR 150	Cover Body	434000.0
83450K15920ZC	Cowl Rear Center Putih - New CB150R StreetFire K15G	Cover Body	61000.0
61302K15920ZD	Cover Depan Samping Kanan Hitam Honda CB150R StreetFire K15G	Cover Body	106000.0
61302K15920ZC	Cover Depan Samping Kanan Putih Honda CB150R StreetFire K15G	Cover Body	109000.0
83121K45N40ROW	Cowl Left Rear Rose White - New CBR 150R K45G & New CBR 150R K45N	Cover Body	252000.0
53208K59A10FMB	Cover Speedometer Hitam Honda Vario 125 eSP	Cover Body	112000.0
64601K59A10MJB	Cover Left Front Coklat (Brown) - Vario 125 eSP & Vario 150 eSP	Cover Body	241000.0
64601K2VN30MPC	Cover Depan Kiri Putih Doff Honda Vario 125 eSP K2V	Cover Body	180000.0
64501K2VN30FMB	Cover Depan Kanan Hitam Honda Vario 125 eSP K2V	Cover Body	160000.0
64301K2VN30ZN	Cover Tameng Depan Putih Doff Honda Vario 125 eSP K2V	Cover Body	248000.0
81141K2FN00ZG	Cover Inner Hitam Honda Scoopy K2F	Cover Body	452000.0
61303K56N00ZE	Garnis Kiri Hitam Honda Sonic 150R	Cover Body	75500.0
64301K2FN00ZJ	Cover Tameng Depan Hitam Metalic Honda Scoopy K2F	Cover Body	264000.0
64301K2SN00ZM	Cover Tameng Depan Hitam Honda Vario 160 K2S	Cover Body	287500.0
61100K2SN00PBL	Spakbor Depan A Hitam Metalic Honda Vario 160 K2S	Cover Body	249000.0
64431K1ZJ10ZQ	Cover Right Floor Side Hitam Metalic Honda PCX 160 K1Z	Cover Body	384000.0
64201K2FN00ZN	Cover Depan Kanan Merah Doff Honda Scoopy K2F	Cover Body	162500.0
80103K1ZJ10	Fender C RR Honda PCX 160 K1Z	Cover Body	48000.0
81134K2FN00ZK	Cover Inner Upper MT GN BL - Scoopy K2F	Cover Body	86500.0
81141KVY960	Cover Inner Lower Beat Karbu	Cover Body	70000.0
64460K1AN00ZA	Lid,Battery (Black) - BeAT K1A	Cover Body	25500.0
19621K0JN00	Cover Mesin Atas Honda Genio	Cover Body	26000.0
80102KVY960	Cover Belakang (Cover RR Cush) - BeAT Karburator	Cover Body	16000.0
8010BK46N00ZA	Fender RR Assy (Spakbor Belakang) - Vario 110 FI	Cover Body	141000.0
53207K93N00MSR	Cover Ring Speedometer Merah Honda Scoopy eSP K93	Cover Body	53000.0
64421K93N00ZQ	Cover Under Side Kanan Putih - Scoopy eSP K93	Cover Body	122000.0
53207K93N00PFW	Cover Ring Speedometer Putih Honda Scoopy eSP K93	Cover Body	53000.0
61100K97T00YD	Spakbor Depan Putih Honda PCX 150 K97	Cover Body	264000.0
6431AK61900	Pinjakan Kaki (Step Assy, Floor) - BeAT POP eSP	Cover Body	203500.0
8010CK15920	Fender B Rear Assy Honda New CB150R Streetfire K15G	Cover Body	165500.0
6434AKZR600ZB	Cover Under Assy - Vario 125 FI	Cover Body	85000.0
31501KC5000	Holder Battery - GL MAX	Cover Body	8000.0
53207K93N00RSW	Cover Ring Speedometer Putih Honda Scoopy eSP K93	Cover Body	59000.0
64431K93N00ZK	Cover Kiri Bawah (Cover Under Left Side) Hitam - Scoopy eSP K93	Cover Body	137500.0
83610K15920WRD	Cowl Right Rear Merah (Red) - New CB150R StreetFire K15G	Cover Body	143500.0
53205K81N00WRD	Cover Batok Depan Merah Honda New BeAT eSP k81	Cover Body	111000.0
53205K81N00FMB	Cover Batok Depan Hitam Honda New BeAT eSP K81	Cover Body	105000.0
64342K45N40	Guard Under Cowl - New CBR 150R K45G	Cover Body	8500.0
64311K45N40ROW	Cowl Right Middle A Repsol - New CBR 150R K45G & New CBR 150R K45N	Cover Body	640000.0
64601K59A10CSR	Cover Left Front Merah (CSR) - Vario 125 eSP & Vario 150 eSP	Cover Body	272500.0
61100K59A10MIB	Spakbor Depan Biru Honda Vario 150 eSP	Cover Body	199000.0
81131K59A10ZL	Cover Rack Biru - Vario 125 eSP & Vario 150 eSP	Cover Body	132000.0
64321K0WNA0ZB	Pijakan Kaki Kiri Honda ADV 160	Cover Body	109000.0
81141K2FN00ZF	Cover Inner Cream Honda Scoopy K2F	Cover Body	386000.0
64202K2FN00ZN	Cover Depan Kiri Merah Doff Honda Scoopy K2F	Cover Body	162500.0
64431K1ZJ10ZU	Cover Right Floor Side Putih Honda PCX 160 K1Z	Cover Body	421000.0
50732K1ZJ10ZB	Cover Right Step Arm Outer Honda PCX 160 K1Z	Cover Body	9500.0
64501K2SN00ZM	Cover Depan Kanan Hitam Honda Vario 160 K2S	Cover Body	254000.0
19200K1NV00	Pump Assy Water Honda PCX 160 K1Z	Cover Body, Pompa Air (Water Pump)	306500.0
64432K1ZJ10ZS	Cover L Floor Sid Merah Doff Kiri Honda PCX 160 K1Z	Cover Body	434500.0
64431K2FN00ZL	Cover Under L Sid Merah Doff (MT SO RED) - Scoopy K2F	Cover Body	152500.0
64201K2FN00ZR	Cover Depan Kanan Grey Honda Scoopy K2F	Cover Body	152500.0
64601K59A70YD	Body Depan Kiri Hitam Metalic (Cover L FR Black) - Honda Vario 125 eSP K60R	Cover Body	254000.0
64325K0WN00	Mat,R Floor - ADV 150	Cover Body	53000.0
64202K0JN00ZB	Cover Depan Kiri Merah Honda Genio	Cover Body	152500.0
83700K0WN00ZB	Cover L Body Side - ADV 150	Cover Body	41000.0
64301K59A70ZR	Cover Front Black Metalic - New Vario 125 eSP K60R	Cover Body	289500.0
64301K25900VBM	Cover Depan Biru (Cover Front Blue) - BeAT FI & BeAT CBS FI (K25)	Cover Body	303000.0
81131K59A70ZC	Cover Rack Hitam Doff - New Vario 150 K59J	Cover Body	218500.0
64311K0WNA0ZB	Pijakan Kaki Kanan Honda ADV 160	Cover Body	109000.0
64308KVB901	Cover Assy FR Lower - Vario Karbu	Cover Body	93500.0
51620K84900ZB	Protector L FR Fork - CRF 150L	Cover Body	51000.0
83500K93N00ZN	Cover R Body Black - Scoopy eSP K93	Cover Body	417500.0
61303K56N00ZB	Cowl L FR Side Merah - Sonic 150R	Cover Body	81500.0
83450K15920ZD	Cowl Rear Center Hitam - New CB150R StreetFire K15G	Cover Body	60000.0
83610K15920RSW	Cowl Right Rear Putih (White) - New CB150R StreetFire K15G	Cover Body	136500.0
83710K15920WRD	Cowl Left Rear Merah (Red) - New CB150R StreetFire K15G	Cover Body	143500.0
61303K15920ZC	Cowl Left Front Side Putih - New CB150R StreetFire K15G & New CB150R Streetfire K15M	Cover Body	109000.0
83600K81N00FMB	Cover Kiri Body Hitam - New BeAT eSP	Cover Body	253000.0
64441K45N40ZA	Cowl Left Under Putih - New CBR 150R K45G & New CBR 150R K45N	Cover Body	376000.0
53204KYZ900ZA	Cover Handle Depan Hitam Honda Supra X 125 Helm-In FI	Cover Body	96000.0
80101K64NP0	Fender Bawah Belakang Honda CBR 250RR K64N	Cover Body	262000.0
64432K0WNA0ZB	Cover Samping Bawah Kiri Honda ADV 160	Cover Body	145000.0
64405K0WNA0ZB	Lid Fuel Hitam Honda ADV 160	Cover Body	18000.0
50312K0WNA0	Cover Dudukan Lampu Depan Kiri Honda ADV 160	Cover Body	147500.0
64301K2SN00ZD	Cover Tameng Depan Hitam Doff Honda Vario 160 K2S	Cover Body	272000.0
64301K2SN00ZK	Cover Tameng Depan Merah Doff Honda Vario 160 K2S	Cover Body	312500.0
64502K1ZJ10ZJ	Cover Depan Kiri Grey Honda PCX 160 K1Z	Cover Body	617000.0
61100K1ZN20MGB	Spakbor Depan Hitam Doff Honda PCX 160 K1Z	Cover Body	252000.0
61100K1ZN20MIB	Spakbor Depan Biru Doff Honda PCX 160 K1Z	Cover Body	248000.0
64431K1ZJ10ZJ	Cover Right Floor Side Biru Doff Honda PCX 160 K1Z	Cover Body	368000.0
81133K2SN00MGB	Lid Inner Pocket Hitam Doff Honda Vario 160 K2S	Cover Body	88500.0
81137K1ZJ10ZN	Lid Smart Emergency Hitam Honda PCX 160 K1Z	Cover Body	96500.0
81146K2FN10ZE	Lid Smart Emergency Hitam Doff - Scoopy K2F	Cover Body	41000.0
64301K2FN00ZP	Cover Depan Biru (Cover Front Top MA Blue matte) - Honda Scoopy eSP K2F	Cover Body	233500.0
80107K0WN00	Cover,Rear Fender Lower - ADV 150	Cover Body	36000.0
19642K0JN00	Cap,L Cover - BeAT K1A & Genio	Cover Body, Tutup Mesin (Crank Case Cover)	16000.0
64100K0WN00ZA	Wind Screen Honda ADV 150	Cover Body	294500.0
50312K97T00	Stay L FR Cover E MT - PCX 150 K97 & PCX Hybrid	Cover Body	93500.0
80101K15600	Fender Belakang Bawah Honda New CB150R StreetFire K15M	Cover Body	102000.0
64431K93N00ZQ	Cover Under Side Kiri Putih - Scoopy eSP K93	Cover Body	122000.0
8011AK64N00	Fender Set A RR - All New CBR 250RR	Cover Body	76500.0
83650K64N00ZA	Cover Seat Lock (Red) - New CBR 250RR	Cover Body	187000.0
83610K64N00ZC	Set RR Center Cowl (Grey) - New CBR 250RR	Cover Body	135500.0
81141K93N00ZK	Cover Inner Seat White - Scoopy eSP K93	Cover Body	416500.0
64202K93N00ZH	Cover Depan Kiri Putih Honda Scoopy eSP K93	Cover Body	163500.0
83175K64N00MGB	Cover L Tank (Hitam) - CBR 250RR	Cover Body	441000.0
61303K56N00ZF	Garnis Kiri Hitam Doff Honda Sonic 150R	Cover Body	90500.0
83710K15920RSW	Cowl Left Rear White - New CB150R StreetFire K15G	Cover Body	137500.0
83500K81N00FMB	Cover Body Kanan Hitam - New BeAT eSP	Cover Body	253000.0
80110K81N00	Cover Battery - New BeAT eSP	Cover Body	17500.0
83111K45N40ZB	Cowl Right Rear Putih - New CBR 150R K45G	Cover Body	313000.0
64501K59A10WRD	Cover Right Front Merah (WRD) - Vario 125 eSP & Vario 150 eSP	Cover Body	251000.0
83750K59A10ZL	Cover Rear Center - Vario 125 eSP & Vario 150 eSP	Cover Body	70500.0
64501K59A10MIB	Cover Right Front Biru - Vario 125 eSP & Vario 150 eSP	Cover Body	227500.0
35112KVGV41	Cover Kunci Transmiter Honda Vario 150 eSP K59	Cover Body	4500.0
83620K2VN30ZA	Cover Body Samping Kiri Hitam Honda Vario 125 eSP K2V	Cover Body	47000.0
81137K97T00ZV	Lid Smart EMG SH Putih - PCX 150 K97	Cover Body	180000.0
84100K2SN00ZA	Behel Belakang Grey Honda Vario 160 K2S	Cover Body	323000.0
64221K45NL0	Cover R Front Side Honda CBR 150R K45R	Cover Body	38000.0
64501K1ZJ10ZP	Cover Depan Kanan Merah Doff Honda PCX 160 K1Z	Cover Body	521000.0
50731K1ZJ10ZB	Cover Right Step Arm Inner Honda PCX 160 K1Z	Cover Body	10000.0
64241K45NL0MGB	Cover Tengah Depan Cowl Front Lower MT GN BL - Honda CBR 150R K45R	Cover Body	198000.0
83510K84901ZB	Cover Set A, R. Side(WL) - CRF 150L	Cover Body	157500.0
64431K45NL0	Cover Body Kiri (Inner Left Mid Cowl) - Honda CBR 150R K45R	Cover Body	117000.0
81141KZL930ZA	Cover Inner Lower - Honda Spacy 81141KZL930ZA	Cover Body	83500.0
37610K15921	Mika Speedometer Honda New CB150R Streetfire	Cover Body	70500.0
64565K0WN00ZA	Cover L Body Lower Silver - ADV 150	Cover Body	91500.0
83110K45N60ZA	Body Belakang Kanan (Cowl Set R RR WL Type1) - CBR 150R K45G K45N	Cover Body	304000.0
50280K15900	Cover Body Depan Bawah Kanan Honda CB150R StreetFire	Cover Body	30000.0
64321K15600	Cowl R Under - New CB150 StreetFire K15M	Cover Body	44000.0
53205K81N00ZF	Cover Batok Depan Biru Honda BeAT sporty eSP K81	Cover Body	118000.0
64210K45N60ZA	Cover Tameng Depan Merah Honda New CBR 150R K45G	Cover Body	517000.0
83131K45N40MGB	Cowl, RR Center Hitam Doff- New CBR 150R K45G & New CBR 150R K45N	Cover Body	87500.0
6432CK15930	Cowl L Under Assy - New CB150R Streetfire K15G	Cover Body	110000.0
83750K93N00ZK	Cover RR Center Black - Scoopy eSP K93	Cover Body	104000.0
53207K93N00MJB	Cover Ring Speedometer Coklat Honda Scoopy eSP K93	Cover Body	59000.0
50325K64N00ZA	Grip L RR - CBR 250RR	Cover Body	239000.0
61100K93N00ZM	Spakbor Depan Putih Honda Scoopy eSP K93	Cover Body	276500.0
83510K56N10MGB	Cover Tail Hitam Doff - Supra GTR 150	Cover Body	430500.0
80150K56N10	Fender B RR - Supra GTR 150	Cover Body	87000.0
83600K81N00RSW	Cover Left Body Putih (White) - New BeAT eSP	Cover Body	278500.0
83121K45N40ZA	Cowl Left Rear Hitam - New CBR 150R K45G & New CBR 150R K45N	Cover Body	252000.0
61100K15920ZD	Spakbor Depan Hitam Honda New CB150R Streetfire K15G	Cover Body	241000.0
64501K59A10CSR	Cover R FR Merah (CSR) - Vario 125 eSP & Vario 150 eSP	Cover Body	272500.0
67101K1ZN40	Visor Meter Honda PCX 160 K1Z	Cover Body	228500.0
33708K03N50ZA	Cover Belakang (Cover Tail) Honda Revo 110 FI	Cover Body	20500.0
50606K56N10	Cover Kanan Pivot Honda Supra GTR K56F	Cover Body	49000.0
61300K84600ZA	Cover Lampu Depan Set Honda CRF150L	Cover Body	158500.0
64502K0WNA0ZH	Cover Body Samping Kiri Putih Honda ADV 160	Cover Body	235000.0
81265K1ZJ10	Karet Tahanan Lumpur Belakang Honda PCX 160 K1Z	Cover Body	27500.0
67110K3BN10ZA	Set Illust Wind Screen Type 1 Honda CB150X	Cover Body	289500.0
64421K2FN00ZQ	Cover Under Right Side Putih Honda Scoopy K2F	Cover Body	157500.0
61100K2FN00ZQ	Spakbor Depan Putih Honda Scoopy K2F	Cover Body	302000.0
64311K45NL0ZD	Cover Kanan Tengah (Cowl Right Middle Black) - Honda CBR 150R K45R	Cover Body	863000.0
64301K1AN00HSM	Cover Tameng Depan (Cover,Front) Silver- BeAT K1A	Cover Body	263000.0
64431K0JN00ZC	Cover Kiri Bawah (Cover Left Under Side) Hitam Doff - Honda Genio	Cover Body	147500.0
81131K0JN00ZC	Cover Inner Rack Hitam Doff - Genio	Cover Body	431500.0
64201K0JN00ZC	Cover Depan Kanan Hitam Doff Honda Genio	Cover Body	147500.0
61100K0WN00MGB	Spakbor Depan Hitam Doft Honda ADV 150	Cover Body	228500.0
83120K45NH0ZA	Cover Body Kiri (Set Illust L Rear Cowl Type 2 Doft) - New CBR 150R K45G K45N	Cover Body	142500.0
61300K84920ZC	Cover Lampu Depan Hitam Honda CRF 150L	Cover Body	81500.0
83710K15600MGB	Cowl L Rear Hitam - New CB150R StreetFire K15M	Cover Body	148000.0
8010BK46N20	Fender Rear Assy (Spakbor Belakang) - Vario 110 eSP	Cover Body	153000.0
80101K59A70	Fender B Rear - New Vario 125 eSP (K60R) & New Vario 150 eSP (K59J)	Cover Body	74500.0
61100K93N00ZP	Spakbor Depan Merah Doff Honda Scoopy eSP K93	Cover Body	269500.0
53210K56NJ0ZA	Cover Batok Depan Honda Supra GTR K56	Cover Body	51000.0
80151K61900ZA	Cover, Center - BeAT POP eSP	Cover Body	84000.0
61304K56N00ZD	Garnis Bawah Putih Honda Sonic 150R	Cover Body	86500.0
53205K93N00ZK	Cover A Speedometer Silver - Scoopy eSP K93	Cover Body	115000.0
64202K93N00ZJ	Cover Depan Kiri Silver Honda Scoopy eSP K93	Cover Body	163500.0
81132K93N00	Pocket Kiri Inner - Scoopy eSP K93	Cover Body	45000.0
80110K93N00	Cover Baterry - Scoopy eSP K93	Cover Body	18000.0
83500K81N00RSW	Cover Right Body Putih - New BeAT eSP	Cover Body	278500.0
64411K45N40ROW	Cowl Left Middle A Repsol - New CBR 150R K45G & New CBR 150R K45N	Cover Body	635500.0
61100K59A10MJB	Spakbor Depan Coklat Honda Vario 150 eSP	Cover Body	211500.0
53208K59A10MJB	Cover Speedometer Coklat Honda Vario 150 eSP	Cover Body	114000.0
81131K59A10ZK	Cover Rack Coklat (Brown) - Vario 125 eSP & Vario 150 eSP	Cover Body	145500.0
83750K59A10ZJ	Cover Rear Center Hitam Doff - Vario 125 eSP & Vario 150 eSP	Cover Body	67000.0
64380K64NP0	Cover Body Kiri Honda CBR 250RR K64N	Cover Body	110000.0
83680K64NP0	Cowl Rear Inner Kiri Honda CBR 250RR K64J	Cover Body	38000.0
64202K2FN00YG	Cover Depan Kiri Hijau Doff Honda Scoopy K2F	Cover Body	215000.0
81142K2FN80ZK	Cover Kantong Kiri Hitam Doff Honda Scoopy K2F	Cover Body	58000.0
50311K0WNA0	Cover Dudukan Lampu Depan Kanan Honda ADV 160	Cover Body	147500.0
83141K45NL0ZC	Cover Seat Lock Merah Honda CBR 150R K45R	Cover Body	157500.0
61306K15710	Cowl Depan Samping Kiri Honda CB150R StreetFire K15P	Cover Body	30500.0
83630K2SN00ZE	Cover Body Bawah Kiri Hitam Doff Honda Vario 160 K2S	Cover Body	112000.0
53207K2SN10FMB	Cover Speedometer Hitam Honda Vario 160 K2S ABS	Cover Body	81000.0
64302K56N10ZB	Cover Front Hitam Honda Supra GTR K56F	Cover Body	71500.0
64351K3BN00	Cover Right Front Side Hitam Honda CB150X	Cover Body	76500.0
64601K2SN00ZL	Cover Left Front Putih Honda Vario 160 K2S	Cover Body	254000.0
64502K1ZJ10ZN	Cover Depan Kiri Hitam Honda PCX 160 K1Z	Cover Body	467000.0
64503K1ZJ10ZQ	Cover FR Center Matte Blue Honda PCX 160 K1Z	Cover Body	183000.0
64503K1ZJ10ZR	Cover FR Center Hitam Doff Honda PCX 160 K1Z	Cover Body	183000.0
83600K2FN00MJB	Cover L Body Brown - Scoopy K2F	Cover Body	426500.0
64202K2FN00ZM	Cover Depan Kiri Merah Honda Scoopy K2F	Cover Body	152500.0
64211K45NL0ZA	Cover Tameng Depan Orange Honda CBR 150R K45R	Cover Body	838000.0
37230K25901	Cover Speedometer Honda BeAT FI CBS K25	Cover Body	26500.0
64455KYZ900	Louver L - Supra X 125 Helm In	Cover Body	54000.0
81144K93N00ZB	Knob Pocket LID R Seat - Honda Scoopy eSP (K93)	Cover Body	5000.0
81132K2FN00	Pocket L Inner - Honda Scoopy eSP K2F	Cover Body	51000.0
67111K45NL0	Kaca Depan (Screen Wind) - Honda CBR 150R K45R	Cover Body	122000.0
64501K0WN01ZE	Cover Body Samping Kanan Depan Rose White - Honda ADV 150	Cover Body	279500.0
53205KYZ900ZK	Cover Batok Depan Honda Supra X 125 Helm In	Cover Body	94500.0
64501K97T00YL	Cover Depan Samping Kanan Coklat Doff PCX 150 K97	Cover Body	439000.0
81141K93N00ZY	Cover Inner (MT GN BL) Hitam Doff - Scoopy eSP K93	Cover Body	520000.0
53205K1AN00ZG	Cover Batok Kepala Depan Hitam Metalik Honda BeAT K1A	Cover Body	112000.0
64410K0WN00ZB	Cover,Center - ADV 150	Cover Body	30500.0
61000K0WN10ZB	Spakbor Depan Merah Type 1 Honda ADV 150	Cover Body	228500.0
64300K45NH0ZC	Cowl Assy R Under Type 2 - CBR 150R K45G K45N	Cover Body	197000.0
39602K41N21	Cap Assy - PCX 150 K97, Scoopy eSP K93	Cover Body	53000.0
50260K15600FMB	Cover Body Depan Kanan Hitam Honda New CB150 StreetFire K15M	Cover Body	216000.0
64501K46N00MAG	Cover Kanan Depan Abu Abu - Vario 110 eSP	Cover Body	152500.0
50265K15600FMB	Cover Body Depan Kiri Hitam Honda New CB150R StreetFire K15M	Cover Body	223000.0
61100K46N00ZC	Spakbor Depan Hitam Honda Vario 110 FI	Cover Body	207500.0
64341K45N40MGB	Cowl R Under Hitam Doff - New CBR 150R K45G & New CBR 150R K45N	Cover Body	294500.0
50260K15600WRD	Cover Body Depan Kanan Merah Honda New CB150R StreetFire K15M	Cover Body	246500.0
50265K15600MGB	Cover Body Depan Kiri Hitam Doff Honda New CB150R StreetFire K15M	Cover Body	229500.0
53205K81N00ZG	Cover Batok Depan Magenta BeAT Sporty eSP K81	Cover Body	105000.0
64501K59A70ZS	Cover R FR Silver - New Vario 150 (K59J)	Cover Body	249000.0
64360K59A70ZA	Cover L Under Side Hitam - New Vario 150 (K59J)	Cover Body	449000.0
64601K59A70ZP	Cover Depan Kiri Putih Mutiara New Vario 150 K59J	Cover Body	276500.0
53206K93N00ZJ	Cover B Speedometer Putih - Scoopy eSP K93	Cover Body	90500.0
84152K97T00ZD	Lid Grb Ril Cover Hitam - PCX 150 K97	Cover Body	218000.0
64441K45N40MGB	Cowl L Under Hitam Doff - New CBR 150R K45G & New CBR 150R K45N	Cover Body	242000.0
64308K61900	Cover, Front Lower - BeAT POP eSP	Cover Body	80500.0
80110K50T00	Cover, Battery - BeAT POP eSP & BeAT Sporty eSP	Cover Body	10000.0
61300K84900ZA	Cover Lampu Depan Putih Honda CRF 150L K84	Cover Body	92500.0
6432BK15930	Cowl R Under Assy - New CB150R Streetfire K15G	Cover Body	110000.0
53205K25900CSR	Cover Batok Kepala Depan Merah Honda BeAT FI & BeAT FI CBS	Cover Body	130000.0
53204KZR600FMB	Visor Honda Vario 125 FI	Cover Body	61000.0
64421K93N00ZH	Cover Under R Side White - Scoopy eSP K93	Cover Body	138500.0
61100K93N00ZL	Spakbor Depan Merah Honda Scoopy eSP K93	Cover Body	291500.0
61100K93N00ZA	Spakbor Depan Cream Honda Scoopy eSP K93	Cover Body	268000.0
81141K93N00ZM	Cover Inner Seat Hijau - Scoopy eSP K93	Cover Body	406500.0
61100K64N00ZA	Spakbor Depan Merah Honda CBR 250RR	Cover Body	345500.0
83610K56N00RSW	Cover R Body Putih - Sonic 150R	Cover Body	135500.0
64320K56N00RSW	Cowl R Side Lower Putih - Sonic 150R	Cover Body	141500.0
53207K56N10ZE	Cover Batok Kanan Putih Honda Supra GTR 150	Cover Body	91500.0
81250K81N00	Box Bagasi (Box Luggage) - New BeAT eSP	Bagasi (Luggage), Cover Body	103000.0
64411K45N40ZB	Cowl Left Middle A Putih (White) - New CBR 150R K45G	Cover Body	758500.0
81131K59A10ZE	Cover Rack Merah Maroon - Vario 125 eSP & Vario 150 eSP	Cover Body	161500.0
81131K2FN80	Pocket Inner Kanan Honda Scoopy K2F	Cover Body	51000.0
64201K2FN00YG	Cover Kanan Depan Hijau Doff Honda Scoopy K2F	Cover Body	215000.0
64350K41N00	Cover Center Hitam Honda Supra X 125 FI	Cover Body	27500.0
64301K2SN00ZL	Cover Tameng Depan Putih Doff Honda Vario 160 K2S	Cover Body	287500.0
83500K2FN00MPC	Cover Body Kanan Putih Doff Honda Scoopy K2F	Cover Body	426500.0
80151K2SN00ZA	Cover Center Hitam Honda Vario 160 K2S	Cover Body	28000.0
64301K2FN00ZM	Cover Tameng Depan Merah Honda Scoopy K2F	Cover Body	233500.0
83610K1ZJ10MGB	Cover Body Kiri Hitam Doff Honda PCX 160 K1Z	Cover Body	376000.0
61100K2SN00MSR	Spakbor Depan A Merah Doff Honda Vario 160 K2S	Cover Body	279500.0
64434K1ZJ10ZC	Lid Plug Maintenance Honda PCX 160 K1Z	Cover Body	15500.0
64361K3BN00	Panel Inner Upper Honda CB150X	Cover Body	66000.0
81142K2SN00ZK	Cover Inner Upper Merah Doff Honda Vario 160 K2S	Cover Body	304000.0
81140K1ZJ10ZS	Outer Inner Cover Putih Honda PCX 160 K1Z	Cover Body	289500.0
81132K1ZN20	Pocket Inner Honda PCX 160 K1Z	Cover Body	32500.0
64421K2FN00ZM	Cover Under R Side Merah doff (MT SO RED) - Honda Scoopy K2F	Cover Body	152500.0
64301K2FN00ZN	Cover FR Top Merah Doff - Honda Scoopy K2F	Cover Body	284500.0
64201K2FN00ZM	Cover Depan Kanan Merah Honda Scoopy K2F	Cover Body	152500.0
61100K2FN00ZK	Spakbor Depan Coklat Doff Honda Scoopy K2F	Cover Body	261500.0
61100K2FN00ZJ	Spakbor Depan Hitam Metalik Honda Scoopy eSP K2F	Cover Body	246500.0
81141K46N20ZA	Cover Inner Lower - Honda New Vario 110 eSP	Cover Body	77500.0
81200K1AN00	Behel (RR Grab Rail) - Honda BeAT K1A	Cover Body	187500.0
50270K15600ZA	Cover Body Depan Atas Kanan Merah Doff Honda New CB150 StreetFire K15M	Cover Body	77500.0
44610K84900	Cover Front Hub - Honda CRF 150L	Cover Body	8500.0
64502K0WN01ZC	Cover Light Front Side WN RD Honda ADV 150	Cover Body	376000.0
64502K96V00YC	Cover Depan Samping Kiri Silver PCX 150 K97	Cover Body	380000.0
64201K93N00ZX	Cover Depan Kanan Merah Honda Scoopy eSP (K93)	Cover Body	170000.0
64330K64N00MSR	Cowl R Middle MT SO RED - All New CBR 250RR	Cover Body	1625500.0
83630K64N00ZJ	Cover Body (Cowl L Rear) Hitam - CBR 250RR K64	Cover Body	287500.0
64430K64N00MSR	Cover Sayap Kiri (Cowl L Middle) Mate Red - CBR 250RR K64	Cover Body	1625500.0
83710K15600MSR	Cowl Left Rear Matte Red - New CB150R StreetFire K15M	Cover Body	165500.0
50275K15600ZD	Cover Body Depan Atas Kiri Hitam Honda New CB150R StreetFire K15M	Cover Body	65000.0
83750K46N00ZC	Cover Tengah Belakang Atas Lampu (Hitam) - Vario 110 FI	Cover Body	58000.0
83750K59A70ZD	Cover RR Center (Hitam) - New Vario 125 eSP (K60R)	Cover Body	217000.0
64350K59A70ZA	Cover R Under Side Hitam - New Vario 150 K59J	Cover Body	449000.0
64601K59A70ZL	Cover Kiri Depan (Cover, L FR) Merah - New Vario 150 K59J	Cover Body	306500.0
64501K59A70ZL	Cover, R FR Merah - New Vario 150 K59J	Cover Body	306000.0
37620K45N41	Case Assy Under ( Dudukan Cover Speedometer ) - New CBR 150R K45G	Cover Body	169000.0
84152K97T00YA	Lid Grb Ril Cover Putih - PCX 150 K97	Cover Body	218000.0
64411K45N40MGB	Cowl A L Middle Hitam Doff - New CBR 150R K45G & New CBR 150R K45N	Cover Body	585000.0
64330K64N00NOR	Cowl R Middle (Orange) - CBR 250RR	Cover Body	1579000.0
64601K59A10RSW	Cover Depan Kiri Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	299500.0
83165K64N00MGB	Cover R Tank (Hitam Doft) - CBR 250RR	Cover Body	441000.0
61100K56N00WRD	Spakbor Depan A Merah Honda Sonic 150R	Cover Body	140500.0
61100K56N00SMM	Spakbor Depan A Magenta Honda Sonic 150R	Cover Body	211500.0
64610K56N10MGB	Cover R Side Hitam - Supra GTR 150	Cover Body	434000.0
61100K15920ZC	Spakbor Depan Putih Honda New CB150R Streetfire K15G	Cover Body	247000.0
64341K45N40ZC	Cowl Right Under Putih (Revolution White) - New CBR 150R K45G	Cover Body	391000.0
64441K45N40ZC	Cowl Left Under Putih (Revolution White) - New CBR 150R K45G	Cover Body	391000.0
64421K45N40ZB	Cowl B Left Middle Hitam (Nitro Black) - New CBR 150R K45G	Cover Body	680500.0
83750K59A10ZP	Cover Rear Center Biru - Vario 125 eSP & Vario 150 eSP	Cover Body	69500.0
64302KZR600FMB	Cover Tameng Depan Hitam Honda Vario Techno 125 FI CBS ISS	Cover Body	141500.0
83610K64NP0	Cowl Tengah Belakang Honda CBR 250RR K64J	Cover Body	32000.0
64224K64NP0	Panel Meter Honda CBR 250RR K64J	Cover Body	95000.0
81135K2FN80	Cover Hinge Honda Scoopy K2F	Cover Body	5000.0
83600K2VN30FMB	Cover Body Kiri Hitam Metalic Honda Vario 125 eSP K2V	Cover Body	220000.0
81141K2FN90ZD	Cover Inner Coklat Honda Scoopy K2F	Cover Body	485000.0
64601K2VN30FMB	Cover Depan Kiri Hitam Honda Vario 125 eSP K2V	Cover Body	160000.0
64301K2VN30ZK	Cover Tameng Depan Biru Doff Honda Vario 125 eSP K2V	Cover Body	233500.0
64301K2FN00YG	Cover Tameng Depan Hitam Honda Scoopy K2F	Cover Body	370000.0
64310K2FN80ZB	Cover Pijakan Kaki Hitam Honda Scoopy K2F	Cover Body	94000.0
61100K0WNA0MGB	Spakbor Depan Hitam Doff Honda ADV 160	Cover Body	228500.0
83400K15710ZA	Cover Set Belakang Tengah Honda CB150R StreetFire K15P	Cover Body	27500.0
80111K45NL0	Fender Belakang Bawah Honda CBR 150R K45R	Cover Body	203500.0
81265K0WNA0	Tahanan Lumpur Honda ADV 160	Cover Body	26000.0
64100K0WNA0ZA	Wind Screen Honda ADV 160	Cover Body	294500.0
83530K2SN00ZE	Cover Body Bawah Kanan Hitam Doff Honda Vario 160 K2S	Cover Body	112000.0
83620K2SN00ZA	Cover Body Kiri Hitam Honda Vario 160 K2S	Cover Body	39000.0
83600K2SN00PBL	Cover Body Kiri Hitam Honda Vario 160 K2S	Cover Body	429000.0
61305K15710	Cover Depan Kanan Honda CB150R StreetFire K15P	Cover Body	30500.0
11360K84900	Cover Com L Rear - Honda CRF 150L	Cover Body	76500.0
61100K59A70YE	Spakbor Depan Putih Doff Honda Vario 125 eSP K60R	Cover Body	183000.0
64431K2SN00ZK	Cover Right Floor Side Merah Doff Honda Vario 160 K2S	Cover Body	162500.0
64432K1ZJ10ZK	Cover Left Floor Side Grey Honda PCX 160 K1Z	Cover Body	496000.0
50741K1ZJ10ZB	Cover Left Step Arm Inner Honda PCX 160 K1Z	Cover Body	9500.0
61100K2FN00ZN	Spakbor Depan Merah Doff Scoopy K2F	Cover Body	261500.0
83111K45NL0ZB	Cover Kanan Merah (Cowl R Rear WN Red) - Honda CBR 150R K45R	Cover Body	335000.0
64501K97T00YM	Cover Body (Cover R FR Side MT CR SL) PCX 150 K97	Cover Body	380000.0
81200K0JN00ZA	Rear Grab Rail (MAG) - Genio	Cover Body	203500.0
61100K1AN00MCS	Spakbor Depan Silver Honda BeAT K1A	Cover Body	135000.0
64400K0WN10ZB	Set Illust,R FR Side Cover Type 1 - ADV 150	Cover Body	279500.0
64421K0JN00ZD	Cover Kanan (Cover Right Under Side) Putih Mutiara - Honda Genio	Cover Body	152500.0
64431K0JN00ZB	Cover Kiri (Cover Left Under Side) Merah - Honda Genio	Cover Body	152500.0
64431K0JN00ZG	Cover Kiri Bawah (Left Under Side) Hitam Metalic - Honda Genio	Cover Body	152500.0
61100K0WN00RSW	Spakbor Depan Putih Honda ADV 150	Cover Body	233500.0
64310K45NA0ZA	Set Illust R Midle Cowl Type 2 - New CBR 150R K45N	Cover Body	594000.0
80151K0JN00ZA	Cover Center Brown - Honda Genio	Cover Body	30500.0
83120K45N60ZA	Body Belakang Kiri (Cowl Set L RR WL Type1) - CBR 150R K45G K45N	Cover Body	304000.0
64302K59A70ZB	Cover Front Top (Mt Gn Bl) - New Vario 150 eSP K59J	Cover Body	233500.0
61100K59A70ZX	Spakbor Depan Biru Doff Honda Vario 150 eSP K59J	Cover Body	233500.0
64301K81N00MGB	Cover Tameng Depan (Cover Front) Hitam Doff - BeAT eSP K81	Cover Body	426500.0
83640K15900ZA	Cowl L Side - CB150 StreetFire K15	Cover Body	47000.0
83620K64N00ZJ	Cover Body Belakang (Cowl R Rear) Black - CBR 250RR K64	Cover Body	287500.0
61100K46N00ZB	Spakbor Depan Putih Honda Vario 110 FI	Cover Body	194000.0
64301K46N00FMB	Cover Tameng Depan (Cover Front Top Black) - Vario 110 FI	Cover Body	186000.0
83750K46N00ZG	Cover Rear Center Grey - Vario 110 eSP	Cover Body	71500.0
53208K59A70ZP	Cover Batok Atas Hitam Abu-Abu Honda New Vario 125 eSP	Cover Body	161500.0
83750K59A70ZB	Cover Rear Center - Vario 150 eSP New	Cover Body	226000.0
81131K59A70ZL	Cover Rack (Merah) - New Vario 150 K59J	Cover Body	258000.0
64210K64N00ASB	Cover Tameng Depan Hitam Metalik Honda CBR 250RR	Cover Body	998000.0
64305K97T00ZD	Garnish FR Hitam - PCX 150 K97	Cover Body	287000.0
64601K46N00FMB	Cover Kiri Depan Hitam - Vario 110 FI	Cover Body	117000.0
64506K97T00ZX	Mold Headlight Kiri Merah - PCX 150 K97	Cover Body	223000.0
84152K97T00ZX	Lid Grab Ril Cover Merah - PCX 150 K97	Cover Body	243000.0
83610K97T00ZN	Cover Body Kiri Hitam - PCX 150 K97	Cover Body	414000.0
64506K97T00YA	Mold L Headlight Putih - PCX 150 K97	Cover Body	196000.0
61100K97T00YA	Spakbor Depan Gold Honda PCX 150 K97	Cover Body	298000.0
8113AKVB930	Cover Assy Inner - Vario Karbu	Cover Body	104000.0
54302K16900FMB	Cover Kanan Depan Hitam Honda Scoopy FI K16	Cover Body	290500.0
61302K56N00ZE	Garnis Depan Kanan Hitam Honda Sonic 150R	Cover Body	75500.0
53205KZR600FMB	Cover Batok Depan Hitam Honda Vario 125 FI	Cover Body	114000.0
64431K93N00ZH	Cover Under L Side White - Scoopy eSP K93	Cover Body	138500.0
83650K93N00ZN	Cover RR Center L Black - Scoopy eSP K93	Cover Body	154500.0
64431K93N00ZG	Cover Under L Side Red - Scoopy eSP K93	Cover Body	138500.0
53207K93N00FMB	Cover Ring Speedometer Hitam Honda Scoopy eSP K93	Cover Body	58000.0
81141K93N00ZL	Cover Inner Seat Silver - Scoopy eSP K93	Cover Body	437000.0
64501K1ZJ10ZJ	Cover Depan Kanan Grey Honda PCX 160 K1Z	Cover Body	617000.0
83610K56N00FMB	Cover R Body Hitam - Sonic 150R	Cover Body	128000.0
64440K56N00FMB	Cover L Side Upper Hitam - Sonic 150R	Cover Body	196000.0
61303K56N00NOR	Cowl L FR Side Orange - Sonic 150R	Cover Body	75500.0
53207K56N10ZC	Cover Batok Kanan Biru Honda Supra GTR 150	Cover Body	81500.0
53205K81N00RSW	Cover Batok Depan Putih Mutiara Honda New BeAT Esp k81	Cover Body	105000.0
64301K59A10ZK	Cover Front Merah - Vario 125 eSP & Vario 150 eSP	Cover Body	305000.0
53206KVY960	Cover Batok Belakang Honda BeAT Karburator KVY	Cover Body	25500.0
81141K2FN90ZE	Cover Inner Hitam Doff Honda Scoopy K2F	Cover Body	360000.0
11360K15900	Cover Tutup Rantai Honda CB150R StreetFire K15	Cover Body, Rantai Roda (Drive Chain Kit)	48000.0
83610K84610ZA	Cover Samping Kiri Hitam Type 1 Honda CRF150L K84	Cover Body	96500.0
81132K2FN80	Pocket Inner Kiri Honda Scoopy K2F	Cover Body	51000.0
64501K2VN30MIB	Cover Depan Kanan Biru Doff Honda Vario 125 eSP K2V	Cover Body	180000.0
64220K03N30	Breket Front Top Cover Honda Revo 110 FI	Cover Body	15500.0
64421K2FN00ZK	Cover Samping Bawah Kanan Coklat MA JB MT Honda Scoopy K2F	Cover Body	152500.0
83560K84600ZA	Cover body Samping Kanan Putih Honda CRF150L K84	Cover Body	84500.0
11341K2SN00	Cover CVT Honda Vario 160 K2S	Cover Body	535500.0
83610K0WNA0ASB	Cover Body Kiri Hitam Metalic Honda ADV 160	Cover Body	233500.0
64501K0WNA0ZF	Cover Body Samping Kanan Putih Honda ADV 160	Cover Body	235000.0
83141K45NL0ZE	Cover Seat Lock Hitam Glossy Honda CBR 150R K45R	Cover Body	183000.0
64211K45NL0ZB	Cover Tameng Depan Merah Honda CBR 150R K45R	Cover Body	838000.0
64460K46N20ZA	Lid Battery Honda Vario 110 eSP	Cover Body	33000.0
53205K2FN00MGB	Cover Speedometer Hitam Doff Honda Scoopy K2F	Cover Body	96500.0
80107K2SN00	Fender C Rear Honda Vario 160 K2S	Cover Body	51000.0
83520K2SN00ZA	Cover Body Kanan Hitam Honda Vario 160 K2S	Cover Body	39000.0
53205K2SN10FMB	Cover Batok Kepala Depan Honda Vario 160 K2S ABS	Cover Body	25500.0
83610K1ZJ10PFW	Cover Body Belakang Kiri Honda PCX 160 K1Z	Cover Body	391000.0
64501K1ZJ10ZS	Cover Depan Kanan Putih Mutiara Honda PCX 160 K1Z	Cover Body	485000.0
53206K2FN00ZL	Cover Bawah Speedometer Hitam Metalic Honda Scoopy K2F	Cover Body	107000.0
61100K1ZN20MDG	Spakbor Depan Grey Honda PCX 160 K1Z	Cover Body	328000.0
64432K2SN00ZD	Cover Left Floor Side Hitam Doff Honda Vario 160 K2S	Cover Body	152500.0
64432K2SN00ZM	Cover Left Floor Side Honda Vario 160 K2S	Cover Body	152500.0
64431K1ZJ10ZK	Cover Right Floor Side Grey Honda PCX 160 K1Z	Cover Body	496000.0
83500K2SN00MGB	Cover Body Kanan Hitam Doff Honda Vario 160 K2S	Cover Body	478000.0
81134K2FN00ZM	Cover Inner Upper Matte Silver - Honda Scoopy eSP K2F	Cover Body	86500.0
81250K2FN00	Box Bagasi (Box Luggage) - Scoopy K2F	Cover Body	169000.0
53205K2FN00FMB	Cover Speedometer Hitam Metalic Honda Scoopy K2F	Cover Body	106000.0
64301K2FN00ZL	Cover Depan (Cover Front Top VI BE) - Honda Scoopy eSP K2F	Cover Body	274500.0
83750K2FN00ZQ	Cover BelakangPutih Doff (Cover Rear Center MS PR CR) - Honda Scoopy eSP K2F	Cover Body	162500.0
64301K1AN00ARB	Cover Tameng Depan (AR Blue Me) - Honda BeAT K1A	Cover Body	314000.0
86650K93NB0ZC	Stripe R Front Cover Type 1 - Honda Scoopy eSP (K93)	Cover Body	28500.0
64502K96V00YH	Cover Depan Samping Kiri Hitam Doff - Honda PCX 150 K97	Cover Body	392000.0
64410K45NE0ZA	Set Illust L Mid Cowl Type 1 Merah - New CBR 150R K45N	Cover Body	254000.0
81134K0JN00ZC	Cover Inner Upper Hitam Doff - Genio	Cover Body	59000.0
64201K0JN00ZB	Cover Depan Kanan Merah Honda Genio	Cover Body	152500.0
83600K0WN00ZB	Cover R Body Side - ADV 150	Cover Body	41000.0
83110K45NH0ZA	Cover Body Kanan (Set Illust R Rear Cowl Type 2 Doft) - New CBR 150R K45G K45N	Cover Body	142500.0
83750K59A70ZN	Cover RR Center Ma Bl Mt - New Vario 150 eSP K59J	Cover Body	127000.0
64330K64N00AGM	Cowl R Middle (Grey) - CBR 250RR	Cover Body	1579000.0
30405KZR600	Guard Engine Control Unit - Vario Techno 125 Helm-In FI CBS, Vario Techno 125 Helm-In FI, Vario 125 eSP K60, Vario 150 eSP K59, New Vario 125 eSP K60R, New Vario 150 eSP K59J	Cover Body	5500.0
64322K15600	Cowl L Under - CB150 StreetFire K15M	Cover Body	47000.0
61303K15920ZB	Cowl L Front Side Hitam - New CB150R StreetFire K15G & New CB150R Streetfire K15M	Cover Body	96500.0
53208K46N00ZB	Cover Speedometer Merah Honda Vario 110 eSP	Cover Body	95500.0
64501K46N00FMB	Cover Kanan Depan (Cover Right Front) Hitam - Vario 110 FI	Cover Body	117000.0
50265K15600WRD	Cover Body Depan Kiri Merah Honda New CB150R StreetFire K15M	Cover Body	252500.0
50270K15600ZC	Cover Body Depan Atas Kanan Hitam Doff Honda New CB150R StreetFire K15M	Cover Body	67000.0
64301K25900NOR	Cover Depan (Cover Front NI ) Orange - BeAT FI & BeAT FI CBS (K25)	Cover Body	286500.0
53208K59A70ZC	Cover Batok Atas Hitam Doff Honda New Vario 150 K59J	Cover Body	150500.0
83610K97T00ZX	Cover Body Kiri Merah - PCX 150 K97	Cover Body	457000.0
83121K45N40MGB	Cowl, L Rear Hitam Doff - New CBR 150R K45G & New CBR 150R K45N	Cover Body	226500.0
83600K93N00ZQ	Cover Body Kiri - Scoopy eSP (K93)	Cover Body	391000.0
61100K97T00YB	Spakbor Depan Merah Doff Honda PCX 150 K97	Cover Body	267000.0
83550K61900ZA	Cover Kanan Belakang (Cover, Right Rear Side) - BeAT POP eSP	Cover Body	23000.0
80102K84900	Fender C RR - CRF 150L	Cover Body	55000.0
61100K56N00RSW	Spakbor Depan A Putih Honda Sonic 150R	Cover Body	135500.0
6131AK18900	Dudukan Lampu Depan Honda Verza 150	Cover Body	64500.0
83155K64N00ZA	Cover Center Tank Hitam Doff - CBR 250RR	Cover Body	255000.0
64501K59A10RSW	Cover Depan Kanan Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	299500.0
64301K59A10ZP	Cover Depan Putih (White) - Vario 125 & 150 eSP	Cover Body	384000.0
64421K45N40ZC	Cowl B L Middle Merah - CBR 150R K45G & New CBR 150R K45N	Cover Body	734000.0
81250K93N00	Box Bagasi (Box Luggage) - Scoopy eSP K93	Bagasi (Luggage), Cover Body	139500.0
50315K64N00ZA	Grip R RR - CBR 250RR	Cover Body	239000.0
83650K64N00ZC	Cover Seat Lock White - CBR 250RR	Cover Body	223500.0
64330K64N00WRD	Cowl R Middle (Merah) - CBR 250RR	Cover Body	1623500.0
64610K56N10MIB	Cover R Side Biru - Supra GTR 150	Cover Body	417000.0
61100K56N10ZE	Spakbor Depan A Putih Honda Supra GTR 150	Cover Body	239000.0
53208K56N10ZC	Cover Batok Kiri Biru Honda Supra GTR 150	Cover Body	81500.0
83710K15920FMB	Cowl Left Rear Hitam - New CB150R StreetFire K15G	Cover Body	133000.0
64511K45N40ZB	Cover Fuel Tank Merah (Red) - New CBR 150R K45G & New CBR 150R K45N	Cover Body	213500.0
64511K45N40ZA	Cover Fuel Tank Repsol - New CBR 150R K45G & New CBR 150R K45N	Cover Body	230500.0
83600K59A10PFW	Cover Left Body Putih (White) - Vario 125 eSP & Vario 150 eSP	Cover Body	302000.0
64301KZR600CSR	Cover Tameng Depan Merah Maron Honda Vario Techno 125 Helm-In FI	Cover Body	382000.0
83500K2VN30FMB	Cover Body Kanan Hitam Metalic Honda Vario 125 eSP K2V	Cover Body	220000.0
64601K2VN30VRD	Cover Depan Kiri Merah Honda Vario 125 eSP K2V	Cover Body	180000.0
61100K2FN00YK	Spakbor Depan Hijau Doff Honda Scoopy K2F	Cover Body	242000.0
53208K2VN30VRD	Cover Batok Atas Merah Honda Vario 125 eSP K2V	Cover Body	118000.0
81141K2FN80ZD	Cover Inner Cream Honda Scoopy K2F	Cover Body	495000.0
80151K2VN30ZA	Cover Center Hitam Honda Vario 125 eSP K2V	Cover Body	49000.0
64502K0WNA0ZB	Cover Depan Samping Kiri Hitam Doff Honda ADV 160	Cover Body	185000.0
80110K16900	Cover Battery Honda Scoopy FI K16G	Cover Body	10500.0
64320K3BN00ZC	Cover Body Set Tengah Kanan Merah Type 1 Honda CB150X	Cover Body	355500.0
83610K0WNA0MGB	Cover Body Kiri Hitam Doff Honda ADV 160	Cover Body	173000.0
83111K45NL0ZE	Cowl Samping Kanan Hitam Honda CBR 150R K45R	Cover Body	305000.0
80103K0WNA0	Spakbor Tengah Belakang Honda ADV 160	Cover Body	59000.0
64560K0WNA0ZB	Garnish Floor Kanan Silver Honda ADV 160	Cover Body	94000.0
64326K0WNA0	Mat Left Floor Hitam Honda ADV 160	Cover Body	65000.0
64320K15600MGB	Cowl Under Center Mate Black - CB150R StreetFire K15M	Cover Body	122000.0
80100K15920ZA	Spakbor Belakang Honda CB150R StreetFire K15P	Cover Body	61000.0
83500K2SN00PBL	Cover Body Kanan Hitam Honda Vario 160 K2S	Cover Body	429000.0
64305K64NA0ZB	Cover Body Kanan Hitam Doff Honda CBR 250RR K64	Cover Body	1244000.0
86201K3BN00ZA	Mark Right Wing 60mm Type 1 Honda CB150X	Cover Body	8500.0
61100K2SN00MPC	Spakbor Depan A Putih Doff Honda Vario 160 K2S	Cover Body	249000.0
64431K2FN00ZN	Cover Under Left Side Hitam Honda Scoopy K2F	Cover Body	152500.0
81140K1ZJ10ZR	Outer Inner Cover Hitam Doff Honda PCX 160 K1Z	Cover Body	279500.0
80110K1ZJ10ZA	Set Illust Rear Center Cover Type 1 Hitam Doff Honda PCX 160 K1Z	Cover Body	27500.0
81141K2FN10ZF	Cover Inner Silver Honda Scoopy K2F	Cover Body	325000.0
64420K1ZJ10ZS	Cover B Center Putih Honda PCX 160 K1Z	Cover Body	127000.0
64431K2FN00ZE	Cover Under L Sid Hitam Scoopy K2F	Cover Body	137500.0
64431K2FN00ZJ	Cover Under L Sid Brown (MA JB MT) - Scoopy K2F	Cover Body	152500.0
83111K45N40ZD	Cover Kanan Belakang Merah (Cowl R Rear WN RD) - Honda New CBR 150R K45G	Cover Body	275500.0
64502K0WN01ZB	Cover Depan Kiri Merah (AB RD MT) - Honda ADV 150	Cover Body	325000.0
33722KWN901	Cover Comp License - Honda CB500F, CB500X, CB650F, CBR650F, CBR500R	Cover Body	46000.0
64501K0WN01ZC	Cover Body R FR Side WN RD Honda ADV150	Cover Body	376000.0
83520K56NJ0	Cover Tail Light Honda Supra GTR 150	Cover Body	48000.0
83121K45N40ZE	Cover Body Belakang Cowl L Rear MT GN BL Honda CBR 150R K45N	Cover Body	241000.0
53204K41N00ZA	Visor Honda New Supra X 125 FI	Cover Body	72500.0
83620KZL930ZA	Cover L Floor Side - Honda Spacy 83620KZL930ZA	Cover Body	39500.0
64301K1AN00RSW	Cover Tameng Depan Putih Mutiara - BeAT K1A	Cover Body	228500.0
83500K1AN00MGB	Cover Body Kanan (Cover,Right Body) Hitam Doff - BeAT K1A	Cover Body	115000.0
64400K0WN10ZA	Set Illust,R FR Side Cover Type 2 - ADV 150	Cover Body	376000.0
64326K0WN00	Mat,L Floor - ADV 150	Cover Body	53000.0
64431K0JN00ZA	Cover Kiri (Cover Left Under Side) Coklat Metalic - Honda Genio	Cover Body	152500.0
64301K0JN00FMB	Cover Tameng Depan (Cover Front Top) Hitam - Genio	Cover Body	514000.0
64336K0WN00ZB	Cover FR Upper AB RD MT - Honda ADV 150	Cover Body	178000.0
64301K0JN00MGB	Cover Tameng Depan (Cover Front Top) Hitam Doff - Honda Genio	Cover Body	452000.0
83510K64N00ZA	Set Illust R Side - CBR 250RR K64	Cover Body	56000.0
83120K45N50ZA	Body Belakang Kiri (Cowl Set L RR WL) - CBR 150R K45N	Cover Body	298500.0
64410K45NA0ZA	Body Kiri Doft (Set Illus L Middle Type 2) - CBR 150R K45N	Cover Body	254000.0
83510K84920ZA	Cover Body Kanan (Set Illust R Side A Cover Type2) - CRF 150L	Cover Body	164500.0
50270K15600ZB	Cover Body Depan Atas Kanan Merah Honda New CB150R StreetFire K15M	Cover Body	94500.0
53208K46N00ZA	Cover Speedometer Silver Honda Vario 110 FI	Cover Body	95500.0
64601K59A70ZM	Cover L FR WN Red - New Vario 125 eSP (K60R)	Cover Body	317000.0
83600K59A70ZC	Cover Body Kiri Hitam - New Vario 150 eSP K59J	Cover Body	459000.0
83750K59A70ZA	Cover Rear Center (Merah) - New Vario 150 K59J	Cover Body	261000.0
64501K59A70ZP	Cover Right Front Putih - New Vario 150 K59J	Cover Body	276500.0
64301K59A70ZP	Cover, Front Putih - New Vario 150 K59J	Cover Body	271000.0
64210K64N00NOR	Cover Tameng Depan Orange Honda CBR 250RR	Cover Body	1044000.0
83111K45N40ZA	Cowl Kanan Belakang Hitam - New CBR 150R K45G & New CBR 150R K45N	Cover Body	252000.0
81138K97T00ZN	Outer R Inner Hitam - PCX 150 K97	Cover Body	207000.0
64305K97T00ZW	Garnish FR Gold - PCX 150 K97	Cover Body	376000.0
83111K45N40MGB	Cowl, R Rear Hitam Doff- New CBR 150R K45G & New CBR 150R K45N	Cover Body	226500.0
61301K15900	Cowl FR Center - CB150R StreetFire (Old)	Cover Body	23500.0
64500K41N00ZA	Cover FR Top Hitam - Supra X 125 FI	Cover Body	186000.0
6431AKVB930	Step Set Floor - Vario Karbu	Cover Body	63500.0
64460K46N00	Cover Tutup Aki Honda Vario 110 FI	Cover Body	15500.0
81142K93N00ZG	Lid Kiri Pocket Brown Honda Scoopy eSP K93	Cover Body	132500.0
83500K59A10ZV	Cover Body Kanan Biru - Vario 125 eSP & Vario 150 eSP	Cover Body	382000.0
64430K64N00AGM	Cowl L Middle (Grey) - CBR 250RR	Cover Body	1586000.0
64340K56N00WRD	Cover R Side Upper Merah - Sonic 150R	Cover Body	211500.0
53207K56N10ZD	Cover Batok Kanan Hitam Doff Honda Supra GTR 150	Cover Body	81500.0
64301K56N10ZD	Cover FR Top Hitam (Black) - Supra GTR 150	Cover Body	272500.0
64301K56N10ZC	Cover FR Top Biru - Supra GTR 150	Cover Body	264000.0
61303K15920ZD	Cowl L FR Side Hitam (Black) - New CB150R StreetFire K15G & New CB150R Streetfire K15M	Cover Body	106000.0
53205K81N00VBM	Cover Batok Depan Biru Honda New BeAT eSP k81	Cover Body	118000.0
83750K59A10ZH	Cover RR Center Merah - Vario 125 eSP & Vario 150 eSP	Cover Body	80500.0
83600K59A10CSR	Cover L Body Merah (CSR) - Vario 125 eSP & Vario 150 eSP	Cover Body	369000.0
83500K59A10CSR	Cover Right Body Merah (CSR) - Vario 125 eSP & Vario 150 eSP	Cover Body	369000.0
64301K59A10ZE	Cover Front Merah Maroon - Vario 125 eSP & Vario 150 eSP	Cover Body	340500.0
64301K59A10ZJ	Cover Front Coklat (Brown) - Vario 125 eSP & Vario 150 eSP	Cover Body	293500.0
53206KYZ900ZH	Cover Batok Belakang Honda Supra X 125 Helm-In FI	Cover Body	185000.0
80108KYT900	Cover Dudukan Riting Belakang Kiri Honda Scoopy Karburator KYT	Cover Body	3000.0
80107KYT900	Cover Dudukan Riting Belakang Kanan Honda Scoopy Karburator KYT	Cover Body	3000.0
81131K16900ZV	Cover Inner Rack Hitam Honda Scoopy FI K16G	Cover Body	178000.0
64350K64NP0	Panel Inner Kanan Honda CBR 250RR K64N	Cover Body	60000.0
64430K64NP0WRD	Cover Body Samping Kiri Merah Honda CBR 250RR K64N	Cover Body	1100000.0
64501K2VN30MGB	Cover Depan Kanan Hitam Doff Honda Vario 125 eSP K2V	Cover Body	160000.0
53208K2VN30MPC	Cover Batok Atas Putih Doff Honda Vario 125 eSP K2V	Cover Body	118000.0
64201K2FN00YF	Cover Kanan Depan Silver Honda Scoopy K2F	Cover Body	195000.0
83500K2FN00YE	Cover Body Kanan Hijau Doff Honda Scoopy K2F	Cover Body	380000.0
64501K59A70YB	Cover Depan Kanan Merah Honda Vario 150 eSP K59J	Cover Body	254000.0
50285KYE940	Cover Body Depan Bawah Kiri Honda Mega Pro FI	Cover Body	44500.0
81130K2FN00ZK	Cover Kantong Hitam Honda Scoopy K2F	Cover Body	102000.0
83520K2VN30ZA	Cover Body Samping Kanan Hitam Honda Vario 125 eSP K2V	Cover Body	47000.0
83610K84620ZA	Cover Set Samping Kiri Type 2 Honda CRF150L K84	Cover Body	101000.0
81130K2VN30ZA	Cover Kantong Bawah Hitam Honda Vario 125 eSP K2V	Cover Body	29000.0
81131K2FN00	Pocket Inner Kanan Honda Scoopy K2F	Cover Body	51000.0
53205K2FN00MJB	Cover Speedometer Brown Honda Scoopy K2F	Cover Body	152500.0
81139K0WN00ZK	Garnish Lower Inner Cover Hitam Doff Honda ADV 160	Cover Body	78000.0
80102K0WNA0	Cover Rear Center Lower Honda ADV 160	Cover Body	45000.0
64325K0WNA0	Mat Right Floor Hitam Honda ADV 160	Cover Body	65000.0
81140K0WN00ZK	Garnish Upper Inner Cover Hitam Doff Honda ADV 160	Cover Body	78000.0
64502K0WNA0ZJ	Cover Body Samping Kiri Depan Putih Doff Honda ADV 160	Cover Body	230000.0
64502K0WNA0ZF	Cover Body Samping Kiri Depan Merah Honda ADV 160	Cover Body	235000.0
19641KZR600	Duct Left Cover Honda Vario Techno 125 FI CBS ISS	Cover Body, Suku Cadang Resmi Motor Honda	15500.0
81200K46N00ZA	Behel Belakang Grey Honda Vario 110 eSP	Cover Body	150500.0
53205K2SN00FMB	Cover Batok kepala Depan Honda Vario 160 K2S CBS	Cover Body	39000.0
61000K64610ZA	Spakbor Depan Hitam Doff Honda CBR 250RR K64	Cover Body	379000.0
50742K1ZJ10ZB	Cover Left Step Arm Outer Honda PCX 160 K1Z	Cover Body	10000.0
83500K2FN00MSR	Cover Body Kanan Merah Doff Honda Scoopy K2F	Cover Body	411500.0
64503K97T00YW	Cover Front Center Hitam Doff Honda PCX 150 K97	Cover Body	177000.0
64503K1ZJ10ZP	Cover Front Center Merah Doff Honda PCX 160 K1Z	Cover Body	188000.0
81142K2SN00ZL	Cover Inner Upper Putih Doff Honda Vario 160 K2S	Cover Body	294000.0
50400K56N00ZA	Grip RR Mat Axis Gray - Sonic 150R	Cover Body	190000.0
81134K2FN00ZL	Cover Inner Upper Hitam (BLK) - Scoopy K2F	Cover Body	284500.0
80106K2FN00	Cover Upper RR Fender - Honda Scoopy K2F	Cover Body	12500.0
64460K2FN00ZC	Lid Battery Hitam - Honda Scoopy K2F	Cover Body	30500.0
53206K1AN10ZA	Cover Batok Belakang Honda BeAT K1A ISS	Cover Body	36000.0
83520KZR600ZB	Cover Right Body Side - Vario 125 FI	Cover Body	45500.0
64241K45NL0FMB	Cover Depan Cowl Front Lower Black - Honda CBR 150R K45R	Cover Body	198000.0
64441K45NL0ZE	Cowl Comp Left Under Black - Honda CBR 150R K45R	Cover Body	416500.0
11341K1AN00	Cover Body Kiri (Cover L Side) - Honda BeAT K1A, Scoopy eSP K2F	Cover Body	389500.0
83121K45N40ZD	Cowl L Rear WN RD - Honda New CBR 150R K45G	Cover Body	275500.0
64432K97T00YY	Cover Left Floor Side (MT GN BL) - Honda PCX 150 K97	Cover Body	345500.0
53250K03N30ZA	Cover Batok Belakang Honda Revo FI	Cover Body	56000.0
81265K0WN00	Tahanan Lumpur (Guard,Splash Rear) - ADV 150	Cover Body	15500.0
64305K97T00YK	Garnish,FR Silver - PCX 150 K97	Cover Body	291500.0
81141K0JN00ZB	Cover,Inner Hitam - Genio	Cover Body	82000.0
53205K1AN00ZH	Cover Batok Kepal Depan Silver Honda BeAT K1A	Cover Body	104000.0
64301K1AN00EMM	Cover Tameng Depan (Cover,Front) Magenta - BeAT K1A	Cover Body	340500.0
64500K0WN10ZA	Set Illust,L FR Side Cover Type 2 - ADV 150	Cover Body	381000.0
77244K0JN00	Cover,Seat Catch - BeAT K1A & Genio	Cover Body, Jok	5500.0
64310K45NH0ZB	Set Illust R Mid Cowl A Type 1 - New CBR 150R K45N	Cover Body	508000.0
53204K46N20MAG	Visor Abu Abu Honda New Vario 110 eSP	Cover Body	54000.0
81134K0JN00ZE	Cover Inner Upper Hitam Metalik Mutiara - Genio	Cover Body	61000.0
64336K0WN00ZD	Cover FR Upper MT GN BL - Honda ADV 150	Cover Body	156500.0
64301K0JN00VRD	Cover Tameng Depan (Cover Front Top) Merah - Honda Genio	Cover Body	470500.0
83500K59A70YB	Body Belakang Kanan (Cover R Body Ma Bl Mt) - New Vario 150 eSP K59J	Cover Body	355500.0
83750K59A70ZM	Cover RR Center (Ma Jb Mt/Brown) - Vario 150 eSP K59J	Cover Body	127000.0
81256KVY700	Cover Assy Battery - BeAT Karburator	Cover Body	10500.0
64211K45NA0ZC	Cover Tameng Depan Grey Honda New CBR 150R K45N	Cover Body	756500.0
64211K45NA0ZB	Cover Tameng Depan Merah Honda New CBR150R K45N	Cover Body	741500.0
83630K64N00ZH	Cover Body Kiri (Cowl L Rear) Mate Red - CBR 250RR K64	Cover Body	330000.0
83620K64N00ZH	Cover Body Kanan (Cowl R Rear) Mate Red - CBR 250RR K64	Cover Body	330000.0
64310K64N00ZD	Cowl Comp R Under (AN GY MT) - CBR 250RR K64	Cover Body	584000.0
83610K64N00FMB	Cowl Tengah Belakang (Cowl RR Center Black) - CBR 250RR K64	Cover Body	193000.0
64430K64N00FMB	Cowl Tengah Kiri (Cowl L Middle) Black - CBR 250RR K64	Cover Body	1348500.0
64320K64N00ZB	Cowl L Under Black Doft - CBR 250RR K64	Cover Body	584000.0
50275K15600ZB	Cover Body Depan Atas Kiri Merah Honda New CB150R StreetFire K15M	Cover Body	94500.0
83751K46N00ZE	Cover Rear Center Lower Biru - Vario 110 FI	Cover Body	86500.0
83750K46N00ZE	Cover Blakang (Cover Rear Center) Biru - Vario 110 FI	Cover Body	64000.0
83710K15600FMB	Cowl L Rear Black - New CB150R StreetFire K15M	Cover Body	126000.0
83610K15600FMB	Cowl R Rear Black - New CB150R StreetFire K15M	Cover Body	126000.0
50270K15600ZD	Cover Body Depan Atas Kanan Hitam Honda New CB150R StreetFire K15M	Cover Body	65000.0
83600K46N00RSW	Cover Body Kiri Putih - Vario 110 eSP	Cover Body	290500.0
50260K15600MGB	Cover Body Depan Kanan Hitam Honda New CB150 StreetFire K15M	Cover Body	223000.0
54303K16900FMB	Cover Kiri Depan Hitam Honda Scoopy FI K16G	Cover Body	290500.0
17235K46N20	Tutup Saringan Udara (Cover Sub Assy Air Cleaner) - BeAT eSP, Scoopy eSP, Vario 110 eSP	Cover Body, Saringan Udara (Filter)	46000.0
64601K59A70ZS	Cover L FR Silver - New Vario 150 (K59J)	Cover Body	249000.0
64301K59A70ZL	Cover Front Merah - New Vario 150 K59J	Cover Body	300500.0
64330K64N00ASB	Cowl Right Middle Hitam Metalik - CBR 250RR	Cover Body	1576000.0
81141K1ZJ10ZR	Lid Inner Pocket Hitam Doff PCX 160 K1Z	Cover Body	135500.0
17546K84901ZB	Cover Body Set Kanan Merah (WL) Honda CRF 150L	Cover Body	213500.0
83610K15920FMB	Cowl Kanan Belakang Hitam - New CB150R StreetFire K15G	Cover Body	133000.0
64520K97T00ZA	Garnish L Silver - PCX 150 K97	Cover Body	177000.0
81200K61900	Behel (Rear Grab Rail) - BeAT POP eSP	Cover Body	193500.0
64505K97T00YA	Mold R Headlight Putih - PCX 150 K97	Cover Body	196000.0
83510K97T00YA	Cover Body Kanan Putih - PCX 150 K97	Cover Body	427000.0
83510K97T00ZX	Cover Body Kanan Merah - PCX 150 K97	Cover Body	457000.0
53205K61900ZA	Cover Batok Depan Hitam Honda BeAT POP eSP	Cover Body	118000.0
64311K45N40MGB	Cowl A R Middle Hitam Doff - New CBR 150R K45G & New CBR 150R K45N	Cover Body	585000.0
64210K45N50ZA	Cover Tameng Depan Repsol Honda New CBR 150R K45G	Cover Body	568500.0
64520KVY900	Cover Assy FR Lower - BeAT Karbu	Cover Body	65500.0
50400K56N00ZB	Rail Grip Belakang Shimmer Silver Metallic - Sonic 150R	Cover Body	186000.0
83630K64N00AGM	Cowl L Rear (Abu-abu) - All New CBR 250RR	Cover Body	359500.0
83620K64N00AGM	Cowl R Rear Abu-abu - CBR 250RR	Cover Body	360500.0
64620K56N10FMB	Cover Samping Kiri Hitam Metalik - Supra GTR	Cover Body	517500.0
61100K56N10ZM	Spakbor Depan A Merah Honda Supra GTR	Cover Body	305000.0
64201K93N00ZM	Cover Depan Kanan Biru Honda Scoopy eSP K93	Cover Body	162500.0
53207K93N00VSM	Cover Ring Speedometer Silver Honda Scoopy eSP K93	Cover Body	59000.0
83630K64N00WRD	Cowl L Rear Red - CBR 250RR	Cover Body	310000.0
64201K93N00ZL	Cover Depan Kanan Hijau Honda Scoopy eSP K93	Cover Body	162500.0
83500K93N00ZM	Cover Body Kanan Putih - Scoopy eSP K93	Cover Body	431500.0
64440K56N00NOR	Cover L Side Upper Orange - Sonic 150R	Cover Body	195000.0
64210K64N00AGM	Cover Tameng Depan Grey Honda CBR 250RR	Cover Body	1076500.0
64440K56N00WRD	Cover L Side Upper Merah (Red) - Sonic 150R	Cover Body	211500.0
64420K56N00RSW	Cowl L Side Lower Putih - Sonic 150R	Cover Body	141500.0
64620K56N10MIB	Cover L Side Biru - Supra GTR 150	Cover Body	417000.0
61100K56N10ZA	Spakbor Depan A Merah Honda Supra GTR 150	Cover Body	238000.0
64341K45N40ZB	Cowl Right Under Hitam - New CBR 150R K45G New CBR 150R K45N	Cover Body	325000.0
64421K45N40ZA	Cowl B Left Middle Hitam - New CBR 150R K45G & New CBR 150R K45N	Cover Body	624500.0
83131K45N40ZC	Cowl Rear Center Putih - New CBR 150R K45G	Cover Body	154500.0
64321K45N40ZB	Cowl B Right Middle Hitam (Nitro Black) - New CBR 150R K45G & New CBR 150R K45N	Cover Body	680500.0
83131K45N40ROW	Cowl Rear Center Putih (White) - New CBR 150R K45G & New CBR 150R K45N	Cover Body	146500.0
83500K59A10MGB	Cover Right Body Hitam Doff - Vario 125 eSP & Vario 150 eSP	Cover Body	289500.0
83500K59A10PFW	Cover Right Body Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	302000.0
53204K59A10FMB	Visor Hitam Honda Vario 125 eSP	Cover Body	76500.0
81251KYT900	Tutup Box Bagasi Honda Scoopy Karburator KYT	Cover Body	20000.0
64200K45A60ZB	Cover Set Tameng Depan Merah Type 1 Honda CBR 150R K45R	Cover Body	800000.0
6434AK16A00	Cover Bawah Hitam Honda Scoopy FI K16G	Cover Body	118000.0
81141K2FN10ZL	Cover Inner Coklat Honda Scoopy K2F	Cover Body	431500.0
64510KYZ900	Cover Bawah Depan Honda Supra X 125 Helm-In FI	Cover Body	15500.0
61110K2VN10ZG	Spakbor Depan Merah Honda Vario 125 eSP K60R	Cover Body	233500.0
81131K2VN30ZK	Cover Rack Biru Doff Honda Vario 125 eSP K2V	Cover Body	155000.0
64301K1AN00MSG	Cover Tameng Depan Hijau Doff Honda BeAT K1A	Cover Body	183000.0
83610K84620ZB	Cover Body Set Kiri Honda CRF150L K84	Cover Body	94500.0
64501K2VN30VRD	Cover Depan Kanan Merah Honda Vario 125 eSP K2V	Cover Body	180000.0
64421K2FN00ZL	Cover Bawah Kanan Cream Honda Scoopy K2F	Cover Body	152500.0
53208K2VN30FMB	Cover Batok Atas Hitam Honda Vario 125 eSP K2V	Cover Body	98000.0
83600K93N00ZP	Cover Body Kiri Merah - Scoopy eSP K93	Cover Body	407500.0
83510K0WNA0MGB	Cover Body Kanan Hitam Doff Honda ADV 160	Cover Body	173000.0
83685K64NA0ZA	Cover Set Bawah Belakang Kiri Type 2 Honda CBR 250RR K64	Cover Body	25500.0
50280KYE940	Cover Body Depan Bawah Kanan Honda Mega Pro FI	Cover Body	44500.0
64211K45NL0ZC	Cover Tameng Depan Merah Honda CBR 150R K45R	Cover Body	797000.0
83610K0WNA0PFW	Cover Body Kiri Putih Metalic Honda ADV 160	Cover Body	220000.0
64502K0WNA0ZL	Cover Body Samping Kiri Hitam Honda ADV 160	Cover Body	195000.0
64337K0WNA0ZB	Cover Multi SW Hitam Honda ADV 160	Cover Body	28000.0
83700K0WNA0	Cover Left Body Side Honda ADV 160	Cover Body	37000.0
83610K0WNA0MSR	Cover Body Kiri Merah Doff Honda ADV 160	Cover Body	170000.0
64400K64NA0ZB	Cover Body Samping Kiri Type 1 Honda CBR 250RR K64	Cover Body	1249000.0
64220K64NA0ZA	Set Illust Front Lower Cowl Type 2 Honda CBR 250RR K64J	Cover Body	70000.0
81130K2FN00ZL	Lid Assy Pocket Hitam Metalic Honda Scoopy K2F	Cover Body	137500.0
83500K2FN00ASB	Cover Body Kanan Hitam Metalic Honda Scoopy K2F	Cover Body	371000.0
50410K2FN00ZF	Behel Belakang Silver Honda Scoopy K2F	Cover Body	227000.0
64202K2FN00ZR	Cover Depan Kiri Hitam Honda Scoopy K2F	Cover Body	152500.0
64431K2SN00ZM	Cover Kanan Bawah Hitam Honda Vario 160 K2S	Cover Body	152500.0
64431K2FN00ZP	Cover Under Kiri Side Putih Honda Scoopy K2F	Cover Body	157500.0
64432K1ZJ10ZU	Cover Floor Side Kiri Putih Honda PCX 160 K1Z	Cover Body	421000.0
83600K2FN00MPC	Cover Body Kiri Putih Doff Honda Scoopy K2F	Cover Body	426500.0
53209K2SN10ZH	Cover Batok Kiri Putih Honda Vario 160 K2S	Cover Body	91500.0
5070AKYZ900	Cover Kiri Pivot Assy Honda Supra X 125 Helm-in Karburator	Cover Body	11500.0
64211K3BN00ZA	Garnis Silver Honda CB150X	Cover Body	162500.0
53206K2SN10ZA	Cover Batok Belakang Honda Vario 160 K2S	Cover Body	25500.0
81265K2SN00	Karet Tahanan Lumpur Honda Vario 160 K2S	Cover Body	42000.0
81253K2SN00	Lid Box Bagasi Honda Vario 160 K2S	Cover Body	32500.0
83610K1ZJ10ASB	Cover Body Kiri Hitam Metalic Honda PCX 160 K1Z	Cover Body	376000.0
84100K1ZJ10	Rail RR Grab Hitam Metalic Honda PCX 160 K1Z	Cover Body	318500.0
64432K2SN00ZK	Cover Left Floor Side Merah Doff Honda Vario 160 K2S	Cover Body	162500.0
64451K3BN00	Cover Left Front Side Honda CB150X	Cover Body	76500.0
64431K2SN00ZL	Cover Right Floor Side Putih Honda Vario 160 K2S	Cover Body	152500.0
64305K1ZJ10ZQ	Garnish Front Biru Doff Honda PCX 160 K1Z	Cover Body	232500.0
64250K3BN00	Panel Assy Meter Honda CB150X	Cover Body	51000.0
83510K1ZJ10ASB	Cover Body Kanan Hitam Metalic Honda PCX 160 K1Z	Cover Body	376000.0
81142K2SN00ZM	Cover Inner Upper Hitam Honda Vario 160 K2S	Cover Body	294000.0
83600K2FN00FMB	Cover Body Kiri Hitam Honda Scoopy K2F	Cover Body	355500.0
64420K1ZJ10ZN	Cover B Center Hitam Honda PCX 160 K1Z	Cover Body	127000.0
84152K97T00YX	Lid Grab Rail Cover Hitam Doff Honda PCX 150 K97	Cover Body	205000.0
80151K2FN00ZL	Cover Center Hitam Doff (MT GN BL) - Scoopy K2F	Cover Body	132000.0
64502K0WN01ZA	Cover Depan Kiri Brown Honda ADV 150	Cover Body	233500.0
64441K45NL0ZB	Cowl Comp Left Under Hitam - Honda CBR 150R K45R	Cover Body	447000.0
83121K45NL0ZE	Cover Kiri Belakang Hitam (Cowl Left Rear Black) - Honda CBR 150R K45R	Cover Body	305000.0
64421K45NL0	Cover Kiri (Cowl Left Side) Honda CBR 150R K45R	Cover Body	54000.0
64400K45NZ0ZA	Cover Body Kiri (Set Illust L Middle Cowl A Type1) - CBR 150R K45R	Cover Body	883500.0
81141K93N00ZX	Cover Inner Merah (MT S0 RED) - Honda Scoopy eSP (K93)	Cover Body	602000.0
64301K1AN00MNB	Cover Tameng Depan (Cover Front) Biru Doff - Honda BeAT K1A	Cover Body	413000.0
35191K27V01	Cover Kabel Jok Honda NEW PCX 150	Cover Body	7500.0
83111K45N40ZE	Cowl Right Rear (MT GN BL) - Honda New CBR 150R K45N	Cover Body	241000.0
64202K2FN00YF	Cover Depan Kiri Silver Honda Scoopy K2F	Cover Body	195000.0
64431K97T00YK	Cover Body (Cover R Floor SD MT CR SL) PCX 150 K97	Cover Body	335000.0
80115K0JN00ZA	Base,Licence Light Genio	Cover Body	11000.0
17245K1AN00	Tutup Saringan Udara (Cover Sub Assy,Air/C) - BeAT K1A	Cover Body, Saringan Udara (Filter)	76500.0
64460K0JN00ZB	Lid,Battery Hitam - Honda Genio	Cover Body	27500.0
77340K0WN00ZA	Grip L RR Black - ADV 150	Cover Body	244000.0
81134K93N00ZY	Cover Inner Upper MT GN BL - Scoopy eSP (K93)	Cover Body	71500.0
83610K0WN00MGB	Cover L Body Hitam Doff - ADV 150	Cover Body	173000.0
83510K0WN00MGB	Cover R Body Hitam Doff Honda ADV 150	Cover Body	173000.0
81140K0WN00ZB	Garnish Upper Inner Cover Silver Metalic - ADV 150	Cover Body	107000.0
64202K0JN00ZG	Cover Depan Kiri Hitam Metalic Honda Genio	Cover Body	152500.0
64202K0JN00ZA	Cover Depan Kiri Coklat Metalic Honda Genio	Cover Body	152500.0
81131K0JN00ZB	Cover Inner Rack Merah - Genio	Cover Body	452000.0
81131K0JN00ZE	Cover Inner Rack Hitam Mutiara - Genio	Cover Body	447000.0
64201K0JN00ZE	Cover Depan Kanan Hitam Honda Genio	Cover Body	162500.0
61100K0JN00MGB	Spakbor Depan Hitam Doff Honda Genio	Cover Body	299500.0
80151K0JN00ZB	Cover Center Black - Honda Genio K0J	Cover Body	30500.0
61355K56NG0ZA	Garnis Kiri Merah Honda Sonic 150R K56	Cover Body	90000.0
64750K56N00ZA	Cover Set Combination Light - Sonic 150R K56	Cover Body	53000.0
64440K45NH0ZA	Set Ilust L Under Cowl Type 2 - CBR 150R K45N	Cover Body	107000.0
64330K64N00FMB	Cover Body Kanan (Cowl R Middle) Black - CBR 250RR K64	Cover Body	1348500.0
77210K18960FMB	Cover Body Kanan (Cowl R Side) Black - CB 150 Verza	Cover Body	169000.0
61100K64N00ZE	Spakbor Depan Hitam Metalik Honda CBR 250RR	Cover Body	395000.0
50260K18960PFR	Cover Body Depan Kanan Merah (Pearl Firebrick) Honda CB 150 Verza	Cover Body	125000.0
83750K46N00ZK	Cover Rear Center Red - Vario 110 eSP	Cover Body	71500.0
83751K46N00ZC	Cover Rear Center Lower Hitam - Vario 110 FI	Cover Body	75500.0
61100K46N00ZG	Spakbor Depan Abu Abu Honda Vario 110 eSP	Cover Body	253000.0
50260K15600MSR	Cover Body Depan kanan Merah Doff Honda New CB150 StreetFire K15M	Cover Body	239500.0
83750K46N00ZH	Cover Rear Center White - Vario 110 eSP	Cover Body	71500.0
64301K46N00MAG	Cover Tameng Depan Abu Abu - Vario 110 eSP	Cover Body	202500.0
50265K15600MSR	Cover Body Depan Kiri Merah Honda New CB150 StreetFire K15M	Cover Body	245500.0
81131K59A70ZR	Cover Rack (AF BL ME) - New Vario 125 eSP (K60R)	Cover Body	249000.0
64501K59A70ZM	Cover R FR WN Red - New Vario 125 eSP (K60R)	Cover Body	317000.0
84100K59A70ZH	Rail Rear Grab NH-303M - New Vario 150 K59J & New Vario 125 K60R	Cover Body	211000.0
81131K59A70ZP	Cover Rack Putih - New Vario 150 K59J	Cover Body	233500.0
64430K64N00NOR	Cowl L Middle Orange - CBR 250RR	Cover Body	1585000.0
81142K93N00ZH	Lid L Pocket Merah - Scoopy eSP K93	Cover Body	138000.0
64601K46N00RSW	Cover Kiri Depan Putih - Vario 110 eSP	Cover Body	152500.0
64510K97T00ZA	Garnish R Silver - PCX 150 K97	Cover Body	177000.0
81137K97T00ZD	Lid Smart EMG Hitam - PCX 150 K97	Cover Body	183000.0
84151K97T00YA	Cover Behel Putih Honda PCX 150 K97	Cover Body	338000.0
64432K97T00ZX	Cover L Floor Side Gold - PCX 150 K97	Cover Body	470000.0
64201K93N00ZQ	Cover Depan Kanan Putih Honda Scoopy eSP K93	Cover Body	127000.0
64431K97T00ZX	Cover R Floor Gold - PCX 150 K97	Cover Body	470000.0
61100K56N10ZL	Spakbor Depan A Orange Honda Supra GTR 150	Cover Body	296500.0
81131KZR600ZK	Cover Inner Upper Hitam - Vario 125 FI	Cover Body	263000.0
81131KVY900	Cover Inner Upper - BeAT Karbu	Cover Body	52500.0
64211K45N40ZE	Cover Tameng Depan Putih Honda CBR 150R K45G	Cover Body	727000.0
6433AK41N00	Cover M/P Assy Honda New Supra X 125 FI	Cover Body	67000.0
83600K59A10ZJ	Cover Body Kiri Hitam Doff - Vario 125 eSP & Vario 150 eSP	Cover Body	403500.0
83620K64N00WRD	Cowl R Rear (WN RD) - CBR 250RR	Cover Body	311000.0
83600K93N00ZM	Cover Body Kiri Putih - Scoopy eSP K93	Cover Body	431500.0
83610K56N00WRD	Cover R Body Merah - Sonic 150R	Cover Body	142500.0
83510K56N10CPR	Cover Belakang Merah - Supra GTR 150	Cover Body	542500.0
83620K56N00SMM	Cover L Body Magenta - Sonic 150R	Cover Body	202500.0
53208K56N10ZE	Cover Batok Kiri Putih Honda Supra GTR 150	Cover Body	91500.0
53208K56N10ZD	Cover Batok Kiri Hitam Honda Supra GTR 150	Cover Body	81500.0
64441K45N40ZB	Cowl Left Under Hitam - New CBR 150R K45G & New CBR 150R K45N	Cover Body	325000.0
83131K45N40ZB	Cowl Rear Center Hitam (Black) - New CBR 150R K45G & New CBR 150R K45N	Cover Body	131000.0
64311K45N40ZB	Cowl Right Middle A Putih Honda New CBR 150R K45G	Cover Body	758500.0
61100K59A10CSR	Spakbor Depan Merah Honda Vario 150 eSP	Cover Body	240000.0
6431AKZR600ZD	Cover Pijakan Kaki Hitam Honda Vario Techno 125 Helm-In FI CBS	Cover Body	81000.0
83611KCJ660	Cover Kanan Carburetor Honda Tiger Revolution	Cover Body	113000.0
81144K0JN60ZA	Knob Inner Pocket Coklat Honda Genio K0JN	Cover Body	6500.0
80100KEV880	Spakbor Belakang Honda Supra FIT	Cover Body	44500.0
81141K2FN80ZG	Cover Inner Hitam Honda Scoopy K2F	Cover Body	430000.0
64470K07900ZA	Molding Kanan Hitam Honda Supra X 125 FI	Cover Body	16000.0
64201K2FN00ZL	Cover Depan Kanan Cream Honda Scoopy eSP K2F	Cover Body	178000.0
64360K64NP0	Panel Inner Kiri Honda CBR 250RR K64N	Cover Body	60000.0
83630K64NP0ZD	Cover Kiri Belakang Merah Honda CBR 250RR K64J	Cover Body	380000.0
83521K64NP0	Cover Samping Kiri Honda CBR 250RR K64J	Cover Body	41000.0
64330K64NP0WRD	Cover Body Samping Kanan Merah Honda CBR 250RR K64N	Cover Body	1100000.0
64301K2VN30ZL	Cover Tameng Depan Hitam Doff Honda Vario 125 eSP K2V	Cover Body	248000.0
64201K2FN00YA	Cover Depan Kanan Oren Honda Scoopy K2F	Cover Body	142500.0
61311K15920	Dudukan Lampu Depan Honda CB150R StreetFire K15	Cover Body	75500.0
83650K2FN00MSG	Cover Belakang Hijau Doff Honda Scoopy K2F	Cover Body	62000.0
64460K2FN80ZB	Cover Tutup Battery Hitam Scoopy K2F	Cover Body	40000.0
64431K2FN00YM	Cover Bawah Kiri Hijau Doff Honda Scoopy K2F	Cover Body	198000.0
64421K2FN00YL	Cover Bawah Kanan Hijau Doff Honda Scoopy K2F	Cover Body	198000.0
83750K2FN00YC	Cover Belakang Hijau Doff Honda Scoopy K2F	Cover Body	130000.0
83600K2FN00YE	Cover Body Kiri Hijau Doff Honda Scoopy K2F	Cover Body	380000.0
64202K0JN00MJB	Cover Depan Kiri Coklat Honda Genio	Cover Body	129000.0
83510K0WNA0ASB	Cover Body Kanan Hitam Honda ADV 160	Cover Body	233500.0
17546K84600ZA	Cover Body Set Kanan Merah Type 1 Honda CRF150L K84	Cover Body	155500.0
81136K2VN30	Box Inner Upper Honda Vario 125 eSP K2V	Cover Body	25000.0
83660K84600ZA	Cover body Samping Kiri Putih Honda CRF150L K84	Cover Body	84500.0
80103KSPB00	Rumah Lampu Plat Nomor Honda Mega Pro	Cover Body	4500.0
83510K0WNA0PFW	Cover Body Kanan Putih Honda ADV 160	Cover Body	213500.0
83750K0WNA0	Cover RR Center Upper Honda ADV 160	Cover Body	28000.0
83500K2FN00ZX	Cover Body Kanan Hitam Doff Honda Scoopy K2F	Cover Body	302000.0
64502K0WNA0ZG	Cover Body Samping Kiri Depan Merah Doff Honda ADV 160	Cover Body	230000.0
80115KZR600ZB	Rumah Lampu Plat Nomor Honda Vario Techno 125 Helm In FI	Cover Body	8500.0
19610K0JN01	Cover Comp Cooling Fan Honda BeAT dan BeAT Street K1A	Cover Body	30500.0
83510K84960ZA	Cover body Samping Kanan Honda CRF150L K84	Cover Body	142500.0
83500K2FN00MJB	Cover Body Kanan Brown Honda Scoopy K2F	Cover Body	426500.0
81130K2FN00ZJ	Lid Assy Pocket Cream Honda Scoopy K2F	Cover Body	127000.0
83500K59A10ZL	Cover Body Kanan (Hitam Metallic) - Vario 125 eSP & Vario 150 eSP	Cover Body	477500.0
83141K45NL0ZB	Cover Seat Lock Merah Honda CBR 150R K45R	Cover Body	193000.0
64370K47N00ZA	Cover Samping Bawah Kanan Honda Blade 125 FI K47	Cover Body	24500.0
83685K64NA0ZB	Cowl Rear Inner Kiri Type 1 Honda CBR 250RR K64	Cover Body	35000.0
83675K64NA0ZB	Cowl Rear Inner Kanan Type 1 Honda CBR 250RR K64	Cover Body	35000.0
64200K64NA0ZB	Cover Tameng Depan Hitam Honda CBR 250RR K64	Cover Body	793000.0
61100K84900ZC	Spakbor Depan Putih Honda CRF150L K84	Cover Body	173000.0
61311K15710	Dudukan Lampu Honda CB150R StreetFire K15P	Cover Body	78500.0
81134K2FN00ZV	Cover Inner Upper Brown Honda Scoopy K2F	Cover Body	173000.0
64405K1ZJ10ZC	Lid Fuel Hitam Honda PCX 160 K1Z	Cover Body	20500.0
86649K93NB0ZC	Mark Sporty Type 1 Honda Scoopy eSP K93	Cover Body	5500.0
84151K1ZJ10ZS	Cover Behel Hitam Metalic Honda PCX 160 K1Z	Cover Body	326500.0
83650K64N00ZK	Cover Seat Lock Hitam Doff Honda CBR 250RR K64J	Cover Body	228500.0
53208K2SN00ZC	Cover Batok kanan Hitam Doff Honda Vario 160 K2S	Cover Body	75500.0
53209K2SN00ZC	Cover Batok Kiri Hitam Doff Honda Vario 160 K2S	Cover Body	75500.0
61100K1ZN20ASB	Spakbor Depan Hitam Metalic Honda PCX 160 K1Z	Cover Body	253000.0
61100K2SN00MGB	Spakbor Depan A Hitam Doff Honda Vario 160 K2S	Cover Body	233500.0
64420K1ZJ10ZQ	Cover B Center Biru Doff Honda PCX 160 K1Z	Cover Body	127000.0
64341K3BN00ZA	Cowl Right Under Silver Honda CB150X	Cover Body	244000.0
64305K1ZJ10ZP	Garnish Front Merah Doff Honda PCX 160 K1Z	Cover Body	246000.0
64200K45NZ0ZB	Cover Tameng Depan Merah Honda CBR 150R K45R	Cover Body	812500.0
83600K2FN00ASB	Cover Body Kiri Hitam Metalic Honda Scoopy K2F	Cover Body	371000.0
83510K84970ZA	Set Illust R Side A Cover Type 1 Honda CRF150L K84	Cover Body	142500.0
83510K1ZJ10MIB	Cover Body Kanan Biru Doff Honda PCX 160 K1Z	Cover Body	376000.0
83510K1ZJ10MGB	Cover Body Kanan Hitam Doff Honda PCX 160 K1Z	Cover Body	376000.0
81140K1ZJ10ZN	Outer Inner Cover Hitam Metalic Honda PCX 160 K1Z	Cover Body	274500.0
83600K2SN00MGB	Cover Body Kiri Hitam Doff Honda Vario 160 K2S	Cover Body	478000.0
17556K84960ZA	Cover Body Kiri Set Hitam Type 1 Honda CRF 150L	Cover Body	173000.0
11341K1ZJ10	Cover CVT Honda PCX 160 K1Z	Cover Body	528500.0
84152K1ZJ10ZR	Lid Grab Rail Cover Putih Honda PCX 160 K1Z	Cover Body	117000.0
81137K1ZJ10ZQ	Lid Smart Emergency Matte Blue Honda PCX 160 K1Z	Cover Body	96500.0
83610K1ZJ10MSR	Cover Left Body Kiri Merah Doff Honda PCX 160 K1Z	Cover Body	396000.0
17225K1ZN80	Cover Saringan Udara (Case Sub Assy Air Cleaner) PCX 160 e:HEV	Cover Body, Saringan Udara (Filter)	73500.0
64431K2FN00ZM	Cover Under L Sid Biru Doff (MA BL MT) - Scoopy K2F	Cover Body	122000.0
5060AKYZ900	Cover Assy R Pivot - Honda Supra X 125 Helm-in	Cover Body	11500.0
53207K2FN00MCS	Cover Ring Speedometer Silver Honda Scoopy K2F	Cover Body	59000.0
61100K84900ZE	Spakbor Depan Grey Honda CRF 150L	Cover Body	183000.0
80110K84920ZE	Cover Spakbor Belakang Merah (Set Illus Rear Fender Comp Type1) - Honda CRF 150L	Cover Body	355500.0
81134K2FN00ZN	Cover Inner UP MT CR SL - Honda Scoopy eSP K2F	Cover Body	66000.0
81134K2FN00ZJ	Cover Inner Upper VI BE - Honda Scoopy eSP K2F	Cover Body	102000.0
83121K45NL0ZD	Cover Kiri Putih Mutiara (Cowl Left Rear RO White) - Honda CBR 150R K45R	Cover Body	305000.0
83121K45NL0ZB	Cover Belakang Kiri Merah (Cowl Left Rear WN Red) - Honda CBR 150R K45R	Cover Body	335000.0
83141K45NL0ZD	Cover Seat Lock Hitam Doff MT GN BL - Honda CBR 150R K45R	Cover Body	183000.0
83750K2FN00ZJ	Cover Belakang Hitam (Cover Rear Center AS BK MT) - Honda Scoopy eSP K2F	Cover Body	142500.0
50534K84900	Plate Left Front Eng Hanger - Honda CRF 150L	Cover Body	11500.0
64411K45N40ZE	Cover Body Kiri Hitam (Cowl A, Left Middle Matte Gun Black) - Honda New CBR 150R K45N	Cover Body	585000.0
64501K0WN01ZD	Cover Kanan Depan Hitam (Matt Gun Black) - Honda ADV 150	Cover Body	223500.0
64333K1AN00	Guide Harness - Honda BeAT K1A	Cover Body	24000.0
53205K1AN00ZQ	Cover Batok Kepala Depan Biru Doff Honda BeAT K1A	Cover Body	86500.0
53173GFM900	Cover L BRK Lever Bracket - Honda BeAT FI CBS, New BeAT Sporty eSP, New BeAT POP eSP, Vario 125 CBS ISS, Vario 150 eSP, Vario 125 eSP	Cover Body	17500.0
50400K18900ZB	Grip Rear Mat Axis Gray - Honda Verza 150	Cover Body	112500.0
53280K59A70ZB	Cover Batok Belakang Honda Vario 150 eSP K59J	Cover Body	37000.0
64211K45NA0ZG	Cover Tameng Depan Hitam Honda New CBR 150R K45N	Cover Body	523000.0
53206KZLA00ZA	Cover Batok Belakang Honda Spacy	Cover Body	41500.0
8010BK18900	Spakbor Belakang (Fender A RR Set) - Honda Verza 150 K18 8010BK18900	Cover Body	59500.0
64432K97T00YK	Cover,Left Floor Side Silver PCX 150 K97	Cover Body	335000.0
61100K97T00YJ	Spakbor Depan Silver PCX 150 K97	Cover Body	237000.0
81142K93N00ZK	Lid L Pocket Hitam - Scoopy eSP K93	Cover Body	122500.0
64502K96V00YB	Cover Body Kiri Depan (Cover,L FR Side) Coklat Doff- PCX 150 K97	Cover Body	439000.0
83600K1AN00FMB	Cover Body Kiri (Cover,Left Body (Black)) Hitam Metalik - BeAT K1A	Cover Body	127000.0
53205K1AN00ZB	Cover Batok Kepala Depan Merah Metalik Honda BeAT K1A	Cover Body	127000.0
50312K0WN00	Cover Dudukan Lampu Depan Kiri Honda ADV 150	Cover Body	147500.0
81132K0WN00	Pocket,Inner - ADV 150	Cover Body	41000.0
83550K0WN10ZB	Set Illust R Body Cover T1 - ADV 150	Cover Body	239000.0
64340K0JN00ZA	Cover Under - Genio	Cover Body	91500.0
83600K0JN00MGB	Cover Body Kiri (Cover Left Body) Hitam Doff - Honda Genio	Cover Body	452000.0
83610K0WN00ARE	Cover L Body Merah Metalic - ADV 150	Cover Body	213500.0
64421K0JN00ZE	Cover Kanan (Right Under Side) Hitam - Honda Genio	Cover Body	162500.0
64350K0WN00ZC	Cover R Center Side Silver Metalic - ADV 150	Cover Body	188000.0
64202K0JN00ZE	Cover Depan Kiri Hitam Honda Genio	Cover Body	162500.0
64360K0WN00ZB	Cover L Center Side Putih - ADV 150	Cover Body	173000.0
61100K0JN00VRD	Spakbor Depan Merah Honda Genio	Cover Body	315000.0
64336K0WN00ZC	Cover FR Upper WN RD - Honda ADV 150	Cover Body	196000.0
53205K0JN00ZA	Cover Speedometer Depan Coklat Metalic Honda Genio	Cover Body	117000.0
81141K61900ZA	Cover Rak (Pocket Inner) - BeAT POP eSP & BeAT Sporty eSP	Cover Body	53500.0
64501K59A70YC	Body Kanan Depan (Cover R FR Ma Bl Mt) - New Vario 150 eSP K59J	Cover Body	254000.0
81131K59A70YB	Cover Rack (Ma Jb Mt/Brown) - Vario 150 eSP K59J	Cover Body	152500.0
17235KVY900	Cover Sub Assy Air Cleaner - Scoopy Karburator	Cover Body	19500.0
50260K18960INS	Cover Body Depan Kanan Silver Honda CB150 Verza	Cover Body	117000.0
64210K64N00ZB	Cover Tameng Depan Merah Honda CBR 250RR K64	Cover Body	802000.0
81250KZR600	Box Bagasi (Box Luggage) - Vario Tehcno 125 FI STD, Vario Tehcno 125 FI CBS ISS, Vario Tehcno 125 Helm-In FI CBS, Vario Tehcno 125 Helm-In FI	Bagasi (Luggage), Cover Body	114000.0
83710K15600WRD	Cowl L Rear Red - New CB150R StreetFire K15M	Cover Body	205000.0
61100K46N00ZJ	Spakbor Depan Grey Metalic Honda Vario 110 eSP	Cover Body	391000.0
83610K15600WRD	Body Belakang Kanan Merah New CB150R StreetFire K15M	Cover Body	206000.0
83610K15600MSR	Cowl Right Rear Matte Red - New CB150R StreetFire K15M	Cover Body	166500.0
64601K46N00ARM	Cover Kiri Depan Merah Maroon - Vario 110 eSP	Cover Body	178000.0
871X0K25610ZAR	Stripe Set R Black - BeAT Sporty eSP (K25)	Cover Body	76500.0
64430K64N00ASB	COWL L MIDDLE Hitam - All New CBR 250RR (K64)	Cover Body	1582000.0
83600K59A70ZP	Cover L Body White - New Vario 150 (K59J)	Cover Body	511000.0
61100K59A70ZK	Spakbor Depan Silver Honda New Vario 150 K59J	Cover Body	268000.0
83500K25900CSR	Cover Body Kanan (Cover Body, Right) Merah - Honda BeAT FI	Cover Body	279500.0
83500K59A70ZL	Cover Body Kanan (Cover, R Body) Merah - New Vario 150 K59J	Cover Body	601000.0
8010AK41N00ZA	Spakbor Belakang Assy - Supra X 125 FI	Cover Body	113000.0
81139K97T00ZX	Outer Inner Kiri Merah - PCX 150 K97	Cover Body	260000.0
81141K97T00ZL	Lid Inner Pocket Merah - PCX 150 K97	Cover Body	249000.0
81138K97T00ZT	Outer R Inner Merah - PCX 150 K97	Cover Body	260000.0
53205K1AN20ZB	Cover Stang Depan Honda BeAT Street K1A	Cover Body	81500.0
64505K97T00ZX	Mold R Headlight Merah - PCX 150 K97	Cover Body	223000.0
61100K97T00ZR	Spakbor Depan Hitam Honda PCX 150 K97	Cover Body	248000.0
64503K97T00YA	Cover FR Center Putih - PCX 150 K97	Cover Body	191000.0
61316K36N10	Back Plate FR Num - PCX 150 K97	Cover Body	359000.0
81141K97T00ZD	Lid Inner Pocket Hitam - PCX 150 K97	Cover Body	214000.0
61100K61900ZA	Spakbor Depan Merah Honda BeAT POP eSP	Cover Body	138500.0
61100K61900ZB	Spakbor Depan Putih Honda BeAT POP eSP	Cover Body	135500.0
64301K61900VBM	Cover Tameng Depan (Cover Front) Biru - BeAT POP eSP	Cover Body	377000.0
64320K15930ZB	Cowl Under Center Putih - New CB150R Streetfire K15G	Cover Body	142500.0
80101K84900	Fender B RR - CRF 150L	Cover Body	57000.0
64511K45N40ZD	Cover Fuel Tank Cowl Hitam - New CBR 150R K45G & New CBR 150R K45N	Cover Body	229500.0
6431BK16A40ZA	Step Floor Assy - Scoopy eSP (K16)	Cover Body	126000.0
64450KYZ900ZD	Cover L M/P SD Silver - Supra X 125 Helm In	Cover Body	361500.0
61100K16A00ZD	Spakbor Depan Hitam Honda Scoopy FI K16	Cover Body	239000.0
64301K61900FMB	Cover Tameng Depan (Cover Front) Hitam - BeAT POP eSP	Cover Body	377000.0
53208K59A10WRD	Cover Speedometer Merah Honda Vario 150 eSP	Cover Body	159500.0
83600K59A10ZM	Cover Body Kiri Hitam Metallic - Vario 125 & 150 eSP	Cover Body	477500.0
83500K59A10RSW	Cover Body Kanan Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	520000.0
64610K56N10FMB	Cover Samping Kanan Hitam Metalik - Supra GTR	Cover Body	517500.0
64321K45N40ZC	Cowl B R Middle Merah - CBR 150R K45G & New CBR 150R K45N	Cover Body	734000.0
53206K93N00ZH	Cover B Speedometer Red - Scoopy eSP K93	Cover Body	102000.0
83600K93N00ZA	Cover Body Kiri Cream - Scoopy eSP K93	Cover Body	418500.0
83650K93N00ZL	Cover Rear Center Lower Putih - Scoopy eSP K93	Cover Body	154500.0
64430K64N00WRD	Cowl L Middle (Merah) - CBR 250RR	Cover Body	1630500.0
83610K56N00MGB	Cover R Body Hitam Doff - Sonic 150R	Cover Body	149500.0
64340K56N00RSW	Cover R Side Upper Putih - Sonic 150R	Cover Body	202500.0
64340K56N00FMB	Cover R Side Upper Hitam - Sonic 150R	Cover Body	196000.0
64320K56N00FMB	Cowl R Side Lower Hitam - Sonic 150R	Cover Body	137500.0
64490K56N10DSM	Cover L RR Body Silver - Supra GTR 150	Cover Body	206500.0
64301K56N10ZA	Cover FR Top Merah - Supra GTR 150	Cover Body	311000.0
53205K81N00SMM	Cover Batok Depan Magenta Honda New BeAT eSP k81	Cover Body	105000.0
64511K45N40PFW	Cover Fuel Tank Putih - New CBR 150R K45G	Cover Body	239000.0
83750K59A10ZN	Cover Rear Center Coklat (Brown) - Vario 125 eSP & Vario 150 eSP	Cover Body	72500.0
64301K59A10ZL	Cover Front Biru (Blue) - Vario 125 eSP & Vario 150 eSP	Cover Body	271500.0
83760K3VN00ZF	Cover Bawah Tengah Belakang Hitam Metalic Honda Stylo 160	Cover Body	25000.0
64502K1ZJ10ZC	Cover Depan Samping Kiri Silver Honda PCX 160 K1Z	Cover Body	485000.0
81134K16900YG	Cover Inner Upper Putih Honda Scoopy eSP K16R	Cover Body	61000.0
64301K1AN00MJB	Cover Tameng Depan Brown Honda BeAT K1A	Cover Body	183000.0
64202K2FN00ZL	Cover Depan Kiri Cream Honda Scoopy K2F	Cover Body	178000.0
83750K16900ZE	Cover Belakang Tengah Hitam Honda Scoopy FI K16G	Cover Body	181000.0
83640KYT940	Guard Dust Kiri Hitam Honda Scoopy Karburator KYT	Cover Body	5000.0
81142K0JN60ZB	Lid Inner Pocket Hitam Honda Genio K0JN	Cover Body	10500.0
81144K0JN60ZB	Knob Inner Pocket Honda Genio K0JN	Cover Body	15500.0
81141K16A40IBM	Cover Inner Brown Honda Scoopy eSP K16R	Cover Body	629500.0
8010AKZR600	Spakbor Belakang Honda Vario Techno 125 FI CBS ISS	Cover Body	122000.0
64301KZR600PFW	Cover Tameng Depan Putih Honda Vario Techno 125 Helm-In FI	Cover Body	305000.0
64301K16A00FMB	Cover Tameng Depan Honda Scoopy FI K16G	Cover Body	191000.0
81139K97T00ZN	Outer L Inner Hitam - PCX 150 K97	Cover Body	207000.0
61000K45A90ZB	Spakbor Depan Merah Type 3 Honda CBR 150R K45R	Cover Body	345500.0
64300K45A60ZA	Cover Body Kanan Merah Type 1 Honda CBR 150R K45R	Cover Body	870000.0
64502K1ZJ10YH	Cover Kiri Depan Merah Maron Honda PCX 160 K1Z	Cover Body	560000.0
8010AKTM850	Spakbor Belakang Hitam Honda Supra X 125 Injection	Cover Body	107000.0
81141K2FN00ZN	Cover Inner Hitam Doff Honda Scoopy K2F	Cover Body	391000.0
64475K07900ZA	Molding Kiri Hitam Honda Supra X 125 FI	Cover Body	16000.0
64431K2FN00ZK	Cover Bawah Kiri Cream Honda Scoopy K2F	Cover Body	152500.0
64380K47N00ZA	Cover Body Bawah Samping Kiri Honda Blade 125 FI K47	Cover Body	25000.0
83600K1AN00MBS	Cover Body Kiri Dark Silver Honda BeAT K1A	Cover Body	135000.0
64600K64NP0ZA	Cover Body Set Kiri Honda CBR 250RR K64N	Cover Body	70000.0
64500K64NP0ZA	Cover Body Set Kanan Honda CBR 250RR K64N	Cover Body	70000.0
64200K45A50ZB	Cover Tameng Depan Hitam Doff Honda CBR 150R K45R	Cover Body	523000.0
53205K1AN00ZU	Cover Batok Kepala Depan Hijau Doff Honda BeAT K1A	Cover Body	98000.0
81131K2VN30ZL	Cover Rack Hitam Doff Honda Vario 125 eSP K2V	Cover Body	155000.0
64225K64NP0	Cover Meter Honda CBR 250RR K64J	Cover Body	28000.0
83670K64NP0	Cowl Rear Inner Kanan Honda CBR 250RR K64J	Cover Body	38000.0
77237K56N00	Cover Seat Catch Honda Sonic 150R K56	Cover Body	6500.0
64501K1ZJ10YJ	Cover Depan Samping Kanan Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	480000.0
64301K2VN30ZM	Cover Tameng Depan Hitam Metalic Honda Vario 125 eSP K2V	Cover Body	233500.0
64210K64NP0ZD	Cover Tameng Depan Merah Honda CBR 250RR K64J	Cover Body	975000.0
64100K64NP0ZA	Wind Screen Honda CBR 250RR K64N	Cover Body	203000.0
64500K2SH00ZC	Cover Depan Kanan Putih Doff Honda Vario 160 K2S	Cover Body	254000.0
83500K2VN30MGB	Cover Body Kanan Hitam Doff Honda Vario 125 eSP K2V	Cover Body	250000.0
64601K2VN30MIB	Cover Depan Kiri Biru Doff Honda Vario 125 eSP K2V	Cover Body	180000.0
64301K2FN00YH	Cover Tameng Depan Hijau Doff Honda Scoopy K2F	Cover Body	312000.0
61300K84920ZB	Cover Lampu Depan Hijau Honda CRF150L K84	Cover Body	81500.0
53208K2VN30MIB	Cover Batok Atas Biru Doff Honda Vario 125 eSP K2V	Cover Body	98000.0
11360K18900	Cover Comp Belakang Kiri Honda Verza	Cover Body	56000.0
50400K18900ZA	Behel Belakang Silver Honda Verza 150	Cover Body	136000.0
64421K2FN00YJ	Cover Bawah Kanan Hitam Doff Honda Scoopy K2F	Cover Body	150000.0
64390K47N00	Cover Bawah Samping Kanan Honda Blade 125 FI K47	Cover Body	16000.0
61304K56N00ZJ	Garnis Bawah Merah Honda Sonic 150R K56	Cover Body	88500.0
53207K2FN00MPC	Cover Ring Speedometer Putih Honda Scoopy K2F	Cover Body	78500.0
80104K25600	Guard Splash Honda BeAT Sporty eSP K25G	Cover Body	8500.0
64395K47N00	Cover Bawah Samping Kiri Honda Blade 125 FI K47	Cover Body	18500.0
37213KZR601	Holder Winker Relay Honda Vario Techno 125 FI STD	Cover Body	3000.0
64420K3BN00ZC	Cover Body Set Tengah Kiri Merah Type 1 Honda CB150X	Cover Body	355500.0
83610K0WNA0MPC	Cover Body Kiri Putih Doff Honda ADV 160	Cover Body	165000.0
83610K0WNA0ARE	Cover Body Kiri Merah Honda ADV 160	Cover Body	213500.0
64400K0WNA0ZH	Cover Body Set Samping Kanan Depan Merah Doff Honda ADV 160	Cover Body	230000.0
17546K84620ZA	Cover Body Set Kanan Hijau Type 2 Honda CRF150L K84	Cover Body	170000.0
64336K0WN00ZX	Cover Atas Depan Putih Honda ADV 160	Cover Body	130000.0
64415K0WNA0ZB	Cover Fuel Lid Honda ADV 160	Cover Body	14000.0
64421K2FN00YA	Cover Bawah Kanan Oranye Honda Scoopy K2F	Cover Body	152500.0
83510K0WNA0MPC	Cover Body Kanan Putih Doff Honda ADV 160	Cover Body	165000.0
83510K0WNA0MSR	Cover Body Kanan Merah Doff Honda ADV 160	Cover Body	170000.0
64501K0WNA0ZH	Cover Body Samping Kanan Depan Hitam Honda ADV 160	Cover Body	195000.0
64320K41N00	Cover Body Tengah Honda Supra X 125 FI	Cover Body	66000.0
83500K2FN00FMB	Cover Body Kanan Hitam Metalic Honda Scoopy K2F	Cover Body	355500.0
83121K45NL0ZA	Cover Belakang Kiri Merah CBR 150R K45R	Cover Body	416500.0
80105K59A10	Tahanan Lumpur Honda Vario 150 eSP K59	Cover Body	8000.0
53205K1AN00ZP	Cover Batok Kepala Depan Brown Honda BeAT K1A	Cover Body	86500.0
81260K2SN00	Cover Tempat Aki Honda Vario 160 K2S	Cover Body	91500.0
83600K59A70YA	Cover Body Kiri Merah Metalic Honda Vario 125 eSP K60R	Cover Body	355500.0
61302K15710ZA	Cover Depan Samping Kanan Hitam Doff Honda CB150R StreetFire K15P	Cover Body	112000.0
53208K2SN10ZH	Cover Batok Kanan Putih Honda Vario 160 K2S	Cover Body	91500.0
61100K84900ZF	Spakbor Depan Hijau Honda CRF150L K84	Cover Body	183000.0
61100K1ZN20MSR	Spakbor Depan Merah Doff Honda PCX 160 K1Z	Cover Body	280000.0
61100K64N00ZT	Spakbor Depan Dark Silver Honda CB150R StreetFire K15P	Cover Body	260000.0
61303K15710ZB	Cover Depan Samping Kiri Hitam Honda CB150R StreetFire K15P	Cover Body	106000.0
53205K1ZJ10	Cover Stang Depan Honda PCX 160 K1Z	Cover Body	51000.0
53206K2FN00ZU	Cover Bawah Spidometer Grey Honda Scoopy K2F	Cover Body	124000.0
83160K64NA0ZA	Cover Tangki Kanan Hitam Type 2 Honda CBR 250RR K64	Cover Body	441000.0
64333K2SN00	Guide Harness Honda Vario 160 K2S	Cover Body	20500.0
84151K1ZJ10ZP	Cover Behel Biru Doff Honda PCX 160 K1Z	Cover Body	319500.0
84151K1ZJ10ZQ	Cover Behel Hitam Doff Honda PCX 160 K1Z	Cover Body	324500.0
83600K2SN00MPC	Cover Body Kiri Putih Doff Honda Vario 160 K2S	Cover Body	520000.0
83750K2SN00ZA	Cover RR Center Hitam Honda Vario 160 K2S	Cover Body	94000.0
53206K2FN00ZK	Cover Bawah Speedometer Hitam Doff Honda Scoopy K2F	Cover Body	71500.0
53206K2FN00ZN	Cover Bawah Speedometer Silver Honda Scoopy K2F	Cover Body	71500.0
53290K59A70ZA	Cover Batok Depan Honda Vario 150 eSP K59J	Cover Body	88500.0
61100K0WN00PFW	Spakbor Depan Putih Mutiara Honda ADV 150	Cover Body	193000.0
64501K0WN01ZB	Cover Depan Kanan Merah Honda ADV 150	Cover Body	325000.0
64171K3BN00	Cover Tanki Kiri Honda CB 150X	Cover Body	51000.0
64431K97T00YY	Cover Right Floor Side Hitam Doff Honda PCX 150 K97	Cover Body	345500.0
64421K2FN00ZP	Cover Under Right Side Hitam Honda Scoopy K2F	Cover Body	152500.0
64321K3BN00MGB	Cowl B Right Middle Hitam Doff Honda CB150X	Cover Body	370000.0
64321K3BN00MSG	Cowl B Right Middle Hijau Honda CB150X	Cover Body	440000.0
64441K3BN00ZA	Cowl left Under Silver Honda CB150X	Cover Body	244000.0
64331K45NL0	Cover Body Kanan Honda CBR 150R K45R	Cover Body	117000.0
64400K45A40ZA	Cover Body Kiri Hitam Doff Honda CBR 150R K45R	Cover Body	863000.0
83510K1ZJ10MSR	Cover Body Kanan Merah Doff Honda PCX 160 K1Z	Cover Body	396000.0
81141K1ZJ10ZS	Lid Inner Pocket Putih Honda PCX 160 K1Z	Cover Body	141000.0
67110K3BN00ZA	Set Illust Wind Screen Type 1 Honda CB150X	Cover Body	289500.0
64601K59A70YB	Cover Kiri Depan Merah Honda Vario 150 eSP K59J	Cover Body	254000.0
83510K1ZJ10MDG	Cover Body Kanan Grey Honda PCX 160 K1Z	Cover Body	533000.0
11341K97N00	Cover CVT Honda PCX 150 K97	Cover Body	383500.0
53205K2FN00VBE	Cover Speedometer Cream Honda Scoopy K2F	Cover Body	127000.0
64305K1ZJ10ZR	Garnish FR Hitam Doff PCX 160 K1Z	Cover Body	230500.0
64201K0JN00MJB	Cover Depan Kanan Coklat Doff Honda Genio	Cover Body	129000.0
50410K2FN00ZC	Behel (Rail Rear Grab Grey) Honda Scoopy K2F	Cover Body	227000.0
86103K60B90ZB	Mark Honda 110MM TYPE 2 - Vario 125 eSP K60R	Cover Body, Sticker Body	12500.0
53207K2FN00VRD	Cover Ring Speedometer Merah Honda Scoopy K2F	Cover Body	59000.0
61100K2FN00ZM	Spakbor Depan Merah Honda Scoopy K2F	Cover Body	218500.0
64301K56N10ZR	Cover Tameng depan Cover Fr Top,(VL RD) - Supra GTR K56F	Cover Body	369000.0
81130K2FN00ZN	Lid Assy Pocket Silver Honda Scoopy K2F	Cover Body	96500.0
64321K45NL0	Cover Kanan (Cowl R Side) - Honda CBR 150R K45R	Cover Body	54000.0
61100K59A70ZJ	Spakbor Depan Putih Mutiara Honda Vario 150 eSP K59J	Cover Body	295500.0
83750K2FN00ZN	Cover Belakang Tengah (Cover Rear Center MA BL MT) - Honda Scoopy eSP K2F	Cover Body	91500.0
83750K2FN00ZK	Cover Belakang Tengah Coklat (Cover Rear Center MA JB MT) - Honda Scoopy eSP K2F	Cover Body	162500.0
64211K45NL0ZD	Cover Tameng Depan Hitam Doff Honda CBR 150R K45R	Cover Body	523000.0
83750K2FN00ZM	Cover Belakang Merah Doff (Cover Rear Center MT SO RED) - Honda Scoopy eSP K2F	Cover Body	157500.0
64501K0WN01ZA	Cover Kanan Depan (SIDE MT ME BR) - Honda ADV 150	Cover Body	233500.0
80160K25900	Cover Seat Lock - Honda BeAT FI, BeAT FI CBS	Cover Body	3000.0
64211K45NA0ZA	Cover Tameng Depan Orange Honda New CBR 150R K45N	Cover Body	653000.0
64502K0WN01ZE	Cover Body Left Front Side Rose White Honda ADV 150	Cover Body	279500.0
37212K46N01	Cover Bawah Speedometer Honda Vario 110 FI	Cover Body	43000.0
17546K84960ZA	Cover Body Kanan Hitam Type 1 Honda CRF 150L K84	Cover Body	173000.0
61100K59A70ZE	Spakbor Depan Merah Honda Vario 125 eSP K60	Cover Body	239000.0
81138K97T00YE	Outer,Right Inner Cover Silver PCX 150 K97	Cover Body	218000.0
80105K0JN00ZA	Spakbor Belakang Honda Genio	Cover Body	123000.0
64331K0JN00	Spacer,Battery - BeAT K1A & Genio	Cover Body	8000.0
77251K56N10	Cover, Seat Lock Key - Supra GTR 150	Cover Body	12500.0
81137K97T00YE	Lid,Smart Emg Silver- PCX 150 K97	Cover Body	204500.0
83510K97T00YJ	Cover Body Kanan (Cover,R Body) Silver- PCX 150 K97	Cover Body	368000.0
83610K97T00YJ	Cover Body Kiri (Cover,L Body) Silver- PCX 150 K97	Cover Body	368000.0
83610K97T00YH	Cover Body Kiri (Cover,L Body) Coklat Doff - PCX 150 K97	Cover Body	420000.0
37102K0WN01	Cover Speedometer Honda ADV 150	Cover Body, Speedometer	76500.0
64460K0JN00ZA	Lid,Battery (CA BR) Coklat - Genio	Cover Body	36000.0
53206K93N00ZS	Cover B, Spidometer Hitam Doff - Scoopy eSP K93	Cover Body	93500.0
17225K0JN00	Case Sub Assy,Air/C - BeAT K1A & Genio	Cover Body, Saringan Udara (Filter)	55000.0
64405K56H20ZB	Cowl Set L Side Lower WL Type 1 - Sonic 150R	Cover Body	165000.0
83610K0WN00MMB	Cover L Body Coklat Metalic - ADV 150	Cover Body	178000.0
83510K0WN00FMB	Cover R Body Hitam - ADV 150	Cover Body	233500.0
83510K0WN00DSM	Cover R Body Silver Metalic - ADV 150	Cover Body	325000.0
83750K0JN00MGB	Cover Belakang Tengah Hitam Doff - Honda Genio	Cover Body	115000.0
64421K0JN00ZG	Cover Kanan Bawah Hitam Metalic - Honda Genio	Cover Body	152500.0
64421K0JN00ZA	Cover Kanan (Cover Right Under Side) Coklat Metalic - Honda Genio	Cover Body	152500.0
83500K0JN00MGB	Cover Body Kanan (Cover Right Body) Hitam Doff - Honda Genio	Cover Body	452000.0
64431K0JN00ZE	Cover Kiri Bawah (Left Under Side) Hitam - Honda Genio	Cover Body	162500.0
64202K93N00ZX	Cover Depan Kiri Merah Honda Scoopy eSP (K93)	Cover Body	170000.0
61100K0WN00WRD	Spakbor Depan Merah Honda ADV 150	Cover Body	228500.0
64201K0JN00ZA	Cover Kanan Depan Coklat Metalic Honda Genio	Cover Body	152500.0
64301K93N00ZY	Cover FR Top VA RD - Scoopy eSP (K93)	Cover Body	320000.0
64301K0JN00PBL	Cover Tameng Depan (Front Top) Hitam Metalik - Honda Genio	Cover Body	469000.0
53205K0JN00ZE	Cover Speedometer Depan Hitam Honda Genio	Cover Body	122000.0
64350K0WN00ZB	Cover R Center Side RO WH - Honda ADV 150	Cover Body	173000.0
64310K0JN00ZB	Step Floor Black - Honda Genio	Cover Body	71500.0
64410K45NH0ZA	Cover Body Kiri (Set Illust L Middle Cowl A Type 2 Doft) - New CBR 150R K45G K45N	Cover Body	249000.0
83130K45NH0ZB	Set Illust RR Center Cowl Type 2 Merah - New CBR 150R K45G K45N	Cover Body	130000.0
61305K56NG0ZA	Garnis Kanan Merah Honda Sonic 150R K56	Cover Body	90000.0
83110K45N50ZA	Body Belakang Kanan (Cowl Set R RR WL) - CBR 150R K45N	Cover Body	298500.0
64350K59A70ZL	Cover R Under Side (Ma Jb Mt/Brown) - Vario 150 eSP K59J	Cover Body	254000.0
80106KZR600	Spakbor Dalam (Fender Rear Inner Assy) - Vario 125 FI	Cover Body	31000.0
61100K56N10ZR	Spakbor Depan A Merah Honda Supra GTR 150	Cover Body	299500.0
64210K64N00ZK	Cover Tameng Depan Hitam Honda CBR 250RR K64	Cover Body	894500.0
64490K56N10ZJ	Body Kiri (Cover L Body RR) Mt Gn Me - Supra GTR 150	Cover Body	130000.0
64480K56N10ZJ	Body Kanan (Cover R Body RR) Mt Gn Me - Supra GTR 150	Cover Body	130000.0
64320K15600RSW	Cowl Under Center White - CB150R StreetFire K15M	Cover Body	138500.0
64310K64N00ZA	Cowl R Under (AF BL MT) - CBR 250RR K64	Cover Body	533000.0
50270K18960INS	Cover Body Depan Kiri Silver Honda CB 150 Verza	Cover Body	117000.0
50270K18960PFR	Cover Body Depan Kiri Merah (Pearl Fire Brick) Honda CB 150 Verza	Cover Body	125000.0
80120K18900	Fender B Rear - Honda CB 150 Verza	Cover Body	81500.0
83450K64K00RED	Single Seat Cowl Red Matte (Merah Doff) - CBR 250RR K64	Cover Body	710500.0
83600K46N00VBM	Cover Body Kiri (Cover Left Body) Biru - Vario 110 FI	Cover Body	293500.0
64301K46N00VBM	Cover Depan (Cover Front Top) Biru- Vario 110 FI	Cover Body	203500.0
61100K46N00ZE	Spakbor Depan Biru Honda Vario 110 FI	Cover Body	199000.0
83500K46N00MAG	Cover Body Kanan Abu Abu - Vario 110 eSP	Cover Body	286500.0
83750K46N00ZF	Cover Rear Center Merah - Vario 110 eSP	Cover Body	81500.0
83600K46N00VRD	Cover Body Kiri Merah - vario 110 eSP	Cover Body	218500.0
64501K46N00ARM	Cover Kanan Depan Merah Maroon - Vario 110 eSP	Cover Body	178000.0
83751K46N00ZG	Cover Rear Center Lower Grey - Vario 110 eSP	Cover Body	93500.0
83600K46N00MAG	Cover Body Kiri Abu Abu - Vario 110 eSP	Cover Body	286500.0
64601K46N00MAG	Cover Depan Kiri Abu Abu - Vario 110 eSP	Cover Body	152500.0
64301K46N00RSW	Cover Tameng Depan Putih Mutiara - Vario 110 eSP	Cover Body	208500.0
83600K25900PCB	Cover Kiri (Cover Left Body (PL CT BL) - BeAT FICBS (K25)	Cover Body	222500.0
64501K59A70ZQ	Cover R Fr RS White - New Vario 125 eSP (K60R)	Cover Body	300500.0
81131K59A70ZS	Cover Rack Silver - Vario 150 New (K59J)	Cover Body	205500.0
64350K59A70ZD	Cover Body Samping Bawah Kanan Merah Doff New Vario 150 K59J	Cover Body	591000.0
53208K59A70ZM	Cover Batok Atas Putih Honda New Vario 150 K59J	Cover Body	157500.0
53208K59A70ZK	Cover Batok Atas Merah Honda New Vario 150 K59J	Cover Body	168000.0
83500K93N00ZP	Cover Body Kanan Merah - Scoopy eSP K93	Cover Body	407500.0
17556K84901ZB	Cover Body Set Kiri Merah (WL) - CRF 150L	Cover Body	213500.0
81139K97T00ZW	Outer Inner Kiri Gold - PCX 150 K97	Cover Body	323000.0
64503K97T00ZW	Cover Front Center Gold - PCX 150 K97	Cover Body	270000.0
64601K59A10FMB	Cover Kiri Depan Hitam - Vario 125 eSP & Vario 150 eSP	Cover Body	225500.0
83610K97T00YA	Cover Body Kiri Putih - PCX 150 K97	Cover Body	427000.0
77237K35V00	Cover Seat Catch - PCX 150 K97	Cover Body, Jok	62000.0
83650K93N00ZP	Cover Rear Center Lower Coklat Doff - Scoopy eSP (K93)	Cover Body	139500.0
53207K97T00ZA	Cover Stang Honda PCX 150 K97	Cover Body	191000.0
83500K61900RSW	Cover Body Kanan Putih - BeAT POP eSP	Cover Body	205500.0
64301K61900RSW	Cover Front Tameng Depan Putih - BeAT POP eSP	Cover Body	377000.0
61100K61900ZD	Spakbor Depan Biru Honda BeAT POP eSP	Cover Body	145500.0
53205K61900RSW	Cover Batok Depan Putih Honda BeAT POP eSP	Cover Body	121000.0
83600K61900RSW	Cover Body Kiri Putih - BeAT POP eSP	Cover Body	233500.0
53206KYZ900ZJ	Cover Batok Belakang Honda Supra X 125 Helm In	Cover Body	197000.0
61100K15900ZB	Fender FR Putih - CB150R StreetFire (Old)	Cover Body	161500.0
83450K15900ZA	Cowl RR Center Putih - CB150R StreetFire (Old)	Cover Body	44000.0
81131K59A10ZM	Cover Rack Merah - Vario 150 eSP	Cover Body	180000.0
53205KPH730FMB	Cover Handle FR Hitam - Kharisma	Cover Body	113000.0
64301KVB930SBM	Cover FR (Cover Body Depan) Biru - Vario Karbu	Cover Body	356500.0
50400K03N30	Behel (RR Grab Rail) - Revo 110 FI	Cover Body	175500.0
6430AKVB900	Cover Set R Floor SD Hitam - Vario Karbu	Cover Body	40500.0
64520K41N00	Garnish Kanan Depan - Supra X 125 FI	Cover Body	5500.0
83600K59A10ZW	Cover L Body Merah - Vario 150 eSP	Cover Body	520000.0
61100K61900ZC	Spakbor Depan Hitam Honda BeAT POP eSP	Cover Body	133000.0
83600K59A10RSW	Cover Body Kiri Putih - Vario 125 eSP & Vario 150 eSP	Cover Body	520000.0
53207K56N10ZM	Cover Batok Kanan Depan Merah Supra GTR	Cover Body	112000.0
53208K56N10ZL	Cover Batok Kiri Merah Honda Supra GTR 150	Cover Body	112000.0
83510K56N10FMB	Cover Tail Hitam Metalik - Supra GTR	Cover Body	517000.0
83600K59A10ZV	Cover Body Kiri Biru - Vario 125 eSP & Vario 150 eSP	Cover Body	382000.0
64431K93N00ZM	Cover Bawah Samping Kiri Biru - Scoopy eSP K93	Cover Body	138500.0
64202K93N00ZM	Cover Depan Kiri Biru Honda Scoopy eSP K93	Cover Body	162500.0
83750K93N00ZG	Cover Rear Center Red - Scoopy eSP K93	Cover Body	122000.0
80151K93N00ZL	Cover Center Silver - Scoopy eSP K93	Cover Body	396000.0
83750K93N00ZH	Cover Belakang Tengah Putih - Scoopy eSP K93	Cover Body	104000.0
77244K16A00	Cover Seat Catch - Scoopy eSP K93	Cover Body, Jok	4500.0
83620K56N00WRD	Cover L Body Merah - Sonic 150R	Cover Body	142500.0
83165K64N00WRD	Cover R Tank (Merah) - CBR 250RR	Cover Body	576000.0
83620K56N00MGB	Cover L Body Hitam Doff - Sonic 150R	Cover Body	149500.0
83610K56N00SMM	Cover R Body Magenta - Sonic 150R	Cover Body	202500.0
64420K56N00FMB	Cowl L Side Lower Hitam - Sonic 150R	Cover Body	137500.0
64610K56N10PFW	Cover R Side Putih - Supra GTR 150	Cover Body	548000.0
53207K56N10ZA	Cover Batok Kanan Merah Honda Supra GTR 150	Cover Body	91500.0
61100K15920ZE	Spakbor Depan Putih Honda New CB150R	Cover Body	302000.0
18355KCJ660	Cover Knalpot Tiger	Cover Body	135500.0
64336K0WN00ZV	Cover Atas Depan Coklat Honda ADV 160	Cover Body	140000.0
83610K1ZJ10MCO	Cover Body Kiri Silver Honda PCX 160 K1Z	Cover Body	440000.0
64501K1ZJ10ZC	Cover Depan Kanan Silver Honda PCX 160 K1Z	Cover Body	485000.0
64501K0WNA0ZJ	Cover Depan Kanan Coklat Honda ADV 160	Cover Body	233500.0
64302KZLA00VBM	Cover Tameng Depan Biru Honda Spacy Karburator	Cover Body	197000.0
53206KEV880ZA	Cover Batok Belakang Honda Supra	Cover Body	44500.0
81141K0JN60ZB	Cover Inner Hitam Honda Genio K0JN	Cover Body	61000.0
83540KYT940	Guard Dust Kanan Hitam Honda Scoopy Karburator KYT	Cover Body	5000.0
81142K0JN60ZA	Lid Inner Pocket Coklat Honda Genio K0JN	Cover Body	10500.0
64420K41N00ZC	Cover Body Kiri Hitam Honda Supra X 125 FI	Cover Body	233000.0
83711KCJ660	Cover Kiri Carburetor Honda Tiger Revolution	Cover Body	113000.0
83520KVB900	Cover Body Samping Kanan Honda Vario 110 CW	Cover Body	39500.0
81141K16A40RSW	Cover Inner Putih Honda Scoopy eSP K16R	Cover Body	572000.0
64320KPH700	Cover Body Tengah Honda Supra X 125 Injection	Cover Body	50500.0
81250KVB930	Box Bagasi Honda Vario 110 CW	Cover Body	53500.0
64421K0JN00ZM	Cover Body Samping Bawah Kanan Biru Doff Honda Genio K0JN	Cover Body	122000.0
80110KYE900	Spakbor Belakang Honda Mega Pro	Cover Body	107000.0
64501K1ZJ10YH	Cover Kanan Depan Merah Maron Honda PCX 160 K1Z	Cover Body	560000.0
64475K03N50ZA	Cover Depan Kiri Bawah Honda Revo 110 FI	Cover Body	16000.0
64202K0JN00ZM	Cover Depan Kiri Biru Doff Honda Genio K0JN	Cover Body	117000.0
61100K0JN60MIB	Spakbor Depan Biru doff Honda Genio K0JN	Cover Body	187000.0
40510KWWC00	Tutup Rantai Honda Supra X 125 FI	Cover Body	20500.0
83160K45A50ZA	Cover Set Tangki Kanan Hitam Doff Type 1 Honda CBR 150R K45R	Cover Body	305000.0
53206KZR600ZK	Cover Batok Belakang Hitam Honda Vario 125 FI	Cover Body	114000.0
61100K1AN00MSG	Spakbor Depan Hijau Doff Honda BeAT K1A	Cover Body	140000.0
61100K1AN00MBS	Spakbor Depan Dark Silver Honda BeAT K1A	Cover Body	140000.0
64320K64NP0ZD	Cover Bawah Kiri Merah Honda CBR 250RR K64N	Cover Body	607500.0
83620K64NP0ZD	Cover Kanan Belakang Merah Honda CBR 250RR K64J	Cover Body	380000.0
83511K64NP0	Cover Samping Kanan Honda CBR 250RR K64J	Cover Body	41000.0
83510K1ZJ10MZB	Cover Body Kanan Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	470000.0
64440K64NP0ZA	Cover Depan Samping Kiri Merah Honda CBR 250RR K64J	Cover Body	240000.0
64431K1ZJ10YN	Cover Body Bawah Kanan Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	455000.0
64340K64NP0ZB	Cover Depan Samping Kanan Hitam Honda CBR 250RR K64J	Cover Body	630000.0
64340K64NP0ZA	Cover Depan Samping Kanan Merah Honda CBR 250RR K64J	Cover Body	240000.0
64431K0JN00ZM	Cover Bawah Kiri Biru Doff Honda Scoopy K2F	Cover Body	122000.0
11341K1ZN40	Cover CVT Honda PCX 160 K1Z	Cover Body	570000.0
83750K59A70ZW	Cover Belakang Tengah Merah Honda Vario 125 eSP K2V	Cover Body	100000.0
83600K2VN30MPC	Cover Body Kiri Putih Doff Honda Vario 125 eSP K2V	Cover Body	250000.0
83600K2VN30MGB	Cover Body Kiri Hitam Doff Honda Vario 125 eSP K2V	Cover Body	250000.0
83500K2VN30MPC	Cover Body Kanan Putih Doff Honda Vario 125 eSP K2V	Cover Body	250000.0
83500K2VN30MIB	Cover Body Kanan Biru Doff Honda Vario 125 eSP K2V	Cover Body	220000.0
64601K2VN30MGB	Cover Depan Kiri Hitam Doff Honda Vario 125 eSP K2V	Cover Body	160000.0
64460K61900ZA	Cover Tutup Aki Honda BeAT POP eSP K61	Cover Body	122000.0
64411K45NL0ZC	Cover Body Kiri Hitam Doff Honda CBR 150R K45R	Cover Body	863000.0
53208K2VN30MGB	Cover Batok Atas Hitam Doff Honda Vario 125 eSP K2V	Cover Body	98000.0
5038AK03N30	Cover Tutup Battery Honda Revo 110 FI	Cover Body	18500.0
64460K2FN80ZA	Cover Tutup Battery Coklat Scoopy K2F	Cover Body	37000.0
61100K2FN00YJ	Spakbor Depan Silver Honda Scoopy K2F	Cover Body	225000.0
81255K2VN30	Cover Battery Honda Vario 125 eSP K2V	Cover Body	28000.0
81142K2FN80ZJ	Cover Kantong Kiri Biru Doff Honda Scoopy K2F	Cover Body	60000.0
81141K2FN80ZE	Cover Inner Hitam Doff Honda Scoopy K2F	Cover Body	360000.0
8016AK47N00	Cover Key Seat Assy Honda Blade 125 FI K47	Cover Body	12500.0
17546K84620ZB	Cover Body Set Kanan Putih Type 1 Honda CRF150L K84	Cover Body	165500.0
83675K64NA0ZA	Cover Set Bawah Belakang Kanan Type 2 Honda CBR 250RR K64	Cover Body	25500.0
83720K3BN00ZB	Cover Body Set Belakang Kiri Hitam Type 1 Honda CB150X	Cover Body	274500.0
83160K3BN00ZC	Cover Set Tangki Kanan Merah Type 1 Honda CB150X	Cover Body	376000.0
53207K2FN00MSR	Cover Ring Speedometer Merah Doff Honda Scoopy K2F	Cover Body	84500.0
77340K0WNA0ZA	Grip Rear Kiri Honda ADV 160	Cover Body	244000.0
53209K2SN10ZJ	Cover Batok Kiri Hitam Honda Vario 160 K2S	Cover Body	93500.0
64501K0WNA0ZE	Cover Depan Kanan Merah Honda ADV 160	Cover Body	235000.0
83510K0WNA0ARE	Cover Body Kanan Merah Honda ADV 160	Cover Body	213500.0
64410K0WNA0ZB	Cover Center Hitam Honda ADV 160	Cover Body	37000.0
64336K0WN00YA	Cover Front Upper Hitam Honda ADV 160	Cover Body	156500.0
83600K2FN00ZX	Cover Body Kiri Hitam Doff Honda Scoopy K2F	Cover Body	302000.0
83600K0WNA0	Cover Right Body Side Honda ADV 160	Cover Body	37000.0
64501K0WNA0ZL	Cover Body Samping Kanan Depan Putih Doff Honda ADV 160	Cover Body	230000.0
8011AK25600	Cover Battery Assy Honda BeAT Sporty eSP K25G	Cover Body	17500.0
84100K41N00ZA	Behel Belakang Hitam Honda Supra X 125 FI New	Cover Body	176000.0
53250K81N30ZA	Cover Stang Honda BeAT Sporty eSP K81	Cover Body	72500.0
50285K15710	Cover Body Depan Bawah Kiri Honda CB150R StreetFire K15P	Cover Body	67000.0
80151K0JN00ZC	Cover Center Hitam Honda Genio	Cover Body	38000.0
61100K64N00ZV	Spakbor Depan Merah Honda CBR 150R K45R	Cover Body	310000.0
83750K2FN00ZV	Cover Rear Center Hitam Doff Honda Scoopy K2F	Cover Body	102000.0
83161K45NL0ZD	Cover Tangki Kanan Hitam Doff CBR 150R K45R	Cover Body	305000.0
80151K2FN00YC	Cover Center Brown Honda Scoopy K2F	Cover Body	305000.0
11346KVB900	Cover Dudukan Reflektor lampu depan bagian kiri Honda Vario 110 CW	Cover Body	6500.0
83131K45NL0ZE	Cover Belakang Hitam Metalic Honda CBR 150R K45R	Cover Body	122000.0
83131K45NL0ZC	Cover Belakang Hitam Honda CBR 150R K45R	Cover Body	157500.0
53206K2FN00ZM	Cover Bawah Speedometer Silver Doff Honda Scoopy eSP K2F	Cover Body	76500.0
61110K59A80ZF	Spakbor Depan Hitam Doff Honda Vario 150 eSP K59J	Cover Body	294500.0
64200K64NC0ZA	Cover Tameng Depan Merah Honda CBR 250RR K64	Cover Body	802000.0
64301K2FN00YA	Cover Tameng Depan Hitam Doff Honda Scoopy K2F	Cover Body	239000.0
83610K84960ZA	Cover Samping Kiri Hitam Type 1 Honda CRF150L K84	Cover Body	142500.0
81255K2SN00	Cover Comp Battery Honda Vario 160 K2S	Cover Body	36000.0
77210KSPB00	Cowl Rear Right Hitam Honda Mega Pro	Cover Body	25500.0
83610K1ZJ10MIB	Cover Body Kiri Biru Doff Honda PCX 160 K1Z	Cover Body	376000.0
83600K2SN00MSR	Cover Body Kiri Merah Doff Honda Vario 160 K2S	Cover Body	616500.0
53208K2SN00ZG	Cover Batok Kanan Hitam Honda Vario 160 K2S	Cover Body	93500.0
53208K2SN10ZB	Cover Batok Kanan Hitam Doff Honda Vario 160 K2S	Cover Body	75500.0
64301K59A70YK	Cover Front Putih Honda Vario 125 eSP K60R	Cover Body	183000.0
64231K3BN00	Cover Front Upper Hitam Honda CB150X	Cover Body	43000.0
64202K0JN00ZL	Cover Depan Kiri Silver Honda Genio	Cover Body	107000.0
64311K2FN00	Cover Right P Step Hitam Honda Scoopy K2F	Cover Body	10500.0
64161K3BN00	Cover Tangki Kanan Honda CB 150X	Cover Body	51000.0
64411K3BN00MCS	Cowl A Left Middle Silver Honda CB150X	Cover Body	200000.0
64421K3BN00MGB	Cowl B Left Middle Hitam Doff Honda CB150X	Cover Body	370000.0
64421K3BN00MSG	Cowl B Left Middle Hijau Honda CB150X	Cover Body	440000.0
64221K3BN00	Cowl Front Center Honda CB150X	Cover Body	28500.0
64305K1ZJ10ZN	Garnish Front Hitam Metalic Honda PCX 160 K1Z	Cover Body	228500.0
64100K0WN20ZA	Wind Screen Honda ADV 150	Cover Body	249000.0
83550K1ZN30ZF	Cover Body Kanan Hitam Metalic Honda PCX 160 K1Z	Cover Body	386000.0
83520K64N00ZA	Set Illust Left Side Honda CBR 250RR K64J	Cover Body	56000.0
83171K45NL0ZD	Cover Tangki Kiri Hitam Doff CBR 150R K45R	Cover Body	305000.0
81141K2FN00ZH	Cover Inner Silver Honda Scoopy K2F	Cover Body	305000.0
81133K1ZJ10	Cover Hinge Honda PCX 160 K1Z	Cover Body	14500.0
64501K2SN00ZL	Cover Depan Kanan putih Doff Honda Vario 160 K2S	Cover Body	254000.0
83550K1ZA00ZP	Cover Body Kanan Putih Mutiara Honda PCX 160 K1Z	Cover Body	401000.0
53208K59A70YJ	Cover Batok Atas Putih Doff Honda Vario 125 eSP K60R	Cover Body	91500.0
84152K1ZJ10ZS	Lid Grab Rail Cover Hitam Honda PCX 160 K1Z	Cover Body	121000.0
64530K1ZJ10	Cover Under Honda PCX 160 K1Z	Cover Body	46000.0
81137K1ZJ10ZJ	Lid Smart Emg Grey Honda PCX 160 K1Z	Cover Body	376000.0
81140K1ZJ10ZP	Outer R Inner Cover Kanan Merah Doff PCX 160 K1Z	Cover Body	299500.0
81141K1ZJ10ZN	Lid Inner Pocket Hitam Honda PCX 160 K1Z	Cover Body	134000.0
84152K1ZJ10ZQ	Lid Grab Rail Cover Hitam Doff PCX 160 K1Z	Cover Body	117000.0
83500K2FN00MIB	Cover, R Body (MA BL MT) - Scoopy K2F	Cover Body	264000.0
64460K2FN00ZB	Lid Battery MB (CA BR) - Honda Scoopy K2F	Cover Body	30500.0
61100K2FN00ZR	Spakbor Depan Hitam Metalik Honda Scoopy K2F	Cover Body	218500.0
64502K96V00ZS	Body Sayap Kiri (Cover Left Front Side GL GO ME) - PCX 150 K97	Cover Body	539000.0
64411K45N40ZC	Cover Kiri Putih Mutiara (Cowl A L Middle RO WH) - Honda New CBR 150R K45N	Cover Body	635500.0
64411K45NL0ZD	Cover Body Samping Kiri Hitam Honda CBR 150R K45R	Cover Body	863000.0
81142K2FN00ZK	Kantong Kiri Hitam Doff (Lid Left Pocket MT GN BL) - Honda Scoopy eSP K2F	Cover Body	86500.0
81142K2FN00ZL	Cover Kantong Kiri Hitam (Lid Left Pocket Black) - Honda Scoopy eSP K2F	Cover Body	132000.0
81142K2FN00ZN	Lid Left Pocket Silver MT CR SL - Honda Scoopy eSP K2F	Cover Body	81500.0
83161K45NL0ZC	Cover Kanan Tanki Merah (Cover Right Fuel Tank WN Red) - Honda CBR 150R K45R	Cover Body	482500.0
83111K45NL0ZD	Cover Belakang Kanan Putih (Cowl R Rear RO White) - Honda CBR 150R K45R	Cover Body	305000.0
83111K45NL0ZA	Cover Belakang Kanan Merah (Cowl Rear VA RD) - Honda CBR 150R K45R	Cover Body	416500.0
83750K2FN00ZP	Cover Belakang Hitam (Cover Rear Center Black) - Honda Scoopy eSP K2F	Cover Body	132000.0
83550K84900ZC	Cover Body Kanan B Grey - Honda CRF 150L	Cover Body	86500.0
64300K45NZ0ZA	Cover Body Kanan Merah (Set Illust R Middle Cowl A Type1) - CBR 150R K45R	Cover Body	883500.0
81142K2FN00ZJ	Lid L Pocket VI BE - Honda Scoopy eSP K2F	Cover Body	117000.0
83131K45N40ZE	Cover Body Cowl Rear Center (MT GN BL) - Honda New CBR 150R K45G	Cover Body	152500.0
64311K45NL0ZB	Cover Kanan Tengah Merah (WN Red) - Honda CBR 150R K45R	Cover Body	863000.0
64502K0WN01ZD	Cover Kiri Depan Hitam (Cover Left Front Side (Matt Gun Black) - Honda ADV 150	Cover Body	223500.0
53205K56N10	Cover Batok Depan Honda Supra GTR 150	Cover Body	40000.0
35108K64N00	Cover Cord Guide - Honda All New CBR 250RR, All New CBR 250RR SP	Cover Body	14500.0
8010AKYT940	Fender Rear Honda Scoopy	Cover Body	100500.0
64320KEV790	Body Tengah (Cover MP) - Honda Supra & Supra Fit	Cover Body	51500.0
81139K97T00YJ	Outer,Left Inner Cover Silver PCX 150 K97	Cover Body	218000.0
81141K97T00ZW	Lid Inner Pocket Silver Honda PCX 150 K97	Cover Body	213500.0
64431K97T00YJ	Cover,Right Floor Side Coklat Doff PCX 150 K97	Cover Body	387000.0
81133K0WN00	Cover,Hinger - ADV 150	Cover Body	10500.0
81138K97T00YD	Outer,R Inner Cover Coklat Doff - PCX 150 K97	Cover Body	274000.0
81137K97T00YD	Lid,Smart Emg Coklat Doff - PCX 150 K97	Cover Body	230000.0
84151K97T00YK	Cover Behel Silver Honda PCX 150 K97	Cover Body	298500.0
64503K97T00YJ	Cover,FR Center Silver - PCX 150 K97	Cover Body	208500.0
64503K97T00YH	Cover,FR Center Coklat Doff - PCX 150 K97	Cover Body	235000.0
83600K1AN00MCS	Cover Body Kiri Silver (Cover,Left Body) - BeAT K1A	Cover Body	114000.0
83500K1AN00MCS	Cover Body Kanan (Cover,R Body (MT CR SL)) Silver - BeAT K1A	Cover Body	114000.0
83500K1AN00FMB	Cover Body Kanan (Cover,Right Body (Black) Hitam - BeAT K1A	Cover Body	127000.0
53205K1AN00ZF	Cover Batok Kepala Depan Putih Mutiara Honda BeAT K1A	Cover Body	104000.0
83650K0WN10ZB	Set Illust,L Body Cover,Type 1 - ADV 150	Cover Body	239000.0
64405KYZ900	Louver R - Supra X 125 Helm In	Cover Body	54000.0
19610K0JN00	Cover Comp,Cooling Fan - Genio & BeAT K1A	Cover Body, Saringan Udara (Filter)	26500.0
19642K44V00	Cap L Cover - BeAT eSP New (K81), Scoopy eSP (K93)	Cover Body	6500.0
64305K56H20ZB	Cowl Set R Side Lower WL Type 1 - Sonic 150R	Cover Body	143500.0
64210K45NC0ZA	Cover Tameng Depan Repsol Honda New CBR 150R K45N	Cover Body	508000.0
83600K0JN00VRD	Cover Body Kiri (Cover Left Body) Merah - Honda Genio	Cover Body	472500.0
83510K0WN00ARE	Cover R Body Merah Metalic - ADV 150	Cover Body	213500.0
83510K0WN00MMB	Cover R Body Coklat Metalic - ADV 150	Cover Body	178000.0
64421K93N00ZY	Cover Under R Side Merah - Scoopy eSP (K93)	Cover Body	157500.0
64431K93N00ZY	Cover Under L Side Merah - Scoopy eSP (K93)	Cover Body	157500.0
64201K0JN00ZF	Cover Depan Kanan Silver Metalic Honda Genio	Cover Body	183000.0
83500K0JN00FMB	Cover Kanan (Cover Right Body) Hitam - Honda Genio	Cover Body	503000.0
64431K0JN00ZD	Cover Kiri Bawah (Cover Left Under Side) Putih Mutiara - Honda Genio	Cover Body	152500.0
64202K0JN00ZF	Cover Depan Kiri Silver Metalic Honda Genio	Cover Body	183000.0
64502K0WN00ZF	Cover L FR Side Silver - ADV 150	Cover Body	406500.0
81134K0JN00ZB	Cover Inner Upper Merah - Genio	Cover Body	76500.0
83110K45NZ0ZA	Cover Kanan (Set Illus Right Rear Cowl Type1) - Honda CBR 150R K45R	Cover Body	335000.0
64201K0JN00ZD	Cover Depan Kanan Putih Mutiara Honda Genio	Cover Body	152500.0
53206K0JN00MGB	Cover Belakang Speedometer Hitam Doff Honda Genio	Cover Body	137500.0
53206K0JN00MBM	Cover Belakang Speedometer Coklat Metalic Honda Genio	Cover Body	142500.0
53205K0JN00ZG	Cover Speedometer Depan Hitam Honda Genio	Cover Body	117000.0
83650K64N00ZH	Cover Seat Lock Black - New CBR 250RR K64	Cover Body	208500.0
64100K45NC0ZA	Wind Screen Honda CBR 150R K45N	Cover Body	122000.0
83120K45N40ZA	Cowl Set L RR WL B/Y Type 2 - CBR 150R K45G K45N	Cover Body	288500.0
64310K45N50ZA	Body Kanan (Cowl Set R Middle A WL) - CBR 150R K45N	Cover Body	697500.0
83600K59A70YB	Body Kiri Belakang (Cover L Body Ma Bl Mt) - New Vario 150 eSP K59J	Cover Body	355500.0
64350K59A70ZM	Cover Body Bawah Kanan (Cover R Under Side Ma Bl Mt) - New Vario 150 eSP K59J	Cover Body	254000.0
64360K59A70ZL	Cover L Under Side (Ma Jb Mt/Beown) - Vario 150 eSP K59J	Cover Body	254000.0
61100K59A70ZV	Spakbor Depan Coklat Doff Honda Vario 150 eSP K59J	Cover Body	233500.0
61100K56N10ZS	Spakbor Depan A Merah Doff Honda Supra GTR 150	Cover Body	305000.0
64210K64N00ZJ	Cover Tameng Depan Merah Doff Honda CBR 250RR K64	Cover Body	1103500.0
17556K84920ZB	Cover Body Set Kiri Merah Type 1 Honda CRF 150L K84	Cover Body	173000.0
64440K45N40ZA	Cowl Set L Under Type 3 Putih - CBR 150R K45N	Cover Body	361500.0
64320K64N00ZD	Cowl L Under ( AN GY MT) - CBR 250RR K64	Cover Body	584000.0
61100K64N00ZK	Spakbor Depan Merah Doff Honda CBR 250RR K64	Cover Body	366500.0
83620K64N00ZA	Cover R Rear Red - CBR 250RR K64	Cover Body	315000.0
83630K64N00ZA	Cowl L Rear Red - CBR 250RR K64	Cover Body	315000.0
83500K46N00VBM	Cover Body Kiri (Cover Right Body) Biru- Vario 110 FI	Cover Body	293500.0
64601K46N00VBM	Cover Body Kiri (Cover Left Front) Biru - Vario 110 FI	Cover Body	127000.0
64501K46N00VBM	Cover Body Kanan Biru - vario 110 FI	Cover Body	127000.0
83500K46N00VRD	Cover Body Kanan Red - Vario 110 eSP	Cover Body	218500.0
61100K15920ZF	Spakbor Depan Honda New CB150R StreetFire K15M	Cover Body	335000.0
64501K46N00VRD	Cover Kanan Depan Red - Vario 110 eSP	Cover Body	124000.0
64301K46N00ZK	Cover Tameng Depan Merah - Vario 110 eSP	Cover Body	285500.0
61100K46N00ZF	Spakbor Depan Merah Honda Vario 110 eSP	Cover Body	304000.0
53205K46N20FMB	Cover Batok Kepala Depan Hitam Honda Vario 110 eSP	Cover Body	156000.0
64601K59A70ZQ	Cover Depan Kiri Putih Glossy New Vario 125 eSP	Cover Body	300500.0
61100K25900ZH	Spakbor Depan Hijau Honda BeAT FI K25	Cover Body	126000.0
83500K59A70ZQ	Cover R Body (White) - New Vario 125 eSP (K60R)	Cover Body	581000.0
64350K59A70ZF	Cover R Under Side Silver - New Vario 150 eSP (K59J)	Cover Body	418500.0
64510KWN930ZE	Cover Body Kiri (Set Ilust Cover L) Glam Gold Metalic - PCX 125 CBU (KWN)	Cover Body	583000.0
64301K59A70ZM	Cover Front WN Red - New Vario 125 eSP (K60R)	Cover Body, Suku Cadang Resmi Motor Honda	315000.0
64301K25900AFB	Cover FR Hitam Metalik - BeAT FI, BeAT CBS FI (K25)	Cover Body	289500.0
83500K25600RSW	Cover Body Kanan (Cover Right Body) Putih Mutiara - BeAT Sporty eSP (K25)	Cover Body	209500.0
83600K25600RSW	Body Kiri (Cover Left body) Putih Mutiara - BeAT Sporty eSP (K25)	Cover Body	209500.0
64350K59A70ZE	Cover R Under Side White - New Vario 150 (K59J)	Cover Body	501500.0
83600K25900FMB	Cover Body Kiri Hitam (Cover Left Body Black)- BeAT FI (K25)	Cover Body	191000.0
83175K64N00ASB	Cover L Tank Hitam Metalik - CBR 250RR	Cover Body	546500.0
83620K64N00RSW	Cowl R Rear Putih - CBR 250RR	Cover Body	356500.0
61100K59A70ZG	Spakbor Depan Merah Honda Vario 150 K59J	Cover Body	327000.0
64320K15930ZC	Cowl Under Center Hitam - New CB150R Streetfire K15G	Cover Body	99500.0
83750K93N00ZM	Cover Rear Center Merah - Scoopy eSP K93	Cover Body	294500.0
64308KZR600ZB	Cover Lower Depan Hitam - Vario 125 FI	Cover Body	79500.0
84152K97T00ZW	Lid Grab Ril Cover Gold - PCX 150 K97	Cover Body	295000.0
64301K0JN00HSM	Cover Tameng Depan Silver - Genio	Cover Body	391000.0
64321K45N40ZE	Cowl B Middle Kanan Hitam - New CBR 150R K45G	Cover Body	568500.0
83500K93N00ZQ	Cover Body Kanan Putih - Scoopy eSP K93	Cover Body	391000.0
81141K97T00ZN	Lid Inner Pocket Putih - PCX 150 K97	Cover Body	221000.0
83510K97T00ZW	Cover Body Kanan Gold - PCX 150 K97	Cover Body	503000.0
84151K97T00ZX	Cover Behel Merah Honda PCX 150 K97	Cover Body	335000.0
84151K97T00ZW	Cover Behel Gold Honda PCX 150 K97	Cover Body	399000.0
64421K45N40ZE	Cowl B, L Middle Hitam - New CBR 150R K45G	Cover Body	568500.0
64511K45N40ZE	Cover, Fuel Tank Hitam Doff - New CBR 150R K45G & New CBR 150R K45N	Cover Body	230500.0
64301K61900WRD	Cover Tameng Depan (Cover Front) Merah - BeAT POP eSP	Cover Body	377000.0
64320K64N00RSW	Cowl L Under Putih - CBR 250RR	Cover Body	551500.0
83630K64N00RSW	Cowl L Rear Putih - CBR 250RR	Cover Body	355500.0
83165K64N00NOR	Cover R Tank Orange - CBR 250RR	Cover Body	570000.0
64400KVLN00FMB	Cover R M/P Hitam-R - Supra X 125	Cover Body	208500.0
64110K45N20ZA	Wind Screen Honda CBR150R K45A	Cover Body	118000.0
81142K93N00ZA	Lid L Pocket - Scoopy eSP (K93 New)	Cover Body	122500.0
8010AK03N30ZA	Spakbor Belakang (Fender RR Assy) - Revo FI	Cover Body	46500.0
83620KVB900	Cover L Body SD - Vario Karbu	Cover Body	39500.0
53205KTL880FMB	Cover Handle FR Hitam - Supra Fit	Cover Body	110000.0
53205K61900FMB	Cover Batok Depan Hitam Honda BeAT POP eSP	Cover Body	101000.0
64420KYZ900ZC	Cover Body Kiri Biru - Supra X 125 Helm In	Cover Body	281500.0
64421K16900FMB	Cover Under R SD - Scoopy FI	Cover Body	127000.0
77220K18900PFW	Cowl L SD Putih - Verza 150	Cover Body	172000.0
5061AKZLA00ZC	Cover Bawah Honda Spacy	Cover Body	48500.0
64400KYZ900ZE	Cover R M/P SD Hitam - Supra X 125 Helm In	Cover Body	375000.0
53205K25900PCB	Cover Batok Kepala Depan Hitam Honda BeAT FI & BeAT FI CBS	Cover Body	111000.0
83500K59A10ZW	Cover, R Body Merah - Vario 150 eSP	Cover Body	520000.0
61000K07900ZB	Spakbor Depan A Putih Honda Blade	Cover Body	228500.0
61100KVY720SBM	Spakbor Depan (Fender FR) Biru - BeAT Karburator	Cover Body	183000.0
83600K59A10YC	Cover Body Kiri Hitam Metalik - Vario 125 & 150 eSP	Cover Body	424500.0
61302K56N00ZC	Garnis Kanan Magenta Honda Sonic 150R	Cover Body	117000.0
61303K56N00ZC	Garnis Kiri Magenta Honda Sonic 150R	Cover Body	117000.0
64301K56N10ZM	Cover Front Top Merah - Supra GTR	Cover Body	423500.0
83510K56N10MIB	Cover Tail Biru - Supra GTR	Cover Body	412500.0
83500K59A10ZJ	Cover Body Kanan Hitam Doff - Vario 125 eSP & Vario 150 eSP	Cover Body	403500.0
81141K93N00ZN	Cover Inner Seat Biru - Scoopy eSP K93	Cover Body	381000.0
53206K93N00ZN	Cover B Speedometer Biru - Scoopy eSP K93	Cover Body	90500.0
83750K93N00ZJ	Cover RR Center Silver - Scoopy eSP K93	Cover Body	104000.0
64431K93N00ZJ	Cover Under L Side Silver - Scoopy eSP K93	Cover Body	142500.0
83750K93N00ZA	Cover Rear Center Cream - Scoopy eSP K93	Cover Body	104000.0
83500K93N00ZA	Cover Body Kanan Cream - Scoopy eSP K93	Cover Body	418500.0
81134K93N00ZK	Cover Inner Upper Cush Silver - Scoopy eSP K93	Cover Body	66000.0
64431K93N00ZL	Cover Under Left Side Hijau - Scoopy eSP K93	Cover Body	138500.0
64320K64N00AGM	Cowl Set L Under Grey - CBR 250RR	Cover Body	538500.0
64202K93N00ZL	Cover Depan Kiri Hijau Honda Scoopy eSP K93	Cover Body	162500.0
83510K56N10PFW	Cover Belakang Putih - Supra GTR 150	Cover Body	546500.0
83175K64N00WRD	Cover L Tank (Merah) - CBR 250RR	Cover Body	576000.0
64210K64N00WRD	Cover Tameng Depan Merah Honda CBR 250RR	Cover Body	814500.0
64501K59A10FMB	Cover Kanan Depan Hitam - Vario 125 eSP & Vario 150 eSP	Cover Body	225500.0
64480K56N10DSM	Cover R RR Body Silver - Supra GTR 150	Cover Body	206500.0
64620K56N10PFW	Cover L Side Putih (White) - Supra GTR 150	Cover Body	548000.0
64620K56N10CPR	Cover L Side Merah (Red) - Supra GTR 150	Cover Body	539500.0
64610K56N10CPR	Cover R Side Merah (Red) - Supra GTR 150	Cover Body	539500.0
53208K56N10ZA	Cover Batok Kiri Merah Honda Supra GTR 150	Cover Body	91500.0
64511K45N40FMB	Cover Fuel Tank Hitam - New CBR 150R K45G	Cover Body	147500.0
83111K45N40ROW	Cowl Right Rear Rose White - New CBR 150R K45G & New CBR 150R K45N	Cover Body	252000.0
83600K59A10WRD	Cover Left Body Merah (WRD) - Vario 125 eSP & Vario 150 eSP	Cover Body	321000.0
83600K59A10MGB	Cover Left Body Hitam Doff - Vario 125 eS & Vario 150 eSP	Cover Body	289500.0
83600K59A10AFB	Cover Left Body Hitam Metallic - Vario 125 eSP & Vario 150 eSP	Cover Body	302000.0
83751KVB930FMB	Cover Rear Center Lower Hitam (Black)	Cover Body	59000.0
53207KVLN01AGM	Cover Speedometer Grey - Supra X 125	Cover Body	50000.0
64333K3VN00	Guide Harness Honda Stylo 160	Cover Body	28000.0
81130K2SN00ZV	Lid Inner Pocket Biru Doff Honda Vario 160 K2S	Cover Body	100000.0
64432K1ZJ10YM	Cover Body Bawah Kiri Merah Maron Honda PCX 160 K1Z	Cover Body	455000.0
64340K64N00AA	Cover Depan Samping Kanan Hitam Sozai Honda CBR 250RR K64N	Cover Body	75000.0
64302K3VN00ASB	Cover Tameng Depan Hitam Metalic Honda Stylo 160	Cover Body	135000.0
64220K64NP0ZA	Cover Depan Bawah Type1 Honda CBR 250RR K64J	Cover Body	55000.0
61100K3VN00ZF	Spakbor Depan Hitam Metalic Honda Stylo 160	Cover Body	198000.0
83650K1ZN40ZE	Cover Body Kiri Merah Doff Type 5 Honda PCX 160 K1Z	Cover Body	410000.0
83550K1ZN40ZE	Cover Body Kanan Merah Doff Type 5 Honda PCX 160 K1Z	Cover Body	410000.0
64500K64NS0ZA	Cover Body Set Kanan Honda CBR 250RR K64N	Cover Body	66000.0
83610K0WNA0MFB	Cover Body Kiri Coklat Honda ADV 160	Cover Body	178000.0
64301K2VN30ZJ	Cover Tameng Depan Merah Honda Vario 125 eSP K2V	Cover Body	233500.0
84151K1ZJ10ZC	Cover Behel Silver Honda PCX 160 K1Z	Cover Body	340000.0
83510K0WNA0MDG	Cover Body Kanan Grey Honda ADV 160	Cover Body	178000.0
84152K1ZJ10ZC	Cover Tutup Behel Silver Honda PCX 160 K1Z	Cover Body	130000.0
84151K1ZJ10YH	Cover Behel Coklat Honda PCX 160 K1Z	Cover Body	340000.0
64502K0WNA0ZK	Cover Depan Kiri Grey Honda ADV 160	Cover Body	233500.0
64502K0WNA0ZE	Cover Depan Kiri Coklat Honda ADV 160	Cover Body	233500.0
6430BKVB900	Cover Bawah Set Kiri Honda Vario 110 CW	Cover Body	40500.0
64302KZLA00FMB	Cover Tameng Depan Hitam Honda Spacy Karburator	Cover Body	159500.0
61100K0WN000AA	Spakbor Depan Hitam Honda ADV 150	Cover Body	92000.0
61301KSPB00MTB	Cover Depan Hitam Honda Mega Pro	Cover Body	168000.0
61100K1AN00MJB	Spakbor Depan Brown Honda BeAT K1A	Cover Body	126000.0
61100K1AN00MIB	Spakbor Depan Biru Doff Honda BeAT K1A	Cover Body	121000.0
80100GF62A0	Spakbor Belakang Honda WIN	Cover Body	67500.0
6431AKZLC30ZC	Cover Pijakan Kaki Hitam Honda Spacy FI	Cover Body	72500.0
80151K16900YH	Cover Center Putih Honda Scoopy eSP K16R	Cover Body	296500.0
64410K41N00ZC	Cover Body Kanan Hitam Metalic Honda Supra X 125 FI	Cover Body	233000.0
64202K2FN00ZY	Cover Depan Kiri Oranye Honda Scoopy K2F	Cover Body	142500.0
83600KVB930PFW	Cover Body Kiri Putih Honda Vario 110 CW	Cover Body	209500.0
83600K16900VBM	Cover Body Kiri Biru Honda Scoopy FI K16G	Cover Body	339500.0
83500KVB930PFW	Cover Body Kanan Putih Honda Vario 110 CW	Cover Body	209500.0
83500K16900VBM	Cover Body Kanan Biru Honda Scoopy FI K16G	Cover Body	339500.0
54303K16900PMC	Cover Kiri Depan Cream Honda Scoopy FI K16G	Cover Body	290500.0
53205KYZ900ZD	Cover Batok Depan Hijau Honda Supra X 125 Helm-In FI	Cover Body	108000.0
64440K56N00SMM	Cover L Side Upper Magenta - Sonic 150R	Cover Body	329000.0
64440K64N00AA	Cover Depan Kiri Honda CBR 250RR K64N	Cover Body	75000.0
64370K64NP0	Cover Body Tengah Kanan Honda CBR 250RR K64N	Cover Body	110000.0
64370K41N00ZC	Cover Body Kanan Hitam Honda Supra X 125 FI	Cover Body	163500.0
83600K16900WRD	Cover Body Kiri Merah Honda Scoopy FI K16G	Cover Body	328000.0
83500K16900WRD	Cover Body Kanan Merah Honda Scoopy FI K16G	Cover Body	328000.0
83500K16900RSW	Cover Body Kanan Putih Honda Scoopy eSP K16R	Cover Body	313000.0
8125AKYZ900	Box Bagasi Honda Supra X 125 Helm-in Karburator	Cover Body	122000.0
8010BKCJ660	Spakbor Belakang Honda Tiger Revolution	Cover Body	103000.0
54302K16900VBM	Cover Kanan Depan Biru Honda Scoopy FI K16G	Cover Body	316000.0
50260K15900ZE	Cover Body Depan Kiri Merah Glossy Honda CB150R StreetFire K15	Cover Body	188000.0
6431BK16A40ZB	Step Floor Assy Honda Scoopy eSP K16R	Cover Body	117000.0
8114AKVBN50	Cover Assy Inner Lower Honda Vario 110 Techno	Cover Body	70000.0
8010AK16A00	Spakbor Belakang Honda Scoopy FI K16G	Cover Body	116000.0
83130K45A50ZB	Cover Set Belakang Tengah Merah Honda CBR 150R K45R	Cover Body	127000.0
81130K2FN80ZH	Cover Kantong Brown Honda Scoopy K2F	Cover Body	132000.0
81130K2FN00ZW	Cover Kantong Brown Honda Scoopy K2F	Cover Body	63000.0
61100K1ZJ10YF	Spakbor Depan Merah Maron Honda PCX 160 K1Z	Cover Body	365000.0
64341K45NL0MBS	Cowl Bawah Kanan Dark Silver Honda CBR 150R K45R	Cover Body	375000.0
8364AK18900	Cover Samping Kiri Honda Verza 150	Cover Body	45000.0
64350K07900ZB	Cover Kanan Inner Leg Shield Honda Blade 110 S K07J	Cover Body	21000.0
83121K45NL0ZC	Cover Body Belakang Kiri Grey Honda CBR 150R K45R	Cover Body	305000.0
80100KTM850	Spakbor Belakang Honda Supra X 125 Injection	Cover Body	86500.0
64470K03N50ZA	Cover Depan Kanan Bawah Honda Revo 110 FI	Cover Body	16000.0
64431K2FN00YC	Cover Bawah Kiri Oren Honda Scoopy K2F	Cover Body	152500.0
53206K0JN00MIB	Cover Belakang Speedometer Biru Doff Honda Genio K0JN	Cover Body	61000.0
8010BKZLA00	Spakbor Belakang Honda Spacy Karburator	Cover Body	48000.0
83130K45A50ZC	Cover Center Belakang Hitam Type 1 Honda CBR 150R K45R	Cover Body	175000.0
64460K16900ZC	Cover Tutup Aki Honda Scoopy eSP K16R	Cover Body	15500.0
64400K45A80ZA	Cover Body Samping Kiri Type 1 Honda CBR 150R K45R	Cover Body	863000.0
64360K07900ZB	Cover Body Kiri Honda Supra X 125 FI	Cover Body	21000.0
64300K45A80ZA	Cover Body Samping Kanan Type 1 Honda CBR 150R K45R	Cover Body	863000.0
64240K45A50ZB	Cover Depan Bawah Type1 Honda CBR 150R K45R	Cover Body	198000.0
64201K0JN00ZM	Cover Depan Kanan Biru Doff Honda Genio K0JN	Cover Body	117000.0
84100K59A70ZU	Behel Belakang Brown Honda Vario 125 eSP K2V	Cover Body	285000.0
83600K1AN00MSG	Cover Body Kiri Hijau Doff Honda BeAT K1A	Cover Body	135000.0
83500K1AN00MBS	Cover Body Kanan Dark Silver Honda BeAT K1A	Cover Body	135000.0
83120K45A50ZA	Cover Body Kiri Belakang Hitam Doff Honda CBR 150R K45R	Cover Body	340000.0
83110K45A50ZA	Cover Body Kanan Belakang Hitam Doff Honda CBR 150R K45R	Cover Body	340000.0
64431K0WNA0ZB	Cover Body Bawah Kanan Silver Honda ADV 160	Cover Body	145000.0
64400K45A50ZA	Cover Body Samping Kiri Set Hitam Doff Honda CBR 150R K45R	Cover Body	863000.0
64340K45A50ZD	Cowl Set Bawah Kanan Grey Type 1 Honda CBR 150R K45R	Cover Body	375000.0
64230K64NP0	Cover Tengah Depan Honda CBR 250RR K64N	Cover Body	50000.0
61000K45A90ZD	Spakbor Depan Hitam Doff Type 1 Honda CBR 150R K45R	Cover Body	276500.0
86642K1ANC0ZC	Stiker Body Depan Kiri Type 2 Honda BeAT K1A	Cover Body	34000.0
64704K0WN00	Knob Adjust Lock Honda ADV 160	Cover Body	82000.0
64330K64NP0MZB	Cover Body Samping Kanan Biru Doff Honda CBR 250RR K64N	Cover Body	1150000.0
64330K64NP0MGB	Cover Body Samping Kanan Hitam Doff Honda CBR 250RR K64N	Cover Body	920000.0
64450KTM850FMX	Cover Body Tengah Kiri Putih Honda Supra X 125 Injection	Cover Body	263000.0
83650K64NP0ZC	Cover Seat Lock Merah Honda CBR 250RR K64J	Cover Body	350000.0
81140K1ZJ10YM	Outer Inner Cover Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	310000.0
81131K0JN60ZB	Cover Inner Rack Biru Doff Honda Genio	Cover Body	240000.0
64503K1ZJ10YM	Cover Front Center Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	130000.0
64502K1ZJ10YJ	Cover Depan Samping Kiri Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	480000.0
64440K64NP0ZB	Cover Depan Samping Kiri Hitam Honda CBR 250RR K64J	Cover Body	190000.0
61100K64NP0ZF	Spakbor Depan Hitam Metalic Honda CBR 250RR K64J	Cover Body	360000.0
83600K2VN30MIB	Cover Body Kiri Biru Doff Honda Vario 125 eSP K2V	Cover Body	220000.0
83141K45NL0ZN	Cover Seat Lock Putih Honda CBR 150R K45R	Cover Body	200000.0
81134K2FN00YB	Cover Inner Upper Putih Honda Scoopy K2F	Cover Body	100000.0
81130K2FN80ZJ	Cover Kantong Biru Doff Honda Scoopy K2F	Cover Body	88000.0
64500K2SH00ZA	Cover Depan Kanan Merah Doff Honda Vario 160 K2S	Cover Body	289500.0
64431K2FN00YL	Cover Bawah Kiri Putih Honda Scoopy K2F	Cover Body	245000.0
53207K2FN00MIB	Cover Ring Speedometer Biru Doff Honda Scoopy K2F	Cover Body	61000.0
53205K2FN00RSW	Cover Speedometer Putih Honda Scoopy K2F	Cover Body	180000.0
17575K25900	Cover Fuel Tank Honda BeAT FI CBS K25	Cover Body	9500.0
64500K0WNB0ZE	Cover Body Set Samping Kiri Depan Hitam Doff Honda ADV 160	Cover Body	185000.0
64500K0WNB0ZC	Cover Body Set Samping Kiri Depan Putih Doff Honda ADV 160	Cover Body	230000.0
64431K2FN00YK	Cover Bawah Kiri Hitam Doff Honda Scoopy K2F	Cover Body	150000.0
64400K0WNA0ZJ	Cover Body Set Samping Kanan Depan Hitam Doff Honda ADV 160	Cover Body	185000.0
64400K0WNA0ZG	Cover Body Set Samping Kanan Depan Putih Doff Honda ADV 160	Cover Body	230000.0
80104K25900	Guard Splash Honda BeAT FI CBS K25	Cover Body	7500.0
37230K46N01	Cover Speedometer Honda Vario 110 eSP	Cover Body	22500.0
37213KPH701	Holder Winker Relay Honda Supra X 125	Cover Body	5500.0
17225K41N00	Cover Saringan Udara Honda Supra X 125 FI New	Cover Body	56000.0
83720K3BN10ZA	Cover Body Set Belakang Kiri Hitam Type 1 Honda CB150X	Cover Body	269500.0
83600K3BN00ZB	Cover Body Set Belakang Kanan Hitam Type 1 Honda CB150X	Cover Body	272500.0
83170K3BN00ZC	Cover Set Tangki Kiri Merah Type 1 Honda CB150X	Cover Body	376000.0
64420K3BN10ZA	Cover Body Set Tengah Kiri Hitam Type 1 Honda CB150X	Cover Body	386000.0
64320K3BN10ZA	Cover Body Set Tengah Kanan Hitam Type 1 Honda CB150X	Cover Body	386000.0
64310K3BN00ZA	Cover Body Set Atas Kanan Silver Type 1 Honda CB150X	Cover Body	183000.0
77220KYE900	Cowl Belakang Kiri Honda Mega Pro New	Cover Body	25500.0
53207K0JN00ZB	Cover Speedometer Bawah Hitam Honda Genio	Cover Body	36000.0
17575K03N30	Cover Fuel Pump Honda Revo 110 FI	Cover Body	11500.0
83650K0WNA0ZC	Cover Body Set Kiri Putih Honda ADV 160	Cover Body	200000.0
83550K0WNA0ZC	Cover Body Set Kanan Putih Honda ADV 160	Cover Body	200000.0
64311K45NL0ZC	Cover Body Kanan Hitam Doff Honda CBR 150R K45R	Cover Body	863000.0
83510K84620ZA	Cover Set Samping Kanan Type 2 Honda CRF150L K84	Cover Body	99500.0
83510K84620ZB	Cover Samping Kanan Hitam Type 1 Honda CRF150L K84	Cover Body	94500.0
83510K84610ZA	Cover Samping Kanan Hitam Type 1 Honda CRF150L K84	Cover Body	96500.0
53208K59A70YB	Cover Batok Atas Merah Honda Vario 125 eSP K60R	Cover Body	142500.0
17556K84620ZA	Cover Body Kiri Hijau Honda CRF150L K84	Cover Body	171000.0
17556K84600ZA	Cover Body Kiri Merah Honda CRF150L K84	Cover Body	155500.0
83450K2SH00ZB	Cover Body Set Emblem Kanan Putih Doff Honda Vario 160 K2S	Cover Body	508000.0
77330K0WNA0ZA	Grip Rear Kanan Honda ADV 160	Cover Body	244000.0
53208K2SN10ZJ	Cover Batok Kanan Hitam Honda Vario 160 K2S	Cover Body	93500.0
81138K0WNA0ZB	Outer Right Inner Cover Honda ADV 160	Cover Body	37000.0
61100K64NP0ZD	Spakbor Depan Merah Honda CBR 250RR K64J	Cover Body	490000.0
80107K0WNA0	Cover Rear Fender Lower Honda ADV 160	Cover Body	44000.0
64501K0WNA0ZK	Cover Body Samping Kanan Depan Merah Doff Honda ADV 160	Cover Body	230000.0
61110K2SN00ZC	Spakbor Depan Merah Doff Honda Vario 160 K2S	Cover Body	279500.0
17231KVB900	Cover Saringan Udara Honda Vario 110 Techno B	Cover Body	25000.0
61110K2SN00ZA	Spakbor Depan A Putih Doff Honda Vario 160 K2S	Cover Body	249000.0
83650K1ZA00ZP	Cover Body Set Belakang Kiri Putih Honda PCX 160 K1Z	Cover Body	401000.0
64220K64NA0ZB	Set Illus Front Lower Cowl Type 1 Honda CBR 250RR K64	Cover Body	41000.0
83450K15900ZD	Cover Belakang Tengah Merah Honda CB150R StreetFire K15	Cover Body	64000.0
83131K45NL0ZA	Cowl Rear Center Merah Honda CBR 150R K45R	Cover Body	152500.0
83650K1ZN30ZC	Cover Body Belakang Kiri Putih Honda PCX 160 K1Z	Cover Body	401000.0
64441K45NL0ZD	Cover Bawah Kiri Putih Honda CBR 150R K45R	Cover Body	477500.0
64431K2FN00YD	Cover Bawah Kiri Merah Honda Scoopy K2F	Cover Body	178000.0
64421K2FN00YB	Cover Bawah Kanan Merah Honda Scoopy K2F	Cover Body	178000.0
64301K59A70YD	Cover Tameng Depan Hitam Metalic Honda Vario 150 eSP K59J	Cover Body	233500.0
61100K59A70ZL	Spakbor Depan Putih Honda Vario 150 eSP K59J	Cover Body	239000.0
64341K45NL0ZC	Cowl Bawah Kanan Hitam Glossy Honda CBR 150R K45R	Cover Body	457000.0
83650K2FN00MPC	Cover Belakang Putih Doff Honda Scoopy K2F	Cover Body	107000.0
83650K2FN00MJB	Cover Belakang Brown Doff Honda Scoopy K2F	Cover Body	96500.0
81146K2FN10ZL	Lid Smart Emergency Brown Honda Scoopy K2F	Cover Body	53000.0
77237K59A10	Cover Seat Catch Honda Vario 150 eSP K59	Cover Body	4500.0
83121K45N40ZC	Cover Body Kiri Putih Mutiara Honda CBR 150R K45G	Cover Body	256000.0
80101K2SN00	Spakbor Bawah Belakang Honda Vario 160 K2S	Cover Body	117000.0
53207K2FN00PBL	Cover Ring Speedometer Hitam Honda Scoopy K2F	Cover Body	59000.0
64330K03N50ZB	Cover Tutup Sisi Tengah Kiri Honda Revo 110 FI	Cover Body	42000.0
81130K2FN00ZX	Lid Assy Pocket Orange Honda Scoopy K2F	Cover Body	67000.0
61304K15710	Cover Meter Honda CB150R StreetFire K15P	Cover Body	34000.0
83450K15900ZC	Cowl Center Belakang Hitam Honda CB150R StreetFire K15P	Cover Body	44000.0
61302K15710ZB	Cover Depan Samping Kanan Hitam Honda CB150R StreetFire K15P	Cover Body	106000.0
64460K2SN00ZA	Lid Battery Hitam Honda Vario 160 K2S	Cover Body	30500.0
84151K1ZJ10ZR	Cover Behel Putih Honda PCX 160 K1Z	Cover Body	340000.0
11360KWWA80	Cover Comp Kiri Rear Honda Revo 110 FI	Cover Body	61000.0
53208K2SN00ZE	Cover Batok Kanan Merah Doff Honda Vario 160 K2S	Cover Body	85500.0
83635K64N60ZA	Cover Belakang Kiri Merah Honda CBR 250RR K64J	Cover Body	315000.0
83170K64NA0ZA	Cover Tangki Kiri Type 2 Honda CBR 250RR K64	Cover Body	441000.0
83160K64N20ZA	Cover Tangki Kanan Merah Honda CBR 250RR K64	Cover Body	576000.0
64440K45NL0ZA	Cover Bawah Kiri Grey Honda CBR 150R K45R	Cover Body	457000.0
64400K64NA0ZA	Cover Body Set Kiri Merah Doff Honda CBR 250RR K64	Cover Body	1625500.0
84151K97T00YW	Cover Behel Biru Doff Honda PCX 150 K97	Cover Body	286000.0
84151K1ZJ10ZN	Cover Behel Merah Doff Honda PCX 160 K1Z	Cover Body	367000.0
83600K59A70YC	Cover Body Kiri Hitam Metalic Honda Vario 150 eSP K59J	Cover Body	355500.0
83610K1ZJ10MDG	Cover Body Kiri Grey Honda PCX 160 K1Z	Cover Body	533000.0
84152K1ZJ10ZP	Lid Grab Rail Cover Biru Doff Honda PCX 160 K1Z	Cover Body	117000.0
84152K1ZJ10ZN	Cover Tutup Behel Merah Doff Honda PCX 160 K1Z	Cover Body	127000.0
53206K1ZJ10	Cover Stang Belakang Honda PCX 160 K1Z	Cover Body	68500.0
53209K2SN00ZE	Cover Batok Kiri Merah Doff Honda Vario 160 K2S	Cover Body	85500.0
53209K2SN10ZB	Cover Batok KIri Hitam Doff Honda Vario 160 K2S	Cover Body	75500.0
61100K0JN00MJB	Spakbor Depan Brown Honda Genio	Cover Body	208500.0
83151K3BN00	Cover Fuel Tank Center Honda CB150X	Cover Body	46000.0
64336K0WN00ZK	Cover Front Upper Putih Honda ADV 150	Cover Body	188000.0
64432K1ZJ10ZQ	Cover Left Floor Side Hitam Metalic Honda PCX 160 K1Z	Cover Body	384000.0
64431K0JN00MJB	Cover Left Under Side Brown Honda Genio	Cover Body	129000.0
64320K56N10ZD	Cover Main Pipe Front Hitam Honda Supra GTR K56F	Cover Body	97000.0
64440K56N00VRD	Cover Left Side Upper Merah Honda Sonic 150R K56	Cover Body	318000.0
64341K45NL0ZA	Cowl Comp Right Under Merah Honda CBR 150R K45R	Cover Body	457000.0
64305K1ZJ10ZJ	Garnish Front Grey Honda PCX 160 K1Z	Cover Body	397500.0
64300K45A40ZA	Cover Body Kanan Hitam Doff Honda CBR 150R K45R	Cover Body	863000.0
83510K1ZJ10PFW	Cover Body Kanan Putih Mutiara Honda PCX 160 K1Z	Cover Body	391000.0
83500K59A70YC	Cover Body Kanan Hitam Metalic Honda Vario 150 eSP K59J	Cover Body	355500.0
83500K2SN00MSR	Cover Body Kanan Merah Doff Honda Vario 160 K2S	Cover Body	616500.0
83171K3BN00ZD	Cover Tangki Kiri Hijau Honda CB150X	Cover Body	435000.0
83171K3BN00ZC	Cover Tangki Kiri Hitam Doff Honda CB150X	Cover Body	350000.0
83161K3BN00ZD	Cover Tangki Kanan Hijau Honda CB150X	Cover Body	435000.0
64506K97T00YY	Mold Left Head Light Hitam Doff Honda PCX 150 K97	Cover Body	183000.0
83600K2FN00MSR	Cover Body Kiri Merah Doff Honda Scoopy K2F	Cover Body	411500.0
83510K97T00YW	Cover Body Kanan Hitam Doff Honda PCX 150 K97	Cover Body	385000.0
53207K2FN00ASB	Cover Ring Speedometer Hitam Honda Scoopy K2F	Cover Body	68500.0
81137K1ZJ10ZS	Lid Smart Emergency Putih Honda PCX 160 K1Z	Cover Body	96500.0
81134K0JN00ZG	Cover Inner Upper Brown Honda Genio	Cover Body	56000.0
64503K1ZJ10ZJ	Cover FR Center Grey Honda PCX 160 K1Z	Cover Body	381000.0
81140K1ZJ10ZQ	Outer R Inner Cover Kanan Matte Blue PCX 160 K1Z	Cover Body	279500.0
83500K59A70YA	Cover R Body Kanan Merah Vario 150 eSP K59J	Cover Body	355500.0
64503K1ZJ10ZN	Cover FR Center Hitam Honda PCX 160 K1Z	Cover Body	183000.0
64421K0JN00MJB	Cover R Under Side Matte Brown Honda Genio	Cover Body	129000.0
61100K2FN00ZP	Spakbor Depan Biru Doff Honda Scoopy K2F	Cover Body	218500.0
61100K2FN00ZL	Spakbor Depan Cream Honda Scoopy K2F	Cover Body	254000.0
50400K16910ZA	Behel Belakang (Pipe Assy RR Grip) - Scoopy eSP K16R,Scoopy FI K16G	Cover Body	137000.0
83111K45N40ZC	Cowl R Rear Rose White - CBR 150R K45G	Cover Body	256000.0
53205K1AN00ZC	Cover Batok Kepala Depan Pink Honda BeAT K1A	Cover Body	183000.0
83120K45NZ0ZA	Cover Kiri Belakang (Set Illus Left Rear Cowl Type1) - Honda CBR 150R K45R	Cover Body	315000.0
83141K45NL0ZA	Cover Seat Lock Orange NI OR - Honda CBR 150R K45R	Cover Body	188000.0
83161K45NL0ZB	Cover Tangki Kanan Merah (Cover Right Fuel Tank VA Red) - Honda CBR 150R K45R	Cover Body	376000.0
83171K45NL0ZC	Cover Kiri Tanki Merah (Cover L Fuel Tank WN Red) - Honda CBR 150R K45R	Cover Body	482500.0
83151K45NL0FMB	Cover Tangki Tengah Hitam (Cover Fuel Tank Center Black) - Honda CBR 150R K45R	Cover Body	279500.0
17255K45NL0	Cover Inlet Duct - Honda CBR 150R K45R	Cover Body	20500.0
61100K59A70ZQ	Spakbor Depan Grey Honda Vario 125 eSP K60R	Cover Body	239000.0
61100KVY960FMB	SpakBor Depan Hitam (Fender Front Black) - Honda BeAT Karbu	Cover Body	130000.0
64501K0WN01ZF	Cover R Front Side (DG SL MT) - Honda ADV 150	Cover Body	406500.0
83120K45NE0ZA	Set Illust Left Rear Cowel Type 1 Honda New CBR 150R K45G	Cover Body	239000.0
64211K45NA0ZE	Cover Tameng Depan Hitam Doff Honda New CBR 150R K45N	Cover Body	497500.0
83121K45N40ZH	Cover Body Cowl L Rear (VA RD) New CBR 150R K45G	Cover Body	346500.0
64311K45N40ZE	Cover Body Samping (Cowl A R Middle MT GN BL)	Cover Body	585000.0
64320KYZ900	Body Tengah (Cover MP Upper) - Honda Supra X 125 Helm-In	Cover Body	96500.0
61100K97T00YH	Spakbor Depan Coklat Honda New PCX 150 K97	Cover Body	254000.0
64421K0JN00ZF	Cover Body Kanan (Cover Right Under Side) Silver - Honda Genio K0J	Cover Body	183000.0
64565K03N30ZB	Cover L Body Lower - Honda Revo FI 64565K03N30ZB	Cover Body	29500.0
64420K1ZJ10ZR	Cover B Center Hitam Doff Honda PCX 160 K1Z	Cover Body	127000.0
64310K64N00ZB	Cowl Comp,Right Under Hitam Doff CBR 250RR K64	Cover Body	584000.0
77330K0WN00ZA	Grip Right,Rear (Black)- ADV 150	Cover Body	244000.0
81139K97T00YH	Outer,L Inner Cover Coklat Doff - PCX 150 K97	Cover Body	274000.0
64333K0JN00	Guide,Harness - Genio	Cover Body	15500.0
80102K0WN00	Fender B,Rear - ADV 150	Cover Body	61000.0
64305K97T00YJ	Garnish,FR Coklat Doff - PCX 150 K97	Cover Body	305000.0
64432K97T00YJ	Cover L Floor Side Coklat Doff - PCX 150 K97	Cover Body	387000.0
83500K1AN00RSW	Cover Body Kanan (Cover,Right Body) Putih Mutiara - BeAT K1A	Cover Body	140500.0
64500K0WN10ZB	Set Illust,L FR Side Cover Type 1 - ADV 150	Cover Body	284500.0
81134K93N00ZX	Cover Inner,Upper Merah Doff- Scoopy eSP K93	Cover Body	86500.0
16305K0JN00	Cover Throtle Body (Cover Comp,Throttle Body) Honda Genio,BeAT K1A	Cover Body, Throttle Body	10500.0
53206K93N00ZQ	Cover B, Spidomeer Putih - Scoopy eSP K93	Cover Body	83500.0
64620K56N10MSR	Cover Samping Kiri (Cover, L Side) Merah Doff - Supra GTR 150	Cover Body	668000.0
64610K56N10MSR	Cover Samping Kanan (Cover, R Side) Merah Doff - Supra GTR 150	Cover Body	668000.0
64200K0JN10ZE	Cover Depan Kanan merah Honda Genio	Cover Body	157500.0
64502K0WN00ZE	Cover L FR Side RO WH (Putih) - ADV 150	Cover Body	279500.0
81142K93N00ZL	LID L Pocket MA SL RD - Scoopy eSP (K93)	Cover Body	132500.0
83600K56H30ZA	Cover Set R Body WL Type 1 - Sonic 150R	Cover Body	215000.0
64405K56H40ZA	Cowl Set L Side Lower WL TY 1 - Sonic 150R	Cover Body	165500.0
83500K0JN00PBL	Cover Kanan (Cover Right Body) Hitam Metalic - Honda Genio	Cover Body	472500.0
81142K93N00ZM	lid L Pocket Putih Mutiara - Scoopy eSP (K93)	Cover Body	122500.0
64421K0JN00ZB	Cover Kanan (Cover Right Under Side) Merah - Honda Genio	Cover Body	152500.0
64201K0JN00ZG	Cover Depan Kanan Hitam Metalic Honda Genio	Cover Body	152500.0
64201K0JN00ZH	Cover Depan Kanan Biru Metalic Honda Genio	Cover Body	203500.0
64501K0WN00ZE	Cover R FR Side Rose White - ADV 150	Cover Body	279500.0
64431K0JN00ZF	Cover Body Kiri (Left Under Side) Silver Metalic - Honda Genio	Cover Body	183000.0
64202K0JN00ZD	Cover Depan Kiri Putih Mutiara Honda Genio	Cover Body	152500.0
64360K0WN00ZA	Cover L Center Side Merah - ADV 150	Cover Body	203500.0
64360K0WN00ZC	Cover L Center Side Silver - ADV 150	Cover Body	188000.0
81134K0JN00ZD	Cover Inner Upper Hitam - Genio	Cover Body	63000.0
81131K0JN00ZA	Cover Inner Rack Coklat Metalik - Genio	Cover Body	447000.0
81131K0JN00ZD	Cover Inner Rack Hitam - Genio	Cover Body	475500.0
61100K0JN00PBL	Spakbor Depan Hitam Honda Genio	Cover Body	315000.0
64350K0WN00ZA	Cover R Center Side WN RD - Honda ADV 150	Cover Body	203500.0
61100K0JN00FMB	Spakbor Depan Hitam Honda Genio	Cover Body	335000.0
64336K0WN00ZE	Cover FR Upper RO WH - Honda ADV 150	Cover Body	195000.0
83650K56NH0ZA	Set Illust L Body Cover Type 1 - New Sonic 150R	Cover Body	127000.0
64340K45N40ZB	Cover Cowl Set R Under WL Type 2 Black - New CBR 150R K45G K45N	Cover Body	326000.0
64310K45NH0ZA	Cover Body Kanan (Set Illust R Middle Cowl A Type 2 Hitam) - New CBR 150R K45G K45N	Cover Body	589000.0
83110K45NA0ZA	Set Illust R RR Cowl Type 2 - CBR 150R K45N	Cover Body	203500.0
64301K64N00ZA	Set Illust R Under - CBR 250RR K64	Cover Body	452000.0
64440K45N50ZA	Cowl Set L Under WL - CBR 150R K45N	Cover Body	361500.0
64220K64N00ZA	Set Illust FR Lower - CBR 250RR K64	Cover Body	54000.0
61305K56N20ZA	Garnis Kanan Orange Honda Sonic 150R K56	Cover Body	159500.0
64601K59A70YC	Body Kiri Depan (Cover L FR Ma Bl Mt) - New Vario 150 eSP K59J	Cover Body	254000.0
64601K59A70YA	Cover Body Depan Kiri (Cover L FR (Ma Jb Mt/Brown) - Vario 150 eSP K59J	Cover Body	254000.0
64501K59A70YA	Cover Depan Kanan (Cover R FR (Ma Jb Mt/Brown) - Vario 150 eSP K59J	Cover Body	254000.0
83110K45NE0ZA	Set Illust,Right Rear Cowl Typ 1 CBR 150R K45N	Cover Body	244000.0
64420K56N00WRD	Cowl L Side Lower Red - Sonic 150R K56	Cover Body	165500.0
53207K56N10ZR	Cover Batok Kanan Merah Honda Supra GTR K56F	Cover Body	91500.0
53208K56N10ZS	Cover Batok Kiri Merah Doff Honda Supra GTR 150	Cover Body	91500.0
53208K56N10ZR	Cover Batok Kiri Merah Honda Supra GTR 150	Cover Body	91500.0
83610K64N00MSR	Cowl RR Center Mate Red - CBR 250RR K64	Cover Body	233500.0
64506K97T00ZE	Mold L Headlight Black - PCX 150 K97	Cover Body	195000.0
83650K64N00ZG	Cover Seat Lock Mate Sollar Red - CBR 250RR K64	Cover Body	247000.0
83510K84920ZB	Cover Body (Cet Illust R Side A Cover T1) - CRF 150L K84	Cover Body	164500.0
77210K18960PFR	Cover Body Samping Kanan Merah - CB 150 Verza	Cover Body	238000.0
77220K18960INS	Cover Body Kiri (Cowl L Side) Silver - CB 150 Verza	Cover Body	206500.0
83175K64N00FMB	Cover Tangki Kiri (Cover L Tank) Black - CBR 250RR K64	Cover Body	528000.0
64320K64N00ZA	Cowl L Under Black Metalic - CBR 250RR K64	Cover Body	538500.0
61100K64N00ZD	Spakbor Depan Hitam Metalik Honda CBR 250RR K64	Cover Body	394000.0
64490K56N10ZG	Cover Body Kiri (Cover L Body RR) Red - Supra GTR 150 K56F	Cover Body	138500.0
64480K56N10ZG	Cover R Body RR Red - Supra GTR 150	Cover Body	138500.0
64301K46N00ARM	Cover Tameng Depan Merah - New Vario 110 eSP	Cover Body	259000.0
53205K46N20MAG	CoverBatok Kepala Depan Abu Abu Honda New Vario 110 eSP	Cover Body	129000.0
83751K46N00ZK	Cover Rear Center Lower Red - Vario 110 eSP	Cover Body	96500.0
83750K46N00ZA	Cover Tengah Belakang Atas Lampu Merah - Vario 110 FI	Cover Body	71500.0
64601K46N00PFW	Cover Kiri Depan (Left Front White) - Vario 110 FI	Cover Body	119000.0
64601K46N00CSR	Cover Body Kiri Depan Merah Maroon - Honda Vario 110 FI	Cover Body	144500.0
64501K46N00RSW	Cover Kanan Depan Putih Mutiara - Vario 110 eSP	Cover Body	152500.0
83600K46N00PFW	Cover Body Kiri (Cover Left Body) White - Vario 110 FI	Cover Body	259000.0
83500K46N00PFW	Cover Right Body White - Vario 110 FI	Cover Body	260000.0
64601K46N00VRD	Cover Kiri Depan Red - Vario 110 eSP	Cover Body	124000.0
53204K46N20FMB	Visor Hitam Honda Vario 110 eSP	Cover Body	55000.0
83751K46N00ZF	Cover Rear Center Lower Merah Maroon - Vario 110 eSP	Cover Body	107000.0
83600K46N00ARM	Cover Kiri Body Merah Maroon - Vario 110 eSP	Cover Body	391000.0
83500K46N00ARM	Cover Body Kanan Merah Maroon - Vario 110 eSP	Cover Body	391000.0
83751K46N00ZH	Cover Rear Center Lower White - Vario 110 eSP	Cover Body	91500.0
53208K59A70ZN	Cover Batok Atas Putih Honda New Vario 125 eSP	Cover Body	163500.0
83600K59A70ZR	Cover L Body (AF BL ME) - New Vario 125 eSP (K60R)	Cover Body	565500.0
81131K59A70ZQ	Cover Rack (Putih) - New Vario 125 eSP (K60R)	Cover Body	253000.0
83500K59A70ZR	Cover R Body AF Black Me - New Vario 125 eSP (K60R)	Cover Body	565500.0
64301K59A70ZQ	Cover Front RS White - New Vario 125 eSP (K60R)	Cover Body	296500.0
53205K25600VBM	Cover Batok Kepala Depan Biru Honda Beat Sporty eSP K25	Cover Body	127000.0
83500K25900PFW	Cover Kanan (Cover Right Body) Putih - BeAT FI, BeAT FI CBS (k25)	Cover Body	194000.0
83600K25900PFW	Cover Body Kiri (Cover Left Body) Putih - BeAT FI, BeAT FI CBS (K25)	Cover Body	193000.0
83500K59A70ZP	Cover R Body White - New Vario 150 (K59J)	Cover Body	511000.0
83500K25900FMB	Cover Body Kanan Hitam (Cover Right Body Black) - BeAT FI, BeAT FI CBS (K25)	Cover Body	191000.0
83750K59A70ZC	Cover RR Center (Putih) - Vario 150 eSP New (K59)	Cover Body	235000.0
83600K59A70ZL	Cover Body Kiri (Cover L Body) Merah - New Vario 150 K59J	Cover Body	601000.0
64360K59A70ZF	Cover L Under Side Silver - New Vario 150 K59J	Cover Body	418500.0
83500K59A70ZS	Cover Body Kanan Silver - New Vario 150 K59J	Cover Body	430500.0
61100K59A70ZH	Spakbor Depan Putih Honda Vario 150 K59J	Cover Body	295500.0
83165K64N00ASB	Cover R Tank Hitam Metalik - CBR 250RR	Cover Body	546500.0
64320K64N00ASB	Cowl L Under Hitam Metalik - CBR 250RR	Cover Body	518000.0
83500K81N00MGB	Cover R Body Black Matte - New BeAT Sposty eSP K81	Cover Body	244000.0
64310K64N00RSW	Cowl Comp R Under Putih - CBR 250RR	Cover Body	547500.0
64310K64N00ASB	Cowl Comp R Under Hitam Metalik - CBR 250RR	Cover Body	506000.0
61100K46N00ZH	Spakbor Depan Putih Honda Vario 110 eSP	Cover Body	253000.0
83650K93N00ZQ	Cover Rear Center Lower Merah - Scoopy eSP K93	Cover Body	128000.0
64401KZL930ZD	Cover Depan Samping Kiri Hitam - Spacy	Cover Body	145500.0
61100K56N00FMB	Spakbor Depan A Hitam Honda Sonic 150R	Cover Body	132000.0
33708K03N30ZC	Cover belakang Hitam (Cover Tail) Honda Revo FI	Cover Body	67000.0
83610K97T00ZW	Cover Body Kiri Gold - PCX 150 K97	Cover Body	503000.0
81138K97T00ZS	Outer R Inner Gold - PCX 150 K97	Cover Body	323000.0
81139K97T00YA	Outer L Inner Putih - PCX 150 K97	Cover Body	230000.0
80151K93N00ZQ	Cover Center Merah - Scoopy eSP (K93)	Cover Body	365500.0
81138K97T00ZV	Outer R Inner Putih - PCX 150 K97	Cover Body	230000.0
53205K61900ZF	Cover Batok Depan Merah Honda BeAT POP eSP	Cover Body	126000.0
53205K61900WRD	Cover Batok Depan Merah Honda BeAT POP eSP	Cover Body	126000.0
80102K18900	Cover RR Fender - Verza 150	Cover Body	11000.0
53205KVY910SBM	Cover FR Handle Biru - BeAT Karbu	Cover Body	134000.0
53205KVR600DSM	Cover Handle FR Silver - Revo	Cover Body	190000.0
64340KYT900	Cover Under Assy - Scoopy	Cover Body	93000.0
64410KTL690FMX	Cover Body Kanan Putih - Supra FIT	Cover Body	205500.0
64410KVLN20FMB	Cover Body Kanan Hitam - Supra X 125	Cover Body	158500.0
64420KTL690FMX	Cover Body Kiri Putih - Supra FIT New	Cover Body	205500.0
83510KPH720FMB	Cover Tail Hitam - Kharisma	Cover Body	33500.0
83600KZL930ZD	Cover Body Kiri Merah - Spacy	Cover Body	328000.0
83500KVB930FMB	Cover Body Kanan Hitam - Vario Karbu	Cover Body	207500.0
61302KSPB00FMB	Cowl R FR SD Hitam - Mega Pro 2010	Cover Body	91500.0
64385KWC900AFB	Cowl L Mid - CS1	Cover Body	92500.0
64500KTL690FMX	Cover FR Top Putih - Supra FIT	Cover Body	111000.0
8010AK16A40	Spakbor Belakang (Fender RR Assy) - New Scoopy eSP (K16)	Cover Body	102000.0
64400K41N00ZC	Cover Body Depan Kanan Hitam - Supra X 125 FI	Cover Body	190000.0
53205KYZ900ZB	Cover Batok Depan Hitam Honda Supra X 125 Helm In	Cover Body	95500.0
53205KTM860FMB	Cover Handle FR Hitam DR - Supra X 125	Cover Body	128000.0
54303K16900CSR	Cover Kiri Depan Merah Honda Scoopy FI K16	Cover Body	378000.0
61100KVR600PEO	Spakbor Depan (Fender A FR) Orange 2 - Revo	Cover Body	144500.0
81141K16A20PMC	Cover Inner Putih - Scoopy FI	Cover Body	629500.0
64301KVY960CSR	Cover Depan Merah - BeAT Karburator	Cover Body	306000.0
64320K64N00MGB	Cowl Set L Under Hitam Doff - CBR 250RR	Cover Body	498500.0
61100KVB930FMB	Spakbor Depan (Fender FR) Hitam - Vario	Cover Body	133000.0
53205K46N00FMB	Cover Batok Kepala Depan Hitam Honda Vario 110 FI	Cover Body	137500.0
61100K07900ZE	Spakbor Depan A Hitam Honda Blade 125 FI	Cover Body	224500.0
83500K59A10YC	Cover Body Kanan Hitam Metalik - Vario 125 & 150 eSP	Cover Body	424500.0
64490K56N10RSW	Cover Body Belakang Kiri Putih - Supra GTR	Cover Body	196000.0
64301K56N10ZL	Cover Front Top Orange - Supra GTR	Cover Body	404500.0
83650K64N00AGM	Cover Seat Lock (Grey) - New CBR 250RR	Cover Body	254000.0
64421K93N00ZM	Cover Bawah Samping Kanan Biru - Scoopy eSP K93	Cover Body	138500.0
83600K93N00ZL	Cover Body Kiri Red - Scoopy eSP K93	Cover Body	457000.0
64201K93N00ZJ	Cover Depan Kanan Silver Honda Scoopy eSP K93	Cover Body	163500.0
64310K64N00AGM	Cowl Set R Under (AN GR MT) - CBR 250RR	Cover Body	533000.0
64340K56N00NOR	Cover R Side Upper Orange - Sonic 150R	Cover Body	195000.0
83175K64N00AGM	Cover L Tank (Grey) - CBR 250RR	Cover Body	589000.0
83165K64N00AGM	Cover R Tank (Grey) - CBR 250RR	Cover Body	589000.0
64320K64N00AFB	Cowl Set L Under (Grey) - CBR 250RR	Cover Body	499500.0
61100K64N00ZC	Spakbor Depan Grey Honda CBR 250RR	Cover Body	417500.0
64320K56N00MGB	Cowl R Side Lower Hitam Doff - Sonic 150R	Cover Body	163500.0
64440K56N00RSW	Cover L Side Upper Putih - Sonic 150R	Cover Body	202500.0
64340K56N00SMM	Cover R Side Upper Magenta (Ungu) - Sonic 150R	Cover Body	329000.0
61302K56N00NOR	Cowl R FR Side Orange - Sonic 150R	Cover Body	75500.0
64301K56N10ZE	Cover FR Top Putih - Supra GTR 150	Cover Body	322000.0
83500K59A10WRD	Cover Right Body Merah (WRD) - Vario 125 eSP & Vario 150 eSP	Cover Body	321000.0
83500K59A10AFB	Cover Right Body Hitam Metallic - Vario 125 eSP & Vario 150 eSP	Cover Body	302000.0
83750KVB930FMB	Cover Rear Center Hitam	Cover Body	31500.0
53206K16900ZP	Cover B Speedometer Merah Scoopy (Red)	Cover Body	124000.0
53205K16A00ZE	Cover Speedometer Hitam Honda Scoopy Fi K16	Cover Body	88500.0
53205KYT940DBM	Cover Speedometer Depan Biru Honda Scoopy KYT	Cover Body	60000.0
83450K2VN50ZB	Cover Body Kanan Biru Doff Type 1 Honda Vario 125 eSP K2V	Cover Body	225000.0
84100K3VN00ZB	Behel Belakang Grey Honda Stylo 160	Cover Body	260000.0
83750K3VN00ASB	Cover Center Belakang Hitam Metalic Honda Stylo 160	Cover Body	153000.0
64302K2VN30ZB	Cover Front Top Hitam Honda Vario 125 eSP K2V	Cover Body	145000.0
53207K3VN00ASB	Garnish Handle Cover Belakang Hitam Metalic Honda Stylo 160	Cover Body	35000.0
5061AKZLC30ZD	Cover Bawah Honda Spacy FI	Cover Body	35000.0
83760K3VN00ZG	Cover Bawah Tengah Belakang Hijau Metalic Honda Stylo 160	Cover Body	27000.0
83760K3VN00ZE	Cover Bawah Tengah Belakang Putih Doff Honda Stylo 160	Cover Body	25000.0
83760K3VN00ZB	Cover Bawah Tengah Belakang Merah Honda Stylo 160	Cover Body	27000.0
83760K3VN00ZA	Cover Bawah Tengah Belakang Cream Honda Stylo 160	Cover Body	25000.0
83610K3VN00ARE	Cover Body Kiri Merah Maron Honda Stylo 160	Cover Body	532000.0
83550K1ZN40ZG	Cover Body Kanan Hitam Metalic Type 3 Honda PCX 160 K1Z	Cover Body	390000.0
83510K3VN00ARE	Cover Body Kanan Merah Maron Honda Stylo 160	Cover Body	532000.0
81141K3VN00MPC	Cover Inner Atas Putih Doff Honda Stylo 160	Cover Body	459000.0
81141K3VN00CGM	Cover Inner Atas Hijau Honda Stylo 160	Cover Body	588000.0
80151K3VN00ZA	Cover Center Cream Honda Stylo 160	Cover Body	169000.0
64601K3VN00ZE	Cover Kiri Depan Putih Doff Honda Stylo 160	Cover Body	410000.0
64601K3VN00ZD	Cover Kiri Depan Hitam Doff Honda Stylo 160	Cover Body	329000.0
64601K2SN00ZN	Cover Depan Kiri Biru Doff Honda Vario 160 K2S	Cover Body	283000.0
64501K3VN00ZE	Cover Kanan Depan Putih Doff Honda Stylo 160	Cover Body	410000.0
64501K3VN00ZD	Cover Kanan Depan Hitam Doff Honda Stylo 160	Cover Body	329000.0
64501K2SN00ZN	Cover Depan Kanan Biru Doff Honda Vario 160 K2S	Cover Body	283000.0
64400K64NR0ZA	Cover Body Samping Kiri Set Merah Honda CBR 250RR K64N	Cover Body	1150000.0
64350K3VN00ZD	Cover Bawah Kanan Hitam Doff Honda Stylo 160	Cover Body	124000.0
64302K3VN00MGB	Cover Tameng Depan Hitam Doff Honda Stylo 160	Cover Body	129000.0
64302K3VN00ARE	Cover Tameng Depan Merah Honda Stylo 160	Cover Body	199000.0
61100K3VN00ZB	Spakbor Depan Merah Honda Stylo 160	Cover Body	265000.0
61100K3VN00ZG	Spakbor Depan Hijau Metalic Honda Stylo 160	Cover Body	277000.0
61100K3VN00ZE	Spakbor Depan Putih Doff Honda Stylo 160	Cover Body	226000.0
61000K1ZN30ZC	Spakbor Depan Merah Doff Type 4 Honda PCX 160 K1Z	Cover Body	280000.0
53205K3VN10ZB	Cover Batok Depan Hitam Doff Honda Stylo 160	Cover Body	147000.0
53205K93N00ZJ	Cover A Speedometer Putih - Scoopy eSP K93	Cover Body	103000.0
81130K2SN00ZL	Lid Inner Pocket Putih Doff Honda Vario 160 K2S	Cover Body	105000.0
84151K1ZJ10YJ	Cover Behel Merah Maron Honda PCX 160 K1Z	Cover Body	444000.0
83615K64NA0ZC	Cover Center Belakang Hitam Doff Honda CBR 250RR K64N	Cover Body	183000.0
83610K1ZJ10CAR	Cover Body Kiri Merah Maron Honda PCX 160 K1Z	Cover Body	499000.0
83510K1ZJ10MCO	Cover Body Kanan Silver Honda PCX 160 K1Z	Cover Body	440000.0
83500K1AN00MJB	Cover Body Kanan Coklat Honda BeAT K1A	Cover Body	115000.0
64431K1ZJ10YM	Cover Body Bawah Kanan Merah Maron Honda PCX 160 K1Z	Cover Body	455000.0
8114AKZR600ZB	Cover Inner Lower Honda Vario Techno 125 FI STD	Cover Body	72000.0
61200KWW640	Spakbor Depan Hitam Honda Revo 110 FI	Cover Body	54500.0
81141K1ZJ10ZC	Lid Inner Pocket Silver Honda PCX 160 K1Z	Cover Body	145000.0
83510K0WNA0MFB	Cover Body Kanan Coklat Honda ADV 160	Cover Body	178000.0
81140K1ZJ10ZC	Outer Inner Cover Silver Honda PCX 160 K1Z	Cover Body	285000.0
64420K1ZJ10ZC	Cover Bawah Tengah Silver Honda PCX 160 K1Z	Cover Body	140000.0
61100KZL930ZH	Spakbor Depan Hitam Honda Spacy Karburator	Cover Body	171000.0
83610K0WNA0MDG	Cover Body Kiri Grey Honda ADV 160	Cover Body	178000.0
83510K1ZJ10MJB	Cover Body Kanan Coklat Honda PCX 160 K1Z	Cover Body	440000.0
81140K1ZJ10YK	Outer Inner Cover Coklat Honda PCX 160 K1Z	Cover Body	285000.0
81137K1ZJ10ZC	Lid Smart Emergency Silver Honda PCX 160 K1Z	Cover Body	105000.0
80151KVY900	Cover Center Hitam Honda BeAT Karburator KVY	Cover Body	63500.0
64503K1ZJ10ZC	Cover Center Depan Silver Honda PCX 160 K1Z	Cover Body	196000.0
64501K1ZJ10YG	Cover Depan Kanan Coklat Honda PCX 160 K1Z	Cover Body	485000.0
64501K0WNA0ZG	Cover Depan Kanan Grey Honda ADV 160	Cover Body	233500.0
64336K0WN00ZY	Cover Atas Depan Grey Honda ADV 160	Cover Body	130000.0
81141K1ZJ10YL	Lid Inner Pocket Merah Maroon Honda PCX 160 K1Z	Cover Body	159000.0
81139K0WN001AA	Garnish Lower Inner Hitam Sozai Honda ADV 150	Cover Body	42000.0
61110K2VN10ZE	Spakbor Depan Putih Type 4 Honda Vario 125 eSP K60R	Cover Body	183000.0
54302K16900PMC	Cover Kanan Depan Cream Honda Scoopy FI K16G	Cover Body	290500.0
81137K1ZJ10YL	Lid Smart Emg Merah Maroon Honda PCX 160 K1Z	Cover Body	96000.0
64450K07900ZC	Cover Body Hijau Kiri Honda Blade 110 K07	Cover Body	193000.0
64431K0WN000AA	Cover Body Bawah Kanan Hitam Sozai Honda ADV 150	Cover Body	82000.0
61304KSPB00MTB	Cover Meter Atas Hitam Honda Mega Pro	Cover Body	81500.0
83450K2SH10ZC	Cover Body Kanan Hitam Doff Type 1 Honda Vario 160 K2S	Cover Body	478000.0
64600K2SH10ZC	Cover Depan Kiri Hitam Doff Type 1 Honda Vario 160 K2S	Cover Body	250000.0
64600K2SH10ZB	Cover Depan Kiri Putih Doff Type 2 Honda Vario 160 K2S	Cover Body	254000.0
64480K07900ZD	Cover Tail Hitam Honda Blade 110 K07	Cover Body	48000.0
64330K47N00ZA	Cover Body Tengah Kiri Putih Honda Blade 125 FI K47	Cover Body	218500.0
50265KYE940ZD	Cover Body Depan Kiri Silver Honda Mega Pro FI	Cover Body	165500.0
61100K03N30ZF	Spakbor Depan Hitam Honda Revo 110 FI	Cover Body	213500.0
61100K41N00ZC	Spakbor Depan Hitam Honda Supra X 125 FI	Cover Body	172000.0
61303K18900ZA	Cover Samping Depan Kiri Silver Honda Verza 150	Cover Body	57000.0
64301K16A00PMC	Cover Tameng Depan Cream Honda Scoopy FI K16G	Cover Body	195000.0
64325K07900ZC	Cover Body Tengah Kanan Putih Honda Blade 110 K07	Cover Body	431500.0
17231KZLA00	Cover Saringan Udara Honda Spacy Karburator	Cover Body	28500.0
83500K1AN00MIB	Cover Body Kanan Biru Doff Honda BeAT K1A	Cover Body	104000.0
81140K0WN002AA	Garnish Upper Inner Cover Hitam Honda ADV 160	Cover Body	42000.0
64565K0WN000AA	Cover Bawah Kiri Hitam Honda ADV 150	Cover Body	40000.0
64421K0JN00MSG	Cover Body Samping Bawah Kanan Hijau Doff Honda Genio K0JN	Cover Body	148500.0
53205K3VN00ZA	Cover Batok Depan Cream Honda Stylo 160	Cover Body	184000.0
64202K0JN00MSG	Cover Depan Kiri Hijau Doff Honda Genio K0JN	Cover Body	135000.0
53208KYT900PFW	Garnish Handle Kiri Putih Honda Scoopy Karburator KYT	Cover Body	16500.0
53205KZLA00ZE	Batok Kepala Depan Hitam Honda Spacy Karburator	Cover Body	127000.0
83750K16900ZD	Cover Belakang Tengah Cream Honda Scoopy FI K16G	Cover Body	187000.0
83600K16900RSW	Cover Body Kiri Putih Honda Scoopy eSP K16R	Cover Body	313000.0
83600K16900CSR	Cover Body Kiri Merah Honda Scoopy FI K16G	Cover Body	400000.0
81141K0JN60ZA	Cover Inner Coklat Honda Genio K0JN	Cover Body	61000.0
81134K0JN00ZJ	Cover Inner Upper Biru Doff Honda Genio K0JN	Cover Body	20500.0
81131K0JN60ZC	Cover Inner Rack Hitam Doff Honda Genio K0JN	Cover Body	229000.0
64320K07900ZJ	Cover A/C Outlet Merah Honda Blade 110 K07A	Cover Body	80500.0
61100K18900ZA	Spakbor Depan Merah Honda Verza 150	Cover Body	262000.0
61100K64N0020	Spakbor Depan Hitam Honda CBR 250RR K64	Cover Body	150000.0
61100K16A00VBM	Spakbor Depan Biru Honda Scoopy FI K16G	Cover Body	264000.0
54303K16900RSW	Cover Kiri Depan Putih Honda Scoopy eSP K16R	Cover Body	310000.0
64400KYZ900ZA	Cover Body Tengah Kanan Putih Honda Supra X 125 Helm-in Karburator	Cover Body	345500.0
64400K41N00ZB	Cover Samping Depan Kanan Putih Honda Supra X 125 FI	Cover Body	191000.0
77250KYE900FMB	Garnish Belakang Kiri Hitam Honda Mega Pro	Cover Body	91500.0
77240KSPB00FMB	Garnish Belakang Kanan Hitam Honda Mega Pro	Cover Body	91500.0
64500K07900ZC	Cover Tameng Depan Putih Honda Blade 110 K07A	Cover Body	243000.0
64450K07900NOR	Cover Body Kiri Oranye Honda Blade 125 FI K47	Cover Body	162500.0
64431K16A40RSW	Cover Bawah Kiri Putih Honda Scoopy eSP K16R	Cover Body	171000.0
64421K16900RSW	Cover Bawah Kanan Putih Honda Scoopy eSP K16R	Cover Body	137500.0
64420K07900ZF	Cover Body Kiri Grey Honda Blade 110 K07A	Cover Body	386000.0
64410K07900ZF	Cover Body Kanan Grey Honda Blade 110 K07A	Cover Body	386000.0
64410K07900ZB	Cover Body Kanan Hitam Honda Blade 110 K07A	Cover Body	386000.0
64400K07900NOR	Cover Body Kanan Oranye Honda Blade 125 FI K47	Cover Body	162500.0
64380K41N00ZC	Cover Body Kiri Hitam Honda Supra X 125 FI	Cover Body	163500.0
64330K07900ZC	Cover Body Tengah Kiri Putih Honda Blade 110 S K07	Cover Body	431500.0
64330K03N30ZC	Cover Center Side Kiri Silver Honda Revo 110 FI	Cover Body	236000.0
61100KYZ900ZF	Spkabor Depan Honda Grey Honda Supra X 125 Helm-in Karburator	Cover Body	194000.0
61316KYT940	Guard Nomor Plat Hitam Honda Scoopy Karburator KYT	Cover Body	7000.0
61314KCJ640	Garnish Kiri Silver Honda Tiger Revolution C	Cover Body	144500.0
61313KCJ640	Garnish Kanan Silver Honda Tiger Revolution C	Cover Body	195000.0
53209K07900ZB	Cover Belakang Speedometer Silver Honda Supra X 125 FI New	Cover Body	49000.0
53204K07900ZE	Cover Handle Top Kiri Hijau Honda Blade 110 S K07J	Cover Body	51000.0
53203K07900ZD	Cover Handle Top Kanan Grey Honda Blade 110 S K07J	Cover Body	51000.0
50260KYE940ZD	Cover Body Depan Kanan Silver Honda Mega Pro FI	Cover Body	165500.0
50260KYE940ZC	Cover Body Depan Kanan Grey Honda Mega Pro FI	Cover Body	143500.0
17220KCJ690	Cover Air C Honda Tiger 2000	Cover Body	21500.0
83750K16900WRD	Cover Center Belakang Merah Honda Scoopy FI K16G	Cover Body	207500.0
83650K1ZN40ZH	Cover Body Kiri Putih Type 2 Honda PCX 160 K1Z	Cover Body	410000.0
83500K16900CSR	Cover Body Kanan Merah Maron Honda Scoopy FI K16G	Cover Body	400000.0
77210K18900ZA	Cover Body Samping Kanan Grey Honda Verza 150	Cover Body	175000.0
64560K03N30ZB	Cover Body Kanan Bawah Honda Revo 110 FI	Cover Body	32500.0
64450K07900ZB	Cover Body Kiri Hitam Honda Blade 110 K07	Cover Body	162500.0
64430K45N00WRD	Cover Body Samping Kiri Merah Honda CBR 150R K45A	Cover Body	587000.0
64400K07900ZC	Cover Body Hijau Kanan Honda Blade 110 K07	Cover Body	193000.0
64301K0JN60MIB	Cover Tameng Depan Biru Doff Honda Genio K0JN	Cover Body	228000.0
64301K0JN60MJB	Cover Tameng Depan Brown Honda Genio K0JN	Cover Body	218500.0
61100KZL930YB	Spakbor Depan Biru Honda Spacy Karburator	Cover Body	205500.0
61100KTM850FMX	Spakbor Depan Putih Honda Supra X 125 Injection	Cover Body	174000.0
61100K16A00WRD	Spakbor Depan Merah Honda Scoopy FI K16G	Cover Body	254000.0
53205K16900WRD	Cover Speedometer Atas Honda Scoopy FI K16G	Cover Body	96500.0
53204K07900ZD	Cover Batok Kiri Grey Honda Blade 110 S K07J	Cover Body	51000.0
53203K07900ZE	Cover Batok Kanan Hijau Honda Blade 110 S K07J	Cover Body	51000.0
84152K1ZJ10YJ	Cover Tutup Behel Merah Maron Honda PCX 160 K1Z	Cover Body	121000.0
64430K41N00	Cover Bawah Depan Kanan Honda Supra X 125 FI	Cover Body	25000.0
64200K45NX0ZB	Cover Tameng Depan Oranye Honda CBR 150R K45R	Cover Body	838000.0
61000K56H20ZB	Spakbor Depan A Magenta Honda Sonic 150R K56	Cover Body	239000.0
53280K1AN00ZA	Cover Speedometer Honda BeAT K1A	Cover Body	71500.0
64210K64NP0ZF	Cover Tameng Depan Hitam Doff Honda CBR 250RR K64N	Cover Body	880000.0
83110K45A60ZA	Cover Belakang Kanan Merah Type1 Honda CBR 150R K45R	Cover Body	335000.0
64300K1AN00ZE	Cover Tameng Depan Biru Type 4 Honda BeAT K1A	Cover Body	289500.0
8010AKYZ910ZA	Spakbor Belakang Hitam Honda Supra X 125 Helm-in	Cover Body	81500.0
5320CK47N00ZA	Cover Batok Belakang Honda Blade 125 FI K47	Cover Body	49000.0
64510K07900ZB	Cover Front Top Inner Honda Supra X 125 FI	Cover Body	32500.0
64400K45NX0ZB	Cover Body Samping Kiri Oranye Honda CBR 150R K45R	Cover Body	880000.0
64310K64NP0ZD	Cover Bawah Kanan Merah Honda CBR 250RR K64N	Cover Body	607500.0
64350KYZ900	Cover Body Depan Honda Supra X 125 Helm-In FI	Cover Body	51000.0
8010AK07900	Spakbor Belakang Honda Supra X 125 FI	Cover Body	74000.0
6431AKZLA00ZA	Cover Pijakan Kaki Hitam Honda Spacy Karburator	Cover Body	84500.0
64320KWB920	Cover Body Tengah Honda Blade 110 KWB	Cover Body	51000.0
6431BK47N00ZA	Cover Body Tengah Honda Blade 125 FI K47	Cover Body	236000.0
50280KSPB00	Cover Body Depan Bawah Kanan Honda Mega Pro	Cover Body	20500.0
83130K45A50ZA	Cover Center Belakang Hitam Type 3 Honda CBR 150R K45R	Cover Body	122000.0
83110K45A80ZA	Cover Body Kanan Belakang Hitam Honda CBR 150R K45R	Cover Body	305000.0
64701K0WN00	Braket Adjust Screen Honda ADV 160	Cover Body	325000.0
64440K45A50ZD	Cowl Set Bawah Kiri Grey Type 1 Honda CBR 150R K45R	Cover Body	375000.0
64300K45A50ZA	Cover Body Samping Kanan Set Hitam Doff Honda CBR 150R K45R	Cover Body	863000.0
64200K45A50ZA	Cover Tameng Depan Merah Honda CBR 150R K45R	Cover Body	838000.0
53290K2SN00ZA	Cover Batok Depan Honda Vario 160 K2S CBS	Cover Body	95000.0
53205K1AN00ZT	Cover Batok Kepala Depan Dark Silver Honda BeAT K1A	Cover Body	98000.0
83630K64NP0ZE	Cover Kiri Belakang Biru Doff Honda CBR 250RR K64J	Cover Body	450000.0
83165K64N00MAG	Cover Tangki Kanan Grey Honda CBR 250RR K64J	Cover Body	480000.0
81131K2VN30ZN	Cover Rack Putih Honda Vario 125 eSP K2V	Cover Body	172000.0
81131K2VN30ZJ	Cover Rack Merah Honda Vario 125 eSP K2V	Cover Body	172000.0
64320K64NP0ZF	Cover Bawah Kiri Putih Honda CBR 250RR K64N	Cover Body	450000.0
64320K64NP0ZE	Cover Bawah Kiri Biru Doff Honda CBR 250RR K64N	Cover Body	460000.0
64320K64NP0ZC	Cover Bawah Kiri Hitam Honda CBR 250RR K64N	Cover Body	450000.0
64310K64NP0ZF	Cover Bawah Kanan Putih Honda CBR 250RR K64N	Cover Body	450000.0
64310K64NP0ZE	Cover Bawah Kanan Biru Doff Honda CBR 250RR K64N	Cover Body	460000.0
64310K64NP0ZC	Cover Bawah Kanan Hitam Honda CBR 250RR K64N	Cover Body	450000.0
61100K64NP0ZE	Spakbor Depan Biru Doff Honda CBR 250RR K64J	Cover Body	615000.0
50400K16900	Behel Belakang Silver Honda Scoopy eSP K16R	Cover Body	147000.0
84151K1ZJ10YK	Cover Behel Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	495000.0
64330K47N00ZB	Cover Body Tengah Kiri Silver Honda Blade 125 FI K47	Cover Body	218500.0
83630K64NP0ZG	Cover Kiri Belakang Hitam Honda CBR 250RR K64J	Cover Body	295000.0
83630K64NP0ZF	Cover Kiri Belakang Grey Honda CBR 250RR K64J	Cover Body	380000.0
83500K1AN00MSG	Cover Body Kanan Hijau Doff Honda BeAT K1A	Cover Body	135000.0
64432K1ZJ10YN	Cover Body Bawah Kiri Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	455000.0
64420K1ZJ10YM	Cover B Center Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	115000.0
64330K64NP0MAG	Cover Body Samping Kanan Grey Honda CBR 250RR K64N	Cover Body	1100000.0
64305K1ZJ10YN	Garnish Front Biru Doff (Imperial) Honda PCX 160 K1Z	Cover Body	270000.0
64210K64NP0ZH	Cover Tameng Depan Hitam Metalic Honda CBR 250RR K64J	Cover Body	760000.0
64210K64NP0ZG	Cover Tameng Depan Grey Honda CBR 250RR K64J	Cover Body	1000000.0
64210K64NP0ZE	Cover Tameng Depan Biru Doff Honda CBR 250RR K64J	Cover Body	1025000.0
64600K2SH00ZA	Cover Depan Kiri Merah Doff Honda Vario 160 K2S	Cover Body	289500.0
81130K2FN80ZK	Cover Kantong Hitam Honda Scoopy K2F	Cover Body	86000.0
83650K2FN00NOR	Cover Belakang Orange Honda Scoopy K2F	Cover Body	94500.0
83650K2FN00MGB	Cover Belakang Hitam Doff Honda Scoopy K2F	Cover Body	55000.0
83600K2VN30VRD	Cover Body Kiri Merah Honda Vario 125 eSP K2V	Cover Body	250000.0
83500K2VN30VRD	Cover Body Kanan Merah Honda Vario 125 eSP K2V	Cover Body	250000.0
83131K45NL0MGB	Cowl Tengah Belakang Hitam Honda CBR 150R K45R	Cover Body	175000.0
81142K2FN80ZL	Cover Kantong Putih Honda Scoopy K2F	Cover Body	90000.0
81142K2FN80ZH	Cover Kantong Coklat Honda Scoopy K2F	Cover Body	105000.0
64441K45NL0MBS	Cover Bawah Kiri Silver Honda CBR 150R K45R	Cover Body	375000.0
64321K3BN00MMB	Cowl B Middle Kanan Brown Honda CB150X	Cover Body	450000.0
53206K2FN00YA	Cover Bawah Speedometer Putih Honda Scoopy K2F	Cover Body	115000.0
40510KYE940	Tutup Rantai Honda Mega Pro FI	Cover Body	52000.0
35191KVG901	Cover Cable Honda Vario Techno 125 FI CBS ISS	Cover Body	45000.0
50280K15710	Cover Body Depan Bawah Kanan Honda CB150R StreetFire K15P	Cover Body	67000.0
61000K45NM0ZA	Spakbor Depan Hitam Metalic Honda CBR 150R K45R	Cover Body	394000.0
53207K2FN00MSG	Cover Ring Speedometer Hijau Doff Honda Scoopy K2F	Cover Body	90000.0
84100KVB900ZA	Behel Belakang Silver Honda Vario 110 CW	Cover Body	203500.0
77237KVBN50	Cover Seat Catch Honda Vario 110 Techno	Cover Body	2500.0
64340K47N00ZA	Cover Tengah Honda Blade 125 FI K47	Cover Body	20500.0
64300K1AN00ZG	Cover Tameng Depan Putih Type 2 Honda BeAT dan BeAT Street K1A	Cover Body	254000.0
83751K46N00ZJ	Cover Bawah Tengah Belakang Merah Honda Vario 110 eSP	Cover Body	96500.0
83600K3BN10ZA	Cover Body Set Belakang Kanan Hitam Type 1 Honda CB150X	Cover Body	264000.0
64440K45NL0ZB	Cover Body Set Bawah Kiri Type 4 Honda CBR 150R K45R	Cover Body	416500.0
64340K56N00VRD	Cover Body Atas Samping Kanan Honda Sonic 150R K56	Cover Body	318000.0
64380K07900ZB	Cover Body Bawah Samping Kiri Honda Blade 110 K07A	Cover Body	31000.0
61302K56N00ZG	Garnis Depan Kanan Merah Honda Sonic 150R K56	Cover Body	117000.0
84100KVBN50SBM	Behel Belakang Biru Honda Vario 110 Techno	Cover Body	160000.0
81130K2FN00ZM	Cover Kantong Silver Honda Scoopy K2F	Cover Body	117000.0
64800K56N00	Tray Pgm Fi Unit Honda Sonic 150R K56	Cover Body	6500.0
17575K46N00	Cover Fuel Tank Honda Vario 110 FI	Cover Body	10500.0
64500K0WNB0ZD	Cover Body Set Samping Kiri Depan Merah Doff Honda ADV 160	Cover Body	230000.0
17556K84610ZA	Cover Body Set Kiri Hitam Type 1 Honda CRF150L K84	Cover Body	173000.0
17546K84610ZA	Cover Body Set Kanan Hitam Type 1 Honda CRF150L K84	Cover Body	173000.0
83160K45A20ZA	Cover Tangki Set Sticker Kanan Merah Type 1 Honda CBR 150R K45R	Cover Body	376000.0
81131K59A70YF	Cover Rack Merah Honda Vario 150 eSP K59J	Cover Body	102000.0
83450K2SH00ZC	Cover Body Set Emblem Kanan Hitam Doff Honda Vario 160 K2S	Cover Body	459000.0
83650K64NP0ZD	Cover Seat Lock Putih Honda CBR 250RR K64J	Cover Body	330000.0
61100K59A70ZW	Spakbor Depan Merah Honda Vario 125 eSP K60R	Cover Body	233500.0
64350K0WNA0ZC	Cover Tutup Sisi Tengah Kanan Hitam Doff Honda ADV 160	Cover Body	135000.0
64565K0WNA0ZB	Garnish Floor Kiri Silver Honda ADV 160	Cover Body	94000.0
64336K0WN00ZW	Cover Front Upper Merah Doff Honda ADV 160	Cover Body	133000.0
64530K0WNA0	Cover Under Hitam Honda ADV 160	Cover Body	71000.0
81142K2FN00ZX	Cover Kantong Kiri Oranye Honda Scoopy K2F	Cover Body	117000.0
18612K64N00	Cover Reed Valve Honda CBR 250RR K64J	Cover Body	62000.0
17234KVB900	Cover Saringan Udara Honda Vario 110 CW	Cover Body	7500.0
50265K15900ZE	Cover Body Deapan Kiri Merah Glossy Honda CB150R StreetFire K15	Cover Body	188000.0
64100K64N00ZA	Wind Screen Honda CBR 250RR K64J	Cover Body	122000.0
61110K1AN00ZH	Spakbor Depan Putih Honda BeA K1A	Cover Body	152500.0
84100KVB900ZB	Behel Hitam Honda Vario 110 CW	Cover Body	353000.0
61110K1AN00ZJ	Spakbor Depan Hitam Metalic Honda BeAT K1A	Cover Body	110000.0
61100K2FN00YB	Spakbor Depan Hitam Doff Honda Scoopy K2F	Cover Body	223500.0
83120K45A40ZA	Cover Body Belakang Kiri Grey Honda CBR 150R K45R	Cover Body	305000.0
61100K2FN00YC	Spakbor Depan Hitam Metalic Honda Scoopy K2F	Cover Body	223500.0
83650K2FN00VBE	Cover Belakang Cream Honda Scoopy K2F	Cover Body	122000.0
83605K1AN00ZC	Cover Body Kiri Hitam Metalic Honda BeAT K1A	Cover Body	127000.0
80100K15900	Spakbor Belakang Honda CB150R StreetFire K15	Cover Body	149500.0
64411K45NL0ZB	Cover Body Kiri Merah Honda CBR 150R K45R	Cover Body	863000.0
64360K59A70ZP	Cover Bawah Kiri Merah Honda Vario 150 eSP K59J	Cover Body	137500.0
64350K59A70ZP	Cover Bawah Kanan Merah Honda Vario 150 eSP K59J	Cover Body	137500.0
64321K15720	Cover Bawah Kanan Hitam Honda CB150R StreetFire K15P	Cover Body	51000.0
83151K45NL0MGB	Cover Tangki Tengah Hitam Doff Honda CBR 150R K45R	Cover Body	259000.0
64301K59A70YB	Cover Tameng Depan Merah Honda Vario 150 eSP K59J	Cover Body	233500.0
77230KSPB00	Cowl Center Belakang Honda Mega Pro	Cover Body	10500.0
17225K50T00	Cover Case Saringan Udara Honda BeAT Sporty eSP K25G	Cover Body	62500.0
61303K15710ZA	Cover Depan Samping Kiri Hitam Doff Honda CB150R StreetFire K15P	Cover Body	112000.0
61100K59A70ZS	Spakbor Depan Silver Honda Vario 150 eSP K59J	Cover Body	264000.0
83750K0JN00MJB	Cover Center Belakang Brown Honda Genio	Cover Body	127000.0
64550K41N00	Cover Front Top Inner Cowl Honda Supra X 125 FI	Cover Body	13500.0
86504K15710ZA	Sticker Shroud Bawah Kiri Type 2 Honda CB150R StreetFire K15P	Cover Body	43000.0
86502K15710ZA	Sticker Shroud Atas Kiri Type 2 Honda CB150R StreetFire K15P	Cover Body	22500.0
84151K1ZJ10ZJ	Cover Behel Matte Grey Honda PCX 160 K1Z	Cover Body	439000.0
64301K64NA0ZA	Cowl Bawah Kanan Hitam Type 2 Honda CBR 250RR K64J	Cover Body	584000.0
64301K64N61ZA	Cowl Bawah Kanan Grey Honda CBR 250RR K64J	Cover Body	584000.0
64302K64NB0ZB	Cowl Bawah Kiri Hitam Type 1 Honda CBR 250RR K64	Cover Body	498500.0
61000K45NM0ZB	Spakbor Depan Merah Type 3 Honda CBR 150R K45R	Cover Body	365500.0
61000K1ZN30ZD	Spakbor Depan Hitam Type 3 Honda PCX 160 K1Z	Cover Body	223500.0
64201K0JN00ZL	Cover Samping Kanan Silver Honda Genio	Cover Body	107000.0
83170K64N20ZA	Cover Tangki Kiri Merah Honda CBR 250RR K64	Cover Body	576000.0
64431K97T00YX	Cover Body Bawah Kanan Biru Doff Honda PCX 150 K97	Cover Body	351000.0
64340K45NL0ZA	Cover Bawah Kanan Grey Honda CBR 150R K45R	Cover Body	457000.0
17576K2SN00	Cover No Rangka (Cover Frame Number) Honda Vario 160 K2S	Cover Body	7500.0
84151K97T00YX	Cover Behel Hitam Doff Honda PCX 150 K97	Cover Body	280000.0
83610K0WN00PFW	Cover Body Kiri Putih Mutiara Honda ADV 150	Cover Body	213500.0
83600K59A10ZD	Cover Body Kiri Putih Mutiara Honda Vario 150 eSP K59	Cover Body	603000.0
83111K45NL0ZC	Cover Body Belakang Kanan Grey Honda CBR 150R K45R	Cover Body	305000.0
53205K0JN00ZJ	Cover Speedometer Depan Brown Honda Genio	Cover Body	89500.0
53209K2SN00ZG	Cover Batok Kiri Hitam Honda Vario 160 K2S	Cover Body	93500.0
61100K97T00YS	Spakbor Depan Biru Doff Honda PCX 150 K97	Cover Body	235000.0
64432K97T00YX	Cover Left Floor Side Biru Doff Honda PCX 150 K97	Cover Body	351000.0
64301K0JN00MJB	Cover Tameng Depan Brown Honda Genio	Cover Body	233500.0
64202K0JN00VWH	Cover Depan Kiri Putih Honda Genio	Cover Body	148500.0
64431K0JN00ZL	Cover Left Under Side Silver Honda Genio	Cover Body	107000.0
64421K0JN00ZL	Cover Right Under Side Silver Honda Genio	Cover Body	107000.0
64311K3BN00MCS	Cowl A Right Middle Silver Honda CB150X	Cover Body	200000.0
64421K3BN00VRD	Cowl B Left Middle Merah Honda CB150X	Cover Body	450000.0
64321K3BN00VRD	Cowl B Right Middle Merah Honda CB150X	Cover Body	450000.0
64441K45NL0ZA	Cowl Comp Left Under Merah Honda CBR 150R K45R	Cover Body	457000.0
64341K45NL0ZD	Cowl Comp Right Under Putih Honda CBR 150R K45R	Cover Body	477500.0
64305K97T00YX	Garnish Front Biru Doff Honda PCX 150 K97	Cover Body	263000.0
64305K97T00YY	Garnish Front Hitam Doff Honda PCX 150 K97	Cover Body	257000.0
83510K0WN00PFW	Cover Body Kanan Putih Mutiara Honda ADV 150	Cover Body	213500.0
83500K2SN00MPC	Cover Body Kanan Putih Honda Vario 160 K2S	Cover Body	520000.0
83151K45NL0WRD	Cover Tangki Tengah Merah Honda CBR 150R K45R	Cover Body	239000.0
83110K45A40ZA	Cover Kanan Belakang Grey Honda CBR 150R K45R	Cover Body	305000.0
81138K97T00YS	Outer Right Inner Cover Hitam Doff Honda PCX 150 K97	Cover Body	217000.0
81137K1ZJ10ZR	Lid Smart Emergency Hitam Doff PCX 160 K1Z	Cover Body	96500.0
81137K1ZJ10ZP	Lid Smart Emergency Merah Doff Honda PCX 160 K1Z	Cover Body	96500.0
81133K2SN00MSR	Lid Inner Pocket Merah Doff Honda Vario 160 K2S	Cover Body	97500.0
81133K2SN00MPC	Lid Inner Pocket Putih Honda Vario 160 K2S	Cover Body	105000.0
81131K0JN00ZG	Cover Inner Rack Brown Honda Genio	Cover Body	244000.0
80100K64N00ZA	Spakbor Belakang Honda CBR 250RR K64J	Cover Body	76500.0
77210K18960MGB	Cover Body Kanan Hitam Doff CB150 Verza	Cover Body	188000.0
64502K96V00YG	Cover Depan Kiri Biru Doff Honda PCX 150 K97	Cover Body	400000.0
64501K97T00A2	Cover Kanan Depan Hitam Doff Honda PCX 150 K97	Cover Body	392000.0
53205K2FN00MIB	Cover Speedometer Biru Doff Honda Scoopy K2F	Cover Body	96500.0
83650K2FN00ASB	Cover Belakang Hitam Honda Scoopy K2F	Cover Body	81500.0
83650K2FN00MSR	Cover Belakang Merah Doff Honda Scoopy K2F	Cover Body	96500.0
53207K1ZJ10FMB	Cover Stang Hitam Honda PCX 160 K1Z	Cover Body	132000.0
84152K97T00YW	Lid Grab Rail Cover Matte Blue PCX 150 K97	Cover Body	209000.0
53205K2FN00MSS	Cover Speedometer Silver Honda Scoopy K2F	Cover Body	107000.0
53207K2FN00MJB	Cover Ring Speedometer Brown Honda Scoopy K2F	Cover Body	83500.0
64420K1ZJ10ZP	Cover B Center Merah Doff Honda PCX 160 K1Z	Cover Body	129500.0
83131K45N40ZD	Cowl Rear Center Putih Honda CBR 150R K45G	Cover Body	179000.0
81141K1ZJ10ZP	Lid Inner Pocket Merah Doff (MT SO RED) PCX 160 K1Z	Cover Body	145500.0
81137K97T00YR	Lid Smart Emergency Matte Blue (MA BL MT) PCX 150 K97	Cover Body	171000.0
81139K97T00YV	Outer L Inner kiri (MA BL MT) Honda PCX 150 K97	Cover Body	222000.0
83600K2FN00MIB	Cover L Body (MA BL MT) - Scoopy K2F	Cover Body	264000.0
80151K2FN00ZP	Cover, Center Silver (MT CR SL) - Scoopy K2F	Cover Body	91500.0
80151K2FN00ZM	Cover Center (MA SD SL) - Scoopy K2F	Cover Body	142500.0
80151K2FN00ZK	Cover Center Merah (VA RD) - Scoopy K2F	Cover Body	142500.0
80151K2FN00ZJ	Cover Center (VI BE) - Scoopy K2F	Cover Body	162500.0
64421K2FN00ZN	Cover Under R Sid Biru Doff (MA BL MT) - Scoopy K2F	Cover Body	122000.0
64501K46N00PFW	Cover Kanan Depan Putih - Vario 110 FI	Cover Body	119000.0
83650K1ZN30ZF	Cover Body Kiri Hitam Metalic Honda PCX 160 K1Z	Cover Body	386000.0
80103KVB900	Tahanan Lumpur (Guard Splash) - Honda Vario 110 CW	Cover Body	5000.0
81200K25900	Behel (Rail RR Grab) - BeAT FI CBS K25,BeAT Sporty eSP K25G	Cover Body	138500.0
80100K56N00	Spakbor Belakang (Fender A Rear) - Honda New Sonic 150R	Cover Body	69500.0
64301K81N00MCS	Cover Tameng Depan silver doff - Honda BeAT eSP New (K81)	Cover Body	426500.0
53206K2FN00ZJ	Cover Bawah Speedometer Cream Honda Scoopy eSP K2F	Cover Body	91500.0
64240K45NZ0ZA	Cover Depan Bawah (Set Illus Fr Lower Cowl Type1) - Honda CBR 150R K45R	Cover Body	208500.0
81142K2FN00ZM	Lid Left Pocket MA SD SL (Matt Silver) - Honda Scoopy eSP K2F	Cover Body	102000.0
83171K45NL0ZB	Cover Tanki kiri Merah (Cover Left Fuel Tank VA Red) - Honda CBR 150R K45R	Cover Body	376000.0
83171K45NL0ZA	Cover Tangki Kiri Orange (Cover Left Fuel Tank NI OR) - Honda CBR 150R K45R	Cover Body	386000.0
83151K45NL0RSW	Cover Tangki Tengah Putih (Cover Fuel Tank Center RO White) - Honda CBR 150R K45R	Cover Body	269500.0
50211KREG00	Rubber Right Tank Guard - Honda CRF 150L	Cover Body	10000.0
17556K84970ZA	Cover Body Set Kiri Hijau Type 1 Honda CRF 150L	Cover Body	173000.0
17546K84970ZA	Cover Body Kanan (Set Illust R Shroud Type 1) - Honda CRF 150L	Cover Body	173000.0
83120K45NA0ZA	Cover Body Kiri - Honda New CBR 150R K45N	Cover Body	203500.0
64310K46N20ZA	Step Floor - Honda Vario 110 FI 64310K46N20ZA	Cover Body	105000.0
53205K1AN00ZJ	Cover Batok Kepala Depan Biru Honda BeAT K1A	Cover Body	208000.0
53207K1AN20ZA	Cover Speedometer Bawah Honda BeAT Streed K1A	Cover Body	15500.0
80100K81N00ZA	Set Illust RR Fender - Honda New BeAT Sporty eSP, BeAT eSP New (K81)	Cover Body	91500.0
37241K18960	Case Meter Lower - Honda CB150 Verza	Cover Body	10500.0
53140KEH600	Grip Comp R Throttle - Honda Mega Pro Advance	Cover Body	32500.0
61100K81N00ZH	Spakbor Depan Silver Honda BeAT eSP New K81	Cover Body	168000.0
64502K0WN01ZF	Cover Depan Samping Kiri Silver Honda ADV 150	Cover Body	406500.0
61100K16A00ZA	Spakbor Depan Cream Honda Scoopy FI	Cover Body	246000.0
64340KVY700	Cover Body Under (Bawah) Honda Beat Karbu	Cover Body	103000.0
8010AK15900	Fender RR Assy CBR 150R Street Fire K15G	Cover Body	160000.0
50260K15600RSW	Cover Body Depan Kanan Putih Honda New CB150R StreetFire K15M	Cover Body	297500.0
53207K0JN00ZA	Cover Speedometer Bawah Hitam Honda New Genio K0J	Cover Body	36000.0
8125AKYT940	Bagasi (Box Assy Luggage) - Honda Scoopy Karburator	Cover Body	97000.0
64505K97T00YK	Mold R Head Light MA JB MT Hitam Doft - Honda PCX 150 K97	Cover Body	237000.0
84151K97T00YJ	Cover Behel Brown Honda New PCX 150 K97	Cover Body	317000.0
64500K07900ZB	Tameng Depan (Cover FR Top Black) - Honda Blade 125 FI K47 64500K07900ZB	Cover Body	233500.0
64601K46N00WRD	Body Depan Kiri (Cover L FR Red) - Honda Vario 110 eSP 64601K46N00WRD	Cover Body	218500.0
64450K41N00ZC	Body Depan Kiri (Cover L FR Black) - Honda Supra X 125 FI 64450K41N00ZC	Cover Body	190000.0
53250K0JN00ZB	Cover Belakang Speedometer Merah Honda Genio	Cover Body	147500.0
50202K56N10	Holder,Coupler Supra GTR 150	Cover Body	12500.0
64223K1AN00	Stay Comp,FR Cover - BeAT K1A	Cover Body	68500.0
64505K97T00YL	Mold,R Head Light Silver - PCX 150 K97	Cover Body	186000.0
64506K97T00YK	Mold,L Head Light Coklat Doff - PCX 150 K97	Cover Body	237000.0
83510K97T00YH	Cover Body Kanan Coklat Doff (Cover,R Body (MA-JB-MT)) - PCX 150 K97	Cover Body	420000.0
81141K97T00ZV	Lid,Inner Pocket Coklat Doff - PCX 150 K97	Cover Body	263000.0
84152K97T00YK	Lid,Grab Ril Cover Silver - PCX 150 K97	Cover Body	210500.0
61100K0JN00VWH	Spakbor Depan Putih Honda Genio	Cover Body	338500.0
5032BK56N00	Box Aki (Box Battery) Honda Sonic 150R	Cover Body	43000.0
35191K44V01	Cover Cable - Genio & Vario 110 eSP	Cover Body	5500.0
83520K0JN00ZF	Set Ils,RR Cntr Cvr Typ 3 - Genio	Cover Body	122000.0
61000K0WN10ZA	Spakbor Depan Putih Type 2 Honda ADV 150	Cover Body	233500.0
53206K93N00ZR	Cover B, Spidometer Merah - Scoopy eSP K93	Cover Body	107000.0
8015BK07900	Cover R License Light - Honda Blade 110	Cover Body	8000.0
64250K0JN10ZE	Set Illus,L FR Cover Type 2 - Genio	Cover Body	157500.0
5033AK56N00	Cover Assy Battery Set - New Sonic 150R	Cover Body	15500.0
50311K97T00	Stay R FR Cover E MT - New PCX 150 K97	Cover Body	88500.0
64502K0WN00ZC	Cover L FR Side WN RD (Merah) - ADV 150	Cover Body	376000.0
64502K0WN00ZA	Cover L FR Side MT ME BR (Coklat Metalic) - ADV 150	Cover Body	233500.0
53205KVLN00WRD	Cover Handle FR WN RD - Supra X 125 53205KVLN00WRD	Cover Body	139500.0
83650K56H30ZA	Cover Set L Body WL Type 1 - Sonic 150R	Cover Body	206000.0
83650K0WN10ZA	Set Illust L Body Cover T2 - ADV 150	Cover Body	239000.0
83550K0WN10ZA	Set Illust R Body Cover Type 2 - ADV 150	Cover Body	239000.0
83130K45NA0ZA	Set Illust RR Center Cowl Type 2 Hitam Doff - New CBR 150R K45N	Cover Body	150000.0
83600K0JN00HSM	Cover Body Kiri (Left Body) Silver Metalic - Honda Genio	Cover Body	609500.0
83600K0JN00PBL	Cover Body Kiri (Cover Left Body) Hitam Metalic - Honda Genio	Cover Body	472500.0
83600K0JN00RSW	Cover Kiri Body (Cover Left Body) Putih Mutiara - Honda Genio	Cover Body	473500.0
83610K0WN00FMB	Cover L Body Hitam - ADV 150	Cover Body	233500.0
83610K0WN00DSM	Cover L Body Silver Metalic - ADV 150	Cover Body	325000.0
83500K0JN00RSW	Cover Belakang (Rear Body) Putih Mutiara - Honda Genio	Cover Body	473500.0
83500K0JN00VRD	Cover Kanan (Right Body) Merah - Honda Genio	Cover Body	472500.0
83650K93N00ZR	Cover RR Center Lower Putih Mutiara - Scoopy eSP (K93)	Cover Body	118000.0
83750K0JN00MBM	Cover RR Center Coklat Metalic - Honda Genio	Cover Body	118000.0
83750K0JN00PBL	Cover Belakang Tengah Hitam Metalic - Honda Genio	Cover Body	122000.0
83750K0JN00RSW	Cover Belakang (Rear Center) Putih Mutiara - Honda Genio	Cover Body	118000.0
83750K0JN00VRD	Cover Belakang Merah - Honda Genio	Cover Body	118000.0
81139K0WN00ZB	Garnish Lower Inner Cover Silver Metalic - ADV 150	Cover Body	102000.0
64501K0WN00ZC	Cover R FR Side Merah - ADV 150	Cover Body	376000.0
64501K0WN00ZA	Cover R FR Side Coklat Metalic - ADV 150	Cover Body	233500.0
64431K0JN00ZH	Cover Kiri Bawah (Left Under Side) Biru Metalic - Honda Genio	Cover Body	203500.0
64202K0JN00ZH	Cover Depan Kiri Biru Metalic Honda Genio	Cover Body	203500.0
81134K0JN00ZA	Cover Inner Upper Coklat Metalik - Genio	Cover Body	61000.0
81131K0JN00ZF	Cover Inner Rack Biru Metalik - Genio	Cover Body	589000.0
80151K93N00YB	Cover Center Hitam Doff - Scoopy eSP K93	Cover Body	381000.0
61100K93N00ZY	Spakbor Depan Merah Honda Scoopy eSP K93	Cover Body	320000.0
61100K0JN00RSW	Spakbor Depan Putih Mutiara Honda Genio	Cover Body	315000.0
64301K0JN00RSW	Cover FR Top RO WH - Honda Genio	Cover Body	472500.0
53206K0JN00VRD	Cover Speedometer Belakang Merah Honda Genio	Cover Body	142500.0
53206K0JN00PBL	Cover Belakang Speedometer Hitam Metalik Honda Genio	Cover Body	142500.0
53206K0JN00ARB	Cover Belakang Speedometer Biru Metalic Honda Genio	Cover Body	183000.0
53205K0JN00ZB	Cover Speedometer Depan Merah Honda Genio	Cover Body	117000.0
53205K0JN00ZD	Cover Speedometer Depan Putih mutiara Honda Genio	Cover Body	117000.0
64336K0WN00ZA	Cover FR Upper MT ME BR - Honda ADV 150	Cover Body	162500.0
64336K0WN00ZF	Cover FR Upper DG SL MT - Honda ADV 150	Cover Body	225500.0
64310K56NF0ZA	Set Illust R Side Upper Cover Type 2 - New Sonic 150R	Cover Body	152500.0
83130K45N40ZB	Cowl Set RR Center WL Type 2 Black - New CBR 150R K45G K45N	Cover Body	185000.0
64410K56NH0ZA	Cover Body Kiri (Set Illust L Side Upper Cover Type 1 Hitam Doft) - New Sonic 150R K56	Cover Body	173000.0
64310K56NH0ZA	Cover Body Kanan (Set Illust R Side Upper Cover Type 1 Hitam Doft) - New Sonic 150R K56	Cover Body	152500.0
64310K56H90ZB	Cover Body Kanan Doff - New Sonic 150R K56	Cover Body	230000.0
64410K56H90ZB	Cover Body Kiri (Set Illust L Side Upper Cowl Type 1 BB Doft) - New Sonic 150R K56	Cover Body	230000.0
64410K45N60ZA	Cover Body Kiri (Cowl Set L Middle A Type 1 Red) - New CBR 150R K45G K45N	Cover Body	697500.0
64306K0WN10ZB	Set Illust,L Center Side Cover Type 1 - ADV 150	Cover Body	178000.0
64310K45N60ZA	Cover Body Kanan (Cowl Set R Middle A WL Type 1 Red) - New CBR 150R K45G K45N	Cover Body	697500.0
64310K45N40ZA	Cover Body Kanan (Cowl Set R Middle A WL Type 2) Black - New CBR 150R K45G K45N	Cover Body	672500.0
64405K56NG0ZA	Cover Body (Set Illust L Side Lower Cowl Merah Type 1) - New Sonic 150R K56	Cover Body	137500.0
64305K56NG0ZA	Cover Body (Set Illust R Side Lower Cowl Merah Type 1) - New Sonic 150R K56	Cover Body	137500.0
83130K45NH0ZA	Set Illust RR Center Cowl Type 3 Hitam Doft - New CBR 150R K45G K45N	Cover Body	130000.0
83650K56NF0ZB	Set Illust L Body Cover Type 1 Hitam Doft - Sonic 150R K56	Cover Body	127000.0
83650K56NF0ZA	Set Illust L Body Cover Type 2 Hitam - Sonic 150R K56	Cover Body	127000.0
83600K56NH0ZA	Set Illust R Body Cover Type 1 Black Doft - Sonic 150R K56	Cover Body	127000.0
83600K56NF0ZA	Set Illust R Body Cover Type 2 Hitam - Sonic 150R K56	Cover Body	127000.0
64305K56H60ZA	Set Illust R Side Lower Type 1 Red - Sonic 150R K56	Cover Body	170000.0
61100K59A10FMB	Spakbor Depan Hitam Honda Vario 125 eSP K60	Cover Body	201000.0
83650K56H00ZC	Cover Set L Body WL (Hitam) - Sonic 150R K56	Cover Body	215500.0
83600K56H00ZB	Cover Set R Body WL (Merah) - Sonic 150R K56	Cover Body	355000.0
64440K45N40ZB	Cowl Set L Under WL Type 2 - CBR 150R K45G K45N	Cover Body	326000.0
64410K56N70ZA	Cover Set L Side Upper WL Type 1 - Sonic 150R K56	Cover Body	239000.0
64410K56N20ZA	Cover Set L Side Upper WL (Orange) - Sonic 150R K56	Cover Body	263000.0
61000K56N20ZA	Spakbor Depan A Hitam Honda Sonic 150R K56 Repsol	Cover Body	201000.0
61000K56N00ZB	Spakbor Depan A Merah Honda Sonic 150R K56	Cover Body	300000.0
64340K45N50ZA	Cowl Set R Under WL - CBR 150R K45G K45N	Cover Body	363500.0
64410K45N50ZA	Body Kiri (Cowl Set L Middle A WL) - CBR 150R K45N	Cover Body	697500.0
83175K64N00NOR	Cover Tangki Kiri (Cover L Tank NI OR) - CBR 250RR K64	Cover Body	570000.0
83130K45N50ZA	Body Belakang (Cowl Set RR Center) WL - CBR 150R K45N	Cover Body	206500.0
64310K56N20ZA	Cover Set R Side Upper WL - Sonic 150R K56	Cover Body	320000.0
81131K59A70YC	Cover Rack Ma Bl Mt - New Vario 150 eSP K59J	Cover Body	152500.0
64360K59A70ZM	Cover Body Bawah Kiri - New Vario 150 eSP K59J	Cover Body	254000.0
53208K59A70YC	Cover Batok Atas Biru Doff Honda New Vario 150 eSP K59J	Cover Body	142500.0
83600K59A70ZY	Cover Body Belakang Kiri (Cover L Body (Ma Jb Mt/Brown) - Vario 150 eSP K59J	Cover Body	355500.0
83500K59A70ZY	Cover Body Belakang Kanan (Cover R Body (Ma Jb Mt/Brown) - Vario 150 eSP K59J	Cover Body	355500.0
64301K59A70YA	Cover Front (Ma Jb Mt/Brown) - Vario 150 eSP K59J	Cover Body	233500.0
61304K56N00ABM	Garnis Bawah Hitam Doff Honda Sonic 150R K56	Cover Body	84500.0
53208K59A70YA	Cover Speedometer Coklat Doff Honda Vario 150 K59J	Cover Body	142500.0
61100K25600ZC	Spakbor Depan Biru Honda BeAT eSP K25	Cover Body	130000.0
83600K81N00MGB	Cover L Body Black Matte - New BeAT Sporty eSP K81	Cover Body	244000.0
64320K56N00WRD	Cowl R Side Lower Red - Sonic 150R K56	Cover Body	165500.0
61100K56N00ZE	Spakbor Depan A Hitam Doft Honda Sonic 150R K56	Cover Body	153500.0
64420K56N00VRD	Cowl L Side Lower Va Rd - Sonic 150R K56	Cover Body	158500.0
83165K64N00MSR	Cover R Tank Mate Red - CBR 250RR K64	Cover Body	645000.0
77237K59A70	Cover Seat Catch - New Vario 125 eSP K60R & New Vario 150 eSP K59J	Cover Body	4500.0
64300K45N40ZA	Cowl Assy R Undercover - New CBR 150R K45N	Cover Body	188000.0
77210K18960INS	Cover Body Kanan (Cowl R Side) Silver - CB 150 Verza	Cover Body	206500.0
61100K18900ZD	Spakbor Depan Hitam Honda Verza 150 FI	Cover Body	194000.0
50270K18960FMB	Cover Body Depan Kiri Hitam Honda CB 150 Verza	Cover Body	95500.0
50260K18960FMB	Cover Body Depan Kanan Hitam Honda CB 150 Verza	Cover Body	95500.0
83165K64N00FMB	Cover Tangki Kanan (Cover R Tank) Black - CBR 250RR K64	Cover Body	528000.0
83450K64K00BGL	Single Seat Cowl Black Freedom (Glosy) - CBR 250RR K64	Cover Body	710500.0
83500K46N00RSW	Cover Body Kanan Putih - Vario 110 eSP	Cover Body	291500.0
64410K45N40ZA	Cover Body Kiri (Cowl Set L Middle A WL Type 2 Black ) - New CBR 150R K45G K45N	Cover Body	672500.0
83750K46N00ZB	Cover Belakang (Cover Rear Center) Putih - Vario 110 FI	Cover Body	61000.0
83600K46N00CSR	Cover Body Kiri Merah Maroon - Vario 110 FI	Cover Body	331000.0
83500K46N00CSR	Cover Right Body Red - Vario 110 FI	Cover Body	332000.0
53205K46N20ARM	Cover Batok Kepala Depan merah Honda Vario 110 eSP	Cover Body	152500.0
83500K46N00FMB	Cover Kanan Body (Cover Right Body) Hitam - Vario 110 FI	Cover Body	257000.0
53205K46N20RSW	Cover Batok Kepala Depan Putih Honda Vario 110 eSP	Cover Body	158000.0
83600K59A70ZQ	Cover L Body White - New Vario 125 eSP	Cover Body	581000.0
53205K25900VBM	Cover Batok Kepala Depan Biru Honda BeAT FI & BeAT FI CBS (K25)	Cover Body	109000.0
83500KVY960FMB	Cover R Body Black - BeAT Karburator (KVY)	Cover Body	175000.0
83600KVY960FMB	Cover L Body Black - BeAT Karburator (KVY)	Cover Body	175000.0
83500K59A70ZM	Cover R Body WN Red - New Vario 125 eSP (K60R)	Cover Body	629500.0
83600K59A70ZM	Cover L Body WN Red - New Vario 125 eSP (K60R)	Cover Body	629500.0
53208K59A70ZL	Cover Batok Atas Merah Honda Vario 125 eSP K60R	Cover Body	170000.0
83600K25900AFB	Cover L Body AF BK MT - BeAT FI, BeAT CBS FI K25	Cover Body	197000.0
83500K25900AFB	Cover Body Kanan Grey BeAT CBS FI K25	Cover Body	197000.0
64301K25900BLG	Cover Depan (Cover Front) Hijau- BeAT FI (K25)	Cover Body	289500.0
64301K59A70ZS	Cover Front Silver - Vario 150 New K59J	Cover Body	242000.0
64360K59A70ZD	Cover Left Under Side (Merah) - New Vario 150 K59J	Cover Body	591000.0
83600K59A70ZS	Cover Body Kiri Silver - New Vario 150 K59J	Cover Body	430500.0
53205K61900ZD	Cover Batok Depan Biru Honda BeAT POP eSP	Cover Body	137500.0
81142K93N00ZJ	Lid Pocket Putih- Scoopy eSP K93	Cover Body	132500.0
64506K97T00ZW	Mold Headlight Kiri Gold - PCX 150 K97	Cover Body	280000.0
81137K97T00ZS	Lid Smart Emg Gold - PCX 150 K97	Cover Body	253000.0
81141K97T00ZK	Lid Inner Pocket Gold - PCX 150 K97	Cover Body	309000.0
83510K97T00ZN	Cover Body Kanan Hitam - PCX 150 K97	Cover Body	414000.0
83750K93N00ZN	Cover, RR Center Putih - Scoopy eSP (K93)	Cover Body	294500.0
83500K61900FMB	Cover Body Kanan Hitam - BeAT POP eSP	Cover Body	198000.0
53205K61900VBM	Cover Batok Depan Biru Honda BeAT POP eSP	Cover Body	130000.0
83600K61900FMB	Cover Body Kiri Hitam - BeAT POP eSP	Cover Body	233500.0
80110K84900ZB	Set Illus, A Rear Fender - CRF 150L	Cover Body	558500.0
83600KZL930ZE	Cover Body Kiri Hitam - Spacy	Cover Body	225500.0
64421K16900VBM	Cover Under R SD Biru - Scoopy FI	Cover Body	137500.0
61302K15900ZA	Cowl R FR SD Silver - CB150R StreetFire (Old)	Cover Body	89500.0
80121KC5010	Mudguard RR - GL MAX	Cover Body	4500.0
53205KEV830FMB	Cover Handle FR Hitam - Supra	Cover Body	76500.0
53205KPH890FMH	Cover Handle FR Silver - Kharisma	Cover Body	73500.0
53205KVLN00POV	Cover Handle FR Hitam - Supra X 125 Injection	Cover Body	139500.0
53205KZLA00ZA	Cover Batok Depan Hijau Honda Spacy	Cover Body	153500.0
53205KFVB50FMB	Cover FR Handle Hitam - Supra Fit New	Cover Body	76500.0
53205KTM860FMH	Cover Handle FR Silver - Supra X 125	Cover Body	174000.0
64301KVB930JGM	Cover FR (Cover Body Depan) Hijau - Vario Karbu	Cover Body	313000.0
64301KVBN50AFB	Cover FR (Cover Body Depan) Hitam - Vario Karbu	Cover Body	293500.0
50260KBW900BNS	Cover Body Depan Kanan Hitam Honda Tiger	Cover Body	73500.0
8010AKWB920	Spakbor Belakang (Fender Assy RR) - Blade Karbu	Cover Body	73500.0
64410KTL690FMH	Cover Body Kanan Silver - Supra Fit New	Cover Body	218500.0
64420KTL690FMH	Cover Body Kiri Silver - Supra Fit New	Cover Body	218500.0
64420KYZ900ZA	Cover Body Kiri Hitam Metallic - Supra X 125 Helm In	Cover Body	254000.0
53205K46N00CSR	Cover batok Kepala Depan Merah Honda Vario 110 eSP	Cover Body	173000.0
64450KTL690FMT	Cover L M/P ( Cover Samping Tengah )Biru - Revo 100	Cover Body	259000.0
64455KPH700	Louver L Silver ( Cover Sayap Tengah ) - Supra X 125 & Supra X 125 Injection	Cover Body	42000.0
64470KWWA60	Cover R FR LWR - Revo 110 New	Cover Body	13000.0
35194K35V31	Kunci Jok (Emergency Key) Honda PCX 150 K97	Key Set (Kunci Kontak)	44000.0
35121K59A71	Remot (Fob) Honda New Vario 150 K59J	Key Set (Kunci Kontak)	305000.0
35111K59A71	Remot (Fob) Honda New Vario 150 K59J	Key Set (Kunci Kontak)	332000.0
35010K81N00	Kunci Kontak (Key Set) Honda BeAT Sporty eSP K81	Key Set (Kunci Kontak)	245500.0
35121K84901	Bahan Kunci (Key Blank) Honda CRF 150L	Key Set (Kunci Kontak)	39000.0
35111K2SN01	Remot (Fob) Honda Vario 160 K2S	Key Set (Kunci Kontak)	330000.0
3501AK60B00	Kunci Kontak Honda Vario 125 eSP LED	Key Set (Kunci Kontak)	274500.0
3501AK59A10	Kunci Kontak+Transmiter Honda Vario 150 eSP	Key Set (Kunci Kontak)	755000.0
35010K25900	Kunci Kontak (Key Set) Honda BeAT FI K25	Key Set (Kunci Kontak)	269500.0
3501AKZR600	Kunci Kontak Honda Vario Techno 125 FI	Key Set (Kunci Kontak)	295000.0
35010K1AN00	Kunci Kontak (Key Set) Honda BeAT K1A	Key Set (Kunci Kontak)	329500.0
35101K97T01	Kunci Kontak (Switch Handle Lock) Honda PCX 150 K97	Key Set (Kunci Kontak)	584500.0
35115K59A11	Cover Konci Kontak Honda Vario 150 eSP K59	Key Set (Kunci Kontak)	35500.0
35100K84901	Kunci Kontak Honda CRF 150L	Key Set (Kunci Kontak)	200000.0
35100K59A71	Kunci Kontak (Switch Handel Lock) Honda New Vario 150 K59J	Key Set (Kunci Kontak), Switch	471500.0
35010K56N00	Kunci Kontak (Key Set) Honda Sonic 150R	Key Set (Kunci Kontak)	348000.0
35100K1AN01	Kunci Kontak Honda BeAT K1A	Key Set (Kunci Kontak)	228500.0
35010K25610	Kunci Kontak (Key Set) Honda BeAT Sporty eSP	Key Set (Kunci Kontak)	179000.0
3501AK93N00	Kunci Kontak Honda New Scoopy eSP K93	Key Set (Kunci Kontak)	248500.0
3501AKZRB20	Kunci Kontak Honda Vario 125 FI CBS ISS	Key Set (Kunci Kontak)	289500.0
35141K59A71	SCU, Smart Control Unit Honda Vario 150 K59J	Key Set (Kunci Kontak)	893500.0
35121KVY900	Bahan Kunci (Key Blank) Honda BeAT eSP K81	Key Set (Kunci Kontak)	24500.0
3W0MIY6F	Honda CB150 Verza	motor	38295000.0
35101K59A71	Kunci Kontak (Switch Handle Lock) Honda Vario 150 eSP K59J	Key Set (Kunci Kontak)	396000.0
35010K41N00	Kunci Kontak (Key Set) Honda Supra 125 FI	Key Set (Kunci Kontak)	330000.0
35010K56N10	Kunci Kontak (Key Set) Honda Supra GTR	Key Set (Kunci Kontak)	299500.0
35010K15920	Kunci Kontak (Key Set) Honda New CB150R StreetFire K15G	Key Set (Kunci Kontak)	705500.0
35010K45N00	Kunci Kontak (Key Set) Honda CBR 150 K45A	Key Set (Kunci Kontak)	953500.0
35141K2FN11	SCU, Smart Control Unit Honda Scoopy eSP K2F	Key Set (Kunci Kontak)	731000.0
72147K93N02	Transmitter Assy - Scoopy eSP (K93)	Key Set (Kunci Kontak)	305000.0
35010KVB930	Kunci Kontak (Key Set) Honda Vario Karbu	Key Set (Kunci Kontak)	229500.0
35010K45N40	Kunci Kontak (Key Set) Honda New CBR 150R K45G	Key Set (Kunci Kontak)	780000.0
35100K59A72	Kunci Kontak (Switch Handle Lock) Honda Vario 150 eSP K59J	Key Set (Kunci Kontak)	447000.0
35121K97N00	Remot (Fob) Honda PCX 150 K97	Key Set (Kunci Kontak)	979000.0
35010KVLN00	Kunci Kontak (Key Set) Honda Supra X 125	Key Set (Kunci Kontak)	249500.0
35141K97N00	SCU, Smart Control Unit Honda PCX 150 K97	Key Set (Kunci Kontak)	1376000.0
35010K25600	Kunci Kontak (Key Set) Honda BeAT POP eSP	Key Set (Kunci Kontak)	271500.0
35194K53D01	Set Emergency Key - New Vario 150 eSP K59J	Key Set (Kunci Kontak)	149500.0
35010GN5830	Kunci Kontak (Key Set) Honda Grand	Key Set (Kunci Kontak)	175000.0
35110K0JN01	Kunci Kontak (Bahan Kunci) Honda Genio	Key Set (Kunci Kontak)	112000.0
35121K45N40	Bahan Kunci (Key Blank) Honda New CBR 150R K45N	Key Set (Kunci Kontak)	41000.0
35010KWWA60	Kunci Kontak (Key Set) Honda Revo Absolute	Key Set (Kunci Kontak)	152500.0
3510AK46N00	Kunci Kontak (Key Set) Honda Vario 110 FI	Key Set (Kunci Kontak)	272500.0
35010KVBN50	Kunci Kontak (Key Set) Honda Vario Karbu CBS	Key Set (Kunci Kontak)	348500.0
35141K2SN01	SCU, Smart Control Unit Honda Vario 160 K2S	Key Set (Kunci Kontak)	893500.0
35010KTM780	Kunci Kontak (Key Set) Honda Supra X 125 Injection	Key Set (Kunci Kontak)	248000.0
35194K1ZJ11	Kunci Jok (Emergency Key) Honda PCX 160 K1Z	Key Set (Kunci Kontak)	56000.0
35121K1AN00	Bahan Kunci (KeyBlank) Honda BeAT K1A	Key Set (Kunci Kontak)	38000.0
35100GN5830	Kunci Kontak (Switch Assy Comb) - Grand Inpresa	Key Set (Kunci Kontak)	149500.0
3501AK16A40	Kunci Kontak+Transmiter Honda Scoopy eSP K16	Key Set (Kunci Kontak)	745000.0
35111K0WN02	Remot (Fob) Honda ADV 150	Key Set (Kunci Kontak)	558500.0
35100K2SN01	Kunci Kontak (Switch Handle Lock) Honda Vario 160 K2S	Key Set (Kunci Kontak)	467000.0
3510AK46N20	Kunci Kontak Honda New Vario 110 eSP	Key Set (Kunci Kontak)	223500.0
3501AKZRB11	Kunci Kontak Honda Vario 125 FI CBS	Key Set (Kunci Kontak)	344000.0
35010KYT940	Kunci Kontak (Key Set) Honda Scoopy Karbu	Key Set (Kunci Kontak)	346500.0
64315KWW660	Cover Comb & Lock Switch Honda Revo 110 FI	Key Set (Kunci Kontak)	4500.0
35100K1ZU11	Kunci Kontak (Switch Handle Lock) Honda PCX 160 K1Z	Key Set (Kunci Kontak)	558500.0
35110K46N01	Kunci Kontak (Bahan Kunci) Honda Scoopy eSP (K93)	Key Set (Kunci Kontak)	133000.0
35101K2SN01	Kunci Kontak (Switch Handle Lock) Honda Vario 160 K2S	Key Set (Kunci Kontak)	396000.0
35101K1ZU11	Kunci Kontak (Switch Handle Lock) Honda PCX 160 K1Z	Key Set (Kunci Kontak)	457000.0
35101K46N01	Kunci Kontak Honda Vario 110 eSP	Key Set (Kunci Kontak)	122000.0
35010KVY960	Kunci Kontak (Key Set) Honda BeAT Karbu	Key Set (Kunci Kontak)	267500.0
35010K03N31	Kunci Kontak (Key Set) Honda Revo 110 FI	Key Set (Kunci Kontak)	303500.0
35010K64N00	Kunci Kontak (Key Set) Honda All New CBR 250RR	Key Set (Kunci Kontak)	1889500.0
35012K45N40	Kunci Kontak (Bahan Kunci) CBR 150R K45N	Key Set (Kunci Kontak)	154500.0
35010KEV650	Kunci Kontak (Key Set) Honda Supra	Key Set (Kunci Kontak)	147000.0
35010KZLA00	Kunci Kontak (Key Set) Honda Spacy	Key Set (Kunci Kontak)	349000.0
35141K0WNA0	SCU, Smart Control Unit Honda ADV 160	Key Set (Kunci Kontak)	933000.0
35101K2FN11	Kunci Kontak (Switch Handle Lock) Honda Scoopy eSP K2F	Key Set (Kunci Kontak)	322000.0
35010K15921	Kunci Kontak (Key Set) - Honda New CB150R Streetfire	Key Set (Kunci Kontak)	649000.0
35010K15901	Kunci Kontak (Key Set) Honda CB150R StreetFire Old	Key Set (Kunci Kontak)	604500.0
35110K60B61	Kunci Kontak (Bahan Kunci) Honda Vario 125 eSP K60R	Key Set (Kunci Kontak)	138000.0
35010K84901	Kunci Kontak (Key Set) Honda CRF150L K84	Key Set (Kunci Kontak)	1052000.0
35010KWB920	Kunci Kontak (Key Set) Honda Blade 110	Key Set (Kunci Kontak)	273000.0
35010KYZ710	Kunci Kontak (Key Set) Honda Supra Helm In FI	Key Set (Kunci Kontak)	277000.0
35010KWWA00	Kunci Kontak (Key Set) Honda Revo FIT	Key Set (Kunci Kontak)	349500.0
35012K59A11	Kunci Kontak (Key Set) Honda Vario 150 eSP K59	Key Set (Kunci Kontak)	475000.0
35141K1ZN20	SCU, Smart Control Unit Honda PCX 160 K1Z	Key Set (Kunci Kontak)	1370500.0
35100K64N01	Kunci Kontak Honda CBR 250RR K64	Key Set (Kunci Kontak)	873500.0
35100K45N41	Kunci Kontak Honda CBR 150R K45N	Key Set (Kunci Kontak)	198000.0
38420K46N01	Transmitter Assy ( Remote ) Honda Vario 110 FI	Key Set (Kunci Kontak)	228500.0
35010KVR600	Kunci Kontak (Key Set) Honda Revo Karbu	Key Set (Kunci Kontak)	279500.0
35010K41N20	Kunci Kontak (Key Set) Honda Supra 125 FI New	Key Set (Kunci Kontak)	257000.0
35141K2VN40	SCU, Smart Control Unit Honda Vario 125 eSP K2V	Key Set (Kunci Kontak)	936000.0
35121K56N00	Bahan Kunci (Key Blank) Honda CB150X	Key Set (Kunci Kontak)	67000.0
35121K1ZN20	Remot (Fob) Honda PCX 160 K1Z	Key Set (Kunci Kontak)	326500.0
35110K59A12	Kunci Kontak (Bahan Kunci) Honda Vario 125 eSP K60	Key Set (Kunci Kontak)	134500.0
77240KTM851	Kunci Jok (Kunci Lock Assy Seat) - Honda BeAT eSP New (K81), CB150 Verza, Supra X 125, Verza 150	Key Set (Kunci Kontak)	76500.0
35110K81N01	Kunci Kontak (Bahan Kunci) Honda BeAT eSP K81	Key Set (Kunci Kontak)	93500.0
35010KCJ690	Kunci Kontak - Key Set Tiger	Key Set (Kunci Kontak)	620500.0
35010K18901	Kunci Kontak (Key Set) Honda Verza	Key Set (Kunci Kontak)	639500.0
6ITJCEPI	Honda Sonic 150R	motor	64517000.0
35121K46N00	Bahan Kunci (Key Blank) Honda Vario 125 eSP	Key Set (Kunci Kontak)	29500.0
35100K2FN12	Kunci Kontak (Switch Handle Lock) Honda Scoopy K2F	Key Set (Kunci Kontak)	396000.0
35010K41N21	Kunci Kontak (Key Set) Honda Supra X 125 FI	Key Set (Kunci Kontak)	294500.0
17620K84902	Tutup Tangki Honda CRF150L K84	Key Set (Kunci Kontak), Tangki Bensin (Fuel Tank)	784000.0
35010K03N50	Kunci Kontak (Key Set) Honda Revo FIT FI	Key Set (Kunci Kontak)	175000.0
35010KPH900	Kunci Kontak (Key Set) Honda Kharisma	Key Set (Kunci Kontak)	150500.0
35110KWWA01	Kunci Kontak (Bahan Kunci) Honda Revo 110 FI	Key Set (Kunci Kontak)	138500.0
35121K0WNA0	Remot (Fob) Honda ADV 160	Key Set (Kunci Kontak)	331000.0
35110K1AN01	Kunci Kontak (Bahan Kunci) Honda BeAT K1A	Key Set (Kunci Kontak)	173000.0
35010K0JN00	Kunci Kontak (Key Set) Honda Genio	Key Set (Kunci Kontak)	233500.0
35110K56N02	Kunci Kontak (Bahan Kunci) Honda Sonic 150R	Key Set (Kunci Kontak)	155500.0
35010KEV950	Kunci Kontak (Key Set) Honda Supra Fit	Key Set (Kunci Kontak)	145500.0
35141K97N32	SCU, Smart Control Unit Honda PCX 150 K97	Key Set (Kunci Kontak)	1421500.0
35111K97N02	Remot (Fob) Honda PCX 150 K97 ABS	Key Set (Kunci Kontak)	979000.0
17620KEH601	Cap Comp Fuel Filler Honda Mega Pro Advance	Key Set (Kunci Kontak), Tangki Bensin (Fuel Tank)	362500.0
35010KYZ900	Kunci Kontak (Key Set) Honda Supra Helm In Karbu	Key Set (Kunci Kontak)	368000.0
3501AK16A00	Kunci Kontak Honda Scoopy	Key Set (Kunci Kontak)	302000.0
35141K2VV10	Set Smart Control Unit Honda Vario 125 eSP K2V	Key Set (Kunci Kontak)	800000.0
35141K1ZN40	SCU, Smart Control Unit Honda PCX 160 K1Z	Key Set (Kunci Kontak)	1370500.0
35010KYE940	Kunci Kontak (Key Set) Honda Mega Pro FI	Key Set (Kunci Kontak)	726000.0
35121K2VN40	Remote (Fob) Honda Vario 125 eSP K2V	Key Set (Kunci Kontak)	355500.0
35011KVY900	Kunci Kontak (Bahan Kunci) Honda BeAT Karburator	Key Set (Kunci Kontak)	190000.0
35010K18900	Kunci Kontak (Key Set) Honda Verza 150	Key Set (Kunci Kontak)	736000.0
35121KWWA00	Bahan Kunci (Key Blank) Honda Revo 110 FI	Key Set (Kunci Kontak)	28500.0
35101K1ZJ11	Kunci Kontak (Switch Handle Lock) Honda ADV 160	Key Set (Kunci Kontak)	450000.0
35121K59A10	Bahan Kunci+Transmiter (Key Blank) Honda Vario 150 eSP K59	Key Set (Kunci Kontak)	137500.0
35141K0WN02	SCU, Smart Control Unit Honda ADV 150	Key Set (Kunci Kontak)	1376000.0
77239KVB900	Kunci Jok (Key Seat Lock) - Supra GTR 150 & CB150R Streetfire K15G	Jok, Key Set (Kunci Kontak)	44500.0
35101K1AN01	Kunci Kontak Honda BeAT K1A	Key Set (Kunci Kontak)	173000.0
35101K0JN01	Kunci Kontak Honda Genio	Key Set (Kunci Kontak)	168000.0
3510AK46N30	Kunci Kontak+Transmiteer Honda Vario 110 FI	Key Set (Kunci Kontak)	695500.0
35010K47N00	Kunci Kontak Honda Blade 110 New	Key Set (Kunci Kontak)	237000.0
3501AK16A20	Kunci Kontak - Key Set Scoopy FI	Key Set (Kunci Kontak)	838000.0
35100KZLA00	Kunci Kontak Honda Spacy Karburator	Key Set (Kunci Kontak)	311000.0
35141K2FN91	SCU, Smart Control Unit Honda Scoopy K2F	Key Set (Kunci Kontak)	731000.0
35012K45NL0	Kunci Kontak (Bahan Kunci) Honda CBR 150R K45R	Key Set (Kunci Kontak)	160500.0
35113K27V51	Teransmiter Honda Vario 150 eSP K59	Key Set (Kunci Kontak)	108000.0
35110K25901	Kunci Kontak (Bahan Kunci) Honda BeAT Sporty eSP K25G	Key Set (Kunci Kontak)	117000.0
35010K15710	Kunci Kontak (Key Set) Honda CB150R StreetFire K15P	Key Set (Kunci Kontak)	786000.0
35010K64N04	Kunci Kontak (Key Set) Honda CBR 250RR K64	Key Set (Kunci Kontak)	1575000.0
35100K1ZJ11	Kunci Kontak (Switch Handle Lock) Honda ADV 160	Key Set (Kunci Kontak)	570000.0
35010K45NL0	Kunci Kontak (Key Set) Honda CBR 150R K45R	Key Set (Kunci Kontak)	773500.0
35110KZR601	Kunci Kontak (Bahan Kunci) Honda Vario Techno 125 Helm-In FI	Key Set (Kunci Kontak)	116000.0
35010KVLN20	Kunci Kontak (Key Set) Honda Supra X 125 Injection	Key Set (Kunci Kontak)	278000.0
35010K45N41	Kunci Kontak (Key Set) Honda New CBR 150R K45G	Key Set (Kunci Kontak)	771000.0
35010K18961	Kunci Kontak (Key Set) Honda CB Verza 150	Key Set (Kunci Kontak)	1059500.0
35121K0WN00	Kunci Remot (Fob) Honda ADV 150	Key Set (Kunci Kontak)	558500.0
35100KEV650	Kunci Kontak Honda Supra 100	Key Set (Kunci Kontak)	128500.0
77239K45N41	Konci Buka Jok (Lock Assy Seat) - CBR 150R K45G&K45N	Key Set (Kunci Kontak)	85000.0
35111K2FN91	Remot (Fob) Honda Scoopy K2F	Key Set (Kunci Kontak)	369000.0
35010K64NP0	Kunci Kontak (Key Set) Honda CBR 250RR K64J	Key Set (Kunci Kontak)	1575000.0
35101KZR601	Kunci Kontak Honda Vario Techno 125 FI CBS ISS	Key Set (Kunci Kontak)	122000.0
35100K15711	Kunci Kontak Honda CB150R StreetFire K15P	Key Set (Kunci Kontak)	213500.0
35101K03N31	Kunci Kontak Honda Revo 110 FI	Key Set (Kunci Kontak)	147500.0
35100K60B62	Kunci Kontak (Key Set) Honda Vario 125 eSP K60R	Key Set (Kunci Kontak)	261000.0
35101K97A01	Kunci Kontak Honda Vario 125 eSP K60R	Key Set (Kunci Kontak)	137500.0
38410K60B61	Control Unit Answer Back Honda Vario 125 eSP K60R	Key Set (Kunci Kontak)	426500.0
35100K64N02	Kunci Kontak Honda CBR 250RR K64J	Key Set (Kunci Kontak)	822500.0
35010K3BN00	Kunci Kontak (Key Set) Honda CB150X	Key Set (Kunci Kontak)	792000.0
17620KREG02	Tutup Tanki (Cap Comp Fuel Filler) - Honda CBR 150R K45R, New CB150R Streetfire New CBR 150R K45G	Key Set (Kunci Kontak), Tangki Bensin (Fuel Tank)	490500.0
77239K64N01	Kunci Set (Key Seat Lock Wave) - Honda All New CBR 250RR	Key Set (Kunci Kontak)	333000.0
35121K97N01	Remot (Fob) Honda PCX 150 K97	Key Set (Kunci Kontak)	979000.0
35011KYE900	Kunci Kontak (Bahan Kunci) Honda CB150 Verza	Key Set (Kunci Kontak)	149500.0
35121KYE900	Bahan Kunci (Key Blank) Honda CBR K45 K45N	Key Set (Kunci Kontak)	25500.0
35010GN5781	Kunci Kontak (Key Set) Honda Old Type	Key Set (Kunci Kontak)	169500.0
35111K97N23	Remot (Fob) Honda PCX 150 K97 Hybrid	Key Set (Kunci Kontak)	1066000.0
35100K64NP1	Kunci Kontak Honda CBR 250RR K64N	Key Set (Kunci Kontak)	873500.0
35121KYZ900	Bahan Kunci (Key Blank) Honda Supra X 125 FI	Key Set (Kunci Kontak)	39000.0
35101K25901	Kunci Kontak Honda BeAT Sporty eSP K25G	Key Set (Kunci Kontak)	146000.0
77110KCJ660	Kunci Jok Honda Tiger Revolution	Key Set (Kunci Kontak)	100000.0
77239K64N03	Kunci Jok Honda CBR 250RR K64J	Key Set (Kunci Kontak)	376000.0
35121K0WN01	Remot (Fob) Honda ADV 150	Key Set (Kunci Kontak)	558500.0
35121K2FN11	Remot (Fob) Honda New Scoopy K2F	Key Set (Kunci Kontak)	330000.0
77239K64N02	Key Seat Lock Wave Honda CBR 250RR K64J	Key Set (Kunci Kontak)	376000.0
35100K3BN01	Kunci Kontak Honda CB150X	Key Set (Kunci Kontak)	228500.0
35141K97N02	SCU, Smart Control Unit Honda PCX 150 K97	Key Set (Kunci Kontak)	1421500.0
35100K2FN11	Kunci Kontak (Switch Handel Lock) Honda Scoopy K2F	Key Set (Kunci Kontak), Switch	396000.0
35100K60B61	Kunci Kontak (Key set) Honda New Vario 125 eSP K60R	Key Set (Kunci Kontak)	282000.0
35141K0WN01	SCU, Smart Control Unit Honda ADV 150	Key Set (Kunci Kontak)	1376000.0
35101K81N01	Kunci Kontak Honda BeAT eSP K81	Key Set (Kunci Kontak)	113500.0
35100K81N01	Kunci Kontak Honda BeAT eSP K81	Key Set (Kunci Kontak)	184500.0
88110KCJ660	Spion Kanan New CB150R Streetfire K15G, New CB150R Streetfire K15M, Old CB150R StreetFire & Tiger Revo	Spion	47000.0
88120KZR600	Spion Kiri (Mirror left) - Vario 125 eSP & Vario 150 eSP	Spion	43000.0
88110KZR600	Spion Kanan (Mirror Right) - Vario 125 eSP & Vario 150 eSP	Spion	43000.0
88210K97N01	Spion Kanan (Mirror Comp R) - PCX 150 K97	Spion	61500.0
88220K97N01	Spion Kiri (Mirror Comp L) - PCX 150 K97	Spion	61500.0
88120KCJ660	Spion Kiri New CB150R K15G, New CB150R K15M, Old CB150R Tiger Revo	Spion	47000.0
88120K25900	Spion Kiri (Mirror Left) BeAT eSP, Vario 110 eSP	Spion	38000.0
88110KWWA40	Spion Kanan (Mirror Right Back) - Supra X 125 FI	Spion	36000.0
88120KWWA40	Spion Kiri (Mirror Left Back) - Supra X 125 FI	Spion	36000.0
88110K25900	Spion Kanan (Mirror Right Back) BeAT FI, BeAT Sporty eSP, BeAT POP eSP	Spion	38000.0
88115KWN980	Cap Lock Nut Karet Spion	Spion	8500.0
45517K81N30	Holder Mirror - Scoopy eSP K93, New Vario 125 eSP K60R, New Vario 150 eSP K59J	Spion, Suku Cadang Resmi Motor Honda	26500.0
88210K59A70	Spion Kanan (Mirror Comp R) - New Vario 150 K59J & New Vario 125 K60R	Spion	50000.0
88211K93N00ZB	Spion Brown - Scoopy eSP K93	Spion	61000.0
33400K15921	Lampu Sein Kanan Depan Honda CB150R StreetFire K15G	Lampu Sein (Winker)	136000.0
33450K15921	Lampu Sein Kiri Depan Honda New CB150R StreetFire K15G	Lampu Sein (Winker)	136000.0
33452K15920	Rubber L Winker Mounting - New CBR 150R K45G, All New CBR 250RR, New CB150R Streetfire K15G & New CB150R Streetfire K15M	Karet (Rubber), Lampu Sein (Winker)	3000.0
34908GA7701	Bohlam Sein Dan Speedometer 12V/3,4W Honda BeAT Sporty eSP	Bohlam (Bulb) Depan, Sein & Belakang, Lampu Sein (Winker)	6000.0
33412K15920	Rubber R Winker Mounting - New CB150R Streetfire K15G, New CB150R Streetfire K15M, New CBR 150R K45G & All New CBR 250RR	Karet (Rubber), Lampu Sein (Winker)	3000.0
34905KANW01	Bohlam Sein (12V10W) Honda BeAT eSP	Bohlam (Bulb) Depan, Sein & Belakang, Lampu Sein (Winker)	15000.0
34905GM9003	Bohlam Sein 12V/10W Honda Vario 110 Karbu	Bohlam (Bulb) Depan, Sein & Belakang, Lampu Sein (Winker)	8500.0
33450K81N01	Lampu Sein Kiri Depan Honda New BeAT eSP K81	Lampu Sein (Winker)	43000.0
33400K81N01	Lampu Sein Kanan Depan Honda New BeAT eSP	Lampu Sein (Winker)	43000.0
33402K1AN01	Winker Comp,R FR - BeAT K1A	Lampu Sein (Winker)	43000.0
33600K15921	Lampu Sein Kanan Belakang Honda New CB150R StreetFire K15G	Lampu Sein (Winker)	138000.0
33650K15921	Lampu Sein Kiri Belakang Honda New CB150R StreetFire K15G	Lampu Sein (Winker)	138000.0
33400K45NA1	Lampu Sein Depan Kanan Honda CBR 150R K45N	Lampu Sein (Winker)	129000.0
33452K1AN01	Lampu Sein Kiri Depan Honda BeAT K1A	Lampu Sein (Winker)	43000.0
33650K59A71	Lampu Sein Kiri Bekalang Honda New Vario 150 K59J	Lampu Sein (Winker)	115500.0
33450K25901	Lampu Sein Kiri Depan Honda BeAT FI	Lampu Sein (Winker)	44500.0
33650K84901	Lampu Sein Kiri Belakang Honda CRF 150L	Lampu Sein (Winker)	110000.0
33450K45NA1	Lampu Sein Kiri Depan Honda CBR 150R K45N	Lampu Sein (Winker)	129000.0
33400K0WN01	Lampu Sein Kanan DepanHonda ADV 150	Lampu Sein (Winker)	107500.0
33450K0WN01	Lampu Sein Kiri Depan Honda ADV 150	Lampu Sein (Winker)	107500.0
33450K84901	Lampu Sein Kiri Depan Honda CRF 150L	Lampu Sein (Winker)	110000.0
33400K25901	Lampu Sein Kanan Depan Honda BeAT FI	Lampu Sein (Winker)	44500.0
33600K59A71	Lampu Sein Belakang Kanan Honda New Vario 150 K59J	Lampu Sein (Winker)	115500.0
33404K0JN01	Lens Winker R FR - Genio	Lampu Sein (Winker)	12500.0
34910KZLA01	Bohlam Sein (12V/10W) Honda Spacy	Bohlam (Bulb) Depan, Sein & Belakang, Lampu Sein (Winker)	18500.0
33410K2FN01	Lampu Sein Kanan Depan Honda Scoopy K2F	Lampu Sein (Winker)	63000.0
33400K93N01	Winker Comp R FR (Lampu Sein Kanan Depan) - Scoopy eSP (K93)	Lampu Sein (Winker)	163000.0
33602K93N01	Lampu Sein Kanan Belakang Honda Scoopy eSP K93	Lampu Sein (Winker)	74000.0
33450KVLN01	Lampu Sein Kiri Depan Honda Supra X 125	Lampu Sein (Winker)	67000.0
33400KVLN01	Lampu Sein Kanan Depan Supra X 125 Injection	Lampu Sein (Winker)	67000.0
33650K45N41	Lampu Sein Kiri Belakang Honda New CBR 150R K45G	Lampu Sein (Winker)	137000.0
33454K0JN01	Mika Lampu Sein Kiri Depan Honda Genio	Lampu Sein (Winker)	12500.0
33402K0JN01	Lampu Sein Kanan Depan Honda Genio	Lampu Sein (Winker)	40000.0
33600K84901	Lampu Sein Kanan Belakang Honda CRF 150L	Lampu Sein (Winker)	110000.0
33452K0JN01	Lampu Sein Kiri Depan Honda Genio	Lampu Sein (Winker)	40000.0
33410K56N11	Lampu Sein Depan Kanan Honda Supra GTR 150	Lampu Sein (Winker)	208000.0
33460K56N11	Lampu Sein Kiri Depan Honda Supra GTR 150	Lampu Sein (Winker)	208000.0
33602K2FN01	Lampu Sein Kanan Belakang Honda Scoopy K2F	Lampu Sein (Winker)	61000.0
33455K0JN01	Rumah Lampu Sein Kiri Depan Honda Genio	Lampu Sein (Winker)	20500.0
33400KZR601	Lampu Sein Kanan Depan Honda Vario 125 FI	Lampu Sein (Winker)	53000.0
33652K93N01	Lampu Sein Kiri Belakang Honda Scoopy eSP K93	Lampu Sein (Winker)	74500.0
33600K45NA1	Lampu Sein Kanan Belakang Honda New CBR 150R K45N	Lampu Sein (Winker)	124000.0
33400K84901	Lampu Sein Kanan Depan Honda CRF 150L	Lampu Sein (Winker)	107000.0
33600K64N01	Lampu Sein Kanan Belakang Honda CBR 250RR	Lampu Sein (Winker)	120500.0
33650K45NA1	Lampu Sein Kiri Belakang Honda CBR 150R K45N	Lampu Sein (Winker)	124000.0
33450K61901	Lampu Sein Kiri Depan Honda BeAT POP eSP	Lampu Sein (Winker)	39000.0
33400K61901	Lampu Sein Kanan Depan Honda BeAT POP eSP	Lampu Sein (Winker)	39000.0
34905KSSC02	Bohlam Sein 12V/10W Honda BeAT eSP New	Bohlam (Bulb) Depan, Sein & Belakang, Lampu Sein (Winker)	20500.0
33420K93N01	Lampu Sein Kiri Depan Honda New Scoopy eSP K93	Lampu Sein (Winker)	71000.0
33460K41N01	Lampu Sein Kiri Depan Honda New Supra X 125 FI	Lampu Sein (Winker)	96000.0
33420K2FN01	Lampu Sein Kiri Depan Honda Scoopy K2F	Lampu Sein (Winker)	63000.0
33650K64N01	Lampu Sein Kiri Belakang Honda CBR 250RR	Lampu Sein (Winker)	120500.0
33113K20901	Pipe CP Honda Beat FI	Lampu Belakang (Back Light), Lampu Depan (Headlight), Lampu Sein (Winker)	6500.0
33650KYT901	Lampu Sein Kiri Belakang Honda Scoopy Karburator	Lampu Sein (Winker)	107000.0
33450KVB931	Lampu Sein Kiri Depan Honda Vario 110 Karburator	Lampu Sein (Winker)	51000.0
33652K2FN01	Lampu Sein Kiri Belakang Honda Scoopy K2F	Lampu Sein (Winker)	61000.0
33450KZR601	Lampu Sein Kiri Depan Honda Vario 125 FI	Lampu Sein (Winker)	53000.0
33452KZZJ00	Rubber Winker Mouer - CRF 250 Rally, SH150i, New Vario 125 eSP K60R, New Vario 150 eSP K59J	Lampu Sein (Winker), Suku Cadang Resmi Motor Honda	41000.0
33410K41N01	Lampu Sein Kanan Depan Honda New Supra X 125 FI	Lampu Sein (Winker)	95000.0
33410K93N01	Lampu Sei Kanan Depan Honda Scoopy eSP K93	Lampu Sein (Winker)	71000.0
33652K0JN01	Lampu Sein Kiri Belakang Honda Genio	Lampu Sein (Winker)	30500.0
33460K07901	Lampu Sein Kiri Depan Honda New Blade	Lampu Sein (Winker)	88500.0
33113KVBT01	Pipe Cp Honda Supra X 125 FI New	Lampu Belakang (Back Light), Lampu Depan (Headlight), Lampu Sein (Winker)	4500.0
33600K18961	Lampu Sein Kanan Belakang Honda CB150 Verza	Lampu Sein (Winker)	117000.0
33400KVB931	Winker Assy R FR - Vario Karburator	Lampu Sein (Winker)	51000.0
33113MAT611	Pipe Cp Honda CB150 Verza	Lampu Belakang (Back Light), Lampu Depan (Headlight), Lampu Sein (Winker)	4500.0
33650K18961	Lampu Sein Kiri Belakang Honda CB150 Verza	Lampu Sein (Winker)	117000.0
33400K41N01	Lampu Sein Kanan Depan Honda Supra X 125 FI	Lampu Sein (Winker)	116500.0
33400K18961	Lampu Sein Kanan Depan Honda CB150 Verza	Lampu Sein (Winker)	121500.0
33450K18961	Lampu Sein Kiri Depan Honda CB150 Verza	Lampu Sein (Winker)	117000.0
33752K03N31	Mika Lampu Sein Kiri Honda Revo 110 FI	Lampu Sein (Winker)	17500.0
33402K16901	Lampu Sein Kanan Depan Honda Scoopy eSP K16	Lampu Sein (Winker)	86500.0
33400K16901	Lampu Sein Kanan Depan Honda Scoopy eSP	Lampu Sein (Winker)	100500.0
33450KCJ651	Lampu Sein Kiri Depan - Tiger New Revo	Lampu Sein (Winker)	99500.0
33651K25901	Mika Lampu Sein Kiri Honda BeAT FI CBS	Lampu Sein (Winker)	10000.0
33401KCJ661	Rumah Lampu Sein Kanan Honda Tiger 2000	Lampu Sein (Winker)	13500.0
33650K15601	Lampu Sein Kiri Belakang Honda CB150R StreetFire K15P	Lampu Sein (Winker)	123000.0
33600K15601	Lampu Sein Kanan Belakang Honda CB150R StreetFire K15G	Lampu Sein (Winker)	123000.0
33450KYE901	Lampu Sein Kiri (Winker Assy L FR) - Mega Pro New	Lampu Sein (Winker)	130000.0
33657K93N01	Soket Lampu Sein Kiri Belakang Honda Scoopy eSP (K93)	Lampu Sein (Winker)	10500.0
33604K0JN01	Mika Lampu Sein Kanan Belakang Honda Genio	Lampu Sein (Winker)	11500.0
33602K0JN01	Lampu Sein Kanan Belakang Honda Genio	Lampu Sein (Winker)	38500.0
33450KYZ901	Lampu Sein Kiri Depan Honda Supra X 125 Helm-In	Lampu Sein (Winker)	137500.0
33452K16901	Lampu Sein Kiri Depan Honda Scoopy eSP K16	Lampu Sein (Winker)	86500.0
33410K07901	Lampu Sein Kanan Depan Honda New Blade	Lampu Sein (Winker)	88500.0
33450KWC901	Lampu Sein Kiri Depan - Honda CS1	Lampu Sein (Winker)	68500.0
33702K03N31	Mika Lampu Sein Kanan Honda Revo 110 FI	Lampu Sein (Winker)	17500.0
33452K3BH00	Rubber Winker Mounting Kiri Honda CBR 150R K45R	Karet (Rubber), Lampu Sein (Winker)	4000.0
34908KVE900	Bohlam Speedometer Honda Scoopy eSP K16R	Bohlam (Bulb) Depan, Sein & Belakang, Lampu Sein (Winker)	3000.0
33453K18961	Mika Lampu Sein Kiri Belakang Honda CB150 Verza	Lampu Sein (Winker)	28500.0
33654K0JN01	Mika Lampu Sein Kiri Belakang Honda Genio	Lampu Sein (Winker)	11500.0
33150K56N01	Soket Lampu Sein Depan Honda Sonic 150R K56	Lampu Sein (Winker)	43000.0
34905KSSC01	Bohlam Sein (12V 10W) Honda Supra X 125 Helm In	Bohlam (Bulb) Depan, Sein & Belakang, Lampu Sein (Winker)	19000.0
33412K3BH00	Rubber Winker Mounting Kanan Honda CBR 150R K45R	Karet (Rubber), Lampu Sein (Winker)	4000.0
33453KVB931	Rumah Lampu Sein Depan Kiri Honda Vario 110 CW	Lampu Sein (Winker)	10500.0
33600K45N41	Lampu Sein Kanan Belakang Honda New CBR 150R K45G	Lampu Sein (Winker)	137000.0
33455K41N01	Soket Lampu Sein Kiri Depan Honda Supra X 125 FI New	Lampu Sein (Winker)	14500.0
33450K15601	Lampu Sein Kiri Depan Honda CB150R StreetFire	Lampu Sein (Winker)	121000.0
33410K07971	Lampu Sein Kanan Depan Honda New Blade 110 K07A	Lampu Sein (Winker)	88500.0
33460K03N31	Lampu Sein Kiri Depan Honda Revo FI	Lampu Sein (Winker)	64000.0
33400KYE901	Lampu Sein Kanan Depan - Mega Pro 2010	Lampu Sein (Winker)	138000.0
33650KYE901	Lampu Sein Kiri Belakang - Mega Pro 2010	Lampu Sein (Winker)	138000.0
33600K56NJ1	Lampu Sein Kanan Belakang Honda Supra GTR K56W	Lampu Sein (Winker)	122000.0
33403KVB931	Rumah Lampu Sein Depan Kanan Honda Vario 110 CW	Lampu Sein (Winker)	10500.0
33600K15901	Lampu Sein Kanan Honda CB150R StreetFire K15	Lampu Sein (Winker)	130000.0
33650K15901	Lampu Sein Kiri Belakang (Winker Assy L RR) - CB150R StreetFire K15	Lampu Sein (Winker)	130000.0
33455K07901	Socket Lampu Sein Kiri Depan Honda Blade 125 FI	Lampu Sein (Winker)	17500.0
33400K15901	Lampu Sein Kanan (Winker Assy R FR) - CB150R StreetFire Old	Lampu Sein (Winker)	130000.0
33403K18961	Lens Comp Winker Right - Honda CB150 Verza, Supra GTR 150	Lampu Sein (Winker)	28500.0
33400KZLA01	Winker Assy Right Front - Honda Spacy	Lampu Sein (Winker)	150500.0
33600KCJ651	Lampu Sein Kanan (Winker Assy R RR) - Tiger New Revolution	Lampu Sein (Winker)	94500.0
33410K03N31	Lampu Sein Kanan Depan Honda Revo FI	Lampu Sein (Winker)	64000.0
33450K41N01	Lampu Sein Kiri Depan Honda Supra X 125 FI	Lampu Sein (Winker)	116500.0
33450KZLA01	Lampu Sein Kiri Depan Honda Spacy	Lampu Sein (Winker)	150500.0
33450K93N01	Winker Comp L FR (Lampu Sein Kiri Depan) - Scoopy eSP (K93)	Lampu Sein (Winker)	73500.0
33600KFE701	Lampu Sein Kanan Belakang - Phantom	Lampu Sein (Winker)	583000.0
33400KWB921	Lampu Sein Kanan Depan - Blade	Lampu Sein (Winker)	37000.0
33652K16901	Lampu Sein Belakang Kiri Honda Scoopy eSP K16R	Lampu Sein (Winker)	68500.0
33650K56NJ1	Lampu Sein Kiri Belakang Honda Supra GTR K56W	Lampu Sein (Winker)	122000.0
33602K16901	Lampu Sein Belakang Kanan Honda Scoopy eSP K16R	Lampu Sein (Winker)	68500.0
33650K18901	Lampu Sein Belakang Kiri Honda Verza 150	Lampu Sein (Winker)	130000.0
33400K18901	Lampu Sein Depan Kanan Honda Verza 150	Lampu Sein (Winker)	130000.0
33400K15601	Lampu Sein Kanan Depan Honda CB150R StreetFire K15P	Lampu Sein (Winker)	121000.0
33457K16901	Soket Lampu Sein Kiri Depan Honda Scoopy eSP K16R	Lampu Sein (Winker)	19500.0
33600KYE901	Lampu Sein Kanan Honda Mega Pro	Lampu Sein (Winker)	124000.0
33607K16901	Soket Lampu Sein Kanan Belakang Honda Scoopy FI K16G	Lampu Sein (Winker)	10500.0
33657K16901	Soket Lampu Sein Kiri Belakang Honda Scoopy FI K16G	Lampu Sein (Winker)	10500.0
33450K15901	Lampu Sein Kiri (Winker Assy L FR) - CB150R StreetFire K15	Lampu Sein (Winker)	130000.0
33403K84901	Lampu Sein Kanan Belakang Honda CRF 150L	Lampu Sein (Winker)	31500.0
33450KYT901	Lampu Sein (Winker Assy L FR) - Scoopy Karburator	Lampu Sein (Winker)	70500.0
33450KVBN51	Lampu Sein (Winker Assy L FR) - Vario Karburator	Lampu Sein (Winker)	57000.0
33400KYZ901	Lampu Sein Kanan Depan Honda Supra X 125 Helm-In	Lampu Sein (Winker)	137500.0
33400KVBN51	Lampu Sein (Winker Assy R FR) - Vario 2	Lampu Sein (Winker)	57000.0
33450K16901	Lampu Sein Kiri Depan Honda Scoopy FI	Lampu Sein (Winker)	100500.0
33650KCJ661	Winker Assy L RR (Lampu Sein Kiri Belakang) - Tiger	Lampu Sein (Winker)	94500.0
33450KPH881	Lampu Sein Kiri Depan - Kharisma	Lampu Sein (Winker)	22500.0
33400KCJ651	Lampu Sein Kanan Depan - Tiger New Revolution	Lampu Sein (Winker)	99500.0
33650KEH601	Lampu Sein Kiri Belakang - Mega Pro Advance	Lampu Sein (Winker)	56000.0
33450KVR602	Lampu Sein Kiri Depan - Revo	Lampu Sein (Winker)	37000.0
33450K3VN01	Lampu Sein Depan Kiri Honda Stylo 160	Lampu Sein (Winker)	320000.0
33450K45TA1	Lampu Sein Depan Kiri Honda CBR 150R K45N	Lampu Sein (Winker)	159500.0
33400K45TA1	Lampu Sein Depan Kanan Honda CBR 150R K45N	Lampu Sein (Winker)	159500.0
33451KCJ661	Rumah Lampu Sein Kiri Honda Tiger 2000	Lampu Sein (Winker)	13500.0
33403KVY961	Rumah Lampu Sein Depan Kanan Honda BeAT Karburator KVY	Lampu Sein (Winker)	10500.0
33452K64TG0	Rubber Winker Mounting Kiri Honda CBR 250RR K64N	Karet (Rubber), Lampu Sein (Winker)	15000.0
33412K64TG0	Rubber Winker Mounting Kanan Honda CBR 250RR K64N	Karet (Rubber), Lampu Sein (Winker)	15000.0
33453KVY961	Rumah Lampu Sein Kiri Depan Honda BeAT Karburator KVY	Lampu Sein (Winker)	10500.0
33113GCCB50	Pipe Cp Honda Scoopy eSP K16R	Lampu Belakang (Back Light), Lampu Depan (Headlight), Lampu Sein (Winker)	5500.0
33650K16901	Lampu Sein Kiri Belakang Honda Scoopy FI K16G	Lampu Sein (Winker)	81500.0
33403KVBN51	Rumah Lampu Sein Depan Kanan Honda Vario 110 Techno	Lampu Sein (Winker)	42000.0
33453KVBN51	Rumah Lampu Sein Depan Kiri Honda Vario 110 Techno	Lampu Sein (Winker)	42000.0
33600KYE941	Lampu Sein Belakang Kanan Honda Mega Pro FI	Lampu Sein (Winker)	93500.0
33450K07971	Lampu Sein Depan Kiri Honda Blade 125 FI K47	Lampu Sein (Winker)	120000.0
33600KEH601	Lampu Sein Kanan (Winker Assy R RR) - Mega Pro Advance	Lampu Sein (Winker)	56000.0
33650KCJ651	Lampu Sein Kiri Belakang (Winker Assy L RR) - Tiger	Lampu Sein (Winker)	94500.0
33460K07971	Lampu Sein Kiri Depan Honda New Blade 110	Lampu Sein (Winker)	88500.0
33450K07901	Lampu Sein Kiri Depan Honda Blade 110 K07A	Lampu Sein (Winker)	125000.0
33400K07901	Lampu Sein Kanan Depan Honda New Blade	Lampu Sein (Winker)	120000.0
34905KYJ901	Bulb Winker(PY21W) - CBR 150, New CBR 250, CBR150R K45A	Lampu Sein (Winker)	356500.0
33400KYT901	Lampu Sein Depan Kanan (Winker Assy Right Front)- Honda Scoopy eSP K16R	Lampu Sein (Winker)	70500.0
33450KVY961	Lampu Sein Depan Kiri (Winker Assy Left Front) - Honda BeAT Karbu	Lampu Sein (Winker)	39000.0
33453K84901	Mika Lampu Sein kiri Belakang Honda CRF 150L	Lampu Sein (Winker)	31500.0
33605K0JN01	Rumah Lampu Sein Kanan Belakang Honda Genio	Lampu Sein (Winker)	20500.0
33655K0JN01	Rumah Lampu Sein Kiri Belakang Honda Genio	Lampu Sein (Winker)	20500.0
33450KEH601	Lampu Sein Kiri (Winker Assy L FR) - Mega Pro Advance	Lampu Sein (Winker)	61000.0
33400KVY961	Lampu Sein (Winker Assy R FR) - BeAT Karburator	Lampu Sein (Winker)	39000.0
33400KEH601	Lampu Sein (Winker Assy R FR) - MegaPro Advance	Lampu Sein (Winker)	61000.0
33600KCJ661	Lampu Sein Kanan Belakang (Winker Assy R RR) - Tiger	Lampu Sein (Winker)	94500.0
34908GA7008	Bohlam Sein (Bulb W Base) - Win	Bohlam (Bulb) Depan, Sein & Belakang, Lampu Sein (Winker)	4500.0
33400KVR601	Lampu Sein Kanan Depan - Revo	Lampu Sein (Winker)	36000.0
33450KTL690	Lampu Sein Kiri Depan - Honda Revo	Lampu Sein (Winker)	25500.0
33400K07971	Lampu Sein Kanan Depan Honda New Blade	Lampu Sein (Winker)	120000.0
Q6KZ53B7	Honda Revo	motor	18612000.0
W6V9VKB7	Honda Supra X	motor	19757000.0
USDH47JT	Honda Supra GTR 150	motor	23157000.0
W445GZJA	Honda Super Cub	motor	24021000.0
1NJVNSS8	Honda EM1 e	motor	27578000.0
EBS5G7G6	Honda BeAT	motor	28227000.0
3BGBUUXW	Honda Genio	motor	33628000.0
0L3GJEES	Honda Scoopy	motor	36747000.0
UQ5S5I7A	Honda Vario 125 eSP	motor	90501000.0
PBY5BIF1	Honda Vario 160	motor	22342000.0
Y3IKXQFX	Honda Stylo 160	motor	27222000.0
BPPKJNK8	Honda PCX	motor	31962000.0
1AUAKCTW	Honda ADV 160	motor	34702000.0
IK3M1135	Honda Forza	motor	38752000.0
CQ6HNG4W	Honda CB150R StreetFire	motor	83617000.0
9H74D4C4	Honda CB150X	motor	92333000.0
95QB93MJ	Honda CBR 150R	motor	0.0
0JD2KD8W	Honda CRF150L	motor	0.0
PE31W7XC	Honda CBR 250RR	motor	0.0
T6H2Y65M	Honda Monkey	motor	0.0
1RXPQ5CV	Honda CRF250 Rally	motor	0.0
3W5VOC2L	Honda CB500F	motor	0.0
19HESTN3	Honda CBR500R	motor	0.0
JTX933LX	Honda CB500X	motor	0.0
I73QRBND	Honda CB650R New Sport	motor	0.0
SATQOPVG	Honda Rebel CMX500	motor	0.0
N6XT5PEK	Honda CRF1000L Africa Twin	motor	0.0
OX9LL564	Honda CBR1000RR SP	motor	0.0
082342MBK0LZ0	AHM Oil SPX2 - 0.8 L	Oli	69500.0
08234M99K8LZ0	Oli Gardan Transmission Gear Oil (Fully Synthetic)	Oli	19500.0
08294M99Z8YN1	Oli Gardan - Transmission Gear Oil	Oli	16500.0
08CLAH50500	Cairan Pendingin (Coolant) - Air Radiator	Oli	19500.0
HBF50ML	Minyak Rem (Brake Fluid HBF50ML) - Mega Pro, Supra X 125 Tiger	Oli	8500.0
ACG10GR	AHM CVT Grease 10 Gr	Oli	15000.0
08232M99K0LN5	AHM Oil MPX2 - 0.8 L 10W-30	Oli	58500.0
SS8175ML	Oil Shock Depan (10 W)- Grand, GL MAX, Revo & Tiger	Oli	28500.0
082342MBK8LZ0	AHM Oil SPX2 - 0.65 L 10W-30	Oli	60500.0
082322MBK3LN9	AHM Oil MPX2 - 0.65 L 10W-30	Oli	49500.0
082322MAK0LN5	AHM Oil MPX1 - 0.8 L 10W-30	Oli	56500.0
ACL70ML	Pelumas Rantai (Ahm Chain Lube 70 ML) - ACL70ML	Oli	20000.0
08234M99K8LN9	AHM Oil SPX1 - 1.2 L 10W-30	Oli	89000.0
08234M99K0LN9	AHM Oil SPX1 - 0.8 L 10W-30	Oli	68500.0
CC200ML	Carbon Cleaner 200ML	Oli	45500.0
OSC70ML	Oil System Cleaner 70ML	Oli	30000.0
TBC500ML	Throttle Body Cleaner 500ML	Oli	35500.0
08234M99K1LN9	AHM Oil SPX1 - 1 L 10W-30	Oli	76500.0
082322MAU0JN3	AHM Oil MPX3 - 0.8 L NIP	Oli	50000.0
082322MAK1LN1	AHM Oil MPX1 - 1 L 10W-30 IDE	Oli	65000.0
082322MAU1JN3	AHM Oil MPX3 - 1 L	Oli	55000.0
082322MAK8LZ0	AHM Oil MPX1 - 1.2 L 10W-30	Oli	73000.0
\.


--
-- Data for Name: produk_diskon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produk_diskon (nama_produk, harga_sebelumnya, harga_sekarang, kategori) FROM stdin;
AHM Oil SPX2 - 0.8 L	69500.0	66025.0	Oli
Oli Gardan Transmission Gear Oil (Fully Synthetic)	19500.0	18525.0	Oli
Oli Gardan - Transmission Gear Oil	16500.0	15675.0	Oli
AHM Oil MPX2 - 0.8 L 10W-30	58500.0	55575.0	Oli
AHM Oil SPX2 - 0.65 L 10W-30	60500.0	57475.0	Oli
AHM Oil MPX2 - 0.65 L 10W-30	49500.0	47025.0	Oli
AHM Oil MPX1 - 0.8 L 10W-30	56500.0	53675.0	Oli
AHM Oil SPX1 - 0.8 L 10W-30	68500.0	65075.0	Oli
AHM Oil SPX1 - 1 L 10W-30	76500.0	72675.0	Oli
AHM Oil MPX3 - 0.8 L NIP	50000.0	47500.0	Oli
AHM Oil MPX1 - 1 L 10W-30 IDE	65000.0	61750.0	Oli
AHM Oil MPX3 - 1 L	55000.0	52250.0	Oli
AHM Oil MPX1 - 1.2 L 10W-30	73000.0	69350.0	Oli
\.


--
-- Name: Akun Akun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Akun"
    ADD CONSTRAINT "Akun_pkey" PRIMARY KEY ("ID_Akun");


--
-- Name: Pembelian Pembelian_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pembelian"
    ADD CONSTRAINT "Pembelian_pkey" PRIMARY KEY ("ID_Pembelian");


--
-- Name: Pesan Pesan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pesan"
    ADD CONSTRAINT "Pesan_pkey" PRIMARY KEY ("Kode_Produk", "ID_Pesanan");


--
-- Name: Pesanan Pesanan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pesanan"
    ADD CONSTRAINT "Pesanan_pkey" PRIMARY KEY ("ID_Pesanan");


--
-- Name: Telepon_Pelanggan Telepon_Pelanggan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Telepon_Pelanggan"
    ADD CONSTRAINT "Telepon_Pelanggan_pkey" PRIMARY KEY ("ID_Akun", email, no_telp);


--
-- Name: Transaksi Transaksi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaksi"
    ADD CONSTRAINT "Transaksi_pkey" PRIMARY KEY ("ID_Transaksi");


--
-- Name: cek_diskon cek_diskon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cek_diskon
    ADD CONSTRAINT cek_diskon_pkey PRIMARY KEY (nama_produk, kode_produk);


--
-- Name: motor motor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motor
    ADD CONSTRAINT motor_pkey PRIMARY KEY (kode_produk);


--
-- Name: oli oli_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oli
    ADD CONSTRAINT oli_pkey PRIMARY KEY (kode_produk);


--
-- Name: peralatan_motor peralatan_motor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peralatan_motor
    ADD CONSTRAINT peralatan_motor_pkey PRIMARY KEY (kode_produk);


--
-- Name: produk_diskon produk_diskon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_diskon
    ADD CONSTRAINT produk_diskon_pkey PRIMARY KEY (nama_produk);


--
-- Name: produk produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk
    ADD CONSTRAINT produk_pkey PRIMARY KEY (kode_produk);


--
-- Name: Pesan trigger_check_kode_produk_nama_produk; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_check_kode_produk_nama_produk BEFORE INSERT ON public."Pesan" FOR EACH ROW EXECUTE FUNCTION public.check_kode_produk_nama_produk();


--
-- Name: Pesanan trigger_check_nama_produk; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_check_nama_produk BEFORE INSERT ON public."Pesanan" FOR EACH ROW EXECUTE FUNCTION public.check_nama_produk();


--
-- Name: produk_diskon trigger_revert_produk_harga; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_revert_produk_harga AFTER DELETE ON public.produk_diskon FOR EACH ROW EXECUTE FUNCTION public.revert_produk_harga();


--
-- Name: produk_diskon trigger_update_produk_harga; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_produk_harga AFTER INSERT OR UPDATE ON public.produk_diskon FOR EACH ROW EXECUTE FUNCTION public.update_produk_harga();


--
-- Name: Pembelian Pembelian_ID_Pesanan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pembelian"
    ADD CONSTRAINT "Pembelian_ID_Pesanan_fkey" FOREIGN KEY ("ID_Pesanan") REFERENCES public."Pesanan"("ID_Pesanan");


--
-- Name: Pesan Pesan_ID_Pesanan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pesan"
    ADD CONSTRAINT "Pesan_ID_Pesanan_fkey" FOREIGN KEY ("ID_Pesanan") REFERENCES public."Pesanan"("ID_Pesanan");


--
-- Name: Pesanan Pesanan_ID_Akun_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pesanan"
    ADD CONSTRAINT "Pesanan_ID_Akun_fkey" FOREIGN KEY ("ID_Akun") REFERENCES public."Akun"("ID_Akun");


--
-- Name: Telepon_Pelanggan Telepon_Pelanggan_ID_Akun_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Telepon_Pelanggan"
    ADD CONSTRAINT "Telepon_Pelanggan_ID_Akun_fkey" FOREIGN KEY ("ID_Akun") REFERENCES public."Akun"("ID_Akun");


--
-- Name: Transaksi Transaksi_ID_Pembelian_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaksi"
    ADD CONSTRAINT "Transaksi_ID_Pembelian_fkey" FOREIGN KEY ("ID_Pembelian") REFERENCES public."Pembelian"("ID_Pembelian");


--
-- Name: cek_diskon cek_diskon_kode_produk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cek_diskon
    ADD CONSTRAINT cek_diskon_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES public.produk(kode_produk);


--
-- Name: cek_diskon cek_diskon_nama_produk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cek_diskon
    ADD CONSTRAINT cek_diskon_nama_produk_fkey FOREIGN KEY (nama_produk) REFERENCES public.produk_diskon(nama_produk);


--
-- Name: motor motor_kode_produk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motor
    ADD CONSTRAINT motor_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES public.produk(kode_produk);


--
-- Name: oli oli_kode_produk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oli
    ADD CONSTRAINT oli_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES public.produk(kode_produk);


--
-- Name: peralatan_motor peralatan_motor_kode_produk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peralatan_motor
    ADD CONSTRAINT peralatan_motor_kode_produk_fkey FOREIGN KEY (kode_produk) REFERENCES public.produk(kode_produk);


--
-- PostgreSQL database dump complete
--


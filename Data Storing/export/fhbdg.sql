-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: fhbdg
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `region` varchar(50) NOT NULL,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `branch_name` (`branch_name`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES
(1,'FIT HUB BendunganHilir','Jl. Bendungan Hilir No.10, RT.1/RW.4, Jakarta Pusat, Daerah KhususIbukota Jakarta 10210','Jakarta'),
(2,'FIT HUB MenaraDuta','Jalan H. R. Rasuna Said No.Kav B/09, RT.5/RW.1, Kuningan, Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12910','Jakarta'),
(3,'FIT HUB SunterAltira','Altira Business Park Blok A01-A03 Lantai 2, Jakarta, DKI Jakarta 14350','Jakarta'),
(4,'FIT HUB Tebet','Jl. Prof. DR. Soepomo No.30, RT.13/RW.2, Tebet Bar., Kec. Tebet, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12810','Jakarta'),
(5,'FIT HUB DurenSawit','Jl. Kolonel Sugiono No.3, RT.1/RW.3, Duren Sawit, Kec. Duren Sawit, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13440','Jakarta'),
(6,'FIT HUB ElangLautPik','Jl. Pantai Indah Selatan No.10, RT.3/RW.3, Kamal Muara, Kec. Penjaringan, Jkt Utara, Daerah Khusus Ibukota Jakarta 14470','Jakarta'),
(7,'FIT HUB Fatmawati','Jl. RS. Fatmawati Raya No.9, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12140','Jakarta'),
(8,'FIT HUB GajahMada','Jl. Gajah Mada No.220, Glodok, Kec. Taman Sari, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11120','Jakarta'),
(9,'FIT HUB Greenville','Jl. Green Ville Blk. BJ-BK No.5, RT.8/RW.14, Duri Kepa, Kec. Kb. Jeruk, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11510','Jakarta'),
(10,'FIT HUB Grogol','Jl. Makaliwe Raya No.42, RW.5, Grogol, Kec. Grogol petamburan, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11450','Jakarta'),
(11,'FIT HUB Mampang','Jl. Mampang Prpt. Raya No.81, RT.7/RW.1, Tegal Parang, Kec. Mampang Prpt., Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12790','Jakarta'),
(12,'FIT HUB ItcKuningan','ITC Kuningan Lantai 5 Jembatan 1, Jl. Prof. DR. Satrio, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12940','Jakarta'),
(13,'FIT HUB Jgc','Ruko New East, Jl. Jkt Garden City Boulevard, Cakung Tim., Kec. Cakung, Daerah Khusus Ibukota Jakarta 13910','Jakarta'),
(14,'FIT HUB MeruyaJameson','Komp. Ruko Taman Kb. Jeruk, Jl. Meruya Ilir Raya No.12, RT.4/RW.7, Meruya Sel., Kec. Kembangan, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11640 (Lantai 3)','Jakarta'),
(15,'FIT HUB ItcPermataHijau','Jl. Arteri Permata Hijau No.11, RT.11/RW.10, Grogol Utara, Kec. Kby. Lama, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12210 (Grand ITC Permata Hijau Lantai Lower Ground)','Jakarta'),
(16,'FIT HUB Pluit','Jl. Pluit Indah No.34, Pluit, Kec. Penjaringan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14450','Jakarta'),
(17,'FIT HUB PuriIndah','Sentra Niaga Puri Indah Blok T1 No. 9-10, Jl. Puri Lkr. Dalam No.Raya, RT.1/RW.2, South Kembangan, Kembangan, West Jakarta City, Jakarta 11610','Jakarta'),
(18,'FIT HUB Rawamangun','Jl. Sunan Drajad No.39, RW.8, Jati, Pulo Gadung, East Jakarta City, Jakarta 13220','Jakarta'),
(19,'FIT HUB Salemba','Jl. Salemba Raya No.57 - 59, Paseban, Kec. Senen, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10430','Jakarta'),
(20,'FIT HUB SedayuCityKelapaGading','Jl. Boulevard Raya Sedayu City Blok SCBRA NO. 3, 5 dan 6, Cakung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13910','Jakarta'),
(21,'FIT HUB TaminiSquare','Jl. Taman Mini Raya Garuda, Pinang Ranti, Makasar,Jakarta Timur 13560,DKI Jakarta (Tamini Square Lantai 2)','Jakarta'),
(22,'FIT HUB Kalimalang','Jl. KH. Noer Ali No.45, RT.2/RW.3, Pd. Klp., Kec. Duren Sawit, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13450','Jakarta'),
(23,'FIT HUB Kemanggisan','Jalan Kebon Jeruk Raya Gg. Abc No.15, RT.007/RW.005, Sukabumi Sel., Kec. Kb. Jeruk, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11530','Jakarta'),
(24,'FIT HUB MallMetroKebayoran','Mall Metro Kebayoran, Jl. Ciledug Raya No.1, RW.5, Ulujami, Kec. Pesanggrahan, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12250','Jakarta'),
(25,'FIT HUB BintaroSektor1','Jalan Bintaro Raya Blok FII Persil no. 1, RT 016/RW08, Kecamatan. Pesanggrahan Kota Jakarta Selatan, Jakarta, Daerah Khusus Ibukota Jakarta 12330','Jakarta'),
(26,'FIT HUB BlokM','Jalan Panglima Polim Raya Blok M.3 No. 1 dan 2, RT.1/RW.2, Melawai, Kec. Kby. Baru, Daerah Khusus Ibukota Jakarta 12130, Indonesia','Jakarta'),
(27,'FIT HUB Wisma46','Jl. Jenderal Sudirman No.Kav. 1, RT.1/RW.8, Karet Tengsin, Kecamatan Tanah Abang, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10220','Jakarta'),
(28,'FIT HUB CempakaPutih','Jl. Cempaka Putih Raya B No.44, RT.7/RW.8, Cemp. Putih Tim., Kec. Cemp. Putih, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10510, Indonesia','Jakarta'),
(29,'FIT HUB PlazaOleos','Jl. TB Simatupang, RT.2/RW.1, Kebagusan, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520','Jakarta'),
(30,'FIT HUB PasarMinggu','Jl. Raya Pasar Minggu No.05, RT.2/RW.7, Duren Tiga, Kec. Pancoran, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12760','Jakarta'),
(31,'FIT HUB MaspionPlaza','Jl. Gn. Sahari No.Kav.18, Pademangan Bar., Kec. Pademangan, Jkt Utara, Daerah Khusus Ibukota Jakarta 14420','Jakarta'),
(32,'FIT HUB TamanPalemLestari','Perumahan Taman Palem Lestari Blok A-11/5-A 11730, RT.8/RW.13, Cengkareng Bar., Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11730','Jakarta'),
(33,'FIT HUB OtistaRay','Jalan Otista Raya 99, Kelurahan Bidaracina, Kecamatan Jatinegara, Jakarta Timur 13330','Jakarta'),
(34,'FIT HUB GadingSerpong','Jl. Gading Serpong Boulevard No.10-11, Pakulonan Bar., Kec. Klp. Dua, Kabupaten Tangerang, Banten 15810','Tangerang'),
(35,'FIT HUB Tangcity','Ruko TangCity Business Park, Jl. Jenderal Sudirman E23, E25, E26 Babakan, Kec. Tangerang, Kota Tangerang, Banten 15117','Tangerang'),
(36,'FIT HUB KarangMulya','Samping Apartemen, The NEST@Puri, Jl. Raden Saleh, RT.001/RW.012, Karang Mulya, Kec. Karang Tengah, Kota Tangerang, Banten 15157','Tangerang'),
(37,'FIT HUB Karawaci','Maxxboxx Lippo Village UG Unit No. UG-09 s.d. UG-13, Lippo VIllage 1200, Jl. Jend. Sudirman No.1110, Bencongan, Kec. Klp. Dua, Kabupaten Tangerang, Banten 15810','Tangerang'),
(38,'FIT HUB Ciledug','Jl. HOS Cokroaminoto No.8, RT.001/RW.005, Sudimara Utara, Kec. Ciledug, Kota Tangerang, Banten 15151, Indonesia','Tangerang'),
(39,'FIT HUB CitraRayaCikupa','Jl. EcoPolis Ave, Mekar Bakti, Kec. Panongan, Kabupaten Tangerang, Banten 15710, Indonesia','Tangerang'),
(40,'FIT HUB BsdGoldfinch','Jalan Goldfinch Selatan SGD, Jl. Springs Boulevard No.29, Cihuni, Kec. Pagedangan, Kabupaten Tangerang, Banten 15332','Tangerang'),
(41,'FIT HUB AlamSutera','Jl Jalur Sutra Ruko Imperial Walk Kavling 29 B Nomor : 30 – 31, Kota Tangerang Selatan Banten 15320','Tangerang Selatan'),
(42,'FIT HUB BintaroSektor9(jombang)','Jalan Jombang Raya No.89 Jombang, Ciputat, Parigi, Kec. Pd. Aren, Kota Tangerang Selatan, Banten 15414, Indonesia','Tangerang Selatan'),
(43,'FIT HUB BintaroSektor7','Kompleks Bintaro Jaya Sektor 7 Blok FG 14 nomor 42A, Pd. Jaya, Kec. Pd. Aren, Kota Tangerang Selatan, Banten 15222','Tangerang Selatan'),
(44,'FIT HUB BsdGoldenBoulevard','Jl. Pahlawan Seribu, Lengkong Karya, BSD City, Kota Tangerang Selatan, Banten 15301, Indonesia','Tangerang Selatan'),
(45,'FIT HUB CiputatLot','Jl. Dewi Sartika No.22, Cipayung, Kec. Ciputat, Kota Tangerang Selatan, Banten 15411, Indonesia','Tangerang Selatan'),
(46,'FIT HUB Pamulang','Superindo, Jalan Pamulang Raya Blok SH/14 Kompleks, Jl. Pamulang Permai, Pamulang Bar., Kec. Ciputat, Tangerang Selatan, Banten 15417','Tangerang Selatan'),
(47,'FIT HUB DarmoPuncakPermai','Jl. Raya Darmo Permai III No.80, Pradahkalikendal, Kec. Dukuhpakis, Surabaya, Jawa Timur 60226','Surabaya'),
(48,'FIT HUB Adityawarman','Jl. Adityawarman No.39, Sawunggaling, Kec. Wonokromo, Surabaya, Jawa Timur 60242','Surabaya'),
(49,'FIT HUB GrahaPena','Gedung Graha Pena Lantai 1 Ruang 112, Jl. Ahmad Yani No.88, Ketintang, Kecamatan, Jawa Timur 60231','Surabaya'),
(50,'FIT HUB Gubeng','Jl. Sumatera No.20-B, RT.010/RW.07, Ketabang, Kec. Genteng, Surabaya, Jawa Timur 60272','Surabaya'),
(51,'FIT HUB ManyarKertoarjo','Jl. Manyar Kertoarjo No.12, Manyar Sabrangan, Kec. Mulyorejo, Kota SBY, Jawa Timur 60116','Surabaya'),
(52,'FIT HUB Merr','Jl. Dr. Ir. H. Soekarno 47-364, Kedung Baruk, Kec. Rungkut, Kota SBY, Jawa Timur 60298','Surabaya'),
(53,'FIT HUB Wiyung','Jl. Raya Menganti Babatan No.9, Babatan, Kec. Wiyung, Kota Surabaya','Surabaya'),
(54,'FIT HUB CitralandBarat','Telaga Utama Road No.D1 No.31-32, Jeruk, Lakarsantri, Surabaya, East Java 60123','Surabaya'),
(55,'FIT HUB Kenjeran','Pertokoan Kenjeran Indah, Jl. Kenjeran No.564 - 572, Dukuh Sutorejo, Kec. Mulyorejo, Surabaya, Jawa Timur 60113','Surabaya'),
(56,'FIT HUB SuryaSumantri','Jl. Surya Sumantri Kel No.53, RT.05/RW.04, Sukawarna, Kec. Sukajadi, Kota Bandung, Jawa Barat 40164','Bandung dan Cimahi'),
(57,'FIT HUB Kopo','Ruko Kavling, Jl. Raya Kopo No.472, Margahayu Utara, Kec. Babakan Ciparay, Kota Bandung, Jawa Barat 40224','Bandung dan Cimahi'),
(58,'FIT HUB Lengkong','Jl. Lengkong Kecil No.52, Paledang, Kec. Lengkong, Kota Bandung, Jawa Barat 40261','Bandung dan Cimahi'),
(59,'FIT HUB Buahbatu','Jl. Buah Batu No.258, Turangga, Kec. Lengkong, Kota Bandung, Jawa Barat 40286','Bandung dan Cimahi'),
(60,'FIT HUB CibabatCimah','Jl. Raya Cilember No.325, Cigugur Tengah, Kec. Cimahi Tengah, Kota Cimahi, Jawa Barat 40522','Bandung dan Cimahi'),
(61,'FIT HUB NipahMall','Jl. Urip Sumoharjo No.23C, Panaikang, Kec. Panakkukang, Kota Makassar, Sulawesi Selatan 90231','Makassar'),
(62,'FIT HUB DepokTownSquare(detos)','Depok Town Square, Jl. Margonda No.1, Kemiri Muka, Kecamatan Beji, Kota Depok, Jawa Barat 16424, Indonesia','Depok'),
(63,'FIT HUB DepokTownCenter(dtc)','DTC, Jl. Raya Sawangan No.1, Rangkapan Jaya, Kec. Pancoran Mas, Kota Depok, Jawa Barat 16435, Indonesia','Depok'),
(64,'FIT HUB CinereRaya','Jl. Cinere Raya No.105, Cinere, Kec. Cinere, Kota Depok, Jawa Barat 16514','Depok'),
(65,'FIT HUB Renon','Jl. Raya Puputan No.148, Sumerta Kelod, Denpasar Selatan, Kota Denpasar, Bali 80234, Indonesia','Bali'),
(66,'FIT HUB TeukuUmarBarat','Jl. Teuku Umar Barat No.12, Pemecutan Klod, Kec. Denpasar Bar., Kota Denpasar, Bali 80119, Indonesia','Bali'),
(67,'FIT HUB SunsetRoad','Jl. Sunset Road Kecamatan No.388, Kuta, Kec. Kuta, Kabupaten Badung, Bali 80361','Bali'),
(68,'FIT HUB GatsuTimur','Jl. Gatot Subroto Tim. No.250, Tonja, Kec. Denpasar Utara, Kota Denpasar, Bali 80234','Bali'),
(69,'FIT HUB Uluwatu','Jl. Uluwatu No.35, Ungasan, South Kuta, Badung Regency, Bali 80361','Bali'),
(70,'FIT HUB HarapanIndah','Ruko Mega Boulevard RV-1, Kota Harapan Indah No.3A, Pusaka Rakyat, Kecamatan Medan Satria, Kabupaten Bekasi, Jawa Barat 17132, Indonesia','Bekasi'),
(71,'FIT HUB LivingPlazaJababeka','Living Plaza Jababeka, Jl. Jababeka Raya, Mekarmukti, Kec. Cikarang Utara, Kabupaten Bekasi, Jawa Barat 17530','Bekasi'),
(72,'FIT HUB SummareconBekasi','Ruko Summarecon Bekasi No. 74B, RT.003/RW.005, Marga Mulya, Bekasi Utara, Bekasi, West Java 17142','Bekasi'),
(73,'FIT HUB PasarkotaPondokGede','Jl. Raya Pd. Gede No.1, Jatirahayu, Kec. Pd. Melati, Kota Bks, Jawa Barat 17415','Bekasi'),
(74,'FIT HUB Jatiasi','Jl. Wibawa Mukti II, RT.003/RW.005, Jatiasih, Kec. Jatiasih, Kota Bks, Jawa Barat 17423','Bekasi'),
(75,'FIT HUB CibinongMayorOking','Jl. Raya Mayor Oking Jaya Atmaja No.67, Ciriung, Kec. Cibinong, Kabupaten Bogor, Jawa Barat 16918','Bogor'),
(76,'FIT HUB SiliwangiBogor','Jl. Siliwangi No.66, RT.5/RW.04, Lawanggintung, Kota Bogor, Jawa Barat 16134, Indonesia','Bogor'),
(77,'FIT HUB TransyogiCibubur','Jl. Alternatif Cibubur No.117, Nagrak, Kec. Gn. Putri, Kabupaten Bogor, Jawa Barat 16967','Bogor'),
(78,'FIT HUB YasminBogo','Jl. Brigjen Saptaji Hadipawira RT. 023 RW. 008, Kelurahan Cilendek Barat, Kecamatan Bogor Barat, Kota Bogor, Jawa Barat','Bogor'),
(79,'FIT HUB JogjaCityMall','Magelang St Lantai 1 No.6 No.18, Kutu Patran, Sinduadi, Mlati, Sleman Regency, Special Region of Yogyakarta 55284','Yogyakarta'),
(80,'FIT HUB D.i.Panjaitan','Jl. Mayor Jend. D.I. Panjaitan No.14, Brumbungan, Kec. Semarang Tengah, Kota Semarang, Jawa Tengah 50135','Semarang'),
(81,'FIT HUB SetiabudiSemarang','Jl. Setia Budi No.39, Srondol Wetan, Kec. Banyumanik, Kota Semarang, Jawa Tengah 50263','Semarang'),
(82,'FIT HUB BsbSemarang','CBD BSB CITY BLOK G9, Kedungpane, Kec. Mijen, Kota Semarang, Jawa Tengah 50246','Semarang'),
(83,'FIT HUB MajapahitSemaran','Jl. Brigjen Sudiarto No.218B, Gayamsari, Kec. Gayamsari, Kota Semarang, Jawa Tengah 50248','Semarang'),
(84,'FIT HUB Gressmall','LG Floor, Jl. Sumatra No.1-5, RT.07/RW.08, Gn. Malang, Randuagung, Kec. Kebomas, Kabupaten Gresik, Jawa Timur 61121','Gresik'),
(85,'FIT HUB PahlawanSidoarjo','JL Pahlawan, Perumahan Pondok Mutiara Blok BD, No. 1, RT 23 RW 10, Rw6, Sidokumpul, Kec. Sidoarjo, Kabupaten Sidoarjo, Jawa Timur 61212','Sidoarjo'),
(86,'FIT HUB BaloiPerseroBatam','Jl. Bunga Raya No.99 Kec. Lubuk Baja, Kota Batam, Kepulauan Riau, Kota Batam, Riau 29444','Batam'),
(87,'FIT HUB DiengMalan','Jl. Dieng No.32, Gading Kasri, Kec. Klojen, Kota Malang, Jawa Timur 65146','Malang');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `category` enum('STRENGTH','MIND & BODY','DANCE','CARDIO') DEFAULT NULL,
  `difficulty` enum('EASY','MEDIUM','MODERATE','HARD') DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  UNIQUE KEY `class_name` (`class_name`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES
(1,'Hiit','STRENGTH','MODERATE',60),
(2,'Core','STRENGTH','MODERATE',60),
(3,'Circuit','STRENGTH','MODERATE',60),
(4,'BootyShaping','STRENGTH','MODERATE',60),
(5,'Bodycombat','CARDIO','MODERATE',60),
(6,'FitCycle','CARDIO','MODERATE',60),
(7,'StrongNation','CARDIO','MODERATE',60),
(8,'PoundFit','CARDIO','MODERATE',60),
(9,'MatPilates','CARDIO','MODERATE',60),
(10,'FitRush','CARDIO','MODERATE',60),
(11,'HipHopDance','DANCE',NULL,60),
(12,'VinyasaYoga','MIND & BODY','MODERATE',60),
(13,'KaphaYoga','MIND & BODY','MODERATE',60),
(14,'LadiesStyleBachata','MIND & BODY','MODERATE',60),
(15,'ThaiBoxing','MIND & BODY','MODERATE',60),
(16,'Zumba','MIND & BODY','MODERATE',60),
(17,'FreestyleDance','DANCE','MODERATE',60),
(18,'CardioDance','DANCE','MODERATE',60),
(19,'Bootcamp','STRENGTH','MODERATE',60),
(20,'BellyDance','DANCE','MODERATE',60),
(21,'Piloxing','CARDIO','EASY',NULL),
(22,'MuayThai','STRENGTH','EASY',60),
(23,'PoundUnplugged','MIND & BODY','MEDIUM',60),
(24,'AsthanggaYoga','MIND & BODY','MEDIUM',60),
(25,'LineDance','DANCE','MEDIUM',60),
(26,'KPopDance','MIND & BODY','EASY',60),
(27,'HathaYoga','MIND & BODY','MEDIUM',60),
(28,'GentleYoga','MIND & BODY','EASY',60),
(29,'Salsation','DANCE','EASY',60),
(30,'BasicYoga','MIND & BODY','EASY',60),
(31,'Tabata','STRENGTH','EASY',60);
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor` (
  `instructor_id` int(11) NOT NULL AUTO_INCREMENT,
  `instructor_name` varchar(255) NOT NULL,
  PRIMARY KEY (`instructor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES
(1,'Gina'),
(2,'Feby'),
(3,'Citra'),
(4,'Rifqi'),
(5,'BLC'),
(6,'Mochammad'),
(7,'Hadi'),
(8,'Indris'),
(9,'Restiany'),
(10,'Dimas'),
(11,'Diva'),
(12,'Iwan'),
(13,'Yebi'),
(14,'Roni'),
(15,'Yuki'),
(16,'Lia'),
(17,'Yufiany'),
(18,'Chellsea'),
(19,'Ricky'),
(20,'Ayu'),
(21,'Dadi'),
(22,'Luky'),
(23,'Ixa'),
(24,'Alexander'),
(25,'Mouza'),
(26,'Erta'),
(27,'Sisi'),
(28,'Sahil'),
(29,'Ratna'),
(30,'Sanny'),
(31,'William'),
(32,'Dina'),
(33,'Gun'),
(34,'Yulianna'),
(35,'Deasy'),
(36,'Andy'),
(37,'Uki'),
(38,'Ilham'),
(39,'Ardha'),
(40,'Teuku'),
(41,'M.'),
(42,'Liana'),
(43,'Azmi'),
(44,'Nurul'),
(45,'Albert'),
(46,'Anantha'),
(47,'Vincentius'),
(48,'Medi'),
(49,'Stevan'),
(50,'Erik'),
(51,'Rahmawati'),
(52,'Ridki');
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `member_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_name` varchar(255) NOT NULL,
  `member_email` varchar(255) NOT NULL,
  `member_phone` varchar(255) NOT NULL,
  `membership_expiry` date NOT NULL,
  `home_branch` int(11) DEFAULT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `referral_code` varchar(255) NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `member_email` (`member_email`),
  UNIQUE KEY `member_phone` (`member_phone`),
  UNIQUE KEY `referral_code` (`referral_code`),
  KEY `home_branch` (`home_branch`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`home_branch`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `branch_id` int(11) NOT NULL,
  `class_datetime` datetime NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`branch_id`,`class_datetime`),
  KEY `class_id` (`class_id`),
  KEY `instructor_id` (`instructor_id`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `schedule_ibfk_3` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES
(56,'2024-07-29 08:00:00',8,2),
(56,'2024-07-29 17:00:00',2,6),
(56,'2024-07-29 18:00:00',22,5),
(56,'2024-07-29 19:05:00',16,11),
(56,'2024-07-29 20:10:00',24,14),
(56,'2024-07-30 08:00:00',16,16),
(56,'2024-07-30 17:00:00',3,19),
(56,'2024-07-30 18:00:00',8,1),
(56,'2024-07-30 19:05:00',26,23),
(56,'2024-07-30 20:10:00',27,13),
(56,'2024-07-31 08:00:00',27,27),
(56,'2024-07-31 17:00:00',1,29),
(56,'2024-07-31 18:00:00',5,33),
(56,'2024-07-31 19:05:00',23,1),
(56,'2024-07-31 20:10:00',3,35),
(56,'2024-08-01 08:00:00',8,37),
(56,'2024-08-01 17:00:00',3,41),
(56,'2024-08-01 18:00:00',29,32),
(56,'2024-08-01 19:05:00',18,15),
(56,'2024-08-01 20:10:00',28,25),
(56,'2024-08-02 08:00:00',1,44),
(56,'2024-08-02 17:00:00',2,47),
(56,'2024-08-02 18:00:00',5,49),
(56,'2024-08-02 19:05:00',29,32),
(56,'2024-08-02 20:10:00',8,2),
(56,'2024-08-03 08:00:00',2,35),
(56,'2024-08-03 09:00:00',9,30),
(56,'2024-08-03 10:00:00',22,5),
(56,'2024-08-04 09:00:00',4,41),
(56,'2024-08-04 10:00:00',16,11),
(57,'2024-07-29 08:15:00',8,3),
(57,'2024-07-29 17:00:00',3,7),
(57,'2024-07-29 18:00:00',16,9),
(57,'2024-07-29 19:05:00',5,12),
(57,'2024-07-30 09:00:00',22,5),
(57,'2024-07-30 16:00:00',2,18),
(57,'2024-07-30 17:00:00',1,20),
(57,'2024-07-30 18:00:00',23,2),
(57,'2024-07-30 19:05:00',27,24),
(57,'2024-07-31 08:15:00',16,10),
(57,'2024-07-31 17:00:00',9,30),
(57,'2024-07-31 18:00:00',22,5),
(57,'2024-07-31 19:05:00',8,3),
(57,'2024-07-31 20:10:00',28,13),
(57,'2024-08-01 07:30:00',8,36),
(57,'2024-08-01 16:00:00',1,40),
(57,'2024-08-01 17:00:00',5,42),
(57,'2024-08-01 18:00:00',25,22),
(57,'2024-08-01 19:05:00',8,2),
(57,'2024-08-02 08:15:00',2,45),
(57,'2024-08-02 17:00:00',4,48),
(57,'2024-08-02 18:00:00',26,31),
(57,'2024-08-02 19:05:00',5,42),
(57,'2024-08-03 08:15:00',3,50),
(57,'2024-08-03 10:30:00',27,13),
(57,'2024-08-04 09:00:00',16,15),
(57,'2024-08-04 10:00:00',4,52),
(58,'2024-07-29 08:00:00',2,4),
(58,'2024-07-29 09:00:00',22,5),
(58,'2024-07-29 17:00:00',5,8),
(58,'2024-07-29 18:00:00',23,2),
(58,'2024-07-29 19:05:00',12,13),
(58,'2024-07-29 20:10:00',18,15),
(58,'2024-07-30 08:00:00',16,9),
(58,'2024-07-30 09:00:00',4,17),
(58,'2024-07-30 17:00:00',1,21),
(58,'2024-07-30 18:00:00',25,22),
(58,'2024-07-30 19:05:00',16,9),
(58,'2024-07-30 20:10:00',28,25),
(58,'2024-07-31 07:30:00',27,26),
(58,'2024-07-31 09:00:00',2,28),
(58,'2024-07-31 17:00:00',26,31),
(58,'2024-07-31 18:00:00',7,34),
(58,'2024-07-31 19:05:00',8,2),
(58,'2024-07-31 20:10:00',27,26),
(58,'2024-08-01 08:00:00',2,38),
(58,'2024-08-01 09:00:00',4,39),
(58,'2024-08-01 17:00:00',3,43),
(58,'2024-08-01 18:00:00',22,5),
(58,'2024-08-01 19:05:00',16,16),
(58,'2024-08-01 20:10:00',5,12),
(58,'2024-08-02 08:00:00',9,30),
(58,'2024-08-02 09:00:00',2,46),
(58,'2024-08-02 17:00:00',18,10),
(58,'2024-08-02 18:00:00',5,33),
(58,'2024-08-02 19:05:00',16,15),
(58,'2024-08-02 20:10:00',27,26),
(58,'2024-08-03 08:00:00',3,21),
(58,'2024-08-03 09:00:00',4,38),
(58,'2024-08-03 10:00:00',5,33),
(58,'2024-08-04 08:00:00',31,51),
(58,'2024-08-04 09:00:00',16,10),
(58,'2024-08-04 10:00:00',12,25),
(59,'2024-07-29 08:00:00',8,1),
(59,'2024-07-29 19:00:00',16,10),
(59,'2024-07-30 20:00:00',8,2),
(59,'2024-07-31 09:10:00',25,22),
(59,'2024-07-31 18:00:00',29,32),
(59,'2024-08-01 20:00:00',27,26),
(59,'2024-08-02 10:10:00',30,24),
(59,'2024-08-02 20:00:00',26,31),
(59,'2024-08-03 08:00:00',12,13),
(59,'2024-08-03 09:10:00',16,15),
(59,'2024-08-04 09:10:00',7,34);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_attendants`
--

DROP TABLE IF EXISTS `schedule_attendants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_attendants` (
  `branch_id` int(11) NOT NULL,
  `class_datetime` datetime NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`branch_id`,`class_datetime`,`member_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `schedule_attendants_ibfk_1` FOREIGN KEY (`branch_id`, `class_datetime`) REFERENCES `schedule` (`branch_id`, `class_datetime`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `schedule_attendants_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_attendants`
--

LOCK TABLES `schedule_attendants` WRITE;
/*!40000 ALTER TABLE `schedule_attendants` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_attendants` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-02 19:51:32

-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: halodoc
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
-- Table structure for table `checkup`
--

DROP TABLE IF EXISTS `checkup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checkup` (
  `idCheck` int(11) NOT NULL AUTO_INCREMENT,
  `idDoctor` int(11) NOT NULL,
  `idPatient` int(11) NOT NULL,
  PRIMARY KEY (`idCheck`),
  KEY `idDoctor` (`idDoctor`),
  KEY `idPatient` (`idPatient`),
  CONSTRAINT `checkup_ibfk_1` FOREIGN KEY (`idDoctor`) REFERENCES `doctor` (`idDoctor`) ON UPDATE CASCADE,
  CONSTRAINT `checkup_ibfk_2` FOREIGN KEY (`idPatient`) REFERENCES `patient` (`idPatient`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checkup`
--

LOCK TABLES `checkup` WRITE;
/*!40000 ALTER TABLE `checkup` DISABLE KEYS */;
/*!40000 ALTER TABLE `checkup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `idCity` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(255) NOT NULL,
  `idProvince` int(11) NOT NULL,
  PRIMARY KEY (`idCity`),
  KEY `idProvince` (`idProvince`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`idProvince`) REFERENCES `province` (`idProvince`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES
(1,'Makassar',1),
(2,'Sukoharjo',2),
(3,'Jakarta Pusat',3),
(4,'Jambi',4),
(5,'Surabaya',5),
(6,'Bandung',6),
(7,'Kab. Bandung',6),
(8,'Tangerang',7),
(9,'Batam',8),
(10,'Boyolali',2),
(11,'Jakarta Selatan',3),
(12,'Solo',2),
(13,'Yogyakarta',2),
(14,'Tegal',2),
(15,'Kudus',2),
(16,'Papua',9),
(17,'Semarang',2),
(18,'Pekalongan',2);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `idContact` int(11) NOT NULL AUTO_INCREMENT,
  `contact` varchar(255) NOT NULL,
  PRIMARY KEY (`idContact`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor` (
  `idDoctor` int(11) NOT NULL AUTO_INCREMENT,
  `price` int(11) NOT NULL,
  `str_number` varchar(255) NOT NULL,
  `doctor_name` varchar(255) NOT NULL,
  `rating` float NOT NULL,
  `experience` int(11) NOT NULL,
  `doctor_url` varchar(255) NOT NULL,
  `idContact` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDoctor`),
  KEY `idContact` (`idContact`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`idContact`) REFERENCES `contact` (`idContact`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES
(1,55000,'7321701420071583','Dr. Iriany Sahali Sp.GK, AIFO-K',99,20,'https://www.halodoc.com/tanya-dokter/dr-iriany-sahali-sp-gk-aifo-k',NULL),
(2,55000,'3321701322158411','Dr. Rosa Kristiansen Sp.GK',100,10,'https://www.halodoc.com/tanya-dokter/dr-rosa-kristiansen-sp-gk',NULL),
(3,55000,'7321701522095374','Dr. Fitri Tyas Sp.GK, AIFO-K',97,16,'https://www.halodoc.com/tanya-dokter/dr-fitri-tyas-sp-gk-aifo-k',NULL),
(4,55000,'33.2.1.701.4.22.126871','Dr. Dewi Susanti Widjajatanadi Sp.GK',96,13,'https://www.halodoc.com/tanya-dokter/dr-dewi-susanti-widjajatanadi-sp-gk',NULL),
(5,199900,'3321701423120739','Dr. Linda Artanti Sp.GK',98,14,'https://www.halodoc.com/tanya-dokter/dr-linda-artanti-sp-gk',NULL),
(6,100000,'7321701422050265','Dr. Dewa Ayu Liona Dewi M.Kes, Sp.GK',100,27,'https://www.halodoc.com/tanya-dokter/dr-dewa-ayu-liona-dewi-m-kes-sp-gk',NULL),
(7,55000,'3121701320148941','Dr. Shiela Stefani M.Gizi, Sp.GK, AIFO-K',100,11,'https://www.halodoc.com/tanya-dokter/dr-shiela-stefani-m-gizi-sp-gk-aifo-k',NULL),
(8,55000,'GO00000101356545','Dr. Karina Marcella Widjaja Sp.GK',99,7,'https://www.halodoc.com/tanya-dokter/dr-karina-marcella-widjaja-sp-gk',NULL),
(9,150000,'3321100219147962','Dr. Yulin Arditawati Sp.GK',91,10,'https://www.halodoc.com/tanya-dokter/dr-yulin-arditawati-sp-gk',NULL),
(10,55000,'GO00000415731121','Dr. Josefina Junizar M.Gizi, Sp.GK',100,23,'https://www.halodoc.com/tanya-dokter/dr-josefina-junizar-m-gizi-sp-gk',NULL),
(11,90000,'KV00000381156403','Dr. Ade Erni M.Gizi, Sp.GK',88,25,'https://www.halodoc.com/tanya-dokter/dr-ade-erni-m-gizi-sp-gk',NULL),
(12,215000,'3121100110114466','Dr. Yohannessa Wulandari M.Gizi, Sp.GK',100,14,'https://www.halodoc.com/tanya-dokter/dr-yohannessa-wulandari-m-gizi-sp-gk',NULL),
(13,55000,'9821701523029479','Dr. Diani Adrina Sp.GK',100,24,'https://www.halodoc.com/tanya-dokter/dr-diani-adrina-sp-gk',NULL),
(14,55000,'FI00001131753088','Dr. Amelya Augusthina Ayusari M.Gizi, Sp.GK',96,13,'https://www.halodoc.com/tanya-dokter/dr-amelya-augusthina-ayusari-m-gizi-sp-gk',NULL),
(15,55000,'3321701421012376','Dr. Noviani . Sp.GK, AIFO-K',95,23,'https://www.halodoc.com/tanya-dokter/dr-noviani-sp-gk-aifo-k',NULL),
(16,55000,'3321701322172175','Dr. Annisa Fauziah Sp.GK',90,10,'https://www.halodoc.com/tanya-dokter/dr-annisa-fauziah-sp-gk',NULL),
(17,55000,'7321701420099638','Dr. Franciska Rahardjo Sp.GK',83,17,'https://www.halodoc.com/tanya-dokter/dr-franciska-rahardjo-sp-gk',NULL),
(18,55000,'PD00000343074094','Dr. Muhammad Nasir Ruki S.Si, M.Kes, Apt, Sp.GK',98,22,'https://www.halodoc.com/tanya-dokter/dr-muhammad-nasir-ruki-s-si-m-kes-apt-sp-gk',NULL),
(19,55000,'3321701422115537','Dr. Ika Swasti Mahargyani Sp.GK, AIFO-K',98,15,'https://www.halodoc.com/tanya-dokter/dr-ika-swasti-mahargyani-sp-gk-aifo-k',NULL),
(20,55000,'3321701420014738','Dr. Dimas Widayu Sp.GK, FINEM',96,21,'https://www.halodoc.com/tanya-dokter/dr-dimas-widayu-sp-gk-finem',NULL);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `education`
--

DROP TABLE IF EXISTS `education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `education` (
  `idEducation` int(11) NOT NULL AUTO_INCREMENT,
  `graduate_year` year(4) NOT NULL,
  `univ_name` varchar(255) NOT NULL,
  `idDoctor` int(11) NOT NULL,
  PRIMARY KEY (`idEducation`),
  KEY `idDoctor` (`idDoctor`),
  CONSTRAINT `education_ibfk_1` FOREIGN KEY (`idDoctor`) REFERENCES `doctor` (`idDoctor`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `education`
--

LOCK TABLES `education` WRITE;
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
INSERT INTO `education` VALUES
(1,2005,'Universitas Hasanuddin',1),
(2,2020,'Universitas Hasanuddin',1),
(3,2014,'FK Universitas Sebelas Maret',2),
(4,2022,'FK Universitas Diponegoro',2),
(5,2008,'Universitas Kristen Maranatha',3),
(6,2022,'Universitas Hasanuddin Makassar',3),
(7,2011,'UNS',4),
(8,2022,'Undip',4),
(9,2018,'Universitas Diponegoro',5),
(10,2011,'Universitas Atma Jaya',5),
(11,2017,'Universitas Hasanuddin',6),
(12,1998,'Universitas Brawijaya',6),
(13,2014,'Universitas Kristen Maranatha',7),
(14,2020,'Universitas Indonesia',7),
(15,2023,'Universitas Indonesia',8),
(16,2017,'Universitas Kristen Krida Wacana (Ukrida)',8),
(17,2022,'Universitas Diponegoro',9),
(18,2014,'Universitas Diponegoro',9),
(19,2001,'Universitas YARSI',10),
(20,2018,'Universitas Hasanuddin',10),
(21,2000,'Universitas Islam Sumatera Utara',11),
(22,2013,'Universitas Indonesia',11),
(23,2011,'Universitas Indonesia',12),
(24,2017,'Universitas Indonesia',12),
(25,2007,'Universitas Indonesia',13),
(26,2001,'Universitas Trisakti',13),
(27,2011,'Universitas Sebelas Maret',14),
(28,2018,'Universitas Indonesia',14),
(29,2016,'Universitas Diponegoro',15),
(30,2002,'Universitas Udayana',15),
(31,2015,'Unniversitas Diponegoro',16),
(32,2010,'Universitas Kristen Maranatha',16),
(33,2022,'Universitas Sebelas Maret',17),
(34,2014,'Universitas Diponegoro',17),
(35,2015,'Universitas Indonesia',18),
(36,2018,'Universitas Indonesia',18),
(37,2022,'Universitas Diponegoro',19),
(38,2016,'Universitas Indonesia',19),
(39,2013,'Universitas Sebelas Maret',20),
(40,2014,'Universitas Indonesia',20);
/*!40000 ALTER TABLE `education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `idPatient` int(11) NOT NULL AUTO_INCREMENT,
  `patient_name` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `street_address` varchar(255) NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `idContact` int(11) NOT NULL,
  `idCity` int(11) NOT NULL,
  PRIMARY KEY (`idPatient`),
  KEY `idContact` (`idContact`),
  KEY `idCity` (`idCity`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`idContact`) REFERENCES `contact` (`idContact`) ON UPDATE CASCADE,
  CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`idCity`) REFERENCES `city` (`idCity`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice`
--

DROP TABLE IF EXISTS `practice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `practice` (
  `idPractice` int(11) NOT NULL AUTO_INCREMENT,
  `idDoctor` int(11) NOT NULL,
  `idCity` int(11) NOT NULL,
  PRIMARY KEY (`idPractice`),
  KEY `idDoctor` (`idDoctor`),
  KEY `idCity` (`idCity`),
  CONSTRAINT `practice_ibfk_1` FOREIGN KEY (`idDoctor`) REFERENCES `doctor` (`idDoctor`) ON UPDATE CASCADE,
  CONSTRAINT `practice_ibfk_2` FOREIGN KEY (`idCity`) REFERENCES `city` (`idCity`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice`
--

LOCK TABLES `practice` WRITE;
/*!40000 ALTER TABLE `practice` DISABLE KEYS */;
INSERT INTO `practice` VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,5,4),
(5,6,5),
(6,7,6),
(7,7,7),
(8,8,8),
(9,9,10),
(10,10,9),
(11,11,6),
(12,12,3),
(13,13,11),
(14,14,12),
(15,15,13),
(16,16,14),
(17,17,15),
(18,18,16),
(19,19,17),
(20,20,18);
/*!40000 ALTER TABLE `practice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `province` (
  `idProvince` int(11) NOT NULL AUTO_INCREMENT,
  `province_name` varchar(255) NOT NULL,
  PRIMARY KEY (`idProvince`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province`
--

LOCK TABLES `province` WRITE;
/*!40000 ALTER TABLE `province` DISABLE KEYS */;
INSERT INTO `province` VALUES
(1,'Sulawesi Selatan'),
(2,'Jawa Tengah'),
(3,'DKI Jakarta'),
(4,'Jambi'),
(5,'Jawa Timur'),
(6,'Jawa Barat'),
(7,'Banten'),
(8,'Kep. Riau'),
(9,'Papua');
/*!40000 ALTER TABLE `province` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-02  7:32:51

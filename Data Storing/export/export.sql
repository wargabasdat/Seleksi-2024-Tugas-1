-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: seleksiBD
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
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat` (
  `link` varchar(255) NOT NULL,
  `nama_pembeli` varchar(255) NOT NULL,
  `waktu` datetime DEFAULT NULL,
  `isi_teks` text DEFAULT NULL,
  PRIMARY KEY (`link`,`nama_pembeli`),
  KEY `nama_pembeli` (`nama_pembeli`),
  CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`link`) REFERENCES `post_mobil` (`link`),
  CONSTRAINT `chat_ibfk_2` FOREIGN KEY (`nama_pembeli`) REFERENCES `pembeli` (`nama_pembeli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cicilan`
--

DROP TABLE IF EXISTS `cicilan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cicilan` (
  `link` varchar(255) NOT NULL,
  `dp` bigint(20) NOT NULL,
  `total_bulan` int(11) NOT NULL,
  `cicilan` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`link`,`dp`,`total_bulan`),
  CONSTRAINT `cicilan_ibfk_1` FOREIGN KEY (`link`) REFERENCES `post_mobil` (`link`),
  CONSTRAINT `fk_link` FOREIGN KEY (`link`) REFERENCES `post_mobil` (`link`) ON DELETE CASCADE,
  CONSTRAINT `dp_positif` CHECK (`dp` >= 0),
  CONSTRAINT `cicilan_positif` CHECK (`cicilan` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cicilan`
--

LOCK TABLES `cicilan` WRITE;
/*!40000 ALTER TABLE `cicilan` DISABLE KEYS */;
INSERT INTO `cicilan` VALUES
('https://www.olx.co.id/item/olx-autos-suzuki-ertiga-15-hybrid-gx-bensin-at-2022-1182-iid-919581976',47424000,60,4624000),
('https://www.olx.co.id/item/olx-mobbi-toyota-voxy-20-bensin-at-2018-pfu-iid-923869195',77707000,60,7707000),
('https://www.olx.co.id/item/olxmobbi-chery-tiggo-8-pro-20-premium-bensin-at-2022-skr-iid-922974627',103314000,60,10314000),
('https://www.olx.co.id/item/olxmobbi-chevrolet-trax-14-premier-bensin-at-2019-vok-iid-920417407',40299000,60,3899000),
('https://www.olx.co.id/item/olxmobbi-chevrolet-trax-14-turbo-ltz-bensin-at-2017-272-iid-922401247',37850000,60,3650000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-10-x-bensin-mt-2019-527-iid-921488967',23822000,60,2222000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-10-x-bensin-mt-2019-819-iid-918958512',22263000,60,2063000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-10-x-bensin-mt-2020-brd-iid-922272161',22708000,60,2108000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-10-x-elegant-bensin-mt-2017-afd-iid-920748106',19368000,60,1768000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-12-r-bensin-mt-2018-813-iid-918957358',25158000,60,2358000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-12-r-bensin-mt-2019-812-iid-918957047',25826000,60,2426000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-12-x-bensin-mt-2019-zkn-iid-922269221',24712000,60,2312000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-12-x-bensin-mt-2020-818-iid-918957155',25380000,60,2380000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-rocky-10-r-asa-bensin-at-2021-pog-iid-922666206',44307000,60,4307000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-sigra-12-r-deluxe-bensin-at-2016-woq-iid-919295197',23822000,60,2222000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-r-bensin-mt-2019-524-iid-921552533',40299000,60,3899000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-r-bensin-mt-2019-tvk-iid-921394576',42971000,60,4171000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-tx-bensin-mt-2009-5gv-iid-920561926',22040000,60,2040000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-x-bensin-at-2020-079-iid-921789481',46534000,60,4534000),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-x-bensin-mt-2023-wir-iid-921174026',50096000,60,4896000),
('https://www.olx.co.id/item/olxmobbi-honda-br-v-15-s-bensin-mt-2016-pie-iid-920894942',34064000,60,3264000),
('https://www.olx.co.id/item/olxmobbi-honda-brio-12-rs-bensin-mt-2017-403-iid-921446584',30947000,60,2947000),
('https://www.olx.co.id/item/olxmobbi-honda-brio-satya-12-e-bensin-at-2022-rkc-iid-922259179',38740000,60,3740000),
('https://www.olx.co.id/item/olxmobbi-honda-brio-satya-12-e-bensin-mt-2020-erw-iid-921031191',34287000,60,3287000),
('https://www.olx.co.id/item/olxmobbi-honda-civic-15-e-bensin-at-2018-6vo-iid-919907970',69691000,60,6891000),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-15-turbo-prestige-bensin-at-2021-ujw-iid-920416677',102423000,60,10223000),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-20-4x2-bensin-mt-2015-413-iid-920519298',48092000,60,4692000),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-20-bensin-at-2018-sjy-iid-919908297',63902000,60,6302000),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-20-bensin-at-2020-wjg-iid-922871096',84387000,60,8387000),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-24-rm3-bensin-at-2015-997-iid-918960468',37404000,60,3604000),
('https://www.olx.co.id/item/olxmobbi-honda-hr-v-15-e-bensin-at-2016-298-iid-921552201',45420000,60,4420000),
('https://www.olx.co.id/item/olxmobbi-honda-hr-v-15-s-bensin-mt-2017-899-iid-921150320',41635000,60,4035000),
('https://www.olx.co.id/item/olxmobbi-honda-jazz-15-rs-bensin-at-2018-wzi-iid-922803799',47870000,60,4670000),
('https://www.olx.co.id/item/olxmobbi-honda-mobilio-15-rs-bensin-at-2014-imk-iid-922934466',31392000,60,2992000),
('https://www.olx.co.id/item/olxmobbi-honda-mobilio-15-rs-bensin-at-2017-1001-iid-919246833',35623000,60,3423000),
('https://www.olx.co.id/item/olxmobbi-honda-mobilio-15-s-bensin-mt-2017-jvc-iid-920369276',32951000,60,3151000),
('https://www.olx.co.id/item/olxmobbi-hyundai-creta-15-prime-ivt-two-tone-bensin-at-2023-uiq-iid-919946728',74367000,60,7367000),
('https://www.olx.co.id/item/olxmobbi-hyundai-creta-15-trend-ivt-bensin-at-2022-kzx-iid-921403707',58335000,60,5735000),
('https://www.olx.co.id/item/olxmobbi-mazda-2-15-gt-bensin-at-2017-599-iid-921313252',41635000,60,4035000),
('https://www.olx.co.id/item/olxmobbi-mazda-cx-5-25-touring-bensin-at-2015-pvk-iid-922257033',50542000,60,4942000),
('https://www.olx.co.id/item/olxmobbi-mitsubishi-outlander-sport-20-gls-bensin-at-2016-862-iid-921501289',40967000,60,3967000),
('https://www.olx.co.id/item/olxmobbi-mitsubishi-outlander-sport-20-glx-bensin-mt-2017-954-iid-922352903',39186000,60,3786000),
('https://www.olx.co.id/item/olxmobbi-mitsubishi-pajero-sport-25-dakar-solar-at-2014-jba-iid-919945654',63011000,60,6211000),
('https://www.olx.co.id/item/olxmobbi-nissan-evalia-15-st-bensin-mt-2012-uoz-iid-919959023',19146000,60,1746000),
('https://www.olx.co.id/item/olxmobbi-nissan-grand-livina-15-sv-bensin-at-2014-2-b1-iid-922353031',20482000,60,1882000),
('https://www.olx.co.id/item/olxmobbi-nissan-juke-15-rx-bensin-at-2011-179-iid-921604077',24490000,60,2290000),
('https://www.olx.co.id/item/olxmobbi-nissan-serena-20-highway-star-bensin-at-2019-3dz-iid-921494115',61898000,60,6098000),
('https://www.olx.co.id/item/olxmobbi-nissan-x-trail-25-bensin-at-2017-064-iid-920807742',48092000,60,4692000),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-14-bensin-at-2019-781-iid-918959400',38740000,60,3740000),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-15-bensin-at-2022-rkt-iid-920417813',51432000,60,5032000),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-15-bensin-at-2022-rkt-iid-921395115',51210000,60,5010000),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-15-bensin-at-2022-uii-iid-922256744',55218000,60,5418000),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-15-bensin-at-2023-816-iid-921726785',55663000,60,5463000),
('https://www.olx.co.id/item/olxmobbi-suzuki-ertiga-15-gx-bensin-mt-2019-991-iid-921590569',40299000,60,3899000),
('https://www.olx.co.id/item/olxmobbi-suzuki-ertiga-15-gx-hybrid-at-2022-427-iid-920807504',50319000,60,4919000),
('https://www.olx.co.id/item/olxmobbi-suzuki-ignis-12-gx-ags-bensin-at-2019-bmr-iid-921679714',30947000,60,2947000),
('https://www.olx.co.id/item/olxmobbi-suzuki-ignis-12-gx-bensin-at-2018-345-iid-921150684',31392000,60,2992000),
('https://www.olx.co.id/item/olxmobbi-suzuki-sx4-15-s-cross-bensin-at-2017-pin-iid-922269696',32060000,60,3060000),
('https://www.olx.co.id/item/olxmobbi-suzuki-sx4-15-s-cross-bensin-at-2021-711-iid-920940275',52100000,60,5100000),
('https://www.olx.co.id/item/olxmobbi-suzuki-xl7-15-beta-bensin-mt-2020-tre-iid-922257931',42748000,60,4148000),
('https://www.olx.co.id/item/olxmobbi-toyota-agya-10-g-bensin-mt-2016-789-iid-918959534',21372000,60,1972000),
('https://www.olx.co.id/item/olxmobbi-toyota-agya-12-g-bensin-at-2021-800-iid-918956874',29834000,60,2834000),
('https://www.olx.co.id/item/olxmobbi-toyota-avanza-13-new-g-bensin-mt-2015-142-iid-920742566',28943000,60,2743000),
('https://www.olx.co.id/item/olxmobbi-toyota-calya-12-g-bensin-at-2020-423-iid-921731704',31615000,60,3015000),
('https://www.olx.co.id/item/olxmobbi-toyota-fortuner-24-4x2-vrz-solar-at-2021-sri-iid-919909405',104204000,60,10404000),
('https://www.olx.co.id/item/olxmobbi-toyota-fortuner-28-4x2-vrz-solar-at-2022-141-iid-921448781',110884000,60,11084000),
('https://www.olx.co.id/item/olxmobbi-toyota-fortuner-28-vrz-solar-at-2022-ujz-iid-918930053',107990000,60,10790000),
('https://www.olx.co.id/item/olxmobbi-toyota-kijang-innova-20-g-bensin-at-2015-cyw-iid-922934691',39854000,60,3854000),
('https://www.olx.co.id/item/olxmobbi-toyota-kijang-innova-20-g-bensin-at-2020-aaf-iid-921294066',63456000,60,6256000),
('https://www.olx.co.id/item/olxmobbi-toyota-kijang-innova-20-v-luxury-bensin-at-2021-407-iid-921596945',81270000,60,8070000),
('https://www.olx.co.id/item/olxmobbi-toyota-raize-10-gr-sport-tss-two-tone-bensin-at-2021-982-iid-921552354',54104000,60,5304000),
('https://www.olx.co.id/item/olxmobbi-toyota-raize-10-t-gr-sport-one-tone-bensin-at-2021-998-iid-918960583',46756000,60,4556000),
('https://www.olx.co.id/item/olxmobbi-toyota-raize-12-g-bensin-at-2023-pzk-iid-919329784',50987000,60,4987000),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-g-bensin-at-2017-779-iid-918959269',33396000,60,3196000),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-7-bensin-mt-2019-567-iid-921716351',48983000,60,4783000),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-bensin-at-2021-poa-iid-921294282',52100000,60,5100000),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-bensin-mt-2018-byj-iid-922272721',44307000,60,4307000),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-bensin-mt-2019-675-iid-921491889',48983000,60,4783000),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-bensin-mt-2019-err-iid-920561653',47647000,60,4647000),
('https://www.olx.co.id/item/olxmobbi-toyota-sienta-15-v-bensin-at-2016-455-iid-921367574',36068000,60,3468000),
('https://www.olx.co.id/item/olxmobbi-toyota-vios-15-g-bensin-at-2016-923-iid-921149959',33619000,60,3219000),
('https://www.olx.co.id/item/olxmobbi-toyota-voxy-20-bensin-at-2017-877-iid-921080792',77484000,60,7684000),
('https://www.olx.co.id/item/olxmobbi-toyota-voxy-20-bensin-at-2018-093-iid-922401874',81270000,60,8070000),
('https://www.olx.co.id/item/olxmobbi-toyota-yaris-15-trd-sportivo-bensin-at-2015-is9-iid-922974846',35178000,60,3378000),
('https://www.olx.co.id/item/olxmobbi-toyota-yaris-15-trd-sportivo-bensin-mt-2017-wox-iid-922271939',40522000,60,3922000),
('https://www.olx.co.id/item/olxmobbi-wuling-almaz-15-exclusive-5-seater-bensin-at-2019-nzi-iid-920562125',42303000,60,4103000),
('https://www.olx.co.id/item/olxmobbi-wuling-almaz-15-smart-enjoy-7-seater-bensin-at-2021-jfg-iid-921393571',42526000,60,4126000),
('https://www.olx.co.id/item/olxmobbi-wuling-confero-s-15-l-lux-plus-bensin-mt-2017-smr-iid-922257247',24267000,60,2267000);
/*!40000 ALTER TABLE `cicilan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_insert_dp
BEFORE INSERT ON cicilan
FOR EACH ROW
BEGIN
    IF NEW.dp < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'dp tidak boleh minus';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_insert_cicilan
BEFORE INSERT ON cicilan
FOR EACH ROW
BEGIN
    IF NEW.cicilan < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'cicilan tidak boleh minus';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_update_dp
BEFORE UPDATE ON cicilan
FOR EACH ROW
BEGIN
    IF NEW.dp < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'dp tidak boleh minus';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_update_cicilan
BEFORE UPDATE ON cicilan
FOR EACH ROW
BEGIN
    IF NEW.cicilan < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'cicilan tidak boleh minus';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `diler`
--

DROP TABLE IF EXISTS `diler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diler` (
  `nama_penjual` varchar(255) NOT NULL,
  `reputasi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nama_penjual`),
  CONSTRAINT `diler_ibfk_1` FOREIGN KEY (`nama_penjual`) REFERENCES `penjual` (`nama_penjual`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diler`
--

LOCK TABLES `diler` WRITE;
/*!40000 ALTER TABLE `diler` DISABLE KEYS */;
/*!40000 ALTER TABLE `diler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like`
--

DROP TABLE IF EXISTS `like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `like` (
  `link` varchar(255) NOT NULL,
  `nama_pembeli` varchar(255) NOT NULL,
  PRIMARY KEY (`link`,`nama_pembeli`),
  KEY `nama_pembeli` (`nama_pembeli`),
  CONSTRAINT `like_ibfk_1` FOREIGN KEY (`link`) REFERENCES `post_mobil` (`link`),
  CONSTRAINT `like_ibfk_2` FOREIGN KEY (`nama_pembeli`) REFERENCES `pembeli` (`nama_pembeli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like`
--

LOCK TABLES `like` WRITE;
/*!40000 ALTER TABLE `like` DISABLE KEYS */;
/*!40000 ALTER TABLE `like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pembeli`
--

DROP TABLE IF EXISTS `pembeli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pembeli` (
  `nama_pembeli` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `daftar_sejak` date DEFAULT NULL,
  PRIMARY KEY (`nama_pembeli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pembeli`
--

LOCK TABLES `pembeli` WRITE;
/*!40000 ALTER TABLE `pembeli` DISABLE KEYS */;
/*!40000 ALTER TABLE `pembeli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penjual`
--

DROP TABLE IF EXISTS `penjual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penjual` (
  `nama_penjual` varchar(255) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `jenis_penjual` varchar(255) DEFAULT NULL,
  `jumlah_iklan` int(11) DEFAULT NULL,
  PRIMARY KEY (`nama_penjual`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penjual`
--

LOCK TABLES `penjual` WRITE;
/*!40000 ALTER TABLE `penjual` DISABLE KEYS */;
INSERT INTO `penjual` VALUES
('Adhi','Bersyukur','Diler',185),
('afan','-','Diler',0),
('alonglim','Jual mobil berkwalitas','Diler',15),
('Alvin','Jual Brio Milil Pribadi','Individu',2),
('Andhika','Hello','Individu',1),
('Andrew Autobahn','follow us at @autobahn.id \nfor newest stock and updates :)','Diler',0),
('Anggoro K D','Let’s just do good things.','Individu',1),
('Antasari Garage','Car Showroom , Auto Detailing & Car Wash \nJl. Pangeran Antasari No 46, Cipete Selatan ,Cilandak .','Diler',8),
('Anugerah Motor Garage','Jual Beli Mobil Second, Tuker Tambah (Pasar Mobil Kemayoran P5 & P6) Kredit atau Cash','Individu',0),
('Ari Sigit','Selalu menghargai orang lain','Individu',1),
('ARIEF S','-','Individu',1),
('Arif','-','Individu',1),
('Arif - focus motor','-','Diler',163),
('AUDY Power Auto','JUAL BELI MOBIL BEKAS','Diler',19),
('Auto second','Sell, buy, trade in car','Diler',12),
('Auto Whole Seller','klik FOLLOW this account OLX to find the best used car in ur hand','Diler',41),
('BensS Auto Garage','Belum Nawar uDah Minta Nett..ehh Di Kasih Net baru Nawar...','Diler',14),
('Big Jaya Auto','Jual Mobil Bekas Berkualitas\nCash/Kredit/Tukar tambah','Diler',7),
('BJM01 (www.bjm-autocars.com)','Mobil Bekas','Diler',0),
('Bongs','Usedcar','Diler',11),
('Calvin','Chris Auto Garage \nBursa Otomotif Sunter \nBlok D2-D3 & C1 No 1A','Diler',0),
('CAR DEAL','-','Individu',1),
('CARAGE INDONESIA','CASH / KREDIT / TRADE IN / BERGARANSI BEBAS TABRAK DAN BANJIR / NEGO SAMPAI DEAL ???','Individu',13),
('CARRO Indonesia','-','Diler',134),
('D & D','Jujur, amanah, barokah','Individu',4),
('D.A','Bleh..bleh..bleeh','Individu',1),
('Daffa','Jual beli mobil berkualitas','Diler',22),
('Dio Trisna Avandy','Welcome\n Wa : 08 lima tujuh satu tujuh delapan delapan sembilan tujuh 67','Diler',19),
('DJAKARTA MOTOR','BRAND NEW AND USED CAR\n\nCASH, CREDIT, TRADE IN\n\nJALAN RADIO DALAM RAYA\n\nJAKARTA SELATAN','Diler',0),
('DSS Motor-JKT 2','Jual&Beli Mobil Bekas Berkualitas Cash/Kredit','Diler',39),
('Dudi','Jual/beli mobil bekas cash/kredit','Diler',16),
('Dwi Fahrani','-','Individu',1),
('Dwiky','be trust','Diler',3),
('ELITE MOTOR','ELITE MOTOR  ||  BURSA MOBIL BSD  BLOK C1  ||  JL. BSD RAYA UTAMA NO 22. TANGERANG','Diler',64),
('Elizabeth','Blessed\n\nAdvokat, Kurator & Konsultan Hukum\nSH & Partners','Individu',6),
('Empire Auto.2 (Alfian)','Jual Beli Trade In Mobil Bekas Berkualitas','Diler',37),
('Eric Indrajaya','Bursa Mobil Bintaro Jl. Raya Boulevard Bintaro Jaya Sektor VII Blok A-21 & 27 (IG : itsmeric_sekencar)','Diler',26),
('Erina usedcars','Jual beli mobil bekas berkualitas','Diler',94),
('Evan - FOCUS MOTOR','HARGA KREDIT/CASH TERBAIK','Diler',214),
('Evi','-','Individu',1),
('FAITH AUTO CARS O81','FAITH Autocars~Terima Jual Beli Tukar Tambah Mobil~Lokasi Grand ITC Permata Hijau Lantai 5 LOT A2','Diler',30),
('Faith_garage','Faith','Diler',11),
('Fandi','-','Diler',6),
('faress88Garage','JUAL BELI MOBIL BEKAS BERKUALITAS CEPAT DAN GA RIBET','Diler',71),
('Fatir','-','Individu',2),
('Felicia Benedicta','BURSA OTOMOTIF MANGGA DUA SQUARE LANTAI LG LOT M21 , B 07  (FOCUS MOTOR) , JKT UTARA','Diler',0),
('Felix FM Motor Mangga 2 Square','Bursa Mobil Mangga Dua Square BLOK B Lot. HL25, Follow IG Kami @fmmotor.id','Diler',62),
('Franz','Garasi Bloko | Premium european cars specialist','Individu',70),
('gammarirz','Only the best','Individu',0),
('Garnet Auto','Jl pejaten barat no 11 C. Jakarta Selatan. Sebelah sekolah Gonzaga','Diler',0),
('GenMud','Mobkas Disini Tempatnya','Individu',3),
('Ghaz','-','Individu',1),
('Habibie Autobahn','Jual Mobil Second Premium','Diler',63),
('HANDY AUTOS','Blok M Square lantai Parkir Atas P5A, Melawai Jaksel. Buka Setiap hari','Diler',306),
('Har WA','Jual/ Beli, cash /kredit, tuker tambah Mobil Bekas','Diler',0),
('Hebo Car','Jual Beli Mobil Berkualitas','Diler',0),
('Herman Matrix Motor','Matrix  Motor\n\n▪ Jual Mobil Baru dan Bekas\n▪ Tukar Tambah\n▪ Cash & Credit\n▪ Segala Merk dan Type kendaraan','Diler',41),
('Herry','wiraswasta','Individu',1),
('herry randa','Daryl\'s auto WTC mangga dua lantai 3A no.75 || Jual beli mobil bekas cash / kredit','Diler',60),
('HM.Budy','-','Individu',1),
('Husadha nurul hudha','-','Individu',1),
('IG 168jayamotor','( IG 168jayamotor )WTC MANGGA DUA TIAPHARI BUKA!!! AKSES LEWAT LIFT TENGAH (  GUDANG MOBIL SABTU MINGGU TETAP BUKA ) TERMURAH SE INDONESIA','Diler',85),
('ig 6  : @fast_automobil','Pusat Jual Beli Mobil Bekas Berkualitas','Diler',162),
('IMEL AW Auto Cars','WTC Mangga Dua Lt 3A No. 85 AW Auto Cars','Diler',0),
('Indra','Car Dealer','Diler',26),
('Irpa','-','Diler',2),
('Jacobson','Nimoo','Individu',3),
('Kent','Jakarta','Diler',13),
('KOKO MORTEN AUTO','Mobil','Diler',127),
('Kredit Murah BCA Finance','-','Diler',121),
('Kristian','Jual Beli Mobil Berkualitas. Menerima Cash/Kredit dan Tukar Tambah. Chat or Call for Fast Response. Follow us on IG : channel_mobil','Diler',0),
('KS Motorsport','Used Car Dealer\nBuy , Sell , Trade in\n Instagram @ksmotorsport.id  Bursa Otomotif PIK-2 Blok D-3','Individu',18),
('Labib','-','Individu',4),
('Landcar Goy','Penjual mobil premium','Diler',11),
('LUMNHS','karyawan swasta','Individu',1),
('M3coupe','Petrolhead','Individu',3),
('M6 Auto','Jual Beli Mobil Second Ciamik','Diler',16),
('Mamay - FOCUS MOTOR','Terima jual beli tukar tambah unit berkualitas stok unit lebih dari 200 mobil','Diler',191),
('Matahari Mobil','Lokasi: Bursa mobil 1 Blok.M1 no.1 Jalan Boulevard timur raya, Kelapa gading. Seberang Lapiazza - MKG Jakarta Utara','Diler',27),
('MECATECH AUTO CAR','Jual beli mbl bekas berkualitas prima dan terpercaya','Diler',0),
('Megalia Auto Gallery','Kami menjual mobil muraah dengan kualitas terbaik','Diler',6),
('Mey','Mey (Focus Motor)\nOffice : \nBursa Otomotif Mangga Dua Square','Diler',0),
('Michael','-','Individu',1),
('Michael Ju','Jual mobil pakai passion dalama kondisi prima','Individu',5),
('Miless','MILES AUTO','Individu',25),
('MOBIL IMPIAN BEKASI','SEDIA BANYAK PILIHAN MOBIL','Diler',72),
('Muhamad ikhsan','Jual Mobil Second Berkualitas','Diler',85),
('N to N otomotif','I love otomotif','Individu',3),
('Nadhira Auto Car','Love family','Diler',0),
('Nanda','instagram : @ndbarunamotor','Diler',52),
('Nicko - FOCUS MOTOR','Showroom mobil bekas berkualitas & bergaransi. Alamat : Jl. Gunung Sahari Raya Bursa Otomotif Mangga Dua Square, Jakarta Utara','Diler',123),
('NITA GARASI AHA','JUAL BELI TUKAR TAMBAH MOBIL BEKAS BERKUALITAS','Diler',60),
('Octa','owner','Individu',6),
('OLX User','-','Individu',1),
('OLXmobbi - Dedy','Dikelola oleh OLX Mobbi','Diler',0),
('Oman','-','Individu',1),
('OwneR','GOD is good','Individu',1),
('prima','-','Individu',1),
('PT.KAWAN MOBIL NUSANTARA','-','Diler',131),
('Qalbi','-','Individu',1),
('Radhisa Rendy','-','Individu',1),
('rainie','Daryls auto WTC Mangga Dua\niG: Darylsauto','Diler',0),
('Rangga Bintang','iyaaa','Individu',1),
('rayraditya','-','Individu',1),
('Regina','Showroom berlokasi di Mangga Dua square, garansi bebas tabrak dan banjir bisa cek ke bengkel resmi.','Diler',231),
('Reynard - Garasi Bloko','Location: Garasi Bloko\nBursa Mobil BSD Blok A5, B5, A8 & A9','Diler',349),
('Ridwan Tedja','Semoga hari anda menyenangkan','Diler',25),
('Rieka Juwita','Marketing di Baruna Motor Jakarta Selatan','Diler',63),
('Risky Royal Auto Cars','@jualbeli.mobiltangerang','Diler',20),
('RNJ_AUTOGARAGE 2','Instagram : Rnj_autogarage','Diler',25),
('Robby - Garasi Bloko Bez Auto','Selling premium Cars Only','Individu',59),
('Ryo','-','Individu',1),
('Sandriana - OLXMobbi','Dikelola oleh OLX Mobbi','Diler',0),
('Setir Kanan','-','Diler',100),
('Shinta','-','Individu',2),
('Sisi','-','Individu',2),
('Sofieee26','Jual-beli mobil 2nd,price spesial hight quality✨','Diler',44),
('Subur','Focus motor','Diler',110),
('Tegar erbama','silahkan telfon di nomor yang tertera di iklan','Diler',26),
('Thalia Autofame','Terima jual beli tukar tambah // Cash & Kredit // mobil bekas berkualitas // Quality Is Our Priority // instagram; Thalia_autofame','Diler',0),
('Thom Rich','Fast Respon :\n\nNol delapan 52 Satu Delapan Tujuh nol 87 Delapan Tujuh\n\nLokasi WA aja !','Individu',127),
('Titan Garage','Mobil klasik/retro/restorasi','Individu',1),
('tyojakarta1679','Buy° Sell° Trade° Consignment','Diler',52),
('unyuunyujuga','-','Individu',6),
('Veby LB Auto','Buy & Sell Premium Car','Diler',47),
('Vinny Focus Motor','Jual Beli Mobil Bekas Berkualitas','Diler',0),
('VIVI - FOCUS MOtOR','Buy•sell•trade car\nSerius Buyer contak wa & tlp\nLokasi : Bursah Mobil Mangga dua Squerr','Diler',223),
('Wawan Kings Auto 2','KING\'S AUTO | BURSA MOBIL SUMARECON SERPONG BLOK F3 + F5 | GADING SERPONG KAB.TANGERANG | MOBIL BEKAS BERGARANSI','Diler',69),
('Wawan Lapak Mobil','WTC Mangga 2 lantai 10 blok : D-E lima belas','Diler',0),
('William','a burning passion for quality','Individu',29),
('Wisnu','-','Individu',2),
('Yales','-','Individu',1),
('Yeni WTC Mangga Dua','Jual Mobil Bekas','Diler',6),
('yogie iskandar','selama iklan masih tayang\nunit masih ada\nsilakan telfon','Individu',12),
('Yudi','-','Individu',1),
('Yulia frapita','Jual beli & tukar tambah Used Cars','Diler',57),
('ZUL NET MOBIL99','Menyajikan segala jenis mobil impian anda, kualitas dan harga terbaik.','Diler',60);
/*!40000 ALTER TABLE `penjual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_mobil`
--

DROP TABLE IF EXISTS `post_mobil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_mobil` (
  `link` varchar(255) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `nama_mobil` varchar(255) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `bahan_bakar` varchar(255) DEFAULT NULL,
  `km` varchar(255) DEFAULT NULL,
  `transmisi` varchar(255) DEFAULT NULL,
  `tahun` int(11) DEFAULT NULL,
  `kapasitas_mesin` varchar(255) DEFAULT NULL,
  `harga` bigint(20) DEFAULT NULL,
  `kota` varchar(255) DEFAULT NULL,
  `provinsi` varchar(255) DEFAULT NULL,
  `nama_penjual` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`link`),
  KEY `fk_nama_penjual` (`nama_penjual`),
  CONSTRAINT `fk_nama_penjual` FOREIGN KEY (`nama_penjual`) REFERENCES `penjual` (`nama_penjual`) ON DELETE CASCADE,
  CONSTRAINT `post_mobil_ibfk_1` FOREIGN KEY (`nama_penjual`) REFERENCES `penjual` (`nama_penjual`),
  CONSTRAINT `harga_positif` CHECK (`harga` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_mobil`
--

LOCK TABLES `post_mobil` WRITE;
/*!40000 ALTER TABLE `post_mobil` DISABLE KEYS */;
INSERT INTO `post_mobil` VALUES
('https://www.olx.co.id/item/6000kmantik-zenix-v-hybrid-modelista-at-20232024-iid-923858522','[6000KM,ANTIK] Zenix V Hybrid Modelista AT 2023/2024','toyota kijang innova (2023)','2.0 Zenix V HV CVT Modellista Hybrid-AT','Hybrid','5.000-10.000 Km','Automatic',2023,'>2.000 - 3.000 cc',485000000,'Cilandak','Jakarta Selatan','Mey'),
('https://www.olx.co.id/item/9000kmrecord-hyundai-creta-15l-trend-ivt-dual-tone-at-20222023-iid-923510368','[9000KM,RECORD] Hyundai Creta 1.5L Trend IVT Dual Tone AT 2022/2023','hyundai creta (2022)','1.5 Trend IVT Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2022,'>1.500 - 2.000 cc',239000000,'Mampang Prapatan','Jakarta Selatan','Adhi'),
('https://www.olx.co.id/item/all-new-mazda-cx-5-elite-2019-iid-923863824','All New Mazda CX-5 Elite 2019','mazda cx-5 (2019)','2.5 Elite Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2019,'>2.000 - 3.000 cc',339000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/all-new-mazda-cx-5-elite-2020-iid-923863592','All New Mazda CX-5 Elite 2020','mazda cx-5 (2020)','2.5 Elite Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2020,'>2.000 - 3.000 cc',365000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/alphard-g-2016-putih-berkualitass-iid-923646944','ALPHARD G 2016 PUTIH BERKUALITASS','toyota alphard (2016)','2.5 G Bensin-AT','Bensin','90.000-95.000 Km','Automatic',2016,'>2.000 - 3.000 cc',648000000,'Cilandak','Jakarta Selatan','Dio Trisna Avandy'),
('https://www.olx.co.id/item/bav-luxury-auto-design-toyota-voxy-20-at-20192018-iid-922999730','(BAV Luxury auto design) Toyota Voxy 2.0 AT 2019/2018','toyota voxy (2019)','2.0 Bensin-AT','Bensin','55.000-60.000 Km','Automatic',2019,'>1.500 - 2.000 cc',320000000,'Cilandak','Jakarta Selatan','Kent'),
('https://www.olx.co.id/item/bmw-218i-gran-coupe-2022-low-odo-iid-923854489','BMW 218i Gran Coupe 2022 LOW ODO','bmw 218i (2022)','1.5 Gran Coupe Sport Bensin-AT','Bensin','0-5.000 Km','Automatic',2022,'>1.000 - 1.500 cc',545000000,'Kebayoran Lama','Jakarta Selatan','ELITE MOTOR'),
('https://www.olx.co.id/item/bmw-320i-f30-m-package-2014-2015-328i-520i-e300-iid-923853376','BMW 320i F30  M Package 2014 / 2015 328i 520i e300','bmw 320i (2015)','2.0 Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2015,'>1.000 - 1.500 cc',349000000,'Kebayoran Baru','Jakarta Selatan','Reynard - Garasi Bloko'),
('https://www.olx.co.id/item/bmw-320i-f30-sport-2014-iid-923204309','BMW 320i F30 Sport 2014','bmw 320i (2014)','2.0 N20 Bensin-AT','Bensin','120.000-125.000 Km','Automatic',2014,'>1.500 - 2.000 cc',266000000,'Cilandak','Jakarta Selatan','Octa'),
('https://www.olx.co.id/item/bmw-e46-m3-coupe-2003-iid-921029310','BMW E46 M3 Coupe 2003','bmw m3 (2003)','','Bensin','40.000-45.000 Km','Manual',2003,'>3.000 cc',1850000000,'Kebayoran Baru','Jakarta Selatan','M3coupe'),
('https://www.olx.co.id/item/bmw-i8-edrive-2017-nik-16-iid-923860616','BMW i8 edrive 2017 nik 16','bmw i8 coupe (2016)','1.5 Hybrid-AT','Hybrid','5.000-10.000 Km','Automatic',2016,'>1.500 - 2.000 cc',2300000000,'Kebayoran Baru','Jakarta Selatan','Herman Matrix Motor'),
('https://www.olx.co.id/item/bmw-x1-2015-bensin-iid-923864264','BMW X1 2015 Bensin','bmw x1 (2015)','2.0 sDrive18i Sport Edition Bensin-AT','Bensin','40000 Km','Otomatis',2015,'>1.500 - 2.000 cc',285000000,'Kebayoran Baru','Jakarta Selatan','Big Jaya Auto'),
('https://www.olx.co.id/item/bmw-x1-xdrive-executive-2012-hitam-aha-gallery-iid-923858318','Bmw X1 Xdrive Executive 2012 hitam (Aha Gallery)','bmw x1 (2012)','1.8 Bensin-AT','Bensin','100.000-105.000 Km','Automatic',2012,'>1.500 - 2.000 cc',175000000,'Kebayoran Baru','Jakarta Selatan','NITA GARASI AHA'),
('https://www.olx.co.id/item/bmw-x5-xdrive40i-at-2023-iid-923412459','BMW X5 xDrive40i AT 2023','bmw x5 (2023)','3.0 xDrive40i xLine Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2023,'>2.000 - 3.000 cc',1425000000,'Kebayoran Baru','Jakarta Selatan','Veby LB Auto'),
('https://www.olx.co.id/item/bmw-x5-xline-xdrive-35i-2015-iid-923863368','BMW X5 xLine xDrive 3.5i 2015','bmw x5 (2015)','3.0 xDrive35i XLine Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2015,'>3.000 cc',545000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/brio-e-at-2023-dp-20-iid-923869631','BRIO E AT 2023 DP 20.','honda brio (2023)','1.2 E Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2023,'>1.000 - 1.500 cc',175000000,'Pesanggrahan','Jakarta Selatan','MOBIL IMPIAN BEKASI'),
('https://www.olx.co.id/item/brio-satya-e-at-2018-iid-923855674','Brio Satya E AT 2018','honda brio satya (2018)','1.2 E Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2018,'>1.000 - 1.500 cc',132000000,'Cilandak','Jakarta Selatan','Evi'),
('https://www.olx.co.id/item/brio-satya-e-cvt-2023-iid-923861357','BRIO SATYA E CVT 2023','honda brio satya (2023)','1.2 New E Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2023,'>1.000 - 1.500 cc',169500000,'Pasar Minggu','Jakarta Selatan','Alvin'),
('https://www.olx.co.id/item/c-200-cgi-classic-c200-2012-iid-918908040','C 200 Cgi classic c200 2012','mercedes-benz c200 (2012)','1.8 CGI Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2012,'>1.500 - 2.000 cc',200000000,'Mampang Prapatan','Jakarta Selatan','Antasari Garage'),
('https://www.olx.co.id/item/calya-g-at-2018-iid-923853876','CALYA G AT 2018','toyota calya (2018)','1.2 G Bensin-AT','Bensin','50.000-55.000 Km','Automatic',2018,'>1.000 - 1.500 cc',105000000,'Kebayoran Lama','Jakarta Selatan','FAITH AUTO CARS O81'),
('https://www.olx.co.id/item/cash-28-gr-sport-2022-km9rb-record-toyota-new-fortuner-matic-diesel-iid-923817522','Cash 2.8 GR SPORT 2022 Km9rb Record Toyota New Fortuner Matic Diesel','toyota fortuner (2022)','2.8 4x2 GR Sport DSL Solar-AT','Diesel','5.000-10.000 Km','Automatic',2022,'>2.000 - 3.000 cc',528000000,'Cilandak','Jakarta Selatan','unyuunyujuga'),
('https://www.olx.co.id/item/cash-murah-bmw-x3-diesel-irit-solar-antik-cat-ori-facelift-turbo-iid-923000610','CASH MURAH BMW X3 Diesel IRIT SOLAR ANTIK CAT ORI FACELIFT TURBO','bmw x3 (2013)','2.0 xDrive20d Efficient Dynamics Solar-AT','Diesel','70.000-75.000 Km','Automatic',2013,'>1.500 - 2.000 cc',259000000,'Cilandak','Jakarta Selatan','Elizabeth'),
('https://www.olx.co.id/item/cash-only-jual-cepat-pajero-sport-2015-dakar-at-4x2-iid-923472500','(Cash only) Jual Cepat PAJERO SPORT 2015 DAKAR AT 4x2','mitsubishi pajero sport (2015)','2.4 Dakar 4x2 Solar-AT','Diesel','205.000-210.000 Km','Automatic',2015,'>2.000 - 3.000 cc',275000000,'Kebayoran Lama','Jakarta Selatan','Yales'),
('https://www.olx.co.id/item/chevrolet-trax-14-ltz-turbo-at-sunroof-2017-2018-iid-923862482','Chevrolet Trax 1.4 LTZ Turbo AT Sunroof 2017 2018','chevrolet trax (2017)','1.4 Turbo LTZ Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2017,'>1.000 - 1.500 cc',145000000,'Kebayoran Baru','Jakarta Selatan','Mamay - FOCUS MOTOR'),
('https://www.olx.co.id/item/ciamik-mitsubishi-grandis-gt-at-2008-iid-923868864','Ciamik Mitsubishi Grandis GT At 2008','mitsubishi grandis (2008)','2.4 GT Bensin-AT','Bensin','120.000-125.000 Km','Automatic',2008,'>2.000 - 3.000 cc',102000000,'Kebayoran Baru','Jakarta Selatan','MECATECH AUTO CAR'),
('https://www.olx.co.id/item/crv-turbo-prestige-2020-km53000-panoramic-simpanan-iid-923867470','CRV Turbo Prestige 2020 KM53.000 Panoramic Simpanan','honda cr-v (2020)','1.5 Turbo Prestige Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2020,'>2.000 - 3.000 cc',411000000,'Kebayoran Lama','Jakarta Selatan','Jacobson'),
('https://www.olx.co.id/item/daihatsu-ayla-m-2014-manual-tangan-pertama-low-km-terawat-paket-dp5jt-iid-923866724','Daihatsu Ayla M 2014 Manual Tangan Pertama Low KM Terawat Paket DP5jt','daihatsu ayla (2014)','1.0 M Bensin-MT','Bensin','75.000-80.000 Km','Manual',2014,'<1.000 cc',70000000,'Pasar Minggu','Jakarta Selatan','afan'),
('https://www.olx.co.id/item/daihatsu-granmax-blind-van-13-ac-fh-mt-2020-dp-95000000-oto029497-iid-923235253','DAIHATSU GRANMAX BLIND VAN 1.3 AC FH M/T 2020 DP. 95.000.000 OTO029497','daihatsu gran max (2022)','1.3 BV AC & PS Bensin-MT','Bensin','15.000-20.000 Km','Manual',2022,'>1.000 - 1.500 cc',95000000,'Kebayoran Baru','Jakarta Selatan','Setir Kanan'),
('https://www.olx.co.id/item/daihatsu-sigra-x-12-at-2024-iid-923857541','Daihatsu Sigra X 1.2 AT 2024','daihatsu sigra (2024)','1.2 X Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2024,'>1.000 - 1.500 cc',148000000,'Cilandak','Jakarta Selatan','Sofieee26'),
('https://www.olx.co.id/item/daihatsu-sirion-13-m-rs-at-tahun-2016-tgn-pertama-istimewa-siap-pakai-iid-923869647','daihatsu sirion 1.3 M RS AT tahun 2016 tgn pertama istimewa siap pakai','daihatsu sirion (2016)','1.3 M Sport Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2016,'>1.000 - 1.500 cc',109500000,'Cilandak','Jakarta Selatan','Fandi'),
('https://www.olx.co.id/item/daihatsu-terios-2018-iid-920928727','DAIHATSU TERIOS 2018','daihatsu terios (2018)','1.5 R Bensin-AT','Bensin','100.000-105.000 Km','Automatic',2018,'>1.000 - 1.500 cc',179000000,'Kebayoran Lama','Jakarta Selatan','LUMNHS'),
('https://www.olx.co.id/item/dijual-cepat-toyota-kijang-innova-2007-iid-922984299','DIJUAL CEPAT Toyota Kijang Innova 2007','toyota kijang innova (2007)','','Bensin','220.000-225.000 Km','Manual',2007,'>1.500 - 2.000 cc',105000000,'Mampang Prapatan','Jakarta Selatan','Qalbi'),
('https://www.olx.co.id/item/dijual-km-7-ribu-yaris-cross-gr-tss-cvt-bensin-iid-923414132','DIJUAL KM 7 RIBU YARIS CROSS GR TSS CVT BENSIN','toyota yaris (2023)','1.5 GR Sport Bensin-AT','Bensin','0-5.000 Km','Automatic',2023,'>1.000 - 1.500 cc',340000000,'Cilandak','Jakarta Selatan','OwneR'),
('https://www.olx.co.id/item/dijual-outlander-sport-20-px-2014-nego-iid-923861097','DIJUAL OUTLANDER SPORT 2.0 PX 2014 (NEGO)','mitsubishi outlander sport (2014)','2.0 PX Bensin-AT','Bensin','125.000-130.000 Km','Automatic',2014,'>1.500 - 2.000 cc',160000000,'Pesanggrahan','Jakarta Selatan','Sisi'),
('https://www.olx.co.id/item/dijualmobil-avanza-2012-matik-iid-923860739','DIJUAL.Mobil Avanza 2012 Matik.','toyota avanza (2012)','1.3 G Bensin-AT','Bensin','115.000-120.000 Km','Automatic',2012,'>1.000 - 1.500 cc',109000000,'Kebayoran Lama','Jakarta Selatan','HM.Budy'),
('https://www.olx.co.id/item/dp-30jt-bmw-520i-2022-m-sport-low-km18rb-pajak-panjang-f6st-iid-912369721','DP 30JT BMW 520i 2022 M SPORT LOW KM.18RB & PAJAK PANJANG #F6ST','bmw 520i (2022)','','Bensin','10.000-15.000 Km','Automatic',2022,'>1.500 - 2.000 cc',850000000,'Pasar Minggu','Jakarta Selatan','ig 6  : @fast_automobil'),
('https://www.olx.co.id/item/dp-40jt-mazda-cx-5-touring-2015-iid-923632449','[dp 40jt] Mazda cx-5 touring 2015','mazda cx-5 (2015)','2.5 Touring Bensin-AT','Bensin','105.000-110.000 Km','Automatic',2015,'>2.000 - 3.000 cc',210000000,'Cilandak','Jakarta Selatan','RNJ_AUTOGARAGE 2'),
('https://www.olx.co.id/item/dp-5-jt-brio-e-metic-2019-iid-923633916','DP 5 JT BRIO E METIC 2019','honda brio (2019)','1.2 E Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2019,'>1.000 - 1.500 cc',140000000,'Cilandak','Jakarta Selatan','DSS Motor-JKT 2'),
('https://www.olx.co.id/item/dp-5-jt-honda-freed-sd-2013-ac-double-tgn-1-istimewa-siap-pakai-iid-923692760','[DP 5 JT] Honda Freed SD 2013 Ac Double Tgn 1 Istimewa Siap Pakai','honda freed (2013)','1.5 E Bensin-AT','Bensin','120.000-125.000 Km','Automatic',2013,'>1.000 - 1.500 cc',119000000,'Pancoran','Jakarta Selatan','Thom Rich'),
('https://www.olx.co.id/item/dp-9juta-honda-brv-e-2023-manual-istimewa-aocl-iid-923336516','[ DP 9juta ] Honda BRV E 2023 Manual Istimewa #aocl#','honda br-v (2023)','1.5 E Bensin-MT','Bensin','15.000-20.000 Km','Manual',2023,'>1.000 - 1.500 cc',218000000,'Cilandak','Jakarta Selatan','BJM01 (www.bjm-autocars.com)'),
('https://www.olx.co.id/item/dp-murah-alphard-25g-atpm-facelift-tahun-2018-iid-922441468','DP MURAH ALPHARD 2.5G ATPM facelift Tahun 2018','toyota alphard (2018)','2.5 G Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2018,'>2.000 - 3.000 cc',840000000,'Cilandak','Jakarta Selatan','Rieka Juwita'),
('https://www.olx.co.id/item/dp-murah-mazda-cx-8-25-elite-tahun-2022-iid-915312178','DP MURAH MAZDA CX-8 2.5 ELITE Tahun 2022','mazda cx-8 (2022)','2.5 Elite Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2022,'>2.000 - 3.000 cc',620000000,'Cilandak','Jakarta Selatan','Rieka Juwita'),
('https://www.olx.co.id/item/dp10-km11000-alphard-g-atpm-2022-2023-mdl-2020-2021-autohigh-iid-918155169','DP10% [Km11.000] Alphard G ATPM 2022 / 2023 Mdl 2020 / 2021 #AUTOHIGH','toyota alphard (2022)','2.5 G Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2022,'>2.000 - 3.000 cc',1135000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km13000-alphard-g-atpm-2021-mdl-2022-2023-autohigh-iid-920525334','DP10% [Km13.000] Alphard G ATPM 2021 Mdl 2022 / 2023 #AUTOHIGH','toyota alphard (2021)','2.5 G Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2021,'>2.000 - 3.000 cc',1065000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km17000-alphard-g-atpm-2019-2020-mdl-2018-2021-autohigh-iid-920567538','DP10% [Km17.000] Alphard G ATPM 2019 / 2020 Mdl 2018 / 2021 #AUTOHIGH','toyota alphard (2019)','2.5 G Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2019,'>2.000 - 3.000 cc',920000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km18000-alphard-g-atpm-2021-2022-mdl-2020-2023-autohigh-iid-922834718','DP10% [Km18.000] Alphard G ATPM 2021 / 2022 Mdl 2020 / 2023 #AUTOHIGH','toyota alphard (2021)','2.5 G Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2021,'>2.000 - 3.000 cc',1035000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km19000-ux200-f-sport-2019-2020-mdl-nx200-rx200-autohigh-iid-922668133','DP10% [Km19.000] UX200 F-Sport 2019 / 2020 Mdl NX200 / RX200 #AUTOHIGH','lexus ux200 (2019)','2.0 F-Sport Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2019,'>1.500 - 2.000 cc',565000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km23000-mini-cooper-cabrio-2019-2020-mdl-2021-autohigh-iid-922931851','DP10% [Km23.000] Mini Cooper Cabrio 2019 / 2020 Mdl 2021 #AUTOHIGH','mini convertible (2019)','1.5 Copper Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2019,'>1.500 - 2.000 cc',685000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km25000-alphard-g-atpm-2021-2022-mdl-2019-2020-autohigh-iid-919257232','DP10% [Km25.000] Alphard G ATPM 2021 / 2022 Mdl 2019 / 2020 #AUTOHIGH','toyota alphard (2021)','2.5 G Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2021,'>2.000 - 3.000 cc',1035000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km34000-pajero-sport-dakar-2021-2022-mdl-2020-autohigh-iid-922670509','DP10% [Km34.000] Pajero Sport Dakar 2021 / 2022 Mdl 2020 #AUTOHIGH','mitsubishi pajero sport (2021)','2.4 Dakar 4x2 Solar-AT','Diesel','25.000-30.000 Km','Automatic',2021,'>2.000 - 3.000 cc',465000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km6000-c300-amg-2023-2024-like-c200-2022-2021-autohigh-iid-923834959','DP10% [Km6.000] C300 AMG 2023 /2024 Like C200 2022 / 2021 #AUTOHIGH','mercedes-benz c300 (2023)','2.0 AMG Line Bensin-AT','Bensin','0-5.000 Km','Automatic',2023,'>2.000 - 3.000 cc',990000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/dp10-km64000-lx570-2014-2015-mdl-f-sport-2012-2013-autohigh-iid-918969835','DP10% [Km64.000] LX570 2014 / 2015 Mdl F-Sport 2012 / 2013 #AUTOHIGH','lexus lx570 (2014)','5.7 Bensin-AT','Bensin','55.000-60.000 Km','Automatic',2014,'>3.000 cc',1125000000,'Kebayoran Baru','Jakarta Selatan','Kredit Murah BCA Finance'),
('https://www.olx.co.id/item/ertiga-gl-manual-2014-iid-923869045','Ertiga GL manual 2014','suzuki ertiga (2014)','1.4 GL Bensin-MT','Bensin','125.000-130.000 Km','Manual',2014,'>1.000 - 1.500 cc',108000000,'Pasar Minggu','Jakarta Selatan','D & D'),
('https://www.olx.co.id/item/ford-ecosport-15-titanium-2015-silver-iid-923852652','Ford Ecosport 1.5 Titanium 2015 silver','ford ecosport (2015)','Titanium-AT','Bensin','75.000-80.000 Km','Automatic',2015,'>1.000 - 1.500 cc',118000000,'Cilandak','Jakarta Selatan','Sofieee26'),
('https://www.olx.co.id/item/ford-escape-2006-bensin-iid-918585438','Ford Escape 2006 Bensin','ford escape (2006)','3.0 Limited Bensin-AT','Bensin','140000 Km','Otomatis',2006,'',99000000,'','','Dudi'),
('https://www.olx.co.id/item/fortuner-srz-matic-bensin-2016-iid-923859215','Fortuner Srz Matic Bensin 2016','toyota fortuner (2016)','2.7 4x2 SRZ Bensin-AT','Bensin','75.000-80.000 Km','Automatic',2016,'>2.000 - 3.000 cc',320000000,'Kebayoran Baru','Jakarta Selatan','BensS Auto Garage'),
('https://www.olx.co.id/item/ganteng-pol-vw-tiguan-allspace-14-tsi-2021-x1-x3-gla200-320i-cx5-crv-iid-921114363','Ganteng Pol! VW Tiguan Allspace 1.4 TSI 2021 x1 x3 gla200 320i cx5 crv','volkswagen tiguan allspace (2021)','1.4 TSI Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2021,'>1.000 - 1.500 cc',349000000,'Kebayoran Baru','Jakarta Selatan','Andrew Autobahn'),
('https://www.olx.co.id/item/honda-accord-24-vtil-2013-hitam-automatic-iid-923858057','Honda Accord 2.4 VTIL 2013 hitam automatic','honda accord (2013)','2.4 VTI-L Bensin-AT','Bensin','100.000-105.000 Km','Automatic',2013,'>2.000 - 3.000 cc',195000000,'Kebayoran Baru','Jakarta Selatan','Erina usedcars'),
('https://www.olx.co.id/item/honda-brio-12-rs-2021-at-black-metallic-iid-923866469','Honda Brio 1.2 RS 2021 AT black metallic','honda brio (2021)','1.2 RS Bensin-AT','Bensin','45.000-50.000 Km','Automatic',2021,'>1.000 - 1.500 cc',165000000,'Cilandak','Jakarta Selatan','Auto Whole Seller'),
('https://www.olx.co.id/item/honda-brv-e-cvt-2017-iid-923864181','Honda brv e cvt 2017','honda br-v (2017)','1.5 E Bensin-AT','Bensin','50.000-55.000 Km','Automatic',2017,'>1.000 - 1.500 cc',172000000,'Pasar Minggu','Jakarta Selatan','Husadha nurul hudha'),
('https://www.olx.co.id/item/honda-crv-24-at-full-service-record-resmi-iid-923389334','Honda CRV  2.4 AT (Full Service Record Resmi)','honda cr-v (2017)','2.4 Bensin-AT','Bensin','155.000-160.000 Km','Automatic',2017,'>2.000 - 3.000 cc',225000000,'Cilandak','Jakarta Selatan','Ryo'),
('https://www.olx.co.id/item/honda-freed-2015-bensin-iid-923862508','Honda Freed 2015 Bensin','honda freed (2015)','1.5 E Bensin-AT','Bensin','90000 Km','Otomatis',2015,'>1.000 - 1.500 cc',188000000,'Mampang Prapatan','Jakarta Selatan','Dudi'),
('https://www.olx.co.id/item/honda-freed-sd-facelift-2012-iid-923853642','Honda Freed SD facelift 2012','honda freed (2012)','1.5 S Bensin-AT','Bensin','115.000-120.000 Km','Automatic',2012,'>1.000 - 1.500 cc',125000000,'Pancoran','Jakarta Selatan','Muhamad ikhsan'),
('https://www.olx.co.id/item/honda-hrv-15-e-cvt-2018-putih-low-km-iid-923858417','Honda HRV 1.5 E CVT 2018 Putih low km','honda hr-v (2018)','1.5 E Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2018,'>1.000 - 1.500 cc',215000000,'Kebayoran Baru','Jakarta Selatan','Hebo Car'),
('https://www.olx.co.id/item/honda-hrv-15-rs-turbo-at-tahun-2022-iid-918523128','HONDA HRV 1.5 RS TURBO AT TAHUN 2022','honda hr-v (2022)','1.5 Turbo RS Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2022,'>1.000 - 1.500 cc',410000000,'Kebayoran Lama','Jakarta Selatan','DJAKARTA MOTOR'),
('https://www.olx.co.id/item/honda-hrv-e-cvt-2016-iid-919614742','HONDA HRV E CVT 2016','honda hr-v (2016)','1.5 E Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2016,'>1.000 - 1.500 cc',180000000,'Cilandak','Jakarta Selatan','M6 Auto'),
('https://www.olx.co.id/item/honda-mobilio-rs-at-2016-iid-923863903','Honda Mobilio RS AT 2016','honda mobilio (2016)','1.5 RS Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2016,'>1.000 - 1.500 cc',150000000,'Pasar Minggu','Jakarta Selatan','Ghaz'),
('https://www.olx.co.id/item/honda-new-accord-15-el-sensing-2022-km-12rb-tangan-1-iid-913074714','Honda New Accord 1.5 EL Sensing 2022 Km 12rb Tangan 1','honda accord (2022)','1.6 Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2022,'>1.000 - 1.500 cc',550000000,'Kebayoran Lama','Jakarta Selatan','Wawan Lapak Mobil'),
('https://www.olx.co.id/item/hot-items-bmw-320i-g20-b48-2021-2022-iid-922251127','HOT ITEMS ! BMW 320i G20 B48 2021 / 2022','bmw 320i (2021)','2.0 Dynamic Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2021,'>1.500 - 2.000 cc',599000000,'Cilandak','Jakarta Selatan','Franz'),
('https://www.olx.co.id/item/hr-v-e-se-2019-2020-2021-cash-10-unit-service-record-honda-hrv-iid-923817792','HR-V E & SE 2019 + 2020 + 2021 Cash 10 Unit Service Record Honda HRV','honda hr-v (2020)','1.5 E Special Edition Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2020,'>1.000 - 1.500 cc',235000000,'Cilandak','Jakarta Selatan','unyuunyujuga'),
('https://www.olx.co.id/item/hyundai-h1-royale-24-at-bensin-iid-923547333','Hyundai H1 ROYALE 2.4 A/T Bensin','hyundai h-1 (2015)','2.4 Royale Bensin-AT','Bensin','90000 Km','Otomatis',2015,'>2.000 - 3.000 cc',205000000,'Kebayoran Baru','Jakarta Selatan','Yudi'),
('https://www.olx.co.id/item/hyundai-stargazer-prime-15-4x2-at-2023-iid-922961221','Hyundai Stargazer Prime 1.5 4x2 AT 2023','hyundai stargazer (2023)','1.5 Prime Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2023,'>1.000 - 1.500 cc',238000000,'Cilandak','Jakarta Selatan','Felicia Benedicta'),
('https://www.olx.co.id/item/innova-venturer-24-at-diesel-2017-iid-923868246','Innova Venturer 2.4 At Diesel 2017','toyota kijang innova (2017)','2.4 Venturer Solar-AT','Diesel','95.000-100.000 Km','Automatic',2017,'>2.000 - 3.000 cc',375000000,'Pasar Minggu','Jakarta Selatan','Labib'),
('https://www.olx.co.id/item/istimewa-mercedes-benz-sprinter-2015-sprinter-315-mercy-sprinter-iid-923558098','Istimewa Mercedes benz Sprinter 2015. Sprinter 315. Mercy Sprinter','mercedes-benz sprinter (2015)','2.1 315 CDi A2 Solar-MT','Diesel','10.000-15.000 Km','Manual',2015,'>2.000 - 3.000 cc',1035000000,'Kebayoran Baru','Jakarta Selatan','Matahari Mobil'),
('https://www.olx.co.id/item/jeep-cherokee-xj-4x4-tahun-1994-iid-923419132','Jeep Cherokee XJ 4x4 tahun 1994','jeep cherokee (1994)','4.0 xj Bensin-AT','Bensin','180.000-185.000 Km','Automatic',1994,'>3.000 cc',190000000,'Kebayoran Baru','Jakarta Selatan','Titan Garage'),
('https://www.olx.co.id/item/jeep-wrangler-rubicon-36-l-at-tahun-2013-km-39rb-iid-922310656','Jeep Wrangler Rubicon 3.6 L AT Tahun 2013 Km 39Rb','jeep wrangler (2013)','3.6 Rubicon Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2013,'>2.000 - 3.000 cc',980000000,'Kebayoran Baru','Jakarta Selatan','KOKO MORTEN AUTO'),
('https://www.olx.co.id/item/jual-cepat-tdp19jt-c200-18-cgi-at-2011-termurah-iid-923855523','JUAL CEPAT! TDP19JT!! C200 1.8 CGI AT 2011 TERMURAH!!','mercedes-benz c200 (2011)','1.8 CGI Bensin-AT','Bensin','60.000-65.000 Km','Automatic',2011,'>1.500 - 2.000 cc',167000000,'Cilandak','Jakarta Selatan','Risky Royal Auto Cars'),
('https://www.olx.co.id/item/jual-mobil-berkualitas-innova-reborn-g-at-2021-iid-923857182','Jual mobil berkualitas Innova reborn G AT 2021','toyota kijang innova (2021)','2.0 G Bensin-AT','Bensin','45.000-50.000 Km','Automatic',2021,'>1.500 - 2.000 cc',317000000,'Kebayoran Baru','Jakarta Selatan','Irpa'),
('https://www.olx.co.id/item/jual-vitara-4x4-istimewa-iid-923855696','Jual Vitara 4X4 Istimewa','suzuki vitara (1993)','1.6 Bensin-MT','Bensin','85.000-90.000 Km','Manual',1993,'>1.000 - 1.500 cc',75000000,'Pesanggrahan','Jakarta Selatan','OLX User'),
('https://www.olx.co.id/item/kia-grand-sedona-ultimate-2017-km-40-rb-pajak-09-25-masih-plastikan-iid-923835105','Kia Grand Sedona Ultimate 2017 km 40 rb pajak 09-25 masih plastikan','kia sedona (2017)','2.0 Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2017,'>2.000 - 3.000 cc',290000000,'Cilandak','Jakarta Selatan','Faith_garage'),
('https://www.olx.co.id/item/kia-sonet-premiere-2021-iid-923854146','KIA SONET PREMIERE 2021.','kia sonet (2020)','1.5 Premiere 5 Seater Bensin-AT','Bensin','50.000-55.000 Km','Automatic',2020,'>1.500 - 2.000 cc',219000000,'Pesanggrahan','Jakarta Selatan','Indra'),
('https://www.olx.co.id/item/kia-sportage-2013-bensin-iid-921194208','Kia Sportage 2013 Bensin','kia sportage (2013)','2.0 EX Bensin-AT','Bensin','90000 Km','Otomatis',2013,'>1.500 - 2.000 cc',150000000,'Mampang Prapatan','Jakarta Selatan','Dudi'),
('https://www.olx.co.id/item/kia-sportage-ex-panoramic-2013-tdp-10-jt-iid-923862140','Kia Sportage EX Panoramic 2013 TDP 10 jt','kia sportage (2013)','2.0 EX Bensin-AT','Bensin','110.000-115.000 Km','Automatic',2013,'>1.500 - 2.000 cc',150000000,'Cilandak','Jakarta Selatan','Garnet Auto'),
('https://www.olx.co.id/item/kijang-innova-v-20-at-2019-hitam-iid-923858157','Kijang innova V 2.0 AT 2019 Hitam','toyota kijang innova (2019)','2.0 V Bensin-AT','Bensin','65.000-70.000 Km','Automatic',2019,'>1.500 - 2.000 cc',298000000,'Cilandak','Jakarta Selatan','Sofieee26'),
('https://www.olx.co.id/item/kijang-lgx-20-tahun-2002-iid-923857751','Kijang LGX 2.0 Tahun 2002','toyota kijang (2002)','2.0 LGX Bensin-AT','Bensin','230.000-235.000 Km','Automatic',2002,'>1.500 - 2.000 cc',72000000,'Cilandak','Jakarta Selatan','Radhisa Rendy'),
('https://www.olx.co.id/item/km-1000-like-new-all-new-honda-accord-20-rs-e-hev-sensing-at-2024-iid-923866295','[KM 1.000, LIKE NEW] All New Honda Accord 2.0 RS E-HEV Sensing AT 2024','honda accord (2024)','2.0 Bensin-AT','Bensin','0-5.000 Km','Automatic',2024,'>2.000 - 3.000 cc',803000000,'Kebayoran Baru','Jakarta Selatan','Evan - FOCUS MOTOR'),
('https://www.olx.co.id/item/km-1000-like-new-all-new-honda-accord-20-rs-e-hev-sensing-at-2024-iid-923866472','[KM 1.000, LIKE NEW] All New Honda Accord 2.0 RS E-HEV Sensing AT 2024','honda accord (2024)','2.0 Bensin-AT','Bensin','0-5.000 Km','Automatic',2024,'>2.000 - 3.000 cc',803000000,'Pesanggrahan','Jakarta Selatan','Mamay - FOCUS MOTOR'),
('https://www.olx.co.id/item/km-40rb-pajak-baru-toyota-voxy-20-2018-pakaian-2019-iid-923869876','KM 40RB | PAJAK BARU | TOYOTA VOXY 2.0 2018 PAKAIAN 2019','toyota voxy (2019)','2.0 Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2019,'>1.500 - 2.000 cc',328000000,'Kebayoran Baru','Jakarta Selatan','Kristian'),
('https://www.olx.co.id/item/km-6rb-full-ori-mazda-6-estate-wagon-25-2022-at-istimewa-20212023-iid-922735107','KM 6RB FULL ORI ! MAZDA 6 ESTATE WAGON 2.5 2022 AT ISTIMEWA 2021/2023','mazda 6 (2022)','2.5 Elite Estate Bensin-AT','Bensin','0-5.000 Km','Automatic',2022,'>2.000 - 3.000 cc',525000000,'Kebayoran Lama','Jakarta Selatan','ZUL NET MOBIL99'),
('https://www.olx.co.id/item/km-9000-new-toyota-land-cruiser-lc300-vxr-diesel-at-20222023-iid-923697180','[KM 9.000] New Toyota Land Cruiser LC300 VXR Diesel AT 2022/2023','toyota land cruiser (2022)','4.5 VX-R Solar-AT','Diesel','5.000-10.000 Km','Automatic',2022,'>3.000 cc',2275000000,'Kebayoran Baru','Jakarta Selatan','VIVI - FOCUS MOtOR'),
('https://www.olx.co.id/item/km-antik-mitsubishi-fuso-colt-diesel-canter-euro2-4x2-mt-20222023-iid-923863109','[KM ANTIK] Mitsubishi Fuso Colt Diesel Canter EURO2 4x2 MT 2022/2023','mitsubishi fuso (2022)','4.0 Solar-MT','Diesel','10.000-15.000 Km','Manual',2022,'>3.000 cc',385000000,'Kebayoran Lama','Jakarta Selatan','VIVI - FOCUS MOtOR'),
('https://www.olx.co.id/item/km-low-daihatsu-xenia-xi-family-2010-matic-aocl-iid-923193702','KM Low Daihatsu Xenia Xi Family 2010 Matic #aocl#','daihatsu xenia (2010)','1.3 R Family Bensin-AT','Bensin','105.000-110.000 Km','Automatic',2010,'>1.000 - 1.500 cc',88000000,'Cilandak','Jakarta Selatan','BJM01 (www.bjm-autocars.com)'),
('https://www.olx.co.id/item/km20rb-honda-accord-turbo-sensing-2019-putih-tangan-pertama-dari-baru-iid-923850049','km20rb honda accord turbo sensing 2019 putih tangan pertama dari baru','honda accord (2019)','1.5 Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2019,'>1.000 - 1.500 cc',428000000,'Pasar Minggu','Jakarta Selatan','Regina'),
('https://www.olx.co.id/item/km53rb-asli-voxy-20-at-2018-hitam-istimewa-super-seger-full-ori-iid-922088733','KM.53.RB ASLI!! VOXY 2.0 AT 2018 HITAM ISTIMEWA SUPER SEGER FULL ORI!!','toyota voxy (2018)','2.0 Bensin-AT','Bensin','50.000-55.000 Km','Automatic',2018,'>1.500 - 2.000 cc',329000000,'Pasar Minggu','Jakarta Selatan','Wawan Kings Auto 2'),
('https://www.olx.co.id/item/km60rb-low-honda-hrv-e-cvt-2016-15-matic-at-hr-v-non-prestige-iid-923868457','[KM60RB LOW] Honda HRV E CVT 2016 1.5 Matic AT HR-V non prestige','honda hr-v (2016)','E CVT-AT','Bensin','55.000-60.000 Km','Automatic',2016,'>1.000 - 1.500 cc',181000000,'Cilandak','Jakarta Selatan','William'),
('https://www.olx.co.id/item/land-rover-defender-110-se-20202021-suv-20-iid-922413412','Land Rover Defender 110 SE 2020/2021 SUV 2.0','land rover defender (2021)','2.3-AT','Bensin','20.000-25.000 Km','Automatic',2021,'>1.500 - 2.000 cc',1959000000,'Cilandak','Jakarta Selatan','Robby - Garasi Bloko Bez Auto'),
('https://www.olx.co.id/item/land-rover-range-rover-vouge-autobiography-30-v6-2014-2016-iid-917283867','Land Rover Range Rover Vouge Autobiography 3.0 V6 2014 / 2016','land rover range rover (2014)','3.0 Vogue Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2014,'>2.000 - 3.000 cc',1550000000,'Cilandak','Jakarta Selatan','Franz'),
('https://www.olx.co.id/item/lexus-lx570-2020-sport-4x4-at-iid-923207243','LEXUS LX570 2020 SPORT 4x4 A/T','lexus lx570 (2020)','5.7 Sport Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2020,'>3.000 cc',2400000000,'Kebayoran Lama','Jakarta Selatan','CAR DEAL'),
('https://www.olx.co.id/item/lexus-rx300-20-f-sport-2018-iid-923736093','Lexus RX300 2.0 F-Sport 2018','lexus rx300 (2018)','2.0 F-Sport Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2018,'>1.500 - 2.000 cc',838000000,'Kebayoran Baru','Jakarta Selatan','Yulia frapita'),
('https://www.olx.co.id/item/lexus-rx300-f-sport-2019-x5-alphard-ml400-iid-923587910','Lexus RX300 F-Sport 2019 x5 alphard ml400','lexus rx300 (2019)','2.0 F-Sport Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2019,'>1.500 - 2.000 cc',820000000,'Kebayoran Baru','Jakarta Selatan','Reynard - Garasi Bloko'),
('https://www.olx.co.id/item/low-km-1000-like-new-new-honda-accord-rs-e-hev-sensing-at-2024-iid-923867050','[ LOW KM 1.000, LIKE NEW ] New Honda Accord RS E-HEV Sensing AT 2024','honda accord (2024)','','Bensin','0-5.000 Km','Automatic',2024,'>2.000 - 3.000 cc',803000000,'Pancoran','Jakarta Selatan','Felicia Benedicta'),
('https://www.olx.co.id/item/low-km-honda-accord-15-vtil-turbo-sensing-putih-at-20192020-iid-923855519','[ LOW KM] Honda Accord 1.5 VTIL Turbo Sensing Putih AT 2019/2020','honda accord (2019)','1.5 Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2019,'>1.000 - 1.500 cc',428000000,'Cilandak','Jakarta Selatan','VIVI - FOCUS MOtOR'),
('https://www.olx.co.id/item/low-km-honda-accord-15-vtil-turbo-sensing-putih-at-20192020-iid-923855608','[ LOW KM] Honda Accord 1.5 VTIL Turbo Sensing Putih AT 2019/2020','honda accord (2019)','1.5 Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2019,'>1.500 - 2.000 cc',428000000,'Kebayoran Baru','Jakarta Selatan','Nicko - FOCUS MOTOR'),
('https://www.olx.co.id/item/low-km-nissan-grand-livina-2010-xv-at-iid-923869097','(LOW KM) Nissan Grand livina 2010 XV AT','nissan grand livina (2010)','1.5 XV Bensin-AT','Bensin','30000 Km','Otomatis',2010,'>1.000 - 1.500 cc',89000000,'Pesanggrahan','Jakarta Selatan','rayraditya'),
('https://www.olx.co.id/item/low-km-sunroof-chevrolet-trax-14-ltz-turbo-at-sunroof-20172018-iid-923862185','[ LOW KM, Sunroof ] Chevrolet Trax 1.4 LTZ Turbo AT Sunroof 2017/2018','chevrolet trax (2017)','1.4 Turbo LTZ Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2017,'>1.000 - 1.500 cc',145000000,'Cilandak','Jakarta Selatan','VIVI - FOCUS MOtOR'),
('https://www.olx.co.id/item/low-km-sunroof-toyota-voxy-20-atpm-putih-20182019-iid-923860325','[ LOW KM, Sunroof ] Toyota Voxy 2.0 ATPM Putih 2018/2019','toyota voxy (2018)','2.0 Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2018,'>2.000 - 3.000 cc',339000000,'Cilandak','Jakarta Selatan','Vinny Focus Motor'),
('https://www.olx.co.id/item/low-km-sunroof-toyota-voxy-20-atpm-putih-20182019-iid-923860401','[ LOW KM, Sunroof ] Toyota Voxy 2.0 ATPM Putih 2018/2019','toyota voxy (2018)','2.0 Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2018,'>1.500 - 2.000 cc',339000000,'Pasar Minggu','Jakarta Selatan','VIVI - FOCUS MOtOR'),
('https://www.olx.co.id/item/low-kmpjk-panjang-toyota-voxy-20-atpm-putih-20182019-iid-923862059','[LOW KM,PJK PANJANG] Toyota Voxy 2.0 ATPM Putih 2018/2019','toyota voxy (2018)','2.0 Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2018,'>2.000 - 3.000 cc',339000000,'Mampang Prapatan','Jakarta Selatan','Arif - focus motor'),
('https://www.olx.co.id/item/matic-daihatsu-luxio-x-15-at-2015-granmax-d-mt-iid-923861453','(Matic) Daihatsu luxio X 1.5 AT 2015  / Granmax D MT','daihatsu luxio (2015)','1.5 X Bensin-AT','Bensin','85.000-90.000 Km','Automatic',2015,'>1.000 - 1.500 cc',140000000,'Cilandak','Jakarta Selatan','Kent'),
('https://www.olx.co.id/item/mazda-2-gt-skyactiv-at-2018-merah-iid-923636450','Mazda 2 GT Skyactiv AT 2018 Merah','mazda 2 (2018)','1.5 GT Skyactiv Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2018,'>1.500 - 2.000 cc',200000000,'Mampang Prapatan','Jakarta Selatan','CARRO Indonesia'),
('https://www.olx.co.id/item/mazda-2-putih-service-record-bengkel-resmi-iid-923860006','Mazda 2 Putih Service Record bengkel resmi','mazda 2 (2018)','1.5 GT Bensin-AT','Bensin','75.000-80.000 Km','Automatic',2018,'>1.000 - 1.500 cc',185000000,'Kebayoran Baru','Jakarta Selatan','Herry'),
('https://www.olx.co.id/item/mazda-cx-5-2012-bensin-iid-923861553','Mazda CX-5 2012 Bensin','mazda cx-5 (2012)','2.0 Touring Bensin-AT','Bensin','140000 Km','Otomatis',2012,'>1.500 - 2.000 cc',170000000,'Pancoran','Jakarta Selatan','D.A'),
('https://www.olx.co.id/item/mazda-cx-5-touring-25-skyactive-putih-sunroof-80k-km-mulusterawat-iid-923857279','Mazda CX-5 Touring 2.5 SkyActive Putih, Sunroof. 80k KM, Mulus,Terawat','mazda cx-5 (2013)','2.5 Touring Bensin-AT','Bensin','75.000-80.000 Km','Automatic',2013,'>2.000 - 3.000 cc',178000000,'Cilandak','Jakarta Selatan','Anggoro K D'),
('https://www.olx.co.id/item/mazda-cx-8-elite-skyactiv-2021-iid-923862605','Mazda CX-8 Elite Skyactiv 2021','mazda cx-8 (2021)','2.5 Elite Bensin-AT','Bensin','25.000-30.000 Km','Automatic',2021,'>2.000 - 3.000 cc',439000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/mazda-cx9-25-turbo-facelift-nik-2018-akhir-fullspec-black-on-black-fu-iid-923548529','Mazda CX9 2.5 Turbo Facelift NIK 2018 Akhir Fullspec Black On Black Fu','mazda cx-9 (2019)','2.5 SKYACTIV-G Bensin-AT','Bensin','50.000-55.000 Km','Automatic',2019,'>2.000 - 3.000 cc',455000000,'Pesanggrahan','Jakarta Selatan','Thalia Autofame'),
('https://www.olx.co.id/item/mazda-cx9-gt-tahun-2011-automatic-abu-abu-iid-922575740','Mazda CX9 GT Tahun 2011 Automatic Abu-abu','mazda cx-9 (2011)','3.7 GT Bensin-AT','Bensin','140.000-145.000 Km','Automatic',2011,'>3.000 cc',179000000,'Pasar Minggu','Jakarta Selatan','HANDY AUTOS'),
('https://www.olx.co.id/item/mercedes-benz-a200-13-progressive-line-2022-iid-923862874','Mercedes Benz A200 1.3 Progressive Line 2022','mercedes-benz a200 (2022)','1.3 Progressive Line Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2022,'>1.000 - 1.500 cc',555000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/mercedes-benz-c250-amg-2015-iid-923864058','Mercedes Benz C250 AMG 2015','mercedes-benz c250 (2015)','2.0 Estate AMG Line Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2015,'>2.000 - 3.000 cc',465000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/mercedes-benz-c250-amg-line-2016-pakai-2017-bensin-iid-923682008','Mercedes-Benz C250 AMG line 2016 pakai 2017 Bensin','mercedes-benz c250 (2017)','2.0 Este AMG Line Bensin-AT','Bensin','30000 Km','Otomatis',2016,'>1.500 - 2.000 cc',490000000,'Cilandak','Jakarta Selatan','Bongs'),
('https://www.olx.co.id/item/mercedes-benz-c300-amg-final-edition-2020-iid-923865471','Mercedes Benz C300 AMG Final Edition 2020','mercedes-benz c300 (2020)','2.0 AMG Line Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2020,'>2.000 - 3.000 cc',619000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/mercedes-benz-c300-amg-line-at-2019-like-new-terawat-rapih-tdp-15jt-iid-921825895','Mercedes Benz C300 AMG Line AT 2019 LIKE NEW terawat rapih tdp 15jt','mercedes-benz c300 (2019)','2.0 AMG Line Bensin-AT','Bensin','25.000-30.000 Km','Automatic',2019,'>1.500 - 2.000 cc',683000000,'Kebayoran Baru','Jakarta Selatan','herry randa'),
('https://www.olx.co.id/item/mercedes-benz-cla200-c117-amg-coupe-facelift-2018-2019-c200-320i-iid-923722794','Mercedes Benz CLA200 C117 AMG Coupè Facelift 2018 / 2019 c200 320i','mercedes-benz cla200 (2019)','1.6 AMG Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2019,'>1.500 - 2.000 cc',495000000,'Kebayoran Baru','Jakarta Selatan','Reynard - Garasi Bloko'),
('https://www.olx.co.id/item/mercedes-benz-cla200-sport-amg-2017-iid-923863073','Mercedes Benz CLA200 Sport AMG 2017','mercedes-benz cla200 (2017)','1.6 AMG Bensin-AT','Bensin','25.000-30.000 Km','Automatic',2017,'>1.500 - 2.000 cc',405000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/mercedes-benz-e300-e-300-w213-iid-923769194','Mercedes Benz E300 E 300 W213','mercedes-benz e300 (2016)','2.0 Avantgarde Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2016,'>1.500 - 2.000 cc',599000000,'Kebayoran Lama','Jakarta Selatan','Michael Ju'),
('https://www.olx.co.id/item/mercedes-benz-gla-200-amg-panoramic-tahun-2014-automatic-hitam-iid-923865920','Mercedes Benz GLA 200 AMG Panoramic Tahun 2014 Automatic Hitam','mercedes-benz gla200 (2014)','1.6 AMG Bensin-AT','Bensin','75.000-80.000 Km','Automatic',2014,'>1.500 - 2.000 cc',349000000,'Pesanggrahan','Jakarta Selatan','HANDY AUTOS'),
('https://www.olx.co.id/item/mercedes-benz-glc200-amg-night-edition-2020-iid-923865771','Mercedes Benz GLC200 AMG Night Edition 2020','mercedes-benz glc200 (2020)','2.0 AMG Line Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2020,'>2.000 - 3.000 cc',635000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/mercedez-benz-cla-200-14-at-turbo-bisa-tt-camry-iid-922756809','Mercedez benz cla 200 1.4 at turbo bisa tt camry','mercedes-benz cla200 (2020)','1.3 AMG Line Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2020,'>1.500 - 2.000 cc',629000000,'Cilandak','Jakarta Selatan','N to N otomotif'),
('https://www.olx.co.id/item/mercy-e300-2012-v6-e-300-iid-923862080','Mercy E300 2012 V6 E 300','mercedes-benz e300 (2012)','3.0 Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2012,'>2.000 - 3.000 cc',280000000,'Kebayoran Baru','Jakarta Selatan','KS Motorsport'),
('https://www.olx.co.id/item/mg-hs-lux-15-at-2020-termurah-se-indonesia-iid-923857154','MG HS LUX 1.5 AT 2020 TERMURAH SE INDONESIA','mg hs (2020)','1.5 Ignite Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2020,'>1.000 - 1.500 cc',248000000,'Kebayoran Lama','Jakarta Selatan','Nanda'),
('https://www.olx.co.id/item/miles-32000-vw-volkswagen-beetle-14-tsi-herbie-style-at-20132014-iid-923825008','[MILES 32.000] Vw Volkswagen Beetle 1.4 Tsi Herbie Style AT 2013/2014','volkswagen beetle (2013)','1.4 Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2013,'>1.000 - 1.500 cc',525000000,'Kebayoran Baru','Jakarta Selatan','VIVI - FOCUS MOtOR'),
('https://www.olx.co.id/item/mitsubishi-mirage-12-sport-at-full-original-gress-kaya-baru-iid-923069886','MITSUBISHI MIRAGE 1.2 SPORT AT FULL ORIGINAL GRESS KAYA BARU','mitsubishi mirage (2015)','1.2 SPORT Bensin-AT','Bensin','85.000-90.000 Km','Automatic',2015,'>1.000 - 1.500 cc',88000000,'Cilandak','Jakarta Selatan','IG 168jayamotor'),
('https://www.olx.co.id/item/mitsubishi-pajero-sport-dakar-2022-diesel-iid-923854786','Mitsubishi Pajero Sport Dakar 2022 Diesel','mitsubishi pajero sport (2022)','2.4 Dakar 4x2 Solar-AT','Diesel','20000 Km','Otomatis',2022,'>2.000 - 3.000 cc',499000000,'Pasar Minggu','Jakarta Selatan','Bongs'),
('https://www.olx.co.id/item/mitsubishi-strada-triton-dobel-kabin-4x4-manual-asli-plat-b-dari-baru-iid-923857569','Mitsubishi Strada Triton dobel kabin 4x4 manual asli plat B dari baru','mitsubishi strada triton (2012)','2.5 DI-D Solar-MT','Diesel','170.000-175.000 Km','Manual',2012,'>2.000 - 3.000 cc',166500000,'Cilandak','Jakarta Selatan','prima'),
('https://www.olx.co.id/item/mitsubishi-xpander-ultimate-2019-iid-921045884','Mitsubishi Xpander Ultimate 2019','mitsubishi xpander (2019)','1.5 Ultime Bensin-AT','Bensin','50000 Km','Otomatis',2019,'>1.000 - 1.500 cc',205000000,'Cilandak','Jakarta Selatan','M6 Auto'),
('https://www.olx.co.id/item/new-mercedes-benz-g63-amg-2023-rare-colour-magno-green-iid-909832811','NEW MERCEDES-BENZ G63 AMG 2023 RARE COLOUR  MAGNO GREEN','mercedes-benz g-class (2023)','G55 AMG-AT','Bensin','0-5.000 Km','Automatic',2023,'>3.000 cc',7000000000,'Kebayoran Baru','Jakarta Selatan','Miless'),
('https://www.olx.co.id/item/nissan-elgrand-2014-iid-923867052','Nissan Elgrand 2014','nissan elgrand (2014)','2.4 Highway Star Bensin-AT','Bensin','95.000-100.000 Km','Automatic',2014,'>2.000 - 3.000 cc',420000000,'Cilandak','Jakarta Selatan','Wisnu'),
('https://www.olx.co.id/item/nissan-livina-15-vl-at-2019-putih-iid-923609655','Nissan Livina 1.5 VL AT 2019 Putih','nissan livina (2019)','1.5 VL Bensin-AT','Bensin','65.000-70.000 Km','Automatic',2019,'>1.000 - 1.500 cc',187000000,'Pasar Minggu','Jakarta Selatan','CARRO Indonesia'),
('https://www.olx.co.id/item/nissan-serena-2015-hws-iid-923865117','Nissan Serena 2015 HWS','nissan serena (2015)','2.0 Highway Star Bensin-AT','Bensin','60.000-65.000 Km','Automatic',2015,'>1.500 - 2.000 cc',175000000,'Cilandak','Jakarta Selatan','Rangga Bintang'),
('https://www.olx.co.id/item/nissan-serena-hws-2019-tdp-12jt-iid-923858474','Nissan Serena HWS 2019 Tdp 12jt','nissan serena (2019)','2.0 Highway Star Bensin-AT','Bensin','115.000-120.000 Km','Automatic',2019,'>1.500 - 2.000 cc',286000000,'Kebayoran Baru','Jakarta Selatan','Auto second'),
('https://www.olx.co.id/item/nissan-xtrail-25-at-matic-2018-km-50-ribu-an-iid-923864469','NISSAN XTRAIL 2.5 AT Matic 2018 - KM 50 Ribu an','nissan x-trail (2018)','2.5 T32 Bensin-AT','Bensin','45.000-50.000 Km','Automatic',2018,'>2.000 - 3.000 cc',220000000,'Cilandak','Jakarta Selatan','AUDY Power Auto'),
('https://www.olx.co.id/item/olx-autos-suzuki-ertiga-15-hybrid-gx-bensin-at-2022-1182-iid-919581976','[OLX AUTOS] Suzuki Ertiga 1.5 Hybrid GX Bensin-AT 2022 1182','suzuki ertiga (2022)','1.5 GX Hybrid-AT','Bensin','55.000-60.000 Km','Automatic',2022,'>1.000 - 1.500 cc',204000000,'Cipayung','Jakarta Timur','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olx-mobbi-toyota-voxy-20-bensin-at-2018-pfu-iid-923869195','[OLX Mobbi] Toyota Voxy 2.0 Bensin-AT 2018 PFU','toyota voxy (2018)','2.0 Bensin-AT','Bensin','85.000-90.000 Km','Automatic',2018,'>2.000 - 3.000 cc',340000000,'Jati Sampurna','Bekasi Kota','Sandriana - OLXMobbi'),
('https://www.olx.co.id/item/olxmobbi-chery-tiggo-8-pro-20-premium-bensin-at-2022-skr-iid-922974627','[OLXmobbi] Chery Tiggo 8 Pro 2.0 Premium Bensin-AT 2022 SKR','chery tiggo 8 pro (2022)','2.0 Premium Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2022,'>1.500 - 2.000 cc',455000000,'Tebet','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-chevrolet-trax-14-premier-bensin-at-2019-vok-iid-920417407','[OLXmobbi] Chevrolet Trax 1.4 Premier Bensin-AT 2019 VOK','chevrolet trax (2019)','1.4 Premier Bensin-AT','Bensin','80.000-85.000 Km','Automatic',2019,'>1.000 - 1.500 cc',172000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-chevrolet-trax-14-turbo-ltz-bensin-at-2017-272-iid-922401247','[OLXmobbi] Chevrolet Trax 1.4 Turbo LTZ Bensin-AT 2017 272','chevrolet trax (2017)','1.4 Turbo LTZ Bensin-AT','Bensin','100.000-105.000 Km','Automatic',2017,'>1.000 - 1.500 cc',161000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-10-x-bensin-mt-2019-527-iid-921488967','[OLXmobbi] Daihatsu Ayla 1.0 X Bensin-MT 2019 527','daihatsu ayla (2019)','1.0 X Bensin-MT','Bensin','40.000-45.000 Km','Manual',2019,'<1.000 cc',98000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-10-x-bensin-mt-2019-819-iid-918958512','[OLXmobbi] Daihatsu Ayla 1.0 X Bensin-MT 2019 819','daihatsu ayla (2019)','1.0 X Bensin-MT','Bensin','75.000-80.000 Km','Manual',2019,'>1.000 - 1.500 cc',91000000,'Medan Satria','Bekasi Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-10-x-bensin-mt-2020-brd-iid-922272161','[OLXmobbi] Daihatsu Ayla 1.0 X Bensin-MT 2020 BRD','daihatsu ayla (2020)','1.0 X Bensin-MT','Bensin','40.000-45.000 Km','Manual',2020,'<1.000 cc',93000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-10-x-elegant-bensin-mt-2017-afd-iid-920748106','[OLXmobbi] Daihatsu Ayla 1.0 X Elegant Bensin-MT 2017 AFD','daihatsu ayla (2017)','1.0 X Elegant Bensin-MT','Bensin','120.000-125.000 Km','Manual',2017,'<1.000 cc',78000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-12-r-bensin-mt-2018-813-iid-918957358','[OLXmobbi] Daihatsu Ayla 1.2 R Bensin-MT 2018 813','daihatsu ayla (2018)','1.2 R Bensin-MT','Bensin','95.000-100.000 Km','Manual',2018,'>1.000 - 1.500 cc',104000000,'Serpong','Tangerang Selatan Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-12-r-bensin-mt-2019-812-iid-918957047','[OLXmobbi] Daihatsu Ayla 1.2 R Bensin-MT 2019 812','daihatsu ayla (2019)','1.2 R Bensin-MT','Bensin','25.000-30.000 Km','Manual',2019,'>1.000 - 1.500 cc',107000000,'Serpong','Tangerang Selatan Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-12-x-bensin-mt-2019-zkn-iid-922269221','[OLXmobbi] Daihatsu Ayla 1.2 X Bensin-MT 2019 ZKN','daihatsu ayla (2019)','1.2 X Bensin-MT','Bensin','90.000-95.000 Km','Manual',2019,'>1.000 - 1.500 cc',102000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-ayla-12-x-bensin-mt-2020-818-iid-918957155','[OLXmobbi] Daihatsu Ayla 1.2 X Bensin-MT 2020 818','daihatsu ayla (2020)','1.2 X Bensin-MT','Bensin','75.000-80.000 Km','Manual',2020,'>1.000 - 1.500 cc',105000000,'Cinere','Depok Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-rocky-10-r-asa-bensin-at-2021-pog-iid-922666206','[OLXmobbi] Daihatsu Rocky 1.0 R ASA Bensin-AT 2021 POG','daihatsu rocky (2021)','1.0 R ASA Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2021,'<1.000 cc',190000000,'Tebet','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-sigra-12-r-deluxe-bensin-at-2016-woq-iid-919295197','[OLXmobbi] Daihatsu Sigra 1.2 R Deluxe Bensin-AT 2016 WOQ','daihatsu sigra (2016)','1.2 R Deluxe Bensin-MT','Bensin','105.000-110.000 Km','Manual',2016,'>1.000 - 1.500 cc',98000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-r-bensin-mt-2019-524-iid-921552533','[OLXmobbi] Daihatsu Terios 1.5 R Bensin-MT 2019 524','daihatsu terios (2019)','1.5 R Bensin-MT','Bensin','165.000-170.000 Km','Manual',2019,'>1.000 - 1.500 cc',172000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-r-bensin-mt-2019-tvk-iid-921394576','[OLXmobbi] Daihatsu Terios 1.5 R Bensin-MT 2019 TVK','daihatsu terios (2019)','1.5 R Bensin-MT','Bensin','50.000-55.000 Km','Manual',2019,'>1.000 - 1.500 cc',184000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-tx-bensin-mt-2009-5gv-iid-920561926','[OLXmobbi] Daihatsu Terios 1.5 TX Bensin-MT 2009 5GV','daihatsu terios (2009)','1.5 TX Bensin-MT','Bensin','105.000-110.000 Km','Manual',2009,'<1.000 cc',90000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-x-bensin-at-2020-079-iid-921789481','[OLXmobbi] Daihatsu Terios 1.5 X Bensin-AT 2020 079','daihatsu terios (2020)','1.5 X Bensin-AT','Bensin','55.000-60.000 Km','Automatic',2020,'>1.000 - 1.500 cc',200000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-daihatsu-terios-15-x-bensin-mt-2023-wir-iid-921174026','[OLXmobbi] Daihatsu Terios 1.5 X Bensin-MT 2023 WIR','daihatsu terios (2023)','1.5 X Bensin-MT','Bensin','15.000-20.000 Km','Manual',2023,'>1.000 - 1.500 cc',216000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-br-v-15-s-bensin-mt-2016-pie-iid-920894942','[OLXmobbi] Honda BR-V 1.5 S Bensin-MT 2016 PIE','honda br-v (2016)','1.5 S Bensin-MT','Bensin','75.000-80.000 Km','Manual',2016,'>1.000 - 1.500 cc',144000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-brio-12-rs-bensin-mt-2017-403-iid-921446584','[OLXmobbi] Honda Brio 1.2 RS Bensin-MT 2017 403','honda brio (2017)','1.2 RS Bensin-MT','Bensin','60.000-65.000 Km','Manual',2017,'>1.000 - 1.500 cc',130000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-brio-satya-12-e-bensin-at-2022-rkc-iid-922259179','[OLXmobbi] Honda Brio Satya 1.2 E Bensin-AT 2022 RKC','honda brio satya (2022)','1.2 E Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2022,'>1.000 - 1.500 cc',165000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-brio-satya-12-e-bensin-mt-2020-erw-iid-921031191','[OLXmobbi] Honda Brio Satya 1.2 E Bensin-MT 2020 ERW','honda brio (2020)','1.2 E Bensin-MT','Bensin','25.000-30.000 Km','Manual',2020,'>1.000 - 1.500 cc',145000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-civic-15-e-bensin-at-2018-6vo-iid-919907970','[OLXmobbi] Honda Civic 1.5 E Bensin-AT 2018 6VO','honda civic (2018)','1.5 E Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2018,'>1.000 - 1.500 cc',304000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-15-turbo-prestige-bensin-at-2021-ujw-iid-920416677','[OLXmobbi] Honda CR-V 1.5 Turbo Prestige Bensin-AT 2021 UJW','honda cr-v (2021)','1.5 Turbo Prestige Bensin-AT','Bensin','45.000-50.000 Km','Automatic',2021,'>1.000 - 1.500 cc',451000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-20-4x2-bensin-mt-2015-413-iid-920519298','[OLXmobbi] Honda CR-V 2.0 4X2 Bensin-MT 2015 413','honda cr-v (2015)','2.0 4X2 Bensin-MT','Bensin','40.000-45.000 Km','Manual',2015,'>1.500 - 2.000 cc',207000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-20-bensin-at-2018-sjy-iid-919908297','[OLXmobbi] Honda CR-V 2.0 Bensin-AT 2018 SJY','honda cr-v (2018)','2.0 Bensin-AT','Bensin','45.000-50.000 Km','Automatic',2018,'>1.500 - 2.000 cc',278000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-20-bensin-at-2020-wjg-iid-922871096','[OLXmobbi] Honda CR-V 2.0 Bensin-AT 2020 WJG','honda cr-v (2020)','2.0 Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2020,'>1.500 - 2.000 cc',370000000,'Pondok Aren','Tangerang Selatan Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-cr-v-24-rm3-bensin-at-2015-997-iid-918960468','[OLXmobbi] Honda CR-V 2.4 RM3 Bensin-AT 2015 997','honda cr-v (2015)','2.4 RM3 Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2015,'>2.000 - 3.000 cc',159000000,'Serpong','Tangerang Selatan Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-hr-v-15-e-bensin-at-2016-298-iid-921552201','[OLXmobbi] Honda HR-V 1.5 E Bensin-AT 2016 298','honda hr-v (2016)','1.5 E Bensin-AT','Bensin','60.000-65.000 Km','Automatic',2016,'>1.000 - 1.500 cc',195000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-hr-v-15-s-bensin-mt-2017-899-iid-921150320','[OLXmobbi] Honda HR-V 1.5 S Bensin-MT 2017 899','honda hr-v (2017)','1.5 S Bensin-MT','Bensin','135.000-140.000 Km','Manual',2017,'>1.000 - 1.500 cc',178000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-jazz-15-rs-bensin-at-2018-wzi-iid-922803799','[OLXmobbi] Honda Jazz 1.5 RS Bensin-AT 2018 WZI','honda jazz (2018)','1.5 RS Bensin-AT','Bensin','95.000-100.000 Km','Automatic',2018,'>1.000 - 1.500 cc',206000000,'Tebet','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-mobilio-15-rs-bensin-at-2014-imk-iid-922934466','[OLXmobbi] Honda Mobilio 1.5 RS Bensin-AT 2014 IMK','honda mobilio (2014)','1.5 RS Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2014,'>1.000 - 1.500 cc',132000000,'Tebet','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-mobilio-15-rs-bensin-at-2017-1001-iid-919246833','[OLXmobbi] Honda Mobilio 1.5 RS Bensin-AT 2017 1001','honda mobilio (2017)','1.5 RS Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2017,'>1.000 - 1.500 cc',151000000,'Tangerang','Tangerang Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-honda-mobilio-15-s-bensin-mt-2017-jvc-iid-920369276','[OLXmobbi] Honda Mobilio 1.5 S Bensin-MT 2017 JVC','honda mobilio (2017)','1.5 S Bensin-MT','Bensin','40.000-45.000 Km','Manual',2017,'>1.000 - 1.500 cc',139000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-hyundai-creta-15-prime-ivt-two-tone-bensin-at-2023-uiq-iid-919946728','[OLXmobbi] Hyundai Creta 1.5 Prime IVT Two tone Bensin-AT 2023 UIQ','hyundai creta (2023)','1.5 Prime IVT Two tone Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2023,'>1.000 - 1.500 cc',325000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-hyundai-creta-15-trend-ivt-bensin-at-2022-kzx-iid-921403707','[OLXmobbi] Hyundai Creta 1.5 Trend IVT Bensin-AT 2022 KZX','hyundai creta (2022)','1.5 Trend IVT Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2022,'>1.000 - 1.500 cc',253000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-mazda-2-15-gt-bensin-at-2017-599-iid-921313252','[OLXmobbi] Mazda 2 1.5 GT Bensin-AT 2017 599','mazda 2 (2017)','1.5 GT Bensin-AT','Bensin','100.000-105.000 Km','Automatic',2017,'>1.000 - 1.500 cc',178000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-mazda-cx-5-25-touring-bensin-at-2015-pvk-iid-922257033','[OLXmobbi] Mazda CX-5 2.5 Touring Bensin-AT 2015 PVK','mazda cx-5 (2015)','2.5 Touring Bensin-AT','Bensin','115.000-120.000 Km','Automatic',2015,'>2.000 - 3.000 cc',218000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-mitsubishi-outlander-sport-20-gls-bensin-at-2016-862-iid-921501289','[OLXmobbi] Mitsubishi Outlander Sport 2.0 GLS Bensin-AT 2016 862','mitsubishi outlander sport (2016)','2.0 GLS Bensin-AT','Bensin','60.000-65.000 Km','Automatic',2016,'>1.500 - 2.000 cc',175000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-mitsubishi-outlander-sport-20-glx-bensin-mt-2017-954-iid-922352903','[OLXmobbi] Mitsubishi Outlander Sport 2.0 GLX Bensin-MT 2017 954','mitsubishi outlander sport (2017)','2.0 GLX Bensin-MT','Bensin','90.000-95.000 Km','Manual',2017,'>1.500 - 2.000 cc',167000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-mitsubishi-pajero-sport-25-dakar-solar-at-2014-jba-iid-919945654','[OLXmobbi] Mitsubishi Pajero Sport 2.5 Dakar Solar-AT 2014 JBA','mitsubishi pajero sport (2014)','2.5 Dakar Solar-AT','Diesel','145.000-150.000 Km','Automatic',2014,'>2.000 - 3.000 cc',274000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-nissan-evalia-15-st-bensin-mt-2012-uoz-iid-919959023','[OLXmobbi] Nissan Evalia 1.5 St Bensin-MT 2012 UOZ','nissan evalia (2012)','1.5 St Bensin-MT','Bensin','115.000-120.000 Km','Manual',2012,'>1.000 - 1.500 cc',77000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-nissan-grand-livina-15-sv-bensin-at-2014-2-b1-iid-922353031','[OLXmobbi] Nissan Grand livina 1.5 SV Bensin-AT 2014 2-B1','nissan grand livina (2014)','1.5 SV Bensin-AT','Bensin','260.000-265.000 Km','Automatic',2014,'>1.000 - 1.500 cc',83000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-nissan-juke-15-rx-bensin-at-2011-179-iid-921604077','[OLXmobbi] Nissan Juke 1.5 RX Bensin-AT 2011 179','nissan juke (2011)','1.5 RX Bensin-AT','Bensin','135.000-140.000 Km','Automatic',2011,'>1.000 - 1.500 cc',101000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-nissan-serena-20-highway-star-bensin-at-2019-3dz-iid-921494115','[OLXmobbi] Nissan Serena 2.0 Highway Star Bensin-AT 2019 3DZ','nissan serena (2019)','2.0 Highway Star Bensin-AT','Bensin','80.000-85.000 Km','Automatic',2019,'>1.500 - 2.000 cc',269000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-nissan-x-trail-25-bensin-at-2017-064-iid-920807742','[OLXmobbi] Nissan X-Trail 2.5 Bensin-AT 2017 064','nissan x-trail (2017)','2.5 Bensin-AT','Bensin','45.000-50.000 Km','Automatic',2017,'>2.000 - 3.000 cc',207000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-14-bensin-at-2019-781-iid-918959400','[OLXmobbi] Suzuki Baleno 1.4 Bensin-AT 2019 781','suzuki baleno (2019)','1.4 Bensin-AT','Bensin','85.000-90.000 Km','Automatic',2019,'>1.000 - 1.500 cc',165000000,'Serpong','Tangerang Selatan Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-15-bensin-at-2022-rkt-iid-920417813','[OLXmobbi] Suzuki Baleno 1.5 Bensin-AT 2022 RKT','suzuki baleno (2022)','1.5 Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2022,'>1.000 - 1.500 cc',222000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-15-bensin-at-2022-rkt-iid-921395115','[OLXmobbi] Suzuki Baleno 1.5 Bensin-AT 2022 RKT','suzuki baleno (2022)','1.5 Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2022,'>1.000 - 1.500 cc',221000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-15-bensin-at-2022-uii-iid-922256744','[OLXmobbi] Suzuki Baleno 1.5 Bensin-AT 2022 UII','suzuki baleno (2022)','1.5 Bensin-AT','Bensin','0-5.000 Km','Automatic',2022,'>1.000 - 1.500 cc',239000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-baleno-15-bensin-at-2023-816-iid-921726785','[OLXmobbi] Suzuki Baleno 1.5 Bensin-AT 2023 816','suzuki baleno (2023)','1.5 Bensin-AT','Bensin','0-5.000 Km','Automatic',2023,'>1.000 - 1.500 cc',241000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-ertiga-15-gx-bensin-mt-2019-991-iid-921590569','[OLXmobbi] Suzuki Ertiga 1.5 GX Bensin-MT 2019 991','suzuki ertiga (2019)','1.5 GX Bensin-MT','Bensin','45.000-50.000 Km','Manual',2019,'>1.000 - 1.500 cc',172000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-ertiga-15-gx-hybrid-at-2022-427-iid-920807504','[OLXmobbi] Suzuki Ertiga 1.5 GX Hybrid-AT 2022 427','suzuki ertiga (2022)','1.5 GX Hybrid-AT','Bensin','40.000-45.000 Km','Automatic',2022,'>1.000 - 1.500 cc',217000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-ignis-12-gx-ags-bensin-at-2019-bmr-iid-921679714','[OLXmobbi] Suzuki Ignis 1.2 GX AGS Bensin-AT 2019 BMR','suzuki ignis (2019)','1.2 GX AGS Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2019,'>1.000 - 1.500 cc',130000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-ignis-12-gx-bensin-at-2018-345-iid-921150684','[OLXmobbi] Suzuki Ignis 1.2 GX Bensin-AT 2018 345','suzuki ignis (2018)','1.2 GX Bensin-AT','Bensin','50.000-55.000 Km','Automatic',2018,'>1.000 - 1.500 cc',132000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-sx4-15-s-cross-bensin-at-2017-pin-iid-922269696','[OLXmobbi] Suzuki SX4 1.5 S-Cross Bensin-AT 2017 PIN','suzuki sx4 (2017)','1.5 S-Cross Bensin-AT','Bensin','75.000-80.000 Km','Automatic',2017,'>1.000 - 1.500 cc',135000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-sx4-15-s-cross-bensin-at-2021-711-iid-920940275','[OLXmobbi] Suzuki SX4 1.5 S-Cross Bensin-AT 2021 711','suzuki sx4 (2021)','1.5 S-Cross Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2021,'>1.000 - 1.500 cc',225000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-suzuki-xl7-15-beta-bensin-mt-2020-tre-iid-922257931','[OLXmobbi] Suzuki XL7 1.5 Beta Bensin-MT 2020 TRE','suzuki xl7 (2020)','1.5 Beta Bensin-MT','Bensin','25.000-30.000 Km','Manual',2020,'>1.000 - 1.500 cc',183000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-agya-10-g-bensin-mt-2016-789-iid-918959534','[OLXmobbi] Toyota Agya 1.0 G Bensin-MT 2016 789','toyota agya (2016)','1.0 G Bensin-MT','Bensin','60.000-65.000 Km','Manual',2016,'>1.000 - 1.500 cc',87000000,'Serpong','Tangerang Selatan Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-agya-12-g-bensin-at-2021-800-iid-918956874','[OLXmobbi] Toyota Agya 1.2 G Bensin-AT 2021 800','toyota agya (2021)','1.2 G Bensin-AT','Bensin','75.000-80.000 Km','Automatic',2021,'>1.000 - 1.500 cc',125000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-avanza-13-new-g-bensin-mt-2015-142-iid-920742566','[OLXmobbi] Toyota Avanza 1.3 New G Bensin-MT 2015 142','toyota avanza (2015)','1.3 New G Bensin-MT','Bensin','50.000-55.000 Km','Manual',2015,'>1.000 - 1.500 cc',121000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-calya-12-g-bensin-at-2020-423-iid-921731704','[OLXmobbi] Toyota Calya 1.2 G Bensin-AT 2020 423','toyota calya (2020)','1.2 G Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2020,'>1.000 - 1.500 cc',133000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-fortuner-24-4x2-vrz-solar-at-2021-sri-iid-919909405','[OLXmobbi] Toyota Fortuner 2.4 4x2 VRZ Solar-AT 2021 SRI','toyota fortuner (2021)','2.4 4x2 VRZ Solar-AT','Diesel','35.000-40.000 Km','Automatic',2021,'>2.000 - 3.000 cc',459000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-fortuner-28-4x2-vrz-solar-at-2022-141-iid-921448781','[OLXmobbi] Toyota Fortuner 2.8 4x2 VRZ Solar-AT 2022 141','toyota fortuner (2022)','2.8 4x2 VRZ Solar-AT','Diesel','50.000-55.000 Km','Automatic',2022,'>2.000 - 3.000 cc',489000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-fortuner-28-vrz-solar-at-2022-ujz-iid-918930053','[OLXmobbi] Toyota Fortuner 2.8 VRZ Solar-AT 2022 UJZ','toyota fortuner (2022)','2.8 VRZ Solar-AT','Diesel','25.000-30.000 Km','Automatic',2022,'>2.000 - 3.000 cc',476000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-kijang-innova-20-g-bensin-at-2015-cyw-iid-922934691','[OLXmobbi] Toyota Kijang Innova 2.0 G Bensin-AT 2015 CYW','toyota kijang innova (2015)','2.0 G Bensin-AT','Bensin','95.000-100.000 Km','Automatic',2015,'>1.500 - 2.000 cc',170000000,'Tebet','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-kijang-innova-20-g-bensin-at-2020-aaf-iid-921294066','[OLXmobbi] Toyota Kijang Innova 2.0 G Bensin-AT 2020 AAF','toyota kijang innova (2020)','2.0 G Bensin-AT','Bensin','75.000-80.000 Km','Automatic',2020,'>1.500 - 2.000 cc',276000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-kijang-innova-20-v-luxury-bensin-at-2021-407-iid-921596945','[OLXmobbi] Toyota Kijang Innova 2.0 V Luxury Bensin-AT 2021 407','toyota kijang innova (2021)','2.0 V Luxury Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2021,'>1.500 - 2.000 cc',356000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-raize-10-gr-sport-tss-two-tone-bensin-at-2021-982-iid-921552354','[OLXmobbi] Toyota Raize 1.0 GR Sport TSS Two Tone Bensin-AT 2021 982','toyota raize (2021)','1.0 GR Sport TSS Two Tone Bensin-AT','Bensin','25.000-30.000 Km','Automatic',2021,'<1.000 cc',234000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-raize-10-t-gr-sport-one-tone-bensin-at-2021-998-iid-918960583','[OLXmobbi] Toyota Raize 1.0 T GR SPORT One Tone Bensin-AT 2021 998','toyota raize (2021)','1.0 T GR SPORT One Tone Bensin-AT','Bensin','30.000-35.000 Km','Manual',2021,'>1.000 - 1.500 cc',201000000,'Serpong','Tangerang Selatan Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-raize-12-g-bensin-at-2023-pzk-iid-919329784','[OLXmobbi] Toyota Raize 1.2 G Bensin-AT 2023 PZK','toyota raize (2023)','1.2 G Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2023,'>1.000 - 1.500 cc',220000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-g-bensin-at-2017-779-iid-918959269','[OLXmobbi] Toyota Rush 1.5 G Bensin-AT 2017 779','toyota rush (2017)','1.5 G Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2017,'>1.500 - 2.000 cc',141000000,'Serpong','Tangerang Selatan Kota','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-7-bensin-mt-2019-567-iid-921716351','[OLXmobbi] Toyota Rush 1.5 TRD Sportivo 7 Bensin-MT 2019 567','toyota rush (2019)','1.5 TRD Sportivo 7 Bensin-MT','Bensin','45.000-50.000 Km','Manual',2019,'>1.000 - 1.500 cc',211000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-bensin-at-2021-poa-iid-921294282','[OLXmobbi] Toyota Rush 1.5 TRD Sportivo Bensin-AT 2021 POA','toyota rush (2021)','1.5 TRD Sportivo Bensin-AT','Bensin','25.000-30.000 Km','Automatic',2021,'>1.000 - 1.500 cc',225000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-bensin-mt-2018-byj-iid-922272721','[OLXmobbi] Toyota Rush 1.5 TRD Sportivo Bensin-MT 2018 BYJ','toyota rush (2018)','1.5 TRD Sportivo Bensin-MT','Bensin','65.000-70.000 Km','Manual',2018,'>1.000 - 1.500 cc',190000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-bensin-mt-2019-675-iid-921491889','[OLXmobbi] Toyota Rush 1.5 TRD Sportivo Bensin-MT 2019 675','toyota rush (2019)','1.5 TRD Sportivo Bensin-MT','Bensin','65.000-70.000 Km','Manual',2019,'>1.000 - 1.500 cc',211000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-rush-15-trd-sportivo-bensin-mt-2019-err-iid-920561653','[OLXmobbi] Toyota Rush 1.5 TRD Sportivo Bensin-MT 2019 ERR','toyota rush (2019)','1.5 TRD Sportivo Bensin-MT','Bensin','15.000-20.000 Km','Manual',2019,'>1.000 - 1.500 cc',205000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-sienta-15-v-bensin-at-2016-455-iid-921367574','[OLXmobbi] Toyota Sienta 1.5 V Bensin-AT 2016 455','toyota sienta (2016)','1.5 V Bensin-AT','Bensin','160.000-165.000 Km','Automatic',2016,'>1.000 - 1.500 cc',153000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-vios-15-g-bensin-at-2016-923-iid-921149959','[OLXmobbi] Toyota Vios 1.5 G Bensin-AT 2016 923','toyota vios (2016)','1.5 G Bensin-AT','Bensin','105.000-110.000 Km','Automatic',2016,'>1.000 - 1.500 cc',142000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-voxy-20-bensin-at-2017-877-iid-921080792','[OLXmobbi] Toyota Voxy 2.0 Bensin-AT 2017 877','toyota voxy (2017)','2.0 Bensin-AT','Bensin','85.000-90.000 Km','Automatic',2017,'>1.500 - 2.000 cc',339000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-voxy-20-bensin-at-2018-093-iid-922401874','[OLXmobbi] Toyota Voxy 2.0 Bensin-AT 2018 093','toyota voxy (2018)','2.0 Bensin-AT','Bensin','60.000-65.000 Km','Automatic',2018,'>1.500 - 2.000 cc',356000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-yaris-15-trd-sportivo-bensin-at-2015-is9-iid-922974846','[OLXmobbi] Toyota Yaris 1.5 TRD Sportivo Bensin-AT 2015 IS9','toyota yaris (2015)','1.5 TRD Sportivo Bensin-AT','Bensin','120.000-125.000 Km','Automatic',2015,'>1.000 - 1.500 cc',149000000,'Tebet','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-toyota-yaris-15-trd-sportivo-bensin-mt-2017-wox-iid-922271939','[OLXmobbi] Toyota Yaris 1.5 TRD Sportivo Bensin-MT 2017 WOX','toyota yaris (2017)','1.5 TRD Sportivo Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2017,'>1.000 - 1.500 cc',173000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-wuling-almaz-15-exclusive-5-seater-bensin-at-2019-nzi-iid-920562125','[OLXmobbi] Wuling Almaz 1.5 Exclusive 5-Seater Bensin-AT 2019 NZI','wuling almaz (2019)','1.5 Exclusive 5-Seater Bensin-AT','Bensin','70.000-75.000 Km','Automatic',2019,'>1.000 - 1.500 cc',181000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-wuling-almaz-15-smart-enjoy-7-seater-bensin-at-2021-jfg-iid-921393571','[OLXmobbi] Wuling Almaz 1.5 Smart Enjoy 7-Seater Bensin-AT 2021 JFG','wuling almaz (2021)','1.5 Smart Enjoy 7-Seater Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2021,'>1.000 - 1.500 cc',182000000,'Jagakarsa','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/olxmobbi-wuling-confero-s-15-l-lux-plus-bensin-mt-2017-smr-iid-922257247','[OLXmobbi] Wuling Confero S 1.5 L Lux Plus Bensin-MT 2017 SMR','wuling confero s (2017)','1.5 L Lux Plus Bensin-MT','Bensin','50.000-55.000 Km','Manual',2017,'>1.000 - 1.500 cc',100000000,'Cilandak','Jakarta Selatan','OLXmobbi - Dedy'),
('https://www.olx.co.id/item/outlander-20-at-gls-2013-iid-922831719','outlander 2.0 AT gls 2013','mitsubishi outlander (2013)','2.0 Bensin-AT','Bensin','145.000-150.000 Km','Automatic',2013,'>1.500 - 2.000 cc',118000000,'Cilandak','Jakarta Selatan','alonglim'),
('https://www.olx.co.id/item/pajero-24-dakar-ultimate-diesel-at-2018-mitsubishi-sport-solar-matic-iid-923820572','Pajero 2.4 Dakar Ultimate Diesel AT 2018 Mitsubishi Sport Solar Matic','mitsubishi pajero sport (2018)','2.4 Dakar 4x2 Ultimate Solar-AT','Diesel','70000 Km','Otomatis',2018,'>2.000 - 3.000 cc',390000000,'Cilandak','Jakarta Selatan','Har WA'),
('https://www.olx.co.id/item/pajero-d-at-23-dp-50-iid-923865511','PAJERO  D AT 23 DP 50.','mitsubishi pajero sport (2023)','2.4 Dakar 4x2 Solar-AT','Diesel','15.000-20.000 Km','Automatic',2023,'>2.000 - 3.000 cc',545000000,'Pesanggrahan','Jakarta Selatan','MOBIL IMPIAN BEKASI'),
('https://www.olx.co.id/item/pajero-sport-dakar-2020-nik-2019-non-ultimate-gr-vrz-trd-2021-fortuner-iid-923863349','Pajero Sport Dakar 2020 NIK 2019 non ultimate GR VRZ TRD 2021 fortuner','mitsubishi pajero sport (2019)','2.4 Dakar Solar-AT','Diesel','45.000-50.000 Km','Automatic',2019,'>2.000 - 3.000 cc',384000000,'Kebayoran Lama','Jakarta Selatan','IMEL AW Auto Cars'),
('https://www.olx.co.id/item/palisade-signature-fwd-jual-harga-second-rasa-baru-iid-921345590','PALISADE SIGNATURE FWD! JUAL HARGA SECOND RASA BARU!','hyundai palisade (2022)','2.2 Signature Solar-AT','Diesel','20.000-25.000 Km','Automatic',2022,'>2.000 - 3.000 cc',745000000,'Cilandak','Jakarta Selatan','ARIEF S'),
('https://www.olx.co.id/item/pilot-seat-isp-on-mercedes-benz-v250-avg-2022-2021-alphard-vellfire-iid-921163452','Pilot Seat ISP On Mercedes Benz V250 AVG  2022 / 2021 Alphard Vellfire','mercedes-benz v250 (2021)','2.0 Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2021,'>2.000 - 3.000 cc',1291000000,'Kebayoran Baru','Jakarta Selatan','Calvin'),
('https://www.olx.co.id/item/porsche-718-boxster-2016-iid-923191346','Porsche 718 Boxster 2016','porsche boxster (2016)','2.9 Bensin-AT','Bensin','10000 Km','Otomatis',2016,'>2.000 - 3.000 cc',1825000000,'Kebayoran Lama','Jakarta Selatan','tyojakarta1679'),
('https://www.olx.co.id/item/range-rover-evouge-dlux-matic-bensin-2012-iid-923862825','Range Rover Evouge D\'LUX matic bensin 2012','land rover evoque (2012)','2.0 Bensin-AT','Bensin','110.000-115.000 Km','Automatic',2012,'>1.500 - 2.000 cc',330000000,'Kebayoran Baru','Jakarta Selatan','BensS Auto Garage'),
('https://www.olx.co.id/item/range-rover-voque-iid-920986961','Range Rover Voque','land rover range rover (2016)','3.0 Vogue Autobiography LWB Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2016,'>2.000 - 3.000 cc',1800000000,'Kebayoran Baru','Jakarta Selatan','GenMud'),
('https://www.olx.co.id/item/rare-c63-amg-2008-w204-c-63-iid-923862220','Rare C63 AMG 2008 W204 C 63','mercedes-benz c63 amg (2008)','6.2 Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2008,'',1250000000,'','','KS Motorsport'),
('https://www.olx.co.id/item/rush-15-s-trd-sportivo-at-2020-tdp20jt-toyota-rush-matic-automatic-iid-923852803','Rush 1.5 S TRD Sportivo AT 2020 TDP20jt Toyota Rush Matic Automatic','toyota rush (2020)','1.5 TRD Sportivo 7 Bensin-AT','Bensin','70000 Km','Otomatis',2020,'>1.000 - 1.500 cc',205000000,'Pancoran','Jakarta Selatan','Har WA'),
('https://www.olx.co.id/item/tdp-1-honda-mobilio-15-rs-at-2014-maroon-iid-923869218','TDP 1 Honda Mobilio 1.5 RS AT 2014 Maroon','honda mobilio (2014)','1.5 RS Bensin-AT','Bensin','50.000-55.000 Km','Automatic',2014,'>1.000 - 1.500 cc',129000000,'Mampang Prapatan','Jakarta Selatan','Nadhira Auto Car'),
('https://www.olx.co.id/item/tdp-1-juta-honda-mobilio-15-e-at-2018-abu-abu-iid-923869492','TDP 1 Juta Honda Mobilio 1.5 E AT 2018 Abu-abu','honda mobilio (2018)','1.5 E Bensin-AT','Bensin','120.000-125.000 Km','Automatic',2018,'>1.000 - 1.500 cc',141000000,'Pasar Minggu','Jakarta Selatan','Nadhira Auto Car'),
('https://www.olx.co.id/item/tdp-1-juta-suzuki-ertiga-hybrid-gx-sport-at-2022-coklat-iid-923868953','TDP 1 Juta Suzuki Ertiga Hybrid GX Sport AT 2022 Coklat','suzuki ertiga (2022)','1.5 GX Hybrid-AT','Hybrid','90.000-95.000 Km','Automatic',2022,'>1.000 - 1.500 cc',189000000,'Kebayoran Lama','Jakarta Selatan','Nadhira Auto Car'),
('https://www.olx.co.id/item/tdp-10-juta-toyota-mark-x-2012-iid-923077822','[ TDP 10 juta ] Toyota Mark X 2012','toyota mark x (2012)','2.5 250G Bensin-AT','Bensin','80.000-85.000 Km','Automatic',2012,'>2.000 - 3.000 cc',207000000,'Kebayoran Baru','Jakarta Selatan','Garnet Auto'),
('https://www.olx.co.id/item/tdp-15jt-km-55rb-honda-hrv-prestige-18-2018-at-istimewa-20172019-iid-923803085','TDP 15JT KM 55RB ! HONDA HRV PRESTIGE 1.8 2018 AT ISTIMEWA 2017/2019','honda hr-v (2018)','1.8 Prestige Bensin-AT','Bensin','50.000-55.000 Km','Automatic',2018,'>1.500 - 2.000 cc',245000000,'Cilandak','Jakarta Selatan','ZUL NET MOBIL99'),
('https://www.olx.co.id/item/tdp-8jt-new-mazda-cx-5-elite-facelift-2022-cx5-cx30-cx9-crv-pajero-x1-iid-923864506','TDP 8JT! New Mazda CX-5 Elite Facelift 2022 cx5 cx30 cx9 crv pajero x1','mazda cx-5 (2022)','2.5 Elite Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2022,'>2.000 - 3.000 cc',435000000,'Kebayoran Baru','Jakarta Selatan','Andrew Autobahn'),
('https://www.olx.co.id/item/tdp-90jt-nego-alphard-g-atpm-2020-nik2019-putih-istimewa-seger-iid-922875774','TDP 90JT NEGO! ALPHARD G ATPM 2020 NIK\'2019 PUTIH ISTIMEWA SEGER!!','toyota alphard (2019)','2.5 G Bensin-AT','Bensin','55.000-60.000 Km','Automatic',2019,'>2.000 - 3.000 cc',825000000,'Pasar Minggu','Jakarta Selatan','Wawan Kings Auto 2'),
('https://www.olx.co.id/item/toyota-agya-type-g-mt-iid-923864645','Toyota Agya type G MT','toyota agya (2015)','1.0 G Bensin-MT','Bensin','35.000-40.000 Km','Manual',2015,'>1.000 - 1.500 cc',85000000,'Kebayoran Lama','Jakarta Selatan','Arif'),
('https://www.olx.co.id/item/toyota-alphard-25-g-at-2017-hitam-iid-923505529','Toyota Alphard 2.5 G AT 2017 Hitam','toyota alphard (2017)','','Bensin','55.000-60.000 Km','Automatic',2017,'>2.000 - 3.000 cc',710000000,'Mampang Prapatan','Jakarta Selatan','CARRO Indonesia'),
('https://www.olx.co.id/item/toyota-alphard-25-g-atpm-facelift-2018-iid-923865995','Toyota Alphard 2.5 G ATPM Facelift 2018','toyota alphard (2018)','2.5 G Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2018,'>2.000 - 3.000 cc',759000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/toyota-alphard-25-g-tss-atpm-2023-iid-923412197','Toyota Alphard 2.5 G TSS ATPM 2023','toyota alphard (2023)','2.5 G Bensin-AT','Bensin','5.000-10.000 Km','Automatic',2023,'>2.000 - 3.000 cc',1195000000,'Kebayoran Baru','Jakarta Selatan','Veby LB Auto'),
('https://www.olx.co.id/item/toyota-alphard-25g-at-2020-km-rendah-kondisi-istimewa-iid-923866337','Toyota Alphard 2.5G AT 2020 - KM Rendah, Kondisi Istimewa!','toyota alphard (2020)','2.5 G Bensin-AT','Bensin','25.000-30.000 Km','Automatic',2020,'>2.000 - 3.000 cc',1099000000,'Kebayoran Baru','Jakarta Selatan','Michael'),
('https://www.olx.co.id/item/toyota-alphard-g-atpm-2016-iid-923695329','Toyota Alphard G ATPM 2016','toyota alphard (2016)','2.5 G Bensin-AT','Bensin','90.000-95.000 Km','Automatic',2016,'>2.000 - 3.000 cc',638000000,'Pasar Minggu','Jakarta Selatan','Ridwan Tedja'),
('https://www.olx.co.id/item/toyota-altis-20-v-at-tahun-2010-iid-923290172','Toyota Altis 2.0 V AT Tahun 2010','toyota corolla altis (2010)','2.0 V Bensin-AT','Bensin','120000 Km','Otomatis',2010,'>1.500 - 2.000 cc',123250000,'Kebayoran Baru','Jakarta Selatan','Fatir'),
('https://www.olx.co.id/item/toyota-avanza-t13-g-mt-grnd-2016-dp-17915000-oto029445-iid-923237710','TOYOTA AVANZA T:1.3 G M/T GRND 2016 DP. 17.915.000 [OTO029445]','toyota avanza (2016)','1.3 G Bensin-MT','Bensin','150.000-155.000 Km','Manual',2016,'>1.000 - 1.500 cc',128000000,'Cilandak','Jakarta Selatan','Setir Kanan'),
('https://www.olx.co.id/item/toyota-calya-12-g-at-2023-oto029849-iid-923859474','TOYOTA CALYA 1.2 G A/T 2023 [OTO029849]','toyota calya (2023)','1.2 G Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2023,'>1.000 - 1.500 cc',145000000,'Cilandak','Jakarta Selatan','Setir Kanan'),
('https://www.olx.co.id/item/toyota-calya-12-g-at-2023-oto029849-iid-923866696','TOYOTA CALYA 1.2 G A/T 2023 [OTO029849]','toyota calya (2023)','1.2 G Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2023,'>1.000 - 1.500 cc',145000000,'Cilandak','Jakarta Selatan','Setir Kanan'),
('https://www.olx.co.id/item/toyota-calya-12-g-mt-2018-2019-at-iid-923056321','Toyota Calya 1.2 G MT 2018 / 2019 AT','toyota calya (2018)','1.2 G Bensin-MT','Bensin','65.000-70.000 Km','Manual',2018,'>1.000 - 1.500 cc',103000000,'Cilandak','Jakarta Selatan','Kent'),
('https://www.olx.co.id/item/toyota-camry-24-v-at-iid-923775577','Toyota Camry 2.4 V AT','toyota camry (2017)','2.4 V Bensin-AT','Bensin','20.000-25.000 Km','Automatic',2017,'>2.000 - 3.000 cc',284000000,'Cilandak','Jakarta Selatan','Oman'),
('https://www.olx.co.id/item/toyota-camry-25-hybrid-at-2020-hitam-iid-923680214','Toyota Camry 2.5 Hybrid AT 2020 Hitam','toyota camry (2020)','2.5 Hybrid-AT','Bensin','35.000-40.000 Km','Automatic',2020,'>2.000 - 3.000 cc',493000000,'Kebayoran Baru','Jakarta Selatan','PT.KAWAN MOBIL NUSANTARA'),
('https://www.olx.co.id/item/toyota-camry-25-v-at-hitam-2013-iid-923854597','Toyota Camry 2.5 V AT Hitam 2013','toyota camry (2013)','2.5 V Bensin-AT','Bensin','105.000-110.000 Km','Automatic',2013,'>2.000 - 3.000 cc',185000000,'Cilandak','Jakarta Selatan','Sofieee26'),
('https://www.olx.co.id/item/toyota-camry-35q-iid-923737822','Toyota Camry 3.5Q','toyota camry (2007)','3.5 Bensin-AT','Bensin','115.000-120.000 Km','Automatic',2007,'>3.000 cc',129000000,'Kebayoran Lama','Jakarta Selatan','gammarirz'),
('https://www.olx.co.id/item/toyota-camry-v-25-at-2015-iid-923859379','Toyota Camry V 2.5 AT 2015','toyota camry (2015)','2.5 V Bensin-AT','Bensin','55.000-60.000 Km','Automatic',2015,'>2.000 - 3.000 cc',235000000,'Setia Budi','Jakarta Selatan','Andhika'),
('https://www.olx.co.id/item/toyota-corolla-cross-hybrid-2020-at-18l-km-42ribu-pajak-panjang-iid-923614518','Toyota Corolla Cross Hybrid 2020 AT 1.8L, Km 42Ribu, Pajak Panjang','toyota corolla (2020)','1.8 Cross Hybrid Bensin-AT','Hybrid','35.000-40.000 Km','Automatic',2020,'>1.500 - 2.000 cc',350000000,'Mampang Prapatan','Jakarta Selatan','Felix FM Motor Mangga 2 Square'),
('https://www.olx.co.id/item/toyota-fortuner-2022-iid-922753347','Toyota Fortuner (2022)','toyota fortuner (2022)','2.4 VRZ GR Sport-AT','Bensin','30.000-35.000 Km','Automatic',2022,'>1.500 - 2.000 cc',510000000,'Kebayoran Baru','Jakarta Selatan','Dwi Fahrani'),
('https://www.olx.co.id/item/toyota-fortuner-24-vrz-trd-2021-iid-923866280','Toyota Fortuner 2.4 VRZ TRD 2021','toyota fortuner (2021)','2.4 4x2 VRZ Solar-AT','Diesel','40.000-45.000 Km','Automatic',2021,'>2.000 - 3.000 cc',425000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/toyota-fortuner-vrz-4x-2-jual-cepat-iid-920311161','Toyota Fortuner VRZ 4x 2 JUAL CEPAT','toyota fortuner (2018)','2.4 4x2 VRZ Solar-AT','Diesel','70000 Km','Otomatis',2018,'>2.000 - 3.000 cc',378000000,'Cilandak','Jakarta Selatan','Empire Auto.2 (Alfian)'),
('https://www.olx.co.id/item/toyota-fortuner-vrz-trd-2019-iid-923860028','Toyota Fortuner VRZ TRD 2019','toyota fortuner (2019)','2.4 VRZ TRD Solar-AT','Diesel','90000 Km','Otomatis',2019,'>2.000 - 3.000 cc',410000000,'Pancoran','Jakarta Selatan','Dwiky'),
('https://www.olx.co.id/item/toyota-fortuner-vrz-trd-2021-non-gr-2022-mdl-2023-pajero-dakar-exceed-iid-923863240','Toyota Fortuner VRZ TRD 2021 non GR 2022 mdl 2023 pajero dakar exceed','toyota fortuner (2021)','2.4 VRZ TRD Solar-AT','Diesel','25.000-30.000 Km','Automatic',2021,'>2.000 - 3.000 cc',427000000,'Kebayoran Lama','Jakarta Selatan','IMEL AW Auto Cars'),
('https://www.olx.co.id/item/toyota-innova-g-luxury-20-at-bensin-2019-dp-murah-iid-923862565','toyota innova g luxury 2.0 AT bensin 2019 dp murah','toyota kijang innova (2019)','2.0 G Luxury Bensin-AT','Bensin','55.000-60.000 Km','Automatic',2019,'>1.500 - 2.000 cc',250000000,'Kebayoran Baru','Jakarta Selatan','Daffa'),
('https://www.olx.co.id/item/toyota-kijang-innova-reborn-20-q-at-bensin-silver-2016-antikkk-iid-923860067','Toyota Kijang Innova Reborn 2.0 Q AT Bensin Silver 2016 Antikkk','toyota kijang innova (2016)','2.0 Q Bensin-AT','Bensin','55.000-60.000 Km','Automatic',2016,'>1.500 - 2.000 cc',265000000,'Pancoran','Jakarta Selatan','Subur'),
('https://www.olx.co.id/item/toyota-kijang-super-iid-923854984','Toyota kijang super','toyota kijang (2002)','1.5 G Bensin-MT','Bensin','45.000-50.000 Km','Manual',2002,'>1.500 - 2.000 cc',47500000,'Kebayoran Lama','Jakarta Selatan','Shinta'),
('https://www.olx.co.id/item/toyota-landcruiser-gr-s-sport-2024-brand-new-hitam-dalam-merah-iid-920407753','Toyota Landcruiser GR S Sport 2024 Brand New Hitam dalam Merah','toyota land cruiser (2024)','4.5 GR-S Solar-AT','Diesel','0-5.000 Km','Automatic',2024,'>2.000 - 3.000 cc',2695000000,'Kebayoran Lama','Jakarta Selatan','Miless'),
('https://www.olx.co.id/item/toyota-raize-10-gr-sport-2022-iid-923866548','Toyota Raize 1.0 GR Sport 2022','toyota raize (2022)','1.0 GR Sport One Tone Bensin-AT','Bensin','25.000-30.000 Km','Automatic',2022,'>1.000 - 1.500 cc',195000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/toyota-rush-s-at-iid-923863881','Toyota rush s at','toyota rush (2021)','1.5 S Bensin-AT','Bensin','25.000-30.000 Km','Automatic',2021,'>1.500 - 2.000 cc',235000000,'Kebayoran Lama','Jakarta Selatan','Yeni WTC Mangga Dua'),
('https://www.olx.co.id/item/toyota-sienta-15-v-cvt-2017-iid-923853732','Toyota Sienta 1.5 V CVT 2017','toyota sienta (2017)','1.5 V Bensin-AT','Bensin','80.000-85.000 Km','Automatic',2017,'>1.000 - 1.500 cc',165000000,'Pancoran','Jakarta Selatan','Muhamad ikhsan'),
('https://www.olx.co.id/item/toyota-vellfire-24-zg-aless-at-2013-iid-922933542','Toyota Vellfire 2.4 ZG Aless AT 2013','toyota vellfire (2013)','2.4 Z Bensin-AT','Bensin','115.000-120.000 Km','Automatic',2013,'>2.000 - 3.000 cc',298000000,'Cilandak','Jakarta Selatan','Kent'),
('https://www.olx.co.id/item/toyota-voxy-20-at-2018-hitam-fullset-iid-923858954','Toyota Voxy 2.0 AT 2018 Hitam Fullset','toyota voxy (2018)','2.0 Bensin-AT','Bensin','105.000-110.000 Km','Automatic',2018,'>1.500 - 2.000 cc',315000000,'Kebayoran Baru','Jakarta Selatan','faress88Garage'),
('https://www.olx.co.id/item/vip-dealer-2018-bmw-x3-xdrive20i-luxury-panoramic-tdp-18jt-iid-922923737','[VIP Dealer] 2018 BMW X3 xDrive20i Luxury Panoramic TDP 18jt','bmw x3 (2018)','2.0 xDrive20i Luxury Bensin-AT','Bensin','35.000-40.000 Km','Automatic',2018,'>1.500 - 2.000 cc',680000000,'Cilandak','Jakarta Selatan','rainie'),
('https://www.olx.co.id/item/vip-dealer-bmw-x3-msport-2022-x-3-m-sport-2023-iid-923648486','[VIP Dealer] BMW X3 MSport 2022 X-3 M-Sport 2023','bmw x3 (2022)','2.0 xDrive30i M Sport Bensin-AT','Bensin','10.000-15.000 Km','Automatic',2022,'>1.500 - 2.000 cc',867000000,'Kebayoran Lama','Jakarta Selatan','IMEL AW Auto Cars'),
('https://www.olx.co.id/item/vip-dealer-landcruiser-km-3000-nik-2023-iid-923189150','[VIP Dealer] Landcruiser KM 3000 nik 2023','toyota land cruiser (2023)','3.0 Solar-AT','Diesel','0-5.000 Km','Automatic',2023,'>3.000 cc',2450000000,'Cilandak','Jakarta Selatan','Landcar Goy'),
('https://www.olx.co.id/item/vip-dealer-lexus-lm-350-at-7-seat-35-tahun-2020km-23-rb-record-iid-922756913','[VIP Dealer] Lexus LM 350 AT 7 Seat 3.5 Tahun 2020Km 23 Rb Record','lexus lm350 (2020)','3.5 4-Seater Bensin-AT','Bensin','15.000-20.000 Km','Automatic',2020,'>2.000 - 3.000 cc',1400000000,'Kebayoran Baru','Jakarta Selatan','KOKO MORTEN AUTO'),
('https://www.olx.co.id/item/vip-dealer-lexus-lx-460-46-bensin-at-2012-iid-923202069','[VIP Dealer] Lexus LX-460 4.6 Bensin At 2012','lexus lx460 (2012)','','Bensin','65.000-70.000 Km','Automatic',2012,'>3.000 cc',935000000,'Kebayoran Lama','Jakarta Selatan','Anugerah Motor Garage'),
('https://www.olx.co.id/item/vip-dealer-low-km-civic-es-2016-iid-923650706','[VIP Dealer] LOW KM!!! CIVIC ES 2016','honda civic (2016)','1.5 ES Bensin-AT','Bensin','65.000-70.000 Km','Automatic',2016,'>1.500 - 2.000 cc',270000000,'Kebayoran Lama','Jakarta Selatan','Tegar erbama'),
('https://www.olx.co.id/item/vip-dealer-range-rover-evoque-iid-923429499','[VIP Dealer] RANGE ROVER EVOQUE','land rover range rover evoque (2011)','Dynamic Si4-AT','Bensin','70.000-75.000 Km','Automatic',2011,'>1.500 - 2.000 cc',395000000,'Cilandak','Jakarta Selatan','CARAGE INDONESIA'),
('https://www.olx.co.id/item/vip-dealer-toyota-alphard-24-sc-audioless-at-2013-iid-922966977','[VIP Dealer] Toyota Alphard 2.4 SC Audioless AT 2013','toyota alphard (2013)','2.4 S Bensin-AT','Bensin','90.000-95.000 Km','Automatic',2013,'>2.000 - 3.000 cc',300000000,'Kebayoran Lama','Jakarta Selatan','Eric Indrajaya'),
('https://www.olx.co.id/item/vip-dealer-toyota-camry-g-2016-low-km-istimewaa-iid-921879200','[VIP Dealer] Toyota Camry G 2016 Low KM Istimewaa','toyota camry (2016)','2.5 G Bensin-AT','Bensin','65.000-70.000 Km','Automatic',2016,'>2.000 - 3.000 cc',189000000,'Kebayoran Baru','Jakarta Selatan','Megalia Auto Gallery'),
('https://www.olx.co.id/item/volkswagen-golf-14-tsi-at-upgrade-r-iid-923855130','VOLKSWAGEN GOLF 1.4 TSI A/T Upgrade R','volkswagen golf (2011)','1.4 TSI Bensin-AT','Bensin','40.000-45.000 Km','Automatic',2011,'>1.000 - 1.500 cc',199000000,'Pesanggrahan','Jakarta Selatan','yogie iskandar'),
('https://www.olx.co.id/item/vw-tiguan-allspace-14-tsi-2021-iid-923867021','VW Tiguan Allspace 1.4 TSI 2021','volkswagen tiguan allspace (2021)','1.4 TSI Bensin-AT','Bensin','30.000-35.000 Km','Automatic',2021,'>1.000 - 1.500 cc',349000000,'Kebayoran Baru','Jakarta Selatan','Habibie Autobahn'),
('https://www.olx.co.id/item/wuling-cloud-ev-tahun-2024-iid-922475808','WULING CLOUD EV tahun 2024','wuling cloud ev (2024)','Listrik-AT','Listrik','0-5.000 Km','Automatic',2024,'<1.000 cc',410000000,'Cilandak','Jakarta Selatan','Rieka Juwita'),
('https://www.olx.co.id/item/x-over-2010-rapih-banget-iid-923573639','X Over 2010 - Rapih Banget','suzuki sx4 (2010)','1.5 X-Over Bensin-AT','Bensin','100.000-105.000 Km','Automatic',2010,'>1.000 - 1.500 cc',92222222,'Pasar Minggu','Jakarta Selatan','Ari Sigit');
/*!40000 ALTER TABLE `post_mobil` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_insert_harga_notNegatif
BEFORE INSERT ON post_mobil
FOR EACH ROW
BEGIN
    IF NEW.harga < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Harga tidak boleh minus';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_update_harga_notNegatif
BEFORE UPDATE ON post_mobil
FOR EACH ROW
BEGIN
    IF NEW.harga < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Harga tidak boleh negatif';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pribadi`
--

DROP TABLE IF EXISTS `pribadi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pribadi` (
  `nama_penjual` varchar(255) NOT NULL,
  `no_telp` varchar(255) NOT NULL,
  PRIMARY KEY (`nama_penjual`,`no_telp`),
  CONSTRAINT `pribadi_ibfk_1` FOREIGN KEY (`nama_penjual`) REFERENCES `penjual` (`nama_penjual`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pribadi`
--

LOCK TABLES `pribadi` WRITE;
/*!40000 ALTER TABLE `pribadi` DISABLE KEYS */;
/*!40000 ALTER TABLE `pribadi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telp_pembeli`
--

DROP TABLE IF EXISTS `telp_pembeli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telp_pembeli` (
  `nama_pembeli` varchar(255) NOT NULL,
  `no_telp` varchar(255) NOT NULL,
  PRIMARY KEY (`nama_pembeli`,`no_telp`),
  CONSTRAINT `telp_pembeli_ibfk_1` FOREIGN KEY (`nama_pembeli`) REFERENCES `pembeli` (`nama_pembeli`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telp_pembeli`
--

LOCK TABLES `telp_pembeli` WRITE;
/*!40000 ALTER TABLE `telp_pembeli` DISABLE KEYS */;
/*!40000 ALTER TABLE `telp_pembeli` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-02 16:14:23

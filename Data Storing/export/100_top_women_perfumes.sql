-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: 100_top_women_perfumes
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `available`
--

DROP TABLE IF EXISTS `available`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available` (
  `store_ID` int NOT NULL,
  `perfume_ID` int NOT NULL,
  PRIMARY KEY (`store_ID`,`perfume_ID`),
  KEY `perfume_ID` (`perfume_ID`),
  CONSTRAINT `available_ibfk_1` FOREIGN KEY (`store_ID`) REFERENCES `store` (`store_ID`),
  CONSTRAINT `available_ibfk_2` FOREIGN KEY (`perfume_ID`) REFERENCES `perfume` (`perfume_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available`
--

LOCK TABLES `available` WRITE;
/*!40000 ALTER TABLE `available` DISABLE KEYS */;
/*!40000 ALTER TABLE `available` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_note`
--

DROP TABLE IF EXISTS `base_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_note` (
  `fragrance_ID` int NOT NULL,
  `perfume_ID` int NOT NULL,
  PRIMARY KEY (`fragrance_ID`,`perfume_ID`),
  KEY `perfume_ID` (`perfume_ID`),
  CONSTRAINT `base_note_ibfk_1` FOREIGN KEY (`fragrance_ID`) REFERENCES `fragrance` (`fragrance_ID`),
  CONSTRAINT `base_note_ibfk_2` FOREIGN KEY (`perfume_ID`) REFERENCES `perfume` (`perfume_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_note`
--

LOCK TABLES `base_note` WRITE;
/*!40000 ALTER TABLE `base_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `brand_name` varchar(255) NOT NULL,
  `country_of_origin` varchar(255) DEFAULT NULL,
  `founded_year` int DEFAULT NULL,
  `founder` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`brand_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES ('Amouage',NULL,NULL,NULL),('Ariana Grande',NULL,NULL,NULL),('Balenciaga',NULL,NULL,NULL),('bdk Parfums',NULL,NULL,NULL),('Bottega Veneta',NULL,NULL,NULL),('Carolina Herrera',NULL,NULL,NULL),('Chanel',NULL,NULL,NULL),('Chlo├⌐',NULL,NULL,NULL),('Dior',NULL,NULL,NULL),('Dolce & Gabbana',NULL,NULL,NULL),('Editions de Parfums Fr├⌐d├⌐ric Malle',NULL,NULL,NULL),('Givenchy',NULL,NULL,NULL),('Gritti',NULL,NULL,NULL),('Guerlain',NULL,NULL,NULL),('Jean Paul Gaultier',NULL,NULL,NULL),('Joop!',NULL,NULL,NULL),('Kayali',NULL,NULL,NULL),('Kenzo',NULL,NULL,NULL),('Kilian',NULL,NULL,NULL),('Lacoste',NULL,NULL,NULL),('Lalique',NULL,NULL,NULL),('Lanc├┤me',NULL,NULL,NULL),('Ligne St Barth',NULL,NULL,NULL),('M. Micallef',NULL,NULL,NULL),('Montblanc',NULL,NULL,NULL),('Mugler',NULL,NULL,NULL),('Narciso Rodriguez',NULL,NULL,NULL),('Nishane',NULL,NULL,NULL),('Parfums de Marly',NULL,NULL,NULL),('Prada',NULL,NULL,NULL),('Shiseido',NULL,NULL,NULL),('Sol de Janeiro',NULL,NULL,NULL),('Tom Ford',NULL,NULL,NULL),('Trussardi',NULL,NULL,NULL),('Versace',NULL,NULL,NULL),('XerJoff',NULL,NULL,NULL),('Yves Saint Laurent',NULL,NULL,NULL),('Zadig & Voltaire',NULL,NULL,NULL);
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fragrance`
--

DROP TABLE IF EXISTS `fragrance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fragrance` (
  `fragrance_ID` int NOT NULL,
  `fragrance_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fragrance_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fragrance`
--

LOCK TABLES `fragrance` WRITE;
/*!40000 ALTER TABLE `fragrance` DISABLE KEYS */;
/*!40000 ALTER TABLE `fragrance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `heart_note`
--

DROP TABLE IF EXISTS `heart_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heart_note` (
  `fragrance_ID` int NOT NULL,
  `perfume_ID` int NOT NULL,
  PRIMARY KEY (`fragrance_ID`,`perfume_ID`),
  KEY `perfume_ID` (`perfume_ID`),
  CONSTRAINT `heart_note_ibfk_1` FOREIGN KEY (`fragrance_ID`) REFERENCES `fragrance` (`fragrance_ID`),
  CONSTRAINT `heart_note_ibfk_2` FOREIGN KEY (`perfume_ID`) REFERENCES `perfume` (`perfume_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heart_note`
--

LOCK TABLES `heart_note` WRITE;
/*!40000 ALTER TABLE `heart_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `heart_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfume`
--

DROP TABLE IF EXISTS `perfume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfume` (
  `perfume_ID` int NOT NULL AUTO_INCREMENT,
  `perfume_name` varchar(255) DEFAULT NULL,
  `brand_name` varchar(255) DEFAULT NULL,
  `perfumer_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `release_year` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `gender` enum('male','female','unisex') DEFAULT NULL,
  `bottle_size` varchar(100) DEFAULT NULL,
  `rating_score` decimal(2,1) DEFAULT NULL,
  `total_rating` int DEFAULT NULL,
  `ranking` int DEFAULT NULL,
  PRIMARY KEY (`perfume_ID`),
  KEY `brand_name` (`brand_name`),
  KEY `perfumer_name` (`perfumer_name`),
  CONSTRAINT `perfume_ibfk_1` FOREIGN KEY (`brand_name`) REFERENCES `brand` (`brand_name`),
  CONSTRAINT `perfume_ibfk_2` FOREIGN KEY (`perfumer_name`) REFERENCES `perfumer` (`perfumer_name`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfume`
--

LOCK TABLES `perfume` WRITE;
/*!40000 ALTER TABLE `perfume` DISABLE KEYS */;
INSERT INTO `perfume` VALUES (1,'Mon Guerlain','Guerlain','Thierry Wasser','Eau de Parfum',2017,NULL,'female',NULL,8.2,1635,1),(2,'Hypnotic Poison','Dior','Annick M├⌐nardo','Eau de Toilette',1998,NULL,'female',NULL,8.0,1908,2),(3,'Delina','Parfums de Marly','Quentin Bisch','Eau de Parfum',2017,NULL,'female',NULL,8.0,1618,3),(4,'Shalimar','Guerlain','Jacques Guerlain','Eau de Parfum',1986,NULL,'female',NULL,8.0,1404,4),(5,'L\'Instant Magic','Guerlain','Randa Hammami','Eau de Parfum',2007,NULL,'female',NULL,8.2,1170,5),(6,'Black Orchid','Tom Ford','David Apel','Eau de Parfum',2006,NULL,'female',NULL,7.6,1969,6),(7,'Coco Mademoiselle','Chanel','Jacques Polge','Eau de Parfum',2001,NULL,'female',NULL,7.8,1596,7),(8,'Delina Exclusif','Parfums de Marly','Quentin Bisch',NULL,2017,NULL,'female',NULL,8.3,1035,8),(9,'Portrait of a Lady','Editions de Parfums Fr├⌐d├⌐ric Malle','Dominique Ropion','Eau de Parfum',2010,NULL,'female',NULL,8.1,1168,9),(10,'L\'Interdit','Givenchy','Dominique Ropion','Eau de Parfum Rouge',2021,NULL,'female',NULL,8.4,892,10),(11,'For Her','Narciso Rodriguez','Christine Nagel','Eau de Toilette',2003,NULL,'female',NULL,7.8,1383,11),(12,'Sunshine Woman','Amouage','Sidonie Lancesseur',NULL,2014,NULL,'female',NULL,8.1,1072,12),(13,'Alien','Mugler','Dominique Ropion','Eau de Parfum',2005,NULL,'female',NULL,7.4,2007,13),(14,'For Her Pure Musc','Narciso Rodriguez','Sonia Constant','Eau de Parfum',2019,NULL,'female',NULL,8.0,1171,14),(15,'Libre','Yves Saint Laurent','Anne Flipo','Eau de Parfum Intense',2020,NULL,'female',NULL,8.2,930,15),(16,'Coco','Chanel','Jacques Polge','Eau de Parfum',1984,NULL,'female',NULL,8.4,809,16),(17,'Rouge Smoking','bdk Parfums','Am├⌐lie Bourgeois','Eau de Parfum',2018,NULL,'female',NULL,8.0,1064,17),(18,'Coromandel','Chanel','Jacques Polge','Eau de Toilette',2007,NULL,'female',NULL,8.3,832,18),(19,'Dior Addict (2014)','Dior','Fran├ºois Demachy','Eau de Parfum',2014,NULL,'female',NULL,8.3,775,19),(20,'Vanilla | 28','Kayali','Gabriela Chelariu',NULL,2018,NULL,'female',NULL,8.1,910,20),(21,'Narciso','Narciso Rodriguez','Aur├⌐lien Guichard','Eau de Parfum Poudr├⌐e',2016,NULL,'female',NULL,7.9,1026,21),(22,'L\'Heure Bleue','Guerlain','Jacques Guerlain','Eau de Parfum',NULL,NULL,'female',NULL,8.3,736,22),(23,'Kenzo Amour','Kenzo','Daphn├⌐ Bugey',NULL,2006,NULL,'female',NULL,8.2,844,23),(24,'Cin├⌐ma','Yves Saint Laurent','Jacques Cavallier-Belletrud','Eau de Parfum',2004,NULL,'female',NULL,8.0,962,24),(25,'Libre','Yves Saint Laurent','Anne Flipo','Eau de Parfum',2019,NULL,'female',NULL,7.6,1359,25),(26,'Casamorati - Dama Bianca','XerJoff','Perfumers','Eau de Parfum',2012,NULL,'female',NULL,8.1,877,26),(27,'Love Don\'t Be Shy','Kilian','Calice Becker','Perfume',2007,NULL,'female',NULL,7.8,1125,27),(28,'Florabotanica','Balenciaga','Olivier Polge',NULL,2012,NULL,'female',NULL,7.8,1014,28),(29,'La Belle','Jean Paul Gaultier','Sonia Constant',NULL,2019,NULL,'female',NULL,8.0,892,29),(30,'Mon Guerlain','Guerlain','Thierry Wasser','Eau de Parfum Intense',2019,NULL,'female',NULL,8.4,650,30),(31,'Chlo├⌐ (2007)','Chlo├⌐','Michel Almairac','Eau de Parfum',2007,NULL,'female',NULL,7.5,1268,31),(32,'Memoir Woman','Amouage','Doroth├⌐e Piot','Eau de Parfum',2010,NULL,'female',NULL,8.3,661,32),(33,'La Belle Le','Jean Paul Gaultier','Quentin Bisch','Parfum',2021,NULL,'female',NULL,8.3,650,33),(34,'Aqua Allegoria Mandarine Basilic','Guerlain','Marie Salamagne',NULL,2007,NULL,'female',NULL,7.9,928,34),(35,'Noir pour Femme','Tom Ford','Sonia Constant',NULL,2015,NULL,'female',NULL,8.4,622,35),(36,'For Her Musc Noir Rose','Narciso Rodriguez','Sonia Constant',NULL,2022,NULL,'female',NULL,8.3,671,36),(37,'Alien Essence Absolue','Mugler','Dominique Ropion',NULL,2012,NULL,'female',NULL,8.3,626,37),(38,'Zen (2007)','Shiseido','Michel Almairac','Eau de Parfum',2007,NULL,'female',NULL,7.8,954,38),(39,'N┬░5 Eau Premi├¿re','Chanel','Jacques Polge',NULL,2008,NULL,'female',NULL,8.2,681,39),(40,'Infusion d\'Iris (2007)','Prada','Daniela Andrier','Eau de Parfum',2007,NULL,'female',NULL,8.0,813,40),(41,'Mitsouko','Guerlain','Jacques Guerlain','Eau de Parfum',NULL,NULL,'female',NULL,8.0,775,41),(42,'Duchessa','Gritti','Luca Gritti',NULL,2020,NULL,'female',NULL,8.4,548,42),(43,'J\'adore','Dior','Calice Becker','Eau de Parfum',1999,NULL,'female',NULL,7.5,1176,43),(44,'Coco Mademoiselle','Chanel','Olivier Polge','Eau de Parfum Intense',2018,NULL,'female',NULL,8.3,594,44),(45,'Hundred Silent Ways','Nishane','Perfumers','Extrait de Parfum',2016,NULL,'female',NULL,8.0,752,45),(46,'Mon Pr├⌐cieux Nectar','Guerlain','Randa Hammami',NULL,2009,NULL,'female',NULL,8.3,577,46),(47,'Manifesto L\'Elixir','Yves Saint Laurent','Perfumers',NULL,2013,NULL,'female',NULL,8.5,511,47),(48,'Shalimar  Initial','Guerlain','Thierry Wasser','Parfum',2011,NULL,'female',NULL,8.1,653,48),(49,'Delina La Ros├⌐e','Parfums de Marly','Quentin Bisch',NULL,2021,NULL,'female',NULL,8.2,627,49),(50,'N┬░5','Chanel','Ernest Beaux','Parfum',1921,NULL,'female',NULL,7.5,1047,50),(51,'Pour Femme','Lacoste','Olivier Cresp','Eau de Parfum',2003,NULL,'female',NULL,7.8,839,51),(52,'Black Opium','Yves Saint Laurent','Nathalie Lorson','Eau de Parfum',2014,NULL,'female',NULL,7.2,1420,52),(53,'La Nuit Tr├⌐sor ├á la Folie','Lanc├┤me','Christophe Raynaud',NULL,2018,NULL,'female',NULL,8.3,542,53),(54,'Les ├ëlixirs Charnels - Gourmand Coquin','Guerlain','Christine Nagel',NULL,2008,NULL,'female',NULL,8.4,501,54),(55,'Cheirosa \'62','Sol de Janeiro','J├⌐r├┤me Epinette',NULL,2017,NULL,'female',NULL,8.0,671,55),(56,'Bottega Veneta','Bottega Veneta','Michel Almairac','Eau de Parfum',2011,NULL,'female',NULL,7.9,743,56),(57,'Good Girl','Carolina Herrera','Louise Turner','Eau de Parfum',2016,NULL,'female',NULL,7.6,929,57),(58,'Dior Addict (2002)','Dior','Thierry Wasser','Eau de Parfum',2002,NULL,'female',NULL,8.3,530,58),(59,'N┬░19','Chanel','Henri Robert','Eau de Parfum',1971,NULL,'female',NULL,8.7,406,59),(60,'This Is Her!','Zadig & Voltaire','Sidonie Lancesseur',NULL,2016,NULL,'female',NULL,7.5,1018,60),(61,'Classique','Jean Paul Gaultier','Jacques Cavallier-Belletrud','Eau de Toilette',1993,NULL,'female',NULL,7.6,899,61),(62,'Chance Eau Tendre','Chanel','Jacques Polge','Eau de Toilette',2010,NULL,'female',NULL,7.9,695,62),(63,'Le Bain','Joop!','Symrise','Eau de Parfum',1988,NULL,'female',NULL,7.5,958,63),(64,'Coco Noir','Chanel','Jacques Polge','Eau de Parfum',2012,NULL,'female',NULL,7.7,840,64),(65,'Sycomore (2008)','Chanel','Jacques Polge','Eau de Toilette',2008,NULL,'female',NULL,8.3,503,65),(66,'Signature','Montblanc','Guillaume Flavigny','Eau de Parfum',2020,NULL,'female',NULL,7.8,735,66),(67,'Cloud','Ariana Grande','Cl├⌐ment Gavarry','Eau de Parfum',2018,NULL,'female',NULL,7.5,994,67),(68,'Jicky','Guerlain','Aim├⌐ Guerlain','Eau de Parfum',NULL,NULL,'female',NULL,8.0,637,68),(69,'Vanille West Indies','Ligne St Barth','Perfumers',NULL,2007,NULL,'female',NULL,8.2,522,69),(70,'Shalimar Ode ├á la Vanille - Sur la route du Mexique','Guerlain','Thierry Wasser',NULL,2013,NULL,'female',NULL,8.5,421,70),(71,'Dia Woman','Amouage','Jean-Claude Ellena','Eau de Parfum',2002,NULL,'female',NULL,7.9,683,71),(72,'Shalimar Mill├⌐sime Vanilla Planifolia','Guerlain','Thierry Wasser',NULL,2021,NULL,'female',NULL,8.6,391,72),(73,'Light Blue','Dolce & Gabbana','Olivier Cresp','Eau de Toilette',2001,NULL,'female',NULL,7.2,1167,73),(74,'Apr├¿s L\'Ond├⌐e','Guerlain','Jacques Guerlain','Eau de Toilette',1906,NULL,'female',NULL,8.2,513,74),(75,'Chance Eau Tendre','Chanel','Olivier Polge','Eau de Parfum',2019,NULL,'female',NULL,8.2,547,75),(76,'Samsara','Guerlain','Jean-Paul Guerlain','Eau de Parfum',1989,NULL,'female',NULL,7.9,646,76),(77,'Light Blue Eau Intense','Dolce & Gabbana','Olivier Cresp',NULL,2017,NULL,'female',NULL,7.9,634,77),(78,'Lalique Le   Eau de','Lalique','Dominique Ropion','Parfum',2005,NULL,'female',NULL,7.7,762,78),(79,'Pure Poison','Dior','Carlos Bena├»m',NULL,2004,NULL,'female',NULL,7.8,712,79),(80,'Libre Le','Yves Saint Laurent','Anne Flipo','Parfum',2022,NULL,'female',NULL,8.4,437,80),(81,'L\'Imp├⌐ratrice','Dolce & Gabbana','Nathalie Lorson',NULL,2009,NULL,'female',NULL,7.4,948,81),(82,'Kenzo Jungle','Kenzo','Dominique Ropion',NULL,1996,NULL,'female',NULL,7.7,745,82),(83,'Crystal Noir','Versace','Perfumers','Eau de Parfum',2004,NULL,'female',NULL,8.1,536,83),(84,'Chance Eau Fra├«che','Chanel','Jacques Polge','Eau de Toilette',2007,NULL,'female',NULL,7.7,725,84),(85,'Lilac Love','Amouage','Nathalie Lorson','Eau de Parfum',2016,NULL,'female',NULL,8.0,589,85),(86,'Nomade','Chlo├⌐','Quentin Bisch','Eau de Parfum',2018,NULL,'female',NULL,7.6,779,86),(87,'Ylang in Gold','M. Micallef','Geoffrey Nejman','Eau de Parfum',2012,NULL,'female',NULL,7.8,662,87),(88,'Versense','Versace','Alberto Morillas',NULL,2009,NULL,'female',NULL,7.8,661,88),(89,'La Nuit Tr├⌐sor L\'','Lanc├┤me','Christophe Raynaud','Eau de Parfum',2015,NULL,'female',NULL,7.9,634,89),(90,'Angel Muse','Mugler','Quentin Bisch','Eau de Parfum',2016,NULL,'female',NULL,8.0,589,90),(91,'Allure','Chanel','Jacques Polge','Eau de Parfum',1999,NULL,'female',NULL,7.9,636,91),(92,'Shalimar','Guerlain','Jacques Guerlain','Eau de Toilette',1925,NULL,'female',NULL,8.5,387,92),(93,'My Name','Trussardi','Aur├⌐lien Guichard',NULL,2013,NULL,'female',NULL,7.9,609,93),(94,'Meliora','Parfums de Marly','Nathalie Lorson',NULL,2012,NULL,'female',NULL,7.9,603,94),(95,'L\'Interdit (2018)','Givenchy','Dominique Ropion','Eau de Parfum',2018,NULL,'female',NULL,7.7,715,95),(96,'Shalimar Philtre de','Guerlain','Thierry Wasser','Parfum',2020,NULL,'female',NULL,8.5,378,96),(97,'Vol de Nuit','Guerlain','Jacques Guerlain','Eau de Toilette',1933,NULL,'female',NULL,8.3,457,97),(98,'Coco','Chanel','Jacques Polge','Eau de Toilette',1984,NULL,'female',NULL,8.6,353,98),(99,'Insolence','Guerlain','Maurice Roucel','Eau de Parfum',2008,NULL,'female',NULL,8.0,564,99),(100,'Narciso','Narciso Rodriguez','Sonia Constant','Eau de Parfum Rouge',2018,NULL,'female',NULL,8.0,564,100);
/*!40000 ALTER TABLE `perfume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfume_accord`
--

DROP TABLE IF EXISTS `perfume_accord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfume_accord` (
  `perfume_ID` int NOT NULL,
  `main_accords` varchar(255) NOT NULL,
  PRIMARY KEY (`perfume_ID`,`main_accords`),
  CONSTRAINT `perfume_accord_ibfk_1` FOREIGN KEY (`perfume_ID`) REFERENCES `perfume` (`perfume_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfume_accord`
--

LOCK TABLES `perfume_accord` WRITE;
/*!40000 ALTER TABLE `perfume_accord` DISABLE KEYS */;
INSERT INTO `perfume_accord` VALUES (1,'Creamy'),(1,'Floral'),(1,'Gourmand'),(1,'Powdery'),(1,'Spicy'),(1,'Sweet'),(2,'Gourmand'),(2,'Oriental'),(2,'Powdery'),(2,'Spicy'),(2,'Sweet'),(3,'Creamy'),(3,'Floral'),(3,'Fresh'),(3,'Fruity'),(3,'Sweet'),(4,'Floral'),(4,'Oriental'),(4,'Powdery'),(4,'Smoky'),(4,'Spicy'),(4,'Sweet'),(5,'Creamy'),(5,'Floral'),(5,'Gourmand'),(5,'Powdery'),(5,'Sweet'),(6,'Floral'),(6,'Oriental'),(6,'Spicy'),(6,'Sweet'),(6,'Woody'),(7,'Citrus'),(7,'Floral'),(7,'Fresh'),(7,'Fruity'),(7,'Oriental'),(7,'Powdery'),(7,'Sweet'),(8,'Creamy'),(8,'Floral'),(8,'Fruity'),(8,'Powdery'),(8,'Sweet'),(9,'Floral'),(9,'Oriental'),(9,'Smoky'),(9,'Spicy'),(9,'Woody'),(10,'Floral'),(10,'Fruity'),(10,'Oriental'),(10,'Spicy'),(10,'Sweet'),(11,'Floral'),(11,'Fresh'),(11,'Powdery'),(11,'Sweet'),(11,'Woody'),(12,'Creamy'),(12,'Floral'),(12,'Fruity'),(12,'Spicy'),(12,'Sweet'),(13,'Floral'),(13,'Oriental'),(13,'Sweet'),(13,'Synthetic'),(13,'Woody'),(14,'Creamy'),(14,'Floral'),(14,'Fresh'),(14,'Powdery'),(14,'Synthetic'),(15,'Citrus'),(15,'Creamy'),(15,'Floral'),(15,'Fresh'),(15,'Oriental'),(15,'Spicy'),(15,'Sweet'),(16,'Floral'),(16,'Oriental'),(16,'Powdery'),(16,'Spicy'),(16,'Sweet'),(16,'Woody'),(17,'Creamy'),(17,'Fruity'),(17,'Gourmand'),(17,'Spicy'),(17,'Sweet'),(18,'Earthy'),(18,'Oriental'),(18,'Powdery'),(18,'Spicy'),(18,'Woody'),(19,'Floral'),(19,'Oriental'),(19,'Powdery'),(19,'Spicy'),(19,'Sweet'),(20,'Creamy'),(20,'Gourmand'),(20,'Oriental'),(20,'Spicy'),(20,'Sweet'),(21,'Creamy'),(21,'Floral'),(21,'Powdery'),(21,'Sweet'),(21,'Woody'),(22,'Floral'),(22,'Oriental'),(22,'Powdery'),(22,'Spicy'),(22,'Sweet'),(23,'Floral'),(23,'Gourmand'),(23,'Oriental'),(23,'Powdery'),(23,'Sweet'),(24,'Floral'),(24,'Gourmand'),(24,'Oriental'),(24,'Powdery'),(24,'Sweet'),(26,'Creamy'),(26,'Floral'),(26,'Gourmand'),(26,'Powdery'),(26,'Sweet'),(27,'Floral'),(27,'Fruity'),(27,'Gourmand'),(27,'Powdery'),(27,'Sweet'),(28,'Floral'),(28,'Fresh'),(28,'Green'),(28,'Powdery'),(28,'Spicy'),(29,'Creamy'),(29,'Floral'),(29,'Fruity'),(29,'Gourmand'),(29,'Sweet'),(31,'Floral'),(31,'Fresh'),(31,'Fruity'),(31,'Powdery'),(31,'Sweet'),(32,'Floral'),(32,'Oriental'),(32,'Smoky'),(32,'Spicy'),(32,'Woody'),(33,'Creamy'),(33,'Floral'),(33,'Fruity'),(33,'Gourmand'),(33,'Sweet'),(34,'Citrus'),(34,'Fresh'),(34,'Fruity'),(34,'Green'),(34,'Spicy'),(35,'Floral'),(35,'Gourmand'),(35,'Oriental'),(35,'Spicy'),(35,'Sweet'),(36,'Creamy'),(36,'Floral'),(36,'Fruity'),(36,'Powdery'),(36,'Sweet'),(37,'Floral'),(37,'Gourmand'),(37,'Oriental'),(37,'Powdery'),(37,'Sweet'),(38,'Citrus'),(38,'Floral'),(38,'Fresh'),(38,'Fruity'),(38,'Woody'),(39,'Citrus'),(39,'Floral'),(39,'Fresh'),(39,'Powdery'),(39,'Sweet'),(40,'Floral'),(40,'Fresh'),(40,'Green'),(40,'Powdery'),(40,'Woody'),(41,'Chypre'),(41,'Floral'),(41,'Fruity'),(41,'Spicy'),(41,'Woody'),(42,'Creamy'),(42,'Fruity'),(42,'Gourmand'),(42,'Spicy'),(42,'Sweet'),(43,'Floral'),(43,'Fresh'),(43,'Fruity'),(43,'Powdery'),(43,'Sweet'),(45,'Creamy'),(45,'Floral'),(45,'Fruity'),(45,'Gourmand'),(45,'Sweet'),(46,'Creamy'),(46,'Floral'),(46,'Gourmand'),(46,'Powdery'),(46,'Sweet'),(47,'Floral'),(47,'Gourmand'),(47,'Oriental'),(47,'Powdery'),(47,'Sweet'),(48,'Floral'),(48,'Oriental'),(48,'Powdery'),(48,'Spicy'),(48,'Sweet'),(49,'Aquatic'),(49,'Floral'),(49,'Fresh'),(49,'Fruity'),(49,'Sweet'),(50,'Floral'),(50,'Powdery'),(50,'Spicy'),(50,'Sweet'),(50,'Synthetic'),(51,'Floral'),(51,'Fresh'),(51,'Powdery'),(51,'Sweet'),(51,'Woody'),(52,'Floral'),(52,'Gourmand'),(52,'Oriental'),(52,'Spicy'),(52,'Sweet'),(53,'Creamy'),(53,'Floral'),(53,'Fruity'),(53,'Gourmand'),(53,'Sweet'),(54,'Gourmand'),(54,'Oriental'),(54,'Powdery'),(54,'Spicy'),(54,'Sweet'),(55,'Creamy'),(55,'Floral'),(55,'Gourmand'),(55,'Sweet'),(55,'Synthetic'),(56,'Floral'),(56,'Leathery'),(56,'Powdery'),(56,'Spicy'),(56,'Woody'),(57,'Creamy'),(57,'Floral'),(57,'Gourmand'),(57,'Oriental'),(57,'Sweet'),(58,'Floral'),(58,'Oriental'),(58,'Powdery'),(58,'Spicy'),(58,'Sweet'),(59,'Chypre'),(59,'Floral'),(59,'Fresh'),(59,'Green'),(59,'Woody'),(60,'Creamy'),(60,'Powdery'),(60,'Sweet'),(60,'Synthetic'),(60,'Woody'),(61,'Floral'),(61,'Fruity'),(61,'Oriental'),(61,'Powdery'),(61,'Sweet'),(62,'Citrus'),(62,'Floral'),(62,'Fresh'),(62,'Fruity'),(62,'Powdery'),(62,'Sweet'),(63,'Floral'),(63,'Gourmand'),(63,'Oriental'),(63,'Powdery'),(63,'Sweet'),(64,'Floral'),(64,'Oriental'),(64,'Powdery'),(64,'Spicy'),(64,'Sweet'),(65,'Earthy'),(65,'Green'),(65,'Smoky'),(65,'Spicy'),(65,'Woody'),(66,'Creamy'),(66,'Floral'),(66,'Fruity'),(66,'Powdery'),(66,'Sweet'),(67,'Creamy'),(67,'Fruity'),(67,'Gourmand'),(67,'Sweet'),(67,'Synthetic'),(68,'Animal'),(68,'Floral'),(68,'Oriental'),(68,'Powdery'),(68,'Spicy'),(69,'Creamy'),(69,'Floral'),(69,'Gourmand'),(69,'Powdery'),(69,'Sweet'),(70,'Oriental'),(70,'Powdery'),(70,'Smoky'),(70,'Spicy'),(70,'Sweet'),(71,'Creamy'),(71,'Floral'),(71,'Fresh'),(71,'Powdery'),(71,'Spicy'),(72,'Oriental'),(72,'Powdery'),(72,'Smoky'),(72,'Spicy'),(72,'Sweet'),(73,'Aquatic'),(73,'Citrus'),(73,'Floral'),(73,'Fresh'),(73,'Fruity'),(74,'Floral'),(74,'Fresh'),(74,'Powdery'),(74,'Spicy'),(74,'Sweet'),(76,'Floral'),(76,'Oriental'),(76,'Powdery'),(76,'Spicy'),(76,'Woody'),(77,'Aquatic'),(77,'Citrus'),(77,'Fresh'),(77,'Fruity'),(77,'Woody'),(78,'Floral'),(78,'Oriental'),(78,'Powdery'),(78,'Spicy'),(78,'Sweet'),(79,'Floral'),(79,'Fresh'),(79,'Powdery'),(79,'Sweet'),(79,'Woody'),(80,'Creamy'),(80,'Floral'),(80,'Oriental'),(80,'Spicy'),(80,'Sweet'),(81,'Aquatic'),(81,'Floral'),(81,'Fresh'),(81,'Fruity'),(81,'Sweet'),(82,'Gourmand'),(82,'Oriental'),(82,'Spicy'),(82,'Sweet'),(82,'Woody'),(83,'Creamy'),(83,'Floral'),(83,'Fresh'),(83,'Spicy'),(83,'Sweet'),(84,'Citrus'),(84,'Floral'),(84,'Fresh'),(84,'Green'),(84,'Woody'),(85,'Creamy'),(85,'Floral'),(85,'Gourmand'),(85,'Powdery'),(85,'Sweet'),(86,'Chypre'),(86,'Floral'),(86,'Fresh'),(86,'Fruity'),(86,'Sweet'),(87,'Creamy'),(87,'Floral'),(87,'Fruity'),(87,'Gourmand'),(87,'Sweet'),(88,'Citrus'),(88,'Floral'),(88,'Fresh'),(88,'Green'),(88,'Woody'),(89,'Floral'),(89,'Fruity'),(89,'Gourmand'),(89,'Oriental'),(89,'Sweet'),(90,'Creamy'),(90,'Fruity'),(90,'Gourmand'),(90,'Oriental'),(90,'Sweet'),(91,'Floral'),(91,'Fruity'),(91,'Oriental'),(91,'Powdery'),(91,'Sweet'),(93,'Creamy'),(93,'Floral'),(93,'Fresh'),(93,'Powdery'),(93,'Sweet'),(94,'Creamy'),(94,'Floral'),(94,'Fresh'),(94,'Fruity'),(94,'Sweet'),(95,'Creamy'),(95,'Floral'),(95,'Fruity'),(95,'Powdery'),(95,'Sweet'),(96,'Citrus'),(96,'Floral'),(96,'Oriental'),(96,'Powdery'),(96,'Sweet'),(97,'Chypre'),(97,'Floral'),(97,'Powdery'),(97,'Spicy'),(97,'Woody'),(99,'Floral'),(99,'Fruity'),(99,'Powdery'),(99,'Sweet'),(99,'Woody');
/*!40000 ALTER TABLE `perfume_accord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfumer`
--

DROP TABLE IF EXISTS `perfumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfumer` (
  `perfumer_name` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`perfumer_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfumer`
--

LOCK TABLES `perfumer` WRITE;
/*!40000 ALTER TABLE `perfumer` DISABLE KEYS */;
INSERT INTO `perfumer` VALUES ('Aim├⌐ Guerlain',NULL,NULL),('Alberto Morillas',NULL,NULL),('Am├⌐lie Bourgeois',NULL,NULL),('Anne Flipo',NULL,NULL),('Annick M├⌐nardo',NULL,NULL),('Aur├⌐lien Guichard',NULL,NULL),('Calice Becker',NULL,NULL),('Carlos Bena├»m',NULL,NULL),('Christine Nagel',NULL,NULL),('Christophe Raynaud',NULL,NULL),('Cl├⌐ment Gavarry',NULL,NULL),('Daniela Andrier',NULL,NULL),('Daphn├⌐ Bugey',NULL,NULL),('David Apel',NULL,NULL),('Dominique Ropion',NULL,NULL),('Doroth├⌐e Piot',NULL,NULL),('Ernest Beaux',NULL,NULL),('Fran├ºois Demachy',NULL,NULL),('Gabriela Chelariu',NULL,NULL),('Geoffrey Nejman',NULL,NULL),('Guillaume Flavigny',NULL,NULL),('Henri Robert',NULL,NULL),('Jacques Cavallier-Belletrud',NULL,NULL),('Jacques Guerlain',NULL,NULL),('Jacques Polge',NULL,NULL),('Jean-Claude Ellena',NULL,NULL),('Jean-Paul Guerlain',NULL,NULL),('J├⌐r├┤me Epinette',NULL,NULL),('Louise Turner',NULL,NULL),('Luca Gritti',NULL,NULL),('Marie Salamagne',NULL,NULL),('Maurice Roucel',NULL,NULL),('Michel Almairac',NULL,NULL),('Nathalie Lorson',NULL,NULL),('Olivier Cresp',NULL,NULL),('Olivier Polge',NULL,NULL),('Perfumers',NULL,NULL),('Quentin Bisch',NULL,NULL),('Randa Hammami',NULL,NULL),('Sidonie Lancesseur',NULL,NULL),('Sonia Constant',NULL,NULL),('Symrise',NULL,NULL),('Thierry Wasser',NULL,NULL);
/*!40000 ALTER TABLE `perfumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_ID` int NOT NULL,
  `perfume_ID` int NOT NULL,
  `user_ID` int NOT NULL,
  `review` text,
  PRIMARY KEY (`review_ID`,`perfume_ID`,`user_ID`),
  KEY `perfume_ID` (`perfume_ID`),
  KEY `user_ID` (`user_ID`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`perfume_ID`) REFERENCES `perfume` (`perfume_ID`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_ID`) REFERENCES `user` (`user_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `store_ID` int NOT NULL,
  `store_name` varchar(255) DEFAULT NULL,
  `store_address` varchar(255) DEFAULT NULL,
  `store_contact` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`store_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `top_note`
--

DROP TABLE IF EXISTS `top_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `top_note` (
  `fragrance_ID` int NOT NULL,
  `perfume_ID` int NOT NULL,
  PRIMARY KEY (`fragrance_ID`,`perfume_ID`),
  KEY `perfume_ID` (`perfume_ID`),
  CONSTRAINT `top_note_ibfk_1` FOREIGN KEY (`fragrance_ID`) REFERENCES `fragrance` (`fragrance_ID`),
  CONSTRAINT `top_note_ibfk_2` FOREIGN KEY (`perfume_ID`) REFERENCES `perfume` (`perfume_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `top_note`
--

LOCK TABLES `top_note` WRITE;
/*!40000 ALTER TABLE `top_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `top_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_ID` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `user_first_name` varchar(255) DEFAULT NULL,
  `user_last_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(16) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-02 10:10:35

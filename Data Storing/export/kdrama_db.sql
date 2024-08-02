-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: kdrama_db
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `acted`
--

DROP TABLE IF EXISTS `acted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acted` (
  `actor_name` varchar(255) NOT NULL,
  `character_id` int NOT NULL,
  `drama_name` varchar(255) NOT NULL,
  PRIMARY KEY (`actor_name`,`character_id`,`drama_name`),
  KEY `character_id` (`character_id`),
  KEY `drama_name` (`drama_name`),
  CONSTRAINT `acted_ibfk_1` FOREIGN KEY (`actor_name`) REFERENCES `actor` (`actor_name`) ON DELETE CASCADE,
  CONSTRAINT `acted_ibfk_2` FOREIGN KEY (`character_id`) REFERENCES `character` (`character_id`) ON DELETE CASCADE,
  CONSTRAINT `acted_ibfk_3` FOREIGN KEY (`drama_name`) REFERENCES `drama` (`drama_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acted`
--

LOCK TABLES `acted` WRITE;
/*!40000 ALTER TABLE `acted` DISABLE KEYS */;
/*!40000 ALTER TABLE `acted` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor` (
  `actor_name` varchar(255) NOT NULL,
  `stage_name` varchar(255) DEFAULT NULL,
  `agency_id` int DEFAULT NULL,
  PRIMARY KEY (`actor_name`),
  KEY `agency_id` (`agency_id`),
  CONSTRAINT `actor_ibfk_1` FOREIGN KEY (`actor_name`) REFERENCES `crew` (`name`) ON DELETE CASCADE,
  CONSTRAINT `actor_ibfk_2` FOREIGN KEY (`agency_id`) REFERENCES `agency` (`agency_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agency`
--

DROP TABLE IF EXISTS `agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agency` (
  `agency_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `ceo` varchar(255) DEFAULT NULL,
  `founded_year` int DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`agency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agency`
--

LOCK TABLES `agency` WRITE;
/*!40000 ALTER TABLE `agency` DISABLE KEYS */;
/*!40000 ALTER TABLE `agency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `award`
--

DROP TABLE IF EXISTS `award`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `award` (
  `award_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`award_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `award`
--

LOCK TABLES `award` WRITE;
/*!40000 ALTER TABLE `award` DISABLE KEYS */;
/*!40000 ALTER TABLE `award` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `character`
--

DROP TABLE IF EXISTS `character`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character` (
  `character_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `role` enum('Main','Side') DEFAULT NULL,
  `backstory` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character`
--

LOCK TABLES `character` WRITE;
/*!40000 ALTER TABLE `character` DISABLE KEYS */;
/*!40000 ALTER TABLE `character` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew`
--

DROP TABLE IF EXISTS `crew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crew` (
  `name` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('Female','Male') DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew`
--

LOCK TABLES `crew` WRITE;
/*!40000 ALTER TABLE `crew` DISABLE KEYS */;
INSERT INTO `crew` VALUES
('Ahn Eun Bin',NULL,NULL),
('Ahn Gil Ho',NULL,NULL),
('Bae Hyun Jin',NULL,NULL),
('Bae Se Young',NULL,NULL),
('Baek Mi Kyung',NULL,NULL),
('Baek Sang Hoon',NULL,NULL),
('Ban Ki Ri',NULL,NULL),
('Choi Ah Il',NULL,NULL),
('Choi Chang Hwan',NULL,NULL),
('Choi Joon Bae',NULL,NULL),
('Choi Jung Gyu',NULL,NULL),
('Choi Ran',NULL,NULL),
('Choi Soo Jin',NULL,NULL),
('Choi Woo Joo',NULL,NULL),
('Choi Yi Ryun',NULL,NULL),
('Ha Byung Hoon',NULL,NULL),
('Han Dong Hwa',NULL,NULL),
('Han Dong Wook',NULL,NULL),
('Han Jin Sun',NULL,NULL),
('Han Sang Woon',NULL,NULL),
('Han Sul Hee',NULL,NULL),
('Han Woo Ri',NULL,NULL),
('Hong Bo Hee',NULL,NULL),
('Hong Jong Chan',NULL,NULL),
('Hong Jung Eun',NULL,NULL),
('Hong Mi Ran',NULL,NULL),
('Hwang Jin Young',NULL,NULL),
('Jang Min Seok',NULL,NULL),
('Jang Young Woo',NULL,NULL),
('Ji Ho Jin',NULL,NULL),
('Jin Soo Wan',NULL,NULL),
('Jo Hyun Taek',NULL,NULL),
('Jo Nam Hyung',NULL,NULL),
('Jo Won Gi',NULL,NULL),
('Jo Yong',NULL,NULL),
('Jo Yoon Young',NULL,NULL),
('Jo Young Kwang',NULL,NULL),
('Joo Dong Min',NULL,NULL),
('Jung Bo Hoon',NULL,NULL),
('Jung Dong Yoon',NULL,NULL),
('Jung Hae Ri',NULL,NULL),
('Jung Ji Hyun',NULL,NULL),
('Jung Ji In',NULL,NULL),
('Jung Seo Kyung',NULL,NULL),
('Jung So Young',NULL,NULL),
('Jung Yi Do',NULL,NULL),
('Jung Yoon Jung',NULL,NULL),
('Kang Cheol Woo',NULL,NULL),
('Kang Eun Kyung',NULL,NULL),
('Kang Full',NULL,NULL),
('Kang Shin Hyo',NULL,NULL),
('Kim Ba Da',NULL,NULL),
('Kim Bo Tong',NULL,NULL),
('Kim Chul Gyu',NULL,NULL),
('Kim Da Hee',NULL,NULL),
('Kim Dae Jin',NULL,NULL),
('Kim Do Yeon',NULL,NULL),
('Kim Eun Hee',NULL,NULL),
('Kim Eun Sook',NULL,NULL),
('Kim Hee Won',NULL,NULL),
('Kim Hong Seon',NULL,NULL),
('Kim Hyung Min',NULL,NULL),
('Kim Hyung Shik',NULL,NULL),
('Kim Jae Hong',NULL,NULL),
('Kim Jin Man',NULL,NULL),
('Kim Jin Min',NULL,NULL),
('Kim Jin Woo',NULL,NULL),
('Kim Kyu Tae',NULL,NULL),
('Kim Kyun Ah',NULL,NULL),
('Kim Sae Bom',NULL,NULL),
('Kim Sang Woo',NULL,NULL),
('Kim Seung Ho',NULL,NULL),
('Kim Song Hee',NULL,NULL),
('Kim Soo Jin',NULL,NULL),
('Kim Soon Ok',NULL,NULL),
('Kim Sung Ho',NULL,NULL),
('Kim Sung Hoon',NULL,NULL),
('Kim Sung Yong',NULL,NULL),
('Kim Tae Yoon',NULL,NULL),
('Kim Tae Yub',NULL,NULL),
('Kim Won Seok',NULL,NULL),
('Kim Won Suk',NULL,NULL),
('Kim Yoon Jin',NULL,NULL),
('Kim Young Hyun',NULL,NULL),
('Kim Yu Jin',NULL,NULL),
('Kwon Do Eun',NULL,NULL),
('Kwon Il Yong',NULL,NULL),
('Kwon So Ra',NULL,NULL),
('Lee Byung Hoon',NULL,NULL),
('Lee Chang Hee',NULL,NULL),
('Lee Dae II',NULL,NULL),
('Lee Dae Kyung',NULL,NULL),
('Lee Dan',NULL,NULL),
('Lee Eun Mi',NULL,NULL),
('Lee Eung Bok',NULL,NULL),
('Lee Gil Bok',NULL,NULL),
('Lee Han Joon',NULL,NULL),
('Lee Hyung Min',NULL,NULL),
('Lee Jae Gyoo',NULL,NULL),
('Lee Jeong Hyo',NULL,NULL),
('Lee Ji Hyun',NULL,NULL),
('Lee Jung Mook',NULL,NULL),
('Lee Jung Rim',NULL,NULL),
('Lee Jung Sub',NULL,NULL),
('Lee Kang',NULL,NULL),
('Lee Myung Woo',NULL,NULL),
('Lee Na Eun',NULL,NULL),
('Lee Nam Gyu',NULL,NULL),
('Lee Shi Eun',NULL,NULL),
('Lee Shin Hwa',NULL,NULL),
('Lee Soo Yeon',NULL,NULL),
('Lee Woo Jung',NULL,NULL),
('Lee Ye Rim',NULL,NULL),
('Min Ji Eun',NULL,NULL),
('Min Yeon Hong',NULL,NULL),
('Moon Ji Won',NULL,NULL),
('Moon Yoo Seok',NULL,NULL),
('Nam Ki Hoon',NULL,NULL),
('Nam Sung Woo',NULL,NULL),
('Noh Do Cheol',NULL,NULL),
('Noh Hee Kyung',NULL,NULL),
('Oh Choong Hwan',NULL,NULL),
('Oh Hyun Jong',NULL,NULL),
('Oh Sang Ho',NULL,NULL),
('Park Ba Ra',NULL,NULL),
('Park Bo Ram',NULL,NULL),
('Park Dhan Hee',NULL,NULL),
('Park Geun Beom',NULL,NULL),
('Park Hae Young',NULL,NULL),
('Park Hye Ryun',NULL,NULL),
('Park In Je',NULL,NULL),
('Park Ja Kyung',NULL,NULL),
('Park Jae Bum',NULL,NULL),
('Park Ji Eun',NULL,NULL),
('Park Joon Hwa',NULL,NULL),
('Park Joon Woo',NULL,NULL),
('Park Kye Ok',NULL,NULL),
('Park Ran',NULL,NULL),
('Park Sang Yeon',NULL,NULL),
('Park Seon Ho',NULL,NULL),
('Park Shin Woo',NULL,NULL),
('Park Soo Jin',NULL,NULL),
('Park Yoo Young',NULL,NULL),
('Seo Jae Won',NULL,NULL),
('Seol Yi Na',NULL,NULL),
('Shim Na Yeon',NULL,NULL),
('Shin Ha Eun',NULL,NULL),
('Shin Kyung Soo',NULL,NULL),
('Shin Won Ho',NULL,NULL),
('Shin Yong Hwi',NULL,NULL),
('Son Jung Hyun',NULL,NULL),
('Song Ji Na',NULL,NULL),
('Song Min Yeop',NULL,NULL),
('Song Yeon Hwa',NULL,NULL),
('Sung Chi Wook',NULL,NULL),
('Tak Jae Young',NULL,NULL),
('unknown',NULL,NULL),
('Yang Hee Seung',NULL,NULL),
('Yeo Ji Na',NULL,NULL),
('Yoo Hak Chan',NULL,NULL),
('Yoo Hyun Mi',NULL,NULL),
('Yoo In Shik',NULL,NULL),
('Yoo Je Won',NULL,NULL),
('Yoo Jung Hee',NULL,NULL),
('Yoon Hyun Gi',NULL,NULL),
('Yoon Ji Ryun',NULL,NULL),
('Yoon Jong Ho',NULL,NULL),
('Yoon Sung Shik',NULL,NULL);
/*!40000 ALTER TABLE `crew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directed`
--

DROP TABLE IF EXISTS `directed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directed` (
  `director_name` varchar(255) NOT NULL,
  `drama_name` varchar(255) NOT NULL,
  PRIMARY KEY (`director_name`,`drama_name`),
  KEY `drama_name` (`drama_name`),
  CONSTRAINT `directed_ibfk_1` FOREIGN KEY (`director_name`) REFERENCES `director` (`director_name`) ON DELETE CASCADE,
  CONSTRAINT `directed_ibfk_2` FOREIGN KEY (`drama_name`) REFERENCES `drama` (`drama_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directed`
--

LOCK TABLES `directed` WRITE;
/*!40000 ALTER TABLE `directed` DISABLE KEYS */;
INSERT INTO `directed` VALUES
('Ha Byung Hoon','18 Again'),
('unknown','A Shop for Killers'),
('Park Joon Hwa','Alchemy of Souls'),
('Bae Hyun Jin','Alchemy of Souls Season 2: Light and Shadow'),
('Park Joon Hwa','Alchemy of Souls Season 2: Light and Shadow'),
('Kim Won Suk','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('Kim Won Suk','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('Kim Jae Hong','Begins Youth'),
('Shim Na Yeon','Beyond Evil'),
('unknown','Bloodhounds'),
('Park Seon Ho','Business Proposal'),
('Kim Chul Gyu','Chicago Typewriter'),
('Lee Jeong Hyo','Crash Landing on You'),
('unknown','D.P.'),
('unknown','D.P. Season 2'),
('Lee Jae Gyoo','Daily Dose of Sunshine'),
('Hong Jong Chan','Dear My Friends'),
('unknown','Death\'s Game'),
('unknown','Death\'s Game Part 2'),
('Jo Young Kwang','Defendant'),
('Jung Dong Yoon','Defendant'),
('Baek Sang Hoon','Descendants of the Sun'),
('Lee Eung Bok','Descendants of the Sun'),
('Park Soo Jin','Dr. Romantic'),
('Yoo In Shik','Dr. Romantic'),
('Lee Gil Bok','Dr. Romantic Season 2'),
('Yoo In Shik','Dr. Romantic Season 2'),
('Yoo In Shik','Dr. Romantic Season 3'),
('Yoo In Shik','Extraordinary Attorney Woo'),
('Kim Jae Hong','Flex X Cop'),
('Kim Chul Gyu','Flower of Evil'),
('Yoon Jong Ho','Flower of Evil'),
('Lee Eung Bok','Goblin'),
('Ahn Gil Ho','Happiness'),
('Kim Jin Woo','Healer'),
('Lee Jung Sub','Healer'),
('Yoo Je Won','Hometown Cha-Cha-Cha'),
('Shin Won Ho','Hospital Playlist'),
('Shin Won Ho','Hospital Playlist Season 2'),
('Jung Dong Yoon','Hot Stove League'),
('Oh Choong Hwan','Hotel del Luna'),
('Jung Dong Yoon','It\'s Okay to Not Be Okay'),
('Park Shin Woo','It\'s Okay to Not Be Okay'),
('Lee Byung Hoon','Jewel in the Palace'),
('Kim Dae Jin','Kill Me, Heal Me'),
('Kim Jin Man','Kill Me, Heal Me'),
('Kim Sung Hoon','Kingdom'),
('Kim Sung Hoon','Kingdom Season 2'),
('Park In Je','Kingdom Season 2'),
('Lee Jeong Hyo','Life on Mars'),
('Kim Kyun Ah','Love for Love\'s Sake'),
('Kim Tae Yub','Lovely Runner'),
('Yoon Jong Ho','Lovely Runner'),
('Kim Won Suk','Misaeng: Incomplete Life'),
('Lee Ye Rim','Missing: The Other Side Season 2'),
('Min Yeon Hong','Missing: The Other Side Season 2'),
('Kim Kyu Tae','Moon Lovers: Scarlet Heart Ryeo'),
('Kim Chul Gyu','Mother'),
('Yoon Hyun Gi','Mother'),
('Choi Joon Bae','Mouse'),
('Kang Cheol Woo','Mouse'),
('Kim Sung Ho','Move to Heaven'),
('Park In Je','Moving'),
('Yoon Sung Shik','Mr. Queen'),
('Lee Eung Bok','Mr. Sunshine'),
('Kim Sung Yong','My Dearest'),
('Lee Han Joon','My Dearest'),
('Kim Sung Yong','My Dearest Part 2'),
('Lee Han Joon','My Dearest Part 2'),
('Kim Sang Woo','My Mister'),
('Kim Won Suk','My Mister'),
('Kim Jin Min','My Name'),
('Han Dong Hwa','Navillera'),
('Kim Yoon Jin','Our Beloved Summer'),
('Kim Kyu Tae','Our Blues'),
('Lee Jung Mook','Our Blues'),
('Han Jin Sun','Partners for Justice Season 2'),
('Noh Do Cheol','Partners for Justice Season 2'),
('Shin Won Ho','Prison Playbook'),
('Jang Young Woo','Queen of Tears'),
('Kim Hee Won','Queen of Tears'),
('Jo Young Kwang','Racket Boys'),
('Shin Won Ho','Reply 1988'),
('Yoo Hak Chan','Reply 1988'),
('Kim Jae Hong','Revenant'),
('Lee Jung Rim','Revenant'),
('Kim Won Suk','Signal'),
('Shin Kyung Soo','Six Flying Dragons'),
('Jo Hyun Taek','SKY Castle'),
('unknown','SKZ Flix'),
('Ahn Gil Ho','Stranger'),
('Lee Chang Hee','Strangers from Hell'),
('Lee Hyung Min','Strong Woman Do Bong Soon'),
('Lee Eung Bok','Sweet Home'),
('Jo Nam Hyung','Tale of the Nine-Tailed 1938'),
('Kang Shin Hyo','Tale of the Nine-Tailed 1938'),
('Park Joon Woo','Taxi Driver'),
('Lee Dan','Taxi Driver Season 2'),
('Choi Jung Gyu','The Devil Judge'),
('Lee Myung Woo','The Fiery Priest'),
('Shin Kyung Soo','The First Responders'),
('Ahn Gil Ho','The Glory'),
('Ahn Gil Ho','The Glory Part 2'),
('Shim Na Yeon','The Good Bad Mother'),
('Kim Hong Seon','The Guest'),
('Park Yoo Young','The Kidnapping Day'),
('Kim Dae Jin','The King of Pigs'),
('Joo Dong Min','The Penthouse Season 2: War in Life'),
('Joo Dong Min','The Penthouse: War in Life'),
('Jung Ji In','The Red Sleeve'),
('Song Yeon Hwa','The Red Sleeve'),
('unknown','The Uncanny Counter'),
('Han Dong Wook','The Worst of Evil'),
('Park Geun Beom','The Worst of Evil'),
('Kim Jae Hong','Through the Darkness'),
('Park Bo Ram','Through the Darkness'),
('Kim Tae Yoon','Tomorrow'),
('Sung Chi Wook','Tomorrow'),
('Nam Ki Hoon','Tunnel'),
('Shin Yong Hwi','Tunnel'),
('Jung Ji Hyun','Twenty-Five Twenty-One'),
('Kim Seung Ho','Twenty-Five Twenty-One'),
('Son Jung Hyun','Twinkling Watermelon'),
('Kim Hyung Shik','Under the Queen\'s Umbrella'),
('Kim Hee Won','Vincenzo'),
('Park Dhan Hee','Weak Hero Class 1'),
('Nam Sung Woo','Weightlifting Fairy Kim Bok Joo'),
('Oh Hyun Jong','Weightlifting Fairy Kim Bok Joo'),
('Oh Choong Hwan','While You Were Sleeping'),
('Park Soo Jin','While You Were Sleeping'),
('Lee Dae Kyung','Youth of May'),
('Song Min Yeop','Youth of May');
/*!40000 ALTER TABLE `directed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `director`
--

DROP TABLE IF EXISTS `director`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `director` (
  `director_name` varchar(255) NOT NULL,
  `signature_genre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`director_name`),
  CONSTRAINT `director_ibfk_1` FOREIGN KEY (`director_name`) REFERENCES `crew` (`name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `director`
--

LOCK TABLES `director` WRITE;
/*!40000 ALTER TABLE `director` DISABLE KEYS */;
INSERT INTO `director` VALUES
('Ahn Gil Ho',NULL),
('Bae Hyun Jin',NULL),
('Baek Sang Hoon',NULL),
('Choi Joon Bae',NULL),
('Choi Jung Gyu',NULL),
('Ha Byung Hoon',NULL),
('Han Dong Hwa',NULL),
('Han Dong Wook',NULL),
('Han Jin Sun',NULL),
('Hong Jong Chan',NULL),
('Jang Young Woo',NULL),
('Jo Hyun Taek',NULL),
('Jo Nam Hyung',NULL),
('Jo Young Kwang',NULL),
('Joo Dong Min',NULL),
('Jung Dong Yoon',NULL),
('Jung Ji Hyun',NULL),
('Jung Ji In',NULL),
('Kang Cheol Woo',NULL),
('Kang Shin Hyo',NULL),
('Kim Chul Gyu',NULL),
('Kim Dae Jin',NULL),
('Kim Hee Won',NULL),
('Kim Hong Seon',NULL),
('Kim Hyung Shik',NULL),
('Kim Jae Hong',NULL),
('Kim Jin Man',NULL),
('Kim Jin Min',NULL),
('Kim Jin Woo',NULL),
('Kim Kyu Tae',NULL),
('Kim Kyun Ah',NULL),
('Kim Sang Woo',NULL),
('Kim Seung Ho',NULL),
('Kim Sung Ho',NULL),
('Kim Sung Hoon',NULL),
('Kim Sung Yong',NULL),
('Kim Tae Yoon',NULL),
('Kim Tae Yub',NULL),
('Kim Won Suk',NULL),
('Kim Yoon Jin',NULL),
('Lee Byung Hoon',NULL),
('Lee Chang Hee',NULL),
('Lee Dae Kyung',NULL),
('Lee Dan',NULL),
('Lee Eung Bok',NULL),
('Lee Gil Bok',NULL),
('Lee Han Joon',NULL),
('Lee Hyung Min',NULL),
('Lee Jae Gyoo',NULL),
('Lee Jeong Hyo',NULL),
('Lee Jung Mook',NULL),
('Lee Jung Rim',NULL),
('Lee Jung Sub',NULL),
('Lee Myung Woo',NULL),
('Lee Ye Rim',NULL),
('Min Yeon Hong',NULL),
('Nam Ki Hoon',NULL),
('Nam Sung Woo',NULL),
('Noh Do Cheol',NULL),
('Oh Choong Hwan',NULL),
('Oh Hyun Jong',NULL),
('Park Bo Ram',NULL),
('Park Dhan Hee',NULL),
('Park Geun Beom',NULL),
('Park In Je',NULL),
('Park Joon Hwa',NULL),
('Park Joon Woo',NULL),
('Park Seon Ho',NULL),
('Park Shin Woo',NULL),
('Park Soo Jin',NULL),
('Park Yoo Young',NULL),
('Shim Na Yeon',NULL),
('Shin Kyung Soo',NULL),
('Shin Won Ho',NULL),
('Shin Yong Hwi',NULL),
('Son Jung Hyun',NULL),
('Song Min Yeop',NULL),
('Song Yeon Hwa',NULL),
('Sung Chi Wook',NULL),
('unknown',NULL),
('Yoo Hak Chan',NULL),
('Yoo In Shik',NULL),
('Yoo Je Won',NULL),
('Yoon Hyun Gi',NULL),
('Yoon Jong Ho',NULL),
('Yoon Sung Shik',NULL);
/*!40000 ALTER TABLE `director` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drama`
--

DROP TABLE IF EXISTS `drama`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drama` (
  `drama_name` varchar(255) NOT NULL,
  `year` int DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `episodes` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `watchers` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`drama_name`),
  CONSTRAINT `drama_chk_1` CHECK ((`rating` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drama`
--

LOCK TABLES `drama` WRITE;
/*!40000 ALTER TABLE `drama` DISABLE KEYS */;
INSERT INTO `drama` VALUES
('18 Again',2020,8.6,'Jung Da Jung and Hong Dae Young have been married for almost two decades, raising their twins together. Despite appearances, their life is far from ideal, filled with Dae Young\'s incessant nonsense. When he gets fired…',16,70,76913,'2020-09-21','2020-11-10'),
('A Shop for Killers',2024,8.8,'Shortly after entering college, Jian receives a call from local police informing her of her uncle’s “suicide”. Her caretaker, since the death of her parents, uncle Jeong Jin Man, had always been quiet and mysterious…',8,51,35262,'2024-01-17','2024-02-07'),
('Alchemy of Souls',2022,9.1,'Set in a fictional country called Daeho that does not exist in history or on maps, it is about the love and growth of young mages as they overcome their twisted fates due to a forbidden magic spell known as the \"alchemy…',20,80,110118,'2022-06-18','2022-08-28'),
('Alchemy of Souls Season 2: Light and Shadow',2022,8.9,'Jang Uk returns from death, and three years later, the story of the mages unfolds anew. Jang Uk becomes a hunter of the soul-shifters when a young woman, a prisoner in her own home, seeks his help to reclaim her freedom.…',10,81,66649,'2022-12-10','2023-01-08'),
('Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land',2019,8.7,'Ta Gon has now become the most powerful man in Arthdal. He has an affectionate relationship only with Taealha, the daughter of the rival Hae Tribe, because of their shared ambitions. Sa Ya has been kept confined in a…',6,81,27364,'2019-06-22','2019-07-07'),
('Arthdal Chronicles Part 3: The Prelude to All Legends',2019,8.7,'Ta Gon gets what he wants as he sits atop his throne. However, now his life and throne are threatened when Eun Seom begins to gather power among the slaves and peasants of Arth as he starts to fight back against the…',6,80,24562,'2019-09-07','2019-09-22'),
('Begins Youth',2024,8.7,'The drama follows the lives of seven boys navigating their school years and personal growth, each grappling with family obligations, loss, poverty, abandonment, violence, and rejection. After an unwanted return to Songju-si,…',12,68,10820,'2024-04-30','2024-05-14'),
('Beyond Evil',2021,8.7,'Meet the two fearless men willing to go to extreme lengths in their pursuit of a serial killer that has shaken up their quiet city: Lee Dong Sik, a once capable detective, is now demoted to perform menial tasks at the…',16,65,58323,'2021-02-19','2021-04-10'),
('Bloodhounds',2023,8.6,'When reserved rookie boxer Kim Geon Woo squares off against loquacious southpaw Hong Woo Jin, Geon Woo narrowly prevails — but the two former marines become fast friends. As their friendship grows, so do the financial…',8,60,46832,'2023-06-09','2023-06-09'),
('Business Proposal',2022,8.7,'Shin Ha Ri is a single woman who works for a company. She has a male friend, who she has had a crush on for a long time, but she learns he has a girlfriend. Shin Ha Ri feels sad and decides to meet her friend Jin Young…',12,60,158710,'2022-02-28','2022-04-05'),
('Chicago Typewriter',2017,8.6,'This drama follows the lives of two men and a woman through two eras: one during the 1930s Japanese occupation of Korea and the other in the 21st century. The three main characters are: (1) Han Se Joo was a writer in…',16,70,64392,'2017-04-07','2017-06-03'),
('Crash Landing on You',2019,9,'After getting into a paragliding accident, South Korean heiress Yoon Se Ri crash lands in North Korea. There, she meets North Korean army officer Ri Jung Hyuk, who agrees to help her return to South Korea. Despite the…',16,85,193070,'2019-12-14','2020-02-16'),
('D.P.',2021,8.8,'Private soldier Jun Ho is a confused youth who served in the military normally like other Koreans. One day, he suddenly becomes a member of the military defector arrest team. As such, he is tasked with capturing deserters…',6,50,60297,'2021-08-27','2021-08-27'),
('D.P. Season 2',2023,8.7,'This unfolding story ensues when military desertion arrest squad members (DP), Jun Ho and Ho Yeol, run across absurdities and unchangeable reality on a regular basis. (Source: Namuwiki; Edited by Krystale Mitaesa at…',6,50,25444,'2023-07-28','2023-07-28'),
('Daily Dose of Sunshine',2023,8.8,'Jung Da Eun works as a nurse. She is transferred to neuropsychiatry from the internal medicine department. This is her first time working in neuropsychiatry, so everything is difficult and awkward for her. Nevertheless,…',12,70,38380,'2023-11-03','2023-11-03'),
('Dear My Friends',2016,8.7,'Park Wan is a translator who is constantly pulled by her mother, Jang Nan Hee, to hang out with her elder friends, Jo Hee Ja, Moon Jung Ah, Oh Choong Nam, and Lee Yeong Won. The plot revolves around the friends\' twilight…',16,70,14160,'2016-05-13','2016-07-02'),
('Death\'s Game',2023,8.9,'After struggling for seven years without securing a stable job, Choi Yi Jae becomes engulfed in despair and hopelessness. Believing that ending his life would be the solution, Yi Jae is met with a surprise when he meets…',4,55,57332,'2023-12-15','2023-12-15'),
('Death\'s Game Part 2',2024,8.9,'After learning what Death meant when they said his death would become more painful, Choi Yi Jae becomes hellbent on revenge. (Source: MyDramaList) ~~ Adapted from the webtoon \"Ije God Jukseubnida\" (이제 곧 죽습니다)…',4,55,34088,'2024-01-05','2024-01-05'),
('Defendant',2017,8.7,'Park Jung Woo is a prosecutor at Seoul Central District Prosecutors’ Office. One day, he wakes up and finds himself a convict on death row. Suffering from temporary amnesia, Jung Woo has no idea what transpired to…',18,70,31909,'2017-01-23','2017-03-21'),
('Descendants of the Sun',2016,8.6,'A love story that develops between a surgeon and a special forces officer. Kang Mo Yeon is a pretty and assertive woman who works as a cardiothoracic surgeon at Haesung Hospital. She isn\'t afraid to admit her mistakes…',16,60,200438,'2016-02-24','2016-04-14'),
('Dr. Romantic',2016,8.7,'Kim Sa Bu was once a famous surgeon at the peak of his career at a major hospital. But he suddenly gives it all up one day to live in seclusion and work as a neighborhood doctor in a small town. He now goes by “Teacher…',20,60,71877,'2016-11-07','2017-01-16'),
('Dr. Romantic Season 2',2020,8.7,'A “real doctor” story set in a small, humble hospital called Doldam Hospital. It is a story about people who meet Kim Sa Bu, a genius doctor, and discover “real romance.” Kim Sa Bu once gained fame as a top surgeon…',16,70,58173,'2020-01-06','2020-02-25'),
('Dr. Romantic Season 3',2023,8.9,'At Doldam Hospital, Dr. Kim Sa Bu and his team are committed to saving lives. After three years, a state-of-the-art trauma centre is set to open, equipped with the latest in medical technology. Prior to the centre\'s…',16,70,29630,'2023-04-28','2023-06-17'),
('Extraordinary Attorney Woo',2022,8.9,'Diagnosed with autism spectrum disorder, 27-year-old Woo Young Woo graduated at the top of her class from the prestigious Seoul National University for both college and law school due to her high IQ of 164, impressive…',16,70,118138,'2022-06-29','2022-08-18'),
('Flex X Cop',2024,8.7,'Jin Yi Soo has everything in life. Being a third-generation conglomerate, he never requires others’ assistance. However, things start changing when he gets entangled in a case. Jin Yi Soo joins the violent investigative…',16,70,25372,'2024-01-26','2024-03-23'),
('Flower of Evil',2020,9.1,'Although Baek Hee Sung is hiding a dark secret surrounding his true identity, he has established a happy family life and a successful career. He is a loving husband and doting father to his young daughter. But his perfect…',16,70,137077,'2020-07-29','2020-09-23'),
('Goblin',2016,8.8,'Kim Shin was once an unbeatable general in Goryeo\'s military who died a tragic death. He now possesses immortality but is tired of living while everyone else around him dies. For 900 years, Kim Shin has searched for…',16,82,239139,'2016-12-02','2017-01-21'),
('Happiness',2021,8.9,'Yoon Sae Bom is a special agent with quick wits and reflexes and another special quality. She earns the opportunity to move into a new apartment set aside for civil servants in a coveted apartment complex by pretending…',12,65,87652,'2021-11-05','2021-12-11'),
('Healer',2014,8.8,'Seo Jung Hoo is a special kind of night courier, known only as \"Healer\" by his clients. For the right price and with the help of a genius hacker, he gets his clients whatever they want, as long as it doesn\'t involve…',20,60,149333,'2014-12-08','2015-02-10'),
('Hometown Cha-Cha-Cha',2021,8.7,'After a conflict with her boss, dentist Yoon Hye Jin escapes the city to a seaside village where she\'d vacationed to before as a little girl. When she learns the village is without a dentist, she decides to set up her…',16,80,119600,'2021-08-28','2021-10-17'),
('Hospital Playlist',2020,9.1,'The stories of people going through their days are seemingly ordinary but actually special at the hospital, a place known as the microcosm of life, where someone is being born and someone\'s life meets its ending. The…',12,90,108944,'2020-03-12','2020-05-28'),
('Hospital Playlist Season 2',2021,9.1,'Everyday is extraordinary for five doctors and their patients inside a hospital, where birth, death and everything in between coexist.\n\n(Source: Netflix)',12,100,67878,'2021-06-17','2021-09-16'),
('Hot Stove League',2019,8.6,'About the preparation period of a major league baseball team. The drama focuses on a loser team that prepares for an extraordinary season upon the arrival of their new general manager, and each episode will focus on…',16,62,27200,'2019-12-13','2020-02-14'),
('Hotel del Luna',2019,8.6,'Nestled deep in the heart of Seoul’s thriving downtown sits a curious hotel, the like of which no one has ever seen before. Old beyond measure, the building has stood for millennia, an ever-present testament to the…',16,80,171828,'2019-07-13','2019-09-01'),
('It\'s Okay to Not Be Okay',2020,8.9,'Moon Gang Tae is a community health worker at a psychiatric ward who was blessed with everything including a great body, smarts, ability to sympathize with others, patience, ability to react quickly, stamina, and more.…',16,75,199570,'2020-06-20','2020-08-09'),
('Jewel in the Palace',2003,8.7,'About 500 years ago during the time of Chosun Dynasty, Korea boasted a rigidly hierarchical and male dominated social structure. Based on a true story about a legendary girl, Jang Geum, who became the first woman to…',54,65,19177,'2003-09-15','2004-03-23'),
('Kill Me, Heal Me',2015,8.7,'A traumatic childhood experience leaves Cha Do Hyeon, suffering from memory loss and dissociation. The latter has resulted in the creation of seven distinct personalities. Wanting to regain control over his life, he…',20,62,114176,'2015-01-07','2015-03-12'),
('Kingdom',2019,8.8,'No sooner does the Joseon King succumb to smallpox, do the rumors of his death begin. The Cho Clan, the clan of the pregnant Queen and her father, Chief State Councillor Cho Hak Joo, declares the Crown Prince, a traitor.…',6,51,73134,'2019-01-25','2019-01-25'),
('Kingdom Season 2',2020,8.9,'Following the events in season one, waves of the undead threaten to reach the capital. In an attempt to save the people during the plague and regain his right to the throne, Crown Prince Lee Chang pursues Jo Hak Joo…',6,45,45638,'2020-03-13','2020-03-13'),
('Life on Mars',2018,8.7,'As the leader of a crime investigation team, Han Tae Joo has propelled his career and risen through the ranks by trusting data over all else. One day, while investigating a serial murder case, he has an accident. When…',16,65,30733,'2018-06-09','2018-08-05'),
('Love for Love\'s Sake',2024,8.8,'Twenty-nine-year-old Tae Myung Ha experiences a bewildering twist of fate when suddenly finds himself transported into a fictional online game where he inhabits the body of a nineteen-year-old character. Soon, Tae Myung…',8,34,25408,'2024-01-24','2024-02-01'),
('Lovely Runner',2024,9.1,'In the glitzy realm of stardom, Ryu Seon Jae shines as a top-tier celebrity, captivating the spotlight since his debut. Despite the facade of a perfect life, the demanding nature of the entertainment industry has left…',16,70,64353,'2024-04-08','2024-05-28'),
('Misaeng: Incomplete Life',2014,8.6,'Jang Geu Rae has played the game of Go since he was a child. When his plans of becoming a professional Go player fail, the down-and-out Geu Rae is forced to take an office job as an intern set up for him by an acquaintance’s…',20,80,33834,'2014-10-17','2014-12-20'),
('Missing: The Other Side Season 2',2022,8.8,'3 Gongdan is a village where missing deceased people, including Kang Eun Sil and Oh Il Yong, stay. Meanwhile, Kim Wook, Jang Pan Seok, Lee Jong A, and Detective Shin Joon Ho try to find the bodies of the missing people…',14,60,10279,'2022-12-19','2023-01-31'),
('Moon Lovers: Scarlet Heart Ryeo',2016,8.7,'When a total eclipse of the sun takes place, Go Ha Jin is transported back in time to the start of the Goryeo Dynasty of Korea during King Taejo\'s rule. She wakes up in the body of the 16-year-old Hae Soo and finds herself…',20,60,148208,'2016-08-29','2016-11-01'),
('Mother',2018,9,'Realizing one of her students is being abused, school teacher and bird researcher Soo Jin impulsively kidnaps the girl and acts as a substitute mother in an attempt to take care of her.\n\n(Source: MyDramaList)',16,63,35470,'2018-01-24','2018-03-15'),
('Mouse',2021,8.8,'A suspenseful story that asks the key question, “What if we could identify psychopaths in advance?” A crazed serial killer’s ruthless murders have left the entire nation gripped with fear, and chaos reigns. Justice-seeking…',20,75,65557,'2021-03-03','2021-05-19'),
('Move to Heaven',2021,9.1,'Han Geu Roo is an autistic 20-year-old. He works for his father’s business “Move To Heaven,” a company that specializes in crime scene cleanup, where they also collect and arrange items left by deceased people,…',10,52,99429,'2021-05-14','2021-05-14'),
('Moving',2023,9.1,'Kim Bong Seok, Jang Hee Soo, and Lee Gang Hoon, seemingly typical high school students, bear extraordinary inherited powers. Bong Seok can fly, Hee Soo possesses exceptional athleticism and rapid injury recovery, and…',20,47,62593,'2023-08-09','2023-09-20'),
('Mr. Queen',2020,9,'Jang Bong Hwan is a South Korean chef who has risen up the ranks to cook for the country’s top politicians in the Blue House’s presidential residences. After a serious accident, he finds himself in the body of the…',20,75,94913,'2020-12-12','2021-02-14'),
('Mr. Sunshine',2018,8.9,'Mr. Sunshine centers on a young boy born into a house servant\'s family who travels to the United States during the 1871 Shinmiyangyo (U.S. expedition to Korea). He returns to his homeland later as a U.S. marine officer.…',24,80,76456,'2018-07-07','2018-09-30'),
('My Dearest',2023,8.9,'A love-story between a noblewoman and a mysterious man who shows up in her hometown set in the 1600s during the Qing invasion. Yu Gil Chae is a pretty, bubbly, and a bit spoiled young lady who\'s called the 99 tailed…',10,80,24809,'2023-08-04','2023-09-02'),
('My Dearest Part 2',2023,8.9,'Jang Hyun is living without purpose or desire. He\'s a cold-hearted man who loves no one until he gets introduced to love after meeting Gil Chae. She is charming and admired by all, but her first love, Yeon Jun, is already…',11,71,13048,'2023-10-13','2023-11-18'),
('My Mister',2018,9,'Park Dong Hoon is a middle-aged engineer who is married to attorney Kang Yoon Hee. However, his life is not that happy as he has two unemployed brothers, Sang Hoon and Gi Hoon, who rely on him. Moreover, his wife is…',16,77,79045,'2018-03-21','2018-05-17'),
('My Name',2021,8.7,'Following her father\'s murder, a revenge-driven woman puts her trust in a powerful crime boss — and enters the police force under his direction. Yoon Ji Woo, a member of a organized crime ring, goes undercover as a…',8,50,98686,'2021-10-15','2021-10-15'),
('Navillera',2021,8.9,'A 70-year-old with a dream and a 23-year-old with a gift lift each other out of harsh realities and rise to the challenge of becoming ballerinos. Shim Deok Chul has had a life long dreaming of performing ballet. He is…',12,65,47517,'2021-03-22','2021-04-27'),
('Our Beloved Summer',2021,8.7,'Years after filming a viral documentary in high school, two bickering ex-lovers get pulled back in front of the camera — and into each other\'s lives. Choi Woong seems naive and a free-spirited man, but he wants to…',16,60,96803,'2021-12-06','2022-01-25'),
('Our Blues',2022,8.6,'\"Our Blues\" takes on an omnibus-style drama, which tells the story of diverse characters that are somewhat interconnected, in one way or the other. Lee Dong Suk, a guy born on the beautiful island of Jeju, selling goods…',20,70,41878,'2022-04-09','2022-06-12'),
('Partners for Justice Season 2',2019,8.7,'In crime and in life, all contact leaves a trace. There is no perfect crime and our hero and heroine have the ultimate cooperation. This drama continues the tale of a forensic scientist and a prosecutor who make the…',32,35,11618,'2019-06-03','2019-07-29'),
('Prison Playbook',2017,9,'Kim Je Hyuk, a famous baseball player, is arrested after using excessive force while chasing a man trying to sexually assault his sister. Shockingly to him and the rest of the nation, he is sentenced to a year in prison.…',16,92,80899,'2017-11-22','2018-01-18'),
('Queen of Tears',2024,8.8,'Baek Hyun Woo, who is the pride of the village of Yongduri, is the legal director of the conglomerate Queens Group, while chaebol heiress Hong Hae In is the “queen” of Queens Group’s department stores. “Queen…',16,88,70271,'2024-03-09','2024-04-28'),
('Racket Boys',2021,8.7,'A story of a boys\' badminton team at a middle school in Haenam as they grow, both as people and as players. Yoon Hyun Jong was once a very good badminton player, but now he struggles to make ends meet for his family.…',16,75,30999,'2021-05-31','2021-08-09'),
('Reply 1988',2015,9.1,'Five childhood friends, who all live in the same Ssangmundong neighborhood of Seoul, lean on each other to survive their challenging teen years and set a path for their futures. Sung Deok Sun struggles for attention…',20,95,113030,'2015-11-06','2016-01-16'),
('Revenant',2023,8.7,'When the door to another world opens, demons exist there. Ku San Young is possessed by one of those demons. Yeom Hae Sang can see the demon which has possessed Ku San Young. They try to figure out the truth behind the…',12,70,31018,'2023-06-23','2023-07-29'),
('Signal',2016,8.9,'Fifteen years ago, a young girl was kidnapped on the way from school, and Park Hae Yeong, who was an elementary school student at that time, witnessed the crime. A few days later, the girl was found dead, and the police…',16,75,83068,'2016-01-22','2016-03-12'),
('Six Flying Dragons',2015,8.7,'A fictional, historical drama about the ambition, rise and fall of real and fictional characters based around Yi Bang Won. Yi Bang Won was the third king of the Joseon Dynasty in Korea and the father of King Se Jong…',50,60,24966,'2015-10-05','2016-03-22'),
('SKY Castle',2018,8.8,'Han Seo Jin, Noh Seung Hye, Jin Jin Hee, and Lee Myung Joo all live with their families in SKY Castle, a luxury private neighborhood hosting wealthy doctors and professors. All of the women wish for their children to…',20,75,72499,'2018-11-23','2019-02-01'),
('SKZ Flix',2023,8.8,'It is a continuation of the On Track Universe storyline started in 2020, as it portrays the return of the film club project, and it is tied to the release of the eighth mini album ROCK-STAR and its song \"Leave\". SKZFLIX…',1,11,1812,'2023-11-03','2023-11-03'),
('Stranger',2017,8.8,'Hwang Shi Mok underwent brain surgery as a child to curb his violent temper, which left him devoid of emotions. Hwang becomes a prosecutor known for his piercing intelligence and logic, but he is ostracized because he…',16,70,58669,'2017-06-10','2017-07-30'),
('Strangers from Hell',2019,8.6,'Yoon Jong Woo is a young guy in his 20s who moves from the countryside to Seoul after his college friend, Jae Ho, offers him a job. While looking for a place to live, he stumbles upon Eden Gosiwon, a cheap hostel that…',10,60,73120,'2019-08-31','2019-10-06'),
('Strong Woman Do Bong Soon',2017,8.7,'Do Bong Soon is a petite, unemployed woman who is honest and kind. She appears little and sweet on the outside, but she is in fact very, very strong. For generations in her family, the women have been gifted Herculean…',16,67,225144,'2017-02-24','2017-04-15'),
('Sweet Home',2020,8.7,'Following the death of his family in an accident, loner Cha Hyun Soo moves to a new apartment. His quiet life is soon disturbed by strange incidents that start occurring in his apartment, and throughout Korea. As people…',10,52,108636,'2020-12-18','2020-12-18'),
('Tale of the Nine-Tailed 1938',2023,8.8,'An unexpected case leads Lee Yeon back in time to 1938, where he reencounters Ryu Hong Joo. Once a guardian spirit of the mountain in the west, she\'s now the owner of a high-end restaurant in the capital city of Gyeongseong.…',12,70,37700,'2023-05-06','2023-06-11'),
('Taxi Driver',2021,8.8,'Do Gi has lived more honestly than anyone else as an officer in the Special Forces. Yet, when a serial killer murders his mother, he spends his days in agony. While feeling wronged and broken, Do Gi meets Jang Sung Chul,…',16,65,67729,'2021-04-09','2021-05-29'),
('Taxi Driver Season 2',2023,8.9,'Despite disbanding after Do Gi\'s successful revenge, the Rainbow Deluxe Taxi crew, including Seong Cheol, Go Eun, Gyeong Gu, and Jin Eon, can\'t resist the call to reunite with their former leader. Though each attempts…',16,70,29452,'2023-02-17','2023-04-15'),
('The Devil Judge',2021,8.7,'Set in a dystopian version of present-day Korea where daily life is chaos and society has collapsed to the point that people openly voice their distrust and hatred for their leaders. In this world bereft of law and order,…',16,75,61083,'2021-07-03','2021-08-22'),
('The Fiery Priest',2019,8.6,'Kim Hae Il is a Catholic priest. He makes spiteful remarks, and he can be rude to others. Koo Dae Young is a detective. He talks a lot, and he is also timid. Park Kyung Sun is a prosecutor. She is smart and beautiful.…',40,35,33506,'2019-02-15','2019-04-20'),
('The First Responders',2022,8.7,'Follow the joint operations of a police force and a fire department, who together will tell a thrilling story. Fierce detective Jin Ho Gae is all about catching low-lifes. He solves cases with his excellent ability to…',12,66,21648,'2022-11-12','2022-12-30'),
('The Glory',2022,8.9,'A high school student dreams of becoming an architect. However, she had to drop out of school after suffering from brutal school violence. Years later, the perpetrator gets married and has a kid. Once the kid is in elementary…',8,50,100524,'2022-12-30','2022-12-30'),
('The Glory Part 2',2023,9,'Moon Dong Eun\'s silent fury against those students that horrifically abused her during her high school years continues to burn inside of her. She meticulously executes her plan to inflict ultimate pain on her tormentors.…',8,55,73749,'2023-03-10','2023-03-10'),
('The Good Bad Mother',2023,8.9,'Young Soon is a single mother and pig farmer who raised her son Kang Ho alone. Despite her love for him, her strict parenting caused Kang Ho to view her as a bad mother. As an adult, Kang Ho became a cold-hearted prosecutor…',14,70,52907,'2023-04-26','2023-06-08'),
('The Guest',2018,8.7,'Yoon Hwa Pyung, a young psychic born into a shaman family, learns about the powerful demon called \"Son\" (Guest). The demon has the power to control other demons and allows them to possess weak people. The possessed people…',16,67,38147,'2018-09-12','2018-11-01'),
('The Kidnapping Day',2023,8.6,'Kim Myung Joon is a poor man with a warm heart. He desperately needs money to pay for his sick daughter\'s operation. His ex-wife suggests he kidnap a child with rich parents. Kim Myung Joon is desperate enough to accept…',12,59,10676,'2023-09-13','2023-10-25'),
('The King of Pigs',2022,8.7,'Two friends meet up and recall their experiences as victims of school bullying when they receive a message from a friend from 20 years ago and mysterious serial killings begin to occur. Kyung Min lives with the trauma…',12,55,17219,'2022-03-18','2022-04-22'),
('The Penthouse Season 2: War in Life',2021,8.7,'After successfully framing Oh Yoon Hee, Cheon Seo Jin and Joo Dan Tae decide to get married. Their engagement party is interrupted by Oh Yoon Hee and Ha Yoon Cheol, who has just come back from the United States. As the…',13,75,40093,'2021-02-19','2021-04-02'),
('The Penthouse: War in Life',2020,8.7,'The residents of Hera Palace, a luxury penthouse apartment with 100 floors, have many secrets and hidden ambitions. Sim Su Ryeon, who was born into wealth, is the queen of the penthouse apartment. Cheon Seo Jin, the…',21,85,61136,'2020-10-26','2021-01-05'),
('The Red Sleeve',2021,8.8,'In 18th-century Korea, Prince Yi San is a perfectionist haunted by his father\'s murder. He\'s set to inherit the throne once his cruel grandfather, the current king, passes away. Despite the emotional scars left by his…',17,80,44638,'2021-11-12','2022-01-01'),
('The Uncanny Counter',2020,8.8,'It tells the story of demon hunters called Counters who come to earth under the guise of being employees at a noodle restaurant in order to capture evil spirits that have returned to earth in pursuit of eternal life.…',16,70,99614,'2020-11-28','2021-01-24'),
('The Worst of Evil',2023,8.6,'Set in Seoul in the 1990s, a former DJ starts selling a new powerful drug nicknamed \"Gangnam Crystal\" in city nightclubs after mastering a gangster organization. Since the police know little about the origin of such…',12,53,33735,'2023-09-27','2023-10-25'),
('Through the Darkness',2022,8.7,'Back in the 1990s, the citizens of Seoul were gripped with a paralyzing fear after a series of brutal attacks and murders occurred. A mysterious figure dubbed ‘Red Cap’ was stalking women on the streets then killing…',12,70,21786,'2022-01-14','2022-03-12'),
('Tomorrow',2022,8.8,'Choi Joon Woong seeks a job, but it\'s hard for him to get hired. One night, he witnesses a man trying to end his life and decides to stop him. He gets acquainted with grim reapers Koo Ryeon and Im Ryoong Gu, who belong…',16,60,89889,'2022-04-01','2022-05-21'),
('Tunnel',2017,8.6,'In 1986, Park Gwang Ho works as an excellent and enthusiastic detective. His life changes when he’s pursuing leads in a serial homicide case and then passes through a time portal, which transports him to present day…',16,64,43859,'2017-03-25','2017-05-21'),
('Twenty-Five Twenty-One',2022,8.8,'In a time when dreams seem out of reach, a teen fencer pursues big ambitions and meets a hardworking young man who seeks to rebuild his life. Na Hee Do is a member of her high school fencing team. Due to the South Korean…',16,75,100817,'2022-02-12','2022-04-03'),
('Twinkling Watermelon',2023,9.2,'In 2023, Eun Gyeol is a CODA (Child of Deaf Adults) high-school student, but he has a passion for music. During the day, he is a studious model pupil, but at night, he rocks out as a guitarist in a band. But when he…',16,70,76448,'2023-09-25','2023-11-14'),
('Under the Queen\'s Umbrella',2022,9,'Within the palace exist troublemaking princes who cause nothing but headaches for the royal family and are about to be turned into proper crown princes. Their mother, Im Hwa Ryeong, is the wife of a great king. But…',16,70,35299,'2022-10-15','2022-12-04'),
('Vincenzo',2021,8.9,'At the age of eight, Park Joo Hyeong left for Italy after being adopted. Now an adult, he is known as Vincenzo Cassano and employed by a Mafia family as a consigliere. Due to warring Mafia factions, he flies to South…',20,85,156936,'2021-02-20','2021-05-02'),
('Weak Hero Class 1',2022,9.1,'Yeon Shi Eun is a model student who ranks at the top of his high school. Physically, Yeon Shi Eun appears weak, but by using his wits and psychology, he fights against the violence that takes place inside and outside…',8,40,85641,'2022-11-18','2022-11-18'),
('Weightlifting Fairy Kim Bok Joo',2016,8.8,'Bok Joo is a weightlifter who is pursuing her dream of winning the gold medal but she then finds romance for the first time in her life. While she is a woman who trains with heavy steel weights, she is also very feminine…',16,60,200405,'2016-11-16','2017-01-11'),
('While You Were Sleeping',2017,8.7,'Nam Hong Ju, endowed with the ability to foresee events, resides with her widowed mother who runs a small restaurant. Despite her gift, she often finds herself powerless to change the outcomes. On the other side of the…',32,30,166858,'2017-09-27','2017-11-16'),
('Youth of May',2021,8.7,'Hee Tae becomes the pride of Gwangju when he enters Seoul National University College of Medicine with top marks. His best friend Kyung Soo, an avid pro-democracy activist, insists that they open an illegal clinic for…',12,70,58863,'2021-05-03','2021-06-08');
/*!40000 ALTER TABLE `drama` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode`
--

DROP TABLE IF EXISTS `episode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `episode` (
  `drama_name` varchar(255) NOT NULL,
  `episode_number` int NOT NULL,
  `rating` float DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`drama_name`,`episode_number`),
  CONSTRAINT `episode_ibfk_1` FOREIGN KEY (`drama_name`) REFERENCES `drama` (`drama_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode`
--

LOCK TABLES `episode` WRITE;
/*!40000 ALTER TABLE `episode` DISABLE KEYS */;
/*!40000 ALTER TABLE `episode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
  `genre_name` varchar(255) NOT NULL,
  `drama_name` varchar(255) NOT NULL,
  PRIMARY KEY (`genre_name`,`drama_name`),
  KEY `drama_name` (`drama_name`),
  CONSTRAINT `genre_ibfk_1` FOREIGN KEY (`drama_name`) REFERENCES `drama` (`drama_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES
('Drama','18 Again'),
('Fantasy','18 Again'),
('Life','18 Again'),
('Romance','18 Again'),
('Action','A Shop for Killers'),
('Drama','A Shop for Killers'),
('Mystery','A Shop for Killers'),
('Thriller','A Shop for Killers'),
('Action','Alchemy of Souls'),
('Fantasy','Alchemy of Souls'),
('Historical','Alchemy of Souls'),
('Romance','Alchemy of Souls'),
('Action','Alchemy of Souls Season 2: Light and Shadow'),
('Fantasy','Alchemy of Souls Season 2: Light and Shadow'),
('Historical','Alchemy of Souls Season 2: Light and Shadow'),
('Romance','Alchemy of Souls Season 2: Light and Shadow'),
('Fantasy','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('Historical','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('Political','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('Romance','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('Fantasy','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('Historical','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('Political','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('Romance','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('Drama','Begins Youth'),
('Fantasy','Begins Youth'),
('Life','Begins Youth'),
('Youth','Begins Youth'),
('Drama','Beyond Evil'),
('Mystery','Beyond Evil'),
('Psychological','Beyond Evil'),
('Thriller','Beyond Evil'),
('Action','Bloodhounds'),
('Crime','Bloodhounds'),
('Drama','Bloodhounds'),
('Thriller','Bloodhounds'),
('Comedy','Business Proposal'),
('Drama','Business Proposal'),
('Romance','Business Proposal'),
('Comedy','Chicago Typewriter'),
('Political','Chicago Typewriter'),
('Romance','Chicago Typewriter'),
('Supernatural','Chicago Typewriter'),
('Comedy','Crash Landing on You'),
('Military','Crash Landing on You'),
('Political','Crash Landing on You'),
('Romance','Crash Landing on You'),
('Action','D.P.'),
('Drama','D.P.'),
('Military','D.P.'),
('Action','D.P. Season 2'),
('Drama','D.P. Season 2'),
('Military','D.P. Season 2'),
('Drama','Daily Dose of Sunshine'),
('Life','Daily Dose of Sunshine'),
('Medical','Daily Dose of Sunshine'),
('Drama','Dear My Friends'),
('Life','Dear My Friends'),
('Melodrama','Dear My Friends'),
('Drama','Death\'s Game'),
('Fantasy','Death\'s Game'),
('Thriller','Death\'s Game'),
('Drama','Death\'s Game Part 2'),
('Fantasy','Death\'s Game Part 2'),
('Thriller','Death\'s Game Part 2'),
('Drama','Defendant'),
('Law','Defendant'),
('Mystery','Defendant'),
('Thriller','Defendant'),
('Action','Descendants of the Sun'),
('Comedy','Descendants of the Sun'),
('Melodrama','Descendants of the Sun'),
('Romance','Descendants of the Sun'),
('Drama','Dr. Romantic'),
('Medical','Dr. Romantic'),
('Romance','Dr. Romantic'),
('Drama','Dr. Romantic Season 2'),
('Medical','Dr. Romantic Season 2'),
('Melodrama','Dr. Romantic Season 2'),
('Romance','Dr. Romantic Season 2'),
('Drama','Dr. Romantic Season 3'),
('Medical','Dr. Romantic Season 3'),
('Romance','Dr. Romantic Season 3'),
('Drama','Extraordinary Attorney Woo'),
('Law','Extraordinary Attorney Woo'),
('Life','Extraordinary Attorney Woo'),
('Romance','Extraordinary Attorney Woo'),
('Action','Flex X Cop'),
('Comedy','Flex X Cop'),
('Mystery','Flex X Cop'),
('Thriller','Flex X Cop'),
('Crime','Flower of Evil'),
('Melodrama','Flower of Evil'),
('Romance','Flower of Evil'),
('Thriller','Flower of Evil'),
('Comedy','Goblin'),
('Fantasy','Goblin'),
('Melodrama','Goblin'),
('Romance','Goblin'),
('Action','Happiness'),
('Drama','Happiness'),
('Sci-Fi','Happiness'),
('Thriller','Happiness'),
('Action','Healer'),
('Mystery','Healer'),
('Romance','Healer'),
('Thriller','Healer'),
('Comedy','Hometown Cha-Cha-Cha'),
('Drama','Hometown Cha-Cha-Cha'),
('Life','Hometown Cha-Cha-Cha'),
('Romance','Hometown Cha-Cha-Cha'),
('Drama','Hospital Playlist'),
('Life','Hospital Playlist'),
('Medical','Hospital Playlist'),
('Romance','Hospital Playlist'),
('Drama','Hospital Playlist Season 2'),
('Life','Hospital Playlist Season 2'),
('Medical','Hospital Playlist Season 2'),
('Romance','Hospital Playlist Season 2'),
('Drama','Hot Stove League'),
('Melodrama','Hot Stove League'),
('Sports','Hot Stove League'),
('Comedy','Hotel del Luna'),
('Fantasy','Hotel del Luna'),
('Horror','Hotel del Luna'),
('Romance','Hotel del Luna'),
('Comedy','It\'s Okay to Not Be Okay'),
('Drama','It\'s Okay to Not Be Okay'),
('Psychological','It\'s Okay to Not Be Okay'),
('Romance','It\'s Okay to Not Be Okay'),
('Food','Jewel in the Palace'),
('Historical','Jewel in the Palace'),
('Medical','Jewel in the Palace'),
('Romance','Jewel in the Palace'),
('Comedy','Kill Me, Heal Me'),
('Drama','Kill Me, Heal Me'),
('Psychological','Kill Me, Heal Me'),
('Romance','Kill Me, Heal Me'),
('Historical','Kingdom'),
('Horror','Kingdom'),
('Political','Kingdom'),
('Thriller','Kingdom'),
('Historical','Kingdom Season 2'),
('Horror','Kingdom Season 2'),
('Supernatural','Kingdom Season 2'),
('Thriller','Kingdom Season 2'),
('Action','Life on Mars'),
('Comedy','Life on Mars'),
('Mystery','Life on Mars'),
('Psychological','Life on Mars'),
('Fantasy','Love for Love\'s Sake'),
('Romance','Love for Love\'s Sake'),
('Youth','Love for Love\'s Sake'),
('Comedy','Lovely Runner'),
('Fantasy','Lovely Runner'),
('Music','Lovely Runner'),
('Romance','Lovely Runner'),
('Business','Misaeng: Incomplete Life'),
('Drama','Misaeng: Incomplete Life'),
('Life','Misaeng: Incomplete Life'),
('Mystery','Missing: The Other Side Season 2'),
('Supernatural','Missing: The Other Side Season 2'),
('Thriller','Missing: The Other Side Season 2'),
('Fantasy','Moon Lovers: Scarlet Heart Ryeo'),
('Historical','Moon Lovers: Scarlet Heart Ryeo'),
('Melodrama','Moon Lovers: Scarlet Heart Ryeo'),
('Romance','Moon Lovers: Scarlet Heart Ryeo'),
('Melodrama','Mother'),
('Mystery','Mother'),
('Psychological','Mother'),
('Thriller','Mother'),
('Mystery','Mouse'),
('Psychological','Mouse'),
('Sci-Fi','Mouse'),
('Thriller','Mouse'),
('Drama','Move to Heaven'),
('Life','Move to Heaven'),
('Action','Moving'),
('Mystery','Moving'),
('Supernatural','Moving'),
('Thriller','Moving'),
('Comedy','Mr. Queen'),
('Fantasy','Mr. Queen'),
('Historical','Mr. Queen'),
('Romance','Mr. Queen'),
('Historical','Mr. Sunshine'),
('Melodrama','Mr. Sunshine'),
('Military','Mr. Sunshine'),
('Romance','Mr. Sunshine'),
('Drama','My Dearest'),
('Historical','My Dearest'),
('Melodrama','My Dearest'),
('Romance','My Dearest'),
('Drama','My Dearest Part 2'),
('Historical','My Dearest Part 2'),
('Melodrama','My Dearest Part 2'),
('Romance','My Dearest Part 2'),
('Drama','My Mister'),
('Life','My Mister'),
('Psychological','My Mister'),
('Action','My Name'),
('Crime','My Name'),
('Mystery','My Name'),
('Thriller','My Name'),
('Drama','Navillera'),
('Life','Navillera'),
('Drama','Our Beloved Summer'),
('Life','Our Beloved Summer'),
('Romance','Our Beloved Summer'),
('Youth','Our Beloved Summer'),
('Drama','Our Blues'),
('Life','Our Blues'),
('Melodrama','Our Blues'),
('Romance','Our Blues'),
('Drama','Partners for Justice Season 2'),
('Law','Partners for Justice Season 2'),
('Medical','Partners for Justice Season 2'),
('Mystery','Partners for Justice Season 2'),
('Comedy','Prison Playbook'),
('Crime','Prison Playbook'),
('Drama','Prison Playbook'),
('Life','Prison Playbook'),
('Comedy','Queen of Tears'),
('Drama','Queen of Tears'),
('Life','Queen of Tears'),
('Romance','Queen of Tears'),
('Comedy','Racket Boys'),
('Drama','Racket Boys'),
('Life','Racket Boys'),
('Sports','Racket Boys'),
('Comedy','Reply 1988'),
('Life','Reply 1988'),
('Romance','Reply 1988'),
('Youth','Reply 1988'),
('Horror','Revenant'),
('Mystery','Revenant'),
('Supernatural','Revenant'),
('Thriller','Revenant'),
('Mystery','Signal'),
('Sci-Fi','Signal'),
('Thriller','Signal'),
('Action','Six Flying Dragons'),
('Drama','Six Flying Dragons'),
('Historical','Six Flying Dragons'),
('Political','Six Flying Dragons'),
('Drama','SKY Castle'),
('Mystery','SKY Castle'),
('Psychological','SKY Castle'),
('Drama','SKZ Flix'),
('Sci-Fi','SKZ Flix'),
('Drama','Stranger'),
('Law','Stranger'),
('Mystery','Stranger'),
('Thriller','Stranger'),
('Drama','Strangers from Hell'),
('Horror','Strangers from Hell'),
('Psychological','Strangers from Hell'),
('Thriller','Strangers from Hell'),
('Action','Strong Woman Do Bong Soon'),
('Comedy','Strong Woman Do Bong Soon'),
('Romance','Strong Woman Do Bong Soon'),
('Supernatural','Strong Woman Do Bong Soon'),
('Action','Sweet Home'),
('Drama','Sweet Home'),
('Horror','Sweet Home'),
('Sci-Fi','Sweet Home'),
('Fantasy','Tale of the Nine-Tailed 1938'),
('Historical','Tale of the Nine-Tailed 1938'),
('Horror','Tale of the Nine-Tailed 1938'),
('Romance','Tale of the Nine-Tailed 1938'),
('Action','Taxi Driver'),
('Crime','Taxi Driver'),
('Drama','Taxi Driver'),
('Thriller','Taxi Driver'),
('Action','Taxi Driver Season 2'),
('Crime','Taxi Driver Season 2'),
('Mystery','Taxi Driver Season 2'),
('Thriller','Taxi Driver Season 2'),
('Crime','The Devil Judge'),
('Drama','The Devil Judge'),
('Law','The Devil Judge'),
('Mystery','The Devil Judge'),
('Action','The Fiery Priest'),
('Comedy','The Fiery Priest'),
('Crime','The Fiery Priest'),
('Mystery','The Fiery Priest'),
('Action','The First Responders'),
('Drama','The First Responders'),
('Mystery','The First Responders'),
('Thriller','The First Responders'),
('Drama','The Glory'),
('Melodrama','The Glory'),
('Thriller','The Glory'),
('Drama','The Glory Part 2'),
('Melodrama','The Glory Part 2'),
('Thriller','The Glory Part 2'),
('Comedy','The Good Bad Mother'),
('Drama','The Good Bad Mother'),
('Family','The Good Bad Mother'),
('Life','The Good Bad Mother'),
('Horror','The Guest'),
('Mystery','The Guest'),
('Supernatural','The Guest'),
('Thriller','The Guest'),
('Comedy','The Kidnapping Day'),
('Drama','The Kidnapping Day'),
('Mystery','The Kidnapping Day'),
('Thriller','The Kidnapping Day'),
('Drama','The King of Pigs'),
('Mystery','The King of Pigs'),
('Thriller','The King of Pigs'),
('Drama','The Penthouse Season 2: War in Life'),
('Mystery','The Penthouse Season 2: War in Life'),
('Thriller','The Penthouse Season 2: War in Life'),
('Drama','The Penthouse: War in Life'),
('Mystery','The Penthouse: War in Life'),
('Thriller','The Penthouse: War in Life'),
('Drama','The Red Sleeve'),
('Historical','The Red Sleeve'),
('Melodrama','The Red Sleeve'),
('Romance','The Red Sleeve'),
('Action','The Uncanny Counter'),
('Drama','The Uncanny Counter'),
('Mystery','The Uncanny Counter'),
('Supernatural','The Uncanny Counter'),
('Action','The Worst of Evil'),
('Crime','The Worst of Evil'),
('Mystery','The Worst of Evil'),
('Thriller','The Worst of Evil'),
('Crime','Through the Darkness'),
('Drama','Through the Darkness'),
('Mystery','Through the Darkness'),
('Thriller','Through the Darkness'),
('Action','Tomorrow'),
('Drama','Tomorrow'),
('Fantasy','Tomorrow'),
('Thriller','Tomorrow'),
('Fantasy','Tunnel'),
('Mystery','Tunnel'),
('Sci-Fi','Tunnel'),
('Thriller','Tunnel'),
('Drama','Twenty-Five Twenty-One'),
('Life','Twenty-Five Twenty-One'),
('Melodrama','Twenty-Five Twenty-One'),
('Romance','Twenty-Five Twenty-One'),
('Drama','Twinkling Watermelon'),
('Fantasy','Twinkling Watermelon'),
('Romance','Twinkling Watermelon'),
('Youth','Twinkling Watermelon'),
('Comedy','Under the Queen\'s Umbrella'),
('Drama','Under the Queen\'s Umbrella'),
('Historical','Under the Queen\'s Umbrella'),
('Political','Under the Queen\'s Umbrella'),
('Comedy','Vincenzo'),
('Crime','Vincenzo'),
('Drama','Vincenzo'),
('Law','Vincenzo'),
('Action','Weak Hero Class 1'),
('Drama','Weak Hero Class 1'),
('Youth','Weak Hero Class 1'),
('Comedy','Weightlifting Fairy Kim Bok Joo'),
('Life','Weightlifting Fairy Kim Bok Joo'),
('Romance','Weightlifting Fairy Kim Bok Joo'),
('Sports','Weightlifting Fairy Kim Bok Joo'),
('Drama','While You Were Sleeping'),
('Mystery','While You Were Sleeping'),
('Romance','While You Were Sleeping'),
('Supernatural','While You Were Sleeping'),
('Drama','Youth of May'),
('Melodrama','Youth of May'),
('Romance','Youth of May'),
('Youth','Youth of May');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network`
--

DROP TABLE IF EXISTS `network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network` (
  `network_name` varchar(255) NOT NULL,
  `drama_name` varchar(255) NOT NULL,
  PRIMARY KEY (`network_name`,`drama_name`),
  KEY `drama_name` (`drama_name`),
  CONSTRAINT `network_ibfk_1` FOREIGN KEY (`drama_name`) REFERENCES `drama` (`drama_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network`
--

LOCK TABLES `network` WRITE;
/*!40000 ALTER TABLE `network` DISABLE KEYS */;
INSERT INTO `network` VALUES
('jTBC','18 Again'),
('Disney+','A Shop for Killers'),
('Hulu','A Shop for Killers'),
('Netflix','Alchemy of Souls'),
('tvN','Alchemy of Souls'),
('Netflix','Alchemy of Souls Season 2: Light and Shadow'),
('tvN','Alchemy of Souls Season 2: Light and Shadow'),
('Netflix','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('tvN','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('Netflix','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('tvN','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('jTBC','Beyond Evil'),
('Netflix','Bloodhounds'),
('Netflix','Business Proposal'),
('SBS','Business Proposal'),
('tvN','Chicago Typewriter'),
('Netflix','Crash Landing on You'),
('tvN','Crash Landing on You'),
('Netflix','D.P.'),
('Netflix','D.P. Season 2'),
('Netflix','Daily Dose of Sunshine'),
('tvN','Dear My Friends'),
('TVING','Death\'s Game'),
('TVING','Death\'s Game Part 2'),
('SBS','Defendant'),
('KBS2','Descendants of the Sun'),
('SBS','Dr. Romantic'),
('SBS','Dr. Romantic Season 2'),
('Disney+','Dr. Romantic Season 3'),
('SBS','Dr. Romantic Season 3'),
('ENA','Extraordinary Attorney Woo'),
('Netflix','Extraordinary Attorney Woo'),
('SBS','Flex X Cop'),
('tvN','Flower of Evil'),
('tvN','Goblin'),
('TVING','Happiness'),
('tvN','Happiness'),
('KBS2','Healer'),
('Netflix','Hometown Cha-Cha-Cha'),
('tvN','Hometown Cha-Cha-Cha'),
('Netflix','Hospital Playlist'),
('tvN','Hospital Playlist'),
('Netflix','Hospital Playlist Season 2'),
('tvN','Hospital Playlist Season 2'),
('SBS','Hot Stove League'),
('tvN','Hotel del Luna'),
('Netflix','It\'s Okay to Not Be Okay'),
('tvN','It\'s Okay to Not Be Okay'),
('MBC','Jewel in the Palace'),
('MBC','Kill Me, Heal Me'),
('Netflix','Kingdom'),
('Netflix','Kingdom Season 2'),
('OCN','Life on Mars'),
('TVING','Lovely Runner'),
('tvN','Lovely Runner'),
('tvN','Misaeng: Incomplete Life'),
('tvN','Missing: The Other Side Season 2'),
('SBS','Moon Lovers: Scarlet Heart Ryeo'),
('tvN','Mother'),
('tvN','Mouse'),
('Netflix','Move to Heaven'),
('Disney+','Moving'),
('Hulu','Moving'),
('tvN','Mr. Queen'),
('Netflix','Mr. Sunshine'),
('tvN','Mr. Sunshine'),
('MBC','My Dearest'),
('MBC','My Dearest Part 2'),
('tvN','My Mister'),
('Netflix','My Name'),
('Netflix','Navillera'),
('tvN','Navillera'),
('Netflix','Our Beloved Summer'),
('SBS','Our Beloved Summer'),
('Netflix','Our Blues'),
('tvN','Our Blues'),
('MBC','Partners for Justice Season 2'),
('Netflix','Prison Playbook'),
('tvN','Prison Playbook'),
('tvN','Queen of Tears'),
('Netflix','Racket Boys'),
('SBS','Racket Boys'),
('tvN','Reply 1988'),
('Disney+','Revenant'),
('SBS','Revenant'),
('tvN','Signal'),
('SBS','Six Flying Dragons'),
('jTBC','SKY Castle'),
('Netflix','Stranger'),
('tvN','Stranger'),
('OCN','Strangers from Hell'),
('jTBC','Strong Woman Do Bong Soon'),
('Netflix','Sweet Home'),
('Amazon Prime','Tale of the Nine-Tailed 1938'),
('tvN','Tale of the Nine-Tailed 1938'),
('SBS','Taxi Driver'),
('Wavve','Taxi Driver'),
('SBS','Taxi Driver Season 2'),
('tvN','The Devil Judge'),
('SBS','The Fiery Priest'),
('DRAMAcube','The First Responders'),
('ENA','The First Responders'),
('SBS','The First Responders'),
('SBS Plus','The First Responders'),
('Netflix','The Glory'),
('Netflix','The Glory Part 2'),
('jTBC','The Good Bad Mother'),
('Netflix','The Good Bad Mother'),
('TVING','The Good Bad Mother'),
('OCN','The Guest'),
('ENA','The Kidnapping Day'),
('TVING','The King of Pigs'),
('SBS','The Penthouse Season 2: War in Life'),
('SBS','The Penthouse: War in Life'),
('MBC','The Red Sleeve'),
('Viki','The Red Sleeve'),
('Netflix','The Uncanny Counter'),
('OCN','The Uncanny Counter'),
('Disney+','The Worst of Evil'),
('Hulu','The Worst of Evil'),
('SBS','Through the Darkness'),
('Wavve','Through the Darkness'),
('MBC','Tomorrow'),
('Netflix','Tomorrow'),
('OCN','Tunnel'),
('Netflix','Twenty-Five Twenty-One'),
('tvN','Twenty-Five Twenty-One'),
('TVING','Twinkling Watermelon'),
('tvN','Twinkling Watermelon'),
('Netflix','Under the Queen\'s Umbrella'),
('tvN','Under the Queen\'s Umbrella'),
('Netflix','Vincenzo'),
('tvN','Vincenzo'),
('Wavve','Weak Hero Class 1'),
('MBC','Weightlifting Fairy Kim Bok Joo'),
('SBS','While You Were Sleeping'),
('KBS2','Youth of May'),
('Wavve','Youth of May');
/*!40000 ALTER TABLE `network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screenwriter`
--

DROP TABLE IF EXISTS `screenwriter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screenwriter` (
  `screenwriter_name` varchar(255) NOT NULL,
  `pen_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`screenwriter_name`),
  CONSTRAINT `screenwriter_ibfk_1` FOREIGN KEY (`screenwriter_name`) REFERENCES `crew` (`name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screenwriter`
--

LOCK TABLES `screenwriter` WRITE;
/*!40000 ALTER TABLE `screenwriter` DISABLE KEYS */;
INSERT INTO `screenwriter` VALUES
('Ahn Eun Bin',NULL),
('Bae Se Young',NULL),
('Baek Mi Kyung',NULL),
('Ban Ki Ri',NULL),
('Choi Ah Il',NULL),
('Choi Chang Hwan',NULL),
('Choi Ran',NULL),
('Choi Soo Jin',NULL),
('Choi Woo Joo',NULL),
('Choi Yi Ryun',NULL),
('Han Sang Woon',NULL),
('Han Sul Hee',NULL),
('Han Woo Ri',NULL),
('Hong Bo Hee',NULL),
('Hong Jung Eun',NULL),
('Hong Mi Ran',NULL),
('Hwang Jin Young',NULL),
('Jang Min Seok',NULL),
('Ji Ho Jin',NULL),
('Jin Soo Wan',NULL),
('Jo Won Gi',NULL),
('Jo Yong',NULL),
('Jo Yoon Young',NULL),
('Jung Bo Hoon',NULL),
('Jung Hae Ri',NULL),
('Jung Seo Kyung',NULL),
('Jung So Young',NULL),
('Jung Yi Do',NULL),
('Jung Yoon Jung',NULL),
('Kang Eun Kyung',NULL),
('Kang Full',NULL),
('Kim Ba Da',NULL),
('Kim Bo Tong',NULL),
('Kim Da Hee',NULL),
('Kim Do Yeon',NULL),
('Kim Eun Hee',NULL),
('Kim Eun Sook',NULL),
('Kim Hyung Min',NULL),
('Kim Sae Bom',NULL),
('Kim Song Hee',NULL),
('Kim Soo Jin',NULL),
('Kim Soon Ok',NULL),
('Kim Won Seok',NULL),
('Kim Young Hyun',NULL),
('Kim Yu Jin',NULL),
('Kwon Do Eun',NULL),
('Kwon Il Yong',NULL),
('Kwon So Ra',NULL),
('Lee Dae II',NULL),
('Lee Eun Mi',NULL),
('Lee Ji Hyun',NULL),
('Lee Kang',NULL),
('Lee Na Eun',NULL),
('Lee Nam Gyu',NULL),
('Lee Shi Eun',NULL),
('Lee Shin Hwa',NULL),
('Lee Soo Yeon',NULL),
('Lee Woo Jung',NULL),
('Min Ji Eun',NULL),
('Moon Ji Won',NULL),
('Moon Yoo Seok',NULL),
('Noh Hee Kyung',NULL),
('Oh Sang Ho',NULL),
('Park Ba Ra',NULL),
('Park Hae Young',NULL),
('Park Hye Ryun',NULL),
('Park Ja Kyung',NULL),
('Park Jae Bum',NULL),
('Park Ji Eun',NULL),
('Park Kye Ok',NULL),
('Park Ran',NULL),
('Park Sang Yeon',NULL),
('Seo Jae Won',NULL),
('Seol Yi Na',NULL),
('Shin Ha Eun',NULL),
('Song Ji Na',NULL),
('Tak Jae Young',NULL),
('unknown',NULL),
('Yang Hee Seung',NULL),
('Yeo Ji Na',NULL),
('Yoo Hyun Mi',NULL),
('Yoo Jung Hee',NULL),
('Yoon Ji Ryun',NULL);
/*!40000 ALTER TABLE `screenwriter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wins`
--

DROP TABLE IF EXISTS `wins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wins` (
  `award_id` int NOT NULL,
  `drama_name` varchar(255) NOT NULL,
  `year` int DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`award_id`,`drama_name`),
  KEY `drama_name` (`drama_name`),
  CONSTRAINT `wins_ibfk_1` FOREIGN KEY (`award_id`) REFERENCES `award` (`award_id`) ON DELETE CASCADE,
  CONSTRAINT `wins_ibfk_2` FOREIGN KEY (`drama_name`) REFERENCES `drama` (`drama_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wins`
--

LOCK TABLES `wins` WRITE;
/*!40000 ALTER TABLE `wins` DISABLE KEYS */;
/*!40000 ALTER TABLE `wins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wrote`
--

DROP TABLE IF EXISTS `wrote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wrote` (
  `screenwriter_name` varchar(255) NOT NULL,
  `drama_name` varchar(255) NOT NULL,
  PRIMARY KEY (`screenwriter_name`,`drama_name`),
  KEY `drama_name` (`drama_name`),
  CONSTRAINT `wrote_ibfk_1` FOREIGN KEY (`screenwriter_name`) REFERENCES `screenwriter` (`screenwriter_name`) ON DELETE CASCADE,
  CONSTRAINT `wrote_ibfk_2` FOREIGN KEY (`drama_name`) REFERENCES `drama` (`drama_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wrote`
--

LOCK TABLES `wrote` WRITE;
/*!40000 ALTER TABLE `wrote` DISABLE KEYS */;
INSERT INTO `wrote` VALUES
('Ahn Eun Bin','18 Again'),
('Choi Yi Ryun','18 Again'),
('Kim Do Yeon','18 Again'),
('Ji Ho Jin','A Shop for Killers'),
('Hong Jung Eun','Alchemy of Souls'),
('Hong Mi Ran','Alchemy of Souls'),
('Hong Jung Eun','Alchemy of Souls Season 2: Light and Shadow'),
('Hong Mi Ran','Alchemy of Souls Season 2: Light and Shadow'),
('Kim Young Hyun','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('Park Sang Yeon','Arthdal Chronicles Part 2: The Sky Turning Inside Out, Rising Land'),
('Kim Young Hyun','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('Park Sang Yeon','Arthdal Chronicles Part 3: The Prelude to All Legends'),
('Choi Woo Joo','Begins Youth'),
('Kim Soo Jin','Begins Youth'),
('Kim Soo Jin','Beyond Evil'),
('unknown','Bloodhounds'),
('Han Sul Hee','Business Proposal'),
('Hong Bo Hee','Business Proposal'),
('Jin Soo Wan','Chicago Typewriter'),
('Park Ji Eun','Crash Landing on You'),
('Kim Bo Tong','D.P.'),
('Kim Bo Tong','D.P. Season 2'),
('Kim Da Hee','Daily Dose of Sunshine'),
('Lee Nam Gyu','Daily Dose of Sunshine'),
('Noh Hee Kyung','Dear My Friends'),
('unknown','Death\'s Game'),
('unknown','Death\'s Game Part 2'),
('Choi Chang Hwan','Defendant'),
('Choi Soo Jin','Defendant'),
('Kim Eun Sook','Descendants of the Sun'),
('Kim Won Seok','Descendants of the Sun'),
('Kang Eun Kyung','Dr. Romantic'),
('Kang Eun Kyung','Dr. Romantic Season 2'),
('Kang Eun Kyung','Dr. Romantic Season 3'),
('Moon Ji Won','Extraordinary Attorney Woo'),
('Kim Ba Da','Flex X Cop'),
('Yoo Jung Hee','Flower of Evil'),
('Kim Eun Sook','Goblin'),
('Han Sang Woon','Happiness'),
('Song Ji Na','Healer'),
('Shin Ha Eun','Hometown Cha-Cha-Cha'),
('Kim Song Hee','Hospital Playlist'),
('Lee Woo Jung','Hospital Playlist'),
('Lee Woo Jung','Hospital Playlist Season 2'),
('Lee Shin Hwa','Hot Stove League'),
('Hong Jung Eun','Hotel del Luna'),
('Hong Mi Ran','Hotel del Luna'),
('Jo Yong','It\'s Okay to Not Be Okay'),
('Kim Young Hyun','Jewel in the Palace'),
('Jin Soo Wan','Kill Me, Heal Me'),
('Kim Eun Hee','Kingdom'),
('Kim Eun Hee','Kingdom Season 2'),
('Lee Dae II','Life on Mars'),
('unknown','Love for Love\'s Sake'),
('Lee Shi Eun','Lovely Runner'),
('Jung Yoon Jung','Misaeng: Incomplete Life'),
('Ban Ki Ri','Missing: The Other Side Season 2'),
('Jung So Young','Missing: The Other Side Season 2'),
('Jo Yoon Young','Moon Lovers: Scarlet Heart Ryeo'),
('Jung Seo Kyung','Mother'),
('Choi Ran','Mouse'),
('Yoon Ji Ryun','Move to Heaven'),
('Kang Full','Moving'),
('Choi Ah Il','Mr. Queen'),
('Park Kye Ok','Mr. Queen'),
('Kim Eun Sook','Mr. Sunshine'),
('Hwang Jin Young','My Dearest'),
('Hwang Jin Young','My Dearest Part 2'),
('Park Hae Young','My Mister'),
('Kim Ba Da','My Name'),
('Lee Eun Mi','Navillera'),
('Lee Na Eun','Our Beloved Summer'),
('Noh Hee Kyung','Our Blues'),
('Jo Won Gi','Partners for Justice Season 2'),
('Min Ji Eun','Partners for Justice Season 2'),
('Jung Bo Hoon','Prison Playbook'),
('Park Ji Eun','Queen of Tears'),
('Jung Bo Hoon','Racket Boys'),
('Kim Song Hee','Reply 1988'),
('Lee Woo Jung','Reply 1988'),
('Kim Eun Hee','Revenant'),
('Kim Eun Hee','Signal'),
('Kim Young Hyun','Six Flying Dragons'),
('Park Sang Yeon','Six Flying Dragons'),
('Yoo Hyun Mi','SKY Castle'),
('unknown','SKZ Flix'),
('Lee Soo Yeon','Stranger'),
('Jung Yi Do','Strangers from Hell'),
('Baek Mi Kyung','Strong Woman Do Bong Soon'),
('Kim Hyung Min','Sweet Home'),
('Han Woo Ri','Tale of the Nine-Tailed 1938'),
('Lee Ji Hyun','Taxi Driver'),
('Oh Sang Ho','Taxi Driver'),
('Oh Sang Ho','Taxi Driver Season 2'),
('Moon Yoo Seok','The Devil Judge'),
('Park Jae Bum','The Fiery Priest'),
('Min Ji Eun','The First Responders'),
('Kim Eun Sook','The Glory'),
('Kim Eun Sook','The Glory Part 2'),
('Bae Se Young','The Good Bad Mother'),
('Kwon So Ra','The Guest'),
('Seo Jae Won','The Guest'),
('unknown','The Kidnapping Day'),
('Tak Jae Young','The King of Pigs'),
('Kim Soon Ok','The Penthouse Season 2: War in Life'),
('Kim Soon Ok','The Penthouse: War in Life'),
('Jung Hae Ri','The Red Sleeve'),
('Kim Sae Bom','The Uncanny Counter'),
('Yeo Ji Na','The Uncanny Counter'),
('Jang Min Seok','The Worst of Evil'),
('Kwon Il Yong','Through the Darkness'),
('Seol Yi Na','Through the Darkness'),
('Kim Yu Jin','Tomorrow'),
('Park Ja Kyung','Tomorrow'),
('Park Ran','Tomorrow'),
('Lee Eun Mi','Tunnel'),
('Kwon Do Eun','Twenty-Five Twenty-One'),
('Jin Soo Wan','Twinkling Watermelon'),
('Park Ba Ra','Under the Queen\'s Umbrella'),
('Park Jae Bum','Vincenzo'),
('unknown','Weak Hero Class 1'),
('Kim Soo Jin','Weightlifting Fairy Kim Bok Joo'),
('Yang Hee Seung','Weightlifting Fairy Kim Bok Joo'),
('Park Hye Ryun','While You Were Sleeping'),
('Lee Kang','Youth of May');
/*!40000 ALTER TABLE `wrote` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-02 20:37:11

-- MariaDB dump 10.19  Distrib 10.9.8-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: baseball
-- ------------------------------------------------------
-- Server version	10.9.8-MariaDB

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
-- Table structure for table `coach`
--

DROP TABLE IF EXISTS `coach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coach` (
  `coach_id` int(11) NOT NULL,
  `coach_name` varchar(255) DEFAULT NULL,
  `team_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`coach_id`),
  KEY `FK_Coach_Team` (`team_name`),
  CONSTRAINT `FK_Coach_Team` FOREIGN KEY (`team_name`) REFERENCES `team` (`team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coach`
--

LOCK TABLES `coach` WRITE;
/*!40000 ALTER TABLE `coach` DISABLE KEYS */;
/*!40000 ALTER TABLE `coach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coach_per_type`
--

DROP TABLE IF EXISTS `coach_per_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coach_per_type` (
  `coach_id` int(11) NOT NULL,
  `coach_type` varchar(255) NOT NULL,
  PRIMARY KEY (`coach_id`,`coach_type`),
  CONSTRAINT `FK_Coach_CoachType` FOREIGN KEY (`coach_id`) REFERENCES `coach` (`coach_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coach_per_type`
--

LOCK TABLES `coach_per_type` WRITE;
/*!40000 ALTER TABLE `coach_per_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `coach_per_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `division_league`
--

DROP TABLE IF EXISTS `division_league`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `division_league` (
  `league_id` int(11) NOT NULL,
  `division_id` int(11) NOT NULL,
  `league_name` varchar(255) DEFAULT NULL,
  `division_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`league_id`,`division_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `division_league`
--

LOCK TABLES `division_league` WRITE;
/*!40000 ALTER TABLE `division_league` DISABLE KEYS */;
INSERT INTO `division_league` VALUES
(1,1,'American League','East'),
(1,2,'American League','West'),
(1,3,'American League','Central'),
(2,1,'National League','East'),
(2,2,'National League','West'),
(2,3,'National League','Central');
/*!40000 ALTER TABLE `division_league` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `game_id` int(11) NOT NULL,
  `stadium_id` int(11) DEFAULT NULL,
  `season_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `home_team_name` varchar(255) DEFAULT NULL,
  `away_team_name` varchar(255) DEFAULT NULL,
  `home_score` int(11) DEFAULT NULL,
  `away_score` int(11) DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  KEY `FK_Game_Stadium` (`stadium_id`),
  KEY `FK_Game_Season` (`season_id`),
  KEY `FK_Game_Home_Team` (`home_team_name`),
  KEY `FK_Game_Away_Team` (`away_team_name`),
  CONSTRAINT `FK_Game_Away_Team` FOREIGN KEY (`away_team_name`) REFERENCES `team` (`team_name`),
  CONSTRAINT `FK_Game_Home_Team` FOREIGN KEY (`home_team_name`) REFERENCES `team` (`team_name`),
  CONSTRAINT `FK_Game_Season` FOREIGN KEY (`season_id`) REFERENCES `season` (`season_id`),
  CONSTRAINT `FK_Game_Stadium` FOREIGN KEY (`stadium_id`) REFERENCES `stadium` (`stadium_id`),
  CONSTRAINT `chk_team_names_different` CHECK (`home_team_name` <> `away_team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
  `player_name` varchar(255) NOT NULL,
  `rank` int(11) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `team_name` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `eta` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `bats` varchar(5) DEFAULT NULL,
  `throws` varchar(5) DEFAULT NULL,
  `height_cm` float DEFAULT NULL,
  `weight_kg` float DEFAULT NULL,
  PRIMARY KEY (`player_name`),
  KEY `FK_Player_Team` (`team_name`),
  CONSTRAINT `FK_Player_Team` FOREIGN KEY (`team_name`) REFERENCES `team` (`team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES
('Adael Amador',45,'2B/SS','Colorado Rockies','AA','2025',21,'S','R',182.88,90.7184),
('Aidan Miller',27,'SS/3B','Philadelphia Phillies','A+','2027',20,'R','R',185.42,92.9864),
('AJ Smith-Shawver',65,'RHP','Atlanta Braves','AAA','2024',21,'R','R',190.5,92.9864),
('Andrew Painter',19,'RHP','Philadelphia Phillies','AA','2025',21,'R','R',200.66,97.5223),
('Anthony Solometo',75,'LHP','Pittsburgh Pirates','A','2024',21,'L','L',195.58,99.7902),
('Blake Mitchell',60,'C','Kansas City Royals','A','2027',19,'L','R',182.88,91.6256),
('Brady House',42,'3B','Washington Nationals','AAA','2025',21,'R','R',193.04,94.3471),
('Brandon Sproat',94,'RHP','New York Mets','AA','2025',23,'R','R',190.5,97.5223),
('Braxton Ashcraft',99,'RHP','Pittsburgh Pirates','AAA','2024',24,'L','R',195.58,88.4504),
('Brayden Taylor',57,'3B/SS','Tampa Bay Rays','AA','2026',22,'L','R',182.88,81.6466),
('Brooks Lee',13,'SS','Minnesota Twins','MLB','2024',23,'S','R',185.42,92.9864),
('Bryce Eldridge',68,'1B','San Francisco Giants','A+','2026',19,'L','R',200.66,101.151),
('Bubba Chandler',49,'RHP','Pittsburgh Pirates','AA','2025',21,'S','R',187.96,90.7184),
('Cade Horton',17,'RHP','Chicago Cubs','AAA','2024',22,'R','R',185.42,95.7079),
('Caden Dana',88,'RHP','Los Angeles Angels','AA','2026',20,'L','R',193.04,97.5223),
('Cam Collier',82,'3B','Cincinnati Reds','A+','2026',19,'L','R',185.42,95.2543),
('Carson Whisenhunt',56,'LHP','San Francisco Giants','AAA','2024',23,'L','L',190.5,94.8007),
('Carson Williams',9,'SS','Tampa Bay Rays','AA','2025',21,'R','R',187.96,81.6466),
('Chase DeLauter',28,'OF','Cleveland Guardians','AA','2025',22,'L','L',193.04,106.594),
('Chase Dollander',36,'RHP','Colorado Rockies','AA','2026',22,'R','R',187.96,90.7184),
('Chase Hampton',80,'RHP','New York Yankees','AA','2024',22,'R','R',187.96,99.7902),
('Coby Mayo',15,'3B/1B','Baltimore Orioles','AAA','2024',22,'R','R',195.58,104.326),
('Cole Young',22,'SS/2B','Seattle Mariners','AA','2025',21,'L','R',182.88,81.6466),
('Colson Montgomery',16,'SS','Chicago White Sox','AAA','2024',22,'L','R',190.5,102.058),
('Colt Emerson',41,'SS/2B','Seattle Mariners','A','2026',19,'L','R',185.42,88.4504),
('Cooper Pratt',93,'SS','Milwaukee Brewers','A+','2027',19,'R','R',193.04,88.4504),
('Dalton Rushing',46,'C/1B','Los Angeles Dodgers','AA','2025',23,'L','R',185.42,99.7902),
('David Festa',87,'RHP','Minnesota Twins','MLB','2024',24,'R','R',198.12,83.9145),
('Drew Gilbert',37,'OF','New York Mets','AAA','2024',23,'L','L',175.26,88.4504),
('Druw Jones',77,'OF','Arizona Diamondbacks','A','2026',20,'R','R',193.04,81.6466),
('Dylan Crews',4,'OF','Washington Nationals','AAA','2024',22,'R','R',180.34,92.0792),
('Dylan Lesko',76,'RHP','Tampa Bay Rays','A+','2026',20,'R','R',187.96,88.4504),
('Edgar Quero',71,'C','Chicago White Sox','AAA','2025',21,'S','R',177.8,95.2543),
('Edwin Arroyo',47,'SS','Cincinnati Reds','AA','2026',20,'S','R',182.88,79.3786),
('Emmanuel Rodriguez',26,'OF','Minnesota Twins','AA','2025',21,'L','L',180.34,95.2543),
('Ethan Salas',6,'C','San Diego Padres','A+','2025',18,'L','R',185.42,83.9145),
('Felnin Celesten',89,'SS','Seattle Mariners','ROK','2028',18,'S','R',185.42,79.3786),
('Harry Ford',23,'C','Seattle Mariners','AA','2025',21,'R','R',177.8,90.7184),
('Hayden Birdsong',95,'RHP','San Francisco Giants','A','2025',22,'R','R',193.04,97.5223),
('Hurston Waldrep',67,'RHP','Atlanta Braves','AAA','2024',22,'R','R',187.96,95.2543),
('Jace Jung',39,'3B/2B','Detroit Tigers','AAA','2024',23,'L','R',182.88,92.9864),
('Jackson Holliday',1,'2B/SS','Baltimore Orioles','MLB','2024',20,'L','R',182.88,83.9145),
('Jackson Jobe',11,'RHP','Detroit Tigers','AA','2025',22,'R','R',187.96,86.1825),
('Jacob Melton',66,'OF','Houston Astros','AAA','2025',23,'L','L',187.96,94.3471),
('Jacob Misiorowski',32,'RHP','Milwaukee Brewers','AA','2025',22,'R','R',200.66,86.1825),
('Jacob Wilson',48,'SS','Oakland Athletics','MLB','2025',22,'R','R',187.96,86.1825),
('Jaison Chourio',83,'OF','Cleveland Guardians','A','2027',19,'S','R',185.42,73.4819),
('James Triantos',51,'2B','Chicago Cubs','AA','2025',21,'R','R',180.34,88.4504),
('James Wood',2,'OF','Washington Nationals','MLB','2024',21,'L','R',200.66,106.141),
('Jasson Domínguez',25,'OF','New York Yankees','AAA','2024',21,'S','R',175.26,86.1825),
('Jeferson Quero',21,'C','Milwaukee Brewers','AAA','2025',21,'R','R',180.34,97.5223),
('Jefferson Rojas',84,'SS','Chicago Cubs','A+','2026',19,'R','R',180.34,68.0388),
('Jett Williams',30,'SS/OF','New York Mets','AA','2025',20,'R','R',170.18,79.3786),
('Jordan Beck',54,'OF','Colorado Rockies','AAA','2025',23,'R','R',187.96,102.058),
('Jordan Lawlar',8,'SS','Arizona Diamondbacks','AAA','2024',22,'R','R',185.42,86.1825),
('Josue De Paula',61,'OF','Los Angeles Dodgers','A+','2026',19,'L','L',190.5,83.9145),
('Junior Caminero',3,'3B/SS','Tampa Bay Rays','AAA','2024',21,'R','R',185.42,71.2139),
('Justin Crawford',53,'OF','Philadelphia Phillies','AA','2026',20,'L','R',187.96,85.2753),
('Kevin Alcántara',63,'OF','Chicago Cubs','AA','2025',22,'R','R',198.12,85.2753),
('Kevin McGonigle',62,'SS/2B','Detroit Tigers','A+','2027',19,'L','R',177.8,84.8217),
('Kyle Manzardo',35,'1B','Cleveland Guardians','AAA','2024',24,'L','R',180.34,92.9864),
('Kyle Teel',24,'C','Boston Red Sox','AA','2025',22,'L','R',182.88,86.1825),
('Lazaro Montes',50,'OF','Seattle Mariners','A+','2026',19,'L','R',190.5,95.2543),
('Leodalis De Vries',78,'SS','San Diego Padres','A','2028',17,'S','R',187.96,83.0073),
('Luisangel Acuña',90,'SS/2B/OF','New York Mets','AAA','2024',22,'R','R',172.72,82.1002),
('Luke Keaschall',92,'2B/OF','Minnesota Twins','AA','2026',21,'R','R',182.88,86.1825),
('Marcelo Mayer',7,'SS','Boston Red Sox','AA','2024',21,'L','R',190.5,85.2753),
('Marco Luciano',73,'SS','San Francisco Giants','MLB','2024',22,'R','R',185.42,80.7394),
('Matt Shaw',29,'3B','Chicago Cubs','AA','2025',22,'R','R',175.26,83.9145),
('Max Clark',10,'OF','Detroit Tigers','A+','2026',19,'L','L',182.88,92.9864),
('Max Meyer',79,'RHP','Miami Marlins','MLB','2024',25,'L','R',182.88,88.904),
('Mick Abel',91,'RHP','Philadelphia Phillies','AAA','2024',22,'R','R',195.58,86.1825),
('Moises Ballesteros',58,'C/1B','Chicago Cubs','AAA','2026',20,'L','R',170.18,88.4504),
('Noah Schultz',18,'LHP','Chicago White Sox','AA','2026',20,'L','L',205.74,99.7902),
('Noble Meyer',38,'RHP','Miami Marlins','A+','2026',19,'R','R',195.58,83.9145),
('Orelvis Martinez',59,'2B','Toronto Blue Jays','MLB','2024',22,'R','R',180.34,90.7184),
('Owen Caissie',34,'OF','Chicago Cubs','AAA','2025',22,'L','R',190.5,86.1825),
('Quinn Mathews',96,'LHP','St. Louis Cardinals','AA','2025',23,'L','L',195.58,85.2753),
('Ralphy Velazquez',85,'1B','Cleveland Guardians','A','2027',19,'L','R',190.5,97.5223),
('Rhett Lowder',20,'RHP','Cincinnati Reds','AA','2024',22,'R','R',187.96,90.7184),
('Ricky Tiedemann',43,'LHP','Toronto Blue Jays','AAA','2024',21,'L','L',193.04,99.7902),
('Robby Snelling',44,'LHP','Miami Marlins','AA','2025',20,'R','L',190.5,95.2543),
('Roman Anthony',14,'OF','Boston Red Sox','AA','2025',20,'L','R',187.96,90.7184),
('Ryan Clifford',69,'OF/1B','New York Mets','AA','2026',21,'L','L',187.96,90.7184),
('Sal Stewart',97,'3B/2B','Cincinnati Reds','A+','2026',20,'R','R',185.42,97.5223),
('Samuel Basallo',12,'C/1B','Baltimore Orioles','AA','2025',19,'L','R',193.04,81.6466),
('Sebastian Walcott',70,'SS','Texas Rangers','A+','2027',18,'R','R',193.04,86.1825),
('Spencer Jones',72,'OF','New York Yankees','AA','2025',23,'L','L',198.12,106.594),
('Starlyn Caba',86,'SS','Philadelphia Phillies','A','2027',18,'S','R',175.26,72.5747),
('Termarr Johnson',74,'2B/SS','Pittsburgh Pirates','A+','2025',20,'L','R',172.72,79.3786),
('Thomas White',55,'LHP','Miami Marlins','A+','2027',19,'L','L',195.58,95.2543),
('Tink Hence',40,'RHP','St. Louis Cardinals','AA','2024',21,'R','R',185.42,88.4504),
('Tommy Troy',52,'SS','Arizona Diamondbacks','A+','2025',22,'R','R',177.8,89.3576),
('Tyler Black',33,'1B','Milwaukee Brewers','AAA','2024',24,'L','R',185.42,92.5328),
('Tyler Locklear',98,'1B','Seattle Mariners','AAA','2024',23,'R','R',187.96,95.2543),
('Walker Jenkins',5,'OF','Minnesota Twins','A+','2026',19,'L','R',190.5,95.2543),
('Xavier Isaac',31,'1B','Tampa Bay Rays','A+','2026',20,'L','L',193.04,108.862),
('Yanquiel Fernandez',64,'OF','Colorado Rockies','AA','2025',21,'L','L',187.96,89.8112),
('Zac Veen',81,'OF','Colorado Rockies','AA','2024',22,'L','R',190.5,86.1825),
('Zebby Matthews',100,'RHP','Minnesota Twins','AAA','2025',24,'R','R',195.58,102.058);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_stats`
--

DROP TABLE IF EXISTS `player_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_stats` (
  `player_stats_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `hits` int(11) DEFAULT NULL,
  `strikeouts` int(11) DEFAULT NULL,
  `at_bats` int(11) DEFAULT NULL,
  PRIMARY KEY (`player_stats_id`,`game_id`,`player_name`),
  KEY `FK_Stats_Game` (`game_id`),
  KEY `FK_Stats_Player` (`player_name`),
  CONSTRAINT `FK_Stats_Game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`),
  CONSTRAINT `FK_Stats_Player` FOREIGN KEY (`player_name`) REFERENCES `player` (`player_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_stats`
--

LOCK TABLES `player_stats` WRITE;
/*!40000 ALTER TABLE `player_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playoff`
--

DROP TABLE IF EXISTS `playoff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playoff` (
  `season_id` int(11) NOT NULL,
  `round_series` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`season_id`),
  CONSTRAINT `FK_Season_Playoff` FOREIGN KEY (`season_id`) REFERENCES `season` (`season_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playoff`
--

LOCK TABLES `playoff` WRITE;
/*!40000 ALTER TABLE `playoff` DISABLE KEYS */;
/*!40000 ALTER TABLE `playoff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regular_season`
--

DROP TABLE IF EXISTS `regular_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regular_season` (
  `season_id` int(11) NOT NULL,
  PRIMARY KEY (`season_id`),
  CONSTRAINT `FK_Season_Regular` FOREIGN KEY (`season_id`) REFERENCES `season` (`season_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regular_season`
--

LOCK TABLES `regular_season` WRITE;
/*!40000 ALTER TABLE `regular_season` DISABLE KEYS */;
/*!40000 ALTER TABLE `regular_season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season`
--

DROP TABLE IF EXISTS `season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `season` (
  `season_id` int(11) NOT NULL,
  `season_year` int(11) DEFAULT NULL,
  PRIMARY KEY (`season_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season`
--

LOCK TABLES `season` WRITE;
/*!40000 ALTER TABLE `season` DISABLE KEYS */;
/*!40000 ALTER TABLE `season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stadium`
--

DROP TABLE IF EXISTS `stadium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stadium` (
  `stadium_id` int(11) NOT NULL,
  `stadium_name` varchar(255) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `states` varchar(255) DEFAULT NULL,
  `zip_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`stadium_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stadium`
--

LOCK TABLES `stadium` WRITE;
/*!40000 ALTER TABLE `stadium` DISABLE KEYS */;
/*!40000 ALTER TABLE `stadium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `team_name` varchar(255) NOT NULL,
  `contact_number` varchar(13) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  `loses` int(11) DEFAULT NULL,
  `official_website` varchar(255) DEFAULT NULL,
  `league_id` int(11) DEFAULT NULL,
  `division_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`team_name`),
  KEY `FK_Team_Division_League` (`league_id`,`division_id`),
  CONSTRAINT `FK_Team_Division_League` FOREIGN KEY (`league_id`, `division_id`) REFERENCES `division_league` (`league_id`, `division_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES
('Arizona Diamondbacks',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Atlanta Braves',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Baltimore Orioles',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Boston Red Sox',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Chicago Cubs',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Chicago White Sox',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Cincinnati Reds',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Cleveland Guardians',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Colorado Rockies',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Detroit Tigers',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Houston Astros',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Kansas City Royals',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Los Angeles Angels',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Los Angeles Dodgers',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Miami Marlins',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Milwaukee Brewers',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Minnesota Twins',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('New York Mets',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('New York Yankees',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Oakland Athletics',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Philadelphia Phillies',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Pittsburgh Pirates',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('San Diego Padres',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('San Francisco Giants',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Seattle Mariners',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('St. Louis Cardinals',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Tampa Bay Rays',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Texas Rangers',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Toronto Blue Jays',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('Washington Nationals',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `win_percentage`
--

DROP TABLE IF EXISTS `win_percentage`;
/*!50001 DROP VIEW IF EXISTS `win_percentage`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `win_percentage` AS SELECT
 1 AS `team_name`,
  1 AS `wins`,
  1 AS `loses`,
  1 AS `win_percentage` */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `win_percentage`
--

/*!50001 DROP VIEW IF EXISTS `win_percentage`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `win_percentage` AS select `team`.`team_name` AS `team_name`,`team`.`wins` AS `wins`,`team`.`loses` AS `loses`,`team`.`wins` / (`team`.`wins` + `team`.`loses`) AS `win_percentage` from `team` group by `team`.`team_name`,`team`.`wins`,`team`.`loses` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-01 23:03:24

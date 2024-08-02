-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: companies
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `City`
--

DROP TABLE IF EXISTS `City`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `City` (
  `CityID` int NOT NULL AUTO_INCREMENT,
  `CityName` varchar(100) NOT NULL,
  `StateID` int NOT NULL,
  PRIMARY KEY (`CityID`),
  KEY `StateID` (`StateID`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`StateID`) REFERENCES `State` (`StateID`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `City`
--

LOCK TABLES `City` WRITE;
/*!40000 ALTER TABLE `City` DISABLE KEYS */;
INSERT INTO `City` VALUES (1,'Bentonville',1),(2,'Springdale',1),(3,'Seattle',2),(4,'Issaquah',2),(5,'Redmond',2),(6,'Spring',3),(7,'Irving',3),(8,'Houston',3),(9,'San Antonio',3),(10,'Dallas',3),(11,'Round Rock',3),(12,'Austin',3),(13,'Midland',3),(14,'Fort Worth',3),(15,'Cupertino',4),(16,'Mountain View',4),(17,'San Ramon',4),(18,'Menlo Park',4),(19,'San Francisco',4),(20,'Burbank',4),(21,'Santa Clara',4),(22,'Palo Alto',4),(23,'San Jose',4),(24,'San Diego',4),(25,'Minnetonka',5),(26,'Minneapolis',5),(27,'Bloomington',5),(28,'Inver Grove Heights',5),(29,'Richfield',5),(30,'Woonsocket',6),(31,'Omaha',7),(32,'Chesterbrook',8),(33,'Philadelphia',8),(34,'Dublin',9),(35,'Findlay',9),(36,'Cincinnati',9),(37,'Columbus',9),(38,'Mayfield Village',9),(39,'Bloomfield',10),(40,'Stamford',10),(41,'Dearborn',11),(42,'Detroit',11),(43,'Atlanta',12),(44,'Indianapolis',13),(45,'New York City',14),(46,'Purchase',14),(47,'White Plains',14),(48,'Armonk',14),(49,'St. Louis',15),(50,'Deerfield',16),(51,'Chicago',16),(52,'Lake Bluff',16),(53,'Moline',16),(54,'Northfield Township',16),(55,'Washington',17),(56,'Charlotte',18),(57,'Mooresville',18),(58,'New Brunswick',19),(59,'Newark',19),(60,'Kenilworth',19),(61,'Parsippany–Troy Hills',19),(62,'Memphis',20),(63,'Nashville',20),(64,'Louisville',21),(65,'McLean',22),(66,'Arlington County',22),(67,'Boise',23),(68,'Boston',24),(69,'Framingham',24),(70,'Waltham',24),(71,'Clearwater',25),(72,'Miami',25),(73,'Lakeland',25),(74,'Bethesda',26),(75,'Beaverton',27);
/*!40000 ALTER TABLE `City` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Company`
--

DROP TABLE IF EXISTS `Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Company` (
  `CompanyID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `IndustryID` int NOT NULL,
  `CityID` int NOT NULL,
  `Revenue` decimal(15,2) DEFAULT NULL,
  `RevenueGrowth` decimal(5,2) DEFAULT NULL,
  `Employees` int DEFAULT NULL,
  PRIMARY KEY (`CompanyID`),
  KEY `IndustryID` (`IndustryID`),
  KEY `CityID` (`CityID`),
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`IndustryID`) REFERENCES `Industry` (`IndustryID`),
  CONSTRAINT `company_ibfk_2` FOREIGN KEY (`CityID`) REFERENCES `City` (`CityID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Company`
--

LOCK TABLES `Company` WRITE;
/*!40000 ALTER TABLE `Company` DISABLE KEYS */;
INSERT INTO `Company` VALUES (1,'Walmart',1,1,611289.00,6.70,2100000),(2,'Amazon',2,3,513983.00,9.40,1540000),(3,'ExxonMobil',3,6,413680.00,44.80,62000),(4,'Apple',4,15,394328.00,7.80,164000),(5,'UnitedHealth Group',5,25,324162.00,12.70,400000),(6,'CVS Health',5,30,322467.00,10.40,259500),(7,'Berkshire Hathaway',6,31,302089.00,9.40,383000),(8,'Alphabet',7,16,282836.00,9.80,156000),(9,'McKesson Corporation',8,7,276711.00,4.80,48500),(10,'Chevron Corporation',3,17,246252.00,51.60,43846),(11,'Cencora',9,32,238587.00,11.50,41500),(12,'Costco',1,4,226954.00,15.80,304000),(13,'Microsoft',7,5,198270.00,18.00,221000),(14,'Cardinal Health',5,34,181364.00,11.60,46035),(15,'Cigna',10,39,180516.00,3.70,70231),(16,'Marathon Petroleum',3,35,180012.00,27.60,17800),(17,'Phillips 66',3,8,175702.00,53.00,13000),(18,'Valero Energy',3,9,171189.00,58.00,9743),(19,'Ford Motor Company',11,41,158057.00,15.90,173000),(20,'The Home Depot',1,43,157403.00,4.10,471600),(21,'General Motors',11,42,156735.00,23.40,167000),(22,'Elevance Health',5,44,156595.00,13.00,102200),(23,'JPMorgan Chase',12,45,154792.00,21.70,293723),(24,'Kroger',1,36,148258.00,7.50,430000),(25,'Centene',5,49,144547.00,14.70,74300),(26,'Verizon Communications',13,45,136835.00,2.40,117100),(27,'Walgreens Boots Alliance',14,50,132703.00,10.70,262500),(28,'Fannie Mae',15,55,121596.00,19.70,8000),(29,'Comcast',13,33,121427.00,4.30,186000),(30,'AT&T',16,10,120741.00,28.50,160700),(31,'Meta Platforms',17,18,116609.00,1.10,86482),(32,'Bank of America',15,56,115053.00,22.60,216823),(33,'Target Corporation',1,26,109120.00,2.90,440000),(34,'Dell Technologies',17,11,102301.00,4.40,133000),(35,'Archer Daniels Midland',18,51,101556.00,19.10,41181),(36,'Citigroup',15,45,101078.00,26.60,238104),(37,'United Parcel Service',19,43,100338.00,3.10,404700),(38,'Pfizer',14,45,100330.00,23.40,83000),(39,'Lowes',1,57,97059.00,0.80,244500),(40,'Johnson & Johnson',14,58,94943.00,1.20,152700),(41,'FedEx',19,62,93512.00,11.40,518249),(42,'Humana',10,64,92870.00,11.80,67100),(43,'Energy Transfer Partners',3,10,89876.00,33.30,12565),(44,'State Farm',15,27,89328.00,8.60,60519),(45,'Freddie Mac',15,65,86717.00,31.60,7819),(46,'PepsiCo',20,46,86859.00,8.70,315000),(47,'Wells Fargo',15,19,82859.00,0.50,238000),(48,'The Walt Disney Company',21,20,82722.00,22.70,195800),(49,'ConocoPhillips',3,8,82156.00,69.90,9500),(50,'Tesla',22,12,81462.00,51.40,127855),(51,'Procter & Gamble',23,36,80187.00,5.30,106000),(52,'United States Postal Service',24,55,78620.00,2.00,576000),(53,'Albertsons',1,67,77650.00,8.00,198650),(54,'General Electric',6,68,76555.00,3.20,172000),(55,'MetLife',15,45,69898.00,1.70,45000),(56,'Goldman Sachs',15,45,68711.00,5.70,48500),(57,'Sysco',25,8,68636.00,33.80,70510),(58,'Bunge Limited',18,47,67232.00,13.70,23000),(59,'RTX Corporation',6,66,67074.00,4.20,182000),(60,'Boeing',26,66,66608.00,6.90,156000),(61,'StoneX Group',15,45,66036.00,55.30,4000),(62,'Lockheed Martin',26,74,65984.00,1.60,116000),(63,'Morgan Stanley',15,45,65936.00,7.90,82427),(64,'Intel',17,21,63054.00,20.10,131900),(65,'HP',17,22,62983.00,0.80,58000),(66,'TD Synnex',27,71,62344.00,97.20,28500),(67,'IBM',7,48,60530.00,16.30,303100),(68,'HCA Healthcare',5,63,60233.00,2.50,250500),(69,'Prudential Financial',15,59,60050.00,15.30,39583),(70,'Caterpillar',28,50,59427.00,16.60,109100),(71,'Merck & Co.',14,60,59283.00,15.80,68000),(72,'World Fuel Services',29,72,59043.00,88.40,5214),(73,'New York Life Insurance Company',30,45,58445.00,14.20,15050),(74,'Enterprise Products',3,8,58186.00,42.60,7300),(75,'AbbVie',14,52,58054.00,3.30,50000),(76,'Plains All American Pipeline',3,8,57342.00,36.30,4100),(77,'Dow Chemical Company',31,13,56902.00,3.50,37800),(78,'AIG',30,45,56437.00,8.40,26200),(79,'American Express',15,45,55625.00,27.30,77300),(80,'Publix',1,73,54942.00,13.50,242000),(81,'Charter Communications',13,40,54022.00,4.50,101700),(82,'Tyson Foods',32,2,53282.00,13.20,142000),(83,'John Deere',33,53,52577.00,19.40,82239),(84,'Cisco',34,23,51557.00,3.50,83300),(85,'Nationwide Mutual Insurance Company',15,37,51450.00,8.60,24791),(86,'Allstate',30,54,51412.00,3.40,54250),(87,'Delta Air Lines',35,43,50582.00,69.20,95000),(88,'Liberty Mutual',30,68,49956.00,3.60,50000),(89,'TJX',1,69,49936.00,2.90,329000),(90,'Progressive Corporation',30,38,49611.00,4.00,55063),(91,'American Airlines',35,14,48971.00,63.90,129700),(92,'CHS',36,28,47194.00,24.30,10014),(93,'Performance Food Group',32,55,47194.00,61.60,34825),(94,'PBF Energy',3,61,46830.00,71.80,3616),(95,'Nike',37,75,46710.00,4.90,79100),(96,'Best Buy',1,29,46298.00,10.60,71100),(97,'Bristol-Myers Squibb',14,45,46159.00,0.50,34300),(98,'United Airlines',35,51,44955.00,82.50,92795),(99,'Thermo Fisher Scientific',38,70,44915.00,14.50,130000),(100,'Qualcomm',17,24,44200.00,31.70,51000);
/*!40000 ALTER TABLE `Company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Industry`
--

DROP TABLE IF EXISTS `Industry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Industry` (
  `IndustryID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`IndustryID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Industry`
--

LOCK TABLES `Industry` WRITE;
/*!40000 ALTER TABLE `Industry` DISABLE KEYS */;
INSERT INTO `Industry` VALUES (1,'Retail'),(2,'Retail and cloud computing'),(3,'Petroleum industry'),(4,'Electronics industry'),(5,'Healthcare'),(6,'Conglomerate'),(7,'Technology and cloud computing'),(8,'Health'),(9,'Pharmacy wholesale'),(10,'Health insurance'),(11,'Automotive industry'),(12,'Financial services'),(13,'Telecommunications'),(14,'Pharmaceutical industry'),(15,'Financials'),(16,'Conglomerate and telecommunications'),(17,'Technology'),(18,'Food industry'),(19,'Transportation'),(20,'Beverage'),(21,'Media'),(22,'Automotive and energy'),(23,'Consumer products manufacturing'),(24,'Logistics'),(25,'Food service'),(26,'Aerospace and defense'),(27,'Infotech'),(28,'Machinery'),(29,'Petroleum industry and logistics'),(30,'Insurance'),(31,'Chemical industry'),(32,'Food processing'),(33,'Agriculture manufacturing'),(34,'Telecom hardware manufacturing'),(35,'Airline'),(36,'Agriculture cooperative'),(37,'Apparel'),(38,'Laboratory instruments');
/*!40000 ALTER TABLE `Industry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `State`
--

DROP TABLE IF EXISTS `State`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `State` (
  `StateID` int NOT NULL AUTO_INCREMENT,
  `StateName` varchar(100) NOT NULL,
  PRIMARY KEY (`StateID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `State`
--

LOCK TABLES `State` WRITE;
/*!40000 ALTER TABLE `State` DISABLE KEYS */;
INSERT INTO `State` VALUES (1,'Arkansas'),(2,'Washington  '),(3,'Texas  '),(4,'California  '),(5,'Minnesota  '),(6,'Rhode Island  '),(7,'Nebraska  '),(8,'Pennsylvania  '),(9,'Ohio  '),(10,'Connecticut  '),(11,'Michigan  '),(12,'Georgia  '),(13,'Indiana  '),(14,'New York  '),(15,'Missouri  '),(16,'Illinois  '),(17,'D.C.  '),(18,'North Carolina  '),(19,'New Jersey  '),(20,'Tennessee  '),(21,'Kentucky  '),(22,'Virginia  '),(23,'Idaho  '),(24,'Massachusetts  '),(25,'Florida  '),(26,'Maryland  '),(27,'Oregon');
/*!40000 ALTER TABLE `State` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-02  9:25:46

/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: basdat2
-- ------------------------------------------------------
-- Server version	11.4.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `bosses`
--

DROP TABLE IF EXISTS `bosses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bosses` (
  `boss_id` int(11) NOT NULL AUTO_INCREMENT,
  `boss_name` varchar(255) NOT NULL,
  `hp` int(11) DEFAULT NULL,
  `souls` int(11) DEFAULT NULL,
  `magic_eff` varchar(50) DEFAULT NULL,
  `fire_eff` varchar(50) DEFAULT NULL,
  `lightning_eff` varchar(50) DEFAULT NULL,
  `dark_eff` varchar(50) DEFAULT NULL,
  `bleed_eff` varchar(50) DEFAULT NULL,
  `poison_eff` varchar(50) DEFAULT NULL,
  `frost_eff` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`boss_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bosses`
--

LOCK TABLES `bosses` WRITE;
/*!40000 ALTER TABLE `bosses` DISABLE KEYS */;
INSERT INTO `bosses` VALUES
(1,'Iudex Gundyr',1037,3000,NULL,NULL,NULL,'Resistance','Resistance','Immunity','Weakness'),
(2,'Vordt of the Boreal Valley',1328,3000,NULL,'Weakness',NULL,'Weakness','Immunity','Immunity','Immunity'),
(3,'Crystal Sage',2723,8000,'Resistance',NULL,'Weakness',NULL,NULL,'Weakness','Weakness'),
(4,'Deacons of the Deep',4099,13000,'Resistance',NULL,NULL,'Resistance','Resistance','Resistance','Weakness'),
(5,'Abyss Watchers',1548,18000,NULL,'Resistance','Weakness','Resistance','Resistance','Immunity','Weakness'),
(6,'High Lord Wolnir',15041,22000,NULL,NULL,NULL,'Resistance','Immunity','Resistance',NULL),
(7,'Pontiff Sulyvahn',5106,28000,NULL,'Weakness','Weakness',NULL,'Resistance','Resistance','Resistance'),
(8,'Aldrich, Devourer of Gods',4727,50000,'Resistance','Weakness','Weakness','Resistance','Resistance','Immunity','Resistance'),
(9,'Yhorm the Giant',27822,36000,NULL,'Immunity','Weakness',NULL,'Immunity','Immunity','Immunity'),
(10,'Dancer of the Boreal Valley',5111,60000,NULL,NULL,'Weakness','Weakness',NULL,'Immunity','Immunity'),
(11,'Dragonslayer Armour',4581,64000,NULL,NULL,'Resistance','Resistance','Immunity','Immunity','Weakness'),
(12,'Twin Princes',4294,NULL,'Weakness',NULL,'Weakness','Resistance',NULL,'Immunity','Weakness'),
(13,'Soul of Cinder',6557,100000,'Weakness','Resistance','Weakness','Weakness','Resistance','Immunity','Weakness'),
(14,'Sister Friede',NULL,72000,NULL,NULL,'Weakness','Weakness','Weakness','Resistance','Immunity'),
(15,'Demon in Pain',7045,NULL,NULL,'Resistance',NULL,'Weakness','Weakness','Immunity','Immunity'),
(16,'Halflight, Spear of the Church',3379,80000,NULL,'Weakness',NULL,'Weakness','Resistance','Resistance','Weakness'),
(17,'Slave Knight Gael',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(18,'Curse-rotted Greatwood',5405,7000,NULL,'Weakness',NULL,NULL,'Immunity','Immunity','Immunity'),
(19,'Old Demon King',5301,25000,NULL,'Resistance',NULL,'Weakness','Immunity','Resistance','Immunity'),
(20,'Oceiros, the Consumed King',8087,58000,'Resistance',NULL,'Weakness',NULL,'Resistance','Immunity','Weakness'),
(21,'Champion Gundyr',4956,60000,NULL,NULL,'Weakness','Resistance','Resistance','Resistance','Weakness'),
(22,'Ancient Wyvern',7873,70000,NULL,NULL,'Weakness',NULL,'Resistance','Resistance','Weakness'),
(23,'The Nameless King',4577,80000,NULL,'Weakness','Resistance','Weakness','Resistance','Immunity','Resistance'),
(24,'Champion\'s Gravetender',2791,60000,NULL,NULL,'Weakness',NULL,'Weakness','Resistance','Resistance'),
(25,'Darkeater Midir',15860,150000,'Resistance','Resistance','Weakness','Resistance','Immunity','Immunity','Immunity'),
(26,'Ravenous Crystal Lizard',1200,4000,'Resistance','Resistance',NULL,NULL,'Immunity','Immunity','Immunity'),
(27,'Demon',1390,5000,NULL,'Resistance',NULL,NULL,'Immunity','Resistance','Immunity'),
(28,'Boreal Outrider Knight',654,1600,'Resistance','Resistance',NULL,'Weakness',NULL,NULL,'Resistance'),
(29,'Deep Accursed',800,1500,NULL,'Weakness',NULL,'Resistance','Weakness',NULL,'Weakness'),
(30,'Giant Slave',NULL,4000,'Resistance','Resistance','Resistance','Resistance',NULL,'Immunity',NULL),
(31,'Stray Demon',2004,5000,NULL,'Resistance','Resistance','Weakness','Immunity','Immunity','Immunity'),
(32,'Carthus Sand Worm',3180,6000,NULL,NULL,'Resistance',NULL,'Resistance','Immunity','Immunity'),
(33,'Sulyvahn\'s Beast',2296,8000,NULL,'Weakness',NULL,NULL,'Weakness','Weakness','Weakness'),
(34,'Ancient Wyvern',7873,70000,NULL,NULL,'Weakness',NULL,'Resistance','Resistance','Weakness'),
(35,'Iron Dragonslayer',4154,64000,NULL,NULL,'Resistance',NULL,'Immunity','Immunity','Weakness');
/*!40000 ALTER TABLE `bosses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bosslocation`
--

DROP TABLE IF EXISTS `bosslocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bosslocation` (
  `arena_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) DEFAULT NULL,
  `boss_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`arena_id`),
  KEY `location_id` (`location_id`),
  KEY `boss_id` (`boss_id`),
  CONSTRAINT `bosslocation_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `bosslocation_ibfk_2` FOREIGN KEY (`boss_id`) REFERENCES `bosses` (`boss_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bosslocation`
--

LOCK TABLES `bosslocation` WRITE;
/*!40000 ALTER TABLE `bosslocation` DISABLE KEYS */;
INSERT INTO `bosslocation` VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4),
(5,5,5),
(6,6,6),
(7,7,7),
(8,8,8),
(9,9,9),
(10,2,10),
(11,11,11),
(12,12,12),
(13,13,13),
(14,14,14),
(15,15,15),
(16,16,16),
(17,14,17),
(18,15,17),
(19,19,18),
(20,20,19),
(21,21,20),
(22,22,21),
(23,23,22),
(24,23,23),
(25,14,24),
(26,16,25),
(27,1,26),
(28,4,26),
(29,5,26),
(30,22,26),
(31,19,27),
(32,19,28),
(33,11,28),
(34,12,28),
(35,4,29),
(36,8,29),
(37,4,30),
(38,7,30),
(39,39,30),
(40,5,31),
(41,20,32),
(42,7,33),
(43,23,22),
(44,44,35),
(45,16,35);
/*!40000 ALTER TABLE `bosslocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) NOT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_name` (`location_name`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES
(8,'Anor Londo'),
(23,'Archdragon Peak'),
(6,'Catacombs of Carthus'),
(4,'Cathedral of the Deep'),
(1,'Cemetery of Ash'),
(21,'Consumed King\'s Garden'),
(5,'Farron Keep'),
(50,'Firelink Shrine'),
(12,'Grand Archives'),
(2,'High Wall of Lothric'),
(39,'Irithyll Dungeon'),
(7,'Irithyll of the Boreal Valley'),
(13,'Kiln of the First Flame'),
(11,'Lothric Castle'),
(14,'Painted World of Ariandel'),
(9,'Profaned Capital'),
(44,'Ringed City Streets'),
(3,'Road of Sacrifices'),
(20,'Smouldering Lake'),
(15,'The Dreg Heap'),
(16,'The Ringed City'),
(19,'Undead Settlement'),
(22,'Untended Graves');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `magic`
--

DROP TABLE IF EXISTS `magic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `magic` (
  `magic_id` int(11) NOT NULL AUTO_INCREMENT,
  `magic_name` varchar(255) NOT NULL,
  `effect` varchar(255) DEFAULT NULL,
  `fp_cost` int(11) DEFAULT NULL,
  `slots` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`magic_id`),
  KEY `location_id` (`location_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `magic_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `magic_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `soulitems` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `magic`
--

LOCK TABLES `magic` WRITE;
/*!40000 ALTER TABLE `magic` DISABLE KEYS */;
INSERT INTO `magic` VALUES
(1,'Heal Aid','Slightly restore HP',27,1,NULL,NULL),
(2,'Heal','Restore HP for self and vicinity',45,1,NULL,NULL),
(3,'Med Heal','Restore moderate HP for self and vicinity',55,1,NULL,NULL),
(4,'Great Heal','Restore high HP for self and vicinity',65,1,7,NULL),
(5,'Soothing Sunlight','Restore high HP for self and broad area',80,1,NULL,9),
(6,'Replenishment','Gradually restore HP',30,1,NULL,NULL),
(7,'Bountiful Light','Gradually restore high HP',45,1,NULL,NULL),
(8,'Bountiful Sunlight','Gradually restore high HP for self and broad area',70,2,NULL,NULL),
(9,'Projected Heal','Toss a light that heals those nearby impact point',55,1,15,NULL),
(10,'Caressing Tears','Cures ailments for self and vicinity',14,1,NULL,NULL),
(11,'Tears of Denial','Grant one chance to endure when HP reaches 0',100,2,NULL,NULL),
(12,'Homeward','Return caster to last bonfire rested at, or to shrine',30,1,NULL,NULL),
(13,'Seek Guidance','Reveal more help, and signs without using ember',15,1,4,NULL),
(14,'Sacred Oath','Boost ATK/DMG absorption for self and vicinity',65,2,NULL,NULL),
(15,'Force','Create shockwave',26,1,NULL,NULL),
(16,'Emit Force','Release shockwave in front',20,1,NULL,NULL),
(17,'Wrath of the Gods','Create powerful shockwave',40,2,9,NULL),
(18,'Way of White Corona','White discus slices into foes and returns to conjurer',15,1,14,NULL),
(19,'Lightning Arrow','Fire lightning arrow',19,1,16,NULL),
(20,'Lightning Spear','Hurl lightning spear',23,1,5,NULL),
(21,'Great Lightning Spear','Hurl giant lightning spear',32,1,NULL,NULL),
(22,'Sunlight Spear','Hurls sunlight spear',48,1,NULL,12),
(23,'Lightning Stake','Strike with a stake of lightning',34,1,20,NULL),
(24,'Lightning Storm','Call forth furious bolts of lightning',36,2,NULL,18),
(25,'Divine Pillars of Light','Bring down multiple pillars of light in vicinity',3,1,12,NULL),
(26,'Blessed Weapon','Bless right weapon',35,1,NULL,NULL),
(27,'Lightning Blade','Reinforce right weapon with lightning',50,1,39,NULL),
(28,'Darkmoon Blade','Reinforce right weapon with Darkmoon light',50,1,NULL,NULL),
(29,'Magic Barrier','Increases magic damage absorption with coating',30,1,NULL,NULL),
(30,'Great Magic Barrier','Greatly increase magic damage absorption with coating',40,2,23,NULL),
(31,'Dark Blade','Reinforce right weapon with dark',35,1,NULL,NULL),
(32,'Vow of Silence','Prevent spells in the vicinity, including one\'s own',35,2,NULL,NULL),
(33,'Dead Again','Bless corpses, transforming them into traps',45,1,NULL,NULL),
(34,'Atonement','Attract more attention from foes',15,1,5,NULL),
(35,'Deep Protection','Some extra ATK/absorption/resist/stamina recovery',25,1,NULL,NULL),
(36,'Gnaw','Summons insect swarm to feast on foes',15,1,NULL,NULL),
(37,'Dorhys\' Gnawing','Summon great insect swarm to feast on foes',20,1,7,NULL),
(38,'Lifehunt Scythe','Steals HP of foes using an illusory scythe',20,1,NULL,7),
(39,'Fireball','Hurls fireball',10,1,NULL,NULL),
(40,'Fire Orb','Hurls giant fire orb',14,1,NULL,NULL),
(41,'Bursting Fireball','Hurl a bursting fireball',14,1,NULL,NULL),
(42,'Great Chaos Fire Orb','Hurl a giant chaos fire orb',32,2,NULL,NULL),
(43,'Chaos Bed Vestiges','Hurl chaos flame that scorches vicinity',35,2,NULL,NULL),
(44,'Floating Chaos','Summons fire-spitting chaos orb',20,1,14,NULL),
(45,'Fire Surge','Emit a constant stream of fire',2,1,NULL,NULL),
(46,'Fire Whip','Sweep foes with fire whip',2,1,NULL,NULL),
(47,'Firestorm','Erect multiple fire pillars in vicinity',2,1,NULL,NULL),
(48,'Chaos Storm','Erect multiple chaos fire pillars in vicinity',3,2,NULL,NULL),
(49,'Great Combustion','Create powerful, giant flame in hand',17,1,NULL,NULL),
(50,'Flame Fan','Make a large sweep with a fan of flame',9,1,15,NULL),
(51,'Sacred Flame','Flame burrows inside foes and ignites',25,1,20,NULL),
(52,'Profaned Flame','Engulf foes at range and burn them to ashes.',30,1,39,NULL),
(53,'Seething Chaos','Hurl chaos clump that seethes and explodes',28,1,NULL,NULL),
(54,'Poison Mist','Create poison mist',18,1,NULL,NULL),
(55,'Toxic Mist','Create intense poison mist',24,1,20,NULL),
(56,'Acid Surge','Emit acid which corrodes weapons and armor',24,1,NULL,NULL),
(57,'Flash Sweat','Intense sweating increases fire damage absorption',20,1,NULL,NULL),
(58,'Profuse Sweat','Profuse sweating temporarily boosts all resistances',20,1,NULL,NULL),
(59,'Iron Flesh','Boost absorption/resistances, but increase weight',40,1,5,NULL),
(60,'Power Within','Temporarily boost attack, but gradually lose HP',30,1,12,NULL),
(61,'Carthus Beacon','Damage increases with consecutive attacks',35,2,NULL,NULL),
(62,'Carthus Flame Arc','Reinforce right weapon with flame',30,1,NULL,NULL),
(63,'Warmth','Create a gentle flame that restores HP on touch',50,2,NULL,NULL),
(64,'Rapport','Charm the enemy, making them a temporary ally',30,1,NULL,NULL),
(65,'Boulder Heave','Spews a boulder from one\'s mouth',17,1,NULL,NULL),
(66,'Black Flame','Create giant, black flame in hand',25,1,NULL,NULL),
(67,'Black Fire Orb','Hurl a black fireball',22,1,NULL,NULL),
(68,'Black Serpent','Release undulating black flame that runs along the ground',19,1,NULL,NULL),
(69,'Soul Arrow','Fire soul arrow',7,1,NULL,NULL),
(70,'Great Soul Arrow','Fire more powerful soul arrow',10,1,NULL,NULL),
(71,'Heavy Soul Arrow','Fire heavy soul arrow',11,1,NULL,NULL),
(72,'Great Heavy Soul Arrow','Fire more powerful heavy soul arrow',14,1,NULL,NULL),
(73,'Farron Dart','Fire soul dart',3,1,NULL,NULL),
(74,'Great Farron Dart','Fire more powerful soul dart',4,1,NULL,NULL),
(75,'Farron Hail','Fire cascade of soul darts',4,1,NULL,NULL),
(76,'Homing Soulmass','Release homing soulmass',20,1,NULL,NULL),
(77,'Homing Crystal Soulmass','Release homing crystal soulmass',43,1,NULL,NULL),
(78,'Crystal Hail','Cast cascade of small crystal soulmasses from sky',19,1,NULL,2),
(79,'Soul Spear','Fire soul spear',32,1,NULL,NULL),
(80,'Crystal Soul Spear','Fire piercing crystal soul spear',46,1,NULL,NULL),
(81,'White Dragon Breath','Emit crystal breath of Seath the Scaleless',25,1,NULL,16),
(82,'Soul Stream','Fire torrential volley of souls',55,2,12,NULL),
(83,'Soul Greatsword','Attack with a greatsword formed from souls',23,1,NULL,NULL),
(84,'Farron Flashsword','Attack with a sword formed from souls',4,1,NULL,NULL),
(85,'Old Moonlight','Conceive old moonlight sword and attack',23,1,NULL,19),
(86,'Magic Weapon','Reinforce right weapon with magic',25,1,NULL,NULL),
(87,'Great Magic Weapon','Greatly reinforce right weapon with magic',35,1,5,NULL),
(88,'Crystal Magic Weapon','Reinforce right weapon with crystal magic',45,1,NULL,NULL),
(89,'Frozen Weapon','Imbues right-hand weapon with frost',30,1,14,NULL),
(90,'Magic Shield','Reinforce left shield with magic',30,1,NULL,NULL),
(91,'Great Magic Shield','Greatly reinforce left shield with magic',60,1,39,NULL),
(92,'Spook','Mask noises of caster and prevent fall damage',15,1,NULL,NULL),
(93,'Aural Decoy','Distract foes with a distant sound',15,1,NULL,NULL),
(94,'Pestilent Mist','Release a cloud of mist that eats away at HP',13,1,NULL,NULL),
(95,'Snap Freeze','Creates cloud of near-freezing mist',16,1,14,NULL),
(96,'Cast Light','Cast light to illuminate surroundings',20,1,NULL,NULL),
(97,'Repair','Repair equipped weapons and armor',20,1,NULL,NULL),
(98,'Hidden Weapon','Turn right weapon invisible',25,1,NULL,NULL),
(99,'Hidden Body','Turn body nearly invisible',25,1,NULL,NULL),
(100,'Chameleon','Transform into something inconspicuous',20,1,NULL,NULL),
(101,'Twisted Wall of Light','Distort light in order to deflect magic',10,1,NULL,NULL),
(102,'Deep Soul','Fire darkened soul sediment',6,1,NULL,3),
(103,'Great Deep Soul','Fire powerful darkened soul sediment',9,1,NULL,NULL),
(104,'Great Soul Dregs','Fires great dark soul dregs',30,1,15,NULL),
(105,'Affinity','Cast dark manifestation of humanity',40,1,NULL,NULL),
(106,'Dark Edge','Strike with blade formed of humanity\'s darkness',26,1,NULL,NULL);
/*!40000 ALTER TABLE `magic` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER check_item_id_count_magic
BEFORE INSERT ON Magic
FOR EACH ROW
BEGIN
    DECLARE item_count INT;
    IF NEW.item_id IS NOT NULL THEN
        SELECT COUNT(*) INTO item_count FROM Magic WHERE item_id = NEW.item_id;
        IF item_count >= 3 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No soul can have more than 3 transposition';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `miracles`
--

DROP TABLE IF EXISTS `miracles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `miracles` (
  `magic_id` int(11) NOT NULL,
  `fth_req` int(11) DEFAULT NULL,
  PRIMARY KEY (`magic_id`),
  CONSTRAINT `miracles_ibfk_1` FOREIGN KEY (`magic_id`) REFERENCES `magic` (`magic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miracles`
--

LOCK TABLES `miracles` WRITE;
/*!40000 ALTER TABLE `miracles` DISABLE KEYS */;
INSERT INTO `miracles` VALUES
(1,8),
(2,12),
(3,15),
(4,25),
(5,45),
(6,15),
(7,25),
(8,35),
(9,28),
(10,12),
(11,15),
(12,18),
(13,12),
(14,28),
(15,12),
(16,18),
(17,30),
(18,18),
(19,35),
(20,20),
(21,30),
(22,40),
(23,35),
(24,45),
(25,30),
(26,15),
(27,30),
(28,30),
(29,15),
(30,25),
(31,25),
(32,30),
(33,23),
(34,18),
(35,20),
(36,18),
(37,25),
(38,22);
/*!40000 ALTER TABLE `miracles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyromancies`
--

DROP TABLE IF EXISTS `pyromancies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyromancies` (
  `magic_id` int(11) NOT NULL,
  `fth_req` int(11) DEFAULT NULL,
  `int_req` int(11) DEFAULT NULL,
  PRIMARY KEY (`magic_id`),
  CONSTRAINT `pyromancies_ibfk_1` FOREIGN KEY (`magic_id`) REFERENCES `magic` (`magic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyromancies`
--

LOCK TABLES `pyromancies` WRITE;
/*!40000 ALTER TABLE `pyromancies` DISABLE KEYS */;
INSERT INTO `pyromancies` VALUES
(39,6,6),
(40,8,8),
(41,12,18),
(42,NULL,NULL),
(43,10,20),
(44,16,16),
(45,NULL,6),
(46,8,13),
(47,NULL,18),
(48,NULL,NULL),
(49,10,10),
(50,15,15),
(51,8,8),
(52,NULL,25),
(53,18,18),
(54,10,NULL),
(55,15,NULL),
(56,13,NULL),
(57,6,6),
(58,6,6),
(59,NULL,8),
(60,10,10),
(61,12,12),
(62,10,10),
(63,25,NULL),
(64,NULL,15),
(65,12,8),
(66,15,15),
(67,20,20),
(68,15,15);
/*!40000 ALTER TABLE `pyromancies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ringlocation`
--

DROP TABLE IF EXISTS `ringlocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ringlocation` (
  `loot_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) DEFAULT NULL,
  `ring_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`loot_id`),
  KEY `location_id` (`location_id`),
  KEY `ring_id` (`ring_id`),
  CONSTRAINT `ringlocation_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `ringlocation_ibfk_2` FOREIGN KEY (`ring_id`) REFERENCES `rings` (`ring_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ringlocation`
--

LOCK TABLES `ringlocation` WRITE;
/*!40000 ALTER TABLE `ringlocation` DISABLE KEYS */;
INSERT INTO `ringlocation` VALUES
(1,19,1),
(2,11,1),
(3,22,1),
(4,8,2),
(5,50,3),
(6,22,4),
(7,19,5),
(8,7,5),
(9,3,5),
(10,16,5),
(11,23,6),
(12,8,6),
(13,16,6),
(14,7,7),
(15,7,7),
(16,4,7),
(17,15,7),
(18,23,9),
(19,22,9),
(20,6,9),
(21,15,9),
(22,21,10),
(23,5,10),
(24,9,10),
(25,19,11),
(26,9,11),
(27,20,11),
(28,23,12),
(29,6,12),
(30,11,12),
(31,8,13),
(32,11,13),
(33,5,13),
(34,20,14),
(35,1,14),
(36,19,15),
(37,20,15),
(38,4,16),
(39,19,16),
(40,14,17),
(41,9,18),
(42,12,19),
(43,2,19),
(44,11,20),
(45,12,21),
(46,12,22),
(47,39,24),
(48,7,24),
(49,23,24),
(50,16,24),
(51,50,25),
(52,39,25),
(53,19,25),
(54,15,25),
(55,4,27),
(56,39,30),
(57,3,31),
(58,6,32),
(59,3,33),
(60,7,34),
(61,5,35),
(62,3,35),
(63,12,35),
(64,3,36),
(65,12,36),
(66,21,36),
(67,39,37),
(68,7,38),
(69,5,39),
(70,1,39),
(71,16,39),
(72,19,40),
(73,22,41),
(74,6,42),
(75,4,43),
(76,2,43),
(77,16,43),
(78,21,45),
(79,21,47),
(80,7,47),
(81,19,48),
(82,7,49),
(83,23,50),
(84,19,51),
(85,9,52),
(86,11,53),
(87,4,55),
(88,6,57),
(89,6,58),
(90,7,59),
(91,8,61),
(92,4,62),
(93,8,68),
(94,23,70),
(95,2,71),
(96,4,71);
/*!40000 ALTER TABLE `ringlocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rings`
--

DROP TABLE IF EXISTS `rings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rings` (
  `ring_id` int(11) NOT NULL AUTO_INCREMENT,
  `ring_name` varchar(255) NOT NULL,
  `effect` varchar(255) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ring_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `rings_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `soulitems` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rings`
--

LOCK TABLES `rings` WRITE;
/*!40000 ALTER TABLE `rings` DISABLE KEYS */;
INSERT INTO `rings` VALUES
(1,'Life Ring','Raises maximum HP',0.3,NULL),
(2,'Sun Princess Ring','Gradually restores HP',0.6,NULL),
(3,'Estus Ring','Increases HP restored with Estus Flask',0.8,NULL),
(4,'Ashen Estus Ring','Increases FP restored with Ashen Estus Flask',0.8,NULL),
(5,'Chloranthy Ring','Raises stamina recovery speed',0.7,NULL),
(6,'Havel\'s Ring','Increases maximum load',1.5,20),
(7,'Ring of Favor','Increases HP, stamina, and maximum equip load',1.5,NULL),
(8,'Prisoner\'s Chain','Increases VGR, END and VIT, but take more damage',0.8,17),
(9,'Ring of Steel Protection','Increases physical damage absorption',0.8,NULL),
(10,'Magic Stoneplate Ring','Increases magic damage absorption',0.6,NULL),
(11,'Flame Stoneplate Ring','Increases Fire damage absorption',0.6,NULL),
(12,'Thunder Stoneplate Ring','Increases lightning damage absorption',0.6,NULL),
(13,'Dark Stoneplate Ring','Increases dark damage absorption',0.6,NULL),
(14,'Speckled Stoneplate Ring','Slightly increases magic, lightning, fire and dark damage absorption',0.9,NULL),
(15,'Bloodbite Ring','Increases bleed resistance',0.6,NULL),
(16,'Poisonbite Ring','Increases poison resistance',0.6,NULL),
(17,'Chillbite Ring','Increases frost resistance',0.6,NULL),
(18,'Cursebite Ring','Increases curse resistance',0.6,NULL),
(19,'Fleshbite Ring','Raises poison, bleed, curse and frost resist',0.9,NULL),
(20,'Knight\'s Ring','Increases strength',0.8,NULL),
(21,'Hunter\'s Ring','Increases dexterity',0.8,NULL),
(22,'Scholar Ring','Increases intelligence',0.6,NULL),
(23,'Priestess Ring','Increases faith',0.6,NULL),
(24,'Covetous Gold Serpent Ring','Fallen foes are more likely to drop items',1.2,NULL),
(25,'Covetous Silver Serpent Ring','Fallen foes yield more souls',1.2,NULL),
(26,'Saint\'s Ring','Allows attunement of additional spells',0.5,NULL),
(27,'Deep Ring','Allows attunement of additional spells',0.5,NULL),
(28,'Darkmoon Ring','Adds many slots for attunement',0.8,NULL),
(29,'Young Dragon Ring','Boosts sorceries',0.7,NULL),
(30,'Bellowing Dragoncrest Ring','Greatly boosts sorceries',1,NULL),
(31,'Great Swamp Ring','Boosts pyromancies',0.7,NULL),
(32,'Witch\'s Ring','Greatly boosts pyromancies',1,NULL),
(33,'Morne\'s Ring','Boosts miracles',0.7,NULL),
(34,'Ring of the Sun\'s First Born','Greatly boosts miracles',1,NULL),
(35,'Lingering Dragoncrest Ring','Extends length of spell effect',0.5,NULL),
(36,'Sage Ring','Shortens spell casting time',0.7,NULL),
(37,'Dusk Crown Ring','Reduces spell FP consumption, but also lowers HP',0.6,NULL),
(38,'Leo Ring','Strengthens thrust weapon counter attacks',0.5,NULL),
(39,'Wolf Ring','Increases poise',0.5,NULL),
(40,'Hawk Ring','Extends the range of bows',0.7,NULL),
(41,'Hornet Ring','Boosts critical attacks',1.1,NULL),
(42,'Knight Slayer\'s Ring','Enemies lose more stamina when guarding attacks',0.9,NULL),
(43,'Ring of the Evil Eye','Absorb HP from each defeated foe',1,NULL),
(44,'Farron Ring','Reduces Skill FP consumption',0.8,NULL),
(45,'Dragonscale Ring','Reduces damage from backstabs',1.1,NULL),
(46,'Horsehoof Ring','Boosts kick effect',0.6,NULL),
(47,'Wood Grain Ring','Slows equipment degradation',0.5,NULL),
(48,'Flynn\'s Ring','Lowering equip load increases attack',0.9,NULL),
(49,'Magic Clutch Ring','Increases magic attack but compromises damage absorption',0.8,NULL),
(50,'Lightning Clutch Ring','Increases lightning attack but compromises damage absorption',0.8,NULL),
(51,'Fire Clutch Ring','Increases Fire attack but compromises damage absorption',0.8,NULL),
(52,'Dark Clutch Ring','Increases dark attack but compromises damage absorption',0.8,NULL),
(53,'Red Tearstone Ring','Boosts attack when HP is low',1.4,NULL),
(54,'Blue Tearstone Ring','Increases damage absorption when HP is low',1.1,NULL),
(55,'Lloyd\'s Sword Ring','Boosts attacks when HP is full',0.9,NULL),
(56,'Lloyd\'s Shield Ring','Boosts damage absorption when HP is full',0.9,NULL),
(57,'Carthus Milkring','Slightly boosts dexterity and obscures rolling',0.8,NULL),
(58,'Carthus Bloodring','Boosts rolling invincibility, at the cost of defense',0.8,NULL),
(59,'Pontiff\'s Right Eye','Boosts attacks, as long attacking persists',1.4,NULL),
(60,'Pontiff\'s Left Eye','Recovers HP with successive attacks',0.9,1),
(61,'Aldrich\'s Ruby','Recovers HP from critical attacks',0.8,NULL),
(62,'Aldrich\'s Sapphire','Recovers FP from critical attacks',0.8,NULL),
(63,'Silvercat Ring','Prevents damage from falling',0.6,NULL),
(64,'Slumbering Dragoncrest Ring','Masks the sounds of its wearer',0.7,NULL),
(65,'Obscuring Ring','Obscures wearer while far away',0.9,NULL),
(66,'Untrue Dark Ring','Retain human appearance while hollow',0.7,NULL),
(67,'Untrue White Ring','Take the appearance of a phantom',0.7,NULL),
(68,'Reversal Ring','Males can perform female actions and vice versa',0.5,NULL),
(69,'Skull Ring','Easier to be detected by enemies',0.6,NULL),
(70,'Calamity Ring','Receive double damage',0.8,NULL),
(71,'Ring of Sacrifice','Lose nothing upon death, but ring breaks',1,NULL);
/*!40000 ALTER TABLE `rings` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER check_item_id_count_rings
BEFORE INSERT ON Rings
FOR EACH ROW
BEGIN
    DECLARE item_count INT;
    IF NEW.item_id IS NOT NULL THEN
        SELECT COUNT(*) INTO item_count FROM Rings WHERE item_id = NEW.item_id;
        IF item_count >= 3 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No soul can have more than 3 transposition';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sorceries`
--

DROP TABLE IF EXISTS `sorceries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sorceries` (
  `magic_id` int(11) NOT NULL,
  `int_req` int(11) DEFAULT NULL,
  PRIMARY KEY (`magic_id`),
  CONSTRAINT `sorceries_ibfk_1` FOREIGN KEY (`magic_id`) REFERENCES `magic` (`magic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sorceries`
--

LOCK TABLES `sorceries` WRITE;
/*!40000 ALTER TABLE `sorceries` DISABLE KEYS */;
INSERT INTO `sorceries` VALUES
(69,10),
(70,15),
(71,13),
(72,18),
(73,8),
(74,23),
(75,28),
(76,20),
(77,30),
(78,18),
(79,32),
(80,48),
(81,50),
(82,45),
(83,22),
(84,23),
(85,25),
(86,10),
(87,15),
(88,30),
(89,15),
(90,10),
(91,18),
(92,10),
(93,18),
(94,30),
(95,18),
(96,15),
(97,15),
(98,12),
(99,15),
(100,12),
(101,27),
(102,12),
(103,20),
(104,40),
(105,32),
(106,30);
/*!40000 ALTER TABLE `sorceries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `soulitems`
--

DROP TABLE IF EXISTS `soulitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `soulitems` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `boss_id` int(11) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `boss_id` (`boss_id`),
  CONSTRAINT `soulitems_ibfk_1` FOREIGN KEY (`boss_id`) REFERENCES `bosses` (`boss_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `soulitems`
--

LOCK TABLES `soulitems` WRITE;
/*!40000 ALTER TABLE `soulitems` DISABLE KEYS */;
INSERT INTO `soulitems` VALUES
(1,2,'Soul of Boreal Valley Vordt'),
(2,3,'Soul of a Crystal Sage'),
(3,4,'Soul of the Deacons of the Deep'),
(4,5,'Soul of the Blood of the Wolf'),
(5,6,'Soul of High Lord Wolnir'),
(6,7,'Soul of Pontiff Sulyvahn'),
(7,8,'Soul of Aldrich'),
(8,9,'Soul of Yhorm the Giant'),
(9,10,'Soul of the Dancer'),
(10,11,'Soul of Dragonslayer Armour'),
(11,12,'Soul of the Twin Princes'),
(12,13,'Soul of the Lords'),
(13,14,'Soul of Sister Friede'),
(14,18,'Soul of the Rotted Greatwood'),
(15,19,'Soul of the Old Demon King'),
(16,20,'Soul of Consumed Oceiros'),
(17,21,'Soul of Champion Gundyr'),
(18,23,'Soul of the Nameless King'),
(19,25,'Soul of Darkeater Midir'),
(20,31,'Soul of a Stray Demon');
/*!40000 ALTER TABLE `soulitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor` (
  `vendor_id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(255) NOT NULL,
  PRIMARY KEY (`vendor_id`),
  UNIQUE KEY `vendor_name` (`vendor_name`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES
(125,'Aldrich Faithful'),
(10,'Anri of Astora'),
(108,'Assassin'),
(6,'Blade of the Darkmoon'),
(27,'Braille Divine Tome of Carim'),
(29,'Braille Divine Tome of Lothric'),
(1,'Burial Gift'),
(57,'Carthus Pyromancy Tome'),
(25,'Cleric'),
(3,'Consumed King\'s Knight'),
(45,'Cornyx of the Great Swamp'),
(88,'Crystal Scroll'),
(43,'Deep Braille Divine Tome'),
(114,'Golden Scroll'),
(65,'Grave Warden Pyromancy Tome'),
(46,'Great Swamp Pyromancy Tome'),
(14,'Greirat of the Undead Settlement'),
(11,'Hawkwood the Deserter'),
(23,'Herald'),
(5,'Irina of Carim'),
(48,'Izalith Pyromancy Tome'),
(126,'Karla'),
(86,'Logan\'s Scroll'),
(40,'Londor Braille Divine Tome'),
(49,'Ludleth'),
(21,'Ludleth of Courland'),
(62,'Mound-makers'),
(121,'Old Woman of Londor'),
(8,'Orbeck of Vinheim'),
(51,'Quelana Pyromancy Tome'),
(18,'Rosaria\'s Fingers'),
(82,'Sage\'s Scroll'),
(2,'Shrine Handmaid'),
(35,'Siegward of Catarina'),
(16,'Sirris of the Sunless Realms'),
(68,'Sorcerer'),
(7,'Starting equipment'),
(89,'Transposed'),
(12,'Unbreakable Patches'),
(33,'Warrior of Sunlight'),
(9,'Watchdogs of Farron'),
(70,'Yoel of Londor'),
(19,'Yuria of Londor');
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendorcatalogmagic`
--

DROP TABLE IF EXISTS `vendorcatalogmagic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendorcatalogmagic` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(11) DEFAULT NULL,
  `magic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  KEY `vendor_id` (`vendor_id`),
  KEY `magic_id` (`magic_id`),
  CONSTRAINT `vendorcatalogmagic_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`),
  CONSTRAINT `vendorcatalogmagic_ibfk_2` FOREIGN KEY (`magic_id`) REFERENCES `magic` (`magic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendorcatalogmagic`
--

LOCK TABLES `vendorcatalogmagic` WRITE;
/*!40000 ALTER TABLE `vendorcatalogmagic` DISABLE KEYS */;
INSERT INTO `vendorcatalogmagic` VALUES
(1,23,1),
(2,2,1),
(3,25,2),
(4,5,2),
(5,27,3),
(6,5,6),
(7,29,7),
(8,5,10),
(9,27,11),
(10,5,12),
(11,33,14),
(12,27,15),
(13,35,16),
(14,33,21),
(15,29,26),
(16,6,28),
(17,29,29),
(18,40,31),
(19,40,32),
(20,40,33),
(21,43,35),
(22,43,36),
(23,45,39),
(24,46,40),
(25,46,41),
(26,48,42),
(27,49,43),
(28,45,45),
(29,51,46),
(30,51,47),
(31,48,48),
(32,45,49),
(33,21,53),
(34,46,54),
(35,57,56),
(36,45,57),
(37,46,58),
(38,57,61),
(39,57,62),
(40,62,63),
(41,51,64),
(42,49,65),
(43,65,66),
(44,65,67),
(45,49,68),
(46,68,69),
(47,2,69),
(48,70,69),
(49,19,69),
(50,8,69),
(51,8,70),
(52,68,71),
(53,8,71),
(54,19,71),
(55,70,71),
(56,8,72),
(57,2,73),
(58,8,73),
(59,8,74),
(60,82,74),
(61,8,75),
(62,82,75),
(63,8,76),
(64,86,76),
(65,8,77),
(66,88,77),
(67,89,78),
(68,8,79),
(69,86,79),
(70,8,80),
(71,88,80),
(72,89,81),
(73,70,83),
(74,19,83),
(75,8,83),
(76,8,84),
(77,89,85),
(78,70,86),
(79,19,86),
(80,8,86),
(81,8,88),
(82,88,88),
(83,70,90),
(84,19,90),
(85,8,90),
(86,108,92),
(87,8,92),
(88,8,93),
(89,8,94),
(90,82,94),
(91,8,96),
(92,114,96),
(93,8,97),
(94,114,97),
(95,8,98),
(96,114,98),
(97,8,99),
(98,114,99),
(99,121,100),
(100,8,101),
(101,114,101),
(102,89,102),
(103,125,103),
(104,126,105),
(105,126,106);
/*!40000 ALTER TABLE `vendorcatalogmagic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendorcatalogrings`
--

DROP TABLE IF EXISTS `vendorcatalogrings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendorcatalogrings` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(11) DEFAULT NULL,
  `ring_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  KEY `vendor_id` (`vendor_id`),
  KEY `ring_id` (`ring_id`),
  CONSTRAINT `vendorcatalogrings_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`),
  CONSTRAINT `vendorcatalogrings_ibfk_2` FOREIGN KEY (`ring_id`) REFERENCES `rings` (`ring_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendorcatalogrings`
--

LOCK TABLES `vendorcatalogrings` WRITE;
/*!40000 ALTER TABLE `vendorcatalogrings` DISABLE KEYS */;
INSERT INTO `vendorcatalogrings` VALUES
(1,1,1),
(2,2,1),
(3,3,10),
(4,2,23),
(5,5,26),
(6,6,28),
(7,7,29),
(8,8,29),
(9,9,39),
(10,10,43),
(11,11,44),
(12,12,46),
(13,2,47),
(14,14,54),
(15,2,56),
(16,16,63),
(17,8,64),
(18,18,65),
(19,19,66),
(20,19,67),
(21,21,69),
(22,19,71);
/*!40000 ALTER TABLE `vendorcatalogrings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weapons`
--

DROP TABLE IF EXISTS `weapons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weapons` (
  `weapon_id` int(11) NOT NULL AUTO_INCREMENT,
  `weapon_name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `special_atk` varchar(255) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `str_bonus` char(1) DEFAULT NULL,
  `dex_bonus` char(1) DEFAULT NULL,
  `fth_bonus` char(1) DEFAULT NULL,
  `int_bonus` char(1) DEFAULT NULL,
  `str_req` int(11) DEFAULT NULL,
  `dex_req` int(11) DEFAULT NULL,
  `fth_req` int(11) DEFAULT NULL,
  `int_req` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`weapon_id`),
  UNIQUE KEY `weapon_name` (`weapon_name`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `weapons_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `soulitems` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weapons`
--

LOCK TABLES `weapons` WRITE;
/*!40000 ALTER TABLE `weapons` DISABLE KEYS */;
INSERT INTO `weapons` VALUES
(1,'Dagger','Dagger',100,'Quickstep',1.5,'E','C',NULL,NULL,5,9,NULL,NULL,NULL),
(2,'Parrying Dagger','Dagger',100,'Parry',1,'E','C',NULL,NULL,5,14,NULL,NULL,NULL),
(3,'Mail Breaker','Dagger',100,'Shield Splitter',1.5,'E','D',NULL,NULL,7,12,NULL,NULL,NULL),
(4,'Harpe','Dagger',100,'Quickstep',1.5,'E','C',NULL,NULL,8,10,NULL,NULL,NULL),
(5,'Bandit\'s Knife','Dagger',100,'Quickstep',1.5,'D','D',NULL,NULL,6,12,NULL,NULL,NULL),
(6,'Rotten Ghru Dagger','Dagger',100,'Quickstep',2,'E','C',NULL,NULL,10,8,NULL,NULL,NULL),
(7,'Corvian Greatknife','Dagger',100,'Blind Spot',2.5,'E','E',NULL,NULL,12,16,NULL,NULL,NULL),
(8,'Murky Hand Scythe','Dagger',100,'Quickstep',2,'D','D','E','E',6,11,11,11,NULL),
(9,'Handmaid\'s Dagger','Dagger',1000,'Blind Spot',0.5,'E','E',NULL,NULL,4,8,NULL,NULL,NULL),
(10,'Scholar\'s Candlestick','Dagger',500,'Guiding Light',1.5,'E','C',NULL,NULL,7,NULL,16,NULL,NULL),
(11,'Aquamarine Dagger','Dagger',300,'Crystal Blade',1.5,'E','D',NULL,'D',5,14,NULL,18,NULL),
(12,'Tailbone Short Sword','Dagger',50,'Unleash Dragon',2,'E','E',NULL,NULL,8,14,NULL,NULL,NULL),
(13,'Brigand Twindaggers','Dagger',100,'Quickstep',2.5,'D','D',NULL,NULL,10,18,NULL,NULL,NULL),
(14,'Shortsword','Straight Sword',100,'Stance',2,'D','C',NULL,NULL,8,10,NULL,NULL,NULL),
(15,'Long Sword','Straight Sword',100,'Stance',3,'D','D',NULL,NULL,10,10,NULL,NULL,NULL),
(16,'Broadsword','Straight Sword',100,'Stance',3,'C','D',NULL,NULL,10,10,NULL,NULL,NULL),
(17,'Broken Straight Sword','Straight Sword',3,'Stance',1,'D','D',NULL,NULL,8,8,NULL,NULL,NULL),
(18,'Astora Straight Sword','Straight Sword',100,'Stance',3,'D','E',NULL,NULL,10,10,12,NULL,NULL),
(19,'Lothric Knight Sword','Straight Sword',500,'Stance',4,'D','D',NULL,NULL,11,18,NULL,NULL,NULL),
(20,'Barbed Straight Sword','Straight Sword',100,'Stance',3,'D','D',NULL,NULL,11,11,NULL,NULL,NULL),
(21,'Dark Sword','Straight Sword',500,'Stomp',4.5,'C','D',NULL,NULL,16,15,NULL,NULL,NULL),
(22,'Cleric\'s Candlestick','Straight Sword',1000,'Guiding Light',2,'D','D',NULL,'C',8,12,12,NULL,3),
(23,'Irithyll Straight Sword','Straight Sword',500,'Stance',4,'D','D',NULL,NULL,12,14,NULL,NULL,NULL),
(24,'Anri\'s Straight Sword','Straight Sword',500,'Stance',3,'E','E','E',NULL,10,10,NULL,NULL,NULL),
(25,'Sunlight Straight Sword','Straight Sword',500,'Oath of Sunlight',3,'D','D','C',NULL,12,12,16,NULL,NULL),
(26,'Morion Blade','Straight Sword',1000,'Stance',4,'D','D',NULL,NULL,12,17,NULL,NULL,NULL),
(27,'Ringed Knight Straight Sword','Straight Sword',800,'Ember',4.5,'C','D','E','E',17,15,NULL,NULL,NULL),
(28,'Lothric\'s Holy Sword','Straight Sword',1000,'Sacred Lothric Light',4,'D','D','E',NULL,10,18,14,NULL,11),
(29,'Gotthard Twinswords','Straight Sword',500,'Spin Slash',6.5,'D','D',NULL,NULL,12,18,NULL,NULL,NULL),
(30,'Valorheart','Straight Sword',500,'Lion Stance',5.5,'D','D',NULL,NULL,12,12,NULL,NULL,NULL),
(31,'Bastard Sword','Greatsword',300,'Stomp',8,'D','D',NULL,NULL,16,10,NULL,NULL,NULL),
(32,'Claymore','Greatsword',100,'Stance',9,'D','D',NULL,NULL,16,13,NULL,NULL,NULL),
(33,'Flamberge','Greatsword',300,'Stance',8.5,'D','D',NULL,NULL,15,14,NULL,NULL,NULL),
(34,'Drakeblood Greatsword','Greatsword',100,'Stance',6,'D','D',NULL,NULL,18,16,NULL,NULL,NULL),
(35,'Executioner\'s Greatsword','Greatsword',100,'Stomp',9,'C','E',NULL,NULL,19,13,NULL,NULL,NULL),
(36,'Black Knight Sword','Greatsword',500,'Perseverance',10,'D','D',NULL,NULL,20,18,NULL,NULL,NULL),
(37,'Onyx Blade','Greatsword',500,'Elfriede\'s Blackflame',9,'E','E','D','D',14,12,15,15,NULL),
(38,'Hollowslayer Greatsword','Greatsword',100,'Stance',8.5,'D','C',NULL,NULL,14,18,NULL,NULL,14),
(39,'Wolnir\'s Holy Sword','Greatsword',1000,'Wrath of the Gods',7.5,'D','E','D',NULL,13,13,13,NULL,5),
(40,'Greatsword of Judgment','Greatsword',1000,'Stance of Judgment',9,'D','D',NULL,'C',17,15,NULL,12,6),
(41,'Storm Ruler','Greatsword',NULL,'Storm King',8,'D','D',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(42,'Wolf Knight\'s Greatsword','Greatsword',1000,'Wolf Sword',11.5,'C','D',NULL,NULL,24,18,NULL,NULL,4),
(43,'Moonlight Greatsword','Greatsword',2000,'Moonlight Vortex',10.5,'E',NULL,NULL,'C',16,11,NULL,26,16),
(44,'Firelink Greatsword','Greatsword',2000,'Ember',9,'D','D',NULL,NULL,20,10,10,10,12),
(45,'Twin Princes\' Greatsword','Greatsword',2000,'Sacred Light and Flame',9.5,'D','D','D','D',22,14,NULL,NULL,NULL),
(46,'Gael\'s Greatsword','Greatsword',2000,'Blade of Peril',9,'C','D',NULL,NULL,19,13,NULL,NULL,NULL),
(47,'Zweihander','Ultra Greatsword',150,'Stomp',10,'D','D',NULL,NULL,19,11,NULL,NULL,NULL),
(48,'Greatsword','Ultra Greatsword',100,'Stomp',20,'D','D',NULL,NULL,28,10,NULL,NULL,NULL),
(49,'Astora Greatsword','Ultra Greatsword',100,'Charge',8,'D','C',NULL,NULL,16,18,NULL,NULL,NULL),
(50,'Lothric Knight Greatsword','Ultra Greatsword',350,'Stomp',16.5,'D','D',NULL,NULL,24,16,NULL,NULL,NULL),
(51,'Cathedral Knight Greatsword','Ultra Greatsword',200,'Stomp',15,'C','E',NULL,NULL,26,10,NULL,NULL,NULL),
(52,'Black Knight Greatsword','Ultra Greatsword',500,'Stomp',16,'C','D',NULL,NULL,30,18,NULL,NULL,NULL),
(53,'Fume Ultra Greatsword','Ultra Greatsword',100,'Stomp',25.5,'A','E',NULL,NULL,50,10,NULL,NULL,NULL),
(54,'Profaned Greatsword','Ultra Greatsword',1000,'Profaned Flame',13.5,'C','D',NULL,NULL,22,10,NULL,NULL,6),
(55,'Lorian\'s Greatsword','Ultra Greatsword',1000,'Flame of Lorian',14,'D','D','D','D',26,10,NULL,NULL,11),
(56,'Ringed Knight Paired Greatswords','Ultra Greatsword',1000,'Ember',22.5,'C','E','E','E',40,15,NULL,NULL,NULL),
(57,'Farron Greatsword','Ultra Greatsword',1000,'Parry',12.5,'D','C',NULL,NULL,18,20,NULL,NULL,4),
(58,'Scimitar','Curved Sword',100,'Spin Slash',2.5,'E','B',NULL,NULL,7,13,NULL,NULL,NULL),
(59,'Falchion','Curved Sword',100,'Spin Slash',4,'D','D',NULL,NULL,9,13,NULL,NULL,NULL),
(60,'Shotel','Curved Sword',200,'Spin Slash',2.5,'E','C',NULL,NULL,9,14,NULL,NULL,NULL),
(61,'Carthus Curved Sword','Curved Sword',150,'Spin Slash',5.5,'D','D',NULL,NULL,15,18,NULL,NULL,NULL),
(62,'Carthus Shotel','Curved Sword',150,'Spin Slash',3,'E','C',NULL,NULL,12,19,NULL,NULL,NULL),
(63,'Rotten Ghru Curved Sword','Curved Sword',100,'Spin Slash',2,'E','C',NULL,NULL,10,13,NULL,NULL,NULL),
(64,'Painting Guardian\'s Curved Sword','Curved Sword',100,'Chained Dance',1.5,'E','B',NULL,NULL,7,19,NULL,NULL,NULL),
(65,'Follower Sabre','Curved Sword',100,'Prying Wedge',4,'D','D',NULL,NULL,9,14,NULL,NULL,NULL),
(66,'Pontiff Knight Curved Sword','Curved Sword',300,'Frost Blade',3.5,'D','D',NULL,NULL,12,18,NULL,10,NULL),
(67,'Crescent Moon Sword','Curved Sword',1000,'Crescent Blade',2.5,NULL,'C',NULL,'D',10,16,NULL,NULL,NULL),
(68,'Storm Curved Sword','Curved Sword',1000,'Tornado',5,'D','C',NULL,NULL,14,20,NULL,NULL,18),
(69,'Demon\'s Scar','Curved Sword',1500,'Spin Slash',0.5,NULL,'E','D','D',NULL,16,17,17,NULL),
(70,'Sellsword Twinblades','Curved Sword',100,'Spin Slash',5.5,'E','C',NULL,NULL,10,16,NULL,NULL,NULL),
(71,'Warden Twinblades','Curved Sword',70,'Spin Slash',6.5,'D','D',NULL,NULL,10,18,NULL,NULL,NULL),
(72,'Dancer\'s Enchanted Swords','Curved Sword',1000,'Dancer\'s Grace',8.5,'D','D','D','D',12,20,9,9,9),
(73,'Murakumo','Curved Greatsword',150,'Spin Slash',11,'D','C',NULL,NULL,20,18,NULL,NULL,NULL),
(74,'Carthus Curved Greatsword','Curved Greatsword',150,'Spin Slash',10.5,'D','C',NULL,NULL,18,22,NULL,NULL,NULL),
(75,'Exile Greatsword','Curved Greatsword',150,'Spin Slash',17,'C','D',NULL,NULL,24,16,NULL,NULL,NULL),
(76,'Harald Curved Greatsword','Curved Greatsword',500,'Sever',14,'D','D',NULL,NULL,22,18,NULL,NULL,NULL),
(77,'Old Wolf Curved Sword','Curved Greatsword',1000,'Wolf Leap',13,'D','C',NULL,NULL,19,25,NULL,NULL,NULL),
(78,'Rapier','Thrusting Sword',100,'Stance',2,'E','C',NULL,NULL,7,12,NULL,NULL,NULL),
(79,'Estoc','Thrusting Sword',300,'Shield Splitter',3.5,'D','D',NULL,NULL,10,12,NULL,NULL,NULL),
(80,'Ricard\'s Rapier','Thrusting Sword',500,'Ricard\'s Lunge and Press',2.5,'D','C',NULL,NULL,8,20,NULL,NULL,NULL),
(81,'Irithyll Rapier','Thrusting Sword',1000,'Shield Splitter',3,'D','D',NULL,NULL,10,16,NULL,NULL,NULL),
(82,'Crystal Sage\'s Rapier','Thrusting Sword',1000,'Stance',2.5,'E','E',NULL,'C',13,18,NULL,NULL,2),
(83,'Crow Quills','Thrusting Sword',100,'Quill Dart',4,'E','C',NULL,NULL,9,16,NULL,NULL,NULL),
(84,'Uchigatana','Katana',100,'Hold',5.5,'E','C',NULL,NULL,11,16,NULL,NULL,NULL),
(85,'Washing Pole','Katana',500,'Hold',8.5,'E','D',NULL,NULL,18,20,NULL,NULL,NULL),
(86,'Black Blade','Katana',300,'Hold',6.5,'E','C',NULL,NULL,18,18,NULL,NULL,NULL),
(87,'Bloodlust','Katana',500,'Bloodlust',5,'E','C',NULL,NULL,11,24,NULL,NULL,NULL),
(88,'Chaos Blade','Katana',500,'Hold',6,'E','A',NULL,NULL,16,14,NULL,NULL,NULL),
(89,'Darkdrift','Katana',500,'Darkdrift',3.5,'E','D',NULL,NULL,10,28,NULL,NULL,NULL),
(90,'Frayed Blade','Katana',1500,'Hold',8,'E','B',NULL,NULL,11,40,NULL,NULL,19),
(91,'Onikiri and Ubadachi','Katana',300,'Onislayer',8.5,'D','C',NULL,NULL,13,25,NULL,NULL,NULL),
(92,'Hand Axe','Axe',100,'Warcry',2.5,'D','D',NULL,NULL,9,8,NULL,NULL,NULL),
(93,'Thrall Axe','Axe',30,'Quickstep',1.5,'D','D',NULL,NULL,8,8,NULL,NULL,NULL),
(94,'Battle Axe','Axe',120,'Warcry',4,'D','D',NULL,NULL,12,8,NULL,NULL,NULL),
(95,'Brigand Axe','Axe',100,'Warcry',3,'D','D',NULL,NULL,14,8,NULL,NULL,NULL),
(96,'Dragonslayer\'s Axe','Axe',100,'Warcry',4,'D','E',NULL,NULL,18,14,NULL,NULL,NULL),
(97,'Millwood Battle Axe','Axe',100,'Warcry',6.5,'C','E',NULL,NULL,15,10,NULL,NULL,NULL),
(98,'Man Serpent Hatchet','Axe',100,'Warcry',4,'D','D',NULL,NULL,16,13,NULL,NULL,NULL),
(99,'Butcher Knife','Axe',500,'Sharpen',7,'A',NULL,NULL,NULL,24,NULL,NULL,NULL,NULL),
(100,'Eleonora','Axe',500,'Feast Bell',6.5,'D','E',NULL,NULL,20,8,NULL,NULL,NULL),
(101,'Winged Knight Twinaxess','Axe',150,'Chain Spin',8.5,'D','D',NULL,NULL,20,12,NULL,NULL,NULL),
(102,'Greataxe','Greataxe',150,'Warcry',16,'D','E',NULL,NULL,32,8,NULL,NULL,NULL),
(103,'Great Machete','Greataxe',200,'Sharpen',14,'D','E',NULL,NULL,24,10,NULL,NULL,NULL),
(104,'Black Knight Greataxe','Greataxe',500,'Warcry',19.5,'C','D',NULL,NULL,36,18,NULL,NULL,NULL),
(105,'Demon\'s Greataxe','Greataxe',1000,'Demonic Flare',14.5,'C','E','D','D',28,NULL,12,12,NULL),
(106,'Dragonslayer Greataxe','Greataxe',1000,'Falling Bolt',20,'D','E','D',NULL,40,NULL,NULL,NULL,10),
(107,'Yhorm\'s Great Machete','Greataxe',1000,'Warcry',19,'C',NULL,NULL,NULL,38,10,NULL,NULL,8),
(108,'Earth Seeker','Greataxe',500,'Earthen Wrath',17,'C',NULL,'D',NULL,24,NULL,15,NULL,NULL),
(109,'Club','Hammer',50,'Warcry',2.5,'C',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(110,'Reinforced Club','Hammer',70,'Warcry',4,'C',NULL,NULL,NULL,12,NULL,NULL,NULL,NULL),
(111,'Mace','Hammer',100,'Perseverance',5,'C','E',NULL,NULL,12,7,NULL,NULL,NULL),
(112,'Morning Star','Hammer',100,'Perseverance',5,'D','E',NULL,NULL,11,9,NULL,NULL,NULL),
(113,'Warpick','Hammer',100,'Galvanize',4.5,'C','E',NULL,NULL,12,10,NULL,NULL,NULL),
(114,'Blacksmith Hammer','Hammer',500,'Perseverance',5,'C',NULL,NULL,NULL,13,13,NULL,NULL,NULL),
(115,'Heysel Pick','Hammer',1500,'Steady Chant',4.5,'D','E',NULL,'B',12,10,NULL,19,NULL),
(116,'Drang Hammers','Hammer',350,'Spin Bash',9,'C','E',NULL,NULL,18,16,NULL,NULL,NULL),
(117,'Large Club','Great Hammer',75,'Warcry',10,'C',NULL,NULL,NULL,22,NULL,NULL,NULL,NULL),
(118,'Great Club','Great Hammer',75,'Warcry',12,'C',NULL,NULL,NULL,28,NULL,NULL,NULL,NULL),
(119,'Great Mace','Great Hammer',150,'Perseverance',18,'D',NULL,NULL,NULL,32,NULL,NULL,NULL,NULL),
(120,'Spiked Mace','Great Hammer',100,'Spin Bash',16,'C',NULL,NULL,NULL,21,13,NULL,NULL,NULL),
(121,'Pickaxe','Great Hammer',100,'Galvanize',8,'C',NULL,NULL,NULL,18,9,NULL,NULL,NULL),
(122,'Great Wooden Hammer','Great Hammer',100,'Spin Bash',6,'C',NULL,NULL,NULL,18,NULL,NULL,NULL,NULL),
(123,'Gargoyle Flame Hammer','Great Hammer',800,'Kindled Flurry',11,'D',NULL,'E','E',22,NULL,9,9,NULL),
(124,'Morne\'s Great Hammer','Great Hammer',1000,'Morne\'s Rage',24,'D',NULL,'D',NULL,50,NULL,30,NULL,NULL),
(125,'Smough\'s Great Hammer','Great Hammer',1000,'Perseverance',24,'C',NULL,NULL,NULL,45,NULL,NULL,NULL,NULL),
(126,'Quakestone Hammer','Great Hammer',300,'Quake',15,'C',NULL,NULL,NULL,40,NULL,NULL,NULL,NULL),
(127,'Ledo\'s Great Hammer','Great Hammer',100,'Call to Stone',28,'B',NULL,NULL,NULL,60,NULL,NULL,NULL,NULL),
(128,'Vordt\'s Great Hammer','Great Hammer',1000,'Perseverance',17,'C',NULL,NULL,NULL,30,NULL,NULL,NULL,1),
(129,'Old King\'s Great Hammer','Great Hammer',1000,'Molten Perseverance',18.5,'D',NULL,'D','D',30,NULL,10,10,15),
(130,'Dragon Tooth','Great Hammer',500,'Perseverance',21,'C',NULL,NULL,NULL,40,NULL,NULL,NULL,NULL),
(131,'Spear','Spear',100,'Shield Splitter',4.5,'D','C',NULL,NULL,11,10,NULL,NULL,NULL),
(132,'Winged Spear','Spear',100,'Charge',6,'D','C',NULL,NULL,12,15,NULL,NULL,NULL),
(133,'Partizan','Spear',100,'Spin Sweep',6.5,'D','D',NULL,NULL,14,12,NULL,NULL,NULL),
(134,'Rotten Ghru Spear','Spear',50,'Charge',5.5,'D','D',NULL,NULL,10,12,NULL,NULL,NULL),
(135,'Four-Pronged Plow','Spear',100,'Charge',6.5,'D','D',NULL,NULL,13,11,NULL,NULL,NULL),
(136,'Saint Bident','Spear',1000,'Charge',8.5,'D','E','C',NULL,12,12,16,NULL,NULL),
(137,'Follower Javelin','Spear',100,'Hurl Spear',4,'C','E',NULL,NULL,12,12,NULL,NULL,NULL),
(138,'Gargoyle Flame Spear','Spear',800,'Kindled Charge',9.5,'E','D','E','E',15,18,9,9,NULL),
(139,'Soldering Iron','Spear',100,'Charge',5,'D','D',NULL,NULL,10,12,NULL,NULL,NULL),
(140,'Yorshka\'s Spear','Spear',1000,'Pacify',6.5,'D','D','D',NULL,18,14,13,NULL,NULL),
(141,'Dragonslayer Spear','Spear',1000,'Lightning Charge',9.5,'D','C','D',NULL,20,20,NULL,NULL,NULL),
(142,'Golden Ritual Spear','Spear',1000,'Steady Chant',3,'E','D','B',NULL,10,10,14,18,NULL),
(143,'Tailbone Spear','Spear',70,'Unleash Dragon',4.5,'E','D',NULL,NULL,13,15,NULL,NULL,NULL),
(144,'Arstor\'s Spear','Spear',1000,'Shield Splitter',6.5,'D','C',NULL,NULL,11,19,NULL,NULL,14),
(145,'Dragonslayer Swordspear','Spear',1000,'Falling Bolt',14.5,'D','D','D',NULL,16,22,18,NULL,18),
(146,'Drang Twinspears','Spear',350,'Charge',8,'D','C',NULL,NULL,14,20,NULL,NULL,NULL),
(147,'Pike','Pike',100,'Charge',7.5,'D','C',NULL,NULL,18,14,NULL,NULL,NULL),
(148,'Greatlance','Pike',100,'Charge',10.5,'D','D',NULL,NULL,21,16,NULL,NULL,NULL),
(149,'Lothric Knight Long Spear','Pike',300,'Charge',8,'D','D',NULL,NULL,14,20,NULL,NULL,NULL),
(150,'Lothric War Banner','Pike',500,'Lothric War Banner',5,'D','D',NULL,NULL,14,14,NULL,NULL,NULL),
(151,'Ringed Knight Spear','Pike',800,'Ember',9,'D','D','E','E',15,17,NULL,NULL,NULL),
(152,'Halberd','Halberd',100,'Charge',8,'D','D',NULL,NULL,16,12,NULL,NULL,NULL),
(153,'Red Hilted Halberd','Halberd',100,'Perseverance',8,'D','D',NULL,NULL,14,14,NULL,NULL,NULL),
(154,'Lucerne','Halberd',100,'Spin Sweep',7.5,'D','D',NULL,NULL,15,13,NULL,NULL,NULL),
(155,'Glaive','Halberd',100,'Spin Sweep',11,'D','E',NULL,NULL,17,11,NULL,NULL,NULL),
(156,'Crescent Axe','Halberd',300,'Warcry',6,'D','D',NULL,NULL,14,12,NULL,NULL,NULL),
(157,'Winged Knight Halberd','Halberd',300,'Chain Spin',14,'D','E',NULL,NULL,26,16,NULL,NULL,NULL),
(158,'Splitleaf Greatsword','Halberd',500,'Wind Wheel',13.5,'C','E',NULL,NULL,26,16,NULL,NULL,NULL),
(159,'Black Knight Glaive','Halberd',500,'Spin Sweep',9,'D','D',NULL,NULL,28,18,NULL,NULL,NULL),
(160,'Crucifix of the Mad King','Halberd',800,'Mad King\'s Folly',12,'D',NULL,'D','E',19,NULL,14,10,NULL),
(161,'Immolation Tinder','Halberd',200,'Punitive Flame',10,'D','D',NULL,'B',18,18,12,12,NULL),
(162,'Gundyr\'s Halberd','Halberd',1000,'Champion\'s Charge',13,'C','E',NULL,NULL,30,15,NULL,NULL,17),
(163,'Great Scythe','Reaper',100,'Neck Swipe',7,'E','C',NULL,NULL,14,14,NULL,NULL,NULL),
(164,'Great Corvian Scythe','Reaper',30,'Neck Swipe',9,'D','C',NULL,NULL,16,18,NULL,NULL,NULL),
(165,'Pontiff Knight Great Scythe','Reaper',300,'Frost',7.5,'E','A',NULL,NULL,14,19,12,NULL,NULL),
(166,'Friede\'s Great Scythe','Reaper',1000,'Elfriede\'s Stance',13,'E','B','E','C',12,16,11,12,13),
(167,'Whip','Whip',100,'Impact',2,NULL,'C',NULL,NULL,6,14,NULL,NULL,NULL),
(168,'Notched Whip','Whip',150,'Impact',2,NULL,'D',NULL,NULL,6,19,NULL,NULL,NULL),
(169,'Spotted Whip','Whip',400,'Impact',2.5,NULL,'D',NULL,NULL,9,20,NULL,NULL,NULL),
(170,'Witch\'s Locks','Whip',1000,'Flame Whip',3,NULL,'D','C','C',9,17,12,12,NULL),
(171,'Rose of Ariandel','Whip',1000,'Awakening',3.5,'C','E','B',NULL,10,12,17,NULL,13),
(172,'Caestus','Fist',100,'Perseverance',0.5,'D','D',NULL,NULL,5,8,NULL,NULL,NULL),
(173,'Demon\'s Fist','Fist',1000,'Flame Whirlwind',5.5,'D',NULL,'E','E',20,8,9,9,NULL),
(174,'Dark Hand','Fist',1000,'Lifedrain',0,'C','C','D','D',NULL,NULL,NULL,NULL,NULL),
(175,'Claw','Claw',100,'Leaping Slash',1.5,'E','C',NULL,NULL,6,14,NULL,NULL,NULL),
(176,'Manikin Claws','Claw',100,'Quickstep',1.5,'E','C',NULL,NULL,8,18,NULL,NULL,NULL),
(177,'Crow Talons','Claw',100,'Raptor Flurry',3,'E','C',NULL,NULL,6,19,NULL,NULL,NULL),
(178,'Torch','Torch',50,'None',1,'D',NULL,NULL,NULL,5,NULL,NULL,NULL,NULL),
(179,'Follower Torch','Torch',100,'Breathe Fire',6,'D','E','E','E',14,NULL,10,10,NULL),
(180,'Short Bow','Bow',100,'Rapid Fire',2,'E','D',NULL,NULL,7,12,NULL,NULL,NULL),
(181,'Composite Bow','Bow',150,'Rapid Fire',3.5,'D','D',NULL,NULL,12,12,NULL,NULL,NULL),
(182,'Longbow','Bow',100,'Puncture',4,'E','D',NULL,NULL,9,14,NULL,NULL,NULL),
(183,'Black Bow of Pharis','Bow',150,'Pharis Triple-shot',3,'E','C',NULL,NULL,9,18,NULL,NULL,NULL),
(184,'White Birch Bow','Bow',300,'Unseen Arrow',2.5,'E','D',NULL,NULL,8,20,NULL,NULL,NULL),
(185,'Dragonrider Bow','Bow',300,'Puncture',6.5,'D','E',NULL,NULL,19,15,NULL,NULL,NULL),
(186,'Darkmoon Longbow','Bow',1000,'Darkmoon Arrow',4.5,NULL,'E',NULL,'C',7,16,NULL,10,7),
(187,'Dragonslayer Greatbow','Greatbow',1000,'Puncturing Arrow',10,'D','D',NULL,NULL,20,20,NULL,NULL,NULL),
(188,'Onislayer Greatbow','Greatbow',300,'Puncturing Arrow',7.5,'E','C',NULL,NULL,18,24,NULL,NULL,NULL),
(189,'Millwood Greatbow','Greatbow',1000,'Pierce Earth',9,'C','E',NULL,NULL,28,12,NULL,NULL,NULL),
(190,'Light Crossbow','Crossbow',100,'Tackle',3,NULL,NULL,NULL,NULL,10,8,NULL,NULL,NULL),
(191,'Heavy Crossbow','Crossbow',100,'Tackle',4.5,NULL,NULL,NULL,NULL,14,8,NULL,NULL,NULL),
(192,'Sniper Crossbow','Crossbow',100,'Tackle',7.5,NULL,NULL,NULL,NULL,18,16,NULL,NULL,NULL),
(193,'Arbalest','Crossbow',100,'Tackle',6,NULL,NULL,NULL,NULL,18,8,NULL,NULL,NULL),
(194,'Knight\'s Crossbow','Crossbow',500,'Tackle',4,NULL,NULL,NULL,NULL,12,8,NULL,NULL,NULL),
(195,'Avelyn','Crossbow',1000,'Tackle',7.5,NULL,NULL,NULL,NULL,16,14,NULL,NULL,NULL),
(196,'Repeating Crossbow','Crossbow',1000,'Repeat Fire',7.5,NULL,NULL,NULL,NULL,16,20,NULL,NULL,NULL),
(197,'Sorcerer\'s Staff','Staff',100,'Steady Chant',2,'E',NULL,NULL,'B',6,NULL,NULL,10,NULL),
(198,'Heretic\'s Staff','Staff',500,'Steady Chant',3,'D',NULL,NULL,'B',8,NULL,NULL,16,NULL),
(199,'Court Sorcerer\'s Staff','Staff',800,'Steady Chant',2,'E',NULL,NULL,'A',6,NULL,NULL,14,NULL),
(200,'Witchtree Branch','Staff',100,'Steady Chant',2,'E',NULL,NULL,'C',7,NULL,NULL,18,NULL),
(201,'Storyteller\'s Staff','Staff',50,'Poison Spores',2.5,'E',NULL,NULL,'B',6,NULL,NULL,12,NULL),
(202,'Mendicant\'s Staff','Staff',200,'Steady Chant',2.5,'D',NULL,NULL,'B',7,NULL,NULL,18,NULL),
(203,'Murky Longstaff','Staff',300,'Chant from the Depths',3,'D','D','E','B',6,NULL,NULL,12,NULL),
(204,'Izalith Staff','Staff',500,'Steady Chant',3,'D','D','C','B',12,NULL,10,14,NULL),
(205,'Man-grub\'s Staff','Staff',NULL,'Steady Chant',3,'D',NULL,NULL,NULL,9,NULL,NULL,18,NULL),
(206,'Preacher\'s Right Arm','Staff',300,'Feasting Branch',2,'E',NULL,NULL,'A',12,NULL,NULL,14,NULL),
(207,'Sage\'s Crystal Staff','Staff',1000,'Steady Chant',2.5,'E',NULL,NULL,'B',7,NULL,NULL,24,NULL),
(208,'Archdeacon\'s Great Staff','Staff',1000,'Steady Chant',2.5,'D',NULL,'A',NULL,8,NULL,12,12,NULL),
(209,'Pyromancy Flame','Pyromancy Flame',100,'Combustion',0,NULL,NULL,'C','C',NULL,NULL,NULL,NULL,NULL),
(210,'Pyromancer\'s Parting Flame','Pyromancy Flame',500,'Parting Flame',0,NULL,NULL,'D','D',15,NULL,13,13,NULL),
(211,'Cleric\'s Sacred Chime','Sacred Chime',100,'Gentle Prayer',0.5,'D',NULL,'A',NULL,3,NULL,14,NULL,NULL),
(212,'Priest\'s Chime','Sacred Chime',300,'Gentle Prayer',0.5,'E',NULL,'B',NULL,3,NULL,10,NULL,NULL),
(213,'Saint-tree Bellvine','Sacred Chime',100,'Gentle Prayer',0.5,'E',NULL,'C',NULL,3,NULL,18,NULL,NULL),
(214,'Yorshka\'s Chime','Sacred Chime',100,'Gentle Prayer',0.5,'D',NULL,'A',NULL,3,NULL,30,NULL,NULL),
(215,'Caitha\'s Chime','Sacred Chime',500,'Gentle Prayer',0.5,'E',NULL,'B','C',3,NULL,12,12,NULL),
(216,'Crystal Chime','Sacred Chime',500,'Gentle Prayer',0.5,'E',NULL,'D','D',3,NULL,18,18,NULL),
(217,'Sacred Chime of Filianore','Sacred Chime',300,'Pray for Favor',0.5,'E',NULL,'C',NULL,4,NULL,18,NULL,NULL),
(218,'Buckler','Small Shield',300,'Parry',1.5,'E',NULL,NULL,NULL,7,13,NULL,NULL,NULL),
(219,'Target Shield','Small Shield',150,'Parry',2,'E',NULL,NULL,NULL,8,11,NULL,NULL,NULL),
(220,'Small Leather Shield','Small Shield',100,'Parry',2,'E',NULL,NULL,NULL,7,NULL,NULL,NULL,NULL),
(221,'Leather Shield','Small Shield',80,'Parry',1.5,'E',NULL,NULL,NULL,7,NULL,NULL,NULL,NULL),
(222,'Crimson Parma','Small Shield',100,'Parry',1.5,'E',NULL,NULL,NULL,7,NULL,NULL,NULL,NULL),
(223,'Red and White Shield','Small Shield',70,'Parry',1.5,'E',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(224,'Caduceus Round Shield','Small Shield',65,'Parry',1.5,'E',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(225,'Elkhorn Round Shield','Small Shield',100,'Parry',1.5,'E',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(226,'Warrior\'s Round Shield','Small Shield',100,'Weapon Skill',1.5,'E',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(227,'Plank Shield','Small Shield',2,'Shield Bash',1,'E',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(228,'Ghru Rotshield','Small Shield',5,'Shield Bash',1.5,'E',NULL,NULL,NULL,5,NULL,NULL,NULL,NULL),
(229,'Iron Round Shield','Small Shield',30,'Parry',2,'E',NULL,NULL,NULL,5,NULL,NULL,NULL,NULL),
(230,'Hawkwood\'s Shield','Small Shield',100,'Parry',2,'E',NULL,NULL,NULL,5,NULL,NULL,NULL,NULL),
(231,'Llewellyn Shield','Small Shield',100,'Parry',3,'D',NULL,NULL,NULL,12,NULL,NULL,NULL,NULL),
(232,'Eastern Iron Shield','Small Shield',300,'Weapon Skill',3,'D',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(233,'Golden Falcon Shield','Small Shield',250,'Parry',2.5,'D',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(234,'Sacred Bloom Shield','Small Shield',150,'Spell Parry',1.5,'D',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(235,'Dragonhead Shield','Small Shield',500,'Dragon Breath',4.5,'D',NULL,'E','E',12,NULL,12,11,NULL),
(236,'Large Leather Shield','Medium Shield',100,'Parry',3.5,'D',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(237,'Carthus Shield','Medium Shield',130,'Parry',2.5,'D',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(238,'East-West Shield','Medium Shield',100,'Parry',2,'D',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(239,'Blue Wooden Shield','Medium Shield',75,'Parry',2.5,'D',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(240,'Round Shield','Medium Shield',100,'Parry',3.5,'D',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(241,'Wooden Shield','Medium Shield',50,'Parry',2.5,'D',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(242,'Wargod Wooden Shield','Medium Shield',200,'Weapon Skill',4,'D',NULL,NULL,NULL,12,NULL,NULL,NULL,NULL),
(243,'Follower Shield','Medium Shield',100,'Weapon Skill',3.5,'D',NULL,NULL,NULL,9,NULL,NULL,NULL,NULL),
(244,'Kite Shield','Medium Shield',100,'Parry',4.5,'D',NULL,NULL,NULL,12,NULL,NULL,NULL,NULL),
(245,'Silver Eagle Kite Shield','Medium Shield',170,'Weapon Skill',5,'D',NULL,NULL,NULL,11,NULL,NULL,NULL,NULL),
(246,'Knight Shield','Medium Shield',120,'Parry',4.5,'D',NULL,NULL,NULL,13,NULL,NULL,NULL,NULL),
(247,'Lothric Knight Shield','Medium Shield',350,'Parry',6,'D',NULL,NULL,NULL,18,NULL,NULL,NULL,NULL),
(248,'Spider Shield','Medium Shield',150,'Weapon Skill',3.5,'D',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(249,'Sunset Shield','Medium Shield',100,'Parry',5,'D',NULL,NULL,NULL,12,NULL,NULL,NULL,NULL),
(250,'Sunlight Shield','Medium Shield',500,'Parry',5.5,'D',NULL,NULL,NULL,12,NULL,NULL,NULL,NULL),
(251,'Stone Parma','Medium Shield',100,'Weapon Skill',7,'D',NULL,NULL,NULL,17,NULL,NULL,NULL,NULL),
(252,'Spiked Shield','Medium Shield',210,'Shield Strike',3.5,'D',NULL,NULL,NULL,12,12,NULL,NULL,NULL),
(253,'Pierce Shield','Medium Shield',10,'Shield Bash',3.5,'D',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(254,'Porcine Shield','Medium Shield',35,'Shield Bash',4.5,'D',NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
(255,'Grass Crest Shield','Medium Shield',500,'Parry',4.5,'D',NULL,NULL,NULL,10,NULL,NULL,NULL,NULL),
(256,'Crest Shield','Medium Shield',300,'Parry',5,'D',NULL,NULL,NULL,14,NULL,NULL,NULL,NULL),
(257,'Dragon Crest Shield','Medium Shield',500,'Parry',5,'D',NULL,NULL,NULL,14,NULL,NULL,NULL,NULL),
(258,'Spirit Tree Crest Shield','Medium Shield',100,'Parry',5,'D',NULL,NULL,NULL,14,NULL,NULL,NULL,NULL),
(259,'Golden Wing Crest Shield','Medium Shield',250,'Spell Parry',5.5,'D',NULL,NULL,NULL,14,NULL,NULL,NULL,NULL),
(260,'Pontiff Knight Shield','Medium Shield',300,'Weapon Skill',3.5,'D',NULL,NULL,NULL,8,12,NULL,NULL,NULL),
(261,'Black Knight Shield','Medium Shield',500,'Weapon Skill',7.5,'D',NULL,NULL,NULL,18,NULL,NULL,NULL,NULL),
(262,'Silver Knight Shield','Medium Shield',500,'Parry',6.5,'D',NULL,NULL,NULL,16,NULL,NULL,NULL,NULL),
(263,'Ethereal Oak Shield','Medium Shield',300,'Weapon Skill',5,'D',NULL,NULL,NULL,12,NULL,NULL,NULL,NULL),
(264,'Shield of Want','Medium Shield',500,'Weapon Skill',5.5,'D',NULL,NULL,NULL,18,NULL,NULL,NULL,NULL),
(265,'Twin Dragon Greatshield','Greatshield',350,'Shield Bash',7,'D',NULL,NULL,NULL,16,NULL,NULL,NULL,NULL),
(266,'Black Iron Greatshield','Greatshield',500,'Shield Bash',14.5,'D',NULL,NULL,NULL,32,NULL,NULL,NULL,NULL),
(267,'Lothric Knight Greatshield','Greatshield',350,'Shield Bash',15,'D',NULL,NULL,NULL,36,NULL,NULL,NULL,NULL),
(268,'Cathedral Knight Greatshield','Greatshield',300,'Shield Bash',15.5,'D',NULL,NULL,NULL,32,NULL,NULL,NULL,NULL),
(269,'Stone Greatshield','Greatshield',300,'Shield Bash',18,'D',NULL,NULL,NULL,38,NULL,NULL,NULL,NULL),
(270,'Bonewheel Shield','Greatshield',90,'Wheel of Fate',15,'D',NULL,NULL,NULL,30,10,NULL,NULL,NULL),
(271,'Ancient Dragon Greatshield','Greatshield',300,'Weapon Skill',6.5,'D',NULL,NULL,NULL,16,NULL,NULL,NULL,NULL),
(272,'Greatshield of Glory','Greatshield',100,'Shield Bash',18.5,'D',NULL,NULL,NULL,40,NULL,NULL,NULL,NULL),
(273,'Moaning Shield','Greatshield',1000,'Moan',21.5,'D',NULL,NULL,NULL,50,NULL,NULL,NULL,NULL),
(274,'Wolf Knight\'s Greatshield','Greatshield',1000,'Weapon Skill',11,'D',NULL,NULL,NULL,30,NULL,NULL,NULL,NULL),
(275,'Havel\'s Greatshield','Greatshield',500,'Stone Flesh',28,'D',NULL,NULL,NULL,40,NULL,NULL,NULL,NULL),
(276,'Curse Ward Greatshield','Greatshield',100,'Weapon Skill',17,'D',NULL,NULL,NULL,34,NULL,NULL,NULL,NULL),
(277,'Dragonslayer Greatshield','Greatshield',1000,'Shield Bash',26,'D',NULL,NULL,NULL,38,NULL,NULL,NULL,10),
(278,'Yhorm\'s Greatshield','Greatshield',1000,'Shield Bash',20.5,'D',NULL,NULL,NULL,40,NULL,NULL,NULL,8),
(279,'Dragonhead Greatshield','Greatshield',500,'Dragon Roar',18,'D',NULL,'E',NULL,35,NULL,15,NULL,NULL),
(280,'Giant Door Shield','Greatshield',300,'Lockout',21.5,'C',NULL,NULL,NULL,45,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `weapons` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER check_item_id_count
BEFORE INSERT ON Weapons
FOR EACH ROW
BEGIN
    DECLARE item_count INT;
    IF NEW.item_id IS NOT NULL THEN
        SELECT COUNT(*) INTO item_count FROM Weapons WHERE item_id = NEW.item_id;
        IF item_count >= 3 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No soul have more than 3 transposition';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-08-02 16:42:21

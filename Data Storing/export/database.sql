-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: seleksi
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Email` varchar(255) NOT NULL,
  `Nama` varchar(255) NOT NULL,
  `Telepon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `Nama` varchar(255) NOT NULL,
  `Asal_restoran` varchar(255) DEFAULT NULL,
  `Harga` decimal(10,2) DEFAULT NULL,
  `Resep` text,
  PRIMARY KEY (`Nama`),
  KEY `FK_Menu_Restaurant` (`Asal_restoran`),
  CONSTRAINT `FK_Menu_Restaurant` FOREIGN KEY (`Asal_restoran`) REFERENCES `restaurant` (`Nama`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner`
--

DROP TABLE IF EXISTS `owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owner` (
  `Email` varchar(255) NOT NULL,
  `Nama` varchar(255) NOT NULL,
  `Telepon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ownership`
--

DROP TABLE IF EXISTS `ownership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ownership` (
  `Email_pemilik` varchar(255) NOT NULL,
  `Nama_restoran` varchar(255) NOT NULL,
  PRIMARY KEY (`Email_pemilik`,`Nama_restoran`),
  KEY `FK_Ownership_Restaurant` (`Nama_restoran`),
  CONSTRAINT `FK_Ownership_Owner` FOREIGN KEY (`Email_pemilik`) REFERENCES `owner` (`Email`),
  CONSTRAINT `FK_Ownership_Restaurant` FOREIGN KEY (`Nama_restoran`) REFERENCES `restaurant` (`Nama`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ownership`
--

LOCK TABLES `ownership` WRITE;
/*!40000 ALTER TABLE `ownership` DISABLE KEYS */;
/*!40000 ALTER TABLE `ownership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `Nama` varchar(255) NOT NULL,
  `Alamat` varchar(255) DEFAULT NULL,
  `Telepon` varchar(100) DEFAULT NULL,
  `Website` varchar(255) DEFAULT NULL,
  `Instagram` varchar(255) DEFAULT NULL,
  `Facebook` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Nama`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES ('A Casa do Porco','Rua Araújo, nº 124 Centro, São Paulo, Brazil','+551132582578','https://acasadoporco.com.br/','https://www.instagram.com/acasadoporcobar/','https://www.facebook.com/acasadoporcobar'),('Alchemist','Refshalevej 173C, 1432 Copenhagen, Denmark','+4531716161','https://alchemist.dk/','https://www.instagram.com/restaurantalchemist/','https://www.facebook.com/Alchemist.CPH'),('Arpège','84 Rue de Varenne, 75007 Paris, France','+33147050906','https://www.alain-passard.com/','https://www.instagram.com/alain_passard',NULL),('Asador Etxebarri','San Juan Plaza, 1, 48291 Axpe, Bizkaia, Spain','+34946583042','https://www.asadoretxebarri.com/','https://www.instagram.com/asadoretxebarrioficial/',NULL),('Atomix','104 E. 30th St. New York, NY 10016, USA',NULL,'https://www.atomixnyc.com/','https://www.instagram.com/atomixnyc/','https://www.facebook.com/atomixnyc'),('Belcanto','Rua Serpa Pinto, 10 A, 1200-445 Lisbon, Portugal','+351213420607','https://belcanto.pt/','https://www.instagram.com/belcanto_joseavillez/','https://www.facebook.com/belcantojoseavillez'),('Boragó','San José María Escrivá de Balaguer 5970, Región Metropolitana, Santiago, 7640804, Chile','+56229538893','https://borago.cl/','https://www.instagram.com/rgborago/','https://www.facebook.com/borago.restaurante'),('Den','Japan, 150-0001 Tokyo, Shibuya City, Jingumae, 2 Chome-3-18','+81364555433','https://www.jimbochoden.com/','https://www.instagram.com/zaiyuhasegawa/',NULL),('Disfrutar','Villarroel 163, 08036 Barcelona, Spain','+34933486896','https://www.disfrutarbarcelona.com/','https://www.instagram.com/disfrutarbcn/','https://www.facebook.com/disfrutarbcn'),('Diverxo','NH Eurobuilding, C. del Padre Damián, 23, 28036 Madrid, Spain','+34915700766','https://diverxo.com/','https://www.instagram.com/dabizdiverxo/',NULL),('Don Julio','Guatemala 4691, Palermo Viejo, Buenos Aires, Argentina','+541148319564','https://www.parrilladonjulio.com/','https://www.instagram.com/pablojesusrivero/',NULL),('El Chato','Calle 65 # 4-76 , Chapinero Alto 110221, Bogotá, Colombia','+576017439931','https://elchato.co/','https://www.instagram.com/elchato_rest/',NULL),('Elkano','Herrerieta Kalea, 2, 20808 Getaria, Gipuzkoa, Spain','+34943140024','https://www.restauranteelkano.com/','https://www.instagram.com/elkano_jatetxea/','https://www.facebook.com/RestauranteElkano/'),('Florilège','Japan, 105-0001 Tokyo, Minato City, Toranomon, 5 Chome-10-7','+81364358018','https://www.aoyama-florilege.jp/','https://www.instagram.com/restaurant_florilege/',NULL),('Frantzén','Klara Norra Kyrkogatan 26, 11122 Stockholm, Sweden','+4608208580','https://www.restaurantfrantzen.com/','https://instagram.com/restaurantfrantzen','https://www.facebook.com/restaurantfrantzen'),('Gaggan','68 Sukhumvit 31, Khlong Tan Nuea, Watthana, Bangkok 10110, Thailand','+66988831022','http://gaggananand.com/','https://www.facebook.com/Chefgaggananand/','https://www.facebook.com/Chefgaggananand/'),('Hiša Franko','Staro selo 1, 5222 Kobarid, Slovenia','+38653894120','https://www.hisafranko.com/','https://www.instagram.com/hisafranko/','https://www.facebook.com/hisa.franko/'),('Ikoyi','180 The Strand, London, Greater London, WC2R 1EA, UK','+4402035834660','https://ikoyilondon.com/','https://www.instagram.com/ikoyi_london/',NULL),('Kjolle','Av. Pedro de Osma 301, Barranco,15063 Lima, Peru','+5112428575','https://kjolle.com/default.html','https://www.instagram.com/kjollerest/','https://www.facebook.com/kjollerest'),('Kol','Lower Ground Floor, 9 Seymour St, London W1H 7BA, UK','+4402038296888','https://kolrestaurant.com/','https://www.instagram.com/kol.restaurant/','https://www.facebook.com/kolrestaurantldn'),('La Colombe','Silvermist Wine Estate, Main Road, Constantia Nek, Cape Town, 7806, South Africa','+27217942390','http://www.lacolombe.co.za/','https://www.instagram.com/lacolombect','https://www.facebook.com/LaColombeRestaurant/'),('Le Du','399/3 Silom 7 Alley, Silom, Bang Rak, Bangkok 10500, Thailand','+66929199969','https://www.ledubkk.com/','https://www.instagram.com/ledubkk/','https://www.facebook.com/Ledurestaurant/'),('Lido 84','Corso Zanardelli 196, 25083, Gardone Riviera (BS), Italy','+39036520019','https://www.ristorantelido84.com/','https://www.instagram.com/ristorantelido84/','https://www.facebook.com/ristorantelido84ChefCamanini'),('Maido','San Martín 399, Miraflores, Lima, Peru','+51013135100','https://www.maido.pe/','https://www.instagram.com/mitsuharu_maido','https://www.facebook.com/MaidoLima/'),('Mayta','Mariscal La Mar Avenue 1285, Miraflores, Lima, Peru, 15074','+51937220734','https://www.maytalima.com/','https://www.instagram.com/maytalima/','https://www.facebook.com/maytarestaurante/'),('Mingles','Seoul, Gangnam-gu, Dosan-daero 67-gil, 19',NULL,'http://www.restaurant-mingles.com/','https://www.instagram.com/mingles_restaurant/',NULL),('Nobelhart & Schmutzig','Friedrichstraße 218, 10969 Berlin, Germany','+493025940610','https://www.nobelhartundschmutzig.com/en/','https://www.instagram.com/nobelhartundschmutzig/','https://www.facebook.com/Nobelhartundschmutzig/'),('Odette','1 St Andrew\'s Rd, #01-04 National Gallery, Singapore 178957','+6563850498','https://www.odetterestaurant.com/','https://www.instagram.com/odetterestaurant/?hl=en','https://www.facebook.com/odetterestaurant'),('Oteque','Rua Conde de Irajá 581, Botafogo, Rio de Janeiro, Brazil','+552134865758','http://www.oteque.com/','https://www.instagram.com/albertolandgraf',NULL),('Piazza Duomo','Piazza Risorgimento 4, Alba (CN) 12051, Italy','+390173366167','https://www.piazzaduomoalba.it/','https://www.instagram.com/PiazzaDuomoAlba/','https://www.facebook.com/piazzaduomoalba/'),('Plénitude','Cheval Blanc Paris 8, Quai du Louvre, 75001 Paris, France','+330140280000','https://www.chevalblanc.com/fr/maison/paris/restaurants-et-bars/plenitude/','https://www.instagram.com/chevalblancparis/',NULL),('Pujol','Tennyson 133, Polanco, Polanco IV Secc, Miguel Hidalgo, 11550 Mexico City, Mexico','+525555454111','https://pujol.com.mx/','https://www.instagram.com/pujolrestaurant/',NULL),('Quintonil','Newton 55, Polanco, 11560, Mexico City, Mexico','+525552802680','https://quintonil.com/','https://www.instagram.com/rest_quintonil/','https://www.facebook.com/quintonil/'),('Quique Dacosta','Carrer Rascassa, 1, 03700 Dénia, Alicante, Spain','+34965784179','https://www.quiquedacosta.es/','https://www.instagram.com/qiqedacosta/','https://www.facebook.com/qiqedacosta/'),('Reale','Piana Santa Liberata, 67031, Castel di Sangro (AQ), Italy','+39086469382','http://www.nikoromito.com/','https://www.instagram.com/ristorantereale/','https://www.facebook.com/RistoranteReale'),('Restaurant Tim Raue','Rudi-Dutschke-Strasse 26, 10969 Berlin, Germany','+4903025937930','https://tim-raue.com/','https://www.instagram.com/restauranttimraue/','https://www.facebook.com/restaurant.tim.raue'),('Rosetta','Colima 166, Colonia Roma Norte 06700, Mexico City, Mexico','+525555337804','https://rosetta.com.mx/','https://www.instagram.com/restauranterosetta/','https://www.facebook.com/RestauranteRosetta'),('Schloss Schauenstein','Obergass 15, CH-7414 Fürstenau, Switzerland','+41816321080','https://www.schauenstein.ch/home','https://www.instagram.com/andreas_caminada_schauenstein/','https://www.facebook.com/profile.php?id=100064434769681'),('Septime','80, Rue de Charonne, Paris 11, France','+33143673829','https://www.septime-charonne.fr/','https://www.instagram.com/septimeparis/',NULL),('Sézanne','1 Chome-11-1 Marunouchi, Chiyoda City, Tokyo 100-6277, Japan','+81352225810','https://www.sezanne.tokyo/','https://www.instagram.com/sezannetokyo/','https://www.facebook.com/SezanneTokyo'),('SingleThread','131 North St, Healdsburg, CA 95448, USA','+17077234646','https://www.singlethreadfarms.com/','https://instagram.com/singlethreadfarms','https://www.facebook.com/SingleThreadFarmsRestaurantandInn'),('Sorn','56 Soi Sukhumvit 26, Klongton Khlong Toei, Bangkok 10110, Thailand','+66990811119',NULL,'https://www.instagram.com/sornfinesouthern/',NULL),('Steirereck','Steirereck, Am Heumarkt 2A im Stadtpark A-1030 Vienna, Austria','+4317133168','https://www.steirereck.at/','https://www.instagram.com/steirereck_stadtpark/',NULL),('Sühring','10 Yen Akat Soi 3, Chongnonsi, Yannawa, Bangkok 10120','+6621072777','https://restaurantsuhring.com/','https://instagram.com/restaurant_suhring','https://www.facebook.com/suhringtwins'),('Table by Bruno Verjus','3 rue de Prague, 75012 Paris, France',NULL,'https://table.paris/','https://www.instagram.com/bruno_verjus/',NULL),('The Chairman','3rd Floor, The Wellington, 198 Wellington St, Central, Hong Kong','+85225552202','http://thechairmangroup.com/','https://www.instagram.com/thechairmanrestauranthk/','https://www.facebook.com/TheChairmanRestaurant/'),('The Jane','Paradeplein 1, 2018 Antwerp, Belgium','+3238084465','https://www.thejaneantwerp.com/','https://www.instagram.com/thejaneantwerp/','https://www.facebook.com/thejaneantwerp/'),('Trèsind Studio','St. Regis Gardens - The Palm Jumeirah - Dubai - United Arab Emirates','+971588951272','https://tresindstudio.com/','https://www.instagram.com/tresindstudio/','https://www.facebook.com/tresindstudio/'),('Uliassi','Via Banchina di Levante 6, 60019 Senigallia, Ancona, Italy','+3907165463','https://www.uliassi.com/','https://www.instagram.com/ristoranteuliassi/','https://www.facebook.com/mauro.uliassi.1'),('Wing','29/F The Wellington, 198 Wellington St, Central, Hong Kong','+85227110063','http://wingrestaurant.hk/','https://www.instagram.com/wingrestaurant_hk/','https://www.facebook.com/wingrestauranthk/');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `Email_customer` varchar(255) NOT NULL,
  `Nama_restoran` varchar(255) NOT NULL,
  `Rating` int DEFAULT NULL,
  `Comment` text,
  PRIMARY KEY (`Email_customer`,`Nama_restoran`),
  KEY `FK_Review_Restaurant` (`Nama_restoran`),
  CONSTRAINT `FK_Review_Customer` FOREIGN KEY (`Email_customer`) REFERENCES `customer` (`Email`),
  CONSTRAINT `FK_Review_Restaurant` FOREIGN KEY (`Nama_restoran`) REFERENCES `restaurant` (`Nama`),
  CONSTRAINT `CHECK_Rating` CHECK (((`Rating` >= 0) and (`Rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-02  2:31:19

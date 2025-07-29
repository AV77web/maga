-- MySQL dump 10.13  Distrib 8.4.5, for Win64 (x86_64)
--
-- Host: localhost    Database: maga
-- ------------------------------------------------------
-- Server version	8.4.5

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
-- Table structure for table `an_anagrafiche`
--

DROP TABLE IF EXISTS `an_anagrafiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_anagrafiche` (
  `idanagrafica` int NOT NULL AUTO_INCREMENT,
  `codice` varchar(20) NOT NULL,
  `ragione_sociale` varchar(255) NOT NULL,
  `tipo` enum('','Azienda','Privato','Ente pubblico') NOT NULL,
  `piva` varchar(16) NOT NULL,
  `codice_fiscale` varchar(16) NOT NULL,
  `capitale_sociale` decimal(15,6) NOT NULL DEFAULT '0.000000',
  `data_nascita` date DEFAULT NULL,
  `luogo_nascita` varchar(255) NOT NULL,
  `sesso` enum('','M','F') NOT NULL,
  `indirizzo` varchar(255) NOT NULL,
  `indirizzo2` varchar(255) NOT NULL,
  `citta` varchar(255) NOT NULL,
  `cap` varchar(10) NOT NULL,
  `provincia` varchar(2) NOT NULL,
  `km` decimal(10,2) NOT NULL,
  `id_nazione` int DEFAULT NULL,
  `telefono` varchar(50) NOT NULL,
  `fax` varchar(50) NOT NULL,
  `cellulare` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `pec` varchar(255) NOT NULL,
  `sitoweb` varchar(255) NOT NULL,
  `note` text NOT NULL,
  `codiceri` varchar(15) NOT NULL,
  `codicerea` varchar(23) DEFAULT NULL,
  `riferimento_amministrazione` varchar(255) DEFAULT NULL,
  `appoggiobancario` varchar(255) NOT NULL,
  `filiale` varchar(100) NOT NULL,
  `codiceiban` varchar(40) NOT NULL,
  `bic` varchar(25) NOT NULL,
  `diciturafissafattura` varchar(255) NOT NULL,
  `idpagamento_vendite` int DEFAULT NULL,
  `idpagamento_acquisti` int DEFAULT NULL,
  `id_piano_sconto_vendite` int DEFAULT NULL,
  `id_piano_sconto_acquisti` int DEFAULT NULL,
  `id_listino` int NOT NULL,
  `idiva_vendite` int DEFAULT NULL,
  `idiva_acquisti` int DEFAULT NULL,
  `id_ritenuta_acconto_vendite` int DEFAULT NULL,
  `id_ritenuta_acconto_acquisti` int DEFAULT NULL,
  `idsede_fatturazione` int NOT NULL,
  `idconto_cliente` int NOT NULL,
  `idbanca_vendite` int DEFAULT NULL,
  `idbanca_acquisti` int DEFAULT NULL,
  `idconto_fornitore` int NOT NULL,
  `id_settore` int NOT NULL,
  `marche` varchar(5000) NOT NULL,
  `dipendenti` int NOT NULL,
  `macchine` int NOT NULL,
  `idagente` int NOT NULL,
  `idrelazione` int NOT NULL,
  `id_provenienza` int DEFAULT NULL,
  `agentemaster` tinyint(1) NOT NULL,
  `idzona` int NOT NULL,
  `foro_competenza` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cognome` varchar(255) NOT NULL,
  `iscrizione_tribunale` varchar(2) NOT NULL,
  `n_alboartigiani` varchar(25) DEFAULT NULL,
  `colore` varchar(7) NOT NULL DEFAULT '#FFFFFF',
  `idtipointervento_default` int DEFAULT NULL,
  `id_dichiarazione_intento_default` int DEFAULT NULL,
  `provvigione_default` decimal(15,6) NOT NULL,
  `gaddress` varchar(255) DEFAULT NULL,
  `lat` float(10,6) DEFAULT NULL,
  `lng` float(10,6) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `codice_destinatario` varchar(7) DEFAULT NULL,
  `split_payment` tinyint(1) NOT NULL DEFAULT '0',
  `enable_newsletter` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idanagrafica`),
  KEY `id_nazione` (`id_nazione`),
  KEY `idtipointervento_default` (`idtipointervento_default`),
  KEY `id_dichiarazione_intento_default` (`id_dichiarazione_intento_default`),
  CONSTRAINT `an_anagrafiche_ibfk_1` FOREIGN KEY (`id_nazione`) REFERENCES `an_nazioni` (`id`),
  CONSTRAINT `an_anagrafiche_ibfk_2` FOREIGN KEY (`idtipointervento_default`) REFERENCES `in_tipiintervento` (`id`),
  CONSTRAINT `an_anagrafiche_ibfk_3` FOREIGN KEY (`id_dichiarazione_intento_default`) REFERENCES `co_dichiarazioni_intento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_anagrafiche`
--

LOCK TABLES `an_anagrafiche` WRITE;
/*!40000 ALTER TABLE `an_anagrafiche` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_anagrafiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_anagrafiche_agenti`
--

DROP TABLE IF EXISTS `an_anagrafiche_agenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_anagrafiche_agenti` (
  `idanagrafica` int NOT NULL,
  `idagente` int NOT NULL,
  PRIMARY KEY (`idanagrafica`,`idagente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_anagrafiche_agenti`
--

LOCK TABLES `an_anagrafiche_agenti` WRITE;
/*!40000 ALTER TABLE `an_anagrafiche_agenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_anagrafiche_agenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_assicurazione_crediti`
--

DROP TABLE IF EXISTS `an_assicurazione_crediti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_assicurazione_crediti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_anagrafica` int NOT NULL,
  `data_inizio` date DEFAULT NULL,
  `data_fine` date DEFAULT NULL,
  `fido_assicurato` decimal(15,6) NOT NULL,
  `totale` decimal(15,6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_assicurazione_crediti`
--

LOCK TABLES `an_assicurazione_crediti` WRITE;
/*!40000 ALTER TABLE `an_assicurazione_crediti` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_assicurazione_crediti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_mansioni`
--

DROP TABLE IF EXISTS `an_mansioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_mansioni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_mansioni`
--

LOCK TABLES `an_mansioni` WRITE;
/*!40000 ALTER TABLE `an_mansioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_mansioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_nazioni`
--

DROP TABLE IF EXISTS `an_nazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_nazioni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iso2` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_nazioni`
--

LOCK TABLES `an_nazioni` WRITE;
/*!40000 ALTER TABLE `an_nazioni` DISABLE KEYS */;
INSERT INTO `an_nazioni` VALUES (2,''),(3,''),(4,''),(5,''),(6,''),(7,''),(8,''),(9,''),(10,''),(11,''),(12,''),(13,''),(14,''),(15,''),(16,''),(17,''),(18,''),(19,''),(20,''),(21,''),(22,''),(23,''),(24,''),(25,''),(26,''),(27,''),(28,''),(29,''),(30,''),(31,''),(32,''),(33,''),(34,''),(35,''),(36,''),(37,''),(38,''),(39,''),(40,''),(41,''),(42,''),(43,''),(44,''),(45,''),(46,''),(47,''),(48,''),(49,''),(50,''),(51,''),(52,''),(53,''),(54,''),(55,''),(56,''),(57,''),(58,''),(59,''),(60,''),(61,''),(62,''),(63,''),(64,''),(65,''),(66,''),(67,''),(68,''),(69,''),(70,''),(71,''),(72,''),(73,''),(74,''),(75,''),(76,''),(77,''),(78,''),(79,''),(80,''),(81,''),(82,'IT'),(83,''),(84,''),(85,''),(86,''),(87,''),(88,''),(89,''),(90,''),(91,''),(92,''),(93,''),(94,''),(95,''),(96,''),(97,''),(98,''),(99,''),(100,''),(101,''),(102,''),(103,''),(104,''),(105,''),(106,''),(107,''),(108,''),(109,''),(110,''),(111,''),(112,''),(113,''),(114,''),(115,''),(116,''),(117,''),(118,''),(119,''),(120,''),(121,''),(122,''),(123,''),(124,''),(125,''),(126,''),(127,''),(128,''),(129,''),(130,''),(131,''),(132,''),(133,''),(134,''),(135,''),(136,''),(137,''),(138,''),(139,''),(140,''),(141,''),(142,''),(144,''),(145,''),(146,''),(147,''),(148,''),(149,''),(150,''),(151,''),(152,''),(153,''),(154,''),(155,''),(156,''),(157,''),(158,''),(159,''),(160,''),(161,''),(162,''),(163,''),(164,''),(165,''),(166,''),(167,''),(168,''),(169,''),(170,''),(171,''),(172,''),(173,''),(174,''),(175,''),(176,''),(177,''),(178,''),(179,''),(180,''),(181,''),(182,''),(183,''),(184,''),(185,''),(186,''),(187,''),(188,''),(189,''),(190,''),(193,''),(194,'PS');
/*!40000 ALTER TABLE `an_nazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_nazioni_lang`
--

DROP TABLE IF EXISTS `an_nazioni_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_nazioni_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `an_nazioni_lang_ibfk_1` (`id_record`),
  KEY `an_nazioni_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `an_nazioni_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `an_nazioni` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `an_nazioni_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_nazioni_lang`
--

LOCK TABLES `an_nazioni_lang` WRITE;
/*!40000 ALTER TABLE `an_nazioni_lang` DISABLE KEYS */;
INSERT INTO `an_nazioni_lang` VALUES (1,1,2,'ALGERIA'),(2,1,3,'ANDORRA'),(3,1,4,'ANGOLA'),(4,1,5,'ANGUILLA'),(5,1,6,'ANTIGUA AND BARBUDA'),(6,1,7,'ARGENTINA'),(7,1,8,'ARMENIA'),(8,1,9,'ARUBA'),(9,1,10,'AUSTRALIA'),(10,1,11,'AUSTRIA'),(11,1,12,'AZERBAIJAN REPUBLIC'),(12,1,13,'BAHAMAS'),(13,1,14,'BAHRAIN'),(14,1,15,'BARBADOS'),(15,1,16,'BELGIO'),(16,1,17,'BELIZE'),(17,1,18,'BENIN'),(18,1,19,'BERMUDA'),(19,1,20,'BHUTAN'),(20,1,21,'BOLIVIA'),(21,1,22,'BOSNIA AND HERZEGOVINA'),(22,1,23,'BOTSWANA'),(23,1,24,'BRASILE'),(24,1,25,'BRITISH VIRGIN ISLANDS'),(25,1,26,'BRUNEI'),(26,1,27,'BULGARIA'),(27,1,28,'BURKINA FASO'),(28,1,29,'BURUNDI'),(29,1,30,'CAMBOGIA'),(30,1,31,'CANADA'),(31,1,32,'CAPO VERDE'),(32,1,33,'CAYMAN ISLANDS'),(33,1,34,'CHAD'),(34,1,35,'CHILE'),(35,1,36,'CHINA WORLDWIDE'),(36,1,37,'COLOMBIA'),(37,1,38,'COMOROS'),(38,1,39,'COOK ISLANDS'),(39,1,40,'COSTA RICA'),(40,1,41,'CROAZIA'),(41,1,42,'CIPRO'),(42,1,43,'REPUBBLICA CECA'),(43,1,44,'DEMOCRATIC REPUBLIC OF THE CONGO'),(44,1,45,'DANIMARCA'),(45,1,46,'DJIBOUTI'),(46,1,47,'DOMINICA'),(47,1,48,'REPUBBLICA DOMINICANA'),(48,1,49,'ECUADOR'),(49,1,50,'EL SALVADOR'),(50,1,51,'ERITREA'),(51,1,52,'ESTONIA'),(52,1,53,'ETHIOPIA'),(53,1,54,'FALKLAND ISLANDS'),(54,1,55,'FAROE ISLANDS'),(55,1,56,'FEDERATED STATES OF MICRONESIA'),(56,1,57,'FIJI'),(57,1,58,'FINLANDIA'),(58,1,59,'FRANCIA'),(59,1,60,'FRENCH GUIANA'),(60,1,61,'FRENCH POLYNESIA'),(61,1,62,'GABON REPUBLIC'),(62,1,63,'GAMBIA'),(63,1,64,'GERMANIA'),(64,1,65,'GIBRALTAR'),(65,1,66,'GRECIA'),(66,1,67,'GREENLAND'),(67,1,68,'GRENADA'),(68,1,69,'GUADELOUPE'),(69,1,70,'GUATEMALA'),(70,1,71,'GUINEA'),(71,1,72,'GUINEA BISSAU'),(72,1,73,'GUYANA'),(73,1,74,'HONDURAS'),(74,1,75,'HONG KONG'),(75,1,76,'UNGHERIA'),(76,1,77,'ISLANDA'),(77,1,78,'INDIA'),(78,1,79,'INDONESIA'),(79,1,80,'IRLANDA'),(80,1,81,'ISRAELE'),(81,1,82,'ITALIA'),(82,1,83,'JAMAICA'),(83,1,84,'GIAPPONE'),(84,1,85,'JORDAN'),(85,1,86,'KAZAKHSTAN'),(86,1,87,'KENYA'),(87,1,88,'KIRIBATI'),(88,1,89,'KUWAIT'),(89,1,90,'KYRGYZSTAN'),(90,1,91,'LAOS'),(91,1,92,'LATVIA'),(92,1,93,'LESOTHO'),(93,1,94,'LIECHTENSTEIN'),(94,1,95,'LITUANIA'),(95,1,96,'LUSSEMBURGO'),(96,1,97,'MADAGASCAR'),(97,1,98,'MALAWI'),(98,1,99,'MALESIA'),(99,1,100,'MALDIVE'),(100,1,101,'MALI'),(101,1,102,'MALTA'),(102,1,103,'MARSHALL ISLANDS'),(103,1,104,'MARTINIQUE'),(104,1,105,'MAURITANIA'),(105,1,106,'MAURITIUS'),(106,1,107,'MAYOTTE'),(107,1,108,'MESSICO'),(108,1,109,'MONGOLIA'),(109,1,110,'MONTSERRAT'),(110,1,111,'MAROCCO'),(111,1,112,'MOZAMBICO'),(112,1,113,'NAMIBIA'),(113,1,114,'NAURU'),(114,1,115,'NEPAL'),(115,1,116,'OLANDA'),(116,1,117,'NETHERLANDS ANTILLES'),(117,1,118,'NUOVA CALEDONIA'),(118,1,119,'NUOVA ZELANDA'),(119,1,120,'NICARAGUA'),(120,1,121,'NIGERIA'),(121,1,122,'NIUE'),(122,1,123,'NORFOLK ISLAND'),(123,1,124,'NORWEGIA'),(124,1,125,'OMAN'),(125,1,126,'PALAU'),(126,1,127,'PANAMA'),(127,1,128,'PAPUA NUOVA GUINEA'),(128,1,129,'PERU'),(129,1,130,'FILIPPINE'),(130,1,131,'PITCAIRN ISLANDS'),(131,1,132,'POLONIA'),(132,1,133,'PORTOGALLO'),(133,1,134,'QATAR'),(134,1,135,'REPUBBLICA DEL CONGO'),(135,1,136,'REUNION'),(136,1,137,'ROMANIA'),(137,1,138,'RUSSIA'),(138,1,139,'RUANDA'),(139,1,140,'SAINT VINCENT AND THE GRENADINES'),(140,1,141,'SAMOA'),(141,1,142,'SAN MARINO'),(142,1,144,'SAUDI ARABIA'),(143,1,145,'SENEGAL'),(144,1,146,'SEYCHELLES'),(145,1,147,'SIERRA LEONE'),(146,1,148,'SINGAPORE'),(147,1,149,'SLOVACCHIA'),(148,1,150,'SLOVENIA'),(149,1,151,'SOLOMON ISLANDS'),(150,1,152,'SOMALIA'),(151,1,153,'SUD AFRICA'),(152,1,154,'SUD KOREA'),(153,1,155,'SPAGNA'),(154,1,156,'SRI LANKA'),(155,1,157,'ST. HELENA'),(156,1,158,'ST. KITTS AND NEVIS'),(157,1,159,'ST. LUCIA'),(158,1,160,'ST. PIERRE AND MIQUELON'),(159,1,161,'SURINAME'),(160,1,162,'SVALBARD AND JAN MAYEN ISLANDS'),(161,1,163,'SWAZILAND'),(162,1,164,'SVEZIA'),(163,1,165,'SVIZZERA'),(164,1,166,'TAIWAN'),(165,1,167,'TAJIKISTAN'),(166,1,168,'TANZANIA'),(167,1,169,'THAILAND'),(168,1,170,'TOGO'),(169,1,171,'TONGA'),(170,1,172,'TRINIDAD E TOBAGO'),(171,1,173,'TUNISIA'),(172,1,174,'TURCHIA'),(173,1,175,'TURKMENISTAN'),(174,1,176,'TURKS AND CAICOS ISLANDS'),(175,1,177,'TUVALU'),(176,1,178,'UGANDA'),(177,1,179,'UCRAINA'),(178,1,180,'EMIRATI ARABI UNITI'),(179,1,181,'REGNO UNITO'),(180,1,182,'STATI UNITI'),(181,1,183,'URUGUAY'),(182,1,184,'VANUATU'),(183,1,185,'CITT├Ç DEL VATICANO'),(184,1,186,'VENEZUELA'),(185,1,187,'VIETNAM'),(186,1,188,'WALLIS AND FUTUNA ISLANDS'),(187,1,189,'YEMEN'),(188,1,190,'ZAMBIA'),(189,1,193,'ALBANIA '),(190,1,194,'Palestina');
/*!40000 ALTER TABLE `an_nazioni_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_pagamenti_anagrafiche`
--

DROP TABLE IF EXISTS `an_pagamenti_anagrafiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_pagamenti_anagrafiche` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mese` int NOT NULL,
  `giorno_fisso` int NOT NULL,
  `idanagrafica` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_pagamenti_anagrafiche`
--

LOCK TABLES `an_pagamenti_anagrafiche` WRITE;
/*!40000 ALTER TABLE `an_pagamenti_anagrafiche` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_pagamenti_anagrafiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_provenienze`
--

DROP TABLE IF EXISTS `an_provenienze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_provenienze` (
  `id` int NOT NULL AUTO_INCREMENT,
  `colore` varchar(7) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_provenienze`
--

LOCK TABLES `an_provenienze` WRITE;
/*!40000 ALTER TABLE `an_provenienze` DISABLE KEYS */;
INSERT INTO `an_provenienze` VALUES (1,'#caffb7'),(2,'#8fbafd');
/*!40000 ALTER TABLE `an_provenienze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_provenienze_lang`
--

DROP TABLE IF EXISTS `an_provenienze_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_provenienze_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `an_provenienze_lang_ibfk_1` (`id_record`),
  KEY `an_provenienze_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `an_provenienze_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `an_provenienze` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `an_provenienze_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_provenienze_lang`
--

LOCK TABLES `an_provenienze_lang` WRITE;
/*!40000 ALTER TABLE `an_provenienze_lang` DISABLE KEYS */;
INSERT INTO `an_provenienze_lang` VALUES (1,1,1,'Sito web','Sito web'),(2,1,2,'Passaparola','Passaparola');
/*!40000 ALTER TABLE `an_provenienze_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_referenti`
--

DROP TABLE IF EXISTS `an_referenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_referenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `idanagrafica` int NOT NULL,
  `idsede` int NOT NULL,
  `idmansione` int NOT NULL,
  `enable_newsletter` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_referenti`
--

LOCK TABLES `an_referenti` WRITE;
/*!40000 ALTER TABLE `an_referenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_referenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_regioni`
--

DROP TABLE IF EXISTS `an_regioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_regioni` (
  `id` int NOT NULL,
  `id_nazione` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_nazione` (`id_nazione`),
  CONSTRAINT `an_regioni_ibfk_1` FOREIGN KEY (`id_nazione`) REFERENCES `an_nazioni` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_regioni`
--

LOCK TABLES `an_regioni` WRITE;
/*!40000 ALTER TABLE `an_regioni` DISABLE KEYS */;
INSERT INTO `an_regioni` VALUES (1,82),(2,82),(3,82),(4,82),(5,82),(6,82),(7,82),(8,82),(9,82),(10,82),(11,82),(12,82),(13,82),(14,82),(15,82),(16,82),(17,82),(18,82),(19,82),(20,82);
/*!40000 ALTER TABLE `an_regioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_regioni_lang`
--

DROP TABLE IF EXISTS `an_regioni_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_regioni_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `an_regioni_lang_ibfk_1` (`id_record`),
  KEY `an_regioni_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `an_regioni_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `an_regioni` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `an_regioni_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_regioni_lang`
--

LOCK TABLES `an_regioni_lang` WRITE;
/*!40000 ALTER TABLE `an_regioni_lang` DISABLE KEYS */;
INSERT INTO `an_regioni_lang` VALUES (1,1,1,'Abruzzo','Abruzzo'),(2,1,2,'Basilicata','Basilicata'),(3,1,3,'Calabria','Calabria'),(4,1,4,'Campania','Campania'),(5,1,5,'Emilia-Romagna','Emilia-Romagna'),(6,1,6,'Friuli-Venezia Giulia','Friuli-Venezia Giulia'),(7,1,7,'Lazio','Lazio'),(8,1,8,'Liguria','Liguria'),(9,1,9,'Lombardia','Lombardia'),(10,1,10,'Marche','Marche'),(11,1,11,'Molise','Molise'),(12,1,12,'Piemonte','Piemonte'),(13,1,13,'Puglia','Puglia'),(14,1,14,'Sardegna','Sardegna'),(15,1,15,'Sicilia','Sicilia'),(16,1,16,'Toscana','Toscana'),(17,1,17,'Trentino-Alto Adige','Trentino-Alto Adige'),(18,1,18,'Umbria','Umbria'),(19,1,19,'Valle d\'Aosta','Valle d\'Aosta'),(20,1,20,'Veneto','Veneto');
/*!40000 ALTER TABLE `an_regioni_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_relazioni`
--

DROP TABLE IF EXISTS `an_relazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_relazioni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `colore` varchar(7) NOT NULL,
  `is_bloccata` tinyint DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_relazioni`
--

LOCK TABLES `an_relazioni` WRITE;
/*!40000 ALTER TABLE `an_relazioni` DISABLE KEYS */;
INSERT INTO `an_relazioni` VALUES (1,'#caffb7',NULL,NULL),(2,'#8fbafd',NULL,NULL),(3,'#ff908c',NULL,NULL),(4,'#ffc400',NULL,NULL),(5,'#00b913',NULL,NULL),(6,'#a2a2a2',NULL,NULL);
/*!40000 ALTER TABLE `an_relazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_relazioni_lang`
--

DROP TABLE IF EXISTS `an_relazioni_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_relazioni_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `an_relazioni_lang_ibfk_1` (`id_record`),
  KEY `an_relazioni_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `an_relazioni_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `an_relazioni` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `an_relazioni_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_relazioni_lang`
--

LOCK TABLES `an_relazioni_lang` WRITE;
/*!40000 ALTER TABLE `an_relazioni_lang` DISABLE KEYS */;
INSERT INTO `an_relazioni_lang` VALUES (1,1,1,'Da contattare','Da contattare'),(2,1,2,'Da richiamare','Da richiamare'),(3,1,3,'Da non richiamare','Da non richiamare'),(4,1,4,'Appuntamento fissato','Appuntamento fissato'),(5,1,5,'Attivo','Attivo'),(6,1,6,'Dormiente','Dormiente');
/*!40000 ALTER TABLE `an_relazioni_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_sdi`
--

DROP TABLE IF EXISTS `an_sdi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_sdi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `codice` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_sdi`
--

LOCK TABLES `an_sdi` WRITE;
/*!40000 ALTER TABLE `an_sdi` DISABLE KEYS */;
INSERT INTO `an_sdi` VALUES (1,'Danea/TeamSystem','M5UXCR1'),(2,'Zucchetti','SUBM70N'),(3,'Wolters Kluwer','W7YVJK9'),(4,'Fattura PA','5RUO82D'),(5,'Studio Rubino','T9K4ZHO'),(6,'Aruba','KRRH6B9'),(7,'WebClient','T04ZHR3'),(8,'Sistemi','USAL8PV'),(9,'LICON by Ix','A4707H7'),(10,'Buffetti','BA6ET11'),(11,'Tech Edge','0G6TBBX'),(12,'Ente autonomo volturno','2LCMINU'),(13,'Archivium srl','3ZJY534'),(14,'Coldiretti','5W4A8J1'),(15,'InfoCamere','66OZKW1'),(16,'CloudFinance','6JXPS2J'),(17,'Cia','6RB0OU9'),(18,'Consorzio CIAT','AU7YEU4'),(19,'Alto Trevigiano Servizi','C1QQYZR'),(20,'Linea Ufficio','EH1R83N'),(21,'Danisoft','G1XGCBG'),(22,'Arthur Informatica','G4AI1U8'),(23,'BesideTech','G9HZJRW'),(24,'SeDiCo Servizi','G9YK3BM'),(25,'MultiWire','GR2P7ZP'),(26,'MySond','H348Q01'),(27,'Ediel','HHBD9AK'),(28,'DocEasy','J6URRTW'),(29,'InformItalia SRL','K0ROACV'),(30,'QuickMastro','KJSRCTG'),(31,'AGYO (Teamsystem)','KUPCRMI'),(32,'Var Group','M5ITOJA'),(33,'Nebu','MJEGRSK'),(34,'K Link Solutions','MSUXCR1'),(35,'Credemtel (gruppo Banca Credem)','MZO2A0U'),(36,'Kalyos','N9KM26R'),(37,'IDOCTORS','NKNH5UQ'),(38,'Extreme software','E2VWRNU'),(39,'Unimatica','E06UCUD'),(40,'CompEd','WHP7LTE');
/*!40000 ALTER TABLE `an_sdi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_sedi`
--

DROP TABLE IF EXISTS `an_sedi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_sedi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nomesede` varchar(255) NOT NULL COMMENT 'Nome sede',
  `piva` varchar(15) NOT NULL COMMENT 'P.Iva',
  `codice_fiscale` varchar(16) NOT NULL COMMENT 'Codice Fiscale',
  `indirizzo` varchar(255) NOT NULL COMMENT 'Indirizzo',
  `indirizzo2` varchar(255) NOT NULL COMMENT 'Indirizzo2',
  `citta` varchar(255) NOT NULL COMMENT 'Citt&agrave;',
  `cap` varchar(10) NOT NULL COMMENT 'C.A.P.',
  `provincia` varchar(2) NOT NULL COMMENT 'Provincia',
  `km` decimal(10,2) NOT NULL,
  `id_nazione` int DEFAULT NULL COMMENT 'Nazione',
  `telefono` varchar(20) NOT NULL COMMENT 'Telefono',
  `fax` varchar(20) NOT NULL COMMENT 'Fax',
  `cellulare` varchar(20) NOT NULL COMMENT 'Cellulare',
  `email` varchar(255) NOT NULL COMMENT 'Email',
  `idanagrafica` int NOT NULL,
  `idzona` int NOT NULL,
  `note` text,
  `gaddress` varchar(255) DEFAULT NULL,
  `lat` float(10,6) DEFAULT NULL,
  `lng` float(10,6) DEFAULT NULL,
  `codice_destinatario` varchar(7) DEFAULT NULL,
  `enable_newsletter` tinyint(1) DEFAULT '1',
  `nome` varchar(225) DEFAULT NULL,
  `descrizione` varchar(225) DEFAULT NULL,
  `targa` varchar(225) DEFAULT NULL,
  `is_automezzo` tinyint NOT NULL DEFAULT '0',
  `is_rappresentante_fiscale` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_nazione` (`id_nazione`),
  CONSTRAINT `an_sedi_ibfk_1` FOREIGN KEY (`id_nazione`) REFERENCES `an_nazioni` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_sedi`
--

LOCK TABLES `an_sedi` WRITE;
/*!40000 ALTER TABLE `an_sedi` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_sedi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_sedi_tecnici`
--

DROP TABLE IF EXISTS `an_sedi_tecnici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_sedi_tecnici` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idsede` int NOT NULL,
  `idtecnico` int NOT NULL,
  `data_inizio` date DEFAULT NULL,
  `data_fine` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idsede` (`idsede`),
  KEY `idtecnico` (`idtecnico`),
  CONSTRAINT `an_sedi_tecnici_ibfk_1` FOREIGN KEY (`idsede`) REFERENCES `an_sedi` (`id`) ON DELETE CASCADE,
  CONSTRAINT `an_sedi_tecnici_ibfk_2` FOREIGN KEY (`idtecnico`) REFERENCES `an_anagrafiche` (`idanagrafica`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_sedi_tecnici`
--

LOCK TABLES `an_sedi_tecnici` WRITE;
/*!40000 ALTER TABLE `an_sedi_tecnici` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_sedi_tecnici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_settori`
--

DROP TABLE IF EXISTS `an_settori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_settori` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_settori`
--

LOCK TABLES `an_settori` WRITE;
/*!40000 ALTER TABLE `an_settori` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_settori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_settori_lang`
--

DROP TABLE IF EXISTS `an_settori_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_settori_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `an_settori_lang_ibfk_1` (`id_record`),
  KEY `an_settori_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `an_settori_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `an_settori` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `an_settori_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_settori_lang`
--

LOCK TABLES `an_settori_lang` WRITE;
/*!40000 ALTER TABLE `an_settori_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_settori_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_tipianagrafiche`
--

DROP TABLE IF EXISTS `an_tipianagrafiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_tipianagrafiche` (
  `id` int NOT NULL AUTO_INCREMENT,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_tipianagrafiche`
--

LOCK TABLES `an_tipianagrafiche` WRITE;
/*!40000 ALTER TABLE `an_tipianagrafiche` DISABLE KEYS */;
INSERT INTO `an_tipianagrafiche` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1);
/*!40000 ALTER TABLE `an_tipianagrafiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_tipianagrafiche_anagrafiche`
--

DROP TABLE IF EXISTS `an_tipianagrafiche_anagrafiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_tipianagrafiche_anagrafiche` (
  `idtipoanagrafica` int NOT NULL,
  `idanagrafica` int NOT NULL,
  PRIMARY KEY (`idtipoanagrafica`,`idanagrafica`),
  KEY `idanagrafica` (`idanagrafica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_tipianagrafiche_anagrafiche`
--

LOCK TABLES `an_tipianagrafiche_anagrafiche` WRITE;
/*!40000 ALTER TABLE `an_tipianagrafiche_anagrafiche` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_tipianagrafiche_anagrafiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_tipianagrafiche_lang`
--

DROP TABLE IF EXISTS `an_tipianagrafiche_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_tipianagrafiche_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `an_tipianagrafiche_lang_ibfk_1` (`id_record`),
  KEY `an_tipianagrafiche_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `an_tipianagrafiche_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `an_tipianagrafiche` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `an_tipianagrafiche_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_tipianagrafiche_lang`
--

LOCK TABLES `an_tipianagrafiche_lang` WRITE;
/*!40000 ALTER TABLE `an_tipianagrafiche_lang` DISABLE KEYS */;
INSERT INTO `an_tipianagrafiche_lang` VALUES (1,1,1,'Cliente','Cliente'),(2,1,2,'Tecnico','Tecnico'),(3,1,3,'Azienda','Azienda'),(4,1,4,'Fornitore','Fornitore'),(5,1,5,'Vettore','Vettore'),(6,1,6,'Agente','Agente');
/*!40000 ALTER TABLE `an_tipianagrafiche_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `an_zone`
--

DROP TABLE IF EXISTS `an_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_zone` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descrizione` varchar(2000) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_zone`
--

LOCK TABLES `an_zone` WRITE;
/*!40000 ALTER TABLE `an_zone` DISABLE KEYS */;
/*!40000 ALTER TABLE `an_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_banche`
--

DROP TABLE IF EXISTS `co_banche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_banche` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `filiale` varchar(255) DEFAULT NULL,
  `iban` varchar(32) NOT NULL,
  `bic` varchar(11) NOT NULL,
  `id_pianodeiconti3` int DEFAULT NULL,
  `note` text,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id_anagrafica` int NOT NULL,
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  `creditor_id` varchar(255) DEFAULT NULL,
  `codice_sia` varchar(5) DEFAULT NULL,
  `branch_code` varchar(20) DEFAULT NULL,
  `bank_code` varchar(20) DEFAULT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `check_digits` varchar(20) DEFAULT NULL,
  `national_check_digits` varchar(20) DEFAULT NULL,
  `id_nazione` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_anagrafica` (`id_anagrafica`),
  KEY `id_nazione` (`id_nazione`),
  CONSTRAINT `co_banche_ibfk_1` FOREIGN KEY (`id_anagrafica`) REFERENCES `an_anagrafiche` (`idanagrafica`) ON DELETE CASCADE,
  CONSTRAINT `co_banche_ibfk_2` FOREIGN KEY (`id_nazione`) REFERENCES `an_nazioni` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_banche`
--

LOCK TABLES `co_banche` WRITE;
/*!40000 ALTER TABLE `co_banche` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_banche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_categorie_contratti`
--

DROP TABLE IF EXISTS `co_categorie_contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_categorie_contratti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `colore` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parent` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_categorie_contratti`
--

LOCK TABLES `co_categorie_contratti` WRITE;
/*!40000 ALTER TABLE `co_categorie_contratti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_categorie_contratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_categorie_contratti_lang`
--

DROP TABLE IF EXISTS `co_categorie_contratti_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_categorie_contratti_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mg_categorie_lang_ibfk_1` (`id_record`),
  KEY `mg_categorie_lang_ibfk_2` (`id_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_categorie_contratti_lang`
--

LOCK TABLES `co_categorie_contratti_lang` WRITE;
/*!40000 ALTER TABLE `co_categorie_contratti_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_categorie_contratti_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_contratti`
--

DROP TABLE IF EXISTS `co_contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_contratti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(50) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `idagente` int NOT NULL,
  `data_bozza` date DEFAULT NULL,
  `data_accettazione` date DEFAULT NULL,
  `data_rifiuto` date DEFAULT NULL,
  `data_conclusione` date DEFAULT NULL,
  `rinnovabile` tinyint(1) NOT NULL,
  `rinnovo_automatico` tinyint(1) NOT NULL DEFAULT '0',
  `giorni_preavviso_rinnovo` smallint NOT NULL,
  `ore_preavviso_rinnovo` decimal(15,6) DEFAULT NULL,
  `budget` decimal(15,6) NOT NULL,
  `descrizione` text,
  `idstato` tinyint DEFAULT NULL,
  `idreferente` int DEFAULT NULL,
  `validita` int DEFAULT NULL,
  `tipo_validita` enum('days','months','years') DEFAULT NULL,
  `esclusioni` text,
  `idanagrafica` int NOT NULL,
  `idsede_destinazione` int NOT NULL,
  `idsede_partenza` int NOT NULL,
  `idpagamento` int NOT NULL,
  `id_banca_azienda` int DEFAULT NULL,
  `id_banca_controparte` int DEFAULT NULL,
  `costo_diritto_chiamata` decimal(15,6) NOT NULL,
  `ore_lavoro` decimal(15,6) NOT NULL,
  `costo_orario` decimal(15,6) NOT NULL,
  `costo_km` decimal(15,6) NOT NULL,
  `idcontratto_prev` int NOT NULL,
  `codice_cig` varchar(15) DEFAULT NULL,
  `codice_cup` varchar(15) DEFAULT NULL,
  `id_documento_fe` varchar(20) DEFAULT NULL,
  `num_item` varchar(15) DEFAULT NULL,
  `sconto_finale` decimal(17,8) NOT NULL,
  `sconto_finale_percentuale` decimal(17,8) NOT NULL,
  `informazioniaggiuntive` text,
  `condizioni_fornitura` text NOT NULL,
  `predefined` tinyint(1) NOT NULL,
  `id_segment` int NOT NULL,
  `id_categoria` int DEFAULT NULL,
  `id_sottocategoria` int DEFAULT NULL,
  `idtipointervento` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_contratti`
--

LOCK TABLES `co_contratti` WRITE;
/*!40000 ALTER TABLE `co_contratti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_contratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_contratti_tipiintervento`
--

DROP TABLE IF EXISTS `co_contratti_tipiintervento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_contratti_tipiintervento` (
  `idcontratto` int NOT NULL,
  `idtipointervento` int NOT NULL,
  `costo_ore` decimal(15,6) NOT NULL,
  `costo_km` decimal(15,6) NOT NULL,
  `costo_dirittochiamata` decimal(15,6) NOT NULL,
  `costo_ore_tecnico` decimal(15,6) NOT NULL,
  `costo_km_tecnico` decimal(15,6) NOT NULL,
  `costo_dirittochiamata_tecnico` decimal(15,6) NOT NULL,
  PRIMARY KEY (`idcontratto`,`idtipointervento`),
  KEY `idtipointervento` (`idtipointervento`),
  CONSTRAINT `co_contratti_tipiintervento_ibfk_1` FOREIGN KEY (`idtipointervento`) REFERENCES `in_tipiintervento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_contratti_tipiintervento`
--

LOCK TABLES `co_contratti_tipiintervento` WRITE;
/*!40000 ALTER TABLE `co_contratti_tipiintervento` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_contratti_tipiintervento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_dichiarazioni_intento`
--

DROP TABLE IF EXISTS `co_dichiarazioni_intento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_dichiarazioni_intento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_anagrafica` int NOT NULL,
  `data` date NOT NULL,
  `numero_protocollo` varchar(255) NOT NULL,
  `numero_progressivo` varchar(255) NOT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date NOT NULL,
  `data_protocollo` date DEFAULT NULL,
  `data_emissione` date DEFAULT NULL,
  `massimale` decimal(15,6) NOT NULL,
  `totale` decimal(15,6) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_anagrafica` (`id_anagrafica`),
  CONSTRAINT `co_dichiarazioni_intento_ibfk_1` FOREIGN KEY (`id_anagrafica`) REFERENCES `an_anagrafiche` (`idanagrafica`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_dichiarazioni_intento`
--

LOCK TABLES `co_dichiarazioni_intento` WRITE;
/*!40000 ALTER TABLE `co_dichiarazioni_intento` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_dichiarazioni_intento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_documenti`
--

DROP TABLE IF EXISTS `co_documenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_documenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(100) NOT NULL,
  `numero_esterno` varchar(100) NOT NULL,
  `data` date DEFAULT NULL,
  `data_competenza` date DEFAULT NULL,
  `data_registrazione` date DEFAULT NULL,
  `idanagrafica` int NOT NULL,
  `idreferente` int DEFAULT NULL,
  `idagente` int NOT NULL,
  `ref_documento` int DEFAULT NULL,
  `idcausalet` int NOT NULL,
  `idspedizione` int NOT NULL,
  `idporto` int NOT NULL,
  `idaspettobeni` int NOT NULL,
  `idvettore` int NOT NULL,
  `n_colli` int NOT NULL,
  `peso` decimal(12,4) DEFAULT NULL,
  `volume` decimal(12,4) DEFAULT NULL,
  `peso_manuale` tinyint(1) NOT NULL,
  `volume_manuale` tinyint(1) NOT NULL,
  `idsede_partenza` int NOT NULL,
  `idsede_destinazione` int NOT NULL,
  `idtipodocumento` tinyint NOT NULL,
  `idstatodocumento` tinyint NOT NULL,
  `idpagamento` int NOT NULL,
  `id_banca_azienda` int DEFAULT NULL,
  `id_banca_controparte` int DEFAULT NULL,
  `idconto` int NOT NULL,
  `idrivalsainps` int NOT NULL,
  `idritenutaacconto` int NOT NULL,
  `rivalsainps` decimal(15,6) NOT NULL,
  `iva_rivalsainps` decimal(15,6) NOT NULL,
  `ritenutaacconto` decimal(15,6) NOT NULL,
  `bollo` decimal(15,6) DEFAULT NULL,
  `id_ritenuta_contributi` int DEFAULT NULL,
  `ritenuta_contributi` decimal(15,6) NOT NULL,
  `split_payment` tinyint(1) NOT NULL DEFAULT '0',
  `is_fattura_conto_terzi` tinyint(1) NOT NULL DEFAULT '0',
  `note` text,
  `note_aggiuntive` text,
  `buono_ordine` varchar(50) NOT NULL,
  `id_segment` int NOT NULL,
  `progressivo_invio` varchar(255) DEFAULT NULL,
  `tipo_resa` varchar(3) DEFAULT NULL,
  `codice_stato_fe` varchar(5) DEFAULT NULL,
  `data_stato_fe` timestamp NULL DEFAULT NULL,
  `descrizione_ricevuta_fe` text,
  `addebita_bollo` tinyint(1) NOT NULL DEFAULT '1',
  `id_riga_bollo` int DEFAULT NULL,
  `dati_aggiuntivi_fe` text,
  `hook_send` tinyint(1) DEFAULT '0',
  `id_dichiarazione_intento` int DEFAULT NULL,
  `id_ricevuta_principale` int DEFAULT NULL,
  `id_autofattura` int DEFAULT NULL,
  `is_ritenuta_pagata` tinyint(1) NOT NULL,
  `sconto_finale` decimal(17,8) NOT NULL,
  `sconto_finale_percentuale` decimal(17,8) NOT NULL,
  `id_riga_spese_incasso` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ref_documento` (`ref_documento`),
  KEY `codice_stato_fe` (`codice_stato_fe`),
  KEY `id_ritenuta_contributi` (`id_ritenuta_contributi`),
  KEY `id_riga_bollo` (`id_riga_bollo`),
  KEY `id_dichiarazione_intento` (`id_dichiarazione_intento`),
  KEY `id_autofattura` (`id_autofattura`),
  CONSTRAINT `co_documenti_ibfk_1` FOREIGN KEY (`ref_documento`) REFERENCES `co_documenti` (`id`) ON DELETE CASCADE,
  CONSTRAINT `co_documenti_ibfk_2` FOREIGN KEY (`codice_stato_fe`) REFERENCES `fe_stati_documento` (`codice`) ON DELETE SET NULL,
  CONSTRAINT `co_documenti_ibfk_3` FOREIGN KEY (`id_ritenuta_contributi`) REFERENCES `co_ritenuta_contributi` (`id`) ON DELETE SET NULL,
  CONSTRAINT `co_documenti_ibfk_4` FOREIGN KEY (`id_riga_bollo`) REFERENCES `co_righe_documenti` (`id`) ON DELETE SET NULL,
  CONSTRAINT `co_documenti_ibfk_5` FOREIGN KEY (`id_dichiarazione_intento`) REFERENCES `co_dichiarazioni_intento` (`id`) ON DELETE SET NULL,
  CONSTRAINT `co_documenti_ibfk_6` FOREIGN KEY (`id_autofattura`) REFERENCES `co_documenti` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_documenti`
--

LOCK TABLES `co_documenti` WRITE;
/*!40000 ALTER TABLE `co_documenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_documenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_fatturazione_contratti`
--

DROP TABLE IF EXISTS `co_fatturazione_contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_fatturazione_contratti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idcontratto` int NOT NULL,
  `data_scadenza` date DEFAULT NULL,
  `idzona` int NOT NULL,
  `iddocumento` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_contratti_fatturazione` (`idcontratto`),
  CONSTRAINT `fk_contratti_fatturazione` FOREIGN KEY (`idcontratto`) REFERENCES `co_contratti` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_fatturazione_contratti`
--

LOCK TABLES `co_fatturazione_contratti` WRITE;
/*!40000 ALTER TABLE `co_fatturazione_contratti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_fatturazione_contratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_iva`
--

DROP TABLE IF EXISTS `co_iva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_iva` (
  `id` int NOT NULL AUTO_INCREMENT,
  `percentuale` decimal(5,2) NOT NULL,
  `indetraibile` decimal(5,2) NOT NULL,
  `esente` tinyint(1) NOT NULL,
  `dicitura` varchar(255) DEFAULT NULL,
  `codice_natura_fe` varchar(4) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `codice` int DEFAULT NULL,
  `esigibilita` enum('I','D','S') NOT NULL DEFAULT 'I',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `co_iva_ibfk_1` (`codice_natura_fe`),
  CONSTRAINT `co_iva_ibfk_1` FOREIGN KEY (`codice_natura_fe`) REFERENCES `fe_natura` (`codice`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_iva`
--

LOCK TABLES `co_iva` WRITE;
/*!40000 ALTER TABLE `co_iva` DISABLE KEYS */;
INSERT INTO `co_iva` VALUES (1,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',1,'I',0),(2,4.00,50.00,0,NULL,NULL,'2025-07-29 12:33:11',2,'I',0),(3,4.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',3,'I',0),(4,4.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',4,'I',0),(5,8.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',5,'I',0),(6,9.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',6,'I',0),(7,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',7,'I',0),(8,10.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',8,'I',0),(9,10.00,50.00,0,NULL,NULL,'2025-07-29 12:33:11',9,'I',0),(10,10.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',10,'I',0),(11,10.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',11,'I',0),(12,10.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',12,'I',0),(13,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',13,'I',0),(14,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',14,'I',0),(15,20.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',15,'I',0),(16,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',16,'I',0),(17,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',17,'I',0),(18,19.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',18,'I',0),(19,2.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',19,'I',0),(20,20.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',20,'I',0),(21,20.00,90.00,0,NULL,NULL,'2025-07-29 12:33:11',21,'I',0),(22,20.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',22,'I',0),(23,20.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',23,'I',0),(24,20.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',24,'I',0),(25,21.00,50.00,0,NULL,NULL,'2025-07-29 12:33:11',25,'I',0),(26,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',26,'I',0),(27,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',27,'I',0),(28,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',28,'I',0),(29,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',29,'I',0),(30,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',30,'I',0),(32,21.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',32,'I',0),(33,21.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',33,'I',0),(34,4.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',34,'I',0),(35,0.00,0.00,1,'Senza addebito iva ex art. 74 comma 8-9 del DPR 633/72',NULL,'2025-07-29 12:33:11',35,'I',0),(36,2.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',36,'I',0),(37,4.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',37,'I',0),(38,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',38,'I',0),(39,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',39,'I',0),(40,10.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',40,'I',0),(41,4.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',41,'I',0),(42,20.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',42,'I',0),(43,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',43,'I',0),(44,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',44,'I',0),(45,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',45,'I',0),(46,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',46,'I',0),(47,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',47,'I',0),(48,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',48,'I',0),(49,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',49,'I',0),(51,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',51,'I',0),(52,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',52,'I',0),(53,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',53,'I',0),(54,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',54,'I',0),(55,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',55,'I',0),(56,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',56,'I',0),(57,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',57,'I',0),(58,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',58,'I',0),(59,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',59,'I',0),(60,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',60,'I',0),(61,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',61,'I',0),(62,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',62,'I',0),(63,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',63,'I',0),(64,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',64,'I',0),(65,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',65,'I',0),(66,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',66,'I',0),(67,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',67,'I',0),(68,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',68,'I',0),(69,10.00,0.00,0,'Operazione soggetta a reverse charge ex art. 17, comma 6, DPR 633/72',NULL,'2025-07-29 12:33:11',69,'I',0),(70,20.00,0.00,0,'Operazione soggetta a reverse charge ex art. 17, comma 6, DPR 633/72',NULL,'2025-07-29 12:33:11',70,'I',0),(71,4.00,0.00,0,'Operazione soggetta a reverse charge ex art. 17, comma 6, DPR 633/72',NULL,'2025-07-29 12:33:11',71,'I',0),(72,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',72,'I',0),(73,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',73,'I',0),(74,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',74,'I',0),(75,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',75,'I',0),(76,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',76,'I',0),(77,0.00,0.00,1,NULL,NULL,'2025-07-29 12:33:11',77,'I',0),(78,10.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',78,'I',0),(79,20.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',79,'I',0),(80,4.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',80,'I',0),(81,4.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',81,'I',0),(82,10.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',82,'I',0),(83,10.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',83,'I',0),(84,4.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',84,'I',0),(85,20.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',85,'I',0),(86,20.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',86,'I',0),(87,0.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',87,'I',0),(88,0.00,0.00,0,'Operazione soggetta a reverse charge ex art. 17, comma 6, DPR 633/72',NULL,'2025-07-29 12:33:11',88,'I',0),(89,21.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',89,'I',0),(90,0.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',90,'I',0),(91,22.00,0.00,0,NULL,NULL,'2025-07-29 12:33:11',91,'I',0),(92,22.00,100.00,0,NULL,NULL,'2025-07-29 12:33:11',92,'I',0),(93,22.00,50.00,0,NULL,NULL,'2025-07-29 12:33:11',93,'I',0),(94,22.00,0.00,0,'Operazione soggetta a reverse charge ex art. 17, comma 6, DPR 633/72',NULL,'2025-07-29 12:33:11',94,'I',0),(95,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',300,'I',1),(96,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',301,'I',1),(97,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',302,'I',1),(98,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',303,'I',1),(99,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',304,'I',1),(100,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',305,'I',1),(101,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',306,'I',1),(102,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',307,'I',1),(103,0.00,0.00,1,NULL,'N4',NULL,308,'I',1),(104,0.00,0.00,1,NULL,'N4',NULL,309,'I',1),(105,0.00,0.00,1,NULL,'N4',NULL,310,'I',1),(106,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',311,'I',1),(107,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',312,'I',1),(108,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',313,'I',1),(109,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',314,'I',1),(110,0.00,0.00,1,NULL,'N1',NULL,315,'I',1),(111,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',316,'I',1),(112,0.00,0.00,1,NULL,'N5',NULL,317,'I',1),(113,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',318,'I',1),(114,0.00,0.00,1,NULL,'N4',NULL,319,'I',1),(115,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',320,'I',1),(116,0.00,0.00,1,NULL,'N4',NULL,321,'I',1),(117,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',322,'I',1),(118,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',323,'I',1),(119,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',324,'I',1),(120,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',325,'I',1),(121,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',326,'I',1),(122,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',327,'I',1),(123,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',328,'I',1),(124,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',329,'I',1),(125,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',330,'I',1),(126,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',331,'I',1),(127,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',332,'I',1),(128,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',333,'I',1),(129,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',334,'I',1),(130,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',335,'I',1),(131,0.00,0.00,1,NULL,'N5',NULL,336,'I',1),(132,0.00,0.00,1,NULL,'N4',NULL,337,'I',1),(133,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',338,'I',1),(134,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',339,'I',1),(135,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',340,'I',1),(136,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',341,'I',1),(137,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',342,'I',1),(138,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',343,'I',1),(139,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',344,'I',1),(140,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',350,'I',1),(141,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',351,'I',1),(142,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',352,'I',1),(143,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',353,'I',1),(144,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',354,'I',1),(145,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',355,'I',1),(146,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',358,'I',1),(147,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',367,'I',1),(148,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',368,'I',1),(149,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',369,'I',1),(150,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',370,'I',1),(151,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',371,'I',1),(152,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',372,'I',1),(153,0.00,0.00,1,NULL,'N2.2','2025-07-29 12:38:08',374,'I',1),(154,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',375,'I',1),(155,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',376,'I',1),(156,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',377,'I',1),(157,0.00,0.00,1,NULL,'N3.6','2025-07-29 12:38:08',378,'I',1),(158,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',379,'I',1),(159,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',380,'I',1),(160,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',381,'I',1),(161,0.00,0.00,1,NULL,'N6.9','2025-07-29 12:38:08',382,'I',1),(162,2.00,0.00,0,NULL,NULL,NULL,2,'I',1),(163,4.00,0.00,0,NULL,NULL,NULL,4,'I',1),(164,5.00,0.00,0,NULL,NULL,NULL,5,'I',1),(165,7.00,0.00,0,NULL,NULL,NULL,7,'I',1),(166,8.00,0.00,0,NULL,NULL,NULL,8,'I',1),(167,10.00,0.00,0,NULL,NULL,NULL,10,'I',1),(168,12.30,0.00,0,NULL,NULL,NULL,13,'I',1),(169,20.00,0.00,0,NULL,NULL,NULL,20,'I',1),(170,21.00,0.00,0,NULL,NULL,NULL,21,'I',1),(171,22.00,0.00,0,NULL,NULL,NULL,22,'I',1),(172,7.30,0.00,0,NULL,NULL,NULL,73,'I',1),(173,7.50,0.00,0,NULL,NULL,NULL,75,'I',1),(174,7.65,0.00,0,NULL,NULL,NULL,76,'I',1),(175,7.70,0.00,0,NULL,NULL,NULL,77,'I',1),(176,7.95,0.00,0,NULL,NULL,NULL,79,'I',1),(177,8.30,0.00,0,NULL,NULL,NULL,83,'I',1),(178,8.50,0.00,0,NULL,NULL,NULL,85,'I',1),(179,8.80,0.00,0,NULL,NULL,NULL,88,'I',1),(180,2.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',102,'I',1),(181,4.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',104,'I',1),(182,5.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',105,'I',1),(183,7.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',107,'I',1),(184,8.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',108,'I',1),(185,10.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',110,'I',1),(186,12.30,0.00,0,NULL,NULL,'2025-07-29 12:38:00',113,'I',1),(187,20.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',120,'I',1),(188,21.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',121,'I',1),(189,22.00,0.00,0,NULL,NULL,'2025-07-29 12:38:00',122,'I',1),(190,7.30,0.00,0,NULL,NULL,'2025-07-29 12:38:00',173,'I',1),(191,7.50,0.00,0,NULL,NULL,'2025-07-29 12:38:00',175,'I',1),(192,7.65,0.00,0,NULL,NULL,'2025-07-29 12:38:00',176,'I',1),(193,7.70,0.00,0,NULL,NULL,'2025-07-29 12:38:00',177,'I',1),(194,7.95,0.00,0,NULL,NULL,'2025-07-29 12:38:00',179,'I',1),(195,8.30,0.00,0,NULL,NULL,'2025-07-29 12:38:00',183,'I',1),(196,8.50,0.00,0,NULL,NULL,'2025-07-29 12:38:00',185,'I',1),(197,8.80,0.00,0,NULL,NULL,'2025-07-29 12:38:00',188,'I',1),(198,0.00,0.00,0,NULL,NULL,NULL,200,'I',1),(199,2.00,0.00,0,NULL,NULL,NULL,202,'I',1),(200,4.00,0.00,0,NULL,NULL,NULL,204,'I',1),(201,5.00,0.00,0,NULL,NULL,NULL,205,'I',1),(202,7.00,0.00,0,NULL,NULL,NULL,207,'I',1),(203,8.00,0.00,0,NULL,NULL,NULL,208,'I',1),(204,10.00,0.00,0,NULL,NULL,NULL,210,'I',1),(205,12.30,0.00,0,NULL,NULL,NULL,213,'I',1),(206,20.00,0.00,0,NULL,NULL,NULL,220,'I',1),(207,21.00,0.00,0,NULL,NULL,NULL,221,'I',1),(208,22.00,0.00,0,NULL,NULL,NULL,222,'I',1),(209,7.30,0.00,0,NULL,NULL,NULL,273,'I',1),(210,7.50,0.00,0,NULL,NULL,NULL,275,'I',1),(211,7.65,0.00,0,NULL,NULL,NULL,276,'I',1),(212,7.70,0.00,0,NULL,NULL,NULL,277,'I',1),(213,7.95,0.00,0,NULL,NULL,NULL,279,'I',1),(214,8.30,0.00,0,NULL,NULL,NULL,283,'I',1),(215,8.50,0.00,0,NULL,NULL,NULL,285,'I',1),(216,8.80,0.00,0,NULL,NULL,NULL,288,'I',1),(217,2.00,100.00,0,NULL,NULL,NULL,602,'I',1),(218,4.00,100.00,0,NULL,NULL,NULL,604,'I',1),(219,5.00,100.00,0,NULL,NULL,NULL,605,'I',1),(220,7.00,100.00,0,NULL,NULL,NULL,607,'I',1),(221,8.00,100.00,0,NULL,NULL,NULL,608,'I',1),(222,10.00,100.00,0,NULL,NULL,NULL,610,'I',1),(223,12.30,100.00,0,NULL,NULL,NULL,613,'I',1),(224,20.00,100.00,0,NULL,NULL,NULL,620,'I',1),(225,21.00,100.00,0,NULL,NULL,NULL,621,'I',1),(226,22.00,100.00,0,NULL,NULL,NULL,622,'I',1),(227,7.30,100.00,0,NULL,NULL,NULL,673,'I',1),(228,7.50,100.00,0,NULL,NULL,NULL,675,'I',1),(229,7.65,100.00,0,NULL,NULL,NULL,676,'I',1),(230,7.70,100.00,0,NULL,NULL,NULL,677,'I',1),(231,7.95,100.00,0,NULL,NULL,NULL,679,'I',1),(232,8.30,100.00,0,NULL,NULL,NULL,683,'I',1),(233,8.50,100.00,0,NULL,NULL,NULL,685,'I',1),(234,8.80,100.00,0,NULL,NULL,NULL,688,'I',1),(235,2.00,0.00,0,NULL,NULL,NULL,802,'I',1),(236,4.00,0.00,0,NULL,NULL,NULL,804,'I',1),(237,5.00,0.00,0,NULL,NULL,NULL,805,'I',1),(238,7.00,0.00,0,NULL,NULL,NULL,807,'I',1),(239,8.00,0.00,0,NULL,NULL,NULL,808,'I',1),(240,10.00,0.00,0,NULL,NULL,NULL,810,'I',1),(241,12.30,0.00,0,NULL,NULL,NULL,813,'I',1),(242,20.00,0.00,0,NULL,NULL,NULL,820,'I',1),(243,21.00,0.00,0,NULL,NULL,NULL,821,'I',1),(244,22.00,0.00,0,NULL,NULL,NULL,822,'I',1),(245,7.30,0.00,0,NULL,NULL,NULL,873,'I',1),(246,7.50,0.00,0,NULL,NULL,NULL,875,'I',1),(247,7.65,0.00,0,NULL,NULL,NULL,876,'I',1),(248,7.70,0.00,0,NULL,NULL,NULL,877,'I',1),(249,7.95,0.00,0,NULL,NULL,NULL,879,'I',1),(250,8.30,0.00,0,NULL,NULL,NULL,883,'I',1),(251,8.50,0.00,0,NULL,NULL,NULL,885,'I',1),(252,8.80,0.00,0,NULL,NULL,NULL,888,'I',1),(253,0.00,0.00,1,NULL,'N4',NULL,253,'I',1),(254,0.00,0.00,1,NULL,'N6.8',NULL,254,'I',1),(255,0.00,0.00,1,NULL,'N2.1',NULL,255,'I',1),(256,0.00,0.00,1,NULL,'N2.1',NULL,256,'I',1),(257,0.00,0.00,1,NULL,'N2.1',NULL,257,'I',1),(258,0.00,0.00,1,NULL,'N2.1',NULL,258,'I',1),(259,0.00,0.00,1,NULL,'N2.1',NULL,259,'I',1),(260,0.00,0.00,1,NULL,'N2.1',NULL,260,'I',1),(261,0.00,0.00,1,NULL,'N2.2',NULL,261,'I',1),(262,0.00,0.00,1,NULL,'N2.2',NULL,262,'I',1),(263,0.00,0.00,1,NULL,'N2.2',NULL,263,'I',1),(264,0.00,0.00,1,NULL,'N2.2',NULL,264,'I',1),(265,0.00,0.00,1,NULL,'N2.2',NULL,265,'I',1),(266,0.00,0.00,1,NULL,'N2.2',NULL,266,'I',1),(267,0.00,0.00,1,NULL,'N2.2',NULL,267,'I',1),(268,0.00,0.00,1,NULL,'N2.2',NULL,268,'I',1),(269,0.00,0.00,1,NULL,'N2.2',NULL,269,'I',1),(270,0.00,0.00,1,NULL,'N2.2',NULL,270,'I',1),(271,0.00,0.00,1,NULL,'N2.2',NULL,271,'I',1),(272,0.00,0.00,1,NULL,'N2.2',NULL,272,'I',1),(273,0.00,0.00,1,NULL,'N2.2',NULL,273,'I',1),(274,0.00,0.00,1,NULL,'N2.2',NULL,274,'I',1),(275,0.00,0.00,1,NULL,'N2.2',NULL,275,'I',1),(276,0.00,0.00,1,NULL,'N2.2',NULL,276,'I',1),(277,0.00,0.00,1,NULL,'N2.2',NULL,277,'I',1),(278,0.00,0.00,1,NULL,'N3.1',NULL,278,'I',1),(279,0.00,0.00,1,NULL,'N3.1',NULL,279,'I',1),(280,0.00,0.00,1,NULL,'N3.1',NULL,280,'I',1),(281,0.00,0.00,1,NULL,'N3.1',NULL,281,'I',1),(282,0.00,0.00,1,NULL,'N3.1',NULL,282,'I',1),(283,0.00,0.00,1,NULL,'N3.1',NULL,283,'I',1),(284,0.00,0.00,1,NULL,'N3.1',NULL,284,'I',1),(285,0.00,0.00,1,NULL,'N3.2',NULL,285,'I',1),(286,0.00,0.00,1,NULL,'N3.2',NULL,286,'I',1),(287,0.00,0.00,1,NULL,'N3.2',NULL,287,'I',1),(288,0.00,0.00,1,NULL,'N3.4',NULL,288,'I',1),(289,0.00,0.00,1,NULL,'N3.4',NULL,289,'I',1),(290,0.00,0.00,1,NULL,'N3.5',NULL,290,'I',1),(291,0.00,0.00,1,NULL,'N3.6',NULL,890,'I',1),(292,0.00,0.00,1,NULL,'N3.6',NULL,891,'I',1),(293,0.00,0.00,1,NULL,'N3.6',NULL,892,'I',1),(294,0.00,0.00,1,NULL,'N3.6',NULL,294,'I',1),(295,0.00,0.00,1,NULL,'N3.6',NULL,295,'I',1),(296,0.00,0.00,1,NULL,'N7',NULL,889,'I',1);
/*!40000 ALTER TABLE `co_iva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_iva_lang`
--

DROP TABLE IF EXISTS `co_iva_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_iva_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `co_iva_lang_ibfk_1` (`id_record`),
  KEY `co_iva_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `co_iva_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `co_iva` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `co_iva_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_iva_lang`
--

LOCK TABLES `co_iva_lang` WRITE;
/*!40000 ALTER TABLE `co_iva_lang` DISABLE KEYS */;
INSERT INTO `co_iva_lang` VALUES (1,1,1,'Corrispettivi in ventilazione','Corrispettivi in ventilazione'),(2,1,2,'Iva 4% indetraibile al 50%','Iva 4% indetraibile al 50%'),(3,1,3,'Iva 04% indetraibile al 100%','Iva 04% indetraibile al 100%'),(4,1,4,'Iva 04% Intra','Iva 04% Intra'),(5,1,5,'Iva 8','Iva 8'),(6,1,6,'Iva 9% ','Iva 9% '),(7,1,7,'Esente art.10','Esente art.10'),(8,1,8,'Iva 10%','Iva 10%'),(9,1,9,'Iva 10% indetraibile al 50%','Iva 10% indetraibile al 50%'),(10,1,10,'Iva 10% indetraibile al 100%','Iva 10% indetraibile al 100%'),(11,1,11,'Iva 10% Intra','Iva 10% Intra'),(12,1,12,'Iva 10% indetraibile','Iva 10% indetraibile'),(13,1,13,'Esente art. 2 DPR 633/72','Esente art. 2 DPR 633/72'),(14,1,14,'N.S. iva art.4 D.P.R.633/72','N.S. iva art.4 D.P.R.633/72'),(15,1,15,'Iva 20% in reverse charge','Iva 20% in reverse charge'),(16,1,16,'Esente art.15','Esente art.15'),(17,1,17,'Non imponibile art. 7','Non imponibile art. 7'),(18,1,18,'Iva 19%','Iva 19%'),(19,1,19,'Iva 2%','Iva 2%'),(20,1,20,'Iva 20%','Iva 20%'),(21,1,21,'Iva 20% indetraibile al 90%','Iva 20% indetraibile al 90%'),(22,1,22,'Iva 20% esente prorata','Iva 20% esente prorata'),(23,1,23,'Iva 20% Intra','Iva 20% Intra'),(24,1,24,'Iva 20% indetraibile','Iva 20% indetraibile'),(25,1,25,'Iva 21% indetraibile 50%','Iva 21% indetraibile 50%'),(26,1,26,'Non imponibile art.72','Non imponibile art.72'),(27,1,27,'Esente art. 1','Esente art. 1'),(28,1,28,'Non imponibile art.26 C.2','Non imponibile art.26 C.2'),(29,1,29,'Non imponibile art.74','Non imponibile art.74'),(30,1,30,'Non imponibile art. 41','Non imponibile art. 41'),(31,1,32,'Iva 21%','Iva 21%'),(32,1,33,'Iva 21% S.Marino','Iva 21% S.Marino'),(33,1,34,'Iva 4%','Iva 4%'),(34,1,35,'Esente art. 74','Esente art. 74'),(35,1,36,'Iva 2% indetraibile','Iva 2% indetraibile'),(36,1,37,'Iva 4% indetraibile','Iva 4% indetraibile'),(37,1,38,'Esente art.6','Esente art.6'),(38,1,39,'Esente art. 5','Esente art. 5'),(39,1,40,'Art. 74 ter 10% indetraibile','Art. 74 ter 10% indetraibile'),(40,1,41,'Art. 74 ter 4% indetraibile','Art. 74 ter 4% indetraibile'),(41,1,42,'Art. 74 ter 20% iva indetraibile','Art. 74 ter 20% iva indetraibile'),(42,1,43,'Non imponibile art. 74 ter','Non imponibile art. 74 ter'),(43,1,44,'Non imponibile art. 8/C','Non imponibile art. 8/C'),(44,1,45,'Esente art.10 C.27Q','Esente art.10 C.27Q'),(45,1,46,'Escluso art. 2','Escluso art. 2'),(46,1,47,'Non soggetto art. 7','Non soggetto art. 7'),(47,1,48,'Non imponibile art. 8','Non imponibile art. 8'),(48,1,49,'Non imponibile art. 9','Non imponibile art. 9'),(49,1,51,'Esente art. 10 n. 11','Esente art. 10 n. 11'),(50,1,52,'Escluso art. 15','Escluso art. 15'),(51,1,53,'Non sogg  art. 17 c.5','Non sogg  art. 17 c.5'),(52,1,54,'Esente art. 10 n. 18','Esente art. 10 n. 18'),(53,1,55,'Esente art. 10 n.1 a n.9','Esente art. 10 n.1 a n.9'),(54,1,56,'Art. 36 D.L. 41/95 acq.','Art. 36 D.L. 41/95 acq.'),(55,1,57,'Non imponibile art. 40 D.L. 331 c. 5','Non imponibile art. 40 D.L. 331 c. 5'),(56,1,58,'Non imponibile art. 41 D.L. 331/93','Non imponibile art. 41 D.L. 331/93'),(57,1,59,'Non imponibile art. 40 D.L. 331 c. 4 bis','Non imponibile art. 40 D.L. 331 c. 4 bis'),(58,1,60,'Non imponibile art. 40 D.L. 331 c. 6/8','Non imponibile art. 40 D.L. 331 c. 6/8'),(59,1,61,'Non imponibile art. 40 D.L. 331 c. 4 bis','Non imponibile art. 40 D.L. 331 c. 4 bis'),(60,1,62,'Non imponibile art. 58 D.L. 331','Non imponibile art. 58 D.L. 331'),(61,1,63,'Non imponibile art. 71 e 72','Non imponibile art. 71 e 72'),(62,1,64,'Non imponibile art. 74','Non imponibile art. 74'),(63,1,65,'Non imponibile art. 8 lett. a)','Non imponibile art. 8 lett. a)'),(64,1,66,'Non imponibile art. 8 lett. c)','Non imponibile art. 8 lett. c)'),(65,1,67,'Non imponibile art. 9 c. 2','Non imponibile art. 9 c. 2'),(66,1,68,'Non imponibile art. 9 punto 9)','Non imponibile art. 9 punto 9)'),(67,1,69,'Art. 17 comma 6 DPR 633/72 10%','Art. 17 comma 6 DPR 633/72 10%'),(68,1,70,'Art. 17 comma 6 DPR 633/72 20%','Art. 17 comma 6 DPR 633/72 20%'),(69,1,71,'Art. 17 comma 6 DPR 633/72 4%','Art. 17 comma 6 DPR 633/72 4%'),(70,1,72,'Acquisti da soggetti minimi','Acquisti da soggetti minimi'),(71,1,73,'Cess. fabbr. strum. art.10 n.8','Cess. fabbr. strum. art.10 n.8'),(72,1,74,'Art. 74 c. 7 e 8','Art. 74 c. 7 e 8'),(73,1,75,'Fuori campo Iva','Fuori campo Iva'),(74,1,76,'Non Imponibile San Marino','Non Imponibile San Marino'),(75,1,77,'Esente art. 10 27 quinquies','Esente art. 10 27 quinquies'),(76,1,78,'Autofatture 10% subappalto','Autofatture 10% subappalto'),(77,1,79,'Autofatture 20% subappalto','Autofatture 20% subappalto'),(78,1,80,'Autofatture 4% subappalto','Autofatture 4% subappalto'),(79,1,81,'Operaz. ag. viag. normale 4%','Operaz. ag. viag. normale 4%'),(80,1,82,'Operaz. ag. viag. normale 10%','Operaz. ag. viag. normale 10%'),(81,1,83,'Autof. acq. fabbr. strum. 10%','Autof. acq. fabbr. strum. 10%'),(82,1,84,'Autof. acq. fabbr. strum. 4%','Autof. acq. fabbr. strum. 4%'),(83,1,85,'Operaz. ag. viag. normale 20%','Operaz. ag. viag. normale 20%'),(84,1,86,'Autof. acq. fabbr. strum. 20%','Autof. acq. fabbr. strum. 20%'),(85,1,87,'Art. 36 D.L. 41/95 vend.','Art. 36 D.L. 41/95 vend.'),(86,1,88,'Art. 17 comma 6 DPR 633/72','Art. 17 comma 6 DPR 633/72'),(87,1,89,'Iva 21% indetraibile','Iva 21% indetraibile'),(88,1,90,'Iva in reverse charge indetraibile','Iva in reverse charge indetraibile'),(89,1,91,'Iva 22%','Iva 22%'),(90,1,92,'Iva 22% indetraibile','Iva 22% indetraibile'),(91,1,93,'Iva 22% indetraibile al 50%','Iva 22% indetraibile al 50%'),(92,1,94,'Art. 17 comma 6 DPR 633/72 22%','Art. 17 comma 6 DPR 633/72 22%'),(93,1,95,'Fuori campo IVA','Fuori campo IVA'),(94,1,96,'Es.art27DL98/11','Es.art27DL98/11'),(95,1,97,'Escluso art. 2','Escluso art. 2'),(96,1,98,'Escluso art. 3','Escluso art. 3'),(97,1,99,'Escluso art. 4','Escluso art. 4'),(98,1,100,'Escluso art. 5','Escluso art. 5'),(99,1,101,'Esc.art7tr noUE','Esc.art7tr noUE'),(100,1,102,'Escl.art7ter UE','Escl.art7ter UE'),(101,1,103,'Es. art.10 n.18','Es. art.10 n.18'),(102,1,104,'Es.art.10 n.1/9','Es.art.10 n.1/9'),(103,1,105,'Esente art. 10','Esente art. 10'),(104,1,106,'Art8,1/a triang','Art8,1/a triang'),(105,1,107,'N.I.art.8,2 ITA','N.I.art.8,2 ITA'),(106,1,108,'N.I.art.8,2 UE','N.I.art.8,2 UE'),(107,1,109,'N.I. art. 9 c.1','N.I. art. 9 c.1'),(108,1,110,'Escluso art. 15','Escluso art. 15'),(109,1,111,'Art.17,6 let.a-','Art.17,6 let.a-'),(110,1,112,'N.I. art.74 ter','N.I. art.74 ter'),(111,1,113,'N.I.art.14 L.49','N.I.art.14 L.49'),(112,1,114,'Es.art.10 n.27q','Es.art.10 n.27q'),(113,1,115,'N.I.a.8,2 no-UE','N.I.a.8,2 no-UE'),(114,1,116,'Es. art.10 n.11','Es. art.10 n.11'),(115,1,117,'N.I. art. 8 bis','N.I. art. 8 bis'),(116,1,118,'N.I. art.8,1 b','N.I. art.8,1 b'),(117,1,119,'N.I. art.8,1 c','N.I. art.8,1 c'),(118,1,120,'N.I. art.8,1 a','N.I. art.8,1 a'),(119,1,121,'N.V.escl.art.26','N.V.escl.art.26'),(120,1,122,'N.I. altri acq.','N.I. altri acq.'),(121,1,123,'Op. non sog.ter','Op. non sog.ter'),(122,1,124,'N.I. art. 9 c.2','N.I. art. 9 c.2'),(123,1,125,'Esc.art7quatrUE','Esc.art7quatrUE'),(124,1,126,'Esc.art7qtrNOUE','Esc.art7qtrNOUE'),(125,1,127,'Esc.art7quinqUE','Esc.art7quinqUE'),(126,1,128,'Esc.art7qnqNOUE','Esc.art7qnqNOUE'),(127,1,129,'Art.36-bis','Art.36-bis'),(128,1,130,'Art.17 comma 3','Art.17 comma 3'),(129,1,131,'DL41/95 art.36','DL41/95 art.36'),(130,1,132,'Es.art.19c3abis','Es.art.19c3abis'),(131,1,133,'N.I. art.38 q.','N.I. art.38 q.'),(132,1,134,'Escl.art.7nodet','Escl.art.7nodet'),(133,1,135,'Esc.art.7spt/sx','Esc.art.7spt/sx'),(134,1,136,'DL331/93 art.41','DL331/93 art.41'),(135,1,137,'DL331art42,40c2','DL331art42,40c2'),(136,1,138,'N.I.art.8,1 b2','N.I.art.8,1 b2'),(137,1,139,'Escl.art.7bisUE','Escl.art.7bisUE'),(138,1,140,'DL331 a.50b,4-g','DL331 a.50b,4-g'),(139,1,141,'DL331 a.50b,4-f','DL331 a.50b,4-f'),(140,1,142,'Cess. dep. IVA','Cess. dep. IVA'),(141,1,143,'N.I.Acq.dep.IVA','N.I.Acq.dep.IVA'),(142,1,144,'Es.art1 L190/14','Es.art1 L190/14'),(143,1,145,'Ces.gratuiteExp','Ces.gratuiteExp'),(144,1,146,'DL331/93 a.58,1','DL331/93 a.58,1'),(145,1,147,'Esc.legge67/88','Esc.legge67/88'),(146,1,148,'Imp.n.s. art.68','Imp.n.s. art.68'),(147,1,149,'Art.74 ter c. 8','Art.74 ter c. 8'),(148,1,150,'Escl.art.7bis','Escl.art.7bis'),(149,1,151,'N.I.art.71 V-SM','N.I.art.71 V-SM'),(150,1,152,'N.I. art. 72','N.I. art. 72'),(151,1,153,'N.I.art.74c.1-2','N.I.art.74c.1-2'),(152,1,154,'Art. 74 c. 7-8','Art. 74 c. 7-8'),(153,1,155,'Art. 17 c. 5','Art. 17 c. 5'),(154,1,156,'Art.17,6 lett.a','Art.17,6 lett.a'),(155,1,157,'Art.74 ter c. 8','Art.74 ter c. 8'),(156,1,158,'Art.17,6 lett.b','Art.17,6 lett.b'),(157,1,159,'Art.17,6 lett.c','Art.17,6 lett.c'),(158,1,160,'Art.17,6 let.a3','Art.17,6 let.a3'),(159,1,161,'Art.17,6,lett.d','Art.17,6,lett.d'),(160,1,162,'Aliq. Iva 2%','Aliq. Iva 2%'),(161,1,163,'Aliq. Iva 4%','Aliq. Iva 4%'),(162,1,164,'Aliq. Iva 5%','Aliq. Iva 5%'),(163,1,165,'Aliq. Iva 7%','Aliq. Iva 7%'),(164,1,166,'Aliq. Iva 8%','Aliq. Iva 8%'),(165,1,167,'Aliq. Iva 10%','Aliq. Iva 10%'),(166,1,168,'Aliq. Iva 12,3%','Aliq. Iva 12,3%'),(167,1,169,'Aliq. Iva 20%','Aliq. Iva 20%'),(168,1,170,'Aliq. Iva 21%','Aliq. Iva 21%'),(169,1,171,'Aliq. Iva 22%','Aliq. Iva 22%'),(170,1,172,'Aliq. Iva 7,3%','Aliq. Iva 7,3%'),(171,1,173,'Aliq. Iva 7,5%','Aliq. Iva 7,5%'),(172,1,174,'Aliq. Iva 7,65%','Aliq. Iva 7,65%'),(173,1,175,'Aliq. Iva 7,7%','Aliq. Iva 7,7%'),(174,1,176,'Aliq. Iva 7,95%','Aliq. Iva 7,95%'),(175,1,177,'Aliq. Iva 8,3%','Aliq. Iva 8,3%'),(176,1,178,'Aliq. Iva 8,5%','Aliq. Iva 8,5%'),(177,1,179,'Aliq. Iva 8,8%','Aliq. Iva 8,8%'),(178,1,180,'Scorporo 2%','Scorporo 2%'),(179,1,181,'Scorporo 4%','Scorporo 4%'),(180,1,182,'Scorporo 5%','Scorporo 5%'),(181,1,183,'Scorporo 7%','Scorporo 7%'),(182,1,184,'Scorporo 8%','Scorporo 8%'),(183,1,185,'Scorporo 10%','Scorporo 10%'),(184,1,186,'Scorporo 12,3%','Scorporo 12,3%'),(185,1,187,'Scorporo 20%','Scorporo 20%'),(186,1,188,'Scorporo 21%','Scorporo 21%'),(187,1,189,'Scorporo 22%','Scorporo 22%'),(188,1,190,'Scorporo 7,3%','Scorporo 7,3%'),(189,1,191,'Scorporo 7,5%','Scorporo 7,5%'),(190,1,192,'Scorporo 7,65%','Scorporo 7,65%'),(191,1,193,'Scorporo 7,7%','Scorporo 7,7%'),(192,1,194,'Scorporo 7,95%','Scorporo 7,95%'),(193,1,195,'Scorporo 8,3%','Scorporo 8,3%'),(194,1,196,'Scorporo 8,5%','Scorporo 8,5%'),(195,1,197,'Scorporo 8,8%','Scorporo 8,8%'),(196,1,198,'Corr. Ventilati','Corr. Ventilati'),(197,1,199,'Iva Vent. 2%','Iva Vent. 2%'),(198,1,200,'Iva Vent. 4%','Iva Vent. 4%'),(199,1,201,'Iva Vent. 5%','Iva Vent. 5%'),(200,1,202,'Iva Vent. 7%','Iva Vent. 7%'),(201,1,203,'Iva Vent. 8%','Iva Vent. 8%'),(202,1,204,'Iva Vent. 10%','Iva Vent. 10%'),(203,1,205,'Iva Vent. 12,3%','Iva Vent. 12,3%'),(204,1,206,'Iva Vent. 20%','Iva Vent. 20%'),(205,1,207,'Iva Vent. 21%','Iva Vent. 21%'),(206,1,208,'Iva Vent. 22%','Iva Vent. 22%'),(207,1,209,'Iva Vent. 7,3%','Iva Vent. 7,3%'),(208,1,210,'Iva Vent. 7,5%','Iva Vent. 7,5%'),(209,1,211,'Iva Vent. 7,65%','Iva Vent. 7,65%'),(210,1,212,'Iva Vent. 7,7%','Iva Vent. 7,7%'),(211,1,213,'Iva Vent. 7,95%','Iva Vent. 7,95%'),(212,1,214,'Iva Vent. 8,3%','Iva Vent. 8,3%'),(213,1,215,'Iva Vent. 8,5%','Iva Vent. 8,5%'),(214,1,216,'Iva Vent. 8,8%','Iva Vent. 8,8%'),(215,1,217,'Iva Tot. Indetr 2%','Iva Tot. Indetr 2%'),(216,1,218,'Iva Tot. Indetr 4%','Iva Tot. Indetr 4%'),(217,1,219,'Iva Tot. Indetr 5%','Iva Tot. Indetr 5%'),(218,1,220,'Iva Tot. Indetr 7%','Iva Tot. Indetr 7%'),(219,1,221,'Iva Tot. Indetr 8%','Iva Tot. Indetr 8%'),(220,1,222,'Iva Tot. Indetr 10%','Iva Tot. Indetr 10%'),(221,1,223,'Iva Tot. Indetr 12,3%','Iva Tot. Indetr 12,3%'),(222,1,224,'Iva Tot. Indetr 20%','Iva Tot. Indetr 20%'),(223,1,225,'Iva Tot. Indetr 21%','Iva Tot. Indetr 21%'),(224,1,226,'Iva Tot. Indetr 22%','Iva Tot. Indetr 22%'),(225,1,227,'Iva Tot. Indetr 7,3%','Iva Tot. Indetr 7,3%'),(226,1,228,'Iva Tot. Indetr 7,5%','Iva Tot. Indetr 7,5%'),(227,1,229,'Iva Tot. Indetr 7,65%','Iva Tot. Indetr 7,65%'),(228,1,230,'Iva Tot. Indetr 7,7%','Iva Tot. Indetr 7,7%'),(229,1,231,'Iva Tot. Indetr 7,95%','Iva Tot. Indetr 7,95%'),(230,1,232,'Iva Tot. Indetr 8,3%','Iva Tot. Indetr 8,3%'),(231,1,233,'Iva Tot. Indetr 8,5%','Iva Tot. Indetr 8,5%'),(232,1,234,'Iva Tot. Indetr 8,8%','Iva Tot. Indetr 8,8%'),(233,1,235,'Iva Agric. 2%','Iva Agric. 2%'),(234,1,236,'Iva Agric. 4%','Iva Agric. 4%'),(235,1,237,'Iva Agric. 5%','Iva Agric. 5%'),(236,1,238,'Iva Agric. 7%','Iva Agric. 7%'),(237,1,239,'Iva Agric. 8%','Iva Agric. 8%'),(238,1,240,'Iva Agric. 10%','Iva Agric. 10%'),(239,1,241,'Iva Agric. 12,3','Iva Agric. 12,3'),(240,1,242,'Iva Agric. 20%','Iva Agric. 20%'),(241,1,243,'Iva Agric. 21%','Iva Agric. 21%'),(242,1,244,'Iva Agric. 22%','Iva Agric. 22%'),(243,1,245,'Iva Agric. 7,3%','Iva Agric. 7,3%'),(244,1,246,'Iva Agric. 7,5%','Iva Agric. 7,5%'),(245,1,247,'Iva Agric. 7,65','Iva Agric. 7,65'),(246,1,248,'Iva Agric. 7,7%','Iva Agric. 7,7%'),(247,1,249,'Iva Agric. 7,95','Iva Agric. 7,95'),(248,1,250,'Iva Agric. 8,3%','Iva Agric. 8,3%'),(249,1,251,'Iva Agric. 8,5%','Iva Agric. 8,5%'),(250,1,252,'Iva Agric. 8,8%','Iva Agric. 8,8%'),(251,1,253,'Escluso Art.74 ter D.P.R. 633/72','Escluso Art.74 ter D.P.R. 633/72'),(252,1,254,'Art. 17 co. 6 lett. d-ter) del DPR 633/72 - Operazioni del settore energetico','Art. 17 co. 6 lett. d-ter) del DPR 633/72 - Operazioni del settore energetico'),(253,1,255,'Art.7 ter  DPR 633/1972 prestazione servizi UE (vendite)','Art.7 ter  DPR 633/1972 prestazione servizi UE (vendite)'),(254,1,256,'Art.7 ter  DPR 633/1972 prestazione servizi extra-UE','Art.7 ter  DPR 633/1972 prestazione servizi extra-UE'),(255,1,257,'Art.7 quater DPR 633/1972 prestazione servizi UE (vendite)','Art.7 quater DPR 633/1972 prestazione servizi UE (vendite)'),(256,1,258,'Art.7 quater DPR 633/1972 prestazione servizi extra-UE','Art.7 quater DPR 633/1972 prestazione servizi extra-UE'),(257,1,259,'Art.7 quinquies DPR 633/1972 (prestazione servizi)','Art.7 quinquies DPR 633/1972 (prestazione servizi)'),(258,1,260,'Art.7 sexies, septies DPR 633/1972 (prestazione servizi)','Art.7 sexies, septies DPR 633/1972 (prestazione servizi)'),(259,1,261,'Fuori campo Iva art. 2 DPR 633/1972','Fuori campo Iva art. 2 DPR 633/1972'),(260,1,262,'Fuori campo Iva art. 3 DPR 633/1972','Fuori campo Iva art. 3 DPR 633/1972'),(261,1,263,'Fuori campo Iva art. 4 DPR 633/1972','Fuori campo Iva art. 4 DPR 633/1972'),(262,1,264,'Fuori campo Iva art. 5 DPR 633/1972','Fuori campo Iva art. 5 DPR 633/1972'),(263,1,265,'Art. 38 c.5 DL  331/1993','Art. 38 c.5 DL  331/1993'),(264,1,266,'Art.17 c.3 DPR 633/1972','Art.17 c.3 DPR 633/1972'),(265,1,267,'Art.19 c.3 lett. b DPR 633/1972','Art.19 c.3 lett. b DPR 633/1972'),(266,1,268,'Art. 50 bis c.4 DL 331/1993','Art. 50 bis c.4 DL 331/1993'),(267,1,269,'Art.74 cc.1 e 2 DPR 633/1972','Art.74 cc.1 e 2 DPR 633/1972'),(268,1,270,'Art.19 c.3 lett. e DPR 633/1972','Art.19 c.3 lett. e DPR 633/1972'),(269,1,271,'Art.13 DPR 633/1972','Art.13 DPR 633/1972'),(270,1,272,'Art. 27 c.1 e 2 DL 98/2011 (contribuenti minimi)','Art. 27 c.1 e 2 DL 98/2011 (contribuenti minimi)'),(271,1,273,'Art.1 c.54-89 L. 190/2014 e succ. modifiche (regime forfettario)','Art.1 c.54-89 L. 190/2014 e succ. modifiche (regime forfettario)'),(272,1,274,'Art.26 c.3 DPR 633/1972','Art.26 c.3 DPR 633/1972'),(273,1,275,'DM 9/4/1993','DM 9/4/1993'),(274,1,276,'Art.26 bis L.196/1997','Art.26 bis L.196/1997'),(275,1,277,'Art.8 c.35 L. 67/1988','Art.8 c.35 L. 67/1988'),(276,1,278,'Art.8 c.1 lett.a DPR 633/1972','Art.8 c.1 lett.a DPR 633/1972'),(277,1,279,'Art.8 c.1 lett.b DPR 633/1972','Art.8 c.1 lett.b DPR 633/1972'),(278,1,280,'Non imp. art. 8 c.1 lett. b-bis  DPR 633/1972','Non imp. art. 8 c.1 lett. b-bis  DPR 633/1972'),(279,1,281,'Non imp. art.9 c.2 DPR 633/1972','Non imp. art.9 c.2 DPR 633/1972'),(280,1,282,'Non imp.art.72 c.1 DPR 633/1972','Non imp.art.72 c.1 DPR 633/1972'),(281,1,283,'Non imp. art.50 bis c.4 lett. g DL 331/93','Non imp. art.50 bis c.4 lett. g DL 331/93'),(282,1,284,'Non imp. art.14 legge n. 49/1987','Non imp. art.14 legge n. 49/1987'),(283,1,285,'Non imp. art.50 bis c.4 lett. f DL 331/93','Non imp. art.50 bis c.4 lett. f DL 331/93'),(284,1,286,'Non imp. art.41 DL 331/93','Non imp. art.41 DL 331/93'),(285,1,287,'Non imp. art.58 c.1 DL 331/93','Non imp. art.58 c.1 DL 331/93'),(286,1,288,'Art. 8 bis DPR 633/1972','Art. 8 bis DPR 633/1972'),(287,1,289,'Non imp. art. 8 bis c.2 DPR 633/1972','Non imp. art. 8 bis c.2 DPR 633/1972'),(288,1,290,'Non imp. art. 8 c.1 lett. c DPR 633/1972','Non imp. art. 8 c.1 lett. c DPR 633/1972'),(289,1,291,'Art.9 c.1 DPR 633/1972','Art.9 c.1 DPR 633/1972'),(290,1,292,'Non imp. art.72 DPR 633/1972','Non imp. art.72 DPR 633/1972'),(291,1,293,'Art. 71 DPR 633/1972','Art. 71 DPR 633/1972'),(292,1,294,'Art. 2 c. 2, n. 4 DPR 633/1972','Art. 2 c. 2, n. 4 DPR 633/1972'),(293,1,295,'Non imp. art.38 quater c.1 DPR 633/1972','Non imp. art.38 quater c.1 DPR 633/1972'),(294,1,296,'Regime OSS, D.Lgs. 83/2021','Regime OSS, D.Lgs. 83/2021');
/*!40000 ALTER TABLE `co_iva_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_mandati_sepa`
--

DROP TABLE IF EXISTS `co_mandati_sepa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_mandati_sepa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_banca` int NOT NULL,
  `id_mandato` varchar(255) NOT NULL,
  `data_firma_mandato` date NOT NULL,
  `singola_disposizione` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_banca` (`id_banca`),
  CONSTRAINT `co_mandati_sepa_ibfk_1` FOREIGN KEY (`id_banca`) REFERENCES `co_banche` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_mandati_sepa`
--

LOCK TABLES `co_mandati_sepa` WRITE;
/*!40000 ALTER TABLE `co_mandati_sepa` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_mandati_sepa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_movimenti`
--

DROP TABLE IF EXISTS `co_movimenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_movimenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idmastrino` int NOT NULL,
  `data` date DEFAULT NULL,
  `iddocumento` int NOT NULL,
  `id_scadenza` int DEFAULT NULL,
  `is_insoluto` tinyint(1) NOT NULL DEFAULT '0',
  `is_apertura` tinyint(1) NOT NULL DEFAULT '0',
  `is_chiusura` tinyint(1) NOT NULL DEFAULT '0',
  `id_anagrafica` int DEFAULT NULL,
  `descrizione` text,
  `note` text,
  `idconto` int NOT NULL,
  `totale` decimal(15,6) DEFAULT NULL,
  `primanota` tinyint NOT NULL,
  `totale_reddito` decimal(15,6) NOT NULL DEFAULT '0.000000',
  `verified_at` timestamp NULL DEFAULT NULL,
  `verified_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_scadenza` (`id_scadenza`),
  CONSTRAINT `co_movimenti_ibfk_1` FOREIGN KEY (`id_scadenza`) REFERENCES `co_scadenziario` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_movimenti`
--

LOCK TABLES `co_movimenti` WRITE;
/*!40000 ALTER TABLE `co_movimenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_movimenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_movimenti_modelli`
--

DROP TABLE IF EXISTS `co_movimenti_modelli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_movimenti_modelli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idmastrino` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descrizione` text NOT NULL,
  `idconto` int NOT NULL,
  `totale` decimal(15,6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_movimenti_modelli`
--

LOCK TABLES `co_movimenti_modelli` WRITE;
/*!40000 ALTER TABLE `co_movimenti_modelli` DISABLE KEYS */;
INSERT INTO `co_movimenti_modelli` VALUES (1,1,'Anticipo fattura','Anticipo fattura num. {numero} del {data}',-1,0.000000),(2,1,'Anticipo fattura','Anticipo fattura num. {numero} del {data}',112,0.000000),(3,1,'Anticipo fattura','Anticipo fattura num. {numero} del {data}',68,0.000000),(4,2,'Accredito anticipo','Accredito anticipo fattura num. {numero} del {data}',112,0.000000),(5,2,'Accredito anticipo','Accredito anticipo fattura num. {numero} del {data}',2,0.000000),(6,3,'Liquidazione salari e stipendi','Liquidazione retribuzione relativa al mese di ...',82,0.000000),(7,3,'Liquidazione salari e stipendi','Liquidazione retribuzione relativa al mese di ...',117,0.000000),(8,3,'Liquidazione salari e stipendi','Liquidazione retribuzione relativa al mese di ...',116,0.000000),(9,4,'Pagamento salari e stipendi','Pagamento ai dipendenti delle retribuzioni nette del mese di ...',116,0.000000),(10,4,'Pagamento salari e stipendi','Pagamento ai dipendenti delle retribuzioni nette del mese di ...',117,0.000000),(11,4,'Pagamento salari e stipendi','Pagamento ai dipendenti delle retribuzioni nette del mese di ...',118,0.000000),(12,4,'Pagamento salari e stipendi','Pagamento ai dipendenti delle retribuzioni nette del mese di ...',2,0.000000);
/*!40000 ALTER TABLE `co_movimenti_modelli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_pagamenti`
--

DROP TABLE IF EXISTS `co_pagamenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_pagamenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `giorno` tinyint NOT NULL,
  `num_giorni` int NOT NULL,
  `prc` decimal(5,2) NOT NULL,
  `idconto_vendite` int DEFAULT NULL,
  `idconto_acquisti` int DEFAULT NULL,
  `predefined` tinyint NOT NULL,
  `codice_modalita_pagamento_fe` varchar(4) DEFAULT NULL,
  `descrizione_incasso` text NOT NULL,
  `importo_fisso_incasso` decimal(15,6) NOT NULL,
  `importo_percentuale_incasso` decimal(15,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `codice_modalita_pagamento_fe` (`codice_modalita_pagamento_fe`),
  CONSTRAINT `co_pagamenti_ibfk_1` FOREIGN KEY (`codice_modalita_pagamento_fe`) REFERENCES `fe_modalita_pagamento` (`codice`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_pagamenti`
--

LOCK TABLES `co_pagamenti` WRITE;
/*!40000 ALTER TABLE `co_pagamenti` DISABLE KEYS */;
INSERT INTO `co_pagamenti` VALUES (1,0,0,100.00,1,1,0,'MP01','',0.000000,0.000000),(2,0,30,100.00,1,1,0,'MP01','',0.000000,0.000000),(3,15,30,100.00,1,1,0,'MP01','',0.000000,0.000000),(4,0,30,100.00,2,2,0,'MP12','',0.000000,0.000000),(5,0,60,100.00,2,2,0,'MP12','',0.000000,0.000000),(6,0,90,100.00,2,2,0,'MP12','',0.000000,0.000000),(7,0,120,100.00,2,2,0,'MP12','',0.000000,0.000000),(8,0,150,100.00,2,2,0,'MP12','',0.000000,0.000000),(9,0,180,100.00,2,2,0,'MP12','',0.000000,0.000000),(10,0,30,50.00,2,2,0,'MP12','',0.000000,0.000000),(11,0,60,50.00,2,2,0,'MP12','',0.000000,0.000000),(12,0,30,33.00,2,2,0,'MP12','',0.000000,0.000000),(13,0,60,33.00,2,2,0,'MP12','',0.000000,0.000000),(14,0,90,34.00,2,2,0,'MP12','',0.000000,0.000000),(15,0,30,25.00,2,2,0,'MP12','',0.000000,0.000000),(16,0,60,25.00,2,2,0,'MP12','',0.000000,0.000000),(17,0,90,25.00,2,2,0,'MP12','',0.000000,0.000000),(18,0,120,25.00,2,2,0,'MP12','',0.000000,0.000000),(19,0,30,20.00,2,2,0,'MP12','',0.000000,0.000000),(20,0,60,20.00,2,2,0,'MP12','',0.000000,0.000000),(21,0,90,20.00,2,2,0,'MP12','',0.000000,0.000000),(22,0,120,20.00,2,2,0,'MP12','',0.000000,0.000000),(23,0,150,20.00,2,2,0,'MP12','',0.000000,0.000000),(24,0,30,16.00,2,2,0,'MP12','',0.000000,0.000000),(25,0,60,16.00,2,2,0,'MP12','',0.000000,0.000000),(26,0,90,16.00,2,2,0,'MP12','',0.000000,0.000000),(27,0,120,16.00,2,2,0,'MP12','',0.000000,0.000000),(28,0,150,16.00,2,2,0,'MP12','',0.000000,0.000000),(29,0,180,20.00,2,2,0,'MP12','',0.000000,0.000000),(30,-1,30,100.00,2,2,0,'MP12','',0.000000,0.000000),(31,-1,60,100.00,2,2,0,'MP12','',0.000000,0.000000),(32,-1,90,100.00,2,2,0,'MP12','',0.000000,0.000000),(33,-1,120,100.00,2,2,0,'MP12','',0.000000,0.000000),(34,-1,150,100.00,2,2,0,'MP12','',0.000000,0.000000),(35,-1,180,100.00,2,2,0,'MP12','',0.000000,0.000000),(36,-1,30,50.00,2,2,0,'MP12','',0.000000,0.000000),(37,-1,60,50.00,2,2,0,'MP12','',0.000000,0.000000),(38,-1,30,33.00,2,2,0,'MP12','',0.000000,0.000000),(39,-1,60,33.00,2,2,0,'MP12','',0.000000,0.000000),(40,-1,90,34.00,2,2,0,'MP12','',0.000000,0.000000),(41,-1,30,25.00,2,2,0,'MP12','',0.000000,0.000000),(42,-1,60,25.00,2,2,0,'MP12','',0.000000,0.000000),(43,-1,90,25.00,2,2,0,'MP12','',0.000000,0.000000),(44,-1,120,25.00,2,2,0,'MP12','',0.000000,0.000000),(45,-1,30,20.00,2,2,0,'MP12','',0.000000,0.000000),(46,-1,60,20.00,2,2,0,'MP12','',0.000000,0.000000),(47,-1,90,20.00,2,2,0,'MP12','',0.000000,0.000000),(48,-1,120,20.00,2,2,0,'MP12','',0.000000,0.000000),(49,-1,150,20.00,2,2,0,'MP12','',0.000000,0.000000),(50,-1,30,16.00,2,2,0,'MP12','',0.000000,0.000000),(51,-1,60,16.00,2,2,0,'MP12','',0.000000,0.000000),(52,-1,90,16.00,2,2,0,'MP12','',0.000000,0.000000),(53,-1,120,16.00,2,2,0,'MP12','',0.000000,0.000000),(54,-1,150,16.00,2,2,0,'MP12','',0.000000,0.000000),(55,-1,180,20.00,2,2,0,'MP12','',0.000000,0.000000),(56,0,30,100.00,2,2,0,'MP05','',0.000000,0.000000),(57,0,60,100.00,2,2,0,'MP05','',0.000000,0.000000),(58,0,90,100.00,2,2,0,'MP05','',0.000000,0.000000),(59,0,120,100.00,2,2,0,'MP05','',0.000000,0.000000),(60,0,150,100.00,2,2,0,'MP05','',0.000000,0.000000),(61,0,180,100.00,2,2,0,'MP05','',0.000000,0.000000),(62,0,30,50.00,2,2,0,'MP05','',0.000000,0.000000),(63,0,60,50.00,2,2,0,'MP05','',0.000000,0.000000),(64,0,30,33.00,2,2,0,'MP05','',0.000000,0.000000),(65,0,60,33.00,2,2,0,'MP05','',0.000000,0.000000),(66,0,90,34.00,2,2,0,'MP05','',0.000000,0.000000),(67,0,30,25.00,2,2,0,'MP05','',0.000000,0.000000),(68,0,60,25.00,2,2,0,'MP05','',0.000000,0.000000),(69,0,90,25.00,2,2,0,'MP05','',0.000000,0.000000),(70,0,120,25.00,2,2,0,'MP05','',0.000000,0.000000),(71,0,30,20.00,2,2,0,'MP05','',0.000000,0.000000),(72,0,60,20.00,2,2,0,'MP05','',0.000000,0.000000),(73,0,90,20.00,2,2,0,'MP05','',0.000000,0.000000),(74,0,120,20.00,2,2,0,'MP05','',0.000000,0.000000),(75,0,150,20.00,2,2,0,'MP05','',0.000000,0.000000),(76,0,30,16.00,2,2,0,'MP05','',0.000000,0.000000),(77,0,60,16.00,2,2,0,'MP05','',0.000000,0.000000),(78,0,90,16.00,2,2,0,'MP05','',0.000000,0.000000),(79,0,120,16.00,2,2,0,'MP05','',0.000000,0.000000),(80,0,150,16.00,2,2,0,'MP05','',0.000000,0.000000),(81,0,180,20.00,2,2,0,'MP05','',0.000000,0.000000),(82,-1,30,100.00,2,2,0,'MP05','',0.000000,0.000000),(83,-1,60,100.00,2,2,0,'MP05','',0.000000,0.000000),(84,-1,90,100.00,2,2,0,'MP05','',0.000000,0.000000),(85,-1,120,100.00,2,2,0,'MP05','',0.000000,0.000000),(86,-1,150,100.00,2,2,0,'MP05','',0.000000,0.000000),(87,-1,180,100.00,2,2,0,'MP05','',0.000000,0.000000),(88,-1,30,50.00,2,2,0,'MP05','',0.000000,0.000000),(89,-1,60,50.00,2,2,0,'MP05','',0.000000,0.000000),(90,-1,30,33.00,2,2,0,'MP05','',0.000000,0.000000),(91,-1,60,33.00,2,2,0,'MP05','',0.000000,0.000000),(92,-1,90,34.00,2,2,0,'MP05','',0.000000,0.000000),(93,-1,30,25.00,2,2,0,'MP05','',0.000000,0.000000),(94,-1,60,25.00,2,2,0,'MP05','',0.000000,0.000000),(95,-1,90,25.00,2,2,0,'MP05','',0.000000,0.000000),(96,-1,120,25.00,2,2,0,'MP05','',0.000000,0.000000),(97,-1,30,20.00,2,2,0,'MP05','',0.000000,0.000000),(98,-1,60,20.00,2,2,0,'MP05','',0.000000,0.000000),(99,-1,90,20.00,2,2,0,'MP05','',0.000000,0.000000),(100,-1,120,20.00,2,2,0,'MP05','',0.000000,0.000000),(101,-1,150,20.00,2,2,0,'MP05','',0.000000,0.000000),(102,-1,30,16.00,2,2,0,'MP05','',0.000000,0.000000),(103,-1,60,16.00,2,2,0,'MP05','',0.000000,0.000000),(104,-1,90,16.00,2,2,0,'MP05','',0.000000,0.000000),(105,-1,120,16.00,2,2,0,'MP05','',0.000000,0.000000),(106,-1,150,16.00,2,2,0,'MP05','',0.000000,0.000000),(107,-1,180,20.00,2,2,0,'MP05','',0.000000,0.000000),(108,0,0,100.00,NULL,NULL,0,'MP06','',0.000000,0.000000),(109,0,0,100.00,NULL,NULL,1,'MP02','',0.000000,0.000000),(110,0,0,100.00,NULL,NULL,1,'MP08','',0.000000,0.000000),(111,0,0,100.00,1,1,1,'MP01','',0.000000,0.000000),(112,0,0,100.00,NULL,NULL,0,'MP08','',0.000000,0.000000),(113,0,10,100.00,2,2,1,'MP05','',0.000000,0.000000),(114,0,1,100.00,NULL,NULL,1,'MP03','',0.000000,0.000000),(115,0,1,100.00,NULL,NULL,1,'MP04','',0.000000,0.000000),(116,0,1,100.00,NULL,NULL,1,'MP06','',0.000000,0.000000),(117,0,1,100.00,NULL,NULL,1,'MP07','',0.000000,0.000000),(118,0,1,100.00,NULL,NULL,1,'MP09','',0.000000,0.000000),(119,0,1,100.00,NULL,NULL,1,'MP10','',0.000000,0.000000),(120,0,1,100.00,NULL,NULL,1,'MP11','',0.000000,0.000000),(121,0,1,100.00,NULL,NULL,1,'MP13','',0.000000,0.000000),(122,0,1,100.00,NULL,NULL,1,'MP14','',0.000000,0.000000),(123,0,1,100.00,NULL,NULL,1,'MP15','',0.000000,0.000000),(124,0,1,100.00,NULL,NULL,1,'MP16','',0.000000,0.000000),(125,0,1,100.00,NULL,NULL,1,'MP17','',0.000000,0.000000),(126,0,1,100.00,NULL,NULL,1,'MP18','',0.000000,0.000000),(127,0,1,100.00,NULL,NULL,1,'MP19','',0.000000,0.000000),(128,0,1,100.00,NULL,NULL,1,'MP20','',0.000000,0.000000),(129,0,1,100.00,NULL,NULL,1,'MP21','',0.000000,0.000000),(130,0,1,100.00,NULL,NULL,1,'MP22','',0.000000,0.000000),(131,0,1,100.00,NULL,NULL,1,'MP23','',0.000000,0.000000),(132,0,0,100.00,2,2,1,'MP12','',0.000000,0.000000);
/*!40000 ALTER TABLE `co_pagamenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_pagamenti_lang`
--

DROP TABLE IF EXISTS `co_pagamenti_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_pagamenti_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `co_pagamenti_lang_ibfk_1` (`id_record`),
  KEY `co_pagamenti_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `co_pagamenti_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `co_pagamenti` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `co_pagamenti_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_pagamenti_lang`
--

LOCK TABLES `co_pagamenti_lang` WRITE;
/*!40000 ALTER TABLE `co_pagamenti_lang` DISABLE KEYS */;
INSERT INTO `co_pagamenti_lang` VALUES (1,1,1,'Rimessa diretta','Rimessa diretta'),(2,1,2,'Rimessa diretta a 30gg','Rimessa diretta a 30gg'),(3,1,3,'Rimessa diretta 30gg fisso al 15','Rimessa diretta 30gg fisso al 15'),(4,1,4,'Ri.Ba. 30gg d.f.','Ri.Ba. 30gg d.f.'),(5,1,5,'Ri.Ba. 60gg d.f.','Ri.Ba. 60gg d.f.'),(6,1,6,'Ri.Ba. 90gg d.f.','Ri.Ba. 90gg d.f.'),(7,1,7,'Ri.Ba. 120gg d.f.','Ri.Ba. 120gg d.f.'),(8,1,8,'Ri.Ba. 150gg d.f.','Ri.Ba. 150gg d.f.'),(9,1,9,'Ri.Ba. 180gg d.f.','Ri.Ba. 180gg d.f.'),(10,1,10,'Ri.Ba. 30/60gg d.f.','Ri.Ba. 30/60gg d.f.'),(11,1,11,'Ri.Ba. 30/60gg d.f.','Ri.Ba. 30/60gg d.f.'),(12,1,12,'Ri.Ba. 30/60/90gg d.f.','Ri.Ba. 30/60/90gg d.f.'),(13,1,13,'Ri.Ba. 30/60/90gg d.f.','Ri.Ba. 30/60/90gg d.f.'),(14,1,14,'Ri.Ba. 30/60/90gg d.f.','Ri.Ba. 30/60/90gg d.f.'),(15,1,15,'Ri.Ba. 30/60/90/120gg d.f.','Ri.Ba. 30/60/90/120gg d.f.'),(16,1,16,'Ri.Ba. 30/60/90/120gg d.f.','Ri.Ba. 30/60/90/120gg d.f.'),(17,1,17,'Ri.Ba. 30/60/90/120gg d.f.','Ri.Ba. 30/60/90/120gg d.f.'),(18,1,18,'Ri.Ba. 30/60/90/120gg d.f.','Ri.Ba. 30/60/90/120gg d.f.'),(19,1,19,'Ri.Ba. 30/60/90/120/150gg d.f.','Ri.Ba. 30/60/90/120/150gg d.f.'),(20,1,20,'Ri.Ba. 30/60/90/120/150gg d.f.','Ri.Ba. 30/60/90/120/150gg d.f.'),(21,1,21,'Ri.Ba. 30/60/90/120/150gg d.f.','Ri.Ba. 30/60/90/120/150gg d.f.'),(22,1,22,'Ri.Ba. 30/60/90/120/150gg d.f.','Ri.Ba. 30/60/90/120/150gg d.f.'),(23,1,23,'Ri.Ba. 30/60/90/120/150gg d.f.','Ri.Ba. 30/60/90/120/150gg d.f.'),(24,1,24,'Ri.Ba. 30/60/90/120/150/180gg d.f.','Ri.Ba. 30/60/90/120/150/180gg d.f.'),(25,1,25,'Ri.Ba. 30/60/90/120/150/180gg d.f.','Ri.Ba. 30/60/90/120/150/180gg d.f.'),(26,1,26,'Ri.Ba. 30/60/90/120/150/180gg d.f.','Ri.Ba. 30/60/90/120/150/180gg d.f.'),(27,1,27,'Ri.Ba. 30/60/90/120/150/180gg d.f.','Ri.Ba. 30/60/90/120/150/180gg d.f.'),(28,1,28,'Ri.Ba. 30/60/90/120/150/180gg d.f.','Ri.Ba. 30/60/90/120/150/180gg d.f.'),(29,1,29,'Ri.Ba. 30/60/90/120/150/180gg d.f.','Ri.Ba. 30/60/90/120/150/180gg d.f.'),(30,1,30,'Ri.Ba. 30gg d.f.f.m.','Ri.Ba. 30gg d.f.f.m.'),(31,1,31,'Ri.Ba. 60gg d.f.f.m.','Ri.Ba. 60gg d.f.f.m.'),(32,1,32,'Ri.Ba. 90gg d.f.f.m.','Ri.Ba. 90gg d.f.f.m.'),(33,1,33,'Ri.Ba. 120gg d.f.f.m.','Ri.Ba. 120gg d.f.f.m.'),(34,1,34,'Ri.Ba. 150gg d.f.f.m.','Ri.Ba. 150gg d.f.f.m.'),(35,1,35,'Ri.Ba. 180gg d.f.f.m.','Ri.Ba. 180gg d.f.f.m.'),(36,1,36,'Ri.Ba. 30/60gg d.f.f.m.','Ri.Ba. 30/60gg d.f.f.m.'),(37,1,37,'Ri.Ba. 30/60gg d.f.f.m.','Ri.Ba. 30/60gg d.f.f.m.'),(38,1,38,'Ri.Ba. 30/60/90gg d.f.f.m.','Ri.Ba. 30/60/90gg d.f.f.m.'),(39,1,39,'Ri.Ba. 30/60/90gg d.f.f.m.','Ri.Ba. 30/60/90gg d.f.f.m.'),(40,1,40,'Ri.Ba. 30/60/90gg d.f.f.m.','Ri.Ba. 30/60/90gg d.f.f.m.'),(41,1,41,'Ri.Ba. 30/60/90/120gg d.f.f.m.','Ri.Ba. 30/60/90/120gg d.f.f.m.'),(42,1,42,'Ri.Ba. 30/60/90/120gg d.f.f.m.','Ri.Ba. 30/60/90/120gg d.f.f.m.'),(43,1,43,'Ri.Ba. 30/60/90/120gg d.f.f.m.','Ri.Ba. 30/60/90/120gg d.f.f.m.'),(44,1,44,'Ri.Ba. 30/60/90/120gg d.f.f.m.','Ri.Ba. 30/60/90/120gg d.f.f.m.'),(45,1,45,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.','Ri.Ba. 30/60/90/120/150gg d.f.f.m.'),(46,1,46,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.','Ri.Ba. 30/60/90/120/150gg d.f.f.m.'),(47,1,47,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.','Ri.Ba. 30/60/90/120/150gg d.f.f.m.'),(48,1,48,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.','Ri.Ba. 30/60/90/120/150gg d.f.f.m.'),(49,1,49,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.','Ri.Ba. 30/60/90/120/150gg d.f.f.m.'),(50,1,50,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.','Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.'),(51,1,51,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.','Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.'),(52,1,52,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.','Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.'),(53,1,53,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.','Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.'),(54,1,54,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.','Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.'),(55,1,55,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.','Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.'),(56,1,56,'Bonifico 30gg d.f.','Bonifico 30gg d.f.'),(57,1,57,'Bonifico 60gg d.f.','Bonifico 60gg d.f.'),(58,1,58,'Bonifico 90gg d.f.','Bonifico 90gg d.f.'),(59,1,59,'Bonifico 120gg d.f.','Bonifico 120gg d.f.'),(60,1,60,'Bonifico 150gg d.f.','Bonifico 150gg d.f.'),(61,1,61,'Bonifico 180gg d.f.','Bonifico 180gg d.f.'),(62,1,62,'Bonifico 30/60gg d.f.','Bonifico 30/60gg d.f.'),(63,1,63,'Bonifico 30/60gg d.f.','Bonifico 30/60gg d.f.'),(64,1,64,'Bonifico 30/60/90gg d.f.','Bonifico 30/60/90gg d.f.'),(65,1,65,'Bonifico 30/60/90gg d.f.','Bonifico 30/60/90gg d.f.'),(66,1,66,'Bonifico 30/60/90gg d.f.','Bonifico 30/60/90gg d.f.'),(67,1,67,'Bonifico 30/60/90/120gg d.f.','Bonifico 30/60/90/120gg d.f.'),(68,1,68,'Bonifico 30/60/90/120gg d.f.','Bonifico 30/60/90/120gg d.f.'),(69,1,69,'Bonifico 30/60/90/120gg d.f.','Bonifico 30/60/90/120gg d.f.'),(70,1,70,'Bonifico 30/60/90/120gg d.f.','Bonifico 30/60/90/120gg d.f.'),(71,1,71,'Bonifico 30/60/90/120/150gg d.f.','Bonifico 30/60/90/120/150gg d.f.'),(72,1,72,'Bonifico 30/60/90/120/150gg d.f.','Bonifico 30/60/90/120/150gg d.f.'),(73,1,73,'Bonifico 30/60/90/120/150gg d.f.','Bonifico 30/60/90/120/150gg d.f.'),(74,1,74,'Bonifico 30/60/90/120/150gg d.f.','Bonifico 30/60/90/120/150gg d.f.'),(75,1,75,'Bonifico 30/60/90/120/150gg d.f.','Bonifico 30/60/90/120/150gg d.f.'),(76,1,76,'Bonifico 30/60/90/120/150/180gg d.f.','Bonifico 30/60/90/120/150/180gg d.f.'),(77,1,77,'Bonifico 30/60/90/120/150/180gg d.f.','Bonifico 30/60/90/120/150/180gg d.f.'),(78,1,78,'Bonifico 30/60/90/120/150/180gg d.f.','Bonifico 30/60/90/120/150/180gg d.f.'),(79,1,79,'Bonifico 30/60/90/120/150/180gg d.f.','Bonifico 30/60/90/120/150/180gg d.f.'),(80,1,80,'Bonifico 30/60/90/120/150/180gg d.f.','Bonifico 30/60/90/120/150/180gg d.f.'),(81,1,81,'Bonifico 30/60/90/120/150/180gg d.f.','Bonifico 30/60/90/120/150/180gg d.f.'),(82,1,82,'Bonifico 30gg d.f.f.m.','Bonifico 30gg d.f.f.m.'),(83,1,83,'Bonifico 60gg d.f.f.m.','Bonifico 60gg d.f.f.m.'),(84,1,84,'Bonifico 90gg d.f.f.m.','Bonifico 90gg d.f.f.m.'),(85,1,85,'Bonifico 120gg d.f.f.m.','Bonifico 120gg d.f.f.m.'),(86,1,86,'Bonifico 150gg d.f.f.m.','Bonifico 150gg d.f.f.m.'),(87,1,87,'Bonifico 180gg d.f.f.m.','Bonifico 180gg d.f.f.m.'),(88,1,88,'Bonifico 30/60gg d.f.f.m.','Bonifico 30/60gg d.f.f.m.'),(89,1,89,'Bonifico 30/60gg d.f.f.m.','Bonifico 30/60gg d.f.f.m.'),(90,1,90,'Bonifico 30/60/90gg d.f.f.m.','Bonifico 30/60/90gg d.f.f.m.'),(91,1,91,'Bonifico 30/60/90gg d.f.f.m.','Bonifico 30/60/90gg d.f.f.m.'),(92,1,92,'Bonifico 30/60/90gg d.f.f.m.','Bonifico 30/60/90gg d.f.f.m.'),(93,1,93,'Bonifico 30/60/90/120gg d.f.f.m.','Bonifico 30/60/90/120gg d.f.f.m.'),(94,1,94,'Bonifico 30/60/90/120gg d.f.f.m.','Bonifico 30/60/90/120gg d.f.f.m.'),(95,1,95,'Bonifico 30/60/90/120gg d.f.f.m.','Bonifico 30/60/90/120gg d.f.f.m.'),(96,1,96,'Bonifico 30/60/90/120gg d.f.f.m.','Bonifico 30/60/90/120gg d.f.f.m.'),(97,1,97,'Bonifico 30/60/90/120/150gg d.f.f.m.','Bonifico 30/60/90/120/150gg d.f.f.m.'),(98,1,98,'Bonifico 30/60/90/120/150gg d.f.f.m.','Bonifico 30/60/90/120/150gg d.f.f.m.'),(99,1,99,'Bonifico 30/60/90/120/150gg d.f.f.m.','Bonifico 30/60/90/120/150gg d.f.f.m.'),(100,1,100,'Bonifico 30/60/90/120/150gg d.f.f.m.','Bonifico 30/60/90/120/150gg d.f.f.m.'),(101,1,101,'Bonifico 30/60/90/120/150gg d.f.f.m.','Bonifico 30/60/90/120/150gg d.f.f.m.'),(102,1,102,'Bonifico 30/60/90/120/150/180gg d.f.f.m.','Bonifico 30/60/90/120/150/180gg d.f.f.m.'),(103,1,103,'Bonifico 30/60/90/120/150/180gg d.f.f.m.','Bonifico 30/60/90/120/150/180gg d.f.f.m.'),(104,1,104,'Bonifico 30/60/90/120/150/180gg d.f.f.m.','Bonifico 30/60/90/120/150/180gg d.f.f.m.'),(105,1,105,'Bonifico 30/60/90/120/150/180gg d.f.f.m.','Bonifico 30/60/90/120/150/180gg d.f.f.m.'),(106,1,106,'Bonifico 30/60/90/120/150/180gg d.f.f.m.','Bonifico 30/60/90/120/150/180gg d.f.f.m.'),(107,1,107,'Bonifico 30/60/90/120/150/180gg d.f.f.m.','Bonifico 30/60/90/120/150/180gg d.f.f.m.'),(108,1,108,'Cambiale','Cambiale'),(109,1,109,'Assegno','Assegno'),(110,1,110,'Bancomat','Bancomat'),(111,1,111,'Contanti','Contanti'),(112,1,112,'Visa','Visa'),(113,1,113,'Bonifico bancario','Bonifico bancario'),(114,1,114,'Assegno circolare','Assegno circolare'),(115,1,115,'Contanti presso Tesoreria','Contanti presso Tesoreria'),(116,1,116,'Vaglia cambiario','Vaglia cambiario'),(117,1,117,'Bollettino bancario','Bollettino bancario'),(118,1,118,'RID','RID'),(119,1,119,'RID utenze','RID utenze'),(120,1,120,'RID veloce','RID veloce'),(121,1,121,'MAV','MAV'),(122,1,122,'Quietanza erario','Quietanza erario'),(123,1,123,'Giroconto su conti di contabilit├á speciale','Giroconto su conti di contabilit├á speciale'),(124,1,124,'Domiciliazione bancaria','Domiciliazione bancaria'),(125,1,125,'Domiciliazione postale','Domiciliazione postale'),(126,1,126,'Bollettino di c/c postale','Bollettino di c/c postale'),(127,1,127,'SEPA Direct Debit','SEPA Direct Debit'),(128,1,128,'SEPA Direct Debit CORE','SEPA Direct Debit CORE'),(129,1,129,'SEPA Direct Debit B2B','SEPA Direct Debit B2B'),(130,1,130,'Trattenuta su somme gi├á riscosse','Trattenuta su somme gi├á riscosse'),(131,1,131,'PagoPA','PagoPA'),(132,1,132,'Ri.Ba.','Ri.Ba.');
/*!40000 ALTER TABLE `co_pagamenti_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_pianodeiconti1`
--

DROP TABLE IF EXISTS `co_pianodeiconti1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_pianodeiconti1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(10) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_pianodeiconti1`
--

LOCK TABLES `co_pianodeiconti1` WRITE;
/*!40000 ALTER TABLE `co_pianodeiconti1` DISABLE KEYS */;
INSERT INTO `co_pianodeiconti1` VALUES (1,'01','Patrimoniale'),(2,'02','Economico');
/*!40000 ALTER TABLE `co_pianodeiconti1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_pianodeiconti2`
--

DROP TABLE IF EXISTS `co_pianodeiconti2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_pianodeiconti2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(10) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  `idpianodeiconti1` int NOT NULL,
  `dir` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_pianodeiconti2`
--

LOCK TABLES `co_pianodeiconti2` WRITE;
/*!40000 ALTER TABLE `co_pianodeiconti2` DISABLE KEYS */;
INSERT INTO `co_pianodeiconti2` VALUES (1,'100','Cassa e banche',1,''),(2,'110','Crediti clienti e crediti diversi',1,''),(3,'120','Effetti attivi',1,''),(4,'130','Ratei e risconti attivi',1,''),(5,'200','Erario iva, INPS, IRPEF, INAIL, ecc',1,''),(6,'220','Immobilizzazioni',1,'entrata/uscita'),(7,'230','Rimanente magazzino',1,''),(8,'240','Debiti fornitori e debiti diversi',1,''),(9,'250','Ratei e risconti passivi',1,''),(10,'300','Fondi ammortamento',1,''),(11,'310','Altri fondi',1,''),(12,'400','Capitale',1,''),(14,'600','Costi merci c/acquisto',2,'uscita'),(15,'610','Costi generali',2,'uscita'),(16,'620','Costi diversi',2,'uscita'),(17,'630','Costi del personale',2,''),(18,'640','Costi ammortamenti',2,''),(19,'650','Costi accantonamenti',2,''),(20,'700','Ricavi',2,'entrata'),(21,'810','Perdite e profitti',1,''),(22,'900','Conti transitori',1,''),(23,'910','Conti compensativi',1,'entrata/uscita');
/*!40000 ALTER TABLE `co_pianodeiconti2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_pianodeiconti3`
--

DROP TABLE IF EXISTS `co_pianodeiconti3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_pianodeiconti3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(10) NOT NULL,
  `descrizione` varchar(255) NOT NULL,
  `idpianodeiconti2` int NOT NULL,
  `dir` varchar(15) NOT NULL,
  `percentuale_deducibile` decimal(5,2) NOT NULL DEFAULT '100.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_pianodeiconti3`
--

LOCK TABLES `co_pianodeiconti3` WRITE;
/*!40000 ALTER TABLE `co_pianodeiconti3` DISABLE KEYS */;
INSERT INTO `co_pianodeiconti3` VALUES (1,'000010','Cassa',1,'',100.00),(2,'000020','Banca C/C',1,'',100.00),(3,'000030','Effetti in portafoglio',1,'',100.00),(4,'000040','Banca effetti all\'incasso',1,'',100.00),(5,'000050','Titoli',1,'',100.00),(6,'000010','Riepilogativo clienti',2,'',100.00),(7,'000030','Clienti per fatture da emettere',2,'',100.00),(8,'000040','Crediti imposte',2,'',100.00),(9,'000050','Crediti diversi',2,'',100.00),(10,'000060','Ri.Ba in portafoglio',2,'',100.00),(11,'000080','Dipendenti c/stipendi',2,'',100.00),(12,'000090','Amministratori c/emolumenti',2,'',100.00),(13,'000010','Effetti allo sconto',3,'',100.00),(14,'000020','Effetti all\'incasso',3,'',100.00),(15,'000030','Effetti insoluti',3,'',100.00),(16,'000010','Risconti attivi',4,'',100.00),(17,'000020','Ratei attivi',4,'',100.00),(18,'000005','Erario c/to iva',5,'',100.00),(19,'000010','Erario c/INPS',5,'',100.00),(20,'000030','Erario c/IRPEF',5,'',100.00),(21,'000040','Erario c/INAIL',5,'',100.00),(22,'000050','Erario c/acconto TFR',5,'',100.00),(23,'000060','Erario c/ritenute d\'acconto',5,'',100.00),(24,'000070','Erario c/enasarco',5,'',100.00),(25,'000080','Erario c/varie',5,'',100.00),(26,'000010','Fabbricati',6,'',100.00),(27,'000020','Mobili e macchine da ufficio',6,'',100.00),(28,'000030','Automezzi',6,'',100.00),(29,'000040','Impianti e attrezzature',6,'',100.00),(30,'000060','Manutenzione da ammortizzare',6,'',100.00),(31,'000070','Costi pluriennali',6,'',100.00),(32,'000010','Merci c/to rimanenze materie prime',7,'',100.00),(33,'000020','Merci c/to rimanenze semilavorati',7,'',100.00),(34,'000010','Riepilogativo fornitori',8,'',100.00),(35,'000020','Cambiali passive',8,'',100.00),(36,'000030','Mutui passivi',8,'',100.00),(37,'000040','Debiti verso banche',8,'',100.00),(38,'000050','Fornitori per fatture da ricevere',8,'',100.00),(39,'000060','Debiti diversi',8,'',100.00),(40,'000070','Finanziamenti vari',8,'',100.00),(41,'000200','Riepilogativo fornitori contabilit&agrave; semplificata',8,'',100.00),(42,'000010','Risconti passivi',9,'',100.00),(43,'000020','Ratei passivi',9,'',100.00),(44,'000010','Fondi ammortamento fabbricati',10,'',100.00),(45,'000020','Fondi ammortamento mobili e macchine da ufficio',10,'',100.00),(46,'000030','Fondi ammortamento automezzi',10,'',100.00),(47,'000040','Fondi ammortamento impianti e attrezzature',10,'',100.00),(48,'000060','Fondi ammortamento manutenzione da ammortizzare',10,'',100.00),(49,'000070','Fondi ammortamento costi pluriennali',10,'',100.00),(50,'000010','Fondo imposte e tasse',11,'',100.00),(51,'000020','Fondo TFR liquidazione personale',11,'',100.00),(52,'000010','Capitale sociale o netto',12,'',100.00),(53,'000020','Riserve',12,'',100.00),(55,'000010','Costi merci c/acquisto di rivendita',14,'uscita',100.00),(56,'000020','Costi merci c/acquisto di produzione',14,'uscita',100.00),(57,'000030','Costi merci c/acquisto intracomunitario',14,'uscita',100.00),(58,'000040','Costi merci c/acquisto importazioni',14,'uscita',100.00),(59,'000010','Spese telefoniche',15,'uscita',100.00),(60,'000020','Spese postali',15,'uscita',100.00),(61,'000030','Spese cancelleria',15,'uscita',100.00),(62,'000040','Spese locomozione e carburante',15,'uscita',100.00),(63,'000050','Spese software',15,'uscita',100.00),(64,'000060','Spese energia elettrica',15,'uscita',100.00),(65,'000070','Spese consulenze',15,'uscita',100.00),(66,'000080','Spese varie',15,'uscita',100.00),(67,'000090','Spese assicurazioni',15,'uscita',100.00),(68,'000100','Spese bancarie',15,'uscita',100.00),(69,'000110','Spese fitti passivi',15,'uscita',100.00),(70,'000120','Spese ristoranti e alberghi',15,'uscita',100.00),(71,'000130','Spese manutenzione e riparazione',15,'uscita',100.00),(72,'000140','Spese canoni leasing',15,'uscita',100.00),(73,'000150','Spese acquisto beni strumentali non ammortizzabilii',15,'uscita',100.00),(74,'000010','Costi interessi passivi',16,'',100.00),(75,'000020','Costi abbuoni passivi',16,'',100.00),(76,'000030','Costi imposte e tasse',16,'',100.00),(77,'000040','Costi imposta IRA',16,'',100.00),(78,'000050','Costi minusvalenze',16,'',100.00),(79,'000060','Costi perdite su crediti',16,'',100.00),(80,'000070','Costi sopravvenienze passive',16,'',100.00),(81,'000080','Costi perdite da operazioni finanziarie',16,'',100.00),(82,'000010','Costi salari e stipendi',17,'',100.00),(83,'000020','Costi contributi sociali',17,'',100.00),(84,'000040','Costi TFR',17,'',100.00),(85,'000050','Costi contributi dipendenti',17,'',100.00),(86,'000060','Costi contributi assicurazione lavoro',17,'',100.00),(87,'000010','Ammortamento fabbricati',18,'',100.00),(88,'000020','Ammortamento mobili e macchine ufficio',18,'',100.00),(89,'000030','Ammortamento automezzi',18,'',100.00),(90,'000040','Ammortamento impianti e attrezzature',18,'',100.00),(91,'000060','Ammortamento manutenzioni',18,'',100.00),(92,'000070','Ammortamento costi pluriennali',18,'',100.00),(93,'000010','Accantonamento TFR',19,'',100.00),(94,'000010','Ricavi merci c/to vendite',20,'entrata',100.00),(95,'000020','Ricavi vendita prestazione servizi',20,'entrata',100.00),(96,'000030','Ricavi interessi attivi',20,'entrata',100.00),(97,'000040','Ricavi fitti attivi',20,'entrata',100.00),(98,'000050','Ricavi vari',20,'entrata',100.00),(99,'000051','Rimborso spese marche da bollo',20,'',100.00),(100,'000060','Ricavi abbuoni attivi',20,'',100.00),(101,'000070','Ricavi sopravvenienze attive',20,'',100.00),(102,'000080','Ricavi plusvalenze',20,'',100.00),(103,'000020','Perdite e profitti',21,'',100.00),(104,'000010','Apertura conti patrimoniali',21,'',100.00),(105,'000900','Chiusura conti patrimoniali',21,'',100.00),(106,'000010','Iva su vendite',22,'',100.00),(107,'000020','Iva su acquisti',22,'',100.00),(108,'000030','Iva indetraibile',22,'',100.00),(109,'000200','Intra UE: riepilogativo fornitori',22,'',100.00),(110,'000210','Intra UE: transitorio iva',22,'',100.00),(111,'000220','Intra UE: transitorio per movimento iva',22,'',100.00),(112,'000021','Banca C/C (conto anticipi)',1,'',100.00),(113,'000011','Anticipo fornitori',8,'',100.00),(114,'000011','Anticipo clienti',2,'',100.00),(115,'000010','Compensazione per autofattura',23,'',100.00),(116,'000210','Personale c/Retribuzioni',8,'',100.00),(117,'000220','INPS c/Competenza',8,'',100.00),(118,'000090','Erario c/Ritenute dipendenti',5,'',100.00),(119,'000040','Iva transitoria',22,'',100.00);
/*!40000 ALTER TABLE `co_pianodeiconti3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_preventivi`
--

DROP TABLE IF EXISTS `co_preventivi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_preventivi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(50) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `idagente` int NOT NULL,
  `data_bozza` date DEFAULT NULL,
  `data_accettazione` date DEFAULT NULL,
  `data_rifiuto` date DEFAULT NULL,
  `data_conclusione` date DEFAULT NULL,
  `data_pagamento` date DEFAULT NULL,
  `budget` decimal(15,6) NOT NULL,
  `descrizione` text,
  `idstato` tinyint NOT NULL,
  `validita` int NOT NULL,
  `tipo_validita` enum('days','months','years') DEFAULT NULL,
  `tempi_consegna` varchar(255) NOT NULL,
  `idanagrafica` int NOT NULL,
  `idsede_destinazione` int NOT NULL,
  `idsede_partenza` int NOT NULL,
  `esclusioni` text,
  `idreferente` int NOT NULL,
  `idpagamento` int NOT NULL,
  `id_banca_azienda` int DEFAULT NULL,
  `id_banca_controparte` int DEFAULT NULL,
  `idporto` int NOT NULL,
  `idtipointervento` int NOT NULL,
  `idiva` int NOT NULL,
  `costo_diritto_chiamata` decimal(15,6) NOT NULL,
  `ore_lavoro` decimal(15,6) NOT NULL,
  `costo_orario` decimal(15,6) NOT NULL,
  `costo_km` decimal(15,6) NOT NULL,
  `master_revision` int NOT NULL,
  `codice_cig` varchar(15) DEFAULT NULL,
  `codice_cup` varchar(15) DEFAULT NULL,
  `id_documento_fe` varchar(20) DEFAULT NULL,
  `num_item` varchar(15) DEFAULT NULL,
  `default_revision` tinyint(1) NOT NULL,
  `descrizione_revision` varchar(255) NOT NULL,
  `numero_revision` int NOT NULL,
  `condizioni_fornitura` text NOT NULL,
  `garanzia` text NOT NULL,
  `sconto_finale` decimal(17,8) NOT NULL,
  `sconto_finale_percentuale` decimal(17,8) NOT NULL,
  `informazioniaggiuntive` text,
  `id_segment` int NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idtipointervento` (`idtipointervento`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_preventivi`
--

LOCK TABLES `co_preventivi` WRITE;
/*!40000 ALTER TABLE `co_preventivi` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_preventivi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_promemoria`
--

DROP TABLE IF EXISTS `co_promemoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_promemoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idcontratto` int NOT NULL,
  `idintervento` int DEFAULT NULL,
  `idtipointervento` int NOT NULL,
  `data_richiesta` date DEFAULT NULL,
  `data_scadenza` datetime DEFAULT NULL,
  `richiesta` varchar(8000) NOT NULL,
  `idsede` int NOT NULL,
  `idimpianti` varchar(255) NOT NULL,
  `idtecnici` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idintervento` (`idintervento`),
  KEY `idtipointervento` (`idtipointervento`),
  CONSTRAINT `co_promemoria_ibfk_1` FOREIGN KEY (`idintervento`) REFERENCES `in_interventi` (`id`) ON DELETE CASCADE,
  CONSTRAINT `co_promemoria_ibfk_2` FOREIGN KEY (`idtipointervento`) REFERENCES `in_tipiintervento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_promemoria`
--

LOCK TABLES `co_promemoria` WRITE;
/*!40000 ALTER TABLE `co_promemoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_promemoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_provvigioni`
--

DROP TABLE IF EXISTS `co_provvigioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_provvigioni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idagente` int NOT NULL,
  `idarticolo` int NOT NULL,
  `provvigione` decimal(15,6) NOT NULL,
  `tipo_provvigione` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_provvigioni`
--

LOCK TABLES `co_provvigioni` WRITE;
/*!40000 ALTER TABLE `co_provvigioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_provvigioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_riferimenti_righe`
--

DROP TABLE IF EXISTS `co_riferimenti_righe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_riferimenti_righe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `source_type` varchar(255) NOT NULL,
  `source_id` int NOT NULL,
  `target_type` varchar(255) NOT NULL,
  `target_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_riferimenti_righe`
--

LOCK TABLES `co_riferimenti_righe` WRITE;
/*!40000 ALTER TABLE `co_riferimenti_righe` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_riferimenti_righe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_righe_contratti`
--

DROP TABLE IF EXISTS `co_righe_contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_righe_contratti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idcontratto` int NOT NULL,
  `idarticolo` int DEFAULT NULL,
  `idpianificazione` int DEFAULT NULL,
  `is_descrizione` tinyint(1) NOT NULL,
  `is_sconto` tinyint(1) NOT NULL DEFAULT '0',
  `descrizione` text,
  `subtotale` decimal(15,6) NOT NULL,
  `sconto` decimal(15,6) NOT NULL,
  `sconto_unitario` decimal(15,6) NOT NULL,
  `sconto_iva_unitario` decimal(15,6) NOT NULL,
  `sconto_unitario_ivato` decimal(15,6) NOT NULL,
  `sconto_percentuale` decimal(15,6) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `note` text,
  `idiva` int NOT NULL,
  `desc_iva` varchar(255) NOT NULL,
  `iva` decimal(15,6) NOT NULL,
  `iva_indetraibile` decimal(15,6) NOT NULL,
  `um` varchar(20) DEFAULT NULL,
  `qta` decimal(15,6) NOT NULL,
  `costo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `iva_unitaria` decimal(17,8) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `provvigione` decimal(15,6) NOT NULL,
  `provvigione_unitaria` decimal(15,6) NOT NULL,
  `provvigione_percentuale` decimal(15,6) NOT NULL,
  `tipo_provvigione` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `order` int NOT NULL,
  `qta_evasa` decimal(15,6) NOT NULL,
  `abilita_serial` tinyint(1) NOT NULL DEFAULT '0',
  `original_id` int DEFAULT NULL,
  `original_type` varchar(255) DEFAULT NULL,
  `original_document_id` int DEFAULT NULL,
  `original_document_type` varchar(255) DEFAULT NULL,
  `id_dettaglio_fornitore` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_dettaglio_fornitore` (`id_dettaglio_fornitore`),
  CONSTRAINT `co_righe_contratti_ibfk_1` FOREIGN KEY (`id_dettaglio_fornitore`) REFERENCES `mg_fornitore_articolo` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_righe_contratti`
--

LOCK TABLES `co_righe_contratti` WRITE;
/*!40000 ALTER TABLE `co_righe_contratti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_righe_contratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_righe_documenti`
--

DROP TABLE IF EXISTS `co_righe_documenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_righe_documenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iddocumento` int NOT NULL,
  `idordine` int NOT NULL,
  `idddt` int NOT NULL,
  `idintervento` int DEFAULT NULL,
  `idarticolo` int DEFAULT NULL,
  `idpreventivo` int NOT NULL,
  `idcontratto` int NOT NULL,
  `ref_riga_documento` int DEFAULT NULL,
  `is_descrizione` tinyint(1) NOT NULL,
  `is_sconto` tinyint(1) NOT NULL DEFAULT '0',
  `is_preventivo` tinyint(1) NOT NULL,
  `is_contratto` tinyint(1) NOT NULL,
  `idtecnico` int NOT NULL,
  `idagente` int NOT NULL,
  `idautomezzo` int NOT NULL,
  `idconto` int NOT NULL,
  `idiva` int NOT NULL,
  `desc_iva` varchar(255) NOT NULL,
  `iva` decimal(15,6) NOT NULL,
  `iva_indetraibile` decimal(15,6) NOT NULL,
  `descrizione` text,
  `subtotale` decimal(15,6) NOT NULL,
  `sconto` decimal(15,6) NOT NULL,
  `sconto_unitario` decimal(15,6) NOT NULL,
  `sconto_iva_unitario` decimal(15,6) NOT NULL,
  `sconto_unitario_ivato` decimal(15,6) NOT NULL,
  `sconto_percentuale` decimal(15,6) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `note` text,
  `idritenutaacconto` int DEFAULT NULL,
  `ritenutaacconto` decimal(15,6) NOT NULL,
  `idrivalsainps` int DEFAULT NULL,
  `rivalsainps` decimal(15,6) NOT NULL,
  `calcolo_ritenuta_acconto` enum('IMP','IMP+RIV') DEFAULT 'IMP',
  `um` varchar(20) DEFAULT NULL,
  `abilita_serial` tinyint(1) NOT NULL DEFAULT '0',
  `qta` decimal(15,6) NOT NULL,
  `costo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `iva_unitaria` decimal(17,8) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `provvigione` decimal(15,6) NOT NULL,
  `provvigione_unitaria` decimal(15,6) NOT NULL,
  `provvigione_percentuale` decimal(15,6) NOT NULL,
  `tipo_provvigione` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `qta_evasa` decimal(15,6) NOT NULL,
  `order` int NOT NULL,
  `ritenuta_contributi` tinyint(1) NOT NULL DEFAULT '0',
  `dati_aggiuntivi_fe` text,
  `original_id` int DEFAULT NULL,
  `original_type` varchar(255) DEFAULT NULL,
  `original_document_id` int DEFAULT NULL,
  `original_document_type` varchar(255) DEFAULT NULL,
  `id_dettaglio_fornitore` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ref_riga_documento` (`ref_riga_documento`),
  KEY `idintervento` (`idintervento`),
  KEY `id_dettaglio_fornitore` (`id_dettaglio_fornitore`),
  KEY `iddocumento` (`iddocumento`),
  KEY `idpreventivo` (`idpreventivo`),
  KEY `idpreventivo_2` (`idpreventivo`),
  CONSTRAINT `co_righe_documenti_ibfk_1` FOREIGN KEY (`ref_riga_documento`) REFERENCES `co_righe_documenti` (`id`) ON DELETE CASCADE,
  CONSTRAINT `co_righe_documenti_ibfk_2` FOREIGN KEY (`id_dettaglio_fornitore`) REFERENCES `mg_fornitore_articolo` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_righe_documenti`
--

LOCK TABLES `co_righe_documenti` WRITE;
/*!40000 ALTER TABLE `co_righe_documenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_righe_documenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_righe_preventivi`
--

DROP TABLE IF EXISTS `co_righe_preventivi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_righe_preventivi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_evasione` date DEFAULT NULL,
  `ora_evasione` time DEFAULT NULL,
  `idpreventivo` int NOT NULL,
  `idarticolo` int DEFAULT NULL,
  `is_descrizione` tinyint(1) NOT NULL,
  `is_sconto` tinyint(1) NOT NULL DEFAULT '0',
  `idiva` int NOT NULL,
  `desc_iva` varchar(255) NOT NULL,
  `iva` decimal(15,6) NOT NULL,
  `iva_indetraibile` decimal(15,6) NOT NULL,
  `descrizione` text,
  `subtotale` decimal(15,6) NOT NULL,
  `sconto` decimal(15,6) NOT NULL,
  `sconto_unitario` decimal(15,6) NOT NULL,
  `sconto_iva_unitario` decimal(15,6) NOT NULL,
  `sconto_unitario_ivato` decimal(15,6) NOT NULL,
  `sconto_percentuale` decimal(15,6) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `note` text,
  `um` varchar(20) DEFAULT NULL,
  `qta` decimal(15,6) NOT NULL,
  `costo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `iva_unitaria` decimal(17,8) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `provvigione` decimal(15,6) NOT NULL,
  `provvigione_unitaria` decimal(15,6) NOT NULL,
  `provvigione_percentuale` decimal(15,6) NOT NULL,
  `tipo_provvigione` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `order` int NOT NULL,
  `qta_evasa` decimal(15,6) NOT NULL,
  `abilita_serial` tinyint(1) NOT NULL DEFAULT '0',
  `id_dettaglio_fornitore` int DEFAULT NULL,
  `confermato` tinyint(1) NOT NULL,
  `is_titolo` tinyint(1) NOT NULL,
  `original_id` int DEFAULT NULL,
  `original_type` varchar(255) DEFAULT NULL,
  `original_document_id` int DEFAULT NULL,
  `original_document_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_dettaglio_fornitore` (`id_dettaglio_fornitore`),
  CONSTRAINT `co_righe_preventivi_ibfk_1` FOREIGN KEY (`id_dettaglio_fornitore`) REFERENCES `mg_fornitore_articolo` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_righe_preventivi`
--

LOCK TABLES `co_righe_preventivi` WRITE;
/*!40000 ALTER TABLE `co_righe_preventivi` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_righe_preventivi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_righe_promemoria`
--

DROP TABLE IF EXISTS `co_righe_promemoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_righe_promemoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(255) NOT NULL,
  `qta` float(12,4) NOT NULL,
  `costo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `iva_unitaria` decimal(15,6) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `provvigione` decimal(15,6) NOT NULL,
  `provvigione_unitaria` decimal(15,6) NOT NULL,
  `provvigione_percentuale` decimal(15,6) NOT NULL,
  `tipo_provvigione` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `um` varchar(25) DEFAULT NULL,
  `abilita_serial` tinyint(1) NOT NULL DEFAULT '0',
  `idiva` int NOT NULL,
  `desc_iva` varchar(255) NOT NULL,
  `iva` decimal(15,6) NOT NULL,
  `id_promemoria` int NOT NULL,
  `sconto` decimal(15,6) NOT NULL,
  `sconto_unitario` decimal(15,6) NOT NULL,
  `sconto_iva_unitario` decimal(15,6) NOT NULL,
  `sconto_unitario_ivato` decimal(15,6) NOT NULL,
  `sconto_percentuale` decimal(15,6) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `idimpianto` int DEFAULT NULL,
  `idarticolo` int DEFAULT NULL,
  `is_descrizione` tinyint(1) NOT NULL DEFAULT '0',
  `is_sconto` tinyint(1) NOT NULL DEFAULT '0',
  `original_id` int DEFAULT NULL,
  `original_type` varchar(255) DEFAULT NULL,
  `original_document_id` int DEFAULT NULL,
  `original_document_type` varchar(255) DEFAULT NULL,
  `id_dettaglio_fornitore` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_riga_contratto` (`id_promemoria`),
  KEY `idarticolo` (`idarticolo`),
  KEY `id_dettaglio_fornitore` (`id_dettaglio_fornitore`),
  CONSTRAINT `co_righe_promemoria_ibfk_1` FOREIGN KEY (`idarticolo`) REFERENCES `mg_articoli` (`id`) ON DELETE SET NULL,
  CONSTRAINT `co_righe_promemoria_ibfk_2` FOREIGN KEY (`id_dettaglio_fornitore`) REFERENCES `mg_fornitore_articolo` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_righe_promemoria`
--

LOCK TABLES `co_righe_promemoria` WRITE;
/*!40000 ALTER TABLE `co_righe_promemoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_righe_promemoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_ritenuta_contributi`
--

DROP TABLE IF EXISTS `co_ritenuta_contributi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_ritenuta_contributi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) NOT NULL,
  `tipologia` varchar(100) NOT NULL,
  `causale` varchar(100) NOT NULL,
  `percentuale` decimal(5,2) NOT NULL,
  `percentuale_imponibile` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_ritenuta_contributi`
--

LOCK TABLES `co_ritenuta_contributi` WRITE;
/*!40000 ALTER TABLE `co_ritenuta_contributi` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_ritenuta_contributi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_ritenutaacconto`
--

DROP TABLE IF EXISTS `co_ritenutaacconto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_ritenutaacconto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) NOT NULL,
  `percentuale` decimal(5,2) NOT NULL,
  `percentuale_imponibile` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_ritenutaacconto`
--

LOCK TABLES `co_ritenutaacconto` WRITE;
/*!40000 ALTER TABLE `co_ritenutaacconto` DISABLE KEYS */;
INSERT INTO `co_ritenutaacconto` VALUES (1,'Ritenuta d\'acconto 20%',20.00,100.00),(2,'Ritenuta d\'acconto 10%',10.00,100.00),(3,'Ritenuta d\'acconto 4%',4.00,100.00);
/*!40000 ALTER TABLE `co_ritenutaacconto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_rivalse`
--

DROP TABLE IF EXISTS `co_rivalse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_rivalse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) NOT NULL,
  `percentuale` decimal(5,2) NOT NULL,
  `indetraibile` decimal(5,2) NOT NULL,
  `esente` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_rivalse`
--

LOCK TABLES `co_rivalse` WRITE;
/*!40000 ALTER TABLE `co_rivalse` DISABLE KEYS */;
INSERT INTO `co_rivalse` VALUES (1,'Rivalsa INPS 4%',4.00,0.00,0);
/*!40000 ALTER TABLE `co_rivalse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_scadenziario`
--

DROP TABLE IF EXISTS `co_scadenziario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_scadenziario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `iddocumento` int NOT NULL,
  `idanagrafica` int NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `descrizione` text NOT NULL,
  `data_emissione` date DEFAULT NULL,
  `scadenza` date DEFAULT NULL,
  `da_pagare` decimal(15,6) DEFAULT NULL,
  `pagato` decimal(15,6) DEFAULT NULL,
  `data_pagamento` date DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `data_concordata` date DEFAULT NULL,
  `presentazioni_exported_at` timestamp NULL DEFAULT NULL,
  `distinta` varchar(255) DEFAULT NULL,
  `id_pagamento` int NOT NULL,
  `id_banca_azienda` int DEFAULT NULL,
  `id_banca_controparte` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_scadenziario`
--

LOCK TABLES `co_scadenziario` WRITE;
/*!40000 ALTER TABLE `co_scadenziario` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_scadenziario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_stampecontabili`
--

DROP TABLE IF EXISTS `co_stampecontabili`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_stampecontabili` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_print` int NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `first_page` int NOT NULL,
  `last_page` int NOT NULL,
  `dir` varchar(255) NOT NULL,
  `id_sezionale` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_stampecontabili`
--

LOCK TABLES `co_stampecontabili` WRITE;
/*!40000 ALTER TABLE `co_stampecontabili` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_stampecontabili` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_staticontratti`
--

DROP TABLE IF EXISTS `co_staticontratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_staticontratti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `icona` varchar(255) NOT NULL,
  `colore` varchar(7) NOT NULL,
  `is_pianificabile` tinyint(1) NOT NULL DEFAULT '0',
  `is_bloccato` tinyint(1) NOT NULL DEFAULT '0',
  `is_fatturabile` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_staticontratti`
--

LOCK TABLES `co_staticontratti` WRITE;
/*!40000 ALTER TABLE `co_staticontratti` DISABLE KEYS */;
INSERT INTO `co_staticontratti` VALUES (1,'fa fa-file-text-o text-muted','#ffef99',0,0,0,NULL,0),(2,'fa fa-clock-o text-warning','#99e6ff',0,0,0,NULL,1),(3,'fa fa-thumbs-up text-success','#99ffff',0,1,1,NULL,1),(4,'fa fa-thumbs-down text-danger','#e5e4e2',0,1,0,NULL,1),(5,'fa fa-gear text-warning','#fdd9a0',1,1,1,NULL,0),(6,'fa fa-file-text-o text-success','#98fb98',1,1,0,NULL,0),(7,'fa fa-check-circle text-success','#88de69',1,1,0,NULL,1),(8,'fa fa-check text-success','#5dd333',0,1,1,NULL,0),(9,'fa fa-file-text-o text-warning','#b4ff99',1,1,1,NULL,0);
/*!40000 ALTER TABLE `co_staticontratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_staticontratti_lang`
--

DROP TABLE IF EXISTS `co_staticontratti_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_staticontratti_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `co_staticontratti_lang_ibfk_1` (`id_record`),
  KEY `co_staticontratti_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `co_staticontratti_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `co_staticontratti` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `co_staticontratti_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_staticontratti_lang`
--

LOCK TABLES `co_staticontratti_lang` WRITE;
/*!40000 ALTER TABLE `co_staticontratti_lang` DISABLE KEYS */;
INSERT INTO `co_staticontratti_lang` VALUES (1,1,1,'Bozza','Bozza'),(2,1,2,'In attesa di conferma','In attesa di conferma'),(3,1,3,'Accettato','Accettato'),(4,1,4,'Rifiutato','Rifiutato'),(5,1,5,'In lavorazione','In lavorazione'),(6,1,6,'Fatturato','Fatturato'),(7,1,7,'Pagato','Pagato'),(8,1,8,'Concluso','Concluso'),(9,1,9,'Parzialmente fatturato','Parzialmente fatturato');
/*!40000 ALTER TABLE `co_staticontratti_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_statidocumento`
--

DROP TABLE IF EXISTS `co_statidocumento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_statidocumento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `icona` varchar(255) NOT NULL,
  `colore` varchar(7) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_statidocumento`
--

LOCK TABLES `co_statidocumento` WRITE;
/*!40000 ALTER TABLE `co_statidocumento` DISABLE KEYS */;
INSERT INTO `co_statidocumento` VALUES (1,'fa fa-check-circle text-success','#88de69'),(2,'fa fa-file-text-o text-muted','#ffef99'),(3,'fa fa-clock-o text-info','#99ffff'),(4,'fa fa-times text-danger','#e5e4e2'),(5,'fa fa-dot-circle-o text-warning','#98fb98'),(6,'fa fa-times text-muted','#d3d3d3');
/*!40000 ALTER TABLE `co_statidocumento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_statidocumento_lang`
--

DROP TABLE IF EXISTS `co_statidocumento_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_statidocumento_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `co_statidocumento_lang_ibfk_1` (`id_record`),
  KEY `co_statidocumento_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `co_statidocumento_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `co_statidocumento` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `co_statidocumento_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_statidocumento_lang`
--

LOCK TABLES `co_statidocumento_lang` WRITE;
/*!40000 ALTER TABLE `co_statidocumento_lang` DISABLE KEYS */;
INSERT INTO `co_statidocumento_lang` VALUES (1,1,1,'Pagato','Pagato'),(2,1,2,'Bozza','Bozza'),(3,1,3,'Emessa','Emessa'),(4,1,4,'Annullata','Annullata'),(5,1,5,'Parzialmente pagato','Parzialmente pagato'),(8,1,6,'Non valida','Non valida');
/*!40000 ALTER TABLE `co_statidocumento_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_statipreventivi`
--

DROP TABLE IF EXISTS `co_statipreventivi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_statipreventivi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `icona` varchar(255) NOT NULL,
  `colore` varchar(7) NOT NULL,
  `is_bloccato` tinyint(1) NOT NULL DEFAULT '0',
  `is_fatturabile` tinyint(1) NOT NULL DEFAULT '0',
  `is_pianificabile` tinyint(1) NOT NULL DEFAULT '0',
  `is_revisionabile` tinyint(1) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_statipreventivi`
--

LOCK TABLES `co_statipreventivi` WRITE;
/*!40000 ALTER TABLE `co_statipreventivi` DISABLE KEYS */;
INSERT INTO `co_statipreventivi` VALUES (1,'fa fa-file-text-o text-muted','#ffef99',0,0,0,1,NULL,0),(2,'fa fa-clock-o text-warning','#99e6ff',0,0,0,1,NULL,1),(3,'fa fa-thumbs-up text-success','#99ffff',1,1,0,0,NULL,1),(4,'fa fa-thumbs-down text-danger','#e5e4e2',1,0,0,1,NULL,1),(5,'fa fa-gear text-warning','#fdd9a0',1,1,1,0,NULL,0),(6,'fa fa-check text-success','#d8bfd8',1,1,0,0,NULL,1),(7,'fa fa-check-circle text-success','#88de69',1,0,1,0,NULL,1),(8,'fa fa-file-text-o text-success','#98fb98',1,0,1,0,NULL,1),(9,'fa fa-file-text-o text-warning','#b4ff99',1,1,1,0,NULL,1);
/*!40000 ALTER TABLE `co_statipreventivi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_statipreventivi_lang`
--

DROP TABLE IF EXISTS `co_statipreventivi_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_statipreventivi_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `co_statipreventivi_lang_ibfk_1` (`id_record`),
  KEY `co_statipreventivi_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `co_statipreventivi_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `co_statipreventivi` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `co_statipreventivi_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_statipreventivi_lang`
--

LOCK TABLES `co_statipreventivi_lang` WRITE;
/*!40000 ALTER TABLE `co_statipreventivi_lang` DISABLE KEYS */;
INSERT INTO `co_statipreventivi_lang` VALUES (1,1,1,'Bozza','Bozza'),(2,1,2,'In attesa di conferma','In attesa di conferma'),(3,1,3,'Accettato','Accettato'),(4,1,4,'Rifiutato','Rifiutato'),(5,1,5,'In lavorazione','In lavorazione'),(6,1,6,'Concluso','Concluso'),(7,1,7,'Pagato','Pagato'),(8,1,8,'Fatturato','Fatturato'),(9,1,9,'Parzialmente fatturato','Parzialmente fatturato');
/*!40000 ALTER TABLE `co_statipreventivi_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_tipi_scadenze`
--

DROP TABLE IF EXISTS `co_tipi_scadenze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_tipi_scadenze` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ctgypurp` varchar(255) NOT NULL,
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_tipi_scadenze`
--

LOCK TABLES `co_tipi_scadenze` WRITE;
/*!40000 ALTER TABLE `co_tipi_scadenze` DISABLE KEYS */;
INSERT INTO `co_tipi_scadenze` VALUES (1,'TAXS',0),(2,'SUPP',0),(3,'SALA',1);
/*!40000 ALTER TABLE `co_tipi_scadenze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_tipi_scadenze_lang`
--

DROP TABLE IF EXISTS `co_tipi_scadenze_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_tipi_scadenze_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `co_tipi_scadenze_lang_ibfk_1` (`id_record`),
  KEY `co_tipi_scadenze_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `co_tipi_scadenze_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `co_tipi_scadenze` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `co_tipi_scadenze_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_tipi_scadenze_lang`
--

LOCK TABLES `co_tipi_scadenze_lang` WRITE;
/*!40000 ALTER TABLE `co_tipi_scadenze_lang` DISABLE KEYS */;
INSERT INTO `co_tipi_scadenze_lang` VALUES (1,1,1,'f24','F24'),(2,1,2,'generico','Scadenze generiche'),(3,1,3,'stipendio','Stipendi');
/*!40000 ALTER TABLE `co_tipi_scadenze_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_tipidocumento`
--

DROP TABLE IF EXISTS `co_tipidocumento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_tipidocumento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dir` enum('entrata','uscita') NOT NULL,
  `reversed` tinyint(1) NOT NULL DEFAULT '0',
  `codice_tipo_documento_fe` varchar(4) NOT NULL,
  `predefined` tinyint NOT NULL DEFAULT '0',
  `id_segment` int NOT NULL,
  `enabled` tinyint NOT NULL DEFAULT '1',
  `help` varchar(255) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `codice_tipo_documento_fe` (`codice_tipo_documento_fe`),
  CONSTRAINT `co_tipidocumento_ibfk_1` FOREIGN KEY (`codice_tipo_documento_fe`) REFERENCES `fe_tipi_documento` (`codice`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_tipidocumento`
--

LOCK TABLES `co_tipidocumento` WRITE;
/*!40000 ALTER TABLE `co_tipidocumento` DISABLE KEYS */;
INSERT INTO `co_tipidocumento` VALUES (1,'uscita',0,'TD01',1,2,1,'Fattura emessa entro le ore 24 del giorno di effettuazione dellÔÇÖoperazione.',NULL),(2,'entrata',0,'TD01',1,1,1,'Fattura emessa entro le ore 24 del giorno di effettuazione dellÔÇÖoperazione.',NULL),(3,'uscita',0,'TD24',0,2,1,'Fattura emessa entro il giorno 15 del mese successivo a quello di effettuazione dell\'operazione  (art. 21 comma 4 lett. a) del D.P.R. 633/1972).',NULL),(4,'entrata',0,'TD24',0,1,1,'Fattura emessa entro il giorno 15 del mese successivo a quello di effettuazione dell\'operazione  (art. 21 comma 4 lett. a) del D.P.R. 633/1972).',NULL),(5,'uscita',0,'TD01',0,2,1,NULL,NULL),(6,'entrata',0,'TD01',0,1,1,NULL,NULL),(7,'uscita',1,'TD04',0,2,1,NULL,NULL),(8,'uscita',0,'TD05',0,2,1,NULL,NULL),(9,'entrata',1,'TD04',0,1,1,NULL,NULL),(10,'entrata',0,'TD05',0,1,1,NULL,NULL),(11,'entrata',0,'TD06',0,1,1,NULL,NULL),(12,'uscita',0,'TD06',0,2,1,NULL,NULL),(13,'entrata',0,'TD02',0,1,1,NULL,NULL),(24,'entrata',0,'TD25',0,1,1,NULL,NULL),(25,'uscita',0,'TD25',0,2,1,NULL,NULL),(26,'uscita',0,'TD02',0,2,1,NULL,NULL),(27,'uscita',0,'TD16',0,2,1,NULL,NULL),(28,'uscita',0,'TD17',0,22,1,NULL,NULL),(29,'uscita',0,'TD18',0,2,1,NULL,NULL),(30,'uscita',0,'TD19',0,22,1,NULL,NULL),(31,'uscita',0,'TD20',0,22,1,NULL,NULL),(32,'uscita',0,'TD21',0,22,1,NULL,NULL),(33,'uscita',0,'TD22',0,2,1,NULL,NULL),(34,'uscita',0,'TD23',0,2,1,NULL,NULL),(35,'uscita',0,'TD26',0,2,1,NULL,NULL),(36,'uscita',0,'TD27',0,2,1,NULL,NULL),(37,'entrata',0,'TD28',0,1,1,NULL,NULL),(38,'uscita',0,'TD28',0,2,1,NULL,NULL);
/*!40000 ALTER TABLE `co_tipidocumento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_tipidocumento_lang`
--

DROP TABLE IF EXISTS `co_tipidocumento_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_tipidocumento_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `co_tipidocumento_lang_ibfk_1` (`id_record`),
  KEY `co_tipidocumento_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `co_tipidocumento_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `co_tipidocumento` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `co_tipidocumento_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_tipidocumento_lang`
--

LOCK TABLES `co_tipidocumento_lang` WRITE;
/*!40000 ALTER TABLE `co_tipidocumento_lang` DISABLE KEYS */;
INSERT INTO `co_tipidocumento_lang` VALUES (1,1,1,'Fattura immediata di acquisto','Fattura immediata di acquisto'),(2,1,2,'Fattura immediata di vendita','Fattura immediata di vendita'),(3,1,3,'Fattura differita di acquisto','Fattura differita di acquisto'),(4,1,4,'Fattura differita di vendita','Fattura differita di vendita'),(5,1,5,'Fattura accompagnatoria di acquisto','Fattura accompagnatoria di acquisto'),(6,1,6,'Fattura accompagnatoria di vendita','Fattura accompagnatoria di vendita'),(7,1,7,'Nota di credito','Nota di credito'),(8,1,8,'Nota di debito','Nota di debito'),(9,1,9,'Nota di credito','Nota di credito'),(10,1,10,'Nota di debito','Nota di debito'),(11,1,11,'Parcella','Parcella'),(12,1,12,'Parcella','Parcella'),(13,1,13,'Acconto/anticipo su fattura','Acconto/anticipo su fattura'),(14,1,24,'Fattura differita di cui all\'art.21, comma 4, terzo periodo lett. b (Dropshipping)','Fattura differita di cui all\'art.21, comma 4, terzo periodo lett. b (Dropshipping)'),(15,1,25,'Fattura differita di cui all\'art.21, comma 4, terzo periodo lett. b (Dropshipping)','Fattura differita di cui all\'art.21, comma 4, terzo periodo lett. b (Dropshipping)'),(16,1,26,'Acconto/anticipo su fattura','Acconto/anticipo su fattura'),(17,1,27,'Integrazione fattura reverse charge interno','Integrazione fattura reverse charge interno'),(18,1,28,'Integrazione/autofattura per acquisto servizi dall\'estero','Integrazione/autofattura per acquisto servizi dall\'estero'),(19,1,29,'Integrazione per acquisto di beni intracomunitari','Integrazione per acquisto di beni intracomunitari'),(20,1,30,'Integrazione/autofattura per acquisto di beni ex art.17 c.2 DPR 633/72','Integrazione/autofattura per acquisto di beni ex art.17 c.2 DPR 633/72'),(21,1,31,'Autofattura per regolarizzazione e integrazione delle fatture (art.6 c.8 d.lgs. 471/97 o art.46 c.5 D.L. 331/93)','Autofattura per regolarizzazione e integrazione delle fatture (art.6 c.8 d.lgs. 471/97 o art.46 c.5 D.L. 331/93)'),(22,1,32,'Autofattura per splafonamento','Autofattura per splafonamento'),(23,1,33,'Estrazione beni da deposito IVA','Estrazione beni da deposito IVA'),(24,1,34,'Estrazione beni da deposito IVA con versamento dell\'IVA','Estrazione beni da deposito IVA con versamento dell\'IVA'),(25,1,35,'Cessione di beni ammortizzabili e per passaggi interni (ex art.36 DPR 633/72)','Cessione di beni ammortizzabili e per passaggi interni (ex art.36 DPR 633/72)'),(26,1,36,'Fattura per autoconsumo o per cessioni gratuite senza rivalsa','Fattura per autoconsumo o per cessioni gratuite senza rivalsa'),(27,1,37,'Fattura per acquisti da San Marino','Fattura per acquisti da San Marino'),(28,1,38,'Fattura per acquisti da San Marino','Fattura per acquisti da San Marino');
/*!40000 ALTER TABLE `co_tipidocumento_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `do_categorie`
--

DROP TABLE IF EXISTS `do_categorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `do_categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `do_categorie`
--

LOCK TABLES `do_categorie` WRITE;
/*!40000 ALTER TABLE `do_categorie` DISABLE KEYS */;
INSERT INTO `do_categorie` VALUES (1,NULL),(2,NULL);
/*!40000 ALTER TABLE `do_categorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `do_categorie_lang`
--

DROP TABLE IF EXISTS `do_categorie_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `do_categorie_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `do_categorie_lang_ibfk_1` (`id_record`),
  KEY `do_categorie_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `do_categorie_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `do_categorie` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `do_categorie_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `do_categorie_lang`
--

LOCK TABLES `do_categorie_lang` WRITE;
/*!40000 ALTER TABLE `do_categorie_lang` DISABLE KEYS */;
INSERT INTO `do_categorie_lang` VALUES (1,1,1,'Documenti societ├á','Documenti societ├á'),(2,1,2,'Contratti assunzione personale','Contratti assunzione personale');
/*!40000 ALTER TABLE `do_categorie_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `do_documenti`
--

DROP TABLE IF EXISTS `do_documenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `do_documenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idcategoria` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descrizione` text,
  `data` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `do_documenti`
--

LOCK TABLES `do_documenti` WRITE;
/*!40000 ALTER TABLE `do_documenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `do_documenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `do_permessi`
--

DROP TABLE IF EXISTS `do_permessi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `do_permessi` (
  `id_categoria` int NOT NULL,
  `id_gruppo` int NOT NULL,
  KEY `id_categoria` (`id_categoria`),
  KEY `id_gruppo` (`id_gruppo`),
  CONSTRAINT `do_permessi_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `do_categorie` (`id`) ON DELETE CASCADE,
  CONSTRAINT `do_permessi_ibfk_2` FOREIGN KEY (`id_gruppo`) REFERENCES `zz_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `do_permessi`
--

LOCK TABLES `do_permessi` WRITE;
/*!40000 ALTER TABLE `do_permessi` DISABLE KEYS */;
/*!40000 ALTER TABLE `do_permessi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_aspettobeni`
--

DROP TABLE IF EXISTS `dt_aspettobeni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_aspettobeni` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_aspettobeni`
--

LOCK TABLES `dt_aspettobeni` WRITE;
/*!40000 ALTER TABLE `dt_aspettobeni` DISABLE KEYS */;
INSERT INTO `dt_aspettobeni` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `dt_aspettobeni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_aspettobeni_lang`
--

DROP TABLE IF EXISTS `dt_aspettobeni_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_aspettobeni_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dt_aspettobeni_lang_ibfk_1` (`id_record`),
  KEY `dt_aspettobeni_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `dt_aspettobeni_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `dt_aspettobeni` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dt_aspettobeni_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_aspettobeni_lang`
--

LOCK TABLES `dt_aspettobeni_lang` WRITE;
/*!40000 ALTER TABLE `dt_aspettobeni_lang` DISABLE KEYS */;
INSERT INTO `dt_aspettobeni_lang` VALUES (1,1,1,'A vista','A vista'),(2,1,2,'Cartoni','Cartoni'),(3,1,3,'Sacchi','Sacchi'),(4,1,4,'Scatola','Scatola');
/*!40000 ALTER TABLE `dt_aspettobeni_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_automezzi`
--

DROP TABLE IF EXISTS `dt_automezzi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_automezzi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `descrizione` varchar(1000) NOT NULL,
  `targa` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_automezzi`
--

LOCK TABLES `dt_automezzi` WRITE;
/*!40000 ALTER TABLE `dt_automezzi` DISABLE KEYS */;
/*!40000 ALTER TABLE `dt_automezzi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_automezzi_tecnici`
--

DROP TABLE IF EXISTS `dt_automezzi_tecnici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_automezzi_tecnici` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idautomezzo` int NOT NULL,
  `idtecnico` int NOT NULL,
  `data_inizio` date DEFAULT NULL,
  `data_fine` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_automezzi_tecnici`
--

LOCK TABLES `dt_automezzi_tecnici` WRITE;
/*!40000 ALTER TABLE `dt_automezzi_tecnici` DISABLE KEYS */;
/*!40000 ALTER TABLE `dt_automezzi_tecnici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_causalet`
--

DROP TABLE IF EXISTS `dt_causalet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_causalet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_importabile` tinyint(1) DEFAULT '1',
  `is_rientrabile` int NOT NULL,
  `reversed` tinyint(1) NOT NULL,
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_causalet`
--

LOCK TABLES `dt_causalet` WRITE;
/*!40000 ALTER TABLE `dt_causalet` DISABLE KEYS */;
INSERT INTO `dt_causalet` VALUES (1,1,0,0,0,NULL),(2,1,0,0,0,NULL),(3,1,0,1,0,NULL),(4,1,0,0,0,NULL),(5,1,0,0,0,NULL),(6,1,0,0,0,NULL);
/*!40000 ALTER TABLE `dt_causalet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_causalet_lang`
--

DROP TABLE IF EXISTS `dt_causalet_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_causalet_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dt_causalet_lang_ibfk_1` (`id_record`),
  KEY `dt_causalet_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `dt_causalet_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `dt_causalet` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dt_causalet_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_causalet_lang`
--

LOCK TABLES `dt_causalet_lang` WRITE;
/*!40000 ALTER TABLE `dt_causalet_lang` DISABLE KEYS */;
INSERT INTO `dt_causalet_lang` VALUES (1,1,1,'Vendita','Vendita'),(2,1,2,'Noleggio','Noleggio'),(3,1,3,'Reso','Reso'),(4,1,4,'Conto lavorazione','Conto lavorazione'),(5,1,5,'Conto visione','Conto visione'),(6,1,6,'Omaggio','Omaggio');
/*!40000 ALTER TABLE `dt_causalet_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_ddt`
--

DROP TABLE IF EXISTS `dt_ddt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_ddt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(100) NOT NULL,
  `numero_esterno` varchar(100) NOT NULL,
  `data` date DEFAULT NULL,
  `data_ora_trasporto` datetime DEFAULT NULL,
  `idagente` int NOT NULL,
  `idiva` int NOT NULL,
  `idanagrafica` int NOT NULL,
  `idreferente` int DEFAULT NULL,
  `idcausalet` int NOT NULL,
  `idspedizione` tinyint NOT NULL,
  `idporto` tinyint NOT NULL,
  `idaspettobeni` tinyint NOT NULL,
  `idvettore` int NOT NULL,
  `idtipoddt` tinyint NOT NULL,
  `idstatoddt` tinyint NOT NULL,
  `idpagamento` int NOT NULL,
  `id_banca_azienda` int DEFAULT NULL,
  `id_banca_controparte` int DEFAULT NULL,
  `idconto` int NOT NULL,
  `idrivalsainps` int NOT NULL,
  `idritenutaacconto` int NOT NULL,
  `idsede_partenza` int NOT NULL,
  `idsede_destinazione` int NOT NULL,
  `rivalsainps` decimal(15,6) NOT NULL,
  `iva_rivalsainps` decimal(15,6) NOT NULL,
  `ritenutaacconto` decimal(15,6) NOT NULL,
  `bollo` decimal(15,6) NOT NULL,
  `n_colli` int NOT NULL,
  `peso` decimal(12,4) DEFAULT NULL,
  `volume` decimal(12,4) DEFAULT NULL,
  `peso_manuale` tinyint(1) NOT NULL,
  `volume_manuale` tinyint(1) NOT NULL,
  `note` varchar(255) NOT NULL,
  `note_aggiuntive` text NOT NULL,
  `codice_cig` varchar(15) DEFAULT NULL,
  `codice_cup` varchar(15) DEFAULT NULL,
  `id_documento_fe` varchar(20) DEFAULT NULL,
  `num_item` varchar(15) DEFAULT NULL,
  `sconto_finale` decimal(17,8) NOT NULL,
  `sconto_finale_percentuale` decimal(17,8) NOT NULL,
  `id_ddt_trasporto_interno` int DEFAULT NULL,
  `id_segment` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_ddt_trasporto_interno` (`id_ddt_trasporto_interno`),
  CONSTRAINT `dt_ddt_ibfk_1` FOREIGN KEY (`id_ddt_trasporto_interno`) REFERENCES `dt_ddt` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_ddt`
--

LOCK TABLES `dt_ddt` WRITE;
/*!40000 ALTER TABLE `dt_ddt` DISABLE KEYS */;
/*!40000 ALTER TABLE `dt_ddt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_porto`
--

DROP TABLE IF EXISTS `dt_porto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_porto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_porto`
--

LOCK TABLES `dt_porto` WRITE;
/*!40000 ALTER TABLE `dt_porto` DISABLE KEYS */;
INSERT INTO `dt_porto` VALUES (1,0),(2,0);
/*!40000 ALTER TABLE `dt_porto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_porto_lang`
--

DROP TABLE IF EXISTS `dt_porto_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_porto_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dt_porto_lang_ibfk_1` (`id_record`),
  KEY `dt_porto_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `dt_porto_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `dt_porto` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dt_porto_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_porto_lang`
--

LOCK TABLES `dt_porto_lang` WRITE;
/*!40000 ALTER TABLE `dt_porto_lang` DISABLE KEYS */;
INSERT INTO `dt_porto_lang` VALUES (1,1,1,'Franco','Franco'),(2,1,2,'Assegnato','Assegnato');
/*!40000 ALTER TABLE `dt_porto_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_righe_ddt`
--

DROP TABLE IF EXISTS `dt_righe_ddt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_righe_ddt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idddt` int NOT NULL,
  `idordine` int NOT NULL,
  `idarticolo` int DEFAULT NULL,
  `is_descrizione` tinyint(1) NOT NULL,
  `is_sconto` tinyint(1) NOT NULL DEFAULT '0',
  `idiva` int NOT NULL,
  `desc_iva` varchar(255) NOT NULL,
  `iva` decimal(15,6) NOT NULL,
  `iva_indetraibile` decimal(15,6) NOT NULL,
  `descrizione` text,
  `subtotale` decimal(15,6) NOT NULL,
  `sconto` decimal(15,6) NOT NULL,
  `sconto_unitario` decimal(15,6) NOT NULL,
  `sconto_iva_unitario` decimal(15,6) NOT NULL,
  `sconto_unitario_ivato` decimal(15,6) NOT NULL,
  `sconto_percentuale` decimal(15,6) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `note` text,
  `um` varchar(20) DEFAULT NULL,
  `abilita_serial` tinyint(1) NOT NULL DEFAULT '0',
  `qta` decimal(15,6) NOT NULL,
  `costo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `iva_unitaria` decimal(17,8) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `provvigione` decimal(15,6) NOT NULL,
  `provvigione_unitaria` decimal(15,6) NOT NULL,
  `provvigione_percentuale` decimal(15,6) NOT NULL,
  `tipo_provvigione` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `qta_evasa` decimal(15,6) NOT NULL,
  `order` int NOT NULL,
  `original_id` int DEFAULT NULL,
  `original_type` varchar(255) DEFAULT NULL,
  `original_document_id` int DEFAULT NULL,
  `original_document_type` varchar(255) DEFAULT NULL,
  `id_dettaglio_fornitore` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_dettaglio_fornitore` (`id_dettaglio_fornitore`),
  KEY `dt_righe_ddt_ibfk_2` (`idddt`),
  CONSTRAINT `dt_righe_ddt_ibfk_1` FOREIGN KEY (`id_dettaglio_fornitore`) REFERENCES `mg_fornitore_articolo` (`id`) ON DELETE SET NULL,
  CONSTRAINT `dt_righe_ddt_ibfk_2` FOREIGN KEY (`idddt`) REFERENCES `dt_ddt` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_righe_ddt`
--

LOCK TABLES `dt_righe_ddt` WRITE;
/*!40000 ALTER TABLE `dt_righe_ddt` DISABLE KEYS */;
/*!40000 ALTER TABLE `dt_righe_ddt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_spedizione`
--

DROP TABLE IF EXISTS `dt_spedizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_spedizione` (
  `id` int NOT NULL AUTO_INCREMENT,
  `esterno` tinyint(1) NOT NULL,
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_spedizione`
--

LOCK TABLES `dt_spedizione` WRITE;
/*!40000 ALTER TABLE `dt_spedizione` DISABLE KEYS */;
INSERT INTO `dt_spedizione` VALUES (1,0,0),(2,1,0),(3,0,0);
/*!40000 ALTER TABLE `dt_spedizione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_spedizione_lang`
--

DROP TABLE IF EXISTS `dt_spedizione_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_spedizione_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dt_spedizione_lang_ibfk_1` (`id_record`),
  KEY `dt_spedizione_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `dt_spedizione_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `dt_spedizione` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dt_spedizione_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_spedizione_lang`
--

LOCK TABLES `dt_spedizione_lang` WRITE;
/*!40000 ALTER TABLE `dt_spedizione_lang` DISABLE KEYS */;
INSERT INTO `dt_spedizione_lang` VALUES (1,1,1,'Espressa','Espressa'),(2,1,2,'Vettore','Vettore'),(3,1,3,'Ritiro in magazzino','Ritiro in magazzino');
/*!40000 ALTER TABLE `dt_spedizione_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_statiddt`
--

DROP TABLE IF EXISTS `dt_statiddt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_statiddt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `icona` varchar(100) NOT NULL,
  `colore` varchar(7) NOT NULL,
  `is_bloccato` tinyint(1) NOT NULL DEFAULT '0',
  `is_fatturabile` tinyint(1) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_statiddt`
--

LOCK TABLES `dt_statiddt` WRITE;
/*!40000 ALTER TABLE `dt_statiddt` DISABLE KEYS */;
INSERT INTO `dt_statiddt` VALUES (1,'fa fa-file-text-o text-muted','#ffef99',0,0,NULL),(2,'fa fa-truck text-success','#99ffff',1,1,NULL),(3,'fa fa-file-text-o text-success','#98fb98',1,0,NULL),(4,'fa fa-file-text-o text-warning','#b4ff99',1,1,NULL),(5,'fa fa-truck text-warning','#FFDF80',1,1,NULL);
/*!40000 ALTER TABLE `dt_statiddt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_statiddt_lang`
--

DROP TABLE IF EXISTS `dt_statiddt_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_statiddt_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dt_statiddt_lang_ibfk_1` (`id_record`),
  KEY `dt_statiddt_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `dt_statiddt_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `dt_statiddt` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dt_statiddt_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_statiddt_lang`
--

LOCK TABLES `dt_statiddt_lang` WRITE;
/*!40000 ALTER TABLE `dt_statiddt_lang` DISABLE KEYS */;
INSERT INTO `dt_statiddt_lang` VALUES (1,1,1,'Bozza','Bozza'),(2,1,2,'Evaso','Evaso'),(3,1,3,'Fatturato','Fatturato'),(4,1,4,'Parzialmente fatturato','Parzialmente fatturato'),(5,1,5,'Parzialmente evaso','Parzialmente evaso');
/*!40000 ALTER TABLE `dt_statiddt_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_tipiddt`
--

DROP TABLE IF EXISTS `dt_tipiddt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_tipiddt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dir` enum('entrata','uscita') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_tipiddt`
--

LOCK TABLES `dt_tipiddt` WRITE;
/*!40000 ALTER TABLE `dt_tipiddt` DISABLE KEYS */;
INSERT INTO `dt_tipiddt` VALUES (1,'uscita'),(2,'entrata');
/*!40000 ALTER TABLE `dt_tipiddt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_tipiddt_lang`
--

DROP TABLE IF EXISTS `dt_tipiddt_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_tipiddt_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dt_tipiddt_lang_ibfk_1` (`id_record`),
  KEY `dt_tipiddt_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `dt_tipiddt_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `dt_tipiddt` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dt_tipiddt_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_tipiddt_lang`
--

LOCK TABLES `dt_tipiddt_lang` WRITE;
/*!40000 ALTER TABLE `dt_tipiddt_lang` DISABLE KEYS */;
INSERT INTO `dt_tipiddt_lang` VALUES (1,1,1,'Ddt in entrata','Ddt in entrata'),(2,1,2,'Ddt in uscita','Ddt in uscita');
/*!40000 ALTER TABLE `dt_tipiddt_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_accounts`
--

DROP TABLE IF EXISTS `em_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL,
  `server` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `from_address` varchar(255) NOT NULL,
  `encryption` enum('','tls','ssl') NOT NULL,
  `ssl_no_verify` tinyint(1) NOT NULL DEFAULT '0',
  `pec` tinyint(1) NOT NULL,
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `timeout` int NOT NULL DEFAULT '1000',
  `connected_at` timestamp NULL DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `client_id` text,
  `client_secret` text,
  `oauth2_state` text,
  `access_token` text,
  `refresh_token` text,
  `oauth2_config` text,
  `id_oauth2` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_oauth2` (`id_oauth2`),
  CONSTRAINT `em_accounts_ibfk_1` FOREIGN KEY (`id_oauth2`) REFERENCES `zz_oauth2` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_accounts`
--

LOCK TABLES `em_accounts` WRITE;
/*!40000 ALTER TABLE `em_accounts` DISABLE KEYS */;
INSERT INTO `em_accounts` VALUES (1,'PEC aziendale','','','','','','','','',0,1,0,NULL,1000,'2025-07-29 12:37:54',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `em_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_files_categories_template`
--

DROP TABLE IF EXISTS `em_files_categories_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_files_categories_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_category` int NOT NULL,
  `id_template` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_files_categories_template`
--

LOCK TABLES `em_files_categories_template` WRITE;
/*!40000 ALTER TABLE `em_files_categories_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_files_categories_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_lists`
--

DROP TABLE IF EXISTS `em_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `query` text,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_lists`
--

LOCK TABLES `em_lists` WRITE;
/*!40000 ALTER TABLE `em_lists` DISABLE KEYS */;
INSERT INTO `em_lists` VALUES (1,'Tutte le Anagrafiche (Sedi legali)','SELECT idanagrafica AS id, \'Modules\\\\Anagrafiche\\\\Anagrafica\' AS tipo FROM an_anagrafiche WHERE deleted_at IS NULL',NULL),(2,'Tutti i Referenti','SELECT id, \'Modules\\\\Anagrafiche\\\\Referente\' AS tipo FROM an_referenti',NULL);
/*!40000 ALTER TABLE `em_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_lists_lang`
--

DROP TABLE IF EXISTS `em_lists_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_lists_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `em_lists_lang_ibfk_1` (`id_record`),
  KEY `em_lists_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `em_lists_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `em_lists` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `em_lists_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_lists_lang`
--

LOCK TABLES `em_lists_lang` WRITE;
/*!40000 ALTER TABLE `em_lists_lang` DISABLE KEYS */;
INSERT INTO `em_lists_lang` VALUES (1,1,1,'Tutte le Anagrafiche (Sedi legali)','Tutte le Anagrafiche (Sedi legali)','Indirizzi email validi per ogni anagrafica caricata a sistema'),(2,1,2,'Tutti i Referenti','Tutti i Referenti','Indirizzi email validi per ogni referente caricata a sistema');
/*!40000 ALTER TABLE `em_lists_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_mansioni_template`
--

DROP TABLE IF EXISTS `em_mansioni_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_mansioni_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idmansione` int NOT NULL,
  `id_template` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_mansioni_template`
--

LOCK TABLES `em_mansioni_template` WRITE;
/*!40000 ALTER TABLE `em_mansioni_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_mansioni_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_print_template`
--

DROP TABLE IF EXISTS `em_print_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_print_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_print` int NOT NULL,
  `id_template` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_print` (`id_print`),
  KEY `id_template` (`id_template`),
  CONSTRAINT `em_print_template_ibfk_2` FOREIGN KEY (`id_print`) REFERENCES `zz_prints` (`id`) ON DELETE CASCADE,
  CONSTRAINT `em_print_template_ibfk_3` FOREIGN KEY (`id_template`) REFERENCES `em_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_print_template`
--

LOCK TABLES `em_print_template` WRITE;
/*!40000 ALTER TABLE `em_print_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `em_print_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_templates`
--

DROP TABLE IF EXISTS `em_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_module` int NOT NULL,
  `id_smtp` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `tipo_reply_to` varchar(255) NOT NULL,
  `reply_to` varchar(255) NOT NULL,
  `cc` varchar(255) NOT NULL,
  `bcc` varchar(255) NOT NULL,
  `read_notify` tinyint(1) NOT NULL,
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  `note_aggiuntive` text NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(5) NOT NULL DEFAULT 'a',
  `indirizzi_proposti` tinyint NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id_account` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_account` (`id_account`),
  CONSTRAINT `em_templates_ibfk_1` FOREIGN KEY (`id_account`) REFERENCES `em_accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_templates`
--

LOCK TABLES `em_templates` WRITE;
/*!40000 ALTER TABLE `em_templates` DISABLE KEYS */;
INSERT INTO `em_templates` VALUES (1,3,1,'Rapportino intervento','fa fa-envelope','','','','',0,1,'',1,'a',0,NULL,1),(2,13,1,'Preventivo','fa fa-envelope','','','','',0,0,'',1,'a',0,NULL,1),(3,31,1,'Contratto','fa fa-envelope','','','','',0,0,'',1,'a',0,NULL,1),(4,24,1,'Ordine','fa fa-envelope','','','','',0,0,'',1,'a',0,NULL,1),(5,25,1,'Ordine','fa fa-envelope','','','','',0,0,'',1,'a',0,NULL,1),(6,14,1,'Fattura','fa fa-envelope','','','','',0,1,'',1,'a',0,NULL,1),(7,26,1,'Ddt','fa fa-envelope','','','','',0,0,'',1,'a',0,NULL,1),(8,31,1,'Consuntivo contratto','fa fa-envelope','','','','',0,0,'',1,'a',0,NULL,1),(9,13,1,'Consuntivo preventivo','fa fa-envelope','','','','',0,0,'',1,'a',0,NULL,1),(10,3,1,'Notifica intervento','fa fa-envelope','','','','',0,1,'',1,'a',0,NULL,1),(11,3,1,'Notifica rimozione intervento','fa fa-envelope','','','','',0,1,'',1,'a',0,NULL,1),(12,3,1,'Stato intervento','fa fa-envelope','','','','',0,0,'',1,'a',0,NULL,1),(13,14,1,'PEC','fa fa-file','','','sdi52@pec.fatturapa.it','',0,0,'',1,'a',0,NULL,1),(14,18,1,'Sollecito di pagamento','fa fa-envelope','','','','',0,1,'',1,'a',0,NULL,1);
/*!40000 ALTER TABLE `em_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `em_templates_lang`
--

DROP TABLE IF EXISTS `em_templates_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_templates_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `em_templates_lang_ibfk_1` (`id_record`),
  KEY `em_templates_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `em_templates_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `em_templates` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `em_templates_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_templates_lang`
--

LOCK TABLES `em_templates_lang` WRITE;
/*!40000 ALTER TABLE `em_templates_lang` DISABLE KEYS */;
INSERT INTO `em_templates_lang` VALUES (1,1,1,'Rapportino intervento','Rapportino intervento','Invio rapportino numero {numero} del {data fine intervento}','<p>Gentile Cliente,</p>\n<p>inviamo in allegato il rapportino numero {numero} del {data fine intervento}.</p>\n<p>Distinti saluti</p>'),(2,1,2,'Preventivo','Preventivo','Invio preventivo numero {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato il preventivo numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(3,1,3,'Contratto','Contratto','Invio contratto numero {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato il contratto numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(4,1,4,'Ordine','Ordine','Invio ordine numero {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato l\'ordine numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(5,1,5,'Ordine','Ordine','Invio ordine numero {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato l\'ordine numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(6,1,6,'Fattura','Fattura','Invio fattura numero {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato la fattura numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(7,1,7,'Ddt','Ddt','Invio ddt {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato il ddt numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(8,1,8,'Consuntivo contratto','Consuntivo contratto','Invio consuntivo contratto numero {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato il rapportino numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(9,1,9,'Consuntivo preventivo','Consuntivo preventivo','Invio consuntivo del preventivo numero {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato il rapportino numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(10,1,10,'Notifica intervento','Notifica intervento','Notifica intervento numero {numero} del {data}','<p>Gentile Tecnico,</p>\r\n<p>un nuovo intervento {numero} in {data} ├¿ stato aggiunto.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(11,1,11,'Notifica rimozione intervento','Notifica rimozione intervento','Notifica intervento numero {numero} del {data}','<p>Gentile Tecnico,</p>\r\n<p>sei stato rimosso dall\'intervento {numero} in {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(12,1,12,'Stato intervento','Stato intervento','Intervento numero {numero} del {data}: {stato}.','<p>Gentile Utente,</p>\r\n<p>l\'intervento {numero} in {data} ├¿ stato spostato nello stato {stato}.</p>'),(13,1,13,'PEC','PEC','Invio fattura numero {numero} del {data}','<p>Gentile Cliente,</p>\r\n<p>inviamo in allegato la fattura numero {numero} del {data}.</p>\r\n<p>&nbsp;</p>\r\n<p>Distinti saluti</p>\r\n'),(14,1,14,'Sollecito di pagamento','Sollecito di pagamento','Sollecito di pagamento fattura {numero}','<p>Spett.le {ragione_sociale},</p>\n\n<p>da un riscontro contabile, ci risulta che la fattura numero {numero} a Voi intestata, riporti il mancato pagamento delle seguenti rate:</p>\n\n<p>{scadenze_fatture_scadute}</p>\n\n<p>La sollecitiamo pertanto di provvedere quanto prima a regolarizzare la sua situazione contabile. A tal proposito, il pagamento potr├á essere effettuato tramite {pagamento}.</p>\n\n<p>Se ha gi├á provveduto al pagamento, ritenga nulla la presente.</p>\n\n<p> </p>\n\n<p>La ringraziamo e le porgiamo i nostri saluti.</p>');
/*!40000 ALTER TABLE `em_templates_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_causali_pagamento_ritenuta`
--

DROP TABLE IF EXISTS `fe_causali_pagamento_ritenuta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_causali_pagamento_ritenuta` (
  `codice` varchar(4) NOT NULL,
  `descrizione` varchar(1000) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_causali_pagamento_ritenuta`
--

LOCK TABLES `fe_causali_pagamento_ritenuta` WRITE;
/*!40000 ALTER TABLE `fe_causali_pagamento_ritenuta` DISABLE KEYS */;
INSERT INTO `fe_causali_pagamento_ritenuta` VALUES ('A','Prestazioni di lavoro autonomo rientranti nell\'esercizio di arte o professione abituale'),('B','Utilizzazione economica, da parte dell\'autore o dell\'inventore, di opere dell\'ingegno, di brevetti industriali e di processi, formule o informazioni relativi a esperienze acquisite in campo industriale, commerciale o scientifico'),('C','Utili derivanti da contratti di associazione in partecipazione e da contratti di cointeressenza, quando l\'apporto ├¿ costituito esclusivamente dalla prestazione di lavoro'),('D','Utili spettanti ai soci promotori e ai soci fondatori delle societ├á di capitali'),('E','Levata di protesti cambiari da parte dei segretari comunali'),('G','Indennit├á corrisposte per la cessazione di attivit├á sportiva professionale'),('H','Indennit├á corrisposte per la cessazione dei rapporti di agenzia delle persone fisiche e delle societ├á di persone, con esclusione delle somme maturate entro il 31.12.2003, gi├á imputate per competenza e tassate come reddito d\'impresa'),('I','Indennit├á corrisposte per la cessazione da funzioni notarili'),('L','Utilizzazione economica, da parte di soggetto diverso dall\'autore o dall\'inventore, di opere dell\'ingegno, di brevetti industriali e di processi, formule e informazioni relative a esperienze acquisite in campo industriale, commerciale o scientifico'),('L1','Redditi derivanti dallÔÇÖutilizzazione economica di opere dellÔÇÖingegno, di brevetti industriali e di processi, che sono percepiti da soggetti che abbiano acquistato a titolo oneroso i diritti alla loro utilizzazione'),('M','Prestazioni di lavoro autonomo non esercitate abitualmente, obblighi di fare, di non fare o permettere'),('M1','Redditi derivanti dallÔÇÖassunzione di obblighi di fare, di non fare o permettere'),('M2','Prestazioni di lavoro autonomo non esercitate abitualmente per le quali sussiste lÔÇÖobbligo di iscrizione alla Gestione Separata ENPAPI'),('N','Indennit├á di trasferta, rimborso forfetario di spese, premi e compensi erogati nell\'esercizio diretto di attivit├á sportive dilettantistiche e in relazione a rapporti di collaborazione coordinata e continuativa di carattere amministrativo-gestionale, di natura non profe\nssionale, resi a favore di societ├á e associazioni sportive dilettantistiche e di cori, bande e filodrammatiche da parte del diretto\nre e dei collaboratori tecnici'),('O','Prestazioni di lavoro autonomo non esercitate abitualmente, obblighi di fare, di non fare o permettere, per le quali non sussiste l\'obbligo di iscrizione alla gestione separata (Circ. Inps 104/2001)'),('O1','Redditi derivanti dallÔÇÖassunzione di obblighi di fare, di non fare o permettere, per le quali non sussiste lÔÇÖobbligo di iscrizione alla gestione separata (Circ. INPS n. 104/2001)'),('P','Compensi corrisposti a soggetti non residenti privi di stabile organizzazione per l\'uso o la concessione in uso di attrezzature industriali, commerciali o scientifiche che si trovano nel territorio dello Stato ovvero a societ├á svizzere o stabili organizzazioni di soci\net├á svizzere che possiedono i requisiti di cui all\'art. 15, c. 2 dellÔÇÖAccordo tra la Comunit├á Europea e la Confederazione svizzera del 26.10\n.2004 (pubblicato in G.U.C.E. 29.12.2004, n. 385/30)'),('Q','Provvigioni corrisposte ad agente o rappresentante di commercio monomandatario'),('R','Provvigioni corrisposte ad agente o rappresentante di commercio plurimandatario'),('S','Provvigioni corrisposte a commissionario'),('T','Provvigioni corrisposte a mediatore'),('U','Provvigioni corrisposte a procacciatore di affari'),('V','Provvigioni corrisposte a incaricato per le vendite a domicilio e provvigioni corrisposte a incaricato per la vendita porta a porta e per la vendita ambulante di giornali quotidiani e periodici (L. 25.02.1987, n. 67)'),('V1','Redditi derivanti da attivit├á commerciali non esercitate abitualmente (ad esempio, provvigioni corrisposte per prestazioni occasionali ad agente o rappresentante di commercio, mediatore, procacciatore dÔÇÖaffari)'),('V2','Redditi derivanti dalle prestazioni non esercitate abitualmente rese dagli incaricati alla vendita diretta a domicilio'),('W','Corrispettivi erogati nel 2013 per prestazioni relative a contratti d\'appalto cui si sono resi applicabili le disposizioni contenute nell\'art. 25-ter D.P.R. 600/1973'),('X','Canoni corrisposti nel 2004 da societ├á o enti residenti, ovvero da stabili organizzazioni di societ├á estere di cui all\'art. 26-quater, c. 1, lett. a) e b) D.P.R. 600/1973, a societ├á o stabili organizzazioni di societ├á, situate in altro Stato membro dell\'Unione Europea in presenza dei relativi requisiti richiesti, per i quali ├¿ stato effettuato nel 2006 il rimborso della ritenuta ai sensi dell\'art. 4 D. Lgs. 143/2005'),('Y','Canoni corrisposti dal 1.01.2005 al 26.07.2005 da soggetti di cui al punto precedente'),('ZO','Titolo diverso dai precedenti');
/*!40000 ALTER TABLE `fe_causali_pagamento_ritenuta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_modalita_pagamento`
--

DROP TABLE IF EXISTS `fe_modalita_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_modalita_pagamento` (
  `codice` varchar(4) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_modalita_pagamento`
--

LOCK TABLES `fe_modalita_pagamento` WRITE;
/*!40000 ALTER TABLE `fe_modalita_pagamento` DISABLE KEYS */;
INSERT INTO `fe_modalita_pagamento` VALUES ('MP01'),('MP02'),('MP03'),('MP04'),('MP05'),('MP06'),('MP07'),('MP08'),('MP09'),('MP10'),('MP11'),('MP12'),('MP13'),('MP14'),('MP15'),('MP16'),('MP17'),('MP18'),('MP19'),('MP20'),('MP21'),('MP22'),('MP23');
/*!40000 ALTER TABLE `fe_modalita_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_modalita_pagamento_lang`
--

DROP TABLE IF EXISTS `fe_modalita_pagamento_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_modalita_pagamento_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` varchar(4) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fe_modalita_pagamento_lang_ibfk_1` (`id_record`),
  KEY `fe_modalita_pagamento_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `fe_modalita_pagamento_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `fe_modalita_pagamento` (`codice`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fe_modalita_pagamento_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_modalita_pagamento_lang`
--

LOCK TABLES `fe_modalita_pagamento_lang` WRITE;
/*!40000 ALTER TABLE `fe_modalita_pagamento_lang` DISABLE KEYS */;
INSERT INTO `fe_modalita_pagamento_lang` VALUES (1,1,'MP01','Contanti','Contanti'),(2,1,'MP02','Assegno','Assegno'),(3,1,'MP03','Assegno circolare','Assegno circolare'),(4,1,'MP04','Contanti presso Tesoreria','Contanti presso Tesoreria'),(5,1,'MP05','Bonifico','Bonifico'),(6,1,'MP06','Vaglia cambiario','Vaglia cambiario'),(7,1,'MP07','Bollettino bancario','Bollettino bancario'),(8,1,'MP08','Carta di pagamento','Carta di pagamento'),(9,1,'MP09','RID','RID'),(10,1,'MP10','RID utenze','RID utenze'),(11,1,'MP11','RID veloce','RID veloce'),(12,1,'MP12','RIBA','RIBA'),(13,1,'MP13','MAV','MAV'),(14,1,'MP14','Quietanza erario','Quietanza erario'),(15,1,'MP15','Giroconto su conti di contabilit├á speciale','Giroconto su conti di contabilit├á speciale'),(16,1,'MP16','Domiciliazione bancaria','Domiciliazione bancaria'),(17,1,'MP17','Domiciliazione postale','Domiciliazione postale'),(18,1,'MP18','Bollettino di c/c postale','Bollettino di c/c postale'),(19,1,'MP19','SEPA Direct Debit','SEPA Direct Debit'),(20,1,'MP20','SEPA Direct Debit CORE','SEPA Direct Debit CORE'),(21,1,'MP21','SEPA Direct Debit B2B','SEPA Direct Debit B2B'),(22,1,'MP22','Trattenuta su somme gi├á riscosse','Trattenuta su somme gi├á riscosse'),(23,1,'MP23','PagoPA','PagoPA');
/*!40000 ALTER TABLE `fe_modalita_pagamento_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_natura`
--

DROP TABLE IF EXISTS `fe_natura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_natura` (
  `codice` varchar(5) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_natura`
--

LOCK TABLES `fe_natura` WRITE;
/*!40000 ALTER TABLE `fe_natura` DISABLE KEYS */;
INSERT INTO `fe_natura` VALUES ('N1'),('N2'),('N2.1'),('N2.2'),('N3'),('N3.1'),('N3.2'),('N3.3'),('N3.4'),('N3.5'),('N3.6'),('N4'),('N5'),('N6'),('N6.1'),('N6.2'),('N6.3'),('N6.4'),('N6.5'),('N6.6'),('N6.7'),('N6.8'),('N6.9'),('N7');
/*!40000 ALTER TABLE `fe_natura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_natura_lang`
--

DROP TABLE IF EXISTS `fe_natura_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_natura_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fe_natura_lang_ibfk_1` (`id_record`),
  KEY `fe_natura_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `fe_natura_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `fe_natura` (`codice`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fe_natura_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_natura_lang`
--

LOCK TABLES `fe_natura_lang` WRITE;
/*!40000 ALTER TABLE `fe_natura_lang` DISABLE KEYS */;
INSERT INTO `fe_natura_lang` VALUES (1,1,'N1','Escluse ex art. 15','Escluse ex art. 15'),(2,1,'N2','Non soggette','Non soggette'),(3,1,'N2.1','non soggette ad IVA ai sensi degli artt. Da 7 a 7-septies del DPR 633/72','non soggette ad IVA ai sensi degli artt. Da 7 a 7-septies del DPR 633/72'),(4,1,'N2.2','non soggette - altri casi','non soggette - altri casi'),(5,1,'N3','Non imponibili','Non imponibili'),(6,1,'N3.1','non imponibili - esportazioni','non imponibili - esportazioni'),(7,1,'N3.2','non imponibili - cessioni intracomunitarie','non imponibili - cessioni intracomunitarie'),(8,1,'N3.3','non imponibili - cessioni verso San Marino','non imponibili - cessioni verso San Marino'),(9,1,'N3.4','non imponibili - operazioni assimilate alle cessioni all\'esportazione','non imponibili - operazioni assimilate alle cessioni all\'esportazione'),(10,1,'N3.5','non imponibili - a seguito di dichiarazioni d\'intento','non imponibili - a seguito di dichiarazioni d\'intento'),(11,1,'N3.6','non imponibili - altre operazioni che non concorrono alla formazione del plafond','non imponibili - altre operazioni che non concorrono alla formazione del plafond'),(12,1,'N4','Esenti','Esenti'),(13,1,'N5','Regime del margine / IVA non esposta in fattura','Regime del margine / IVA non esposta in fattura'),(14,1,'N6','Inversione contabile (per le operazioni in reverse charge ovvero nei casi di autofatturazione per acquisti extra UE di servizi ovvero per importazioni di beni nei soli casi previsti)','Inversione contabile (per le operazioni in reverse charge ovvero nei casi di autofatturazione per acquisti extra UE di servizi ovvero per importazioni di beni nei soli casi previsti)'),(15,1,'N6.1','inversione contabile - cessione di rottami e altri materiali di recupero','inversione contabile - cessione di rottami e altri materiali di recupero'),(16,1,'N6.2','inversione contabile - cessione di oro e argento pure','inversione contabile - cessione di oro e argento pure'),(17,1,'N6.3','inversione contabile - subappalto nel settore edile','inversione contabile - subappalto nel settore edile'),(18,1,'N6.4','inversione contabile - cessione di fabbricati','inversione contabile - cessione di fabbricati'),(19,1,'N6.5','inversione contabile - cessione di telefoni cellulari','inversione contabile - cessione di telefoni cellulari'),(20,1,'N6.6','inversione contabile - cessione di prodotti elettronici','inversione contabile - cessione di prodotti elettronici'),(21,1,'N6.7','inversione contabile - prestazioni comparto edile e settori connessi','inversione contabile - prestazioni comparto edile e settori connessi'),(22,1,'N6.8','inversione contabile - operazioni settore energetico','inversione contabile - operazioni settore energetico'),(23,1,'N6.9','inversione contabile - altri casi','inversione contabile - altri casi'),(24,1,'N7','IVA assolta in altro stato UE (vendite a distanza ex art. 40 c. 3 e 4 e art. 41 c. 1 lett. b, DL 331/93; prestazione di servizi di telecomunicazioni, tele-radiodiffusione ed elettronici ex art. 7-sexies lett. f, g, art. 74-sexies DPR 633/72)','IVA assolta in altro stato UE (vendite a distanza ex art. 40 c. 3 e 4 e art. 41 c. 1 lett. b, DL 331/93; prestazione di servizi di telecomunicazioni, tele-radiodiffusione ed elettronici ex art. 7-sexies lett. f, g, art. 74-sexies DPR 633/72)');
/*!40000 ALTER TABLE `fe_natura_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_regime_fiscale`
--

DROP TABLE IF EXISTS `fe_regime_fiscale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_regime_fiscale` (
  `codice` varchar(4) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_regime_fiscale`
--

LOCK TABLES `fe_regime_fiscale` WRITE;
/*!40000 ALTER TABLE `fe_regime_fiscale` DISABLE KEYS */;
INSERT INTO `fe_regime_fiscale` VALUES ('RF01'),('RF02'),('RF04'),('RF05'),('RF06'),('RF07'),('RF08'),('RF09'),('RF10'),('RF11'),('RF12'),('RF13'),('RF14'),('RF15'),('RF16'),('RF17'),('RF18'),('RF19');
/*!40000 ALTER TABLE `fe_regime_fiscale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_regime_fiscale_lang`
--

DROP TABLE IF EXISTS `fe_regime_fiscale_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_regime_fiscale_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fe_regime_fiscale_lang_ibfk_1` (`id_record`),
  KEY `fe_regime_fiscale_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `fe_regime_fiscale_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `fe_regime_fiscale` (`codice`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fe_regime_fiscale_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_regime_fiscale_lang`
--

LOCK TABLES `fe_regime_fiscale_lang` WRITE;
/*!40000 ALTER TABLE `fe_regime_fiscale_lang` DISABLE KEYS */;
INSERT INTO `fe_regime_fiscale_lang` VALUES (1,1,'RF01','Ordinario','Ordinario'),(2,1,'RF02','Contribuenti minimi (art.1, c.96-117, L. 244/07)','Contribuenti minimi (art.1, c.96-117, L. 244/07)'),(3,1,'RF04','Agricoltura e attivit├á connesse e pesca (artt.34 e 34-bis, DPR 633/72)','Agricoltura e attivit├á connesse e pesca (artt.34 e 34-bis, DPR 633/72)'),(4,1,'RF05','Vendita sali e tabacchi (art.74, c.1, DPR. 633/72)','Vendita sali e tabacchi (art.74, c.1, DPR. 633/72)'),(5,1,'RF06','Commercio fiammiferi (art.74, c.1, DPR  633/72)','Commercio fiammiferi (art.74, c.1, DPR  633/72)'),(6,1,'RF07','Editoria (art.74, c.1, DPR  633/72)','Editoria (art.74, c.1, DPR  633/72)'),(7,1,'RF08','Gestione servizi telefonia pubblica (art.74, c.1, DPR 633/72)','Gestione servizi telefonia pubblica (art.74, c.1, DPR 633/72)'),(8,1,'RF09','Rivendita documenti di trasporto pubblico e di sosta (art.74, c.1, DPR  633/72)','Rivendita documenti di trasporto pubblico e di sosta (art.74, c.1, DPR  633/72)'),(9,1,'RF10','Intrattenimenti, giochi e altre attivit├á di cui alla tariffa allegata al DPR 640/72 (art.74, c.6, DPR 633/72)','Intrattenimenti, giochi e altre attivit├á di cui alla tariffa allegata al DPR 640/72 (art.74, c.6, DPR 633/72)'),(10,1,'RF11','Agenzie viaggi e turismo (art.74-ter, DPR 633/72)','Agenzie viaggi e turismo (art.74-ter, DPR 633/72)'),(11,1,'RF12','Agriturismo (art.5, c.2, L. 413/91)','Agriturismo (art.5, c.2, L. 413/91)'),(12,1,'RF13','Vendite a domicilio (art.25-bis, c.6, DPR  600/73)','Vendite a domicilio (art.25-bis, c.6, DPR  600/73)'),(13,1,'RF14','Rivendita beni usati, oggetti dÔÇÖarte, dÔÇÖantiquariato o da collezione (art.36, DL 41/95)','Rivendita beni usati, oggetti dÔÇÖarte, dÔÇÖantiquariato o da collezione (art.36, DL 41/95)'),(14,1,'RF15','Agenzie di vendite allÔÇÖasta di oggetti dÔÇÖarte, antiquariato o da collezione (art.40-bis, DL 41/95)','Agenzie di vendite allÔÇÖasta di oggetti dÔÇÖarte, antiquariato o da collezione (art.40-bis, DL 41/95)'),(15,1,'RF16','IVA per cassa P.A. (art.6, c.5, DPR 633/72)','IVA per cassa P.A. (art.6, c.5, DPR 633/72)'),(16,1,'RF17','IVA per cassa (art. 32-bis, DL 83/2012)','IVA per cassa (art. 32-bis, DL 83/2012)'),(17,1,'RF18','Altro','Altro'),(18,1,'RF19','Regime forfettario (art.1, c.54-89, L. 190/2014)','Regime forfettario (art.1, c.54-89, L. 190/2014)');
/*!40000 ALTER TABLE `fe_regime_fiscale_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_stati_documento`
--

DROP TABLE IF EXISTS `fe_stati_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_stati_documento` (
  `codice` varchar(5) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `is_generabile` tinyint(1) DEFAULT '0',
  `is_inviabile` tinyint(1) DEFAULT '0',
  `tipo` varchar(255) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_stati_documento`
--

LOCK TABLES `fe_stati_documento` WRITE;
/*!40000 ALTER TABLE `fe_stati_documento` DISABLE KEYS */;
INSERT INTO `fe_stati_documento` VALUES ('AT','fa fa-check text-warning',0,0,'danger'),('DT','fa fa-calendar-times-o text-danger',0,0,'danger'),('EC01','fa fa-check text-success',0,0,'success'),('EC02','fa fa-times text-danger',1,0,'danger'),('ERR','fa fa-close',1,1,'danger'),('ERVAL','fa fa-edit text-danger',1,1,'warning'),('GEN','fa fa-file-code-o text-info',1,1,'info'),('MC','fa fa-paper-plane-o text-success',0,0,'info'),('NE','fa fa-check-circle text-warning',0,0,'warning'),('NS','fa fa-times text-danger',1,0,'danger'),('QUEUE','fa fa-spinner',0,0,'danger'),('RC','fa fa-inbox text-success',0,0,'success'),('WAIT','fa fa-clock-o text-warning',0,0,'warning');
/*!40000 ALTER TABLE `fe_stati_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_stati_documento_lang`
--

DROP TABLE IF EXISTS `fe_stati_documento_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_stati_documento_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fe_stati_documento_lang_ibfk_1` (`id_record`),
  KEY `fe_stati_documento_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `fe_stati_documento_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `fe_stati_documento` (`codice`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fe_stati_documento_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_stati_documento_lang`
--

LOCK TABLES `fe_stati_documento_lang` WRITE;
/*!40000 ALTER TABLE `fe_stati_documento_lang` DISABLE KEYS */;
INSERT INTO `fe_stati_documento_lang` VALUES (1,1,'AT','Attestazione trasmissione','Attestazione trasmissione'),(2,1,'DT','Decorrenza termini','Decorrenza termini'),(3,1,'EC01','Accettata','Accettata'),(4,1,'EC02','Rifiutata','Rifiutata'),(5,1,'ERR','Trasmissione non riuscita','Trasmissione non riuscita'),(6,1,'ERVAL','Errore di validazione','Errore di validazione'),(7,1,'GEN','Generata','Generata'),(8,1,'MC','Mancata consegna','Mancata consegna'),(9,1,'NE','Notifica esito','Notifica esito'),(10,1,'NS','Scartata','Scartata'),(11,1,'QUEUE','In coda di elaborazione','In coda di elaborazione'),(12,1,'RC','Consegnata','Consegnata'),(13,1,'WAIT','In elaborazione','In elaborazione');
/*!40000 ALTER TABLE `fe_stati_documento_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_tipi_documento`
--

DROP TABLE IF EXISTS `fe_tipi_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_tipi_documento` (
  `codice` varchar(4) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_tipi_documento`
--

LOCK TABLES `fe_tipi_documento` WRITE;
/*!40000 ALTER TABLE `fe_tipi_documento` DISABLE KEYS */;
INSERT INTO `fe_tipi_documento` VALUES ('TD01'),('TD02'),('TD03'),('TD04'),('TD05'),('TD06'),('TD16'),('TD17'),('TD18'),('TD19'),('TD20'),('TD21'),('TD22'),('TD23'),('TD24'),('TD25'),('TD26'),('TD27'),('TD28');
/*!40000 ALTER TABLE `fe_tipi_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_tipi_documento_lang`
--

DROP TABLE IF EXISTS `fe_tipi_documento_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_tipi_documento_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` varchar(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fe_tipi_documento_lang_ibfk_1` (`id_record`),
  KEY `fe_tipi_documento_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `fe_tipi_documento_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `fe_tipi_documento` (`codice`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fe_tipi_documento_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_tipi_documento_lang`
--

LOCK TABLES `fe_tipi_documento_lang` WRITE;
/*!40000 ALTER TABLE `fe_tipi_documento_lang` DISABLE KEYS */;
INSERT INTO `fe_tipi_documento_lang` VALUES (1,1,'TD01','Fattura','Fattura'),(2,1,'TD02','Acconto/anticipo su fattura','Acconto/anticipo su fattura'),(3,1,'TD03','Acconto/anticipo su parcella','Acconto/anticipo su parcella'),(4,1,'TD04','Nota di credito','Nota di credito'),(5,1,'TD05','Nota di debito','Nota di debito'),(6,1,'TD06','Parcella','Parcella'),(7,1,'TD16','Integrazione fattura reverse charge interno','Integrazione fattura reverse charge interno'),(8,1,'TD17','Integrazione/autofattura per acquisto servizi dall\'estero','Integrazione/autofattura per acquisto servizi dall\'estero'),(9,1,'TD18','Integrazione per acquisto di beni intracomunitari','Integrazione per acquisto di beni intracomunitari'),(10,1,'TD19','Integrazione/autofattura per acquisto di beni ex art.17 c.2 DPR 633/72','Integrazione/autofattura per acquisto di beni ex art.17 c.2 DPR 633/72'),(11,1,'TD20','Autofattura per regolarizzazione e integrazione delle fatture (art.6 c.8 d.lgs. 471/97 o art.46 c.5 D.L. 331/93)','Autofattura per regolarizzazione e integrazione delle fatture (art.6 c.8 d.lgs. 471/97 o art.46 c.5 D.L. 331/93)'),(12,1,'TD21','Autofattura per splafonamento','Autofattura per splafonamento'),(13,1,'TD22','Estrazione beni da deposito IVA','Estrazione beni da deposito IVA'),(14,1,'TD23','Estrazione beni da deposito IVA con versamento dell\'IVA','Estrazione beni da deposito IVA con versamento dell\'IVA'),(15,1,'TD24','Fattura differita di cui all\'art.21, comma 4, lett. a)','Fattura differita di cui all\'art.21, comma 4, lett. a)'),(16,1,'TD25','Fattura differita di cui all\'art.21, comma 4, terzo periodo lett. b)','Fattura differita di cui all\'art.21, comma 4, terzo periodo lett. b)'),(17,1,'TD26','Cessione di beni ammortizzabili e per passaggi interni (ex art.36 DPR 633/72)','Cessione di beni ammortizzabili e per passaggi interni (ex art.36 DPR 633/72)'),(18,1,'TD27','Fattura per autoconsumo o per cessioni gratuite senza rivalsa','Fattura per autoconsumo o per cessioni gratuite senza rivalsa'),(19,1,'TD28','Fattura per acquisti da San Marino','Fattura per acquisti da San Marino');
/*!40000 ALTER TABLE `fe_tipi_documento_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_tipi_ritenuta`
--

DROP TABLE IF EXISTS `fe_tipi_ritenuta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_tipi_ritenuta` (
  `codice` varchar(4) NOT NULL,
  `descrizione` varchar(255) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_tipi_ritenuta`
--

LOCK TABLES `fe_tipi_ritenuta` WRITE;
/*!40000 ALTER TABLE `fe_tipi_ritenuta` DISABLE KEYS */;
INSERT INTO `fe_tipi_ritenuta` VALUES ('RT01','Ritenuta persone fisiche'),('RT02','Ritenuta persone giuridiche'),('RT03','Contributo INPS'),('RT04','Contributo ENASARCO'),('RT05','Contributo ENPAM'),('RT06','Altro contributo previdenziale');
/*!40000 ALTER TABLE `fe_tipi_ritenuta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fe_tipo_cassa`
--

DROP TABLE IF EXISTS `fe_tipo_cassa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fe_tipo_cassa` (
  `codice` varchar(4) NOT NULL,
  `descrizione` varchar(255) NOT NULL,
  PRIMARY KEY (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fe_tipo_cassa`
--

LOCK TABLES `fe_tipo_cassa` WRITE;
/*!40000 ALTER TABLE `fe_tipo_cassa` DISABLE KEYS */;
INSERT INTO `fe_tipo_cassa` VALUES ('TC01','Cassa nazionale previdenza e assistenza avvocati e procuratori legali'),('TC02','Cassa previdenza dottori commercialisti'),('TC03','Cassa previdenza e assistenza geometri'),('TC04','Cassa nazionale previdenza e assistenza ingegneri e architetti liberi professionisti'),('TC05','Cassa nazionale del notariato'),('TC06','Cassa nazionale previdenza e assistenza ragionieri e periti commerciali'),('TC07','Ente nazionale assistenza agenti e rappresentanti di commercio (ENASARCO)'),('TC08','Ente nazionale previdenza e assistenza consulenti del lavoro (ENPACL)'),('TC09','Ente nazionale previdenza e assistenza medici (ENPAM)'),('TC10','Ente nazionale previdenza e assistenza farmacisti (ENPAF)'),('TC11','Ente nazionale previdenza e assistenza veterinari (ENPAV)'),('TC12','Ente nazionale previdenza e assistenza impiegati dell agricoltura (ENPAIA)'),('TC13','Fondo previdenza impiegati imprese di spedizione e agenzie marittime'),('TC14','Istituto nazionale previdenza giornalisti italiani (INPGI)'),('TC15','Opera nazionale assistenza orfani sanitari italiani (ONAOSI)'),('TC16','Cassa autonoma assistenza integrativa giornalisti italiani (CASAGIT)'),('TC17','Ente previdenza periti industriali e periti industriali laureati (EPPI)'),('TC18','Ente previdenza e assistenza pluricategoriale (EPAP)'),('TC19','Ente nazionale previdenza e assistenza biologi (ENPAB)'),('TC20','Ente nazionale previdenza e assistenza professione infermieristica (ENPAPI)'),('TC21','Ente nazionale previdenza e assistenza psicologi (ENPAP)'),('TC22','INPS');
/*!40000 ALTER TABLE `fe_tipo_cassa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_fasceorarie`
--

DROP TABLE IF EXISTS `in_fasceorarie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_fasceorarie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `giorni` varchar(255) DEFAULT NULL,
  `ora_inizio` time DEFAULT NULL,
  `ora_fine` time DEFAULT NULL,
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  `is_predefined` tinyint(1) NOT NULL DEFAULT '0',
  `include_bank_holidays` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_fasceorarie`
--

LOCK TABLES `in_fasceorarie` WRITE;
/*!40000 ALTER TABLE `in_fasceorarie` DISABLE KEYS */;
INSERT INTO `in_fasceorarie` VALUES (1,'1,2,3,4,5,6,7','00:00:00','23:59:00',0,1,0,NULL);
/*!40000 ALTER TABLE `in_fasceorarie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_fasceorarie_lang`
--

DROP TABLE IF EXISTS `in_fasceorarie_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_fasceorarie_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `in_fasceorarie_lang_ibfk_1` (`id_record`),
  KEY `in_fasceorarie_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `in_fasceorarie_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `in_fasceorarie` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `in_fasceorarie_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_fasceorarie_lang`
--

LOCK TABLES `in_fasceorarie_lang` WRITE;
/*!40000 ALTER TABLE `in_fasceorarie_lang` DISABLE KEYS */;
INSERT INTO `in_fasceorarie_lang` VALUES (1,1,1,'Ordinario','Ordinario');
/*!40000 ALTER TABLE `in_fasceorarie_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_fasceorarie_tipiintervento`
--

DROP TABLE IF EXISTS `in_fasceorarie_tipiintervento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_fasceorarie_tipiintervento` (
  `idfasciaoraria` int NOT NULL,
  `idtipointervento` int NOT NULL,
  `costo_orario` decimal(15,6) NOT NULL,
  `costo_km` decimal(15,6) NOT NULL,
  `costo_diritto_chiamata` decimal(15,6) NOT NULL,
  `costo_orario_tecnico` decimal(15,6) NOT NULL,
  `costo_km_tecnico` decimal(15,6) NOT NULL,
  `costo_diritto_chiamata_tecnico` decimal(15,6) NOT NULL,
  PRIMARY KEY (`idfasciaoraria`,`idtipointervento`),
  KEY `idtipointervento` (`idtipointervento`),
  CONSTRAINT `in_fasceorarie_tipiintervento_ibfk_1` FOREIGN KEY (`idfasciaoraria`) REFERENCES `in_fasceorarie` (`id`),
  CONSTRAINT `in_fasceorarie_tipiintervento_ibfk_2` FOREIGN KEY (`idtipointervento`) REFERENCES `in_tipiintervento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_fasceorarie_tipiintervento`
--

LOCK TABLES `in_fasceorarie_tipiintervento` WRITE;
/*!40000 ALTER TABLE `in_fasceorarie_tipiintervento` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_fasceorarie_tipiintervento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_interventi`
--

DROP TABLE IF EXISTS `in_interventi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_interventi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idintervento` varchar(25) NOT NULL,
  `data_richiesta` datetime DEFAULT NULL,
  `richiesta` text,
  `descrizione` text,
  `km` decimal(7,2) NOT NULL,
  `idtipointervento` int NOT NULL,
  `nomefile` varchar(255) NOT NULL,
  `idanagrafica` int NOT NULL,
  `idreferente` int NOT NULL,
  `idagente` int NOT NULL,
  `idstatointervento` int NOT NULL,
  `informazioniaggiuntive` text,
  `prezzo_ore_unitario` decimal(15,2) NOT NULL,
  `idsede_partenza` int NOT NULL,
  `idsede_destinazione` int NOT NULL,
  `idautomezzo` int NOT NULL,
  `idclientefinale` int NOT NULL,
  `info_sede` varchar(255) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `firma_file` varchar(255) NOT NULL,
  `firma_data` datetime DEFAULT NULL,
  `firma_nome` varchar(255) NOT NULL,
  `data_invio` datetime DEFAULT NULL,
  `data_scadenza` datetime DEFAULT NULL,
  `sconto_globale` decimal(12,4) NOT NULL,
  `tipo_sconto_globale` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `codice_cig` varchar(15) DEFAULT NULL,
  `codice_cup` varchar(15) DEFAULT NULL,
  `id_documento_fe` varchar(20) DEFAULT NULL,
  `num_item` varchar(15) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id_segment` int NOT NULL,
  PRIMARY KEY (`idintervento`),
  UNIQUE KEY `id` (`id`),
  KEY `in_interventi_ibfk_1` (`idanagrafica`),
  KEY `in_interventi_ibfk_2` (`idtipointervento`),
  KEY `primary_key` (`id`),
  KEY `idstatointervento` (`idstatointervento`),
  CONSTRAINT `in_interventi_ibfk_1` FOREIGN KEY (`idtipointervento`) REFERENCES `in_tipiintervento` (`id`),
  CONSTRAINT `in_interventi_ibfk_2` FOREIGN KEY (`idstatointervento`) REFERENCES `in_statiintervento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_interventi`
--

LOCK TABLES `in_interventi` WRITE;
/*!40000 ALTER TABLE `in_interventi` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_interventi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_interventi_tags`
--

DROP TABLE IF EXISTS `in_interventi_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_interventi_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_intervento` int NOT NULL,
  `id_tag` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_interventi_tags`
--

LOCK TABLES `in_interventi_tags` WRITE;
/*!40000 ALTER TABLE `in_interventi_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_interventi_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_interventi_tecnici`
--

DROP TABLE IF EXISTS `in_interventi_tecnici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_interventi_tecnici` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idintervento` varchar(25) NOT NULL,
  `idtipointervento` int NOT NULL,
  `idtecnico` int NOT NULL,
  `orario_inizio` datetime NOT NULL,
  `orario_fine` datetime NOT NULL,
  `ore` decimal(12,6) NOT NULL,
  `km` decimal(12,6) NOT NULL,
  `prezzo_ore_unitario` decimal(15,6) NOT NULL,
  `prezzo_km_unitario` decimal(15,6) NOT NULL,
  `prezzo_ore_consuntivo` decimal(15,6) NOT NULL,
  `prezzo_km_consuntivo` decimal(15,6) NOT NULL,
  `prezzo_dirittochiamata` decimal(15,6) NOT NULL,
  `prezzo_ore_unitario_tecnico` decimal(15,6) NOT NULL,
  `prezzo_km_unitario_tecnico` decimal(15,6) NOT NULL,
  `prezzo_ore_consuntivo_tecnico` decimal(15,6) NOT NULL,
  `prezzo_km_consuntivo_tecnico` decimal(15,6) NOT NULL,
  `prezzo_dirittochiamata_tecnico` decimal(15,6) NOT NULL,
  `uid` int DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `sconto` decimal(17,8) NOT NULL,
  `sconto_unitario` decimal(17,8) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `scontokm` decimal(17,8) NOT NULL,
  `scontokm_unitario` decimal(17,8) NOT NULL,
  `tipo_scontokm` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `in_interventi_tecnici_ibfk_1` (`idintervento`),
  KEY `in_interventi_tecnici_ibfk_2` (`idtecnico`),
  KEY `idtipointervento` (`idtipointervento`),
  CONSTRAINT `in_interventi_tecnici_ibfk_1` FOREIGN KEY (`idtipointervento`) REFERENCES `in_tipiintervento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_interventi_tecnici`
--

LOCK TABLES `in_interventi_tecnici` WRITE;
/*!40000 ALTER TABLE `in_interventi_tecnici` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_interventi_tecnici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_interventi_tecnici_assegnati`
--

DROP TABLE IF EXISTS `in_interventi_tecnici_assegnati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_interventi_tecnici_assegnati` (
  `id_intervento` int NOT NULL,
  `id_tecnico` int NOT NULL,
  KEY `id_intervento` (`id_intervento`),
  KEY `id_tecnico` (`id_tecnico`),
  CONSTRAINT `in_interventi_tecnici_assegnati_ibfk_1` FOREIGN KEY (`id_intervento`) REFERENCES `in_interventi` (`id`) ON DELETE CASCADE,
  CONSTRAINT `in_interventi_tecnici_assegnati_ibfk_2` FOREIGN KEY (`id_tecnico`) REFERENCES `an_anagrafiche` (`idanagrafica`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_interventi_tecnici_assegnati`
--

LOCK TABLES `in_interventi_tecnici_assegnati` WRITE;
/*!40000 ALTER TABLE `in_interventi_tecnici_assegnati` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_interventi_tecnici_assegnati` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_righe_interventi`
--

DROP TABLE IF EXISTS `in_righe_interventi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_righe_interventi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` text,
  `qta` float(12,4) NOT NULL,
  `qta_evasa` decimal(15,6) NOT NULL,
  `costo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `iva_unitaria` decimal(17,8) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `provvigione` decimal(15,6) NOT NULL,
  `provvigione_unitaria` decimal(15,6) NOT NULL,
  `provvigione_percentuale` decimal(15,6) NOT NULL,
  `tipo_provvigione` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `um` varchar(20) DEFAULT NULL,
  `abilita_serial` tinyint(1) NOT NULL DEFAULT '0',
  `idiva` int NOT NULL,
  `desc_iva` varchar(255) NOT NULL,
  `iva` decimal(15,6) NOT NULL,
  `idintervento` int DEFAULT NULL,
  `idarticolo` int DEFAULT NULL,
  `is_descrizione` tinyint(1) NOT NULL,
  `is_sconto` tinyint(1) NOT NULL DEFAULT '0',
  `sconto` decimal(17,8) NOT NULL,
  `sconto_unitario` decimal(17,8) NOT NULL,
  `sconto_iva_unitario` decimal(17,8) NOT NULL,
  `sconto_unitario_ivato` decimal(17,8) NOT NULL,
  `sconto_percentuale` decimal(17,8) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `note` text,
  `idimpianto` int DEFAULT NULL,
  `old_id` int DEFAULT NULL,
  `original_id` int DEFAULT NULL,
  `original_type` varchar(255) DEFAULT NULL,
  `original_document_id` int DEFAULT NULL,
  `original_document_type` varchar(255) DEFAULT NULL,
  `id_dettaglio_fornitore` int DEFAULT NULL,
  `idsede_partenza` int NOT NULL,
  `order` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idintervento` (`idintervento`),
  KEY `idarticolo` (`idarticolo`),
  KEY `id_dettaglio_fornitore` (`id_dettaglio_fornitore`),
  CONSTRAINT `in_righe_interventi_ibfk_1` FOREIGN KEY (`idintervento`) REFERENCES `in_interventi` (`id`) ON DELETE CASCADE,
  CONSTRAINT `in_righe_interventi_ibfk_2` FOREIGN KEY (`idarticolo`) REFERENCES `mg_articoli` (`id`),
  CONSTRAINT `in_righe_interventi_ibfk_3` FOREIGN KEY (`id_dettaglio_fornitore`) REFERENCES `mg_fornitore_articolo` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_righe_interventi`
--

LOCK TABLES `in_righe_interventi` WRITE;
/*!40000 ALTER TABLE `in_righe_interventi` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_righe_interventi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_righe_tipiinterventi`
--

DROP TABLE IF EXISTS `in_righe_tipiinterventi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_righe_tipiinterventi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_tipointervento` varchar(25) NOT NULL,
  `descrizione` varchar(255) DEFAULT NULL,
  `qta` decimal(12,4) NOT NULL,
  `um` varchar(25) DEFAULT NULL,
  `prezzo_acquisto` decimal(15,6) NOT NULL,
  `prezzo_vendita` decimal(15,6) NOT NULL,
  `idiva` int NOT NULL,
  `subtotale` decimal(15,6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_righe_tipiinterventi`
--

LOCK TABLES `in_righe_tipiinterventi` WRITE;
/*!40000 ALTER TABLE `in_righe_tipiinterventi` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_righe_tipiinterventi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_statiintervento`
--

DROP TABLE IF EXISTS `in_statiintervento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_statiintervento` (
  `codice` varchar(25) NOT NULL,
  `colore` varchar(7) NOT NULL DEFAULT '#FFFFFF',
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  `is_bloccato` tinyint(1) NOT NULL,
  `is_fatturabile` tinyint(1) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `notifica` tinyint(1) NOT NULL DEFAULT '0',
  `notifica_cliente` tinyint NOT NULL,
  `notifica_tecnico_sessione` tinyint NOT NULL,
  `notifica_tecnico_assegnato` tinyint NOT NULL,
  `id_email` int DEFAULT NULL,
  `destinatari` varchar(255) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `id_email` (`id_email`),
  CONSTRAINT `in_statiintervento_ibfk_1` FOREIGN KEY (`id_email`) REFERENCES `em_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_statiintervento`
--

LOCK TABLES `in_statiintervento` WRITE;
/*!40000 ALTER TABLE `in_statiintervento` DISABLE KEYS */;
INSERT INTO `in_statiintervento` VALUES ('FAT','#98fb98',0,1,0,NULL,0,0,0,0,12,NULL,2),('OK','#d8bfd8',0,1,1,NULL,0,0,0,0,12,NULL,3),('WIP','#99e6ff',0,0,0,NULL,0,0,0,0,12,NULL,4);
/*!40000 ALTER TABLE `in_statiintervento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_statiintervento_lang`
--

DROP TABLE IF EXISTS `in_statiintervento_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_statiintervento_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `in_statiintervento_lang_ibfk_1` (`id_record`),
  KEY `in_statiintervento_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `in_statiintervento_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `in_statiintervento` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `in_statiintervento_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_statiintervento_lang`
--

LOCK TABLES `in_statiintervento_lang` WRITE;
/*!40000 ALTER TABLE `in_statiintervento_lang` DISABLE KEYS */;
INSERT INTO `in_statiintervento_lang` VALUES (1,1,2,'Fatturato','Fatturato'),(2,1,3,'Completato','Completato'),(3,1,4,'Programmato','Programmato');
/*!40000 ALTER TABLE `in_statiintervento_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_tags`
--

DROP TABLE IF EXISTS `in_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_tags`
--

LOCK TABLES `in_tags` WRITE;
/*!40000 ALTER TABLE `in_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_tariffe`
--

DROP TABLE IF EXISTS `in_tariffe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_tariffe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idtecnico` int NOT NULL,
  `idtipointervento` int NOT NULL,
  `costo_ore` decimal(15,6) NOT NULL,
  `costo_km` decimal(15,6) NOT NULL,
  `costo_dirittochiamata` decimal(15,6) NOT NULL,
  `costo_ore_tecnico` decimal(15,6) NOT NULL,
  `costo_km_tecnico` decimal(15,6) NOT NULL,
  `costo_dirittochiamata_tecnico` decimal(15,6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idtipointervento` (`idtipointervento`),
  CONSTRAINT `in_tariffe_ibfk_1` FOREIGN KEY (`idtipointervento`) REFERENCES `in_tipiintervento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_tariffe`
--

LOCK TABLES `in_tariffe` WRITE;
/*!40000 ALTER TABLE `in_tariffe` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_tariffe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_tipiintervento`
--

DROP TABLE IF EXISTS `in_tipiintervento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_tipiintervento` (
  `codice` varchar(25) NOT NULL,
  `costo_orario` decimal(15,6) NOT NULL,
  `costo_km` decimal(15,6) NOT NULL,
  `costo_diritto_chiamata` decimal(15,6) NOT NULL,
  `costo_orario_tecnico` decimal(15,6) NOT NULL,
  `costo_km_tecnico` decimal(15,6) NOT NULL,
  `costo_diritto_chiamata_tecnico` decimal(15,6) NOT NULL,
  `calcola_km` tinyint NOT NULL,
  `tempo_standard` decimal(10,2) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `non_conteggiare` tinyint NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_tipiintervento`
--

LOCK TABLES `in_tipiintervento` WRITE;
/*!40000 ALTER TABLE `in_tipiintervento` DISABLE KEYS */;
INSERT INTO `in_tipiintervento` VALUES ('GEN',30.000000,0.500000,0.000000,0.000000,0.000000,0.000000,1,1.00,NULL,1,0,''),('ODS',0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,1,1.00,NULL,2,0,'');
/*!40000 ALTER TABLE `in_tipiintervento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_tipiintervento_lang`
--

DROP TABLE IF EXISTS `in_tipiintervento_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_tipiintervento_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `in_tipiintervento_lang_ibfk_1` (`id_record`),
  KEY `in_tipiintervento_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `in_tipiintervento_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `in_tipiintervento` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `in_tipiintervento_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_tipiintervento_lang`
--

LOCK TABLES `in_tipiintervento_lang` WRITE;
/*!40000 ALTER TABLE `in_tipiintervento_lang` DISABLE KEYS */;
INSERT INTO `in_tipiintervento_lang` VALUES (1,1,1,'Generico','Generico'),(2,1,2,'Ordine di servizio','Ordine di servizio');
/*!40000 ALTER TABLE `in_tipiintervento_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_articoli`
--

DROP TABLE IF EXISTS `mg_articoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_articoli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codice` varchar(255) NOT NULL,
  `descrizione` text NOT NULL,
  `um` varchar(20) NOT NULL,
  `abilita_serial` tinyint(1) NOT NULL DEFAULT '0',
  `immagine` varchar(255) DEFAULT NULL,
  `note` varchar(1000) NOT NULL,
  `qta` decimal(15,6) NOT NULL,
  `qta_multipla` decimal(15,6) NOT NULL DEFAULT '0.000000',
  `ubicazione` varchar(255) NOT NULL,
  `prezzo_acquisto` decimal(15,6) NOT NULL,
  `coefficiente` decimal(15,6) NOT NULL,
  `prezzo_vendita` decimal(15,6) NOT NULL,
  `prezzo_vendita_ivato` decimal(15,6) NOT NULL,
  `minimo_vendita` decimal(15,6) NOT NULL,
  `minimo_vendita_ivato` decimal(15,6) NOT NULL,
  `idiva_vendita` int DEFAULT NULL,
  `gg_garanzia` int NOT NULL,
  `peso_lordo` decimal(12,6) NOT NULL,
  `volume` decimal(12,6) NOT NULL,
  `componente_filename` varchar(255) NOT NULL,
  `contenuto` text,
  `attivo` tinyint(1) NOT NULL,
  `id_categoria` int DEFAULT NULL,
  `id_sottocategoria` int DEFAULT NULL,
  `servizio` tinyint(1) NOT NULL,
  `idconto_vendita` int DEFAULT NULL,
  `idconto_acquisto` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `id_fornitore` int DEFAULT NULL,
  `um_secondaria` varchar(255) DEFAULT NULL,
  `fattore_um_secondaria` decimal(19,10) DEFAULT NULL,
  `id_combinazione` int DEFAULT NULL,
  `id_marca` int DEFAULT NULL,
  `id_modello` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_combinazione` (`id_combinazione`),
  CONSTRAINT `mg_articoli_ibfk_1` FOREIGN KEY (`id_combinazione`) REFERENCES `mg_combinazioni` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_articoli`
--

LOCK TABLES `mg_articoli` WRITE;
/*!40000 ALTER TABLE `mg_articoli` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_articoli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_articoli_automezzi`
--

DROP TABLE IF EXISTS `mg_articoli_automezzi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_articoli_automezzi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idarticolo` int NOT NULL,
  `idautomezzo` int NOT NULL,
  `qta` decimal(12,4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_articoli_automezzi`
--

LOCK TABLES `mg_articoli_automezzi` WRITE;
/*!40000 ALTER TABLE `mg_articoli_automezzi` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_articoli_automezzi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_articoli_lang`
--

DROP TABLE IF EXISTS `mg_articoli_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_articoli_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mg_articoli_lang_ibfk_1` (`id_record`),
  KEY `mg_articoli_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `mg_articoli_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `mg_articoli` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `mg_articoli_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_articoli_lang`
--

LOCK TABLES `mg_articoli_lang` WRITE;
/*!40000 ALTER TABLE `mg_articoli_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_articoli_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_articolo_attributo`
--

DROP TABLE IF EXISTS `mg_articolo_attributo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_articolo_attributo` (
  `id_articolo` int NOT NULL,
  `id_valore` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_articolo`,`id_valore`),
  KEY `id_valore` (`id_valore`),
  CONSTRAINT `mg_articolo_attributo_ibfk_1` FOREIGN KEY (`id_articolo`) REFERENCES `mg_articoli` (`id`),
  CONSTRAINT `mg_articolo_attributo_ibfk_2` FOREIGN KEY (`id_valore`) REFERENCES `mg_valori_attributi` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_articolo_attributo`
--

LOCK TABLES `mg_articolo_attributo` WRITE;
/*!40000 ALTER TABLE `mg_articolo_attributo` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_articolo_attributo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_attributi`
--

DROP TABLE IF EXISTS `mg_attributi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_attributi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ordine` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_attributi`
--

LOCK TABLES `mg_attributi` WRITE;
/*!40000 ALTER TABLE `mg_attributi` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_attributi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_attributi_lang`
--

DROP TABLE IF EXISTS `mg_attributi_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_attributi_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mg_attributi_lang_ibfk_1` (`id_record`),
  KEY `mg_attributi_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `mg_attributi_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `mg_attributi` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `mg_attributi_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_attributi_lang`
--

LOCK TABLES `mg_attributi_lang` WRITE;
/*!40000 ALTER TABLE `mg_attributi_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_attributi_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_attributo_combinazione`
--

DROP TABLE IF EXISTS `mg_attributo_combinazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_attributo_combinazione` (
  `id_combinazione` int NOT NULL,
  `id_attributo` int NOT NULL,
  `order` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_attributo`,`id_combinazione`),
  KEY `id_combinazione` (`id_combinazione`),
  CONSTRAINT `mg_attributo_combinazione_ibfk_1` FOREIGN KEY (`id_attributo`) REFERENCES `mg_attributi` (`id`),
  CONSTRAINT `mg_attributo_combinazione_ibfk_2` FOREIGN KEY (`id_combinazione`) REFERENCES `mg_combinazioni` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_attributo_combinazione`
--

LOCK TABLES `mg_attributo_combinazione` WRITE;
/*!40000 ALTER TABLE `mg_attributo_combinazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_attributo_combinazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_causali_movimenti`
--

DROP TABLE IF EXISTS `mg_causali_movimenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_causali_movimenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_movimento` enum('carico','scarico','spostamento') NOT NULL DEFAULT 'spostamento',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_causali_movimenti`
--

LOCK TABLES `mg_causali_movimenti` WRITE;
/*!40000 ALTER TABLE `mg_causali_movimenti` DISABLE KEYS */;
INSERT INTO `mg_causali_movimenti` VALUES (1,'carico'),(2,'scarico'),(3,'spostamento');
/*!40000 ALTER TABLE `mg_causali_movimenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_causali_movimenti_lang`
--

DROP TABLE IF EXISTS `mg_causali_movimenti_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_causali_movimenti_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mg_causali_movimenti_lang_ibfk_1` (`id_record`),
  KEY `mg_causali_movimenti_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `mg_causali_movimenti_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `mg_causali_movimenti` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `mg_causali_movimenti_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_causali_movimenti_lang`
--

LOCK TABLES `mg_causali_movimenti_lang` WRITE;
/*!40000 ALTER TABLE `mg_causali_movimenti_lang` DISABLE KEYS */;
INSERT INTO `mg_causali_movimenti_lang` VALUES (1,1,1,'Carico','Carico','Carico manuale'),(2,1,2,'Scarico','Scarico','Scarico manuale'),(3,1,3,'Spostamento','Spostamento','Spostamento manuale');
/*!40000 ALTER TABLE `mg_causali_movimenti_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_combinazioni`
--

DROP TABLE IF EXISTS `mg_combinazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_combinazioni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codice` varchar(255) NOT NULL,
  `id_categoria` int DEFAULT NULL,
  `id_sottocategoria` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_sottocategoria` (`id_sottocategoria`),
  CONSTRAINT `mg_combinazioni_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `zz_categorie` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mg_combinazioni_ibfk_2` FOREIGN KEY (`id_sottocategoria`) REFERENCES `zz_categorie` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_combinazioni`
--

LOCK TABLES `mg_combinazioni` WRITE;
/*!40000 ALTER TABLE `mg_combinazioni` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_combinazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_combinazioni_lang`
--

DROP TABLE IF EXISTS `mg_combinazioni_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_combinazioni_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mg_combinazioni_lang_ibfk_1` (`id_record`),
  KEY `mg_combinazioni_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `mg_combinazioni_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `mg_combinazioni` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `mg_combinazioni_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_combinazioni_lang`
--

LOCK TABLES `mg_combinazioni_lang` WRITE;
/*!40000 ALTER TABLE `mg_combinazioni_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_combinazioni_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_fornitore_articolo`
--

DROP TABLE IF EXISTS `mg_fornitore_articolo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_fornitore_articolo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_articolo` int NOT NULL,
  `id_fornitore` int NOT NULL,
  `codice_fornitore` varchar(255) NOT NULL,
  `barcode_fornitore` varchar(255) NOT NULL,
  `descrizione` varchar(255) NOT NULL,
  `prezzo_acquisto` decimal(15,6) NOT NULL,
  `qta_minima` decimal(15,6) NOT NULL,
  `giorni_consegna` int NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_articolo` (`id_articolo`),
  KEY `id_fornitore` (`id_fornitore`),
  CONSTRAINT `mg_fornitore_articolo_ibfk_1` FOREIGN KEY (`id_articolo`) REFERENCES `mg_articoli` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mg_fornitore_articolo_ibfk_2` FOREIGN KEY (`id_fornitore`) REFERENCES `an_anagrafiche` (`idanagrafica`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_fornitore_articolo`
--

LOCK TABLES `mg_fornitore_articolo` WRITE;
/*!40000 ALTER TABLE `mg_fornitore_articolo` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_fornitore_articolo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_listini`
--

DROP TABLE IF EXISTS `mg_listini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_listini` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `data_attivazione` date DEFAULT NULL,
  `data_scadenza_predefinita` date DEFAULT NULL,
  `is_sempre_visibile` tinyint(1) NOT NULL,
  `attivo` tinyint(1) NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_listini`
--

LOCK TABLES `mg_listini` WRITE;
/*!40000 ALTER TABLE `mg_listini` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_listini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_listini_articoli`
--

DROP TABLE IF EXISTS `mg_listini_articoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_listini_articoli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_listino` int NOT NULL,
  `id_articolo` int NOT NULL,
  `data_scadenza` date DEFAULT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `sconto_percentuale` decimal(15,6) NOT NULL,
  `dir` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_listini_articoli`
--

LOCK TABLES `mg_listini_articoli` WRITE;
/*!40000 ALTER TABLE `mg_listini_articoli` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_listini_articoli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_movimenti`
--

DROP TABLE IF EXISTS `mg_movimenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_movimenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idarticolo` int NOT NULL,
  `qta` decimal(15,6) NOT NULL,
  `movimento` varchar(255) NOT NULL,
  `data` date DEFAULT NULL,
  `manuale` tinyint(1) NOT NULL,
  `idintervento` int DEFAULT NULL,
  `idddt` int NOT NULL,
  `iddocumento` int NOT NULL,
  `idautomezzo` int NOT NULL,
  `idsede` int NOT NULL,
  `reference_id` int DEFAULT NULL,
  `reference_type` varchar(255) DEFAULT NULL,
  `idutente` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idintervento` (`idintervento`),
  KEY `idarticolo` (`idarticolo`),
  CONSTRAINT `mg_movimenti_ibfk_1` FOREIGN KEY (`idintervento`) REFERENCES `in_interventi` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_movimenti`
--

LOCK TABLES `mg_movimenti` WRITE;
/*!40000 ALTER TABLE `mg_movimenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_movimenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_piani_sconto`
--

DROP TABLE IF EXISTS `mg_piani_sconto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_piani_sconto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `prc_guadagno` decimal(5,2) NOT NULL,
  `note` varchar(1000) NOT NULL,
  `prc_combinato` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_piani_sconto`
--

LOCK TABLES `mg_piani_sconto` WRITE;
/*!40000 ALTER TABLE `mg_piani_sconto` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_piani_sconto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_prezzi_articoli`
--

DROP TABLE IF EXISTS `mg_prezzi_articoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_prezzi_articoli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_articolo` int NOT NULL,
  `id_anagrafica` int DEFAULT NULL,
  `minimo` decimal(15,6) DEFAULT NULL,
  `massimo` decimal(15,6) DEFAULT NULL,
  `sconto_percentuale` decimal(15,6) NOT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `dir` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_articolo` (`id_articolo`),
  KEY `id_anagrafica` (`id_anagrafica`),
  CONSTRAINT `mg_prezzi_articoli_ibfk_1` FOREIGN KEY (`id_articolo`) REFERENCES `mg_articoli` (`id`),
  CONSTRAINT `mg_prezzi_articoli_ibfk_2` FOREIGN KEY (`id_anagrafica`) REFERENCES `an_anagrafiche` (`idanagrafica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_prezzi_articoli`
--

LOCK TABLES `mg_prezzi_articoli` WRITE;
/*!40000 ALTER TABLE `mg_prezzi_articoli` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_prezzi_articoli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_prodotti`
--

DROP TABLE IF EXISTS `mg_prodotti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_prodotti` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `id_articolo` int DEFAULT NULL,
  `lotto` varchar(50) DEFAULT NULL,
  `serial` varchar(50) DEFAULT NULL,
  `altro` varchar(50) DEFAULT NULL,
  `data` datetime NOT NULL,
  `id_riga_documento` int DEFAULT NULL,
  `id_riga_ordine` int DEFAULT NULL,
  `id_riga_ddt` int DEFAULT NULL,
  `id_riga_intervento` int DEFAULT NULL,
  `id_riga_contratto` int DEFAULT NULL,
  `dir` enum('entrata','uscita') DEFAULT 'uscita',
  PRIMARY KEY (`id`),
  KEY `id_riga_documento` (`id_riga_documento`),
  KEY `id_riga_ordine` (`id_riga_ordine`),
  KEY `id_riga_ddt` (`id_riga_ddt`),
  KEY `id_articolo` (`id_articolo`),
  KEY `id_riga_intervento` (`id_riga_intervento`),
  KEY `id_riga_contratto` (`id_riga_contratto`),
  CONSTRAINT `mg_prodotti_ibfk_1` FOREIGN KEY (`id_riga_documento`) REFERENCES `co_righe_documenti` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mg_prodotti_ibfk_2` FOREIGN KEY (`id_riga_ordine`) REFERENCES `or_righe_ordini` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mg_prodotti_ibfk_3` FOREIGN KEY (`id_riga_ddt`) REFERENCES `dt_righe_ddt` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mg_prodotti_ibfk_5` FOREIGN KEY (`id_articolo`) REFERENCES `mg_articoli` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mg_prodotti_ibfk_6` FOREIGN KEY (`id_riga_intervento`) REFERENCES `in_righe_interventi` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mg_prodotti_ibfk_7` FOREIGN KEY (`id_riga_contratto`) REFERENCES `co_righe_contratti` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_prodotti`
--

LOCK TABLES `mg_prodotti` WRITE;
/*!40000 ALTER TABLE `mg_prodotti` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_prodotti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_scorte_sedi`
--

DROP TABLE IF EXISTS `mg_scorte_sedi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_scorte_sedi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_articolo` int NOT NULL,
  `id_sede` int NOT NULL,
  `threshold_qta` decimal(15,6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_scorte_sedi`
--

LOCK TABLES `mg_scorte_sedi` WRITE;
/*!40000 ALTER TABLE `mg_scorte_sedi` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_scorte_sedi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_unitamisura`
--

DROP TABLE IF EXISTS `mg_unitamisura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_unitamisura` (
  `id` tinyint NOT NULL AUTO_INCREMENT,
  `valore` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_unitamisura`
--

LOCK TABLES `mg_unitamisura` WRITE;
/*!40000 ALTER TABLE `mg_unitamisura` DISABLE KEYS */;
INSERT INTO `mg_unitamisura` VALUES (1,'nr'),(2,'kg'),(3,'pz'),(4,'litri'),(5,'ore');
/*!40000 ALTER TABLE `mg_unitamisura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_valori_attributi`
--

DROP TABLE IF EXISTS `mg_valori_attributi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_valori_attributi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_attributo` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_attributo` (`id_attributo`),
  CONSTRAINT `mg_valori_attributi_ibfk_1` FOREIGN KEY (`id_attributo`) REFERENCES `mg_attributi` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_valori_attributi`
--

LOCK TABLES `mg_valori_attributi` WRITE;
/*!40000 ALTER TABLE `mg_valori_attributi` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_valori_attributi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_componenti`
--

DROP TABLE IF EXISTS `my_componenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_componenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_impianto` int NOT NULL,
  `id_articolo` int NOT NULL,
  `pre_id_articolo` int NOT NULL,
  `note` text,
  `data_registrazione` date DEFAULT NULL,
  `data_installazione` date DEFAULT NULL,
  `data_rimozione` date DEFAULT NULL,
  `id_componente_vecchio` int DEFAULT NULL,
  `id_intervento` int DEFAULT NULL,
  `id_sostituzione` int DEFAULT NULL,
  `data_sostituzione` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_intervento` (`id_intervento`),
  KEY `id_sostituzione` (`id_sostituzione`),
  KEY `id_impianto` (`id_impianto`),
  KEY `id_articolo` (`id_articolo`),
  CONSTRAINT `my_componenti_ibfk_1` FOREIGN KEY (`id_intervento`) REFERENCES `in_interventi` (`id`) ON DELETE SET NULL,
  CONSTRAINT `my_componenti_ibfk_2` FOREIGN KEY (`id_sostituzione`) REFERENCES `my_componenti` (`id`) ON DELETE SET NULL,
  CONSTRAINT `my_componenti_ibfk_3` FOREIGN KEY (`id_impianto`) REFERENCES `my_impianti` (`id`) ON DELETE CASCADE,
  CONSTRAINT `my_componenti_ibfk_4` FOREIGN KEY (`id_articolo`) REFERENCES `mg_articoli` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_componenti`
--

LOCK TABLES `my_componenti` WRITE;
/*!40000 ALTER TABLE `my_componenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_componenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_componenti_interventi`
--

DROP TABLE IF EXISTS `my_componenti_interventi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_componenti_interventi` (
  `id_intervento` int DEFAULT NULL,
  `id_componente` int NOT NULL,
  KEY `id_intervento` (`id_intervento`),
  KEY `id_componente` (`id_componente`),
  CONSTRAINT `my_componenti_interventi_ibfk_1` FOREIGN KEY (`id_intervento`) REFERENCES `in_interventi` (`id`) ON DELETE CASCADE,
  CONSTRAINT `my_componenti_interventi_ibfk_2` FOREIGN KEY (`id_componente`) REFERENCES `my_componenti` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_componenti_interventi`
--

LOCK TABLES `my_componenti_interventi` WRITE;
/*!40000 ALTER TABLE `my_componenti_interventi` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_componenti_interventi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_impianti`
--

DROP TABLE IF EXISTS `my_impianti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_impianti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `matricola` varchar(25) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descrizione` varchar(5000) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `idanagrafica` int NOT NULL,
  `id_marca` int DEFAULT NULL,
  `id_modello` int DEFAULT NULL,
  `id_categoria` int DEFAULT NULL,
  `id_sottocategoria` int DEFAULT NULL,
  `idsede` int NOT NULL,
  `data` date DEFAULT NULL,
  `idtecnico` int NOT NULL,
  `ubicazione` varchar(255) NOT NULL,
  `scala` varchar(50) NOT NULL,
  `piano` varchar(50) NOT NULL,
  `occupante` varchar(255) NOT NULL,
  `proprietario` varchar(255) NOT NULL,
  `palazzo` varchar(255) NOT NULL,
  `interno` varchar(255) NOT NULL,
  `immagine` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_categoria` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_impianti`
--

LOCK TABLES `my_impianti` WRITE;
/*!40000 ALTER TABLE `my_impianti` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_impianti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_impianti_contratti`
--

DROP TABLE IF EXISTS `my_impianti_contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_impianti_contratti` (
  `idcontratto` varchar(25) NOT NULL,
  `idimpianto` int DEFAULT NULL,
  KEY `idimpianto` (`idimpianto`),
  CONSTRAINT `my_impianti_contratti_ibfk_1` FOREIGN KEY (`idimpianto`) REFERENCES `my_impianti` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_impianti_contratti`
--

LOCK TABLES `my_impianti_contratti` WRITE;
/*!40000 ALTER TABLE `my_impianti_contratti` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_impianti_contratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_impianti_interventi`
--

DROP TABLE IF EXISTS `my_impianti_interventi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_impianti_interventi` (
  `idintervento` int DEFAULT NULL,
  `idimpianto` int DEFAULT NULL,
  `note` text NOT NULL,
  KEY `idintervento` (`idintervento`),
  KEY `idimpianto` (`idimpianto`),
  CONSTRAINT `my_impianti_interventi_ibfk_1` FOREIGN KEY (`idintervento`) REFERENCES `in_interventi` (`id`) ON DELETE CASCADE,
  CONSTRAINT `my_impianti_interventi_ibfk_2` FOREIGN KEY (`idimpianto`) REFERENCES `my_impianti` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_impianti_interventi`
--

LOCK TABLES `my_impianti_interventi` WRITE;
/*!40000 ALTER TABLE `my_impianti_interventi` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_impianti_interventi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_impianto_componenti`
--

DROP TABLE IF EXISTS `my_impianto_componenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_impianto_componenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idsostituto` int DEFAULT NULL,
  `idintervento` int DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `data` date DEFAULT NULL,
  `data_sostituzione` date DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `contenuto` text,
  `idimpianto` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idintervento` (`idintervento`),
  KEY `idimpianto` (`idimpianto`),
  KEY `idsostituto` (`idsostituto`),
  CONSTRAINT `my_impianto_componenti_ibfk_1` FOREIGN KEY (`idintervento`) REFERENCES `in_interventi` (`id`) ON DELETE CASCADE,
  CONSTRAINT `my_impianto_componenti_ibfk_2` FOREIGN KEY (`idimpianto`) REFERENCES `my_impianti` (`id`) ON DELETE CASCADE,
  CONSTRAINT `my_impianto_componenti_ibfk_3` FOREIGN KEY (`idsostituto`) REFERENCES `my_impianto_componenti` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_impianto_componenti`
--

LOCK TABLES `my_impianto_componenti` WRITE;
/*!40000 ALTER TABLE `my_impianto_componenti` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_impianto_componenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `or_ordini`
--

DROP TABLE IF EXISTS `or_ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `or_ordini` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(100) NOT NULL,
  `numero_esterno` varchar(100) NOT NULL,
  `data` date DEFAULT NULL,
  `idagente` int NOT NULL,
  `idanagrafica` int NOT NULL,
  `idreferente` int DEFAULT NULL,
  `idsede_destinazione` int NOT NULL,
  `idsede_partenza` int NOT NULL,
  `idtipoordine` tinyint NOT NULL,
  `idstatoordine` tinyint NOT NULL,
  `idpagamento` int NOT NULL,
  `id_banca_azienda` int DEFAULT NULL,
  `id_banca_controparte` int NOT NULL,
  `idconto` int NOT NULL,
  `idrivalsainps` int NOT NULL,
  `idritenutaacconto` int NOT NULL,
  `rivalsainps` decimal(15,6) NOT NULL,
  `iva_rivalsainps` decimal(15,6) NOT NULL,
  `ritenutaacconto` decimal(15,6) NOT NULL,
  `bollo` decimal(10,2) NOT NULL,
  `note` varchar(255) NOT NULL,
  `condizioni_fornitura` text,
  `note_aggiuntive` text NOT NULL,
  `codice_cig` varchar(15) DEFAULT NULL,
  `codice_cup` varchar(15) DEFAULT NULL,
  `id_documento_fe` varchar(20) DEFAULT NULL,
  `num_item` varchar(15) DEFAULT NULL,
  `data_cliente` date DEFAULT NULL,
  `numero_cliente` varchar(255) DEFAULT NULL,
  `sconto_finale` decimal(17,8) NOT NULL,
  `sconto_finale_percentuale` decimal(17,8) NOT NULL,
  `codice_commessa` varchar(100) DEFAULT NULL,
  `idspedizione` tinyint DEFAULT NULL,
  `idporto` tinyint DEFAULT NULL,
  `idvettore` int DEFAULT NULL,
  `id_segment` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `or_ordini`
--

LOCK TABLES `or_ordini` WRITE;
/*!40000 ALTER TABLE `or_ordini` DISABLE KEYS */;
/*!40000 ALTER TABLE `or_ordini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `or_righe_ordini`
--

DROP TABLE IF EXISTS `or_righe_ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `or_righe_ordini` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_evasione` date DEFAULT NULL,
  `ora_evasione` time DEFAULT NULL,
  `idordine` int NOT NULL,
  `idarticolo` int DEFAULT NULL,
  `idpreventivo` int NOT NULL,
  `is_descrizione` tinyint(1) NOT NULL,
  `is_sconto` tinyint(1) NOT NULL DEFAULT '0',
  `idiva` int NOT NULL,
  `desc_iva` varchar(255) NOT NULL,
  `idagente` int NOT NULL,
  `iva` decimal(15,6) NOT NULL,
  `iva_indetraibile` decimal(15,6) NOT NULL,
  `descrizione` text,
  `subtotale` decimal(15,6) NOT NULL,
  `sconto` decimal(15,6) NOT NULL,
  `sconto_unitario` decimal(15,6) NOT NULL,
  `sconto_percentuale` decimal(15,6) NOT NULL,
  `sconto_iva_unitario` decimal(15,6) NOT NULL,
  `sconto_unitario_ivato` decimal(15,6) NOT NULL,
  `tipo_sconto` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `note` text,
  `um` varchar(20) DEFAULT NULL,
  `abilita_serial` tinyint(1) NOT NULL DEFAULT '0',
  `qta` decimal(15,6) NOT NULL,
  `costo_unitario` decimal(15,6) NOT NULL,
  `prezzo_unitario` decimal(15,6) NOT NULL,
  `iva_unitaria` decimal(17,8) NOT NULL,
  `prezzo_unitario_ivato` decimal(15,6) NOT NULL,
  `provvigione` decimal(15,6) NOT NULL,
  `provvigione_unitaria` decimal(15,6) NOT NULL,
  `provvigione_percentuale` decimal(15,6) NOT NULL,
  `tipo_provvigione` enum('UNT','PRC') NOT NULL DEFAULT 'UNT',
  `qta_evasa` decimal(15,6) NOT NULL,
  `order` int NOT NULL,
  `original_id` int DEFAULT NULL,
  `original_type` varchar(255) DEFAULT NULL,
  `original_document_id` int DEFAULT NULL,
  `original_document_type` varchar(255) DEFAULT NULL,
  `id_dettaglio_fornitore` int DEFAULT NULL,
  `confermato` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_dettaglio_fornitore` (`id_dettaglio_fornitore`),
  CONSTRAINT `or_righe_ordini_ibfk_1` FOREIGN KEY (`id_dettaglio_fornitore`) REFERENCES `mg_fornitore_articolo` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `or_righe_ordini`
--

LOCK TABLES `or_righe_ordini` WRITE;
/*!40000 ALTER TABLE `or_righe_ordini` DISABLE KEYS */;
/*!40000 ALTER TABLE `or_righe_ordini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `or_statiordine`
--

DROP TABLE IF EXISTS `or_statiordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `or_statiordine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `icona` varchar(100) NOT NULL,
  `colore` varchar(7) NOT NULL,
  `impegnato` tinyint(1) NOT NULL DEFAULT '0',
  `is_bloccato` tinyint(1) NOT NULL DEFAULT '0',
  `is_fatturabile` tinyint(1) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `or_statiordine`
--

LOCK TABLES `or_statiordine` WRITE;
/*!40000 ALTER TABLE `or_statiordine` DISABLE KEYS */;
INSERT INTO `or_statiordine` VALUES (1,'fa fa-file-text-o text-muted','#ffef99',0,0,0,NULL,0),(2,'fa fa-truck text-success','#99ffff',1,1,1,NULL,0),(3,'fa fa-gear text-warning','#FFDF80',1,1,1,NULL,0),(4,'fa fa-file-text-o text-warning','#b4ff99',1,1,1,NULL,0),(5,'fa fa-file-text-o text-success','#98fb98',1,1,0,NULL,0),(6,'fa fa-clock-o text-warning','#f9f5be',0,0,0,NULL,0),(7,'fa fa-thumbs-up text-success','#99E6FF',1,1,1,NULL,0),(8,'fa fa-thumbs-down text-danger','#e5e4e2',0,1,0,NULL,0);
/*!40000 ALTER TABLE `or_statiordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `or_statiordine_lang`
--

DROP TABLE IF EXISTS `or_statiordine_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `or_statiordine_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `or_statiordine_lang_ibfk_1` (`id_record`),
  KEY `or_statiordine_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `or_statiordine_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `or_statiordine` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `or_statiordine_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `or_statiordine_lang`
--

LOCK TABLES `or_statiordine_lang` WRITE;
/*!40000 ALTER TABLE `or_statiordine_lang` DISABLE KEYS */;
INSERT INTO `or_statiordine_lang` VALUES (1,1,1,'Bozza','Bozza'),(2,1,2,'Evaso','Evaso'),(3,1,3,'Parzialmente evaso','Parzialmente evaso'),(4,1,4,'Parzialmente fatturato','Parzialmente fatturato'),(5,1,5,'Fatturato','Fatturato'),(6,1,6,'In attesa di conferma','In attesa di conferma'),(7,1,7,'Accettato','Accettato'),(8,1,8,'Annullato','Annullato');
/*!40000 ALTER TABLE `or_statiordine_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `or_tipiordine`
--

DROP TABLE IF EXISTS `or_tipiordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `or_tipiordine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dir` enum('entrata','uscita') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `or_tipiordine`
--

LOCK TABLES `or_tipiordine` WRITE;
/*!40000 ALTER TABLE `or_tipiordine` DISABLE KEYS */;
INSERT INTO `or_tipiordine` VALUES (1,'uscita'),(2,'entrata');
/*!40000 ALTER TABLE `or_tipiordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `or_tipiordine_lang`
--

DROP TABLE IF EXISTS `or_tipiordine_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `or_tipiordine_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `or_tipiordine_lang_ibfk_1` (`id_record`),
  KEY `or_tipiordine_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `or_tipiordine_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `or_tipiordine` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `or_tipiordine_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `or_tipiordine_lang`
--

LOCK TABLES `or_tipiordine_lang` WRITE;
/*!40000 ALTER TABLE `or_tipiordine_lang` DISABLE KEYS */;
INSERT INTO `or_tipiordine_lang` VALUES (1,1,1,'Ordine fornitore','Ordine fornitore'),(2,1,2,'Ordine cliente','Ordine cliente');
/*!40000 ALTER TABLE `or_tipiordine_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_api_resources`
--

DROP TABLE IF EXISTS `zz_api_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_api_resources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(15) NOT NULL,
  `type` enum('create','retrieve','update','delete') DEFAULT NULL,
  `resource` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_api_resources`
--

LOCK TABLES `zz_api_resources` WRITE;
/*!40000 ALTER TABLE `zz_api_resources` DISABLE KEYS */;
INSERT INTO `zz_api_resources` VALUES (1,'v1','create','allegato','API\\Common\\Allegato',1),(2,'v1','retrieve','clienti','Modules\\Anagrafiche\\API\\v1\\Anagrafiche',1),(3,'v1','retrieve','anagrafiche','Modules\\Anagrafiche\\API\\v1\\Anagrafiche',1),(4,'v1','create','anagrafica','Modules\\Anagrafiche\\API\\v1\\Anagrafiche',1),(5,'v1','update','anagrafica','Modules\\Anagrafiche\\API\\v1\\Anagrafiche',1),(6,'v1','delete','anagrafica','Modules\\Anagrafiche\\API\\v1\\Anagrafiche',1),(7,'v1','retrieve','sedi','Modules\\Anagrafiche\\API\\v1\\Sedi',1),(8,'v1','create','movimento_articolo','Modules\\Articoli\\API\\v1\\Movimenti',1),(9,'v1','retrieve','articoli','Modules\\Articoli\\API\\v1\\Articoli',1),(10,'v1','create','login','Modules\\Utenti\\API\\v1\\Login',1),(11,'v1','create','logout','Modules\\Utenti\\API\\v1\\Logout',1),(12,'v1','retrieve','folder_size','Modules\\StatoServizi\\API\\v1\\FolderSize',1),(13,'v1','retrieve','tipi_intervento','Modules\\TipiIntervento\\API\\v1\\TipiInterventi',1),(14,'v1','retrieve','stati_intervento','Modules\\StatiIntervento\\API\\v1\\StatiInterventi',1),(15,'v1','retrieve','stati_preventivo','Modules\\StatiPreventivo\\API\\v1\\StatiPreventivi',1),(16,'v1','retrieve','stati_contratto','Modules\\StatiContratto\\API\\v1\\StatiContratti',1),(17,'v1','retrieve','tipi_intervento','Modules\\Interventi\\API\\v1\\Interventi',1),(18,'v1','retrieve','interventi','Modules\\Interventi\\API\\v1\\Interventi',1),(19,'v1','create','intervento','Modules\\Interventi\\API\\v1\\Interventi',1),(20,'v1','update','intervento','Modules\\Interventi\\API\\v1\\Interventi',1),(21,'v1','update','firma_intervento','Modules\\Interventi\\API\\v1\\Firma',1),(22,'v1','retrieve','sync','Modules\\Interventi\\API\\v1\\Sync',1),(23,'v1','update','sync','Modules\\Interventi\\API\\v1\\Sync',1),(24,'v1','retrieve','sessioni_intervento','Modules\\Interventi\\API\\v1\\Sessioni',1),(25,'v1','create','sessione','Modules\\Interventi\\API\\v1\\Sessioni',1),(26,'v1','delete','sessioni_intervento','Modules\\Interventi\\API\\v1\\Sessioni',1),(27,'v1','retrieve','righe_intervento','Modules\\Interventi\\API\\v1\\Righe',1),(28,'v1','create','riga_intervento','Modules\\Interventi\\API\\v1\\Righe',1),(29,'v1','retrieve','stampa','API\\Common\\Stampa',1),(30,'v1','retrieve','impianti','Modules\\Impianti\\API\\v1\\Impianti',1),(31,'v1','retrieve','impianti_intervento','Modules\\Interventi\\API\\v1\\Impianti',1),(32,'v1','create','impianti_intervento','Modules\\Interventi\\API\\v1\\Impianti',1),(33,'v1','retrieve','rapportino','Modules\\Interventi\\API\\v1\\Rapportino',1),(34,'v1','create','rapportino','Modules\\Interventi\\API\\v1\\Rapportino',1),(35,'app-v1','create','login','API\\App\\v1\\Login',1),(36,'app-v1','retrieve','clienti','API\\App\\v1\\Clienti',1),(37,'app-v1','retrieve','clienti-cleanup','API\\App\\v1\\Clienti',1),(38,'app-v1','retrieve','cliente','API\\App\\v1\\Clienti',1),(39,'app-v1','retrieve','tecnici','API\\App\\v1\\Tecnici',1),(40,'app-v1','retrieve','tecnici-cleanup','API\\App\\v1\\Tecnici',1),(41,'app-v1','retrieve','tecnico','API\\App\\v1\\Tecnici',1),(42,'app-v1','retrieve','sedi','API\\App\\v1\\Sedi',1),(43,'app-v1','retrieve','sedi-cleanup','API\\App\\v1\\Sedi',1),(44,'app-v1','retrieve','sede','API\\App\\v1\\Sedi',1),(45,'app-v1','retrieve','referenti','API\\App\\v1\\Referenti',1),(46,'app-v1','retrieve','referenti-cleanup','API\\App\\v1\\Referenti',1),(47,'app-v1','retrieve','referente','API\\App\\v1\\Referenti',1),(48,'app-v1','retrieve','impianti','API\\App\\v1\\Impianti',1),(49,'app-v1','retrieve','impianti-cleanup','API\\App\\v1\\Impianti',1),(50,'app-v1','retrieve','impianto','API\\App\\v1\\Impianti',1),(51,'app-v1','retrieve','stati-intervento','API\\App\\v1\\StatiIntervento',1),(52,'app-v1','retrieve','stati-intervento-cleanup','API\\App\\v1\\StatiIntervento',1),(53,'app-v1','retrieve','stato-intervento','API\\App\\v1\\StatiIntervento',1),(54,'app-v1','retrieve','tipi-intervento','API\\App\\v1\\TipiIntervento',1),(55,'app-v1','retrieve','tipi-intervento-cleanup','API\\App\\v1\\TipiIntervento',1),(56,'app-v1','retrieve','tipo-intervento','API\\App\\v1\\TipiIntervento',1),(57,'app-v1','retrieve','articoli','API\\App\\v1\\Articoli',1),(58,'app-v1','retrieve','articoli-cleanup','API\\App\\v1\\Articoli',1),(59,'app-v1','retrieve','articolo','API\\App\\v1\\Articoli',1),(60,'app-v1','retrieve','interventi','API\\App\\v1\\Interventi',1),(61,'app-v1','retrieve','interventi-cleanup','API\\App\\v1\\Interventi',1),(62,'app-v1','retrieve','intervento','API\\App\\v1\\Interventi',1),(63,'app-v1','create','intervento','API\\App\\v1\\Interventi',1),(64,'app-v1','update','intervento','API\\App\\v1\\Interventi',1),(65,'app-v1','delete','intervento','API\\App\\v1\\Interventi',1),(66,'app-v1','retrieve','sessioni','API\\App\\v1\\SessioniInterventi',1),(67,'app-v1','retrieve','sessioni-cleanup','API\\App\\v1\\SessioniInterventi',1),(68,'app-v1','retrieve','sessione','API\\App\\v1\\SessioniInterventi',1),(69,'app-v1','delete','sessione','API\\App\\v1\\SessioniInterventi',1),(70,'app-v1','create','sessione','API\\App\\v1\\SessioniInterventi',1),(71,'app-v1','update','sessione','API\\App\\v1\\SessioniInterventi',1),(72,'app-v1','retrieve','righe-interventi','API\\App\\v1\\RigheInterventi',1),(73,'app-v1','retrieve','righe-interventi-cleanup','API\\App\\v1\\RigheInterventi',1),(74,'app-v1','retrieve','riga-intervento','API\\App\\v1\\RigheInterventi',1),(75,'app-v1','create','riga-intervento','API\\App\\v1\\RigheInterventi',1),(76,'app-v1','update','riga-intervento','API\\App\\v1\\RigheInterventi',1),(77,'app-v1','delete','riga-intervento','API\\App\\v1\\RigheInterventi',1),(78,'app-v1','retrieve','aliquote-iva','API\\App\\v1\\AliquoteIva',1),(79,'app-v1','retrieve','aliquote-iva-cleanup','API\\App\\v1\\AliquoteIva',1),(80,'app-v1','retrieve','aliquota-iva','API\\App\\v1\\AliquoteIva',1),(81,'app-v1','retrieve','impostazioni','API\\App\\v1\\Impostazioni',1),(82,'app-v1','retrieve','impostazioni-cleanup','API\\App\\v1\\Impostazioni',1),(83,'app-v1','retrieve','impostazione','API\\App\\v1\\Impostazioni',1),(84,'app-v1','retrieve','contratti','API\\App\\v1\\Contratti',1),(85,'app-v1','retrieve','contratti-cleanup','API\\App\\v1\\Contratti',1),(86,'app-v1','retrieve','contratto','API\\App\\v1\\Contratti',1),(87,'app-v1','retrieve','preventivi','API\\App\\v1\\Preventivi',1),(88,'app-v1','retrieve','preventivi-cleanup','API\\App\\v1\\Preventivi',1),(89,'app-v1','retrieve','preventivo','API\\App\\v1\\Preventivi',1),(90,'app-v1','retrieve','tariffe-tecnici','API\\App\\v1\\TariffeTecnici',1),(91,'app-v1','retrieve','tariffe-tecnici-cleanup','API\\App\\v1\\TariffeTecnici',1),(92,'app-v1','retrieve','tariffa-tecnico','API\\App\\v1\\TariffeTecnici',1),(93,'app-v1','retrieve','tariffe-contratti','API\\App\\v1\\TariffeContratti',1),(94,'app-v1','retrieve','tariffe-contratti-cleanup','API\\App\\v1\\TariffeContratti',1),(95,'app-v1','retrieve','tariffa-contratto','API\\App\\v1\\TariffeContratti',1),(96,'app-v1','retrieve','allegati-interventi','API\\App\\v1\\AllegatiInterventi',1),(97,'app-v1','retrieve','allegati-interventi-cleanup','API\\App\\v1\\AllegatiInterventi',1),(98,'app-v1','retrieve','allegato-intervento','API\\App\\v1\\AllegatiInterventi',1),(99,'app-v1','create','allegato-intervento','API\\App\\v1\\AllegatiInterventi',1),(100,'app-v1','retrieve','email-rapportino','API\\App\\v1\\RapportinoIntervento',1),(101,'app-v1','create','email-rapportino','API\\App\\v1\\RapportinoIntervento',1),(102,'v1','retrieve','allegato','API\\Common\\Allegato',1),(103,'v1','retrieve','cron-logs','API\\Common\\Task',1),(104,'v1','create','cron-restart','API\\Common\\Task',1),(105,'v1','retrieve','stampa-binary','API\\Common\\Stampa',1),(106,'app-v1','create','cliente','API\\App\\v1\\Clienti',1),(107,'app-v1','update','cliente','API\\App\\v1\\Clienti',1),(108,'app-v1','delete','cliente','API\\App\\v1\\Clienti',1),(109,'app-v1','update','intervento-flash','API\\App\\v1\\Flash\\Intervento',1),(110,'v1','create','articolo','Modules\\Articoli\\API\\v1\\Articoli',1),(111,'v1','update','articolo','Modules\\Articoli\\API\\v1\\Articoli',1),(112,'app-v1','retrieve','revisione','API\\App\\v1\\Revisione',1),(113,'v1','create','articolo','Modules\\Articoli\\API\\v1\\Articoli',1),(114,'v1','update','articolo','Modules\\Articoli\\API\\v1\\Articoli',1),(115,'app-v1','retrieve','revisione','API\\App\\v1\\Revisione',1),(116,'app-v1','retrieve','sedi-azienda','API\\App\\v1\\SediAzienda',1),(117,'app-v1','retrieve','sedi-azienda-cleanup','API\\App\\v1\\SediAzienda',1),(118,'app-v1','retrieve','sede-azienda','API\\App\\v1\\SediAzienda',1),(119,'app-v1','retrieve','movimenti-manuali','API\\App\\v1\\MovimentiManuali',1),(120,'app-v1','retrieve','movimenti-manuali-cleanup','API\\App\\v1\\MovimentiManuali',1),(121,'app-v1','create','movimento-manuale','API\\App\\v1\\MovimentiManuali',1),(122,'app-v1','retrieve','controllo-clienti','API\\App\\v1\\ControlloClienti',1),(123,'app-v1','retrieve','segnalazione-bug','API\\App\\v1\\SegnalazioneBug',1),(124,'app-v1','create','segnalazione-bug','API\\App\\v1\\SegnalazioneBug',1),(125,'app-v1','retrieve','checklist','API\\App\\v1\\Checklists',1),(126,'app-v1','retrieve','checklists','API\\App\\v1\\Checklists',1),(127,'app-v1','update','checklist','API\\App\\v1\\Checklists',1),(128,'app-v1','retrieve','checklist-cleanup','API\\App\\v1\\Checklists',1),(129,'v1','retrieve','stati_ordine','Modules\\StatiOrdine\\API\\v1\\StatiOrdini',1),(130,'app-v1','retrieve','campi-personalizzati','API\\App\\v1\\CampiPersonalizzati',1),(131,'app-v1','retrieve','campi-personalizzati-cleanup','API\\App\\v1\\CampiPersonalizzati',1),(132,'app-v1','retrieve','campi-personalizzati-valori','API\\App\\v1\\CampiPersonalizzatiValori',1),(133,'app-v1','retrieve','campi-personalizzati-valori-cleanup','API\\App\\v1\\CampiPersonalizzatiValori',1),(134,'app-v1','update','campi-personalizzati-valori','API\\App\\v1\\CampiPersonalizzatiValori',1),(135,'app-v1','retrieve','pagamenti','API\\App\\v1\\Pagamenti',1),(136,'app-v1','retrieve','pagamenti-cleanup','API\\App\\v1\\Pagamenti',1),(137,'app-v1','retrieve','pagamento','API\\App\\v1\\Pagamenti',1),(138,'v1','delete','righe_ddt','Modules\\DDT\\API\\v1\\Righe',1),(139,'v1','update','righe_ddt','Modules\\DDT\\API\\v1\\Righe',1),(140,'v1','create','righe_ddt','Modules\\DDT\\API\\v1\\Righe',1),(141,'v1','retrieve','righe_ddt','Modules\\DDT\\API\\v1\\Righe',1),(142,'v1','delete','ddt','Modules\\DDT\\API\\v1\\DDTS',1),(143,'v1','update','ddt','Modules\\DDT\\API\\v1\\DDTS',1),(144,'v1','create','ddt','Modules\\DDT\\API\\v1\\DDTS',1),(145,'v1','retrieve','ddt','Modules\\DDT\\API\\v1\\DDTS',1),(146,'v1','update','riga_intervento','Modules\\Interventi\\API\\v1\\Righe',1),(147,'v1','delete','riga_intervento','Modules\\Interventi\\API\\v1\\Righe',1),(148,'v1','retrieve','pagamenti','Modules\\Pagamenti\\API\\v1\\Pagamenti',1),(149,'app-v1','retrieve','seriali-cleanup','API\\App\\v1\\Seriali',1),(150,'app-v1','retrieve','seriali','API\\App\\v1\\Seriali',1),(151,'app-v1','retrieve','seriale','API\\App\\v1\\Seriali',1);
/*!40000 ALTER TABLE `zz_api_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_cache`
--

DROP TABLE IF EXISTS `zz_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_cache` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `valid_time` varchar(255) DEFAULT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_cache`
--

LOCK TABLES `zz_cache` WRITE;
/*!40000 ALTER TABLE `zz_cache` DISABLE KEYS */;
INSERT INTO `zz_cache` VALUES (1,'Ricevute Elettroniche','','1 day',NULL),(2,'Ricevute Elettroniche importate','','1 day',NULL),(3,'Fatture Elettroniche','','1 day',NULL),(4,'Ultima versione di OpenSTAManager disponibile','','7 day',NULL),(5,'Ultima esecuzione del cron','','1 month',NULL),(6,'ID del cron','','1 month',NULL),(7,'Cron in esecuzione','','1 month',NULL),(8,'Disabilita cron','','1 month',NULL),(9,'Spazio utilizzato','','60 minute','2025-07-29 12:38:24'),(10,'Informazioni su Services','','1 day',NULL),(11,'Informazioni su spazio FE','','1 day','2025-07-29 12:38:24');
/*!40000 ALTER TABLE `zz_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_cache_lang`
--

DROP TABLE IF EXISTS `zz_cache_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_cache_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_cache_lang_ibfk_1` (`id_record`),
  KEY `zz_cache_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_cache_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_cache` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_cache_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_cache_lang`
--

LOCK TABLES `zz_cache_lang` WRITE;
/*!40000 ALTER TABLE `zz_cache_lang` DISABLE KEYS */;
INSERT INTO `zz_cache_lang` VALUES (1,1,1,'Ricevute Elettroniche','Ricevute Elettroniche'),(2,1,2,'Ricevute Elettroniche importate','Ricevute Elettroniche importate'),(3,1,3,'Fatture Elettroniche','Fatture Elettroniche'),(4,1,4,'Ultima versione di OpenSTAManager disponibile','Ultima versione di OpenSTAManager disponibile'),(5,1,5,'Ultima esecuzione del cron','Ultima esecuzione del cron'),(6,1,6,'ID del cron','ID del cron'),(7,1,7,'Cron in esecuzione','Cron in esecuzione'),(8,1,8,'Disabilita cron','Disabilita cron'),(9,1,9,'Spazio utilizzato','Spazio utilizzato'),(10,1,10,'Informazioni su Services','Informazioni su Services'),(11,1,11,'Informazioni su spazio FE','Informazioni su spazio FE');
/*!40000 ALTER TABLE `zz_cache_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_categorie`
--

DROP TABLE IF EXISTS `zz_categorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `colore` varchar(255) DEFAULT NULL,
  `parent` int DEFAULT NULL,
  `is_articolo` tinyint(1) NOT NULL DEFAULT '1',
  `is_impianto` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `zz_categorie_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `zz_categorie` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_categorie`
--

LOCK TABLES `zz_categorie` WRITE;
/*!40000 ALTER TABLE `zz_categorie` DISABLE KEYS */;
INSERT INTO `zz_categorie` VALUES (1,'#ffffff',NULL,1,0);
/*!40000 ALTER TABLE `zz_categorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_categorie_lang`
--

DROP TABLE IF EXISTS `zz_categorie_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_categorie_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mg_categorie_lang_ibfk_1` (`id_record`),
  KEY `mg_categorie_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_categorie_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_categorie` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_categorie_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_categorie_lang`
--

LOCK TABLES `zz_categorie_lang` WRITE;
/*!40000 ALTER TABLE `zz_categorie_lang` DISABLE KEYS */;
INSERT INTO `zz_categorie_lang` VALUES (1,1,1,'Componenti','Componenti','');
/*!40000 ALTER TABLE `zz_categorie_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_checklist_items`
--

DROP TABLE IF EXISTS `zz_checklist_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_checklist_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_checklist` int DEFAULT NULL,
  `content` text,
  `id_parent` int DEFAULT NULL,
  `is_titolo` tinyint(1) NOT NULL,
  `order` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_checklist` (`id_checklist`),
  KEY `id_parent` (`id_parent`),
  CONSTRAINT `zz_checklist_items_ibfk_1` FOREIGN KEY (`id_checklist`) REFERENCES `zz_checklists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zz_checklist_items_ibfk_2` FOREIGN KEY (`id_parent`) REFERENCES `zz_checklist_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_checklist_items`
--

LOCK TABLES `zz_checklist_items` WRITE;
/*!40000 ALTER TABLE `zz_checklist_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_checklist_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_checklists`
--

DROP TABLE IF EXISTS `zz_checklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_checklists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `id_module` int DEFAULT NULL,
  `id_plugin` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_module` (`id_module`),
  KEY `id_plugin` (`id_plugin`),
  CONSTRAINT `zz_checklists_ibfk_1` FOREIGN KEY (`id_module`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zz_checklists_ibfk_2` FOREIGN KEY (`id_plugin`) REFERENCES `zz_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_checklists`
--

LOCK TABLES `zz_checklists` WRITE;
/*!40000 ALTER TABLE `zz_checklists` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_checklists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_currencies`
--

DROP TABLE IF EXISTS `zz_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_currencies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_currencies`
--

LOCK TABLES `zz_currencies` WRITE;
/*!40000 ALTER TABLE `zz_currencies` DISABLE KEYS */;
INSERT INTO `zz_currencies` VALUES (1,'Euro','&euro;'),(2,'Sterlina','&pound;'),(3,'Dollaro','&dollar;');
/*!40000 ALTER TABLE `zz_currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_currencies_lang`
--

DROP TABLE IF EXISTS `zz_currencies_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_currencies_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_currencies_lang_ibfk_1` (`id_record`),
  KEY `zz_currencies_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_currencies_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_currencies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_currencies_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_currencies_lang`
--

LOCK TABLES `zz_currencies_lang` WRITE;
/*!40000 ALTER TABLE `zz_currencies_lang` DISABLE KEYS */;
INSERT INTO `zz_currencies_lang` VALUES (1,1,1,'Euro','Euro'),(2,1,2,'Sterlina','Sterlina'),(3,1,3,'Dollaro','Dollaro');
/*!40000 ALTER TABLE `zz_currencies_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_default_description`
--

DROP TABLE IF EXISTS `zz_default_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_default_description` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `descrizione` text NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_default_description`
--

LOCK TABLES `zz_default_description` WRITE;
/*!40000 ALTER TABLE `zz_default_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_default_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_default_description_module`
--

DROP TABLE IF EXISTS `zz_default_description_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_default_description_module` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_description` int NOT NULL,
  `id_module` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_default_description_module`
--

LOCK TABLES `zz_default_description_module` WRITE;
/*!40000 ALTER TABLE `zz_default_description_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_default_description_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_events`
--

DROP TABLE IF EXISTS `zz_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `data` date NOT NULL,
  `id_nazione` int NOT NULL,
  `id_regione` int DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT '0',
  `is_bank_holiday` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_nazione` (`id_nazione`),
  CONSTRAINT `zz_events_ibfk_1` FOREIGN KEY (`id_nazione`) REFERENCES `an_nazioni` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_events`
--

LOCK TABLES `zz_events` WRITE;
/*!40000 ALTER TABLE `zz_events` DISABLE KEYS */;
INSERT INTO `zz_events` VALUES (1,'Natale','2022-12-25',82,NULL,1,1);
/*!40000 ALTER TABLE `zz_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_field_record`
--

DROP TABLE IF EXISTS `zz_field_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_field_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_field` int NOT NULL,
  `id_record` int NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_field` (`id_field`),
  CONSTRAINT `zz_field_record_ibfk_1` FOREIGN KEY (`id_field`) REFERENCES `zz_fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_field_record`
--

LOCK TABLES `zz_field_record` WRITE;
/*!40000 ALTER TABLE `zz_field_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_field_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_fields`
--

DROP TABLE IF EXISTS `zz_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_module` int DEFAULT NULL,
  `id_plugin` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `html_name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `options` text,
  `order` int NOT NULL,
  `on_add` tinyint(1) NOT NULL,
  `top` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_module` (`id_module`),
  KEY `id_plugin` (`id_plugin`),
  CONSTRAINT `zz_fields_ibfk_1` FOREIGN KEY (`id_module`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zz_fields_ibfk_2` FOREIGN KEY (`id_plugin`) REFERENCES `zz_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_fields`
--

LOCK TABLES `zz_fields` WRITE;
/*!40000 ALTER TABLE `zz_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_files`
--

DROP TABLE IF EXISTS `zz_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `original` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `id_category` int DEFAULT NULL,
  `size` int DEFAULT NULL,
  `id_module` int DEFAULT NULL,
  `id_plugin` int DEFAULT NULL,
  `id_record` int NOT NULL,
  `id_adapter` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_record` (`id_record`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_files`
--

LOCK TABLES `zz_files` WRITE;
/*!40000 ALTER TABLE `zz_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_files_categories`
--

DROP TABLE IF EXISTS `zz_files_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_files_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_files_categories`
--

LOCK TABLES `zz_files_categories` WRITE;
/*!40000 ALTER TABLE `zz_files_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_files_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_files_print`
--

DROP TABLE IF EXISTS `zz_files_print`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_files_print` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_print` int NOT NULL,
  `id_file` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_files_print`
--

LOCK TABLES `zz_files_print` WRITE;
/*!40000 ALTER TABLE `zz_files_print` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_files_print` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_group_module`
--

DROP TABLE IF EXISTS `zz_group_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_group_module` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idgruppo` int NOT NULL,
  `idmodule` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `clause` varchar(5000) NOT NULL,
  `position` enum('WHR','HVN') NOT NULL DEFAULT 'WHR',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idmodule` (`idmodule`),
  KEY `idgruppo` (`idgruppo`),
  CONSTRAINT `zz_group_module_ibfk_1` FOREIGN KEY (`idmodule`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zz_group_module_ibfk_2` FOREIGN KEY (`idgruppo`) REFERENCES `zz_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_group_module`
--

LOCK TABLES `zz_group_module` WRITE;
/*!40000 ALTER TABLE `zz_group_module` DISABLE KEYS */;
INSERT INTO `zz_group_module` VALUES (1,2,3,'Mostra al tecnico solo le sue attivit├á programmate e assegnate','in_interventi.id IN (SELECT idintervento FROM in_interventi_tecnici WHERE idintervento=in_interventi.id AND idtecnico=|id_anagrafica| UNION SELECT id_intervento FROM in_interventi_tecnici_assegnati WHERE id_intervento=in_interventi.id AND id_tecnico=|id_anagrafica|)','WHR',1,1),(2,2,2,'Mostra ai tecnici solo le anagrafiche in cui sono coinvolti con delle attivit├á',' an_anagrafiche.idanagrafica IN (SELECT idanagrafica FROM in_interventi_tecnici INNER JOIN in_interventi ON in_interventi_tecnici.idintervento=in_interventi.id WHERE in_interventi.idanagrafica=an_anagrafiche.idanagrafica AND idtecnico=|id_anagrafica|)','WHR',0,1),(3,3,2,'Mostra agli agenti solo le anagrafiche di cui sono agenti',' an_anagrafiche.idagente=|id_anagrafica|','WHR',1,1),(4,4,2,'Mostra ai clienti solo la propria anagrafica',' an_anagrafiche.idanagrafica=|id_anagrafica|','WHR',1,1),(5,4,3,'Mostra al cliente solo le attivit├á in cui ├¿ impostato come \'Cliente\'',' in_interventi.idanagrafica=|id_anagrafica|','WHR',1,1),(6,4,14,'Mostra ai clienti solo le proprie fatture',' co_documenti.idanagrafica=|id_anagrafica|','WHR',1,1),(7,3,16,'Mostra agli agenti solo la prima nota delle anagrafiche di cui sono agenti',' idagente=|id_anagrafica|','WHR',1,1),(8,4,30,'Mostra ai clienti solo i propri impianti',' my_impianti.idanagrafica=|id_anagrafica|','WHR',1,1),(9,4,26,'Mostra ddt di vendita ai clienti coinvolti','dt_ddt.idanagrafica=|id_anagrafica|','WHR',0,1),(10,4,24,'Mostra ordini cliente ai clienti coinvolti','or_ordini.idanagrafica=|id_anagrafica|','WHR',0,1),(11,4,14,'Mostra ai clienti solo le proprie fatture','co_documenti.idanagrafica=|id_anagrafica|','WHR',0,1),(12,2,3,'Mostra al tecnico solo le attivit├á a cui ├¿ stato assegnato','in_interventi.id IN (SELECT id_intervento FROM in_interventi_tecnici_assegnati WHERE id_intervento=in_interventi.id AND id_tecnico=|id_anagrafica|)','WHR',0,1),(13,4,31,'Mostra i contratti ai clienti coinvolti','co_contratti.idanagrafica=|id_anagrafica|','WHR',1,1),(14,2,3,'Mostra al tecnico solo le attivit├á a cui ├¿ stato assegnato','in_interventi.id IN (SELECT id_intervento FROM in_interventi_tecnici_assegnati WHERE id_intervento=in_interventi.id AND id_tecnico=|id_anagrafica|)','WHR',0,1),(15,4,31,'Mostra i contratti ai clienti coinvolti','co_contratti.idanagrafica=|id_anagrafica|','WHR',1,1),(16,2,30,'Mostra impianti ai tecnici assegnati','my_impianti.idtecnico=|id_anagrafica|','WHR',0,1),(17,4,13,'Mostra agli agenti solo le anagrafiche di cui sono agenti','co_preventivi.idanagrafica=|id_anagrafica|','WHR',1,0),(18,3,13,'Mostra agli agenti solo i preventivi dei clienti dei quali si ├¿ agenti','an_anagrafiche.idagente=|id_anagrafica|','WHR',1,0),(19,3,13,'Mostra agli agenti solo i preventivi di cui sono agenti','co_preventivi.idagente=|id_anagrafica|','WHR',1,0),(20,4,3,'Mostra al cliente solo le attivit├á in cui ├¿ impostato come \'Per conto di\'','in_interventi.idclientefinale=|id_anagrafica|','WHR',0,1),(21,4,3,'Mostra al cliente tutte le attivit├á in cui ├¿ coinvolto','(in_interventi.idanagrafica=|id_anagrafica| OR in_interventi.idclientefinale=|id_anagrafica|)','WHR',0,1);
/*!40000 ALTER TABLE `zz_group_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_group_module_lang`
--

DROP TABLE IF EXISTS `zz_group_module_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_group_module_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_group_module_lang_ibfk_1` (`id_record`),
  KEY `zz_group_module_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_group_module_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_group_module` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_group_module_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_group_module_lang`
--

LOCK TABLES `zz_group_module_lang` WRITE;
/*!40000 ALTER TABLE `zz_group_module_lang` DISABLE KEYS */;
INSERT INTO `zz_group_module_lang` VALUES (1,1,1,'Mostra al tecnico solo le sue attivit├á programmate e assegnate','Mostra al tecnico solo le sue attivit├á programmate e assegnate'),(2,1,2,'Mostra ai tecnici solo le anagrafiche in cui sono coinvolti con delle attivit├á','Mostra ai tecnici solo le anagrafiche in cui sono coinvolti con delle attivit├á'),(3,1,3,'Mostra agli agenti solo le anagrafiche di cui sono agenti','Mostra agli agenti solo le anagrafiche di cui sono agenti'),(4,1,4,'Mostra ai clienti solo la propria anagrafica','Mostra ai clienti solo la propria anagrafica'),(5,1,5,'Mostra al cliente solo le attivit├á in cui ├¿ impostato come \'Cliente\'','Mostra al cliente solo le attivit├á in cui ├¿ impostato come \'Cliente\''),(6,1,6,'Mostra ai clienti solo le proprie fatture','Mostra ai clienti solo le proprie fatture'),(7,1,7,'Mostra agli agenti solo la prima nota delle anagrafiche di cui sono agenti','Mostra agli agenti solo la prima nota delle anagrafiche di cui sono agenti'),(8,1,8,'Mostra ai clienti solo i propri impianti','Mostra ai clienti solo i propri impianti'),(9,1,9,'Mostra ddt di vendita ai clienti coinvolti','Mostra ddt di vendita ai clienti coinvolti'),(10,1,10,'Mostra ordini cliente ai clienti coinvolti','Mostra ordini cliente ai clienti coinvolti'),(11,1,11,'Mostra ai clienti solo le proprie fatture','Mostra ai clienti solo le proprie fatture'),(12,1,12,'Mostra al tecnico solo le attivit├á a cui ├¿ stato assegnato','Mostra al tecnico solo le attivit├á a cui ├¿ stato assegnato'),(13,1,13,'Mostra i contratti ai clienti coinvolti','Mostra i contratti ai clienti coinvolti'),(14,1,14,'Mostra al tecnico solo le attivit├á a cui ├¿ stato assegnato','Mostra al tecnico solo le attivit├á a cui ├¿ stato assegnato'),(15,1,15,'Mostra i contratti ai clienti coinvolti','Mostra i contratti ai clienti coinvolti'),(16,1,16,'Mostra impianti ai tecnici assegnati','Mostra impianti ai tecnici assegnati'),(17,1,17,'Mostra agli agenti solo le anagrafiche di cui sono agenti','Mostra agli agenti solo le anagrafiche di cui sono agenti'),(18,1,18,'Mostra agli agenti solo i preventivi dei clienti dei quali si ├¿ agenti','Mostra agli agenti solo i preventivi dei clienti dei quali si ├¿ agenti'),(19,1,19,'Mostra agli agenti solo i preventivi di cui sono agenti','Mostra agli agenti solo i preventivi di cui sono agenti'),(20,1,20,'Mostra al cliente solo le attivit├á in cui ├¿ impostato come \'Per conto di\'','Mostra al cliente solo le attivit├á in cui ├¿ impostato come \'Per conto di\''),(21,1,21,'Mostra al cliente tutte le attivit├á in cui ├¿ coinvolto','Mostra al cliente tutte le attivit├á in cui ├¿ coinvolto');
/*!40000 ALTER TABLE `zz_group_module_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_group_segment`
--

DROP TABLE IF EXISTS `zz_group_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_group_segment` (
  `id_gruppo` int NOT NULL,
  `id_segment` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_group_segment`
--

LOCK TABLES `zz_group_segment` WRITE;
/*!40000 ALTER TABLE `zz_group_segment` DISABLE KEYS */;
INSERT INTO `zz_group_segment` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,29),(1,30),(1,31);
/*!40000 ALTER TABLE `zz_group_segment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_group_view`
--

DROP TABLE IF EXISTS `zz_group_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_group_view` (
  `id_gruppo` int NOT NULL,
  `id_vista` int NOT NULL,
  PRIMARY KEY (`id_gruppo`,`id_vista`),
  KEY `id_vista` (`id_vista`),
  CONSTRAINT `zz_group_view_ibfk_1` FOREIGN KEY (`id_gruppo`) REFERENCES `zz_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zz_group_view_ibfk_2` FOREIGN KEY (`id_vista`) REFERENCES `zz_views` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_group_view`
--

LOCK TABLES `zz_group_view` WRITE;
/*!40000 ALTER TABLE `zz_group_view` DISABLE KEYS */;
INSERT INTO `zz_group_view` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,29),(1,30),(1,31),(1,32),(1,33),(1,34),(1,35),(1,36),(1,37),(1,38),(1,39),(1,40),(1,41),(1,42),(1,43),(1,44),(1,45),(1,46),(1,47),(1,48),(1,49),(1,50),(1,51),(1,52),(1,53),(1,54),(1,55),(1,56),(1,57),(1,58),(1,59),(1,60),(1,61),(1,62),(1,63),(1,64),(1,65),(1,66),(1,67),(1,68),(1,69),(1,70),(1,71),(1,72),(1,73),(1,74),(1,75),(1,76),(1,77),(1,78),(1,79),(1,80),(1,81),(1,82),(1,83),(1,84),(1,85),(1,86),(1,87),(1,88),(1,89),(1,90),(1,91),(1,92),(1,93),(1,94),(1,95),(1,96),(1,97),(1,98),(1,99),(1,100),(1,101),(1,102),(1,103),(1,104),(1,105),(1,106),(1,107),(1,108),(1,109),(1,110),(1,111),(1,112),(1,113),(1,114),(1,115),(1,116),(1,117),(1,118),(1,119),(1,120),(1,121),(1,122),(1,123),(1,124),(1,125),(1,126),(1,127),(1,128),(1,129),(1,130),(1,131),(1,132),(1,133),(1,134),(1,138),(1,139),(1,140),(1,141),(1,142),(1,143),(1,144),(1,145),(1,146),(1,147),(1,148),(1,149),(1,150),(1,151),(1,152),(1,153),(1,154),(1,155),(1,156),(1,157),(1,158),(1,159),(1,160),(1,161),(1,162),(1,163),(1,164),(1,165),(1,166),(1,169),(1,170),(1,171),(1,172),(1,173),(1,174),(1,175),(1,176),(1,177),(1,178),(1,179),(1,180),(1,181),(1,182),(1,183),(1,184),(1,185),(1,186),(1,187),(1,188),(1,189),(1,190),(1,191),(1,192),(1,193),(1,194),(1,195),(1,196),(1,197),(1,198),(1,199),(1,200),(1,201),(1,202),(1,203),(1,204),(1,205),(1,206),(1,207),(1,208),(1,209),(1,210),(1,211),(1,212),(1,213),(1,214),(1,215),(1,216),(1,217),(1,218),(1,219),(1,220),(1,221),(1,222),(1,223),(1,224),(1,225),(1,226),(1,227),(1,228),(1,229),(1,230),(1,231),(1,232),(1,233),(1,234),(1,235),(1,236),(1,237),(1,238),(1,239),(1,240),(1,241),(1,242),(1,243),(1,244),(1,245),(1,246),(1,247),(1,248),(1,249),(1,250),(1,251),(1,252),(1,253),(1,254),(1,255),(1,256),(1,257),(1,258),(1,259),(1,260),(1,261),(1,262),(1,263),(1,264),(1,265),(1,266),(1,267),(1,268),(1,269),(1,272),(1,273),(1,274),(1,275),(1,276),(1,277),(1,278),(1,279),(1,280),(1,281),(1,282),(1,283),(1,284),(1,285),(1,286),(1,287),(1,288),(1,289),(1,290),(1,291),(1,292),(1,293),(1,294),(1,295),(1,296),(1,297),(1,298),(1,299),(1,300),(1,301),(1,302),(1,303),(1,304),(1,305),(1,306),(1,307),(1,308),(1,309),(1,310),(1,311),(1,312),(1,313),(1,314),(1,315),(1,316),(1,317),(1,318),(1,319),(1,320),(1,321),(1,322),(1,323),(1,324),(1,325),(1,326),(1,327),(1,328),(1,329),(1,330),(1,331),(1,332),(1,333),(1,334),(1,335),(1,336),(1,337),(1,338),(1,339),(1,340),(1,341),(1,342),(1,343),(1,344),(1,345),(1,346),(1,347),(1,348),(1,349),(1,350),(1,351),(1,352),(1,353),(1,354),(1,355),(1,356),(1,357),(1,358),(1,359),(1,360),(1,361),(1,362),(1,363),(1,364),(1,365),(1,366),(1,367),(1,368),(1,369),(1,370),(1,371),(1,372),(1,373),(1,374),(1,375),(1,376),(1,377),(1,378),(1,379),(1,380),(1,381),(1,382),(1,383),(1,384),(1,385),(1,386),(1,387),(1,388),(1,389),(1,390),(1,391),(1,392),(1,393),(1,394),(1,395),(1,396),(1,397),(1,398),(1,399),(1,400),(1,401),(1,402),(1,403),(1,404),(1,405),(1,406),(1,407),(1,408),(1,409),(1,410),(1,411),(1,412),(1,413),(1,414),(1,415),(1,416),(1,417),(1,418),(1,419),(1,420),(1,421),(1,422),(1,423),(1,424),(1,425),(1,426),(1,427),(1,428),(1,429),(1,430),(1,431),(1,432),(1,433),(1,434),(1,435),(1,436),(1,438),(1,439),(1,440),(1,441),(1,442),(1,443),(1,444),(1,445),(1,446),(1,447),(1,448),(1,449),(1,450),(1,451),(1,452),(1,453),(1,454),(1,455),(1,456),(1,457),(1,458),(1,459),(1,460),(1,461),(1,462),(1,465),(1,466),(1,467),(1,468),(1,469),(1,470),(1,471),(1,472),(1,473),(1,474),(1,475),(1,476),(1,477),(1,478),(1,479),(1,480),(1,481),(1,482),(1,483),(1,484),(1,485),(1,486),(1,487),(1,488),(1,489),(1,490),(1,491),(1,492),(1,493),(1,494),(1,495),(1,496),(1,497),(1,498),(1,499),(1,500),(1,501),(1,504),(1,505),(1,506),(1,507);
/*!40000 ALTER TABLE `zz_group_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_groups`
--

DROP TABLE IF EXISTS `zz_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `editable` tinyint(1) NOT NULL,
  `id_module_start` int DEFAULT NULL,
  `theme` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_groups`
--

LOCK TABLES `zz_groups` WRITE;
/*!40000 ALTER TABLE `zz_groups` DISABLE KEYS */;
INSERT INTO `zz_groups` VALUES (1,'Amministratori',0,NULL,NULL),(2,'Tecnici',0,NULL,NULL),(3,'Agenti',0,NULL,NULL),(4,'Clienti',0,NULL,NULL);
/*!40000 ALTER TABLE `zz_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_groups_lang`
--

DROP TABLE IF EXISTS `zz_groups_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_groups_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_groups_lang_ibfk_1` (`id_record`),
  KEY `zz_groups_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_groups_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_groups_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_groups_lang`
--

LOCK TABLES `zz_groups_lang` WRITE;
/*!40000 ALTER TABLE `zz_groups_lang` DISABLE KEYS */;
INSERT INTO `zz_groups_lang` VALUES (1,1,1,'Amministratori','Amministratori'),(2,1,2,'Tecnici','Tecnici'),(3,1,3,'Agenti','Agenti'),(4,1,4,'Clienti','Clienti');
/*!40000 ALTER TABLE `zz_groups_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_hooks`
--

DROP TABLE IF EXISTS `zz_hooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_hooks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `id_module` int DEFAULT NULL,
  `processing_at` timestamp NULL DEFAULT NULL,
  `processing_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_module` (`id_module`),
  CONSTRAINT `zz_hooks_ibfk_1` FOREIGN KEY (`id_module`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_hooks`
--

LOCK TABLES `zz_hooks` WRITE;
/*!40000 ALTER TABLE `zz_hooks` DISABLE KEYS */;
INSERT INTO `zz_hooks` VALUES (1,'Ricevute','Plugins\\ReceiptFE\\ReceiptHook',1,14,NULL,NULL),(2,'Fatture','Plugins\\ImportFE\\InvoiceHook',1,15,NULL,NULL),(3,'Aggiornamenti','Modules\\Aggiornamenti\\UpdateHook',1,6,NULL,NULL),(5,'Email','Modules\\Emails\\EmailHook',1,NULL,NULL,NULL),(6,'Fatture Elettroniche','Plugins\\ExportFE\\InvoiceHook',1,NULL,NULL,NULL),(7,'Spazio','Modules\\StatoServizi\\SpaceHook',1,50,NULL,NULL),(8,'Informazioni su Services','Modules\\StatoServizi\\ServicesHook',1,50,NULL,NULL),(9,'Notifiche su Ricevute FE','Plugins\\ReceiptFE\\NotificheRicevuteHook',1,14,NULL,NULL);
/*!40000 ALTER TABLE `zz_hooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_hooks_lang`
--

DROP TABLE IF EXISTS `zz_hooks_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_hooks_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_hooks_lang_ibfk_1` (`id_record`),
  KEY `zz_hooks_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_hooks_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_hooks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_hooks_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_hooks_lang`
--

LOCK TABLES `zz_hooks_lang` WRITE;
/*!40000 ALTER TABLE `zz_hooks_lang` DISABLE KEYS */;
INSERT INTO `zz_hooks_lang` VALUES (1,1,1,'Ricevute','Ricevute'),(2,1,2,'Fatture','Fatture'),(3,1,3,'Aggiornamenti','Aggiornamenti'),(4,1,5,'Email','Email'),(5,1,6,'Fatture Elettroniche','Fatture Elettroniche'),(6,1,7,'Spazio','Spazio'),(7,1,8,'Informazioni su Services','Informazioni su Services'),(8,1,9,'Notifiche su Ricevute FE','Notifiche su Ricevute FE');
/*!40000 ALTER TABLE `zz_hooks_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_imports`
--

DROP TABLE IF EXISTS `zz_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_imports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_imports`
--

LOCK TABLES `zz_imports` WRITE;
/*!40000 ALTER TABLE `zz_imports` DISABLE KEYS */;
INSERT INTO `zz_imports` VALUES (1,'Anagrafiche','Modules\\Anagrafiche\\Import\\CSV'),(2,'Articoli','Modules\\Articoli\\Import\\CSV'),(3,'Piano dei conti','Modules\\Partitario\\Import\\CSV'),(4,'Impianti','Modules\\Impianti\\Import\\CSV'),(5,'Attivit├á','Modules\\Interventi\\Import\\CSV'),(6,'Listini cliente','Modules\\ListiniCliente\\Import\\CSV');
/*!40000 ALTER TABLE `zz_imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_imports_lang`
--

DROP TABLE IF EXISTS `zz_imports_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_imports_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_imports_lang_ibfk_1` (`id_record`),
  KEY `zz_imports_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_imports_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_imports` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_imports_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_imports_lang`
--

LOCK TABLES `zz_imports_lang` WRITE;
/*!40000 ALTER TABLE `zz_imports_lang` DISABLE KEYS */;
INSERT INTO `zz_imports_lang` VALUES (1,1,1,'Anagrafiche','Anagrafiche'),(2,1,2,'Articoli','Articoli'),(3,1,3,'Piano dei conti','Piano dei conti'),(4,1,4,'Impianti','Impianti'),(5,1,5,'Attivit├á','Attivit├á'),(6,1,6,'Listini cliente','Listini cliente');
/*!40000 ALTER TABLE `zz_imports_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_langs`
--

DROP TABLE IF EXISTS `zz_langs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_langs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `iso_code` varchar(2) NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `date` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  `timestamp` varchar(100) NOT NULL,
  `decimals` varchar(1) NOT NULL,
  `thousands` varchar(1) DEFAULT NULL,
  `is_rtl` tinyint(1) NOT NULL DEFAULT '0',
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_langs`
--

LOCK TABLES `zz_langs` WRITE;
/*!40000 ALTER TABLE `zz_langs` DISABLE KEYS */;
INSERT INTO `zz_langs` VALUES (1,'Italiano (Italian)',1,'it','it_IT','d/m/Y','H:i','d/m/Y H:i',',','.',0,1),(2,'English (English)',1,'en','en_GB','m/d/Y','H:i','m/d/Y H:i','.',',',0,0);
/*!40000 ALTER TABLE `zz_langs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_logs`
--

DROP TABLE IF EXISTS `zz_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_utente` int DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `stato` varchar(50) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_logs`
--

LOCK TABLES `zz_logs` WRITE;
/*!40000 ALTER TABLE `zz_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_marche`
--

DROP TABLE IF EXISTS `zz_marche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_marche` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `parent` int NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `immagine` varchar(255) NOT NULL,
  `is_articolo` tinyint(1) NOT NULL DEFAULT '1',
  `is_impianto` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_marche`
--

LOCK TABLES `zz_marche` WRITE;
/*!40000 ALTER TABLE `zz_marche` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_marche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_modules`
--

DROP TABLE IF EXISTS `zz_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_modules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `directory` varchar(50) NOT NULL,
  `attachments_directory` varchar(255) NOT NULL DEFAULT '',
  `options` text,
  `options2` text,
  `icon` varchar(255) NOT NULL,
  `version` varchar(15) NOT NULL,
  `compatibility` varchar(1000) NOT NULL,
  `order` int NOT NULL,
  `parent` int DEFAULT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL,
  `use_notes` tinyint(1) DEFAULT '0',
  `use_checklists` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `zz_modules_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_modules`
--

LOCK TABLES `zz_modules` WRITE;
/*!40000 ALTER TABLE `zz_modules` DISABLE KEYS */;
INSERT INTO `zz_modules` VALUES (1,'Dashboard','dashboard','dashboard','custom','','nav-icon fa fa-dashboard','2.0','2.0',0,NULL,1,1,0,0),(2,'Anagrafiche','anagrafiche','anagrafiche','\nSELECT\n    |select|\nFROM\n    `an_anagrafiche`\n    LEFT JOIN `an_relazioni` ON `an_anagrafiche`.`idrelazione` = `an_relazioni`.`id`\n    LEFT JOIN `an_relazioni_lang` ON (`an_relazioni`.`id` = `an_relazioni_lang`.`id_record` AND `an_relazioni_lang`.|lang|)\n    LEFT JOIN `an_tipianagrafiche_anagrafiche` ON `an_tipianagrafiche_anagrafiche`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `an_tipianagrafiche` ON `an_tipianagrafiche`.`id` = `an_tipianagrafiche_anagrafiche`.`idtipoanagrafica`\n    LEFT JOIN `an_tipianagrafiche_lang` ON (`an_tipianagrafiche`.`id` = `an_tipianagrafiche_lang`.`id_record` AND `an_tipianagrafiche_lang`.|lang|)\n    LEFT JOIN (SELECT `idanagrafica`, GROUP_CONCAT(`nomesede` SEPARATOR \', \') AS nomi FROM `an_sedi` GROUP BY `idanagrafica`) AS sedi ON `an_anagrafiche`.`idanagrafica`= `sedi`.`idanagrafica`\n    LEFT JOIN (SELECT `idanagrafica`, GROUP_CONCAT(`nome` SEPARATOR \', \') AS nomi FROM `an_referenti` GROUP BY `idanagrafica`) AS referenti ON `an_anagrafiche`.`idanagrafica` =`referenti`.`idanagrafica`\n    LEFT JOIN (SELECT `co_pagamenti_lang`.`title`AS nome, `co_pagamenti`.`id` FROM `co_pagamenti` LEFT JOIN `co_pagamenti_lang` ON (`co_pagamenti`.`id` = `co_pagamenti_lang`.`id_record` AND `co_pagamenti_lang`.|lang|))AS pagvendita ON IF(`an_anagrafiche`.`idpagamento_vendite`>0,`an_anagrafiche`.`idpagamento_vendite`= `pagvendita`.`id`,\'\')\n    LEFT JOIN (SELECT `co_pagamenti_lang`.`title` AS nome, `co_pagamenti`.`id` FROM `co_pagamenti` LEFT JOIN `co_pagamenti_lang` ON (`co_pagamenti`.`id` = `co_pagamenti_lang`.`id_record` AND `co_pagamenti_lang`.|lang|))AS pagacquisto ON IF(`an_anagrafiche`.`idpagamento_acquisti`>0,`an_anagrafiche`.`idpagamento_acquisti`= `pagacquisto`.`id`,\'\')\n    LEFT JOIN `an_zone` ON `an_anagrafiche`.`idzona`=`an_zone`.`id`\nWHERE\n    1=1 AND `an_anagrafiche`.`deleted_at` IS NULL\nGROUP BY\n    `an_anagrafiche`.`idanagrafica`, `pagvendita`.`nome`, `pagacquisto`.`nome`\nHAVING\n    2=2\nORDER BY\n    TRIM(`ragione_sociale`)','','nav-icon fa fa-users','2.0','2.0',1,NULL,1,1,1,0),(3,'Interventi','interventi','interventi','\nSELECT\n    |select|\nFROM\n    `in_interventi`\n    LEFT JOIN `an_anagrafiche` ON `in_interventi`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `in_interventi_tecnici` ON `in_interventi_tecnici`.`idintervento` = `in_interventi`.`id`\n    LEFT JOIN (SELECT `idintervento`, SUM(`prezzo_unitario`*`qta`-`sconto`) AS `ricavo_righe`, SUM(`costo_unitario`*`qta`) AS `costo_righe` FROM `in_righe_interventi` GROUP BY `idintervento`) AS `righe` ON `righe`.`idintervento` = `in_interventi`.`id`\n    INNER JOIN `in_statiintervento` ON `in_interventi`.`idstatointervento`=`in_statiintervento`.`id`\n    LEFT JOIN `in_statiintervento_lang` ON (`in_statiintervento_lang`.`id_record` = `in_statiintervento`.`id` AND `in_statiintervento_lang`.|lang|)\n    LEFT JOIN `an_referenti` ON `in_interventi`.`idreferente` = `an_referenti`.`id`\n    LEFT JOIN (SELECT `an_sedi`.`id`, CONCAT(`an_sedi`.`nomesede`, \'<br />\',IF(`an_sedi`.`telefono`!=\'\',CONCAT(`an_sedi`.`telefono`,\'<br />\'),\'\'),IF(`an_sedi`.`cellulare`!=\'\',CONCAT(`an_sedi`.`cellulare`,\'<br />\'),\'\'),`an_sedi`.`citta`,IF(`an_sedi`.`indirizzo`!=\'\',CONCAT(\' - \',`an_sedi`.`indirizzo`),\'\')) AS `info` FROM `an_sedi`) AS `sede_destinazione` ON `sede_destinazione`.`id` = `in_interventi`.`idsede_destinazione`\n    LEFT JOIN (SELECT GROUP_CONCAT(DISTINCT `co_documenti`.`numero_esterno` SEPARATOR \', \') AS `info`, `co_righe_documenti`.`original_document_id` AS `idintervento` FROM `co_documenti` INNER JOIN `co_righe_documenti` ON `co_documenti`.`id` = `co_righe_documenti`.`iddocumento` WHERE `original_document_type` = \'Modules\\\\Interventi\\\\Intervento\' GROUP BY `idintervento`, `original_document_id`) AS `fattura` ON `fattura`.`idintervento` = `in_interventi`.`id`\n    LEFT JOIN (SELECT `in_interventi_tecnici_assegnati`.`id_intervento`, GROUP_CONCAT( DISTINCT `ragione_sociale` SEPARATOR \', \') AS `nomi` FROM `an_anagrafiche` INNER JOIN `in_interventi_tecnici_assegnati` ON `in_interventi_tecnici_assegnati`.`id_tecnico` = `an_anagrafiche`.`idanagrafica` GROUP BY `id_intervento`) AS `tecnici_assegnati` ON `in_interventi`.`id` = `tecnici_assegnati`.`id_intervento`\n    LEFT JOIN (SELECT `in_interventi_tecnici`.`idintervento`, GROUP_CONCAT( DISTINCT `ragione_sociale` SEPARATOR \', \') AS `nomi` FROM `an_anagrafiche` INNER JOIN `in_interventi_tecnici` ON `in_interventi_tecnici`.`idtecnico` = `an_anagrafiche`.`idanagrafica` GROUP BY `idintervento`) AS `tecnici` ON `in_interventi`.`id` = `tecnici`.`idintervento`\n    LEFT JOIN (SELECT COUNT(`id`) as emails, `em_emails`.`id_record` FROM `em_emails` INNER JOIN `zz_operations` ON `zz_operations`.`id_email` = `em_emails`.`id` WHERE `id_module` IN (SELECT `zz_modules`.`id` FROM `zz_modules` WHERE `name` = \'Interventi\' AND `zz_operations`.`op` = \'send-email\' GROUP BY `em_emails`.`id_record`) AND `zz_operations`.`op` = \'send-email\' GROUP BY `em_emails`.`id_record`) AS `email` ON `email`.`id_record` = `in_interventi`.`id`\n    LEFT JOIN (SELECT GROUP_CONCAT(CONCAT(`matricola`, IF(`nome` != \'\', CONCAT(\' - \', `nome`), \'\')) SEPARATOR \'<br />\') AS `descrizione`, `my_impianti_interventi`.`idintervento` FROM `my_impianti` INNER JOIN `my_impianti_interventi` ON `my_impianti`.`id` = `my_impianti_interventi`.`idimpianto` GROUP BY `my_impianti_interventi`.`idintervento`) AS `impianti` ON `impianti`.`idintervento` = `in_interventi`.`id`\n    LEFT JOIN (SELECT `co_contratti`.`id`, CONCAT(`co_contratti`.`numero`, \' del \', DATE_FORMAT(`data_bozza`, \'%d/%m/%Y\')) AS `info` FROM `co_contratti`) AS `contratto` ON `contratto`.`id` = `in_interventi`.`id_contratto`\n    LEFT JOIN (SELECT `co_preventivi`.`id`, CONCAT(`co_preventivi`.`numero`, \' del \', DATE_FORMAT(`data_bozza`, \'%d/%m/%Y\')) AS `info` FROM `co_preventivi`) AS `preventivo` ON `preventivo`.`id` = `in_interventi`.`id_preventivo`\n    LEFT JOIN (SELECT `or_ordini`.`id`, CONCAT(`or_ordini`.`numero`, \' del \', DATE_FORMAT(`data`, \'%d/%m/%Y\')) AS `info` FROM `or_ordini`) AS `ordine` ON `ordine`.`id` = `in_interventi`.`id_ordine`\n    INNER JOIN `in_tipiintervento` ON `in_interventi`.`idtipointervento` = `in_tipiintervento`.`id`\n    LEFT JOIN `in_tipiintervento_lang` ON (`in_tipiintervento_lang`.`id_record` = `in_tipiintervento`.`id` AND `in_tipiintervento_lang`.|lang|)\n    LEFT JOIN (SELECT GROUP_CONCAT(\' \', `zz_files`.`name`) as name, `zz_files`.`id_record` FROM `zz_files` INNER JOIN `zz_modules` ON `zz_files`.`id_module` = `zz_modules`.`id` LEFT JOIN `zz_modules_lang` ON (`zz_modules_lang`.`id_record` = `zz_modules`.`id` AND `zz_modules_lang`.|lang|) WHERE `zz_modules`.`name` = \'Interventi\' GROUP BY id_record) AS files ON `files`.`id_record` = `in_interventi`.`id`\n    LEFT JOIN (SELECT `in_interventi_tags`.`id_intervento`, GROUP_CONCAT( DISTINCT `name` SEPARATOR \', \') AS `nomi` FROM `in_tags` INNER JOIN `in_interventi_tags` ON `in_interventi_tags`.`id_tag` = `in_tags`.`id` GROUP BY `in_interventi_tags`.`id_intervento`) AS `tags` ON `in_interventi`.`id` = `tags`.`id_intervento`\n    LEFT JOIN `an_zone` ON `an_anagrafiche`.`idzona`=`an_zone`.`id`\nWHERE \n    1=1 |segment(`in_interventi`.`id_segment`)| |date_period(`orario_inizio`,`data_richiesta`)|\nGROUP BY \n    `in_interventi`.`id`\nHAVING \n    2=2\nORDER BY \n    IFNULL(`orario_fine`, `data_richiesta`) DESC','','nav-icon fa fa-wrench','2.0','2.0',2,NULL,1,1,1,1),(6,'Aggiornamenti','aggiornamenti','aggiornamenti','custom','','nav-icon fa fa-download','2.0','2.0',9,NULL,1,1,0,0),(7,'Backup','backups','backups','custom','','nav-icon fa fa-archive','2.0','2.0',8,NULL,1,1,0,0),(8,'Tipi di anagrafiche','tipi_anagrafiche','tipi_anagrafiche','\nSELECT\n    |select|\nFROM\n    `an_tipianagrafiche`\n    LEFT JOIN `an_tipianagrafiche_lang` ON (`an_tipianagrafiche`.`id` = `an_tipianagrafiche_lang`.`id_record` AND `an_tipianagrafiche_lang`.|lang|)\nWHERE\n    1=1\nHAVING\n    2=2','','nav-icon fa fa-circle-o','2.0','2.0',0,2,1,0,0,0),(9,'Tipi di intervento','tipi_intervento','tipi_intervento','\nSELECT\n    |select|\nFROM \n    `in_tipiintervento`\n    LEFT JOIN `in_tipiintervento_lang` ON (`in_tipiintervento_lang`.`id_record` = `in_tipiintervento`.`id` AND `in_tipiintervento_lang`.|lang|)\nWHERE \n    1=1 AND `deleted_at` IS NULL \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.0','2.0',0,3,1,1,0,0),(10,'Stati di intervento','stati_intervento','stati_intervento','\nSELECT\n    |select|\nFROM \n    `in_statiintervento`\n    LEFT JOIN `in_statiintervento_lang` ON (`in_statiintervento_lang`.`id_record` = `in_statiintervento`.`id` AND `in_statiintervento_lang`.|lang|)\nWHERE \n    1=1 AND `deleted_at` IS NULL \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.0','2.0',1,3,1,1,0,0),(12,'Contabilit├á','contabilita','contabilita','menu','','nav-icon fa fa-eur','2.0','2.0',5,NULL,1,1,0,0),(13,'Preventivi','preventivi','preventivi','\nSELECT\n    |select| \nFROM\n    `co_preventivi`\n    LEFT JOIN `an_anagrafiche` ON `co_preventivi`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `co_statipreventivi` ON `co_preventivi`.`idstato` = `co_statipreventivi`.`id`\n    LEFT JOIN `co_statipreventivi_lang` ON (`co_statipreventivi`.`id` = `co_statipreventivi_lang`.`id_record` AND co_statipreventivi_lang.|lang|)\n    LEFT JOIN (SELECT `idpreventivo`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM(`subtotale` - `sconto` + `iva`) AS `totale` FROM `co_righe_preventivi` GROUP BY `idpreventivo`) AS righe ON `co_preventivi`.`id` = `righe`.`idpreventivo`\n    LEFT JOIN (SELECT `an_anagrafiche`.`idanagrafica`, `an_anagrafiche`.`ragione_sociale` AS nome FROM `an_anagrafiche`)AS agente ON `agente`.`idanagrafica`=`co_preventivi`.`idagente`\n    LEFT JOIN (SELECT GROUP_CONCAT(DISTINCT `co_documenti`.`numero_esterno` SEPARATOR \', \') AS `info`, `co_righe_documenti`.`original_document_id` AS `idpreventivo` FROM `co_documenti` INNER JOIN `co_righe_documenti` ON `co_documenti`.`id` = `co_righe_documenti`.`iddocumento` WHERE `original_document_type`=\'ModulesPreventiviPreventivo\' GROUP BY `idpreventivo`, `original_document_id`) AS `fattura` ON `fattura`.`idpreventivo` = `co_preventivi`.`id`\n    LEFT JOIN (SELECT COUNT(id) as emails, em_emails.id_record FROM em_emails INNER JOIN zz_operations ON zz_operations.id_email = em_emails.id WHERE id_module IN(SELECT `id` FROM `zz_modules` WHERE `name` = \'Preventivi\') AND `zz_operations`.`op` = \'send-email\' GROUP BY em_emails.id_record) AS `email` ON `email`.`id_record` = `co_preventivi`.`id`\nWHERE \n    1=1 |segment(`co_preventivi`.`id_segment`)| |date_period(custom,\'|period_start|\' >= `data_bozza` AND \'|period_start|\' <= `data_conclusione`,\'|period_end|\' >= `data_bozza` AND \'|period_end|\' <= `data_conclusione`,`data_bozza` >= \'|period_start|\' AND `data_bozza` <= \'|period_end|\',`data_conclusione` >= \'|period_start|\' AND `data_conclusione` <= \'|period_end|\',`data_bozza` >= \'|period_start|\' AND `data_conclusione` = NULL)| AND `default_revision` = 1\nGROUP BY \n    `co_preventivi`.`id`, `fattura`.`info`\nHAVING \n    2=2\nORDER BY \n    `co_preventivi`.`data_bozza` DESC, numero ASC','','nav-icon fa fa-circle-o','2.0','2.0',0,33,1,1,1,0),(14,'Fatture di vendita','fatture','fatture/vendite','\nSELECT\n    |select|\nFROM\n    `co_documenti`\n    LEFT JOIN (SELECT SUM(`totale`) AS `totale`, `iddocumento` FROM `co_movimenti`  WHERE `totale` > 0 AND `primanota` = 1 GROUP BY `iddocumento`) AS `primanota` ON `primanota`.`iddocumento` = `co_documenti`.`id`\n    LEFT JOIN `an_anagrafiche` ON `co_documenti`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `co_tipidocumento` ON `co_documenti`.`idtipodocumento` = `co_tipidocumento`.`id`\n    LEFT JOIN `co_tipidocumento_lang` ON (`co_tipidocumento`.`id` = `co_tipidocumento_lang`.`id_record` AND co_tipidocumento_lang.|lang|)\n    LEFT JOIN (SELECT `iddocumento`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM((`subtotale` - `sconto` + `rivalsainps`) * `co_iva`.`percentuale` / 100) AS `iva` FROM `co_righe_documenti` LEFT JOIN `co_iva` ON `co_iva`.`id` = `co_righe_documenti`.`idiva` GROUP BY `iddocumento`) AS `righe` ON `co_documenti`.`id` = `righe`.`iddocumento`\n    LEFT JOIN (SELECT `co_banche`.`id`, CONCAT(`co_banche`.`nome`, \' - \', `co_banche`.`iban`) AS `descrizione` FROM `co_banche` GROUP BY `co_banche`.`id`) AS `banche` ON `banche`.`id` =`co_documenti`.`id_banca_azienda`\n	LEFT JOIN `co_statidocumento` ON `co_documenti`.`idstatodocumento` = `co_statidocumento`.`id`\n    LEFT JOIN `co_statidocumento_lang` ON (`co_statidocumento`.`id` = `co_statidocumento_lang`.`id_record` AND `co_statidocumento_lang`.|lang|)\n    LEFT JOIN `fe_stati_documento` ON `co_documenti`.`codice_stato_fe` = `fe_stati_documento`.`codice`\n    LEFT JOIN `fe_stati_documento_lang` ON (`fe_stati_documento`.`codice` = `fe_stati_documento_lang`.`id_record` AND `fe_stati_documento_lang`.|lang|)\n    LEFT JOIN `co_ritenuta_contributi` ON `co_documenti`.`id_ritenuta_contributi` = `co_ritenuta_contributi`.`id`\n    LEFT JOIN (SELECT COUNT(id) as `emails`, `em_emails`.`id_record` FROM `em_emails` INNER JOIN `zz_operations` ON `zz_operations`.`id_email` = `em_emails`.`id` WHERE `id_module` IN(SELECT `id` FROM `zz_modules` WHERE name = \'Fatture di vendita\') AND `zz_operations`.`op` = \'send-email\' GROUP BY `em_emails`.`id_record`) AS `email` ON `email`.`id_record` = `co_documenti`.`id`\n	LEFT JOIN `co_pagamenti` ON `co_documenti`.`idpagamento` = `co_pagamenti`.`id`\n    LEFT JOIN `co_pagamenti_lang` ON (`co_pagamenti`.`id` = `co_pagamenti_lang`.`id_record` AND co_pagamenti_lang.|lang|)\n    LEFT JOIN (SELECT `numero_esterno`, `id_segment`, `idtipodocumento`, `data` FROM `co_documenti` WHERE `co_documenti`.`idtipodocumento` IN( SELECT `id` FROM `co_tipidocumento` WHERE `dir` = \'entrata\') AND `numero_esterno` != \'\'  |date_period(`co_documenti`.`data`)|   GROUP BY `id_segment`, `numero_esterno`, `idtipodocumento`HAVING COUNT(`numero_esterno`) > 1) dup ON `co_documenti`.`numero_esterno` = `dup`.`numero_esterno` AND `dup`.`id_segment` = `co_documenti`.`id_segment` AND `dup`.`idtipodocumento` = `co_documenti`.`idtipodocumento`\nWHERE\n    1=1 AND `dir` = \'entrata\' |segment(`co_documenti`.`id_segment`)| |date_period(`co_documenti`.`data`)|\nHAVING\n    2=2\nORDER BY\n    `co_documenti`.`data` DESC,\n    CAST(`co_documenti`.`numero_esterno` AS UNSIGNED) DESC','','nav-icon fa fa-circle-o','2.0','2.0',3,33,1,1,1,0),(15,'Fatture di acquisto','fatture','fatture','\nSELECT\n    |select|\nFROM\n    `co_documenti`\n    LEFT JOIN `an_anagrafiche` ON `co_documenti`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `co_tipidocumento` ON `co_documenti`.`idtipodocumento` = `co_tipidocumento`.`id`\n    LEFT JOIN `co_tipidocumento_lang` ON (`co_tipidocumento`.`id` = `co_tipidocumento_lang`.`id_record` AND `co_tipidocumento_lang`.|lang|)\n    LEFT JOIN `co_statidocumento` ON `co_documenti`.`idstatodocumento` = `co_statidocumento`.`id`\n    LEFT JOIN `co_statidocumento_lang` ON (`co_statidocumento`.`id` = `co_statidocumento_lang`.`id_record` AND `co_statidocumento_lang`.|lang|)\n    LEFT JOIN `co_ritenuta_contributi` ON `co_documenti`.`id_ritenuta_contributi` = `co_ritenuta_contributi`.`id`\n    LEFT JOIN `co_pagamenti` ON `co_documenti`.`idpagamento` = `co_pagamenti`.`id`\n    LEFT JOIN `co_pagamenti_lang` ON (`co_pagamenti`.`id` = `co_pagamenti_lang`.`id_record` AND `co_pagamenti_lang`.|lang|)\n    LEFT JOIN (SELECT `co_banche`.`id`, CONCAT(`nome`, \' - \', `iban`) AS `descrizione` FROM `co_banche`) AS `banche` ON `banche`.`id` = `co_documenti`.`id_banca_azienda`\n    LEFT JOIN (SELECT `iddocumento`, GROUP_CONCAT(`co_pianodeiconti3`.`descrizione`) AS `descrizione` FROM `co_righe_documenti` INNER JOIN `co_pianodeiconti3` ON `co_pianodeiconti3`.`id` = `co_righe_documenti`.`idconto` GROUP BY iddocumento) AS `conti` ON `conti`.`iddocumento` = `co_documenti`.`id`\n    LEFT JOIN (SELECT `iddocumento`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM(`iva`) AS `iva` FROM `co_righe_documenti` GROUP BY `iddocumento`) AS `righe` ON `co_documenti`.`id` = `righe`.`iddocumento`\n    LEFT JOIN (SELECT COUNT(`d`.`id`) AS `conteggio`, IF(`d`.`numero_esterno` = \'\', `d`.`numero`, `d`.`numero_esterno`) AS `numero_documento`, `d`.`idanagrafica` AS `anagrafica`, `d`.`id_segment`, YEAR(`d`.`data`) AS `anno` FROM `co_documenti` AS `d`\n    LEFT JOIN `co_tipidocumento` AS `d_tipo` ON `d`.`idtipodocumento` = `d_tipo`.`id` WHERE 1=1 AND `d_tipo`.`dir` = \'uscita\' AND(\'|period_start|\' <= `d`.`data` AND \'|period_end|\' >= `d`.`data` OR \'|period_start|\' <= `d`.`data_competenza` AND \'|period_end|\' >= `d`.`data_competenza`) GROUP BY `d`.`id_segment`, `numero_documento`, `d`.`idanagrafica`, YEAR(`d`.`data`)) AS `d` ON (`d`.`numero_documento` = IF(`co_documenti`.`numero_esterno` = \'\',`co_documenti`.`numero`,`co_documenti`.`numero_esterno`) AND `d`.`anagrafica` = `co_documenti`.`idanagrafica` AND `d`.`id_segment` = `co_documenti`.`id_segment` AND `d`.`anno` = YEAR(`co_documenti`.`data`))\nWHERE\n    1=1\nAND\n    `dir` = \'uscita\' |segment(`co_documenti`.`id_segment`)| |date_period(custom, \'|period_start|\' <= `co_documenti`.`data` AND \'|period_end|\' >= `co_documenti`.`data`, \'|period_start|\' <= `co_documenti`.`data_competenza` AND \'|period_end|\' >= `co_documenti`.`data_competenza` )|\nGROUP BY\n    `co_documenti`.`id`, `d`.`conteggio`\nHAVING\n    2=2\nORDER BY\n    `co_documenti`.`data` DESC,\n    CAST(IF(`co_documenti`.`numero` = \'\', `co_documenti`.`numero_esterno`, `co_documenti`.`numero`) AS UNSIGNED) DESC','','nav-icon fa fa-circle-o','2.0','2.0',4,34,1,1,1,0),(16,'Prima nota','primanota','primanota','\nSELECT\n    |select| \nFROM\n    `co_movimenti`\n    INNER JOIN `co_pianodeiconti3` ON `co_movimenti`.`idconto` = `co_pianodeiconti3`.`id`\n    LEFT JOIN `co_documenti` ON `co_documenti`.`id` = `co_movimenti`.`iddocumento`\n    LEFT JOIN `an_anagrafiche` ON `co_movimenti`.`id_anagrafica` = `an_anagrafiche`.`idanagrafica`\nWHERE\n    1=1 AND `primanota` = 1  |date_period(`co_movimenti`.`data`)|\nGROUP BY\n    `idmastrino`,\n    `primanota`,\n    `co_movimenti`.`data`,\n    `numero_esterno`,\n    `co_movimenti`.`descrizione`,\n    `an_anagrafiche`.`ragione_sociale`\nHAVING\n    2=2\nORDER BY\n    `co_movimenti`.`data` DESC','','nav-icon fa fa-circle-o','2.0','2.0',5,12,1,1,0,0),(17,'Piano dei conti','partitario','partitario','custom','','nav-icon fa fa-circle-o','2.0','2.0',6,12,1,1,0,0),(18,'Scadenzario','scadenzario','scadenzario','\nSELECT\n    |select| \nFROM \n    `co_scadenziario`\n    LEFT JOIN `co_documenti` ON `co_scadenziario`.`iddocumento` = `co_documenti`.`id`\n    LEFT JOIN `co_banche` ON `co_banche`.`id` = `co_documenti`.`id_banca_azienda`\n    LEFT JOIN `an_anagrafiche` ON `co_scadenziario`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `co_pagamenti` ON `co_documenti`.`idpagamento` = `co_pagamenti`.`id`\n    LEFT JOIN `co_pagamenti_lang` ON (`co_pagamenti_lang`.`id_record` = `co_pagamenti`.`id` AND `co_pagamenti_lang`.|lang|)\n    LEFT JOIN `co_tipidocumento` ON `co_documenti`.`idtipodocumento` = `co_tipidocumento`.`id`\n    LEFT JOIN `co_statidocumento` ON `co_documenti`.`idstatodocumento` = `co_statidocumento`.`id`\n    LEFT JOIN `co_statidocumento_lang` ON (`co_statidocumento_lang`.`id_record` = `co_statidocumento`.`id` AND `co_statidocumento_lang`.|lang|)\n    LEFT JOIN (SELECT COUNT(id_email) as emails, zz_operations.id_record FROM zz_operations WHERE id_module IN(SELECT `id` FROM `zz_modules` WHERE `name` = \'Scadenzario\') AND `zz_operations`.`op` = \'send-email\' GROUP BY zz_operations.id_record) AS `email` ON `email`.`id_record` = `co_scadenziario`.`id`\nWHERE \n    1=1 AND (`co_statidocumento`.`id` IS NULL OR `co_statidocumento`.`name` IN (\'Emessa\', \'Parzialmente pagato\', \'Pagato\')) \nHAVING\n    2=2\nORDER BY \n    `scadenza` ASC','','nav-icon fa fa-circle-o','2.0','2.0',7,12,1,1,1,0),(20,'Magazzino','magazzino','magazzino','menu','','nav-icon fa fa-truck','2.0','2.0',6,NULL,1,1,0,0),(21,'Articoli','articoli','articoli','\nSELECT\n    |select|\nFROM\n    `mg_articoli`\n    LEFT JOIN `mg_articoli_lang` ON (`mg_articoli_lang`.`id_record` = `mg_articoli`.`id` AND `mg_articoli_lang`.|lang|)\n    LEFT JOIN `an_anagrafiche` ON `mg_articoli`.`id_fornitore` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `co_iva` ON `mg_articoli`.`idiva_vendita` = `co_iva`.`id`\n    LEFT JOIN (SELECT SUM(`or_righe_ordini`.`qta` - `or_righe_ordini`.`qta_evasa`) AS qta_impegnata, `or_righe_ordini`.`idarticolo` FROM `or_righe_ordini` INNER JOIN `or_ordini` ON `or_righe_ordini`.`idordine` = `or_ordini`.`id` INNER JOIN `or_tipiordine` ON `or_ordini`.`idtipoordine` = `or_tipiordine`.`id` INNER JOIN `or_statiordine` ON `or_ordini`.`idstatoordine` = `or_statiordine`.`id` WHERE `or_tipiordine`.`dir` = \'entrata\' AND `or_righe_ordini`.`confermato` = 1 AND `or_statiordine`.`impegnato` = 1 GROUP BY `idarticolo`) a ON `a`.`idarticolo` = `mg_articoli`.`id`\n    LEFT JOIN (SELECT SUM(`or_righe_ordini`.`qta` - `or_righe_ordini`.`qta_evasa`) AS qta_ordinata, `or_righe_ordini`.`idarticolo` FROM `or_righe_ordini` INNER JOIN `or_ordini` ON `or_righe_ordini`.`idordine` = `or_ordini`.`id` INNER JOIN `or_tipiordine` ON `or_ordini`.`idtipoordine` = `or_tipiordine`.`id` INNER JOIN `or_statiordine` ON `or_ordini`.`idstatoordine` = `or_statiordine`.`id` WHERE `or_tipiordine`.`dir` = \'uscita\' AND `or_righe_ordini`.`confermato` = 1 AND `or_statiordine`.`impegnato` = 1\n    GROUP BY `idarticolo`) ordini_fornitore ON `ordini_fornitore`.`idarticolo` = `mg_articoli`.`id`\n    LEFT JOIN `zz_categorie` ON `mg_articoli`.`id_categoria` = `zz_categorie`.`id`\n    LEFT JOIN `zz_categorie_lang` ON (`zz_categorie`.`id` = `zz_categorie_lang`.`id_record` AND `zz_categorie_lang`.|lang|)\n    LEFT JOIN `zz_categorie` AS sottocategorie ON `mg_articoli`.`id_sottocategoria` = `sottocategorie`.`id`\n    LEFT JOIN `zz_categorie_lang` AS sottocategorie_lang ON (`sottocategorie`.`id` = `sottocategorie_lang`.`id_record` AND `sottocategorie_lang`.|lang|)\n    LEFT JOIN (SELECT `co_iva`.`percentuale` AS perc, `co_iva`.`id`, `zz_settings`.`nome` FROM `co_iva` INNER JOIN `zz_settings` ON `co_iva`.`id`=`zz_settings`.`valore`)AS iva ON `iva`.`nome`= \'Iva predefinita\' \n    LEFT JOIN mg_scorte_sedi ON mg_scorte_sedi.id_articolo = mg_articoli.id\n    LEFT JOIN (SELECT CASE WHEN MIN(differenza) < 0 THEN -1 WHEN MAX(threshold_qta) > 0 THEN 1 ELSE 0 END AS stato_giacenza, idarticolo FROM (SELECT SUM(mg_movimenti.qta) - COALESCE(mg_scorte_sedi.threshold_qta, 0) AS differenza, COALESCE(mg_scorte_sedi.threshold_qta, 0) as threshold_qta, mg_movimenti.idarticolo FROM mg_movimenti LEFT JOIN mg_scorte_sedi ON mg_scorte_sedi.id_sede = mg_movimenti.idsede AND mg_scorte_sedi.id_articolo = mg_movimenti.idarticolo GROUP BY mg_movimenti.idarticolo, mg_movimenti.idsede) AS subquery GROUP BY idarticolo) AS giacenze ON giacenze.idarticolo = mg_articoli.id\nWHERE\n    1=1 AND `mg_articoli`.`deleted_at` IS NULL\nGROUP BY\n    `mg_articoli`.`id`\nHAVING\n    2=2\nORDER BY\n    `mg_articoli_lang`.`title`','','nav-icon fa fa-circle-o','2.0','2.0',0,20,1,1,1,0),(22,'Piani di sconto/maggiorazione','piano_sconto','piano_sconto','SELECT\n    |select|\nFROM \n    `mg_piani_sconto` \nWHERE \n    1=1\nHAVING \n    2=2 \nORDER BY \n    `nome`','','nav-icon fa fa-circle-o','2.0','2.0',1,20,1,1,0,0),(23,'Automezzi','automezzi','automezzi','{	\"main_query\": [	{	\"type\": \"table\", \"fields\": \"Targa,Nome,Descrizione\", \"query\": \"SELECT `id`, `targa` AS `Targa`, `nome` AS `Nome`,`descrizione` AS `Descrizione`  FROM `dt_automezzi` ORDER BY `targa`\"}	]}','','nav-icon fa fa-circle-o','2.0','2.0',2,20,1,1,0,0),(24,'Ordini cliente','ordini','ordini','\nSELECT\n    |select|\nFROM\n	`or_ordini`\n    INNER JOIN `or_tipiordine` ON `or_ordini`.`idtipoordine` = `or_tipiordine`.`id`\n    INNER JOIN `an_anagrafiche` ON `or_ordini`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `an_anagrafiche` AS agente ON `or_ordini`.`idagente` = `agente`.`idanagrafica`\n    LEFT JOIN (SELECT `idordine`, SUM(`qta` - `qta_evasa`) AS `qta_da_evadere`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM(`subtotale` - `sconto` + `iva`) AS `totale` FROM `or_righe_ordini` GROUP BY `idordine`) AS righe ON `or_ordini`.`id` = `righe`.`idordine`\n    LEFT JOIN (SELECT `idordine`, MIN(`data_evasione`) AS `data_evasione` FROM `or_righe_ordini` WHERE (`qta` - `qta_evasa`)>0 GROUP BY `idordine`) AS `righe_da_evadere` ON `righe`.`idordine`=`righe_da_evadere`.`idordine`\n    INNER JOIN `or_statiordine` ON `or_statiordine`.`id` = `or_ordini`.`idstatoordine`\n    LEFT JOIN `or_statiordine_lang` ON (`or_statiordine`.`id` = `or_statiordine_lang`.`id_record` AND `or_statiordine_lang`.|lang|)\n    LEFT JOIN (SELECT GROUP_CONCAT(DISTINCT \'Fattura \',`co_documenti`.`numero_esterno` SEPARATOR \', \') AS `info`, `co_righe_documenti`.`original_document_id` AS `idordine` FROM `co_documenti` INNER JOIN `co_righe_documenti` ON `co_documenti`.`id` = `co_righe_documenti`.`iddocumento` WHERE `original_document_type`=\'ModulesOrdiniOrdine\' GROUP BY original_document_id) AS `fattura` ON `fattura`.`idordine` = `or_ordini`.`id`\n    LEFT JOIN (SELECT GROUP_CONCAT(DISTINCT \'DDT \', `dt_ddt`.`numero_esterno` SEPARATOR \', \') AS `info`, `dt_righe_ddt`.`original_document_id` AS `idddt` FROM `dt_ddt` INNER JOIN `dt_righe_ddt` ON `dt_ddt`.`id`=`dt_righe_ddt`.`idddt` WHERE `original_document_type`=\'ModulesOrdiniOrdine\' GROUP BY original_document_id) AS `ddt` ON `ddt`.`idddt`=`or_ordini`.`id`\n    LEFT JOIN (SELECT COUNT(`id`) as emails, `em_emails`.`id_record` FROM `em_emails` INNER JOIN `zz_operations` ON `zz_operations`.`id_email` = `em_emails`.`id` WHERE `id_module` IN (SELECT `id` FROM `zz_modules` WHERE `name` = \'Ordini cliente\' AND `zz_operations`.`op` = \'send-email\' GROUP BY `em_emails`.`id_record`) AND `zz_operations`.`op` = \'send-email\' GROUP BY id_record) AS email ON `email`.`id_record` = `or_ordini`.`id`\nWHERE\n    1=1 |segment(`or_ordini`.`id_segment`)| AND `dir` = \'entrata\'  |date_period(`or_ordini`.`data`)|\nHAVING\n    2=2\nORDER BY \n	`data` DESC, \n    CAST(`numero_esterno` AS UNSIGNED) DESC','','nav-icon fa fa-circle-o','2.0','2.0',1,33,1,1,1,0),(25,'Ordini fornitore','ordini','ordini','\nSELECT\n    |select|\nFROM\n	`or_ordini`\n    INNER JOIN `or_tipiordine` ON `or_ordini`.`idtipoordine` = `or_tipiordine`.`id`\n    INNER JOIN `an_anagrafiche` ON `or_ordini`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN (SELECT `idordine`, SUM(`qta` - `qta_evasa`) AS `qta_da_evadere`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM(`subtotale` - `sconto` + `iva`) AS `totale` FROM `or_righe_ordini` GROUP BY `idordine`) AS righe ON `or_ordini`.`id` = `righe`.`idordine`\n    LEFT JOIN (SELECT `idordine`, MIN(`data_evasione`) AS `data_evasione` FROM `or_righe_ordini` WHERE (`qta` - `qta_evasa`)>0 GROUP BY `idordine`) AS `righe_da_evadere` ON `righe`.`idordine`=`righe_da_evadere`.`idordine`\n    INNER JOIN `or_statiordine` ON `or_statiordine`.`id` = `or_ordini`.`idstatoordine`\n    LEFT JOIN `or_statiordine_lang` ON (`or_statiordine`.`id` = `or_statiordine_lang`.`id_record` AND `or_statiordine_lang`.|lang|)\n    LEFT JOIN (SELECT GROUP_CONCAT(DISTINCT co_documenti.numero_esterno SEPARATOR \', \') AS info, co_righe_documenti.original_document_id AS idordine FROM co_documenti INNER JOIN co_righe_documenti ON co_documenti.id = co_righe_documenti.iddocumento WHERE original_document_type=\'Modules\\Ordini\\Ordine\' GROUP BY idordine, original_document_id) AS fattura ON fattura.idordine = or_ordini.id\n    LEFT JOIN (SELECT COUNT(`id`) as emails, `em_emails`.`id_record` FROM `em_emails` INNER JOIN `zz_operations` ON `zz_operations`.`id_email` = `em_emails`.`id` WHERE `id_module` IN(SELECT `id` FROM `zz_modules` WHERE `name` = \'Ordini fornitore\') AND `zz_operations`.`op` = \'send-email\' GROUP BY `em_emails`.`id_record`) AS email ON `email`.`id_record` = `or_ordini`.`id`\nWHERE\n    1=1 |segment(`or_ordini`.`id_segment`)| AND `dir` = \'uscita\' |date_period(`or_ordini`.`data`)|\nHAVING\n    2=2\nORDER BY \n	`data` DESC, \n    CAST(`numero_esterno` AS UNSIGNED) DESC','','nav-icon fa fa-circle-o','2.0','2.0',2,34,1,1,1,0),(26,'Ddt in uscita','ddt','ddt','\nSELECT\n    |select| \nFROM\n    `dt_ddt`\n    LEFT JOIN `an_anagrafiche` ON `dt_ddt`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `dt_tipiddt` ON `dt_ddt`.`idtipoddt` = `dt_tipiddt`.`id`\n    LEFT JOIN `dt_causalet` ON `dt_ddt`.`idcausalet` = `dt_causalet`.`id`\n    LEFT JOIN `dt_causalet_lang` ON (`dt_causalet_lang`.`id_record` = `dt_causalet`.`id` AND `dt_causalet_lang`.|lang|)\n    LEFT JOIN `dt_spedizione` ON `dt_ddt`.`idspedizione` = `dt_spedizione`.`id`\n    LEFT JOIN `dt_spedizione_lang` ON (`dt_spedizione_lang`.`id_record` = `dt_spedizione`.`id` AND `dt_spedizione_lang`.|lang|)\n    LEFT JOIN `an_anagrafiche` `vettori` ON `dt_ddt`.`idvettore` = `vettori`.`idanagrafica`\n    LEFT JOIN `an_sedi` AS sedi ON `dt_ddt`.`idsede_partenza` = sedi.`id`\n    LEFT JOIN `an_sedi` AS `sedi_destinazione`ON `dt_ddt`.`idsede_destinazione` = `sedi_destinazione`.`id`\n    LEFT JOIN (SELECT `idddt`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM(`subtotale` - `sconto` + `iva`) AS `totale` FROM `dt_righe_ddt` GROUP BY `idddt`) AS righe ON `dt_ddt`.`id` = `righe`.`idddt`\n    LEFT JOIN `dt_statiddt` ON `dt_statiddt`.`id` = `dt_ddt`.`idstatoddt`\n    LEFT JOIN `dt_statiddt_lang` ON (`dt_statiddt_lang`.`id_record` = `dt_statiddt`.`id` AND `dt_statiddt_lang`.|lang|)    \n    LEFT JOIN (SELECT GROUP_CONCAT(DISTINCT \'Fattura \',`co_documenti`.`numero_esterno` SEPARATOR \', \') AS `info`, `co_righe_documenti`.`original_document_id` AS `idddt` FROM `co_documenti` INNER JOIN `co_righe_documenti` ON `co_documenti`.`id` = `co_righe_documenti`.`iddocumento` WHERE `original_document_type`=\'Modules\\DDT\\DDT\' GROUP BY `original_document_id`) AS `fattura` ON `fattura`.`idddt` = `dt_ddt`.`id`\n    LEFT JOIN (SELECT COUNT(`id`) as emails, `em_emails`.`id_record` FROM `em_emails` INNER JOIN `zz_operations` ON `zz_operations`.`id_email` = `em_emails`.`id` WHERE `id_module` IN (SELECT `id` FROM `zz_modules` WHERE `name` = \'Ddt di vendita\') AND `zz_operations`.`op` = \'send-email\' GROUP BY id_record) AS `email` ON `email`.`id_record` = `dt_ddt`.`id`\nWHERE\n    1=1 |segment(`dt_ddt`.`id_segment`)| AND `dir` = \'entrata\' |date_period(`data`)|\nHAVING\n    2=2\nORDER BY\n    `data` DESC,\n    CAST(`numero_esterno` AS UNSIGNED) DESC,\n    `dt_ddt`.`created_at` DESC','','nav-icon fa fa-circle-o','2.0','2.0',3,20,1,1,1,0),(27,'Ddt in entrata','ddt','ddt','\nSELECT\n    |select| \nFROM\n    `dt_ddt`\n    LEFT JOIN `an_anagrafiche` ON `dt_ddt`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `dt_tipiddt` ON `dt_ddt`.`idtipoddt` = `dt_tipiddt`.`id`\n    LEFT JOIN `dt_causalet` ON `dt_ddt`.`idcausalet` = `dt_causalet`.`id`\n    LEFT JOIN `dt_causalet_lang` ON (`dt_causalet_lang`.`id_record` = `dt_causalet`.`id` AND `dt_causalet_lang`.|lang|)\n    LEFT JOIN `dt_spedizione` ON `dt_ddt`.`idspedizione` = `dt_spedizione`.`id`\n    LEFT JOIN `dt_spedizione_lang` ON (`dt_spedizione_lang`.`id_record` = `dt_spedizione`.`id` AND `dt_spedizione_lang`.|lang|)\n    LEFT JOIN `an_anagrafiche` `vettori` ON `dt_ddt`.`idvettore` = `vettori`.`idanagrafica`\n    LEFT JOIN `an_sedi` AS sedi ON `dt_ddt`.`idsede_partenza` = sedi.`id`\n    LEFT JOIN `an_sedi` AS `sedi_destinazione`ON `dt_ddt`.`idsede_destinazione` = `sedi_destinazione`.`id`\n    LEFT JOIN(SELECT `idddt`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM(`subtotale` - `sconto` + `iva`) AS `totale` FROM `dt_righe_ddt` GROUP BY `idddt`) AS righe ON `dt_ddt`.`id` = `righe`.`idddt` \n    LEFT JOIN `dt_statiddt` ON `dt_statiddt`.`id` = `dt_ddt`.`idstatoddt`\n    LEFT JOIN `dt_statiddt_lang` ON (`dt_statiddt_lang`.`id_record` = `dt_statiddt`.`id` AND `dt_statiddt_lang`.|lang|)\n    LEFT JOIN (SELECT GROUP_CONCAT(DISTINCT \'Fattura \',`co_documenti`.`numero` SEPARATOR \', \') AS `info`, `co_righe_documenti`.`original_document_id` AS `idddt` FROM `co_documenti` INNER JOIN `co_righe_documenti` ON `co_documenti`.`id` = `co_righe_documenti`.`iddocumento` WHERE `original_document_type`=\'Modules\\DDT\\DDT\' GROUP BY `original_document_id`) AS `fattura` ON `fattura`.`idddt` = `dt_ddt`.`id`\nWHERE\n    1=1 |segment(`dt_ddt`.`id_segment`)| AND `dir` = \'uscita\' |date_period(`data`)|\nHAVING\n    2=2\nORDER BY\n    `data` DESC,\n    CAST(`numero_esterno` AS UNSIGNED) DESC,\n    `dt_ddt`.`created_at` DESC','','nav-icon fa fa-circle-o','2.0','2.0',4,20,1,1,1,0),(28,'Zone','zone','zone','SELECT |select| FROM `an_zone` WHERE 1=1 HAVING 2=2 ORDER BY `id`','','nav-icon fa fa-circle-o','2.0','2.0',2,2,1,1,0,0),(29,'Tecnici e tariffe','tecnici_tariffe','tecnici_tariffe','\nSELECT\n    |select| \nFROM \n    `an_anagrafiche`\n    INNER JOIN `an_tipianagrafiche_anagrafiche` ON `an_anagrafiche`.`idanagrafica` = `an_tipianagrafiche_anagrafiche`.`idanagrafica`\n    LEFT JOIN `an_tipianagrafiche` ON `an_tipianagrafiche_anagrafiche`.`idtipoanagrafica` = `an_tipianagrafiche`.`id`\n    LEFT JOIN `an_tipianagrafiche_lang` ON (`an_tipianagrafiche_lang`.`id_record` = `an_tipianagrafiche`.`id` AND |lang|)\nWHERE \n    1=1 AND `an_tipianagrafiche`.`name` = \'Tecnico\' AND `an_anagrafiche`.`deleted_at` IS NULL\nHAVING \n    2=2 \nORDER BY \n    `ragione_sociale`','','nav-icon fa fa-circle-o','2.0','2.0',3,3,1,1,0,0),(30,'Impianti','impianti','impianti','\nSELECT\n    |select|\nFROM\n    `my_impianti`\n    LEFT JOIN `an_anagrafiche` AS clienti ON `clienti`.`idanagrafica` = `my_impianti`.`idanagrafica`\n    LEFT JOIN `an_anagrafiche` AS tecnici ON `tecnici`.`idanagrafica` = `my_impianti`.`idtecnico` \n    LEFT JOIN `zz_categorie` ON `zz_categorie`.`id` = `my_impianti`.`id_categoria`\n    LEFT JOIN `zz_categorie_lang` ON (`zz_categorie`.`id` = `zz_categorie_lang`.`id_record` AND `zz_categorie_lang`.|lang|)\n    LEFT JOIN `zz_categorie` as sub ON sub.`id` = `my_impianti`.`id_sottocategoria`\n    LEFT JOIN `zz_categorie_lang` as sub_lang ON (sub.`id` = sub_lang.`id_record` AND sub_lang.|lang|)\n    LEFT JOIN (SELECT an_sedi.id, CONCAT(an_sedi.nomesede, \'<br />\',IF(an_sedi.telefono!=\'\',CONCAT(an_sedi.telefono,\'<br />\'),\'\'),IF(an_sedi.cellulare!=\'\',CONCAT(an_sedi.cellulare,\'<br />\'),\'\'),an_sedi.citta,IF(an_sedi.indirizzo!=\'\',CONCAT(\' - \',an_sedi.indirizzo),\'\')) AS info FROM an_sedi) AS sede ON sede.id = my_impianti.idsede\n    LEFT JOIN `zz_marche` as marca ON `marca`.`id` = `my_impianti`.`id_marca`\n    LEFT JOIN `zz_marche` as modello ON `modello`.`id` = `my_impianti`.`id_modello`\nWHERE\n    1=1\nHAVING\n    2=2\nORDER BY\n    `matricola`','','nav-icon fa fa-puzzle-piece','0.1','2.0',7,NULL,1,1,1,1),(31,'Contratti','contratti','contratti','\nSELECT\n    |select|\nFROM\n    `co_contratti`\n    LEFT JOIN `an_anagrafiche` ON `co_contratti`.`idanagrafica` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `an_anagrafiche` AS `agente` ON `co_contratti`.`idagente` = `agente`.`idanagrafica`\n    LEFT JOIN `co_staticontratti` ON `co_contratti`.`idstato` = `co_staticontratti`.`id`\n    LEFT JOIN `co_staticontratti_lang` ON (`co_staticontratti`.`id` = `co_staticontratti_lang`.`id_record` AND |lang|)\n    LEFT JOIN (SELECT `idcontratto`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM(`subtotale` - `sconto` + `iva`) AS `totale` FROM `co_righe_contratti` GROUP BY `idcontratto`) AS righe ON `co_contratti`.`id` = `righe`.`idcontratto`\n    LEFT JOIN (WITH RigheAgg AS (SELECT idintervento,SUM(prezzo_unitario * qta) AS sommacosti_per_intervento FROM in_righe_interventi GROUP BY idintervento), TecniciAgg AS (SELECT idintervento, SUM(prezzo_ore_consuntivo) AS sommasessioni_per_intervento FROM in_interventi_tecnici GROUP BY idintervento) SELECT SUM(COALESCE(RigheAgg.sommacosti_per_intervento, 0)) AS sommacosti, SUM(COALESCE(TecniciAgg.sommasessioni_per_intervento, 0)) AS sommasessioni, i.id_contratto FROM in_interventi i LEFT JOIN RigheAgg ON RigheAgg.idintervento = i.id LEFT JOIN TecniciAgg ON TecniciAgg.idintervento = i.id GROUP BY i.id_contratto) AS spesacontratto ON spesacontratto.id_contratto = co_contratti.id\n    LEFT JOIN (SELECT GROUP_CONCAT(CONCAT(matricola, IF(nome != \'\', CONCAT(\' - \', nome), \'\')) SEPARATOR \'<br />\') AS descrizione, my_impianti_contratti.idcontratto FROM my_impianti INNER JOIN my_impianti_contratti ON my_impianti.id = my_impianti_contratti.idimpianto GROUP BY my_impianti_contratti.idcontratto) AS impianti ON impianti.idcontratto = co_contratti.id\n    LEFT JOIN (SELECT um, SUM(qta) AS somma, idcontratto FROM co_righe_contratti GROUP BY um, idcontratto) AS orecontratti ON orecontratti.um = \'ore\' AND orecontratti.idcontratto = co_contratti.id\n    LEFT JOIN (SELECT in_interventi.id_contratto, SUM(ore) AS sommatecnici FROM in_interventi_tecnici INNER JOIN in_interventi ON in_interventi_tecnici.idintervento = in_interventi.id LEFT JOIN in_tipiintervento ON in_interventi_tecnici.idtipointervento=in_tipiintervento.id WHERE non_conteggiare=0 GROUP BY in_interventi.id_contratto) AS tecnici ON tecnici.id_contratto = co_contratti.id\n    LEFT JOIN `co_categorie_contratti` ON `co_contratti`.`id_categoria` = `co_categorie_contratti`.`id`\n    LEFT JOIN `co_categorie_contratti_lang` ON (`co_categorie_contratti`.`id` = `co_categorie_contratti_lang`.`id_record` AND `co_categorie_contratti_lang`.|lang|)\n    LEFT JOIN `co_categorie_contratti` AS sottocategorie ON `co_contratti`.`id_sottocategoria` = `sottocategorie`.`id`\n    LEFT JOIN `co_categorie_contratti_lang` AS sottocategorie_lang ON (`sottocategorie`.`id` = `sottocategorie_lang`.`id_record` AND `sottocategorie_lang`.|lang|)\nWHERE\n    1=1 |segment(`co_contratti`.`id_segment`)| |date_period(custom,\'|period_start|\' >= `data_bozza` AND \'|period_start|\' <= `data_conclusione`,\'|period_end|\' >= `data_bozza` AND \'|period_end|\' <= `data_conclusione`,`data_bozza` >= \'|period_start|\' AND `data_bozza` <= \'|period_end|\',`data_conclusione` >= \'|period_start|\' AND `data_conclusione` <= \'|period_end|\',`data_bozza` >= \'|period_start|\' AND `data_conclusione` = NULL)|\nHAVING \n    2=2\nORDER BY \n    `co_contratti`.`data_bozza` DESC','','nav-icon fa fa-circle-o','2.0','2.0',0,33,1,1,1,0),(33,'Vendite','','','menu','','nav-icon fa fa-line-chart','2.1','2.*',3,NULL,1,1,0,0),(34,'Acquisti','','','menu','','nav-icon fa fa-shopping-cart','2.1','2.*',4,NULL,1,1,0,0),(36,'Gestione email','','','','','nav-icon fa fa-envelope','2.3','2.3',1,NULL,1,1,0,0),(37,'Segmenti','segmenti','segmenti','\nSELECT\n    |select| \nFROM\n    `zz_segments`\n    LEFT JOIN `zz_segments_lang` ON (`zz_segments_lang`.`id_record` = `zz_segments`.`id` AND `zz_segments_lang`.|lang|)\n    INNER JOIN `zz_modules` ON `zz_modules`.`id` = `zz_segments`.`id_module`\n    LEFT JOIN `zz_modules_lang` ON (`zz_modules_lang`.`id_record` = `zz_modules`.`id` AND `zz_modules_lang`.|lang|)\n    LEFT JOIN (SELECT GROUP_CONCAT(`zz_groups_lang`.`title` ORDER BY `zz_groups_lang`.`title`  SEPARATOR \', \') AS `gruppi`, `zz_group_segment`.`id_segment` FROM `zz_group_segment` INNER JOIN `zz_groups` ON `zz_groups`.`id` = `zz_group_segment`.`id_gruppo` LEFT JOIN `zz_groups_lang` ON (`zz_groups_lang`.`id_record` = `zz_groups`.`id` AND `zz_groups_lang`.|lang|) GROUP BY  `zz_group_segment`.`id_segment`) AS `t` ON `t`.`id_segment` = `zz_segments`.`id`\nWHERE\n    1=1\nHAVING\n    2=2\nORDER BY `zz_segments_lang`.`title`,\n    `zz_segments`.`id_module`','','nav-icon fa fa-database','2.4','2.4',1,NULL,1,1,0,0),(38,'Import','import','import','custom','','nav-icon fa fa-file-o','2.4','2.4',1,NULL,1,1,0,0),(39,'Banche','banche','banche','SELECT |select| FROM `co_banche` INNER JOIN an_anagrafiche ON `an_anagrafiche`.`idanagrafica` = `co_banche`.`id_anagrafica` WHERE 1=1 AND `co_banche`.`deleted_at` IS NULL AND `an_anagrafiche`.`deleted_at` IS NULL HAVING 2=2','','nav-icon fa fa-university','2.4','2.4',1,NULL,1,1,0,0),(40,'Modelli prima nota','modelli_primanota','modelli_primanota','SELECT |select| FROM `co_movimenti_modelli` WHERE 1=1 GROUP BY `idmastrino` HAVING 2=2','','nav-icon fa fa-circle-o','2.4.1','2.4.1',1,NULL,1,1,0,0),(41,'Campi personalizzati','custom_fields','custom_fields','\nSELECT\n    |select|\nFROM\n    `zz_fields`\n    LEFT JOIN `zz_modules` ON `zz_modules`.`id` = `zz_fields`.`id_module`\n    LEFT JOIN `zz_modules_lang` ON (`zz_modules_lang`.`id_record` = `zz_modules`.`id` AND `zz_modules_lang`.|lang|)\n    LEFT JOIN `zz_plugins` ON `zz_plugins`.`id` = `zz_fields`.`id_plugin`\n    LEFT JOIN `zz_plugins_lang` ON (`zz_plugins_lang`.`id_record` = `zz_plugins`.`id` AND `zz_plugins_lang`.|lang|)\nWHERE\n    1=1\nHAVING\n    2=2','','nav-icon fa fa-list','2.4.1','2.4.1',1,NULL,1,0,0,0),(42,'Gestione documentale','gestione_documentale','gestione_documentale','\nSELECT\n    |select| \nFROM \n    `do_documenti`\n    INNER JOIN `do_categorie` ON `do_categorie`.`id` = `do_documenti`.`idcategoria`\n    LEFT JOIN `do_categorie_lang` ON (`do_categorie_lang`.`id_record` = `do_categorie`.`id` AND `do_categorie_lang`.|lang|)\n    INNER JOIN `do_permessi` ON `do_permessi`.`id_categoria` = `do_documenti`.`idcategoria`\nWHERE \n    1=1 AND \n    `deleted_at` IS NULL AND\n    `id_gruppo` = (SELECT `idgruppo` FROM `zz_users` WHERE `zz_users`.`id` = |id_utente|) \nHAVING \n    2=2 \nORDER BY \n    `data` DESC','','nav-icon fa fa-file-text-o','2.4','2.4',1,NULL,1,1,0,0),(43,'Categorie documenti','categorie_documenti','categorie_documenti','\nSELECT\n    |select| \nFROM \n   `do_categorie`\n   LEFT JOIN `do_categorie_lang` ON (`do_categorie_lang`.`id_record` = `do_categorie`.`id` AND `do_categorie_lang`.|lang|)\n   INNER JOIN `do_permessi` ON `do_permessi`.`id_categoria` = `do_categorie`.`id`\nWHERE \n    1=1 AND \n    `deleted_at` IS NULL AND\n    `id_gruppo` = (SELECT `idgruppo` FROM `zz_users` WHERE `id` = |id_utente|)\nHAVING\n    2=2','','nav-icon fa fa-circle-o','2.4','2.4',1,42,1,1,0,0),(44,'Tipi di spedizione','spedizioni','spedizioni','\nSELECT\n    |select| \nFROM \n    `dt_spedizione`\n    LEFT JOIN `dt_spedizione_lang` ON (`dt_spedizione_lang`.`id_record` = `dt_spedizione`.`id` AND `dt_spedizione_lang`.|lang|)\nWHERE \n    1=1 \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.2','2.4.2',1,NULL,1,1,0,0),(46,'Casse previdenziali','rivalse','rivalse','SELECT |select| FROM `co_rivalse` WHERE 1=1 HAVING 2=2','','nav-icon fa fa-percent','2.4.6','2.4.6',1,NULL,1,1,0,0),(47,'Ritenute previdenziali','ritenute_contributi','ritenute_contributi','SELECT |select| FROM `co_ritenuta_contributi` WHERE 1=1 HAVING 2=2','','nav-icon fa fa-percent','2.4.6','2.4.6',1,NULL,1,1,0,0),(48,'Stati dei preventivi','stati_preventivo','stati_preventivo','\nSELECT\n    |select| \nFROM \n    `co_statipreventivi`\n    LEFT JOIN `co_statipreventivi_lang` ON (`co_statipreventivi`.`id` = `co_statipreventivi_lang`.`id_record` AND |lang|)\nWHERE \n    1=1\nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.9','2.4.9',1,13,1,1,0,0),(49,'Stati dei contratti','stati_contratto','stati_contratto','\nSELECT\n    |select| \nFROM \n    `co_staticontratti`\n    LEFT JOIN `co_staticontratti_lang` ON (`co_staticontratti`.`id` = `co_staticontratti_lang`.`id_record` AND |lang|)\nWHERE \n    1=1 AND deleted_at IS NULL \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.9','2.4.9',1,31,1,1,0,0),(50,'Stato dei servizi','stato_servizi','stato_servizi','custom','','nav-icon fa fa-clock-o','2.4.9','2.4.9',1,NULL,1,1,0,0),(51,'Tipi scadenze','tipi_scadenze','tipi_scadenze','\nSELECT\n    |select| \nFROM \n    `co_tipi_scadenze`\n    LEFT JOIN `co_tipi_scadenze_lang` ON (`co_tipi_scadenze_lang`.`id_record` = `co_tipi_scadenze`.`id` AND `co_tipi_scadenze_lang`.|lang|)\nWHERE \n    1=1\nHAVING\n    2=2','','nav-icon fa fa-calendar','2.4.10','2.4.10',1,NULL,1,1,0,0),(52,'Checklists','checklists','checklists','\nSELECT\n    |select|\nFROM\n    `zz_checklists`\n    LEFT JOIN `zz_modules` ON `zz_checklists`.`id_module` = `zz_modules`.`id`\n    LEFT JOIN `zz_modules_lang` ON (`zz_modules_lang`.`id_record` = `zz_modules`.`id` AND `zz_modules_lang`.|lang|)\n    LEFT JOIN `zz_plugins` ON `zz_checklists`.`id_plugin`=`zz_plugins`.`id`\n    LEFT JOIN `zz_plugins_lang` ON (`zz_plugins_lang`.`id_record` = `zz_plugins`.`id` AND `zz_plugins_lang`.|lang|)\nWHERE\n    1=1\nHAVING\n    2=2','','nav-icon fa fa-check-square-o','2.4.11','2.*',1,NULL,1,1,0,0),(53,'Newsletter','newsletter','newsletter','\nSELECT\n    |select| \nFROM \n    `em_newsletters` \n    LEFT JOIN `em_templates` ON `em_newsletters`.`id_template` = `em_templates`.`id`\n    LEFT JOIN `em_templates_lang` ON (`em_templates_lang`.`id_record` = `em_templates`.`id` AND `em_templates_lang`.|lang|)\n    LEFT JOIN (SELECT `id_newsletter`, COUNT(*) AS totale FROM `em_newsletter_receiver` GROUP BY  `id_newsletter`) AS riceventi ON `riceventi`.`id_newsletter` = `em_newsletters`.`id`\nWHERE \n    1=1 AND `em_newsletters`.`deleted_at` IS NULL\nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.11','2.*',1,36,1,1,0,0),(54,'Stato email','stato_email','stato_email','\nSELECT\n    |select|\nFROM \n    `em_emails`\n    LEFT JOIN `em_templates` ON `em_templates`.`id` = `em_emails`.`id_template`\n    INNER JOIN `zz_users` ON `zz_users`.`id` = `em_emails`.`created_by`\n    LEFT JOIN (SELECT `id_email`, GROUP_CONCAT(`address` SEPARATOR \'<br>\') as `nomi` FROM `em_email_receiver` GROUP BY `id_email`)AS `destinatari` ON `destinatari`.`id_email` = `em_emails`.`id`\n    LEFT JOIN `zz_modules` ON `zz_modules`.`id` = `em_templates`.`id_module`\n    LEFT JOIN `zz_modules_lang` ON (`zz_modules`.`id` = `zz_modules_lang`.`id_record` AND `zz_modules_lang`.|lang|)\nWHERE \n    1=1 \nAND \n    (`em_emails`.`created_at` BETWEEN \'|period_start|\' AND \'|period_end|\' OR `em_emails`.`sent_at` IS NULL)\nHAVING \n    2=2\nORDER BY \n    `em_emails`.`created_at` DESC','','nav-icon fa fa-circle-o','2.4.11','2.*',1,36,1,1,0,0),(55,'Liste newsletter','liste_newsletter','liste_newsletter','\nSELECT\n    |select| \nFROM \n    `em_lists`\n    LEFT JOIN `em_lists_lang` ON (`em_lists_lang`.`id_record` = `em_lists`.`id` AND `em_lists_lang`.|lang|)\nWHERE \n    1=1 AND deleted_at IS NULL \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.11','2.*',1,36,1,0,0,0),(56,'Relazioni','relazioni_anagrafiche','relazioni_anagrafiche','\nSELECT\n    |select|\nFROM\n    `an_relazioni`\n    LEFT JOIN `an_relazioni_lang` ON (`an_relazioni`.`id` = `an_relazioni_lang`.`id_record` AND |lang|)\nWHERE\n    1=1 AND `deleted_at` IS NULL\nHAVING\n    2=2\nORDER BY \n    `an_relazioni`.`created_at` DESC','','nav-icon fa fa-angle-right ','2.4.13','2.*',1,2,1,1,0,0),(57,'Stampe','stampe','stampe','\nSELECT\n    |select| \nFROM \n    `zz_prints`\n    LEFT JOIN `zz_prints_lang` ON (`zz_prints_lang`.`id_record` = `zz_prints`.`id` AND `zz_prints_lang`.|lang|)\n    LEFT JOIN `zz_modules` ON `zz_modules`.`id` = `zz_prints`.`id_module`\n    LEFT JOIN `zz_modules_lang` ON (`zz_modules_lang`.`id_record` = `zz_modules`.`id` AND `zz_modules_lang`.|lang|)\nWHERE \n    1=1 \n    AND `zz_prints`.`enabled`=1 \nHAVING \n    2=2','','nav-icon fa fa-print','2.4.14','2.4.14',1,NULL,1,0,0,0),(58,'Causali movimenti','causali_movimenti','causali_movimenti','\nSELECT\n    |select|\nFROM \n    `mg_causali_movimenti`\n    LEFT JOIN `mg_causali_movimenti_lang` ON (`mg_causali_movimenti`.`id` = `mg_causali_movimenti_lang`.`id_record` AND `mg_causali_movimenti_lang`.|lang|)\nWHERE \n    1=1 \nHAVING \n    2=2','','nav-icon fa fa-exchange','2.4.14','2.4.14',1,NULL,1,1,0,0),(59,'Giacenze sedi','giacenze_sedi','giacenze_sedi','\nSELECT\n    |select|\nFROM\n    `mg_articoli`\n    LEFT JOIN `mg_articoli_lang` ON (`mg_articoli`.`id` = `mg_articoli_lang`.`id_record` AND `mg_articoli_lang`.|lang|)\n    LEFT JOIN `an_anagrafiche` ON `mg_articoli`.`id_fornitore` = `an_anagrafiche`.`idanagrafica`\n    LEFT JOIN `co_iva` ON `mg_articoli`.`idiva_vendita` = `co_iva`.`id`\n    LEFT JOIN `co_iva_lang` ON (`co_iva`.`id` = `co_iva_lang`.`id_record` AND `co_iva_lang`.|lang|)\n    LEFT JOIN (SELECT SUM(`qta` - `qta_evasa`) AS qta_impegnata, `idarticolo` FROM `or_righe_ordini` INNER JOIN `or_ordini` ON `or_righe_ordini`.`idordine` = `or_ordini`.`id` WHERE `idstatoordine` IN(SELECT `id` FROM `or_statiordine` WHERE `is_bloccato` = 0) GROUP BY `idarticolo`) ordini ON `ordini`.`idarticolo` = `mg_articoli`.`id`\n    LEFT JOIN (SELECT `idarticolo`, `idsede`, SUM(`qta`) AS `qta` FROM `mg_movimenti` WHERE `idsede` = |giacenze_sedi_idsede| GROUP BY `idarticolo`, `idsede`) movimenti ON `mg_articoli`.`id` = `movimenti`.`idarticolo`\n    LEFT JOIN `zz_categorie` AS categoria ON `categoria`.`id`= `mg_articoli`.`id_categoria`\n    LEFT JOIN `zz_categorie_lang` AS categoria_lang ON (`categoria_lang`.`id_record` = `categoria`.`id` AND `categoria_lang`.|lang|)\n    LEFT JOIN `zz_categorie` AS sottocategoria ON `sottocategoria`.`id`=`mg_articoli`.`id_sottocategoria`\n    LEFT JOIN `zz_categorie_lang` AS sottocategoria_lang ON (`sottocategoria_lang`.`id_record` = `sottocategoria`.`id` AND `sottocategoria_lang`.|lang|)\n	LEFT JOIN (SELECT `co_iva`.`percentuale` AS perc, `co_iva`.`id`, `zz_settings`.`nome` FROM `co_iva` INNER JOIN `zz_settings` ON `co_iva`.`id`=`zz_settings`.`valore`)AS iva ON `iva`.`nome`= \'Iva predefinita\'\nWHERE\n    1=1 AND `mg_articoli`.`deleted_at` IS NULL\nHAVING\n    2=2 AND `qta` > 0\nORDER BY\n    `mg_articoli_lang`.`title`','','nav-icon fa fa-circle-o','2.4.18','2.4.18',5,20,1,1,1,0),(60,'Listini','listini','listini','\nSELECT\n    |select| \nFROM\n    `mg_prezzi_articoli`\n    INNER JOIN `an_anagrafiche` ON `an_anagrafiche`.`idanagrafica` = `mg_prezzi_articoli`.`id_anagrafica`\n    INNER JOIN `mg_articoli` ON `mg_articoli`.`id` = `mg_prezzi_articoli`.`id_articolo`\n    LEFT JOIN `mg_articoli_lang` ON (`mg_articoli_lang`.`id_record` = `mg_articoli`.`id` AND `mg_articoli_lang`.|lang|)\n    LEFT JOIN `zz_categorie` AS `categoria` ON `mg_articoli`.`id_categoria` = `categoria`.`id`\n    LEFT JOIN `zz_categorie_lang` AS `categorialang` ON (`categorialang`.`id_record` = `categoria`.`id` AND `categorialang`.|lang|)\n    LEFT JOIN `zz_categorie` AS `sottocategoria` ON `mg_articoli`.`id_sottocategoria` = `sottocategoria`.`id`\n    LEFT JOIN `zz_categorie_lang` AS `sottocategorialang` ON (`sottocategorialang`.`id_record` = `sottocategoria`.`id` AND `sottocategorialang`.|lang|)\n    LEFT JOIN `zz_modules` ON `zz_modules`.`name`= \'Articoli\'\n    LEFT JOIN `zz_modules_lang` ON (`zz_modules`.`id` = `zz_modules_lang`.`id_record` AND `zz_modules_lang`.|lang|)\n    LEFT JOIN (SELECT `codice_fornitore` AS codice, `id_articolo`, `id_fornitore`, `barcode_fornitore` AS barcode, `deleted_at` FROM `mg_fornitore_articolo`) AS fornitore ON `mg_prezzi_articoli`.`id_articolo`= `fornitore`.`id_articolo` AND `mg_prezzi_articoli`.`id_anagrafica`=`fornitore`.`id_fornitore` AND `fornitore`.`deleted_at` IS NULL\nWHERE\n    1=1 AND `mg_articoli`.`deleted_at` IS NULL AND `an_anagrafiche`.`deleted_at` IS NULL\nHAVING\n    2=2\nORDER BY\n    `an_anagrafiche`.`ragione_sociale`','','nav-icon fa fa-circle-o','2.4','2.4',1,20,1,1,0,0),(61,'Tipi documento','tipi_documento','tipi_documento','\nSELECT\n    |select| \nFROM \n    `co_tipidocumento`\n    LEFT JOIN `co_tipidocumento_lang` ON (`co_tipidocumento`.`id` = `co_tipidocumento_lang`.`id_record` AND `co_tipidocumento_lang`.|lang|)\n    LEFT JOIN `zz_segments` ON `co_tipidocumento`.`id_segment` = `zz_segments`.`id` \n    LEFT JOIN `zz_segments_lang` ON (`zz_segments`.`id` = `zz_segments_lang`.`id_record` AND `zz_segments_lang`.|lang|)\nWHERE \n    1=1 AND `deleted_at` IS NULL \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.20','2.4.20',1,NULL,1,1,0,0),(62,'Attributi Combinazioni','attributi_combinazioni','attributi_combinazioni','\nSELECT\n    |select|\nFROM \n    `mg_attributi` \n    LEFT JOIN `mg_attributi_lang` ON (`mg_attributi`.`id` = `mg_attributi_lang`.`id_record` AND `mg_attributi_lang`.|lang|)\nWHERE \n    1=1 AND \n    `mg_attributi`.`deleted_at` IS NULL \nHAVING \n    2=2','','nav-icon fa fa-circle-o','1.0','2.*',100,20,1,1,0,0),(63,'Combinazioni','combinazioni_articoli','combinazioni_articoli','\nSELECT\n    |select|\nFROM \n    `mg_combinazioni`\n    LEFT JOIN `mg_combinazioni_lang` ON (`mg_combinazioni`.`id` = `mg_combinazioni_lang`.`id_record` AND `mg_combinazioni_lang`.|lang|)\nWHERE \n    1=1 AND \n    `mg_combinazioni`.`deleted_at` IS NULL \nGROUP BY\n    `mg_combinazioni`.`id`\nHAVING \n    2=2','','nav-icon fa fa-circle-o','1.0','2.*',100,20,1,1,0,0),(64,'Mansioni referenti','mansioni','mansioni','SELECT |select| FROM an_mansioni WHERE 1=1 HAVING 2=2 ORDER BY `nome`','','nav-icon fa fa-circle-o','1.0','2.*',100,NULL,1,1,0,0),(65,'Fasce orarie','fasce_orarie','fasce_orarie','\nSELECT\n    |select|\nFROM \n    `in_fasceorarie`\n    LEFT JOIN `in_fasceorarie_lang` ON (`in_fasceorarie_lang`.`id_record` = `in_fasceorarie`.`id` AND `in_fasceorarie_lang`.|lang|)\nWHERE \n    1=1 AND deleted_at IS NULL \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.32','2.4.32',1,3,1,1,0,0),(66,'Eventi','eventi','eventi','\nSELECT\n    |select|\nFROM\n    `zz_events`\nINNER JOIN `an_nazioni` ON `an_nazioni`.`id` = `zz_events`.`id_nazione`\nINNER JOIN `an_nazioni_lang` ON (`an_nazioni`.`id` = `an_nazioni_lang`.`id_record` AND |lang|)\nWHERE\n    1=1 \nHAVING\n    2=2','','nav-icon fa fa-circle-o','2.4.32','2.4.32',1,NULL,1,1,0,0),(67,'Provenienze','provenienze','provenienze','\nSELECT\n    |select|\nFROM\n    `an_provenienze`\n    LEFT JOIN `an_provenienze_lang` ON (`an_provenienze`.`id` = `an_provenienze_lang`.`id_record` AND |lang|)\nWHERE\n    1=1\nHAVING\n    2=2','','nav-icon fa fa-circle-o','2.4.34','2.4.34',3,2,1,1,0,0),(68,'Settori','settori_merceologici','settori_merceologici','\nSELECT\n    |select|\nFROM\n    `an_settori`\n    LEFT JOIN `an_settori_lang` ON (`an_settori`.`id` = `an_settori_lang`.`id_record` AND |lang|)\nWHERE\n    1=1\nHAVING\n    2=2','','nav-icon fa fa-circle-o','2.4.34','2.4.34',4,2,1,1,0,0),(69,'Mappa','mappa','mappa','custom','','nav-icon fa fa-map','2.4.36','2.4.36',10,NULL,1,1,0,0),(70,'Listini cliente','listini_cliente','listini_cliente','\nSELECT\n    |select|\nFROM \n    `mg_listini`\n    LEFT JOIN (SELECT `mg_listini_articoli`.`id_listino`, COUNT(`id_listino`) AS num FROM `mg_listini_articoli` GROUP BY `id_listino`) AS articoli ON `mg_listini`.`id`=`articoli`.`id_listino`\n    LEFT JOIN (SELECT `an_anagrafiche`.`id_listino`, COUNT(`id_listino`) AS num FROM `an_anagrafiche` GROUP BY `id_listino`) AS anagrafiche ON `mg_listini`.`id`=`anagrafiche`.`id_listino`\n    LEFT JOIN (SELECT `zz_users`.`id`, `zz_users`.`username` FROM `zz_users` INNER JOIN (SELECT `zz_operations`.`id_utente`, `zz_operations`.`id_record` FROM `zz_operations` LEFT JOIN `zz_modules` ON `zz_modules`.`name` = \'Listini cliente\' LEFT JOIN `zz_modules_lang` ON (`zz_modules_lang`.`id_record` = `zz_modules`.`id` AND `zz_modules_lang`.|lang|) ORDER BY `id_utente` DESC LIMIT 0, 1) AS `id`) AS `utente` ON `utente`.`id` = `mg_listini`.`id`\nWHERE \n    1=1 \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.*','2.*',2,20,1,1,0,0),(71,'Stati degli ordini','stati_ordine','stati_ordine','\nSELECT\n    |select|\nFROM \n    `or_statiordine`\n    LEFT JOIN `or_statiordine_lang` ON (`or_statiordine`.`id` = `or_statiordine_lang`.`id_record` AND `or_statiordine_lang`.|lang|)\nWHERE \n    1=1 AND \n    deleted_at IS NULL \nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.48','2.4.48',1,NULL,1,1,0,0),(72,'Stati fatture','stati_fattura','stati_fattura','\nSELECT\n    |select| \nFROM \n    `co_statidocumento`\n    LEFT JOIN `co_statidocumento_lang` ON (`co_statidocumento`.`id` = `co_statidocumento_lang`.`id_record` AND |lang|)\nWHERE \n    1=1\nHAVING \n    2=2','','nav-icon fa fa-circle-o','2.4.50','2.4.50',1,NULL,1,1,0,0),(73,'Gestione task','gestione_task','gestione_task','\nSELECT\n    |select| \nFROM \n    `zz_tasks` \n    LEFT JOIN `zz_tasks_lang` ON (`zz_tasks_lang`.`id_record` = `zz_tasks`.`id` AND `zz_tasks_lang`.|lang|)\nWHERE \n    1=1 \nHAVING \n    2=2','','nav-icon fa fa-calendar','2.4.51','2.4.51',5,NULL,1,1,0,0),(74,'Automezzi','automezzi','automezzi','SELECT |select| FROM an_sedi INNER JOIN zz_settings ON (zz_settings.valore=an_sedi.idanagrafica AND zz_settings.nome=\'Azienda predefinita\' ) WHERE 1=1 AND an_sedi.is_automezzo=1 HAVING 2=2 ORDER BY nomesede ASC','','nav-icon fa fa-circle-o','1.0','2.4.16',100,20,0,1,0,0),(75,'Accesso con OAuth','oauth','oauth','SELECT |select| FROM zz_oauth2 WHERE 1=1 AND is_login=1 HAVING 2=2','','nav-icon fa fa-circle-o','1.0','2.4.54',100,NULL,1,1,0,0),(76,'Adattatori di archiviazione','adattatori_archiviazione','adattatori_archiviazione','\nSELECT\n    |select| \nFROM \n    `zz_storage_adapters` \nWHERE \n    1=1 AND `deleted_at` IS NULL\nHAVING \n    2=2','','nav-icon fa fa-folder','2.5','2.5',2,NULL,1,1,0,0),(78,'Tags','tags','tags','SELECT |select| FROM `in_tags` WHERE 1=1 HAVING 2=2','','nav-icon fa fa-circle-o','2.5.2','2.5.2',2,NULL,1,1,1,0),(79,'Marche','marche','marchi','SELECT |select| FROM `zz_marche` WHERE 1=1 AND parent = 0 HAVING 2=2 ORDER BY `zz_marche`.`name`','','fa fa-angle-right','2.6','2.6',7,NULL,1,1,1,1),(80,'Stati DDT','stati_ddt','stati_ddt','SELECT |select| FROM `dt_statiddt` LEFT JOIN `dt_statiddt_lang` ON (`dt_statiddt`.`id` = `dt_statiddt_lang`.`id_record` AND `dt_statiddt_lang`.|lang|) WHERE 1=1 AND `deleted_at` IS NULL HAVING 2=2','','fa fa-circle-o','2.6','2.6',7,NULL,1,1,1,1),(81,'Categorie contratti','categorie_contratti','categorie_contratti','\r\nSELECT\r\n |select|\r\nFROM \r\n `co_categorie_contratti`\r\n    LEFT JOIN `co_categorie_contratti_lang` ON (`co_categorie_contratti`.`id` = `co_categorie_contratti_lang`.`id_record` AND `co_categorie_contratti_lang`.|lang|)\r\nWHERE \r\n    1=1 AND `parent` IS NULL \r\nHAVING \r\n    2=2','','fa fa-briefcase','2.5.5','2.5.5',1,NULL,1,1,0,0),(82,'Descrizioni predefinite','descrizioni_predefinite','','SELECT |select| FROM `zz_default_description` WHERE 1=1 HAVING 2=2','','fa fa-circle-o','2.8','2.8',8,NULL,1,1,1,1),(83,'Categorie file','categorie_files','','SELECT |select| FROM `zz_files_categories` WHERE 1=1 AND `deleted_at` IS NULL HAVING 2=2','','fa fa-circle-o','2.8','2.8',8,NULL,1,1,1,1);
/*!40000 ALTER TABLE `zz_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_modules_lang`
--

DROP TABLE IF EXISTS `zz_modules_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_modules_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_modules_lang_ibfk_1` (`id_record`),
  KEY `zz_modules_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_modules_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_modules_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_modules_lang`
--

LOCK TABLES `zz_modules_lang` WRITE;
/*!40000 ALTER TABLE `zz_modules_lang` DISABLE KEYS */;
INSERT INTO `zz_modules_lang` VALUES (1,1,1,'Dashboard','Dashboard',''),(2,1,2,'Anagrafiche','Anagrafiche',''),(3,1,3,'Interventi','Attivit├á',''),(4,1,6,'Aggiornamenti','Aggiornamenti',''),(5,1,7,'Backup','Backup',''),(6,1,8,'Tipi di anagrafiche','Tipi di anagrafiche',''),(7,1,9,'Tipi di intervento','Tipi di attivit├á',''),(8,1,10,'Stati di intervento','Stati di attivit├á',''),(9,1,12,'Contabilit├á','Contabilit├á',''),(10,1,13,'Preventivi','Preventivi',''),(11,1,14,'Fatture di vendita','Fatture di vendita',''),(12,1,15,'Fatture di acquisto','Fatture di acquisto',''),(13,1,16,'Prima nota','Prima nota',''),(14,1,17,'Piano dei conti','Piano dei conti',''),(15,1,18,'Scadenzario','Scadenzario',''),(16,1,20,'Magazzino','Magazzino',''),(17,1,21,'Articoli','Articoli',''),(18,1,22,'Piani di sconto/maggiorazione','Piani di sconto/magg.',''),(19,1,23,'Automezzi','Automezzi',''),(20,1,24,'Ordini cliente','Ordini cliente',''),(21,1,25,'Ordini fornitore','Ordini fornitore',''),(22,1,26,'Ddt di vendita','Ddt in uscita',''),(23,1,27,'Ddt di acquisto','Ddt in entrata',''),(24,1,28,'Zone','Zone',''),(25,1,29,'Tecnici e tariffe','Tecnici e tariffe',''),(26,1,30,'Impianti','Impianti',''),(27,1,31,'Contratti','Contratti',''),(29,1,33,'Vendite','Vendite',''),(30,1,34,'Acquisti','Acquisti',''),(31,1,36,'Gestione email','Gestione email',''),(32,1,37,'Segmenti','Segmenti',''),(33,1,38,'Import','Import',''),(34,1,39,'Banche','Banche',''),(35,1,40,'Modelli prima nota','Modelli prima nota',''),(36,1,41,'Campi personalizzati','Campi personalizzati',''),(37,1,42,'Gestione documentale','Gestione documentale',''),(38,1,43,'Categorie documenti','Categorie documenti',''),(39,1,44,'Tipi di spedizione','Tipi di spedizione',''),(41,1,46,'Casse previdenziali','Casse previdenziali',''),(42,1,47,'Ritenute previdenziali','Ritenute previdenziali',''),(43,1,48,'Stati dei preventivi','Stati dei preventivi',''),(44,1,49,'Stati dei contratti','Stati dei contratti',''),(45,1,50,'Stato dei servizi','Stato dei servizi',''),(46,1,51,'Tipi scadenze','Tipi scadenze',''),(47,1,52,'Checklists','Checklists',''),(48,1,53,'Newsletter','Newsletter',''),(49,1,54,'Stato email','Coda di invio',''),(50,1,55,'Liste newsletter','Liste',''),(51,1,56,'Relazioni','Relazioni',''),(52,1,57,'Stampe','Stampe',''),(53,1,58,'Causali movimenti','Causali movimenti',''),(54,1,59,'Giacenze sedi','Giacenze sedi',''),(55,1,60,'Listini','Listini',''),(56,1,61,'Tipi documento','Tipi documento',''),(57,1,62,'Attributi Combinazioni','Attributi Combinazioni',''),(58,1,63,'Combinazioni','Combinazioni',''),(59,1,64,'Mansioni referenti','Mansioni referenti',''),(60,1,65,'Fasce orarie','Fasce orarie',''),(61,1,66,'Eventi','Eventi',''),(62,1,67,'Provenienze','Provenienze clienti',''),(63,1,68,'Settori','Settori merceologici',''),(64,1,69,'Mappa','Mappa',''),(65,1,70,'Listini cliente','Listini cliente',''),(66,1,71,'Stati degli ordini','Stati degli ordini',''),(67,1,72,'Stati fatture','Stati fatture',''),(68,1,73,'Gestione task','Gestione task',''),(69,1,74,'Automezzi','Automezzi',''),(70,1,75,'Accesso con OAuth','Accesso con OAuth',''),(128,1,76,'Adattatori di archiviazione','Adattatori di archiviazione','');
/*!40000 ALTER TABLE `zz_modules_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_oauth2`
--

DROP TABLE IF EXISTS `zz_oauth2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_oauth2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `class` varchar(255) DEFAULT NULL,
  `client_id` text,
  `client_secret` text,
  `config` text,
  `state` text,
  `access_token` text,
  `refresh_token` text,
  `after_configuration` text,
  `is_login` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_oauth2`
--

LOCK TABLES `zz_oauth2` WRITE;
/*!40000 ALTER TABLE `zz_oauth2` DISABLE KEYS */;
INSERT INTO `zz_oauth2` VALUES (1,'Microsoft','Modules\\Emails\\OAuth2\\MicrosoftLogin','','','{\"tenant_id\":\"consumers\"}','',NULL,NULL,'',1,0,'2025-07-29 12:43:02','2025-07-29 12:43:02');
/*!40000 ALTER TABLE `zz_oauth2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_permissions`
--

DROP TABLE IF EXISTS `zz_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idgruppo` int NOT NULL,
  `idmodule` int NOT NULL,
  `permessi` enum('-','r','rw') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idmodule` (`idmodule`),
  KEY `idgruppo` (`idgruppo`),
  CONSTRAINT `zz_permissions_ibfk_1` FOREIGN KEY (`idmodule`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zz_permissions_ibfk_2` FOREIGN KEY (`idgruppo`) REFERENCES `zz_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_permissions`
--

LOCK TABLES `zz_permissions` WRITE;
/*!40000 ALTER TABLE `zz_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_plugins`
--

DROP TABLE IF EXISTS `zz_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `idmodule_from` int NOT NULL,
  `idmodule_to` int NOT NULL,
  `position` varchar(50) NOT NULL,
  `script` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `order` int NOT NULL,
  `compatibility` varchar(1000) NOT NULL,
  `version` varchar(15) NOT NULL,
  `options2` text,
  `options` text,
  `directory` varchar(50) NOT NULL,
  `attachments_directory` varchar(255) NOT NULL DEFAULT '',
  `help` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idmodule_from` (`idmodule_from`),
  KEY `idmodule_to` (`idmodule_to`),
  CONSTRAINT `zz_plugins_ibfk_1` FOREIGN KEY (`idmodule_from`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zz_plugins_ibfk_2` FOREIGN KEY (`idmodule_to`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_plugins`
--

LOCK TABLES `zz_plugins` WRITE;
/*!40000 ALTER TABLE `zz_plugins` DISABLE KEYS */;
INSERT INTO `zz_plugins` VALUES (1,'Impianti del cliente',30,2,'tab','',1,1,0,'2.*','',NULL,'{ \"main_query\": [{\"type\": \"table\", \"fields\": \"Matricola, Nome, Data, Descrizione\", \"query\": \"SELECT id, (SELECT `id` FROM `zz_modules` WHERE `name` = \'Impianti\') AS _link_module_, id AS _link_record_, matricola AS Matricola, nome AS Nome, DATE_FORMAT(data, \'%d/%m/%Y\') AS Data, descrizione AS Descrizione FROM my_impianti WHERE idanagrafica=|id_parent| HAVING 2=2\"}]}','','',''),(2,'Impianti',30,3,'tab','',1,1,0,'','',NULL,'custom','impianti_intervento','impianti_intervento',''),(3,'Referenti',2,2,'tab','',1,1,0,'2.*','',NULL,'	{ \"main_query\": [	{	\"type\": \"table\", \"fields\": \"Nominativo, Mansione, Telefono, Indirizzo email, Sede\",	\"query\": \"SELECT an_referenti.id, an_referenti.nome AS Nominativo, an_mansioni.nome AS Mansione, an_referenti.telefono AS Telefono, an_referenti.email AS \'Indirizzo email\', IF(idsede = 0, \'Sede legale\', an_sedi.nomesede) AS Sede FROM an_referenti LEFT OUTER JOIN an_sedi ON idsede = an_sedi.id LEFT OUTER JOIN an_mansioni ON idmansione = an_mansioni.id WHERE 1=1 AND an_referenti.idanagrafica=|id_parent| HAVING 2=2 ORDER BY an_referenti.id DESC\"}	]}','referenti','referenti',''),(4,'Sedi aggiuntive',2,2,'tab','',1,1,0,'2.*','',NULL,' { \"main_query\": [ { \"type\": \"table\", \"fields\": \"Nome, Indirizzo, Citt├á, CAP, Provincia, Referente\", \"query\": \"SELECT an_sedi.id, an_sedi.nomesede AS Nome, an_sedi.indirizzo AS Indirizzo, an_sedi.citta AS Citt├á, an_sedi.cap AS CAP, an_sedi.provincia AS Provincia, GROUP_CONCAT(an_referenti.nome SEPARATOR \\\", \\\") AS Referente FROM an_sedi LEFT OUTER JOIN an_referenti ON idsede = an_sedi.id WHERE 1=1 AND an_sedi.idanagrafica=|id_parent| GROUP BY an_sedi.id HAVING 2=2 ORDER BY an_sedi.id DESC\"} ]}','sedi','sedi',''),(7,'Statistiche',2,2,'tab','',1,1,0,'','',NULL,'custom','statistiche_anagrafiche','statistiche_anagrafiche',''),(8,'Interventi svolti',3,30,'tab','my_impianti.interventi.php',1,1,0,'','',NULL,NULL,'','',''),(9,'Componenti ini',30,30,'tab','my_impianti.componenti.php',0,1,0,'','',NULL,NULL,'','',''),(10,'Movimenti',21,21,'tab','articoli.movimenti.php',1,1,0,'','',NULL,NULL,'','',''),(11,'Serial',21,21,'tab','articoli.lotti.php',1,1,0,'','',NULL,NULL,'','',''),(12,'Consuntivo',13,13,'tab','',1,1,0,'','',NULL,'custom','consuntivo','consuntivo',''),(13,'Consuntivo',31,31,'tab','',1,1,0,'','',NULL,'custom','consuntivo','consuntivo',''),(14,'Pianificazione interventi',31,31,'tab','',1,1,0,'','',NULL,'custom','pianificazione_interventi','pianificazione_interventi',''),(17,'Ddt del cliente',26,2,'tab','',1,1,0,'2.*','',NULL,'{ \"main_query\": [ { \"type\": \"table\", \"fields\": \"Numero, Data, Descrizione, Qt├á\", \"query\": \"SELECT `dt_ddt`.`id`, (CASE WHEN `dt_tipiddt`.`dir` = \'entrata\' THEN (SELECT `id` FROM `zz_modules` WHERE `name` = \'Ddt in uscita\') ELSE (SELECT `id` FROM `zz_modules` WHERE `name` = \'Ddt in entrata\') END) AS _link_module_, `dt_ddt`.`id` AS _link_record_, IF(`dt_ddt`.`numero_esterno` = \'\', `dt_ddt`.`numero`, `dt_ddt`.`numero_esterno`) AS Numero, DATE_FORMAT(`dt_ddt`.`data`, \'%d/%m/%Y\') AS Data, `dt_righe_ddt`.`descrizione` AS `Descrizione`, REPLACE(REPLACE(REPLACE(FORMAT(`dt_righe_ddt`.`qta`, 2), \',\', \'#\'), \'.\', \',\'), \'#\', \'.\') AS `Qt├á` FROM `dt_ddt` LEFT JOIN `dt_righe_ddt` ON `dt_ddt`.`id`=`dt_righe_ddt`.`idddt` JOIN `dt_tipiddt` ON `dt_ddt`.`idtipoddt` = `dt_tipiddt`.`id` WHERE `dt_ddt`.`idanagrafica`=|id_parent| ORDER BY `dt_ddt`.`id` DESC\"} ]}','','','Righe ddt del cliente. I ddt senza righe non saranno visualizzati.'),(18,'Revisioni',13,13,'tab','',1,1,0,'','',NULL,'custom','revisioni','revisioni',''),(19,'Giacenze',21,21,'tab','articoli.giacenze.php',1,1,0,'','',NULL,NULL,'','',''),(20,'Rinnovi',31,31,'tab','',1,1,0,'','',NULL,'custom','rinnovi_contratti','rinnovi_contratti',''),(21,'Statistiche',21,21,'tab','',1,1,0,'','',NULL,'custom','statistiche_articoli','statistiche_articoli',''),(22,'Dichiarazioni d\'Intento',14,2,'tab','',1,1,0,'','',NULL,'{ \"main_query\": [	{	\"type\": \"table\", \"fields\": \"Protocollo, Progressivo, Massimale, Totale, Data inizio, Data fine\", \"query\": \"SELECT id, numero_protocollo AS Protocollo, numero_progressivo AS Progressivo, DATE_FORMAT(data_inizio,\'%d/%m/%Y\') AS \'Data inizio\', DATE_FORMAT(data_fine,\'%d/%m/%Y\') AS \'Data fine\', ROUND(massimale, 2) AS Massimale, ROUND(totale, 2) AS Totale FROM co_dichiarazioni_intento WHERE 1=1 AND deleted_at IS NULL AND id_anagrafica = |id_parent| HAVING 2=2 ORDER BY co_dichiarazioni_intento.id DESC\"}	]}','dichiarazioni_intento','dichiarazioni_intento',''),(23,'Pianificazione fatturazione',31,31,'tab','',1,1,0,'','',NULL,'custom','pianificazione_fatturazione','pianificazione_fatturazione',''),(24,'Storico attivit├á',3,2,'tab','',1,1,0,'2.*','',NULL,' { \"main_query\": [ {  \"type\": \"table\", \"fields\": \"Numero, Data inizio, Data fine, Tipo\", \"query\": \"SELECT in_interventi.id, in_interventi.codice AS Numero, DATE_FORMAT(MAX(orario_inizio), \'%d/%m/%Y\') AS \'Data inizio\', DATE_FORMAT(MAX(orario_fine), \'%d/%m/%Y\') AS \'Data fine\', `in_tipiintervento_lang`.`title`AS \'Tipo\', (SELECT `id` FROM `zz_modules` WHERE `name` = \'Interventi\' LIMIT 1) AS _link_module_, in_interventi.id AS _link_record_ FROM in_interventi LEFT JOIN `in_interventi_tecnici` ON `in_interventi_tecnici`.`idintervento` = `in_interventi`.`id` INNER JOIN `in_statiintervento` ON `in_interventi`.`idstatointervento`=`in_statiintervento`.`id` INNER JOIN `in_tipiintervento` ON (`in_interventi`.`idtipointervento` = `in_tipiintervento`.`id`) LEFT JOIN `in_tipiintervento_lang` ON (`in_tipiintervento_lang`.`id_record` = `in_tipiintervento`.`id` AND `in_tipiintervento_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \'Lingua\')) WHERE 1=1 AND in_interventi.deleted_at IS NULL AND idanagrafica = |id_parent| GROUP BY `in_interventi`.`id` HAVING 2=2 ORDER BY in_interventi.id DESC\"}	]}','','',''),(25,'Consuntivo',24,24,'tab','',1,1,0,'','',NULL,'custom','consuntivo','consuntivo',''),(26,'Allegati',2,2,'tab','allegati.php',1,1,0,'','',NULL,NULL,'','',''),(27,'Componenti',30,30,'tab','',1,1,0,'','',NULL,'custom','componenti','componenti',''),(28,'Contratti del cliente',2,2,'tab','',1,0,0,'','',NULL,'{ \"main_query\": [ { \"type\": \"table\", \"fields\": \"Numero, Nome, Cliente, Totale, Stato, Predefinito\", \"query\": \"SELECT `co_contratti`.`id`, `numero` AS Numero, `co_contratti`.`nome` AS Nome, `an_anagrafiche`.`ragione_sociale` AS Cliente, FORMAT(`righe`.`totale_imponibile`,2) AS Totale, `co_staticontratti_lang`.`title` AS Stato, IF(`co_contratti`.`predefined`=1, \'S├î\', \'NO\') AS Predefinito FROM `co_contratti` LEFT JOIN `an_anagrafiche` ON `co_contratti`.`idanagrafica` = `an_anagrafiche`.`idanagrafica` LEFT JOIN `co_staticontratti` ON `co_contratti`.`idstato` = `co_staticontratti`.`id` LEFT JOIN `co_staticontratti_lang` ON (`co_staticontratti`.`id` = `co_staticontratti_lang`.`id_record` AND `co_staticontratti_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \'Lingua\')) LEFT JOIN (SELECT `idcontratto`, SUM(`subtotale` - `sconto`) AS `totale_imponibile`, SUM(`subtotale` - `sconto` + `iva`) AS `totale` FROM `co_righe_contratti` GROUP BY `idcontratto` ) AS righe ON `co_contratti`.`id` =`righe`.`idcontratto` WHERE 1=1 AND `co_contratti`.`idanagrafica`=|id_parent| GROUP BY `co_contratti`.`id` HAVING 2=2 ORDER BY `co_contratti`.`id` ASC\"} ]}','contratti_anagrafiche','contratti_anagrafiche',''),(29,'Movimenti contabili',15,15,'tab','',1,1,0,'','',NULL,'custom','movimenti_contabili','movimenti_contabili',''),(30,'Movimenti contabili',14,14,'tab','',1,1,0,'','',NULL,'custom','movimenti_contabili','movimenti_contabili',''),(31,'Movimenti contabili',2,2,'tab','',1,1,0,'','',NULL,'custom','movimenti_contabili','movimenti_contabili',''),(32,'Presentazioni Bancarie',18,18,'tab_main','',1,1,0,'','',NULL,'custom','presentazioni_bancarie','presentazioni_bancarie',''),(33,'Regole pagamenti',2,2,'tab','',1,1,0,'','',NULL,'{ \"main_query\": [ { \"type\": \"table\", \"fields\": \"Mese di chiusura, Giorno di riprogrammazione\", \"query\": \"SELECT id, IF(mese=\'01\', \'Gennaio\', IF(mese=\'02\', \'Febbraio\',IF(mese=\'03\', \'Marzo\',IF(mese=\'04\', \'Aprile\',IF(mese=\'05\', \'Maggio\', IF(mese=\'06\', \'Giugno\', IF(mese=\'07\', \'Luglio\',IF(mese=\'08\', \'Agosto\',IF(mese=\'09\', \'Settembre\', IF(mese=\'10\', \'Ottobre\', IF(mese=\'11\', \'Novembre\',\'Dicembre\'))))))))))) AS `Mese di chiusura`, giorno_fisso AS `Giorno di riprogrammazione` FROM an_pagamenti_anagrafiche WHERE 1=1 AND idanagrafica=|id_parent| GROUP BY id HAVING 2=2 ORDER BY an_pagamenti_anagrafiche.mese ASC\"} ]}','pagamenti_anagrafiche','pagamenti_anagrafiche',''),(34,'Registrazioni',15,15,'tab','',1,0,0,'','',NULL,'custom','registrazioni','registrazioni',''),(35,'Registrazioni',14,14,'tab','',1,0,0,'','',NULL,'custom','registrazioni','registrazioni',''),(36,'Provvigioni',21,21,'tab','',1,1,0,'','',NULL,'{ \"main_query\": [ { \"type\": \"table\", \"fields\": \"Agente, Provvigione\", \"query\": \"SELECT co_provvigioni.id, an_anagrafiche.ragione_sociale AS `Agente`, CONCAT(FORMAT(co_provvigioni.provvigione,2), \' \', IF(co_provvigioni.tipo_provvigione=\'UNT\', \'Ôé¼\', \'%\')) AS `Provvigione` FROM co_provvigioni LEFT JOIN an_anagrafiche ON co_provvigioni.idagente=an_anagrafiche.idanagrafica WHERE co_provvigioni.idarticolo=|id_parent| HAVING 2=2 ORDER BY co_provvigioni.id DESC\"} ]}','provvigioni','provvigioni',''),(37,'Statistiche vendita',21,21,'tab_main','',1,1,0,'2.*','0.1',NULL,'{\"main_query\": [{\"type\": \"table\", \"fields\": \"Articolo, Q.t├á, Percentuale tot., Totale\", \"query\": \"SELECT (SELECT `id` FROM `zz_modules` WHERE `name` = \'Articoli\') AS _link_module_, mg_articoli.id AS _link_record_, ROUND(SUM(IF(reversed=1, -co_righe_documenti.qta, co_righe_documenti.qta)),2) AS `Q.t├á`, ROUND((SUM(IF(reversed=1, -co_righe_documenti.qta, co_righe_documenti.qta)) * 100 / (SELECT SUM(IF(reversed=1, -co_righe_documenti.qta, co_righe_documenti.qta)) FROM co_documenti INNER JOIN co_tipidocumento ON co_documenti.idtipodocumento=co_tipidocumento.id INNER JOIN co_righe_documenti ON co_righe_documenti.iddocumento=co_documenti.id INNER JOIN mg_articoli ON mg_articoli.id=co_righe_documenti.idarticolo WHERE co_tipidocumento.dir=\'entrata\' )),2) AS \'Percentuale tot.\', ROUND(SUM(IF(reversed=1, -(co_righe_documenti.subtotale - co_righe_documenti.sconto), (co_righe_documenti.subtotale - co_righe_documenti.sconto))),2) AS Totale, mg_articoli.id, CONCAT(mg_articoli.codice,\' - \',mg_articoli_lang.title) AS Articolo FROM co_documenti INNER JOIN co_statidocumento ON co_statidocumento.id = co_documenti.idstatodocumento INNER JOIN co_tipidocumento ON co_documenti.idtipodocumento=co_tipidocumento.id LEFT JOIN co_statidocumento_lang ON  (co_statidocumento.id = co_statidocumento_lang.id_record AND co_statidocumento_lang.id_lang = 1) INNER JOIN co_righe_documenti ON co_righe_documenti.iddocumento=co_documenti.id INNER JOIN mg_articoli ON mg_articoli.id=co_righe_documenti.idarticolo LEFT JOIN mg_articoli_lang ON (mg_articoli.id = mg_articoli_lang.id_record AND mg_articoli_lang.id_lang = 1) WHERE 1=1 AND co_tipidocumento.dir=\'entrata\' AND (co_statidocumento_lang.title = \'Pagato\' OR co_statidocumento_lang.title = \'Parzialmente pagato\' OR co_statidocumento_lang.title = \'Emessa\' ) GROUP BY co_righe_documenti.idarticolo, mg_articoli_lang.title HAVING 2=2 ORDER BY SUM(IF(reversed=1, -co_righe_documenti.qta, co_righe_documenti.qta)) DESC\"}]}','','',''),(38,'Assicurazione crediti',2,2,'tab','',1,1,0,'2.*','',NULL,'{ \"main_query\": [ { \"type\": \"table\", \"fields\": \"Fido assicurato, Data inizio, Data fine, Totale, Residuo\", \"query\": \"SELECT id, DATE_FORMAT(data_inizio,\'%d/%m/%Y\') AS \'Data inizio\', DATE_FORMAT(data_fine,\'%d/%m/%Y\') AS \'Data fine\', ROUND(fido_assicurato, 2) AS \'Fido assicurato\', ROUND(totale, 2) AS Totale, ROUND(fido_assicurato - totale, 2) AS Residuo, IF((fido_assicurato - totale) < 0, \'#f4af1b\', \'#4dc347\') AS _bg_ FROM an_assicurazione_crediti WHERE 1=1 AND id_anagrafica = |id_parent| HAVING 2=2 ORDER BY an_assicurazione_crediti.id DESC\"} ]}','assicurazione_crediti','assicurazione_crediti',''),(39,'Mostra su mappa',3,3,'tab_main','mappa.php',1,0,0,'','',NULL,NULL,'','',''),(40,'Mandati SEPA',39,39,'tab','',1,1,0,'2.6.*','',NULL,'custom','mandati_sepa','mandati_sepa',''),(41,'Importazione FE',14,14,'tab_main','',1,1,0,'2.6.*','2.0',NULL,'custom','importFE_ZIP','importFE_ZIP','');
/*!40000 ALTER TABLE `zz_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_plugins_lang`
--

DROP TABLE IF EXISTS `zz_plugins_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_plugins_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_plugins_lang_ibfk_1` (`id_record`),
  KEY `zz_plugins_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_plugins_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_plugins` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_plugins_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_plugins_lang`
--

LOCK TABLES `zz_plugins_lang` WRITE;
/*!40000 ALTER TABLE `zz_plugins_lang` DISABLE KEYS */;
INSERT INTO `zz_plugins_lang` VALUES (1,1,1,'Impianti del cliente','Impianti del cliente'),(2,1,2,'Impianti','Impianti'),(3,1,3,'Referenti','Referenti'),(4,1,4,'Sedi','Sedi aggiuntive'),(5,1,7,'Statistiche','Statistiche'),(6,1,8,'Interventi svolti','Interventi svolti'),(7,1,9,'Componenti ini','Componenti ini'),(8,1,10,'Movimenti','Movimenti'),(9,1,11,'Serial','Serial'),(10,1,12,'Consuntivo','Consuntivo'),(11,1,13,'Consuntivo','Consuntivo'),(12,1,14,'Pianificazione interventi','Pianificazione attivit├á'),(13,1,17,'Ddt del cliente','Ddt del cliente'),(14,1,18,'Revisioni','Revisioni'),(15,1,19,'Giacenze','Giacenze'),(16,1,20,'Rinnovi','Rinnovi'),(17,1,21,'Statistiche','Statistiche'),(18,1,22,'Dichiarazioni d\'Intento','Dichiarazioni d\'Intento'),(19,1,23,'Pianificazione fatturazione','Pianificazione fatturazione'),(20,1,24,'Storico attivit├á','Storico attivit├á'),(21,1,25,'Consuntivo','Consuntivo'),(22,1,26,'Allegati','Allegati'),(23,1,27,'Componenti','Componenti'),(24,1,28,'Contratti del cliente','Contratti del cliente'),(25,1,29,'Movimenti contabili','Movimenti contabili'),(26,1,30,'Movimenti contabili','Movimenti contabili'),(27,1,31,'Movimenti contabili','Movimenti contabili'),(28,1,32,'Presentazioni Bancarie','Presentazioni Bancarie'),(29,1,33,'Regole pagamenti','Regole pagamenti'),(30,1,34,'Registrazioni','Registrazioni'),(31,1,35,'Registrazioni','Registrazioni'),(32,1,36,'Provvigioni','Provvigioni'),(33,1,37,'Statistiche vendita','Statistiche vendita');
/*!40000 ALTER TABLE `zz_plugins_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_prints`
--

DROP TABLE IF EXISTS `zz_prints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_prints` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_module` int NOT NULL,
  `is_record` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `directory` varchar(50) NOT NULL,
  `previous` varchar(50) NOT NULL,
  `options` text,
  `icon` varchar(50) NOT NULL,
  `version` varchar(15) NOT NULL,
  `compatibility` varchar(1000) NOT NULL,
  `order` int NOT NULL,
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL,
  `available_options` text,
  PRIMARY KEY (`id`),
  KEY `id_module` (`id_module`),
  CONSTRAINT `zz_prints_ibfk_1` FOREIGN KEY (`id_module`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_prints`
--

LOCK TABLES `zz_prints` WRITE;
/*!40000 ALTER TABLE `zz_prints` DISABLE KEYS */;
INSERT INTO `zz_prints` VALUES (1,1,1,'Stampa calendario','dashboard','','','fa fa-print','','',0,1,1,NULL),(2,25,1,'Ordine fornitore','ordini','idordine','{\"pricing\":true, \"images\": false}','fa fa-print','','',0,1,1,NULL),(3,14,1,'Fattura di vendita (senza intestazione)','fatture','iddocumento','{\"hide-header\": true, \"hide-footer\": true, \"last-page-footer\": true}','fa fa-print','','',0,0,1,'{\"pricing\":\"Visualizzare i prezzi\", \"hide-total\": \"Nascondere i totali delle righe\", \"show-only-total\": \"Visualizzare solo i totali del documento\", \"hide-header\": \"Nascondere intestazione\", \"hide-footer\": \"Nascondere footer\", \"last-page-footer\": \"Visualizzare footer solo su ultima pagina\", \"rows-per-page\": \"Definire il numero di righe per pagina\"}'),(4,13,1,'Preventivo (senza totali)','preventivi','idpreventivo','{\"pricing\":true, \"hide-total\":true, \"images\": true}','fa fa-print','','',0,0,1,'{\"pricing\":\"Visualizzare i prezzi\", \"hide-total\": \"Nascondere i totali delle righe\", \"show-only-total\": \"Visualizzare solo i totali del documento\", \"hide-header\": \"Nascondere intestazione\", \"hide-footer\": \"Nascondere footer\", \"last-page-footer\": \"Visualizzare footer solo su ultima pagina\", \"hide-item-number\": \"Nascondere i codici degli articoli\"}'),(5,13,1,'Preventivo (solo totale)','preventivi','idpreventivo','{\"pricing\":false, \"last-page-footer\":true, \"show-only-total\":true, \"images\": true}','fa fa-print','','',0,0,1,'{\"pricing\":\"Visualizzare i prezzi\", \"hide-total\": \"Nascondere i totali delle righe\", \"show-only-total\": \"Visualizzare solo i totali del documento\", \"hide-header\": \"Nascondere intestazione\", \"hide-footer\": \"Nascondere footer\", \"last-page-footer\": \"Visualizzare footer solo su ultima pagina\", \"hide-item-number\": \"Nascondere i codici degli articoli\"}'),(6,17,1,'Bilancio','bilancio','','{\"orientation\": \"L\"}','fa fa-print','','',0,0,1,NULL),(7,14,1,'Fattura elettronica di vendita','fatture_elettroniche','iddocumento','{\"hide-header\": true, \"hide-footer\": true}','fa fa-print','','',0,0,1,NULL),(8,15,1,'Fattura elettronica di acquisto','fatture_elettroniche','iddocumento','{\"hide-header\": true, \"hide-footer\": true}','fa fa-print','','',0,1,1,NULL),(9,24,1,'Consuntivo ordine','ordini_cons','idordine','{\"pricing\":true}','fa fa-print','','',0,0,1,NULL),(10,2,1,'Dettaglio anagrafica','anagrafiche','idanagrafica','','fa fa-print','','',0,1,1,NULL),(11,2,1,'Dati aziendali','azienda','idanagrafica','','fa fa-print','','',0,0,1,NULL),(12,2,1,'Dettaglio anagrafica','anagrafiche','idanagrafica','','fa fa-print','','',0,1,1,NULL),(13,2,1,'Dati aziendali','azienda','idanagrafica','','fa fa-print','','',0,0,1,NULL),(14,24,1,'Ordine cliente (senza codici)','ordini','idordine','{\"pricing\": true, \"last-page-footer\": true, \"hide-item-number\": true, \"images\": true}','fa fa-print','','',0,0,1,NULL),(15,16,16,'Prima nota','prima_nota','idmastrino','{\"orientation\": \"L\"}','fa fa-print','','',0,1,1,NULL),(16,3,1,'Intervento & checklist','interventi','idintervento','{\"pricing\":true, \"checklist\": true}','fa fa-print','','',0,0,1,NULL),(17,3,1,'Intervento & checklist (senza costi)','interventi','idintervento','{\"pricing\":false, \"checklist\": true}','fa fa-print','','',0,0,1,NULL),(18,21,0,'Barcode bulk','barcode_bulk','','','fa fa-print','','',0,0,1,NULL),(19,18,1,'Scadenza','scadenzario','','','fa fa-print','','',0,0,1,NULL),(20,2,1,'Provvigioni','provvigione','idanagrafica','','fa fa-print','','',0,0,1,NULL),(21,27,1,'Ddt di acquisto','ddt','idddt','{\"pricing\":true}','fa fa-print','','',0,1,1,NULL),(22,1,1,'Stampa calendario settimanale','dashboard_settimanale','','','fa fa-print','','',0,0,1,NULL),(23,13,1,'Preventivo (senza codici)','preventivi','idpreventivo','{\"pricing\": true, \"last-page-footer\": true, \"images\": true, \"hide-item-number\": true}','fa fa-print','','',0,0,1,'{\"pricing\":\"Visualizzare i prezzi\", \"hide-total\": \"Nascondere i totali delle righe\", \"show-only-total\": \"Visualizzare solo i totali del documento\", \"hide-header\": \"Nascondere intestazione\", \"hide-footer\": \"Nascondere footer\", \"last-page-footer\": \"Visualizzare footer solo su ultima pagina\", \"hide-item-number\": \"Nascondere i codici degli articoli\"}'),(24,13,1,'Preventivo(solo totale imponibile)','preventivi','idpreventivo','{\"pricing\": false, \"last-page-footer\": true, \"images\": true, \"no-iva\":true, \"show-only-total\":true }','fa fa-print','','',0,0,1,'{\"pricing\":\"Visualizzare i prezzi\", \"hide-total\": \"Nascondere i totali delle righe\", \"show-only-total\": \"Visualizzare solo i totali del documento\", \"hide-header\": \"Nascondere intestazione\", \"hide-footer\": \"Nascondere footer\", \"last-page-footer\": \"Visualizzare footer solo su ultima pagina\", \"hide-item-number\": \"Nascondere i codici degli articoli\"}'),(25,21,0,'Inventario cespiti','magazzino_cespiti','','{\"orientation\": \"L\"}','fa fa-print','','',0,0,1,NULL);
/*!40000 ALTER TABLE `zz_prints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_prints_lang`
--

DROP TABLE IF EXISTS `zz_prints_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_prints_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_prints_lang_ibfk_1` (`id_record`),
  KEY `zz_prints_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_prints_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_prints` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_prints_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_prints_lang`
--

LOCK TABLES `zz_prints_lang` WRITE;
/*!40000 ALTER TABLE `zz_prints_lang` DISABLE KEYS */;
INSERT INTO `zz_prints_lang` VALUES (1,1,1,'Stampa calendario','Stampa calendario','Calendario'),(2,1,2,'Ordine fornitore','Richiesta di acquisto (RdA)','Ordine fornitore num. {numero} del {data}'),(3,1,3,'Fattura di vendita (senza intestazione)','Fattura di vendita (senza intestazione)','Fattura num. {numero} del {data}'),(4,1,4,'Preventivo (senza totali)','Preventivo (senza totali)','Preventivo num. {numero} del {data}'),(5,1,5,'Preventivo (solo totale)','Preventivo (solo totale)','Preventivo num. {numero} del {data}'),(6,1,6,'Bilancio','Bilancio','Bilancio'),(7,1,7,'Fattura elettronica di vendita','Fattura elettronica di vendita','Fattura elettronica {numero} del {data}'),(8,1,8,'Fattura elettronica di acquisto','Fattura elettronica di acquisto','Fattura elettronica {numero} del {data}'),(9,1,9,'Consuntivo ordine','Consuntivo ordine','Consuntivo ordine num. {numero} del {data}'),(10,1,10,'Dettaglio anagrafica','Dettaglio anagrafica','Anagrafica {codice} - {ragione_sociale}'),(11,1,11,'Dati aziendali','Dati aziendali','Dati aziendali {ragione_sociale}'),(12,1,12,'Dettaglio anagrafica','Dettaglio anagrafica','Anagrafica {codice} - {ragione_sociale}'),(13,1,13,'Dati aziendali','Dati aziendali','Dati aziendali {ragione_sociale}'),(14,1,14,'Ordine cliente (senza codici)','Ordine cliente (senza codici)','Ordine cliente num. {numero} del {data}'),(15,1,15,'Prima nota','Prima nota','Prima nota del {data}'),(16,1,16,'Intervento & checklist','Intervento & checklist','Intervento num {numero} del {data}'),(17,1,17,'Intervento & checklist (senza costi)','Intervento & checklist (senza prezzi)','Intervento num {numero} del {data}'),(18,1,18,'Barcode bulk','Barcode','Barcode'),(19,1,19,'Scadenza','Scadenza','Scadenza'),(20,1,20,'Provvigioni','Provvigioni','Provvigioni {ragione_sociale}'),(21,1,21,'Ddt di acquisto','Ddt in entrata','DDT num. {numero} del {data}'),(22,1,22,'Stampa calendario settimanale','Stampa calendario settimanale','Calendario settimanale'),(23,1,23,'Preventivo (senza codici)','Preventivo (senza codici)','Preventivo num. {numero} del {data} rev {revisione}'),(24,1,24,'Preventivo(solo totale imponibile)','Preventivo (solo totale imponibile)','Preventivo num. {numero} del {data} rev {revisione}'),(25,1,25,'Inventario cespiti','Inventario cespiti','Cespiti');
/*!40000 ALTER TABLE `zz_prints_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_segments`
--

DROP TABLE IF EXISTS `zz_segments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_segments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_module` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `clause` text NOT NULL,
  `position` enum('WHR','HVN') NOT NULL DEFAULT 'WHR',
  `pattern` varchar(255) NOT NULL,
  `note` text NOT NULL,
  `dicitura_fissa` text NOT NULL,
  `predefined` tinyint(1) NOT NULL DEFAULT '0',
  `predefined_accredito` tinyint(1) NOT NULL,
  `predefined_addebito` tinyint(1) NOT NULL,
  `autofatture` tinyint(1) NOT NULL,
  `for_fe` tinyint(1) NOT NULL,
  `is_sezionale` tinyint(1) NOT NULL,
  `is_fiscale` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_segments`
--

LOCK TABLES `zz_segments` WRITE;
/*!40000 ALTER TABLE `zz_segments` DISABLE KEYS */;
INSERT INTO `zz_segments` VALUES (1,14,'Standard vendite','1=1','WHR','####/YYYY','','',1,0,0,0,1,1,1),(2,15,'Standard acquisti','1=1','WHR','#','','',1,0,0,0,1,1,1),(3,18,'Scadenzario totale','ABS(`co_scadenziario`.`pagato`) < ABS(`co_scadenziario`.`da_pagare`)','WHR','####','','',1,0,0,0,0,0,1),(4,18,'Scadenzario clienti','((SELECT dir FROM co_tipidocumento WHERE co_tipidocumento.id=co_documenti.idtipodocumento)=\'entrata\') AND ABS(`co_scadenziario`.`pagato`) < ABS(`co_scadenziario`.`da_pagare`)','WHR','####','','',0,0,0,0,0,0,0),(5,18,'Scadenzario fornitori','((SELECT dir FROM co_tipidocumento WHERE co_tipidocumento.id=co_documenti.idtipodocumento)=\'uscita\') AND ABS(`co_scadenziario`.`pagato`) < ABS(`co_scadenziario`.`da_pagare`)','WHR','####','','',0,0,0,0,0,0,0),(7,18,'Scadenzario generico','co_scadenziario.tipo=\"generico\"','WHR','####','','',0,0,0,0,0,0,0),(8,18,'Scadenzario F24','co_scadenziario.tipo=\"f24\"','WHR','####','','',0,0,0,0,0,0,0),(9,18,'Scadenzario completo','(`co_scadenziario`.`scadenza` BETWEEN \'|period_start|\' AND \'|period_end|\' AND codice_tipo_documento_fe NOT IN (\'TD16\', \'TD17\', \'TD18\', \'TD19\', \'TD20\', \'TD21\', \'TD22\', \'TD23\', \'TD26\', \'TD27\', \'TD28\'))','WHR','####','','',0,0,0,0,0,0,0),(10,3,'Standard attivit├á','1=1','WHR','#','','',1,0,0,0,0,1,0),(11,3,'Attivit├á','(orario_inizio BETWEEN \'|period_start|\' AND \'|period_end|\' OR orario_fine BETWEEN \'|period_start|\' AND \'|period_end|\')','WHR','####','','',0,0,0,0,0,0,0),(12,3,'Promemoria','((in_interventi_tecnici.orario_inizio=\'0000-00-00 00:00:00\' AND in_interventi_tecnici.orario_fine=\'0000-00-00 00:00:00\') OR in_interventi_tecnici.id IS NULL)','WHR','####','','',0,0,0,0,0,0,0),(13,60,'Tutti','1=1','WHR','####','','',1,0,0,0,0,0,0),(14,60,'Fornitori','mg_prezzi_articoli.dir=\"uscita\"','WHR','####','','',0,0,0,0,0,0,0),(15,60,'Clienti','mg_prezzi_articoli.dir=\"entrata\"','WHR','####','','',0,0,0,0,0,0,0),(16,3,'Non completate','in_interventi.idstatointervento NOT IN(SELECT in_statiintervento.id FROM in_statiintervento WHERE is_bloccato=1)','WHR','####','','',0,0,0,0,0,0,0),(17,18,'Scadenzario Ri.Ba. Clienti','co_pagamenti.codice_modalita_pagamento_fe= \'MP12\' AND co_tipidocumento.dir=\"entrata\" AND ABS(`co_scadenziario`.`pagato`) < ABS(`co_scadenziario`.`da_pagare`)','WHR','####','','',0,0,0,0,0,0,0),(18,18,'Scadenzario Ri.Ba. Fornitori','co_pagamenti.codice_modalita_pagamento_fe= \'MP12\' AND co_tipidocumento.dir=\"uscita\" AND ABS(`co_scadenziario`.`pagato`) < ABS(`co_scadenziario`.`da_pagare`)','WHR','####','','',0,0,0,0,0,0,0),(19,54,'Tutte','1=1','WHR','####','','',1,0,0,0,0,0,0),(20,54,'Non inviate','1=1 AND sent_at IS NULL','WHR','####','','',0,0,0,0,0,0,0),(21,15,'Fatture non elettroniche','1=1','WHR','#','0','0',0,0,0,0,0,1,1),(22,15,'Autofatture','1=1','WHR','####','','',0,0,0,1,1,1,1),(23,14,'Autofatture','1=1','WHR','####','','',0,0,0,1,1,1,1),(24,13,'Standard preventivi','1=1','WHR','#','','',1,0,0,0,0,1,0),(25,31,'Standard contratti','1=1','WHR','#','','',1,0,0,0,0,1,0),(26,27,'Standard ddt in entrata','1=1','WHR','#','','',1,0,0,0,0,1,0),(27,26,'Standard ddt in uscita','1=1','WHR','##','','',1,0,0,0,0,1,0),(28,24,'Standard ordini cliente','1=1','WHR','##','','',1,0,0,0,0,1,0),(29,25,'Standard ordini fornitore','1=1','WHR','#','','',1,0,0,0,0,1,0),(30,18,'Scadenzario autofatture','(codice_tipo_documento_fe IN (\'TD16\', \'TD17\', \'TD18\', \'TD19\', \'TD20\', \'TD21\', \'TD22\', \'TD23\', \'TD26\', \'TD27\', \'TD28\'))','WHR','####','','',0,0,0,0,0,0,1),(31,21,'Disponibili','1=1 AND `qta` > 0','WHR','####','','',0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `zz_segments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_segments_lang`
--

DROP TABLE IF EXISTS `zz_segments_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_segments_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_segments_lang_ibfk_1` (`id_record`),
  KEY `zz_segments_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_segments_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_segments` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_segments_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_segments_lang`
--

LOCK TABLES `zz_segments_lang` WRITE;
/*!40000 ALTER TABLE `zz_segments_lang` DISABLE KEYS */;
INSERT INTO `zz_segments_lang` VALUES (1,1,1,'Standard vendite','Standard vendite'),(2,1,2,'Standard acquisti','Standard acquisti'),(3,1,3,'Scadenzario totale','Scadenzario totale'),(4,1,4,'Scadenzario clienti','Scadenzario clienti'),(5,1,5,'Scadenzario fornitori','Scadenzario fornitori'),(6,1,7,'Scadenzario generico','Scadenzario generico'),(7,1,8,'Scadenzario F24','Scadenzario F24'),(8,1,9,'Scadenzario completo','Scadenzario completo'),(9,1,10,'Standard attivit├á','Standard attivit├á'),(10,1,11,'Attivit├á','Attivit├á'),(11,1,12,'Promemoria','Promemoria'),(12,1,13,'Tutti','Tutti'),(13,1,14,'Fornitori','Fornitori'),(14,1,15,'Clienti','Clienti'),(15,1,16,'Non completate','Non completate'),(16,1,17,'Scadenzario Ri.Ba. Clienti','Scadenzario Ri.Ba. Clienti'),(17,1,18,'Scadenzario Ri.Ba. Fornitori','Scadenzario Ri.Ba. Fornitori'),(18,1,19,'Tutte','Tutte'),(19,1,20,'Non inviate','Non inviate'),(20,1,21,'Fatture non elettroniche','Fatture non elettroniche'),(21,1,22,'Autofatture','Autofatture'),(22,1,23,'Autofatture','Autofatture'),(23,1,24,'Standard preventivi','Standard preventivi'),(24,1,25,'Standard contratti','Standard contratti'),(25,1,26,'Standard ddt in entrata','Standard ddt in entrata'),(26,1,27,'Standard ddt in uscita','Standard ddt in uscita'),(27,1,28,'Standard ordini cliente','Standard ordini cliente'),(28,1,29,'Standard ordini fornitore','Standard ordini fornitore'),(29,1,30,'Scadenzario autofatture','Scadenzario autofatture'),(30,1,31,'Disponibili','Disponibili');
/*!40000 ALTER TABLE `zz_segments_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_semaphores`
--

DROP TABLE IF EXISTS `zz_semaphores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_semaphores` (
  `id_utente` int NOT NULL,
  `posizione` varchar(255) NOT NULL,
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_semaphores`
--

LOCK TABLES `zz_semaphores` WRITE;
/*!40000 ALTER TABLE `zz_semaphores` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_semaphores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_settings`
--

DROP TABLE IF EXISTS `zz_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `valore` text,
  `tipo` varchar(1000) NOT NULL,
  `editable` tinyint(1) NOT NULL,
  `sezione` varchar(100) NOT NULL,
  `order` int DEFAULT NULL,
  `is_user_setting` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_settings`
--

LOCK TABLES `zz_settings` WRITE;
/*!40000 ALTER TABLE `zz_settings` DISABLE KEYS */;
INSERT INTO `zz_settings` VALUES (2,'Azienda predefinita','0','query=SELECT `an_anagrafiche`.`idanagrafica` AS id, `ragione_sociale` AS descrizione FROM `an_anagrafiche` INNER JOIN `an_tipianagrafiche_anagrafiche` ON `an_anagrafiche`.`idanagrafica` = `an_tipianagrafiche_anagrafiche`.`idanagrafica` WHERE `idtipoanagrafica` = (SELECT `an_tipianagrafiche`.`id` FROM `an_tipianagrafiche` LEFT JOIN `an_tipianagrafiche_lang` ON(`an_tipianagrafiche`.`id` = `an_tipianagrafiche_lang`.`id_record`) WHERE `title` = \'Azienda\') AND `deleted_at` IS NULL',1,'Generali',1,0),(6,'Iva predefinita','171','query=SELECT `co_iva`.`id`, `name` AS text FROM `co_iva` LEFT JOIN `co_iva_lang` ON (`co_iva_lang`.`id_record` = `co_iva`.`id` AND `co_iva_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Fatturazione',NULL,0),(7,'Tipo di pagamento predefinito','82','query=SELECT `co_pagamenti`.`id`, `name` AS descrizione FROM `co_pagamenti` LEFT JOIN `co_pagamenti_lang` ON (`co_pagamenti_lang`.`id_record` = `co_pagamenti`.`id` AND `co_pagamenti_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Fatturazione',NULL,0),(8,'Ritenuta d\'acconto predefinita','','query=SELECT id, descrizione FROM `co_ritenutaacconto` ORDER BY descrizione ASC',1,'Fatturazione',NULL,0),(9,'Cassa previdenziale predefinita','','query=SELECT id, descrizione FROM `co_rivalse` ORDER BY descrizione ASC',1,'Fatturazione',NULL,0),(10,'Importo marca da bollo','2','decimal',1,'Fatturazione',NULL,0),(11,'Soglia minima per l\'applicazione della marca da bollo','77.47','decimal',1,'Fatturazione',NULL,0),(12,'Conto aziendale predefinito','','query=SELECT id,descrizione FROM co_pianodeiconti3 WHERE idpianodeiconti2=(SELECT id FROM co_pianodeiconti2 WHERE descrizione=\'Cassa e banche\')',1,'Fatturazione',NULL,0),(21,'Movimenta il magazzino durante l\'inserimento o eliminazione dei lotti/serial number','1','boolean',1,'Magazzino',NULL,0),(28,'Mostra i prezzi al tecnico','1','boolean',1,'Attivit├á',NULL,0),(29,'Formato codice anagrafica','########','string',1,'Anagrafiche',NULL,0),(36,'Conto predefinito fatture di vendita','','query=SELECT id, CONCAT_WS(\' - \', numero, descrizione) AS descrizione FROM co_pianodeiconti3 WHERE dir=\'entrata\'',1,'Fatturazione',NULL,0),(37,'Conto predefinito fatture di acquisto','','query=SELECT id, CONCAT_WS(\' - \', numero, descrizione) AS descrizione FROM co_pianodeiconti3 WHERE dir=\'uscita\'',1,'Fatturazione',NULL,0),(40,'Numero di backup da mantenere','7','integer',1,'Backup',4,0),(41,'Backup automatico','0','boolean',1,'Backup',3,0),(43,'Utilizzare i tooltip sul calendario','0','boolean',1,'Dashboard',6,0),(44,'Visualizzare la domenica sul calendario','1','boolean',1,'Dashboard',7,0),(45,'Nascondere la barra sinistra di default','0','boolean',1,'Generali',2,1),(47,'Cifre decimali per importi','2','list[2,3,4,5]',1,'Generali',9,0),(48,'CSS Personalizzato','','textarea',1,'Generali',17,0),(49,'Attiva aggiornamenti','1','boolean',0,'Aggiornamenti',NULL,0),(50,'Vista dashboard','settimana','list[mese,settimana,giorno,agenda]',1,'Dashboard',5,0),(53,'Dicitura fissa fattura','Ai sensi del D.Lgs. 196/2003 Vi informiamo che i Vs. dati saranno utilizzati esclusivamente per i fini connessi ai rapporti commerciali tra di noi in essere. Contributo CONAI assolto ove dovuto - Vi preghiamo di controllare i Vs. dati anagrafici, la P. IVA e il Cod. Fiscale. Non ci riteniamo responsabili di eventuali errori.','ckeditor',1,'Fatturazione',NULL,0),(55,'Lunghezza pagine per API','200','integer',0,'API',NULL,0),(56,'Attiva notifica di presenza utenti sul record','0','boolean',1,'Generali',13,0),(57,'Timeout notifica di presenza (minuti)','15','integer',1,'Generali',14,0),(59,'Prima pagina','1','query=SELECT `zz_modules`.`id`, `title` AS descrizione FROM `zz_modules` LEFT JOIN `zz_modules_lang` ON (`zz_modules_lang`.`id_record` = `zz_modules`.`id` AND `zz_modules_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\")) WHERE `enabled` = 1 AND `options` != \"\" AND `options` != \"menu\" AND `options` IS NOT NULL ORDER BY `order` ASC',1,'Generali',11,0),(60,'Cifre decimali per quantit├á','2','list[0,1,2,3,4,5]',1,'Generali',10,0),(63,'apilayer API key for VAT number','','string',1,'API',16,0),(64,'Metodologia calcolo ritenuta d\'acconto predefinito','IMP','query=SELECT \'IMP\' AS id, \'Imponibile\' AS descrizione UNION SELECT \'IMP+RIV\' AS id, \'Imponibile + rivalsa\' AS descrizione',1,'Fatturazione',NULL,0),(65,'Cambia automaticamente stato ddt fatturati','1','boolean',1,'Ddt',NULL,0),(66,'Cambia automaticamente stato ordini fatturati','1','boolean',1,'Ordini',NULL,0),(67,'Tempo di attesa ricerche in secondi','2','integer',0,'Generali',NULL,0),(68,'Logo stampe','','string',0,'Generali',NULL,0),(69,'Abilita esportazione Excel e PDF','0','boolean',1,'Generali',18,0),(70,'Allega stampa per fattura verso Privati','0','boolean',1,'Fatturazione Elettronica',8,0),(71,'Allega stampa per fattura verso Aziende','0','boolean',1,'Fatturazione Elettronica',9,0),(72,'Allega stampa per fattura verso PA','0','boolean',1,'Fatturazione Elettronica',10,0),(73,'Regime Fiscale','','query=SELECT `codice` AS id, CONCAT(`codice`, \" - \", `name`)as descrizione FROM `fe_regime_fiscale` LEFT JOIN `fe_regime_fiscale_lang` ON (`fe_regime_fiscale_lang`.`id_record`=`fe_regime_fiscale`.`codice` AND `fe_regime_fiscale_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Fatturazione Elettronica',1,0),(74,'Tipo Cassa Previdenziale','','query=SELECT codice AS id, CONCAT_WS(\' - \', codice, descrizione) AS descrizione FROM fe_tipo_cassa',1,'Fatturazione Elettronica',2,0),(75,'Causale ritenuta d\'acconto','','query=SELECT codice AS id, CONCAT_WS(\' - \', codice, descrizione) AS descrizione FROM fe_causali_pagamento_ritenuta',1,'Fatturazione Elettronica',3,0),(76,'Authorization ID Indice PA','','string',1,'Fatturazione Elettronica',4,0),(77,'Ora inizio sul calendario','00:00:00','time',1,'Dashboard',1,0),(78,'Ora fine sul calendario','23:59:00','time',1,'Dashboard',2,0),(79,'OSMCloud Services API Token','','string',1,'Fatturazione Elettronica',11,0),(80,'OSMCloud Services API Token','','string',1,'Fatturazione Elettronica',11,0),(81,'OSMCloud Services API Token','','string',1,'Fatturazione Elettronica',11,0),(82,'Terzo intermediario','','query=SELECT `an_anagrafiche`.`idanagrafica` AS id, `ragione_sociale` AS descrizione FROM `an_anagrafiche` INNER JOIN `an_tipianagrafiche_anagrafiche` ON `an_anagrafiche`.`idanagrafica` = `an_tipianagrafiche_anagrafiche`.`idanagrafica` WHERE `idtipoanagrafica` = (SELECT `idtipoanagrafica` FROM `an_tipianagrafiche` LEFT JOIN `an_tipianagrafiche_lang` ON (`an_tipianagrafiche_lang`.`id_record` = `an_tipianagrafiche`.`id` AND `an_tipianagrafiche_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\")) WHERE `name` = \"Fornitore\") AND `deleted_at` IS NULL',1,'Fatturazione Elettronica',NULL,0),(83,'Lunghezza in pagine del buffer Datatables','10','list[5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,250,500,1000]',1,'Generali',1,0),(84,'OSMCloud Services API Version','v3','string',0,'Fatturazione Elettronica',11,0),(85,'Iva per lettere d\'intento','290','query=SELECT `co_iva`.`id`, CONCAT(`codice`,\" - \",`name`) AS descrizione FROM `co_iva` LEFT JOIN `co_iva_lang` ON (`co_iva_lang`.`id_record` = `co_iva`.`id` AND `co_iva_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\")) WHERE codice_natura_fe LIKE \"N3.%\" AND `deleted_at` IS NULL ORDER BY `name` ASC',1,'Fatturazione',11,0),(86,'Permetti inserimento sessioni degli altri tecnici','0','boolean',1,'Attivit├á',NULL,0),(87,'Conto per Riepilogativo fornitori','34','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(88,'Conto per Riepilogativo clienti','6','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(89,'Conto per Iva indetraibile','108','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(90,'Conto per Iva su vendite','106','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(91,'Conto per Iva su acquisti','107','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(92,'Conto per Erario c/ritenute d\'acconto','23','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(93,'Conto per Erario c/INPS','19','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(94,'Conto per Erario c/enasarco','24','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(95,'Conto per Apertura conti patrimoniali','104','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(96,'Conto per Chiusura conti patrimoniali','105','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei Conti',1,0),(97,'Filigrana stampe','','string',0,'Generali',NULL,0),(100,'Giorni lavorativi','Luned├¼,Marted├¼,Mercoled├¼,Gioved├¼,Venerd├¼','multiple[Luned├¼,Marted├¼,Mercoled├¼,Gioved├¼,Venerd├¼,Sabato,Domenica]',1,'Attivit├á',NULL,0),(101,'Attiva scorciatoie da tastiera','1','boolean',1,'Generali',NULL,0),(102,'Modifica Viste di default','0','boolean',0,'Generali',NULL,0),(103,'Abilita canale pre-release per aggiornamenti','0','boolean',1,'Aggiornamenti',NULL,0),(104,'Notifica al tecnico l\'aggiunta della sessione nell\'attivit├á','0','boolean',1,'Attivit├á',15,0),(105,'Notifica al tecnico la rimozione della sessione dall\'attivit├á','0','boolean',1,'Attivit├á',16,0),(106,'Totali delle tabelle ristretti alla selezione','0','boolean',1,'Generali',119,0),(107,'Google Maps API key per Tecnici','','string',1,'Applicazione',1,0),(108,'Mostra prezzi','1','boolean',1,'Applicazione',2,0),(109,'Sincronizza solo i Clienti per cui il Tecnico ha lavorato in passato','1','boolean',1,'Applicazione',3,0),(110,'Mesi per lo storico delle Attivit├á','6','integer',1,'Applicazione',3,0),(111,'Stato dell\'attivit├á alla chiusura','3','query=SELECT `in_statiintervento`.`id`, `name` AS text FROM `in_statiintervento` LEFT JOIN `in_statiintervento_lang` ON (`in_statiintervento_lang`.`id_record` = `in_statiintervento`.`id` AND `in_statiintervento_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\")) WHERE is_bloccato = 1',1,'Applicazione',1,0),(112,'Stato dell\'attivit├á dopo la firma','3','query=SELECT `in_statiintervento`.`id`, `name` AS text FROM `in_statiintervento` LEFT JOIN `in_statiintervento_lang` ON (`in_statiintervento_lang`.`id_record` = `in_statiintervento`.`id` AND `in_statiintervento_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\")) WHERE is_bloccato = 1',1,'Attivit├á',2,0),(114,'Espandi automaticamente la sezione \"Dettagli aggiuntivi\"','0','boolean',1,'Attivit├á',15,0),(115,'Conferma automaticamente le quantit├á negli ordini cliente','1','boolean',1,'Ordini',NULL,0),(116,'Conferma automaticamente le quantit├á negli ordini fornitore','1','boolean',1,'Ordini',NULL,0),(117,'Liquidazione iva','Mensile','list[Mensile,Trimestrale]',1,'Fatturazione',16,0),(118,'Nascondere la barra dei plugin di default','0','boolean',1,'Generali',2,1),(119,'Conto anticipo clienti','114','query=SELECT id, CONCAT_WS(\' - \', numero, descrizione) AS descrizione FROM co_pianodeiconti3',1,'Fatturazione',NULL,0),(120,'Conto anticipo fornitori','113','query=SELECT id, CONCAT_WS(\' - \', numero, descrizione) AS descrizione FROM co_pianodeiconti3',1,'Fatturazione',NULL,0),(121,'Alert occupazione tecnici','1','boolean',1,'Attivit├á',NULL,0),(122,'Soft quota','','integer',1,'Generali',NULL,0),(123,'Permetti selezione articoli con quantit├á minore o uguale a zero in Documenti di Vendita','0','boolean',1,'Generali',20,0),(124,'Inizio periodo calendario','','date',1,'Generali',23,1),(125,'Fine periodo calendario','','date',1,'Generali',23,1),(126,'Condizioni generali di fornitura preventivi','','ckeditor',1,'Preventivi',NULL,0),(127,'Descrizione fattura pianificata','Canone {rata} del contratto numero {numero}','text',1,'Fatturazione',NULL,0),(128,'Numero massimo di tentativi','2','integer',1,'Newsletter',1,0),(129,'Verifica numero intervento','1','boolean',1,'Attivit├á',1,0),(130,'Verifica numero intervento','1','boolean',1,'Attivit├á',1,0),(131,'Visualizza informazioni aggiuntive sul calendario','0','boolean',1,'Dashboard',1,0),(132,'Formato ore in stampa','Decimale','list[Decimale,Sessantesimi]',1,'Attivit├á',1,0),(133,'Conferma automaticamente le quantit├á nei preventivi','1','boolean',1,'Preventivi',NULL,0),(134,'Permetti il superamento della soglia quantit├á dei documenti di origine','0','boolean',1,'Generali',20,0),(135,'Numero email da inviare in contemporanea per account','10','integer',1,'Newsletter',2,0),(136,'Aggiorna info di acquisto','Non aggiornare','list[Non aggiornare,Aggiorna prezzo di listino,Aggiorna prezzo di acquisto + imposta fornitore predefinito]',1,'Fatturazione',16,0),(137,'Numero di giorni mantenimento coda di invio','0','integer',1,'Mail',1,0),(138,'Aggiungi riferimento tra documenti','1','boolean',1,'Generali',18,0),(139,'Notifica al tecnico l\'assegnazione all\'attivit├á','0','boolean',1,'Attivit├á',17,0),(140,'Notifica al tecnico la rimozione dell\'assegnazione dall\'attivit├á','0','boolean',1,'Attivit├á',18,0),(141,'Condizioni generali di fornitura contratti','','ckeditor',1,'Contratti',NULL,0),(142,'Abilita la modifica di altri tecnici','1','boolean',1,'Applicazione',4,0),(143,'Visualizzazione colori sessioni','Sfondo colore stato - bordo colore tecnico','list[Sfondo colore stato - bordo colore tecnico,Sfondo colore tecnico - bordo colore stato]',1,'Dashboard',7,0),(144,'Mantieni riferimenti tra tutti i documenti collegati','1','boolean',1,'Generali',19,0),(145,'Descrizione personalizzata in fatturazione','','textarea',1,'Attivit├á',17,0),(148,'Conto per autofattura','115','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei conti',NULL,0),(149,'Conto di secondo livello per i crediti clienti','2','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti2` WHERE idpianodeiconti1=(SELECT id FROM co_pianodeiconti1 WHERE descrizione=\"Patrimoniale\") ORDER BY `descrizione` ASC',1,'Piano dei conti',NULL,0),(150,'Conto di secondo livello per i debiti fornitori','8','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti2` WHERE idpianodeiconti1=(SELECT id FROM co_pianodeiconti1 WHERE descrizione=\"Patrimoniale\") ORDER BY `descrizione` ASC',1,'Piano dei conti',NULL,0),(151,'Data inizio controlli su stati FE','01/01/2019','date',1,'Fatturazione elettronica',23,0),(152,'Tempo predefinito di snap attivit├á sul calendario','00:15:00','string',1,'Dashboard',5,0),(153,'Aggiungi le note delle righe tra documenti','0','boolean',1,'Generali',24,0),(154,'Bloccare i prezzi inferiori al minimo di vendita','0','boolean',1,'Fatturazione',NULL,0),(155,'Visualizza promemoria','1','boolean',1,'Applicazione',5,0),(156,'Dimensione widget predefinita','col-md-3','list[col-md-1,col-md-2,col-md-3,col-md-4,col-md-6]',1,'Generali',NULL,0),(157,'Movimenta magazzino da fatture di acquisto','1','boolean',1,'Fatturazione Elettronica',NULL,0),(158,'Posizione del simbolo valuta','Dopo','list[Prima,Dopo]',1,'Generali',NULL,0),(159,'Permetti fatturazione delle attivit├á collegate a contratti','0','boolean',1,'Fatturazione',NULL,0),(160,'Stato predefinito dell\'attivit├á da Dashboard','4','query=SELECT `in_statiintervento`.`id`, `name` AS text FROM `in_statiintervento` LEFT JOIN `in_statiintervento_lang` ON (`in_statiintervento_lang`.`id_record` = `in_statiintervento`.`id` AND `in_statiintervento_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Attivit├á',NULL,0),(161,'Stato predefinito dell\'attivit├á','0','query=SELECT `in_statiintervento`.`id`, `name` AS text FROM `in_statiintervento` LEFT JOIN `in_statiintervento_lang` ON (`in_statiintervento_lang`.`id_record` = `in_statiintervento`.`id` AND `in_statiintervento_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Attivit├á',NULL,0),(162,'Data emissione fattura automatica','0','boolean',1,'Fatturazione',NULL,0),(163,'Invio solleciti in automatico','0','boolean',1,'Scadenzario',1,0),(164,'Template email primo sollecito','14','query=SELECT `em_templates`.`id`, `name` AS descrizione FROM `em_templates` LEFT JOIN `em_templates_lang` ON (`em_templates_lang`.`id_record` = `em_templates`.`id` AND `em_templates_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Scadenzario',2,0),(165,'Ritardo in giorni della scadenza della fattura per invio sollecito pagamento','12','integer',1,'Scadenzario',3,0),(166,'Ritardo in giorni dall\'ultima email per invio sollecito pagamento','10','integer',1,'Scadenzario',4,0),(167,'Visualizza solo promemoria assegnati','0','boolean',1,'Applicazione',7,0),(168,'Permetti fatturazione delle attivit├á collegate a ordini','0','boolean',1,'Fatturazione',NULL,0),(169,'Permetti fatturazione delle attivit├á collegate a preventivi','0','boolean',1,'Fatturazione',NULL,0),(170,'Serial number abilitato di default','0','boolean',1,'Magazzino',NULL,0),(171,'Rimuovi avviso fatture estere','0','boolean',1,'Fatturazione elettronica',NULL,0),(172,'Tile server OpenStreetMap','https://{s}.tile.openstreetmap.de/{z}/{x}/{y}.png','string',1,'Generali',NULL,0),(173,'Numero di minuti di avanzamento delle sessioni delle attivit├á','1','string',1,'Attivit├á',NULL,0),(174,'Sistema di firma','Base','list[Base,Tavoletta Wacom]',1,'Generali',2,0),(175,'Licenza Wacom SDK - Key','','string',1,'Tavoletta Wacom',1,0),(176,'Sfondo firma tavoletta Wacom','#d3d3d3','string',1,'Tavoletta Wacom',2,0),(177,'Luminosit├á firma Wacom','15','integer',1,'Tavoletta Wacom',3,0),(178,'Contrasto firma Wacom','3','integer',1,'Tavoletta Wacom',4,0),(179,'Tipo di sconto predefinito','%','list[%,Ôé¼]',1,'Generali',1,0),(180,'Permetti l\'accesso agli amministratori','1','boolean',1,'Applicazione',4,0),(181,'Crea contratto rinnovabile di default','0','boolean',1,'Contratti',2,0),(182,'Giorni di preavviso di default','2','decimal',1,'Contratti',3,0),(183,'Cifre decimali per importi in stampa','2','list[0,1,2,3,4,5]',1,'Generali',35,0),(184,'Cifre decimali per quantit├á in stampa','2','list[0,1,2,3,4,5]',1,'Generali',36,0),(185,'Cifre decimali per totali in stampa','2','list[0,1,2]',1,'Generali',37,0),(186,'Creazione seriali in import FE','1','boolean',1,'Fatturazione Elettronica',16,0),(187,'Secondi timeout tavoletta Wacom','15','text',1,'Tavoletta Wacom',6,0),(188,'Lingua','1','query=SELECT `id`, `name` AS descrizione FROM `zz_langs` ORDER BY `descrizione` ASC',1,'Generali',NULL,0),(189,'Licenza Wacom SDK - Secret','','string',1,'Tavoletta Wacom',1,0),(190,'Data inizio verifica contatore fattura di vendita',NULL,'date',1,'Fatturazione',NULL,0),(191,'Magazzino cespiti','','query=SELECT id, nomesede AS descrizione FROM an_sedi WHERE idanagrafica=(SELECT valore FROM zz_settings WHERE nome=\'Azienda predefinita\')',1,'Magazzino',NULL,0),(192,'Raggruppa attivit├á per tipologia in fattura','0','boolean',1,'Fatturazione',NULL,0),(193,'Giorni validit├á fattura scartata','5','int',0,'Fatturazione Elettronica',NULL,0),(194,'Esclusioni default preventivi','','textarea',1,'Preventivi',NULL,0),(195,'Visualizza numero ordine cliente','1','boolean',1,'Ordini',NULL,0),(196,'Ridimensiona automaticamente le immagini caricate','0','boolean',1,'Generali',NULL,0),(197,'Larghezza per ridimensionamento immagini','600','integer',1,'Generali',NULL,0),(198,'Template email secondo sollecito',NULL,'query=SELECT `em_templates`.`id`, `name` AS descrizione FROM `em_templates` LEFT JOIN `em_templates_lang` ON (`em_templates_lang`.`id_record` = `em_templates`.`id` AND `em_templates_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Scadenzario',3,0),(199,'Template email terzo sollecito',NULL,'query=SELECT `em_templates`.`id`, `name` AS descrizione FROM `em_templates` LEFT JOIN `em_templates_lang` ON (`em_templates_lang`.`id_record` = `em_templates`.`id` AND `em_templates_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Scadenzario',4,0),(200,'Template email mancato pagamento dopo i solleciti',NULL,'query=SELECT `em_templates`.`id`, `name` AS descrizione FROM `em_templates` LEFT JOIN `em_templates_lang` ON (`em_templates_lang`.`id_record` = `em_templates`.`id` AND `em_templates_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Scadenzario',4,0),(201,'Indirizzo email mancato pagamento dopo i solleciti','','string',1,'Scadenzario',4,0),(202,'Template email promemoria scadenza',NULL,'query=SELECT `em_templates`.`id`, `name` AS descrizione FROM `em_templates` LEFT JOIN `em_templates_lang` ON (`em_templates_lang`.`id_record` = `em_templates`.`id` AND `em_templates_lang`.`id_lang` = (SELECT `valore` FROM `zz_settings` WHERE `nome` = \"Lingua\"))',1,'Scadenzario',4,0),(203,'Intervallo di giorni in anticipo per invio promemoria scadenza','5','integer',1,'Scadenzario',4,0),(204,'Limita la visualizzazione degli impianti a quelli gestiti dal tecnico','0','boolean',1,'Applicazione',9,0),(205,'Geolocalizzazione automatica','1','boolean',1,'Anagrafiche',NULL,0),(206,'Gestore mappa','OpenStreetMap','list[Google Maps,OpenStreetMap]',1,'Generali',NULL,0),(207,'Tile server satellite','https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}','string',1,'Generali',NULL,0),(208,'Metodo di importazione XML fatture di vendita','Automatico','list[Automatico,Manuale]',1,'Fatturazione',NULL,0),(209,'Cambia automaticamente stato contratti fatturati','1','boolean',1,'Contratti',NULL,0),(210,'Cambia automaticamente stato attivit├á fatturate','1','boolean',1,'Attivit├á',NULL,0),(211,'Raggruppamento fatturazione massiva ddt','','list[cliente,sede]',1,'Ddt',NULL,0),(212,'Raggruppamento fatturazione massiva attivit├á','','list[cliente,sede]',1,'Attivit├á',NULL,0),(213,'Raggruppamento fatturazione massiva contratti','','list[cliente,sede]',1,'Contratti',NULL,0),(214,'Raggruppamento fatturazione massiva ordini','','list[cliente,sede]',1,'Ordini',NULL,0),(215,'Raggruppamento fatturazione massiva preventivi','','list[cliente,sede]',1,'Preventivi',NULL,0),(216,'Conto predefinito per le spese d\'incasso','98','query=SELECT id, descrizione FROM co_pianodeiconti3 WHERE idpianodeiconti2=(SELECT id FROM co_pianodeiconti2 WHERE descrizione=\'Ricavi\')',1,'Fatturazione',NULL,0),(217,'Rendi casuale il nome dei file allegati','1','boolean',1,'Generali',NULL,0),(218,'Endpoint ibanapi.com','https://api.ibanapi.com','string',1,'API',NULL,0),(219,'Api key ibanapi.com','','string',1,'API',NULL,0),(220,'Adattatore archiviazione backup','2','query=SELECT `id`, `name` AS descrizione FROM `zz_storage_adapters` WHERE `deleted_at` IS NULL ORDER BY `name`',1,'Backup',NULL,0),(221,'Password di protezione backup','','password',1,'Backup',NULL,0),(222,'Conto per Iva transitoria','119','query=SELECT `id`, CONCAT_WS(\' - \', `numero`, `descrizione`) AS descrizione FROM `co_pianodeiconti3` ORDER BY `descrizione` ASC',1,'Piano dei conti',NULL,0);
/*!40000 ALTER TABLE `zz_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_settings_lang`
--

DROP TABLE IF EXISTS `zz_settings_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_settings_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `help` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_settings_lang_ibfk_1` (`id_record`),
  KEY `zz_settings_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_settings_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_settings` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_settings_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_settings_lang`
--

LOCK TABLES `zz_settings_lang` WRITE;
/*!40000 ALTER TABLE `zz_settings_lang` DISABLE KEYS */;
INSERT INTO `zz_settings_lang` VALUES (1,1,193,'Giorni validit├á fattura scartata','Numero di giorni a disposizione per poter correggere una fattura scartata dallo SDI prima di non poter pi├╣ utilizzare il suo numero di fatturazione. Una volta passati i giorni indicati ├¿ necessario emettere una nuova fattura e questa passa in stato Non valida.'),(2,1,195,'Visualizza numero ordine cliente','Se abilitata, utilizza nei documenti il numero d\'ordine del cliente al posto del numero interno dell\'ordine'),(3,1,196,'Ridimensiona automaticamente le immagini caricate',''),(4,1,197,'Larghezza per ridimensionamento immagini',''),(5,2,196,'Auto resize uploaded images',''),(6,2,197,'Resizing images width',''),(7,1,198,'Template email secondo sollecito',''),(8,1,199,'Template email terzo sollecito',''),(9,1,200,'Template email mancato pagamento dopo i solleciti',''),(10,1,201,'Indirizzo email mancato pagamento dopo i solleciti',''),(11,1,202,'Template email promemoria scadenza',''),(12,1,203,'Intervallo di giorni in anticipo per invio promemoria scadenza',''),(13,1,204,'Limita la visualizzazione degli impianti a quelli gestiti dal tecnico',''),(14,1,205,'Geolocalizzazione automatica',''),(15,1,206,'Gestore mappa',''),(16,1,207,'Tile server satellite',''),(17,2,207,'Satellite tile server',''),(18,1,208,'Metodo di importazione XML fatture di vendita',NULL),(19,2,208,'Metodo di importazione XML fatture di vendita',NULL),(20,1,209,'Cambia automaticamente stato contratti fatturati',''),(21,2,209,'Automatically change the status of billed contracts',''),(22,1,210,'Cambia automaticamente stato attivit├á fatturate',''),(23,2,210,'Automatically change the status of billed activities',''),(24,1,211,'Raggruppamento fatturazione massiva ddt',''),(25,2,211,'Massive ddt billing grouping',''),(26,1,212,'Raggruppamento fatturazione massiva attivit├á',''),(27,2,212,'Massive activities billing grouping',''),(28,1,213,'Raggruppamento fatturazione massiva contratti',''),(29,2,213,'Massive contracts billing grouping',''),(30,1,214,'Raggruppamento fatturazione massiva ordini',''),(31,2,214,'Massive orders billing grouping',''),(32,1,215,'Raggruppamento fatturazione massiva preventivi',''),(33,2,215,'Massive quotes billing grouping',''),(34,1,216,'Conto predefinito per le spese d\'incasso',''),(35,2,216,'Default account for collection costs',''),(36,1,217,'Rendi casuale il nome dei file allegati',''),(37,2,217,'Randomize attachments name',''),(38,1,218,'Endpoint ibanapi.com',NULL),(39,1,219,'Api key ibanapi.com',NULL),(40,1,220,'Adattatore archiviazione backup','Adattatore di archiviazione da utilizzare per i backup'),(41,2,220,'Backup storage adapter','Storage adapter to use for backups'),(42,1,221,'Password di protezione backup','Password da utilizzare per proteggere i backup in formato zip'),(43,2,221,'Backup protection password','Password to use for protecting zip backups'),(44,1,222,'Conto per Iva transitoria',''),(45,2,222,'Conto per Iva transitoria','');
/*!40000 ALTER TABLE `zz_settings_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_storage_adapters`
--

DROP TABLE IF EXISTS `zz_storage_adapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_storage_adapters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `class` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `options` text COLLATE utf8mb4_general_ci NOT NULL,
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  `is_default` tinyint(1) NOT NULL,
  `is_local` tinyint(1) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_storage_adapters`
--

LOCK TABLES `zz_storage_adapters` WRITE;
/*!40000 ALTER TABLE `zz_storage_adapters` DISABLE KEYS */;
INSERT INTO `zz_storage_adapters` VALUES (1,'Adattatore locale','\\Modules\\FileAdapters\\Adapters\\LocalAdapter','{ \"directory\":\"/files\" }',0,1,1,NULL,'2025-07-29 12:43:31','2025-07-29 12:43:31'),(2,'Backup','\\Modules\\FileAdapters\\Adapters\\LocalAdapter','{ \"directory\":\"/files/backups\" }',1,0,1,NULL,'2025-07-29 12:45:52','2025-07-29 12:45:52');
/*!40000 ALTER TABLE `zz_storage_adapters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_tasks`
--

DROP TABLE IF EXISTS `zz_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `class` text NOT NULL,
  `expression` varchar(255) NOT NULL,
  `next_execution_at` timestamp NULL DEFAULT NULL,
  `last_executed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_tasks`
--

LOCK TABLES `zz_tasks` WRITE;
/*!40000 ALTER TABLE `zz_tasks` DISABLE KEYS */;
INSERT INTO `zz_tasks` VALUES (1,'Backup automatico','Modules\\Backups\\BackupTask','0 1 * * *',NULL,NULL),(2,'Importazione automatica Ricevute FE','Plugins\\ReceiptFE\\ReceiptTask','0 */24 * * *',NULL,NULL),(3,'Eliminazione automatica coda d\'invio','Modules\\StatoEmail\\EliminaMailTask','0 */4 * * *',NULL,NULL),(4,'Invio automatico mail','Modules\\Emails\\EmailTask','*/1 * * * *',NULL,NULL),(5,'Solleciti scadenze','Modules\\Scadenzario\\SollecitoTask','0 8 * * *',NULL,NULL);
/*!40000 ALTER TABLE `zz_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_tasks_lang`
--

DROP TABLE IF EXISTS `zz_tasks_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_tasks_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_tasks_lang_ibfk_1` (`id_record`),
  KEY `zz_tasks_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_tasks_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_tasks` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_tasks_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_tasks_lang`
--

LOCK TABLES `zz_tasks_lang` WRITE;
/*!40000 ALTER TABLE `zz_tasks_lang` DISABLE KEYS */;
INSERT INTO `zz_tasks_lang` VALUES (1,1,1,'Backup automatico','Backup automatico'),(2,1,2,'Importazione automatica Ricevute FE','Importazione automatica Ricevute FE'),(3,1,3,'Eliminazione automatica coda d\'invio','Eliminazione automatica coda d\'invio'),(4,1,4,'Invio automatico mail','Invio automatico mail'),(5,1,5,'Solleciti scadenze','Solleciti scadenze');
/*!40000 ALTER TABLE `zz_tasks_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_tasks_logs`
--

DROP TABLE IF EXISTS `zz_tasks_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_tasks_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_task` int DEFAULT NULL,
  `level` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `context` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_task` (`id_task`),
  CONSTRAINT `zz_tasks_logs_ibfk_1` FOREIGN KEY (`id_task`) REFERENCES `zz_tasks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_tasks_logs`
--

LOCK TABLES `zz_tasks_logs` WRITE;
/*!40000 ALTER TABLE `zz_tasks_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_tasks_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_user_sedi`
--

DROP TABLE IF EXISTS `zz_user_sedi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_user_sedi` (
  `id_user` int NOT NULL,
  `idsede` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_user_sedi`
--

LOCK TABLES `zz_user_sedi` WRITE;
/*!40000 ALTER TABLE `zz_user_sedi` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_user_sedi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_users`
--

DROP TABLE IF EXISTS `zz_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_users` (
  `id` int NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `image_file_id` int DEFAULT NULL,
  `options` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_users`
--

LOCK TABLES `zz_users` WRITE;
/*!40000 ALTER TABLE `zz_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_views`
--

DROP TABLE IF EXISTS `zz_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_views` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_module` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `query` text,
  `order` tinyint NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `slow` tinyint(1) NOT NULL DEFAULT '0',
  `format` tinyint(1) NOT NULL DEFAULT '0',
  `html_format` tinyint NOT NULL DEFAULT '0',
  `search_inside` varchar(255) DEFAULT NULL,
  `order_by` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `summable` tinyint(1) NOT NULL DEFAULT '0',
  `avg` tinyint(1) NOT NULL DEFAULT '0',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_module` (`id_module`),
  CONSTRAINT `zz_views_ibfk_1` FOREIGN KEY (`id_module`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=508 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_views`
--

LOCK TABLES `zz_views` WRITE;
/*!40000 ALTER TABLE `zz_views` DISABLE KEYS */;
INSERT INTO `zz_views` VALUES (1,2,'id','an_anagrafiche.idanagrafica',1,1,0,0,0,NULL,NULL,0,0,0,1),(2,2,'Ragione sociale','ragione_sociale',2,1,0,0,0,NULL,NULL,1,0,0,1),(3,2,'Tipo','GROUP_CONCAT(\' \',`an_tipianagrafiche_lang`.`title`)',3,1,0,0,0,NULL,NULL,1,0,0,1),(4,2,'Citt├á','an_anagrafiche.citta',4,1,0,0,0,NULL,NULL,1,0,0,1),(5,2,'tel_Telefono','an_anagrafiche.telefono',5,1,0,0,0,NULL,NULL,1,0,0,1),(6,2,'color_Relazione','an_relazioni.colore',6,1,0,0,0,'color_title_Relazione',NULL,1,0,0,1),(7,2,'color_title_Relazione','`an_relazioni_lang`.`title`',7,1,0,0,0,NULL,NULL,0,0,0,1),(8,3,'id','in_interventi.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(9,3,'Numero','in_interventi.codice',2,1,0,0,0,NULL,'CAST(in_interventi.codice AS UNSIGNED)',1,0,0,1),(10,3,'Ragione sociale','ragione_sociale',3,1,0,0,0,NULL,NULL,1,0,0,1),(11,3,'Data inizio','MIN(orario_inizio)',4,1,0,1,0,NULL,NULL,1,0,0,1),(12,3,'Data fine','MAX(orario_fine)',5,1,0,1,0,NULL,NULL,1,0,0,1),(13,3,'_bg_','`in_statiintervento`.`colore`',6,1,0,0,0,NULL,NULL,0,0,0,1),(14,3,'Stato','`in_statiintervento_lang`.`title`',7,1,0,0,0,NULL,NULL,1,0,0,1),(15,3,'Tipo','`in_tipiintervento_lang`.`title`',8,1,0,0,0,NULL,NULL,1,0,0,1),(16,3,'_print_','\'Intervento\'',20,0,0,0,0,NULL,NULL,1,0,0,1),(17,3,'idanagrafica','in_interventi.idanagrafica',10,1,0,0,0,NULL,NULL,0,0,0,1),(18,3,'orario_inizio','orario_inizio',11,1,0,0,0,NULL,NULL,0,0,0,1),(19,3,'data_richiesta','data_richiesta',12,1,0,0,0,NULL,NULL,0,0,0,1),(20,3,'orario_fine','orario_fine',13,1,0,0,0,NULL,NULL,0,0,0,1),(21,8,'id','`an_tipianagrafiche`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,1),(22,8,'Descrizione','`an_tipianagrafiche_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(23,9,'id','`in_tipiintervento`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,1),(24,9,'Codice','codice',2,1,0,0,0,NULL,NULL,1,0,0,1),(25,9,'Descrizione','`in_tipiintervento_lang`.`title`',3,1,0,0,0,NULL,NULL,1,0,0,1),(26,9,'Costo orario','costo_orario',4,1,0,1,0,NULL,NULL,1,0,0,1),(27,9,'Costo al km','costo_km',5,1,0,1,0,NULL,NULL,1,0,0,1),(28,9,'Diritto di chiamata','costo_diritto_chiamata',6,1,0,1,0,NULL,NULL,1,0,0,1),(29,9,'Costo orario tecnico','costo_orario_tecnico',7,1,0,1,0,NULL,NULL,1,0,0,1),(30,9,'Costo al km tecnico','costo_km_tecnico',8,1,0,1,0,NULL,NULL,1,0,0,1),(31,9,'Diritto di chiamata tecnico','costo_diritto_chiamata_tecnico',9,1,0,1,0,NULL,NULL,1,0,0,1),(32,10,'id','`in_statiintervento`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,1),(33,10,'Codice','codice',2,1,0,0,0,NULL,NULL,1,0,0,1),(34,10,'Descrizione','`in_statiintervento_lang`.`title`',3,1,0,0,0,NULL,NULL,1,0,0,1),(35,10,'color_Colore','colore',4,1,0,0,0,NULL,NULL,1,0,0,1),(36,13,'id','`co_preventivi`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,1),(37,13,'Numero','numero',2,1,0,0,0,NULL,NULL,1,0,0,1),(38,13,'Nome','`co_preventivi`.`nome`',3,1,0,0,0,NULL,NULL,1,0,0,1),(39,13,'Cliente','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(40,13,'icon_Stato','co_statipreventivi.icona',5,1,0,0,0,NULL,NULL,1,0,0,1),(41,13,'icon_title_Stato','`co_statipreventivi_lang`.`title`',6,1,0,0,0,NULL,NULL,0,0,0,1),(42,13,'data_bozza','data_bozza',7,1,0,0,0,NULL,NULL,0,0,0,1),(43,13,'data_conclusione','data_conclusione',8,1,0,0,0,NULL,NULL,0,0,0,1),(44,14,'id','co_documenti.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(45,14,'Numero','IF(co_documenti.numero_esterno=\'\', co_documenti.numero, co_documenti.numero_esterno)',2,1,0,0,0,NULL,'CAST(co_documenti.numero_esterno AS UNSIGNED)',1,0,0,1),(46,14,'Data','co_documenti.data',3,1,0,1,0,NULL,'data',1,0,0,1),(47,14,'Ragione sociale','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(48,14,'Imponibile','righe.totale_imponibile * IF(co_tipidocumento.reversed, -1, 1)',6,1,0,1,0,NULL,NULL,1,1,0,1),(49,14,'icon_Stato','co_statidocumento.icona',11,1,0,0,0,NULL,NULL,1,0,0,1),(50,14,'icon_title_Stato','`co_statidocumento_lang`.`title`',7,1,0,0,0,NULL,NULL,0,0,0,1),(51,14,'dir','dir',9,1,0,0,0,NULL,NULL,0,0,0,1),(52,15,'id','co_documenti.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(53,15,'Numero','IF(numero_esterno=\'\', numero, numero_esterno)',2,1,0,0,0,NULL,'CAST(numero_esterno AS UNSIGNED)',1,0,0,1),(54,15,'Data','data',3,1,0,1,0,NULL,'data',1,0,0,1),(55,15,'Ragione sociale','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(56,15,'Imponibile','righe.totale_imponibile * IF(co_tipidocumento.reversed, -1, 1)',6,1,0,1,0,NULL,NULL,1,1,0,1),(57,15,'icon_Stato','co_statidocumento.icona',6,1,0,0,0,NULL,NULL,1,0,0,1),(58,15,'icon_title_Stato','`co_statidocumento_lang`.`title`',7,1,0,0,0,NULL,NULL,0,0,0,1),(59,15,'dir','dir',9,1,0,0,0,NULL,NULL,0,0,0,1),(60,16,'id','co_movimenti.idmastrino',1,1,0,0,0,NULL,NULL,0,0,0,1),(61,16,'Data','co_movimenti.data',2,1,0,1,0,NULL,'data',1,0,0,1),(62,16,'Causale','co_movimenti.descrizione',3,1,0,0,0,NULL,NULL,1,0,0,1),(63,16,'Controparte','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(64,16,'Conto dare','GROUP_CONCAT(CASE WHEN totale > 0 THEN co_pianodeiconti3.descrizione ELSE NULL END)',8,1,0,0,0,NULL,NULL,1,0,0,1),(65,16,'Dare','SUM(IF(totale > 0, ABS(totale), 0))',6,1,0,1,0,NULL,NULL,1,1,0,1),(66,16,'Avere','SUM(IF(totale < 0, ABS(totale), 0))',7,1,0,1,0,NULL,NULL,1,1,0,1),(67,16,'Conto avere','GROUP_CONCAT(CASE WHEN totale < 0 THEN co_pianodeiconti3.descrizione ELSE NULL END)',9,1,0,0,0,NULL,NULL,1,0,0,1),(68,18,'id','co_scadenziario.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(69,18,'Anagrafica','an_anagrafiche.ragione_sociale',3,1,0,0,0,NULL,NULL,1,0,0,1),(70,18,'Tipo di pagamento','`co_pagamenti_lang`.`title`',4,1,0,0,0,NULL,NULL,1,0,0,1),(71,18,'Data emissione','data_emissione',5,1,0,1,0,NULL,NULL,1,0,0,1),(72,18,'Data scadenza','scadenza',6,1,0,1,0,NULL,'scadenza',1,0,0,1),(73,18,'Importo','da_pagare',7,1,0,1,0,NULL,NULL,1,1,0,1),(74,18,'Pagato','pagato',8,1,0,1,0,NULL,NULL,1,1,0,1),(75,18,'_bg_','IF(pagato = da_pagare, \'#CCFFCC\', IF(data_concordata IS NOT NULL AND data_concordata != \'0000-00-00\', IF(data_concordata < NOW(), \'#ec5353\', \'#b3d2e3\'), IF(scadenza < NOW(), \'#f08080\', IF(DATEDIFF(co_scadenziario.scadenza,NOW()) < 10, \'#f9f9c6\', \'\'))))',9,1,0,0,0,NULL,NULL,0,0,0,1),(76,18,'da_pagare','da_pagare',10,1,0,0,0,NULL,NULL,0,0,0,1),(77,18,'descrizione','`co_statidocumento_lang`.`title`',11,1,0,0,0,NULL,NULL,0,0,0,1),(78,18,'pagato_reale','pagato',12,1,0,0,0,NULL,NULL,0,0,0,1),(79,21,'id','mg_articoli.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(80,21,'Codice','mg_articoli.codice',2,1,0,0,0,NULL,NULL,1,0,0,1),(81,21,'Categoria','`zz_categorie_lang`.`title`',4,1,0,0,0,NULL,NULL,1,0,0,1),(82,21,'Sottocategoria','`sottocategorie_lang`.`title`',5,1,0,0,0,NULL,NULL,1,0,0,1),(83,21,'Q.t├á','`mg_articoli`.`qta`',9,1,0,1,0,NULL,NULL,1,1,0,1),(84,22,'id','id',1,1,0,0,0,NULL,NULL,0,0,0,1),(85,22,'Nome','nome',2,1,0,0,0,NULL,NULL,1,0,0,1),(86,22,'Percentuale guadagno o sconto','prc_guadagno',3,1,0,0,0,NULL,NULL,1,0,0,1),(87,22,'Note','note',4,1,0,0,0,NULL,NULL,1,0,0,1),(88,23,'id','id',1,1,0,0,0,NULL,NULL,0,0,0,1),(89,23,'Targa','targa',2,1,0,0,0,NULL,NULL,1,0,0,1),(90,23,'Nome','nome',3,1,0,0,0,NULL,NULL,1,0,0,1),(91,23,'Descrizione','descrizione',4,1,0,0,0,NULL,NULL,1,0,0,1),(92,24,'id','or_ordini.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(93,24,'Numero','IF(numero_esterno=\'\', numero, numero_esterno)',2,1,0,0,0,NULL,'CAST(numero_esterno AS UNSIGNED)',1,0,0,1),(94,24,'Ragione sociale','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(95,24,'icon_Stato','or_statiordine.icona',6,1,0,0,0,NULL,NULL,1,0,0,1),(96,24,'icon_title_Stato','`or_statiordine_lang`.`title`',7,1,0,0,0,NULL,NULL,0,0,0,1),(97,24,'Data','data',3,1,0,1,0,NULL,'data',1,0,0,1),(98,24,'dir','dir',8,1,0,0,0,NULL,NULL,0,0,0,1),(99,25,'id','or_ordini.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(100,25,'Numero','IF(numero_esterno=\'\', numero, numero_esterno)',2,1,0,0,0,NULL,'CAST(numero_esterno AS UNSIGNED)',1,0,0,1),(101,25,'Ragione sociale','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(102,25,'icon_Stato','or_statiordine.icona',6,1,0,0,0,NULL,NULL,1,0,0,1),(103,25,'icon_title_Stato','`or_statiordine_lang`.`title`',7,1,0,0,0,NULL,NULL,0,0,0,1),(104,25,'dir','dir',7,1,0,0,0,NULL,NULL,0,0,0,1),(105,26,'id','dt_ddt.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(106,26,'Numero','IF(numero_esterno=\'\', numero, numero_esterno)',2,1,0,0,0,NULL,'CAST(numero_esterno AS UNSIGNED)',1,0,0,1),(107,26,'Data','data',3,1,0,1,0,NULL,'data',1,0,0,1),(108,26,'Ragione sociale','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(109,26,'icon_Stato','dt_statiddt.icona',10,1,0,0,0,NULL,NULL,1,0,0,1),(110,26,'icon_title_Stato','`dt_statiddt_lang`.`title`',11,1,0,0,0,NULL,NULL,0,0,0,1),(111,26,'dir','dir',12,1,0,0,0,NULL,NULL,0,0,0,1),(112,27,'id','dt_ddt.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(113,27,'Numero','IF(numero_esterno=\'\', numero, numero_esterno)',2,1,0,0,0,NULL,'CAST(IF(numero_esterno=\"\", numero, numero_esterno) AS UNSIGNED)',1,0,0,1),(114,27,'Data','data',3,1,0,1,0,NULL,'data',1,0,0,1),(115,27,'Ragione sociale','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(116,27,'icon_Stato','dt_statiddt.icona',10,1,0,0,0,NULL,NULL,1,0,0,1),(117,27,'icon_title_Stato','`dt_statiddt_lang`.`title`',11,1,0,0,0,NULL,NULL,0,0,0,1),(118,27,'dir','dir',12,1,0,0,0,NULL,NULL,0,0,0,1),(119,28,'id','id',1,1,0,0,0,NULL,NULL,0,0,0,1),(120,28,'Nome','nome',2,1,0,0,0,NULL,NULL,1,0,0,1),(121,28,'Descrizione','descrizione',3,1,0,0,0,NULL,NULL,1,0,0,1),(122,30,'id','my_impianti.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(123,30,'Matricola','matricola',2,1,0,0,0,NULL,NULL,1,0,0,1),(124,30,'Data','data',3,1,0,1,0,NULL,'data',1,0,0,1),(125,30,'Cliente','clienti.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(126,30,'Tecnico','tecnici.ragione_sociale',5,1,0,0,0,NULL,NULL,1,0,0,1),(127,31,'id','`co_contratti`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,1),(128,31,'Numero','numero',2,1,0,0,0,NULL,'CAST(numero AS UNSIGNED)',1,0,0,1),(129,31,'Nome','`co_contratti`.`nome`',3,1,0,0,0,NULL,NULL,1,0,0,1),(130,31,'Cliente','an_anagrafiche.ragione_sociale',4,1,0,0,0,NULL,NULL,1,0,0,1),(131,31,'icon_Stato','co_staticontratti.icona',5,1,0,0,0,NULL,NULL,1,0,0,1),(132,31,'icon_title_Stato','`co_staticontratti_lang`.`title`',6,1,0,0,0,NULL,NULL,0,0,0,1),(133,31,'data_bozza','data_bozza',7,1,0,0,0,NULL,NULL,0,0,0,1),(134,31,'data_conclusione','data_conclusione',8,1,0,0,0,NULL,NULL,0,0,0,1),(138,21,'Descrizione','`mg_articoli_lang`.`title`',1,1,0,0,0,NULL,NULL,1,0,0,1),(139,30,'idanagrafica','my_impianti.idanagrafica',1,0,0,0,0,NULL,NULL,0,0,0,1),(140,14,'idanagrafica','an_anagrafiche.idanagrafica',1,0,0,0,0,NULL,NULL,0,0,0,1),(141,2,'idagente','idagente',9,0,0,0,0,NULL,NULL,0,0,0,1),(142,39,'id','co_banche.id',0,0,0,0,0,NULL,NULL,0,0,0,0),(143,39,'Nome','co_banche.nome',0,1,0,0,0,NULL,NULL,1,0,0,0),(144,39,'Filiale','co_banche.filiale',0,1,0,0,0,NULL,NULL,1,0,0,0),(145,39,'IBAN','co_banche.iban',0,1,0,0,0,NULL,NULL,1,0,0,0),(146,40,'id','co_movimenti_modelli.idmastrino',0,1,0,0,0,NULL,NULL,0,0,0,1),(147,40,'Nome','co_movimenti_modelli.nome',1,1,0,0,0,NULL,NULL,1,0,0,1),(148,31,'Impianti','impianti.descrizione',4,1,0,0,0,NULL,NULL,0,0,0,1),(149,13,'idanagrafica','co_preventivi.idanagrafica',0,0,0,0,0,NULL,NULL,0,0,0,1),(150,14,'_bg_','IF(`dup`.`numero_esterno` IS NOT NULL, \'#ec5353\', co_statidocumento.colore)',0,0,0,0,0,NULL,NULL,0,0,0,1),(151,14,'Tipo','`co_tipidocumento_lang`.`title`',4,1,0,0,0,NULL,NULL,1,0,0,1),(152,15,'Tipo','`co_tipidocumento_lang`.`title`',4,1,0,0,0,NULL,NULL,1,0,0,1),(153,30,'Sede','IF(my_impianti.idsede > 0, sede.info, CONCAT(\'\', IF (clienti.telefono!=\'\',CONCAT(clienti.telefono,\'<br>\'),\'\'), IF(clienti.cellulare!=\'\', CONCAT(clienti.cellulare,\'<br>\'),\'\'),IF(clienti.citta!=\'\',clienti.citta,\'\'),IF(clienti.indirizzo!=\'\',CONCAT(\' - \',clienti.indirizzo),\'\')))',4,1,0,0,0,NULL,NULL,0,0,0,0),(154,9,'Tempo standard','in_tipiintervento.tempo_standard',10,1,0,1,0,NULL,NULL,0,0,0,0),(155,41,'id','`zz_fields`.`id`',0,0,0,0,0,NULL,NULL,0,0,0,1),(156,41,'Modulo','`zz_modules_lang`.`title`',0,1,0,0,0,NULL,NULL,1,0,0,1),(157,41,'Plugin','`zz_plugins_lang`.`title`',0,1,0,0,0,NULL,NULL,1,0,0,1),(158,41,'Nome','`zz_fields`.`name`',0,1,0,0,0,NULL,NULL,1,0,0,1),(159,44,'Descrizione','`dt_spedizione_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(160,44,'id','`dt_spedizione`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,1),(161,37,'id','`zz_segments`.`id`',0,0,0,0,0,NULL,NULL,0,0,0,1),(162,37,'Nome','`zz_segments_lang`.`title`',1,1,0,0,0,NULL,NULL,1,0,0,1),(163,37,'Modulo','`zz_modules_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(164,37,'Maschera','pattern',3,1,0,0,0,NULL,NULL,1,0,0,1),(165,37,'Note','note',4,1,0,0,0,NULL,NULL,1,0,0,1),(166,37,'Predefinito','IF(predefined=1, \'S├¼\', \'No\')',5,1,0,0,0,NULL,NULL,1,0,0,1),(169,14,'icon_FE','`fe_stati_documento`.`icon`',10,1,0,0,0,NULL,NULL,1,0,0,0),(170,14,'icon_title_FE','`fe_stati_documento_lang`.`title`',10,1,0,0,0,NULL,NULL,0,0,0,0),(171,14,'icon_Inviata','IF(emails IS NOT NULL, \'fa fa-envelope text-success\', \'\')',11,1,0,0,0,NULL,NULL,1,0,0,0),(172,14,'icon_title_Inviata','IF(emails IS NOT NULL, \'Inviata via email\', \'\')',12,1,0,0,0,NULL,NULL,0,0,0,0),(173,2,'Codice destinatario','an_anagrafiche.codice_destinatario',4,1,0,0,0,NULL,NULL,0,0,0,0),(174,2,'Tipologia','tipo',3,1,0,0,0,NULL,NULL,1,0,0,0),(175,30,'Nome','my_impianti.nome',2,1,0,0,0,NULL,NULL,1,0,0,1),(176,44,'Predefinita','IF(predefined, \'S├¼\', \'No\')',2,1,0,0,0,NULL,NULL,0,0,0,0),(177,16,'Rif. fattura','co_documenti.numero_esterno',2,1,0,0,0,NULL,NULL,1,0,0,0),(178,3,'Tecnici','tecnici.nomi',14,1,0,0,0,NULL,NULL,1,0,0,1),(179,46,'id','id',1,1,0,0,0,NULL,NULL,0,0,0,1),(180,46,'Descrizione','descrizione',2,1,0,0,0,NULL,NULL,1,0,0,1),(181,46,'Percentuale','percentuale',3,1,0,0,0,NULL,NULL,1,0,0,1),(182,46,'Indetraibile','indetraibile',4,1,0,0,0,NULL,NULL,1,0,0,1),(183,47,'Percentuale imponibile','percentuale_imponibile',4,1,0,0,0,NULL,NULL,1,0,0,0),(184,47,'Percentuale','percentuale',3,1,0,0,0,NULL,NULL,1,0,0,0),(185,47,'Descrizione','descrizione',2,1,0,0,0,NULL,NULL,1,0,0,0),(186,47,'id','id',1,1,0,0,0,NULL,NULL,1,0,0,0),(187,15,'Conto','conti.descrizione',10,1,0,0,0,NULL,NULL,0,0,0,1),(188,48,'Fatturabile','IF(is_fatturabile, \'S&igrave;\', \'No\')',6,1,0,0,0,NULL,NULL,1,0,0,0),(189,48,'Bloccato','IF(is_bloccato, \'S├¼\', \'No\')',5,1,0,0,0,NULL,NULL,1,0,0,0),(190,48,'Pianificabile','IF(is_pianificabile, \'S&igrave;\', \'No\')',4,1,0,0,0,NULL,NULL,1,0,0,0),(191,48,'Icona','icona',3,1,0,0,0,NULL,NULL,1,0,0,0),(192,48,'Descrizione','`co_statipreventivi_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(193,48,'id','`co_statipreventivi`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(194,49,'Fatturabile','IF(is_fatturabile, \'S&igrave;\', \'No\')',6,1,0,0,0,NULL,NULL,1,0,0,0),(195,49,'Bloccato','IF(is_bloccato, \'S├¼\', \'No\')',5,1,0,0,0,NULL,NULL,1,0,0,0),(196,49,'Pianificabile','IF(is_pianificabile, \'S&igrave;\', \'No\')',4,1,0,0,0,NULL,NULL,1,0,0,0),(197,49,'Icona','icona',3,1,0,0,0,NULL,NULL,1,0,0,0),(198,49,'Descrizione','`co_staticontratti_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(199,49,'id','`co_staticontratti`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(200,18,'Rif. Fattura','IF( numero_esterno!=\"\", numero_esterno, numero )',2,1,0,0,0,NULL,NULL,1,0,0,1),(201,18,'Descrizione scadenza','co_scadenziario.descrizione',1,1,0,0,0,NULL,NULL,1,0,0,1),(202,18,'Saldo','da_pagare-pagato',13,1,1,1,0,NULL,NULL,1,1,0,1),(203,31,'Ore rimanenti','orecontratti.somma - IFNULL(tecnici.sommatecnici, 0)',5,1,0,1,0,NULL,NULL,0,0,0,0),(204,31,'Rinnovabile','IF(`co_contratti`.`rinnovabile`=1, \'S├¼\', \'No\')',6,1,0,1,0,NULL,NULL,0,0,0,0),(205,31,'Data conclusione','IF(data_conclusione=0, \'\', data_conclusione)',7,1,0,1,0,NULL,NULL,0,0,0,0),(206,24,'Imponibile','righe.totale_imponibile',5,1,0,1,0,NULL,NULL,1,1,0,0),(207,25,'Imponibile','righe.totale_imponibile',5,1,0,1,0,NULL,NULL,1,1,0,0),(208,26,'Sede partenza','IF(dt_ddt.idsede_partenza=0, \"Sede legale\",CONCAT_WS(\" - \", sedi.nomesede,sedi.citta))',5,1,0,0,0,NULL,NULL,1,0,0,0),(209,26,'Causale','`dt_causalet_lang`.`title`',6,1,0,0,0,NULL,NULL,1,0,0,0),(210,26,'Tipo spedizione','`dt_spedizione_lang`.`title`',7,1,0,1,0,NULL,NULL,1,0,0,0),(211,26,'Vettore','`vettori`.`ragione_sociale`',8,1,0,1,0,NULL,NULL,1,0,0,0),(212,26,'Imponibile','righe.totale_imponibile',9,1,0,1,0,NULL,NULL,1,1,0,0),(213,27,'Sede partenza','IF(`dt_ddt`.`idsede_partenza`=0, \"Sede legale\",CONCAT_WS(\" - \", sedi.nomesede,sedi.citta))',5,1,0,0,0,NULL,NULL,1,0,0,0),(214,27,'Causale','`dt_causalet_lang`.`title`',6,1,0,0,0,NULL,NULL,1,0,0,0),(215,27,'Tipo spedizione','`dt_spedizione_lang`.`title`',7,1,0,1,0,NULL,NULL,1,0,0,0),(216,27,'Vettore','`vettori`.`ragione_sociale`',8,1,0,1,0,NULL,NULL,1,0,0,0),(217,27,'Imponibile','righe.totale_imponibile',9,1,0,1,0,NULL,NULL,1,1,0,0),(218,3,'Richiesta','richiesta',14,1,0,0,0,NULL,NULL,0,0,0,1),(219,3,'Descrizione','in_interventi.descrizione',15,1,0,0,0,NULL,NULL,0,0,0,1),(220,26,'Sede destinazione','IF(`dt_ddt`.`idsede_destinazione`=0, \'Sede legale\',CONCAT_WS(\' - \', sedi_destinazione.nomesede,sedi_destinazione.citta))',5,1,0,0,0,NULL,NULL,1,0,0,0),(221,27,'Sede destinazione','IF(`dt_ddt`.`idsede_destinazione`=0, \'Sede legale\',CONCAT_WS(\' - \', sedi_destinazione.nomesede,sedi_destinazione.citta))',5,1,0,1,0,NULL,NULL,1,0,0,0),(222,51,'Descrizione','`co_tipi_scadenze_lang`.`title`',3,1,0,0,0,NULL,NULL,1,0,0,0),(223,51,'Nome','`co_tipi_scadenze`.`name`',2,1,0,0,0,NULL,NULL,1,0,0,0),(224,51,'id','`co_tipi_scadenze`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,0),(225,29,'_bg_','colore',3,1,0,0,0,NULL,NULL,0,0,0,0),(226,29,'Nome','ragione_sociale',2,1,0,0,0,NULL,NULL,1,0,0,0),(227,29,'id','`an_anagrafiche`.`idanagrafica`',1,1,0,0,0,NULL,NULL,0,0,0,0),(228,52,'id','`zz_checklists`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(229,52,'Nome','`zz_checklists`.`name`',2,1,0,0,0,NULL,NULL,1,0,0,1),(230,52,'Modulo','`zz_modules_lang`.`title`',5,1,0,0,0,NULL,NULL,1,0,0,1),(231,52,'Plugin','`zz_plugins_lang`.`title`',5,1,0,0,0,NULL,NULL,1,0,0,1),(232,53,'id','`em_newsletters`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(233,53,'Nome','`em_newsletters`.`name`',2,1,0,0,0,NULL,NULL,1,0,0,1),(234,53,'Template','`em_templates_lang`.`title`',3,1,0,0,0,NULL,NULL,1,0,0,1),(235,53,'Completato','IF(completed_at IS NULL OR em_newsletters.state=\'DEV\', \'No\', CONCAT(\'S├¼ \', \'(\', DATE_FORMAT(completed_at, \'%d/%m/%Y %H:%i:%s\'),\')\'))',6,1,0,0,0,NULL,NULL,1,0,0,1),(236,54,'id','`em_emails`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(237,54,'Oggetto','`em_emails`.`subject`',2,1,0,0,0,NULL,NULL,1,0,0,1),(238,54,'Contenuto','`em_emails`.`content`',3,1,0,0,0,NULL,NULL,1,0,0,0),(239,54,'Template','`em_templates`.`name`',3,1,0,0,0,NULL,NULL,1,0,0,1),(240,54,'Data invio','`em_emails`.`sent_at`',4,1,0,1,0,NULL,NULL,1,0,0,1),(241,54,'Ultimo tentativo','`em_emails`.`failed_at`',5,1,0,1,0,NULL,NULL,1,0,0,1),(242,54,'Utente','`zz_users`.`username`',6,1,0,0,0,NULL,NULL,1,0,0,1),(243,54,'_bg_','IF(em_emails.sent_at IS NULL, IF(em_emails.failed_at IS NULL, \'#f9f9c6\', \'#ec5353\'), \'#CCFFCC\')',6,1,0,0,0,NULL,NULL,0,0,0,0),(244,31,'Imponibile','righe.totale_imponibile',5,1,0,1,0,NULL,NULL,1,0,0,1),(245,13,'Imponibile','righe.totale_imponibile',5,1,0,1,0,NULL,NULL,1,0,0,1),(246,24,'Numero ordine cliente','numero_cliente',3,1,0,0,0,NULL,NULL,1,0,0,1),(247,55,'id','`em_lists`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(248,55,'Nome','`em_lists_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(249,55,'Descrizione','`em_lists_lang`.`description`',3,1,0,0,0,NULL,NULL,1,0,0,1),(250,55,'Dinamica','IF(query IS NULL, \'No\', \'Si\')',4,1,0,0,0,NULL,NULL,1,0,0,1),(251,43,'id','`do_categorie`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(252,43,'Descrizione','`do_categorie_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(253,42,'id','`do_documenti`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(254,42,'Categoria','`do_categorie_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(255,42,'Nome','`do_documenti`.`nome`',3,1,0,0,0,NULL,NULL,1,0,0,1),(256,42,'Data','`do_documenti`.`data`',4,1,0,1,0,NULL,NULL,1,0,0,1),(257,21,'Fornitore predefinito','an_anagrafiche.ragione_sociale',6,1,0,0,0,NULL,NULL,1,0,0,1),(258,21,'Prezzo di acquisto','prezzo_acquisto',6,1,0,1,0,NULL,NULL,1,0,0,1),(259,21,'Prezzo di vendita','prezzo_vendita',6,1,0,1,0,NULL,NULL,1,0,0,1),(260,54,'Modulo','`zz_modules_lang`.`title`',3,1,0,0,0,NULL,NULL,1,0,0,1),(261,54,'Destinatari','`destinatari`.`nomi`',1,1,0,0,0,NULL,NULL,1,0,0,1),(262,56,'id','an_relazioni.id',1,0,0,0,0,NULL,NULL,0,0,0,1),(263,56,'Descrizione','`an_relazioni_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(264,56,'Colore','an_relazioni.colore',3,1,0,0,0,NULL,NULL,1,0,0,1),(265,18,'Note','co_scadenziario.note',5,1,0,0,0,NULL,NULL,0,0,0,0),(266,21,'Prezzo vendita ivato','IF( co_iva.percentuale IS NOT NULL, (mg_articoli.prezzo_vendita + mg_articoli.prezzo_vendita * co_iva.percentuale / 100), mg_articoli.prezzo_vendita + mg_articoli.prezzo_vendita*iva.perc/100)',8,1,0,1,0,NULL,NULL,0,0,0,1),(267,21,'Q.t├á impegnata','IFNULL(a.qta_impegnata, 0)',10,1,0,1,0,NULL,NULL,0,1,0,1),(268,21,'Q.t├á disponibile','`mg_articoli`.`qta`-IFNULL(a.qta_impegnata, 0)',11,1,0,1,0,NULL,NULL,0,1,0,1),(269,21,'Barcode','mg_articoli.barcode',2,1,0,0,0,NULL,NULL,1,0,0,1),(272,57,'Nome del file','`zz_prints_lang`.`filename`',3,1,0,0,0,NULL,NULL,1,0,0,0),(273,57,'Titolo','`zz_prints_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(274,57,'id','zz_prints.id',1,1,0,0,0,NULL,NULL,0,0,0,0),(275,14,'Totale documento','(righe.totale_imponibile + righe.iva + `co_documenti`.`rivalsainps`) * IF(co_tipidocumento.reversed, -1, 1)',9,1,0,1,0,NULL,NULL,0,0,0,1),(276,14,'Netto a pagare','(`righe`.`totale_imponibile` + IF(`co_documenti`.`split_payment` = 0, `righe`.`iva`, 0) + `co_documenti`.`rivalsainps` - `co_documenti`.`ritenutaacconto` - `co_documenti`.`sconto_finale` - IF(`co_documenti`.`id_ritenuta_contributi` != 0, (( `righe`.`totale_imponibile` * `co_ritenuta_contributi`.`percentuale_imponibile` / 100) / 100 * `co_ritenuta_contributi`.`percentuale`), 0)) *(1 - `co_documenti`.`sconto_finale_percentuale` / 100 ) * IF(`co_tipidocumento`.`reversed`, -1, 1)',10,1,0,1,0,NULL,NULL,1,0,0,1),(277,15,'Totale documento','(righe.totale_imponibile + righe.iva + `co_documenti`.`rivalsainps` + `co_documenti`.`iva_rivalsainps`) * IF(co_tipidocumento.reversed, -1, 1)',6,1,0,1,0,NULL,NULL,1,0,0,1),(278,15,'Netto a pagare','(righe.totale_imponibile + IF(co_documenti.split_payment=0, righe.iva, 0) + `co_documenti`.`rivalsainps` + `co_documenti`.`iva_rivalsainps` - `co_documenti`.`ritenutaacconto` - `co_documenti`.`sconto_finale` - IF(`co_documenti`.`id_ritenuta_contributi`!=0, ((`righe`.`totale_imponibile`*`co_ritenuta_contributi`.`percentuale_imponibile`/100)/100*`co_ritenuta_contributi`.`percentuale`), 0)) * (1 - `co_documenti`.`sconto_finale_percentuale` / 100) * IF(co_tipidocumento.reversed, -1, 1)',7,1,0,1,0,NULL,NULL,1,0,0,1),(279,31,'Totale documento','righe.totale',5,1,0,1,0,NULL,NULL,0,0,0,1),(280,13,'Totale documento','righe.totale',5,1,0,1,0,NULL,NULL,0,0,0,1),(281,27,'Totale documento','righe.totale',9,1,0,1,0,NULL,NULL,0,0,0,1),(282,26,'Totale documento','righe.totale',9,1,0,1,0,NULL,NULL,0,0,0,1),(283,24,'Totale documento','righe.totale',5,1,0,1,0,NULL,NULL,0,0,0,1),(284,25,'Totale documento','righe.totale',5,1,0,1,0,NULL,NULL,0,0,0,1),(285,58,'Tipo','CONCAT(UCASE(LEFT(tipo_movimento, 1)), SUBSTRING(tipo_movimento, 2))',4,1,0,0,0,NULL,NULL,1,0,0,0),(286,58,'Descrizione','`mg_causali_movimenti_lang`.`description`',3,1,0,0,0,NULL,NULL,1,0,0,0),(287,58,'Nome','`mg_causali_movimenti_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(288,58,'id','`mg_causali_movimenti`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,0),(289,3,'Sede','IF(in_interventi.idsede_destinazione > 0, sede_destinazione.info, CONCAT(\'\', IF(an_anagrafiche.telefono!=\'\',CONCAT(an_anagrafiche.telefono,\'<br>\'),\'\'),IF(an_anagrafiche.cellulare!=\'\',CONCAT(an_anagrafiche.cellulare,\'<br>\'),\'\'),IF(an_anagrafiche.citta!=\'\',an_anagrafiche.citta,\'\'),IF(an_anagrafiche.indirizzo!=\'\',CONCAT(\' - \',an_anagrafiche.indirizzo),\'\')))',4,1,0,0,1,NULL,NULL,1,0,0,0),(290,3,'Rif. fattura','fattura.info',17,1,0,0,0,NULL,NULL,1,0,0,1),(291,25,'Data','or_ordini.data',3,1,0,1,0,NULL,NULL,1,0,0,0),(292,59,'_link_module_','21',1,1,0,0,0,NULL,NULL,0,0,0,1),(293,59,'id','mg_articoli.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(294,59,'Codice','mg_articoli.codice',2,1,0,0,0,NULL,NULL,1,0,0,1),(295,59,'Categoria','`categoria_lang`.`title`',4,1,0,0,0,NULL,NULL,1,0,0,1),(296,59,'Sottocategoria','`sottocategoria_lang`.`title`',5,1,0,0,0,NULL,NULL,1,0,0,1),(297,59,'Q.t├á','movimenti.qta',9,1,0,0,0,NULL,NULL,1,0,0,1),(298,59,'Descrizione','`mg_articoli_lang`.`title`',1,1,0,0,0,NULL,NULL,1,0,0,1),(299,59,'Fornitore','an_anagrafiche.ragione_sociale',6,1,0,0,0,NULL,NULL,1,0,0,1),(300,59,'Prezzo di acquisto','prezzo_acquisto',6,1,0,1,0,NULL,NULL,1,1,0,1),(301,59,'Prezzo di vendita','prezzo_vendita',6,1,0,1,0,NULL,NULL,1,1,0,1),(302,59,'Prezzo vendita ivato','IF(co_iva.percentuale IS NOT NULL, (mg_articoli.prezzo_vendita + mg_articoli.prezzo_vendita * co_iva.percentuale / 100), mg_articoli.prezzo_vendita + mg_articoli.prezzo_vendita * iva.perc / 100)',8,1,0,1,0,NULL,NULL,0,0,0,1),(303,59,'Barcode','mg_articoli.barcode',2,1,0,0,0,NULL,NULL,1,0,0,1),(304,39,'Anagrafica','an_anagrafiche.ragione_sociale',0,1,0,0,0,NULL,NULL,1,0,0,1),(305,39,'Predefinito','IF(`co_banche`.`predefined`, \'Si\', \'No\')',6,1,0,0,0,NULL,NULL,1,0,0,1),(306,60,'id','mg_prezzi_articoli.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(307,60,'Minimo','mg_prezzi_articoli.minimo',4,1,0,1,0,NULL,NULL,1,0,0,1),(308,60,'Massimo','mg_prezzi_articoli.massimo',5,1,0,1,0,NULL,NULL,1,0,0,1),(309,60,'Prezzo unitario','mg_prezzi_articoli.prezzo_unitario',6,1,0,1,0,NULL,NULL,1,0,0,1),(310,60,'Sconto percentuale','mg_prezzi_articoli.sconto_percentuale',7,1,0,1,0,NULL,NULL,1,0,0,1),(311,60,'Articolo','CONCAT(`mg_articoli`.`codice`, \" - \", `mg_articoli_lang`.`title`)',2,1,0,0,0,NULL,NULL,1,0,0,1),(312,60,'Ragione sociale','an_anagrafiche.ragione_sociale',3,1,0,0,0,NULL,NULL,1,0,0,1),(313,60,'_link_module_','zz_modules.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(314,60,'_link_record_','mg_articoli.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(315,3,'Tecnici assegnati','tecnici_assegnati.nomi',14,1,0,0,0,NULL,NULL,1,0,0,1),(316,60,'Sottocategoria','`sottocategorialang`.`title`',5,1,0,0,0,NULL,NULL,1,0,0,0),(317,60,'Categoria','`categorialang`.`title`',4,1,0,0,0,NULL,NULL,1,0,0,0),(318,61,'Attivo','co_tipidocumento.enabled',7,1,0,0,0,NULL,NULL,1,0,0,0),(319,61,'Predefinito','co_tipidocumento.predefined',6,1,0,0,0,NULL,NULL,1,0,0,0),(320,61,'Codice FE','co_tipidocumento.codice_tipo_documento_fe',5,1,0,0,0,NULL,NULL,1,0,0,0),(321,61,'Reversed','co_tipidocumento.reversed',4,1,0,0,0,NULL,NULL,1,0,0,0),(322,61,'Direzione','co_tipidocumento.dir',3,1,0,0,0,NULL,NULL,1,0,0,0),(323,61,'Descrizione','`co_tipidocumento_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(324,61,'id','`co_tipidocumento`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,0),(325,13,'Rif. fattura','fattura.info',9,1,0,0,0,NULL,NULL,1,0,0,0),(326,40,'Causale','co_movimenti_modelli.descrizione',2,1,0,0,0,NULL,NULL,1,0,0,1),(327,15,'_bg_','IF(`d`.`conteggio`>1, \'#ec5353\', co_statidocumento.colore)',1,0,0,0,0,NULL,NULL,0,0,0,1),(328,30,'Categoria','`zz_categorie_lang`.`title`',6,1,0,0,0,NULL,NULL,1,0,0,1),(329,21,'Q.t├á ordinata','ordini_fornitore.qta_ordinata',10,1,0,1,0,NULL,NULL,1,1,0,1),(330,25,'icon_Prev. evasione','IF(righe.`qta_da_evadere` > 0,IF((righe_da_evadere.data_evasione>now() OR righe_da_evadere.data_evasione IS NULL), \'fa fa-clock-o text-info\', \'fa fa-warning text-danger\'), \'fa fa-check text-success\')',8,1,0,0,0,NULL,NULL,0,0,0,0),(331,25,'icon_title_Prev. evasione','IF(righe.`qta_da_evadere` > 0,IF((righe_da_evadere.data_evasione>now() OR righe_da_evadere.data_evasione IS NULL), \'In orario\', \'In ritardo\'), \'Consegnato\')',9,1,0,0,0,NULL,NULL,0,0,0,0),(332,24,'icon_Prev. evasione','IF(righe.`qta_da_evadere` > 0,IF((righe_da_evadere.data_evasione>now() OR righe_da_evadere.data_evasione IS NULL), \'fa fa-clock-o text-info\', \'fa fa-warning text-danger\'), \'fa fa-check text-success\')',8,1,0,0,0,NULL,NULL,0,0,0,0),(333,24,'icon_title_Prev. evasione','IF(righe.`qta_da_evadere` > 0,IF((righe_da_evadere.data_evasione>now() OR righe_da_evadere.data_evasione IS NULL), \'In orario\', \'In ritardo\'), \'Consegnato\')',9,1,0,0,0,NULL,NULL,0,0,0,0),(334,57,'Modulo','`zz_modules_lang`.`title`',4,1,0,0,0,NULL,NULL,1,0,0,0),(335,57,'Predefinita','zz_prints.predefined',5,1,0,0,0,NULL,NULL,1,0,0,0),(336,57,'Ordine','zz_prints.order',6,1,0,0,0,NULL,NULL,1,0,0,0),(337,25,'icon_Prev. evasione','IF(righe.`qta_da_evadere` > 0,IF((righe_da_evadere.data_evasione>now() OR righe_da_evadere.data_evasione IS NULL), \'fa fa-clock-o text-info\', \'fa fa-warning text-danger\'), \'fa fa-check text-success\')',8,1,0,0,0,NULL,NULL,0,0,0,0),(338,25,'icon_title_Prev. evasione','IF(righe.`qta_da_evadere` > 0,IF((righe_da_evadere.data_evasione>now() OR righe_da_evadere.data_evasione IS NULL), \'In orario\', \'In ritardo\'), \'Consegnato\')',9,1,0,0,0,NULL,NULL,0,0,0,0),(339,24,'icon_Prev. evasione','IF(righe.`qta_da_evadere` > 0,IF((righe_da_evadere.data_evasione>now() OR righe_da_evadere.data_evasione IS NULL), \'fa fa-clock-o text-info\', \'fa fa-warning text-danger\'), \'fa fa-check text-success\')',8,1,0,0,0,NULL,NULL,0,0,0,0),(340,24,'icon_title_Prev. evasione','IF(righe.`qta_da_evadere` > 0,IF((righe_da_evadere.data_evasione>now() OR righe_da_evadere.data_evasione IS NULL), \'In orario\', \'In ritardo\'), \'Consegnato\')',9,1,0,0,0,NULL,NULL,0,0,0,0),(341,57,'Modulo','`zz_modules_lang`.`title`',4,1,0,0,0,NULL,NULL,1,0,0,0),(342,57,'Predefinita','zz_prints.predefined',5,1,0,0,0,NULL,NULL,1,0,0,0),(343,57,'Ordine','zz_prints.order',6,1,0,0,0,NULL,NULL,1,0,0,0),(344,15,'N. Prot.','co_documenti.numero',1,1,0,0,0,NULL,'CAST(co_documenti.numero AS UNSIGNED)',0,0,0,0),(345,53,'Stato','IF(em_newsletters.state = \'DEV\', \'Bozza\', IF(em_newsletters.state = \'WAIT\', \'Invio in corso\', \'Completata\'))',4,1,0,0,0,NULL,NULL,1,0,0,0),(346,53,'Destinatari','`totale`',5,1,0,0,0,NULL,NULL,1,0,0,0),(347,3,'Referente','`an_referenti`.`nome`',7,1,0,0,0,NULL,NULL,1,0,0,0),(348,18,'Scaduto','IF(pagato = da_pagare, \'NO\', IF(data_concordata IS NOT NULL AND data_concordata > NOW(), \'NO\', IF(scadenza < NOW(), \'S├î\', \'NO\')))',14,1,0,0,0,NULL,NULL,1,0,0,0),(349,24,'Riferimenti','CONCAT(IF(fattura.info != \"\", fattura.info,\"\"), IF(ddt.info != \"\", ddt.info,\"\"))',11,1,0,0,0,NULL,NULL,1,0,0,0),(350,25,'Rif. fattura','fattura.info',8,1,0,0,0,NULL,NULL,1,0,0,0),(351,2,'Referenti','referenti.nomi',11,1,0,0,0,NULL,NULL,1,0,0,1),(352,2,'Sedi','sedi.nomi',10,1,0,0,0,NULL,NULL,1,0,0,1),(353,62,'id','mg_attributi.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(354,62,'Nome','`mg_attributi_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(355,63,'id','mg_combinazioni.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(356,63,'Nome','`mg_combinazioni_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(357,14,'Banca','`banche`.`descrizione`',6,1,0,0,0,NULL,NULL,1,0,0,1),(358,15,'Banca','banche.descrizione',6,1,0,0,0,NULL,NULL,1,0,0,1),(359,3,'icon_Inviata','IF(emails IS NOT NULL, \'fa fa-envelope text-success\', \'\')',18,1,0,0,0,NULL,NULL,1,0,0,0),(360,3,'icon_title_Inviata','IF(emails IS NOT NULL, \'Inviata via email\', \'\')',19,1,0,0,0,NULL,NULL,0,0,0,0),(361,63,'Codice','mg_combinazioni.codice',1,1,0,0,0,NULL,NULL,1,0,0,0),(362,64,'id','an_mansioni.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(363,64,'Nome','an_mansioni.nome',2,1,0,0,0,NULL,NULL,1,0,0,1),(364,54,'Tentativi','`em_emails`.`attempt`',7,1,0,0,0,NULL,NULL,1,0,0,0),(365,54,'Data creazione','`em_emails`.`created_at`',9,1,0,1,0,NULL,NULL,1,0,0,0),(366,18,'Distinta','co_scadenziario.distinta',15,1,0,0,0,NULL,NULL,0,0,0,1),(367,24,'icon_Inviato','IF(emails IS NOT NULL, \'fa fa-envelope text-success\', \'\')',12,1,0,0,0,NULL,NULL,1,0,0,0),(368,25,'icon_Inviato','IF(emails IS NOT NULL, \'fa fa-envelope text-success\', \'\')',12,1,0,0,0,NULL,NULL,0,0,0,0),(369,18,'icon_Inviato','IF(emails IS NOT NULL, \'fa fa-envelope text-success\', \'\')',16,1,0,0,0,NULL,NULL,1,0,0,1),(370,18,'icon_title_Inviato','IF(emails IS NOT NULL, \'S├î\', \'NO\')',17,1,0,0,0,NULL,NULL,0,0,0,1),(371,2,'Codice','an_anagrafiche.codice',1,1,0,0,0,NULL,NULL,0,0,0,1),(372,21,'Servizio','IF(mg_articoli.servizio, \'S├¼\', \'No\')',13,1,0,0,0,NULL,NULL,1,0,0,1),(373,60,'Codice','fornitore.codice',8,1,0,0,1,NULL,NULL,0,0,0,1),(374,60,'Barcode','fornitore.barcode',9,1,0,0,1,NULL,NULL,0,0,0,1),(375,3,'Impianti','impianti.descrizione',16,1,0,0,1,NULL,NULL,0,0,0,1),(376,65,'id','in_fasceorarie.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(377,65,'Nome','`in_fasceorarie_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(378,65,'Giorni','IF(in_fasceorarie.giorni = \'1,2,3,4,5\', \'Lavorativi\',  IF(in_fasceorarie.giorni = \'6,7\', \'Fine settimana\', IF(in_fasceorarie.giorni = \'6\', \'Solo Sabato\', IF(in_fasceorarie.giorni = \'1,2,3,4,5,6,7\', \'Tutti\', \'Solo inclusi\' ))))',3,1,0,0,0,NULL,NULL,1,0,0,1),(379,65,'Ora inizio','in_fasceorarie.ora_inizio',4,1,0,1,0,NULL,NULL,1,0,0,1),(380,65,'Ora fine','in_fasceorarie.ora_fine',5,1,0,1,0,NULL,NULL,1,0,0,1),(381,65,'Includi festivit├á','IF(in_fasceorarie.include_bank_holidays, \'S&igrave;\', \'No\')',6,1,0,0,0,NULL,NULL,1,0,0,1),(382,66,'id','zz_events.id',1,1,0,0,0,NULL,NULL,0,0,0,1),(383,66,'Nome','zz_events.nome',2,1,0,0,0,NULL,NULL,1,0,0,1),(384,66,'Nazione','`an_nazioni_lang`.`title`',3,1,0,0,0,NULL,NULL,1,0,0,1),(385,66,'Data','zz_events.data',4,1,0,1,0,NULL,NULL,1,0,0,1),(386,66,'Ricorrente','IF(zz_events.is_recurring, \'S&igrave;\', \'No\')',5,1,0,0,0,NULL,NULL,1,0,0,1),(387,66,'Festivit├á','IF(zz_events.is_bank_holiday, \'S&igrave;\', \'No\')',6,1,0,0,0,NULL,NULL,1,0,0,1),(388,3,'Contratto','contratto.info',21,1,0,0,0,NULL,NULL,0,0,0,1),(389,3,'Preventivo','preventivo.info',22,1,0,0,0,NULL,NULL,0,0,0,1),(390,3,'Ordine','ordine.info',23,1,0,0,0,NULL,NULL,0,0,0,1),(391,3,'Ricavi','IFNULL(SUM(in_interventi_tecnici.prezzo_ore_unitario*in_interventi_tecnici.ore-in_interventi_tecnici.sconto + in_interventi_tecnici.prezzo_km_unitario*in_interventi_tecnici.km-in_interventi_tecnici.scontokm + in_interventi_tecnici.prezzo_dirittochiamata), 0) + IFNULL(ricavo_righe, 0)',21,1,0,1,0,NULL,NULL,0,1,0,1),(392,3,'Costi','IFNULL(SUM(in_interventi_tecnici.prezzo_ore_unitario_tecnico*in_interventi_tecnici.ore + in_interventi_tecnici.prezzo_km_unitario_tecnico*in_interventi_tecnici.km + in_interventi_tecnici.prezzo_dirittochiamata_tecnico), 0) + IFNULL(costo_righe, 0)',20,1,0,1,0,NULL,NULL,0,1,0,1),(393,3,'Ore','SUM(in_interventi_tecnici.ore)',28,1,0,1,0,NULL,NULL,0,1,0,1),(394,67,'id','an_provenienze.id',1,1,0,0,0,NULL,NULL,1,0,0,1),(395,67,'descrizione','`an_provenienze_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(396,67,'colore','an_provenienze.colore',3,1,0,0,0,NULL,NULL,1,0,0,1),(397,68,'id','an_settori.id',1,1,0,0,0,NULL,NULL,1,0,0,1),(398,68,'descrizione','`an_settori_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,1),(399,14,'Pagamento','`co_pagamenti_lang`.`title`',13,1,0,0,0,NULL,NULL,0,0,0,1),(400,15,'Pagamento','`co_pagamenti_lang`.`title`',13,1,0,0,0,NULL,NULL,0,0,0,1),(401,2,'Indirizzo','an_anagrafiche.indirizzo',13,1,0,0,0,NULL,NULL,0,0,0,1),(402,2,'tel_Cellulare','an_anagrafiche.cellulare',14,1,0,0,0,NULL,NULL,0,0,0,1),(403,13,'_bg_','co_statipreventivi.colore',10,0,0,0,0,NULL,NULL,0,0,0,1),(404,48,'color_Colore','colore',7,1,0,0,0,NULL,NULL,1,0,0,1),(405,70,'id','`mg_listini`.`id`',1,1,0,0,0,NULL,NULL,0,0,0,1),(406,70,'Nome','nome',2,1,0,0,0,NULL,NULL,1,0,0,1),(407,70,'Data attivazione','data_attivazione',3,1,0,1,0,NULL,NULL,1,0,0,1),(408,70,'Articoli','`articoli`.`num`',4,1,0,0,0,NULL,NULL,1,0,0,1),(409,70,'Anagrafiche','`anagrafiche`.`num`',5,1,0,0,0,NULL,NULL,1,0,0,1),(410,70,'Ultima modifica','`utente`.`username`',6,1,0,0,0,NULL,NULL,1,0,0,1),(411,70,'Sempre visibile','IF(is_sempre_visibile=0,\'NO\',\'S├î\')',7,1,0,0,0,NULL,NULL,1,0,0,1),(412,70,'Attivo','IF(attivo=0,\'NO\',\'S├î\')',7,1,0,0,0,NULL,NULL,1,0,0,1),(413,2,'Pagamento cliente','`pagvendita`.`nome`',15,1,0,0,0,NULL,NULL,0,0,0,0),(414,2,'Pagamento fornitore','`pagacquisto`.`nome`',16,1,0,0,0,NULL,NULL,0,0,0,0),(415,13,'Agente','`agente`.`nome`',11,1,0,0,0,NULL,NULL,0,0,0,0),(416,26,'icon_Inviato','IF(emails IS NOT NULL, \'fa fa-envelope text-success\', \'\')',13,1,0,0,0,NULL,NULL,0,0,0,0),(417,18,'Banca azienda','`co_banche`.`nome`',18,1,0,0,0,NULL,NULL,0,0,0,0),(418,3,'KM','sum(in_interventi_tecnici.km)',29,1,0,1,0,NULL,NULL,0,1,0,0),(419,37,'Gruppi con accesso','`t`.`gruppi`',6,1,0,0,0,NULL,NULL,1,0,0,1),(420,13,'_print_','\'Preventivo\'',12,0,0,0,0,NULL,NULL,0,0,0,1),(421,24,'_print_','\'Ordine cliente\'',13,0,0,0,0,NULL,NULL,0,0,0,1),(422,26,'_print_','\'Ddt di vendita\'',14,0,0,0,0,NULL,NULL,0,0,0,1),(423,14,'_print_','\'Fattura di vendita\'',14,0,0,0,0,NULL,NULL,0,0,0,1),(424,14,'Prima nota','`primanota`.`totale`',15,1,0,1,0,NULL,NULL,0,0,0,1),(425,13,'icon_Inviata','IF(emails IS NOT NULL, \'fa fa-envelope text-success\', \'\')',16,1,0,0,0,NULL,NULL,1,0,0,0),(426,13,'icon_title_Inviata','IF(emails IS NOT NULL, \'Inviato via email\', \'\')',17,1,0,0,0,NULL,NULL,0,0,0,0),(427,18,'Scadenza giorni','DATEDIFF(co_scadenziario.scadenza,NOW())',19,1,0,0,0,'','',1,0,0,1),(428,31,'Agente','`agente`.`ragione_sociale`',15,1,0,0,0,NULL,NULL,0,0,0,1),(429,71,'Fatturabile','IF(is_fatturabile, \'S&igrave;\', \'No\')',6,1,0,0,0,NULL,NULL,1,0,0,0),(430,71,'Bloccato','IF(is_bloccato, \'S├¼\', \'No\')',5,1,0,0,0,NULL,NULL,1,0,0,0),(431,71,'Impegnato','IF(impegnato, \'S&igrave;\', \'No\')',4,1,0,0,0,NULL,NULL,1,0,0,0),(432,71,'Icona','icona',3,1,0,0,0,NULL,NULL,1,0,0,0),(433,71,'Descrizione','`or_statiordine_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(434,71,'id','`or_statiordine`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(435,27,'Riferimenti','IF(fattura.info != \"\", fattura.info,\"\")',15,1,0,0,0,NULL,NULL,0,0,0,0),(436,70,'Data scadenza','data_scadenza_predefinita',3,1,0,1,0,NULL,NULL,1,0,0,1),(438,49,'color_Colore','colore',7,0,0,1,0,'','',1,0,0,0),(439,71,'color_Colore','colore',7,0,0,1,0,'','',1,0,0,0),(440,24,'_bg_','or_statiordine.colore',14,0,0,1,0,'','',0,0,0,0),(441,25,'_bg_','or_statiordine.colore',14,0,0,1,0,'','',0,0,0,0),(442,31,'_bg_','co_staticontratti.colore',14,0,0,1,0,'','',0,0,0,0),(443,26,'_bg_','dt_statiddt.colore',14,0,0,1,0,'','',0,0,0,0),(444,27,'_bg_','dt_statiddt.colore',14,0,0,1,0,'','',0,0,0,0),(445,61,'Sezionale','`zz_segments_lang`.`title`',8,1,0,0,0,'','',1,0,0,0),(446,18,'Esportazione distinta','presentazioni_exported_at',20,1,0,1,0,'','',1,0,0,0),(447,26,'Riferimenti','IF(fattura.info != \"\", fattura.info,\"\")',16,1,0,0,0,NULL,NULL,0,0,0,0),(448,72,'Icona','icona',3,1,0,0,0,NULL,NULL,1,0,0,0),(449,72,'Descrizione','`co_statidocumento_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(450,72,'id','`co_statidocumento`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(451,72,'color_Colore','colore',1,0,0,0,0,NULL,NULL,0,0,0,1),(452,3,'Allegati','IF(`files`.`name` != \'\', `files`.`name`, \'No\')',30,1,0,0,0,'','',0,0,0,0),(453,73,'id','`zz_tasks`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(454,73,'Nome','`zz_tasks_lang`.`title`',1,1,0,0,0,NULL,NULL,1,0,0,1),(455,73,'Expression','expression',2,1,0,0,0,NULL,NULL,1,0,0,0),(456,73,'Prossima esecuzione','next_execution_at',3,1,0,0,0,NULL,NULL,1,0,0,0),(457,73,'Precedente esecuzione','last_executed_at',4,1,0,0,0,NULL,NULL,1,0,0,0),(458,30,'Sottocategoria','`sub_lang`.`title`',7,1,0,0,0,'','',1,0,0,0),(459,2,'emailto_Email','`an_anagrafiche`.`email`',17,1,0,0,0,'','',0,0,0,0),(460,75,'id','id',0,1,0,0,0,'','',0,0,0,0),(461,75,'Nome','nome',1,1,0,0,0,'','',1,0,0,0),(462,43,'Gruppi abilitati','(SELECT GROUP_CONCAT(\' \', `nome`) FROM `zz_groups` WHERE `id` IN (SELECT `id_gruppo` FROM `do_permessi` WHERE `id_categoria` = `do_categorie`.`id`))',5,1,0,0,0,NULL,NULL,1,0,0,0),(465,78,'id','id',1,1,0,0,0,NULL,NULL,1,0,0,0),(466,78,'Nome','name',1,1,0,0,0,NULL,NULL,1,0,0,0),(467,3,'Tags','tags.nomi',10,1,0,0,0,NULL,NULL,1,0,0,0),(468,18,'Data concordata','IF(data_concordata IS NOT NULL AND data_concordata != \'0000-00-00\', data_concordata, \'\')',21,1,0,1,0,NULL,NULL,1,0,0,0),(469,30,'Marca','marca.name',11,1,0,0,0,NULL,NULL,0,0,0,0),(470,30,'Modello','modello.name',12,1,0,0,0,NULL,NULL,0,0,0,0),(471,59,'Valore','(prezzo_acquisto*movimenti.qta)',11,1,0,1,0,'','',1,1,0,0),(472,24,'Agente','agente.ragione_sociale',15,1,0,0,0,'','',0,0,0,0),(473,79,'id','zz_marche.id',0,0,0,0,0,'','',0,0,0,0),(474,79,'Nome','zz_marche.name',1,0,0,0,0,'','',1,0,0,0),(475,79,'Link','zz_marche.link',2,0,0,0,0,'','',1,0,0,0),(476,80,'Fatturabile','IF(is_fatturabile, \'S&igrave;\', \'No\')',6,1,0,0,0,NULL,NULL,1,0,0,0),(477,80,'Bloccato','IF(is_bloccato, \'S├¼\', \'No\')',5,1,0,0,0,NULL,NULL,1,0,0,0),(478,80,'Icona','icona',3,1,0,0,0,NULL,NULL,1,0,0,0),(479,80,'Descrizione','`dt_statiddt_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(480,80,'id','`dt_statiddt`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(481,80,'color_Colore','colore',7,0,0,1,0,'','',1,0,0,0),(482,81,'id','`co_categorie_contratti`.`id`',3,1,0,0,0,NULL,NULL,0,0,0,0),(483,81,'Nome','`co_categorie_contratti_lang`.`title`',2,1,0,0,0,NULL,NULL,1,0,0,0),(484,14,'IVA','(righe.iva)*IF(co_tipidocumento.reversed, -1, 1)',16,1,0,1,0,'','',0,0,0,0),(485,31,'Categoria','`co_categorie_contratti_lang`.`title`',16,1,0,0,0,'','',0,0,0,0),(486,31,'Sottocategoria','`co_categorie_contratti_lang`.`title`',17,1,0,0,0,'','',0,0,0,0),(487,2,'Zone','an_zone.nome',18,1,0,0,0,'','',0,0,0,0),(488,3,'Zone','an_zone.nome',18,1,0,0,0,'','',0,0,0,0),(489,31,'Da rinnovare','IF(rinnovabile,IF(DATEDIFF(data_conclusione,NOW()) BETWEEN 0 AND giorni_preavviso_rinnovo,\'S├¼\',IF(DATEDIFF(data_conclusione,NOW()) <= 0,\'S├¼\',\'No\')),\'No\')',19,1,0,0,0,'','',1,0,0,0),(490,14,'Note interne','`co_documenti`.`note_aggiuntive`',23,1,0,0,0,'','',0,0,0,0),(491,27,'Note interne','`dt_ddt`.`note_aggiuntive`',17,1,0,0,0,'','',0,0,0,0),(492,26,'Note interne','`dt_ddt`.`note_aggiuntive`',19,1,0,0,0,'','',0,0,0,0),(493,25,'Note interne','`or_ordini`.`note_aggiuntive`',15,1,0,0,0,'','',0,0,0,0),(494,24,'Note interne','`or_ordini`.`note_aggiuntive`',17,1,0,0,0,'','',0,0,0,0),(495,31,'Residuo contratto','IF((righe.totale_imponibile - (COALESCE(sommacosti, 0) + COALESCE(sommasessioni, 0))) != 0, (righe.totale_imponibile - (COALESCE(sommacosti, 0) + COALESCE(sommasessioni, 0))), \'\')',20,1,0,0,0,'','',1,0,0,0),(496,13,'Note interne','`co_preventivi`.`informazioniaggiuntive`',18,1,0,0,0,'','',0,0,0,0),(497,31,'Note interne','`co_contratti`.`informazioniaggiuntive`',18,1,0,0,0,'','',0,0,0,0),(498,21,'_bg_','IF(giacenze.stato_giacenza!=0, IF(giacenze.stato_giacenza>0, \'#CCFFCC\', \'#ec5353\'), \'\')',16,1,0,0,0,'','',0,0,0,0),(499,82,'Descrizione','`zz_default_description`.`descrizione`',3,1,0,0,0,NULL,NULL,1,0,0,1),(500,82,'Nome','zz_default_description.name',2,1,0,0,0,NULL,NULL,1,0,0,1),(501,82,'id','`zz_default_description`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1),(504,21,'Marche','(SELECT `name` FROM `zz_marche` WHERE `zz_marche`.`id` = `mg_articoli`.`id_marca`)',15,1,0,0,0,'','',0,0,0,0),(505,21,'Modello','`mg_articoli`.`id_modello`',16,1,0,0,0,'','',0,0,0,0),(506,83,'Descrizione','zz_files_categories.name',2,1,0,0,0,NULL,NULL,1,0,0,1),(507,83,'id','`zz_files_categories`.`id`',1,0,0,0,0,NULL,NULL,0,0,0,1);
/*!40000 ALTER TABLE `zz_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_views_lang`
--

DROP TABLE IF EXISTS `zz_views_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_views_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_views_lang_ibfk_1` (`id_record`),
  KEY `zz_views_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_views_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_views` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_views_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_views_lang`
--

LOCK TABLES `zz_views_lang` WRITE;
/*!40000 ALTER TABLE `zz_views_lang` DISABLE KEYS */;
INSERT INTO `zz_views_lang` VALUES (1,1,1,'id','id'),(2,1,2,'Ragione sociale','Ragione sociale'),(3,1,3,'Tipo','Tipo'),(4,1,4,'Citt├á','Citt├á'),(5,1,5,'Telefono','tel_Telefono'),(6,1,6,'color_Relazione','color_Relazione'),(7,1,7,'color_title_Relazione','color_title_Relazione'),(8,1,8,'id','id'),(9,1,9,'Numero','Numero'),(10,1,10,'Ragione sociale','Ragione sociale'),(11,1,11,'Data inizio','Data inizio'),(12,1,12,'Data fine','Data fine'),(13,1,13,'_bg_','_bg_'),(14,1,14,'Stato','Stato'),(15,1,15,'Tipo','Tipo'),(16,1,16,'_print_','_print_'),(17,1,17,'idanagrafica','idanagrafica'),(18,1,18,'orario_inizio','orario_inizio'),(19,1,19,'data_richiesta','data_richiesta'),(20,1,20,'orario_fine','orario_fine'),(21,1,21,'id','id'),(22,1,22,'Descrizione','Descrizione'),(23,1,23,'id','id'),(24,1,24,'Codice','Codice'),(25,1,25,'Descrizione','Descrizione'),(26,1,26,'Costo orario','Costo orario'),(27,1,27,'Costo al km','Costo al km'),(28,1,28,'Diritto di chiamata','Diritto di chiamata'),(29,1,29,'Costo orario tecnico','Costo orario tecnico'),(30,1,30,'Costo al km tecnico','Costo al km tecnico'),(31,1,31,'Diritto di chiamata tecnico','Diritto di chiamata tecnico'),(32,1,32,'id','id'),(33,1,33,'Codice','Codice'),(34,1,34,'Descrizione','Descrizione'),(35,1,35,'color_Colore','color_Colore'),(36,1,36,'id','id'),(37,1,37,'Numero','Numero'),(38,1,38,'Nome','Nome'),(39,1,39,'Cliente','Cliente'),(40,1,40,'icon_Stato','icon_Stato'),(41,1,41,'icon_title_Stato','icon_title_Stato'),(42,1,42,'data_bozza','data_bozza'),(43,1,43,'data_conclusione','data_conclusione'),(44,1,44,'id','id'),(45,1,45,'Numero','Numero'),(46,1,46,'Data','Data'),(47,1,47,'Ragione sociale','Ragione sociale'),(48,1,48,'Imponibile','Imponibile'),(49,1,49,'icon_Stato','icon_Stato'),(50,1,50,'icon_title_Stato','icon_title_Stato'),(51,1,51,'dir','dir'),(52,1,52,'id','id'),(53,1,53,'Numero','Numero'),(54,1,54,'Data','Data'),(55,1,55,'Ragione sociale','Ragione sociale'),(56,1,56,'Imponibile','Imponibile'),(57,1,57,'icon_Stato','icon_Stato'),(58,1,58,'icon_title_Stato','icon_title_Stato'),(59,1,59,'dir','dir'),(60,1,60,'id','id'),(61,1,61,'Data','Data'),(62,1,62,'Causale','Causale'),(63,1,63,'Controparte','Controparte'),(64,1,64,'Conto dare','Conto dare'),(65,1,65,'Dare','Dare'),(66,1,66,'Avere','Avere'),(67,1,67,'Conto avere','Conto avere'),(68,1,68,'id','id'),(69,1,69,'Anagrafica','Anagrafica'),(70,1,70,'Tipo di pagamento','Tipo di pagamento'),(71,1,71,'Data emissione','Data emissione'),(72,1,72,'Data scadenza','Data scadenza'),(73,1,73,'Importo','Importo'),(74,1,74,'Pagato','Pagato'),(75,1,75,'_bg_','_bg_'),(76,1,76,'da_pagare','da_pagare'),(77,1,77,'descrizione','descrizione'),(78,1,78,'pagato_reale','pagato_reale'),(79,1,79,'id','id'),(80,1,80,'Codice','Codice'),(81,1,81,'Categoria','Categoria'),(82,1,82,'Sottocategoria','Sottocategoria'),(83,1,83,'Q.t├á','Q.t├á'),(84,1,84,'id','id'),(85,1,85,'Nome','Nome'),(86,1,86,'Percentuale guadagno o sconto','Percentuale guadagno o sconto'),(87,1,87,'Note','Note'),(88,1,88,'id','id'),(89,1,89,'Targa','Targa'),(90,1,90,'Nome','Nome'),(91,1,91,'Descrizione','Descrizione'),(92,1,92,'id','id'),(93,1,93,'Numero','Numero'),(94,1,94,'Ragione sociale','Ragione sociale'),(95,1,95,'icon_Stato','icon_Stato'),(96,1,96,'icon_title_Stato','icon_title_Stato'),(97,1,97,'Data','Data'),(98,1,98,'dir','dir'),(99,1,99,'id','id'),(100,1,100,'Numero','Numero'),(101,1,101,'Ragione sociale','Ragione sociale'),(102,1,102,'icon_Stato','icon_Stato'),(103,1,103,'icon_title_Stato','icon_title_Stato'),(104,1,104,'dir','dir'),(105,1,105,'id','id'),(106,1,106,'Numero','Numero'),(107,1,107,'Data','Data'),(108,1,108,'Ragione sociale','Ragione sociale'),(109,1,109,'icon_Stato','icon_Stato'),(110,1,110,'icon_title_Stato','icon_title_Stato'),(111,1,111,'dir','dir'),(112,1,112,'id','id'),(113,1,113,'Numero','Numero'),(114,1,114,'Data','Data'),(115,1,115,'Ragione sociale','Ragione sociale'),(116,1,116,'icon_Stato','icon_Stato'),(117,1,117,'icon_title_Stato','icon_title_Stato'),(118,1,118,'dir','dir'),(119,1,119,'id','id'),(120,1,120,'Nome','Nome'),(121,1,121,'Descrizione','Descrizione'),(122,1,122,'id','id'),(123,1,123,'Matricola','Matricola'),(124,1,124,'Data','Data'),(125,1,125,'Cliente','Cliente'),(126,1,126,'Tecnico','Tecnico'),(127,1,127,'id','id'),(128,1,128,'Numero','Numero'),(129,1,129,'Nome','Nome'),(130,1,130,'Cliente','Cliente'),(131,1,131,'icon_Stato','icon_Stato'),(132,1,132,'icon_title_Stato','icon_title_Stato'),(133,1,133,'data_bozza','data_bozza'),(134,1,134,'data_conclusione','data_conclusione'),(135,1,138,'Descrizione','Descrizione'),(136,1,139,'idanagrafica','idanagrafica'),(137,1,140,'idanagrafica','idanagrafica'),(138,1,141,'idagente','idagente'),(139,1,142,'id','id'),(140,1,143,'Nome','Nome'),(141,1,144,'Filiale','Filiale'),(142,1,145,'IBAN','IBAN'),(143,1,146,'id','id'),(144,1,147,'Nome','Nome'),(145,1,148,'Impianti','Impianti'),(146,1,149,'idanagrafica','idanagrafica'),(147,1,150,'_bg_','_bg_'),(148,1,151,'Tipo','Tipo'),(149,1,152,'Tipo','Tipo'),(150,1,153,'Sede','Sede'),(151,1,154,'Tempo standard','Tempo standard'),(152,1,155,'id','id'),(153,1,156,'Modulo','Modulo'),(154,1,157,'Plugin','Plugin'),(155,1,158,'Nome','Nome'),(156,1,159,'Descrizione','Descrizione'),(157,1,160,'id','id'),(158,1,161,'id','id'),(159,1,162,'Nome','Nome'),(160,1,163,'Modulo','Modulo'),(161,1,164,'Maschera','Maschera'),(162,1,165,'Note','Note'),(163,1,166,'Predefinito','Predefinito'),(166,1,169,'icon_FE','icon_FE'),(167,1,170,'icon_title_FE','icon_title_FE'),(168,1,171,'icon_Inviata','icon_Inviata'),(169,1,172,'icon_title_Inviata','icon_title_Inviata'),(170,1,173,'Codice destinatario','Codice destinatario'),(171,1,174,'Tipologia','Tipologia'),(172,1,175,'Nome','Nome'),(173,1,176,'Predefinita','Predefinita'),(174,1,177,'Rif. fattura','Rif. fattura'),(175,1,178,'Tecnici','Tecnici'),(176,1,179,'id','id'),(177,1,180,'Descrizione','Descrizione'),(178,1,181,'Percentuale','Percentuale'),(179,1,182,'Indetraibile','Indetraibile'),(180,1,183,'Percentuale imponibile','Percentuale imponibile'),(181,1,184,'Percentuale','Percentuale'),(182,1,185,'Descrizione','Descrizione'),(183,1,186,'id','id'),(184,1,187,'Conto','Conto'),(185,1,188,'Fatturabile','Fatturabile'),(186,1,189,'Completato','Bloccato'),(187,1,190,'Pianificabile','Pianificabile'),(188,1,191,'Icona','Icona'),(189,1,192,'Descrizione','Descrizione'),(190,1,193,'id','id'),(191,1,194,'Fatturabile','Fatturabile'),(192,1,195,'Completato','Bloccato'),(193,1,196,'Pianificabile','Pianificabile'),(194,1,197,'Icona','Icona'),(195,1,198,'Descrizione','Descrizione'),(196,1,199,'id','id'),(197,1,200,'Rif. Fattura','Rif. Fattura'),(198,1,201,'Descrizione scadenza','Descrizione scadenza'),(199,1,202,'Saldo','Saldo'),(200,1,203,'Ore rimanenti','Ore rimanenti'),(201,1,204,'Rinnovabile','Rinnovabile'),(202,1,205,'Data conclusione','Data conclusione'),(203,1,206,'Imponibile','Imponibile'),(204,1,207,'Imponibile','Imponibile'),(205,1,208,'Sede partenza','Sede partenza'),(206,1,209,'Causale','Causale'),(207,1,210,'Tipo spedizione','Tipo spedizione'),(208,1,211,'Vettore','Vettore'),(209,1,212,'Imponibile','Imponibile'),(210,1,213,'Sede partenza','Sede partenza'),(211,1,214,'Causale','Causale'),(212,1,215,'Tipo spedizione','Tipo spedizione'),(213,1,216,'Vettore','Vettore'),(214,1,217,'Imponibile','Imponibile'),(215,1,218,'Richiesta','Richiesta'),(216,1,219,'Descrizione','Descrizione'),(217,1,220,'Sede destinazione','Sede destinazione'),(218,1,221,'Sede destinazione','Sede destinazione'),(219,1,222,'Descrizione','Descrizione'),(220,1,223,'Nome','Nome'),(221,1,224,'id','id'),(222,1,225,'_bg_','_bg_'),(223,1,226,'Nome','Nome'),(224,1,227,'id','id'),(225,1,228,'id','id'),(226,1,229,'Nome','Nome'),(227,1,230,'Modulo','Modulo'),(228,1,231,'Plugin','Plugin'),(229,1,232,'id','id'),(230,1,233,'Nome','Nome'),(231,1,234,'Template','Template'),(232,1,235,'Completato','Completato'),(233,1,236,'id','id'),(234,1,237,'Oggetto','Oggetto'),(235,1,238,'Contenuto','Contenuto'),(236,1,239,'Template','Template'),(237,1,240,'Data invio','Data invio'),(238,1,241,'Ultimo tentativo','Ultimo tentativo'),(239,1,242,'Utente','Utente'),(240,1,243,'_bg_','_bg_'),(241,1,244,'Imponibile','Imponibile'),(242,1,245,'Imponibile','Imponibile'),(243,1,246,'Numero ordine cliente','Numero ordine cliente'),(244,1,247,'id','id'),(245,1,248,'Nome','Nome'),(246,1,249,'Descrizione','Descrizione'),(247,1,250,'Dinamica','Dinamica'),(248,1,251,'id','id'),(249,1,252,'Descrizione','Descrizione'),(250,1,253,'id','id'),(251,1,254,'Categoria','Categoria'),(252,1,255,'Nome','Nome'),(253,1,256,'Data','Data'),(254,1,257,'Fornitore','Fornitore predefinito'),(255,1,258,'Prezzo di acquisto','Prezzo di acquisto'),(256,1,259,'Prezzo di vendita','Prezzo di vendita'),(257,1,260,'Modulo','Modulo'),(258,1,261,'Destinatari','Destinatari'),(259,1,262,'id','id'),(260,1,263,'Descrizione','Descrizione'),(261,1,264,'Colore','Colore'),(262,1,265,'Note','Note'),(263,1,266,'Prezzo vendita ivato','Prezzo vendita ivato'),(264,1,267,'Q.t├á impegnata','Q.t├á impegnata'),(265,1,268,'Q.t├á disponibile','Q.t├á disponibile'),(266,1,269,'Barcode','Barcode'),(267,1,272,'Nome del file','Nome del file'),(268,1,273,'Titolo','Titolo'),(269,1,274,'id','id'),(270,1,275,'Totale documento','Totale documento'),(271,1,276,'Netto a pagare','Netto a pagare'),(272,1,277,'Totale documento','Totale documento'),(273,1,278,'Netto a pagare','Netto a pagare'),(274,1,279,'Totale documento','Totale documento'),(275,1,280,'Totale documento','Totale documento'),(276,1,281,'Totale documento','Totale documento'),(277,1,282,'Totale documento','Totale documento'),(278,1,283,'Totale documento','Totale documento'),(279,1,284,'Totale documento','Totale documento'),(280,1,285,'Tipo','Tipo'),(281,1,286,'Descrizione','Descrizione'),(282,1,287,'Nome','Nome'),(283,1,288,'id','id'),(284,1,289,'Sede','Sede'),(285,1,290,'Rif. fattura','Rif. fattura'),(286,1,291,'Data','Data'),(287,1,292,'_link_module_','_link_module_'),(288,1,293,'id','id'),(289,1,294,'Codice','Codice'),(290,1,295,'Categoria','Categoria'),(291,1,296,'Sottocategoria','Sottocategoria'),(292,1,297,'Q.t├á','Q.t├á'),(293,1,298,'Descrizione','Descrizione'),(294,1,299,'Fornitore','Fornitore'),(295,1,300,'Prezzo di acquisto','Prezzo di acquisto'),(296,1,301,'Prezzo di vendita','Prezzo di vendita'),(297,1,302,'Prezzo vendita ivato','Prezzo vendita ivato'),(298,1,303,'Barcode','Barcode'),(299,1,304,'Anagrafica','Anagrafica'),(300,1,305,'Predefinito','Predefinito'),(301,1,306,'id','id'),(302,1,307,'Minimo','Minimo'),(303,1,308,'Massimo','Massimo'),(304,1,309,'Prezzo unitario','Prezzo unitario'),(305,1,310,'Sconto percentuale','Sconto percentuale'),(306,1,311,'Articolo','Articolo'),(307,1,312,'Ragione sociale','Ragione sociale'),(308,1,313,'_link_module_','_link_module_'),(309,1,314,'_link_record_','_link_record_'),(310,1,315,'Tecnici assegnati','Tecnici assegnati'),(311,1,316,'Sottocategoria','Sottocategoria'),(312,1,317,'Categoria','Categoria'),(313,1,318,'Attivo','Attivo'),(314,1,319,'Predefinito','Predefinito'),(315,1,320,'Codice FE','Codice FE'),(316,1,321,'Reversed','Reversed'),(317,1,322,'Direzione','Direzione'),(318,1,323,'Descrizione','Descrizione'),(319,1,324,'id','id'),(320,1,325,'Rif. fattura','Rif. fattura'),(321,1,326,'Causale','Causale'),(322,1,327,'_bg_','_bg_'),(323,1,328,'Categoria','Categoria'),(324,1,329,'Q.t├á ordinata','Q.t├á ordinata'),(325,1,330,'icon_Prev. evasione','icon_Prev. evasione'),(326,1,331,'icon_title_Prev. evasione','icon_title_Prev. evasione'),(327,1,332,'icon_Prev. evasione','icon_Prev. evasione'),(328,1,333,'icon_title_Prev. evasione','icon_title_Prev. evasione'),(329,1,334,'Modulo','Modulo'),(330,1,335,'Predefinita','Predefinita'),(331,1,336,'Ordine','Ordine'),(332,1,337,'icon_Prev. evasione','icon_Prev. evasione'),(333,1,338,'icon_title_Prev. evasione','icon_title_Prev. evasione'),(334,1,339,'icon_Prev. evasione','icon_Prev. evasione'),(335,1,340,'icon_title_Prev. evasione','icon_title_Prev. evasione'),(336,1,341,'Modulo','Modulo'),(337,1,342,'Predefinita','Predefinita'),(338,1,343,'Ordine','Ordine'),(339,1,344,'N. Prot.','N. Prot.'),(340,1,345,'Stato','Stato'),(341,1,346,'Destinatari','Destinatari'),(342,1,347,'Referente','Referente'),(343,1,348,'Scaduto','Scaduto'),(344,1,349,'Riferimenti','Riferimenti'),(345,1,350,'Rif. fattura','Rif. fattura'),(346,1,351,'Referenti','Referenti'),(347,1,352,'Sedi','Sedi'),(348,1,353,'id','id'),(349,1,354,'Nome','Nome'),(350,1,355,'id','id'),(351,1,356,'Nome','Nome'),(352,1,357,'Banca','Banca'),(353,1,358,'Banca','Banca'),(354,1,359,'icon_Inviata','icon_Inviata'),(355,1,360,'icon_title_Inviata','icon_title_Inviata'),(356,1,361,'Codice','Codice'),(357,1,362,'id','id'),(358,1,363,'Nome','Nome'),(359,1,364,'Tentativi','Tentativi'),(360,1,365,'Data creazione','Data creazione'),(361,1,366,'Distinta','Distinta'),(362,1,367,'icon_Inviato','icon_Inviato'),(363,1,368,'icon_Inviato','icon_Inviato'),(364,1,369,'icon_Inviato','icon_Inviato'),(365,1,370,'icon_title_Inviato','icon_title_Inviato'),(366,1,371,'Codice','Codice'),(367,1,372,'Servizio','Servizio'),(368,1,373,'Codice','Codice'),(369,1,374,'Barcode','Barcode'),(370,1,375,'Impianti','Impianti'),(371,1,376,'id','id'),(372,1,377,'Nome','Nome'),(373,1,378,'Giorni','Giorni'),(374,1,379,'Ora inizio','Ora inizio'),(375,1,380,'Ora fine','Ora fine'),(376,1,381,'Includi festivit├á','Includi festivit├á'),(377,1,382,'id','id'),(378,1,383,'Nome','Nome'),(379,1,384,'Nazione','Nazione'),(380,1,385,'Data','Data'),(381,1,386,'Ricorrente','Ricorrente'),(382,1,387,'Festivit├á','Festivit├á'),(383,1,388,'Contratto','Contratto'),(384,1,389,'Preventivo','Preventivo'),(385,1,390,'Ordine','Ordine'),(386,1,391,'Ricavi','Ricavi'),(387,1,392,'Costi','Costi'),(388,1,393,'Ore','Ore'),(389,1,394,'id','id'),(390,1,395,'descrizione','descrizione'),(391,1,396,'colore','colore'),(392,1,397,'id','id'),(393,1,398,'descrizione','descrizione'),(394,1,399,'Pagamento','Pagamento'),(395,1,400,'Pagamento','Pagamento'),(396,1,401,'Indirizzo','Indirizzo'),(397,1,402,'Cellulare','tel_Cellulare'),(398,1,403,'_bg_','_bg_'),(399,1,404,'color_Colore','color_Colore'),(400,1,405,'id','id'),(401,1,406,'Nome','Nome'),(402,1,407,'Data attivazione','Data attivazione'),(403,1,408,'Articoli','Articoli'),(404,1,409,'Anagrafiche','Anagrafiche'),(405,1,410,'Ultima modifica','Ultima modifica'),(406,1,411,'Sempre visibile','Sempre visibile'),(407,1,412,'Attivo','Attivo'),(408,1,413,'Pagamento cliente','Pagamento cliente'),(409,1,414,'Pagamento fornitore','Pagamento fornitore'),(410,1,415,'Agente','Agente'),(411,1,416,'icon_Inviato','icon_Inviato'),(412,1,417,'Banca azienda','Banca azienda'),(413,1,418,'KM','KM'),(414,1,419,'Gruppi con accesso','Gruppi con accesso'),(415,1,420,'_print_','_print_'),(416,1,421,'_print_','_print_'),(417,1,422,'_print_','_print_'),(418,1,423,'_print_','_print_'),(419,1,424,'Prima nota','Prima nota'),(420,1,425,'icon_Inviata','icon_Inviata'),(421,1,426,'icon_title_Inviata','icon_title_Inviata'),(422,1,427,'Scadenza giorni','Scadenza giorni'),(423,1,428,'Agente','Agente'),(424,1,429,'Fatturabile','Fatturabile'),(425,1,430,'Completato','Bloccato'),(426,1,431,'Impegnato','Impegnato'),(427,1,432,'Icona','Icona'),(428,1,433,'Descrizione','Descrizione'),(429,1,434,'id','id'),(430,1,435,'Riferimenti','Riferimenti'),(431,1,436,'Data scadenza','Data scadenza'),(433,1,438,'color_Colore','color_Colore'),(434,1,439,'color_Colore','color_Colore'),(435,1,440,'_bg_','_bg_'),(436,1,441,'_bg_','_bg_'),(437,1,442,'_bg_','_bg_'),(438,1,443,'_bg_','_bg_'),(439,1,444,'_bg_','_bg_'),(440,1,445,'Sezionale','Sezionale'),(441,1,446,'Esportazione distinta','Esportazione distinta'),(442,1,447,'Riferimenti','Riferimenti'),(443,1,448,'Icona','Icona'),(444,1,449,'Descrizione','Descrizione'),(445,1,450,'id','id'),(446,1,451,'color_Colore','color_Colore'),(447,1,452,'Allegati','Allegati'),(448,1,453,'id','id'),(449,1,454,'Nome','Nome'),(450,1,455,'Expression','Expression'),(451,1,456,'Prossima esecuzione','Prossima esecuzione'),(452,1,457,'Precedente esecuzione','Precedente esecuzione'),(453,1,458,'Sottocategoria','Sottocategoria'),(454,1,459,'Email','emailto_Email'),(455,1,460,'id','id'),(456,1,461,'Nome','Nome');
/*!40000 ALTER TABLE `zz_views_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_widgets`
--

DROP TABLE IF EXISTS `zz_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` enum('stats','chart','custom','print') DEFAULT NULL,
  `id_module` int NOT NULL,
  `location` enum('controller_top','controller_right','editor_top','editor_right') DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `query` text,
  `bgcolor` varchar(100) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `print_link` varchar(255) DEFAULT NULL,
  `more_link` varchar(5000) DEFAULT NULL,
  `more_link_type` enum('link','popup','javascript') DEFAULT NULL,
  `php_include` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `order` int DEFAULT NULL,
  `help` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_module` (`id_module`),
  CONSTRAINT `zz_widgets_ibfk_1` FOREIGN KEY (`id_module`) REFERENCES `zz_modules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_widgets`
--

LOCK TABLES `zz_widgets` WRITE;
/*!40000 ALTER TABLE `zz_widgets` DISABLE KEYS */;
INSERT INTO `zz_widgets` VALUES (13,'Valore magazzino','stats',21,'controller_top',NULL,'SELECT CONCAT_WS(\" \", REPLACE(REPLACE(REPLACE(FORMAT(SUM(prezzo_acquisto*qta),2), \",\", \"#\"), \".\", \",\"), \"#\", \".\"), \"&euro;\") AS dato FROM mg_articoli WHERE qta>0 AND deleted_at IS NULL AND servizio=0 AND 1=1','danger','fa fa-money','','',NULL,'',1,1,'Articoli a magazzino (tutti o solo attivi secondo il segmento)'),(14,'Articoli in magazzino','stats',21,'controller_top',NULL,'SELECT REPLACE(REPLACE(REPLACE(FORMAT(SUM(qta),2), \",\", \"#\"), \".\", \",\"), \"#\", \".\") AS dato FROM mg_articoli WHERE qta>0 AND deleted_at IS NULL AND servizio=0 AND 1=1','info','fa fa-check-square-o','','',NULL,'',1,1,'Articoli a magazzino (tutti o solo attivi secondo il segmento)'),(15,'Stampa calendario','print',1,'controller_top',NULL,NULL,'gray','fa fa-print','','./modules/dashboard/widgets/stampa_calendario.dashboard.php','popup','',1,7,NULL),(16,'Attivit├á da pianificare','stats',1,'controller_top',NULL,'SELECT COUNT(id) AS dato FROM in_interventi WHERE id NOT IN (SELECT idintervento FROM in_interventi_tecnici) AND idstatointervento IN (SELECT id FROM in_statiintervento WHERE is_bloccato = 0) ','warning','fa fa-cogs','','./modules/interventi/widgets/interventi_da_pianificare.php','popup','',1,0,NULL),(17,'Attivit├á nello stato da programmare','stats',1,'controller_top',NULL,'SELECT COUNT(id) AS dato FROM in_interventi WHERE in_interventi.idstatointervento = (SELECT in_statiintervento.id FROM in_statiintervento WHERE in_statiintervento.codice=\'TODO\') ORDER BY in_interventi.data_richiesta ASC','warning','fa fa-hourglass-half','','./modules/interventi/widgets/interventi_da_programmare.php','popup','',1,8,NULL),(18,'Attivit├á confermate','stats',1,'controller_top',NULL,'SELECT COUNT(id) AS dato FROM in_interventi WHERE in_interventi.idstatointervento = (SELECT in_statiintervento.id FROM in_statiintervento WHERE in_statiintervento.codice=\'WIP\') ORDER BY in_interventi.data_richiesta ASC','success','fa fa-hourglass-half','','./modules/interventi/widgets/interventi_confermati.php','popup','',1,8,NULL),(19,'Spazio utilizzato','chart',50,'controller_right','col-md-6',NULL,'success','fa fa-hdd-o','','',NULL,'./modules/stato_servizi/widgets/spazio_utilizzato.php',1,1,NULL),(20,'Note interne','custom',1,'controller_top',NULL,NULL,'info','fa fa-file-text-o ','','./modules/dashboard/widgets/notifiche.php','popup','./modules/dashboard/widgets/notifiche.php',1,1,NULL),(21,'Sincronizzazione disiscritti','custom',55,'controller_top',NULL,NULL,'success','fa fa-envelope ','','./modules/liste_newsletter/widgets/opt-out.php','popup','./modules/liste_newsletter/widgets/opt-out.php',0,1,NULL),(22,'Listini attivi','stats',70,'controller_top',NULL,'SELECT COUNT(mg_listini.id) AS dato FROM mg_listini WHERE 1=1 AND attivo=1 HAVING 2=2','success','fa fa-check','','','javascript','',1,1,NULL),(23,'Listini scaduti','stats',70,'controller_top',NULL,'SELECT COUNT(mg_listini.id) AS dato FROM mg_listini WHERE 1=1 AND attivo=0 HAVING 2=2','danger','fa fa-times','','','javascript','',1,2,NULL),(24,'Stampa calendario settimanale','print',1,'controller_top',NULL,NULL,'gray','fa fa-print','','./modules/dashboard/widgets/stampa_calendario_settimanale.dashboard.php','popup','',1,7,NULL),(25,'Preventivi da fatturare','stats',1,'controller_top',NULL,'SELECT COUNT(id) AS dato FROM co_preventivi WHERE idstato IN (SELECT id FROM co_statipreventivi WHERE is_fatturabile=1) AND default_revision=1','maroon','fa fa-file','','./modules/preventivi/widgets/preventivi.fatturare.dashboard.php','popup','',0,NULL,NULL),(26,'Stampa cespiti','print',21,'controller_top','col-md-3','','info','fa fa-print','','./modules/articoli/widgets/stampa_cespiti.php','popup','',1,1,NULL);
/*!40000 ALTER TABLE `zz_widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_widgets_lang`
--

DROP TABLE IF EXISTS `zz_widgets_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_widgets_lang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `zz_widgets_lang_ibfk_1` (`id_record`),
  KEY `zz_widgets_lang_ibfk_2` (`id_lang`),
  CONSTRAINT `zz_widgets_lang_ibfk_1` FOREIGN KEY (`id_record`) REFERENCES `zz_widgets` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `zz_widgets_lang_ibfk_2` FOREIGN KEY (`id_lang`) REFERENCES `zz_langs` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_widgets_lang`
--

LOCK TABLES `zz_widgets_lang` WRITE;
/*!40000 ALTER TABLE `zz_widgets_lang` DISABLE KEYS */;
INSERT INTO `zz_widgets_lang` VALUES (1,1,13,'Valore magazzino','Valore magazzino','Valore'),(2,1,14,'Articoli in magazzino','Articoli in magazzino','Unit├á'),(3,1,15,'Stampa calendario','Stampa calendario','Stampa calendario'),(4,1,16,'Attivit├á da pianificare','Attivit├á da pianificare','Promemoria attivit├á da pianificare'),(5,1,17,'Attivit├á nello stato da programmare','Attivit├á nello stato da programmare','Attivit├á nello stato da programmare'),(6,1,18,'Attivit├á confermate','Attivit├á confermate','Attivit├á confermate'),(7,1,19,'Spazio utilizzato','Spazio utilizzato','Spazio utilizzato'),(8,1,20,'Note interne','Note interne','Note interne'),(9,1,21,'Sincronizzazione disiscritti','Sincronizzazione disiscritti','Sincronizza disiscritti dal servizio esterno'),(10,1,22,'Listini attivi','Listini attivi','Listini attivi'),(11,1,23,'Listini scaduti','Listini scaduti','Listini disattivati'),(12,1,24,'Stampa calendario settimanale','Stampa calendario settimanale','Stampa calendario settimanale'),(13,1,25,'Preventivi da fatturare','Preventivi da fatturare','Preventivi da fatturare'),(14,1,26,'Stampa cespiti','Stampa cespiti','Stampa cespiti');
/*!40000 ALTER TABLE `zz_widgets_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'maga'
--

--
-- Dumping routines for database 'maga'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-29 14:52:36

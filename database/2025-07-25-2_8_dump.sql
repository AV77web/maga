-- MySQL dump 10.13  Distrib 8.4.5, for Win64 (x86_64)
--
-- Host: localhost    Database: 2_8
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
  `ragione_sociale` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idanagrafica`)
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
-- Table structure for table `an_nazioni`
--

DROP TABLE IF EXISTS `an_nazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_nazioni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_nazioni`
--

LOCK TABLES `an_nazioni` WRITE;
/*!40000 ALTER TABLE `an_nazioni` DISABLE KEYS */;
INSERT INTO `an_nazioni` VALUES (2,'ALGERIA'),(3,'ANDORRA'),(4,'ANGOLA'),(5,'ANGUILLA'),(6,'ANTIGUA AND BARBUDA'),(7,'ARGENTINA'),(8,'ARMENIA'),(9,'ARUBA'),(10,'AUSTRALIA'),(11,'AUSTRIA'),(12,'AZERBAIJAN REPUBLIC'),(13,'BAHAMAS'),(14,'BAHRAIN'),(15,'BARBADOS'),(16,'BELGIO'),(17,'BELIZE'),(18,'BENIN'),(19,'BERMUDA'),(20,'BHUTAN'),(21,'BOLIVIA'),(22,'BOSNIA AND HERZEGOVINA'),(23,'BOTSWANA'),(24,'BRASILE'),(25,'BRITISH VIRGIN ISLANDS'),(26,'BRUNEI'),(27,'BULGARIA'),(28,'BURKINA FASO'),(29,'BURUNDI'),(30,'CAMBOGIA'),(31,'CANADA'),(32,'CAPO VERDE'),(33,'CAYMAN ISLANDS'),(34,'CHAD'),(35,'CHILE'),(36,'CHINA WORLDWIDE'),(37,'COLOMBIA'),(38,'COMOROS'),(39,'COOK ISLANDS'),(40,'COSTA RICA'),(41,'CROAZIA'),(42,'CIPRO'),(43,'REPUBBLICA CECA'),(44,'DEMOCRATIC REPUBLIC OF THE CONGO'),(45,'DANIMARCA'),(46,'DJIBOUTI'),(47,'DOMINICA'),(48,'REPUBBLICA DOMINICANA'),(49,'ECUADOR'),(50,'EL SALVADOR'),(51,'ERITREA'),(52,'ESTONIA'),(53,'ETHIOPIA'),(54,'FALKLAND ISLANDS'),(55,'FAROE ISLANDS'),(56,'FEDERATED STATES OF MICRONESIA'),(57,'FIJI'),(58,'FINLANDIA'),(59,'FRANCIA'),(60,'FRENCH GUIANA'),(61,'FRENCH POLYNESIA'),(62,'GABON REPUBLIC'),(63,'GAMBIA'),(64,'GERMANIA'),(65,'GIBRALTAR'),(66,'GRECIA'),(67,'GREENLAND'),(68,'GRENADA'),(69,'GUADELOUPE'),(70,'GUATEMALA'),(71,'GUINEA'),(72,'GUINEA BISSAU'),(73,'GUYANA'),(74,'HONDURAS'),(75,'HONG KONG'),(76,'UNGHERIA'),(77,'ISLANDA'),(78,'INDIA'),(79,'INDONESIA'),(80,'IRLANDA'),(81,'ISRAELE'),(82,'ITALIA'),(83,'JAMAICA'),(84,'GIAPPONE'),(85,'JORDAN'),(86,'KAZAKHSTAN'),(87,'KENYA'),(88,'KIRIBATI'),(89,'KUWAIT'),(90,'KYRGYZSTAN'),(91,'LAOS'),(92,'LATVIA'),(93,'LESOTHO'),(94,'LIECHTENSTEIN'),(95,'LITUANIA'),(96,'LUSSEMBURGO'),(97,'MADAGASCAR'),(98,'MALAWI'),(99,'MALESIA'),(100,'MALDIVE'),(101,'MALI'),(102,'MALTA'),(103,'MARSHALL ISLANDS'),(104,'MARTINIQUE'),(105,'MAURITANIA'),(106,'MAURITIUS'),(107,'MAYOTTE'),(108,'MESSICO'),(109,'MONGOLIA'),(110,'MONTSERRAT'),(111,'MAROCCO'),(112,'MOZAMBICO'),(113,'NAMIBIA'),(114,'NAURU'),(115,'NEPAL'),(116,'OLANDA'),(117,'NETHERLANDS ANTILLES'),(118,'NUOVA CALEDONIA'),(119,'NUOVA ZELANDA'),(120,'NICARAGUA'),(121,'NIGERIA'),(122,'NIUE'),(123,'NORFOLK ISLAND'),(124,'NORWEGIA'),(125,'OMAN'),(126,'PALAU'),(127,'PANAMA'),(128,'PAPUA NUOVA GUINEA'),(129,'PERU'),(130,'FILIPPINE'),(131,'PITCAIRN ISLANDS'),(132,'POLONIA'),(133,'PORTOGALLO'),(134,'QATAR'),(135,'REPUBBLICA DEL CONGO'),(136,'REUNION'),(137,'ROMANIA'),(138,'RUSSIA'),(139,'RUANDA'),(140,'SAINT VINCENT AND THE GRENADINES'),(141,'SAMOA'),(142,'SAN MARINO'),(144,'SAUDI ARABIA'),(145,'SENEGAL'),(146,'SEYCHELLES'),(147,'SIERRA LEONE'),(148,'SINGAPORE'),(149,'SLOVACCHIA'),(150,'SLOVENIA'),(151,'SOLOMON ISLANDS'),(152,'SOMALIA'),(153,'SUD AFRICA'),(154,'SUD KOREA'),(155,'SPAGNA'),(156,'SRI LANKA'),(157,'ST. HELENA'),(158,'ST. KITTS AND NEVIS'),(159,'ST. LUCIA'),(160,'ST. PIERRE AND MIQUELON'),(161,'SURINAME'),(162,'SVALBARD AND JAN MAYEN ISLANDS'),(163,'SWAZILAND'),(164,'SVEZIA'),(165,'SVIZZERA'),(166,'TAIWAN'),(167,'TAJIKISTAN'),(168,'TANZANIA'),(169,'THAILAND'),(170,'TOGO'),(171,'TONGA'),(172,'TRINIDAD E TOBAGO'),(173,'TUNISIA'),(174,'TURCHIA'),(175,'TURKMENISTAN'),(176,'TURKS AND CAICOS ISLANDS'),(177,'TUVALU'),(178,'UGANDA'),(179,'UCRAINA'),(180,'EMIRATI ARABI UNITI'),(181,'REGNO UNITO'),(182,'STATI UNITI'),(183,'URUGUAY'),(184,'VANUATU'),(185,'CITT├Ç DEL VATICANO'),(186,'VENEZUELA'),(187,'VIETNAM'),(188,'WALLIS AND FUTUNA ISLANDS'),(189,'YEMEN'),(190,'ZAMBIA'),(193,'ALBANIA ');
/*!40000 ALTER TABLE `an_nazioni` ENABLE KEYS */;
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
  `mansione` varchar(255) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `idanagrafica` int NOT NULL,
  `idsede` int NOT NULL,
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
-- Table structure for table `an_relazioni`
--

DROP TABLE IF EXISTS `an_relazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_relazioni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) NOT NULL,
  `colore` varchar(7) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_relazioni`
--

LOCK TABLES `an_relazioni` WRITE;
/*!40000 ALTER TABLE `an_relazioni` DISABLE KEYS */;
INSERT INTO `an_relazioni` VALUES (1,'Da contattare','#caffb7'),(2,'Da richiamare','#8fbafd'),(3,'Da non richiamare','#ff908c'),(4,'Appuntamento fissato','#ffc400'),(5,'Attivo','#00b913'),(6,'Dormiente','#a2a2a2');
/*!40000 ALTER TABLE `an_relazioni` ENABLE KEYS */;
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
  `km` float(10,2) NOT NULL,
  `nazione` varchar(255) NOT NULL COMMENT 'Nazione',
  `telefono` varchar(20) NOT NULL COMMENT 'Telefono',
  `fax` varchar(20) NOT NULL COMMENT 'Fax',
  `cellulare` varchar(20) NOT NULL COMMENT 'Cellulare',
  `email` varchar(255) NOT NULL COMMENT 'Email',
  `idanagrafica` int NOT NULL,
  `idzona` int NOT NULL,
  PRIMARY KEY (`id`)
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
-- Table structure for table `an_tipianagrafiche`
--

DROP TABLE IF EXISTS `an_tipianagrafiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_tipianagrafiche` (
  `idtipoanagrafica` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(255) NOT NULL,
  `default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idtipoanagrafica`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `an_tipianagrafiche`
--

LOCK TABLES `an_tipianagrafiche` WRITE;
/*!40000 ALTER TABLE `an_tipianagrafiche` DISABLE KEYS */;
INSERT INTO `an_tipianagrafiche` VALUES (1,'Cliente',1),(2,'Tecnico',1),(3,'Azienda',1),(4,'Fornitore',1),(5,'Vettore',1),(6,'Agente',1);
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
-- Table structure for table `an_zone`
--

DROP TABLE IF EXISTS `an_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `an_zone` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descrizione` varchar(2000) NOT NULL,
  `default` tinyint(1) NOT NULL,
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
  `data_bozza` datetime DEFAULT NULL,
  `data_accettazione` datetime DEFAULT NULL,
  `data_rifiuto` datetime DEFAULT NULL,
  `data_conclusione` datetime DEFAULT NULL,
  `rinnovabile` tinyint(1) NOT NULL,
  `giorni_preavviso_rinnovo` smallint NOT NULL,
  `budget` decimal(12,4) NOT NULL,
  `descrizione` text,
  `idstato` tinyint DEFAULT NULL,
  `idreferente` int DEFAULT NULL,
  `validita` int DEFAULT NULL,
  `esclusioni` text NOT NULL,
  `idanagrafica` int NOT NULL,
  `idpagamento` int NOT NULL,
  `idtipointervento` varchar(25) NOT NULL,
  `costo_diritto_chiamata` decimal(12,4) NOT NULL,
  `ore_lavoro` decimal(12,4) NOT NULL,
  `costo_orario` decimal(12,4) NOT NULL,
  `costo_km` decimal(12,4) NOT NULL,
  `idcontratto_prev` int NOT NULL,
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
-- Table structure for table `co_contratti_interventi`
--

DROP TABLE IF EXISTS `co_contratti_interventi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_contratti_interventi` (
  `idcontratto` int NOT NULL,
  `idintervento` varchar(25) NOT NULL,
  PRIMARY KEY (`idcontratto`,`idintervento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_contratti_interventi`
--

LOCK TABLES `co_contratti_interventi` WRITE;
/*!40000 ALTER TABLE `co_contratti_interventi` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_contratti_interventi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_documenti`
--

DROP TABLE IF EXISTS `co_documenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_documenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` int NOT NULL,
  `numero_esterno` varchar(100) NOT NULL,
  `data` datetime NOT NULL,
  `idanagrafica` int NOT NULL,
  `idcausalet` int NOT NULL,
  `idspedizione` int NOT NULL,
  `idporto` int NOT NULL,
  `idaspettobeni` int NOT NULL,
  `idvettore` int NOT NULL,
  `n_colli` int NOT NULL,
  `idsede` int NOT NULL,
  `idtipodocumento` tinyint NOT NULL,
  `idstatodocumento` tinyint NOT NULL,
  `idpagamento` int NOT NULL,
  `idconto` int NOT NULL,
  `idrivalsainps` int NOT NULL,
  `idritenutaacconto` int NOT NULL,
  `rivalsainps` decimal(12,4) NOT NULL,
  `iva_rivalsainps` decimal(12,4) NOT NULL,
  `ritenutaacconto` decimal(12,4) NOT NULL,
  `bollo` decimal(12,4) NOT NULL,
  `note` text NOT NULL,
  `note_aggiuntive` text NOT NULL,
  `buono_ordine` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
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
-- Table structure for table `co_iva`
--

DROP TABLE IF EXISTS `co_iva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_iva` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) NOT NULL,
  `percentuale` float(5,2) NOT NULL,
  `descrizione2` varchar(200) NOT NULL,
  `indetraibile` float(5,2) NOT NULL,
  `esente` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_iva`
--

LOCK TABLES `co_iva` WRITE;
/*!40000 ALTER TABLE `co_iva` DISABLE KEYS */;
INSERT INTO `co_iva` VALUES (1,'Corrispettivi in ventilazione',0.00,'',0.00,0),(2,'Iva 4% indetraibile al 50%',4.00,'',50.00,0),(3,'Iva 04% indetraibile al 100%',4.00,'',100.00,0),(4,'Iva 04% Intra',4.00,'',0.00,0),(5,'Iva 8',8.00,'',0.00,0),(6,'Iva 9% ',9.00,'',0.00,0),(7,'Esente art.10',0.00,'',0.00,1),(8,'Iva 10%',10.00,'',0.00,0),(9,'Iva 10% indetraibile al 50%',10.00,'',50.00,0),(10,'Iva 10% indetraibile al 100%',10.00,'',100.00,0),(11,'Iva 10% Intra',10.00,'',0.00,0),(12,'Iva 10% indetraibile',10.00,'',100.00,0),(13,'Esente art. 2 DPR 633/72',0.00,'',0.00,1),(14,'N.S. iva art.4 D.P.R.633/72',0.00,'',0.00,0),(15,'Iva 20% in reverse charge',20.00,'',0.00,0),(16,'Esente art.15',0.00,'',0.00,1),(17,'Non imponibile art. 7',0.00,'',0.00,1),(18,'Iva 19%',19.00,'',0.00,0),(19,'Iva 2%',2.00,'',0.00,0),(20,'Iva 20%',20.00,'',0.00,0),(21,'Iva 20% indetraibile al 90%',20.00,'',90.00,0),(22,'Iva 20% esente prorata',20.00,'',100.00,0),(23,'Iva 20% Intra',20.00,'',0.00,0),(24,'Iva 20% indetraibile',20.00,'',100.00,0),(25,'Iva 21% indetraibile 50%',21.00,'',50.00,0),(26,'Non imponibile art.72',0.00,'',0.00,1),(27,'Esente art. 1',0.00,'',0.00,1),(28,'Non imponibile art.26 C.2',0.00,'',0.00,1),(29,'Non imponibile art.74',0.00,'',0.00,1),(30,'Non imponibile art. 41',0.00,'',0.00,1),(31,'Fuori campo iva',0.00,'',0.00,0),(32,'Iva 21%',21.00,'',0.00,0),(33,'Iva 21% S.Marino',21.00,'',0.00,0),(34,'Iva 4%',4.00,'',0.00,0),(35,'Esente art. 74',0.00,'',0.00,1),(36,'Iva 2% indetraibile',2.00,'',100.00,0),(37,'Iva 4% indetraibile',4.00,'',100.00,0),(38,'Esente art.6',0.00,'',0.00,1),(39,'Esente art. 5',0.00,'',0.00,1),(40,'Art. 74 ter 10% indetraibile',10.00,'',100.00,0),(41,'Art. 74 ter 4% indetraibile',4.00,'',100.00,0),(42,'Art. 74 ter 20% iva indetraibile',20.00,'',100.00,0),(43,'Non imponibile art. 74 ter',0.00,'',0.00,0),(44,'Non imponibile art. 8/C',0.00,'',0.00,1),(45,'Esente art.10 C.27Q',0.00,'',0.00,1),(46,'Escluso art. 2',0.00,'',0.00,1),(47,'Non soggetto art. 7',0.00,'',0.00,0),(48,'Non imponibile art. 8',0.00,'',0.00,1),(49,'Non imponibile art. 9',0.00,'',0.00,1),(50,'Esente art. 10',0.00,'',0.00,1),(51,'Esente art. 10 n. 11',0.00,'',0.00,1),(52,'Escluso art. 15',0.00,'',0.00,1),(53,'Non sogg  art. 17 c.5',0.00,'',0.00,1),(54,'Esente art. 10 n. 18',0.00,'',0.00,1),(55,'Esente art. 10 n.1 a n.9',0.00,'',0.00,1),(56,'Art. 36 D.L. 41/95 acq.',0.00,'',0.00,0),(57,'Non imponibile art. 40 D.L. 331 c. 5',0.00,'',0.00,1),(58,'Non imponibile art. 41 D.L. 331/93',0.00,'',0.00,1),(59,'Non imponibile art. 40 D.L. 331 c. 4 bis',0.00,'',0.00,1),(60,'Non imponibile art. 40 D.L. 331 c. 6/8',0.00,'',0.00,1),(61,'Non imponibile art. 40 D.L. 331 c. 4 bis',0.00,'',0.00,1),(62,'Non imponibile art. 58 D.L. 331',0.00,'',0.00,1),(63,'Non imponibile art. 71 e 72',0.00,'',0.00,1),(64,'Non imponibile art. 74',0.00,'',0.00,1),(65,'Non imponibile art. 8 lett. a)',0.00,'',0.00,1),(66,'Non imponibile art. 8 lett. c)',0.00,'',0.00,1),(67,'Non imponibile art. 9 c. 2',0.00,'',0.00,1),(68,'Non imponibile art. 9 punto 9)',0.00,'',0.00,1),(69,'Art. 17 comma 6 DPR 633/72 10%',10.00,'',0.00,0),(70,'Art. 17 comma 6 DPR 633/72 20%',20.00,'',0.00,0),(71,'Art. 17 comma 6 DPR 633/72 4%',4.00,'',0.00,0),(72,'Acquisti da soggetti minimi',0.00,'',0.00,0),(73,'Cess. fabbr. strum. art.10 n.8',0.00,'',0.00,0),(74,'Art. 74 c. 7 e 8',0.00,'',0.00,0),(75,'Fuori campo Iva',0.00,'',0.00,0),(76,'Non Imponibile San Marino',0.00,'',0.00,0),(77,'Esente art. 10 27 quinquies',0.00,'',0.00,1),(78,'Autofatture 10% subappalto',10.00,'',0.00,0),(79,'Autofatture 20% subappalto',20.00,'',0.00,0),(80,'Autofatture 4% subappalto',4.00,'',0.00,0),(81,'Operaz. ag. viag. normale 4%',4.00,'',0.00,0),(82,'Operaz. ag. viag. normale 10%',10.00,'',0.00,0),(83,'Autof. acq. fabbr. strum. 10%',10.00,'',0.00,0),(84,'Autof. acq. fabbr. strum. 4%',4.00,'',0.00,0),(85,'Operaz. ag. viag. normale 20%',20.00,'',0.00,0),(86,'Autof. acq. fabbr. strum. 20%',20.00,'',0.00,0),(87,'Art. 36 D.L. 41/95 vend.',0.00,'',0.00,0),(88,'Art. 17 comma 6 DPR 633/72',0.00,'',0.00,0),(89,'Iva 21% indetraibile',21.00,'',100.00,0),(90,'Iva in reverse charge indetraibile',0.00,'',100.00,0),(91,'Iva 22%',22.00,'',0.00,0),(92,'Iva 22% indetraibile',22.00,'',100.00,0),(93,'Iva 22% indetraibile al 50%',22.00,'',50.00,0);
/*!40000 ALTER TABLE `co_iva` ENABLE KEYS */;
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
  `data` datetime NOT NULL,
  `data_documento` datetime NOT NULL,
  `iddocumento` varchar(10) NOT NULL,
  `idanagrafica` int NOT NULL,
  `descrizione` text NOT NULL,
  `idconto` int NOT NULL,
  `totale` decimal(12,4) DEFAULT NULL,
  `primanota` float(10,2) NOT NULL,
  PRIMARY KEY (`id`)
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
-- Table structure for table `co_ordiniservizio`
--

DROP TABLE IF EXISTS `co_ordiniservizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_ordiniservizio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idcontratto` int NOT NULL,
  `idintervento` varchar(25) NOT NULL,
  `data_scadenza` datetime NOT NULL,
  `matricola` varchar(25) NOT NULL,
  `copia_centrale` tinyint(1) NOT NULL,
  `copia_cliente` tinyint(1) NOT NULL,
  `copia_amministratore` tinyint(1) NOT NULL,
  `funzionamento_in_sicurezza` tinyint(1) NOT NULL,
  `stato` enum('aperto','chiuso') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_ordiniservizio`
--

LOCK TABLES `co_ordiniservizio` WRITE;
/*!40000 ALTER TABLE `co_ordiniservizio` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_ordiniservizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_ordiniservizio_pianificazionefatture`
--

DROP TABLE IF EXISTS `co_ordiniservizio_pianificazionefatture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_ordiniservizio_pianificazionefatture` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idcontratto` int NOT NULL,
  `data_scadenza` datetime NOT NULL,
  `idzona` int NOT NULL,
  `iddocumento` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_ordiniservizio_pianificazionefatture`
--

LOCK TABLES `co_ordiniservizio_pianificazionefatture` WRITE;
/*!40000 ALTER TABLE `co_ordiniservizio_pianificazionefatture` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_ordiniservizio_pianificazionefatture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_ordiniservizio_vociservizio`
--

DROP TABLE IF EXISTS `co_ordiniservizio_vociservizio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_ordiniservizio_vociservizio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idordineservizio` int NOT NULL,
  `voce` varchar(255) NOT NULL,
  `categoria` varchar(255) NOT NULL,
  `note` varchar(2000) NOT NULL,
  `eseguito` tinyint(1) NOT NULL,
  `presenza` tinyint(1) NOT NULL,
  `esito` tinyint(1) NOT NULL,
  `priorita` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_ordiniservizio_vociservizio`
--

LOCK TABLES `co_ordiniservizio_vociservizio` WRITE;
/*!40000 ALTER TABLE `co_ordiniservizio_vociservizio` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_ordiniservizio_vociservizio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_pagamenti`
--

DROP TABLE IF EXISTS `co_pagamenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_pagamenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(50) NOT NULL,
  `giorno` tinyint NOT NULL,
  `num_giorni` varchar(100) NOT NULL,
  `prc` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_pagamenti`
--

LOCK TABLES `co_pagamenti` WRITE;
/*!40000 ALTER TABLE `co_pagamenti` DISABLE KEYS */;
INSERT INTO `co_pagamenti` VALUES (1,'Rimessa diretta',0,'0',100),(2,'Rimessa diretta a 30gg',0,'30',100),(3,'Rimessa diretta 30gg fisso al 15',15,'30',100),(4,'Ri.Ba. 30gg d.f.',0,'30',100),(5,'Ri.Ba. 60gg d.f.',0,'60',100),(6,'Ri.Ba. 90gg d.f.',0,'90',100),(7,'Ri.Ba. 120gg d.f.',0,'120',100),(8,'Ri.Ba. 150gg d.f.',0,'150',100),(9,'Ri.Ba. 180gg d.f.',0,'180',100),(10,'Ri.Ba. 30/60gg d.f.',0,'30',50),(11,'Ri.Ba. 30/60gg d.f.',0,'60',50),(12,'Ri.Ba. 30/60/90gg d.f.',0,'30',33),(13,'Ri.Ba. 30/60/90gg d.f.',0,'60',33),(14,'Ri.Ba. 30/60/90gg d.f.',0,'90',34),(15,'Ri.Ba. 30/60/90/120gg d.f.',0,'30',25),(16,'Ri.Ba. 30/60/90/120gg d.f.',0,'60',25),(17,'Ri.Ba. 30/60/90/120gg d.f.',0,'90',25),(18,'Ri.Ba. 30/60/90/120gg d.f.',0,'120',25),(19,'Ri.Ba. 30/60/90/120/150gg d.f.',0,'30',20),(20,'Ri.Ba. 30/60/90/120/150gg d.f.',0,'60',20),(21,'Ri.Ba. 30/60/90/120/150gg d.f.',0,'90',20),(22,'Ri.Ba. 30/60/90/120/150gg d.f.',0,'120',20),(23,'Ri.Ba. 30/60/90/120/150gg d.f.',0,'150',20),(24,'Ri.Ba. 30/60/90/120/150/180gg d.f.',0,'30',16),(25,'Ri.Ba. 30/60/90/120/150/180gg d.f.',0,'60',16),(26,'Ri.Ba. 30/60/90/120/150/180gg d.f.',0,'90',16),(27,'Ri.Ba. 30/60/90/120/150/180gg d.f.',0,'120',16),(28,'Ri.Ba. 30/60/90/120/150/180gg d.f.',0,'150',16),(29,'Ri.Ba. 30/60/90/120/150/180gg d.f.',0,'180',20),(30,'Ri.Ba. 30gg d.f.f.m.',-1,'30',100),(31,'Ri.Ba. 60gg d.f.f.m.',-1,'60',100),(32,'Ri.Ba. 90gg d.f.f.m.',-1,'90',100),(33,'Ri.Ba. 120gg d.f.f.m.',-1,'120',100),(34,'Ri.Ba. 150gg d.f.f.m.',-1,'150',100),(35,'Ri.Ba. 180gg d.f.f.m.',-1,'180',100),(36,'Ri.Ba. 30/60gg d.f.f.m.',-1,'30',50),(37,'Ri.Ba. 30/60gg d.f.f.m.',-1,'60',50),(38,'Ri.Ba. 30/60/90gg d.f.f.m.',-1,'30',33),(39,'Ri.Ba. 30/60/90gg d.f.f.m.',-1,'60',33),(40,'Ri.Ba. 30/60/90gg d.f.f.m.',-1,'90',34),(41,'Ri.Ba. 30/60/90/120gg d.f.f.m.',-1,'30',25),(42,'Ri.Ba. 30/60/90/120gg d.f.f.m.',-1,'60',25),(43,'Ri.Ba. 30/60/90/120gg d.f.f.m.',-1,'90',25),(44,'Ri.Ba. 30/60/90/120gg d.f.f.m.',-1,'120',25),(45,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.',-1,'30',20),(46,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.',-1,'60',20),(47,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.',-1,'90',20),(48,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.',-1,'120',20),(49,'Ri.Ba. 30/60/90/120/150gg d.f.f.m.',-1,'150',20),(50,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.',-1,'30',16),(51,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.',-1,'60',16),(52,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.',-1,'90',16),(53,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.',-1,'120',16),(54,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.',-1,'150',16),(55,'Ri.Ba. 30/60/90/120/150/180gg d.f.f.m.',-1,'180',20),(56,'Bonifico 30gg d.f.',0,'30',100),(57,'Bonifico 60gg d.f.',0,'60',100),(58,'Bonifico 90gg d.f.',0,'90',100),(59,'Bonifico 120gg d.f.',0,'120',100),(60,'Bonifico 150gg d.f.',0,'150',100),(61,'Bonifico 180gg d.f.',0,'180',100),(62,'Bonifico 30/60gg d.f.',0,'30',50),(63,'Bonifico 30/60gg d.f.',0,'60',50),(64,'Bonifico 30/60/90gg d.f.',0,'30',33),(65,'Bonifico 30/60/90gg d.f.',0,'60',33),(66,'Bonifico 30/60/90gg d.f.',0,'90',34),(67,'Bonifico 30/60/90/120gg d.f.',0,'30',25),(68,'Bonifico 30/60/90/120gg d.f.',0,'60',25),(69,'Bonifico 30/60/90/120gg d.f.',0,'90',25),(70,'Bonifico 30/60/90/120gg d.f.',0,'120',25),(71,'Bonifico 30/60/90/120/150gg d.f.',0,'30',20),(72,'Bonifico 30/60/90/120/150gg d.f.',0,'60',20),(73,'Bonifico 30/60/90/120/150gg d.f.',0,'90',20),(74,'Bonifico 30/60/90/120/150gg d.f.',0,'120',20),(75,'Bonifico 30/60/90/120/150gg d.f.',0,'150',20),(76,'Bonifico 30/60/90/120/150/180gg d.f.',0,'30',16),(77,'Bonifico 30/60/90/120/150/180gg d.f.',0,'60',16),(78,'Bonifico 30/60/90/120/150/180gg d.f.',0,'90',16),(79,'Bonifico 30/60/90/120/150/180gg d.f.',0,'120',16),(80,'Bonifico 30/60/90/120/150/180gg d.f.',0,'150',16),(81,'Bonifico 30/60/90/120/150/180gg d.f.',0,'180',20),(82,'Bonifico 30gg d.f.f.m.',-1,'30',100),(83,'Bonifico 60gg d.f.f.m.',-1,'60',100),(84,'Bonifico 90gg d.f.f.m.',-1,'90',100),(85,'Bonifico 120gg d.f.f.m.',-1,'120',100),(86,'Bonifico 150gg d.f.f.m.',-1,'150',100),(87,'Bonifico 180gg d.f.f.m.',-1,'180',100),(88,'Bonifico 30/60gg d.f.f.m.',-1,'30',50),(89,'Bonifico 30/60gg d.f.f.m.',-1,'60',50),(90,'Bonifico 30/60/90gg d.f.f.m.',-1,'30',33),(91,'Bonifico 30/60/90gg d.f.f.m.',-1,'60',33),(92,'Bonifico 30/60/90gg d.f.f.m.',-1,'90',34),(93,'Bonifico 30/60/90/120gg d.f.f.m.',-1,'30',25),(94,'Bonifico 30/60/90/120gg d.f.f.m.',-1,'60',25),(95,'Bonifico 30/60/90/120gg d.f.f.m.',-1,'90',25),(96,'Bonifico 30/60/90/120gg d.f.f.m.',-1,'120',25),(97,'Bonifico 30/60/90/120/150gg d.f.f.m.',-1,'30',20),(98,'Bonifico 30/60/90/120/150gg d.f.f.m.',-1,'60',20),(99,'Bonifico 30/60/90/120/150gg d.f.f.m.',-1,'90',20),(100,'Bonifico 30/60/90/120/150gg d.f.f.m.',-1,'120',20),(101,'Bonifico 30/60/90/120/150gg d.f.f.m.',-1,'150',20),(102,'Bonifico 30/60/90/120/150/180gg d.f.f.m.',-1,'30',16),(103,'Bonifico 30/60/90/120/150/180gg d.f.f.m.',-1,'60',16),(104,'Bonifico 30/60/90/120/150/180gg d.f.f.m.',-1,'90',16),(105,'Bonifico 30/60/90/120/150/180gg d.f.f.m.',-1,'120',16),(106,'Bonifico 30/60/90/120/150/180gg d.f.f.m.',-1,'150',16),(107,'Bonifico 30/60/90/120/150/180gg d.f.f.m.',-1,'180',20),(108,'Cambiale',0,'0',100),(109,'Assegno',0,'0',100),(110,'Bancomat',0,'0',100),(111,'Contanti',0,'0',100),(112,'Visa',0,'0',100);
/*!40000 ALTER TABLE `co_pagamenti` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_pianodeiconti2`
--

LOCK TABLES `co_pianodeiconti2` WRITE;
/*!40000 ALTER TABLE `co_pianodeiconti2` DISABLE KEYS */;
INSERT INTO `co_pianodeiconti2` VALUES (1,'100','Cassa e banche',1,''),(2,'110','Crediti clienti e crediti diversi',1,''),(3,'120','Effetti attivi',1,''),(4,'130','Ratei e risconti attivi',1,''),(5,'200','Erario iva, INPS, IRPEF, INAIL, ecc',1,''),(6,'220','Immobilizzazioni',1,''),(7,'230','Rimanente magazzino',1,''),(8,'240','Debiti fornitori e debiti diversi',1,''),(9,'250','Ratei e risconti passivi',1,''),(10,'300','Fondi ammortamento',1,''),(11,'310','Altri fondi',1,''),(12,'400','Capitale',1,''),(14,'600','Costi merci c/acquisto',2,'uscita'),(15,'610','Costi generali',2,'uscita'),(16,'620','Costi diversi',2,''),(17,'630','Costi del personale',2,''),(18,'640','Costi ammortamenti',2,''),(19,'650','Costi accantonamenti',2,''),(20,'700','Ricavi',2,'entrata'),(21,'810','Perdite e profitti',2,''),(22,'900','Conti transitori',2,'');
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
  `can_delete` tinyint(1) NOT NULL,
  `can_edit` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_pianodeiconti3`
--

LOCK TABLES `co_pianodeiconti3` WRITE;
/*!40000 ALTER TABLE `co_pianodeiconti3` DISABLE KEYS */;
INSERT INTO `co_pianodeiconti3` VALUES (1,'000010','Cassa',1,'',0,0),(2,'000020','Banca C/C',1,'',0,0),(3,'000030','Effetti in portafoglio',1,'',0,0),(4,'000040','Banca effetti all\'incasso',1,'',0,0),(5,'000050','Titoli',1,'',0,0),(6,'000010','Riepilogativo clienti',2,'',0,0),(7,'000030','Clienti per fatture da emettere',2,'',0,0),(8,'000040','Crediti imposte',2,'',0,0),(9,'000050','Crediti diversi',2,'',0,0),(10,'000060','Ri.Ba in portafoglio',2,'',0,0),(11,'000080','Dipendenti c/stipendi',2,'',0,0),(12,'000090','Amministratori c/emolumenti',2,'',0,0),(13,'000010','Effetti allo sconto',3,'',0,0),(14,'000020','Effetti all\'incasso',3,'',0,0),(15,'000030','Effetti insoluti',3,'',0,0),(16,'000010','Risconti attivi',4,'',0,0),(17,'000020','Ratei attivi',4,'',0,0),(18,'000005','Erario c/to iva',5,'',0,0),(19,'000010','Erario c/INPS',5,'',0,0),(20,'000030','Erario c/IRPEF',5,'',0,0),(21,'000040','Erario c/INAIL',5,'',0,0),(22,'000050','Erario c/acconto TFR',5,'',0,0),(23,'000060','Erario c/ritenute d\'acconto',5,'',0,0),(24,'000070','Erario c/enasarco',5,'',0,0),(25,'000080','Erario c/varie',5,'',0,0),(26,'000010','Fabbricati',6,'',1,0),(27,'000020','Mobili e macchine da ufficio',6,'',0,0),(28,'000030','Automezzi',6,'',0,0),(29,'000040','Impianti e attrezzature',6,'',0,0),(30,'000060','Manutenzione da ammortizzare',6,'',0,0),(31,'000070','Costi pluriennali',6,'',0,0),(32,'000010','Merci c/to rimanenze materie prime',7,'',0,0),(33,'000020','Merci c/to rimanenze semilavorati',7,'',0,0),(34,'000010','Riepilogativo fornitori',8,'',0,0),(35,'000020','Cambiali passive',8,'',0,0),(36,'000030','Mutui passivi',8,'',0,0),(37,'000040','Debiti verso banche',8,'',0,0),(38,'000050','Fornitori per fatture da ricevere',8,'',0,0),(39,'000060','Debiti diversi',8,'',0,0),(40,'000070','Finanziamenti vari',8,'',0,0),(41,'000200','Riepilogativo fornitori contabilit&agrave; semplificata',8,'',0,0),(42,'000010','Risconti passivi',9,'',0,0),(43,'000020','Ratei passivi',9,'',0,0),(44,'000010','Fondi ammortamento fabbricati',10,'',0,0),(45,'000020','Fondi ammortamento mobili e macchine da ufficio',10,'',0,0),(46,'000030','Fondi ammortamento automezzi',10,'',0,0),(47,'000040','Fondi ammortamento impianti e attrezzature',10,'',0,0),(48,'000060','Fondi ammortamento manutenzione da ammortizzare',10,'',0,0),(49,'000070','Fondi ammortamento costi pluriennali',10,'',0,0),(50,'000010','Fondo imposte e tasse',11,'',0,0),(51,'000020','Fondo TFR liquidazione personale',11,'',0,0),(52,'000010','Capitale sociale o netto',12,'',0,0),(53,'000020','Riserve',12,'',0,0),(55,'000010','Costi merci c/acquisto di rivendita',14,'uscita',0,0),(56,'000020','Costi merci c/acquisto di produzione',14,'uscita',0,0),(57,'000030','Costi merci c/acquisto intracomunitario',14,'uscita',0,0),(58,'000040','Costi merci c/acquisto importazioni',14,'uscita',0,0),(59,'000010','Spese telefoniche',15,'uscita',1,1),(60,'000020','Spese postali',15,'uscita',1,1),(61,'000030','Spese cancelleria',15,'uscita',1,1),(62,'000040','Spese locomozione e carburante',15,'uscita',0,0),(63,'000050','Spese software',15,'uscita',1,1),(64,'000060','Spese energia elettrica',15,'uscita',1,1),(65,'000070','Spese consulenze',15,'uscita',1,1),(66,'000080','Spese varie',15,'uscita',1,1),(67,'000090','Spese assicurazioni',15,'uscita',1,1),(68,'000100','Spese bancarie',15,'uscita',1,1),(69,'000110','Spese fitti passivi',15,'uscita',1,1),(70,'000120','Spese ristoranti e alberghi',15,'uscita',1,1),(71,'000130','Spese manutenzione e riparazione',15,'uscita',1,1),(72,'000140','Spese canoni leasing',15,'uscita',1,1),(73,'000150','Spese acquisto beni strumentali non ammortizzabilii',15,'uscita',0,0),(74,'000010','Costi interessi passivi',16,'',0,0),(75,'000020','Costi abbuoni passivi',16,'',0,0),(76,'000030','Costi imposte e tasse',16,'',0,0),(77,'000040','Costi imposta IRA',16,'',0,0),(78,'000050','Costi minusvalenze',16,'',0,0),(79,'000060','Costi perdite su crediti',16,'',0,0),(80,'000070','Costi sopravvenienze passive',16,'',0,0),(81,'000080','Costi perdite da operazioni finanziarie',16,'',0,0),(82,'000010','Costi salari e stipendi',17,'',0,0),(83,'000020','Costi contributi sociali',17,'',0,0),(84,'000040','Costi TFR',17,'',0,0),(85,'000050','Costi contributi dipendenti',17,'',0,0),(86,'000060','Costi contributi assicurazione lavoro',17,'',0,0),(87,'000010','Ammortamento fabbricati',18,'',0,0),(88,'000020','Ammortamento mobili e macchine ufficio',18,'',0,0),(89,'000030','Ammortamento automezzi',18,'',0,0),(90,'000040','Ammortamento impianti e attrezzature',18,'',0,0),(91,'000060','Ammortamento manutenzioni',18,'',0,0),(92,'000070','Ammortamento costi pluriennali',18,'',0,0),(93,'000010','Accantonamento TFR',19,'',0,0),(94,'000010','Ricavi merci c/to vendite',20,'entrata',0,0),(95,'000020','Ricavi vendita prestazione servizi',20,'entrata',0,0),(96,'000030','Ricavi interessi attivi',20,'entrata',0,0),(97,'000040','Ricavi fitti attivi',20,'entrata',0,0),(98,'000050','Ricavi vari',20,'entrata',0,0),(99,'000051','Rimborso spese marche da bollo',20,'',0,0),(100,'000060','Ricavi abbuoni attivi',20,'',0,0),(101,'000070','Ricavi sopravvenienze attive',20,'',0,0),(102,'000080','Ricavi plusvalenze',20,'',0,0),(103,'000020','Perdite e profitti',21,'',0,0),(104,'000010','Apertura conti patrimoniali',21,'',0,0),(105,'000900','Chiusura conti patrimoniali',21,'',0,0),(106,'000010','Iva su vendite',22,'',0,0),(107,'000020','Iva su acquisti',22,'',0,0),(108,'000030','Iva indetraibile',22,'',0,0),(109,'000200','Intra UE: riepilogativo fornitori',22,'',0,0),(110,'000210','Intra UE: transitorio iva',22,'',0,0),(111,'000220','Intra UE: transitorio per movimento iva',22,'',0,0);
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
  `data_bozza` datetime NOT NULL,
  `data_accettazione` datetime NOT NULL,
  `data_rifiuto` datetime NOT NULL,
  `data_conclusione` datetime NOT NULL,
  `data_pagamento` datetime NOT NULL,
  `budget` decimal(12,4) NOT NULL,
  `descrizione` text NOT NULL,
  `idstato` tinyint NOT NULL,
  `validita` int NOT NULL,
  `tempi_consegna` varchar(255) NOT NULL,
  `idanagrafica` int NOT NULL,
  `esclusioni` text NOT NULL,
  `idreferente` int NOT NULL,
  `idpagamento` int NOT NULL,
  `idporto` int NOT NULL,
  `idtipointervento` varchar(25) NOT NULL,
  `costo_diritto_chiamata` decimal(12,4) NOT NULL,
  `ore_lavoro` decimal(12,4) NOT NULL,
  `costo_orario` decimal(12,4) NOT NULL,
  `costo_km` decimal(12,4) NOT NULL,
  PRIMARY KEY (`id`)
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
-- Table structure for table `co_preventivi_interventi`
--

DROP TABLE IF EXISTS `co_preventivi_interventi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_preventivi_interventi` (
  `idpreventivo` int NOT NULL,
  `idintervento` varchar(25) NOT NULL,
  `costo_orario` decimal(12,4) NOT NULL,
  `costo_km` decimal(12,4) NOT NULL,
  PRIMARY KEY (`idpreventivo`,`idintervento`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_preventivi_interventi`
--

LOCK TABLES `co_preventivi_interventi` WRITE;
/*!40000 ALTER TABLE `co_preventivi_interventi` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_preventivi_interventi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_righe2_contratti`
--

DROP TABLE IF EXISTS `co_righe2_contratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_righe2_contratti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idcontratto` int NOT NULL,
  `descrizione` text NOT NULL,
  `subtotale` decimal(12,4) NOT NULL,
  `um` varchar(20) NOT NULL,
  `qta` decimal(12,4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_righe2_contratti`
--

LOCK TABLES `co_righe2_contratti` WRITE;
/*!40000 ALTER TABLE `co_righe2_contratti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_righe2_contratti` ENABLE KEYS */;
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
  `idintervento` varchar(25) NOT NULL,
  `idtipointervento` varchar(25) NOT NULL,
  `data_richiesta` datetime NOT NULL,
  `richiesta` varchar(8000) NOT NULL,
  `idsede` int NOT NULL,
  PRIMARY KEY (`id`)
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
  `idintervento` varchar(25) NOT NULL,
  `idarticolo` int NOT NULL,
  `idpreventivo` int NOT NULL,
  `idcontratto` int NOT NULL,
  `idtecnico` int NOT NULL,
  `idagente` int NOT NULL,
  `idautomezzo` int NOT NULL,
  `idiva` int NOT NULL,
  `desc_iva` varchar(255) NOT NULL,
  `iva` decimal(12,4) NOT NULL,
  `iva_indetraibile` decimal(12,4) NOT NULL,
  `descrizione` text NOT NULL,
  `subtotale` decimal(12,4) NOT NULL,
  `sconto` decimal(12,4) NOT NULL,
  `um` varchar(20) NOT NULL,
  `qta` decimal(12,4) NOT NULL,
  `lotto` varchar(50) NOT NULL,
  `serial` varchar(50) NOT NULL,
  `altro` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
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
  `data_evasione` datetime NOT NULL,
  `idpreventivo` int NOT NULL,
  `idarticolo` int NOT NULL,
  `idiva` int NOT NULL,
  `iva` decimal(12,4) NOT NULL,
  `iva_indetraibile` decimal(12,4) NOT NULL,
  `descrizione` text NOT NULL,
  `lotto` varchar(50) NOT NULL,
  `serial` varchar(50) NOT NULL,
  `altro` varchar(50) NOT NULL,
  `subtotale` decimal(12,4) NOT NULL,
  `um` varchar(20) NOT NULL,
  `qta` decimal(12,4) NOT NULL,
  PRIMARY KEY (`id`)
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
-- Table structure for table `co_ritenutaacconto`
--

DROP TABLE IF EXISTS `co_ritenutaacconto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_ritenutaacconto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) NOT NULL,
  `percentuale` float(5,2) NOT NULL,
  `indetraibile` float(5,2) NOT NULL,
  `esente` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_ritenutaacconto`
--

LOCK TABLES `co_ritenutaacconto` WRITE;
/*!40000 ALTER TABLE `co_ritenutaacconto` DISABLE KEYS */;
INSERT INTO `co_ritenutaacconto` VALUES (1,'Ritenuta d\'acconto 20%',20.00,0.00,0);
/*!40000 ALTER TABLE `co_ritenutaacconto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_rivalsainps`
--

DROP TABLE IF EXISTS `co_rivalsainps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_rivalsainps` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) NOT NULL,
  `percentuale` float(5,2) NOT NULL,
  `indetraibile` float(5,2) NOT NULL,
  `esente` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_rivalsainps`
--

LOCK TABLES `co_rivalsainps` WRITE;
/*!40000 ALTER TABLE `co_rivalsainps` DISABLE KEYS */;
INSERT INTO `co_rivalsainps` VALUES (1,'Rivalsa INPS 4%',4.00,0.00,0);
/*!40000 ALTER TABLE `co_rivalsainps` ENABLE KEYS */;
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
  `data_emissione` datetime NOT NULL,
  `scadenza` datetime NOT NULL,
  `da_pagare` decimal(12,4) DEFAULT NULL,
  `pagato` decimal(12,4) DEFAULT NULL,
  `data_pagamento` datetime NOT NULL,
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
-- Table structure for table `co_staticontratti`
--

DROP TABLE IF EXISTS `co_staticontratti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_staticontratti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_bloccato` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_staticontratti`
--

LOCK TABLES `co_staticontratti` WRITE;
/*!40000 ALTER TABLE `co_staticontratti` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_staticontratti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_statipreventivi`
--

DROP TABLE IF EXISTS `co_statipreventivi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `co_statipreventivi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_bloccato` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_statipreventivi`
--

LOCK TABLES `co_statipreventivi` WRITE;
/*!40000 ALTER TABLE `co_statipreventivi` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_statipreventivi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dt_statiddt`
--

DROP TABLE IF EXISTS `dt_statiddt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dt_statiddt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_bloccato` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dt_statiddt`
--

LOCK TABLES `dt_statiddt` WRITE;
/*!40000 ALTER TABLE `dt_statiddt` DISABLE KEYS */;
/*!40000 ALTER TABLE `dt_statiddt` ENABLE KEYS */;
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
-- Table structure for table `in_statiintervento`
--

DROP TABLE IF EXISTS `in_statiintervento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_statiintervento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_bloccato` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_statiintervento`
--

LOCK TABLES `in_statiintervento` WRITE;
/*!40000 ALTER TABLE `in_statiintervento` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_statiintervento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mg_articoli`
--

DROP TABLE IF EXISTS `mg_articoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_articoli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_categoria` int DEFAULT NULL,
  `id_sottocategoria` int DEFAULT NULL,
  `id_marca` int DEFAULT NULL,
  `id_modello` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id_marchio` int DEFAULT NULL,
  PRIMARY KEY (`id`)
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
-- Table structure for table `mg_marchi`
--

DROP TABLE IF EXISTS `mg_marchi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mg_marchi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mg_marchi`
--

LOCK TABLES `mg_marchi` WRITE;
/*!40000 ALTER TABLE `mg_marchi` DISABLE KEYS */;
/*!40000 ALTER TABLE `mg_marchi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_impianti`
--

DROP TABLE IF EXISTS `my_impianti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_impianti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `id_categoria` int DEFAULT NULL,
  `id_sottocategoria` int DEFAULT NULL,
  `id_marca` int DEFAULT NULL,
  `id_modello` int DEFAULT NULL,
  PRIMARY KEY (`id`)
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
-- Table structure for table `or_statiordine`
--

DROP TABLE IF EXISTS `or_statiordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `or_statiordine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_bloccato` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `or_statiordine`
--

LOCK TABLES `or_statiordine` WRITE;
/*!40000 ALTER TABLE `or_statiordine` DISABLE KEYS */;
/*!40000 ALTER TABLE `or_statiordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updates`
--

DROP TABLE IF EXISTS `updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `updates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `directory` varchar(255) DEFAULT NULL,
  `version` varchar(255) NOT NULL,
  `sql` tinyint(1) NOT NULL,
  `script` tinyint(1) NOT NULL,
  `done` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates`
--

LOCK TABLES `updates` WRITE;
/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_api_resources`
--

DROP TABLE IF EXISTS `zz_api_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_api_resources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_api_resources`
--

LOCK TABLES `zz_api_resources` WRITE;
/*!40000 ALTER TABLE `zz_api_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_api_resources` ENABLE KEYS */;
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
  `note` text,
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
-- Table structure for table `zz_marche`
--

DROP TABLE IF EXISTS `zz_marche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_marche` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parent` int DEFAULT NULL,
  `is_articolo` tinyint(1) DEFAULT '1',
  `is_impianto` tinyint(1) DEFAULT '0',
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
  `name` varchar(255) DEFAULT NULL,
  `directory` varchar(255) DEFAULT NULL,
  `options` text,
  `options2` text,
  `icon` varchar(255) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `compatibility` varchar(50) DEFAULT NULL,
  `order` int DEFAULT NULL,
  `parent` int DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `use_notes` tinyint(1) DEFAULT NULL,
  `use_checklists` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_modules`
--

LOCK TABLES `zz_modules` WRITE;
/*!40000 ALTER TABLE `zz_modules` DISABLE KEYS */;
INSERT INTO `zz_modules` VALUES (1,'Marchi','marchi','SELECT |select| FROM `mg_marchi` WHERE 1=1 HAVING 2=2 ORDER BY `mg_marchi`.`name`','','fa fa-angle-right','2.6','2.6',7,NULL,1,1,1,1);
/*!40000 ALTER TABLE `zz_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_modules_lang`
--

DROP TABLE IF EXISTS `zz_modules_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_modules_lang` (
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_lang`,`id_record`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_modules_lang`
--

LOCK TABLES `zz_modules_lang` WRITE;
/*!40000 ALTER TABLE `zz_modules_lang` DISABLE KEYS */;
INSERT INTO `zz_modules_lang` VALUES (1,1,'Marchi',NULL),(2,1,'Marchi',NULL);
/*!40000 ALTER TABLE `zz_modules_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_plugins`
--

DROP TABLE IF EXISTS `zz_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `options` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_plugins`
--

LOCK TABLES `zz_plugins` WRITE;
/*!40000 ALTER TABLE `zz_plugins` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_segments`
--

DROP TABLE IF EXISTS `zz_segments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_segments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `clause` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_segments`
--

LOCK TABLES `zz_segments` WRITE;
/*!40000 ALTER TABLE `zz_segments` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_segments` ENABLE KEYS */;
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
  `tipo` varchar(255) DEFAULT NULL,
  `editable` tinyint(1) DEFAULT '0',
  `sezione` varchar(255) DEFAULT NULL,
  `order` int DEFAULT NULL,
  `is_user_setting` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_settings`
--

LOCK TABLES `zz_settings` WRITE;
/*!40000 ALTER TABLE `zz_settings` DISABLE KEYS */;
INSERT INTO `zz_settings` VALUES (1,'Api key ibanapi.com','','string',1,'API',NULL,0),(2,'OpenRouter API Key','','string',1,'API',NULL,0),(3,'Endpoint ibanapi.com','https://api.ibanapi.com','string',1,'API',NULL,0),(4,'Api key ibanapi.com','','string',1,'API',NULL,0),(5,'Endpoint ibanapi.com','https://api.ibanapi.com','string',1,'API',NULL,0),(6,'Api key ibanapi.com','','string',1,'API',NULL,0),(7,'Endpoint ibanapi.com','https://api.ibanapi.com','string',1,'API',NULL,0),(8,'Api key ibanapi.com','','string',1,'API',NULL,0);
/*!40000 ALTER TABLE `zz_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_settings_lang`
--

DROP TABLE IF EXISTS `zz_settings_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_settings_lang` (
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `help` text,
  PRIMARY KEY (`id_lang`,`id_record`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_settings_lang`
--

LOCK TABLES `zz_settings_lang` WRITE;
/*!40000 ALTER TABLE `zz_settings_lang` DISABLE KEYS */;
INSERT INTO `zz_settings_lang` VALUES (1,1,'Api key ibanapi.com',NULL),(1,2,'OpenRouter API Key','API Key per l\'integrazione con OpenRouter AI. Ottieni la tua chiave da https://openrouter.ai/keys'),(1,3,'Endpoint ibanapi.com',NULL);
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
  `name` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `options` text,
  `can_delete` tinyint(1) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_local` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_storage_adapters`
--

LOCK TABLES `zz_storage_adapters` WRITE;
/*!40000 ALTER TABLE `zz_storage_adapters` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_storage_adapters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_views`
--

DROP TABLE IF EXISTS `zz_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_views` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_module` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `query` text,
  `order` int DEFAULT NULL,
  `search` tinyint(1) DEFAULT NULL,
  `slow` tinyint(1) DEFAULT NULL,
  `format` tinyint(1) DEFAULT NULL,
  `html_format` tinyint(1) DEFAULT NULL,
  `search_inside` tinyint(1) DEFAULT NULL,
  `order_by` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  `summable` tinyint(1) DEFAULT NULL,
  `avg` tinyint(1) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_views`
--

LOCK TABLES `zz_views` WRITE;
/*!40000 ALTER TABLE `zz_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_views_lang`
--

DROP TABLE IF EXISTS `zz_views_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_views_lang` (
  `id_lang` int NOT NULL,
  `id_record` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `help` text,
  PRIMARY KEY (`id_lang`,`id_record`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_views_lang`
--

LOCK TABLES `zz_views_lang` WRITE;
/*!40000 ALTER TABLE `zz_views_lang` DISABLE KEYS */;
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
  `query` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_widgets`
--

LOCK TABLES `zz_widgets` WRITE;
/*!40000 ALTER TABLE `zz_widgets` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_widgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database '2_8'
--

--
-- Dumping routines for database '2_8'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-25 14:51:57

-- MySQL dump 10.13  Distrib 8.4.5, for Win64 (x86_64)
--
-- Host: localhost    Database: magazzino
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
-- Table structure for table `articoli`
--

DROP TABLE IF EXISTS `articoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articoli` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `quantita` decimal(12,2) DEFAULT NULL,
  `min` decimal(12,2) DEFAULT NULL,
  `max` decimal(12,2) DEFAULT NULL,
  `supplier` varchar(100) NOT NULL,
  `has_diba` enum('S','N') NOT NULL DEFAULT 'N',
  `um` varchar(10) DEFAULT NULL,
  `prezzo` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articoli`
--

LOCK TABLES `articoli` WRITE;
/*!40000 ALTER TABLE `articoli` DISABLE KEYS */;
INSERT INTO `articoli` VALUES (1,'Vite M6','vite metrica 6mm in acciaio',100.00,30.00,30.00,'SIEMENS','N',NULL,21.57),(2,'Rondella Ø5','Rondella zincata',500.00,100.00,2000.00,'Bulloneria Srl','N',NULL,43.50),(3,'Piastra Supporto','Piastra in acciaio 100x50mm',35.00,10.00,100.00,'Metaltech','N',NULL,52.78),(4,'Motore 230V','Motore monofase 230V',8.00,2.00,15.00,'ElettroPower','S',NULL,33.41),(5,'Cavo 3x1.5mm²','Cavo multipolare nero',120.00,30.00,500.00,'Cavi Italia','N',NULL,88.72),(6,'Connettore 4 pin','Connettore per motore',75.00,20.00,300.00,'ElettroPower','N',NULL,63.36),(7,'Involucro ABS','Box in plastica ABS',60.00,10.00,200.00,'PlastTech','N',NULL,40.65),(8,'Pannello LED','Modulo LED 12V',42.00,10.00,100.00,'LucePro','N',NULL,93.18),(9,'Scheda controllo','PCB controller v1.2',22.00,5.00,50.00,'PCB Factory','N',NULL,63.92),(10,'Gruppo montaggio A','Assemblato con motore e supporti',10.00,0.00,30.00,'Assemblaggi Spa','S',NULL,30.09),(16,'eee','fff',9000.00,0.00,0.00,'OMRON','N',NULL,38.69),(19,'product 70','descrizione prodotto 70',0.00,0.00,58900000.00,'','N',NULL,93.16),(20,'product 80','descrizione prodotto 80 jljljllljlkjlj ljljljljljljllklkjlkjljlk',0.00,0.00,0.00,'','N',NULL,69.76),(21,'product 90000','descrizione prodotto 90000 della lista dei prodotti',665.00,9.00,100.00,'','N',NULL,59.29),(22,'999999','ojeojojoijoi',988.00,8.00,12.00,'BAXI','S',NULL,77.18),(25,'KHKJHKHKHKJgggggggggggggggggppppppppppppppppppppppppppppppppppp','KHKHKJHKHKHKHKJHK',78788.00,778.00,79.00,'','N',NULL,18.01),(26,'HJKGHKGHKGQ','OJOJGLJ',71810.00,7.00,8.00,'','N',NULL,28.54),(27,'NJKHH','HKJHKJHK',8.00,8.00,8.00,'','N',NULL,78.65),(28,'JLKJLJLKJLKJLKJ','LKJLJL',908.00,8.00,8.00,'SIEMENS','N',NULL,27.64),(29,'UOUO','OUOUOI',8.00,8.00,8.00,'','N',NULL,72.25),(30,'ORITTOU','OUORTUOTU',197.00,7.00,7.00,'SIEMENS','N',NULL,88.32),(31,'RTRTRE','RTR',100.00,20.00,250.00,'','N',NULL,34.84),(32,'78787878','questo è il prodotto di codice 78787878 della lista dei prodotti',21008.00,10.00,200.00,'OMRON','N',NULL,79.24),(33,'88888888','questo è il prodotto numero 88888888 della lista dei prdotti',1820233.00,70.00,800.00,'BAXI','N',NULL,11.71);
/*!40000 ALTER TABLE `articoli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `causali`
--

DROP TABLE IF EXISTS `causali`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `causali` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codice` varchar(3) NOT NULL,
  `description` varchar(250) NOT NULL,
  `tipo` enum('C','S') NOT NULL,
  `attiva` tinyint DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `causali`
--

LOCK TABLES `causali` WRITE;
/*!40000 ALTER TABLE `causali` DISABLE KEYS */;
INSERT INTO `causali` VALUES (1,'CAR','Carico da fornitore','C',1),(2,'RET','Rientro produzione','C',1),(3,'INV','Rettifica inventariale (carico)','C',1),(4,'PRE','Prelievo produzione','S',1),(5,'VEN','Vendita cliente','S',1),(6,'INV','Rettifica inventariale (scarico)','S',1),(7,'RSF','Reso a fornitore','S',1),(8,'RCL','Reso da cliente','C',1);
/*!40000 ALTER TABLE `causali` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clienti`
--

DROP TABLE IF EXISTS `clienti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clienti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codice` varchar(10) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `tipo_cliente` enum('Privato','Azienda') NOT NULL DEFAULT 'Privato',
  `partita_iva` varchar(20) DEFAULT NULL,
  `cf` varchar(20) DEFAULT NULL,
  `indirizzo` varchar(255) DEFAULT NULL,
  `citta` varchar(100) DEFAULT NULL,
  `cap` varchar(10) DEFAULT NULL,
  `pv` varchar(2) DEFAULT NULL,
  `nazione` varchar(50) DEFAULT 'Italia',
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `sito_web` varchar(100) DEFAULT NULL,
  `note` text,
  `data_creazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `data_modifica` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `contatto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codice` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienti`
--

LOCK TABLES `clienti` WRITE;
/*!40000 ALTER TABLE `clienti` DISABLE KEYS */;
INSERT INTO `clienti` VALUES (1,'CL0001','Mario Rossi','Privato',NULL,'RSSMRA80A01H501U','Via Roma 10','Milano','20100','MI','Italia','02-1234567','mario.rossi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Mario Rossi'),(2,'CL0002','Francesca Bianchi','Privato',NULL,'BNCHFNC85B22F205Y','Via Torino 5','Torino','10100','TO','Italia','011-2345678','francesca.bianchi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Francesca Bianchi'),(3,'CL0003','Giovanni Verdi','Privato',NULL,'VRDGNN90C15L219T','Piazza Garibaldi 7','Napoli','80100','NA','Italia','081-3456789','giovanni.verdi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Giovanni Verdi'),(4,'CL0004','Studio Tecnico Alfa','Azienda','01234567890',NULL,'Via Galileo Galilei 12','Bologna','40100','BO','Italia','051-4567890','info@studioalfa.it','www.studioalfa.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Bianchi'),(5,'CL0005','Impresa Edile Beta','Azienda','09876543210',NULL,'Via Dante 3','Firenze','50100','FI','Italia','055-5678901','contatti@edilebeta.it','www.edilebeta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Rossi'),(6,'CL0006','Lucia Neri','Privato',NULL,'NRELUC75D41F205Z','Via Marconi 21','Venezia','30100','VE','Italia','041-6789012','lucia.neri@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Lucia Neri'),(7,'CL0007','Azienda Gamma Srl','Azienda','02345678901',NULL,'Corso Italia 45','Genova','16100','GE','Italia','010-7890123','info@gammasrl.it','www.gammasrl.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott.ssa Verdi'),(8,'CL0008','Marco Russo','Privato',NULL,'RSSMRC82L17H501U','Via Manzoni 9','Palermo','90100','PA','Italia','091-8901234','marco.russo@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Marco Russo'),(9,'CL0009','Consorzio Delta','Azienda','03456789012',NULL,'Via della Libertà 16','Catania','95100','CT','Italia','095-9012345','info@consorziodelta.it','www.consorziodelta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Bianchi'),(10,'CL0010','Anna Gallo','Privato',NULL,'GLLANN83M22F205K','Via Leopardi 13','Bari','70100','BA','Italia','080-1234567','anna.gallo@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Anna Gallo'),(11,'CL0011','Società Epsilon','Azienda','04567890123',NULL,'Via Vittorio Veneto 4','Trieste','34100','TS','Italia','040-2345678','contatti@epsilon.it','www.epsilon.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Neri'),(12,'CL0012','Roberto Marino','Privato',NULL,'MRNRBT79P15H501S','Via Cavour 20','Verona','37100','VR','Italia','045-3456789','roberto.marino@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Roberto Marino'),(13,'CL0013','Ditta Zeta','Azienda','05678901234',NULL,'Via San Marco 11','Padova','35100','PD','Italia','049-4567890','info@dittazeta.it','www.dittazeta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Rossi'),(14,'CL0014','Elena Ferri','Privato',NULL,'FRRELE78B20F205Z','Via Roma 32','Reggio Emilia','42100','RE','Italia','0522-567890','elena.ferri@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Elena Ferri'),(15,'CL0015','Ingegneria Theta','Azienda','06789012345',NULL,'Via Piave 8','Parma','43100','PR','Italia','0521-678901','info@thetaingegneria.it','www.thetaingegneria.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Gallo'),(16,'CL0016','Laura Conti','Privato',NULL,'CNTLRA82C25F205V','Via Carducci 14','Modena','41100','MO','Italia','059-789012','laura.conti@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Laura Conti'),(17,'CL0017','Impresa Iota','Azienda','07890123456',NULL,'Via Roma 1','Rimini','47900','RN','Italia','0541-890123','info@impiantoiota.it','www.impiantoiota.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Bianchi'),(18,'CL0018','Paolo Villa','Privato',NULL,'VLLPLA85H14F205A','Via Verdi 2','Pescara','65100','PE','Italia','085-901234','paolo.villa@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Paolo Villa'),(19,'CL0019','Forniture Kappa','Azienda','08901234567',NULL,'Via Milano 20','Lecce','73100','LE','Italia','0832-123456','info@kappaforniture.it','www.kappaforniture.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott.ssa Ferri'),(20,'CL0020','Sonia Riva','Privato',NULL,'RVSNIA81S30F205N','Via Dante 18','Como','22100','CO','Italia','031-234567','sonia.riva@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Sonia Riva'),(21,'CL0021','Società Lambda','Azienda','09012345678',NULL,'Via Firenze 7','Arezzo','52100','AR','Italia','0575-345678','contatti@lambda.it','www.lambda.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Marino'),(22,'CL0022','Giorgio Esposito','Privato',NULL,'SPTGGR80D12F205W','Via Napoli 15','Salerno','84100','SA','Italia','089-456789','giorgio.esposito@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Giorgio Esposito'),(23,'CL0023','Ditta Mu','Azienda','09123456789',NULL,'Via Torino 50','Cagliari','09100','CA','Italia','070-567890','info@dittamu.it','www.dittamu.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Rossi');
/*!40000 ALTER TABLE `clienti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddt`
--

DROP TABLE IF EXISTS `ddt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ddt` (
  `id_ddt` int NOT NULL AUTO_INCREMENT,
  `num_ddt` varchar(20) NOT NULL,
  `data_ddt` date NOT NULL,
  `cliente_id` int NOT NULL,
  `stato` enum('DA_SPEDIRE','SPEDITO','ANNULLATO') DEFAULT 'DA_SPEDIRE',
  `note` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_ddt`),
  UNIQUE KEY `num_ddt` (`num_ddt`),
  KEY `fk_ddt_clienti` (`cliente_id`),
  CONSTRAINT `fk_ddt_clienti` FOREIGN KEY (`cliente_id`) REFERENCES `clienti` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddt`
--

LOCK TABLES `ddt` WRITE;
/*!40000 ALTER TABLE `ddt` DISABLE KEYS */;
/*!40000 ALTER TABLE `ddt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ddt_righe`
--

DROP TABLE IF EXISTS `ddt_righe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ddt_righe` (
  `id_riga` int NOT NULL AUTO_INCREMENT,
  `id_ddt` int NOT NULL,
  `cod_articolo` varchar(30) NOT NULL,
  `descrizione` varchar(255) DEFAULT NULL,
  `qta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_riga`),
  KEY `fk_righe_ddt` (`id_ddt`),
  CONSTRAINT `fk_righe_ddt` FOREIGN KEY (`id_ddt`) REFERENCES `ddt` (`id_ddt`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ddt_righe`
--

LOCK TABLES `ddt_righe` WRITE;
/*!40000 ALTER TABLE `ddt_righe` DISABLE KEYS */;
/*!40000 ALTER TABLE `ddt_righe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diba`
--

DROP TABLE IF EXISTS `diba`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diba` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_father` int NOT NULL,
  `id_son` int NOT NULL,
  `quantita` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_father` (`id_father`),
  KEY `id_son` (`id_son`),
  CONSTRAINT `diba_ibfk_1` FOREIGN KEY (`id_father`) REFERENCES `articoli` (`id`),
  CONSTRAINT `diba_ibfk_2` FOREIGN KEY (`id_son`) REFERENCES `articoli` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diba`
--

LOCK TABLES `diba` WRITE;
/*!40000 ALTER TABLE `diba` DISABLE KEYS */;
INSERT INTO `diba` VALUES (1,10,4,1.00),(2,10,3,2.00),(3,10,6,4.00),(4,10,7,1.00),(5,10,9,1.00),(6,10,8,1.00),(7,4,2,10.00),(8,4,2,130.00),(10,22,5,1.00),(11,10,30,1.00),(12,10,8,1.00),(13,10,3,1.00),(14,10,20,1.00),(15,10,21,1.00),(16,10,2,1.00),(17,10,2,1.00);
/*!40000 ALTER TABLE `diba` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornitori`
--

DROP TABLE IF EXISTS `fornitori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornitori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codice` varchar(10) NOT NULL,
  `rag_soc` varchar(255) NOT NULL,
  `partita_iva` varchar(20) NOT NULL,
  `cf` varchar(20) NOT NULL,
  `indirizzo` varchar(255) DEFAULT NULL,
  `citta` varchar(100) DEFAULT NULL,
  `cap` varchar(10) DEFAULT NULL,
  `pv` varchar(2) DEFAULT NULL,
  `nazione` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `sito_web` varchar(100) DEFAULT NULL,
  `note` text,
  `data_creazione` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `data_modifica` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `contatto` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codice` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornitori`
--

LOCK TABLES `fornitori` WRITE;
/*!40000 ALTER TABLE `fornitori` DISABLE KEYS */;
INSERT INTO `fornitori` VALUES (1,'F001','Alfa Logistics Srl','IT12345678901','RSSMRA80A01H501Z','Via Roma 10','Milano','20121','MI','Italia','+39 02 1234567','info@alfalogistics.it','www.alfalogistics.it','Fornitore principale per logistica.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(2,'F002','Beta Construction Spa','IT98765432109','BNCLGU75T10F205L','Corso Venezia 5','Torino','10123','TO','Italia','+39 011 7654321','contatti@betaconstruction.it','www.betaconstruction.it','Partner per edilizia.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(3,'F003','GammaTech SRL','IT13579246801','FRRVLR82L41D325C','Via Garibaldi 22','Bologna','40121','BO','Italia','+39 051 234567','gamma@gammatech.it','www.gammatech.it','Fornitore hardware e software.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(4,'F004','Delta Food SNC','IT24681357902','BNCPLA70H41F205P','Piazza Duomo 1','Firenze','50122','FI','Italia','+39 055 987654','delta@deltafood.it','www.deltafood.it','Specialista forniture alimentari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(5,'F005','Epsilon Energy Srl','IT10293847561','PLRMNL60C12H501S','Viale Europa 15','Napoli','80133','NA','Italia','+39 081 112233','epsilon@epsilonenergy.it','www.epsilonenergy.it','Forniture impianti energetici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(6,'F006','Zeta Motors Spa','IT56473829104','GRDRRT85M01F205R','Via Manzoni 8','Genova','16121','GE','Italia','+39 010 445566','zeta@zetamotors.it','www.zetamotors.it','Fornitore mezzi aziendali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(7,'F007','Eta Pharma Srl','IT91827364501','VRDLGU77T41H501T','Via Verdi 30','Palermo','90133','PA','Italia','+39 091 778899','eta@etapharma.it','www.etapharma.it','Farmaceutica e presidi medici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(8,'F008','Theta Systems SNC','IT19283746502','BRSCLD65A12F205G','Via Dante 12','Bari','70121','BA','Italia','+39 080 334455','theta@thetasystems.it','www.thetasystems.it','Servizi IT.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(9,'F009','Iota Fashion Srl','IT31415926535','NRCVTT88B41D325M','Corso Italia 50','Venezia','30121','VE','Italia','+39 041 556677','iota@iotafashion.it','www.iotafashion.it','Fornitore abbigliamento da lavoro.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(10,'F010','Kappa Agro Spa','IT16180339887','MNGFRN70C01H501P','Via Po 7','Verona','37121','VR','Italia','+39 045 998877','kappa@kappaagro.it','www.kappaagro.it','Prodotti agricoli.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(11,'F011','Lambda Services SRL','IT27182818284','BLNLRA79T10F205Z','Via Mazzini 18','Trieste','34121','TS','Italia','+39 040 223344','lambda@lambdaservices.it','www.lambdaservices.it','Servizi generali per aziende.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(12,'F012','Mu Design SNC','IT14142135623','VLLGRT62A01F205C','Piazza San Marco 3','Padova','35121','PD','Italia','+39 049 445566','mu@mudesign.it','www.mudesign.it','Design e arredamento uffici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(13,'F013','Nu Tech Srl','IT16117234567','CRSLGU73C51H501N','Via Vittorio Veneto 9','Parma','43121','PR','Italia','+39 0521 556677','nu@nutech.it','www.nutech.it','Forniture elettroniche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(14,'F014','Xi Logistic Spa','IT10111213141','VRDLRS80H01F205A','Viale Marconi 40','Modena','41121','MO','Italia','+39 059 778899','xi@xilogistic.it','www.xilogistic.it','Trasporti e logistica.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(15,'F015','Omicron Green SRL','IT21222324252','BLDMNL69C61H501G','Via Cavour 25','Reggio Emilia','42121','RE','Italia','+39 0522 998877','omicron@omicrongreen.it','www.omicrongreen.it','Prodotti ecosostenibili.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(16,'F016','Pi Medical SNC','IT31323334362','RZZLRA75A12F205U','Piazza Libertà 6','Brescia','25121','BS','Italia','+39 030 334455','pi@pimedical.it','www.pimedical.it','Forniture ospedaliere.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(17,'F017','Rho Networks Srl','IT41424344472','PRTMNL81B01H501O','Via Matteotti 14','Lecce','73100','LE','Italia','+39 0832 445566','rho@rhonetworks.it','www.rhonetworks.it','Soluzioni networking.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(18,'F018','Sigma Industrial Spa','IT51525354582','MRSFRN78H41F205D','Corso Garibaldi 60','Perugia','06121','PG','Italia','+39 075 556677','sigma@sigmaindustrial.it','www.sigmaindustrial.it','Forniture industriali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(19,'F019','Tau Clean SRL','IT61626364692','TRVBLR85T10H501E','Via XX Settembre 11','Catania','95121','CT','Italia','+39 095 778899','tau@tauclean.it','www.tauclean.it','Servizi di pulizia industriale.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(20,'F020','Upsilon Electronics SNC','IT71727374702','VNTGRN82A01F205L','Viale della Repubblica 99','Livorno','57121','LI','Italia','+39 0586 112233','upsilon@upsilonelectronics.it','www.upsilonelectronics.it','Forniture elettroniche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(21,'F021','Omega Print Srl','IT82838485812','FSCLRA67H12H501F','Via Manzoni 5','Aosta','11100','AO','Italia','+39 0165 334455','omega@omegaprint.it','www.omegaprint.it','Tipografia e stampa.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(22,'F022','Alpha Global Spa','IT93949596914','GNTBLR74T01F205M','Via Veneto 3','Campobasso','86100','CB','Italia','+39 0874 445566','alpha@alphaglobal.it','www.alphaglobal.it','Forniture internazionali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(23,'F023','Beta Glass SRL','IT10293847564','RCCMNL83C41H501X','Corso Italia 40','Pescara','65121','PE','Italia','+39 085 556677','beta@betaglass.it','www.betaglass.it','Produzione vetri speciali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(24,'F024','Gamma Freight SNC','IT11213141516','BLNRRT90A12H501Y','Via Garibaldi 19','Taranto','74121','TA','Italia','+39 099 778899','gamma@gammafreight.it','www.gammafreight.it','Spedizioni internazionali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(25,'F025','Delta Oil Spa','IT12131415171','FNTGRN69B01F205V','Piazza Duomo 5','Trapani','91100','TP','Italia','+39 0923 998877','delta@deltaoil.it','www.deltaoil.it','Forniture energetiche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(26,'F026','Epsilon Build Srl','IT13141516181','LMBFRN85C61H501K','Viale Europa 20','Sassari','07100','SS','Italia','+39 079 445566','epsilon@epsilonbuild.it','www.epsilonbuild.it','Materiali per costruzioni.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(27,'F027','Zeta Foods Spa','IT14151617191','RZZBLR77H41F205T','Via Roma 99','Cosenza','87100','CS','Italia','+39 0984 223344','zeta@zetafoods.it','www.zetafoods.it','Distribuzione alimentare.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(28,'F028','Eta Health SRL','IT15161718102','GRDFRN82T12H501S','Via Verdi 7','Cagliari','09121','CA','Italia','+39 070 556677','eta@etahealth.it','www.etahealth.it','Dispositivi sanitari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(29,'F029','Theta Media SNC','IT16171819212','NVRMNL74B01F205Q','Via Dante 88','Rimini','47921','RN','Italia','+39 0541 334455','theta@thetamedia.it','www.thetamedia.it','Servizi pubblicitari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL),(30,'F030','Iota Marine Spa','IT17181920222','PRSCNT68H41H501C','Corso Italia 55','La Spezia','19121','SP','Italia','+39 0187 778899','iota@iotamarine.it','www.iotamarine.it','Forniture navali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL);
/*!40000 ALTER TABLE `fornitori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(100) NOT NULL,
  `pwd` varchar(60) NOT NULL,
  `role` varchar(10) NOT NULL DEFAULT 'user',
  UNIQUE KEY `id` (`id`,`user`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (2,'villari.andrea@libero.it','$2b$10$O6Z..94zCelmspklOd4pf.m0.Ag9yT7.QcwSJA.o623Zo5czkmEKy','admin'),(3,'pinco@pallino.it','$2b$10$uWz1EzuRfT6A9FROA8oCQukGln7A4xCgL3WZqTTr0q3rOigYPr/52','user'),(4,'oml@sales.it','$2b$10$Fzf5G3XUsYrqLUO7vgTOJuZcPRG7fS0KmSP/LWAtfKYTYChC1RbKO','user');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimenti`
--

DROP TABLE IF EXISTS `movimenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimenti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `tipo` enum('C','S') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantita` decimal(12,2) DEFAULT NULL,
  `codice_cau` varchar(3) NOT NULL DEFAULT '',
  `idart` int NOT NULL,
  `note` text,
  `descriptioncau` varchar(250) DEFAULT NULL,
  `descriptionart` varchar(100) DEFAULT NULL,
  `user` varchar(100) DEFAULT NULL,
  `timestamp` varchar(19) DEFAULT NULL,
  `um` varchar(10) DEFAULT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimenti`
--

LOCK TABLES `movimenti` WRITE;
/*!40000 ALTER TABLE `movimenti` DISABLE KEYS */;
INSERT INTO `movimenti` VALUES (1,'2025-06-15','C','Acquisto iniziale',100.00,'CAR',1,'','Carico da fornitore','Vite M5x20','villari.andrea@libero.it','2025-06-15 07:03:17',NULL),(2,'2025-06-16','C','Acquisto iniziale',500.00,'CAR',2,'','Carico da fornitore','Rondella Ø5','villari.andrea@libero.it','2025-06-16 07:39:20',NULL),(3,'2025-06-17','S','Utilizzo per montaggio',30.00,'PRE',1,'Commessa #1234','Prelievo produzione','Vite M5x20','villari.andrea@libero.it','2025-06-17 18:50:54',NULL),(4,'2025-06-18','C','Restock',20.00,'CAR',3,'','Carico da fornitore','Piastra Supporto','villari.andrea@libero.it','2025-06-18 00:16:24',NULL),(5,'2025-06-19','S','Utilizzo produzione',5.00,'PRE',3,'','Prelievo produzione','Piastra Supporto','villari.andrea@libero.it','2025-06-19 04:42:59',NULL),(6,'2025-06-19','C','Nuovo stock',5.00,'CAR',4,'','Carico da fornitore','Motore 230V','villari.andrea@libero.it','2025-06-19 20:17:53',NULL),(7,'2025-06-20','S','Montaggio kit A',3.00,'PRE',4,'','Prelievo produzione','Motore 230V','villari.andrea@libero.it','2025-06-20 14:19:50',NULL),(8,'2025-06-21','C','Ricevuto nuovo lotto',50.00,'CAR',5,'','Carico da fornitore','Cavo 3x1.5mm²','villari.andrea@libero.it','2025-06-21 05:39:32',NULL),(9,'2025-06-21','S','Produzione LED kit',10.00,'PRE',5,'','Prelievo produzione','Cavo 3x1.5mm²','villari.andrea@libero.it','2025-06-21 18:11:41',NULL),(10,'2025-06-22','C','Riassortimento magazzino',40.00,'CAR',6,'','Carico da fornitore','Connettore 4 pin','villari.andrea@libero.it','2025-06-22 20:16:46',NULL),(11,'2025-06-23','S','Montaggio gruppo A',20.00,'PRE',6,'','Prelievo produzione','Connettore 4 pin','villari.andrea@libero.it','2025-06-23 00:52:16',NULL),(12,'2025-06-23','C','Restock case',25.00,'CAR',7,'','Carico da fornitore','Involucro ABS','villari.andrea@libero.it','2025-06-23 17:48:53',NULL),(13,'2025-06-24','S','Prelievo assemblaggio',10.00,'PRE',7,'','Prelievo produzione','Involucro ABS','villari.andrea@libero.it','2025-06-24 00:21:44',NULL),(14,'2025-06-25','C','LED ricevuti',15.00,'CAR',8,'','Carico da fornitore','Pannello LED','villari.andrea@libero.it','2025-06-25 15:02:15',NULL),(15,'2025-06-25','S','Montaggio',10.00,'PRE',8,'','Prelievo produzione','Pannello LED','villari.andrea@libero.it','2025-06-25 04:04:51',NULL),(16,'2025-06-26','C','Reso cliente difettoso',2.00,'RCL',4,'Motore rumoroso restituito','Reso da cliente','Motore 230V','villari.andrea@libero.it','2025-06-26 02:53:10',NULL),(17,'2025-06-26','C','Reso cliente errato',5.00,'RCL',1,'Codice errato in spedizione','Reso da cliente','Vite M5x20','villari.andrea@libero.it','2025-06-26 05:35:14',NULL),(18,'2025-06-27','S','Reso a fornitore per difetto',3.00,'RSF',6,'Pin piegati','Reso a fornitore','Connettore 4 pin','villari.andrea@libero.it','2025-06-27 11:42:03',NULL),(19,'2025-06-27','S','Reso a fornitore per overstock',10.00,'RSF',5,'Quantità eccessiva in magazzino','Reso a fornitore','Cavo 3x1.5mm²','villari.andrea@libero.it','2025-06-27 04:41:55',NULL),(20,'2025-06-28','C','Reso da cliente',1.00,'RCL',10,'Cliente ha restituito kit montaggio','Reso da cliente','Gruppo montaggio A','villari.andrea@libero.it','2025-06-28 13:57:08',NULL),(21,'2025-06-28','S','Reso a fornitore',2.00,'RSF',3,'Piastra graffiata','Reso a fornitore','Piastra Supporto','villari.andrea@libero.it','2025-06-28 20:51:44',NULL);
/*!40000 ALTER TABLE `movimenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordini`
--

DROP TABLE IF EXISTS `ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordini` (
  `id_ordine` int NOT NULL AUTO_INCREMENT,
  `num_ordine` varchar(20) NOT NULL,
  `data_ordine` date NOT NULL,
  `fornitore_id` int NOT NULL,
  `stato` enum('APERTO','INVIATO','CHIUSO','ANNULLATO') DEFAULT 'APERTO',
  `note` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_ordine`),
  UNIQUE KEY `num_ordine` (`num_ordine`),
  KEY `fk_ordini_fornitori` (`fornitore_id`),
  CONSTRAINT `fk_ordini_fornitori` FOREIGN KEY (`fornitore_id`) REFERENCES `fornitori` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini`
--

LOCK TABLES `ordini` WRITE;
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
INSERT INTO `ordini` VALUES (5,'1','2025-07-09',5,'ANNULLATO','ciao ciao...','2025-07-09 09:41:59','2025-07-09 09:41:59'),(8,'10','2025-07-09',21,'APERTO','CCCCCCCCCCCCCC','2025-07-09 12:21:22','2025-07-09 12:21:22'),(9,'11','2025-07-09',23,'CHIUSO','464646','2025-07-09 13:46:42','2025-07-09 13:46:42');
/*!40000 ALTER TABLE `ordini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordini_righe`
--

DROP TABLE IF EXISTS `ordini_righe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordini_righe` (
  `id_riga` int NOT NULL AUTO_INCREMENT,
  `id_ordine` int NOT NULL,
  `descrizione` varchar(255) DEFAULT NULL,
  `prezzo_unitario` decimal(10,2) NOT NULL,
  `nome_articolo` varchar(100) NOT NULL,
  `quantita` decimal(12,2) DEFAULT NULL,
  `totale_righe` decimal(12,2) GENERATED ALWAYS AS ((`quantita` * `prezzo_unitario`)) STORED,
  PRIMARY KEY (`id_riga`),
  KEY `fk_righe_ordini` (`id_ordine`),
  CONSTRAINT `fk_righe_ordini` FOREIGN KEY (`id_ordine`) REFERENCES `ordini` (`id_ordine`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini_righe`
--

LOCK TABLES `ordini_righe` WRITE;
/*!40000 ALTER TABLE `ordini_righe` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordini_righe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'magazzino'
--

--
-- Dumping routines for database 'magazzino'
--
/*!50003 DROP PROCEDURE IF EXISTS `DeleteArticoli` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteArticoli`(
IN p_id INT
)
BEGIN
DELETE FROM `articoli`
WHERE `id` = p_id;
-- Restituisce un messaggio di errore
SELECT 'Ricambio eliminato con successo' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCausali` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCausali`(
IN p_id INT
)
BEGIN
DELETE FROM `causali`
WHERE `id` = p_id;

SELECT 'Ricambio eliminato con successo' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCliente`(
    IN p_id INT
)
BEGIN
    DELETE FROM `clienti`
    WHERE `id` = p_id;

    SELECT 'Cliente eliminato con successo' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteDiba` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDiba`(
    IN p_id INT
)
BEGIN
    DELETE FROM diba WHERE id = p_id;
    SELECT ROW_COUNT() as affectedRows;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteFornitore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteFornitore`(
    IN p_id INT
)
BEGIN
    DELETE FROM `fornitori`
    WHERE `id` = p_id;

    SELECT 'Fornitore eliminato con successo' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteMovimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMovimento`(
    IN p_id INT
)
BEGIN
    DECLARE v_idart INT;
    DECLARE v_quantita DECIMAL(10, 2);
    DECLARE v_tipo CHAR(1);
    DECLARE v_affected_rows INT;

    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    
    SELECT idart, quantita, tipo INTO v_idart, v_quantita, v_tipo
    FROM movimenti
    WHERE id = p_id
    FOR UPDATE;

    
    IF FOUND_ROWS() = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Movimento non trovato.';
    END IF;

    
    IF v_tipo = 'C' THEN
        
        UPDATE articoli SET quantita = quantita - v_quantita WHERE id = v_idart;
    ELSEIF v_tipo = 'S' THEN
        
        UPDATE articoli SET quantita = quantita + v_quantita WHERE id = v_idart;
    ELSE
        
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo movimento del record da eliminare non valido.';
    END IF;

    
    DELETE FROM movimenti WHERE id = p_id;
    SET v_affected_rows = ROW_COUNT();

    COMMIT;

    
    SELECT v_affected_rows as affectedRows;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchArticoli` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchArticoli`(
	IN `p_name` VARCHAR(255),
	IN `p_description` VARCHAR(255),
	IN `p_supplier` VARCHAR(255)
)
BEGIN
    SELECT
        `id`,
        `name`,
        `description`,
        `quantita`,
        `min`,
        `max`,
        `supplier`,
        `has_diba`
    FROM
        `articoli`
    WHERE
        (p_name IS NULL OR p_name = '' OR `name` LIKE CONCAT('%', p_name, '%'))
        AND (p_description IS NULL OR p_description = '' OR `description` LIKE CONCAT('%', p_description, '%'))
        AND (p_supplier IS NULL OR p_supplier = '' OR `supplier` LIKE CONCAT('%', p_supplier, '%'))
    ORDER BY
        `name` ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchCausali` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchCausali`(
     in p_codice varchar(3),
     in p_description varchar(255),
     in p_tipo enum('C','S')
     )
begin
     select
     `codice`,
     `description`,
     `tipo`
     from
     `causali`
     where
     (p_codice is null or p_codice = '' or `codice` like concat('%', p_codice ,'%'))
     and (p_description is null or p_description ='' or `description` like concat('%', p_description,'%'))
     and (p_tipo is null or p_tipo='' or `tipo` like concat('%', p_tipo, '%'))
     order by
     `codice` asc;
     end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchClienti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchClienti`(
	IN `p_codice` VARCHAR(10),
	IN `p_nome` VARCHAR(255),
	IN `p_tipo_cliente` ENUM('Azienda','Privato'),
	IN `p_partita_iva` VARCHAR(20),
	IN `p_citta` VARCHAR(100),
	IN `p_cf` VARCHAR(20),
	IN `p_contatto` VARCHAR(100)
)
BEGIN
    SELECT
        `id`,
        `codice`,
        `nome`,
        `tipo_cliente`,
        `partita_iva`,
        `cf`,
        `indirizzo`,
        `citta`,
        `telefono`,
        `email`,
        `contatto`
    FROM
        `clienti`
    WHERE
        (p_codice IS NULL OR p_codice = '' OR `codice` LIKE CONCAT('%', p_codice, '%'))
		  AND (p_nome IS NULL OR p_nome = '' OR `nome` LIKE CONCAT('%', p_nome, '%'))
        AND (p_tipo_cliente IS NULL OR p_tipo_cliente = '' OR `tipo_cliente` LIKE CONCAT('%', p_tipo_cliente, '%'))
		  AND (p_contatto IS NULL OR p_contatto = '' OR `contatto` LIKE CONCAT('%', p_contatto, '%'))
        AND (p_citta IS NULL OR p_citta = '' OR `citta` LIKE CONCAT('%', p_citta, '%'))
        AND (p_cf IS NULL OR p_cf = '' OR `cf` LIKE CONCAT('%', p_cf, '%'))
		  AND (p_contatto IS NULL OR p_contatto = '' OR `contatto` LIKE CONCAT('%', p_contatto, '%'))
    ORDER BY
        `nome` ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchDiba` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchDiba`(
    IN p_id INT,
    IN p_id_father INT,
    IN p_id_son INT
)
BEGIN
    SELECT
        d.id,
        d.id_father,
        father.name AS father_name,
        father.description AS father_description,
        d.id_son,
        son.name AS son_name,
        son.description AS son_description,
        d.quantita
    FROM
        diba d
    JOIN
        articoli father ON d.id_father = father.id
    JOIN
        articoli son ON d.id_son = son.id
    WHERE
        (p_id IS NULL OR d.id = p_id) AND
        (p_id_father IS NULL OR d.id_father = p_id_father) AND
        (p_id_son IS NULL OR d.id_son = p_id_son)
    ORDER BY
        father.name, son.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchFornitori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchFornitori`(
	IN `p_ragione_sociale` VARCHAR(255),
	IN `p_piva` VARCHAR(20),
	IN `p_contatto` VARCHAR(100),
	IN `p_citta` VARCHAR(1000),
	IN `p_cf` VARCHAR(20)
)
BEGIN
    SELECT
        `id`,
        `rag_soc`,
        `partita_iva`,
        `indirizzo`,
        `telefono`,
        `email`,
        `contatto`
    FROM
        `fornitori`
    WHERE
        (p_ragione_sociale IS NULL OR p_ragione_sociale = '' OR `rag_soc` LIKE CONCAT('%', p_ragione_sociale, '%'))
        AND (p_piva IS NULL OR p_piva = '' OR `partita_iva` LIKE CONCAT('%', p_piva, '%'))
		  AND (p_contatto IS NULL OR p_contatto ='' OR contatto LIKE CONCAT('%',p_contatto,'%'))
		  AND (p_citta IS NULL OR p_citta ='' OR citta LIKE CONCAT('%',p_citta,'%'))
		  AND (p_cf IS NULL OR p_cf ='' OR cf LIKE CONCAT('%',p_cf,'%'))
    	  ORDER BY
        `rag_soc` ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchMovimenti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchMovimenti`(
	IN `p_idart` INT,
	IN `p_data_da` DATE,
	IN `p_data_a` DATE,
	IN `p_tipo` ENUM('C','S'),
	IN `p_codice_cau` VARCHAR(3),
	IN `p_user` VARCHAR(100)
)
BEGIN
SELECT
m.id,
m.data,
m.quantita,
m.tipo,
m.note,
m.idart,
m.codice_cau,
m.user,
m.timestamp,
a.name AS descriptionart,
c.description AS descriptioncau
FROM
movimenti m
JOIN
articoli a ON m.idart = a.id
JOIN
causali c ON m.codice_cau = c.codice
WHERE 
(p_idart IS NULL OR p_idart = '' OR m.idart = p_idart) AND
(p_data_da IS NULL OR m.data >= p_data_da) AND
(p_data_a IS NULL OR m.data <= p_data_a) AND
(p_tipo IS NULL OR m.tipo = p_tipo) AND
(p_codice_cau IS NULL OR m.codice_cau = codice_cau) AND
(p_user IS NULL OR p_user = '' OR m.user = p_user)
ORDER BY
m.data DESC, m.id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchOrdini` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchOrdini`(
p_num_ordine VARCHAR(20),
p_data_da DATE,
p_data_a DATE,
p_fornitore_id INT,
p_stato ENUM('APERTO','INVIATO','CHIUSO','ANNULLATO')
)
begin
select 

id_ordine,
num_ordine,
data_ordine,
fornitore_id,
stato,
note
from ordini o
where 
(p_num_ordine is null or p_num_ordine = "" or o.num_ordine = p_num_ordine) and
(p_data_da is null or o.data_ordine >= p_data_da) and
(p_data_a is null or o.data_ordine <= p_data_a) and
(p_fornitore_id is null or p_fornitore_id = "" or o.fornitore_id = p_fornitore_id) and
(p_stato is null or p_stato = "" or o.stato = p_stato)
order by
o.data_ordine desc;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchUsers`(
    
     IN p_id INT,
         IN p_username VARCHAR(255)
     )
BEGIN
    
         SELECT
             id,
             user AS username,
             role
         FROM
             login
         WHERE
    
             (p_id IS NULL OR id = p_id)
         AND
    
             (p_username IS NULL OR user = p_username)
         ORDER BY
             username;
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertArticolo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertArticolo`(
           IN p_name VARCHAR(255),
   IN p_description VARCHAR(255),
   IN p_quantita INT,
   IN p_min INT,
   IN p_max INT,
   IN p_supplier VARCHAR(255)
   )
BEGIN
INSERT INTO `articoli` (`name`,`description`,`quantita`,`min`,`max`,`supplier`)
VALUES (p_name, p_description, p_quantita, p_min, p_max, p_supplier);
SELECT LAST_INSERT_ID() AS id;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertCausale` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertCausale`(
IN p_codice varchar(3),
IN p_description varchar(255),
IN p_tipo enum('C','S')
)
begin
insert into `causali` (`codice`, `description`,`tipo`)
values (p_codice, p_description, p_tipo);
select last_insert_id() as id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertCliente`(
    IN p_codice VARCHAR(10),
    IN p_nome VARCHAR(255),
    IN p_tipo_cliente ENUM('Privato','Azienda'),
    IN p_partita_iva VARCHAR(20),
    IN p_cf VARCHAR(20),
    IN p_indirizzo VARCHAR(255),
    IN p_citta VARCHAR(100),
    IN p_cap VARCHAR(10),
    IN p_pv VARCHAR(2),
    IN p_nazione VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_sito_web VARCHAR(100),
    IN p_note TEXT,
    IN p_contatto VARCHAR(100)
)
BEGIN
    INSERT INTO `clienti` (
        `codice`, `nome`, `tipo_cliente`, `partita_iva`, `cf`, 
        `indirizzo`, `citta`, `cap`, `pv`, `nazione`, 
        `telefono`, `email`, `sito_web`, `note`, `contatto`
    )
    VALUES (
        p_codice, p_nome, p_tipo_cliente, p_partita_iva, p_cf,
        p_indirizzo, p_citta, p_cap, p_pv, p_nazione,
        p_telefono, p_email, p_sito_web, p_note, p_contatto
    );
    
    SELECT LAST_INSERT_ID() AS id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertDiBa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDiBa`(
	IN `p_id_father` INT,
	IN `p_id_son` INT,
	IN `p_quantita` decimal(12,2)
)
BEGIN 

DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN 
		 ROLLBACK;
		 RESIGNAL;
	END;
	
	-- Inserisci la nuova riga nella distinta base
	START TRANSACTION; 
	INSERT INTO `diba` (`id_father`, `id_son`, `quantita`)
	VALUES (p_id_father, p_id_son, p_quantita);
	
	-- Aggiorna l'articolo padre per segnalare che ora ha una distinta base
	UPDATE articoli
	SET has_diba = 'S'
	WHERE id = p_id_father;
		
	COMMIT;

	SELECT LAST_INSERT_ID()AS id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertFornitore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertFornitore`(
    IN p_codice VARCHAR(10),
    IN p_rag_soc VARCHAR(255),
    IN p_partita_iva VARCHAR(20),
    IN p_cf VARCHAR(20),
    IN p_indirizzo VARCHAR(255),
    IN p_citta VARCHAR(100),
    IN p_cap VARCHAR(10),
    IN p_pv VARCHAR(2),
    IN p_nazione VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_sito_web VARCHAR(100),
    IN p_note TEXT,
    IN p_contatto VARCHAR(100)
)
BEGIN
    INSERT INTO `fornitori` (
        `codice`, `rag_soc`, `partita_iva`, `cf`, `indirizzo`, 
        `citta`, `cap`, `pv`, `nazione`, `telefono`, 
        `email`, `sito_web`, `note`, `contatto`
    )
    VALUES (
        p_codice, p_rag_soc, p_partita_iva, p_cf, p_indirizzo,
        p_citta, p_cap, p_pv, p_nazione, p_telefono,
        p_email, p_sito_web, p_note, p_contatto
    );
    
    SELECT LAST_INSERT_ID() AS id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertMovimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertMovimento`(
	IN `p_idart` INT,
	IN `p_codice_cau` VARCHAR(3),
	IN `p_data` DATE,
	IN `p_quantita` DECIMAL(10, 2),
	IN `p_tipo` CHAR(1),
	IN `p_note` TEXT
)
BEGIN
    DECLARE current_quantita DECIMAL(10, 2);
    DECLARE new_id INT;

    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL; -- Rilancia l'eccezione al chiamante
    END;

    START TRANSACTION;

    
    IF p_tipo = 'S' THEN
        
        SELECT quantita INTO current_quantita FROM articoli WHERE id = p_idart FOR UPDATE;

        IF current_quantita IS NULL THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Articolo non trovato.';
        END IF;

        IF current_quantita < p_quantita THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantit� insufficiente per lo scarico.';
        END IF;
    END IF;

    
    INSERT INTO movimenti (idart, codice_cau, data, quantita, tipo, note)
    VALUES (p_idart, p_codice_cau, p_data, p_quantita, p_tipo, p_note);

    SET new_id = LAST_INSERT_ID();

    
    IF p_tipo = 'C' THEN
        UPDATE articoli SET quantita = quantita + p_quantita WHERE id = p_idart;
    ELSEIF p_tipo = 'S' THEN
        UPDATE articoli SET quantita = quantita - p_quantita WHERE id = p_idart;
    END IF;

    COMMIT;

    
    SELECT new_id as insertId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertOrdini` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertOrdini`(
    IN p_num_ordine VARCHAR(20),
    IN p_data_ordine DATE,
    IN p_fornitore_id INT,
    IN p_stato ENUM('APERTO','INVIATO','CHIUSO','ANNULLATO'),
    IN p_note TEXT
)
BEGIN
    INSERT INTO `ordini` (
        `num_ordine`,
        `data_ordine`,
        `fornitore_id`,
        `stato`,
        `note`
    )
    VALUES (
        p_num_ordine,
        p_data_ordine,
        p_fornitore_id,
        COALESCE(p_stato, 'APERTO'),
        p_note
    );

    SELECT LAST_INSERT_ID() AS id_ordine;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Insert_Movimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_Movimento`(
	IN `p_idart` INT,
	IN `p_codice_cau` VARCHAR(3),
	IN `p_data` DATE,
	IN `p_quantita` DECIMAL(10,2),
	IN `p_tipo` CHAR(1),
	IN `p_note` TEXT,
	IN `p_user` VARCHAR(100),
	IN `p_timestamp` VARCHAR(19)
)
BEGIN
    DECLARE current_quantita DECIMAL(10, 2);
    DECLARE new_id INT;
    DECLARE v_has_diba ENUM('S','N');
    DECLARE v_id_son INT;
    DECLARE v_qta_per_son DECIMAL(10,2);
    DECLARE done INT DEFAULT FALSE;
    DECLARE total_movimento DECIMAL(10,2);
    DECLARE v_error_msg TEXT;

    DECLARE cur CURSOR FOR
        SELECT id_son, quantita FROM diba WHERE id_father = p_idart;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Controllo giacenza solo per gli scarichi del padre
    IF p_tipo = 'S' THEN
        SELECT quantita INTO current_quantita FROM articoli WHERE id = p_idart FOR UPDATE;

        IF current_quantita IS NULL THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Articolo padre non trovato.';
        END IF;

        IF current_quantita < p_quantita THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantità insufficiente per lo scarico dell\'articolo padre.';
        END IF;
    END IF;

    -- Inserisci il movimento principale (padre)
    INSERT INTO movimenti (idart, codice_cau, data, quantita, tipo, note , user, timestamp)
    VALUES (p_idart, p_codice_cau, p_data, p_quantita, p_tipo, p_note, p_user, p_timestamp);

    SET new_id = LAST_INSERT_ID();

    -- Aggiorna giacenza padre
    IF p_tipo = 'C' THEN
        UPDATE articoli SET quantita = quantita + p_quantita WHERE id = p_idart;
    ELSEIF p_tipo = 'S' THEN
        UPDATE articoli SET quantita = quantita - p_quantita WHERE id = p_idart;
    END IF;

    -- Verifica se ha distinta base
    SELECT has_diba INTO v_has_diba FROM articoli WHERE id = p_idart;

    IF v_has_diba = 'S' THEN
        OPEN cur;

        fetch_loop: LOOP
            FETCH cur INTO v_id_son, v_qta_per_son;

            IF done THEN
                LEAVE fetch_loop;
            END IF;

            SET total_movimento = v_qta_per_son * p_quantita;

            -- Controlla giacenza figlio SOLO in caso di scarico
            IF p_tipo = 'S' THEN
                SELECT quantita INTO current_quantita FROM articoli WHERE id = v_id_son FOR UPDATE;

                IF current_quantita IS NULL THEN
                    SET v_error_msg = CONCAT('Articolo figlio ID ', v_id_son, ' non trovato.');
                    ROLLBACK;
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
                END IF;

                IF current_quantita < total_movimento THEN
                    SET v_error_msg = CONCAT('Quantità insufficiente per lo scarico del figlio ID ', v_id_son);
                    ROLLBACK;
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_msg;
                END IF;
            END IF;

            -- Aggiorna giacenza figlio
            IF p_tipo = 'C' THEN
                UPDATE articoli
                SET quantita = quantita + total_movimento
                WHERE id = v_id_son;
            ELSEIF p_tipo = 'S' THEN
                UPDATE articoli
                SET quantita = quantita - total_movimento
                WHERE id = v_id_son;
            END IF;

            -- Inserisci movimento anche per il figlio
            INSERT INTO movimenti (idart, codice_cau, data, quantita, tipo, note , user, timestamp)
            VALUES (
                v_id_son,
                p_codice_cau,
                p_data,
                total_movimento,
                p_tipo,
                CONCAT(
                IF(p_tipo = 'C', 'Carico ', 'Scarico '),
                'da distinta base per articolo padre ID: ', p_idart
                ),
                p_user,
                p_timestamp
            );

        END LOOP;

        CLOSE cur;
    END IF;

    COMMIT;

    SELECT new_id AS insertId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateArticolo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateArticolo`(
IN p_id INT,
IN p_name VARCHAR(255),
IN p_description TEXT,
IN p_quantita INT,
IN p_min INT,
IN p_max INT,
IN p_supplier VARCHAR(255)
)
BEGIN
UPDATE `articoli`
SET 
`name` = p_name,
`description` = p_description,
`quantita` = p_quantita,
`min` = p_min,
`max` = p_max,
`supplier`= p_supplier
WHERE 
`id` = p_id;

SELECT 'Ricambio aggiornato con successo' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCliente`(
    IN p_id INT,
    IN p_codice VARCHAR(10),
    IN p_nome VARCHAR(255),
    IN p_tipo_cliente ENUM('Privato','Azienda'),
    IN p_partita_iva VARCHAR(20),
    IN p_cf VARCHAR(20),
    IN p_indirizzo VARCHAR(255),
    IN p_citta VARCHAR(100),
    IN p_cap VARCHAR(10),
    IN p_pv VARCHAR(2),
    IN p_nazione VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_sito_web VARCHAR(100),
    IN p_note TEXT,
    IN p_contatto VARCHAR(100)
)
BEGIN
    UPDATE `clienti`
    SET
        `codice` = p_codice,
        `nome` = p_nome,
        `tipo_cliente` = p_tipo_cliente,
        `partita_iva` = p_partita_iva,
        `cf` = p_cf,
        `indirizzo` = p_indirizzo,
        `citta` = p_citta,
        `cap` = p_cap,
        `pv` = p_pv,
        `nazione` = p_nazione,
        `telefono` = p_telefono,
        `email` = p_email,
        `sito_web` = p_sito_web,
        `note` = p_note,
        `contatto` = p_contatto
    WHERE
        `id` = p_id;

    SELECT 'Cliente aggiornato con successo' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateDiba` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDiba`(
    IN p_id INT,
    IN p_quantita DECIMAL(10, 2) -- O INT
)
BEGIN
    UPDATE diba
    SET
        quantita = p_quantita
    WHERE id = p_id;

    SELECT ROW_COUNT() as affectedRows;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateFornitore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateFornitore`(
    IN p_id INT,
    IN p_codice VARCHAR(10),
    IN p_rag_soc VARCHAR(255),
    IN p_partita_iva VARCHAR(20),
    IN p_cf VARCHAR(20),
    IN p_indirizzo VARCHAR(255),
    IN p_citta VARCHAR(100),
    IN p_cap VARCHAR(10),
    IN p_pv VARCHAR(2),
    IN p_nazione VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_sito_web VARCHAR(100),
    IN p_note TEXT,
    IN p_contatto VARCHAR(100)
)
BEGIN
    UPDATE `fornitori`
    SET
        `codice` = p_codice,
        `rag_soc` = p_rag_soc,
        `partita_iva` = p_partita_iva,
        `cf` = p_cf,
        `indirizzo` = p_indirizzo,
        `citta` = p_citta,
        `cap` = p_cap,
        `pv` = p_pv,
        `nazione` = p_nazione,
        `telefono` = p_telefono,
        `email` = p_email,
        `sito_web` = p_sito_web,
        `note` = p_note,
        `contatto` = p_contatto
    WHERE
        `id` = p_id;

    SELECT 'Fornitore aggiornato con successo' AS message;
END ;;
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
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-09 18:06:26

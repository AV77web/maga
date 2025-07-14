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
INSERT INTO `articoli` VALUES (1,'Vite M6','vite metrica 6mm in acciaio',100.00,30.00,30.00,'SIEMENS','N',NULL,21.57),(2,'Rondella Ø5','Rondella zincata',500.00,100.00,2000.00,'Bulloneria Srl','N',NULL,43.50),(3,'Piastra Supporto','Piastra in acciaio 100x50mm',35.00,10.00,100.00,'Metaltech','N',NULL,52.78),(4,'Motore 230V','Motore monofase 230V',8.00,2.00,15.00,'ElettroPower','S',NULL,33.41),(5,'Cavo 3x1.5mm²','Cavo multipolare nero',120.00,30.00,500.00,'Cavi Italia','S',NULL,88.72),(6,'Connettore 4 pin','Connettore per motore',75.00,20.00,300.00,'ElettroPower','N',NULL,63.36),(7,'Involucro ABS','Box in plastica ABS',60.00,10.00,200.00,'PlastTech','N',NULL,40.65),(8,'Pannello LED','Modulo LED 12V',42.00,10.00,100.00,'LucePro','N',NULL,93.18),(9,'Scheda controllo','PCB controller v1.2',22.00,5.00,50.00,'PCB Factory','N',NULL,63.92),(10,'Gruppo montaggio A','Assemblato con motore e supporti',10.00,0.00,30.00,'Assemblaggi Spa','S',NULL,30.09),(16,'eee','fff',9000.00,0.00,0.00,'OMRON','N',NULL,38.69),(19,'product 70','descrizione prodotto 70',0.00,0.00,58900000.00,'','N',NULL,93.16),(20,'product 80','descrizione prodotto 80 jljljllljlkjlj ljljljljljljllklkjlkjljlk',0.00,0.00,0.00,'','N',NULL,69.76),(21,'product 90000','descrizione prodotto 90000 della lista dei prodotti',665.00,9.00,100.00,'','N',NULL,59.29),(22,'999999','ojeojojoijoi',988.00,8.00,12.00,'BAXI','S',NULL,77.18),(25,'KHKJHKHKHKJgggggggggggggggggppppppppppppppppppppppppppppppppppp','KHKHKJHKHKHKHKJHK',78788.00,778.00,79.00,'','N',NULL,18.01),(26,'HJKGHKGHKGQ','OJOJGLJ',71810.00,7.00,8.00,'','N',NULL,28.54),(27,'NJKHH','HKJHKJHK',8.00,8.00,8.00,'','N',NULL,78.65),(28,'JLKJLJLKJLKJLKJ','LKJLJL',908.00,8.00,8.00,'SIEMENS','N',NULL,27.64),(29,'UOUO','OUOUOI',8.00,8.00,8.00,'','N',NULL,72.25),(30,'ORITTOU','OUORTUOTU',197.00,7.00,7.00,'SIEMENS','N',NULL,88.32),(31,'RTRTRE','RTR',100.00,20.00,250.00,'','N',NULL,34.84),(32,'78787878','questo è il prodotto di codice 78787878 della lista dei prodotti',21008.00,10.00,200.00,'OMRON','S',NULL,79.24),(33,'88888888','questo è il prodotto numero 88888888 della lista dei prdotti',1820233.00,70.00,800.00,'BAXI','N',NULL,11.71);
/*!40000 ALTER TABLE `articoli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_clienti`
--

DROP TABLE IF EXISTS `backup_clienti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_clienti` (
  `id` int NOT NULL DEFAULT '0',
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
  `contatto` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_clienti`
--

LOCK TABLES `backup_clienti` WRITE;
/*!40000 ALTER TABLE `backup_clienti` DISABLE KEYS */;
INSERT INTO `backup_clienti` VALUES (1,'CL0001','Mario Rossi','Privato',NULL,'RSSMRA80A01H501U','Via Roma 10','Milano','20100','MI','Italia','02-1234567','mario.rossi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Mario Rossi'),(2,'CL0002','Francesca Bianchi','Privato',NULL,'BNCHFNC85B22F205Y','Via Torino 5','Torino','10100','TO','Italia','011-2345678','francesca.bianchi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Francesca Bianchi'),(3,'CL0003','Giovanni Verdi','Privato',NULL,'VRDGNN90C15L219T','Piazza Garibaldi 7','Napoli','80100','NA','Italia','081-3456789','giovanni.verdi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Giovanni Verdi'),(4,'CL0004','Studio Tecnico Alfa','Azienda','01234567890',NULL,'Via Galileo Galilei 12','Bologna','40100','BO','Italia','051-4567890','info@studioalfa.it','www.studioalfa.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Bianchi'),(5,'CL0005','Impresa Edile Beta','Azienda','09876543210',NULL,'Via Dante 3','Firenze','50100','FI','Italia','055-5678901','contatti@edilebeta.it','www.edilebeta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Rossi'),(6,'CL0006','Lucia Neri','Privato',NULL,'NRELUC75D41F205Z','Via Marconi 21','Venezia','30100','VE','Italia','041-6789012','lucia.neri@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Lucia Neri'),(7,'CL0007','Azienda Gamma Srl','Azienda','02345678901',NULL,'Corso Italia 45','Genova','16100','GE','Italia','010-7890123','info@gammasrl.it','www.gammasrl.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott.ssa Verdi'),(8,'CL0008','Marco Russo','Privato',NULL,'RSSMRC82L17H501U','Via Manzoni 9','Palermo','90100','PA','Italia','091-8901234','marco.russo@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Marco Russo'),(9,'CL0009','Consorzio Delta','Azienda','03456789012',NULL,'Via della Libertà 16','Catania','95100','CT','Italia','095-9012345','info@consorziodelta.it','www.consorziodelta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Bianchi'),(10,'CL0010','Anna Gallo','Privato',NULL,'GLLANN83M22F205K','Via Leopardi 13','Bari','70100','BA','Italia','080-1234567','anna.gallo@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Anna Gallo'),(11,'CL0011','Società Epsilon','Azienda','04567890123',NULL,'Via Vittorio Veneto 4','Trieste','34100','TS','Italia','040-2345678','contatti@epsilon.it','www.epsilon.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Neri'),(12,'CL0012','Roberto Marino','Privato',NULL,'MRNRBT79P15H501S','Via Cavour 20','Verona','37100','VR','Italia','045-3456789','roberto.marino@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Roberto Marino'),(13,'CL0013','Ditta Zeta','Azienda','05678901234',NULL,'Via San Marco 11','Padova','35100','PD','Italia','049-4567890','info@dittazeta.it','www.dittazeta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Rossi'),(14,'CL0014','Elena Ferri','Privato',NULL,'FRRELE78B20F205Z','Via Roma 32','Reggio Emilia','42100','RE','Italia','0522-567890','elena.ferri@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Elena Ferri'),(15,'CL0015','Ingegneria Theta','Azienda','06789012345',NULL,'Via Piave 8','Parma','43100','PR','Italia','0521-678901','info@thetaingegneria.it','www.thetaingegneria.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Gallo'),(16,'CL0016','Laura Conti','Privato',NULL,'CNTLRA82C25F205V','Via Carducci 14','Modena','41100','MO','Italia','059-789012','laura.conti@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Laura Conti'),(17,'CL0017','Impresa Iota','Azienda','07890123456',NULL,'Via Roma 1','Rimini','47900','RN','Italia','0541-890123','info@impiantoiota.it','www.impiantoiota.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Bianchi'),(18,'CL0018','Paolo Villa','Privato',NULL,'VLLPLA85H14F205A','Via Verdi 2','Pescara','65100','PE','Italia','085-901234','paolo.villa@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Paolo Villa'),(19,'CL0019','Forniture Kappa','Azienda','08901234567',NULL,'Via Milano 20','Lecce','73100','LE','Italia','0832-123456','info@kappaforniture.it','www.kappaforniture.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott.ssa Ferri'),(20,'CL0020','Sonia Riva','Privato',NULL,'RVSNIA81S30F205N','Via Dante 18','Como','22100','CO','Italia','031-234567','sonia.riva@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Sonia Riva'),(21,'CL0021','Società Lambda','Azienda','09012345678',NULL,'Via Firenze 7','Arezzo','52100','AR','Italia','0575-345678','contatti@lambda.it','www.lambda.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Marino'),(22,'CL0022','Giorgio Esposito','Privato',NULL,'SPTGGR80D12F205W','Via Napoli 15','Salerno','84100','SA','Italia','089-456789','giorgio.esposito@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Giorgio Esposito'),(23,'CL0023','Ditta Mu','Azienda','09123456789',NULL,'Via Torino 50','Cagliari','09100','CA','Italia','070-567890','info@dittamu.it','www.dittamu.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Rossi'),(24,'gggggggggg','gggggggggggg','Privato','gggggggggggg','ggggggggg','Via Col Moschin, 43','Bassano del Grappa','36061','VI','Italia','gggggg','ljj@linl.it','dddddddd','dddddd','2025-07-10 10:30:41','2025-07-10 10:30:41','ddd');
/*!40000 ALTER TABLE `backup_clienti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_controparti`
--

DROP TABLE IF EXISTS `backup_controparti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_controparti` (
  `id` int NOT NULL DEFAULT '0',
  `codice` varchar(10) NOT NULL,
  `rag_soc` varchar(255) NOT NULL,
  `tipo_cliente` enum('Privato','Azienda') DEFAULT NULL,
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
  `ruolo` enum('cliente','fornitore','entrambi') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_controparti`
--

LOCK TABLES `backup_controparti` WRITE;
/*!40000 ALTER TABLE `backup_controparti` DISABLE KEYS */;
INSERT INTO `backup_controparti` VALUES (1,'F001','Alfa Logistics Srl',NULL,'IT12345678901','RSSMRA80A01H501Z','Via Roma 10','Milano','20121','MI','Italia','+39 02 1234567','info@alfalogistics.it','www.alfalogistics.it','Fornitore principale per logistica.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(2,'F002','Beta Construction Spa',NULL,'IT98765432109','BNCLGU75T10F205L','Corso Venezia 5','Torino','10123','TO','Italia','+39 011 7654321','contatti@betaconstruction.it','www.betaconstruction.it','Partner per edilizia.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(3,'F003','GammaTech SRL',NULL,'IT13579246801','FRRVLR82L41D325C','Via Garibaldi 22','Bologna','40121','BO','Italia','+39 051 234567','gamma@gammatech.it','www.gammatech.it','Fornitore hardware e software.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(4,'F004','Delta Food SNC',NULL,'IT24681357902','BNCPLA70H41F205P','Piazza Duomo 1','Firenze','50122','FI','Italia','+39 055 987654','delta@deltafood.it','www.deltafood.it','Specialista forniture alimentari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(5,'F005','Epsilon Energy Srl',NULL,'IT10293847561','PLRMNL60C12H501S','Viale Europa 15','Napoli','80133','NA','Italia','+39 081 112233','epsilon@epsilonenergy.it','www.epsilonenergy.it','Forniture impianti energetici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(6,'F006','Zeta Motors Spa',NULL,'IT56473829104','GRDRRT85M01F205R','Via Manzoni 8','Genova','16121','GE','Italia','+39 010 445566','zeta@zetamotors.it','www.zetamotors.it','Fornitore mezzi aziendali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(7,'F007','Eta Pharma Srl',NULL,'IT91827364501','VRDLGU77T41H501T','Via Verdi 30','Palermo','90133','PA','Italia','+39 091 778899','eta@etapharma.it','www.etapharma.it','Farmaceutica e presidi medici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(8,'F008','Theta Systems SNC',NULL,'IT19283746502','BRSCLD65A12F205G','Via Dante 12','Bari','70121','BA','Italia','+39 080 334455','theta@thetasystems.it','www.thetasystems.it','Servizi IT.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(9,'F009','Iota Fashion Srl',NULL,'IT31415926535','NRCVTT88B41D325M','Corso Italia 50','Venezia','30121','VE','Italia','+39 041 556677','iota@iotafashion.it','www.iotafashion.it','Fornitore abbigliamento da lavoro.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(10,'F010','Kappa Agro Spa',NULL,'IT16180339887','MNGFRN70C01H501P','Via Po 7','Verona','37121','VR','Italia','+39 045 998877','kappa@kappaagro.it','www.kappaagro.it','Prodotti agricoli.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(11,'F011','Lambda Services SRL',NULL,'IT27182818284','BLNLRA79T10F205Z','Via Mazzini 18','Trieste','34121','TS','Italia','+39 040 223344','lambda@lambdaservices.it','www.lambdaservices.it','Servizi generali per aziende.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(12,'F012','Mu Design SNC',NULL,'IT14142135623','VLLGRT62A01F205C','Piazza San Marco 3','Padova','35121','PD','Italia','+39 049 445566','mu@mudesign.it','www.mudesign.it','Design e arredamento uffici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(13,'F013','Nu Tech Srl',NULL,'IT16117234567','CRSLGU73C51H501N','Via Vittorio Veneto 9','Parma','43121','PR','Italia','+39 0521 556677','nu@nutech.it','www.nutech.it','Forniture elettroniche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(14,'F014','Xi Logistic Spa',NULL,'IT10111213141','VRDLRS80H01F205A','Viale Marconi 40','Modena','41121','MO','Italia','+39 059 778899','xi@xilogistic.it','www.xilogistic.it','Trasporti e logistica.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(15,'F015','Omicron Green SRL',NULL,'IT21222324252','BLDMNL69C61H501G','Via Cavour 25','Reggio Emilia','42121','RE','Italia','+39 0522 998877','omicron@omicrongreen.it','www.omicrongreen.it','Prodotti ecosostenibili.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(16,'F016','Pi Medical SNC',NULL,'IT31323334362','RZZLRA75A12F205U','Piazza Libertà 6','Brescia','25121','BS','Italia','+39 030 334455','pi@pimedical.it','www.pimedical.it','Forniture ospedaliere.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(17,'F017','Rho Networks Srl',NULL,'IT41424344472','PRTMNL81B01H501O','Via Matteotti 14','Lecce','73100','LE','Italia','+39 0832 445566','rho@rhonetworks.it','www.rhonetworks.it','Soluzioni networking.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(18,'F018','Sigma Industrial Spa',NULL,'IT51525354582','MRSFRN78H41F205D','Corso Garibaldi 60','Perugia','06121','PG','Italia','+39 075 556677','sigma@sigmaindustrial.it','www.sigmaindustrial.it','Forniture industriali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(19,'F019','Tau Clean SRL',NULL,'IT61626364692','TRVBLR85T10H501E','Via XX Settembre 11','Catania','95121','CT','Italia','+39 095 778899','tau@tauclean.it','www.tauclean.it','Servizi di pulizia industriale.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(20,'F020','Upsilon Electronics SNC',NULL,'IT71727374702','VNTGRN82A01F205L','Viale della Repubblica 99','Livorno','57121','LI','Italia','+39 0586 112233','upsilon@upsilonelectronics.it','www.upsilonelectronics.it','Forniture elettroniche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(21,'F021','Omega Print Srl',NULL,'IT82838485812','FSCLRA67H12H501F','Via Manzoni 5','Aosta','11100','AO','Italia','+39 0165 334455','omega@omegaprint.it','www.omegaprint.it','Tipografia e stampa.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(22,'F022','Alpha Global Spa',NULL,'IT93949596914','GNTBLR74T01F205M','Via Veneto 3','Campobasso','86100','CB','Italia','+39 0874 445566','alpha@alphaglobal.it','www.alphaglobal.it','Forniture internazionali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(23,'F023','Beta Glass SRL',NULL,'IT10293847564','RCCMNL83C41H501X','Corso Italia 40','Pescara','65121','PE','Italia','+39 085 556677','beta@betaglass.it','www.betaglass.it','Produzione vetri speciali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(24,'F024','Gamma Freight SNC',NULL,'IT11213141516','BLNRRT90A12H501Y','Via Garibaldi 19','Taranto','74121','TA','Italia','+39 099 778899','gamma@gammafreight.it','www.gammafreight.it','Spedizioni internazionali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(25,'F025','Delta Oil Spa',NULL,'IT12131415171','FNTGRN69B01F205V','Piazza Duomo 5','Trapani','91100','TP','Italia','+39 0923 998877','delta@deltaoil.it','www.deltaoil.it','Forniture energetiche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(26,'F026','Epsilon Build Srl',NULL,'IT13141516181','LMBFRN85C61H501K','Viale Europa 20','Sassari','07100','SS','Italia','+39 079 445566','epsilon@epsilonbuild.it','www.epsilonbuild.it','Materiali per costruzioni.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(27,'F027','Zeta Foods Spa',NULL,'IT14151617191','RZZBLR77H41F205T','Via Roma 99','Cosenza','87100','CS','Italia','+39 0984 223344','zeta@zetafoods.it','www.zetafoods.it','Distribuzione alimentare.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(28,'F028','Eta Health SRL',NULL,'IT15161718102','GRDFRN82T12H501S','Via Verdi 7','Cagliari','09121','CA','Italia','+39 070 556677','eta@etahealth.it','www.etahealth.it','Dispositivi sanitari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(29,'F029','Theta Media SNC',NULL,'IT16171819212','NVRMNL74B01F205Q','Via Dante 88','Rimini','47921','RN','Italia','+39 0541 334455','theta@thetamedia.it','www.thetamedia.it','Servizi pubblicitari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(30,'F030','Iota Marine Spa',NULL,'IT17181920222','PRSCNT68H41H501C','Corso Italia 55','La Spezia','19121','SP','Italia','+39 0187 778899','iota@iotamarine.it','www.iotamarine.it','Forniture navali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(31,'gggggggggg','gggggggggggg','Privato','gggggggggggg','ggggggggg','Via Col Moschin, 43','Bassano del Grappa','36061','VI','Italia','gggggg','ljj@linl.it','dddddddd','dddddd','2025-07-10 10:30:41','2025-07-10 10:30:41','ddd','cliente');
/*!40000 ALTER TABLE `backup_controparti` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienti`
--

LOCK TABLES `clienti` WRITE;
/*!40000 ALTER TABLE `clienti` DISABLE KEYS */;
INSERT INTO `clienti` VALUES (1,'CL0001','Mario Rossi','Privato',NULL,'RSSMRA80A01H501U','Via Roma 10','Milano','20100','MI','Italia','02-1234567','mario.rossi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Mario Rossi'),(2,'CL0002','Francesca Bianchi','Privato',NULL,'BNCHFNC85B22F205Y','Via Torino 5','Torino','10100','TO','Italia','011-2345678','francesca.bianchi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Francesca Bianchi'),(3,'CL0003','Giovanni Verdi','Privato',NULL,'VRDGNN90C15L219T','Piazza Garibaldi 7','Napoli','80100','NA','Italia','081-3456789','giovanni.verdi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Giovanni Verdi'),(4,'CL0004','Studio Tecnico Alfa','Azienda','01234567890',NULL,'Via Galileo Galilei 12','Bologna','40100','BO','Italia','051-4567890','info@studioalfa.it','www.studioalfa.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Bianchi'),(5,'CL0005','Impresa Edile Beta','Azienda','09876543210',NULL,'Via Dante 3','Firenze','50100','FI','Italia','055-5678901','contatti@edilebeta.it','www.edilebeta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Rossi'),(6,'CL0006','Lucia Neri','Privato',NULL,'NRELUC75D41F205Z','Via Marconi 21','Venezia','30100','VE','Italia','041-6789012','lucia.neri@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Lucia Neri'),(7,'CL0007','Azienda Gamma Srl','Azienda','02345678901',NULL,'Corso Italia 45','Genova','16100','GE','Italia','010-7890123','info@gammasrl.it','www.gammasrl.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott.ssa Verdi'),(8,'CL0008','Marco Russo','Privato',NULL,'RSSMRC82L17H501U','Via Manzoni 9','Palermo','90100','PA','Italia','091-8901234','marco.russo@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Marco Russo'),(9,'CL0009','Consorzio Delta','Azienda','03456789012',NULL,'Via della Libertà 16','Catania','95100','CT','Italia','095-9012345','info@consorziodelta.it','www.consorziodelta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Bianchi'),(10,'CL0010','Anna Gallo','Privato',NULL,'GLLANN83M22F205K','Via Leopardi 13','Bari','70100','BA','Italia','080-1234567','anna.gallo@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Anna Gallo'),(11,'CL0011','Società Epsilon','Azienda','04567890123',NULL,'Via Vittorio Veneto 4','Trieste','34100','TS','Italia','040-2345678','contatti@epsilon.it','www.epsilon.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Neri'),(12,'CL0012','Roberto Marino','Privato',NULL,'MRNRBT79P15H501S','Via Cavour 20','Verona','37100','VR','Italia','045-3456789','roberto.marino@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Roberto Marino'),(13,'CL0013','Ditta Zeta','Azienda','05678901234',NULL,'Via San Marco 11','Padova','35100','PD','Italia','049-4567890','info@dittazeta.it','www.dittazeta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Rossi'),(14,'CL0014','Elena Ferri','Privato',NULL,'FRRELE78B20F205Z','Via Roma 32','Reggio Emilia','42100','RE','Italia','0522-567890','elena.ferri@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Elena Ferri'),(15,'CL0015','Ingegneria Theta','Azienda','06789012345',NULL,'Via Piave 8','Parma','43100','PR','Italia','0521-678901','info@thetaingegneria.it','www.thetaingegneria.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Gallo'),(16,'CL0016','Laura Conti','Privato',NULL,'CNTLRA82C25F205V','Via Carducci 14','Modena','41100','MO','Italia','059-789012','laura.conti@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Laura Conti'),(17,'CL0017','Impresa Iota','Azienda','07890123456',NULL,'Via Roma 1','Rimini','47900','RN','Italia','0541-890123','info@impiantoiota.it','www.impiantoiota.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Bianchi'),(18,'CL0018','Paolo Villa','Privato',NULL,'VLLPLA85H14F205A','Via Verdi 2','Pescara','65100','PE','Italia','085-901234','paolo.villa@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Paolo Villa'),(19,'CL0019','Forniture Kappa','Azienda','08901234567',NULL,'Via Milano 20','Lecce','73100','LE','Italia','0832-123456','info@kappaforniture.it','www.kappaforniture.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott.ssa Ferri'),(20,'CL0020','Sonia Riva','Privato',NULL,'RVSNIA81S30F205N','Via Dante 18','Como','22100','CO','Italia','031-234567','sonia.riva@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Sonia Riva'),(21,'CL0021','Società Lambda','Azienda','09012345678',NULL,'Via Firenze 7','Arezzo','52100','AR','Italia','0575-345678','contatti@lambda.it','www.lambda.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Marino'),(22,'CL0022','Giorgio Esposito','Privato',NULL,'SPTGGR80D12F205W','Via Napoli 15','Salerno','84100','SA','Italia','089-456789','giorgio.esposito@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Giorgio Esposito'),(23,'CL0023','Ditta Mu','Azienda','09123456789',NULL,'Via Torino 50','Cagliari','09100','CA','Italia','070-567890','info@dittamu.it','www.dittamu.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Rossi'),(24,'gggggggggg','gggggggggggg','Privato','gggggggggggg','ggggggggg','Via Col Moschin, 43','Bassano del Grappa','36061','VI','Italia','gggggg','ljj@linl.it','dddddddd','dddddd','2025-07-10 10:30:41','2025-07-10 10:30:41','ddd');
/*!40000 ALTER TABLE `clienti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controparti`
--

DROP TABLE IF EXISTS `controparti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `controparti` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codice` varchar(10) NOT NULL,
  `rag_soc` varchar(255) NOT NULL,
  `tipo_cliente` enum('Privato','Azienda') DEFAULT NULL,
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
  `data_modifica` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `contatto` varchar(100) DEFAULT NULL,
  `ruolo` enum('cliente','fornitore','entrambi') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codice` (`codice`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controparti`
--

LOCK TABLES `controparti` WRITE;
/*!40000 ALTER TABLE `controparti` DISABLE KEYS */;
INSERT INTO `controparti` VALUES (1,'F001','Alfa Logistics Srl',NULL,'IT12345678901','RSSMRA80A01H501Z','Via Roma 10','Milano','20121','MI','Italia','+39 02 1234567','info@alfalogistics.it','www.alfalogistics.it','Fornitore principale per logistica.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(2,'F002','Beta Construction Spa',NULL,'IT98765432109','BNCLGU75T10F205L','Corso Venezia 5','Torino','10123','TO','Italia','+39 011 7654321','contatti@betaconstruction.it','www.betaconstruction.it','Partner per edilizia.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(3,'F003','GammaTech SRL',NULL,'IT13579246801','FRRVLR82L41D325C','Via Garibaldi 22','Bologna','40121','BO','Italia','+39 051 234567','gamma@gammatech.it','www.gammatech.it','Fornitore hardware e software.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(4,'F004','Delta Food SNC',NULL,'IT24681357902','BNCPLA70H41F205P','Piazza Duomo 1','Firenze','50122','FI','Italia','+39 055 987654','delta@deltafood.it','www.deltafood.it','Specialista forniture alimentari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(5,'F005','Epsilon Energy Srl',NULL,'IT10293847561','PLRMNL60C12H501S','Viale Europa 15','Napoli','80133','NA','Italia','+39 081 112233','epsilon@epsilonenergy.it','www.epsilonenergy.it','Forniture impianti energetici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(6,'F006','Zeta Motors Spa',NULL,'IT56473829104','GRDRRT85M01F205R','Via Manzoni 8','Genova','16121','GE','Italia','+39 010 445566','zeta@zetamotors.it','www.zetamotors.it','Fornitore mezzi aziendali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(7,'F007','Eta Pharma Srl',NULL,'IT91827364501','VRDLGU77T41H501T','Via Verdi 30','Palermo','90133','PA','Italia','+39 091 778899','eta@etapharma.it','www.etapharma.it','Farmaceutica e presidi medici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(8,'F008','Theta Systems SNC',NULL,'IT19283746502','BRSCLD65A12F205G','Via Dante 12','Bari','70121','BA','Italia','+39 080 334455','theta@thetasystems.it','www.thetasystems.it','Servizi IT.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(9,'F009','Iota Fashion Srl',NULL,'IT31415926535','NRCVTT88B41D325M','Corso Italia 50','Venezia','30121','VE','Italia','+39 041 556677','iota@iotafashion.it','www.iotafashion.it','Fornitore abbigliamento da lavoro.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(10,'F010','Kappa Agro Spa',NULL,'IT16180339887','MNGFRN70C01H501P','Via Po 7','Verona','37121','VR','Italia','+39 045 998877','kappa@kappaagro.it','www.kappaagro.it','Prodotti agricoli.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(11,'F011','Lambda Services SRL',NULL,'IT27182818284','BLNLRA79T10F205Z','Via Mazzini 18','Trieste','34121','TS','Italia','+39 040 223344','lambda@lambdaservices.it','www.lambdaservices.it','Servizi generali per aziende.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(12,'F012','Mu Design SNC',NULL,'IT14142135623','VLLGRT62A01F205C','Piazza San Marco 3','Padova','35121','PD','Italia','+39 049 445566','mu@mudesign.it','www.mudesign.it','Design e arredamento uffici.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(13,'F013','Nu Tech Srl',NULL,'IT16117234567','CRSLGU73C51H501N','Via Vittorio Veneto 9','Parma','43121','PR','Italia','+39 0521 556677','nu@nutech.it','www.nutech.it','Forniture elettroniche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(14,'F014','Xi Logistic Spa',NULL,'IT10111213141','VRDLRS80H01F205A','Viale Marconi 40','Modena','41121','MO','Italia','+39 059 778899','xi@xilogistic.it','www.xilogistic.it','Trasporti e logistica.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(15,'F015','Omicron Green SRL',NULL,'IT21222324252','BLDMNL69C61H501G','Via Cavour 25','Reggio Emilia','42121','RE','Italia','+39 0522 998877','omicron@omicrongreen.it','www.omicrongreen.it','Prodotti ecosostenibili.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(16,'F016','Pi Medical SNC',NULL,'IT31323334362','RZZLRA75A12F205U','Piazza Libertà 6','Brescia','25121','BS','Italia','+39 030 334455','pi@pimedical.it','www.pimedical.it','Forniture ospedaliere.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(17,'F017','Rho Networks Srl',NULL,'IT41424344472','PRTMNL81B01H501O','Via Matteotti 14','Lecce','73100','LE','Italia','+39 0832 445566','rho@rhonetworks.it','www.rhonetworks.it','Soluzioni networking.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(18,'F018','Sigma Industrial Spa',NULL,'IT51525354582','MRSFRN78H41F205D','Corso Garibaldi 60','Perugia','06121','PG','Italia','+39 075 556677','sigma@sigmaindustrial.it','www.sigmaindustrial.it','Forniture industriali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(19,'F019','Tau Clean SRL',NULL,'IT61626364692','TRVBLR85T10H501E','Via XX Settembre 11','Catania','95121','CT','Italia','+39 095 778899','tau@tauclean.it','www.tauclean.it','Servizi di pulizia industriale.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(20,'F020','Upsilon Electronics SNC',NULL,'IT71727374702','VNTGRN82A01F205L','Viale della Repubblica 99','Livorno','57121','LI','Italia','+39 0586 112233','upsilon@upsilonelectronics.it','www.upsilonelectronics.it','Forniture elettroniche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(21,'F021','Omega Print Srl',NULL,'IT82838485812','FSCLRA67H12H501F','Via Manzoni 5','Aosta','11100','AO','Italia','+39 0165 334455','omega@omegaprint.it','www.omegaprint.it','Tipografia e stampa.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(22,'F022','Alpha Global Spa',NULL,'IT93949596914','GNTBLR74T01F205M','Via Veneto 3','Campobasso','86100','CB','Italia','+39 0874 445566','alpha@alphaglobal.it','www.alphaglobal.it','Forniture internazionali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(23,'F023','Beta Glass SRL',NULL,'IT10293847564','RCCMNL83C41H501X','Corso Italia 40','Pescara','65121','PE','Italia','+39 085 556677','beta@betaglass.it','www.betaglass.it','Produzione vetri speciali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(24,'F024','Gamma Freight SNC',NULL,'IT11213141516','BLNRRT90A12H501Y','Via Garibaldi 19','Taranto','74121','TA','Italia','+39 099 778899','gamma@gammafreight.it','www.gammafreight.it','Spedizioni internazionali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(25,'F025','Delta Oil Spa',NULL,'IT12131415171','FNTGRN69B01F205V','Piazza Duomo 5','Trapani','91100','TP','Italia','+39 0923 998877','delta@deltaoil.it','www.deltaoil.it','Forniture energetiche.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(26,'F026','Epsilon Build Srl',NULL,'IT13141516181','LMBFRN85C61H501K','Viale Europa 20','Sassari','07100','SS','Italia','+39 079 445566','epsilon@epsilonbuild.it','www.epsilonbuild.it','Materiali per costruzioni.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(27,'F027','Zeta Foods Spa',NULL,'IT14151617191','RZZBLR77H41F205T','Via Roma 99','Cosenza','87100','CS','Italia','+39 0984 223344','zeta@zetafoods.it','www.zetafoods.it','Distribuzione alimentare.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(28,'F028','Eta Health SRL',NULL,'IT15161718102','GRDFRN82T12H501S','Via Verdi 7','Cagliari','09121','CA','Italia','+39 070 556677','eta@etahealth.it','www.etahealth.it','Dispositivi sanitari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(29,'F029','Theta Media SNC',NULL,'IT16171819212','NVRMNL74B01F205Q','Via Dante 88','Rimini','47921','RN','Italia','+39 0541 334455','theta@thetamedia.it','www.thetamedia.it','Servizi pubblicitari.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(30,'F030','Iota Marine Spa',NULL,'IT17181920222','PRSCNT68H41H501C','Corso Italia 55','La Spezia','19121','SP','Italia','+39 0187 778899','iota@iotamarine.it','www.iotamarine.it','Forniture navali.','2025-07-08 21:28:06','2025-07-08 21:28:06',NULL,'fornitore'),(31,'gggggggggg','gggggggggggg','Privato','gggggggggggg','ggggggggg','Via Col Moschin, 43','Bassano del Grappa','36061','VI','Italia','gggggg','ljj@linl.it','dddddddd','dddddd','2025-07-10 10:30:41','2025-07-10 10:30:41','ddd','cliente'),(32,'C-CL0001','Mario Rossi','Privato','','RSSMRA80A01H501U','Via Roma 10','Milano','20100','MI','Italia','02-1234567','mario.rossi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Mario Rossi','cliente'),(33,'C-CL0002','Francesca Bianchi','Privato','','BNCHFNC85B22F205Y','Via Torino 5','Torino','10100','TO','Italia','011-2345678','francesca.bianchi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Francesca Bianchi','cliente'),(34,'C-CL0003','Giovanni Verdi','Privato','','VRDGNN90C15L219T','Piazza Garibaldi 7','Napoli','80100','NA','Italia','081-3456789','giovanni.verdi@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Giovanni Verdi','cliente'),(35,'C-CL0004','Studio Tecnico Alfa','Azienda','01234567890','','Via Galileo Galilei 12','Bologna','40100','BO','Italia','051-4567890','info@studioalfa.it','www.studioalfa.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Bianchi','cliente'),(36,'C-CL0005','Impresa Edile Beta','Azienda','09876543210','','Via Dante 3','Firenze','50100','FI','Italia','055-5678901','contatti@edilebeta.it','www.edilebeta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Rossi','cliente'),(37,'C-CL0006','Lucia Neri','Privato','','NRELUC75D41F205Z','Via Marconi 21','Venezia','30100','VE','Italia','041-6789012','lucia.neri@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Lucia Neri','cliente'),(38,'C-CL0007','Azienda Gamma Srl','Azienda','02345678901','','Corso Italia 45','Genova','16100','GE','Italia','010-7890123','info@gammasrl.it','www.gammasrl.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott.ssa Verdi','cliente'),(39,'C-CL0008','Marco Russo','Privato','','RSSMRC82L17H501U','Via Manzoni 9','Palermo','90100','PA','Italia','091-8901234','marco.russo@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Marco Russo','cliente'),(40,'C-CL0009','Consorzio Delta','Azienda','03456789012','','Via della Libertà 16','Catania','95100','CT','Italia','095-9012345','info@consorziodelta.it','www.consorziodelta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Bianchi','cliente'),(41,'C-CL0010','Anna Gallo','Privato','','GLLANN83M22F205K','Via Leopardi 13','Bari','70100','BA','Italia','080-1234567','anna.gallo@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Anna Gallo','cliente'),(42,'C-CL0011','Società Epsilon','Azienda','04567890123','','Via Vittorio Veneto 4','Trieste','34100','TS','Italia','040-2345678','contatti@epsilon.it','www.epsilon.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Neri','cliente'),(43,'C-CL0012','Roberto Marino','Privato','','MRNRBT79P15H501S','Via Cavour 20','Verona','37100','VR','Italia','045-3456789','roberto.marino@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Roberto Marino','cliente'),(44,'C-CL0013','Ditta Zeta','Azienda','05678901234','','Via San Marco 11','Padova','35100','PD','Italia','049-4567890','info@dittazeta.it','www.dittazeta.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Rossi','cliente'),(45,'C-CL0014','Elena Ferri','Privato','','FRRELE78B20F205Z','Via Roma 32','Reggio Emilia','42100','RE','Italia','0522-567890','elena.ferri@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Elena Ferri','cliente'),(46,'C-CL0015','Ingegneria Theta','Azienda','06789012345','','Via Piave 8','Parma','43100','PR','Italia','0521-678901','info@thetaingegneria.it','www.thetaingegneria.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Gallo','cliente'),(47,'C-CL0016','Laura Conti','Privato','','CNTLRA82C25F205V','Via Carducci 14','Modena','41100','MO','Italia','059-789012','laura.conti@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Laura Conti','cliente'),(48,'C-CL0017','Impresa Iota','Azienda','07890123456','','Via Roma 1','Rimini','47900','RN','Italia','0541-890123','info@impiantoiota.it','www.impiantoiota.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Bianchi','cliente'),(49,'C-CL0018','Paolo Villa','Privato','','VLLPLA85H14F205A','Via Verdi 2','Pescara','65100','PE','Italia','085-901234','paolo.villa@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Paolo Villa','cliente'),(50,'C-CL0019','Forniture Kappa','Azienda','08901234567','','Via Milano 20','Lecce','73100','LE','Italia','0832-123456','info@kappaforniture.it','www.kappaforniture.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott.ssa Ferri','cliente'),(51,'C-CL0020','Sonia Riva','Privato','','RVSNIA81S30F205N','Via Dante 18','Como','22100','CO','Italia','031-234567','sonia.riva@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Sonia Riva','cliente'),(52,'C-CL0021','Società Lambda','Azienda','09012345678','','Via Firenze 7','Arezzo','52100','AR','Italia','0575-345678','contatti@lambda.it','www.lambda.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Sig. Marino','cliente'),(53,'C-CL0022','Giorgio Esposito','Privato','','SPTGGR80D12F205W','Via Napoli 15','Salerno','84100','SA','Italia','089-456789','giorgio.esposito@email.it',NULL,'','2025-07-09 14:07:13','2025-07-09 14:07:13','Giorgio Esposito','cliente'),(54,'C-CL0023','Ditta Mu','Azienda','09123456789','','Via Torino 50','Cagliari','09100','CA','Italia','070-567890','info@dittamu.it','www.dittamu.it','','2025-07-09 14:07:13','2025-07-09 14:07:13','Dott. Rossi','cliente');
/*!40000 ALTER TABLE `controparti` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diba`
--

LOCK TABLES `diba` WRITE;
/*!40000 ALTER TABLE `diba` DISABLE KEYS */;
INSERT INTO `diba` VALUES (1,10,4,1.00),(2,10,3,2.00),(3,10,6,4.00),(4,10,7,1.00),(5,10,9,1.00),(6,10,8,1.00),(7,4,2,10.00),(8,4,2,130.00),(10,22,5,1.00),(11,10,30,1.00),(12,10,8,1.00),(13,10,3,1.00),(14,10,20,1.00),(15,10,21,1.00),(16,10,2,1.00),(17,10,2,1.00),(18,32,22,5.00),(19,32,16,5.00),(20,32,28,6.00),(21,5,16,4.00),(22,5,26,11.00);
/*!40000 ALTER TABLE `diba` ENABLE KEYS */;
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
  CONSTRAINT `fk_ordini_fornitori` FOREIGN KEY (`fornitore_id`) REFERENCES `controparti` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini`
--

LOCK TABLES `ordini` WRITE;
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
INSERT INTO `ordini` VALUES (5,'1','2025-07-09',5,'ANNULLATO','ciao ciao...','2025-07-09 09:41:59','2025-07-09 09:41:59'),(8,'10','2025-07-09',21,'APERTO','CCCCCCCCCCCCCC','2025-07-09 12:21:22','2025-07-09 12:21:22'),(9,'11','2025-07-09',23,'CHIUSO','464646','2025-07-09 13:46:42','2025-07-09 13:46:42'),(11,'4','2025-07-10',1,'APERTO','dddddddddddddd','2025-07-10 13:12:00','2025-07-10 13:12:00'),(12,'ORD-0001','2025-06-08',3,'ANNULLATO','Note ordine 1','2025-07-14 12:29:19','2025-07-14 12:29:19'),(13,'ORD-0002','2025-04-24',1,'CHIUSO','Note ordine 2','2025-07-14 12:29:19','2025-07-14 12:29:19'),(14,'ORD-0003','2025-05-10',5,'APERTO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(15,'ORD-0004','2025-06-08',3,'ANNULLATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(16,'ORD-0005','2025-04-21',1,'APERTO','Note ordine 5','2025-07-14 12:29:19','2025-07-14 12:29:19'),(17,'ORD-0006','2025-06-27',3,'ANNULLATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(18,'ORD-0007','2025-06-13',5,'APERTO','Urgente','2025-07-14 12:29:19','2025-07-14 12:29:19'),(19,'ORD-0008','2025-04-19',3,'ANNULLATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(20,'ORD-0009','2025-06-26',4,'APERTO','Consegna parziale','2025-07-14 12:29:19','2025-07-14 12:29:19'),(21,'ORD-0010','2025-06-11',3,'INVIATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(22,'ORD-0011','2025-04-22',5,'INVIATO','Nota aggiuntiva','2025-07-14 12:29:19','2025-07-14 12:29:19'),(23,'ORD-0012','2025-07-13',1,'ANNULLATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(24,'ORD-0013','2025-07-08',3,'CHIUSO','Pagamento anticipato','2025-07-14 12:29:19','2025-07-14 12:29:19'),(25,'ORD-0014','2025-05-16',2,'INVIATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(26,'ORD-0015','2025-05-07',5,'APERTO','Confermare quantità','2025-07-14 12:29:19','2025-07-14 12:29:19'),(27,'ORD-0016','2025-05-02',5,'CHIUSO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(28,'ORD-0017','2025-07-03',3,'ANNULLATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(29,'ORD-0018','2025-06-04',2,'INVIATO','Ordine speciale','2025-07-14 12:29:19','2025-07-14 12:29:19'),(30,'ORD-0019','2025-05-09',4,'ANNULLATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(31,'ORD-0020','2025-05-31',5,'ANNULLATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(32,'ORD-0021','2025-06-10',3,'CHIUSO','Nota interna','2025-07-14 12:29:19','2025-07-14 12:29:19'),(33,'ORD-0022','2025-06-03',3,'ANNULLATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(34,'ORD-0023','2025-04-18',2,'INVIATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(35,'ORD-0024','2025-05-06',5,'CHIUSO','Richiesta rapida','2025-07-14 12:29:19','2025-07-14 12:29:19'),(36,'ORD-0025','2025-07-05',4,'APERTO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(37,'ORD-0026','2025-05-24',3,'CHIUSO','Ordine urgente','2025-07-14 12:29:19','2025-07-14 12:29:19'),(38,'ORD-0027','2025-05-11',4,'INVIATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(39,'ORD-0028','2025-05-26',4,'APERTO','Verifica merce','2025-07-14 12:29:19','2025-07-14 12:29:19'),(40,'ORD-0029','2025-05-08',1,'INVIATO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19'),(41,'ORD-0030','2025-07-07',3,'CHIUSO',NULL,'2025-07-14 12:29:19','2025-07-14 12:29:19');
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
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini_righe`
--

LOCK TABLES `ordini_righe` WRITE;
/*!40000 ALTER TABLE `ordini_righe` DISABLE KEYS */;
INSERT INTO `ordini_righe` (`id_riga`, `id_ordine`, `descrizione`, `prezzo_unitario`, `nome_articolo`, `quantita`) VALUES (1,5,'Assemblato con motore e supporti',30.09,'Gruppo montaggio A',30.95),(2,5,'questo è il prodotto di codice 78787878 della lista dei prodotti',79.24,'78787878',40.85),(3,5,'Modulo LED 12V',93.18,'Pannello LED',15.06),(4,5,'Connettore per motore',63.36,'Connettore 4 pin',49.36),(5,5,'LKJLJL',27.64,'JLKJLJLKJLKJLKJ',28.91),(6,5,'Motore monofase 230V',33.41,'Motore 230V',50.50),(7,5,'descrizione prodotto 70',93.16,'product 70',46.78),(8,8,'Modulo LED 12V',93.18,'Pannello LED',38.06),(9,8,'questo è il prodotto numero 88888888 della lista dei prdotti',11.71,'88888888',12.68),(10,8,'fff',38.69,'eee',29.55),(11,8,'Connettore per motore',63.36,'Connettore 4 pin',36.18),(12,8,'questo è il prodotto di codice 78787878 della lista dei prodotti',79.24,'78787878',46.12),(13,8,'Rondella zincata',43.50,'Rondella Ø5',9.14),(14,8,'ojeojojoijoi',77.18,'999999',1.99),(15,9,'KHKHKJHKHKHKHKJHK',18.01,'KHKJHKHKHKJgggggggggggggggggppppppppppppppppppppppppppppppppppp',17.12),(16,9,'Cavo multipolare nero',88.72,'Cavo 3x1.5mm²',3.46),(17,9,'descrizione prodotto 90000 della lista dei prodotti',59.29,'product 90000',24.57),(18,9,'Piastra in acciaio 100x50mm',52.78,'Piastra Supporto',13.91),(19,9,'ojeojojoijoi',77.18,'999999',13.61),(20,9,'OUOUOI',72.25,'UOUO',48.89),(21,9,'PCB controller v1.2',63.92,'Scheda controllo',18.07),(22,9,'Rondella zincata',43.50,'Rondella Ø5',15.19),(23,9,'RTR',34.84,'RTRTRE',38.92),(24,9,'Modulo LED 12V',93.18,'Pannello LED',24.32),(25,11,'OUORTUOTU',88.32,'ORITTOU',13.57),(26,11,'Motore monofase 230V',33.41,'Motore 230V',14.12),(27,11,'PCB controller v1.2',63.92,'Scheda controllo',27.72),(28,11,'fff',38.69,'eee',11.43),(29,11,'questo è il prodotto di codice 78787878 della lista dei prodotti',79.24,'78787878',20.39),(30,11,'vite metrica 6mm in acciaio',21.57,'Vite M6',18.05),(31,11,'descrizione prodotto 90000 della lista dei prodotti',59.29,'product 90000',29.63),(32,11,'RTR',34.84,'RTRTRE',1.45),(33,12,'ojeojojoijoi',77.18,'999999',39.58),(34,12,'Connettore per motore',63.36,'Connettore 4 pin',14.61),(35,12,'Piastra in acciaio 100x50mm',52.78,'Piastra Supporto',3.45),(36,12,'OJOJGLJ',28.54,'HJKGHKGHKGQ',50.32),(37,12,'descrizione prodotto 70',93.16,'product 70',22.52),(38,12,'fff',38.69,'eee',28.54),(39,12,'vite metrica 6mm in acciaio',21.57,'Vite M6',5.86),(40,12,'PCB controller v1.2',63.92,'Scheda controllo',28.16),(41,12,'KHKHKJHKHKHKHKJHK',18.01,'KHKJHKHKHKJgggggggggggggggggppppppppppppppppppppppppppppppppppp',26.25),(42,12,'Cavo multipolare nero',88.72,'Cavo 3x1.5mm²',9.46),(43,12,'OUOUOI',72.25,'UOUO',40.11),(44,12,'Box in plastica ABS',40.65,'Involucro ABS',37.31),(45,13,'descrizione prodotto 70',93.16,'product 70',6.86),(46,13,'OUOUOI',72.25,'UOUO',7.60),(47,13,'Assemblato con motore e supporti',30.09,'Gruppo montaggio A',30.32),(48,13,'Rondella zincata',43.50,'Rondella Ø5',15.73),(49,13,'Box in plastica ABS',40.65,'Involucro ABS',28.41),(50,13,'KHKHKJHKHKHKHKJHK',18.01,'KHKJHKHKHKJgggggggggggggggggppppppppppppppppppppppppppppppppppp',42.49),(51,14,'Modulo LED 12V',93.18,'Pannello LED',44.63),(52,14,'questo è il prodotto di codice 78787878 della lista dei prodotti',79.24,'78787878',24.00),(53,14,'Piastra in acciaio 100x50mm',52.78,'Piastra Supporto',43.08),(54,14,'OUORTUOTU',88.32,'ORITTOU',5.83),(55,14,'HKJHKJHK',78.65,'NJKHH',27.87),(56,14,'LKJLJL',27.64,'JLKJLJLKJLKJLKJ',45.53),(57,14,'questo è il prodotto numero 88888888 della lista dei prdotti',11.71,'88888888',17.92),(58,15,'OUOUOI',72.25,'UOUO',27.30),(59,15,'HKJHKJHK',78.65,'NJKHH',48.71),(60,15,'questo è il prodotto di codice 78787878 della lista dei prodotti',79.24,'78787878',21.25),(61,15,'Rondella zincata',43.50,'Rondella Ø5',13.22),(62,15,'vite metrica 6mm in acciaio',21.57,'Vite M6',4.34),(63,16,'OJOJGLJ',28.54,'HJKGHKGHKGQ',33.37),(64,16,'descrizione prodotto 70',93.16,'product 70',48.81),(65,16,'questo è il prodotto di codice 78787878 della lista dei prodotti',79.24,'78787878',12.71),(66,16,'Box in plastica ABS',40.65,'Involucro ABS',43.19),(67,16,'Piastra in acciaio 100x50mm',52.78,'Piastra Supporto',7.79),(68,16,'questo è il prodotto numero 88888888 della lista dei prdotti',11.71,'88888888',6.07),(69,16,'Motore monofase 230V',33.41,'Motore 230V',32.47),(70,16,'KHKHKJHKHKHKHKJHK',18.01,'KHKJHKHKHKJgggggggggggggggggppppppppppppppppppppppppppppppppppp',50.69),(71,16,'descrizione prodotto 80 jljljllljlkjlj ljljljljljljllklkjlkjljlk',69.76,'product 80',46.57),(72,16,'OUOUOI',72.25,'UOUO',5.36),(73,16,'vite metrica 6mm in acciaio',21.57,'Vite M6',24.73),(74,17,'OJOJGLJ',28.54,'HJKGHKGHKGQ',41.28),(75,17,'Piastra in acciaio 100x50mm',52.78,'Piastra Supporto',46.76),(76,17,'Box in plastica ABS',40.65,'Involucro ABS',14.57),(77,17,'OUOUOI',72.25,'UOUO',43.35),(78,17,'Connettore per motore',63.36,'Connettore 4 pin',40.03),(79,17,'descrizione prodotto 70',93.16,'product 70',38.40),(80,17,'Modulo LED 12V',93.18,'Pannello LED',10.14),(81,17,'fff',38.69,'eee',34.68),(82,17,'PCB controller v1.2',63.92,'Scheda controllo',44.26),(83,17,'questo è il prodotto numero 88888888 della lista dei prdotti',11.71,'88888888',38.21),(84,18,'questo è il prodotto numero 88888888 della lista dei prdotti',11.71,'88888888',18.11),(85,18,'fff',38.69,'eee',4.20),(86,18,'OUORTUOTU',88.32,'ORITTOU',12.15),(87,18,'Piastra in acciaio 100x50mm',52.78,'Piastra Supporto',15.05),(88,18,'descrizione prodotto 70',93.16,'product 70',23.84),(89,18,'Assemblato con motore e supporti',30.09,'Gruppo montaggio A',40.65),(90,18,'HKJHKJHK',78.65,'NJKHH',45.63),(91,19,'Connettore per motore',63.36,'Connettore 4 pin',18.33),(92,19,'descrizione prodotto 70',93.16,'product 70',4.26),(93,19,'RTR',34.84,'RTRTRE',18.88),(94,19,'questo è il prodotto di codice 78787878 della lista dei prodotti',79.24,'78787878',27.62),(95,19,'Assemblato con motore e supporti',30.09,'Gruppo montaggio A',46.21),(96,19,'vite metrica 6mm in acciaio',21.57,'Vite M6',47.49),(97,19,'fff',38.69,'eee',48.29),(98,19,'OUORTUOTU',88.32,'ORITTOU',12.38),(99,19,'Rondella zincata',43.50,'Rondella Ø5',15.44),(100,19,'descrizione prodotto 90000 della lista dei prodotti',59.29,'product 90000',6.76);
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteArticoli`(IN p_id INT)
BEGIN
    DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete articolo') AS response; END;
    START TRANSACTION; DELETE FROM articoli WHERE id=p_id; SET v_rows=ROW_COUNT(); IF v_rows=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo non trovato'; END IF; COMMIT;
    SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCausali`(IN p_id INT)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN ROLLBACK;
        SELECT JSON_OBJECT('status','error','message','Errore delete causale') AS response; END;

    START TRANSACTION;

    DELETE FROM causali WHERE id = p_id;
    SET v_rows = ROW_COUNT();

    IF v_rows = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Causale non trovata';
    END IF;

    COMMIT;
    SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteControparte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteControparte`(IN p_id INT)
BEGIN
  DECLARE v_rows INT DEFAULT 0;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete controparte') AS response; END;
  START TRANSACTION;
  DELETE FROM controparti WHERE id=p_id;
  SET v_rows=ROW_COUNT();
  IF v_rows=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Controparte non trovata'; END IF;
  COMMIT;
  SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteDdt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDdt`(IN p_id_ddt INT)
BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete DDT') AS response; END;
  START TRANSACTION; DELETE FROM ddt WHERE id_ddt=p_id_ddt; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DDT non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteDdt_righe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDdt_righe`(IN p_id_riga INT)
BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete riga DDT') AS response; END;
  START TRANSACTION; DELETE FROM ddt_righe WHERE id_riga=p_id_riga; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Riga non trovata'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDiba`(IN p_id INT)
BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete DIBA') AS response; END;
  START TRANSACTION; DELETE FROM diba WHERE id=p_id; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Record DIBA non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteFornitori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteFornitori`(IN p_id INT)
BEGIN DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete fornitore') AS response; END;
  START TRANSACTION; DELETE FROM fornitori WHERE id=p_id; SET v_rows=ROW_COUNT(); IF v_rows=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fornitore non trovato'; END IF; COMMIT;
  SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteLogin`(IN p_id INT)
BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete login') AS response; END;
  START TRANSACTION; DELETE FROM login WHERE id=p_id; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Login non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteMovimenti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMovimenti`(IN p_id INT)
BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete movimento') AS response; END;
  START TRANSACTION; DELETE FROM movimenti WHERE id=p_id; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Movimento non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteOrdini` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteOrdini`(IN p_id INT)
BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete ordine') AS response; END;
  START TRANSACTION; DELETE FROM ordini WHERE id_ordine=p_id; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ordine non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteOrdini_righe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteOrdini_righe`(IN p_id_riga INT)
BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete riga ordine') AS response; END;
  START TRANSACTION; DELETE FROM ordini_righe WHERE id_riga=p_id_riga; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Riga non trovata'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
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
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchArticoli`(
    IN p_name        VARCHAR(100),   
    IN p_supplier    VARCHAR(100),   
    IN p_page        INT,            
    IN p_page_size   INT,            
    IN p_order_by    VARCHAR(50),    
    IN p_order_dir   VARCHAR(4)      
)
BEGIN
    DECLARE v_offset   INT DEFAULT 0;
    DECLARE v_total    INT DEFAULT 0;

    -- Calcola l?offset
    SET v_offset = (p_page - 1) * p_page_size;

    
    SELECT COUNT(*) INTO v_total
    FROM articoli a
    WHERE (p_name     IS NULL OR p_name     = '' OR a.name     LIKE CONCAT('%', p_name,     '%'))
      AND (p_supplier IS NULL OR p_supplier = '' OR a.supplier LIKE CONCAT('%', p_supplier, '%'));

    
    SET @qry = CONCAT(
        'SELECT JSON_ARRAYAGG(row_json) AS data ',
        'FROM (',
            'SELECT JSON_OBJECT(',
                '"id",         id,',
                '"name",       name,',
                '"description",description,',
                '"quantita",   quantita,',
                '"min",        `min`,',
                '"max",        `max`,',
                '"supplier",   supplier,',
                '"has_diba",   has_diba',
            ') AS row_json ',
            'FROM articoli ',
            'WHERE 1 = 1 ',

            IF(p_name IS NULL     OR p_name     = '', '', CONCAT('AND name     LIKE "%', p_name,     '%" ')),
            IF(p_supplier IS NULL OR p_supplier = '', '', CONCAT('AND supplier LIKE "%', p_supplier, '%" ')),

            'ORDER BY ', p_order_by, ' ', p_order_dir, ' ',
            'LIMIT ', p_page_size, ' OFFSET ', v_offset,
        ') AS sub'
    );

    PREPARE stmt FROM @qry;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

   
    SELECT JSON_OBJECT(
        'status',     'success',
        'totalRows',  v_total,
        'page',       p_page,
        'pageSize',   p_page_size
    ) AS meta;
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
    IN p_codice      VARCHAR(3),      -- filtro LIKE sul codice
    IN p_description VARCHAR(250),    -- filtro LIKE sulla descrizione
    IN p_tipo        ENUM('C','S'),   -- filtro esatto sul tipo
    IN p_attiva      TINYINT,         -- 1 attive, 0 disattive, NULL tutte
    IN p_page        INT,             -- pagina 1-based
    IN p_page_size   INT,             -- record per pagina
    IN p_order_by    VARCHAR(50),     -- campo di ordinamento (whitelist lato app)
    IN p_order_dir   VARCHAR(4)       -- ASC | DESC
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    DECLARE v_total  INT DEFAULT 0;

    SET v_offset = (p_page - 1) * p_page_size;

    /* --- Totale righe filtrate --- */
    SELECT COUNT(*) INTO v_total
      FROM causali
     WHERE (p_codice      IS NULL OR codice      LIKE CONCAT('%',p_codice,'%'))
       AND (p_description IS NULL OR description LIKE CONCAT('%',p_description,'%'))
       AND (p_tipo        IS NULL OR tipo        =  p_tipo)
       AND (p_attiva      IS NULL OR attiva      =  p_attiva);

    /* --- Query dinamica con JSON_ARRAYAGG --- */
    SET @sql = CONCAT(
      'SELECT JSON_ARRAYAGG(JSON_OBJECT(',
          '"id",id,"codice",codice,"description",description,',
          '"tipo",tipo,"attiva",attiva)) AS data ',
      'FROM causali WHERE 1=1 ',
          IF(p_codice      IS NULL,'', CONCAT(' AND codice LIKE "%',      p_codice,      '%"')),
          IF(p_description IS NULL,'', CONCAT(' AND description LIKE "%', p_description, '%"')),
          IF(p_tipo        IS NULL,'', CONCAT(' AND tipo = "',            p_tipo,        '"')),
          IF(p_attiva      IS NULL,'', CONCAT(' AND attiva = ',           p_attiva)),
      ' ORDER BY ', p_order_by,' ',p_order_dir,
      ' LIMIT ', p_page_size,' OFFSET ', v_offset
    );

    PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

    /* --- Meta dati paginazione --- */
    SELECT JSON_OBJECT(
            'status','success',
            'totalRows',v_total,
            'page',p_page,
            'pageSize',p_page_size
          ) AS meta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchControparti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchControparti`(
    IN p_nome           VARCHAR(255),
    IN p_tipo           ENUM('CLIENTE','FORNITORE'),
    IN p_codice_fiscale VARCHAR(20),
    IN p_partita_iva    VARCHAR(20),
    IN p_citta          VARCHAR(100),
    IN p_contatto       VARCHAR(100),
    IN p_page           INT,
    IN p_page_size      INT,
    IN p_order_by       VARCHAR(50),
    IN p_order_dir      VARCHAR(4)
)
BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0;
  SET v_offset=(p_page-1)*p_page_size;
  -- Conteggio totale
  SELECT COUNT(*) INTO v_total FROM controparti
    WHERE (p_nome           IS NULL OR nome LIKE CONCAT('%',p_nome,'%'))
      AND (p_tipo           IS NULL OR tipo=p_tipo)
      AND (p_codice_fiscale IS NULL OR codice_fiscale LIKE CONCAT('%',p_codice_fiscale,'%'))
      AND (p_partita_iva    IS NULL OR partita_iva LIKE CONCAT('%',p_partita_iva,'%'))
      AND (p_citta          IS NULL OR citta LIKE CONCAT('%',p_citta,'%'))
      AND (p_contatto       IS NULL OR contatto LIKE CONCAT('%',p_contatto,'%'));

  -- Build query dinamica con JSON_ARRAYAGG identica a pattern FetchOrdini/FetchMovimenti
  SET @q = CONCAT(
    'SELECT JSON_ARRAYAGG(JSON_OBJECT(',
      '"id",id,',
      '"nome",nome,',
      '"tipo",tipo,',
      '"codice_fiscale",codice_fiscale,',
      '"partita_iva",partita_iva,',
      '"citta",citta,',
      '"telefono",telefono,',
      '"email",email,',
      '"contatto",contatto',
    ')) AS data FROM controparti WHERE 1=1',
    IF(p_nome           IS NULL,'', CONCAT(' AND nome LIKE "%',p_nome,'%"')),
    IF(p_tipo           IS NULL,'', CONCAT(' AND tipo="',p_tipo,'"')),
    IF(p_codice_fiscale IS NULL,'', CONCAT(' AND codice_fiscale LIKE "%',p_codice_fiscale,'%"')),
    IF(p_partita_iva    IS NULL,'', CONCAT(' AND partita_iva LIKE "%',p_partita_iva,'%"')),
    IF(p_citta          IS NULL,'', CONCAT(' AND citta LIKE "%',p_citta,'%"')),
    IF(p_contatto       IS NULL,'', CONCAT(' AND contatto LIKE "%',p_contatto,'%"')),
    ' ORDER BY ', p_order_by, ' ', p_order_dir,
    ' LIMIT ', p_page_size, ' OFFSET ', v_offset
  );
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;

  SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchDdt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchDdt`(IN p_num_ddt VARCHAR(20), IN p_cliente_id INT, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4))
BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM ddt WHERE (p_num_ddt IS NULL OR num_ddt LIKE CONCAT('%',p_num_ddt,'%')) AND (p_cliente_id IS NULL OR cliente_id=p_cliente_id);
    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id_ddt",id_ddt,"num_ddt",num_ddt,"data_ddt",data_ddt,"cliente_id",cliente_id,"stato",stato)) AS data FROM ddt WHERE 1=1',
                    IF(p_num_ddt IS NULL,'', CONCAT(' AND num_ddt LIKE "%',p_num_ddt,'%"')),
                    IF(p_cliente_id IS NULL,'', CONCAT(' AND cliente_id=',p_cliente_id)),
                    ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchDdt_righe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchDdt_righe`(IN p_id_ddt INT, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4))
BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
  SELECT COUNT(*) INTO v_total FROM ddt_righe WHERE (p_id_ddt IS NULL OR id_ddt=p_id_ddt);
  SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id_riga",id_riga,"id_ddt",id_ddt,"cod_articolo",cod_articolo,"descrizione",descrizione,"qta",qta)) AS data FROM ddt_righe WHERE 1=1',
                  IF(p_id_ddt IS NULL,'', CONCAT(' AND id_ddt=',p_id_ddt)),
                  ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
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
    IN p_id_father  INT,
    IN p_page       INT,
    IN p_page_size  INT,
    IN p_order_by   VARCHAR(50),
    IN p_order_dir  VARCHAR(4)
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    DECLARE v_total  INT DEFAULT 0;
    SET v_offset = (p_page - 1) * p_page_size;

    /* 1) totale righe */
    SELECT COUNT(*) INTO v_total
    FROM diba
    WHERE (p_id_father IS NULL OR id_father = p_id_father);

    /* 2) righe paginate con JOIN articoli a (figlio) */
    SET @q = CONCAT(
        'SELECT JSON_ARRAYAGG(row_json) AS data ',
        'FROM (',
            'SELECT JSON_OBJECT(',
                '\"id\",            d.id,',
                '\"id_father\",     d.id_father,',
                '\"id_son\",        d.id_son,',
                '\"quantita\",      d.quantita,',
                '\"son_name\",      a.name,',
                '\"son_description\",a.description',
            ') AS row_json ',
            'FROM diba d ',
            'LEFT JOIN articoli a ON a.id = d.id_son ',
            'WHERE 1 = 1 ',
            IF(p_id_father IS NULL, '', CONCAT('AND d.id_father = ', p_id_father, ' ')),
            'ORDER BY ', p_order_by, ' ', p_order_dir, ' ',
            'LIMIT ', p_page_size, ' OFFSET ', v_offset,
        ') AS sub'
    );

    PREPARE stmt FROM @q; EXECUTE stmt; DEALLOCATE PREPARE stmt;

    /* 3) meta */
    SELECT JSON_OBJECT(
        'status',    'success',
        'totalRows', v_total,
        'page',      p_page,
        'pageSize',  p_page_size
    ) AS meta;
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
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchFornitori`(
    IN p_codice VARCHAR(10), IN p_rag_soc VARCHAR(255), IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM fornitori WHERE (p_codice IS NULL OR codice LIKE CONCAT('%',p_codice,'%')) AND (p_rag_soc IS NULL OR rag_soc LIKE CONCAT('%',p_rag_soc,'%'));
    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"codice",codice,"rag_soc",rag_soc,"telefono",telefono)) AS data FROM fornitori WHERE 1=1',
                    IF(p_codice IS NULL,'', CONCAT(' AND codice LIKE "%',p_codice,'%"')),
                    IF(p_rag_soc IS NULL,'', CONCAT(' AND rag_soc LIKE "%',p_rag_soc,'%"')),
                    ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;
    SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchLogin`(IN p_user VARCHAR(100), IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4))
BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM login WHERE (p_user IS NULL OR `user` LIKE CONCAT('%',p_user,'%'));
    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"user",`user`,`role`,role)) AS data FROM login WHERE 1=1',
                    IF(p_user IS NULL,'', CONCAT(' AND `user` LIKE "%',p_user,'%"')),
                    ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
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
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchMovimenti`(
    IN p_codice_cau VARCHAR(3),
    IN p_idart      INT,
    IN p_from       DATE,
    IN p_to         DATE,
    IN p_page       INT,
    IN p_page_size  INT,
    IN p_order_by   VARCHAR(50),
    IN p_order_dir  VARCHAR(4)
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    DECLARE v_total  INT DEFAULT 0;

    /* totale righe */
    SELECT COUNT(*) INTO v_total
      FROM movimenti
     WHERE (p_codice_cau IS NULL OR codice_cau = p_codice_cau)
       AND (p_idart      IS NULL OR idart      = p_idart)
       AND (p_from       IS NULL OR `data`    >= p_from)
       AND (p_to         IS NULL OR `data`    <= p_to);

    SET v_offset = (p_page - 1) * p_page_size;

    /* pagina con LIMIT applicato nella sotto-query */
    SET @sql = CONCAT(
      'SELECT JSON_ARRAYAGG(JSON_OBJECT(',
         '"id",id,"data",`data`,"tipo",tipo,"description",description,',
         '"quantita",quantita,"codice_cau",codice_cau,"idart",idart,',
         '"user",`user`,"um",um)) AS data ',
      'FROM (',
        'SELECT * FROM movimenti WHERE 1=1 ',
          IF(p_codice_cau IS NULL,'', CONCAT(' AND codice_cau=\"',p_codice_cau,'\"')),
          IF(p_idart      IS NULL,'', CONCAT(' AND idart=',p_idart)),
          IF(p_from       IS NULL,'', CONCAT(' AND `data`>=\"',p_from,'\"')),
          IF(p_to         IS NULL,'', CONCAT(' AND `data`<=\"',p_to,'\"')),
        ' ORDER BY ', p_order_by,' ',p_order_dir,
        ' LIMIT ', p_page_size,' OFFSET ', v_offset,
      ') AS paged'
    );

    PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

    SELECT JSON_OBJECT(
             'status','success',
             'totalRows', v_total,
             'page', p_page,
             'pageSize', p_page_size
           ) AS meta;
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
    IN p_num_ordine   VARCHAR(20),         -- filtro facoltativo sul numero ordine
    IN p_fornitore_id INT,                 -- filtro facoltativo per fornitore
    IN p_page         INT,                 -- numero pagina (parte da 1)
    IN p_page_size    INT,                 -- righe per pagina
    IN p_order_by     VARCHAR(50),         -- colonna di ordinamento
    IN p_order_dir    VARCHAR(4)           -- ASC / DESC
)
BEGIN
    DECLARE v_offset  INT DEFAULT 0;
    DECLARE v_total   INT DEFAULT 0;


    SET v_offset = (p_page - 1) * p_page_size;

    SELECT COUNT(*) INTO v_total
    FROM ordini o
    WHERE (p_num_ordine   IS NULL OR p_num_ordine   = '' OR o.num_ordine   LIKE CONCAT('%', p_num_ordine,   '%'))
      AND (p_fornitore_id IS NULL OR p_fornitore_id = 0 OR o.fornitore_id = p_fornitore_id);


    SET @qry = CONCAT(
        'SELECT JSON_ARRAYAGG(row_json) AS data ',
        'FROM (',
            'SELECT JSON_OBJECT(',
                '\"id_ordine\",   id_ordine,',
                '\"num_ordine\",  num_ordine,',
                '\"data_ordine\", DATE_FORMAT(data_ordine, \"%Y-%m-%d\"),',
                '\"fornitore_id\",fornitore_id,',
                '\"stato\",       stato,',
                '\"note\",        IFNULL(note, \"\")',
            ') AS row_json ',
            'FROM ordini ',
            'WHERE 1 = 1 ',
                IF(p_num_ordine   IS NULL OR p_num_ordine   = '', '', CONCAT('AND num_ordine   LIKE \"%', p_num_ordine,   '%\" ')),
                IF(p_fornitore_id IS NULL OR p_fornitore_id = 0, '', CONCAT('AND fornitore_id = ', p_fornitore_id, ' ')),
            'ORDER BY ', p_order_by, ' ', p_order_dir, ' ',
            'LIMIT ', p_page_size, ' OFFSET ', v_offset,
        ') AS sub'
    );

    PREPARE stmt FROM @qry;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;


    SELECT JSON_OBJECT(
        'status',    'success',
        'totalRows', v_total,
        'page',      p_page,
        'pageSize',  p_page_size
    ) AS meta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FetchOrdini_righe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FetchOrdini_righe`(IN p_id_ordine INT, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4))
BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
  SELECT COUNT(*) INTO v_total FROM ordini_righe WHERE (p_id_ordine IS NULL OR id_ordine=p_id_ordine);
  SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id_riga",id_riga,"id_ordine",id_ordine,"nome_articolo",nome_articolo,"quantita",quantita,"prezzo_unitario",prezzo_unitario,"totale_righe",totale_righe)) AS data FROM ordini_righe WHERE 1=1',
                  IF(p_id_ordine IS NULL,'', CONCAT(' AND id_ordine=',p_id_ordine)),
                  ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END ;;
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
/*!50003 DROP PROCEDURE IF EXISTS `InsertArticoli` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertArticoli`(
    IN p_name          VARCHAR(100),
    IN p_description   VARCHAR(100),
    IN p_quantita      DECIMAL(12,2),
    IN p_min           DECIMAL(12,2),
    IN p_max           DECIMAL(12,2),
    IN p_supplier      VARCHAR(100),
    IN p_has_diba      ENUM('S','N'),
    IN p_um            VARCHAR(10),
    IN p_prezzo        DECIMAL(12,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento articolo') AS response; END;
    START TRANSACTION;
    -- Validation
    IF p_quantita IS NOT NULL AND p_quantita < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >= 0'; END IF;
    IF p_min IS NOT NULL AND p_min < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Min >= 0'; END IF;
    IF p_max IS NOT NULL AND p_max < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Max >= 0'; END IF;
    IF p_prezzo IS NOT NULL AND p_prezzo < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prezzo >= 0'; END IF;
    INSERT INTO articoli(name,description,quantita,`min`,`max`,supplier,has_diba,um,prezzo)
    VALUES(p_name,p_description,p_quantita,p_min,p_max,p_supplier,p_has_diba,p_um,p_prezzo);
    COMMIT;
    SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertCausali` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertCausali`(
    IN p_codice      VARCHAR(3),
    IN p_description VARCHAR(250),
    IN p_tipo        ENUM('C','S'),
    IN p_attiva      TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN ROLLBACK;
        SELECT JSON_OBJECT('status','error','message','Errore inserimento causale') AS response;
      END;

    START TRANSACTION;

    -- VALIDAZIONI
    IF p_codice IS NULL OR p_codice = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Codice obbligatorio';
    END IF;

    INSERT INTO causali (codice, description, tipo, attiva)
    VALUES (p_codice, p_description, p_tipo, IFNULL(p_attiva,1));

    COMMIT;
    SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertControparte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertControparte`(
    IN p_nome           VARCHAR(255),
    IN p_tipo           ENUM('CLIENTE','FORNITORE'),
    IN p_codice_fiscale VARCHAR(20),
    IN p_partita_iva    VARCHAR(20),
    IN p_indirizzo      VARCHAR(255),
    IN p_citta          VARCHAR(100),
    IN p_cap            VARCHAR(10),
    IN p_provincia      VARCHAR(2),
    IN p_nazione        VARCHAR(50),
    IN p_telefono       VARCHAR(20),
    IN p_email          VARCHAR(100),
    IN p_contatto       VARCHAR(100),
    IN p_note           TEXT
)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento controparte') AS response; END;
  START TRANSACTION;
  IF p_nome IS NULL OR p_nome='' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Nome obbligatorio'; END IF;
  IF p_tipo NOT IN ('CLIENTE','FORNITORE') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tipo non valido'; END IF;
  INSERT INTO controparti(nome,tipo,codice_fiscale,partita_iva,indirizzo,citta,cap,provincia,nazione,telefono,email,contatto,note)
    VALUES(p_nome,p_tipo,p_codice_fiscale,p_partita_iva,p_indirizzo,p_citta,p_cap,p_provincia,p_nazione,p_telefono,p_email,p_contatto,p_note);
  COMMIT;
  SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertDdt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDdt`(IN p_num_ddt VARCHAR(20), IN p_data_ddt DATE, IN p_cliente_id INT, IN p_stato ENUM('DA_SPEDIRE','SPEDITO','ANNULLATO'), IN p_note TEXT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento DDT') AS response; END;
    START TRANSACTION;
    IF NOT EXISTS (SELECT 1 FROM clienti WHERE id=p_cliente_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cliente non esiste'; END IF;
    INSERT INTO ddt(num_ddt,data_ddt,cliente_id,stato,note) VALUES(p_num_ddt,p_data_ddt,p_cliente_id,p_stato,p_note);
    COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertDdt_righe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDdt_righe`(IN p_id_ddt INT, IN p_cod_articolo VARCHAR(30), IN p_descrizione VARCHAR(255), IN p_qta DECIMAL(10,2))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento riga DDT') AS response; END;
    START TRANSACTION; IF p_qta<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
    IF NOT EXISTS (SELECT 1 FROM ddt WHERE id_ddt=p_id_ddt) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DDT non trovato'; END IF;
    INSERT INTO ddt_righe(id_ddt,cod_articolo,descrizione,qta) VALUES(p_id_ddt,p_cod_articolo,p_descrizione,p_qta);
    COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertDiba` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDiba`(IN p_id_father INT, IN p_id_son INT, IN p_quantita DECIMAL(10,2))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento DIBA') AS response; END;
  START TRANSACTION; IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id_father) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo padre non esiste'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id_son) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo figlio non esiste'; END IF;
  INSERT INTO diba(id_father,id_son,quantita) VALUES(p_id_father,p_id_son,p_quantita); COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertFornitori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertFornitori`(
    IN p_codice VARCHAR(10), IN p_rag_soc VARCHAR(255), IN p_partita_iva VARCHAR(20), IN p_cf VARCHAR(20),
    IN p_indirizzo VARCHAR(255), IN p_citta VARCHAR(100), IN p_cap VARCHAR(10), IN p_pv VARCHAR(2), IN p_nazione VARCHAR(50),
    IN p_telefono VARCHAR(20), IN p_email VARCHAR(100), IN p_sito_web VARCHAR(100), IN p_note TEXT, IN p_contatto VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento fornitore') AS response; END;
    START TRANSACTION;
    IF p_codice IS NULL OR p_codice='' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Codice fornitore obbligatorio'; END IF;
    INSERT INTO fornitori(codice,rag_soc,partita_iva,cf,indirizzo,citta,cap,pv,nazione,telefono,email,sito_web,note,contatto)
    VALUES(p_codice,p_rag_soc,p_partita_iva,p_cf,p_indirizzo,p_citta,p_cap,p_pv,p_nazione,p_telefono,p_email,p_sito_web,p_note,p_contatto);
    COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertLogin`(IN p_user VARCHAR(100), IN p_pwd VARCHAR(60), IN p_role VARCHAR(10))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento login') AS response; END;
    START TRANSACTION; IF EXISTS (SELECT 1 FROM login WHERE user=p_user) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Utente già esistente'; END IF;
    INSERT INTO login(`user`,pwd,role) VALUES(p_user,p_pwd,p_role); COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertMovimenti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertMovimenti`(IN p_data DATE, IN p_tipo ENUM('C','S'), IN p_description VARCHAR(255), IN p_quantita DECIMAL(12,2), IN p_codice_cau VARCHAR(3), IN p_idart INT, IN p_note TEXT, IN p_user VARCHAR(100), IN p_um VARCHAR(10))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento movimento') AS response; END;
  START TRANSACTION; IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM causali WHERE codice=p_codice_cau) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Causale inesistente'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_idart) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo inesistente'; END IF;
  INSERT INTO movimenti(`data`,tipo,description,quantita,codice_cau,idart,note,descriptioncau,descriptionart,`user`,`timestamp`,um)
      SELECT p_data,p_tipo,p_description,p_quantita,p_codice_cau,p_idart,p_note,description,name,p_user,NOW(),p_um
      FROM causali c, articoli a WHERE c.codice=p_codice_cau AND a.id=p_idart LIMIT 1;
  COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertOrdini`(IN p_num_ordine VARCHAR(20), IN p_data DATE, IN p_fornitore_id INT, IN p_stato ENUM('APERTO','INVIATO','CHIUSO','ANNULLATO'), IN p_note TEXT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento ordine') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM fornitori WHERE id=p_fornitore_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fornitore non esiste'; END IF;
    INSERT INTO ordini(num_ordine,data_ordine,fornitore_id,stato,note) VALUES(p_num_ordine,p_data,p_fornitore_id,p_stato,p_note); COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertOrdini_righe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertOrdini_righe`(IN p_id_ordine INT, IN p_descrizione VARCHAR(255), IN p_prezzo_unitario DECIMAL(10,2), IN p_nome_articolo VARCHAR(100), IN p_quantita DECIMAL(12,2))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento riga ordine') AS response; END;
  START TRANSACTION; IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF; IF p_prezzo_unitario<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prezzo_unitario >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM ordini WHERE id_ordine=p_id_ordine) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ordine non trovato'; END IF;
  INSERT INTO ordini_righe(id_ordine,descrizione,prezzo_unitario,nome_articolo,quantita) VALUES(p_id_ordine,p_descrizione,p_prezzo_unitario,p_nome_articolo,p_quantita);
  COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateArticoli` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateArticoli`(
    IN p_id INT,
    IN p_name          VARCHAR(100),
    IN p_description   VARCHAR(100),
    IN p_quantita      DECIMAL(12,2),
    IN p_min           DECIMAL(12,2),
    IN p_max           DECIMAL(12,2),
    IN p_supplier      VARCHAR(100),
    IN p_has_diba      ENUM('S','N'),
    IN p_um            VARCHAR(10),
    IN p_prezzo        DECIMAL(12,2)
)
BEGIN
    DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update articolo') AS response; END;
    START TRANSACTION;
    IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo non trovato'; END IF;
    -- Validations as Insert
    IF p_quantita IS NOT NULL AND p_quantita < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >= 0'; END IF;
    IF p_min IS NOT NULL AND p_min < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Min >= 0'; END IF;
    IF p_max IS NOT NULL AND p_max < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Max >= 0'; END IF;
    IF p_prezzo IS NOT NULL AND p_prezzo < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prezzo >= 0'; END IF;
    UPDATE articoli SET name=p_name,description=p_description,quantita=p_quantita,`min`=p_min,`max`=p_max,supplier=p_supplier,has_diba=p_has_diba,um=p_um,prezzo=p_prezzo WHERE id=p_id;
    SET v_rows=ROW_COUNT(); COMMIT;
    SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateCausali` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCausali`(
    IN p_id          INT,
    IN p_codice      VARCHAR(3),
    IN p_description VARCHAR(250),
    IN p_tipo        ENUM('C','S'),
    IN p_attiva      TINYINT
)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN ROLLBACK;
        SELECT JSON_OBJECT('status','error','message','Errore update causale') AS response; END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM causali WHERE id = p_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Causale non trovata';
    END IF;

    UPDATE causali
       SET codice      = p_codice,
           description = p_description,
           tipo        = p_tipo,
           attiva      = p_attiva
     WHERE id = p_id;

    SET v_rows = ROW_COUNT();
    COMMIT;
    SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateControparte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateControparte`(
    IN p_id             INT,
    IN p_nome           VARCHAR(255),
    IN p_tipo           ENUM('CLIENTE','FORNITORE'),
    IN p_codice_fiscale VARCHAR(20),
    IN p_partita_iva    VARCHAR(20),
    IN p_indirizzo      VARCHAR(255),
    IN p_citta          VARCHAR(100),
    IN p_cap            VARCHAR(10),
    IN p_provincia      VARCHAR(2),
    IN p_nazione        VARCHAR(50),
    IN p_telefono       VARCHAR(20),
    IN p_email          VARCHAR(100),
    IN p_contatto       VARCHAR(100),
    IN p_note           TEXT
)
BEGIN
  DECLARE v_rows INT DEFAULT 0;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update controparte') AS response; END;
  START TRANSACTION;
  IF NOT EXISTS (SELECT 1 FROM controparti WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Controparte non trovata'; END IF;
  IF p_tipo NOT IN ('CLIENTE','FORNITORE') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tipo non valido'; END IF;
  UPDATE controparti SET nome=p_nome,tipo=p_tipo,codice_fiscale=p_codice_fiscale,partita_iva=p_partita_iva,indirizzo=p_indirizzo,citta=p_citta,cap=p_cap,provincia=p_provincia,nazione=p_nazione,telefono=p_telefono,email=p_email,contatto=p_contatto,note=p_note
    WHERE id=p_id;
  SET v_rows=ROW_COUNT();
  COMMIT;
  SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateDdt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDdt`(IN p_id_ddt INT, IN p_num_ddt VARCHAR(20), IN p_data_ddt DATE, IN p_cliente_id INT, IN p_stato ENUM('DA_SPEDIRE','SPEDITO','ANNULLATO'), IN p_note TEXT)
BEGIN
    DECLARE v_rows INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update DDT') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM ddt WHERE id_ddt=p_id_ddt) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DDT non trovato'; END IF;
    IF NOT EXISTS (SELECT 1 FROM clienti WHERE id=p_cliente_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cliente non esiste'; END IF;
    UPDATE ddt SET num_ddt=p_num_ddt,data_ddt=p_data_ddt,cliente_id=p_cliente_id,stato=p_stato,note=p_note WHERE id_ddt=p_id_ddt;
    SET v_rows=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateDdt_righe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDdt_righe`(IN p_id_riga INT, IN p_id_ddt INT, IN p_cod_articolo VARCHAR(30), IN p_descrizione VARCHAR(255), IN p_qta DECIMAL(10,2))
BEGIN
    DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update riga DDT') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM ddt_righe WHERE id_riga=p_id_riga) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Riga non trovata'; END IF;
    IF NOT EXISTS (SELECT 1 FROM ddt WHERE id_ddt=p_id_ddt) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DDT non trovato'; END IF;
    IF p_qta<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
    UPDATE ddt_righe SET id_ddt=p_id_ddt,cod_articolo=p_cod_articolo,descrizione=p_descrizione,qta=p_qta WHERE id_riga=p_id_riga;
    SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDiba`(IN p_id INT, IN p_id_father INT, IN p_id_son INT, IN p_quantita DECIMAL(10,2))
BEGIN
  DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update DIBA') AS response; END;
  START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM diba WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Record DIBA non trovato'; END IF;
  IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id_father) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo padre non esiste'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id_son) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo figlio non esiste'; END IF;
  UPDATE diba SET id_father=p_id_father,id_son=p_id_son,quantita=p_quantita WHERE id=p_id; SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateFornitori` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateFornitori`(
    IN p_id INT, IN p_codice VARCHAR(10), IN p_rag_soc VARCHAR(255), IN p_partita_iva VARCHAR(20), IN p_cf VARCHAR(20),
    IN p_indirizzo VARCHAR(255), IN p_citta VARCHAR(100), IN p_cap VARCHAR(10), IN p_pv VARCHAR(2), IN p_nazione VARCHAR(50),
    IN p_telefono VARCHAR(20), IN p_email VARCHAR(100), IN p_sito_web VARCHAR(100), IN p_note TEXT, IN p_contatto VARCHAR(100)
)
BEGIN
    DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update fornitore') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM fornitori WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fornitore non trovato'; END IF;
    UPDATE fornitori SET codice=p_codice, rag_soc=p_rag_soc, partita_iva=p_partita_iva, cf=p_cf, indirizzo=p_indirizzo, citta=p_citta, cap=p_cap, pv=p_pv, nazione=p_nazione,
         telefono=p_telefono, email=p_email, sito_web=p_sito_web, note=p_note, contatto=p_contatto WHERE id=p_id;
    SET v_rows=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateLogin`(IN p_id INT, IN p_pwd VARCHAR(60), IN p_role VARCHAR(10))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update login') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM login WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Login non trovato'; END IF;
    UPDATE login SET pwd=p_pwd, role=p_role WHERE id=p_id; COMMIT; SELECT JSON_OBJECT('status','success','message','Login aggiornato') AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateMovimenti` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMovimenti`(IN p_id INT, IN p_data DATE, IN p_tipo ENUM('C','S'), IN p_description VARCHAR(255), IN p_quantita DECIMAL(12,2), IN p_codice_cau VARCHAR(3), IN p_idart INT, IN p_note TEXT, IN p_user VARCHAR(100), IN p_um VARCHAR(10))
BEGIN
  DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update movimento') AS response; END;
  START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM movimenti WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Movimento non trovato'; END IF;
  IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM causali WHERE codice=p_codice_cau) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Causale inesistente'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_idart) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo inesistente'; END IF;
  UPDATE movimenti SET `data`=p_data,tipo=p_tipo,description=p_description,quantita=p_quantita,codice_cau=p_codice_cau,idart=p_idart,note=p_note,`user`=p_user,um=p_um WHERE id=p_id; SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateOrdini` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrdini`(IN p_id INT, IN p_num_ordine VARCHAR(20), IN p_data DATE, IN p_fornitore_id INT, IN p_stato ENUM('APERTO','INVIATO','CHIUSO','ANNULLATO'), IN p_note TEXT)
BEGIN
  DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update ordine') AS response; END;
  START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM ordini WHERE id_ordine=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ordine non trovato'; END IF;
  IF NOT EXISTS (SELECT 1 FROM fornitori WHERE id=p_fornitore_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fornitore non esiste'; END IF;
  UPDATE ordini SET num_ordine=p_num_ordine,data_ordine=p_data,fornitore_id=p_fornitore_id,stato=p_stato,note=p_note WHERE id_ordine=p_id; SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateOrdini_righe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrdini_righe`(IN p_id_riga INT, IN p_id_ordine INT, IN p_descrizione VARCHAR(255), IN p_prezzo_unitario DECIMAL(10,2), IN p_nome_articolo VARCHAR(100), IN p_quantita DECIMAL(12,2))
BEGIN
  DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update riga ordine') AS response; END;
  START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM ordini_righe WHERE id_riga=p_id_riga) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Riga non trovata'; END IF;
  IF NOT EXISTS (SELECT 1 FROM ordini WHERE id_ordine=p_id_ordine) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ordine non trovato'; END IF;
  IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF; IF p_prezzo_unitario<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prezzo_unitario >0'; END IF;
  UPDATE ordini_righe SET id_ordine=p_id_ordine,descrizione=p_descrizione,prezzo_unitario=p_prezzo_unitario,nome_articolo=p_nome_articolo,quantita=p_quantita WHERE id_riga=p_id_riga;
  SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
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

-- Dump completed on 2025-07-14 17:07:36

-- MariaDB dump 10.18  Distrib 10.4.17-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: etr
-- ------------------------------------------------------
-- Server version	10.4.17-MariaDB

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
-- Table structure for table `epulet`
--

DROP TABLE IF EXISTS `epulet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epulet` (
  `nev` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `varos` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `utca` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`nev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epulet`
--

LOCK TABLES `epulet` WRITE;
/*!40000 ALTER TABLE `epulet` DISABLE KEYS */;
INSERT INTO `epulet` VALUES ('A épület','Kecskemét','Jó utca 5'),('AIO','Szeged','Kossuth L utca 8'),('Bolyai','Szeged','Aradi Vértanúk tere 10'),('Dóm tér 10','Szeged','Dóm Tér 10'),('Irinyi','Szeged','Aradi Vértanuk tere 1'),('TIK','Szeged','Szikra utca 8');
/*!40000 ALTER TABLE `epulet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hallgato`
--

DROP TABLE IF EXISTS `hallgato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hallgato` (
  `kod` varchar(100) NOT NULL,
  `vezeteknev` varchar(255) DEFAULT NULL,
  `keresztnev` varchar(255) DEFAULT NULL,
  `szak` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`kod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hallgato`
--

LOCK TABLES `hallgato` WRITE;
/*!40000 ALTER TABLE `hallgato` DISABLE KEYS */;
INSERT INTO `hallgato` VALUES ('AR4835','Antal','Rudolf','GTK'),('BB4214','Barta','Béla','ÁOK'),('BD4634','Barta','Diána','GTK'),('FF4919','Fodor','Fanni','GTK'),('FH4156','Fodor','Henrik','TTIK'),('FK4133','Fodor','Kornél','TTIK'),('GF4839','Gál','Fanni','TTIK'),('GG4958','Gulyás','Gergely','TTIK'),('GM4482','Gál','Mónika','TTIK'),('GR4973','Gulyás','Rudolf','ÁOK'),('HD4852','Hegedűs','Dóra','TTIK'),('HR4116','Hegedűs','Rudolf','TTIK'),('KM4231','Kis','Mónika','TTIK'),('N?4126','Nagy','Ádám','ÁOK'),('OB4660','Orosz','Béla','BTK'),('OF4289','Orosz','Ferenc','BTK'),('OF4988','Orosz','Fanni','GTK'),('PA436','Pásztor','Anita','BTK'),('PD4497','Pásztor','Diána','ÁOK'),('PG4487','Pap','Gergely','ÁOK'),('PH4598','Pék','Henrik','BTK'),('PK4415','Pék','Katalin','TTIK'),('PR4535','Pásztor','Réka','ÁOK'),('SB4203','Somogyi','Botond','TTIK'),('SH4203','Szikla','Henrik','TTIK'),('SZ4686','Somogyi','Zoltán','GTK');
/*!40000 ALTER TABLE `hallgato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kurzus`
--

DROP TABLE IF EXISTS `kurzus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kurzus` (
  `nev` varchar(50) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `idopont` date DEFAULT NULL,
  `kod` varchar(10) COLLATE utf8_hungarian_ci NOT NULL,
  PRIMARY KEY (`kod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kurzus`
--

LOCK TABLES `kurzus` WRITE;
/*!40000 ALTER TABLE `kurzus` DISABLE KEYS */;
INSERT INTO `kurzus` VALUES ('Anatómia','2022-11-24','AN'),('Gyógyerek','2022-11-21','GYOGY'),('Programozás I','2022-11-21','P1'),('Progalap','2022-11-22','PA'),('Pénzügyek II','2022-11-24','PNZ2'),('Webtervezés','2022-11-19','WEB');
/*!40000 ALTER TABLE `kurzus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oktat`
--

DROP TABLE IF EXISTS `oktat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oktat` (
  `oktato_kod` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `kurzus_kod` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oktat`
--

LOCK TABLES `oktat` WRITE;
/*!40000 ALTER TABLE `oktat` DISABLE KEYS */;
INSERT INTO `oktat` VALUES ('AD4976','AN'),('FA4383','P1'),('HR4927','P1');
/*!40000 ALTER TABLE `oktat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oktato`
--

DROP TABLE IF EXISTS `oktato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oktato` (
  `kod` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `vezeteknev` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `keresztnev` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `szak` varchar(10) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `kezdesEve` year(4) DEFAULT NULL,
  PRIMARY KEY (`kod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oktato`
--

LOCK TABLES `oktato` WRITE;
/*!40000 ALTER TABLE `oktato` DISABLE KEYS */;
INSERT INTO `oktato` VALUES ('AD4976','Antal','Diána','BTK',2013),('AH4307','Antal','Henrik','GTK',2008),('BF4990','Barta','Fanni','ÁOK',2014),('BR4177','Barta','Réka','BTK',1998),('CD4686','Csonka','Dalma','TTIK',1994),('CF426','Csonka','Fanni','TTIK',1998),('FA4353','Fodor','Anita','TTIK',1984),('FA4383','Fekete','Anita','TTIK',1980),('FD4925','Fodor','Dóra','ÁOK',2015),('GD4627','Gáspár','Diána','BTK',2021),('GD463','Gáspár','Dalma','GTK',2015),('GP4364','Gáspár','Panna','GTK',1984),('GR4319','Gáspár','Réka','GTK',2021),('GR4367','Gál','Réka','ÁOK',2003),('H?4556','Hegedűs','Ádám','ÁOK',2006),('HR4927','Hegedűs','Roland','BTK',2021),('KF4629','Kis','Fanni','TTIK',2013),('KJ4652','Kis','János','BTK',2020),('KR4831','Kis','Rudolf','BTK',1985),('OE4896','Oláh','Emese','GTK',2008),('P?4834','Pásztor','Ádám','ÁOK',1982),('PB424','Pék','Béla','ÁOK',1991),('PB497','Pék','Botond','TTIK',2012),('PG4751','Pásztor','Gergely','GTK',2018),('PR4558','Pap','Rudolf','BTK',2013),('SM4172','Szikla','Mónika','TTIK',1990),('SP4347','Somogyi','Panna','ÁOK',2004);
/*!40000 ALTER TABLE `oktato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resztvesz`
--

DROP TABLE IF EXISTS `resztvesz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resztvesz` (
  `hallgato_kod` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kurzus_kod` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resztvesz`
--

LOCK TABLES `resztvesz` WRITE;
/*!40000 ALTER TABLE `resztvesz` DISABLE KEYS */;
INSERT INTO `resztvesz` VALUES ('AR4835','P1'),('GR4973','P1'),('PG4487','P1'),('SZ4686','AN'),('SH4203','AN');
/*!40000 ALTER TABLE `resztvesz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terem`
--

DROP TABLE IF EXISTS `terem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terem` (
  `nev` varchar(255) COLLATE utf8_hungarian_ci NOT NULL,
  `ferohely` int(11) DEFAULT NULL,
  `epuletnev` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`nev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terem`
--

LOCK TABLES `terem` WRITE;
/*!40000 ALTER TABLE `terem` DISABLE KEYS */;
INSERT INTO `terem` VALUES ('Bolyai János terem',30,'Bolyai'),('Boncterem 1',30,'AIO'),('Boncterem 2',15,'AIO'),('Gépterem I',30,'A épület'),('Irinyi-212',60,'Irinyi'),('Irinyi-222',18,'Irinyi'),('Labor 15',8,'AIO');
/*!40000 ALTER TABLE `terem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-25 23:00:12

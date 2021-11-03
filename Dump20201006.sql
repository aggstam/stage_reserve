CREATE DATABASE  IF NOT EXISTS `stagereserve` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `stagereserve`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: stagereserve
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `attendee`
--

DROP TABLE IF EXISTS `attendee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int NOT NULL,
  `user_id` int NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfa807y3m9ak91ufnowldj36u4` (`reservation_id`),
  KEY `FKo5adpi1kuc9s6l1p20acd22vi` (`user_id`),
  CONSTRAINT `FKfa807y3m9ak91ufnowldj36u4` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `FKo5adpi1kuc9s6l1p20acd22vi` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendee`
--

LOCK TABLES `attendee` WRITE;
/*!40000 ALTER TABLE `attendee` DISABLE KEYS */;
INSERT INTO `attendee` VALUES (6,6,4,'2020-10-20 09:49:00.000000'),(7,9,4,'2020-10-20 09:49:00.000000'),(9,6,2,'2020-09-21 12:47:40.698000');
/*!40000 ALTER TABLE `attendee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reserveFrom` datetime(6) NOT NULL,
  `reserveTo` datetime(6) NOT NULL,
  `createdBy_id` int NOT NULL,
  `stage_id` int NOT NULL,
  `event` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKglyl2ak5yon0p3g4n3jrges3w` (`createdBy_id`),
  KEY `FKl2vjtrlgbdqm3c1mhrgt7bjhw` (`stage_id`),
  CONSTRAINT `FKglyl2ak5yon0p3g4n3jrges3w` FOREIGN KEY (`createdBy_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKl2vjtrlgbdqm3c1mhrgt7bjhw` FOREIGN KEY (`stage_id`) REFERENCES `stage` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (4,'2020-09-09 09:49:00.000000','2020-09-20 09:49:00.000000',2,2,'Event evv'),(6,'2020-09-10 20:00:00.000000','2020-09-24 23:00:00.000000',2,1,'Event ee'),(9,'2020-10-20 12:32:00.000000','2020-10-21 11:00:00.000000',2,1,'Test eevv'),(14,'2020-10-28 16:00:00.000000','2020-10-29 16:00:00.000000',8,1,'Test event'),(15,'2020-12-30 16:00:00.000000','2020-12-31 16:00:00.000000',8,1,'efdasdassd'),(16,'2020-10-27 16:00:00.000000','2020-10-28 16:00:00.000000',8,2,'dsfafasfsada'),(17,'2020-10-29 16:00:00.000000','2020-10-30 16:00:00.000000',8,2,'Test event'),(18,'2020-11-07 16:00:00.000000','2020-11-08 16:00:00.000000',8,2,'dsfafasfsadaasda'),(19,'2020-12-14 17:00:00.000000','2020-12-15 17:00:00.000000',8,2,'dsfafasfsada'),(20,'2021-01-05 17:00:00.000000','2021-01-06 17:00:00.000000',8,2,'Test event'),(21,'2021-03-30 17:00:00.000000','2021-03-31 17:00:00.000000',8,2,'Test event'),(22,'2020-10-21 21:00:00.000000','2020-10-29 21:00:00.000000',9,3,'perry paul n Greg'),(23,'2020-11-03 21:00:00.000000','2020-11-10 21:00:00.000000',9,3,'ghthe'),(24,'2020-11-16 21:00:00.000000','2020-11-17 21:00:00.000000',9,1,'perry paul n Greg');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stage`
--

DROP TABLE IF EXISTS `stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `capacity` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stage`
--

LOCK TABLES `stage` WRITE;
/*!40000 ALTER TABLE `stage` DISABLE KEYS */;
INSERT INTO `stage` VALUES (1,300,'basement.jpg','The basement','The basement description',1),(2,1000,'Triangles.jpg','Trianges','Triangles description',1),(3,600,'backyard.jpg','The backyard','The backyard description',1);
/*!40000 ALTER TABLE `stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `management` tinyint(1) NOT NULL DEFAULT '0',
  `users` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `surname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_e6gkqunxajvyxl5uctpl2vl2p` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'12345678',1,1,'aggelos@cc','/resources/images/users/2\\auctioneer_logo.jpg','aggelossd','6999999999','testttttt'),(4,'12345678',0,1,'sdads@sdas','/resources/images/users/4\\University-of-Piraeus-Logo.png','sasaasd','6986666666','fdffdhgf'),(7,'12345678',0,0,'aggelosstam13@gmail.com','https://lh4.googleusercontent.com/-IB40zddFYRI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuckN9iurgofJ5Yv74teF0lwgK2KNgw/photo.jpg','AGGELOS STAMATIOU','6999999999','Aggelos'),(8,NULL,0,0,'angelo.9513@gmail.com','https://lh3.googleusercontent.com/a-/AOh14GiWd5e3C3Gvh49lMQEik9LdrLMdLMlI4OxYNqVO','undefined',NULL,'undefined'),(9,'12345678',1,1,'goras.nik@gmail.com','https://lh3.googleusercontent.com/-lZOGio3VlB0/AAAAAAAAAAI/AAAAAAAAAAA/kFb6xRqJjHI/photo.jpg','Grigoris','6999999999','Goras'),(10,'1q2w3e4r5t',0,0,'meggie.dim@gmail.com','/resources/images/users/10\\home1.jpg','Megi ','6985029016','Dimo');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'stagereserve'
--

--
-- Dumping routines for database 'stagereserve'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-06 20:09:22

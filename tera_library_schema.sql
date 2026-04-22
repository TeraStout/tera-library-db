-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: tera_library
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `author_name` varchar(255) NOT NULL,
  PRIMARY KEY (`author_id`),
  UNIQUE KEY `idx_author_name` (`author_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Ilima Todd'),(7,'J. Scott Savage'),(18,'Jack Lyon'),(15,'Jason Mow'),(9,'K.M. Weiland'),(14,'Kenny Kemp'),(8,'Lois Lowry'),(3,'Markus Zusak'),(5,'Nancy Campbell Allen'),(16,'Neil K. Newell'),(10,'Tad Williams'),(20,'Wendie L. Edwards'),(17,'William J. Hamblin');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_authors`
--

DROP TABLE IF EXISTS `book_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_authors` (
  `book_isbn` varchar(13) NOT NULL,
  `author_id` int NOT NULL,
  `author_order` int DEFAULT NULL,
  PRIMARY KEY (`book_isbn`,`author_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `book_authors_ibfk_1` FOREIGN KEY (`book_isbn`) REFERENCES `books` (`isbn`) ON DELETE CASCADE,
  CONSTRAINT `book_authors_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_authors`
--

LOCK TABLES `book_authors` WRITE;
/*!40000 ALTER TABLE `book_authors` DISABLE KEYS */;
INSERT INTO `book_authors` VALUES ('9780375842207',3,1),('9780544340688',8,1),('9780756402709',10,1),('9780756404710',10,1),('9780756406417',10,1),('9780756406950',10,1),('9780971222854',20,1),('9780978924614',9,1),('9780990595304',15,1),('9781590388105',18,1),('9781599554969',14,1),('9781606418338',16,1),('9781606418338',17,2),('9781609073305',7,1),('9781609079246',1,1),('9781629721040',1,1),('9781629721750',5,1),('9781629727370',5,1);
/*!40000 ALTER TABLE `book_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_genres`
--

DROP TABLE IF EXISTS `book_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_genres` (
  `book_isbn` varchar(13) NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`book_isbn`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `book_genres_ibfk_1` FOREIGN KEY (`book_isbn`) REFERENCES `books` (`isbn`) ON DELETE CASCADE,
  CONSTRAINT `book_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_genres`
--

LOCK TABLES `book_genres` WRITE;
/*!40000 ALTER TABLE `book_genres` DISABLE KEYS */;
INSERT INTO `book_genres` VALUES ('9781609079246',1),('9781629721040',1),('9780375842207',2),('9780544340688',2),('9781609079246',2),('9781629721040',2),('9780544340688',3),('9781609079246',3),('9781629721040',3),('9780375842207',7),('9780978924614',7),('9780990595304',7),('9781599554969',7),('9781606418338',7),('9780375842207',9),('9781629721750',13),('9781629727370',13),('9781609073305',14),('9781629721750',14),('9781629727370',14),('9781590388105',15),('9781629721750',15),('9781629727370',15),('9781629721750',16),('9781629727370',16),('9781609073305',21),('9781609073305',22),('9780756402709',24),('9780756404710',24),('9780756406417',24),('9780756406950',24),('9781609073305',24),('9780544340688',27),('9780971222854',29),('9780978924614',29),('9780990595304',29),('9781590388105',29),('9781599554969',29),('9781606418338',29),('9780756402709',31),('9780756404710',31),('9780756406417',31),('9780756406950',31),('9780756402709',32),('9780756404710',32),('9780756406417',32),('9780756406950',32),('9781590388105',49),('9780971222854',52),('9780971222854',53);
/*!40000 ALTER TABLE `book_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `isbn` varchar(13) NOT NULL,
  `title` varchar(500) NOT NULL,
  `book_type` enum('hardback','paperback') NOT NULL,
  `publisher_id` int NOT NULL,
  `publication_year` year DEFAULT NULL,
  `series_id` int DEFAULT NULL,
  `series_number` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`isbn`),
  KEY `publisher_id` (`publisher_id`),
  KEY `idx_title` (`title`),
  KEY `series_id` (`series_id`),
  CONSTRAINT `books_ibfk_3` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`),
  CONSTRAINT `books_ibfk_4` FOREIGN KEY (`series_id`) REFERENCES `series` (`series_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES ('9780375842207','The Book Thief','paperback',3,2007,NULL,NULL,'2026-01-10 22:12:25'),('9780544340688','The Giver','paperback',8,1998,6,1,'2026-01-11 19:27:46'),('9780756402709','Shadowmarch','paperback',10,2005,8,1,'2026-01-11 19:57:42'),('9780756404710','Shadowplay','paperback',10,2008,8,2,'2026-01-11 20:00:00'),('9780756406417','Shadowrise','paperback',10,2010,8,3,'2026-01-11 20:07:10'),('9780756406950','Shadowheart','paperback',10,2011,8,4,'2026-01-11 20:09:18'),('9780971222854','Hidden Light','paperback',18,2007,16,1,'2026-01-12 00:44:12'),('9780978924614','Behold the Dawn','paperback',9,2009,NULL,NULL,'2026-01-11 19:37:02'),('9780990595304','Moroni & the Battle for Manti','paperback',15,2016,13,1,'2026-01-11 23:37:46'),('9781590388105','The Moroni Code','paperback',16,2007,NULL,NULL,'2026-01-12 00:30:15'),('9781599554969','The Wise Man Returns','paperback',14,2011,NULL,NULL,'2026-01-11 20:33:26'),('9781606418338','The Book of Malchus','paperback',16,2010,NULL,NULL,'2026-01-12 00:05:28'),('9781609073305','Water Keep','paperback',1,2013,5,1,'2026-01-11 19:21:06'),('9781609079246','Remake','hardback',1,2014,1,1,'2026-01-10 21:54:32'),('9781629721040','Resist','hardback',1,2016,1,2,'2026-01-10 21:59:46'),('9781629721750','Beauty and the Clockwork Beast','paperback',1,2016,3,1,'2026-01-10 22:23:46'),('9781629727370','Brass Carriages and Glass Hearts','paperback',1,2020,3,4,'2026-01-10 22:26:00');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(100) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE KEY `idx_genre_name` (`genre_name`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (24,'Action and Adventure'),(53,'Apocalyptic Fiction'),(9,'Bildungsroman'),(21,'Children'),(27,'Classic Literature'),(3,'Dystopian'),(31,'Epic Fantasy'),(14,'Fantasy'),(49,'Fiction'),(7,'Historical Fiction'),(22,'Middle Reader'),(15,'Mystery'),(32,'Paranormal Fantasy'),(29,'Religious Fiction'),(16,'Romance'),(1,'Science Fiction'),(13,'Steampunk Fiction'),(52,'Thriller'),(2,'Young Adult');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishers` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(255) NOT NULL,
  PRIMARY KEY (`publisher_id`),
  UNIQUE KEY `idx_publisher_name` (`publisher_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
INSERT INTO `publishers` VALUES (3,'Alfred A. Knopf'),(10,'Daw Books'),(16,'Deseret Book'),(15,'Ethos Productions'),(8,'Houghton Mifflin Harcourt'),(9,'PenForASword'),(18,'Seventh Seal Publishing'),(1,'Shadow Mountain'),(14,'Sweetwater Books');
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reading_log`
--

DROP TABLE IF EXISTS `reading_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reading_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `book_isbn` varchar(13) NOT NULL,
  `date_started` date DEFAULT NULL,
  `date_finished` date DEFAULT NULL,
  `rating` tinyint DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `book_isbn` (`book_isbn`),
  CONSTRAINT `reading_log_ibfk_1` FOREIGN KEY (`book_isbn`) REFERENCES `books` (`isbn`) ON DELETE CASCADE,
  CONSTRAINT `reading_log_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reading_log`
--

LOCK TABLES `reading_log` WRITE;
/*!40000 ALTER TABLE `reading_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `reading_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `series`
--

DROP TABLE IF EXISTS `series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `series` (
  `series_id` int NOT NULL AUTO_INCREMENT,
  `series_name` varchar(255) NOT NULL,
  PRIMARY KEY (`series_id`),
  UNIQUE KEY `idx_series_name` (`series_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `series`
--

LOCK TABLES `series` WRITE;
/*!40000 ALTER TABLE `series` DISABLE KEYS */;
INSERT INTO `series` VALUES (7,''),(5,'Far World'),(16,'Millennial Glory'),(1,'Remake'),(8,'Shadowmarch'),(3,'Steampunk Proper Romance'),(6,'The Giver'),(13,'The War Chapters Series');
/*!40000 ALTER TABLE `series` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-21 20:36:39

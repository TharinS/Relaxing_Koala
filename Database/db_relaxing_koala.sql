-- MariaDB dump 10.19  Distrib 10.6.16-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: relaxing_koala
-- ------------------------------------------------------
-- Server version	10.6.16-MariaDB-0ubuntu0.22.04.1

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
-- Table structure for table `analytics`
--

DROP TABLE IF EXISTS `analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analytics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `food_item_id` int(11) NOT NULL,
  `counter` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `food_item_id` (`food_item_id`),
  CONSTRAINT `analytics_ibfk_1` FOREIGN KEY (`food_item_id`) REFERENCES `food_item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analytics`
--

LOCK TABLES `analytics` WRITE;
/*!40000 ALTER TABLE `analytics` DISABLE KEYS */;
INSERT INTO `analytics` VALUES (1,1,1299),(2,2,1106),(3,3,1131),(4,4,1839),(5,5,803),(6,6,996),(7,7,574),(8,8,880),(9,9,679),(10,10,1755),(11,11,1739),(12,12,1430),(13,13,1435),(14,14,885),(15,15,1122),(16,16,954),(17,17,906),(18,18,1167),(19,19,1116),(20,20,1582),(21,21,1060),(22,22,1556),(23,23,1099),(24,24,1827),(25,25,838),(26,26,1209),(27,27,1530),(28,28,527),(29,29,546),(30,30,648);
/*!40000 ALTER TABLE `analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  `delivery_time` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (1,'26 Glenferrie','Hawthorn','3122','2024-01-15 18:00:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(2,'26 Glenferrie','Hawthorn','3122','2024-02-02 19:30:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(3,'26 Glenferrie','Hawthorn','3122','2024-03-10 20:00:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(4,'26 Glenferrie','Hawthorn','3122','2024-04-05 12:00:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(5,'26 Glenferrie','Hawthorn','3122','2024-05-01 13:30:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(6,'26 Glenferrie','Hawthorn','3122','2024-06-18 18:45:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(7,'26 Glenferrie','Hawthorn','3122','2024-07-08 19:00:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(8,'26 Glenferrie','Hawthorn','3122','2024-08-14 20:30:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(9,'26 Glenferrie','Hawthorn','3122','2024-09-03 21:00:00','2024-05-25 01:58:37','2024-05-25 01:58:37'),(10,'26 Glenferrie','Hawthorn','3122','2024-10-10 19:15:00','2024-05-25 01:58:37','2024-05-25 01:58:37');
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_item`
--

DROP TABLE IF EXISTS `food_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `foodname` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `asset` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_item`
--

LOCK TABLES `food_item` WRITE;
/*!40000 ALTER TABLE `food_item` DISABLE KEYS */;
INSERT INTO `food_item` VALUES (1,'Chicken Teriyaki',12.50,'Grilled chicken with teriyaki sauce','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','1'),(2,'Sushi Roll',8.00,'Rice and fish rolled in seaweed','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','2'),(3,'Miso Soup',3.50,'Traditional Japanese soup with tofu and seaweed','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','3'),(4,'Pad Thai',10.00,'Stir-fried noodles with shrimp','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','4'),(5,'Spring Rolls',5.00,'Fried rolls filled with vegetables','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','5'),(6,'Dim Sum',15.00,'Steamed dumplings with various fillings','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','6'),(7,'Bibimbap',12.00,'Mixed rice with vegetables and beef','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','7'),(8,'Kimchi',4.00,'Fermented spicy cabbage','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','8'),(9,'Peking Duck',25.00,'Roast duck with crispy skin','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','9'),(10,'Tom Yum Soup',6.50,'Spicy Thai soup with shrimp','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','10'),(11,'Chicken Satay',9.00,'Grilled chicken skewers with peanut sauce','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','11'),(12,'Beef Bulgogi',13.00,'Marinated beef slices','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','12'),(13,'Fried Rice',8.50,'Stir-fried rice with vegetables and meat','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','13'),(14,'Tofu Stir-fry',9.00,'Stir-fried tofu with vegetables','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','14'),(15,'Ramen',11.00,'Japanese noodle soup','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','15'),(16,'Tempura',12.00,'Battered and fried seafood and vegetables','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','16'),(17,'Pho',10.00,'Vietnamese noodle soup with beef','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','17'),(18,'Gyoza',7.00,'Japanese dumplings','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','18'),(19,'Chicken Curry',14.00,'Spicy chicken curry with rice','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','19'),(20,'Green Curry',13.50,'Thai green curry with chicken','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','20'),(21,'Sashimi',18.00,'Sliced raw fish','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','21'),(22,'Yakitori',9.50,'Grilled chicken skewers','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','22'),(23,'Laksa',11.50,'Spicy noodle soup with coconut milk','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','23'),(24,'Mango Sticky Rice',6.50,'Sweet sticky rice with mango','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','24'),(25,'Hot and Sour Soup',5.50,'Spicy and tangy soup','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','25'),(26,'Lo Mein',9.00,'Stir-fried noodles with vegetables','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','26'),(27,'Mapo Tofu',10.00,'Spicy tofu with minced meat','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','27'),(28,'Prawn Crackers',4.50,'Crispy prawn-flavored snacks','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','28'),(29,'Szechuan Chicken',13.00,'Spicy chicken with Szechuan peppers','main dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','29'),(30,'Egg Drop Soup',4.00,'Chinese soup with beaten eggs','side dish',1,'2024-05-25 01:52:02','2024-05-25 01:52:02','30');
/*!40000 ALTER TABLE `food_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_number` int(11) DEFAULT NULL,
  `creator_id` int(11) NOT NULL,
  `creator_type` enum('employee','customer') NOT NULL,
  `order_time` datetime NOT NULL,
  `order_type` enum('dine-in','delivery') NOT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `delivery_id` (`delivery_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `food_item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `food_item_id` (`food_item_id`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`food_item_id`) REFERENCES `food_item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (21,1,1,2,20.00),(22,1,1,1,25.00),(23,2,2,1,45.00),(24,2,1,1,50.00),(25,3,3,1,25.00),(26,3,1,1,30.00),(27,4,4,1,30.00),(28,4,1,1,35.00),(29,5,5,1,35.00),(30,5,1,1,40.00),(31,6,6,1,50.00),(32,6,1,1,55.00),(33,7,7,1,55.00),(34,7,1,1,60.00),(35,8,8,1,40.00),(36,8,1,1,45.00),(37,9,9,1,45.00),(38,9,1,1,50.00),(39,10,10,1,60.00),(40,10,1,1,65.00),(41,11,1,1,12.50),(42,11,3,1,3.50),(43,12,2,1,13.00),(44,12,4,1,4.00),(45,13,5,1,10.00),(46,13,6,1,5.00),(47,14,7,1,14.00),(48,14,8,1,6.50),(49,15,9,1,15.00),(50,15,10,1,9.00),(51,16,11,1,11.00),(52,16,12,1,5.50),(53,17,13,1,13.50),(54,17,14,1,7.00),(55,18,15,1,12.00),(56,18,16,1,6.00),(57,19,17,1,10.00),(58,19,18,1,5.50),(59,20,19,1,14.50),(60,20,20,1,8.00),(61,21,21,1,12.00),(62,21,22,1,6.50),(63,22,23,1,13.50),(64,22,24,1,7.50),(65,23,25,1,15.00),(66,23,26,1,9.50),(67,24,27,1,11.50),(68,24,28,1,5.50),(69,25,29,1,14.00),(70,25,30,1,7.00),(71,26,1,1,12.00),(72,26,2,1,6.00),(73,27,3,1,11.00),(74,27,4,1,5.50),(75,28,5,1,15.00),(76,28,6,1,9.00),(77,29,7,1,13.50),(78,29,8,1,7.50),(79,30,9,1,14.50),(80,30,10,1,8.50);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_number` int(11) DEFAULT NULL,
  `creator_id` int(11) NOT NULL,
  `creator_type` enum('employee','customer') NOT NULL,
  `order_time` datetime NOT NULL,
  `order_type` enum('dine-in','delivery') NOT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `delivery_id` (`delivery_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,NULL,2,'customer','2023-01-15 18:00:00','delivery',1,45.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(2,NULL,2,'customer','2023-02-02 19:30:00','delivery',2,50.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(3,NULL,2,'customer','2023-03-10 20:00:00','delivery',3,30.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(4,NULL,2,'customer','2023-04-05 12:00:00','delivery',4,35.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(5,NULL,2,'customer','2023-05-01 13:30:00','delivery',5,40.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(6,NULL,2,'customer','2023-06-18 18:45:00','delivery',6,55.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(7,NULL,2,'customer','2023-07-08 19:00:00','delivery',7,60.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(8,NULL,2,'customer','2023-08-14 20:30:00','delivery',8,45.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(9,NULL,2,'customer','2023-09-03 21:00:00','delivery',9,50.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(10,NULL,2,'customer','2023-10-10 19:15:00','delivery',10,65.00,'2024-05-25 02:13:59','2024-05-25 02:13:59'),(11,1,1,'employee','2023-11-01 12:00:00','dine-in',NULL,16.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(12,2,1,'employee','2023-11-02 12:30:00','dine-in',NULL,17.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(13,3,1,'employee','2023-11-03 13:00:00','dine-in',NULL,15.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(14,4,1,'employee','2023-11-04 13:30:00','dine-in',NULL,20.50,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(15,5,1,'employee','2023-11-05 14:00:00','dine-in',NULL,24.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(16,6,1,'employee','2023-11-06 14:30:00','dine-in',NULL,16.50,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(17,7,1,'employee','2023-11-07 15:00:00','dine-in',NULL,20.50,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(18,8,1,'employee','2023-11-08 15:30:00','dine-in',NULL,18.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(19,9,1,'employee','2023-11-09 16:00:00','dine-in',NULL,15.50,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(20,10,1,'employee','2023-11-10 16:30:00','dine-in',NULL,22.50,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(21,11,1,'employee','2023-11-11 17:00:00','dine-in',NULL,18.50,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(22,12,1,'employee','2023-11-12 17:30:00','dine-in',NULL,21.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(23,13,1,'employee','2023-11-13 18:00:00','dine-in',NULL,24.50,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(24,14,1,'employee','2023-11-14 18:30:00','dine-in',NULL,17.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(25,15,1,'employee','2023-11-15 19:00:00','dine-in',NULL,21.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(26,16,1,'employee','2023-11-16 19:30:00','dine-in',NULL,18.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(27,17,1,'employee','2023-11-17 20:00:00','dine-in',NULL,16.50,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(28,18,1,'employee','2023-11-18 20:30:00','dine-in',NULL,24.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(29,19,1,'employee','2023-11-19 21:00:00','dine-in',NULL,21.00,'2024-05-25 02:14:03','2024-05-25 02:14:03'),(30,20,1,'employee','2023-11-20 21:30:00','dine-in',NULL,23.00,'2024-05-25 02:14:03','2024-05-25 02:14:03');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `reservation_time` datetime NOT NULL,
  `table_number` int(11) NOT NULL,
  `number_of_guests` int(11) DEFAULT 1,
  `special_requests` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,2,'2024-06-15 19:00:00',1,4,'Window seat, vegetarian options','2024-05-25 01:57:31','2024-05-25 01:57:31'),(2,2,'2024-07-04 12:30:00',3,2,'Quiet area, gluten-free','2024-05-25 01:57:31','2024-05-25 01:57:31'),(3,2,'2024-07-20 18:45:00',5,3,'Near the entrance, vegan options','2024-05-25 01:57:31','2024-05-25 01:57:31'),(4,2,'2024-08-10 20:00:00',2,5,'Away from kitchen, birthday celebration','2024-05-25 01:57:31','2024-05-25 01:57:31'),(5,2,'2024-09-05 13:00:00',4,2,'Near the garden, no special requests','2024-05-25 01:57:31','2024-05-25 01:57:31');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `transaction_type` enum('cash','card') NOT NULL,
  `transaction_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,2,1,'card','2023-01-15 07:05:00',45.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(2,2,2,'card','2023-02-02 08:35:00',50.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(3,2,3,'card','2023-03-10 09:05:00',30.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(4,2,4,'card','2023-04-05 02:05:00',35.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(5,2,5,'card','2023-05-01 03:35:00',40.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(6,2,6,'card','2023-06-18 08:50:00',55.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(7,2,7,'card','2023-07-08 09:05:00',60.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(8,2,8,'card','2023-08-14 10:35:00',45.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(9,2,9,'card','2023-09-03 11:05:00',50.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(10,2,10,'card','2023-10-10 08:20:00',65.00,'2024-05-25 02:16:33','2024-05-25 02:16:33'),(11,1,11,'cash','2023-11-01 01:05:00',16.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(12,1,12,'cash','2023-11-02 01:35:00',17.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(13,1,13,'card','2023-11-03 02:05:00',15.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(14,1,14,'card','2023-11-04 02:35:00',20.50,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(15,1,15,'card','2023-11-05 03:05:00',24.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(16,1,16,'card','2023-11-06 03:35:00',16.50,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(17,1,17,'card','2023-11-07 04:05:00',20.50,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(18,1,18,'card','2023-11-08 04:35:00',18.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(19,1,19,'card','2023-11-09 05:05:00',15.50,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(20,1,20,'card','2023-11-10 05:35:00',22.50,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(21,1,21,'card','2023-11-11 06:05:00',18.50,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(22,1,22,'card','2023-11-12 06:35:00',21.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(23,1,23,'card','2023-11-13 07:05:00',24.50,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(24,1,24,'card','2023-11-14 07:35:00',17.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(25,1,25,'card','2023-11-15 08:05:00',21.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(26,1,26,'card','2023-11-16 08:35:00',18.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(27,1,27,'card','2023-11-17 09:05:00',16.50,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(28,1,28,'card','2023-11-18 09:35:00',24.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(29,1,29,'card','2023-11-19 10:05:00',21.00,'2024-05-25 02:16:36','2024-05-25 02:16:36'),(30,1,30,'card','2023-11-20 10:35:00',23.00,'2024-05-25 02:16:36','2024-05-25 02:16:36');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `type` enum('employee','customer') NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'John','Doe','none','none','none','employee','root'),(2,'Jane','Doe','26 Glenferrie','Hawthorn','3122','customer','root');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-26 12:16:17

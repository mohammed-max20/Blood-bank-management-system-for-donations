-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bloodbankmanagementsystem
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `blood_car_req`
--

DROP TABLE IF EXISTS `blood_car_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_car_req` (
  `order_number` int NOT NULL AUTO_INCREMENT,
  `ID_number` int DEFAULT NULL,
  `full_name` varchar(100) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `age` int NOT NULL,
  `gender` varchar(10) NOT NULL,
  `blood_type` varchar(10) NOT NULL,
  `weight` float NOT NULL,
  `request_date` date NOT NULL,
  `request_day` varchar(10) GENERATED ALWAYS AS (dayname(`request_date`)) STORED,
  `request_time` time NOT NULL,
  `location` varchar(255) NOT NULL,
  `city_name` varchar(100) DEFAULT NULL,
  `neighborhood_name` varchar(100) DEFAULT NULL,
  `street_name` varchar(100) DEFAULT NULL,
  `address_description` text,
  `health_conditions` text,
  PRIMARY KEY (`order_number`),
  UNIQUE KEY `request_time` (`request_time`),
  UNIQUE KEY `unique_request_datetime` (`request_date`,`request_time`),
  UNIQUE KEY `ID_number` (`ID_number`),
  CONSTRAINT `blood_car_req_chk_1` CHECK ((`age` between 18 and 65)),
  CONSTRAINT `blood_car_req_chk_2` CHECK ((`weight` >= 50))
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_car_req`
--

LOCK TABLES `blood_car_req` WRITE;
/*!40000 ALTER TABLE `blood_car_req` DISABLE KEYS */;
INSERT INTO `blood_car_req` (`order_number`, `ID_number`, `full_name`, `contact_number`, `age`, `gender`, `blood_type`, `weight`, `request_date`, `request_time`, `location`, `city_name`, `neighborhood_name`, `street_name`, `address_description`, `health_conditions`) VALUES (16,1,'None None None','None',65,'None','None',70,'2024-04-18','10:00:00','24.7627776, 46.7304448','None','Mugharrzat','Balqees','','');
/*!40000 ALTER TABLE `blood_car_req` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_donation_questionnaire`
--

DROP TABLE IF EXISTS `blood_donation_questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_donation_questionnaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `id_number` varchar(10) NOT NULL,
  `blood_type` varchar(5) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `q1` varchar(10) NOT NULL,
  `q2` varchar(10) NOT NULL,
  `q3` varchar(10) NOT NULL,
  `q4` varchar(10) NOT NULL,
  `q5` varchar(10) NOT NULL,
  `q6` varchar(10) NOT NULL,
  `q7` varchar(10) NOT NULL,
  `q8` varchar(10) NOT NULL,
  `q9` varchar(10) NOT NULL,
  `q10` varchar(10) NOT NULL,
  `q11` varchar(10) NOT NULL,
  `q12` varchar(10) NOT NULL,
  `q13` varchar(10) NOT NULL,
  `q14` varchar(10) NOT NULL,
  `q15` varchar(10) NOT NULL,
  `q16` varchar(10) NOT NULL,
  `q17` varchar(10) NOT NULL,
  `q18` varchar(10) NOT NULL,
  `q19` varchar(10) NOT NULL,
  `q20` varchar(10) NOT NULL,
  `q21` varchar(10) NOT NULL,
  `q22` varchar(10) NOT NULL,
  `q23` varchar(10) NOT NULL,
  `q24` varchar(10) NOT NULL,
  `q25` varchar(10) NOT NULL,
  `q26` varchar(10) NOT NULL,
  `q27` varchar(10) NOT NULL,
  `q28` varchar(10) NOT NULL,
  `q29` varchar(10) NOT NULL,
  `q30` varchar(10) NOT NULL,
  `q31` varchar(10) NOT NULL,
  `q32` varchar(10) NOT NULL,
  `q33` varchar(10) NOT NULL,
  `q34` varchar(10) NOT NULL,
  `q35` varchar(10) NOT NULL,
  `q36` varchar(10) NOT NULL,
  `q37` varchar(10) NOT NULL,
  `q38` varchar(10) NOT NULL,
  `q39` varchar(10) NOT NULL,
  `q40` varchar(10) NOT NULL,
  `q41` varchar(10) NOT NULL,
  `q42` varchar(10) NOT NULL,
  `q43` varchar(10) NOT NULL,
  `q44` varchar(10) NOT NULL,
  `q45` varchar(10) NOT NULL,
  `q46` varchar(10) NOT NULL,
  `q47` varchar(10) NOT NULL,
  `q48` varchar(10) NOT NULL,
  `q49` varchar(10) NOT NULL,
  `q50` varchar(10) NOT NULL,
  `q51` varchar(10) NOT NULL,
  `q52` varchar(10) NOT NULL,
  `q53` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_donation_questionnaire`
--

LOCK TABLES `blood_donation_questionnaire` WRITE;
/*!40000 ALTER TABLE `blood_donation_questionnaire` DISABLE KEYS */;
INSERT INTO `blood_donation_questionnaire` VALUES (1,'Mohammed Alabdali','1111111111','B+','male','نعم','لا','لا','نعم','لا','لا','نعم','نعم','لا','لا','لا','لا','نعم','لا','لا','لا','لا','نعم','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','2024-03-26 20:38:31'),(6,'ggd','3123134323','A-','male','نعم','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','نعم','نعم','نعم','نعم','2024-03-27 18:25:59'),(4,'Mohammed Alabdali','1111111331','B+','male','لا','لا','لا','لا','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','2024-03-26 20:50:26'),(5,'ddddmmed Alabdali','5655454343','A-','female','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','نعم','نعم','نعم','لا','2024-03-27 07:02:08'),(7,'ggd','3123134323','B-','male','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','2024-04-02 12:57:54'),(8,'qwqw','7654323432','O+','male','لا','نعم','لا','لا','لا','لا','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','نعم','لا','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','لا','لا','نعم','2024-04-14 16:43:43'),(9,'dawd dwad dwad','1010101010','O+','male','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','2024-04-14 17:50:13'),(10,'None None None','1','None','','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','نعم','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','لا','2024-04-16 17:45:26');
/*!40000 ALTER TABLE `blood_donation_questionnaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blooddonorexperience`
--

DROP TABLE IF EXISTS `blooddonorexperience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blooddonorexperience` (
  `id` int NOT NULL AUTO_INCREMENT,
  `donor_name` varchar(100) NOT NULL,
  `experience` text NOT NULL,
  `submission_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blooddonorexperience`
--

LOCK TABLES `blooddonorexperience` WRITE;
/*!40000 ALTER TABLE `blooddonorexperience` DISABLE KEYS */;
INSERT INTO `blooddonorexperience` VALUES (2,'حمد','تجربتي كمتبرع بالدم:\r\n\r\nأردت دائمًا المساهمة في تحسين حياة الناس ومساعدتهم في الحالات الطارئة. لذلك، قررت التبرع بالدم للمرة الأولى اليوم.\r\n\r\nوجدت العملية سهلة وبسيطة جدًا. بمجرد وصولي إلى المستشفى، تم استقبالي بود ودفء كبيرين من قبل الموظفين. قاموا بإجراء فحص سريع للتأكد من أني جاهز للتبرع.\r\n\r\nبعد ذلك، تم توجيهي إلى غرفة التبرع حيث قمت بالجلوس على كرسي مريح وبدأت عملية التبرع. لم يكن هناك ألم ولم أشعر بأي شيء سوى شعور السعادة والرضا بالمساهمة في الحياة الإيجابية لشخص آخر.\r\n\r\nبمجرد الانتهاء، تم تقديم الماء والوجبات الخفيفة لي للتأكد من أني بخير. كانت تجربة التبرع بالدم ملهمة وأعتز بها كثيرًا. سأعود بالتأكيد للتبرع مرة أخرى في المستقبل.\r\n','2024-04-07 11:57:19'),(23,'max','test123','2024-04-07 14:38:14'),(24,'malek','123','2024-04-07 14:38:35'),(25,'ziad','test','2024-04-07 14:38:53'),(26,'dawd dwad dwad','يصشcdw','2024-04-14 17:35:26'),(27,'fahad maxx alfradiy','wdawdww','2024-04-16 17:26:17'),(28,'First2 Middle2 Last2','www','2024-04-23 07:03:23'),(22,'Khalid Almalki','Enjoy your blood donation: Always choose to improve people\'s lives and help them in emergency situations. That\'s why I decided to donate blood for the first time today. I found a very easy and simple way. As soon as I arrived at the hospital, I was greeted with great friendliness and warmth by the staff. For quick execution to see which ones are ready to donate. Next, I was directed to the donation room where I sat in a comfortable chair and began the donation process. There was no pain and he felt nothing but a little happiness and satisfaction in contributing to a recent positive life. Once finished, light and meals were served to make sure I was okay. The blood donation experience was epic and something I cherish very much. I will definitely be back to donate again in the future.','2024-04-07 14:35:33');
/*!40000 ALTER TABLE `blooddonorexperience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donation`
--

DROP TABLE IF EXISTS `donation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donation` (
  `Donation_ID` int NOT NULL AUTO_INCREMENT,
  `id_number` int DEFAULT NULL,
  `Donor_name` varchar(50) DEFAULT NULL,
  `Donor_phone` int DEFAULT NULL,
  `Blood_type` char(3) DEFAULT NULL,
  `Hospital_name` char(50) DEFAULT NULL,
  PRIMARY KEY (`Donation_ID`),
  UNIQUE KEY `Donation_ID` (`Donation_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation`
--

LOCK TABLES `donation` WRITE;
/*!40000 ALTER TABLE `donation` DISABLE KEYS */;
/*!40000 ALTER TABLE `donation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donor`
--

DROP TABLE IF EXISTS `donor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donor` (
  `ID_number` int NOT NULL,
  `F_name` varchar(50) DEFAULT NULL,
  `M_name` varchar(50) DEFAULT NULL,
  `L_name` varchar(50) DEFAULT NULL,
  `Neighborhood` varchar(30) DEFAULT NULL,
  `city` char(30) DEFAULT NULL,
  `street` char(30) DEFAULT NULL,
  `Hospital_name` char(30) DEFAULT NULL,
  `phone_number` int DEFAULT NULL,
  `Gender` char(5) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Blood_type` char(3) DEFAULT NULL,
  `Birth_date` date DEFAULT NULL,
  `appointment_datetime` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donor`
--

LOCK TABLES `donor` WRITE;
/*!40000 ALTER TABLE `donor` DISABLE KEYS */;
INSERT INTO `donor` VALUES (1332343424,'awawda','dawda','awdaw','awdwad','Riyadh','wadwad','National Guard Hospital',532470793,'male','al.adddalimu@gmail.com','O+','0000-00-00','2024-05-21 12:10:00',1),(1312313231,'Mohammed','dw','Alabdali','dw','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','maxdder_15@hotmail.com','A+','2004-02-03','2024-05-10 04:45:00',1),(1947284938,'Mohammed','dwa','Alabdali','d','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','ddwad@hotmail.com','A+','1994-02-01','2024-04-09 07:20:00',1),(1234567456,'Mohammed','sef','Alabdali','www','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','maxdder_15@hotmail.com','A+','1991-01-29','2024-04-16 06:44:00',1),(1111111116,'Mohammed','d','Alabdali','ds','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','al.abdalimu@gmail.com','A+','1992-03-04','2024-04-17 18:19:00',0),(44444444,'Mohammed','ب','Alabdali','d','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','al.abdalimu@gmail.com','A+','2024-04-25','2024-04-07 15:15:00',0),(5434,'Mohammed','sef','Alabdali','cssccs','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Male','al.assabdalimu@gmail.com','B-','2018-06-12','2024-04-05 08:21:00',1),(77,'Mohammed','d','Alabdali','dwwd','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','al.abdalimu@gmail.com','A+','2000-07-05','2024-04-08 08:45:00',1),(5,'Mohammed','ب','Alabdali','dwwd','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','al.abdalimu@gmail.com','A+','1992-07-08','2024-03-25 08:50:00',0),(3,'Mohammed','ww','Alabdali','ن','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','al.abdalimu@gmail.com','A+','2002-02-27','2024-04-07 10:54:00',0),(0,'Mohammed','wwqqqqqqqqqqqqqq','Alabdali','dwwdqqqqqq','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470793,'Femal','al.abdalimu@gmail.com','A+','1998-02-03','2024-04-27 05:50:00',1),(2,'First2','Middle2','Last2','fesf','Riyadh','Almughr','National Guard Hospital',987654321,'Femal','user2@example.com','B+','0000-00-00','2024-04-25 11:46:00',1),(2020202020,'dawd','dwd','dawd','dwd','Riyadh','Almughrizat, Al Mughrizat','National Guard Hospital',532470794,'Femal','al.adddddbdalimu@gmail.com','A+','0000-00-00','2024-04-18 10:08:00',1),(1,'None','None','None','dsd','None','dccc','National Guard Hospital',0,'None','None','Non','0000-00-00','2024-04-23 07:38:00',1),(1345453545,'efsefe','esfesf','esfes','awdawd','Riyadh','awdawdawd','National Guard Hospital',500414640,'male','al.abdalimu@gmail.com','A+','0000-00-00','2024-05-16 12:08:00',1);
/*!40000 ALTER TABLE `donor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financial_reward`
--

DROP TABLE IF EXISTS `financial_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_reward` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) DEFAULT NULL,
  `phone_number` int DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_reward`
--

LOCK TABLES `financial_reward` WRITE;
/*!40000 ALTER TABLE `financial_reward` DISABLE KEYS */;
INSERT INTO `financial_reward` VALUES (1,'fahad Alabdali',532470111,'1q1qdalimu@gmail.com'),(2,'Mohammed Alabdali',532470793,'al.abdalimu@gmail.com'),(3,'Mohasmed Alabdali',532170793,'al.qalimu@gmail.com'),(4,'hamad Alabdali',532410793,'qq11dalimu@gmail.com'),(5,'mod Alabdali',532470712,'1qqabdalimu@gmail.com'),(6,'qed Alabdali',532472393,'ssslimu@gmail.com'),(7,'lodd Alabdali',532310193,'al.asssssu@gmail.com'),(8,'Mohammed Alabdali',532470793,'al.abdalimu@gmail.com'),(9,'Mohammed Alabdali',532470793,'al.abdalimu@gmail.com'),(10,'sd',2147483647,'al.abdalimu@gmail.com'),(11,'Mohammed Alabdali',532470793,'maxdder_15@hotmail.com'),(12,'Mohammed Alabdali',532470793,'falimu@gmail.com'),(13,'Mohammed Alabdali',532470793,'222@hotmail.com'),(14,'dwwdwadawaf',532470793,'dwad@hotmail.com');
/*!40000 ALTER TABLE `financial_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital` (
  `Hospital_ID` int NOT NULL,
  `Hos_Name` varchar(50) DEFAULT NULL,
  `Phone` int DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Hospital_ID`),
  UNIQUE KEY `Hospital_ID` (`Hospital_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `ID_number` int NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Password` char(50) DEFAULT NULL,
  PRIMARY KEY (`ID_number`),
  UNIQUE KEY `ID_number` (`ID_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `ID_number` int NOT NULL,
  `F_name` varchar(50) DEFAULT NULL,
  `M_name` varchar(50) DEFAULT NULL,
  `L_name` varchar(50) DEFAULT NULL,
  `Neighborhood` varchar(50) DEFAULT NULL,
  `city` char(30) DEFAULT NULL,
  `street` char(30) DEFAULT NULL,
  `Hospital_name` varchar(50) DEFAULT NULL,
  `phone_number` int DEFAULT NULL,
  `Gender` char(7) DEFAULT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `Blood_type` char(3) DEFAULT NULL,
  `Birth_date` date DEFAULT NULL,
  `Notes` varchar(500) DEFAULT NULL,
  `appointment_datetime` timestamp NULL DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_number`),
  UNIQUE KEY `ID_number` (`ID_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1235442343,'wadasss','wds','wadwa','awdwad','wad','wadw','National Guard Hospital',532470793,'male','al.abdalimu@gmail.com','AB-','0000-00-00','wadadsw','2024-05-14 11:54:00','2024-05-02 11:54:59',NULL),(1235453434,'dwdawdw','dawdawd','wadaw','wdadaw','waddwad','dawdaw','National Guard Hospital',532470793,'male','al.abdalimu@gmail.com','O+','0000-00-00','awddawd','2024-05-16 05:19:00','2024-05-02 13:19:44',NULL),(1323534343,'dawd','awdawd','awdawd','dawdwa','awdw','waddw','National Guard Hospital',532470793,'male','dd@hotmail.com','AB-','0000-00-00','dawdawdaw','2024-05-22 06:46:00','2024-05-02 12:41:54',NULL);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `register`
--

DROP TABLE IF EXISTS `register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `register` (
  `ID_number` int NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Password` char(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Confirm_password` char(50) DEFAULT NULL,
  `Nationality` char(30) DEFAULT NULL,
  `City` char(30) DEFAULT NULL,
  `Phone_number` int DEFAULT NULL,
  `Birth_date` date DEFAULT NULL,
  `Gender` varchar(15) DEFAULT NULL,
  `Blood_type` char(3) DEFAULT NULL,
  `F_name` varchar(30) DEFAULT NULL,
  `M_name` varchar(30) DEFAULT NULL,
  `L_name` varchar(30) DEFAULT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `security_question` varchar(255) DEFAULT NULL,
  `security_answer` varchar(255) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_number`),
  UNIQUE KEY `ID_number` (`ID_number`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `register`
--

LOCK TABLES `register` WRITE;
/*!40000 ALTER TABLE `register` DISABLE KEYS */;
INSERT INTO `register` VALUES (1,'admin','admin',NULL,'admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2024-04-19 18:41:30'),(342,'wda','Xzxz4444','al.abdalimu@gmail.com','Xzxz4444','awdaw','wd',523,'1997-02-04','male','A+','awd','dawd','awd',NULL,NULL,NULL,'2024-04-19 18:41:30'),(1332343424,'dawdawdawdaw','Xzxz3333','al.adddalimu@gmail.com','Xzxz1111','dawdaw','Riyadh',532470793,'1985-05-14','male','O+','awawda','dawda','awdaw',NULL,'What is your favorite animal?','ff','2024-04-19 20:21:49'),(1323534343,'wdawdw','Xzxz1234','dd@hotmail.com','Xzxz1234','awd','awdw',532470793,'1997-01-28','male','AB-','dawd','awdawd','awdawd',NULL,'What is your favorite food?','dd','2024-05-02 11:56:29'),(3,'user3','password3','user3@example.com','password3','Nationality3','City3',555555555,'1988-12-12','Male','A+','First3','Middle3','Last3',NULL,NULL,NULL,'2024-04-19 18:41:30'),(2020202020,'wwq','Xzxz4444','al.adddddbdalimu@gmail.com','Xzxz1234','dwa','Riyadh',532470794,'0000-00-00','male','A-','dawd','dwd','dawd',NULL,NULL,NULL,'2024-04-19 20:54:54'),(2147483647,'hthff','Sasss6666','waff@gmail.com','Sasss6666','hthf','rgdgdr',2147483647,'1999-06-08','female','AB+','rdgdg','grdgdr','grdg',NULL,NULL,NULL,'2024-04-19 18:41:30'),(1234212341,'saad','Xzxz1111','al.abdalimu@gmail.com','Xzxz1111','wdaw','Riyadh',532470793,'1996-05-06','male','A+','mohammed','dwd','wda',NULL,'What is your favorite animal?','cat','2024-04-23 07:06:20'),(523,'ewd','Xzxz1111','al.abdalimu@gmail.com','Xzxz1111','dwad','dwad',4234,'1997-01-28','male','A+','fes','fesf','efs',NULL,NULL,NULL,'2024-04-19 18:41:30'),(1454223443,'dwadwad','Xzxz1111','al.abdalimu@gmail.com','Xzxz1111','dwadwa','Riyadh',532470793,'1992-01-27','male','A+','dwadawaw','awadwa','wadawdawd',NULL,'What is your favorite food?','food','2024-04-21 07:39:38'),(1345453545,'efesfes','Xzxz1234','al.abdalimu@gmail.com','Xzxz1234','wda','Riyadh',500414640,'2002-01-29','male','A+','efsefe','esfesf','esfes',NULL,NULL,NULL,'2024-04-19 18:41:30'),(1246354555,'faawd','Sasss333','al.abdalimu@gmail.com','Xzxz1111','wdw','adw',534535435,'2001-01-15','male','A+','dwadawd','dawdwa','awdad',NULL,'What is your favorite food?','food','2024-04-23 16:15:58'),(1245334343,'qwerd','Xzxz1111','al.abdaliaamu@gmail.com','Xzxz1111','wda','wawd',532470798,'2005-02-01','male','A+','www','dhhdd','awawdsa',NULL,'What is your favorite food?','free','2024-04-30 09:36:48'),(1235442343,'wadwdaw','Sasss333','al.abdalimu@gmail.com','Sasss333','wad','wad',532470793,'1998-03-05','male','AB-','wadasss','wds','wadwa',NULL,'What is your favorite food?','aa','2024-04-30 09:43:01'),(1343222222,'wdwadaaw','Xzxz1234','al.abdalimu@gmail.com','Xzxz1234','dwad','wad',532470793,'2004-02-03','male','O+','wadas','wdasda','awdssw',NULL,'What is your favorite food?','ss','2024-04-30 09:45:18'),(1235453434,'ggggg','Xzxz1111','al.abdalimu@gmail.com','Xzxz1111','awdwa','waddwad',532470793,'2000-01-31','male','O+','dwdawdw','dawdawd','wadaw',NULL,'What is your favorite food?','dw','2024-04-30 10:50:31'),(1128412143,'max','Xzxz1111','al.abdalimu@gmail.com','Xzxz1111','Saudi arabia','Riyadh',532470793,'2003-11-18','male','O+','Mohammed','Fisal','Alabdali',NULL,'What is your favorite food?','rice','2024-05-07 11:55:28'),(1334234342,'dwawww','Xzxz1111','al.abdsalimu@gmail.com','Xzxz1111','dwa','Riyadh',532470793,'1997-01-27','male','O-','dwad','awdwa','dwad',NULL,'What is your favorite food?','qq11','2024-05-09 09:28:59');
/*!40000 ALTER TABLE `register` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-15  9:29:33

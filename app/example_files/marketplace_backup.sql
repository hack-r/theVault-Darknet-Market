/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.10-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: marketplace
-- ------------------------------------------------------
-- Server version	10.11.10-MariaDB

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
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `address` text NOT NULL,
  `pubkey` text DEFAULT NULL,
  `coin` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_user_id_foreign` (`user_id`),
  CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `admins_id_foreign` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bans`
--

DROP TABLE IF EXISTS `bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bans` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `until` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bans_user_id_foreign` (`user_id`),
  CONSTRAINT `bans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bans`
--

LOCK TABLES `bans` WRITE;
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES
('top_vendors_frontpage','O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:3:{i:0;O:10:\"App\\Vendor\":32:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"vendors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:6:\"string\";s:12:\"incrementing\";b:0;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";s:36:\"3b5a1e23-7890-abcd-ef01-23456789abcd\";s:12:\"vendor_level\";i:3;s:10:\"experience\";i:300;s:5:\"about\";s:96:\"Leading provider of curated DNA donor profiles with comprehensive genetic compatibility testing.\";s:9:\"profilebg\";s:11:\"dna_bg2.jpg\";s:7:\"trusted\";i:1;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";s:15:\"purchases_count\";i:1;}s:11:\"\0*\0original\";a:9:{s:2:\"id\";s:36:\"3b5a1e23-7890-abcd-ef01-23456789abcd\";s:12:\"vendor_level\";i:3;s:10:\"experience\";i:300;s:5:\"about\";s:96:\"Leading provider of curated DNA donor profiles with comprehensive genetic compatibility testing.\";s:9:\"profilebg\";s:11:\"dna_bg2.jpg\";s:7:\"trusted\";i:1;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";s:15:\"purchases_count\";i:1;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:4:\"user\";O:8:\"App\\User\":32:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:5:\"users\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:0;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:16:{s:2:\"id\";s:36:\"3b5a1e23-7890-abcd-ef01-23456789abcd\";s:8:\"username\";s:9:\"celebdna2\";s:8:\"password\";s:6:\"dummy2\";s:10:\"session_id\";N;s:8:\"mnemonic\";s:9:\"mnemonic2\";s:15:\"payment_address\";N;s:9:\"last_seen\";N;s:9:\"login_2fa\";i:0;s:13:\"referral_code\";s:4:\"ref2\";s:11:\"referred_by\";N;s:18:\"bitmessage_address\";N;s:7:\"pgp_key\";N;s:14:\"msg_public_key\";N;s:15:\"msg_private_key\";N;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";}s:11:\"\0*\0original\";a:16:{s:2:\"id\";s:36:\"3b5a1e23-7890-abcd-ef01-23456789abcd\";s:8:\"username\";s:9:\"celebdna2\";s:8:\"password\";s:6:\"dummy2\";s:10:\"session_id\";N;s:8:\"mnemonic\";s:9:\"mnemonic2\";s:15:\"payment_address\";N;s:9:\"last_seen\";N;s:9:\"login_2fa\";i:0;s:13:\"referral_code\";s:4:\"ref2\";s:11:\"referred_by\";N;s:18:\"bitmessage_address\";N;s:7:\"pgp_key\";N;s:14:\"msg_public_key\";N;s:15:\"msg_private_key\";N;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:2:{i:0;s:8:\"password\";i:1;s:14:\"remember_token\";}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:5:\"email\";i:2;s:8:\"password\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:19:\"\0*\0authPasswordName\";s:8:\"password\";s:20:\"\0*\0rememberTokenName\";s:14:\"remember_token\";}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:2:{i:0;s:8:\"password\";i:1;s:14:\"remember_token\";}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:2:\"id\";i:1;s:12:\"vendor_level\";i:2;s:5:\"about\";i:3;s:10:\"created_at\";i:4;s:10:\"updated_at\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:19:\"\0*\0authPasswordName\";s:8:\"password\";s:20:\"\0*\0rememberTokenName\";s:14:\"remember_token\";}i:1;O:10:\"App\\Vendor\":32:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"vendors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:6:\"string\";s:12:\"incrementing\";b:0;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";s:36:\"9d4e1e23-4567-89ab-cdef-0123456789ab\";s:12:\"vendor_level\";i:2;s:10:\"experience\";i:150;s:5:\"about\";s:95:\"Specializes in high-quality DNA donor screening for couples seeking enhanced fertility options.\";s:9:\"profilebg\";s:11:\"dna_bg1.jpg\";s:7:\"trusted\";i:1;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";s:15:\"purchases_count\";i:0;}s:11:\"\0*\0original\";a:9:{s:2:\"id\";s:36:\"9d4e1e23-4567-89ab-cdef-0123456789ab\";s:12:\"vendor_level\";i:2;s:10:\"experience\";i:150;s:5:\"about\";s:95:\"Specializes in high-quality DNA donor screening for couples seeking enhanced fertility options.\";s:9:\"profilebg\";s:11:\"dna_bg1.jpg\";s:7:\"trusted\";i:1;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";s:15:\"purchases_count\";i:0;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:4:\"user\";O:8:\"App\\User\":32:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:5:\"users\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:0;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:16:{s:2:\"id\";s:36:\"9d4e1e23-4567-89ab-cdef-0123456789ab\";s:8:\"username\";s:8:\"celebdna\";s:8:\"password\";s:14:\"dummy_password\";s:10:\"session_id\";N;s:8:\"mnemonic\";s:14:\"dummy_mnemonic\";s:15:\"payment_address\";N;s:9:\"last_seen\";N;s:9:\"login_2fa\";i:0;s:13:\"referral_code\";s:14:\"dummy_referral\";s:11:\"referred_by\";N;s:18:\"bitmessage_address\";N;s:7:\"pgp_key\";N;s:14:\"msg_public_key\";N;s:15:\"msg_private_key\";N;s:10:\"created_at\";s:19:\"2025-02-16 23:43:27\";s:10:\"updated_at\";s:19:\"2025-02-16 23:43:27\";}s:11:\"\0*\0original\";a:16:{s:2:\"id\";s:36:\"9d4e1e23-4567-89ab-cdef-0123456789ab\";s:8:\"username\";s:8:\"celebdna\";s:8:\"password\";s:14:\"dummy_password\";s:10:\"session_id\";N;s:8:\"mnemonic\";s:14:\"dummy_mnemonic\";s:15:\"payment_address\";N;s:9:\"last_seen\";N;s:9:\"login_2fa\";i:0;s:13:\"referral_code\";s:14:\"dummy_referral\";s:11:\"referred_by\";N;s:18:\"bitmessage_address\";N;s:7:\"pgp_key\";N;s:14:\"msg_public_key\";N;s:15:\"msg_private_key\";N;s:10:\"created_at\";s:19:\"2025-02-16 23:43:27\";s:10:\"updated_at\";s:19:\"2025-02-16 23:43:27\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:2:{i:0;s:8:\"password\";i:1;s:14:\"remember_token\";}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:5:\"email\";i:2;s:8:\"password\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:19:\"\0*\0authPasswordName\";s:8:\"password\";s:20:\"\0*\0rememberTokenName\";s:14:\"remember_token\";}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:2:{i:0;s:8:\"password\";i:1;s:14:\"remember_token\";}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:2:\"id\";i:1;s:12:\"vendor_level\";i:2;s:5:\"about\";i:3;s:10:\"created_at\";i:4;s:10:\"updated_at\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:19:\"\0*\0authPasswordName\";s:8:\"password\";s:20:\"\0*\0rememberTokenName\";s:14:\"remember_token\";}i:2;O:10:\"App\\Vendor\":32:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"vendors\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:6:\"string\";s:12:\"incrementing\";b:0;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";s:36:\"c2f5a123-4567-89ab-cdef-abcdef123456\";s:12:\"vendor_level\";i:1;s:10:\"experience\";i:90;s:5:\"about\";s:105:\"Offers personalized DNA donor matching services designed to support couples in their journey to conceive.\";s:9:\"profilebg\";s:11:\"dna_bg3.jpg\";s:7:\"trusted\";i:0;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";s:15:\"purchases_count\";i:0;}s:11:\"\0*\0original\";a:9:{s:2:\"id\";s:36:\"c2f5a123-4567-89ab-cdef-abcdef123456\";s:12:\"vendor_level\";i:1;s:10:\"experience\";i:90;s:5:\"about\";s:105:\"Offers personalized DNA donor matching services designed to support couples in their journey to conceive.\";s:9:\"profilebg\";s:11:\"dna_bg3.jpg\";s:7:\"trusted\";i:0;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";s:15:\"purchases_count\";i:0;}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:1:{s:4:\"user\";O:8:\"App\\User\":32:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:5:\"users\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:0;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:16:{s:2:\"id\";s:36:\"c2f5a123-4567-89ab-cdef-abcdef123456\";s:8:\"username\";s:9:\"celebdna3\";s:8:\"password\";s:6:\"dummy3\";s:10:\"session_id\";N;s:8:\"mnemonic\";s:9:\"mnemonic3\";s:15:\"payment_address\";N;s:9:\"last_seen\";N;s:9:\"login_2fa\";i:0;s:13:\"referral_code\";s:4:\"ref3\";s:11:\"referred_by\";N;s:18:\"bitmessage_address\";N;s:7:\"pgp_key\";N;s:14:\"msg_public_key\";N;s:15:\"msg_private_key\";N;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";}s:11:\"\0*\0original\";a:16:{s:2:\"id\";s:36:\"c2f5a123-4567-89ab-cdef-abcdef123456\";s:8:\"username\";s:9:\"celebdna3\";s:8:\"password\";s:6:\"dummy3\";s:10:\"session_id\";N;s:8:\"mnemonic\";s:9:\"mnemonic3\";s:15:\"payment_address\";N;s:9:\"last_seen\";N;s:9:\"login_2fa\";i:0;s:13:\"referral_code\";s:4:\"ref3\";s:11:\"referred_by\";N;s:18:\"bitmessage_address\";N;s:7:\"pgp_key\";N;s:14:\"msg_public_key\";N;s:15:\"msg_private_key\";N;s:10:\"created_at\";s:19:\"2025-02-16 23:49:34\";s:10:\"updated_at\";s:19:\"2025-02-16 23:49:34\";}s:10:\"\0*\0changes\";a:0:{}s:8:\"\0*\0casts\";a:0:{}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:2:{i:0;s:8:\"password\";i:1;s:14:\"remember_token\";}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:5:\"email\";i:2;s:8:\"password\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:19:\"\0*\0authPasswordName\";s:8:\"password\";s:20:\"\0*\0rememberTokenName\";s:14:\"remember_token\";}}s:10:\"\0*\0touches\";a:0:{}s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:2:{i:0;s:8:\"password\";i:1;s:14:\"remember_token\";}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:5:{i:0;s:2:\"id\";i:1;s:12:\"vendor_level\";i:2;s:5:\"about\";i:3;s:10:\"created_at\";i:4;s:10:\"updated_at\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}s:19:\"\0*\0authPasswordName\";s:8:\"password\";s:20:\"\0*\0rememberTokenName\";s:14:\"remember_token\";}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}',1739858718);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` char(36) NOT NULL,
  `parent_id` char(36) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
('47c3223c-ecfc-11ef-9872-00163e5e6c00',NULL,'Celebrity DNA Samples!','2025-02-17 06:56:15','2025-02-17 06:56:15'),
('47c3283c-ecfc-11ef-9872-00163e5e6c00',NULL,'DNA Samples','2025-02-17 06:56:15','2025-02-17 06:56:15'),
('47c32ab3-ecfc-11ef-9872-00163e5e6c00',NULL,'Targeted Extraction Services','2025-02-17 06:56:15','2025-02-17 06:56:15'),
('47c32b31-ecfc-11ef-9872-00163e5e6c00','47c3283c-ecfc-11ef-9872-00163e5e6c00','High IQ','2025-02-17 12:14:43','2025-02-17 12:14:43'),
('47c32b32-ecfc-11ef-9872-00163e5e6c00','47c3283c-ecfc-11ef-9872-00163e5e6c00','Musicians','2025-02-17 12:14:43','2025-02-17 12:14:43'),
('47c32b33-ecfc-11ef-9872-00163e5e6c00','47c3283c-ecfc-11ef-9872-00163e5e6c00','Artists','2025-02-17 12:14:43','2025-02-17 12:14:43'),
('47c32b34-ecfc-11ef-9872-00163e5e6c00','47c3283c-ecfc-11ef-9872-00163e5e6c00','Athletes','2025-02-17 12:14:43','2025-02-17 12:14:43'),
('47c32b35-ecfc-11ef-9872-00163e5e6c00','47c3283c-ecfc-11ef-9872-00163e5e6c00','Tall','2025-02-17 12:14:43','2025-02-17 12:14:43'),
('47c32b36-ecfc-11ef-9872-00163e5e6c00','47c3283c-ecfc-11ef-9872-00163e5e6c00','Well-Rounded','2025-02-17 12:14:43','2025-02-17 12:14:43'),
('47c32b37-ecfc-11ef-9872-00163e5e6c00','47c3283c-ecfc-11ef-9872-00163e5e6c00','Mutations','2025-02-17 12:14:43','2025-02-17 12:14:43');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversations` (
  `id` char(36) NOT NULL,
  `sender_id` char(36) DEFAULT NULL,
  `receiver_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conversations_sender_id_foreign` (`sender_id`),
  KEY `conversations_receiver_id_foreign` (`receiver_id`),
  CONSTRAINT `conversations_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conversations_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `digital_products`
--

DROP TABLE IF EXISTS `digital_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `digital_products` (
  `id` char(36) NOT NULL,
  `autodelivery` tinyint(1) NOT NULL DEFAULT 0,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `digital_products_id_foreign` FOREIGN KEY (`id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `digital_products`
--

LOCK TABLES `digital_products` WRITE;
/*!40000 ALTER TABLE `digital_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `digital_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispute_messages`
--

DROP TABLE IF EXISTS `dispute_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispute_messages` (
  `id` char(36) NOT NULL,
  `message` text NOT NULL,
  `author_id` char(36) NOT NULL,
  `dispute_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dispute_messages_author_id_foreign` (`author_id`),
  KEY `dispute_messages_dispute_id_foreign` (`dispute_id`),
  CONSTRAINT `dispute_messages_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dispute_messages_dispute_id_foreign` FOREIGN KEY (`dispute_id`) REFERENCES `disputes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispute_messages`
--

LOCK TABLES `dispute_messages` WRITE;
/*!40000 ALTER TABLE `dispute_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispute_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disputes`
--

DROP TABLE IF EXISTS `disputes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disputes` (
  `id` char(36) NOT NULL,
  `winner_id` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `disputes_winner_id_foreign` (`winner_id`),
  CONSTRAINT `disputes_winner_id_foreign` FOREIGN KEY (`winner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disputes`
--

LOCK TABLES `disputes` WRITE;
/*!40000 ALTER TABLE `disputes` DISABLE KEYS */;
/*!40000 ALTER TABLE `disputes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `id` char(36) NOT NULL,
  `vendor_id` char(36) NOT NULL,
  `buyer_id` char(36) DEFAULT NULL,
  `product_id` char(36) DEFAULT NULL,
  `product_name` text NOT NULL,
  `product_value` decimal(16,2) NOT NULL,
  `type` enum('positive','neutral','negative') NOT NULL,
  `quality_rate` tinyint(4) NOT NULL,
  `communication_rate` tinyint(4) NOT NULL,
  `shipping_rate` tinyint(4) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feedback_vendor_id_foreign` (`vendor_id`),
  KEY `feedback_product_id_foreign` (`product_id`),
  KEY `feedback_buyer_id_foreign` (`buyer_id`),
  CONSTRAINT `feedback_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `feedback_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  CONSTRAINT `feedback_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  `image` text NOT NULL,
  `first` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `images_product_id_foreign` (`product_id`),
  CONSTRAINT `images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES
('244c2eef-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c16','thorn.png',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c32f4-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c01','iq.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3427-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c02','iq.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c34d6-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c03','iq.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c357d-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c04','music.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c362e-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c05','music.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c36cc-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c06','music.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c377a-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c07','artist.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3819-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c08','artist.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c38ab-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c09','artist.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c392d-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c0a','athlete.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c39b6-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c0b','athlete.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3a47-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c0c','athlete.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3ad6-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c0d','tall.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3b5d-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c0e','tall.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3bf1-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c0f','tall.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3c8b-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c10','rounded.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3d23-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c11','rounded.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3daf-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c12','rounded.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3f3e-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c13','mutate.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c3fde-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c14','mutate.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22'),
('244c4082-ed7b-11ef-9872-00163e5e6c00','9fb57a9a-ecff-11ef-9872-00163e5e6c15','mutate.jpg',1,'2025-02-17 22:04:22','2025-02-17 22:04:22');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `performed_id` char(36) DEFAULT NULL,
  `performed_on` varchar(255) DEFAULT NULL,
  `description` mediumtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logs_user_id_foreign` (`user_id`),
  CONSTRAINT `logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` char(36) NOT NULL,
  `content_sender` longtext NOT NULL,
  `nonce_sender` longtext NOT NULL,
  `content_receiver` longtext NOT NULL,
  `nonce_receiver` longtext NOT NULL,
  `conversation_id` char(36) NOT NULL,
  `sender_id` char(36) DEFAULT NULL,
  `receiver_id` char(36) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_conversation_id_foreign` (`conversation_id`),
  KEY `messages_sender_id_foreign` (`sender_id`),
  KEY `messages_receiver_id_foreign` (`receiver_id`),
  CONSTRAINT `messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'0001_01_01_000000_create_users_table',1),
(2,'0001_01_01_000001_create_cache_table',1),
(3,'0001_01_01_000002_create_jobs_table',1),
(4,'2014_10_12_000000_create_users_table',2),
(5,'2014_10_12_100000_create_password_resets_table',2),
(6,'2018_08_28_103514_create_p_g_p_keys_table',2),
(7,'2018_08_30_104044_create_vendors_table',2),
(8,'2018_08_30_204259_create_categories_table',2),
(9,'2018_08_30_204840_create_admins_table',2),
(10,'2018_08_31_121912_create_products_table',2),
(11,'2018_08_31_122620_create_physical_products_table',2),
(12,'2018_08_31_122628_create_digital_products_table',2),
(13,'2018_08_31_182733_create_offers_table',2),
(14,'2018_08_31_192727_create_shippings_table',2),
(15,'2018_09_01_203115_create_images_table',2),
(16,'2018_09_06_132015_create_wishlists_table',2),
(17,'2018_09_07_112831_create_feedback_table',2),
(18,'2018_09_24_101728_create_purchases_table',2),
(19,'2018_10_01_100924_create_disputes_table',2),
(20,'2018_10_01_101836_create_dispute_messages_table',2),
(21,'2018_10_12_144436_create_conversations_table',2),
(22,'2018_10_12_144542_create_messages_table',2),
(23,'2018_10_27_205143_create_logs_table',2),
(24,'2018_11_15_113419_create_addresses_table',2),
(25,'2019_01_05_140832_create_notifications_table',2),
(26,'2019_01_11_214222_create_vendor_purchases_table',2),
(27,'2019_02_13_101528_create_permissions_table',2),
(28,'2019_02_16_185709_create_tickets_table',2),
(29,'2019_02_16_190336_create_ticket_replies_table',2),
(30,'2019_03_25_133234_create_bans_table',2),
(31,'2019_05_11_205112_create_shipping_offers_deleted',2),
(32,'2019_05_12_220221_create_purchases_cancelation',2),
(33,'2019_05_26_221922_create_product_purchase_types',2),
(34,'2019_08_08_091529_add_featured_field_to_products_table',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `description` mediumtext NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `route_name` text DEFAULT NULL,
  `route_params` mediumtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offers` (
  `id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  `min_quantity` int(11) NOT NULL,
  `price` decimal(16,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `offers_product_id_foreign` (`product_id`),
  CONSTRAINT `offers_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES
('9fb57a9a-ecff-11ef-9872-00163e5e6c01','9fb57a9a-ecff-11ef-9872-00163e5e6c01',1,150.00,'2025-02-17 12:59:24','2025-02-17 12:59:24',0);
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_user_id_foreign` (`user_id`),
  CONSTRAINT `permissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pgpkeys`
--

DROP TABLE IF EXISTS `pgpkeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pgpkeys` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `key` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pgpkeys_user_id_foreign` (`user_id`),
  CONSTRAINT `pgpkeys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pgpkeys`
--

LOCK TABLES `pgpkeys` WRITE;
/*!40000 ALTER TABLE `pgpkeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `pgpkeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_products`
--

DROP TABLE IF EXISTS `physical_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physical_products` (
  `id` char(36) NOT NULL,
  `countries_option` enum('all','include','exclude') DEFAULT 'all',
  `countries` text NOT NULL,
  `country_from` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `physical_products_id_foreign` FOREIGN KEY (`id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_products`
--

LOCK TABLES `physical_products` WRITE;
/*!40000 ALTER TABLE `physical_products` DISABLE KEYS */;
INSERT INTO `physical_products` VALUES
('9fb57a9a-ecff-11ef-9872-00163e5e6c01','include','US,GB','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c02','all','US,CA,JP,FR','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c03','exclude','CN,IR,RU','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c04','include','US,BR,AR','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c05','all','US,DE,IT','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c06','include','US,AU','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c07','include','US,IN','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c09','all','US,CA','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0a','include','UK,FR,DE','Germany','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0b','exclude','IT,ES','Italy','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0c','include','US,NL','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0d','all','US,SE,NO','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0e','include','JP,US','Japan','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0f','include','US,AU','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c10','exclude','CN,RU','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c11','include','US,CA,AU','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c12','include','FR,GB','United Kingdom','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c13','all','US,MX','United States','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c14','include','BR,AR','Brazil','2025-02-18 04:39:14','2025-02-18 04:39:14'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c15','include','US,CA','United States','2025-02-18 04:39:15','2025-02-18 04:39:15'),
('9fb57a9a-ecff-11ef-9872-00163e5e6c16','include','US,CA,MX','United States','2025-02-18 04:39:14','2025-02-18 04:39:14');
/*!40000 ALTER TABLE `physical_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `rules` text NOT NULL,
  `quantity` int(11) NOT NULL,
  `mesure` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `coins` text NOT NULL,
  `category_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `types` varchar(255) NOT NULL DEFAULT 'normal',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `products_category_id_foreign` (`category_id`),
  KEY `products_user_id_foreign` (`user_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES
('9fb57a9a-ecff-11ef-9872-00163e5e6c01','High IQ DNA Sample - Premium','A premium DNA sample from an individual with exceptional intelligence, perfect for research.','For research and collectible purposes only. Not for cloning.',3,'vial',1,'150','47c32b31-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:25:08','2025-02-17 12:25:08','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c02','High IQ DNA Sample - Limited Edition','Limited edition DNA sample from a genius known for groundbreaking innovations.','Keep secure and do not distribute.',5,'vial',1,'160','47c32b31-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:25:08','2025-02-17 12:25:08','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c03','High IQ DNA Sample - Exclusive','An exclusive DNA sample from a renowned intellectual, comes with a certificate of authenticity.','Not for public reproduction.',4,'vial',1,'170','47c32b31-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:25:08','2025-02-17 12:25:08','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c04','Musician DNA Sample - Fresh','Fresh DNA sample from a top musician, capturing their unique sound and creativity.','For research and collectible purposes only. Not for cloning.',3,'vial',1,'150','47c32b32-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:25:08','2025-02-17 12:25:08','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c05','Musician DNA Sample - Limited Edition','Limited edition DNA sample from a legendary musician, perfect for collectors.','Keep secure and do not distribute.',5,'vial',1,'160','47c32b32-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:25:08','2025-02-17 12:25:08','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c06','Musician DNA Sample - Exclusive','An exclusive DNA sample from a celebrated artist, comes with a certificate of authenticity.','Not for public reproduction.',4,'vial',1,'170','47c32b32-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:25:08','2025-02-17 12:25:08','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c07','Artist DNA Sample - Fresh','Fresh DNA sample from a renowned artist, capturing their creative essence.','For research and collectible purposes only. Not for cloning.',3,'vial',1,'150','47c32b33-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:26:49','2025-02-17 12:26:49','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c08','Artist DNA Sample - Limited Edition','Limited edition DNA sample from a famous artist, ideal for collectors.','Keep secure and do not distribute.',5,'vial',1,'160','47c32b33-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:26:49','2025-02-17 12:26:49','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c09','Artist DNA Sample - Exclusive','An exclusive DNA sample from a celebrated artist, comes with a certificate of authenticity.','Not for public reproduction.',4,'vial',1,'170','47c32b33-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:26:49','2025-02-17 12:26:49','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0a','Athlete DNA Sample - Fresh','Fresh DNA sample from a top athlete, showcasing their exceptional physical abilities.','For research and collectible purposes only. Not for cloning.',3,'vial',1,'150','47c32b34-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:27:15','2025-02-17 12:27:15','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0b','Athlete DNA Sample - Limited Edition','Limited edition DNA sample from a legendary athlete, perfect for collectors.','Keep secure and do not distribute.',5,'vial',1,'160','47c32b34-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:27:15','2025-02-17 12:27:15','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0c','Athlete DNA Sample - Exclusive','An exclusive DNA sample from a celebrated athlete, comes with a certificate of authenticity.','Not for public reproduction.',4,'vial',1,'170','47c32b34-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:27:15','2025-02-17 12:27:15','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0d','Tall DNA Sample - Fresh','Fresh DNA sample from an individual known for their height, ideal for research.','For research and collectible purposes only. Not for cloning.',3,'vial',1,'150','47c32b35-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:29:46','2025-02-17 12:29:46','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0e','Tall DNA Sample - Limited Edition','Limited edition DNA sample from a tall individual, perfect for collectors.','Keep secure and do not distribute.',5,'vial',1,'160','47c32b35-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:29:46','2025-02-17 12:29:46','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c0f','Tall DNA Sample - Exclusive','An exclusive DNA sample from a renowned tall individual, comes with a certificate of authenticity.','Not for public reproduction.',4,'vial',1,'170','47c32b35-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:29:46','2025-02-17 12:29:46','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c10','Well-Rounded DNA Sample - Fresh','Fresh DNA sample from an individual known for their diverse talents and skills.','For research and collectible purposes only. Not for cloning.',3,'vial',1,'150','47c32b36-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:29:48','2025-02-17 12:29:48','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c11','Well-Rounded DNA Sample - Limited Edition','Limited edition DNA sample from a well-rounded individual, perfect for collectors.','Keep secure and do not distribute.',5,'vial',1,'160','47c32b36-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:29:48','2025-02-17 12:29:48','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c12','Well-Rounded DNA Sample - Exclusive','An exclusive DNA sample from a celebrated well-rounded individual, comes with a certificate of authenticity.','Not for public reproduction.',4,'vial',1,'170','47c32b36-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:29:48','2025-02-17 12:29:48','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c13','Mutation DNA Sample - Fresh','Fresh DNA sample from an individual with unique genetic mutations, ideal for research.','For research and collectible purposes only. Not for cloning.',3,'vial',1,'150','47c32b37-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:31:43','2025-02-17 12:31:43','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c14','Mutation DNA Sample - Limited Edition','Limited edition DNA sample from an individual with notable mutations, perfect for collectors.','Keep secure and do not distribute.',5,'vial',1,'160','47c32b37-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:31:43','2025-02-17 12:31:43','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c15','Mutation DNA Sample - Exclusive','An exclusive DNA sample from a renowned individual with unique mutations, comes with a certificate of authenticity.','Not for public reproduction.',4,'vial',1,'170','47c32b37-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:31:43','2025-02-17 12:31:43','normal',1),
('9fb57a9a-ecff-11ef-9872-00163e5e6c16','Trace Thorn DNA Sample - Rock Star','Experience the essence of rock with a premium DNA sample from Trace Thorn, a legendary rock star known for his powerful vocals and captivating stage presence. Much like Billy Corgan, Trace has left an indelible mark on the music industry with his unique sound and artistic vision. This exclusive sample is perfect for collectors and researchers alike.','For research and collectible purposes only. Not for cloning.',3,'vial',1,'0','47c3223c-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-17 12:45:57','2025-02-17 12:45:57','normal',1),
('a1d57b9a-ecff-11ef-9872-00163e5e6c20','NYC Budget DNA Extraction','A cheap and efficient DNA extraction service for uncelebrated New York City residents. Designed for research and targeted extraction from specific individuals in NYC.','Strictly for research purposes. Limited to non-famous, consented participants in New York City.',10,'sample',1,'50','47c32ab3-ecfc-11ef-9872-00163e5e6c00','3b5a1e23-7890-abcd-ef01-23456789abcd','2025-02-18 04:44:53','2025-02-18 04:44:53','normal',0),
('b2e67c9a-ecff-11ef-9872-00163e5e6c21','Hollywood Celebrity DNA Extraction','A premium, top-of-the-line DNA extraction service tailored for celebrities in Hollywood. This ultra-exclusive service ensures the highest quality extraction for high-profile clients.','For celebrity clients only. Privacy and consent are strictly enforced via verified channels. Price reflects the exclusivity and superior technology involved.',5,'sample',1,'1000','47c32ab3-ecfc-11ef-9872-00163e5e6c00','9d4e1e23-4567-89ab-cdef-0123456789ab','2025-02-18 04:44:53','2025-02-18 04:44:53','premium',1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchases` (
  `id` char(36) NOT NULL,
  `offer_id` char(36) NOT NULL,
  `shipping_id` char(36) DEFAULT NULL,
  `buyer_id` char(36) DEFAULT NULL,
  `vendor_id` char(36) NOT NULL,
  `dispute_id` char(36) DEFAULT NULL,
  `feedback_id` char(36) DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `address` text NOT NULL,
  `to_pay` decimal(24,12) NOT NULL,
  `message` text NOT NULL,
  `state` enum('purchased','sent','delivered','disputed','canceled') NOT NULL DEFAULT 'purchased',
  `type` enum('fe','normal') NOT NULL DEFAULT 'normal',
  `coin_name` varchar(5) NOT NULL DEFAULT 'btc',
  `marketplace_address` text DEFAULT NULL,
  `multisig_address` text DEFAULT NULL,
  `redeem_script` text DEFAULT NULL,
  `private_key` text DEFAULT NULL,
  `hex` text DEFAULT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `delivered_product` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchases_offer_id_foreign` (`offer_id`),
  KEY `purchases_shipping_id_foreign` (`shipping_id`),
  KEY `purchases_buyer_id_foreign` (`buyer_id`),
  KEY `purchases_vendor_id_foreign` (`vendor_id`),
  KEY `purchases_feedback_id_foreign` (`feedback_id`),
  CONSTRAINT `purchases_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_feedback_id_foreign` FOREIGN KEY (`feedback_id`) REFERENCES `feedback` (`id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_offer_id_foreign` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchases_shipping_id_foreign` FOREIGN KEY (`shipping_id`) REFERENCES `shippings` (`id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` VALUES
('a1b2c3d4-ecff-11ef-9872-00163e5e6c01','9fb57a9a-ecff-11ef-9872-00163e5e6c01',NULL,'3b5a1e23-7890-abcd-ef01-23456789abcd','3b5a1e23-7890-abcd-ef01-23456789abcd',NULL,NULL,1,'123 Research Lane, Science City, SC 12345',150.000000000000,'Looking forward to this sample!','purchased','normal','btc','marketplace-address-placeholder',NULL,NULL,NULL,NULL,0,NULL,'2025-02-17 13:00:49','2025-02-17 13:00:49');
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES
('ekTNsYeqyNrKo4glGzmzZd3zKnRwddQTkq2zxyVr',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoickREejNENDV2ekNFazQ4YUNwdnU3UzZBa1YxbnB1bVNmMUhrT3czUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1739858713);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shippings`
--

DROP TABLE IF EXISTS `shippings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shippings` (
  `id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(16,2) NOT NULL,
  `duration` varchar(30) NOT NULL,
  `from_quantity` int(11) NOT NULL,
  `to_quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `shippings_product_id_foreign` (`product_id`),
  CONSTRAINT `shippings_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shippings`
--

LOCK TABLES `shippings` WRITE;
/*!40000 ALTER TABLE `shippings` DISABLE KEYS */;
INSERT INTO `shippings` VALUES
('b1c2d3e4-ecff-11ef-9872-00163e5e6c01','9fb57a9a-ecff-11ef-9872-00163e5e6c01','Standard Shipping',10.00,'5-7 business days',1,1,'2025-02-17 12:55:37','2025-02-17 12:55:37',0);
/*!40000 ALTER TABLE `shippings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_replies`
--

DROP TABLE IF EXISTS `ticket_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_replies` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `ticket_id` char(36) NOT NULL,
  `text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_replies_user_id_foreign` (`user_id`),
  KEY `ticket_replies_ticket_id_foreign` (`ticket_id`),
  CONSTRAINT `ticket_replies_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_replies`
--

LOCK TABLES `ticket_replies` WRITE;
/*!40000 ALTER TABLE `ticket_replies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_replies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `answered` tinyint(1) NOT NULL DEFAULT 0,
  `solved` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tickets_user_id_foreign` (`user_id`),
  CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `mnemonic` text NOT NULL,
  `payment_address` text DEFAULT NULL,
  `last_seen` timestamp NULL DEFAULT NULL,
  `login_2fa` tinyint(1) NOT NULL DEFAULT 0,
  `referral_code` varchar(255) NOT NULL,
  `referred_by` char(36) DEFAULT NULL,
  `bitmessage_address` text DEFAULT NULL,
  `pgp_key` text DEFAULT NULL,
  `msg_public_key` longtext DEFAULT NULL,
  `msg_private_key` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_referred_by_foreign` (`referred_by`),
  CONSTRAINT `users_referred_by_foreign` FOREIGN KEY (`referred_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
('3b5a1e23-7890-abcd-ef01-23456789abcd','celebdna2','dummy2',NULL,'mnemonic2',NULL,NULL,0,'ref2',NULL,NULL,NULL,NULL,NULL,'2025-02-17 04:49:34','2025-02-17 04:49:34'),
('9d4e1e23-4567-89ab-cdef-0123456789ab','celebdna','dummy_password',NULL,'dummy_mnemonic',NULL,NULL,0,'dummy_referral',NULL,NULL,NULL,NULL,NULL,'2025-02-17 04:43:27','2025-02-17 04:43:27'),
('c2f5a123-4567-89ab-cdef-abcdef123456','celebdna3','dummy3',NULL,'mnemonic3',NULL,NULL,0,'ref3',NULL,NULL,NULL,NULL,NULL,'2025-02-17 04:49:34','2025-02-17 04:49:34');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_purchases`
--

DROP TABLE IF EXISTS `vendor_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor_purchases` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `address` text NOT NULL,
  `coin` varchar(10) NOT NULL,
  `amount` decimal(24,12) NOT NULL DEFAULT 0.000000000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vendor_purchases_user_id_foreign` (`user_id`),
  CONSTRAINT `vendor_purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_purchases`
--

LOCK TABLES `vendor_purchases` WRITE;
/*!40000 ALTER TABLE `vendor_purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendors` (
  `id` char(36) NOT NULL,
  `vendor_level` int(10) unsigned NOT NULL,
  `experience` int(11) NOT NULL DEFAULT 0,
  `about` text DEFAULT NULL,
  `profilebg` text DEFAULT NULL,
  `trusted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `vendors_id_foreign` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendors`
--

LOCK TABLES `vendors` WRITE;
/*!40000 ALTER TABLE `vendors` DISABLE KEYS */;
INSERT INTO `vendors` VALUES
('3b5a1e23-7890-abcd-ef01-23456789abcd',3,300,'Leading provider of curated DNA donor profiles with comprehensive genetic compatibility testing.','dna_bg2.jpg',1,'2025-02-17 04:49:34','2025-02-17 04:49:34'),
('9d4e1e23-4567-89ab-cdef-0123456789ab',2,150,'Specializes in high-quality DNA donor screening for couples seeking enhanced fertility options.','dna_bg1.jpg',1,'2025-02-17 04:49:34','2025-02-17 04:49:34'),
('c2f5a123-4567-89ab-cdef-abcdef123456',1,90,'Offers personalized DNA donor matching services designed to support couples in their journey to conceive.','dna_bg3.jpg',0,'2025-02-17 04:49:34','2025-02-17 04:49:34');
/*!40000 ALTER TABLE `vendors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wishlists` (
  `user_id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlists`
--

LOCK TABLES `wishlists` WRITE;
/*!40000 ALTER TABLE `wishlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlists` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-18  1:10:09

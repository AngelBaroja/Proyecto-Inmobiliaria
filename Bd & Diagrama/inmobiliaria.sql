-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: inmobiliaria
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `contratos`
--

DROP TABLE IF EXISTS `contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monto` decimal(10,0) NOT NULL,
  `fechaInicio` datetime NOT NULL,
  `fechaFin` datetime NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `idInmueble` int(11) NOT NULL,
  `idInquilino` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idInmueble` (`idInmueble`),
  KEY `idInquilino` (`idInquilino`),
  CONSTRAINT `contratos_ibfk_1` FOREIGN KEY (`idInmueble`) REFERENCES `inmuebles` (`id`),
  CONSTRAINT `contratos_ibfk_2` FOREIGN KEY (`idInquilino`) REFERENCES `inquilinos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos`
--

LOCK TABLES `contratos` WRITE;
/*!40000 ALTER TABLE `contratos` DISABLE KEYS */;
INSERT INTO `contratos` VALUES (2,50000,'2025-09-20 00:00:00','2025-09-27 00:00:00',1,14,1);
/*!40000 ALTER TABLE `contratos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagenes`
--

DROP TABLE IF EXISTS `imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imagenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `InmuebleId` int(11) NOT NULL,
  `url` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `InmuebleId` (`InmuebleId`),
  CONSTRAINT `imagenes_ibfk_1` FOREIGN KEY (`InmuebleId`) REFERENCES `inmuebles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagenes`
--

LOCK TABLES `imagenes` WRITE;
/*!40000 ALTER TABLE `imagenes` DISABLE KEYS */;
INSERT INTO `imagenes` VALUES (2,14,'/Uploads/Inmuebles\\4f3eb8f2-fc88-4d64-baf0-cb3c1f3bcf51.jpg'),(3,15,'/Uploads/Inmuebles\\fc205dce-6098-4c63-b2e5-9f6cbc7ebc22.jpg'),(7,17,'/Uploads/Inmuebles\\d7a69044-1be2-4061-ab2f-5113a51c4779.jpg'),(8,17,'/Uploads/Inmuebles\\855d2238-d324-4eb2-9022-4308a0b22dbc.jpg');
/*!40000 ALTER TABLE `imagenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inmuebles`
--

DROP TABLE IF EXISTS `inmuebles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inmuebles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `direccion` varchar(50) NOT NULL,
  `ambientes` int(11) NOT NULL,
  `uso` varchar(30) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `superficie` int(11) NOT NULL,
  `latitud` decimal(10,0) NOT NULL,
  `longitud` decimal(10,0) NOT NULL,
  `estado` varchar(30) NOT NULL,
  `precio` int(11) NOT NULL,
  `urlPortada` varchar(500) DEFAULT NULL,
  `idImagen` int(11) DEFAULT NULL,
  `idPropietario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idPropietario` (`idPropietario`),
  KEY `idImagen` (`idImagen`),
  CONSTRAINT `inmuebles_ibfk_1` FOREIGN KEY (`idPropietario`) REFERENCES `propietarios` (`id`),
  CONSTRAINT `inmuebles_ibfk_2` FOREIGN KEY (`idImagen`) REFERENCES `imagenes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inmuebles`
--

LOCK TABLES `inmuebles` WRITE;
/*!40000 ALTER TABLE `inmuebles` DISABLE KEYS */;
INSERT INTO `inmuebles` VALUES (14,'Calle False 122',3,'Comercial','Local',80,102,104,'Ocupado',350000,'/Uploads/Inmuebles/portada_14.jpg',NULL,9),(15,'Uruguay 512',2,'Comercial','Depósito',150,206,305,'Disponible',800000,'/Uploads/Inmuebles/portada_15.jpg',NULL,3),(17,'Super Calle 1300',4,'Residencial','Casa',50,76,52,'Disponible',450000,'/Uploads/Inmuebles/portada_17.webp',NULL,5);
/*!40000 ALTER TABLE `inmuebles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inquilinos`
--

DROP TABLE IF EXISTS `inquilinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inquilinos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DNI` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inquilinos`
--

LOCK TABLES `inquilinos` WRITE;
/*!40000 ALTER TABLE `inquilinos` DISABLE KEYS */;
INSERT INTO `inquilinos` VALUES (1,40125698,'Laura','Ramírez','1178901234','laura.ramirez@gmail.com',1),(2,38965412,'Diego','Sánchez','1189012345','diego.sanchez@gmail.com',1),(3,41237895,'Sofía','Torres','1190123456','sofia.torres@gmail.com',1),(4,39541236,'Matías','Domínguez','1101234567','matias.dominguez@gmail.com',1),(5,42369874,'Julieta','Acosta','1112345678','julieta.acosta@gmail.com',1);
/*!40000 ALTER TABLE `inquilinos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propietarios`
--

DROP TABLE IF EXISTS `propietarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propietarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DNI` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propietarios`
--

LOCK TABLES `propietarios` WRITE;
/*!40000 ALTER TABLE `propietarios` DISABLE KEYS */;
INSERT INTO `propietarios` VALUES (2,37775452,'Pio Ricardo','Baroja','2657545454','pio@gmail.com',1),(3,44565245,'Matias','Corvalan','2664525742','marcoteca@hotmail.com',1),(4,30456987,'Carlos','Gómez','1123456789','carlos.gomez@gmail.com',1),(5,28975643,'María','Fernández','1134567890','maria.fernandez@gmail.com',1),(6,31547896,'Jorge','Pérez','1145678901','jorge.perez@gmail.com',1),(7,27654321,'Ana','Martínez','1156789012','ana.martinez@gmail.com',1),(8,33214567,'Ricardo','López','1167890123','ricardo.lopez@gmail.com',1),(9,39137714,'Angel','Baroja','2664525742','Angel@gmail.com',1);
/*!40000 ALTER TABLE `propietarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Apellido` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Clave` varchar(255) NOT NULL,
  `Avatar` varchar(255) DEFAULT '',
  `Rol` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Email` (`Email`),
  CONSTRAINT `chk_rol` CHECK (`Rol` in (1,2))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'matias','Corvalan','mati@mail.com','zEfYY5GuCHYxJnjvXMW26fucSSSTVhSAhqs7G93KraY=','',1),(2,'angel','baroja','angel@mail.com','zEfYY5GuCHYxJnjvXMW26fucSSSTVhSAhqs7G93KraY=','',1),(3,'Santi','Bene','ANGEL@BAROJA.COM','zEfYY5GuCHYxJnjvXMW26fucSSSTVhSAhqs7G93KraY=','',2);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'inmobiliaria'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-22 19:29:35

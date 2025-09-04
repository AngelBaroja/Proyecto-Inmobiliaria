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
INSERT INTO `contratos` VALUES (1,50000,'2025-09-04 00:00:00','2026-09-04 00:00:00',1,10,2);
/*!40000 ALTER TABLE `contratos` ENABLE KEYS */;
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
  `idPropietario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idPropietario` (`idPropietario`),
  CONSTRAINT `inmuebles_ibfk_1` FOREIGN KEY (`idPropietario`) REFERENCES `propietarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inmuebles`
--

LOCK TABLES `inmuebles` WRITE;
/*!40000 ALTER TABLE `inmuebles` DISABLE KEYS */;
INSERT INTO `inmuebles` VALUES (4,'Calle Real 123',4,'Comercial','Local',213,142,421,'Disponible',50000,7),(5,'Calle 123',2,'Comercial','Local',100,10,111,'Disponible',10000,8),(6,'Avenida 456',2,'Comercial','Local',150,20,254,'Disponible',20000,2),(7,'Rambla 789',3,'Comercial','Local',200,30,119,'Ocupado',30000,3),(8,'Paseo 101',4,'Comercial','Depósito',250,40,324,'No Disponible',500000,4),(9,'Belgrano 1235',3,'Residencial','Casa',300,50,543,'Disponible',60000,5),(10,'3 de Febrero 46',2,'Residencial','Casa',350,60,40,'Ocupado',30500,6),(11,'Sucre 1532',4,'Residencial','Departamento',400,70,565,'No Disponible',75000,7);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propietarios`
--

LOCK TABLES `propietarios` WRITE;
/*!40000 ALTER TABLE `propietarios` DISABLE KEYS */;
INSERT INTO `propietarios` VALUES (2,37775452,'Pio','Baroja','2657545454','pio@gmail.com',1),(3,44565245,'Matias','Corvalan','2664525742','marcoteca@hotmail.com',1),(4,30456987,'Carlos','Gómez','1123456789','carlos.gomez@gmail.com',1),(5,28975643,'María','Fernández','1134567890','maria.fernandez@gmail.com',1),(6,31547896,'Jorge','Pérez','1145678901','jorge.perez@gmail.com',1),(7,27654321,'Ana','Martínez','1156789012','ana.martinez@gmail.com',1),(8,33214567,'Ricardo','López','1167890123','ricardo.lopez@gmail.com',1);
/*!40000 ALTER TABLE `propietarios` ENABLE KEYS */;
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

-- Dump completed on 2025-09-04 16:28:04

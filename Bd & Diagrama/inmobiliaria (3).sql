-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2025 at 06:31 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inmobiliaria`
--

-- --------------------------------------------------------

--
-- Table structure for table `contratos`
--

CREATE TABLE `contratos` (
  `id` int(11) NOT NULL,
  `monto` decimal(10,0) NOT NULL,
  `fechaInicio` datetime NOT NULL,
  `fechaFin` datetime NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `idInmueble` int(11) NOT NULL,
  `idInquilino` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `imagenes`
--

CREATE TABLE `imagenes` (
  `id` int(11) NOT NULL,
  `InmuebleId` int(11) NOT NULL,
  `url` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `imagenes`
--

INSERT INTO `imagenes` (`id`, `InmuebleId`, `url`) VALUES
(2, 14, '/Uploads/Inmuebles\\4f3eb8f2-fc88-4d64-baf0-cb3c1f3bcf51.jpg'),
(3, 15, '/Uploads/Inmuebles\\fc205dce-6098-4c63-b2e5-9f6cbc7ebc22.jpg'),
(7, 17, '/Uploads/Inmuebles\\d7a69044-1be2-4061-ab2f-5113a51c4779.jpg'),
(8, 17, '/Uploads/Inmuebles\\855d2238-d324-4eb2-9022-4308a0b22dbc.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `inmuebles`
--

CREATE TABLE `inmuebles` (
  `id` int(11) NOT NULL,
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
  `idPropietario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inmuebles`
--

INSERT INTO `inmuebles` (`id`, `direccion`, `ambientes`, `uso`, `tipo`, `superficie`, `latitud`, `longitud`, `estado`, `precio`, `urlPortada`, `idImagen`, `idPropietario`) VALUES
(14, 'Calle False 122', 3, 'Comercial', 'Local', 80, 102, 104, 'Disponible', 350000, '/Uploads/Inmuebles/portada_14.jpg', NULL, 9),
(15, 'Uruguay 512', 2, 'Comercial', 'Depósito', 150, 206, 305, 'Disponible', 800000, '/Uploads/Inmuebles/portada_15.jpg', NULL, 3),
(17, 'Super Calle 1300', 4, 'Residencial', 'Casa', 50, 76, 52, 'Disponible', 450000, '/Uploads/Inmuebles/portada_17.webp', NULL, 5);

-- --------------------------------------------------------

--
-- Table structure for table `inquilinos`
--

CREATE TABLE `inquilinos` (
  `id` int(11) NOT NULL,
  `DNI` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inquilinos`
--

INSERT INTO `inquilinos` (`id`, `DNI`, `nombre`, `apellido`, `telefono`, `email`, `estado`) VALUES
(1, 40125698, 'Laura', 'Ramírez', '1178901234', 'laura.ramirez@gmail.com', 1),
(2, 38965412, 'Diego', 'Sánchez', '1189012345', 'diego.sanchez@gmail.com', 1),
(3, 41237895, 'Sofía', 'Torres', '1190123456', 'sofia.torres@gmail.com', 1),
(4, 39541236, 'Matías', 'Domínguez', '1101234567', 'matias.dominguez@gmail.com', 1),
(5, 42369874, 'Julieta', 'Acosta', '1112345678', 'julieta.acosta@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `propietarios`
--

CREATE TABLE `propietarios` (
  `id` int(11) NOT NULL,
  `DNI` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `propietarios`
--

INSERT INTO `propietarios` (`id`, `DNI`, `nombre`, `apellido`, `telefono`, `email`, `estado`) VALUES
(2, 37775452, 'Pio Ricardo', 'Baroja', '2657545454', 'pio@gmail.com', 1),
(3, 44565245, 'Matias', 'Corvalan', '2664525742', 'marcoteca@hotmail.com', 1),
(4, 30456987, 'Carlos', 'Gómez', '1123456789', 'carlos.gomez@gmail.com', 1),
(5, 28975643, 'María', 'Fernández', '1134567890', 'maria.fernandez@gmail.com', 1),
(6, 31547896, 'Jorge', 'Pérez', '1145678901', 'jorge.perez@gmail.com', 1),
(7, 27654321, 'Ana', 'Martínez', '1156789012', 'ana.martinez@gmail.com', 1),
(8, 33214567, 'Ricardo', 'López', '1167890123', 'ricardo.lopez@gmail.com', 1),
(9, 39137714, 'Angel', 'Baroja', '2664525742', 'Angel@gmail.com', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idInmueble` (`idInmueble`),
  ADD KEY `idInquilino` (`idInquilino`);

--
-- Indexes for table `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `InmuebleId` (`InmuebleId`);

--
-- Indexes for table `inmuebles`
--
ALTER TABLE `inmuebles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idPropietario` (`idPropietario`),
  ADD KEY `idImagen` (`idImagen`);

--
-- Indexes for table `inquilinos`
--
ALTER TABLE `inquilinos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `propietarios`
--
ALTER TABLE `propietarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `inmuebles`
--
ALTER TABLE `inmuebles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `inquilinos`
--
ALTER TABLE `inquilinos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `propietarios`
--
ALTER TABLE `propietarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `contratos_ibfk_1` FOREIGN KEY (`idInmueble`) REFERENCES `inmuebles` (`id`),
  ADD CONSTRAINT `contratos_ibfk_2` FOREIGN KEY (`idInquilino`) REFERENCES `inquilinos` (`id`);

--
-- Constraints for table `imagenes`
--
ALTER TABLE `imagenes`
  ADD CONSTRAINT `imagenes_ibfk_1` FOREIGN KEY (`InmuebleId`) REFERENCES `inmuebles` (`id`);

--
-- Constraints for table `inmuebles`
--
ALTER TABLE `inmuebles`
  ADD CONSTRAINT `inmuebles_ibfk_1` FOREIGN KEY (`idPropietario`) REFERENCES `propietarios` (`id`),
  ADD CONSTRAINT `inmuebles_ibfk_2` FOREIGN KEY (`idImagen`) REFERENCES `imagenes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

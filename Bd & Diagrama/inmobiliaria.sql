-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 22, 2025 at 11:37 PM
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
(2, 37775452, 'Pio', 'Baroja', '2657545454', 'pio@gmail.com', 1),
(3, 44565245, 'Matias', 'Corvalan', '2664525742', 'marcoteca@hotmail.com', 1),
(4, 30456987, 'Carlos', 'Gómez', '1123456789', 'carlos.gomez@gmail.com', 1),
(5, 28975643, 'María', 'Fernández', '1134567890', 'maria.fernandez@gmail.com', 1),
(6, 31547896, 'Jorge', 'Pérez', '1145678901', 'jorge.perez@gmail.com', 1),
(7, 27654321, 'Ana', 'Martínez', '1156789012', 'ana.martinez@gmail.com', 1),
(8, 33214567, 'Ricardo', 'López', '1167890123', 'ricardo.lopez@gmail.com', 1);

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `inquilinos`
--
ALTER TABLE `inquilinos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `propietarios`
--
ALTER TABLE `propietarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

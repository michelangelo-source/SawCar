-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2024 at 11:07 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sawcar`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPAddCar` (IN `brand` VARCHAR(255), IN `model` VARCHAR(255), IN `generation` INT, IN `startYear` YEAR, IN `endYear` YEAR)   BEGIN
INSERT INTO car_brand SELECT NULL,brand WHERE NOT EXISTS ( SELECT 1 FROM car_brand WHERE Brand = brand );
INSERT INTO car_model SELECT NULL,(SELECT car_brand.Id FROM car_brand WHERE car_brand.Brand=brand),model WHERE NOT EXISTS ( SELECT 1 FROM car_model WHERE Model = model );

INSERT INTO car_generation SELECT NULL,(SELECT car_brand.Id FROM car_brand WHERE car_brand.Brand=brand),(SELECT car_model.Id FROM car_model WHERE car_model.Model=model),generation,startYear,endYear WHERE NOT EXISTS ( SELECT 1 FROM car_generation WHERE car_generation.Id=generation AND car_generation.Brand_Id=(SELECT car_brand.Id FROM car_brand WHERE car_brand.Brand=brand) AND car_generation.Model_Id= (SELECT car_model.Id FROM car_model WHERE car_model.Model=model));
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `car_brand`
--

CREATE TABLE `car_brand` (
  `Id` double NOT NULL,
  `Brand` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car_brand`
--

INSERT INTO `car_brand` (`Id`, `Brand`) VALUES
(1, 'Fiat');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `car_generation`
--

CREATE TABLE `car_generation` (
  `Id` double NOT NULL,
  `Brand_Id` double NOT NULL,
  `Model_Id` double NOT NULL,
  `Ganeration` int(11) NOT NULL,
  `Start_Year` year(4) NOT NULL,
  `End_Year` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car_generation`
--

INSERT INTO `car_generation` (`Id`, `Brand_Id`, `Model_Id`, `Ganeration`, `Start_Year`, `End_Year`) VALUES
(1, 1, 1, 1, '2015', '2024'),
(3, 1, 1, 4, '2015', '2024');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `car_model`
--

CREATE TABLE `car_model` (
  `Id` double NOT NULL,
  `Brand_Id` double NOT NULL,
  `Model` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car_model`
--

INSERT INTO `car_model` (`Id`, `Brand_Id`, `Model`) VALUES
(1, 1, 'Tipo');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `follows`
--

CREATE TABLE `follows` (
  `ID` double NOT NULL,
  `UserID` double NOT NULL,
  `Followed_UserdID` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `follows`
--

INSERT INTO `follows` (`ID`, `UserID`, `Followed_UserdID`) VALUES
(4, 2, 4),
(5, 2, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tokens`
--

CREATE TABLE `tokens` (
  `ID` double NOT NULL,
  `userID` double NOT NULL,
  `token` varchar(255) NOT NULL,
  `generate_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`ID`, `userID`, `token`, `generate_date`, `is_active`) VALUES
(1, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjA5MTc3MSwiZXhwIjoxNzEyMDkzMjExfQ.MhkVrFuRM8O8VNihLQPbcDqov-srY9Lnml1xXDDFHvA', '2024-04-02', 0),
(2, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjA5MTgxMywiZXhwIjoxNzEyMDkzMjUzfQ.5IgvU5Cif3U52D3yep5qKjHM7XmKg8eTsxoD7CRN698', '2024-04-02', 0),
(3, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjA5MjE1MiwiZXhwIjoxNzEyMDkzNTkyfQ.XWciiUqj6V3LJmnfALaSlS3HL1lLWfD74yzHotCY4RQ', '2024-04-02', 0),
(4, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjA5MzMzOSwiZXhwIjoxNzEyMDk0Nzc5fQ.0844HxePnyTTvB7xg0yifbu43M_PyJEggYdGsDy-164', '2024-04-02', 0),
(5, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxMjA5MzM4MSwiZXhwIjoxNzEyMDk0ODIxfQ.IVtX4g94QHO3qfc8skPIIbVKzDsf76q18ppznp3EmG8', '2024-04-02', 0),
(6, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjA5NDI3MCwiZXhwIjoxNzEyMDk1NzEwfQ.57s4dHrIA6rGRNnQXh4OIwlnvr6yMNEarlRNpzS42dk', '2024-04-02', 0),
(7, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxMjA5NDMwNywiZXhwIjoxNzEyMDk1NzQ3fQ.w_QYBhyH62NS6ioTycNrJolnbOFz-_0u2kXSB5OowhU', '2024-04-02', 0),
(8, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjA5NDQ3OSwiZXhwIjoxNzEyMDk1OTE5fQ.967OxDfQEobDor0DBZV4LELKdSrqxYZv5IETzcbXdiU', '2024-04-02', 0),
(9, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxMjA5NDUxOCwiZXhwIjoxNzEyMDk1OTU4fQ.6-Q9qyF1dRM7myBPJ4bbGi70l0o1mxyrZMjxy5r6QL4', '2024-04-02', 0),
(10, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxMzk2OSwiZXhwIjoxNzEyMzE1NDA5fQ.66e2Zeif8vBgDnG1Oua544as8_SA0sbAa5gaIeq6WOU', '2024-04-05', 0),
(11, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNDE0OCwiZXhwIjoxNzEyMzE1NTg4fQ.3BdNEWaIVFolZSoPwEqltCwiBNgaZ2DBzZ33WUZLElw', '2024-04-05', 0),
(12, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNDI3MiwiZXhwIjoxNzEyMzE1NzEyfQ.zkwGSRbf2WC4UbzR1vOFpK9rfWFvmSNwnCWCoY5tD8A', '2024-04-05', 0),
(13, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNDk3NSwiZXhwIjoxNzEyMzE2NDE1fQ.ams_uJ4ehaLdWYRx1yJHQex9olOTX_M9BeRd_zpnxds', '2024-04-05', 0),
(14, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNTU2NiwiZXhwIjoxNzEyMzE3MDA2fQ.uV_5moMlVzEg9KxU2oaSkjJG_wDIMgmt-qz0_GU_ZQ0', '2024-04-05', 0),
(15, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNTY0NSwiZXhwIjoxNzEyMzE3MDg1fQ.XRa7qZGPyu33c2SyjOK0WkglL75vplLgmsgdrLEteKI', '2024-04-05', 0),
(16, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNTg3MCwiZXhwIjoxNzEyMzE3MzEwfQ.dk4iHM-JPRmDHoFyn4A4DswwcUffGOzuKHJveOdGEQg', '2024-04-05', 0),
(17, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNTg3MiwiZXhwIjoxNzEyMzE3MzEyfQ.v9IsVe6dNtfxjURIjs8y_Hiw-ptD6imGbmwnH5nsNuM', '2024-04-05', 0),
(18, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNTk2MiwiZXhwIjoxNzEyMzE3NDAyfQ.WsCVxUvNCEtw9Etg6cKQK6rELdknc9Ni7dV_UohjsL0', '2024-04-05', 0),
(19, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNTk2NCwiZXhwIjoxNzEyMzE3NDA0fQ.N61Esi07TJO8_PpIhnlCK1d2iF4U7QUVEQrneQrj0FE', '2024-04-05', 0),
(20, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNjEwOCwiZXhwIjoxNzEyMzE3NTQ4fQ.YzUBToHrpmv3FOTEPCBFFh4urwy4zJu0wjmOpy8Pg9E', '2024-04-05', 0),
(21, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNjExMywiZXhwIjoxNzEyMzE3NTUzfQ.lAgJtCxQ2OvI_PYNCaN-zJdsT2GPu7PPtAKDaJAQ5mg', '2024-04-05', 0),
(22, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNjIwNiwiZXhwIjoxNzEyMzE3NjQ2fQ.FNCjgj_Oi3T7LpAzAWW-_mRiNB5HQATNb3jJZsb9IjM', '2024-04-05', 0),
(23, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNjIxMSwiZXhwIjoxNzEyMzE3NjUxfQ.DbVBHIxMCo_X0Iv_uGYxL9jU2xEihomOIG7bkyZpUxM', '2024-04-05', 0),
(24, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxMjMxNjU3NSwiZXhwIjoxNzEyMzE4MDE1fQ.LqfHm7d0B2RsHYHL8rjX6GYS7bNX2htF0iOqtzuuAZU', '2024-04-05', 0),
(25, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMjMxNjcyNCwiZXhwIjoxNzEyMzE4MTY0fQ.6AbX3ELUQJjxi3BMAbzpouCcqfY75FjT_ccdcdwfgRY', '2024-04-05', 0),
(26, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5MTcwMCwiZXhwIjoxNzEzODkzMTQwfQ.18JlJp2nxii1dZxsenurpqLvxU9lG0wySsCohLRast4', '2024-04-23', 0),
(27, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5MTcxMywiZXhwIjoxNzEzODkzMTUzfQ.ZDGyyzMy_BfR-OGe0x2qRL43lWQ9xuq-y-VitJGLpCk', '2024-04-23', 0),
(28, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5MTcxOSwiZXhwIjoxNzEzODkzMTU5fQ.Mr8xIIVu-qO4eZroXhXArTEf9Xzy0U23D1029MqoYLU', '2024-04-23', 0),
(29, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5MTcyMSwiZXhwIjoxNzEzODkzMTYxfQ.xfIV4VJ_k23whOk88qJfDZrcaj504gXtBaTv2VE4JJw', '2024-04-23', 0),
(30, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5MjcxMCwiZXhwIjoxNzEzODk0MTUwfQ.dyLpd4ViYt1NIAevBAzjt9shyWViDPm5PYCXivF76Ek', '2024-04-23', 0),
(31, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5MzE3MiwiZXhwIjoxNzEzODk0NjEyfQ.S4OQfVEEWyKAXyNRRQzaHgT_I1DF5xcPhyb0jzSOvW0', '2024-04-23', 0),
(32, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5MzE3OCwiZXhwIjoxNzEzODk0NjE4fQ.tMkeJSM5W1onTg6bOxBiXN03OzZOzaIOZ3PomH1HgDA', '2024-04-23', 0),
(33, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5NDI5OCwiZXhwIjoxNzEzODk1NzM4fQ.cnHL-2SXj2E1iCVhoETGW0wQ42oVZdy11EzlTH7Le38', '2024-04-23', 0),
(34, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5NDMxNSwiZXhwIjoxNzEzODk1NzU1fQ.5LID1VIvuudd9non3tdjaHztycQiBL6xbt-u9IyZCVE', '2024-04-23', 0),
(35, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5NDMxNywiZXhwIjoxNzEzODk1NzU3fQ.AgokaJBVIRbb1n6i5brDT6SXC-AcnBTm_yYgiX3ars4', '2024-04-23', 0),
(36, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5NDMxOCwiZXhwIjoxNzEzODk1NzU4fQ.---BwC5qxeK_F9fGRfbhVy86Slad_MouwI3CpRwHg1M', '2024-04-23', 0),
(37, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5NDM4OSwiZXhwIjoxNzEzODk1ODI5fQ.I4C1qaLFaP2B91EVIPqqTgFP5ceHr-SfiQR9jJY_V-o', '2024-04-23', 0),
(38, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5NDQzMywiZXhwIjoxNzEzODk1ODczfQ.QRJB2CtQmAPldVxraxfRPBKPvNlyI__HW6cxKHkPFbU', '2024-04-23', 0),
(39, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5NDQzNCwiZXhwIjoxNzEzODk1ODc0fQ.ZMwCdcxlZQETLYaLDPS-ip-VkUoopgrM0GZ0vZN4Dwo', '2024-04-23', 0),
(40, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxMzg5NDQ0NywiZXhwIjoxNzEzODk1ODg3fQ.UW1oIwb1K3trmAzQmf_Cm2TcJWsZjfdAZUGj41RcC20', '2024-04-23', 0),
(41, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MDk2NywiZXhwIjoxNzE0MDYyNDA3fQ.q26AOrrQVSJmb3R6mbJc4fkW_ovVM4IoIpU4j8_AsE0', '2024-04-25', 0),
(42, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MTAxMSwiZXhwIjoxNzE0MDYyNDUxfQ.99Xem6lYqpJx-tpIFPu_fumraGMFs8-3RsUwthXupB4', '2024-04-25', 0),
(43, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MTA4MCwiZXhwIjoxNzE0MDYyNTIwfQ.7hR6olUVh6joEwffUN0V-q6vAsNRCMILKHABCJovQuc', '2024-04-25', 0),
(44, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MTIwMSwiZXhwIjoxNzE0MDYyNjQxfQ.UMK2FHLD_mifn6cfB6xHSpIUhmM7SRC37pZHa0S6qiY', '2024-04-25', 0),
(45, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MTI5MCwiZXhwIjoxNzE0MDYyNzMwfQ.s2X6Wa3b3Sn9tE7kRysjWjafgamIYyC4eib0G9Cku2k', '2024-04-25', 0),
(46, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MTM5OCwiZXhwIjoxNzE0MDYyODM4fQ.zbPxez4v0Dwkwf5HtMdTjKapqdJ5JiTPAJHHeYig6aw', '2024-04-25', 0),
(47, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MTQ1MiwiZXhwIjoxNzE0MDYyODkyfQ.tH5wMY3xQefws3TpQEXeEnzqtgaGCdfUfbTF6-SJyaw', '2024-04-25', 0),
(48, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MTQ4NCwiZXhwIjoxNzE0MDYyOTI0fQ.TuWS6n9SvRuK2HC8PZUxcGiJaJqzc1usijk5cbO8bvc', '2024-04-25', 0),
(49, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MjA0MCwiZXhwIjoxNzE0MDYzNDgwfQ.GvlYz-yKdI4PKA8aDe3NrvcssH7s_3EOqfmOM5jgVgE', '2024-04-25', 0),
(50, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MjEyNCwiZXhwIjoxNzE0MDYzNTY0fQ.PjZZInCnyQqwAZPN-mt4ZOsdzNgw49UF3PxdIfmXowA', '2024-04-25', 0),
(51, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MjI2MCwiZXhwIjoxNzE0MDYzNzAwfQ.OJaKXlXsYT6EJUY48fpjmEUS2Ek0_GZEkWQ66-WqYCY', '2024-04-25', 0),
(52, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MjYxNiwiZXhwIjoxNzE0MDY0MDU2fQ.J-hSN9O-N-01ymYBx9Wu_HVFsdJegUCDToPY-XVjMd8', '2024-04-25', 0),
(53, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MjcwOCwiZXhwIjoxNzE0MDY0MTQ4fQ.wb-90Ca1vzdESHSpNGk3YdyHhBJiZ-8Rnr_JGwTM6Dc', '2024-04-25', 0),
(54, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2Mjc5NSwiZXhwIjoxNzE0MDY0MjM1fQ.LCPWazfn0gA0qsn9WuKYlZZh-z6N3snj7QBana8TwMw', '2024-04-25', 0),
(55, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MjkxMiwiZXhwIjoxNzE0MDY0MzUyfQ.qRw6WMn2xwAwfsFmfwgIEcB0_gqOrTj0c4lWyNlMDO4', '2024-04-25', 0),
(56, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2Mjk1OSwiZXhwIjoxNzE0MDY0Mzk5fQ.gljFZmj62pgEScaKQWHOUZMIKAls0Azovt-7L_dLwUs', '2024-04-25', 0),
(57, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MzA3MCwiZXhwIjoxNzE0MDY0NTEwfQ.-JiDVv_FQ4lnW-9Gqbh5qHucHh9UJLSSCZBuz_hUlcg', '2024-04-25', 0),
(58, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MzQ5NiwiZXhwIjoxNzE0MDY0OTM2fQ.n4TtEM3kpx-DU7jDgp9cDAX0I7fv0m4uKHoQp5CwchY', '2024-04-25', 0),
(59, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MzcwNywiZXhwIjoxNzE0MDY1MTQ3fQ._PE1ErQLdOVvg8c6CDZzzngbazUwA7UZFMiARdKD09Q', '2024-04-25', 0),
(60, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2Mzc2MiwiZXhwIjoxNzE0MDY1MjAyfQ.gnOMPSpdDavk909_1JcbUkkIxxoT_hsexyknvUk26Zk', '2024-04-25', 0),
(61, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MzgwOCwiZXhwIjoxNzE0MDY1MjQ4fQ.vrAnsG8NRPI9rZjcm9hdP-uQH8qc1wMWXOnuLW0Ekiw', '2024-04-25', 0),
(62, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2MzgzOSwiZXhwIjoxNzE0MDY1Mjc5fQ.fuTnw2geUHEPNCTf7w0kZfripjsbcFK93tfT8iFjwXA', '2024-04-25', 0),
(63, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2NzQ4MiwiZXhwIjoxNzE0MDY4OTIyfQ.AaEr0W3o-6gRdLGa-pitcezi1f03ty0X_mfuil3qVsI', '2024-04-25', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `ID` double UNSIGNED NOT NULL,
  `NickName` text NOT NULL,
  `Email` text NOT NULL,
  `Password` text NOT NULL,
  `Type` text NOT NULL DEFAULT 'User',
  `name` text NOT NULL,
  `surname` text NOT NULL,
  `can_be_found` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `NickName`, `Email`, `Password`, `Type`, `name`, `surname`, `can_be_found`) VALUES
(1, 'qq', 'qq', '$2a$10$pHAns0fYZIAq/kmrO46OPeDs04EBHPTFoyPCijPzgs3fqsQZmAIWm', 'USER', 'qq', 'qq', 1),
(2, 'admin', 'admin@sawcar.pl', '$2a$10$9SUp6ehxtDzE/kK.OcPqiOCzllzsOK8XajVJhKhnYQlmGho/p6Ssa', 'ADMIN', 'ADMIN', 'ADMIN', 0),
(3, 'moderator', 'moderator@sawcar.pl', '$2a$10$dI2EiXvypoRgEO1vDOFFEOXCJ02D6j0Y8H0/tnffe45UGLVzD7f7y', 'MODERATOR', 'moderator', 'moderator', 0),
(4, 'Guido', 'tgacek@sawcar.pl', '$2a$10$.tjx6/nZL7.4uRcwBKSd4u0MbE3sDYYhIQ0Amy6pWcIl0l29aRpou', 'USER', 'Tomek', 'Gacek', 1),
(6, 'tomek', 'tomek@sawcar.pl', '$2a$10$5pp/G9cKvJfy3SMQv9HUje17j9ZVSC8e5pn/M9GrtfuWtW5P71tCS', 'USER', 'tomek', 'tomek', 1),
(7, 'dar3cz3q', 'dar@gmail.com', '$2a$10$TS4A9yoNMytFSwBLtm9U0.grUUOPWIs/eyk/Z5tkR.PHfEnvZHG6m', 'USER', 'Darek', 'Homa', 1),
(8, 'Guido2', 'tgacek2@sawcar.pl', '$2a$10$FpS6yZW0F32Gue/u6pJJqet2/kBZpLcBwDPuMNXvuO3VObN4lnWY6', 'USER', 'Tomek', 'Gacek', 1),
(9, '', '', '$2a$10$L8YZ4zFOJUALBG3GAPnNwedvrwSiirh4..4oShDiRtoNzcGYVhcz.', 'USER', '', '', 1);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `car_brand`
--
ALTER TABLE `car_brand`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Brand` (`Brand`);

--
-- Indeksy dla tabeli `car_generation`
--
ALTER TABLE `car_generation`
  ADD PRIMARY KEY (`Id`);

--
-- Indeksy dla tabeli `car_model`
--
ALTER TABLE `car_model`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Model` (`Model`);

--
-- Indeksy dla tabeli `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `NickName` (`NickName`) USING HASH,
  ADD UNIQUE KEY `Email` (`Email`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `car_brand`
--
ALTER TABLE `car_brand`
  MODIFY `Id` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `car_generation`
--
ALTER TABLE `car_generation`
  MODIFY `Id` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `car_model`
--
ALTER TABLE `car_model`
  MODIFY `Id` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `follows`
--
ALTER TABLE `follows`
  MODIFY `ID` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `ID` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` double UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Cze 09, 2024 at 03:07 PM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPAddCar` (IN `brandPROCEDURE` VARCHAR(255), IN `modelPROCEDURE` VARCHAR(255), IN `generationPROCEDURE` INT, IN `startYearPROCEDURE` INT, IN `endYearPROCEDURE` INT)   BEGIN
    DECLARE brandId INT DEFAULT NULL;
    DECLARE modelId INT DEFAULT NULL;

    -- Sprawdzenie istnienia marki
    SELECT Id INTO brandId FROM car_brand WHERE Brand = brandPROCEDURE LIMIT 1;
    
    -- Jeśli marka nie istnieje, dodaj ją
    IF brandId IS NULL THEN 
        INSERT INTO car_brand (Brand) VALUES (brandPROCEDURE);
        SELECT LAST_INSERT_ID() INTO brandId; -- Pobierz ID ostatnio wstawionego rekordu
    END IF;

    -- Sprawdzenie istnienia modelu
    SELECT Id INTO modelId FROM car_model WHERE Model = modelPROCEDURE AND Brand_Id = brandId LIMIT 1;

    -- Jeśli model nie istnieje, dodaj go
    IF modelId IS NULL THEN 
        INSERT INTO car_model (Brand_Id, Model) VALUES (brandId, modelPROCEDURE);
        SELECT LAST_INSERT_ID() INTO modelId; -- Pobierz ID ostatnio wstawionego rekordu
    END IF;

    -- Sprawdzenie istnienia generacji
    IF NOT EXISTS (
        SELECT 1
        FROM car_generation
        WHERE Generation = generationPROCEDURE
          AND Brand_Id = brandId
          AND Model_Id = modelId
    ) THEN
        INSERT INTO car_generation (Brand_Id, Model_Id, Generation, Start_Year, End_Year)
        VALUES (brandId, modelId, generationPROCEDURE, startYearPROCEDURE, endYearPROCEDURE);
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `car_brand`
--

CREATE TABLE `car_brand` (
  `Id` int(11) NOT NULL,
  `Brand` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car_brand`
--

INSERT INTO `car_brand` (`Id`, `Brand`) VALUES
(3, 'Ferrari'),
(2, 'Fiat'),
(7, 'Ford'),
(5, 'Honda'),
(6, 'Lamborghini'),
(4, 'Seat'),
(1, 'Volkswagen');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `car_generation`
--

CREATE TABLE `car_generation` (
  `Id` int(11) NOT NULL,
  `Brand_Id` int(11) DEFAULT NULL,
  `Model_Id` int(11) DEFAULT NULL,
  `Generation` int(11) DEFAULT NULL,
  `Start_Year` int(11) DEFAULT NULL,
  `End_Year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car_generation`
--

INSERT INTO `car_generation` (`Id`, `Brand_Id`, `Model_Id`, `Generation`, `Start_Year`, `End_Year`) VALUES
(1, 1, 1, 2, 1983, 1992),
(2, 2, 2, 1, 2015, 2024),
(3, 2, 3, 2, 1993, 1999),
(4, 3, 4, 1, 2020, 2024),
(5, 1, 5, 1, 1973, 1988),
(6, 1, 5, 2, 1979, 1988),
(7, 1, 5, 5, 1996, 2005),
(8, 4, 6, 1, 1999, 2006),
(9, 5, 7, 8, 2006, 2011),
(10, 6, 8, 1, 2001, 2010),
(11, 7, 9, 1, 2004, 2006);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `car_model`
--

CREATE TABLE `car_model` (
  `Id` int(11) NOT NULL,
  `Brand_Id` int(11) DEFAULT NULL,
  `Model` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car_model`
--

INSERT INTO `car_model` (`Id`, `Brand_Id`, `Model`) VALUES
(1, 1, 'Golf'),
(5, 1, 'Passat'),
(3, 2, 'Punto'),
(2, 2, 'Tipo'),
(4, 3, 'SF90'),
(6, 4, 'Leon'),
(7, 5, 'Civic'),
(8, 6, 'Murcielago'),
(9, 7, 'GT');

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
(5, 2, 1),
(7, 4, 6),
(9, 4, 4),
(10, 10, 10);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `seen`
--

CREATE TABLE `seen` (
  `Id` double NOT NULL,
  `user_id` double NOT NULL,
  `text` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `brand_id` double NOT NULL,
  `model_id` double NOT NULL,
  `generation_id` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seen`
--

INSERT INTO `seen` (`Id`, `user_id`, `text`, `filename`, `date`, `brand_id`, `model_id`, `generation_id`) VALUES
(3, 6, 'Żółty błysk ', '1.jpg', '2024-06-06', 3, 4, 4),
(4, 6, 'Sf90', '2.jpg', '2024-06-06', 3, 4, 4),
(5, 6, 'ferrrrrari', '3.jpg', '2024-06-06', 3, 4, 4),
(6, 8, 'autko', '4.jpg', '2024-06-06', 3, 4, 4),
(7, 6, 'Ty to jest civic', '5.jpg', '2024-06-07', 5, 7, 9),
(8, 4, 'Passeratti', '6.jpg', '2024-06-09', 1, 5, 7),
(9, 10, 'Lambo', '7.jpg', '2024-06-09', 6, 8, 10),
(10, 4, 'FordGT', '8.jpg', '2024-06-09', 7, 9, 11);

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
(63, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNDA2NzQ4MiwiZXhwIjoxNzE0MDY4OTIyfQ.AaEr0W3o-6gRdLGa-pitcezi1f03ty0X_mfuil3qVsI', '2024-04-25', 0),
(64, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzQxNjIyNiwiZXhwIjoxNzE3NDE3NjY2fQ.KjfIhvOkNn-lr2BJJqGksJFITMXEK1siAVciXu5zsJ0', '2024-06-03', 0),
(65, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzQxNjUyMiwiZXhwIjoxNzE3NDE3OTYyfQ.27trKcUYhu-5PDvvO5cffhfsNgBqyEbb8QnYKMAs0uY', '2024-06-03', 0),
(66, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzQxODAzOCwiZXhwIjoxNzE3NDE5NDc4fQ.icylaHaga5yr2rGf3VOeHE-9UrK2BhSHzASfta_4Ly4', '2024-06-03', 0),
(67, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzQxOTcxMSwiZXhwIjoxNzE3NDIxMTUxfQ.GoJHEIGq0psN3Itn6Y3hdXkZ6u5NMJjJl_FxOBJso6E', '2024-06-03', 0),
(68, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzQyMDc2OCwiZXhwIjoxNzE3NDIyMjA4fQ.ahVeNNd3o2PnwZv2MNsM3izGMp8hrwHzCA84EspOjhQ', '2024-06-03', 0),
(69, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzQzNzExMywiZXhwIjoxNzE3NDM4NTUzfQ.TAcD6WH5vJWcMqqEctcoE18FJHaDv182PvFzJkpyKE8', '2024-06-03', 0),
(70, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzQzOTU1NSwiZXhwIjoxNzE3NDQwOTk1fQ._Lye05-jafyxl7ct-cP-__5OieMh7XxjYkLwjZL8MiM', '2024-06-03', 0),
(71, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4MjEwMywiZXhwIjoxNzE3NTgzNTQzfQ.mjS85JUtdt_3IbhRj8APCXSHly0-u-BMqzr6EFoqYTc', '2024-06-05', 0),
(72, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4MjE1NywiZXhwIjoxNzE3NTgzNTk3fQ.LS3HKP0Moyzoso1x3-ciUrpxPGyRL7mmypNhPQt5DKc', '2024-06-05', 0),
(73, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4Mjc0MSwiZXhwIjoxNzE3NTg0MTgxfQ.jFaYAHRF-PIo6CuPtiLzpzi1x7kdV8N628h-zW3qnw0', '2024-06-05', 0),
(74, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4MjgwMywiZXhwIjoxNzE3NTg0MjQzfQ.TLq3wAcHjEgPAAeTS_3F1BEV28_0dEHRS4hMI_SJjs8', '2024-06-05', 0),
(75, 3, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtb2RlcmF0b3IiLCJpYXQiOjE3MTc1ODI4NzYsImV4cCI6MTcxNzU4NDMxNn0.IW8N-0Y5HrLMyuLJxCMla4ffkSxJm8WJxGX4_Bc33ME', '2024-06-05', 0),
(76, 3, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtb2RlcmF0b3IiLCJpYXQiOjE3MTc1ODM1MzQsImV4cCI6MTcxNzU4NDk3NH0.BCfWHxS_7IpBcsbQBM8xCsSVsOdRm63AX5w3kgAX_3E', '2024-06-05', 0),
(77, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4NDE2OCwiZXhwIjoxNzE3NTg1NjA4fQ.RCYShs2bY_15jdhwsiVpqS7wvvXP5FlMGnbB-vwby-k', '2024-06-05', 0),
(78, 3, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtb2RlcmF0b3IiLCJpYXQiOjE3MTc1ODQxODAsImV4cCI6MTcxNzU4NTYyMH0.R3QZO3vD4TYjtAecSQdkQ4oHbcHljfajWpKZa6zrkx8', '2024-06-05', 0),
(79, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4NDE5OSwiZXhwIjoxNzE3NTg1NjM5fQ.162seCfLUvlkCKn7OCZ988cmIlzKg-3q5MA_O_rA2as', '2024-06-05', 0),
(80, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4NDM4NiwiZXhwIjoxNzE3NTg1ODI2fQ.9wfTdujytS_ZKed26sP1wz5S9CxRAIInNWGpuL_O1rM', '2024-06-05', 0),
(81, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4NDM5MiwiZXhwIjoxNzE3NTg1ODMyfQ.YgDvo2bJPmciAUPHZGrW7L1byoJ5YQZju_Oh9GhAn4k', '2024-06-05', 0),
(82, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4Njc3NywiZXhwIjoxNzE3NTg4MjE3fQ.xrmYe7_JACR_XO4uoW4wf-IJI55T_UCY50dQ_UaeTzQ', '2024-06-05', 0),
(83, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4NjkwMCwiZXhwIjoxNzE3NTg4MzQwfQ.LUV2J5-4zO8hdma4UEx_gURhcb0bgGIRWfg8dLn75X0', '2024-06-05', 0),
(84, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4NjkxNCwiZXhwIjoxNzE3NTg4MzU0fQ.xNHUJ4bRXjkL9OujKptLRopc_qY1eLLfY7QrZYOaNAI', '2024-06-05', 0),
(85, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4NjkxOSwiZXhwIjoxNzE3NTg4MzU5fQ.eg6Lmf0P1CTpw7k9CO0g_-TMjHh1IMqiyMmJIVxEvWQ', '2024-06-05', 0),
(86, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4Njk5MSwiZXhwIjoxNzE3NTg4NDMxfQ.ByGXbIt4ag_ZKG4p0zniEia-lkxC9k_4_Nx9JhViWjo', '2024-06-05', 0),
(87, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4NzAwMSwiZXhwIjoxNzE3NTg4NDQxfQ.h9_HJthdJiqvJJxfqxda9mhtqmRXAz0XnqOvsDNwDOs', '2024-06-05', 0),
(88, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4NzQzOSwiZXhwIjoxNzE3NTg4ODc5fQ.K2gOP-L0uesaeMYN0WgEC1roDxArchzpCeP739HkScQ', '2024-06-05', 0),
(89, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4NzU5NywiZXhwIjoxNzE3NTg5MDM3fQ.ZYUYj1InMk1FsvtmYAscKd-C3Usr33lb1DaMnUjpmwc', '2024-06-05', 0),
(90, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4NzYyNywiZXhwIjoxNzE3NTg5MDY3fQ.PuPbBGr0K1nRRnZQJYyjyzGRHpkKsAcwhDVSBN5AloY', '2024-06-05', 0),
(91, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4Nzg1NSwiZXhwIjoxNzE3NTg5Mjk1fQ.9eVqGiqQOEXaC5f0uTyQRE94s7zjeH2lk9Qgu_pEtyM', '2024-06-05', 0),
(92, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4Nzg2MiwiZXhwIjoxNzE3NTg5MzAyfQ.7dR_xJQG4S586lowIs3NUxFOmIn7h-6tME98jBBhJRs', '2024-06-05', 0),
(93, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4Nzg3MSwiZXhwIjoxNzE3NTg5MzExfQ.kLOnLE5_kKquQGgQ9duLHLakSLFcGISAUIJPr8v03zk', '2024-06-05', 0),
(94, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4Nzg4OCwiZXhwIjoxNzE3NTg5MzI4fQ.zlMMpwMj_zbCHJ1Hy-r3i1cEBVy9DAJizsFsGKk-q5s', '2024-06-05', 0),
(95, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4ODA2MCwiZXhwIjoxNzE3NTg5NTAwfQ.ggxabAeJB2dutpz-6jAOlLJ-HgF2Z0B8UC6ooTT4USw', '2024-06-05', 0),
(96, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4ODEwMywiZXhwIjoxNzE3NTg5NTQzfQ.aYYChfUwTV4Yu-KVT8ymNdsoeczqWry0-rCAcEfKhrM', '2024-06-05', 0),
(97, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4ODMwNiwiZXhwIjoxNzE3NTg5NzQ2fQ.Khs6SHnv29dBHBQp1_vkbaIC2-RUS8ImgU6G5OjQL58', '2024-06-05', 0),
(98, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU4OTYxOSwiZXhwIjoxNzE3NTkxMDU5fQ.F-IQAT3tmiuVNTkjG_Hg3GBHaF9hNAWd5RNhVKdV3p8', '2024-06-05', 0),
(99, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU4OTYzMCwiZXhwIjoxNzE3NTkxMDcwfQ.Y3ix3barnvAbnLp7pLUng7VIF8iQz5HwpnnGRW3mmc0', '2024-06-05', 0),
(100, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzU5MjIyNCwiZXhwIjoxNzE3NTkzNjY0fQ.6XBA2C7Hhp5k55oHjoQkkCWzdzHva3AV9cm5UMREIy0', '2024-06-05', 0),
(101, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzU5Mzc2OSwiZXhwIjoxNzE3NTk1MjA5fQ.n9NywO2UOx3v_mna5DI67XWDajKTYd7UHn_fr4y2bT8', '2024-06-05', 0),
(102, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzYxNjM0MywiZXhwIjoxNzE3NjE3NzgzfQ.8CXZXlYHBgbtM-axFxVzeMDIoFzdelPaE79ufyJX6n4', '2024-06-05', 0),
(103, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzYxNzgxMiwiZXhwIjoxNzE3NjE5MjUyfQ.6FlmUj2Fj6pp49m413wDyRXr3u8Jjs9MKo4-ZqOcqVg', '2024-06-05', 0),
(104, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzYyMTM0MiwiZXhwIjoxNzE3NjIyNzgyfQ.81LbUteMJoaSjyjLNC-A-pUhsUxP6ZCNBpEXAA2lOyI', '2024-06-05', 0),
(105, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzYyMzYwMCwiZXhwIjoxNzE3NjI1MDQwfQ.EJvUAKxcF2Vg_z5Ga86kHGmR2hml9TTx_kcfFgOh-F0', '2024-06-05', 0),
(106, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzYyMzc4OSwiZXhwIjoxNzE3NjI1MjI5fQ.W4MFwHG7JFnE7A0O4HR6KUuPtdhPs56DLGrSOvmTHxk', '2024-06-05', 0),
(107, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzYyMzg4NSwiZXhwIjoxNzE3NjI1MzI1fQ.nlt4p3gornF18h84CfnnFDWw6TrfLy_bwmhoVD5tr6s', '2024-06-05', 0),
(108, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzYyMzkxMywiZXhwIjoxNzE3NjI1MzUzfQ.qRzgZiexxyPydUv6RWSGtybs491fejhnIhNzNFaY7N0', '2024-06-05', 0),
(109, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzYyMzk0NywiZXhwIjoxNzE3NjI1Mzg3fQ.xK9E3_q6d1KI1_nLqIxOTeJnRyCmyZZlveu8UNiMjWY', '2024-06-05', 0),
(110, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzY4NzE3MiwiZXhwIjoxNzE3Njg4NjEyfQ.8Jx0JZpNHZO3R3Toi2swmvSc7_mMrntM1dsdR7Yj8AM', '2024-06-06', 0),
(111, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzY4NzcwMCwiZXhwIjoxNzE3Njg5MTQwfQ.U8d5hmns8BbnlyznRqHUlC0oB4KPGuQhkbXTy47mG4o', '2024-06-06', 0),
(112, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzY4NzcwOSwiZXhwIjoxNzE3Njg5MTQ5fQ.a2EQrSozDIyYnxSunfoZzqMjSiSru-v3cDDfjvHHhgs', '2024-06-06', 0),
(113, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzY5MDAzOSwiZXhwIjoxNzE3NjkxNDc5fQ.XVSS9ldWg6Hn9S0NDfkU51oX9dxdmq39uaz3xbBbArc', '2024-06-06', 0),
(114, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzY5MTAxMywiZXhwIjoxNzE3NjkyNDUzfQ.knztsl6fyvZilVLUKkQEpNOuBLV3PI3s9v98UR-qujw', '2024-06-06', 0),
(115, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzY5MjUwMywiZXhwIjoxNzE3NjkzOTQzfQ.mFCqVoDYII9O8H7jxI6wuIZQMSbIcQHZu2gDIsPWoV4', '2024-06-06', 0),
(116, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzY5Mzk1NiwiZXhwIjoxNzE3Njk1Mzk2fQ.WKyxRhxrJxKkn6LvAMSlSw0GSB_RbZLSyYEEmxstfo8', '2024-06-06', 0),
(117, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzY5NTUzMywiZXhwIjoxNzE3Njk2OTczfQ.MReNDHxIAsHd-XQEpUTHDqGW13BHUhFCPGpG0qJEP5g', '2024-06-06', 0),
(118, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzY5NjQ5MSwiZXhwIjoxNzE3Njk3OTMxfQ.yCxyp3g-QJPrEQv1OX-ZXRYNZoMeNciMMpYlTgb7O7k', '2024-06-06', 0),
(119, 6, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0b21layIsImlhdCI6MTcxNzcwODI1NSwiZXhwIjoxNzE3NzA5Njk1fQ.Ql8vp7iYiZNrQH1ZEx_HR_1ol9UbJSkcW4ojg51biCg', '2024-06-06', 0),
(120, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzcwODI4MiwiZXhwIjoxNzE3NzA5NzIyfQ.t53uuFjpd3z-18Gq43RhmRXzFe0qgzS1msNZLonzdVA', '2024-06-06', 0),
(121, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzcwODMxMywiZXhwIjoxNzE3NzA5NzUzfQ.3qAInIZmLPmRkvH_3243ZK7rp8xd5aDrSSu2bEa4rls', '2024-06-06', 0),
(122, 6, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0b21layIsImlhdCI6MTcxNzcwODMyMCwiZXhwIjoxNzE3NzA5NzYwfQ.8JUDBrMU72qVueUmiyzVhEuy-ZdMGUP1mMWYjET19ns', '2024-06-06', 0),
(123, 8, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbzIiLCJpYXQiOjE3MTc3MDg5ODMsImV4cCI6MTcxNzcxMDQyM30.7Ex1r4qDOiLHcXq6KC2qqgYD4lYxWk-n6rP0qC6Jwbc', '2024-06-06', 0),
(124, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzcwOTQ2NSwiZXhwIjoxNzE3NzEwOTA1fQ.iVqINsQpjkpauUSt0JjBvbcyTgWkXyDhLUDnHlU0FE4', '2024-06-06', 0),
(125, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzcxMDE3OCwiZXhwIjoxNzE3NzExNjE4fQ.tF1LftoX4MH0FnH7Ud2DX5d7xETPye-xwGH6dC28Ess', '2024-06-06', 0),
(126, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzcxMDE4NSwiZXhwIjoxNzE3NzExNjI1fQ.B248fQxr24GeZ_EkNkFfR6AFNEIGR2xNHL0856sU45k', '2024-06-06', 0),
(127, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzcxMTY2NCwiZXhwIjoxNzE3NzEzMTA0fQ.cCyWHDvmIdsHIYCVSUVwDNhZXPCRo0CtNafdMfYMXLI', '2024-06-07', 0),
(128, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzcxNDE1OSwiZXhwIjoxNzE3NzE1NTk5fQ.RmjqsDVwhRljLSaQ1he0mmyK5AdYmQ7OqsN6zvhF3rI', '2024-06-07', 0),
(129, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzcxNTY4MiwiZXhwIjoxNzE3NzE3MTIyfQ.mfBXZANSlnkx_6UfR_V2fs99AsMb6kXVCcX9d5-MWEM', '2024-06-07', 0),
(130, 6, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0b21layIsImlhdCI6MTcxNzcxNjEwNCwiZXhwIjoxNzE3NzE3NTQ0fQ.Xk9TfJtm_G9YkZaWgmBu0YIpTjXezX4F3aVtzAGliSg', '2024-06-07', 0),
(131, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzcxNjE2NiwiZXhwIjoxNzE3NzE3NjA2fQ.u9eLb3cJBPKRzCwYe_DcuX7U7TWDWYQGBCWLWvy1YTE', '2024-06-07', 0),
(132, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzMDYwOSwiZXhwIjoxNzE3OTMyMDQ5fQ.SQ_-1vsOMsd8uhmJBDmmj0I1g1DizDicVOk_N111jnc', '2024-06-09', 0),
(133, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzMTY3MiwiZXhwIjoxNzE3OTMzMTEyfQ.yLTzKBn99fRZzMITzA9fq8vtFaXmIcsnpZcHckShbTQ', '2024-06-09', 0),
(134, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzMTY3OCwiZXhwIjoxNzE3OTMzMTE4fQ.zuYYqHtvHt86i2IGv0M4wQv8Z7N5kEPEp6xASwNlZpw', '2024-06-09', 0),
(135, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzMzYwNSwiZXhwIjoxNzE3OTM1MDQ1fQ.0lETFI8K2wHFlagILEpQruUMkpvWuSeRiqj1ljk1ViI', '2024-06-09', 0),
(136, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzNDI2NiwiZXhwIjoxNzE3OTM1NzA2fQ.3sgYjngFnuabK_prpi2uc_S6v0EzaxzZgPaG0FYR8kw', '2024-06-09', 0),
(137, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzkzNDI3NywiZXhwIjoxNzE3OTM1NzE3fQ.LyRwfSo0T3Rs1JRaLOuXVAGdfMANkV0uiztdXVQYpvE', '2024-06-09', 0),
(138, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzNDQxMiwiZXhwIjoxNzE3OTM1ODUyfQ.PnYpFEbNW3Rx8j-2U9uhpuslgCkMrqLkI8xpDwOZz90', '2024-06-09', 0),
(139, 10, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJNaWNoYWwiLCJpYXQiOjE3MTc5MzQ5NDgsImV4cCI6MTcxNzkzNjM4OH0.zEdRH2KpEOlk3ti4aTRRJdLCpRDGpXh_hfFGJ3NlGjA', '2024-06-09', 0),
(140, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzkzNTA0OSwiZXhwIjoxNzE3OTM2NDg5fQ.28Bjf_TIS3tUJ0cAEVdXmGPBDzXkK-nZ5X-CAy9SimI', '2024-06-09', 0),
(141, 10, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJNaWNoYWwiLCJpYXQiOjE3MTc5MzUyODIsImV4cCI6MTcxNzkzNjcyMn0.Lr9V1qVAoDzJPqQmhcglHmH_O5_sUKqe8W8-q7Lejvc', '2024-06-09', 0),
(142, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzNTQ4MywiZXhwIjoxNzE3OTM2OTIzfQ.s9Srl5HGuiVYXKHhy3yxc7wNG7iU-R3fIbi3F-YTfdw', '2024-06-09', 0),
(143, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzkzNTY5NCwiZXhwIjoxNzE3OTM3MTM0fQ.tkBaA5ASgH7ibnsVunRITppum-U_xyLZSgFDlaxGXRI', '2024-06-09', 0),
(144, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzNTc1MiwiZXhwIjoxNzE3OTM3MTkyfQ.J9E0KI6uvCSbln3d5CxO4PmgTICRbIUCqciGxEhHmjM', '2024-06-09', 0),
(145, 4, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJHdWlkbyIsImlhdCI6MTcxNzkzNzUyNSwiZXhwIjoxNzE3OTM4OTY1fQ.IgAL9IDNqFMrgTvEfFL5iPxveJtb1cAYlOyjMNBBq2I', '2024-06-09', 0),
(146, 2, 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcxNzkzNzk2MSwiZXhwIjoxNzE3OTM5NDAxfQ.fZ7oNyIxVfnHmGPGORk8nxcuVGYXgGe75rGZjERy5gg', '2024-06-09', 0);

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
(10, 'Michal', 'mi@sawcar.pl', '$2a$10$Tm2eRjJ5IDjfn9xuxa9/UOBzM44AKMVg6zapbGI60SAhEItkCdl/m', 'USER', 'Michal', 'Michal', 1);

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
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Brand_Id` (`Brand_Id`,`Model_Id`,`Generation`),
  ADD KEY `Model_Id` (`Model_Id`);

--
-- Indeksy dla tabeli `car_model`
--
ALTER TABLE `car_model`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Brand_Id` (`Brand_Id`,`Model`);

--
-- Indeksy dla tabeli `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `seen`
--
ALTER TABLE `seen`
  ADD PRIMARY KEY (`Id`);

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
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `car_generation`
--
ALTER TABLE `car_generation`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `car_model`
--
ALTER TABLE `car_model`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `follows`
--
ALTER TABLE `follows`
  MODIFY `ID` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `seen`
--
ALTER TABLE `seen`
  MODIFY `Id` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `ID` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` double UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `car_generation`
--
ALTER TABLE `car_generation`
  ADD CONSTRAINT `car_generation_ibfk_1` FOREIGN KEY (`Brand_Id`) REFERENCES `car_brand` (`Id`),
  ADD CONSTRAINT `car_generation_ibfk_2` FOREIGN KEY (`Model_Id`) REFERENCES `car_model` (`Id`);

--
-- Constraints for table `car_model`
--
ALTER TABLE `car_model`
  ADD CONSTRAINT `car_model_ibfk_1` FOREIGN KEY (`Brand_Id`) REFERENCES `car_brand` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

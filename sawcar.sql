-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2024 at 10:48 AM
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
-- Database: `sawcar`
--

-- --------------------------------------------------------

--
-- Table structure for table `follows`
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
(2, 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `users`
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
(7, 'dar3cz3q', 'dar@gmail.com', '$2a$10$TS4A9yoNMytFSwBLtm9U0.grUUOPWIs/eyk/Z5tkR.PHfEnvZHG6m', 'USER', 'Darek', 'Homa', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `NickName` (`NickName`) USING HASH,
  ADD UNIQUE KEY `Email` (`Email`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `follows`
--
ALTER TABLE `follows`
  MODIFY `ID` double NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` double UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

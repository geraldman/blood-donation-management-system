-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2025 at 10:04 AM
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
-- Database: `blood_donation`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `admin_email` varchar(100) NOT NULL,
  `admin_password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_name`, `admin_email`, `admin_password`) VALUES
(1000, 'Gerald', 'gerald@gmail.com', 'geraldgerald');

-- --------------------------------------------------------

--
-- Table structure for table `blood`
--

CREATE TABLE `blood` (
  `blood_id` int(11) NOT NULL,
  `blood_name` varchar(100) NOT NULL,
  `blood_stock` int(11) DEFAULT NULL,
  `last_modified_by_admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blood`
--

INSERT INTO `blood` (`blood_id`, `blood_name`, `blood_stock`, `last_modified_by_admin_id`) VALUES
(1, 'A-', 102, 1000),
(2, 'A+', 90, 1000),
(3, 'B+', 2, 1000),
(4, 'B-', 2, 1000),
(5, 'AB+', 2, 1000),
(6, 'AB-', 3, 1000),
(7, 'O+', 2, 1000),
(8, 'O-', 2, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `donors`
--

CREATE TABLE `donors` (
  `donor_user_id` int(11) NOT NULL,
  `donor_last_donation_date` date NOT NULL,
  `donor_blood_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `donors`
--

INSERT INTO `donors` (`donor_user_id`, `donor_last_donation_date`, `donor_blood_id`) VALUES
(1, '2025-04-29', 1),
(1, '2025-05-20', 6);

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `request_id` int(11) NOT NULL,
  `requester_id` int(11) NOT NULL,
  `requester_blood_id` int(11) NOT NULL,
  `requested_blood_quantity` int(11) NOT NULL,
  `requested_blood_fullfiled` int(11) DEFAULT 0,
  `request_date` date DEFAULT NULL,
  `request_status` enum('Served','Pending','Cancelled') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`request_id`, `requester_id`, `requester_blood_id`, `requested_blood_quantity`, `requested_blood_fullfiled`, `request_date`, `request_status`) VALUES
(1, 2, 2, 20, 0, '2025-05-01', 'Pending'),
(2, 1, 1, 10, 0, '2025-05-06', 'Pending'),
(3, 2, 6, 3, 3, '2025-05-21', 'Served');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_email`, `user_password`) VALUES
(1, 'Excel Viryan', 'excelviryan@gmail.com', 'excelganteng'),
(2, 'Kevin Syonin', 'kevinsyonin@gmail.com', 'kevinganteng'),
(3, 'dcfvgbhjkm', 'sfksn@gmail.com', 'suyfbsgf');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `admin_email` (`admin_email`);

--
-- Indexes for table `blood`
--
ALTER TABLE `blood`
  ADD PRIMARY KEY (`blood_id`),
  ADD KEY `last_modified_by_admin_id` (`last_modified_by_admin_id`);

--
-- Indexes for table `donors`
--
ALTER TABLE `donors`
  ADD PRIMARY KEY (`donor_user_id`,`donor_last_donation_date`),
  ADD KEY `donor_blood_id` (`donor_blood_id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `requester_id` (`requester_id`),
  ADD KEY `requester_blood_id` (`requester_blood_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT for table `blood`
--
ALTER TABLE `blood`
  MODIFY `blood_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blood`
--
ALTER TABLE `blood`
  ADD CONSTRAINT `blood_ibfk_1` FOREIGN KEY (`last_modified_by_admin_id`) REFERENCES `admin` (`admin_id`);

--
-- Constraints for table `donors`
--
ALTER TABLE `donors`
  ADD CONSTRAINT `donors_ibfk_1` FOREIGN KEY (`donor_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `donors_ibfk_2` FOREIGN KEY (`donor_blood_id`) REFERENCES `blood` (`blood_id`);

--
-- Constraints for table `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`requester_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`requester_blood_id`) REFERENCES `blood` (`blood_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

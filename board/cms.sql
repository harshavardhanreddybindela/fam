-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2025 at 01:45 AM
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
-- Database: `cms`
--

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `branch_id` int(11) NOT NULL,
  `branch_name` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`branch_id`, `branch_name`) VALUES
(4, 'Artificial Intelligence'),
(5, 'CSE'),
(6, 'ECE'),
(7, 'Mechanical'),
(8, 'Civil'),
(9, 'IT'),
(10, 'Cyber Security'),
(11, 'Machine Learning'),
(12, 'EEE'),
(14, 'Embedded Systems '),
(34, 'MBA'),
(35, 'BA Finance'),
(36, 'Cloud Computing'),
(39, 'Data Science'),
(48, 'Algorithms'),
(49, 'Big Data Analytics'),
(50, 'Mathematics'),
(64, 'Block Chain'),
(72, 'Check Branch'),
(73, 'Check Branch'),
(74, 'Inserting'),
(75, 'branches'),
(76, 'branches'),
(77, 'ISE'),
(78, 'branches'),
(79, 'ISE'),
(80, 'FSD');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `city_id` int(25) NOT NULL,
  `city_name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`city_id`, `city_name`) VALUES
(1, 'Mumbai'),
(2, 'Pune'),
(3, 'Chennai'),
(4, 'Coimbatore'),
(5, 'Ahmedabad'),
(6, 'Surat'),
(7, 'Jaipur'),
(8, 'Udaipur'),
(9, 'Thiruvananthapuram'),
(10, 'Kochi'),
(11, 'Visakhapatnam'),
(12, 'Vijayawada');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `country_id` int(25) NOT NULL,
  `country_name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`country_id`, `country_name`) VALUES
(1, 'India'),
(2, 'USA');

-- --------------------------------------------------------

--
-- Table structure for table `country_states`
--

CREATE TABLE `country_states` (
  `country_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `country_states`
--

INSERT INTO `country_states` (`country_id`, `state_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `hobbies`
--

CREATE TABLE `hobbies` (
  `hobbies_id` int(10) NOT NULL,
  `hobby` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hobbies`
--

INSERT INTO `hobbies` (`hobbies_id`, `hobby`) VALUES
(1, 'Drawing'),
(2, 'Singing'),
(3, 'Dancing'),
(4, 'Sketching');

-- --------------------------------------------------------

--
-- Table structure for table `qualifications`
--

CREATE TABLE `qualifications` (
  `qualification_id` int(10) NOT NULL,
  `qualification` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `qualifications`
--

INSERT INTO `qualifications` (`qualification_id`, `qualification`) VALUES
(1, 'Highschool'),
(2, 'Higherschool'),
(3, 'Bachelors'),
(4, 'Masters'),
(5, 'Phd');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `state_id` int(25) NOT NULL,
  `state_name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`state_id`, `state_name`) VALUES
(1, 'Maharashtra'),
(2, 'Tamil Nadu'),
(3, 'Gujarat'),
(4, 'Rajasthan'),
(5, 'Kerala'),
(6, 'Andhra Pradesh');

-- --------------------------------------------------------

--
-- Table structure for table `state_cities`
--

CREATE TABLE `state_cities` (
  `state_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `state_cities`
--

INSERT INTO `state_cities` (`state_id`, `city_id`) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 11),
(6, 12);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `dob` date NOT NULL,
  `address` varchar(100) NOT NULL,
  `city` int(20) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `country` int(25) NOT NULL,
  `state` int(10) NOT NULL,
  `profile` mediumblob DEFAULT NULL,
  `branch_name` int(11) DEFAULT NULL,
  `qualification` int(11) DEFAULT NULL,
  `password` varchar(500) DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` int(10) DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `fname`, `lname`, `email`, `phone`, `gender`, `dob`, `address`, `city`, `pincode`, `country`, `state`, `profile`, `branch_name`, `qualification`, `password`, `created_on`, `created_by`, `updated_on`, `updated_by`, `is_admin`) VALUES
(156, '  Harsha  ', 'Reddy', 'harshareddy4400@gmail.com', '3145561111', 'male', '2024-04-16', '13 TDP', 3, '515411', 1, 2, '', 5, 3, '$argon2id$v=19$m=65536,t=3,p=4$Mejx2xF+/nwoByR9PSCihg$pXqRPFUNq4oB7Iq2ch4ML7wjl9o5paulAsMSgAc3a1g', '2024-04-04 21:02:45', NULL, NULL, NULL, 1),
(158, ' Nikhil ', 'Reddy', 'nikhil.reddy@gmail.com', '3146671121', 'male', '2024-04-01', '123', 1, '555155', 1, 1, '', 6, 4, '$argon2id$v=19$m=65536,t=3,p=4$varGBIBCfh8AS9tn4qWvxw$+JLG88bU6Ni5T2JJ3eh/x0BIspo0FVgFCtwN1cUHvqo', '2024-04-04 21:07:59', NULL, NULL, NULL, 0),
(159, 'Venkat', 'reddy', 'venkat211121@gmail.com', '3146679555', 'male', '2024-04-01', '123', 12, '131341', 1, 6, 0x3c46696c6553746f726167653a202750484c202d2053544c2043616e63656c6c65642e6a70656727202827696d6167652f6a70656727293e, 7, 4, '$argon2id$v=19$m=65536,t=3,p=4$ojkqKYcgsSK/pLDmqiF5kg$Z4xSiLSPN/gHB21MWZ+lAx4CKllLVICp8h2YO5Ads40', '2024-04-04 21:13:21', NULL, NULL, NULL, 0),
(160, 'Divya', 'T', 'divyat@gmail.com', '3145561231', 'male', '2024-04-01', '123 Olive St', 10, '', 1, 5, 0x3c46696c6553746f726167653a2027494d475f303031362e504e4727202827696d6167652f706e6727293e, 5, 4, '$argon2id$v=19$m=65536,t=3,p=4$70kLpS5wXghfMOzXUSAAyQ$h0vW/CEYYBOJyDWzPKFcAhqPHwjQ+ykdL2DjZwP0U6U', '2024-04-07 16:15:43', NULL, NULL, NULL, 0),
(164, ' Nikhil ', 'Bindela', 'nikhil.bindela@gmail.com', '3146672101', 'male', '2024-03-04', '4057 Olive', 12, '63108', 1, 6, '', 5, 4, '$argon2id$v=19$m=65536,t=3,p=4$u4Ucq2fkLEMGg+79OrXbbQ$Lj+5KRLS92TvHa1Ht6zUipVGlbfCiVFpb6vn+/wRU+o', '2024-04-09 21:49:41', NULL, NULL, NULL, 0),
(168, '  Harsha Vardhan Reddy  ', 'Bindela ', 'harshavardhanreddy.bindela@slu.edu', '03146679577', 'male', '2001-02-27', 'STL', 12, '63108', 1, 6, '', 9, 4, '$argon2id$v=19$m=65536,t=3,p=4$YDE6M7kGpjD3yvjWpwP7pw$eIYZpJvMWJUjyi1Ho3Xvxg3WZl0Y3Zvo8v8vvDv/wJ8', '2024-05-29 20:59:02', NULL, NULL, NULL, 0),
(169, 'Harsha Vardhan Reddy', 'Bindela', 'bharshareddy412@gmai', '3146679577', 'male', '2024-05-07', 'STL', 12, '63108', 1, 6, 0x3c46696c6553746f726167653a202750484f544f2d323032342d30352d32312d32302d34372d33322e6a706727202827696d6167652f6a70656727293e, 36, 4, NULL, '2024-05-29 21:07:17', NULL, NULL, NULL, 0),
(183, 'Harsha Vardhan Reddy', 'Bindela', 'bharshareddy412@gmai', '3146679577', 'male', '2000-07-20', 'STL\r\nApt C', 12, '63108', 1, 6, 0x3c46696c6553746f726167653a2027494d475f303532302e4a504727202827696d6167652f6a70656727293e, 5, 4, NULL, '2024-07-16 09:39:18', NULL, NULL, NULL, 0),
(186, 'Harsha', '', 'bharshareddy27@gmail.com', '', '', '0000-00-00', '', 0, '', 0, 0, NULL, NULL, NULL, '$argon2id$v=19$m=65536,t=3,p=4$TvmSePOou0bzrdqBp9qXEw$5bscAxurQHFzNHiY0T3dH1vftWfkCcIiA/mNm+77s0k', '2024-12-07 21:10:18', NULL, NULL, NULL, 0),
(187, 'Harsha Vardhan Reddy Bindela', '', 'bharshareddy27@gmail.com', '', '', '0000-00-00', '', 0, '', 0, 0, NULL, NULL, NULL, '$argon2id$v=19$m=65536,t=3,p=4$hOpvpGbX3xxADo3FjWGmBw$a4XGD2nLHJugl+q7z5Y9/vGOfFFNGgY+4jWXWHXlkO0', '2024-12-10 17:30:15', NULL, NULL, NULL, 0),
(188, 'Radhika', 'Sagi', 'radhika1092@gmail.com', '3145569577', 'female', '2024-12-01', '35 Calais Rd', 3, '07869', 1, 2, 0x3c46696c6553746f726167653a2027272028276170706c69636174696f6e2f6f637465742d73747265616d27293e, 6, 3, NULL, '2024-12-10 23:13:40', NULL, NULL, NULL, 0),
(189, 'Kamalakar', 'Reddy', 'kamalakar.bindela@gmail.com', '3145568209', 'male', '2024-12-09', 'India', 1, '515411', 1, 1, 0x3c46696c6553746f726167653a2027272028276170706c69636174696f6e2f6f637465742d73747265616d27293e, 5, 3, NULL, '2024-12-10 23:15:39', NULL, NULL, NULL, 0),
(190, 'Josna', '', 'josna.pitta@slu.edu', '', '', '0000-00-00', '', 0, '', 0, 0, NULL, NULL, NULL, '$argon2id$v=19$m=65536,t=3,p=4$EGBmAMhamkX7g2EyRBRk3g$B2bY3F4hPouxfBDiOaPSaGRT+RPrsMorSDkb8fHBw3Q', '2025-01-27 21:16:50', NULL, NULL, NULL, 0),
(191, 'Josna', '', 'joshna.pitta@gmail.com', '', '', '0000-00-00', '', 0, '', 0, 0, NULL, NULL, NULL, '$argon2id$v=19$m=65536,t=3,p=4$n9Qnjl9yb4exUQtAmdW37A$qDSxKKB0LQGJ03aLTzXCidpcgv+lI+59Fz/UV0xZG+E', '2025-01-27 21:17:58', NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `student_hobbies`
--

CREATE TABLE `student_hobbies` (
  `student_hobbies_id` int(10) NOT NULL,
  `student_id` int(11) NOT NULL,
  `hobbies_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_hobbies`
--

INSERT INTO `student_hobbies` (`student_hobbies_id`, `student_id`, `hobbies_id`) VALUES
(181, 159, 1),
(182, 158, 1),
(183, 158, 2),
(184, 160, 1),
(185, 160, 2),
(186, 160, 3),
(187, 164, 3),
(188, 164, 1),
(191, 156, 1),
(193, 169, 2),
(194, 169, 3),
(195, 168, 2),
(196, 183, 1),
(197, 183, 4),
(198, 188, 1),
(199, 189, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`branch_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`city_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `country_states`
--
ALTER TABLE `country_states`
  ADD PRIMARY KEY (`country_id`,`state_id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `hobbies`
--
ALTER TABLE `hobbies`
  ADD PRIMARY KEY (`hobbies_id`);

--
-- Indexes for table `qualifications`
--
ALTER TABLE `qualifications`
  ADD PRIMARY KEY (`qualification_id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`state_id`);

--
-- Indexes for table `state_cities`
--
ALTER TABLE `state_cities`
  ADD PRIMARY KEY (`city_id`,`state_id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_hobbies`
--
ALTER TABLE `student_hobbies`
  ADD PRIMARY KEY (`student_hobbies_id`),
  ADD KEY `hobbies_id` (`hobbies_id`),
  ADD KEY `student_hobbies_ibfk_1` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `city_id` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `country_id` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hobbies`
--
ALTER TABLE `hobbies`
  MODIFY `hobbies_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `qualifications`
--
ALTER TABLE `qualifications`
  MODIFY `qualification_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `state_id` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;

--
-- AUTO_INCREMENT for table `student_hobbies`
--
ALTER TABLE `student_hobbies`
  MODIFY `student_hobbies_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `country_states`
--
ALTER TABLE `country_states`
  ADD CONSTRAINT `country_states_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`),
  ADD CONSTRAINT `country_states_ibfk_2` FOREIGN KEY (`state_id`) REFERENCES `states` (`state_id`);

--
-- Constraints for table `state_cities`
--
ALTER TABLE `state_cities`
  ADD CONSTRAINT `state_cities_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`),
  ADD CONSTRAINT `state_cities_ibfk_2` FOREIGN KEY (`state_id`) REFERENCES `states` (`state_id`);

--
-- Constraints for table `student_hobbies`
--
ALTER TABLE `student_hobbies`
  ADD CONSTRAINT `student_hobbies_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_hobbies_ibfk_2` FOREIGN KEY (`hobbies_id`) REFERENCES `hobbies` (`hobbies_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2024 at 06:32 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `busbookingdb`
--
CREATE DATABASE IF NOT EXISTS `busbookingdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `busbookingdb`;
--
-- Database: `cms`
--
CREATE DATABASE IF NOT EXISTS `cms` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cms`;

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
(67, 'Supply Chain'),
(69, 'Check Branch'),
(70, 'Check Branch'),
(71, 'Inserting');

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
(165, ' Ramakanth ', 'Reddy', 'ramakanth@gmail.com', '3146679577', 'male', '1999-07-19', '4057 Olive Street', 8, '516001', 1, 4, '', 48, 4, '$argon2id$v=19$m=65536,t=3,p=4$kA2Z2qdFLpO/h17m/eLZ0Q$hFFPEzGmoBS0vU1Bm4at5XzEp4jsdS+UtbLBGLcUiAY', '2024-04-09 21:51:52', NULL, NULL, NULL, 0),
(167, 'Chandu', '', 'chandur659@gmail.com', '', '', '0000-00-00', '', 0, '', 0, 0, NULL, NULL, NULL, '$argon2id$v=19$m=65536,t=3,p=4$hsHp5rNe1I4WTPKcPAwaaQ$3qihbrZ6UsmqwtzlKOnxgWPSp4rZNkKHH/ht1q6zz28', '2024-05-08 14:26:33', NULL, NULL, NULL, 0);

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
(191, 156, 1);

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
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

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
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `student_hobbies`
--
ALTER TABLE `student_hobbies`
  MODIFY `student_hobbies_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;

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
--
-- Database: `crud_flask`
--
CREATE DATABASE IF NOT EXISTS `crud_flask` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `crud_flask`;

-- --------------------------------------------------------

--
-- Table structure for table `phone_book`
--

CREATE TABLE `phone_book` (
  `id` int(5) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `phone_book`
--

INSERT INTO `phone_book` (`id`, `name`, `phone`, `address`) VALUES
(16, 'Muhammad Hanif', '085733492411', 'Lamongan'),
(21, 'Harsha', '1234567890', '1232 Olive'),
(22, 'Harsha', '1234567890', '123 Olive');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `phone_book`
--
ALTER TABLE `phone_book`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `phone_book`
--
ALTER TABLE `phone_book`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"barcode\",\"table\":\"item\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'barcode', 'item', '{\"sorted_col\":\"`item`.`barcode` DESC\"}', '2023-07-19 14:59:11');

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2023-07-19 16:35:48', '{\"Console\\/Mode\":\"collapse\",\"NavigationWidth\":0}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `shp`
--
CREATE DATABASE IF NOT EXISTS `shp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `shp`;

-- --------------------------------------------------------

--
-- Table structure for table `hobbies`
--

CREATE TABLE `hobbies` (
  `hobbies_id` int(10) NOT NULL,
  `hobby` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `name` text NOT NULL,
  `username` varchar(18) NOT NULL,
  `email` varchar(21) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`name`, `username`, `email`, `password`) VALUES
('Harsha', 'hbindela', 'hbindel@slu.edu', '$2y$10$eHSmC10qR8BrdsDwWnduiO1icnhKQIZLp17gj0ZPfXouvMQUly/sG');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hobbies`
--
ALTER TABLE `hobbies`
  ADD PRIMARY KEY (`hobbies_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hobbies`
--
ALTER TABLE `hobbies`
  MODIFY `hobbies_id` int(10) NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Database: `toyinventory`
--
CREATE DATABASE IF NOT EXISTS `toyinventory` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `toyinventory`;

-- --------------------------------------------------------

--
-- Table structure for table `admin_details`
--

CREATE TABLE `admin_details` (
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `admin_details`
--

INSERT INTO `admin_details` (`name`, `password`) VALUES
('admin', 'password');

-- --------------------------------------------------------

--
-- Table structure for table `iybigiftinventory`
--

CREATE TABLE `iybigiftinventory` (
  `GiftId` int(11) NOT NULL,
  `GiftName` varchar(100) NOT NULL,
  `GiftPrice` decimal(10,2) NOT NULL,
  `CreatedBy` varchar(50) NOT NULL,
  `CreatedDate` date DEFAULT NULL,
  `ModifiedBy` varchar(50) NOT NULL,
  `ModifiedDate` date DEFAULT NULL,
  `available_quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iybigiftinventory`
--

INSERT INTO `iybigiftinventory` (`GiftId`, `GiftName`, `GiftPrice`, `CreatedBy`, `CreatedDate`, `ModifiedBy`, `ModifiedDate`, `available_quantity`) VALUES
(12, 'Airplane Toy', 107.79, '', NULL, '', NULL, 0),
(13, 'Kitchen Kit', 105.60, '', NULL, '', NULL, 1),
(14, 'SLU Logo Toy', 94.64, '', NULL, '', NULL, 2),
(15, 'Action Figure', 46.39, '', NULL, '', NULL, 1),
(16, 'Billiken Toy', 38.05, '', NULL, '', NULL, 2),
(17, 'Ludo', 41.07, '', NULL, '', NULL, 1),
(18, 'Billiken LOGO', 99.00, '', NULL, '', NULL, 1),
(21, 'Ware Truck', 14.99, '', NULL, '', NULL, 0),
(22, 'Tyre', 1400.00, '', NULL, '', NULL, 0),
(23, 'Bulb', 100.00, '', NULL, '', NULL, 10),
(29, 'Shine Tank', 121.00, '', NULL, '', NULL, 12),
(30, 'Venky Toy', 123.00, '', NULL, '', NULL, 13);

-- --------------------------------------------------------

--
-- Table structure for table `iybigiftsin`
--

CREATE TABLE `iybigiftsin` (
  `Id` int(11) NOT NULL,
  `GiftReceivingStatus` varchar(50) NOT NULL,
  `GiftReceivedDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `GiftId` int(11) NOT NULL,
  `GiftName` varchar(100) NOT NULL,
  `CreatedBy` varchar(50) NOT NULL,
  `CreatedDate` date DEFAULT NULL,
  `ModifiedBy` varchar(50) DEFAULT NULL,
  `ModifiedDate` varchar(50) DEFAULT NULL,
  `GiftPrice` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iybigiftsin`
--

INSERT INTO `iybigiftsin` (`Id`, `GiftReceivingStatus`, `GiftReceivedDate`, `GiftId`, `GiftName`, `CreatedBy`, `CreatedDate`, `ModifiedBy`, `ModifiedDate`, `GiftPrice`) VALUES
(1, 'Donated', '2023-08-15 23:10:34', 1, 'Kitchen Kit', '', NULL, NULL, NULL, 105.60),
(10, 'Purchased', '2023-08-09 05:00:00', 15, 'Action Figure', '', NULL, NULL, NULL, 46.39),
(16, 'Donated', '2024-01-01 06:00:00', 13, 'Kitchen Kit', '', NULL, NULL, NULL, 105.60);

-- --------------------------------------------------------

--
-- Table structure for table `iybigiftsout`
--

CREATE TABLE `iybigiftsout` (
  `Id` int(11) NOT NULL,
  `GiftId` int(11) NOT NULL,
  `GiftName` varchar(100) NOT NULL,
  `Shelter` varchar(100) NOT NULL,
  `KiddoDOB` date NOT NULL,
  `KiddoGender` varchar(10) NOT NULL,
  `DateOfDelivery` date NOT NULL,
  `BirthdayHeroName` varchar(100) NOT NULL,
  `GiftOutTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CreatedBy` varchar(50) NOT NULL,
  `CreatedDate` date DEFAULT NULL,
  `ModifiedBy` varchar(50) NOT NULL,
  `ModifiedDate` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iybigiftsout`
--

INSERT INTO `iybigiftsout` (`Id`, `GiftId`, `GiftName`, `Shelter`, `KiddoDOB`, `KiddoGender`, `DateOfDelivery`, `BirthdayHeroName`, `GiftOutTime`, `CreatedBy`, `CreatedDate`, `ModifiedBy`, `ModifiedDate`) VALUES
(5, 15, 'Action Figure', 'SLU', '2023-08-08', 'male', '2023-08-01', 'Nikhil', '2023-08-18 01:39:25', '', NULL, '', NULL),
(7, 15, 'Action Figure', 'SLU', '2023-07-31', 'female', '2023-08-17', 'Rolanda', '2023-08-18 13:16:48', '', NULL, '', NULL),
(8, 13, 'Kitchen Kit', 'KDP', '2024-01-26', 'male', '2024-01-27', 'Ramakanth', '2024-01-28 04:04:12', '', NULL, '', NULL),
(9, 23, 'Bulb', 'ATP', '0000-00-00', '', '2024-01-30', 'Janardhan', '2024-01-30 13:55:16', '', NULL, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `iybi kiddo information`
--

CREATE TABLE `iybi kiddo information` (
  `BirthdayHeroName` varchar(100) NOT NULL,
  `KiddoDOB` date NOT NULL,
  `KiddoGender` varchar(10) NOT NULL,
  `DateOfDelivery` date NOT NULL,
  `CreatedBy` varchar(50) NOT NULL,
  `CreatedDate` date DEFAULT NULL,
  `ModifiedBy` varchar(50) NOT NULL,
  `ModifiedDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `iybishelter`
--

CREATE TABLE `iybishelter` (
  `ShelterName` varchar(100) NOT NULL,
  `CreatedBy` varchar(50) NOT NULL,
  `CreatedDate` date DEFAULT NULL,
  `ModifiedBy` varchar(50) NOT NULL,
  `ModifiedDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `iybigiftinventory`
--
ALTER TABLE `iybigiftinventory`
  ADD PRIMARY KEY (`GiftId`);

--
-- Indexes for table `iybigiftsin`
--
ALTER TABLE `iybigiftsin`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_articles_users1` (`GiftId`);

--
-- Indexes for table `iybigiftsout`
--
ALTER TABLE `iybigiftsout`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `GiftId` (`GiftId`),
  ADD KEY `idx_iybigiftsout_BirthdayHeroName` (`BirthdayHeroName`);

--
-- Indexes for table `iybi kiddo information`
--
ALTER TABLE `iybi kiddo information`
  ADD KEY `fk_iybi kiddo infdormation_users1` (`BirthdayHeroName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `iybigiftinventory`
--
ALTER TABLE `iybigiftinventory`
  MODIFY `GiftId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `iybigiftsin`
--
ALTER TABLE `iybigiftsin`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `iybigiftsout`
--
ALTER TABLE `iybigiftsout`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `iybigiftsin`
--
ALTER TABLE `iybigiftsin`
  ADD CONSTRAINT `fk_articles_users1` FOREIGN KEY (`GiftId`) REFERENCES `iybigiftinventory` (`GiftId`);

--
-- Constraints for table `iybigiftsout`
--
ALTER TABLE `iybigiftsout`
  ADD CONSTRAINT `iybigiftsout_ibfk_1` FOREIGN KEY (`GiftId`) REFERENCES `iybigiftinventory` (`GiftId`);

--
-- Constraints for table `iybi kiddo information`
--
ALTER TABLE `iybi kiddo information`
  ADD CONSTRAINT `fk_iybi kiddo infdormation_users1` FOREIGN KEY (`BirthdayHeroName`) REFERENCES `iybigiftsout` (`BirthdayHeroName`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

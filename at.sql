-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 12, 2026 at 10:17 AM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assignment_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
CREATE TABLE IF NOT EXISTS `assignments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usn` varchar(25) NOT NULL,
  `student_id` int NOT NULL,
  `subject` varchar(255) NOT NULL,
  `assignment_type` varchar(100) NOT NULL,
  `assignment_no` int NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `semester` int NOT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assignments`
--

INSERT INTO `assignments` (`id`, `usn`, `student_id`, `subject`, `assignment_type`, `assignment_no`, `file_path`, `semester`, `uploaded_at`) VALUES
(31, '4GW23CI014', 84, 'Computer Networks', 'MOOC Course', 2, 'uploads/4GW23CI014/1765179067_ASI_Module 5.pdf CN.pdf', 5, '2025-12-08 07:31:07'),
(35, '4GW23CI046', 116, 'Data Visualization Lab', 'Tech Talk', 2, 'uploads/4GW23CI046/1765180124_BCS501-module-4-pdf (2).pdf', 5, '2025-12-08 07:48:44'),
(49, '4GW23CI041', 111, 'Computer Networks', 'Tech Talk', 2, 'uploads/4GW23CI041/1765336442_2023BECSAIML041_27_08_2025 17_13_09.pdf', 5, '2025-12-10 03:14:02'),
(39, '4GW22CI022', 28, 'Advanced AI and ML', 'MOOC Course', 2, 'uploads/4GW22CI022/1765185688_Program12.xlsx', 7, '2025-12-08 09:21:28'),
(43, '4GW23CI044', 114, 'Computer Networks', 'Quiz', 1, 'uploads/4GW23CI044/1765331682_Screenshot (109).png', 5, '2025-12-10 01:54:42'),
(44, '4GW23CI044', 114, 'Computer Networks', 'Quiz', 1, 'uploads/4GW23CI044/1765331745_Screenshot (109).png', 5, '2025-12-10 01:55:45'),
(45, '4GW23CI044', 114, 'Computer Networks', 'Quiz', 1, 'uploads/4GW23CI044/1765331758_Screenshot (109).png', 5, '2025-12-10 01:55:58'),
(50, '4GW23CI041', 111, 'Computer Networks', 'Quiz', 1, 'uploads/4GW23CI041/1765336464_COE0118575  COMEDK.pdf', 5, '2025-12-10 03:14:24'),
(51, '4GW23CI022', 92, 'Research Methodology and IPR', 'Tech Talk', 1, 'uploads/4GW23CI022/1765340625_GITAM Admissions madhu.pdf', 5, '2025-12-10 04:23:45'),
(52, '4GW24CI046', 185, 'Data Structures and Applications', 'Tech Talk', 1, 'uploads/4GW24CI046/1765343264_2521210555.pdf', 3, '2025-12-10 05:07:44'),
(53, '4GW24CI046', 185, 'Data Structures and Applications', 'MOOC Course', 2, 'uploads/4GW24CI046/1765343280_2521210555.pdf', 3, '2025-12-10 05:08:00'),
(54, '4GW24CI057', 196, 'Digital Design & ComputerOrganization', 'Green Book', 1, 'uploads/4GW24CI057/1765343317_COE0118575  COMEDK.pdf', 3, '2025-12-10 05:08:37'),
(55, '4GW24CI057', 196, 'Digital Design & ComputerOrganization', 'MOOC Course', 2, 'uploads/4GW24CI057/1765343353_COE0118575  COMEDK.pdf', 3, '2025-12-10 05:09:13'),
(56, '4GW24CI057', 196, 'Mathematics for Computer Science', 'Quiz', 1, 'uploads/4GW24CI057/1765343371_COMEDK and Uni-Gauge UGET 2022.pdf', 3, '2025-12-10 05:09:31'),
(57, '4GW24CI062', 201, 'Object Oriented Programming with Java', 'Quiz', 1, 'uploads/4GW24CI062/1765343399_HALL TICKET.pdf', 3, '2025-12-10 05:09:59'),
(58, '4GW24CI062', 201, 'Operating Systems', 'MOOC Course', 2, 'uploads/4GW24CI062/1765343419_2521210555.pdf', 3, '2025-12-10 05:10:19'),
(59, '4GW24CI057', 196, 'Object Oriented Programming with Java', 'Tech Talk', 1, 'uploads/4GW24CI057/1765345396_2023BECSAIML041_27_08_2025 17_13_09.pdf', 3, '2025-12-10 05:43:16');

-- --------------------------------------------------------

--
-- Table structure for table `assignment_types`
--

DROP TABLE IF EXISTS `assignment_types`;
CREATE TABLE IF NOT EXISTS `assignment_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assignment_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assignment_types`
--

INSERT INTO `assignment_types` (`id`, `assignment_type`) VALUES
(1, 'Quiz'),
(2, 'Tech Talk'),
(3, 'MOOC Course'),
(4, 'Green Book');

-- --------------------------------------------------------

--
-- Table structure for table `hod`
--

DROP TABLE IF EXISTS `hod`;
CREATE TABLE IF NOT EXISTS `hod` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hod`
--

INSERT INTO `hod` (`id`, `username`, `password`, `name`) VALUES
(1, 'hod', 'hod123', 'Head of Department');

-- --------------------------------------------------------

--
-- Table structure for table `scheme`
--

DROP TABLE IF EXISTS `scheme`;
CREATE TABLE IF NOT EXISTS `scheme` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `credits` int NOT NULL,
  `year` int NOT NULL,
  `sem` int NOT NULL,
  `stream` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `scheme`
--

INSERT INTO `scheme` (`id`, `code`, `name`, `credits`, `year`, `sem`, `stream`, `status`) VALUES
(1, 'BMATS101', 'Mathematics-I for CSE Stream', 4, 2022, 1, '', 'Active'),
(2, 'BPHYS102', 'Applied Physics for CSE stream', 4, 2022, 1, '', 'Active'),
(3, 'BPOPS103', 'Principles of Programming Using C', 3, 2022, 1, '', 'Active'),
(4, 'BESCK104C', 'Introduction to Electronics Communication', 3, 2022, 1, '', 'Active'),
(5, 'BETCK105I', 'Introduction to Cyber Security', 3, 2022, 1, '', 'Active'),
(6, 'BENGK106', 'Communicative English', 1, 2022, 1, '', 'Active'),
(7, 'BICOK107', 'Indian Constitution', 1, 2022, 1, '', 'Active'),
(8, 'BIDTK158', 'Innovation and Design Thinking', 1, 2022, 1, '', 'Active'),
(9, 'BMATS201', 'Mathematics-II forCSE Stream', 4, 2022, 2, '', 'Active'),
(10, 'BCHES202', 'Applied Chemistry for CSE Stream', 4, 2022, 2, '', 'Active'),
(11, 'BCEDK203', 'Computer-Aided Engineering Drawing', 3, 2022, 2, '', 'Active'),
(12, 'BESCK204B', 'Introduction to Electrical Engineering', 3, 2022, 2, '', 'Active'),
(13, 'BPLCK205B', 'Introduction to Python Programming', 2, 2022, 2, '', 'Active'),
(14, 'BPWSK206', 'Professional Writing Skills in English', 1, 2022, 2, '', 'Active'),
(15, 'BKSKK207', 'Samskrutika Kannada', 1, 2022, 2, '', 'Active'),
(16, 'BKBKK207', 'Balake Kannada', 1, 2022, 2, '', 'Active'),
(17, 'BSFHK258', 'Scientific Foundations of Health', 1, 2022, 2, '', 'Active'),
(18, 'BCS301', 'Mathematics for Computer Science', 4, 2022, 3, '', 'Active'),
(19, 'BCS302', 'Digital Design & ComputerOrganization', 4, 2022, 3, '', 'Active'),
(20, 'BCS303', 'Operating Systems', 4, 2022, 3, '', 'Active'),
(21, 'BCS304', 'Data Structures and Applications', 3, 2022, 3, '', 'Active'),
(22, 'BCSL305', 'Data Structures Lab', 1, 2022, 3, '', 'Active'),
(23, 'BCS306A', 'Object Oriented Programming with Java', 3, 2022, 3, '', 'Active'),
(24, 'BDS306B', 'Python Programming for Data Science', 3, 2022, 3, '', 'Active'),
(25, 'BDS306C', 'Data Analytics with R', 3, 2022, 3, '', 'Active'),
(26, 'BCS358A', 'Data Analytics with Excel', 1, 2022, 3, '', 'Active'),
(27, 'BAI358B', 'Ethics and Public Policy for AI', 1, 2022, 3, '', 'Active'),
(28, 'BCS358C', 'Project Managementwith Git', 1, 2022, 3, '', 'Active'),
(29, 'BAI358D', 'PHP Programming', 1, 2022, 3, '', 'Active'),
(30, 'BSCK307', 'Social Connect and Responsibility', 1, 2022, 3, '', 'Active'),
(31, 'BNSK359', 'National Service Scheme (NSS)', 0, 2022, 3, '', 'Active'),
(32, 'BPEK359', 'Physical Education (PE) (Sports and Athletics)', 0, 2022, 3, '', 'Active'),
(33, 'BYOK359', 'Yoga', 0, 2022, 3, '', 'Active'),
(34, '401', 'Analysis & Design of Algorithms', 3, 2022, 4, '', 'Active'),
(35, 'BAD402', 'Artificial Intelligence', 4, 2022, 4, '', 'Active'),
(36, 'BCS403', 'Database Management Systems', 4, 2022, 4, '', 'Active'),
(37, 'BCSL404', 'Analysis & Design of Algorithms Lab', 1, 2022, 4, '', 'Active'),
(38, 'BCS405A', 'Discrete Mathematical Structures', 3, 2022, 4, '', 'Active'),
(39, 'BAI405B', 'Metric Spaces', 3, 2022, 4, '', 'Active'),
(40, 'BCS405C', 'Optimization Technique', 3, 2022, 4, '', 'Active'),
(41, 'BAI405D', 'Algorithmic Game Theory', 3, 2022, 4, '', 'Active'),
(42, 'BDSL456A', 'Scala', 1, 2022, 4, '', 'Active'),
(43, 'BDSL456B', 'Mango DB', 1, 2022, 4, '', 'Active'),
(44, 'BDSL456C', ' MERN ', 1, 2022, 4, '', 'Active'),
(45, 'BCS4L56D', 'Technical writing using LATEX (Lab)', 1, 2022, 4, '', 'Active'),
(46, 'BBOK407', 'Biology For Engineers', 2, 2022, 4, '', 'Active'),
(47, 'BUHK408', 'Universal human values course', 1, 2022, 4, '', 'Active'),
(48, 'BNSK459', 'National Service Scheme (NSS)', 0, 2022, 4, '', 'Active'),
(49, 'BPEK459', 'Physical Education (PE) (Sports and Athletics)', 0, 2022, 4, '', 'Active'),
(50, 'BYOK459', 'Yoga', 0, 2022, 4, '', 'Active'),
(51, 'BCI501', 'Software Engineering & Project Management', 3, 2022, 5, '', 'Active'),
(52, 'BCI502', 'Computer Networks', 4, 2022, 5, '', 'Active'),
(53, 'BCI503', 'Theory of Computation', 4, 2022, 5, '', 'Active'),
(54, 'BCIL504', 'Data Visualization Lab', 1, 2022, 5, '', 'Active'),
(59, 'BCI586', 'Mini Project', 2, 2022, 5, '', 'Active'),
(60, 'BRMK557', 'Research Methodology and IPR', 3, 2022, 5, '', 'Active'),
(62, 'BNSK559', 'National Service Scheme (NSS)', 0, 2022, 5, '', 'Active'),
(63, 'BPEK559', 'Physical Education (PE) (Sports and Athletics)', 0, 2022, 5, '', 'Active'),
(64, 'BYOK559', 'Yoga', 0, 2022, 5, '', 'Active'),
(65, 'BCI601', 'Microcontrollers& Embedded Systems', 4, 2022, 6, '', 'Active'),
(66, 'BCI602', 'Machine Learning -I', 4, 2022, 6, '', 'Active'),
(67, 'BCI613A', 'Human-Centered AI', 3, 2022, 6, '', 'Active'),
(68, 'BCI613B', 'Cloud Computing', 3, 2022, 6, '', 'Active'),
(69, 'BCI613C', 'Blockchain Technology', 3, 2022, 6, '', 'Active'),
(70, 'BCI613D', 'Time Series Analysis', 3, 2022, 6, '', 'Active'),
(71, 'BCI654A', 'Introduction to Data Structures', 3, 2022, 6, '', 'Active'),
(72, 'BCI654B', 'Fundamentals of Operating Systems', 3, 2022, 6, '', 'Active'),
(73, 'BCI654C', 'Mobile Application Development', 3, 2022, 6, '', 'Active'),
(74, 'BCI654D', 'Introduction to AI', 3, 2022, 6, '', 'Active'),
(75, 'BCI685', 'Project Phase I', 2, 2022, 6, '', 'Active'),
(76, 'BCIL606', 'Machine Learning lab', 1, 2022, 6, '', 'Active'),
(77, 'BCI657A', 'Explainable AI', 1, 2022, 6, '', 'Active'),
(78, 'BCI657B', 'PyTorch', 1, 2022, 6, '', 'Active'),
(79, 'BCI657C', 'Generative AI', 1, 2022, 6, '', 'Active'),
(80, 'BCI657D', 'Devops', 1, 2022, 6, '', 'Active'),
(81, 'BNSK659', 'National Service Scheme (NSS)', 0, 2022, 6, '', 'Active'),
(82, 'BPEK659', 'Physical Education (PE) (Sports and Athletics)', 0, 2022, 6, '', 'Active'),
(83, 'BYOK659', 'Yoga', 0, 2022, 6, '', 'Active'),
(84, 'BCI701', 'Natural Language Processing', 4, 2022, 7, '', 'Active'),
(85, 'BCI702', 'Machine Learning -II', 4, 2022, 7, '', 'Active'),
(86, 'BCI703', 'Information &Network Security', 4, 2022, 7, '', 'Active'),
(87, 'BCI714A', 'AI of Things', 3, 2022, 7, '', 'Active'),
(88, 'BCI714B', 'High Performance Computing', 3, 2022, 7, '', 'Active'),
(89, 'BCI714C', 'Data Engineering & MLOps', 3, 2022, 7, '', 'Active'),
(90, 'BCI714D', 'Big Data Analytics', 3, 2022, 7, '', 'Active'),
(91, 'BCI755A', 'Introduction to DBMS', 3, 2022, 7, '', 'Active'),
(92, 'BCI755B', 'Introduction to Algorithms', 3, 2022, 7, '', 'Active'),
(93, 'BCI755C', 'Software Engineering', 3, 2022, 7, '', 'Active'),
(94, 'BCI755D', 'Introduction to Machine Learning', 3, 2022, 7, '', 'Active'),
(95, 'BCI786', 'Major Project Phase-II', 6, 2022, 7, '', 'Active'),
(96, 'BCI8011', 'Professional Elective throughNPTEL', 3, 2022, 8, '', 'Active'),
(97, 'BCI8022', 'Open Elective (Online Courses) Only through NPTEL', 3, 2022, 8, '', 'Active'),
(98, 'BCI803', 'Internship', 10, 2022, 8, '', 'Active'),
(174, '402', 'ARTIFICIAL INTELLIGENCE', 4, 2022, 4, '', 'Active'),
(175, '403', 'Database Management Systems', 4, 2022, 4, '', 'Active'),
(176, '404', 'Analysis & Design of Algorithms Lab', 1, 2022, 4, '', 'Active'),
(177, '405A', 'Discrete Mathematical Structures', 3, 2022, 4, '', 'Active'),
(178, '405B', 'Metric Spaces', 3, 2022, 4, '', 'Active'),
(179, '405C', 'Optimization Technique', 3, 2022, 4, '', 'Active'),
(180, '405D', 'Algorithmic Game Theory', 3, 2022, 4, '', 'Active'),
(181, '456A', 'Scala', 1, 2022, 4, '', 'Active'),
(182, '456B', 'Mango DB', 1, 2022, 4, '', 'Active'),
(183, '456C', 'MERN', 1, 2022, 4, '', 'Active'),
(184, '456D', 'Technical writing using LATEX (Lab)', 1, 2022, 4, '', 'Active'),
(185, 'BBOC407', 'Biology For Computer Engineers', 2, 2022, 4, '', 'Active'),
(186, '408', 'Universal human values course', 1, 2022, 4, '', 'Active'),
(187, '459', 'National Service Scheme (NSS)', 0, 2022, 4, '', 'Active'),
(188, '459', 'Physical Education (PE) (Sports and Athletics)', 0, 2022, 4, '', 'Active'),
(189, '459', 'Yoga', 0, 2022, 4, '', 'Active'),
(197, '502', 'COMPUTER NETWORKS', 4, 2022, 5, '', 'Active'),
(198, '503', 'THEORY OF COMPUTATION', 4, 2022, 5, '', 'Active'),
(199, '504', 'DATA VISUALIZATION LAB', 1, 2022, 5, '', 'Active'),
(200, '586', 'MINI PROJECT', 2, 2022, 5, '', 'Active'),
(201, '557', 'RESEARCH METHODOLOGY AND IPR', 3, 2022, 5, '', 'Active'),
(202, '508', 'ENVIRONMENTAL STUDIES AND E-WASTE MANAGEMENT', 2, 2022, 5, '', 'Active'),
(204, '515C', 'UNIX SYSTEM PROGRAMMING', 3, 2022, 5, '', 'Active'),
(207, '101', 'MATHEMATICS FOR CSESTREAM-I', 4, 2022, 1, '', 'Active'),
(208, '102', 'PHYSICS FOR CSE STREAM', 4, 2022, 1, '', 'Active'),
(209, '103', 'PRINCIPLES OF PROGRAMMING USING C', 3, 2022, 1, '', 'Active'),
(210, '106', 'COMMUNICATIVE ENGLISH', 1, 2022, 1, '', 'Active'),
(211, '107', 'INDIAN CONSTITUTION', 1, 2022, 1, '', 'Active'),
(212, '104C', 'INTRODUCTION TO ELECTRONICS ENGINEERING', 3, 2022, 1, '', 'Active'),
(213, '105I', 'INTRODUCTION TO CYBER SECURITY', 3, 2022, 1, '', 'Active'),
(214, '158', 'INNOVATION AND DESIGNTHINKING', 1, 2022, 1, '', 'Active'),
(231, 'BMATE201', 'MATHEMATICS-II FOR EES', 4, 2022, 2, '', 'Active'),
(232, '202', 'APPLIED PHYSICS FOR EES', 4, 2022, 2, '', 'Active'),
(233, '203', 'BASIC ELECTRONICS', 3, 2022, 2, '', 'Active'),
(234, '206', 'PROFESSIONALWRITING SKILLS IN ENGLISH', 1, 2022, 2, '', 'Active'),
(235, '207', 'INDIAN CONSTITUTION', 1, 2022, 2, '', 'Active'),
(236, '258', 'INNOVATION AND DESIGN THINKING', 1, 2022, 2, '', 'Active'),
(237, '204E', 'INTRODUCTION TO C PROGRAMMING', 3, 2022, 2, '', 'Active'),
(238, '205H', 'INTRODUCTION TO INTERNET OF THINGS(IOT)', 3, 2022, 2, '', 'Active'),
(239, '105B', 'INTRODUCTION TO PYTHON PROGRAMMING', 3, 2022, 2, '', 'Active'),
(240, '101', 'MATHEMATICS FOR EES-I', 4, 2022, 2, '', 'Active'),
(241, '104B', 'INTRODUCTION TO ELECTRICAL ENGINEERING', 3, 2022, 2, '', 'Active'),
(242, '301', 'MATHEMATICS FOR COMPUTER SCIENCE', 4, 2023, 3, '', 'Active'),
(244, '303', 'OPERATING SYSTEMS', 4, 2023, 3, '', 'Active'),
(245, '304', 'DATA STRUCTURES AND APPLICATIONS', 3, 2023, 3, '', 'Active'),
(246, '305', 'DATA STRUCTURES LAB', 1, 2023, 3, '', 'Active'),
(247, '307', 'SOCIAL CONNECT AND RESPONSIBILITY', 1, 2023, 3, '', 'Active'),
(249, '358A', 'DATA ANALYTICS WITH EXCEL', 1, 2023, 3, '', 'Active'),
(250, '306A', 'OBJECT ORIENTED PROGRAMMING WITH JAVA', 3, 2023, 3, '', 'Active'),
(252, '105E', 'RENEWABLE ENERGY SOURCES', 3, 2024, 1, '', 'Active'),
(253, '104E', 'INTRODUCTION TO C PROGRAMMING', 3, 2024, 1, '', 'Active'),
(254, 'BMATE101', 'MATHEMATICS FOR EES-I', 4, 2024, 1, '', 'Active'),
(255, ' BCHEE102', 'CHEMISTRY FOR EES', 4, 2024, 1, '', 'Active'),
(256, 'BCEDK103', 'COMPUTER-AIDED ENGINEERING DRAWING', 3, 2024, 1, '', 'Active'),
(257, ' BENGK106', 'COMMUNICATIVE ENGLISH', 1, 2024, 1, '', 'Active'),
(258, 'BKSKK107', 'SAMSKRUTIKA KANNADA', 1, 2024, 1, '', 'Active'),
(259, ' BSFHK158', 'SCIENTIFIC FOUNDATIONS OF HEALTH', 1, 2024, 1, '', 'Active'),
(260, ' BETCK105E', 'RENEWABLE ENERGY SOURCES', 3, 2024, 1, '', 'Active'),
(261, ' BESCK104E', 'INTRODUCTION TO C PROGRAMMING', 3, 2024, 1, '', 'Active'),
(262, 'BCHEE102', 'CHEMISTRY FOR EES', 4, 2024, 1, '', 'Active'),
(263, 'BSFHK158', 'SCIENTIFIC FOUNDATIONS OF HEALTH', 1, 2024, 1, '', 'Active'),
(264, 'BETCK105E', 'RENEWABLE ENERGY SOURCES', 3, 2024, 1, '', 'Active'),
(265, 'BESCK104E', 'INTRODUCTION TO C PROGRAMMING', 3, 2024, 1, '', 'Active'),
(266, 'BKBKK107', 'SAMSKRUTIKA KANNADA', 1, 2024, 1, '', 'Active'),
(278, 'BESCK104B', 'INTRODUCTION TO ELECTRICAL ENGINEERING', 3, 2024, 1, '', 'Active'),
(279, 'BPLCK105B', 'INTRODUCTION TO PYTHON PROGRAMMING', 3, 2024, 1, '', 'Active'),
(280, 'BCS401', 'Analysis & Design of Algorithm', 3, 2022, 4, '', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usn` varchar(10) NOT NULL,
  `password` varchar(500) NOT NULL,
  `name` varchar(500) NOT NULL,
  `email` varchar(1000) NOT NULL,
  `dept` varchar(5) NOT NULL,
  `mobile` bigint NOT NULL,
  `sem` int NOT NULL,
  `batch` int NOT NULL,
  `dob` date DEFAULT NULL,
  `active` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id`, `usn`, `password`, `name`, `email`, `dept`, `mobile`, `sem`, `batch`, `dob`, `active`) VALUES
(2, '4GW22CI048', 'password', 'Shambhavi', 'kulkarnishambhavi31@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(3, '4GW22CI047', 'password', 'Sandhya Gangadhara Bhat', 'bhatsandhya965@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(4, '4GW22CI046', 'password', 'Roshni A', 'test@168', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(5, '4GW22CI045', 'password', 'Rohana G', 'Rohanagowda1@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(6, '4GW22CI044', 'password', 'Rakshitha C M', 'rakshitha477@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(7, '4GW22CI043', 'password', 'Rakshitha B M', 'rakshithamahadeva31@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(8, '4GW22CI042', 'password', 'Raina Mohammed Shamoon', 'rainamohammed004@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(9, '4GW22CI041', 'password', 'Priyanka N Gowda', 'priyankangowdapriyankangowda@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(10, '4GW22CI040', 'password', 'Pradeepta Hemanth', 'pradeeptahemanth09@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(11, '4GW22CI039', 'password', 'Poorvika Shree V', 'poorvika4488@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(12, '4GW22CI038', 'password', 'Poojitha K D', 'poojithapoojitha363@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(13, '4GW22CI037', 'password', 'Pallavi B L', 'pallavibl502@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(14, '4GW22CI036', 'password', 'Nitya T M', 'nityamanjunath07@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(15, '4GW22CI035', 'password', 'Nanditha C G', 'nandithacg22@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(16, '4GW22CI034', 'password', 'Nagashree N', 'nagashreenageshs24@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(17, '4GW22CI033', 'password', 'Monisha G', 'monishag129@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(18, '4GW22CI032', 'password', 'Monica M P', 'mbm929667@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(19, '4GW22CI031', 'password', 'Madhushree H', 'shreemadhu584@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(20, '4GW22CI030', 'password', 'Krupa Ashok Pyati', 'krupaashokpyati@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(21, '4GW22CI029', 'password', 'Khushi K N', 'khushikn7@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(22, '4GW22CI028', 'password', 'Keerthana Y P', 'keerthanayp15@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(23, '4GW22CI027', 'password', 'Jasna Fathima K', 'jasnafathima395@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(24, '4GW22CI026', 'password', 'Hitha Kiran', 'hithakiran20@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(25, '4GW22CI025', 'password', 'G K Harshitha', 'gkharshitha19@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(26, '4GW22CI024', 'password', 'Divya S', 'divyasrisathya2002@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(27, '4GW22CI023', 'password', 'Dimple Priya P M', 'dimplepriya06@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(28, '4GW22CI022', 'password', 'Dhruthi Jain S M', 'dhurthijain24@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(29, '4GW22CI021', 'password', 'Deeksha R Bhatt', 'deekshabhatt0105@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(30, '4GW22CI020', 'password', 'Chethana K', 'chethanak23chethanak@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(31, '4GW22CI019', 'password', 'Chandana M Pallegar', 'chandanapallegar@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(32, '4GW22CI018', 'password', 'Chandana B L', 'chandanabelur2004@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(33, '4GW22CI017', 'password', 'Chandana B', 'chandanab843@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(34, '4GW22CI016', 'password', 'Bhuvana B C', 'bhuvi1046@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(35, '4GW22CI015', 'password', 'Bhoomika Raghavendra', 'test@137', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(36, '4GW22CI014', 'password', 'Bhavani S A', 'bhavanigowda117@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(37, '4GW22CI013', 'password', 'Ashwini D', 'ashwinid996@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(38, '4GW22CI012', 'password', 'Arwapalli Hiran Mai', 'arwapallihiranmai@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(39, '4GW22CI011', 'password', 'Archana S', 'archanasharavanan0509@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(40, '4GW22CI010', 'password', 'Apoorva K', 'apoorvak048@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(41, '4GW22CI009', 'password', 'Anu', 'anuravindra0@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(42, '4GW22CI008', 'password', 'Ankita Venugopal', 'ankitavenugopal@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(43, '4GW22CI007', 'password', 'Anjali Pandey', 'test@129', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(44, '4GW22CI006', 'password', 'Anisha M', 'anishamahesh2710@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(45, '4GW22CI005', 'password', 'Angadi Sai Sanjana', 'test@127', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(46, '4GW22CI004', 'password', 'Ananya R Naik', 'ananyanaik1704@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(47, '4GW22CI003', 'password', 'Amrutha S', 'amruthaa.srikant@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(48, '4GW22CI002', 'password', 'Aishwarya S M', 'aishwaryamadeshaaishu@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(49, '4GW22CI001', 'password', 'Aditi H Kumar', 'monalikakumar4@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(50, '4GW22CI049', 'password', 'Sheethal S Gowda', 'sgshe04@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(51, '4GW22CI050', 'password', 'Shibha', 'shibhamgshetty19@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(52, '4GW22CI051', 'password', 'Shiny N', 'shinejosh428@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(53, '4GW22CI052', 'password', 'Shubhangi Singh', 'singhshubhangi3009@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(54, '4GW22CI053', 'password', 'Sneha V', 'snehadevang00@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(55, '4GW22CI054', 'password', 'Spoorthi A', 'spoorthi.mys2903@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(56, '4GW22CI055', 'password', 'Srividya Swaroop M P', 'svswaroop.aiq@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(57, '4GW22CI056', 'password', 'T R Deepika', 'deepu110305@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(58, '4GW22CI057', 'password', 'Thanusha S', 'test@179', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(59, '4GW22CI058', 'password', 'Vaishnavi R S', 'vaishnavirs1822@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(60, '4GW22CI059', 'password', 'Vamshi N G', 'vamshingvamshi70@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(61, '4GW22CI060', 'password', 'Varshini S', 'svarshini563@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(62, '4GW22CI061', 'password', 'Vinutha B M', 'vinuthabm1664@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(63, '4GW22CI062', 'password', 'Vyshnavi Keerthi D', 'test@184', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(64, '4GW22CI403', 'password', 'NETHRAVATHI R', 'nethravathir348@gmail.com', 'AIML', 123456, 7, 2021, '0000-00-00', 1),
(65, '4GW22CI406', 'password', 'Y HARSHITHA', 'harshitha2harshi@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(66, '4GW22CI400', 'password', 'ASHWINI R', 'ashwinigayathri312@gmail.com', 'AIML', 123456, 7, 2022, '0000-00-00', 1),
(67, '4GW22CI401', 'password', 'DHANYASHREE S', 'dhanyashree334@gmail.com', 'AIML', 123456, 7, 2021, '0000-00-00', 1),
(68, '4GW22CI402', 'password', 'HARSHITHA K R', 'harshithah304@gmail.com', 'AIML', 123456, 7, 2021, '0000-00-00', 1),
(69, '4GW22CI404', 'password', 'NIKITHA C', 'nayaknikitha601@gmail.com', 'AIML', 123456, 7, 2021, '0000-00-00', 1),
(70, '4GW22CI405', 'password', 'POOJA R', 'poojayadavkushi@gmail.com', 'AIML', 123456, 7, 2021, '0000-00-00', 1),
(71, '4GW23CI001', 'password', 'Aditi Naduthota', 'adinaduthota@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(72, '4GW23CI002', 'password', 'Aishwarya G', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-02', 1),
(73, '4GW23CI003', 'password', 'Aishwarya S', 'aishwarya161005@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(74, '4GW23CI004', 'password', 'Amulya U', 'amulyau19@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(75, '4GW23CI005', 'password', 'Bhagyashree Hokrani', 'bhagyashreehokrani2023@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(76, '4GW23CI006', 'password', 'Bhavana V', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-06', 1),
(77, '4GW23CI007', 'password', 'C A Monisha', 'monishaappaiah20@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(78, '4GW23CI008', 'password', 'Chandana K S', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-08', 1),
(79, '4GW23CI009', 'password', 'Chandana K T', 'chandanakt1712@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(80, '4GW23CI010', 'password', 'Chandana S', 'chandanasrinivas0904@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(81, '4GW23CI011', 'password', 'Chethana B M', 'chethanabm1049@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(82, '4GW23CI012', 'password', 'Divya K N', 'divyakn004@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(83, '4GW23CI013', 'password', 'Diya Suraj Ballal', 'diyaballal3127@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(84, '4GW23CI014', 'password', 'Endukuri Sai Sruthi', 'saisruthiendukuri@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(85, '4GW23CI015', 'password', 'Harshitha R', 'harshitharavikumar29@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(86, '4GW23CI016', 'password', 'Harshitha S', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-16', 1),
(87, '4GW23CI017', 'password', 'Hitha Pradeep Y', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-17', 1),
(88, '4GW23CI018', 'password', 'Impana V', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-18', 1),
(89, '4GW23CI019', 'password', 'Jangam Kavya', 'kavya7lisa@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(90, '4GW23CI020', 'password', 'Jeevitha V', 'jeevithav2901@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(91, '4GW23CI021', 'password', 'Keerthana B', 'keerthanab675@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(92, '4GW23CI022', 'password', 'Kotakonda Akshitha', 'akshithakotakonda0404@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(93, '4GW23CI023', 'password', 'Lekhana Suresh', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-23', 1),
(94, '4GW23CI024', 'password', 'Maanvi Chandan', 'maanvichandan@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(95, '4GW23CI025', 'password', 'Mamatha M', 'mamathaudogere@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(96, '4GW23CI026', 'password', 'Manasa', 'manasamanasa15378@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(97, '4GW23CI027', 'password', 'Manasa G R', 'manasagowda2785@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(98, '4GW23CI028', 'password', 'Manogna C', 'manognachennakeshav625@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(99, '4GW23CI029', 'password', 'Manohari M', 'manoharim987@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(100, '4GW23CI030', 'password', 'Manya A Gowda', 'gowdamans2523@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(101, '4GW23CI031', 'password', 'Manya C P', 'manyacp08@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(102, '4GW23CI032', 'password', 'Nandini', 'nandinikanje@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(103, '4GW23CI033', 'password', 'Nanditha M', 'nandithamnanditha902@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(104, '4GW23CI034', 'password', 'Nethrashree Y S', 'nethrays13@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(105, '4GW23CI035', 'password', 'Nidhi', 'nidhiammu26@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(106, '4GW23CI036', 'password', 'Niharika T R', 'niharikatr37@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(107, '4GW23CI037', 'password', 'Pranamya S Bharadwaj', 'pranamyabharadwaj@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(108, '4GW23CI038', 'password', 'Pranathi S', 'pranathispranathis@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(109, '4GW23CI039', 'password', 'Prarthana N', 'prathananswamy@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(110, '4GW23CI040', 'password', 'Prathiksha S', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(111, '4GW23CI041', 'password', 'Preethi B', 'preethibdixit2711@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(112, '4GW23CI042', 'password', 'Priya N Singh', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(113, '4GW23CI043', 'password', 'Priyanka C', 'priyachandru398@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(114, '4GW23CI044', 'password', 'R Haritha', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(115, '4GW23CI045', 'password', 'Ruchitha S', 'ruchithashivaswamy03@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(116, '4GW23CI046', 'password', 'Dongari Sai Pallavi', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(117, '4GW23CI047', 'password', 'Shreya Harish', 'shreyaharish84@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(118, '4GW23CI048', 'password', 'Sinchana M', 'sinchana16905@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(119, '4GW23CI049', 'password', 'Sinchana Mahesh', 'sinchanamahesh2005@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(120, '4GW23CI050', 'password', 'Siri N Murthy', 'sirinmurthy09@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(121, '4GW23CI051', 'password', 'Soja J S', 'soja257@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(122, '4GW23CI052', 'password', 'Spoorthi Koorgalli Shivakumar', 'spoorthiks645@gmail.com', 'AIML', 123456, 5, 2023, '0005-04-06', 1),
(123, '4GW23CI053', 'password', 'Srinidhi R', 'ramdasnidhi@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(124, '4GW23CI054', 'password', 'Suchithra S A', 'ssuchithrasa@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(125, '4GW23CI055', 'password', 'Swasti M Petkar', 'swastimpetkar@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(126, '4GW23CI056', 'password', 'Syeda Afira Ayman', 'afiraayman05@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(127, '4GW23CI057', 'password', 'Tejashwini', 'tejashwinishekharappakaradi@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(128, '4GW23CI058', 'password', 'Thanushree S T', 'thanushreest01@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(129, '4GW23CI059', 'password', 'Thanushri N', 'thanumegha270@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(130, '4GW23CI060', 'password', 'Trupthi H P', 'trupthihp.123@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(131, '4GW23CI061', 'password', 'Vaishnavi S', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(132, '4GW23CI062', 'password', 'Veluru Nandini', 'velurunandini08@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(133, '4GW23CI400', 'password', 'ARPITHA P', 'Arpi47947@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(134, '4GW23CI401', 'password', 'JYOTHI LAKSHMI B S', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(135, '4GW23CI402', 'password', 'SHRENITHA K', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(136, '4GW23CI403', 'password', 'SINCHANA N', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(137, '4GW23CI404', 'password', 'SNEHA K', 'test@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(138, '4GW23CI405', 'password', 'SONIKA P', 'sonikasonu1823@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(139, '4GW23CI406', 'password', 'THANISHKA S', 'thanishka890@gmail.com', 'AIML', 123456, 5, 2023, '0000-00-00', 1),
(140, '4GW24CI001', 'password', 'Achala C', 'chandruachala9@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(141, '4GW24CI002', 'password', 'Ananya B M', 'bmananya2006@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(142, '4GW24CI003', 'password', 'Anjali Ajith', 'anjali.ajith.official@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(143, '4GW24CI004', 'password', 'Aveline Joyce', 'avelinejoyce4@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(144, '4GW24CI005', 'password', 'B Tanmayi', 'tanmayi.b1234@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(145, '4GW24CI006', 'password', 'Basavasiri H L', 'lokeshabasavasiri1140@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(146, '4GW24CI007', 'password', 'Bhavana M P', 'mpbhavana2006@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(147, '4GW24CI008', 'password', 'Bhoomika P', 'bhoomikakp66@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(148, '4GW24CI009', 'password', 'Chandrakala S', 'chandrakalashashidhar.25@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(149, '4GW24CI010', 'password', 'Chinmayi Mohan', 'chinmayi.mohan2006@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(150, '4GW24CI011', 'password', 'Daneti Rakshita Chaitanya', 'rakshitachaitanya34@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(151, '4GW24CI012', 'password', 'Dhanalakshmi N', 'dhanu2006gowda@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(152, '4GW24CI013', 'password', 'Hardageri Hima Bindu', 'himabindureddy912@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(153, '4GW24CI014', 'password', 'Harini Nayaka G M', 'gmharininayaka@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(154, '4GW24CI015', 'password', 'Inaam Haniya Yousuf', 'forstudiesalwayz@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(155, '4GW24CI016', 'password', 'Jeevika K S', 'jeevikaks0811@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(156, '4GW24CI017', 'password', 'Keertana Ammanagi', 'keertana7ammanagi@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(157, '4GW24CI018', 'password', 'Keerthana R', 'keerthanar12106@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(158, '4GW24CI019', 'password', 'Khushi Mishra', 'khushim1109@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(159, '4GW24CI020', 'password', 'Likhitha Shasthry B S', 'likhithashasthry@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(160, '4GW24CI021', 'password', 'Lisha S Kumar', 'lishaskumar5@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(161, '4GW24CI022', 'password', 'M R Meghana', 'mrmeghana2864@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(162, '4GW24CI023', 'password', 'Manya E A', 'manyaananth@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(163, '4GW24CI024', 'password', 'Manya K', 'manyakappannaks02@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(164, '4GW24CI025', 'password', 'Meghana M', 'meghanamurali10@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(165, '4GW24CI026', 'password', 'Megharani Rajkumar Gani', 'meghagani21@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(166, '4GW24CI027', 'password', 'Mohammed Ayesha Tahreem', 'ayeshatahreem1983@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(167, '4GW24CI028', 'password', 'Musanapalli Shruthi Reddy', 'shruthireddy8286@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(168, '4GW24CI029', 'password', 'Nithyashree H', 'nithyapankaja@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(169, '4GW24CI030', 'password', 'Punyashree P R', 'punyashreepr7@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(170, '4GW24CI031', 'password', 'R Veena', 'rajannarajannaprajwal@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(171, '4GW24CI032', 'password', 'Rachana R Rao', 'rachana.radhesh@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(172, '4GW24CI033', 'password', 'Rakshitha M', 'rakshithamrakshi6@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(173, '4GW24CI034', 'password', 'Ria Kuzhikandathil Climis', 'ria.climis@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(174, '4GW24CI035', 'password', 'Sameeksha S', 'sameekshasameksha45@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(175, '4GW24CI036', 'password', 'Samiksha R', 'samiksha.rag05@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(176, '4GW24CI037', 'password', 'Sandhya R', 'sakkuraani32@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(177, '4GW24CI038', 'password', 'Sanika', 'sanikamahesh636112@gamil.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(178, '4GW24CI039', 'password', 'Sanika P', 'sanikapapanna@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(179, '4GW24CI040', 'password', 'Sanjana G Rao', 'sanjanagrao.mys06@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(180, '4GW24CI041', 'password', 'Santhekudlur Nikitha', 'nikithareddysk7@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(181, '4GW24CI042', 'password', 'Shafna M S', 'shafnasalmanms@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(182, '4GW24CI043', 'password', 'Sharanya S Prasad', 'sharanya.mys1@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(183, '4GW24CI044', 'password', 'Shravya H', 'shravyah2910@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(184, '4GW24CI045', 'password', 'Sinchana', 'sinchanamj006@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(185, '4GW24CI046', 'password', 'Sinchana S', 'shankarasinchana@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(186, '4GW24CI047', 'password', 'Siri Patel M', 'siripatel.m861@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(187, '4GW24CI048', 'password', 'Snehaganga N S', 'snehaganganadumane@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(188, '4GW24CI049', 'password', 'Sowndarya B', 'soundaryab0402@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(189, '4GW24CI050', 'password', 'Spandana A Y', 'spandana.ay14@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(190, '4GW24CI051', 'password', 'Spoorthi U', 'spoorthiu10@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(191, '4GW24CI052', 'password', 'Srujana Ponnamma M J', 'srujanaponnammamj@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(192, '4GW24CI053', 'password', 'Subhangi Dutta', 'subhangidutta23@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(193, '4GW24CI054', 'password', 'Swati', 'gulgiswati@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(194, '4GW24CI055', 'password', 'Syeda Saneen', 'saneensyeda06@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(195, '4GW24CI056', 'password', 'Tammisetty Harini', 'haritreaty2006@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(196, '4GW24CI057', 'password', 'Telugu Shivani', 'shivanitelugu8@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(197, '4GW24CI058', 'password', 'Thanushree M R', 'thanushreemrthanu25@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(198, '4GW24CI059', 'password', 'Vaishnavi Pandith M G', 'vaishnavipandith20@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(199, '4GW24CI060', 'password', 'Varsha Suresh', 'varsha.suresh.mys@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(200, '4GW24CI061', 'password', 'Varshitha S', 'hnswaru8@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1),
(201, '4GW24CI062', 'password', 'Yashaswini B G', 'yashaswini05gowda@gmail.com', 'AIML', 123456, 3, 2024, '0000-00-00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
CREATE TABLE IF NOT EXISTS `teachers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `department` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teacher_id` (`teacher_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `teacher_id`, `name`, `email`, `password`, `department`) VALUES
(13, 'T005', 'Sumana', '<email4>@gmail.com', '12345', 'CSE(AI&ML)'),
(12, 'T004', 'Geetha A.L', '<email3>@gmail.com', '12345', 'CSE(AI&ML)'),
(11, 'T003', 'Jeevitha H.M', '<email2>@gmail.com', '12345', 'CSE(AI&ML)'),
(10, 'T002', 'Dr.Arpitha Shankar S.I', '<email1>@gmail.com', '12345', 'CSE(AI&ML)'),
(9, 'T001', 'Dr.Manjuprasad B', '<email1>@gmail.com', '12345', 'CSE(AI&ML)'),
(14, 'T006', 'Dr.G.Sreeramulu Mahesh', '<email5>@gmail.com', '12345', 'CSE(AI&ML)'),
(15, 'T007', 'Syeda Nausheen Fathima', '<email6>@gmail.com', '12345', 'CSE(AI&ML)');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

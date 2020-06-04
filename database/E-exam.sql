-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 25, 2020 at 12:10 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `E-exam`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `ID` int(11) NOT NULL,
  `Nationalid` int(11) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(15) DEFAULT NULL,
  `realName` varchar(15) DEFAULT NULL,
  `graduted` varchar(15) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `request` varchar(10) DEFAULT 'null'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`ID`, `Nationalid`, `Email`, `Password`, `realName`, `graduted`, `age`, `request`) VALUES
(1, 111111, 'moataz@gmail.com', 'moataz', 'moataz', 'm', 40, 'null'),
(2, 222222, 'saad@gmail.com', 'saad11', 'saad', 's', 30, 'null'),
(7, 3333, '3ali33@gmail.com', ':d', ':e', ':f', 40, 'null'),
(8, 2222221, 'saadg@gmail.com', 'mmmmmm', 'jhfyujg', 'm', 9, 'null'),
(9, 0, 'm@hmwil.com', 'gggggg', 'fghjkjhjkk', 'g', 5, 'null');

-- --------------------------------------------------------

--
-- Table structure for table `Chapter`
--

CREATE TABLE `Chapter` (
  `ID` int(11) NOT NULL,
  `subjectname` text DEFAULT NULL,
  `chaptername` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Chapter`
--

INSERT INTO `Chapter` (`ID`, `subjectname`, `chaptername`) VALUES
(14, 'OOP', 'g'),
(15, 'OOP', 'g'),
(18, 'data structure', 'k'),
(20, 'OOP', 'z'),
(21, 'OOP', 'hh'),
(22, 'kk', 'q'),
(23, 'database', 'basic'),
(24, 'database', 'sql');

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE `Department` (
  `ID` int(11) NOT NULL,
  `Name` text DEFAULT NULL,
  `whenstart` text DEFAULT NULL,
  `leader` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Department`
--

INSERT INTO `Department` (`ID`, `Name`, `whenstart`, `leader`) VALUES
(1, 'SE', 'level 1', 'عمر ابو هانى'),
(3, 'bio', 'level 1', 'kk'),
(4, 'IS', 'level 3', '10100'),
(5, 'CS', 'level 3', 'Ahmed Hassan'),
(6, 'IT', 'level 1', 'vwjkwes');

-- --------------------------------------------------------

--
-- Table structure for table `examchapter`
--

CREATE TABLE `examchapter` (
  `ID` int(11) NOT NULL,
  `examid` int(11) DEFAULT NULL,
  `chapter` int(11) DEFAULT NULL,
  `type` text DEFAULT NULL,
  `level` text DEFAULT NULL,
  `count` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `examchapter`
--

INSERT INTO `examchapter` (`ID`, `examid`, `chapter`, `type`, `level`, `count`) VALUES
(108, 45, 2, 'trueandfalse', 'null', '5'),
(109, 45, 1, 'mcq', 'A', '7'),
(110, 45, 2, 'mcq', 'B', '9'),
(111, 45, 1, 'mcq', 'C', '4'),
(112, 45, 1, 'trueandfalse', 'null', '2'),
(113, 47, 1, 'mcq', 'C', '3'),
(114, 47, 1, 'trueandfalse', 'null', '6'),
(115, 47, 1, 'mcq', 'A', '8'),
(116, 47, 1, 'mcq', 'B', '4'),
(180, 108, 1, 'trueandfalse', 'null', '1'),
(181, 108, 1, 'mcq', 'B', '1'),
(182, 108, 2, 'trueandfalse', 'null', '2'),
(183, 108, 1, 'mcq', 'C', '1'),
(184, 108, 2, 'mcq', 'A', '1'),
(185, 108, 2, 'mcq', 'C', '0'),
(186, 108, 1, 'mcq', 'A', '2'),
(187, 108, 2, 'mcq', 'B', '0');

-- --------------------------------------------------------

--
-- Table structure for table `examdetails`
--

CREATE TABLE `examdetails` (
  `ID` int(11) NOT NULL,
  `subject` text DEFAULT NULL,
  `whenstart` text DEFAULT NULL,
  `time` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `examdetails`
--

INSERT INTO `examdetails` (`ID`, `subject`, `whenstart`, `time`) VALUES
(45, 'OOP', '2020-04-08 09:55', '1 Hours'),
(47, 'data structure', '2020-04-08 10:11', '2 Hours'),
(108, 'database', '2020-04-23 12:18', '2 Hours');

-- --------------------------------------------------------

--
-- Table structure for table `Professor`
--

CREATE TABLE `Professor` (
  `ID` int(11) NOT NULL,
  `Nationalid` int(11) DEFAULT NULL,
  `Email` text DEFAULT NULL,
  `Password` text DEFAULT NULL,
  `realName` text DEFAULT NULL,
  `graduted` text DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `request` varchar(10) DEFAULT 'null'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Professor`
--

INSERT INTO `Professor` (`ID`, `Nationalid`, `Email`, `Password`, `realName`, `graduted`, `age`, `request`) VALUES
(6, 111111, 'amr@gmail.com', 'amr111', 'عمرو ابو هانى', 'm', 48, 'null'),
(7, 555555, 'islam@gmail.com', 'islam111', 'اسلام حسن', 'h', 30, 'null'),
(8, 5555559, 'ipislam@gmail.com', 'islam111', 'vwjkwes', 'anakk', 40, 'null'),
(9, 222222, 'ahmed@gmail.com', 'mmmmmm', 'Ahmed Hassan', 'h', 5, 'null');

-- --------------------------------------------------------

--
-- Table structure for table `queastion_mcq`
--

CREATE TABLE `queastion_mcq` (
  `ID` int(11) NOT NULL,
  `Question` text DEFAULT NULL,
  `subject` text DEFAULT NULL,
  `numberofchapter` text DEFAULT NULL,
  `level` text DEFAULT NULL,
  `answer1` text DEFAULT NULL,
  `answer2` text DEFAULT NULL,
  `answer3` text DEFAULT NULL,
  `answer4` text DEFAULT NULL,
  `correctanswer` text DEFAULT NULL,
  `bank` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `queastion_mcq`
--

INSERT INTO `queastion_mcq` (`ID`, `Question`, `subject`, `numberofchapter`, `level`, `answer1`, `answer2`, `answer3`, `answer4`, `correctanswer`, `bank`) VALUES
(1, 'fd', 'OOP', '3', 'C', 'd', 'j', 'f', 'k', 'f', 'false'),
(2, 'u', 'OOP', '2', 'B', 'p', 'k', 'g', 'u', 'k', 'true'),
(3, 'd', 'data structure', '1', 'B', 'f', 'j', 'b', 'p', 'j', 'true'),
(4, 'q1', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'e', 'false'),
(5, 'q2', 'OOP', '2', 'C', 'z', 'x', 'c', 'v', 'x', 'true'),
(6, 'qa1', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(7, 'qa2', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(8, 'qa3', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(9, 'qa4', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(10, 'qa5', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(11, 'qa6', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(12, 'qa7', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(13, 'qa8', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(14, 'qa9', 'OOP', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(23, 'qb1', 'OOP', '1', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(24, 'qb2', 'OOP', '1', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(25, 'qb3', 'OOP', '1', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(26, 'qb4', 'OOP', '1', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(27, 'qb5', 'OOP', '1', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(28, 'qb6', 'OOP', '1', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(29, 'qb7', 'OOP', '1', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(30, 'qb8', 'OOP', '1', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(31, 'qc1', 'OOP', '1', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(32, 'qc2', 'OOP', '1', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(33, 'qc3', 'OOP', '1', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(34, 'qc4', 'OOP', '1', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(35, 'qc5', 'OOP', '1', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(36, 'wa1', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(37, 'wa2', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(38, 'wa3', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(39, 'wa4', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(40, 'wa5', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(41, 'wa6', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(42, 'wa7', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(43, 'wa8', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(44, 'wa9', 'OOP', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(45, 'wb1', 'OOP', '2', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(46, 'wb2', 'OOP', '2', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(47, 'wb3', 'OOP', '2', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(48, 'wb4', 'OOP', '2', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(49, 'wb5', 'OOP', '2', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(50, 'wb6', 'OOP', '2', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(51, 'wb7', 'OOP', '2', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(52, 'wb8', 'OOP', '2', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(53, 'wc1', 'OOP', '2', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(54, 'wc2', 'OOP', '2', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(55, 'wc3', 'OOP', '2', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(56, 'wc4', 'OOP', '2', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(57, 'ea1', 'OOP', '3', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(58, 'ea2', 'OOP', '3', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(59, 'ea3', 'OOP', '3', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(60, 'ea4', 'OOP', '3', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(61, 'ea5', 'OOP', '3', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(62, 'ea6', 'OOP', '3', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(63, 'eb1', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(64, 'eb2', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(65, 'eb3', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(66, 'eb4', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(67, 'eb5', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(68, 'eb6', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(69, 'eb7', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(70, 'eb8', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(71, 'eb9', 'OOP', '3', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(72, 'ec1', 'OOP', '3', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(73, 'ec2', 'OOP', '3', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(74, 'ec3', 'OOP', '3', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(75, 'ec4', 'OOP', '3', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(76, 'ec5', 'OOP', '3', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(77, 'ra1', 'OOP', '4', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(78, 'ra2', 'OOP', '4', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(79, 'ra3', 'OOP', '4', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(80, 'ra4', 'OOP', '4', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(81, 'ra5', 'OOP', '4', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(82, 'ra6', 'OOP', '4', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(83, 'rb1', 'OOP', '4', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(84, 'rb2', 'OOP', '4', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(85, 'rb3', 'OOP', '4', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(86, 'rb4', 'OOP', '4', 'B', 'q', 'w', 'e', 'r', 'w', 'false'),
(90, 'rc3', 'OOP', '4', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(91, 'rc2', 'OOP', '4', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(92, 'rc1', 'OOP', '4', 'C', 'q', 'w', 'e', 'r', 'w', 'false'),
(93, 'da1', 'data structure', '1', 'A', 'a', 's', 'd', 'f', 'd', 'true'),
(94, 'da2', 'data structure', '1', 'A', 'a', 's', 'd', 'f', 'd', 'true'),
(95, 'da3', 'data structure', '1', 'A', 'a', 's', 'd', 'f', 'd', 'true'),
(96, 'da4', 'data structure', '1', 'A', 'a', 's', 'd', 'f', 'd', 'true'),
(97, 'da5', 'data structure', '1', 'A', 'a', 's', 'd', 'f', 'd', 'true'),
(98, 'db1', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(99, 'db2', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(100, 'db3', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(101, 'db4', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(102, 'db5', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(103, 'db6', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(104, 'db7', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(105, 'db8', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(106, 'db9', 'data structure', '1', 'B', 'a', 's', 'd', 'f', 'd', 'true'),
(107, 'dc1', 'data structure', '1', 'C', 'a', 's', 'd', 'f', 'd', 'true'),
(108, 'dc2', 'data structure', '1', 'C', 'a', 's', 'd', 'f', 'd', 'true'),
(109, 'dc3', 'data structure', '1', 'C', 'a', 's', 'd', 'f', 'd', 'true'),
(110, 'b1', 'kk', '1', 'A', 'z', 'x', 'c', 'v', 'c', 'false'),
(111, 'b2', 'kk', '1', 'B', 'z', 'x', 'c', 'v', 'x', 'false'),
(112, 'b3', 'kk', '1', 'C', 'z', 'x', 'c', 'v', 'x', 'false'),
(113, 'mcqa1', 'database', '1', 'A', 'q', 'w', 'e', 'r', 'e', 'false'),
(114, 'mcqa2', 'database', '1', 'A', 'q', 'w', 'e', 'r', 'w', 'false'),
(115, 'q1b', 'database', '1', 'B', 'a', 'd', 'f', 's', 'f', 'false'),
(116, 'q2b', 'database', '1', 'B', 'a', 's', 'd', 'f', 'd', 'false'),
(117, 'q1c', 'database', '1', 'C', 'z', 'x', 'c', 'v', 'c', 'false'),
(118, 'qc1a', 'database', '2', 'A', 'q', 'w', 'e', 'r', 'w', 'true');

-- --------------------------------------------------------

--
-- Table structure for table `queastion_true_and_false`
--

CREATE TABLE `queastion_true_and_false` (
  `ID` int(11) NOT NULL,
  `Question` text DEFAULT NULL,
  `subject` text DEFAULT NULL,
  `numberofchapter` text DEFAULT NULL,
  `correctanswer` text DEFAULT NULL,
  `bank` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `queastion_true_and_false`
--

INSERT INTO `queastion_true_and_false` (`ID`, `Question`, `subject`, `numberofchapter`, `correctanswer`, `bank`) VALUES
(1, 'yy', 'OOP', '2', 'False', 'true'),
(2, 'z', 'data structure', '1', 'True', 'true'),
(3, 'x', 'data structure', '1', 'True', 'true'),
(4, '1', 'OOP', '1', 'True', 'false'),
(5, '2', 'OOP', '1', 'True', 'false'),
(6, '3', 'OOP', '1', 'True', 'false'),
(7, '4', 'OOP', '1', 'True', 'false'),
(8, '5', 'OOP', '1', 'True', 'false'),
(9, '6', 'OOP', '1', 'True', 'false'),
(10, '7', 'OOP', '1', 'True', 'false'),
(11, '8', 'OOP', '1', 'True', 'false'),
(12, '9', 'OOP', '1', 'True', 'false'),
(13, '10', 'OOP', '1', 'True', 'false'),
(16, '11', 'OOP', '2', 'True', 'false'),
(17, '12', 'OOP', '2', 'True', 'false'),
(18, '13', 'OOP', '2', 'True', 'false'),
(19, '14', 'OOP', '2', 'True', 'false'),
(20, '15', 'OOP', '2', 'True', 'false'),
(21, '16', 'OOP', '2', 'True', 'false'),
(22, '17', 'OOP', '2', 'True', 'false'),
(23, '18', 'OOP', '3', 'True', 'false'),
(24, '19', 'OOP', '3', 'True', 'false'),
(25, '20', 'OOP', '3', 'True', 'false'),
(26, '21', 'OOP', '3', 'True', 'false'),
(27, '22', 'OOP', '3', 'True', 'false'),
(28, '23', 'OOP', '3', 'True', 'false'),
(29, '24', 'OOP', '3', 'True', 'false'),
(30, '25', 'OOP', '3', 'True', 'false'),
(31, '26', 'OOP', '3', 'True', 'false'),
(32, '27', 'OOP', '3', 'True', 'false'),
(33, '28', 'OOP', '4', 'True', 'false'),
(34, '29', 'OOP', '4', 'True', 'false'),
(35, '30', 'OOP', '4', 'True', 'false'),
(36, '31', 'OOP', '4', 'True', 'false'),
(37, '32', 'OOP', '4', 'True', 'false'),
(38, '33', 'OOP', '4', 'True', 'false'),
(39, '34', 'OOP', '4', 'True', 'false'),
(40, '35', 'OOP', '4', 'True', 'false'),
(41, '36', 'data structure', '1', 'True', 'false'),
(42, '37', 'data structure', '1', 'True', 'false'),
(43, '38', 'data structure', '1', 'True', 'false'),
(44, '39', 'data structure', '1', 'True', 'false'),
(45, '40', 'data structure', '1', 'True', 'false'),
(46, 'b1', 'kk', '1', 'True', 'false'),
(47, 't1', 'database', '1', 'True', 'false'),
(48, 'tc1', 'database', '2', 'True', 'true'),
(49, 'tc2', 'database', '2', 'False', 'false');

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `ID` int(11) NOT NULL,
  `type` varchar(11) DEFAULT NULL,
  `Nationalid` int(11) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(20) DEFAULT NULL,
  `realName` varchar(20) DEFAULT NULL,
  `graduted` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`ID`, `type`, `Nationalid`, `Email`, `Password`, `realName`, `graduted`, `age`) VALUES
(42, 'Professor', 333333, 'hassan@gmail.com', 'mmmmmm', 'hassan ahmed', 'f', 5),
(48, 'Professor', 2222220, 'aa@hmail.coom', 'sgggjj', 'jhfgjhfjj', 'dgbhj', 65),
(49, 'Professor', 2222229, 'ahme0d@gmail.com', 'ffffff', 'ffffffff', 'ff', 55),
(53, 'Professor', 0, 'ddf@fh.dj', 'fuggvbhh', 'chhffyuf', 'fjfg', 86633),
(55, 'Admin', 589632, 'x@gm.com', 'xxxxxx', 'xxxxxxxx', 'x', 8),
(56, 'Professor', 1111110, 'amrm@gmail.com', 'gggggg', 'fkfkcjjfhgdhhu', 'fjfdjgffg', 55),
(57, 'Admin', 5896328, 'x@gmail.com', 'fhhjjhh', 'chgjjhjkhgh', 'ghh', 566),
(58, 'Admin', 55889963, 'xm@gmail.com', 'qqsdjljj', 'fhffgghjkjg', 'thh', 669);

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `ID` int(11) NOT NULL,
  `Nationalid` int(11) DEFAULT NULL,
  `Collageid` int(11) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `level` text DEFAULT NULL,
  `department` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`ID`, `Nationalid`, `Collageid`, `name`, `password`, `level`, `department`) VALUES
(1, 222222, 222222, 'asdasd', '222222', 'level 2', 'SE'),
(45, 2226666, 2222229, 'ghlojug', 'gjjhkkuyukj', 'level 3', 'IS'),
(46, 111111, 111111, 'ahmed Mohamed', '111111', 'level 3', 'IS');

-- --------------------------------------------------------

--
-- Table structure for table `Subject`
--

CREATE TABLE `Subject` (
  `ID` int(11) NOT NULL,
  `Name` varchar(15) DEFAULT NULL,
  `department` varchar(65) DEFAULT NULL,
  `professor` varchar(65) DEFAULT NULL,
  `level` varchar(65) DEFAULT NULL,
  `semester` varchar(15) DEFAULT NULL,
  `counter` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Subject`
--

INSERT INTO `Subject` (`ID`, `Name`, `department`, `professor`, `level`, `semester`, `counter`) VALUES
(1, 'OOP', 'general', 'عمرو ابو هانى', 'level 3', 'semester 1', '4'),
(4, 'data structure', 'general', 'عمرو ابو هانى', 'level 2', 'semester 2', '1'),
(6, 'sql', 'bio', 'اسلام حسن', 'level 3', 'semester 2', '1'),
(7, 'database', 'IS', 'Ahmed Hassan', 'level 3', 'semester 2', '2'),
(8, 'network', 'IT', 'vwjkwes', 'level 4', 'semester 1', '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nationalid` (`Nationalid`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `Chapter`
--
ALTER TABLE `Chapter`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Department`
--
ALTER TABLE `Department`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Name` (`Name`) USING HASH;

--
-- Indexes for table `examchapter`
--
ALTER TABLE `examchapter`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `examdetails`
--
ALTER TABLE `examdetails`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Professor`
--
ALTER TABLE `Professor`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nationalid` (`Nationalid`),
  ADD UNIQUE KEY `Email` (`Email`) USING HASH;

--
-- Indexes for table `queastion_mcq`
--
ALTER TABLE `queastion_mcq`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Question` (`Question`) USING HASH;

--
-- Indexes for table `queastion_true_and_false`
--
ALTER TABLE `queastion_true_and_false`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Question` (`Question`) USING HASH;

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nationalid` (`Nationalid`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nationalid` (`Nationalid`),
  ADD UNIQUE KEY `Collageid` (`Collageid`);

--
-- Indexes for table `Subject`
--
ALTER TABLE `Subject`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Chapter`
--
ALTER TABLE `Chapter`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `Department`
--
ALTER TABLE `Department`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `examchapter`
--
ALTER TABLE `examchapter`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=188;

--
-- AUTO_INCREMENT for table `examdetails`
--
ALTER TABLE `examdetails`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `Professor`
--
ALTER TABLE `Professor`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `queastion_mcq`
--
ALTER TABLE `queastion_mcq`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `queastion_true_and_false`
--
ALTER TABLE `queastion_true_and_false`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `Student`
--
ALTER TABLE `Student`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `Subject`
--
ALTER TABLE `Subject`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2021 at 03:20 PM
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
-- Database: `console`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AdminId` varchar(20) NOT NULL,
  `Email` varchar(20) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `attendence`
--

CREATE TABLE `attendence` (
  `AttendenceId` varchar(20) NOT NULL,
  `Status` binary(2) NOT NULL,
  `StudentId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `classId` varchar(20) NOT NULL,
  `ClassName` varchar(50) NOT NULL,
  `AdminId` varchar(20) NOT NULL,
  `TeacherId` varchar(20) NOT NULL,
  `StudentId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `marks`
--

CREATE TABLE `marks` (
  `StudentId` varchar(20) NOT NULL,
  `TeacherId` varchar(20) NOT NULL,
  `Marks` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `MessageId` varchar(20) NOT NULL,
  `Message` varchar(500) NOT NULL,
  `TeacherId` varchar(20) NOT NULL,
  `StudentId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `NotificationId` varchar(20) NOT NULL,
  `Notification` varchar(500) NOT NULL,
  `TeacherId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `PaymentId` varchar(20) NOT NULL,
  `StudentId` varchar(20) NOT NULL,
  `AdminId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `StudentId` varchar(20) NOT NULL,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `MobileNumber` int(20) NOT NULL,
  `ClassId` varchar(20) NOT NULL,
  `NotificationId` varchar(20) NOT NULL,
  `MessageId` varchar(20) NOT NULL,
  `TimeTableId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `TeacherId` varchar(20) NOT NULL,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(20) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `MobileNumber` int(20) NOT NULL,
  `ClassId` varchar(20) NOT NULL,
  `NotificationId` varchar(20) NOT NULL,
  `MessageId` varchar(20) NOT NULL,
  `TimeTableId` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `TimeTableId` varchar(20) NOT NULL,
  `StartTime` varchar(20) NOT NULL,
  `EndTime` varchar(20) NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminId`);

--
-- Indexes for table `attendence`
--
ALTER TABLE `attendence`
  ADD PRIMARY KEY (`AttendenceId`),
  ADD UNIQUE KEY `StudentId` (`StudentId`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`classId`),
  ADD UNIQUE KEY `AdminId` (`AdminId`,`TeacherId`,`StudentId`),
  ADD KEY `TeacherId` (`TeacherId`),
  ADD KEY `StudentId` (`StudentId`);

--
-- Indexes for table `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`StudentId`,`TeacherId`),
  ADD UNIQUE KEY `StudentId` (`StudentId`,`TeacherId`),
  ADD KEY `TeacherId` (`TeacherId`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`MessageId`),
  ADD UNIQUE KEY `TeacherId` (`TeacherId`,`StudentId`),
  ADD KEY `StudentId` (`StudentId`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`NotificationId`),
  ADD UNIQUE KEY `TeacherId` (`TeacherId`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`PaymentId`),
  ADD UNIQUE KEY `StudentId` (`StudentId`,`AdminId`),
  ADD KEY `AdminId` (`AdminId`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`StudentId`),
  ADD UNIQUE KEY `NotificationId` (`NotificationId`),
  ADD UNIQUE KEY `MessageId` (`MessageId`),
  ADD UNIQUE KEY `TimeTableId` (`TimeTableId`),
  ADD UNIQUE KEY `ClassId` (`ClassId`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`TeacherId`),
  ADD UNIQUE KEY `ClassId` (`ClassId`,`NotificationId`,`MessageId`,`TimeTableId`),
  ADD KEY `NotificationId` (`NotificationId`),
  ADD KEY `MessageId` (`MessageId`),
  ADD KEY `TimeTableId` (`TimeTableId`);

--
-- Indexes for table `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`TimeTableId`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendence`
--
ALTER TABLE `attendence`
  ADD CONSTRAINT `attendence_ibfk_1` FOREIGN KEY (`StudentId`) REFERENCES `student` (`StudentId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `teacher` (`ClassId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `class_ibfk_2` FOREIGN KEY (`AdminId`) REFERENCES `admin` (`AdminId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `class_ibfk_3` FOREIGN KEY (`TeacherId`) REFERENCES `teacher` (`TeacherId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `class_ibfk_4` FOREIGN KEY (`StudentId`) REFERENCES `student` (`StudentId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `marks`
--
ALTER TABLE `marks`
  ADD CONSTRAINT `marks_ibfk_1` FOREIGN KEY (`StudentId`) REFERENCES `student` (`StudentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `marks_ibfk_2` FOREIGN KEY (`TeacherId`) REFERENCES `teacher` (`TeacherId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`TeacherId`) REFERENCES `teacher` (`TeacherId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`StudentId`) REFERENCES `student` (`StudentId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`TeacherId`) REFERENCES `teacher` (`TeacherId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`AdminId`) REFERENCES `admin` (`AdminId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`StudentId`) REFERENCES `student` (`StudentId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`ClassId`) REFERENCES `class` (`classId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `student_ibfk_2` FOREIGN KEY (`NotificationId`) REFERENCES `notification` (`NotificationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `student_ibfk_3` FOREIGN KEY (`MessageId`) REFERENCES `message` (`MessageId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `student_ibfk_4` FOREIGN KEY (`TimeTableId`) REFERENCES `timetable` (`TimeTableId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`NotificationId`) REFERENCES `notification` (`NotificationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`MessageId`) REFERENCES `message` (`MessageId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `teacher_ibfk_3` FOREIGN KEY (`TimeTableId`) REFERENCES `timetable` (`TimeTableId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2019 at 05:56 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `speed_age`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_order` ()  select COUNT(*) as count FROM consignment$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_par` (IN `sname` VARCHAR(20))  NO SQL
SELECT shippername,COUNT(*) AS COUNT from consignment WHERE shippername=sname$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `profit` ()  SELECT SUM(shipment_charge) FROM consignment$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `profit branch` (IN `branchid` TEXT)  SELECT branch_id,booked_at_branch,SUM(shipment_charge) AS SUM
FROM consignment 
WHERE branch_id=branchid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `vieworder` (IN `sname` VARCHAR(20))  NO SQL
SELECT * FROM consignment WHERE shippername=sname$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `admin` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `admin`, `password`) VALUES
(1, 'admin', '1234'),
(15, 'trishala', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `id` int(11) NOT NULL,
  `dealer_name` text NOT NULL,
  `branchaddress` text NOT NULL,
  `phone` text NOT NULL,
  `branch_location` text NOT NULL,
  `pincode` text NOT NULL,
  `branch_name` text NOT NULL,
  `branch_id` text NOT NULL,
  `reqid` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`id`, `dealer_name`, `branchaddress`, `phone`, `branch_location`, `pincode`, `branch_name`, `branch_id`, `reqid`) VALUES
(5, 'shrinkhla', ' dehradun', '7021345678', 'dehradun', '214565', 'dehradun', 'bra1573823267', '1573823098'),
(6, 'ekta', ' chansandra', '7021345678', 'banglore', '600501', 'chansandra', 'bra1573988940', '1573988872'),
(7, 'yashwanth', ' malur', '8794562121', 'malur', '600502', 'malur', 'bra1573989032', '1573989007'),
(8, 'tripti', ' lalpur', '7021345678', 'ranchi', '52144', 'ranchi', 'bra1573989113', '1573989089'),
(9, 'alisha', ' delhi', '8794562121', 'delhi', '600502', 'delhi', 'bra1574011743', '1574011693'),
(10, 'spoorthy', ' kengeri', '7021345678', 'banglore', '524633', 'kengeri', 'bra1574060946', '1574060907'),
(11, 'khushi', ' indore', '7894561230', 'indore', '456123', 'indore', 'bra1574225697', '1574225667'),
(12, 'ekta', ' digha', '7021345678', 'patna', '214565', 'patna', 'bra1575199887', '1575199804');

-- --------------------------------------------------------

--
-- Table structure for table `consignment`
--

CREATE TABLE `consignment` (
  `id` int(11) NOT NULL,
  `shippername` text NOT NULL,
  `shipperasddress` varchar(20) NOT NULL,
  `phone` text NOT NULL,
  `material_descrption` text NOT NULL,
  `no_of_item` int(20) NOT NULL,
  `branch_id` text NOT NULL,
  `booked_at_branch` text NOT NULL,
  `date_of_booking` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `shipment_charge` text NOT NULL,
  `total_weight` text NOT NULL,
  `reciver_name` text NOT NULL,
  `reciver_address` varchar(20) NOT NULL,
  `reciver_phone` text NOT NULL,
  `ccn` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `consignment`
--

INSERT INTO `consignment` (`id`, `shippername`, `shipperasddress`, `phone`, `material_descrption`, `no_of_item`, `branch_id`, `booked_at_branch`, `date_of_booking`, `shipment_charge`, `total_weight`, `reciver_name`, `reciver_address`, `reciver_phone`, `ccn`) VALUES
(24, 'rahul', 'banglore', '7022264197', 'document', 1, 'bra1573823267', 'delhi', '2019-11-13 18:30:00', '45220', '1', 'ekta', 'ranchi', '7895412321', 'Book1574098675'),
(25, 'sachin', 'delhi', '7022264197', 'document', 1, 'bra1573823267', 'banglore', '2019-11-08 18:30:00', '1234', '1', 'ekta', 'banglore', '7895412321', 'Book1574185759'),
(26, 'rahul', 'indore', '7854122222', 'document', 7, 'bra1574225697', 'indore', '2019-11-19 18:30:00', '1000', '8', 'dev', 'banglore', '7845123690', 'Book1574225844'),
(27, 'raj', 'banglore', '7022264197', 'document', 1, 'bra1573988940', 'banglore', '2019-11-15 18:30:00', '1234', '1', 'trishala', 'hose no 15,rr nagar,', '7895412321', 'Book1574226812');

--
-- Triggers `consignment`
--
DELIMITER $$
CREATE TRIGGER `add_track` AFTER INSERT ON `consignment` FOR EACH ROW INSERT INTO courier_track VALUES(new.ccn,new.shippername,NOW(),'loaded')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `booking_time` AFTER INSERT ON `consignment` FOR EACH ROW INSERT INTO consign_time VALUES('consignment received',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cons_track` AFTER INSERT ON `consignment` FOR EACH ROW UPDATE courier_track
SET ccn=ccn,sender_name=new.shippername,date=NOW(),status='loaded'
WHERE ccn=new.ccn
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `consign_time`
--

CREATE TABLE `consign_time` (
  `event` varchar(20) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `consign_time`
--

INSERT INTO `consign_time` (`event`, `time`) VALUES
('consignment received', '2019-11-16 04:37:05'),
('consignment received', '2019-11-16 04:51:31'),
('consignment received', '2019-11-17 17:38:25'),
('consignment received', '2019-11-17 17:41:44'),
('consignment received', '2019-11-18 03:30:35'),
('consignment received', '2019-11-18 16:45:24'),
('consignment received', '2019-11-18 17:24:28'),
('consignment received', '2019-11-18 17:27:11'),
('consignment received', '2019-11-18 17:34:35'),
('consignment received', '2019-11-18 17:37:55'),
('consignment received', '2019-11-19 17:49:19'),
('consignment received', '2019-11-20 04:57:24'),
('consignment received', '2019-11-20 05:13:32');

-- --------------------------------------------------------

--
-- Table structure for table `corporate`
--

CREATE TABLE `corporate` (
  `id` int(11) NOT NULL,
  `user_id` text NOT NULL,
  `password` text NOT NULL,
  `address` text NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `corporate`
--

INSERT INTO `corporate` (`id`, `user_id`, `password`, `address`, `email`) VALUES
(1, 'sachin', '1234', 'banglore', ''),
(8, '45', 'trishala', 'BANGLORE', ''),
(11, 'khushi', '1235', 'BANGLORE', ''),
(15, 'raj', '1234', 'BANGLORE', 'tris8@gmail.com'),
(21, 'khushi', '147', 'BANGLORE', 'tris8@gmail.com'),
(22, 'khushi', '147', 'BANGLORE', 'tris8@gmail.com'),
(23, 'raj', '1234', 'BANGLORE', 'kj@ghn.vnamj');

-- --------------------------------------------------------

--
-- Table structure for table `courier_track`
--

CREATE TABLE `courier_track` (
  `ccn` text NOT NULL,
  `sender_name` text NOT NULL,
  `date` datetime NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `courier_track`
--

INSERT INTO `courier_track` (`ccn`, `sender_name`, `date`, `status`) VALUES
('Book1574098675', 'rahul', '2019-11-20 10:51:23', 'dispatched'),
('Book1574185759', 'sachin', '2019-11-19 23:19:19', 'loaded'),
('Book1574225844', 'rahul', '2019-11-20 10:38:45', 'delivered'),
('Book1574226812', 'raj', '2019-11-20 10:45:16', 'shipped');

-- --------------------------------------------------------

--
-- Table structure for table `deaer`
--

CREATE TABLE `deaer` (
  `id` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `email` varchar(20) NOT NULL,
  `address` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deaer`
--

INSERT INTO `deaer` (`id`, `username`, `password`, `email`, `address`) VALUES
(1, 'dealer', '1234', '', ''),
(10, 'raj', '234', 'kj@ghn.vnamj', 'BANGLORE'),
(11, 'khushboo', '1234', 'kumarikhusi@gmail.co', 'BANGLORE'),
(12, 'trishala', '1234', 'kumaritri@gmail.com', 'BANGLORE'),
(13, 'spoorthy', '1234', 'kumaritri@gmail.com', 'BANGLORE'),
(14, 'khushi', '1234', 'kumarikhusi@gmail.co', 'indore'),
(15, 'ekta', '1234', 'kumaritri@gmail.com', 'patna');

-- --------------------------------------------------------

--
-- Table structure for table `dearship_request`
--

CREATE TABLE `dearship_request` (
  `name` text NOT NULL,
  `address` text NOT NULL,
  `phone` text NOT NULL,
  `applydate` date NOT NULL,
  `amount` int(100) NOT NULL,
  `branch_location` text NOT NULL,
  `office` text NOT NULL,
  `pincode` int(20) NOT NULL,
  `reqid` text NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dearship_request`
--

INSERT INTO `dearship_request` (`name`, `address`, `phone`, `applydate`, `amount`, `branch_location`, `office`, `pincode`, `reqid`, `id`) VALUES
('ekta', 'patna', '702226547', '1998-02-12', 20000, 'banglore', 'banglore', 60050, '1572802673', 2),
('shrinkhla', 'rudrapoor', '7021345678', '2019-02-12', 2000, 'dehradun', 'dehradun', 214565, '1573823098', 3),
('ekta', 'banglore', '7021345678', '2019-11-08', 2000, 'banglore', 'chansandra', 600501, '1573988872', 4),
('yashwanth', 'banglore', '8794562121', '2019-11-02', 2000, 'malur', 'malur', 600502, '1573989007', 5),
('tripti', 'ranchi', '7021345678', '2019-11-05', 2000, 'ranchi', 'lalpur', 52144, '1573989089', 6),
('alisha', 'delhi', '8794562121', '2019-11-02', 2000, 'delhi', 'delhi', 600502, '1574011693', 7),
('spoorthy', 'banglore', '7021345678', '2019-11-15', 2000, 'banglore', 'kengeri', 524633, '1574060907', 8),
('khushi', 'indore', '7894561230', '2019-11-16', 2000, 'indore', 'indore', 456123, '1574225667', 9),
('ekta', 'patna', '7021345678', '2019-12-18', 2000, 'patna', 'digha', 214565, '1575199804', 10);

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `id` int(11) NOT NULL,
  `ccn` text NOT NULL,
  `deliveryid` text NOT NULL,
  `shippername` text NOT NULL,
  `bookatbranch` text NOT NULL,
  `deliveryedatbranch` text NOT NULL,
  `dealername` text NOT NULL,
  `dateofdelivery` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`id`, `ccn`, `deliveryid`, `shippername`, `bookatbranch`, `deliveryedatbranch`, `dealername`, `dateofdelivery`) VALUES
(14, 'Book1574098675', 'del1574099007', 'rahul', 'bra1573823267', 'bra1573988940', 'ekta', '2019-11-09'),
(15, 'Book1574225844', 'del1574225924', 'rahul', 'bra1574225697', 'bra1573988940', 'ekta', '2019-11-20'),
(16, 'Book1574226812', 'del1574226916', 'raj', 'bra1573988940', 'bra1573988940', 'ekta', '2019-11-22');

--
-- Triggers `delivery`
--
DELIMITER $$
CREATE TRIGGER `deliver_track` AFTER INSERT ON `delivery` FOR EACH ROW UPDATE courier_track
SET date=NOW(),status='shipped'
WHERE ccn=new.ccn
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dispatcher`
--

CREATE TABLE `dispatcher` (
  `id` int(11) NOT NULL,
  `ccn` text NOT NULL,
  `Branch_name` text NOT NULL,
  `shipper_name` text NOT NULL,
  `phone` text NOT NULL,
  `sender_address` text NOT NULL,
  `reciver_name` text NOT NULL,
  `reciver_phoneno` text NOT NULL,
  `reciver_ address` text NOT NULL,
  `assignedto` text NOT NULL,
  `dispatcher_Id` text NOT NULL,
  `dispatchid` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dispatcher`
--

INSERT INTO `dispatcher` (`id`, `ccn`, `Branch_name`, `shipper_name`, `phone`, `sender_address`, `reciver_name`, `reciver_phoneno`, `reciver_ address`, `assignedto`, `dispatcher_Id`, `dispatchid`) VALUES
(20, 'Book1574225844', 'bra1574225697', 'rahul', '7854122222', 'indore', 'dev', '7845123690', 'banglore', 'EMP1572767672', 'EMP1572767672', 'DIS1574225951'),
(21, 'Book1574098675', 'bra1573823267', 'rahul', '7022264197', 'banglore', 'ekta', '7895412321', 'ranchi', 'EMP1573990295', 'EMP1573990295', 'DIS1574227283');

--
-- Triggers `dispatcher`
--
DELIMITER $$
CREATE TRIGGER `dispatch_track` AFTER INSERT ON `dispatcher` FOR EACH ROW UPDATE courier_track
SET date=NOW(),status='dispatched'
WHERE ccn=new.ccn
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `emplyee`
--

CREATE TABLE `emplyee` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `role` text NOT NULL,
  `branchid` text NOT NULL,
  `branch_name` text NOT NULL,
  `branch_location` text NOT NULL,
  `dateofjoin` date NOT NULL,
  `salary` int(100) NOT NULL,
  `Empid` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emplyee`
--

INSERT INTO `emplyee` (`id`, `name`, `role`, `branchid`, `branch_name`, `branch_location`, `dateofjoin`, `salary`, `Empid`) VALUES
(4, 'kundan', 'Deliveryboy', 'bra1528549763', 'banglore', 'banglore', '2012-02-02', 5010, 'EMP1572767672'),
(5, 'yash', 'Deliveryboy', 'bra1573823267', 'dehradun', 'dehradun', '2019-02-12', 2541, 'EMP1573823744'),
(6, 'vikash', 'Deliveryboy', 'bra1573989032', 'malur', 'malur', '2019-11-09', 1000, 'EMP1573990295'),
(7, 'abhijeet', 'Deliveryboy', 'bra1575199887', 'patna', 'patna', '2019-12-14', 2000, 'EMP1575200022');

-- --------------------------------------------------------

--
-- Table structure for table `receiver`
--

CREATE TABLE `receiver` (
  `id` int(11) NOT NULL,
  `ccn` text NOT NULL,
  `receiver_name` text NOT NULL,
  `reciverphoneno` text NOT NULL,
  `Material` text NOT NULL,
  `dateofreceive` text NOT NULL,
  `recivername` text NOT NULL,
  `relation` text NOT NULL,
  `Dispatchername` text NOT NULL,
  `DispatcherID` text NOT NULL,
  `receiver_id` text NOT NULL,
  `BookedAt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `receiver`
--

INSERT INTO `receiver` (`id`, `ccn`, `receiver_name`, `reciverphoneno`, `Material`, `dateofreceive`, `recivername`, `relation`, `Dispatchername`, `DispatcherID`, `receiver_id`, `BookedAt`) VALUES
(9, 'Book1574098675', 'ekta', '7895412321', 'books', '2019-11-14', 'trishala', 'friend', 'EMP1572767672', 'EMP1572767672', 'REC1574099437', 'bra1573823267'),
(10, 'Book1574225844', 'dev', '7845123690', 'books', '2019-11-22', 'trishala', 'friend', 'EMP1572767672', 'EMP1572767672', 'REC1574226525', 'bra1574225697');

--
-- Triggers `receiver`
--
DELIMITER $$
CREATE TRIGGER `rece_track` AFTER INSERT ON `receiver` FOR EACH ROW UPDATE courier_track
SET date=NOW(),status='delivered'
WHERE ccn=new.ccn
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `testimonial`
--

CREATE TABLE `testimonial` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `subject` text NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `testimonial`
--

INSERT INTO `testimonial` (`id`, `name`, `email`, `subject`, `message`) VALUES
(5, 'tri', 'kumaritri@gmail.com', 'delivery', 'i love the services'),
(6, 'trishala', 'tris8@gmail.com', 'product', 'damage product received'),
(426, 'khushboo', 'kumarikhusi@gmail.com', 'product', 'damaged'),
(427, 'ekta singh', 'kumaritri@gmail.com', 'delivery', 'good exprience');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dealer_name` (`dealer_name`(3072)),
  ADD KEY `branchaddress` (`branchaddress`(3072));

--
-- Indexes for table `consignment`
--
ALTER TABLE `consignment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `consign_time`
--
ALTER TABLE `consign_time`
  ADD PRIMARY KEY (`time`);

--
-- Indexes for table `corporate`
--
ALTER TABLE `corporate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deaer`
--
ALTER TABLE `deaer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dearship_request`
--
ALTER TABLE `dearship_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dispatcher`
--
ALTER TABLE `dispatcher`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emplyee`
--
ALTER TABLE `emplyee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `receiver`
--
ALTER TABLE `receiver`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonial`
--
ALTER TABLE `testimonial`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `consignment`
--
ALTER TABLE `consignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `corporate`
--
ALTER TABLE `corporate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `deaer`
--
ALTER TABLE `deaer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `dearship_request`
--
ALTER TABLE `dearship_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `dispatcher`
--
ALTER TABLE `dispatcher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `emplyee`
--
ALTER TABLE `emplyee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `receiver`
--
ALTER TABLE `receiver`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `testimonial`
--
ALTER TABLE `testimonial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=428;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2021 at 09:28 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `author` varchar(20) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `image_file` varchar(20) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `author`, `slug`, `content`, `image_file`, `date`) VALUES
(2, 'Post # 1', 'Admin', 'post-no-1', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis corrupti, fugiat rerum molestias sit eos animi magnam, reiciendis, dolorem facere obcaecati enim sed minima vitae eum. Libero alias aliquam a! Nisi, ex! Aspernatur maxime, voluptates tempore dolorum odio amet nobis!', 'home-bg.jpg', '2021-02-17 12:50:38'),
(3, 'Post # 2', 'Sarmad Khalique', 'post-no-3', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis corrupti, fugiat rerum molestias sit eos animi magnam, reiciendis, dolorem facere obcaecati enim sed minima vitae eum. Libero alias aliquam a! Nisi, ex! Aspernatur maxime, voluptates tempore dolorum odio amet nobis!', 'home-bg.jpg', '2021-02-17 12:05:33'),
(4, 'Post # 3', 'Sarmad Khalique', 'post-no-4', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis corrupti, fugiat rerum molestias sit eos animi magnam, reiciendis, dolorem facere obcaecati enim sed minima vitae eum. Libero alias aliquam a! Nisi, ex! Aspernatur maxime, voluptates tempore dolorum odio amet nobis!', 'home-bg.jpg', '2021-02-17 12:06:40'),
(6, 'Post # 4', 'Sarmad Khalique', 'post-no-6', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis corrupti, fugiat rerum molestias sit eos animi magnam, reiciendis, dolorem facere obcaecati enim sed minima vitae eum. Libero alias aliquam a! Nisi, ex! Aspernatur maxime, voluptates tempore dolorum odio amet nobis!', 'home-bg.jpg', '2021-02-17 12:06:49'),
(7, 'Post # 5', 'Sarmad Khalique', 'post-no-7', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis corrupti, fugiat rerum molestias sit eos animi magnam, reiciendis, dolorem facere obcaecati enim sed minima vitae eum. Libero alias aliquam a! Nisi, ex! Aspernatur maxime, voluptates tempore dolorum odio amet nobis!', 'home-bg.jpg', '2021-02-17 12:06:58'),
(8, 'Post # 6', 'Sarmad Khalique', 'post-no-8', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis corrupti, fugiat rerum molestias sit eos animi magnam, reiciendis, dolorem facere obcaecati enim sed minima vitae eum. Libero alias aliquam a! Nisi, ex! Aspernatur maxime, voluptates tempore dolorum odio amet nobis!', 'home-bg.jpg', '2021-02-17 12:07:13'),
(9, 'Post # 7', 'Sarmad Khalique', 'post-no-9', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis corrupti, fugiat rerum molestias sit eos animi magnam, reiciendis, dolorem facere obcaecati enim sed minima vitae eum. Libero alias aliquam a! Nisi, ex! Aspernatur maxime, voluptates tempore dolorum odio amet nobis!', 'home-bg.jpg', '2021-02-17 12:07:23'),
(10, 'Post # 8', 'Admin', 'post-no-10', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis corrupti, fugiat rerum molestias sit eos animi magnam, reiciendis, dolorem facere obcaecati enim sed minima vitae eum. Libero alias aliquam a! Nisi, ex! Aspernatur maxime, voluptates tempore dolorum odio amet nobis!', 'home-bg.jpg', '2021-02-17 12:07:34'),
(23, 'Post # 9', 'Admin', 'post-9', 'testing', 'about-bg.jpg', '2021-02-17 12:58:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

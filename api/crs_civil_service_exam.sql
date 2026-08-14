-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 14, 2026 at 10:47 AM
-- Server version: 8.0.45-0ubuntu0.22.04.1
-- PHP Version: 8.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crs_civil_service_exam`
--

-- --------------------------------------------------------

--
-- Table structure for table `exam_sessions`
--

CREATE TABLE `exam_sessions` (
  `id` int NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `start_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_activity` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `exam_sessions`
--

INSERT INTO `exam_sessions` (`id`, `user_id`, `session_token`, `start_time`, `last_activity`, `is_active`, `ip_address`, `user_agent`) VALUES
(1, 'CRSMRPBP4PH98NZ', '202da0ab-12a7-496a-a142-e40487af92db', '2026-07-17 19:20:35', '2026-07-17 19:20:35', 1, '::ffff:127.0.0.1', 'curl/7.81.0'),
(2, 'CRSMRPC0WOOPF3E', '84a65e5d-7e25-4621-ba1c-383bdd54caf4', '2026-07-17 19:29:45', '2026-07-17 19:29:45', 0, '::ffff:127.0.0.1', 'curl/7.81.0'),
(3, 'CRSMRPC9K5AA2DY', '457e9ce0-a2ef-4da1-931a-6d9707f92728', '2026-07-17 19:36:29', '2026-07-17 19:36:29', 0, '::ffff:127.0.0.1', 'curl/7.81.0'),
(4, 'CRSMRPCU3GCC93N', 'b04b293e-58bb-457b-93cb-f3890e377dfb', '2026-07-17 19:52:27', '2026-07-17 19:53:21', 0, '::1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(5, 'CRSMRPE3OP3C1VH', '556f2cd5-aa7d-4ead-9058-e7f21aed3fc4', '2026-07-17 20:27:54', '2026-07-17 20:39:30', 0, '::1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(6, 'CRSMRQLSTTOU60G', '076fbf4d-aace-4d30-979b-3848c5c68af4', '2026-07-18 16:51:10', '2026-07-18 16:57:11', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(7, 'CRSMRQMPWH7XEWA', 'f36e86f8-e231-4a35-a65f-67b728818e85', '2026-07-18 17:16:53', '2026-07-18 17:29:56', 0, '192.168.1.117', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36'),
(8, 'CRSMRQOGTFG2M66', 'ff1c84c0-de1f-4c0d-9e97-270f46f34707', '2026-07-18 18:05:49', '2026-07-18 18:07:39', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(9, 'CRSMRQPUJM58LKZ', '01e4fd9e-d9bc-4347-ac8f-b698bcd65e61', '2026-07-18 18:44:29', '2026-07-18 18:45:00', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(10, 'CRSMSHC4AFAAL01', '84f265d0-6d6c-4e84-83f4-daf2538007cd', '2026-08-06 09:49:56', '2026-08-06 09:56:07', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(11, 'CRSMSHC7HR9OROJ', '02da38eb-1926-4a9b-bd73-ed7bd9cf71a6', '2026-08-06 09:52:25', '2026-08-06 09:56:16', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(12, 'CRSMSHE2I06HV9F', '921665d6-2277-46ab-bc26-329829562cdf', '2026-08-06 10:44:31', '2026-08-06 10:47:29', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(13, 'CRSMSHE89G5JOF8', 'a13ec0c7-10f2-4163-8f5f-edf661214dc0', '2026-08-06 10:49:00', '2026-08-06 10:50:41', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int NOT NULL,
  `section` varchar(20) NOT NULL,
  `question_number` int NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('objective','subjective','theory') NOT NULL,
  `marks` int NOT NULL,
  `options` json DEFAULT NULL,
  `correct_answer` text,
  `keywords` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `section`, `question_number`, `question_text`, `question_type`, `marks`, `options`, `correct_answer`, `keywords`, `created_at`) VALUES
(1, 'A', 1, 'Which of the following is NOT a principle of the Cross River State Civil Service?', 'objective', 5, '[\"Merit-based recruitment\", \"Political neutrality\", \"Partisan decision making\", \"Professionalism\"]', '2', NULL, '2026-07-17 18:10:11'),
(2, 'A', 2, 'The \"Back to Farm\" initiative in Cross River State is primarily aimed at:', 'objective', 5, '[\"Urban development\", \"Food security\", \"Industrial growth\", \"Tourism promotion\"]', '1', NULL, '2026-07-17 18:10:11'),
(3, 'A', 3, 'Which ministry is responsible for agricultural development in Cross River State?', 'objective', 5, '[\"Ministry of Finance\", \"Ministry of Agriculture\", \"Ministry of Works\", \"Ministry of Health\"]', '1', NULL, '2026-07-17 18:10:11'),
(4, 'B', 4, 'Define the term \"Public Service\" in the context of Cross River State Civil Service.', 'subjective', 10, NULL, 'Public service is the provision of services to the citizens by government entities.', NULL, '2026-07-17 18:10:11'),
(5, 'B', 5, 'What is the role of a Permanent Secretary in the Civil Service?', 'subjective', 10, NULL, 'A Permanent Secretary is the accounting officer and chief administrative officer of a ministry.', NULL, '2026-07-17 18:10:11'),
(6, 'C', 6, 'Discuss the importance of the \"Back to Farm\" initiative for Cross River State. Your answer should cover: food security, economic empowerment, and youth engagement.', 'theory', 15, NULL, NULL, 'food security,economic empowerment,youth engagement,agriculture,sustainable development', '2026-07-17 18:10:11'),
(7, 'C', 7, 'Explain the concept of digital governance and its benefits to the Cross River State Civil Service.', 'theory', 15, NULL, NULL, 'digital governance,technology,efficiency,transparency,accountability,service delivery', '2026-07-17 18:10:11'),
(8, 'D', 8, 'Describe the process of budget preparation in a Cross River State Ministry.', 'subjective', 15, NULL, 'Budget preparation involves needs assessment, cost estimation, proposal writing, and submission to the Ministry of Finance.', NULL, '2026-07-17 18:10:11'),
(9, 'D', 9, 'What are the key components of the Integrated Personnel and Payroll Information System (IPPIS)?', 'subjective', 15, NULL, 'IPPIS components include personnel records, payroll management, pension administration, and financial reporting.', NULL, '2026-07-17 18:10:11'),
(10, 'D', 10, 'Explain the grievance handling procedure in the Civil Service.', 'theory', 15, NULL, NULL, 'grievance,complaint,procedure,investigation,resolution,disciplinary,appeal', '2026-07-17 18:10:11');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `exam_started` tinyint(1) DEFAULT '0',
  `exam_completed` tinyint(1) DEFAULT '0',
  `total_score` int DEFAULT '0',
  `percentage_score` decimal(5,2) DEFAULT '0.00',
  `pass_status` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_id`, `full_name`, `phone_number`, `email`, `exam_started`, `exam_completed`, `total_score`, `percentage_score`, `pass_status`, `created_at`, `updated_at`) VALUES
(1, 'CRSMRPBP4PH98NZ', 'Test Candidate', '08012345678', 'test001_invalid@example.com', 1, 0, 0, '0.00', 0, '2026-07-17 19:20:35', '2026-07-17 19:25:35'),
(2, 'CRSMRPC0WOOPF3E', 'Test Candidate', '08012378678', 'test01@example.com', 1, 1, 29, '26.36', 0, '2026-07-17 19:29:45', '2026-07-17 19:29:45'),
(3, 'CRSMRPC9K5AA2DY', 'Test Candidate', '08045378678', 'test02@example.com', 1, 1, 29, '26.36', 0, '2026-07-17 19:36:28', '2026-07-17 19:36:29'),
(4, 'CRSMRPCU3GCC93N', 'John Joe', '08063746372', 'a1in1@roynek.com', 1, 1, 15, '13.64', 0, '2026-07-17 19:52:27', '2026-07-17 19:53:21'),
(5, 'CRSMRPE3OP3C1VH', 'hu hij', '0908788', 'kensntems@gmail.com', 1, 1, 15, '13.64', 0, '2026-07-17 20:27:54', '2026-07-17 20:39:30'),
(6, 'CRSMRQLSTTOU60G', 'john happy', '+2349065808112', 'a1in1@roynek.com', 1, 1, 8, '7.27', 0, '2026-07-18 16:51:10', '2026-07-18 16:57:11'),
(7, 'CRSMRQMPWH7XEWA', 'hen', '09065875', 'okoi@mailer', 1, 1, 5, '4.55', 0, '2026-07-18 17:16:53', '2026-07-18 17:29:56'),
(8, 'CRSMRQOGTFG2M66', 'hen mark', '+23490127674', 'johnsna@gma.com', 1, 1, 0, '0.00', 0, '2026-07-18 18:05:49', '2026-07-18 18:07:39'),
(9, 'CRSMRQPUJM58LKZ', 'Kenyor Komommo Ntem', '09097441316', 'nkenyor@gmail.com', 1, 1, 10, '9.09', 0, '2026-07-18 18:44:29', '2026-07-18 18:45:00'),
(10, 'CRSMSHC4AFAAL01', 'KENYOR KOMOMMO NTEM', '+23490876512', 'a1in1234@roynek.com', 1, 1, 0, '0.00', 0, '2026-08-06 09:49:56', '2026-08-06 09:56:07'),
(11, 'CRSMSHC7HR9OROJ', 'JOHN JHON', '234672684647', 'A1@GMAIL.COM', 1, 1, 0, '0.00', 0, '2026-08-06 09:52:25', '2026-08-06 09:56:16'),
(12, 'CRSMSHE2I06HV9F', 'Mark John', '+23480974637478', 'markjohn@gmail.com', 1, 1, 8, '7.27', 0, '2026-08-06 10:44:31', '2026-08-06 10:47:29'),
(13, 'CRSMSHE89G5JOF8', 'Henry mark', '234676456765', 'john@gamil.co.ng', 1, 1, 0, '0.00', 0, '2026-08-06 10:49:00', '2026-08-06 10:50:41');

-- --------------------------------------------------------

--
-- Table structure for table `user_answers`
--

CREATE TABLE `user_answers` (
  `id` int NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `question_id` int NOT NULL,
  `answer_text` text NOT NULL,
  `score` int DEFAULT '0',
  `max_possible_score` int DEFAULT '0',
  `evaluated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_answers`
--

INSERT INTO `user_answers` (`id`, `user_id`, `question_id`, `answer_text`, `score`, `max_possible_score`, `evaluated_at`, `created_at`, `updated_at`) VALUES
(1, 'CRSMRPC0WOOPF3E', 1, '2', 5, 5, '2026-07-17 19:29:45', '2026-07-17 19:29:45', '2026-07-17 19:29:45'),
(2, 'CRSMRPC0WOOPF3E', 4, 'Public service is the provision of services to the citizens by government entities.', 10, 10, '2026-07-17 19:29:45', '2026-07-17 19:29:45', '2026-07-17 19:29:45'),
(3, 'CRSMRPC0WOOPF3E', 6, 'The Back to Farm initiative is crucial for food security and economic empowerment of youth in Cross River State through sustainable agriculture practices.', 9, 15, '2026-07-17 19:29:45', '2026-07-17 19:29:45', '2026-07-17 19:29:45'),
(4, 'CRSMRPC0WOOPF3E', 2, '1', 5, 5, '2026-07-17 19:29:45', '2026-07-17 19:29:45', '2026-07-17 19:29:45'),
(5, 'CRSMRPC9K5AA2DY', 1, '2', 5, 5, '2026-07-17 19:36:29', '2026-07-17 19:36:29', '2026-07-17 19:36:29'),
(6, 'CRSMRPC9K5AA2DY', 4, 'Public service is the provision of services to the citizens by government entities.', 10, 10, '2026-07-17 19:36:29', '2026-07-17 19:36:29', '2026-07-17 19:36:29'),
(7, 'CRSMRPC9K5AA2DY', 6, 'The Back to Farm initiative is crucial for food security and economic empowerment of youth in Cross River State through sustainable agriculture practices.', 9, 15, '2026-07-17 19:36:29', '2026-07-17 19:36:29', '2026-07-17 19:36:29'),
(8, 'CRSMRPC9K5AA2DY', 2, '1', 5, 5, '2026-07-17 19:36:29', '2026-07-17 19:36:29', '2026-07-17 19:36:29'),
(9, 'CRSMRPCU3GCC93N', 1, '2', 5, 5, '2026-07-17 19:52:54', '2026-07-17 19:52:54', '2026-07-17 19:52:54'),
(10, 'CRSMRPCU3GCC93N', 2, '1', 5, 5, '2026-07-17 19:53:01', '2026-07-17 19:53:01', '2026-07-17 19:53:01'),
(11, 'CRSMRPCU3GCC93N', 3, '1', 5, 5, '2026-07-17 19:53:17', '2026-07-17 19:53:14', '2026-07-17 19:53:17'),
(13, 'CRSMRPE3OP3C1VH', 1, '2', 5, 5, '2026-07-17 20:38:55', '2026-07-17 20:38:55', '2026-07-17 20:38:55'),
(14, 'CRSMRPE3OP3C1VH', 2, '1', 5, 5, '2026-07-17 20:38:58', '2026-07-17 20:38:58', '2026-07-17 20:38:58'),
(15, 'CRSMRPE3OP3C1VH', 3, '1', 5, 5, '2026-07-17 20:39:01', '2026-07-17 20:38:59', '2026-07-17 20:39:01'),
(17, 'CRSMRQLSTTOU60G', 1, '1', 0, 5, '2026-07-18 16:51:13', '2026-07-18 16:51:13', '2026-07-18 16:51:13'),
(18, 'CRSMRQLSTTOU60G', 2, '2', 0, 5, '2026-07-18 16:51:15', '2026-07-18 16:51:15', '2026-07-18 16:51:15'),
(19, 'CRSMRQLSTTOU60G', 3, '1', 5, 5, '2026-07-18 16:51:18', '2026-07-18 16:51:18', '2026-07-18 16:51:18'),
(20, 'CRSMRQLSTTOU60G', 4, 'to give to the people', 3, 10, '2026-07-18 16:51:31', '2026-07-18 16:51:26', '2026-07-18 16:51:31'),
(22, 'CRSMRQLSTTOU60G', 5, 'to head over the MDA they have been posted to.', 0, 10, '2026-07-18 16:51:49', '2026-07-18 16:51:49', '2026-07-18 16:51:49'),
(23, 'CRSMRQLSTTOU60G', 6, 'to help promote crop development', 0, 15, '2026-07-18 16:52:11', '2026-07-18 16:52:06', '2026-07-18 16:52:11'),
(25, 'CRSMRQLSTTOU60G', 7, 'it would make it easy for people to grow and connect.', 0, 15, '2026-07-18 16:52:27', '2026-07-18 16:52:23', '2026-07-18 16:52:27'),
(27, 'CRSMRQLSTTOU60G', 9, 'just a cool stuff', 0, 15, '2026-07-18 16:54:00', '2026-07-18 16:53:01', '2026-07-18 16:54:00'),
(30, 'CRSMRQLSTTOU60G', 8, 'I get you and here is the right flow of events', 0, 15, '2026-07-18 16:53:17', '2026-07-18 16:53:17', '2026-07-18 16:53:17'),
(31, 'CRSMRQLSTTOU60G', 10, 'the detection work flow and basic processes', 0, 15, '2026-07-18 16:53:51', '2026-07-18 16:53:31', '2026-07-18 16:53:51'),
(36, 'CRSMRQMPWH7XEWA', 3, '1', 5, 5, '2026-07-18 17:16:59', '2026-07-18 17:16:59', '2026-07-18 17:16:59'),
(37, 'CRSMRQMPWH7XEWA', 2, '2', 0, 5, '2026-07-18 17:17:02', '2026-07-18 17:17:02', '2026-07-18 17:17:02'),
(38, 'CRSMRQMPWH7XEWA', 1, '1', 0, 5, '2026-07-18 17:17:02', '2026-07-18 17:17:02', '2026-07-18 17:17:02'),
(39, 'CRSMRQOGTFG2M66', 1, '0', 0, 5, '2026-07-18 18:07:39', '2026-07-18 18:07:03', '2026-07-18 18:07:39'),
(40, 'CRSMRQOGTFG2M66', 2, '0', 0, 5, '2026-07-18 18:07:39', '2026-07-18 18:07:03', '2026-07-18 18:07:39'),
(41, 'CRSMRQOGTFG2M66', 3, '2', 0, 5, '2026-07-18 18:07:39', '2026-07-18 18:07:03', '2026-07-18 18:07:39'),
(48, 'CRSMRQPUJM58LKZ', 1, '0', 0, 5, '2026-07-18 18:45:01', '2026-07-18 18:44:35', '2026-07-18 18:45:00'),
(49, 'CRSMRQPUJM58LKZ', 2, '1', 5, 5, '2026-07-18 18:45:01', '2026-07-18 18:44:47', '2026-07-18 18:45:00'),
(50, 'CRSMRQPUJM58LKZ', 3, '1', 5, 5, '2026-07-18 18:45:01', '2026-07-18 18:44:54', '2026-07-18 18:45:00'),
(52, 'CRSMSHC4AFAAL01', 1, '0', 0, 5, '2026-08-06 09:56:08', '2026-08-06 09:56:07', '2026-08-06 09:56:07'),
(53, 'CRSMSHC4AFAAL01', 2, '0', 0, 5, '2026-08-06 09:56:08', '2026-08-06 09:56:07', '2026-08-06 09:56:07'),
(54, 'CRSMSHC4AFAAL01', 3, '0', 0, 5, '2026-08-06 09:56:08', '2026-08-06 09:56:07', '2026-08-06 09:56:07'),
(55, 'CRSMSHE2I06HV9F', 1, '1', 0, 5, '2026-08-06 10:47:29', '2026-08-06 10:47:29', '2026-08-06 10:47:29'),
(56, 'CRSMSHE2I06HV9F', 2, '1', 5, 5, '2026-08-06 10:47:29', '2026-08-06 10:47:29', '2026-08-06 10:47:29'),
(57, 'CRSMSHE2I06HV9F', 3, '2', 0, 5, '2026-08-06 10:47:29', '2026-08-06 10:47:29', '2026-08-06 10:47:29'),
(58, 'CRSMSHE2I06HV9F', 4, 'tHE SERVICE OF THE PEOPLE....', 3, 10, '2026-08-06 10:47:29', '2026-08-06 10:47:29', '2026-08-06 10:47:29'),
(59, 'CRSMSHE2I06HV9F', 5, 'Just to have fun....', 0, 10, '2026-08-06 10:47:29', '2026-08-06 10:47:29', '2026-08-06 10:47:29'),
(60, 'CRSMSHE2I06HV9F', 6, 'jUST SOME RANDOM TEXT....', 0, 15, '2026-08-06 10:47:29', '2026-08-06 10:47:29', '2026-08-06 10:47:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `idx_user_session` (`user_id`),
  ADD KEY `idx_token` (`session_token`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_question` (`section`,`question_number`),
  ADD KEY `idx_type` (`question_type`),
  ADD KEY `idx_section` (`section`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_phone` (`phone_number`);

--
-- Indexes for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_question` (`user_id`,`question_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_question` (`question_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user_answers`
--
ALTER TABLE `user_answers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  ADD CONSTRAINT `exam_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_answers`
--
ALTER TABLE `user_answers`
  ADD CONSTRAINT `user_answers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

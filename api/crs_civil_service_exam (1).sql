-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 14, 2026 at 12:17 PM
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
(13, 'CRSMSHE89G5JOF8', 'a13ec0c7-10f2-4163-8f5f-edf661214dc0', '2026-08-06 10:49:00', '2026-08-06 10:50:41', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(14, 'CRSMSSVONAWMOZX', '1ef1b418-0599-495c-8e5b-f6964f3d0ad1', '2026-08-14 11:43:06', '2026-08-14 11:43:06', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36'),
(15, 'CRSMSSW2F8330ME', 'd6599b36-e4ff-41ad-bdc9-8896275beba4', '2026-08-14 11:53:49', '2026-08-14 11:55:30', 0, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36');

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
(10, 'D', 10, 'Explain the grievance handling procedure in the Civil Service.', 'theory', 15, NULL, NULL, 'grievance,complaint,procedure,investigation,resolution,disciplinary,appeal', '2026-07-17 18:10:11'),
(37, 'A', 4, 'Which of the following is NOT a core value of the Cross River State Civil Service?', 'objective', 5, '[\"Integrity\", \"Professionalism\", \"Political Partisanship\", \"Accountability\"]', '2', NULL, '2026-08-14 11:52:16'),
(38, 'A', 5, 'The Cross River State Civil Service Commission is primarily responsible for:', 'objective', 5, '[\"Budget preparation\", \"Staff recruitment and discipline\", \"Infrastructure development\", \"Healthcare delivery\"]', '1', NULL, '2026-08-14 11:52:16'),
(39, 'A', 6, 'What is the primary purpose of the State Treasury Single Account (TSA)?', 'objective', 5, '[\"To increase government spending\", \"To consolidate all government revenue and payments\", \"To create multiple bank accounts\", \"To reduce transparency\"]', '1', NULL, '2026-08-14 11:52:16'),
(40, 'A', 7, 'Define the concept of \"Public Trust\" in the context of the Civil Service.', 'subjective', 5, NULL, 'Public trust is the confidence that citizens have in government officials to act in the public interest, with integrity and accountability.', NULL, '2026-08-14 11:52:16'),
(41, 'A', 8, 'Explain the role of a Permanent Secretary in policy implementation.', 'subjective', 5, NULL, 'A Permanent Secretary translates government policies into actionable programs, ensures resources are allocated effectively, and monitors implementation to achieve policy objectives.', NULL, '2026-08-14 11:52:16'),
(42, 'A', 9, 'Discuss the importance of citizen engagement in public service delivery. Your answer should cover: transparency, accountability, feedback mechanisms, and service improvement.', 'theory', 5, NULL, NULL, 'citizen engagement,transparency,accountability,feedback,service delivery,public participation,governance', '2026-08-14 11:52:16'),
(43, 'A', 10, 'Explain the qualities of an effective Permanent Secretary in the modern civil service. Your answer should cover: leadership, strategic thinking, adaptability, and communication.', 'theory', 5, NULL, NULL, 'leadership,strategic thinking,adaptability,communication,integrity,professionalism,innovation', '2026-08-14 11:52:16'),
(44, 'B', 1, 'You are the Permanent Secretary of the Ministry of Agriculture. It is 10:00 AM on a Monday. You receive three urgent matters simultaneously: [Matter 1: Commissioner requests brief verbal update at 11:00 AM on fertilizer distribution, Matter 2: Accountant-General needs expenditure report immediately, Matter 3: Farmers protesting at Ministry gate]. As Permanent Secretary, outline in bullet points how you would prioritize and handle these three matters within the next two hours.', 'theory', 10, NULL, NULL, 'Prioritization,Delegation,Crisis Management,Communication,Protocol,Farmers,Agriculture,Commissioner,Accountant-General', '2026-08-14 11:52:16'),
(45, 'B', 2, 'Cross River State Government has mandated that all Ministries must transition from paper-based file keeping to a digital document management system within six months. Your Ministry has 120 staff members, many of whom have never used a computer for file management. A training session is scheduled for next week. (a) Select the most appropriate response to the situation where a senior Director refuses to attend training and briefly explain your choice. (b) List two practical steps you would take as Permanent Secretary to ensure a smooth transition.', 'theory', 10, NULL, NULL, 'Digital Transformation,Change Management,Training,ICT,Staff Development,Resistance,Digital Document Management,Paperless', '2026-08-14 11:52:16'),
(46, 'B', 3, 'You are the Permanent Secretary of the Ministry of Education. A new education policy has been announced that requires all schools to implement digital learning within six months. However, many rural schools lack electricity and internet connectivity. Task: Outline how you would handle this situation, including stakeholder engagement, phased implementation, and resource mobilization.', 'theory', 10, NULL, NULL, 'digital learning,stakeholder engagement,phased implementation,resource mobilization,rural schools,infrastructure,education policy', '2026-08-14 11:52:16'),
(47, 'C', 1, 'You are the Permanent Secretary, Ministry of Health, Cross River State. A cholera outbreak has been confirmed in Akamkpa LGA. Your Ministry needs ₦150 million urgently to procure emergency medical supplies. Write a formal letter to the Permanent Secretary, Ministry of Finance, requesting the immediate release of these funds.', '', 10, NULL, NULL, 'Formal Letter,Official Correspondence,Request,Funding,Health Emergency,Cholera,Procurement,Ministry of Health,Ministry of Finance', '2026-08-14 11:52:16'),
(48, 'C', 2, 'You are the Permanent Secretary of your Ministry. The Cross River State Civil Service Commission has directed all Ministries to conduct a mandatory staff verification exercise next month. Draft a circular from your office to all Directors and Heads of Departments in your Ministry, announcing this exercise.', '', 10, NULL, NULL, 'Circular,Staff Verification,Compliance,Directors,Documentation,Commission,Human Resources', '2026-08-14 11:52:16'),
(49, 'C', 3, 'You are the Permanent Secretary, Ministry of Works, Cross River State. A contractor has abandoned a road construction project in Obudu LGA for three months despite receiving 70% of the contract sum. Write a formal letter to the Managing Director, Cross River Construction Ltd., referencing contract details, stating the breach, invoking penalty clause, and demanding resumption of work.', '', 10, NULL, NULL, 'Contract,Breach,Construction,Penalty,Termination,Blacklisting,Legal,Works,Contractor', '2026-08-14 11:52:16'),
(50, 'C', 4, 'You are the Permanent Secretary, Ministry of Education, Cross River State. Write a circular to all Chief Inspectors of Education, informing them of a new teacher recruitment exercise. Include the eligibility criteria, application process, deadline, and the importance of maintaining transparency.', '', 10, NULL, NULL, 'circular,teacher recruitment,Chief Inspectors,Education,eligibility,transparency,application,recruitment', '2026-08-14 11:52:16'),
(51, 'C', 5, 'You are the Permanent Secretary, Ministry of Health, Cross River State. Write a letter to the United Nations Children\'s Fund (UNICEF) requesting support for a polio vaccination campaign in the state. Include the scope of the campaign, the target population, the required resources, and the expected impact.', '', 10, NULL, NULL, 'UNICEF,polio vaccination,health campaign,request letter,international collaboration,child health,immunization', '2026-08-14 11:52:16'),
(52, 'D', 1, 'You are the Permanent Secretary, Ministry of Women Affairs, Cross River State. Over the past three months, reported cases of gender-based violence (GBV) have increased by 40% across the state. The Governor has directed your Ministry to lead a State-wide coordinated response within 90 days. Prepare a comprehensive action plan as a memo to the Secretary to the State Government (SSG).', '', 15, NULL, NULL, 'GBV,Women Affairs,Inter-Ministerial Coordination,Budget,Policy,Monitoring,Action Plan,Shelter,Gender-Based Violence,Security', '2026-08-14 11:52:16'),
(53, 'D', 2, 'You are the Permanent Secretary, Ministry of Finance, Cross River State. While reconciling your Ministry\'s accounts, you discover a ₦500 million discrepancy. The amount was withdrawn as a \"special security vote\" approved by the Governor\'s office with no documentation. (a) Identify three ethical dilemmas. (b) Outline step-by-step administrative and legal actions. (c) Draft a brief confidential memo to the Head of Service.', '', 20, NULL, NULL, 'Ethics,Financial Management,Discrepancy,Transparency,Audit,Accountability,Legal,Governor,Security Vote,Whistleblower,Public Finance', '2026-08-14 11:52:16'),
(54, 'D', 3, 'You are the Permanent Secretary, Ministry of Health, Cross River State. A new disease outbreak has been reported in three Local Government Areas. The health facilities are overwhelmed, and there is a shortage of medical supplies. The State Government has declared a health emergency. Task: Prepare a comprehensive response plan addressed as a memo to the Secretary to the State Government (SSG). Your plan must include: (1) Immediate response interventions (2) Resource mobilization strategy (3) Coordination with development partners (4) Communication and public awareness plan (5) Monitoring and evaluation framework.', '', 15, NULL, NULL, 'health emergency,disease outbreak,response plan,resource mobilization,coordination,public awareness,monitoring,WHO,UNICEF,rapid response', '2026-08-14 11:52:16'),
(55, 'D', 4, 'You are the Permanent Secretary, Ministry of Works, Cross River State. A major road construction project is behind schedule and over budget. The contractor has cited rising material costs and security challenges as reasons for the delay. However, an internal investigation has revealed potential mismanagement. Task: (a) Identify three ethical dilemmas you face (6 marks) (b) Outline the step-by-step administrative actions you would take (10 marks) (c) Draft a brief confidential memo to the Commissioner (4 marks).', '', 20, NULL, NULL, 'road construction,project delay,budget overrun,ethical dilemmas,contractor,investigation,accountability,project management,oversight,procurement', '2026-08-14 11:52:16'),
(56, 'D', 5, 'You are the Permanent Secretary, Ministry of Commerce, Cross River State. The State Government has launched a new initiative to support Small and Medium Enterprises (SMEs) in the state. You are tasked with developing a framework for the disbursement of ₦1 billion in grants to SMEs. Task: Prepare a detailed implementation plan including: (1) Eligibility criteria (2) Application and selection process (3) Disbursement mechanism (4) Monitoring and evaluation (5) Risk management strategy.', '', 15, NULL, NULL, 'SMEs,grants,entrepreneurship,implementation plan,eligibility,disbursement,monitoring,risk management,economic development,commerce', '2026-08-14 11:52:16');

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
(13, 'CRSMSHE89G5JOF8', 'Henry mark', '234676456765', 'john@gamil.co.ng', 1, 1, 0, '0.00', 0, '2026-08-06 10:49:00', '2026-08-06 10:50:41'),
(14, 'CRSMSSVONAWMOZX', 'hen des', '090364756274', 'ikikoa@try.com', 1, 0, 0, '0.00', 0, '2026-08-14 11:43:06', '2026-08-14 11:43:06'),
(15, 'CRSMSSW2F8330ME', 'HEN MARK', '09064756234', 'DHFG@FGH.COM', 1, 1, 0, '0.00', 0, '2026-08-14 11:53:49', '2026-08-14 11:55:30');

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
(60, 'CRSMSHE2I06HV9F', 6, 'jUST SOME RANDOM TEXT....', 0, 15, '2026-08-06 10:47:29', '2026-08-06 10:47:29', '2026-08-06 10:47:29'),
(61, 'CRSMSSW2F8330ME', 1, '0', 0, 5, '2026-08-14 11:55:31', '2026-08-14 11:53:53', '2026-08-14 11:55:30'),
(62, 'CRSMSSW2F8330ME', 2, '0', 0, 5, '2026-08-14 11:55:31', '2026-08-14 11:53:57', '2026-08-14 11:55:30'),
(63, 'CRSMSSW2F8330ME', 3, '3', 0, 5, '2026-08-14 11:55:31', '2026-08-14 11:54:00', '2026-08-14 11:55:30'),
(64, 'CRSMSSW2F8330ME', 37, '1', 0, 5, '2026-08-14 11:55:31', '2026-08-14 11:54:02', '2026-08-14 11:55:30'),
(65, 'CRSMSSW2F8330ME', 38, '0', 0, 5, '2026-08-14 11:55:31', '2026-08-14 11:54:05', '2026-08-14 11:55:30'),
(66, 'CRSMSSW2F8330ME', 39, '0', 0, 5, '2026-08-14 11:55:31', '2026-08-14 11:54:08', '2026-08-14 11:55:30');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user_answers`
--
ALTER TABLE `user_answers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

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

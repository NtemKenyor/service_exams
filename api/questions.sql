-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 14, 2026 at 12:01 PM
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_question` (`section`,`question_number`),
  ADD KEY `idx_type` (`question_type`),
  ADD KEY `idx_section` (`section`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

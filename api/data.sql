-- ============================================
-- CLEAR EXISTING DATA
-- ============================================
-- First, clear user answers (foreign key constraint)
TRUNCATE TABLE user_answers;

-- Then clear questions
TRUNCATE TABLE questions;

-- Reset auto-increment
ALTER TABLE questions AUTO_INCREMENT = 1;

-- ============================================
-- INSERT ALL QUESTIONS (Section A)
-- ============================================
INSERT INTO questions (section, question_number, question_text, question_type, marks, options, correct_answer, keywords) VALUES

-- SECTION A: SHORT QUESTIONS (Original)
('A', 1, 'Cross River State recently launched the "Back to Farm" initiative to boost food security. (a) Name two (2) Ministries in Cross River State that would directly collaborate to make this initiative successful. (b) State one specific role a Permanent Secretary in either Ministry would play in coordinating this program.', 'theory', 5, NULL, NULL, 'Agriculture,Finance,Food Security,Collaboration,Coordination,Policy,Ministry of Agriculture,Ministry of Finance'),

('A', 2, 'A Permanent Secretary receives an email with the subject: "URGENT: Verify Your Bank Account Details for Salary Payment." The email contains a link asking for personal information. (a) What is this type of cyber threat commonly called? (b) List two (2) warning signs that should alert the Permanent Secretary that this email is suspicious.', 'theory', 5, NULL, NULL, 'Phishing,Cybersecurity,Suspicious Email,Bank Details,Warning Signs,Spam,Urgency,Link,Personal Information'),

('A', 3, 'The Integrated Personnel and Payroll Information System (IPPIS) is used in the Cross River State Civil Service. (a) What is the primary purpose of IPPIS? (b) Identify one benefit and one challenge of using IPPIS from a Permanent Secretary\'s perspective.', 'theory', 5, NULL, NULL, 'IPPIS,Payroll,Personnel Management,Data Integration,Transparency,Efficiency,Employee Records,Salary Processing'),

-- SECTION A: Additional Objective Questions
('A', 4, 'Which of the following is NOT a core value of the Cross River State Civil Service?', 'objective', 5, 
 '["Integrity", "Professionalism", "Political Partisanship", "Accountability"]', '2', NULL),

('A', 5, 'The Cross River State Civil Service Commission is primarily responsible for:', 'objective', 5,
 '["Budget preparation", "Staff recruitment and discipline", "Infrastructure development", "Healthcare delivery"]', '1', NULL),

('A', 6, 'What is the primary purpose of the State Treasury Single Account (TSA)?', 'objective', 5,
 '["To increase government spending", "To consolidate all government revenue and payments", "To create multiple bank accounts", "To reduce transparency"]', '1', NULL),

-- SECTION A: Additional Subjective Questions
('A', 7, 'Define the concept of "Public Trust" in the context of the Civil Service.', 'subjective', 5,
 NULL, 'Public trust is the confidence that citizens have in government officials to act in the public interest, with integrity and accountability.', NULL),

('A', 8, 'Explain the role of a Permanent Secretary in policy implementation.', 'subjective', 5,
 NULL, 'A Permanent Secretary translates government policies into actionable programs, ensures resources are allocated effectively, and monitors implementation to achieve policy objectives.', NULL),

-- SECTION A: Additional Theory Questions
('A', 9, 'Discuss the importance of citizen engagement in public service delivery. Your answer should cover: transparency, accountability, feedback mechanisms, and service improvement.', 'theory', 5,
 NULL, NULL, 'citizen engagement,transparency,accountability,feedback,service delivery,public participation,governance'),

('A', 10, 'Explain the qualities of an effective Permanent Secretary in the modern civil service. Your answer should cover: leadership, strategic thinking, adaptability, and communication.', 'theory', 5,
 NULL, NULL, 'leadership,strategic thinking,adaptability,communication,integrity,professionalism,innovation');

-- ============================================
-- SECTION B: SCENARIO-BASED QUESTIONS
-- ============================================
INSERT INTO questions (section, question_number, question_text, question_type, marks, options, correct_answer, keywords) VALUES

('B', 1, 'You are the Permanent Secretary of the Ministry of Agriculture. It is 10:00 AM on a Monday. You receive three urgent matters simultaneously: [Matter 1: Commissioner requests brief verbal update at 11:00 AM on fertilizer distribution, Matter 2: Accountant-General needs expenditure report immediately, Matter 3: Farmers protesting at Ministry gate]. As Permanent Secretary, outline in bullet points how you would prioritize and handle these three matters within the next two hours.', 'theory', 10, NULL, NULL, 'Prioritization,Delegation,Crisis Management,Communication,Protocol,Farmers,Agriculture,Commissioner,Accountant-General'),

('B', 2, 'Cross River State Government has mandated that all Ministries must transition from paper-based file keeping to a digital document management system within six months. Your Ministry has 120 staff members, many of whom have never used a computer for file management. A training session is scheduled for next week. (a) Select the most appropriate response to the situation where a senior Director refuses to attend training and briefly explain your choice. (b) List two practical steps you would take as Permanent Secretary to ensure a smooth transition.', 'theory', 10, NULL, NULL, 'Digital Transformation,Change Management,Training,ICT,Staff Development,Resistance,Digital Document Management,Paperless'),

('B', 3, 'You are the Permanent Secretary of the Ministry of Education. A new education policy has been announced that requires all schools to implement digital learning within six months. However, many rural schools lack electricity and internet connectivity. Task: Outline how you would handle this situation, including stakeholder engagement, phased implementation, and resource mobilization.', 'theory', 10, NULL, NULL, 'digital learning,stakeholder engagement,phased implementation,resource mobilization,rural schools,infrastructure,education policy'),

('B', 4, 'The Governor has approved a major infrastructure project in your Ministry. However, a senior official has raised concerns about irregularities in the procurement process. Task: Outline the steps you would take to investigate the matter while maintaining project momentum and ensuring due process.', 'theory', 10, NULL, NULL, 'procurement,investigation,due process,transparency,accountability,infrastructure,ethics,project management'),

('B', 5, 'Your Ministry has received complaints about poor service delivery from the public. Task: Develop a plan to improve customer service, including staff retraining, process simplification, and feedback mechanisms.', 'theory', 10, NULL, NULL, 'customer service,service delivery,staff retraining,process improvement,feedback,complaints,public satisfaction,quality assurance');

-- ============================================
-- SECTION C: LETTER WRITING
-- ============================================
INSERT INTO questions (section, question_number, question_text, question_type, marks, options, correct_answer, keywords) VALUES

('C', 1, 'You are the Permanent Secretary, Ministry of Health, Cross River State. A cholera outbreak has been confirmed in Akamkpa LGA. Your Ministry needs ₦150 million urgently to procure emergency medical supplies. Write a formal letter to the Permanent Secretary, Ministry of Finance, requesting the immediate release of these funds.', 'letter', 10, NULL, NULL, 'Formal Letter,Official Correspondence,Request,Funding,Health Emergency,Cholera,Procurement,Ministry of Health,Ministry of Finance'),

('C', 2, 'You are the Permanent Secretary of your Ministry. The Cross River State Civil Service Commission has directed all Ministries to conduct a mandatory staff verification exercise next month. Draft a circular from your office to all Directors and Heads of Departments in your Ministry, announcing this exercise.', 'letter', 10, NULL, NULL, 'Circular,Staff Verification,Compliance,Directors,Documentation,Commission,Human Resources'),

('C', 3, 'You are the Permanent Secretary, Ministry of Works, Cross River State. A contractor has abandoned a road construction project in Obudu LGA for three months despite receiving 70% of the contract sum. Write a formal letter to the Managing Director, Cross River Construction Ltd., referencing contract details, stating the breach, invoking penalty clause, and demanding resumption of work.', 'letter', 10, NULL, NULL, 'Contract,Breach,Construction,Penalty,Termination,Blacklisting,Legal,Works,Contractor'),

('C', 4, 'You are the Permanent Secretary, Ministry of Education, Cross River State. Write a circular to all Chief Inspectors of Education, informing them of a new teacher recruitment exercise. Include the eligibility criteria, application process, deadline, and the importance of maintaining transparency.', 'letter', 10, NULL, NULL, 'circular,teacher recruitment,Chief Inspectors,Education,eligibility,transparency,application,recruitment'),

('C', 5, 'You are the Permanent Secretary, Ministry of Health, Cross River State. Write a letter to the United Nations Children\'s Fund (UNICEF) requesting support for a polio vaccination campaign in the state. Include the scope of the campaign, the target population, the required resources, and the expected impact.', 'letter', 10, NULL, NULL, 'UNICEF,polio vaccination,health campaign,request letter,international collaboration,child health,immunization'),

('C', 6, 'You are the Permanent Secretary, Ministry of Finance, Cross River State. Write a letter to all Ministries requesting the submission of their budget estimates for the next fiscal year. Include the submission deadline, the required format, the guidelines, and the consequences of non-compliance.', 'letter', 10, NULL, NULL, 'budget estimates,Ministries,Finance,submission deadline,budget guidelines,compliance,financial planning');

-- ============================================
-- SECTION D: CASE STUDIES
-- ============================================
INSERT INTO questions (section, question_number, question_text, question_type, marks, options, correct_answer, keywords) VALUES

('D', 1, 'You are the Permanent Secretary, Ministry of Women Affairs, Cross River State. Over the past three months, reported cases of gender-based violence (GBV) have increased by 40% across the state. The Governor has directed your Ministry to lead a State-wide coordinated response within 90 days. Prepare a comprehensive action plan as a memo to the Secretary to the State Government (SSG).', 'case_study', 15, NULL, NULL, 'GBV,Women Affairs,Inter-Ministerial Coordination,Budget,Policy,Monitoring,Action Plan,Shelter,Gender-Based Violence,Security'),

('D', 2, 'You are the Permanent Secretary, Ministry of Finance, Cross River State. While reconciling your Ministry\'s accounts, you discover a ₦500 million discrepancy. The amount was withdrawn as a "special security vote" approved by the Governor\'s office with no documentation. (a) Identify three ethical dilemmas. (b) Outline step-by-step administrative and legal actions. (c) Draft a brief confidential memo to the Head of Service.', 'case_study', 20, NULL, NULL, 'Ethics,Financial Management,Discrepancy,Transparency,Audit,Accountability,Legal,Governor,Security Vote,Whistleblower,Public Finance'),

('D', 3, 'You are the Permanent Secretary, Ministry of Health, Cross River State. A new disease outbreak has been reported in three Local Government Areas. The health facilities are overwhelmed, and there is a shortage of medical supplies. The State Government has declared a health emergency. Task: Prepare a comprehensive response plan addressed as a memo to the Secretary to the State Government (SSG). Your plan must include: (1) Immediate response interventions (2) Resource mobilization strategy (3) Coordination with development partners (4) Communication and public awareness plan (5) Monitoring and evaluation framework.', 'case_study', 15, NULL, NULL, 'health emergency,disease outbreak,response plan,resource mobilization,coordination,public awareness,monitoring,WHO,UNICEF,rapid response'),

('D', 4, 'You are the Permanent Secretary, Ministry of Works, Cross River State. A major road construction project is behind schedule and over budget. The contractor has cited rising material costs and security challenges as reasons for the delay. However, an internal investigation has revealed potential mismanagement. Task: (a) Identify three ethical dilemmas you face (6 marks) (b) Outline the step-by-step administrative actions you would take (10 marks) (c) Draft a brief confidential memo to the Commissioner (4 marks).', 'case_study', 20, NULL, NULL, 'road construction,project delay,budget overrun,ethical dilemmas,contractor,investigation,accountability,project management,oversight,procurement'),

('D', 5, 'You are the Permanent Secretary, Ministry of Commerce, Cross River State. The State Government has launched a new initiative to support Small and Medium Enterprises (SMEs) in the state. You are tasked with developing a framework for the disbursement of ₦1 billion in grants to SMEs. Task: Prepare a detailed implementation plan including: (1) Eligibility criteria (2) Application and selection process (3) Disbursement mechanism (4) Monitoring and evaluation (5) Risk management strategy.', 'case_study', 15, NULL, NULL, 'SMEs,grants,entrepreneurship,implementation plan,eligibility,disbursement,monitoring,risk management,economic development,commerce');

-- ============================================
-- VERIFY INSERTION
-- ============================================
SELECT 'Total Questions:' as '', COUNT(*) as count FROM questions
UNION ALL
SELECT 'Section A:', COUNT(*) FROM questions WHERE section = 'A'
UNION ALL
SELECT 'Section B:', COUNT(*) FROM questions WHERE section = 'B'
UNION ALL
SELECT 'Section C:', COUNT(*) FROM questions WHERE section = 'C'
UNION ALL
SELECT 'Section D:', COUNT(*) FROM questions WHERE section = 'D'
UNION ALL
SELECT '', '' 
UNION ALL
SELECT 'By Type:', '' 
UNION ALL
SELECT CONCAT('  ', question_type, ':'), COUNT(*) FROM questions GROUP BY question_type;

-- Show all questions
SELECT section, question_number, question_type, marks, LEFT(question_text, 60) as question_preview 
FROM questions 
ORDER BY section, question_number;
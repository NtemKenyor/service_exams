const express = require('express');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const dotenv = require('dotenv');
const mysql = require('mysql2/promise');
const { v4: uuidv4 } = require('uuid');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;



app.use(cors()); // Allow all origins

// Alternative: Explicitly allow all with options
app.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'PATCH'],
  allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept'],
  credentials: false // Must be false when origin is '*'
}));

// Handle preflight requests
app.options('*', cors());



app.use(express.json());

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100
});
app.use('/api/', limiter);

// Database connection pool
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// ============================================
// SCORING FUNCTIONS
// ============================================

const scoreObjective = (userAnswer, correctAnswer, options) => {
  if (!userAnswer || !correctAnswer) return 0;
  
  if (!isNaN(correctAnswer)) {
    return parseInt(userAnswer) === parseInt(correctAnswer) ? 1 : 0;
  }
  
  return userAnswer.trim().toLowerCase() === correctAnswer.trim().toLowerCase() ? 1 : 0;
};

const scoreSubjective = (userAnswer, correctAnswer) => {
  if (!userAnswer || !correctAnswer) return 0;
  
  const normalize = (text) => text.trim().toLowerCase().replace(/\s+/g, ' ');
  const userNorm = normalize(userAnswer);
  const correctNorm = normalize(correctAnswer);
  
  if (userNorm.includes(correctNorm) || correctNorm.includes(userNorm)) {
    return 1;
  }
  
  const userWords = userNorm.split(' ');
  const correctWords = correctNorm.split(' ');
  const matchCount = userWords.filter(word => correctWords.includes(word)).length;
  const matchPercentage = matchCount / correctWords.length;
  
  if (matchPercentage >= 0.8) return 1;
  if (matchPercentage >= 0.6) return 0.75;
  if (matchPercentage >= 0.4) return 0.5;
  if (matchPercentage >= 0.2) return 0.25;
  return 0;
};

const scoreTheory = (userAnswer, keywords) => {
  if (!userAnswer || !keywords) return 0;
  
  const keywordList = keywords.split(',').map(k => k.trim().toLowerCase());
  const userLower = userAnswer.toLowerCase();
  
  let matchedKeywords = 0;
  for (const keyword of keywordList) {
    if (userLower.includes(keyword)) {
      matchedKeywords++;
    }
  }
  
  return matchedKeywords / keywordList.length;
};

const calculateScore = (questionType, userAnswer, correctAnswer, options, keywords) => {
  if (!userAnswer || userAnswer.trim() === '') return 0;
  
  let score = 0;
  
  switch(questionType) {
    case 'objective':
      score = scoreObjective(userAnswer, correctAnswer, options);
      break;
    case 'subjective':
      score = scoreSubjective(userAnswer, correctAnswer);
      break;
    case 'theory':
      score = scoreTheory(userAnswer, keywords);
      break;
    default:
      score = 0;
  }
  
  return parseFloat(score.toFixed(2));
};

// ============================================
// HELPER: Safe JSON Parse
// ============================================
const safeJSONParse = (value) => {
  if (!value) return null;
  
  if (typeof value === 'object') return value;
  
  if (typeof value === 'string') {
    try {
      return JSON.parse(value);
    } catch (e) {
      if (value.includes(',')) {
        return value.split(',').map(s => s.trim());
      }
      return [value.trim()];
    }
  }
  
  return null;
};

// ============================================
// API ENDPOINTS
// ============================================

// 1. Register user
app.post('/api/register', async (req, res) => {
  try {
    const { fullName, phoneNumber, email } = req.body;
    
    if (!fullName || !phoneNumber) {
      return res.status(400).json({ 
        success: false, 
        message: 'Full name and phone number are required' 
      });
    }
    
    const [existing] = await pool.query(
      'SELECT user_id FROM users WHERE phone_number = ?',
      [phoneNumber]
    );
    
    if (existing.length > 0) {
      return res.status(400).json({ 
        success: false, 
        message: 'User already registered',
        userId: existing[0].user_id
      });
    }
    
    const userId = `CRS${Date.now().toString(36).toUpperCase()}${Math.random().toString(36).substring(2, 6).toUpperCase()}`;
    
    await pool.query(
      `INSERT INTO users (user_id, full_name, phone_number, email, exam_started) 
       VALUES (?, ?, ?, ?, TRUE)`,
      [userId, fullName, phoneNumber, email || null]
    );
    
    const sessionToken = uuidv4();
    const ipAddress = req.ip || req.connection.remoteAddress;
    const userAgent = req.headers['user-agent'];
    
    await pool.query(
      `INSERT INTO exam_sessions (user_id, session_token, ip_address, user_agent) 
       VALUES (?, ?, ?, ?)`,
      [userId, sessionToken, ipAddress, userAgent]
    );
    
    res.status(201).json({
      success: true,
      message: 'Registration successful',
      userId: userId,
      sessionToken: sessionToken,
      fullName: fullName
    });
    
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Registration failed', 
      error: error.message 
    });
  }
});

// 2. Get all questions for a user
app.post('/api/questions', async (req, res) => {
  try {
    const { userId, sessionToken } = req.body;
    
    if (!userId || !sessionToken) {
      return res.status(400).json({ 
        success: false, 
        message: 'User ID and session token are required' 
      });
    }
    
    const [session] = await pool.query(
      'SELECT * FROM exam_sessions WHERE user_id = ? AND session_token = ? AND is_active = TRUE',
      [userId, sessionToken]
    );
    
    if (session.length === 0) {
      return res.status(401).json({ 
        success: false, 
        message: 'Invalid or expired session' 
      });
    }
    
    const [questions] = await pool.query(
      `SELECT id, section, question_number, question_text, question_type, marks, options 
       FROM questions 
       ORDER BY section, question_number`
    );
    
    const [answers] = await pool.query(
      'SELECT question_id, answer_text FROM user_answers WHERE user_id = ?',
      [userId]
    );
    
    const answerMap = new Map();
    answers.forEach(a => {
      answerMap.set(a.question_id, a.answer_text);
    });
    
    const formattedQuestions = questions.map(q => ({
      id: q.id,
      section: q.section,
      questionNumber: q.question_number,
      questionText: q.question_text,
      questionType: q.question_type,
      marks: q.marks,
      options: safeJSONParse(q.options),
      answer: answerMap.get(q.id) || '',
      isAnswered: answerMap.has(q.id)
    }));
    
    const [user] = await pool.query(
      'SELECT full_name, exam_completed FROM users WHERE user_id = ?',
      [userId]
    );
    
    res.json({
      success: true,
      userId: userId,
      fullName: user[0]?.full_name || '',
      examCompleted: user[0]?.exam_completed || false,
      totalQuestions: questions.length,
      questions: formattedQuestions
    });
    
  } catch (error) {
    console.error('Error fetching questions:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to fetch questions', 
      error: error.message 
    });
  }
});

// 3. Save answer and auto-score
app.post('/api/save-answer', async (req, res) => {
  try {
    const { userId, sessionToken, questionId, answerText } = req.body;
    
    if (!userId || !sessionToken || !questionId || answerText === undefined) {
      return res.status(400).json({ 
        success: false, 
        message: 'Missing required fields' 
      });
    }
    
    const [session] = await pool.query(
      'SELECT * FROM exam_sessions WHERE user_id = ? AND session_token = ? AND is_active = TRUE',
      [userId, sessionToken]
    );
    
    if (session.length === 0) {
      return res.status(401).json({ 
        success: false, 
        message: 'Invalid or expired session' 
      });
    }
    
    const [question] = await pool.query(
      `SELECT id, question_type, marks, options, correct_answer, keywords 
       FROM questions WHERE id = ?`,
      [questionId]
    );
    
    if (question.length === 0) {
      return res.status(404).json({ 
        success: false, 
        message: 'Question not found' 
      });
    }
    
    const q = question[0];
    
    const score = calculateScore(
      q.question_type,
      answerText,
      q.correct_answer,
      q.options,
      q.keywords
    );
    
    const maxPossibleScore = q.marks;
    const actualScore = Math.round(score * maxPossibleScore);
    
    await pool.query(
      `INSERT INTO user_answers (user_id, question_id, answer_text, score, max_possible_score, evaluated_at) 
       VALUES (?, ?, ?, ?, ?, NOW()) 
       ON DUPLICATE KEY UPDATE 
       answer_text = VALUES(answer_text), 
       score = VALUES(score), 
       max_possible_score = VALUES(max_possible_score),
       evaluated_at = VALUES(evaluated_at)`,
      [userId, questionId, answerText, actualScore, maxPossibleScore]
    );
    
    res.json({
      success: true,
      message: 'Answer saved and scored',
      questionId: questionId,
      score: actualScore,
      maxScore: maxPossibleScore,
      percentage: parseFloat(((actualScore / maxPossibleScore) * 100).toFixed(2))
    });
    
  } catch (error) {
    console.error('Error saving answer:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to save answer', 
      error: error.message 
    });
  }
});

// 4. Submit exam
app.post('/api/submit-exam', async (req, res) => {
  try {
    const { userId, sessionToken } = req.body;
    
    if (!userId || !sessionToken) {
      return res.status(400).json({ 
        success: false, 
        message: 'User ID and session token are required' 
      });
    }
    
    const [session] = await pool.query(
      'SELECT * FROM exam_sessions WHERE user_id = ? AND session_token = ? AND is_active = TRUE',
      [userId, sessionToken]
    );
    
    if (session.length === 0) {
      return res.status(401).json({ 
        success: false, 
        message: 'Invalid or expired session' 
      });
    }
    
    const [user] = await pool.query(
      'SELECT exam_completed FROM users WHERE user_id = ?',
      [userId]
    );
    
    if (user[0]?.exam_completed) {
      return res.status(400).json({ 
        success: false, 
        message: 'Exam already submitted' 
      });
    }
    
    const [answers] = await pool.query(
      'SELECT score FROM user_answers WHERE user_id = ?',
      [userId]
    );
    
    let totalScore = 0;
    answers.forEach(a => {
      totalScore += a.score || 0;
    });
    
    const [questions] = await pool.query(
      'SELECT SUM(marks) as total_marks FROM questions'
    );
    
    const totalMarks = questions[0]?.total_marks || 100;
    const percentageScore = (totalScore / totalMarks) * 100;
    const passStatus = percentageScore >= 60;
    
    await pool.query(
      `UPDATE users SET 
       exam_completed = TRUE, 
       total_score = ?, 
       percentage_score = ?, 
       pass_status = ?
       WHERE user_id = ?`,
      [totalScore, percentageScore, passStatus, userId]
    );
    
    await pool.query(
      'UPDATE exam_sessions SET is_active = FALSE WHERE session_token = ?',
      [sessionToken]
    );
    
    res.json({
      success: true,
      message: 'Exam submitted successfully',
      userId: userId,
      totalScore: totalScore,
      totalMarks: totalMarks,
      percentageScore: parseFloat(percentageScore.toFixed(2)),
      passStatus: passStatus,
      passMark: 60
    });
    
  } catch (error) {
    console.error('Error submitting exam:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to submit exam', 
      error: error.message 
    });
  }
});

// 5. Get results
app.get('/api/results/:userId', async (req, res) => {
  try {
    const { userId } = req.params;
    
    const [user] = await pool.query(
      `SELECT full_name, phone_number, total_score, percentage_score, pass_status, exam_completed 
       FROM users WHERE user_id = ?`,
      [userId]
    );
    
    if (user.length === 0) {
      return res.status(404).json({ 
        success: false, 
        message: 'User not found' 
      });
    }
    
    if (!user[0].exam_completed) {
      return res.status(400).json({ 
        success: false, 
        message: 'Exam not yet completed' 
      });
    }
    
    const [answers] = await pool.query(
      `SELECT q.section, q.question_number, q.question_text, q.question_type, q.marks,
       ua.answer_text, ua.score, ua.max_possible_score 
       FROM user_answers ua 
       JOIN questions q ON ua.question_id = q.id 
       WHERE ua.user_id = ? 
       ORDER BY q.section, q.question_number`,
      [userId]
    );
    
    res.json({
      success: true,
      user: user[0],
      answers: answers
    });
    
  } catch (error) {
    console.error('Error fetching results:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to fetch results', 
      error: error.message 
    });
  }
});

// 6. Get all users - FIXED
app.get('/api/users', async (req, res) => {
  try {
    const [users] = await pool.query(
      'SELECT user_id, full_name, phone_number, email, exam_started, exam_completed, total_score, percentage_score, pass_status, created_at as registration_date FROM users ORDER BY created_at DESC'
    );
    
    res.json({
      success: true,
      users: users
    });
    
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to fetch users', 
      error: error.message 
    });
  }
});

// Health check
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    service: 'CRS Civil Service Exam System',
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
  console.log(`📚 Database: ${process.env.DB_NAME}`);
  console.log(`✅ Ready for requests`);
});

module.exports = app;
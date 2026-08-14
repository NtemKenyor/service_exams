const express = require('express');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const dotenv = require('dotenv');
const mysql = require('mysql2/promise');
const { v4: uuidv4 } = require('uuid');
const os = require('os');
const fs = require('fs');
const path = require('path');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// ============================================
// LOGGING SETUP
// ============================================
const LOG_DIR = path.join(__dirname, 'logs');

// Create logs directory if it doesn't exist
if (!fs.existsSync(LOG_DIR)) {
  fs.mkdirSync(LOG_DIR, { recursive: true });
}

// Create log streams
const createLogStream = (filename) => {
  return fs.createWriteStream(path.join(LOG_DIR, filename), { flags: 'a' });
};

const accessLogStream = createLogStream('access.log');
const errorLogStream = createLogStream('error.log');
const debugLogStream = createLogStream('debug.log');

// Custom logger
const logger = {
  info: (message, data = null) => {
    const logEntry = {
      timestamp: new Date().toISOString(),
      level: 'INFO',
      message: message,
      data: data
    };
    const logString = JSON.stringify(logEntry) + '\n';
    accessLogStream.write(logString);
    debugLogStream.write(logString);
    console.log(`✅ ${message}`);
  },
  error: (message, error = null) => {
    const logEntry = {
      timestamp: new Date().toISOString(),
      level: 'ERROR',
      message: message,
      error: error ? {
        message: error.message,
        stack: error.stack,
        code: error.code
      } : null
    };
    const logString = JSON.stringify(logEntry) + '\n';
    errorLogStream.write(logString);
    debugLogStream.write(logString);
    console.error(`❌ ${message}`, error);
  },
  warn: (message, data = null) => {
    const logEntry = {
      timestamp: new Date().toISOString(),
      level: 'WARN',
      message: message,
      data: data
    };
    const logString = JSON.stringify(logEntry) + '\n';
    debugLogStream.write(logString);
    console.warn(`⚠️ ${message}`);
  },
  debug: (message, data = null) => {
    if (process.env.DEBUG === 'true') {
      const logEntry = {
        timestamp: new Date().toISOString(),
        level: 'DEBUG',
        message: message,
        data: data
      };
      const logString = JSON.stringify(logEntry) + '\n';
      debugLogStream.write(logString);
      console.log(`🔍 ${message}`);
    }
  }
};

// ============================================
// CORS - FULLY OPEN
// ============================================
app.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'PATCH'],
  allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept']
}));

app.options('*', cors());

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// ============================================
// RATE LIMITING
// ============================================
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 1000,
  message: {
    success: false,
    message: 'Too many requests, please try again later.'
  },
  handler: (req, res) => {
    logger.warn(`Rate limit exceeded for IP: ${req.ip}`);
    res.status(429).json({
      success: false,
      message: 'Too many requests, please try again later.'
    });
  }
});
app.use('/api/', limiter);

// ============================================
// LOGGING MIDDLEWARE
// ============================================
app.use((req, res, next) => {
  const startTime = Date.now();
  const logData = {
    method: req.method,
    url: req.url,
    ip: req.ip || req.connection.remoteAddress,
    userAgent: req.headers['user-agent'],
    body: req.method === 'POST' ? req.body : undefined
  };
  
  logger.debug(`Request received`, logData);
  
  // Log response time
  res.on('finish', () => {
    const duration = Date.now() - startTime;
    logger.info(`Response sent: ${req.method} ${req.url} - ${res.statusCode} (${duration}ms)`);
  });
  
  next();
});

// ============================================
// DATABASE CONNECTION
// ============================================
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Test database connection on startup
pool.getConnection()
  .then(connection => {
    logger.info('Database connection established successfully');
    connection.release();
  })
  .catch(err => {
    logger.error('Failed to connect to database', err);
    process.exit(1);
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


// 1. Register user with date-based re-entry support
app.post('/api/register', async (req, res) => {
  try {
    const { fullName, phoneNumber, email } = req.body;
    
    logger.info(`Registration attempt for: ${fullName} (${phoneNumber})`);
    
    if (!fullName || !phoneNumber) {
      logger.warn(`Registration failed: Missing required fields`);
      return res.status(400).json({ 
        success: false, 
        message: 'Full name and phone number are required' 
      });
    }
    
    // Check if user exists
    const [existing] = await pool.query(
      'SELECT user_id, full_name, email, created_at, exam_started, exam_completed FROM users WHERE phone_number = ?',
      [phoneNumber]
    );
    
    // If user exists, check if it's the same day
    if (existing.length > 0) {
      const user = existing[0];
      const createdAt = new Date(user.created_at);
      const today = new Date();
      
      // Compare dates (year, month, day only)
      const isSameDay = 
        createdAt.getFullYear() === today.getFullYear() &&
        createdAt.getMonth() === today.getMonth() &&
        createdAt.getDate() === today.getDate();
      
      // If same day, allow re-entry (resume exam)
      if (isSameDay) {
        logger.info(`Re-entry: User already registered today (${phoneNumber})`);
        
        // Check if user already has an active session
        const [activeSession] = await pool.query(
          'SELECT session_token FROM exam_sessions WHERE user_id = ? AND is_active = TRUE',
          [user.user_id]
        );
        
        let sessionToken;
        if (activeSession.length > 0) {
          // Reuse existing active session
          sessionToken = activeSession[0].session_token;
          logger.info(`Reusing existing session for user ${user.user_id}`);
        } else {
          // Create new session
          sessionToken = uuidv4();
          const ipAddress = req.ip || req.connection.remoteAddress;
          const userAgent = req.headers['user-agent'];
          
          await pool.query(
            `INSERT INTO exam_sessions (user_id, session_token, ip_address, user_agent) 
             VALUES (?, ?, ?, ?)`,
            [user.user_id, sessionToken, ipAddress, userAgent]
          );
          logger.info(`New session created for user ${user.user_id}`);
        }
        
        return res.status(200).json({
          success: true,
          message: 'Welcome back! Resuming your exam.',
          userId: user.user_id,
          sessionToken: sessionToken,
          fullName: user.full_name,
          isReentry: true,
          examCompleted: user.exam_completed === 1,
          examStarted: user.exam_started === 1,
        });
      } else {
        // Different day - allow new registration
        logger.info(`User exists but from different day. Creating new registration for: ${phoneNumber}`);
        
        // Generate new user ID
        const userId = `CRS${Date.now().toString(36).toUpperCase()}${Math.random().toString(36).substring(2, 6).toUpperCase()}`;
        
        // Insert new user (with updated date)
        await pool.query(
          `INSERT INTO users (user_id, full_name, phone_number, email, exam_started) 
           VALUES (?, ?, ?, ?, TRUE)`,
          [userId, fullName, phoneNumber, email || null]
        );
        
        // Create new session
        const sessionToken = uuidv4();
        const ipAddress = req.ip || req.connection.remoteAddress;
        const userAgent = req.headers['user-agent'];
        
        await pool.query(
          `INSERT INTO exam_sessions (user_id, session_token, ip_address, user_agent) 
           VALUES (?, ?, ?, ?)`,
          [userId, sessionToken, ipAddress, userAgent]
        );
        
        logger.info(`New registration successful for different day: ${fullName} (${userId})`);
        
        return res.status(201).json({
          success: true,
          message: 'Registration successful',
          userId: userId,
          sessionToken: sessionToken,
          fullName: fullName,
          isReentry: false,
          isNewDay: true,
        });
      }
    }
    
    // --- NEW USER ---
    // Generate unique user ID
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
    
    logger.info(`Registration successful: ${fullName} (${userId})`);
    
    res.status(201).json({
      success: true,
      message: 'Registration successful',
      userId: userId,
      sessionToken: sessionToken,
      fullName: fullName,
      isReentry: false,
      isNewDay: false,
    });
    
  } catch (error) {
    logger.error('Registration error', error);
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
    
    logger.info(`Fetching questions for user: ${userId}`);
    
    if (!userId || !sessionToken) {
      logger.warn(`Questions fetch failed: Missing credentials`);
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
      logger.warn(`Questions fetch failed: Invalid session for user ${userId}`);
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
    
    logger.info(`Questions fetched successfully for user ${userId} (${questions.length} questions)`);
    
    res.json({
      success: true,
      userId: userId,
      fullName: user[0]?.full_name || '',
      examCompleted: user[0]?.exam_completed || false,
      totalQuestions: questions.length,
      total_time: 1800, // this is in seconds...
      show_result: true,
      questions: formattedQuestions
    });
    
  } catch (error) {
    logger.error('Error fetching questions', error);
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
    
    logger.info(`Saving answer for user ${userId}, question ${questionId}`);
    
    if (!userId || !sessionToken || !questionId || answerText === undefined) {
      logger.warn(`Answer save failed: Missing required fields`);
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
      logger.warn(`Answer save failed: Invalid session for user ${userId}`);
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
      logger.warn(`Answer save failed: Question ${questionId} not found`);
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
    
    logger.info(`Answer saved: User ${userId}, Question ${questionId}, Score ${actualScore}/${maxPossibleScore}`);
    
    res.json({
      success: true,
      message: 'Answer saved and scored',
      questionId: questionId,
      score: actualScore,
      maxScore: maxPossibleScore,
      percentage: parseFloat(((actualScore / maxPossibleScore) * 100).toFixed(2))
    });
    
  } catch (error) {
    logger.error('Error saving answer', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to save answer', 
      error: error.message 
    });
  }
});

// ============================================
// 3a. BULK SAVE ANSWERS - With Chunking
// ============================================
app.post('/api/bulk-save-answers', async (req, res) => {
  try {
    const { userId, sessionToken, answers, chunkSize = 50 } = req.body;
    
    logger.info(`Bulk save starting for user ${userId} (${answers?.length || 0} answers)`);
    
    if (!userId || !sessionToken) {
      logger.warn(`Bulk save failed: Missing credentials`);
      return res.status(400).json({ 
        success: false, 
        message: 'User ID and session token are required' 
      });
    }
    
    if (!answers || !Array.isArray(answers) || answers.length === 0) {
      logger.warn(`Bulk save failed: Empty answers array for user ${userId}`);
      return res.status(400).json({ 
        success: false, 
        message: 'Answers array is required and cannot be empty' 
      });
    }
    
    // Validate session
    const [session] = await pool.query(
      'SELECT * FROM exam_sessions WHERE user_id = ? AND session_token = ? AND is_active = TRUE',
      [userId, sessionToken]
    );
    
    if (session.length === 0) {
      logger.warn(`Bulk save failed: Invalid session for user ${userId}`);
      return res.status(401).json({ 
        success: false, 
        message: 'Invalid or expired session' 
      });
    }
    
    // Get all question IDs
    const questionIds = answers.map(a => a.questionId).filter(id => id);
    
    if (questionIds.length === 0) {
      logger.warn(`Bulk save failed: No valid question IDs for user ${userId}`);
      return res.status(400).json({ 
        success: false, 
        message: 'No valid question IDs provided' 
      });
    }
    
    // Fetch all questions in one query
    const placeholders = questionIds.map(() => '?').join(',');
    const [questions] = await pool.query(
      `SELECT id, question_type, marks, options, correct_answer, keywords 
       FROM questions 
       WHERE id IN (${placeholders})`,
      questionIds
    );
    
    // Create a map for quick lookup
    const questionMap = new Map();
    questions.forEach(q => {
      questionMap.set(q.id, q);
    });
    
    // Prepare bulk data
    const allBulkData = [];
    const results = [];
    const errors = [];
    
    for (const answer of answers) {
      const { questionId, answerText } = answer;
      
      if (!questionId) {
        errors.push({ questionId, error: 'Missing question ID' });
        continue;
      }
      
      const question = questionMap.get(questionId);
      
      if (!question) {
        errors.push({ questionId, error: 'Question not found' });
        continue;
      }
      
      if (answerText === undefined || answerText === null) {
        errors.push({ questionId, error: 'Answer text is required' });
        continue;
      }
      
      // Calculate score
      const score = calculateScore(
        question.question_type,
        answerText,
        question.correct_answer,
        question.options,
        question.keywords
      );
      
      const maxPossibleScore = question.marks;
      const actualScore = Math.round(score * maxPossibleScore);
      
      allBulkData.push([
        userId,
        questionId,
        answerText,
        actualScore,
        maxPossibleScore,
        new Date()
      ]);
      
      results.push({
        questionId,
        score: actualScore,
        maxScore: maxPossibleScore,
        percentage: parseFloat(((actualScore / maxPossibleScore) * 100).toFixed(2)),
        status: 'success'
      });
    }
    
    // Bulk insert with chunking
    if (allBulkData.length > 0) {
      const connection = await pool.getConnection();
      
      try {
        await connection.beginTransaction();
        
        const bulkQuery = `
          INSERT INTO user_answers 
            (user_id, question_id, answer_text, score, max_possible_score, evaluated_at) 
          VALUES ? 
          ON DUPLICATE KEY UPDATE 
            answer_text = VALUES(answer_text), 
            score = VALUES(score), 
            max_possible_score = VALUES(max_possible_score),
            evaluated_at = VALUES(evaluated_at)
        `;
        
        // Process in chunks
        const totalChunks = Math.ceil(allBulkData.length / chunkSize);
        let processedChunks = 0;
        
        for (let i = 0; i < allBulkData.length; i += chunkSize) {
          const chunk = allBulkData.slice(i, i + chunkSize);
          await connection.query(bulkQuery, [chunk]);
          processedChunks++;
          
          logger.debug(`Bulk save chunk ${processedChunks}/${totalChunks} completed for user ${userId}`);
        }
        
        await connection.commit();
        connection.release();
        
        logger.info(`Bulk save completed: ${allBulkData.length} answers saved for user ${userId}`);
        
      } catch (error) {
        await connection.rollback();
        connection.release();
        logger.error(`Bulk save transaction failed for user ${userId}`, error);
        throw error;
      }
    }
    
    // Update session activity
    await pool.query(
      'UPDATE exam_sessions SET last_activity = CURRENT_TIMESTAMP WHERE session_token = ?',
      [sessionToken]
    );
    
    // Calculate total score so far
    const [scoreResult] = await pool.query(
      'SELECT SUM(score) as total_score FROM user_answers WHERE user_id = ?',
      [userId]
    );
    
    const totalScoreSoFar = scoreResult[0]?.total_score || 0;
    
    res.json({
      success: true,
      message: `Saved ${results.length} answers successfully`,
      totalSaved: results.length,
      totalErrors: errors.length,
      totalScoreSoFar: totalScoreSoFar,
      results: results,
      errors: errors.length > 0 ? errors : undefined
    });
    
  } catch (error) {
    logger.error('Error bulk saving answers', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to bulk save answers', 
      error: error.message 
    });
  }
});

// ============================================
// 3b. BULK SUBMIT EXAM - Submit with all answers
// ============================================
app.post('/api/bulk-submit-exam', async (req, res) => {
  try {
    const { userId, sessionToken, answers, chunkSize = 50 } = req.body;
    
    logger.info(`Bulk submit starting for user ${userId}`);
    
    if (!userId || !sessionToken) {
      logger.warn(`Bulk submit failed: Missing credentials`);
      return res.status(400).json({ 
        success: false, 
        message: 'User ID and session token are required' 
      });
    }
    
    // Validate session
    const [session] = await pool.query(
      'SELECT * FROM exam_sessions WHERE user_id = ? AND session_token = ? AND is_active = TRUE',
      [userId, sessionToken]
    );
    
    if (session.length === 0) {
      logger.warn(`Bulk submit failed: Invalid session for user ${userId}`);
      return res.status(401).json({ 
        success: false, 
        message: 'Invalid or expired session' 
      });
    }
    
    // Check if already submitted
    const [user] = await pool.query(
      'SELECT exam_completed FROM users WHERE user_id = ?',
      [userId]
    );
    
    if (user[0]?.exam_completed) {
      logger.warn(`Bulk submit failed: Exam already submitted for user ${userId}`);
      return res.status(400).json({ 
        success: false, 
        message: 'Exam already submitted' 
      });
    }
    
    // If answers are provided, save them first
    if (answers && Array.isArray(answers) && answers.length > 0) {
      logger.info(`Saving ${answers.length} answers before submission for user ${userId}`);
      
      // Process answers similarly to bulk-save-answers
      const questionIds = answers.map(a => a.questionId).filter(id => id);
      
      if (questionIds.length > 0) {
        const placeholders = questionIds.map(() => '?').join(',');
        const [questions] = await pool.query(
          `SELECT id, question_type, marks, options, correct_answer, keywords 
           FROM questions 
           WHERE id IN (${placeholders})`,
          questionIds
        );
        
        const questionMap = new Map();
        questions.forEach(q => {
          questionMap.set(q.id, q);
        });
        
        const allBulkData = [];
        
        for (const answer of answers) {
          const { questionId, answerText } = answer;
          const question = questionMap.get(questionId);
          
          if (question && answerText !== undefined && answerText !== null) {
            const score = calculateScore(
              question.question_type,
              answerText,
              question.correct_answer,
              question.options,
              question.keywords
            );
            
            const maxPossibleScore = question.marks;
            const actualScore = Math.round(score * maxPossibleScore);
            
            allBulkData.push([
              userId,
              questionId,
              answerText,
              actualScore,
              maxPossibleScore,
              new Date()
            ]);
          }
        }
        
        if (allBulkData.length > 0) {
          const connection = await pool.getConnection();
          
          try {
            await connection.beginTransaction();
            
            const bulkQuery = `
              INSERT INTO user_answers 
                (user_id, question_id, answer_text, score, max_possible_score, evaluated_at) 
              VALUES ? 
              ON DUPLICATE KEY UPDATE 
                answer_text = VALUES(answer_text), 
                score = VALUES(score), 
                max_possible_score = VALUES(max_possible_score),
                evaluated_at = VALUES(evaluated_at)
            `;
            
            // Process in chunks
            for (let i = 0; i < allBulkData.length; i += chunkSize) {
              const chunk = allBulkData.slice(i, i + chunkSize);
              await connection.query(bulkQuery, [chunk]);
            }
            
            await connection.commit();
            connection.release();
            
            logger.info(`Answers saved before submission for user ${userId}`);
            
          } catch (error) {
            await connection.rollback();
            connection.release();
            logger.error(`Answer save failed before submission for user ${userId}`, error);
            throw error;
          }
        }
      }
    }
    
    // Calculate final score
    const [scoreResult] = await pool.query(
      'SELECT SUM(score) as total_score FROM user_answers WHERE user_id = ?',
      [userId]
    );
    
    const totalScore = scoreResult[0]?.total_score || 0;
    
    // Get total marks
    const [questions] = await pool.query(
      'SELECT SUM(marks) as total_marks FROM questions'
    );
    
    const totalMarks = questions[0]?.total_marks || 100;
    const percentageScore = (totalScore / totalMarks) * 100;
    const passStatus = percentageScore >= 60;
    
    // Update user
    await pool.query(
      `UPDATE users SET 
       exam_completed = TRUE, 
       total_score = ?, 
       percentage_score = ?, 
       pass_status = ?
       WHERE user_id = ?`,
      [totalScore, percentageScore, passStatus, userId]
    );
    
    // Deactivate session
    await pool.query(
      'UPDATE exam_sessions SET is_active = FALSE WHERE session_token = ?',
      [sessionToken]
    );
    
    logger.info(`Exam submitted successfully for user ${userId}: Score ${totalScore}/${totalMarks} (${percentageScore.toFixed(2)}%)`);
    
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
    logger.error('Error submitting exam', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to submit exam', 
      error: error.message 
    });
  }
});

// 4. Submit exam (single)
app.post('/api/submit-exam', async (req, res) => {
  try {
    const { userId, sessionToken } = req.body;
    
    logger.info(`Submit exam request for user ${userId}`);
    
    if (!userId || !sessionToken) {
      logger.warn(`Submit exam failed: Missing credentials`);
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
      logger.warn(`Submit exam failed: Invalid session for user ${userId}`);
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
      logger.warn(`Submit exam failed: Exam already submitted for user ${userId}`);
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
    
    logger.info(`Exam submitted for user ${userId}: Score ${totalScore}/${totalMarks} (${percentageScore.toFixed(2)}%)`);
    
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
    logger.error('Error submitting exam', error);
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
    
    logger.info(`Fetching results for user ${userId}`);
    
    const [user] = await pool.query(
      `SELECT full_name, phone_number, total_score, percentage_score, pass_status, exam_completed 
       FROM users WHERE user_id = ?`,
      [userId]
    );
    
    if (user.length === 0) {
      logger.warn(`Results fetch failed: User ${userId} not found`);
      return res.status(404).json({ 
        success: false, 
        message: 'User not found' 
      });
    }
    
    if (!user[0].exam_completed) {
      logger.warn(`Results fetch failed: Exam not completed for user ${userId}`);
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
    
    logger.info(`Results fetched successfully for user ${userId}`);
    
    res.json({
      success: true,
      user: user[0],
      answers: answers
    });
    
  } catch (error) {
    logger.error('Error fetching results', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to fetch results', 
      error: error.message 
    });
  }
});

// 6. Get all users
app.get('/api/users', async (req, res) => {
  try {
    logger.info('Fetching all users');
    
    const [users] = await pool.query(
      'SELECT user_id, full_name, phone_number, email, exam_started, exam_completed, total_score, percentage_score, pass_status, created_at as registration_date FROM users ORDER BY created_at DESC'
    );
    
    logger.info(`Fetched ${users.length} users`);
    
    res.json({
      success: true,
      users: users
    });
    
  } catch (error) {
    logger.error('Error fetching users', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to fetch users', 
      error: error.message 
    });
  }
});

// 7. Health check
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    service: 'CRS Civil Service Exam System',
    version: '2.0.0',
    timestamp: new Date().toISOString()
  });
});

// 8. Get logs (Admin only - for demo purposes)
app.get('/api/logs/:type', async (req, res) => {
  try {
    const { type } = req.params;
    const allowedTypes = ['access', 'error', 'debug'];
    
    if (!allowedTypes.includes(type)) {
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid log type. Allowed: access, error, debug' 
      });
    }
    
    const logFile = path.join(LOG_DIR, `${type}.log`);
    
    if (!fs.existsSync(logFile)) {
      return res.status(404).json({ 
        success: false, 
        message: 'Log file not found' 
      });
    }
    
    const logs = fs.readFileSync(logFile, 'utf8');
    const logLines = logs.split('\n').filter(line => line.trim());
    const recentLogs = logLines.slice(-50); // Get last 50 lines
    
    res.json({
      success: true,
      type: type,
      totalLines: logLines.length,
      recentLogs: recentLogs
    });
    
  } catch (error) {
    logger.error('Error fetching logs', error);
    res.status(500).json({ 
      success: false, 
      message: 'Failed to fetch logs', 
      error: error.message 
    });
  }
});

// 9. Root endpoint
app.get('/', (req, res) => {
  res.json({
    name: 'CRS Civil Service Exam System API',
    version: '2.0.0',
    status: 'running',
    endpoints: {
      health: 'GET /api/health',
      register: 'POST /api/register',
      questions: 'POST /api/questions',
      saveAnswer: 'POST /api/save-answer',
      bulkSaveAnswers: 'POST /api/bulk-save-answers',
      bulkSubmitExam: 'POST /api/bulk-submit-exam',
      submitExam: 'POST /api/submit-exam',
      results: 'GET /api/results/:userId',
      users: 'GET /api/users',
      logs: 'GET /api/logs/:type'
    }
  });
});

// ============================================
// GET LOCAL IP ADDRESS
// ============================================
const getLocalIP = () => {
  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      if (iface.family === 'IPv4' && !iface.internal) {
        return iface.address;
      }
    }
  }
  return 'localhost';
};

// ============================================
// ERROR HANDLING MIDDLEWARE
// ============================================
app.use((err, req, res, next) => {
  logger.error('Unhandled error', err);
  res.status(500).json({
    success: false,
    message: 'Internal server error',
    error: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// ============================================
// START SERVER - Listen on all interfaces
// ============================================
const localIP = getLocalIP();

app.listen(PORT, '0.0.0.0', () => {
  console.log(`\n🚀 ${'='.repeat(50)}`);
  console.log(`   CRS CIVIL SERVICE EXAM SYSTEM API`);
  console.log(`${'='.repeat(55)}`);
  console.log(`\n   📍 Local Access:   http://localhost:${PORT}`);
  console.log(`   📍 Network Access: http://${localIP}:${PORT}`);
  console.log(`   🌐 CORS:          Fully open (all origins allowed)`);
  console.log(`   📚 Database:      ${process.env.DB_NAME}`);
  console.log(`   📝 Logs:          ./logs/ (access.log, error.log, debug.log)`);
  console.log(`   ✅ Status:        Running`);
  console.log(`\n${'='.repeat(55)}`);
  console.log(`\n📱 Other devices on your network can access at:`);
  console.log(`   ➜ http://${localIP}:${PORT}`);
  console.log(`\n🔧 Test with curl:`);
  console.log(`   curl http://${localIP}:${PORT}/api/health`);
  console.log(`\n📝 View logs:`);
  console.log(`   tail -f logs/access.log`);
  console.log(`   tail -f logs/error.log`);
  console.log(`   tail -f logs/debug.log\n`);
  
  logger.info(`Server started successfully on port ${PORT}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  logger.info('SIGTERM received, shutting down gracefully');
  process.exit(0);
});

process.on('SIGINT', () => {
  logger.info('SIGINT received, shutting down gracefully');
  process.exit(0);
});

module.exports = app;
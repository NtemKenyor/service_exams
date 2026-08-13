

## 1. Testing with cURL Commands

### Test 1: Health Check
```bash
curl -X GET http://localhost:5000/api/health
```

### Test 2: Register User
```bash
curl -X POST http://localhost:5000/api/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "John Doe",
    "phoneNumber": "08012345678",
    "email": "john.doe@example.com"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "Registration successful",
  "userId": "CRS1234567890ABCD",
  "sessionToken": "550e8400-e29b-41d4-a716-446655440000",
  "fullName": "John Doe"
}
```

### Test 3: Get Questions
```bash
curl -X POST http://localhost:5000/api/questions \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "CRS1234567890ABCD",
    "sessionToken": "550e8400-e29b-41d4-a716-446655440000"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "userId": "CRS1234567890ABCD",
  "fullName": "John Doe",
  "examCompleted": false,
  "totalQuestions": 10,
  "questions": [
    {
      "id": 1,
      "section": "A",
      "questionNumber": 1,
      "questionText": "Which of the following is NOT a principle of the Cross River State Civil Service?",
      "questionType": "objective",
      "marks": 5,
      "options": ["Merit-based recruitment", "Political neutrality", "Partisan decision making", "Professionalism"],
      "answer": "",
      "isAnswered": false
    },
    // ... more questions
  ]
}
```

### Test 4: Save Objective Answer
```bash
curl -X POST http://localhost:5000/api/save-answer \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "CRS1234567890ABCD",
    "sessionToken": "550e8400-e29b-41d4-a716-446655440000",
    "questionId": 1,
    "answerText": "2"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "Answer saved and scored",
  "questionId": 1,
  "score": 5,
  "maxScore": 5,
  "percentage": 100
}
```

### Test 5: Save Subjective Answer
```bash
curl -X POST http://localhost:5000/api/save-answer \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "CRS1234567890ABCD",
    "sessionToken": "550e8400-e29b-41d4-a716-446655440000",
    "questionId": 4,
    "answerText": "Public service is the provision of services to the citizens by government entities."
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "Answer saved and scored",
  "questionId": 4,
  "score": 10,
  "maxScore": 10,
  "percentage": 100
}
```

### Test 6: Save Theory Answer
```bash
curl -X POST http://localhost:5000/api/save-answer \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "CRS1234567890ABCD",
    "sessionToken": "550e8400-e29b-41d4-a716-446655440000",
    "questionId": 6,
    "answerText": "The Back to Farm initiative is crucial for food security and economic empowerment of youth in Cross River State through sustainable agriculture practices."
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "Answer saved and scored",
  "questionId": 6,
  "score": 15,
  "maxScore": 15,
  "percentage": 100
}
```

### Test 7: Submit Exam
```bash
curl -X POST http://localhost:5000/api/submit-exam \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "CRS1234567890ABCD",
    "sessionToken": "550e8400-e29b-41d4-a716-446655440000"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "Exam submitted successfully",
  "userId": "CRS1234567890ABCD",
  "totalScore": 85,
  "totalMarks": 100,
  "percentageScore": 85,
  "passStatus": true,
  "passMark": 60
}
```

### Test 8: Get Results
```bash
curl -X GET http://localhost:5000/api/results/CRS1234567890ABCD
```

**Expected Response:**
```json
{
  "success": true,
  "user": {
    "full_name": "John Doe",
    "phone_number": "08012345678",
    "total_score": 85,
    "percentage_score": 85.00,
    "pass_status": true,
    "exam_completed": true
  },
  "answers": [
    {
      "section": "A",
      "question_number": 1,
      "question_text": "Which of the following is NOT a principle...",
      "question_type": "objective",
      "marks": 5,
      "answer_text": "2",
      "score": 5,
      "max_possible_score": 5
    }
    // ... more answers
  ]
}
```

## Hint - Summary

The system now properly handles three question types:

1. **Objective**: Multiple choice questions with options, scored by comparing selected index with correct answer
2. **Subjective**: Open-ended questions, scored by matching against a reference answer
3. **Theory**: Essay questions, scored by checking for keywords

Each question type is saved in the database with appropriate columns and scored accordingly when answers are saved. The scoring is done automatically on save, and the total score is calculated when the exam is submitted.


# Auto Bulk Save
this helps improve efficiency and reduces server load drastically:

# Bulk save answers
curl -X POST http://localhost:5000/api/bulk-save-answers \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "CRSMRPC0WOOPF3E",
    "sessionToken": "84a65e5d-7e25-4621-ba1c-383bdd54caf4",
    "answers": [
      {"questionId": 1, "answerText": "2"},
      {"questionId": 2, "answerText": "1"},
      {"questionId": 3, "answerText": "0"},
      {"questionId": 4, "answerText": "Public service is the provision of services to the citizens by government entities."},
      {"questionId": 6, "answerText": "The Back to Farm initiative is crucial for food security and economic empowerment of youth in Cross River State through sustainable agriculture practices."}
    ]
  }'

# Bulk submit exam with answers
curl -X POST http://localhost:5000/api/bulk-submit-exam \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "CRSMRPC0WOOPF3E",
    "sessionToken": "84a65e5d-7e25-4621-ba1c-383bdd54caf4",
    "answers": [
      {"questionId": 1, "answerText": "2"},
      {"questionId": 2, "answerText": "1"}
    ]
  }'





# Hint - Summary
No, 50 in this context is 50 answers per chunk, not 50MB.

BULK_CHUNK_SIZE=50 = Process 50 answers at a time in each database insert batch

It limits how many records are inserted in a single SQL query to prevent timeouts

Example:

If you have 500 answers to save

With chunk size 50 → 10 database inserts (chunks) of 50 answers each

With chunk size 100 → 5 database inserts of 100 answers each

Benefits:

Prevents database query timeouts

Reduces memory usage

If one chunk fails, others may still succeed


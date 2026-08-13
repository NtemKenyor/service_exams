#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Base URL
BASE_URL="http://localhost:5000/api"

# Store variables
USER_ID=""
SESSION_TOKEN=""
QUESTION_IDS=()

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  CRS EXAM SYSTEM API TEST SUITE${NC}"
echo -e "${BLUE}========================================${NC}\n"

# Function to print test results
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ PASSED:${NC} $2"
    else
        echo -e "${RED}✗ FAILED:${NC} $2"
        echo -e "${RED}  Error: $3${NC}"
    fi
}

# 1. Health Check
echo -e "${YELLOW}Test 1: Health Check${NC}"
response=$(curl -s -X GET $BASE_URL/health)
if echo "$response" | grep -q "OK"; then
    print_result 0 "Health check successful"
    echo -e "${BLUE}Response:${NC} $response\n"
else
    print_result 1 "Health check failed" "$response"
    exit 1
fi

# 2. Register User
echo -e "${YELLOW}Test 2: Register User${NC}"
response=$(curl -s -X POST $BASE_URL/register \
    -H "Content-Type: application/json" \
    -d '{
        "fullName": "Test Candidate",
        "phoneNumber": "08045378678",
        "email": "test02@example.com"
    }')

if echo "$response" | grep -q "success.*true"; then
    USER_ID=$(echo "$response" | grep -o '"userId":"[^"]*"' | cut -d'"' -f4)
    SESSION_TOKEN=$(echo "$response" | grep -o '"sessionToken":"[^"]*"' | cut -d'"' -f4)
    print_result 0 "User registered successfully"
    echo -e "${BLUE}User ID:${NC} $USER_ID"
    echo -e "${BLUE}Session Token:${NC} $SESSION_TOKEN\n"
else
    print_result 1 "Registration failed" "$response"
    exit 1
fi

# 3. Get Questions
echo -e "${YELLOW}Test 3: Get Questions${NC}"
response=$(curl -s -X POST $BASE_URL/questions \
    -H "Content-Type: application/json" \
    -d "{
        \"userId\": \"$USER_ID\",
        \"sessionToken\": \"$SESSION_TOKEN\"
    }")

if echo "$response" | grep -q "success.*true"; then
    QUESTION_IDS=($(echo "$response" | grep -o '"id":[0-9]*' | cut -d':' -f2))
    TOTAL_QUESTIONS=$(echo "$response" | grep -o '"totalQuestions":[0-9]*' | cut -d':' -f2)
    print_result 0 "Questions fetched successfully"
    echo -e "${BLUE}Total Questions:${NC} $TOTAL_QUESTIONS"
    echo -e "${BLUE}First 5 Question IDs:${NC} ${QUESTION_IDS[@]:0:5}\n"
else
    print_result 1 "Failed to fetch questions" "$response"
    exit 1
fi

# 4. Save Objective Answer
echo -e "${YELLOW}Test 4: Save Objective Answer (Q1)${NC}"
response=$(curl -s -X POST $BASE_URL/save-answer \
    -H "Content-Type: application/json" \
    -d "{
        \"userId\": \"$USER_ID\",
        \"sessionToken\": \"$SESSION_TOKEN\",
        \"questionId\": ${QUESTION_IDS[0]},
        \"answerText\": \"2\"
    }")

if echo "$response" | grep -q "success.*true"; then
    SCORE=$(echo "$response" | grep -o '"score":[0-9]*' | cut -d':' -f2)
    print_result 0 "Objective answer saved"
    echo -e "${BLUE}Score:${NC} $SCORE\n"
else
    print_result 1 "Failed to save objective answer" "$response"
fi

# 5. Save Subjective Answer
echo -e "${YELLOW}Test 5: Save Subjective Answer (Q4)${NC}"
response=$(curl -s -X POST $BASE_URL/save-answer \
    -H "Content-Type: application/json" \
    -d "{
        \"userId\": \"$USER_ID\",
        \"sessionToken\": \"$SESSION_TOKEN\",
        \"questionId\": ${QUESTION_IDS[3]},
        \"answerText\": \"Public service is the provision of services to the citizens by government entities.\"
    }")

if echo "$response" | grep -q "success.*true"; then
    SCORE=$(echo "$response" | grep -o '"score":[0-9]*' | cut -d':' -f2)
    print_result 0 "Subjective answer saved"
    echo -e "${BLUE}Score:${NC} $SCORE\n"
else
    print_result 1 "Failed to save subjective answer" "$response"
fi

# 6. Save Theory Answer
echo -e "${YELLOW}Test 6: Save Theory Answer (Q6)${NC}"
response=$(curl -s -X POST $BASE_URL/save-answer \
    -H "Content-Type: application/json" \
    -d "{
        \"userId\": \"$USER_ID\",
        \"sessionToken\": \"$SESSION_TOKEN\",
        \"questionId\": ${QUESTION_IDS[5]},
        \"answerText\": \"The Back to Farm initiative is crucial for food security and economic empowerment of youth in Cross River State through sustainable agriculture practices.\"
    }")

if echo "$response" | grep -q "success.*true"; then
    SCORE=$(echo "$response" | grep -o '"score":[0-9]*' | cut -d':' -f2)
    PERCENTAGE=$(echo "$response" | grep -o '"percentage":[0-9.]*' | cut -d':' -f2)
    print_result 0 "Theory answer saved"
    echo -e "${BLUE}Score:${NC} $SCORE"
    echo -e "${BLUE}Percentage:${NC} $PERCENTAGE%\n"
else
    print_result 1 "Failed to save theory answer" "$response"
fi

# 7. Save Another Answer
echo -e "${YELLOW}Test 7: Save Another Objective Answer (Q2)${NC}"
response=$(curl -s -X POST $BASE_URL/save-answer \
    -H "Content-Type: application/json" \
    -d "{
        \"userId\": \"$USER_ID\",
        \"sessionToken\": \"$SESSION_TOKEN\",
        \"questionId\": ${QUESTION_IDS[1]},
        \"answerText\": \"1\"
    }")

if echo "$response" | grep -q "success.*true"; then
    print_result 0 "Second objective answer saved\n"
else
    print_result 1 "Failed to save second objective answer" "$response"
fi

# 8. Submit Exam
echo -e "${YELLOW}Test 8: Submit Exam${NC}"
response=$(curl -s -X POST $BASE_URL/submit-exam \
    -H "Content-Type: application/json" \
    -d "{
        \"userId\": \"$USER_ID\",
        \"sessionToken\": \"$SESSION_TOKEN\"
    }")

if echo "$response" | grep -q "success.*true"; then
    TOTAL_SCORE=$(echo "$response" | grep -o '"totalScore":[0-9]*' | cut -d':' -f2)
    PERCENTAGE=$(echo "$response" | grep -o '"percentageScore":[0-9.]*' | cut -d':' -f2)
    PASS_STATUS=$(echo "$response" | grep -o '"passStatus":true\|false' | cut -d':' -f2)
    
    if [ "$PASS_STATUS" = "true" ]; then
        PASS_TEXT="${GREEN}PASSED${NC}"
    else
        PASS_TEXT="${RED}FAILED${NC}"
    fi
    
    print_result 0 "Exam submitted successfully"
    echo -e "${BLUE}Total Score:${NC} $TOTAL_SCORE"
    echo -e "${BLUE}Percentage:${NC} $PERCENTAGE%"
    echo -e "${BLUE}Status:${NC} $PASS_TEXT\n"
else
    print_result 1 "Failed to submit exam" "$response"
fi

# 9. Get Results
echo -e "${YELLOW}Test 9: Get Results${NC}"
response=$(curl -s -X GET $BASE_URL/results/$USER_ID)

if echo "$response" | grep -q "success.*true"; then
    USER_NAME=$(echo "$response" | grep -o '"full_name":"[^"]*"' | cut -d'"' -f4)
    TOTAL_SCORE=$(echo "$response" | grep -o '"total_score":[0-9]*' | cut -d':' -f2)
    PERCENTAGE=$(echo "$response" | grep -o '"percentage_score":[0-9.]*' | cut -d':' -f2)
    
    print_result 0 "Results fetched successfully"
    echo -e "${BLUE}Candidate:${NC} $USER_NAME"
    echo -e "${BLUE}Total Score:${NC} $TOTAL_SCORE"
    echo -e "${BLUE}Percentage:${NC} $PERCENTAGE%\n"
else
    print_result 1 "Failed to fetch results" "$response"
fi

# 10. Get All Users
echo -e "${YELLOW}Test 10: Get All Users${NC}"
response=$(curl -s -X GET $BASE_URL/users)

if echo "$response" | grep -q "success.*true"; then
    USER_COUNT=$(echo "$response" | grep -o '"user_id"' | wc -l)
    print_result 0 "Users list fetched"
    echo -e "${BLUE}Total Users:${NC} $USER_COUNT\n"
else
    print_result 1 "Failed to fetch users" "$response"
fi

# Summary
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✓ Test Suite Complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "User ID: $USER_ID"
echo -e "Session Token: $SESSION_TOKEN"
echo -e "\n${YELLOW}To test individual endpoints manually:${NC}"
echo -e "  curl -X GET $BASE_URL/health"
echo -e "  curl -X GET $BASE_URL/results/$USER_ID"
echo -e "  curl -X GET $BASE_URL/users"
-- Migration: persist each candidate's allocated question set and total marks
-- Run this once against crs_civil_service_exam before deploying the updated server.js

ALTER TABLE users
  ADD COLUMN allocated_question_ids JSON NULL AFTER exam_started,
  ADD COLUMN total_allocated_marks INT NULL AFTER allocated_question_ids;

-- Notes:
-- - allocated_question_ids stores the exact question IDs given to this user
--   the first time they call /api/questions, e.g. [1,2,3,37,38,...].
-- - total_allocated_marks stores the sum of marks for those questions
--   (e.g. 60), captured at allocation time.
-- - Existing users (registered before this migration) will have NULL in
--   both columns. server.js falls back gracefully for them by deriving
--   totals from user_answers, same as before, but any user who submits
--   incomplete answers under the old fallback can still see an inflated
--   percentage. If practical, ask still-in-progress candidates to
--   re-register/resume so a fresh allocation gets persisted, or backfill
--   these two columns for in-progress users manually.
-- Resham Furqan
-- 10/11/2025

-- Testing Triggers

-- Test 1: prevent_future_editions
SELECT '=== TEST 1: prevent_future_editions - Future year (Should FAIL) ===' AS test_description;
INSERT INTO edition (festival_ID, venue, start_date, end_date, year)
VALUES (1, 'Future Venue', '2026-05-01', '2026-05-10', 2026);
SELECT '' AS spacer;

SELECT '=== TEST 2: prevent_future_editions - Valid past year (Should SUCCEED) ===' AS test_description;
INSERT INTO edition (festival_ID, venue, start_date, end_date, year)
VALUES (1, 'Past Venue', '2020-05-01', '2020-05-10', 2020);
SELECT 'Success: Past edition inserted' AS result;
SELECT '' AS spacer;

SELECT '=== TEST 3: prevent_future_editions - Invalid date range (Should FAIL) ===' AS test_description;
INSERT INTO edition (festival_ID, venue, start_date, end_date, year)
VALUES (1, 'Invalid Date Venue', '2024-05-10', '2024-05-01', 2024);
SELECT '' AS spacer;

-- Test 2: set_award_category_level
SELECT '=== TEST 4: set_award_category_level - "Best" category (Should set to Main) ===' AS test_description;
INSERT INTO award_category (category_name, level, description)
VALUES ('Best New Director', 'Secondary', 'Test category for new directors');
SELECT 'Checking inserted category level:' AS check_message;
SELECT category_name, level FROM award_category WHERE category_name = 'Best New Director';
SELECT '' AS spacer;

SELECT '=== TEST 5: set_award_category_level - "Special" category (Should set to Special) ===' AS test_description;
INSERT INTO award_category (category_name, level, description)
VALUES ('Special Achievement Award', 'Secondary', 'Test special award');
SELECT 'Checking inserted category level:' AS check_message;
SELECT category_name, level FROM award_category WHERE category_name = 'Special Achievement Award';
SELECT '' AS spacer;

SELECT '=== TEST 6: set_award_category_level - Regular category (Should stay Secondary) ===' AS test_description;
INSERT INTO award_category (category_name, level, description)
VALUES ('Sound Editing', 'Secondary', 'Test regular category');
SELECT 'Checking inserted category level:' AS check_message;
SELECT category_name, level FROM award_category WHERE category_name = 'Sound Editing';
SELECT '' AS spacer;

SELECT '=== TEST 7: Audit trail verification ===' AS test_description;
SELECT 'Checking category_audit table entries:' AS check_message;
SELECT category_name, level_assigned, created_by FROM category_audit;
SELECT '' AS spacer;

SELECT '=== TRIGGER TESTS COMPLETED ===' AS final_message;

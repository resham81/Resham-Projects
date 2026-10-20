-- Resham Furqan
-- 10/11/2025

-- Testing Indexes

-- =============================================
-- COMPREHENSIVE INDEX TESTS
-- =============================================

-- Verify Index Creation
SELECT '=== TEST 1: Index verification - nomination table ===' AS test_description;
SHOW INDEX FROM nomination;
SELECT '' AS spacer;

SELECT '=== TEST 2: Index verification - edition table ===' AS test_description;
SHOW INDEX FROM edition;
SELECT '' AS spacer;

SELECT '=== TEST 3: Index verification - film_crew table ===' AS test_description;
SHOW INDEX FROM film_crew;
SELECT '' AS spacer;

-- Test Query Performance with EXPLAIN
SELECT '=== TEST 4: Query performance - nomination status search ===' AS test_description;
EXPLAIN SELECT * FROM nomination WHERE status = 'Won';
SELECT '' AS spacer;

SELECT '=== TEST 5: Query performance - edition year range ===' AS test_description;
EXPLAIN SELECT * FROM edition WHERE year BETWEEN 2020 AND 2025;
SELECT '' AS spacer;

SELECT '=== TEST 6: Query performance - composite index usage ===' AS test_description;
EXPLAIN SELECT * FROM nomination WHERE edition_ID = 1 AND status = 'Won' AND category_ID = 1;
SELECT '' AS spacer;

SELECT '=== TEST 7: Query performance - person name search ===' AS test_description;
EXPLAIN SELECT * FROM person WHERE last_name = 'Nolan' AND first_name = 'Christopher';
SELECT '' AS spacer;

SELECT '=== TEST 8: Query performance - film release year ===' AS test_description;
EXPLAIN SELECT * FROM film WHERE release_year > 2000;
SELECT '' AS spacer;

SELECT '=== INDEX TESTS COMPLETED ===' AS final_message;

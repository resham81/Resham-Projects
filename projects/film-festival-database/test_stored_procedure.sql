-- Resham Furqan 
-- 10/11/2025

-- Testing Stored Procedures

-- Test Procedure 1
-- Test Case 1: Valid festival and year - Should return winners from Oscars 2023
SELECT '=== TEST 1: Valid festival and year (Oscars 2023) ===' AS test_description;
CALL Get_festival_winners('Academy Awards (Oscars)', 2023, NULL);
SELECT '' AS spacer;

-- Test Case 2: With category filter - Should return Palme d'Or winners from Cannes 2024
SELECT '=== TEST 2: Category filter (Palme d''Or at Cannes 2024) ===' AS test_description;
CALL Get_festival_winners('Cannes Film Festival', 2024, 'Palme');
SELECT '' AS spacer;

-- Test Case 3: Non-existent festival - Should show error message
SELECT '=== TEST 3: Non-existent festival (Error handling) ===' AS test_description;
CALL Get_festival_winners('Non-existent Festival', 2023, NULL);
SELECT '' AS spacer;

-- Test Case 4: Year with no winners - Should return empty set
SELECT '=== TEST 4: Year with no winners (Oscars 2000) ===' AS test_description;
CALL Get_festival_winners('Academy Awards (Oscars)', 2000, NULL);
SELECT '' AS spacer;

-- Test Case 5: Partial category name matching - Should work with 'PALME'
SELECT '=== TEST 5: Partial category name matching (PALME) ===' AS test_description;
CALL Get_festival_winners('Cannes Film Festival', 2024, 'PALME');
SELECT '' AS spacer;

-- Test Case 6: Testing with different category - Should return actors if any won in 2023
SELECT '=== TEST 6: Different category search (ACTOR at Oscars 2023) ===' AS test_description;
CALL Get_festival_winners('Academy Awards (Oscars)', 2023, 'ACTOR');
SELECT '' AS spacer;

-- Test Case 7: Edge cases
SELECT '=== TEST 7a: Empty string festival (Error handling) ===' AS test_description;
CALL Get_festival_winners('', 2023, NULL);

SELECT '=== TEST 7b: NULL year parameter ===' AS test_description;
CALL Get_festival_winners('Academy Awards (Oscars)', NULL, NULL);

-- First, check available festival IDs
SELECT '=== Available festivals for testing ===' AS test_description;
SELECT festival_ID, name FROM film_festival;
SELECT '' AS spacer;

-- Test Procedure 2
SELECT '=== TEST 1: Calculate_festival_statistics - Valid festival ID ===' AS test_description;
CALL Calculate_festival_statistics_with_cursor(1);
SELECT '' AS spacer;

SELECT '=== TEST 2: Calculate_festival_statistics - Another valid festival ID ===' AS test_description;
CALL Calculate_festival_statistics_with_cursor(2);
SELECT '' AS spacer;

SELECT '=== TEST 3: Calculate_festival_statistics - Invalid festival ID ===' AS test_description;
CALL Calculate_festival_statistics_with_cursor(999);
SELECT '' AS spacer;

SELECT '=== ALL TESTS COMPLETED ===' AS final_message;

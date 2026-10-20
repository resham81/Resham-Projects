-- Resham Furqan
-- 10/11/2025

-- Testing Views

-- Test View 1: festival_performance_overview
SELECT '=== TEST 1: festival_performance_overview - Full view data ===' AS test_description;
SELECT festival_name, country, total_editions, total_nominations, total_wins, overall_win_rate 
FROM festival_performance_overview;
SELECT '' AS spacer;

SELECT '=== TEST 2: festival_performance_overview - Specific festival details ===' AS test_description;
SELECT * FROM festival_performance_overview 
WHERE festival_name = 'Academy Awards (Oscars)';
SELECT '' AS spacer;

SELECT '=== TEST 3: festival_performance_overview - Calculated fields verification ===' AS test_description;
SELECT festival_name, years_active, first_edition_year, latest_edition_year,
       total_editions, total_nominations, total_wins, overall_win_rate
FROM festival_performance_overview;
SELECT '' AS spacer;

-- Test View 2: international_co_productions (UPDATED COLUMNS)
SELECT '=== TEST 4: international_co_productions - All co-productions ===' AS test_description;
SELECT primary_country, partner_country, co_production_count, co_production_films, avg_duration
FROM international_co_productions;
SELECT '' AS spacer;

SELECT '=== TEST 5: international_co_productions - Specific country analysis ===' AS test_description;
SELECT * FROM international_co_productions 
WHERE primary_country = 'United States' OR partner_country = 'United States';
SELECT '' AS spacer;

SELECT '=== TEST 6: international_co_productions - Film details verification ===' AS test_description;
SELECT primary_country, partner_country, co_production_films, avg_duration,
       first_co_production_year, latest_co_production_year
FROM international_co_productions 
WHERE co_production_count > 0;
SELECT '' AS spacer;

SELECT '=== VIEW TESTS COMPLETED SUCCESSFULLY! ===' AS final_message;

-- Resham Furqan
-- Final Assignment
-- This file contains Query 1: To analyze festival edition statistics

SELECT ff.name as festival_name, e.year, e.venue,
DATEDIFF(e.end_date, e.start_date) as duration_days,
COUNT(DISTINCT n.nomination_ID) as total_nominations,
COUNT(DISTINCT CASE WHEN n.status = 'Won' THEN n.nomination_ID END) as awards_given,
COUNT(DISTINCT n.film_ID) as unique_films,
COUNT(DISTINCT n.person_ID) as unique_people
FROM edition e
JOIN film_festival ff ON e.festival_ID = ff.festival_ID
LEFT JOIN nomination n ON e.edition_ID = n.edition_ID
GROUP BY ff.name, e.year, e.venue, e.start_date, e.end_date
HAVING total_nominations > 0
ORDER BY ff.name, e.year DESC;


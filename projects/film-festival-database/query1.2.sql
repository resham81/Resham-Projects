-- Resham Furqan
-- Final Assignment
-- This file contains Query 2: To help users find films by language and duration

SELECT title, release_year, language, duration,
CONCAT(FLOOR(duration / 60), 'h ', duration % 60, 'm') AS formatted_duration
FROM film
WHERE language LIKE '%English%'
AND duration BETWEEN 90 AND 180
AND release_year > 2000
ORDER BY duration DESC, release_year DESC;



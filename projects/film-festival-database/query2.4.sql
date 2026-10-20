-- Resham Furqan
-- Final Assignment
-- This file contains Query 4: For role analysis of film crew

SELECT f.title, f.release_year, p.first_name, p.last_name,
fc.role, p.profession
FROM film_crew fc
JOIN film f ON fc.film_ID = f.film_ID
JOIN person p ON fc.person_ID = p.person_ID
WHERE fc.role IN ('Director', 'Producer', 'Actor')
AND f.title IS NOT NULL
ORDER BY f.release_year DESC, fc.role
LIMIT 20;


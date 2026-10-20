-- Resham Furqan
-- Final Assignment
-- This file contains Query 2: To count nominations by festival

SELECT ff.name as festival_name, ff.country,
COUNT(n.nomination_ID) as total_nominations,
COUNT(DISTINCT n.film_ID) as unique_films,
COUNT(DISTINCT n.person_ID) as unique_people
FROM film_festival ff
JOIN edition e ON ff.festival_ID = e.festival_ID
JOIN nomination n ON e.edition_ID = n.edition_ID
GROUP BY ff.festival_ID, ff.name, ff.country
HAVING total_nominations > 0
ORDER BY total_nominations DESC;



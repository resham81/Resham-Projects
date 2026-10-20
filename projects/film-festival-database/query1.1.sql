-- Resham Furqan
-- Final Assignment
-- This file the Query 1: To find recent award-winning films

SELECT f.title, f.release_year, ac.category_name, e.year as award_year
FROM nomination n
JOIN film f ON n.film_ID = f.film_ID
JOIN award_category ac ON n.category_ID = ac.category_ID
JOIN edition e ON n.edition_ID = e.edition_ID
WHERE n.status = 'Won'
AND e.year BETWEEN 2020 AND 2025
AND ac.level = 'Main'
ORDER BY e.year DESC, f.title;



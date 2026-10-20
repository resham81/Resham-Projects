-- Resham Furqan
-- Final Assignment
-- this file contains Query 3: To find award winners

SELECT f.title as film_title, p.first_name, p.last_name,
ac.category_name, ff.name as festival_name, e.year
FROM nomination n
JOIN film f ON n.film_ID = f.film_ID
LEFT JOIN person p ON n.person_ID = p.person_ID
JOIN award_category ac ON n.category_ID = ac.category_ID
JOIN edition e ON n.edition_ID = e.edition_ID
JOIN film_festival ff ON e.festival_ID = ff.festival_ID
WHERE n.status = 'Won'
AND f.title IS NOT NULL
ORDER BY e.year DESC, ff.name
LIMIT 15;


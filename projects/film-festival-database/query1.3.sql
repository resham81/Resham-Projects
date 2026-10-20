-- Resham Furqan
-- Final Assignment
-- This file contains Query 3: To find festivals by location and type

SELECT name, location, founding_year, festival_type,
CONCAT(name, ' - ', location) AS festival_location
FROM film_festival
WHERE festival_type IN ('International', 'National')
AND location IS NOT NULL
AND name IS NOT NULL
ORDER BY festival_type, country;


-- Resham Furqan
-- Final Assignment
-- This file contains Query 4: To calculate ages of people and career duration
SELECT first_name, last_name, profession, dob,
TIMESTAMPDIFF(YEAR, dob, CURDATE()) as age,
CASE
    WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) < 30 THEN 'Early Career'
    WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 30 AND 50 THEN 'Mid Career'
    ELSE 'Established'
END as career_stage
FROM person
WHERE dob IS NOT NULL
AND profession IN ('Director', 'Actor', 'Producer')
ORDER BY age DESC, last_name;


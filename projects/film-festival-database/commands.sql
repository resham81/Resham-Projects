-- Resham Furqan
-- Final Assignment

-- commands I used
-- Part 2

-- to create the database
CREATE DATABASE film_festival;
USE film_festival;

-- to create the tables
SOURCE create_tables.sql;

-- to verify
SHOW TABLES;

-- to insert data into tables
SOURCE insert_data.sql;

-- to enable pager with better settings
PAGER less -SFX;

-- to verify
SELECT * FROM film_festival;
SELECT * FROM film;
SELECT * FROM nomination;
SELECT * FROM edition;
SELECT * FROM film_crew;
SELECT * FROM person;
SELECT * FROM country;
SELECT * FROM award_category;
SELECT * FROM film_production;

-- Part 3
-- level 1 queries

-- Query 1: To find recent award-winning films
SELECT f.title, f.release_year, ac.category_name, e.year as award_year
FROM nomination n
JOIN film f ON n.film_ID = f.film_ID
JOIN award_category ac ON n.category_ID = ac.category_ID
JOIN edition e ON n.edition_ID = e.edition_ID
WHERE n.status = 'Won'
AND e.year BETWEEN 2020 AND 2025
AND ac.level = 'Main'
ORDER BY e.year DESC, f.title;

-- Query 2: To help users find films by language and duration
SELECT title, release_year, language, duration,
CONCAT(FLOOR(duration / 60), 'h ', duration % 60, 'm') AS formatted_duration
FROM film
WHERE language LIKE '%English%'
AND duration BETWEEN 90 AND 180
AND release_year > 2000
ORDER BY duration DESC, release_year DESC;

-- Query 3: To find festivals by location and type
SELECT name, location, founding_year, festival_type,
CONCAT(name, ' - ', location) AS festival_location
FROM film_festival
WHERE festival_type IN ('International', 'National')
AND location IS NOT NULL
AND name IS NOT NULL
ORDER BY festival_type, country;

-- Query 4: To calculate ages of people and career duration
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

-- Level 2 Queries

-- Query 1: To analyze festival edition statistics
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

-- Query 2: To count nominations by festival
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

-- Query 3: To find award winners
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

-- Query 4: For role analysis of film crew
SELECT f.title, f.release_year, p.first_name, p.last_name,
fc.role, p.profession
FROM film_crew fc
JOIN film f ON fc.film_ID = f.film_ID
JOIN person p ON fc.person_ID = p.person_ID
WHERE fc.role IN ('Director', 'Producer', 'Actor')
AND f.title IS NOT NULL
ORDER BY f.release_year DESC, fc.role
LIMIT 20;

-- Part 4

-- run advanced features file
SOURCE advanced_features.sql;

-- test each of the features
SOURCE test_stored_procedure.sql;

SOURCE test_views.sql;

SOURCE test_triggers.sql;

SOURCE test_indexes.sql;


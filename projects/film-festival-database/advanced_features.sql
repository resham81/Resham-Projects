-- Resham Furqan
-- Final Assignment
-- 06/11/25

-- Implementation of advanced features in the database

USE film_festival;

-- Dropping existing procedures, views, triggers
DROP PROCEDURE IF EXISTS Get_festival_winners;
DROP PROCEDURE IF EXISTS Calculate_festival_statistics_with_cursor;
DROP TRIGGER IF EXISTS prevent_future_editions;
DROP TRIGGER IF EXISTS set_award_category_level;
DROP VIEW IF EXISTS festival_performance_overview;
DROP VIEW IF EXISTS international_co_productions;

-- Supporting table
CREATE TABLE IF NOT EXISTS category_audit(
    audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100),
    level_assigned VARCHAR(20),
    created_at DATETIME,
    created_by VARCHAR(50)
);

-- Stored Procedures
-- SP 1

DELIMITER //

CREATE  PROCEDURE Get_festival_winners(
    IN festival_name VARCHAR(100),
    IN award_year INT,
    IN category_filter VARCHAR(100)
)
BEGIN
    DECLARE festival_count INT;

    -- checking if festival exists using the aggregate func COUNT
    SELECT COUNT(*) INTO festival_count
    FROM film_festival
    WHERE name = festival_name;

    -- for error handling using IF_THEN_ELSE control structure
    IF festival_count = 0 THEN
        SELECT CONCAT('Festival "', festival_name, '" not found') AS error_message;
    ELSE
        -- retrieving the winners with optional category filter using the LIKE operator for pattern matching
        SELECT f.title AS film_title, CONCAT(p.first_name, ' ', p.last_name) AS winner_name, ac.category_name, ac.level AS award_level, e.year, ff.name AS festival_name,
        CASE
            WHEN n.is_unanimous = 1 THEN 'Unanimous'
            ELSE 'Majority'
        END AS decision_type
        FROM nomination n
        JOIN film f ON n.film_ID = f.film_ID
        LEFT JOIN person p ON n.person_ID = p.person_ID
        JOIN award_category ac ON n.category_ID = ac.category_ID
        JOIN edition e ON n.edition_ID = e.edition_ID
        JOIN film_festival ff ON e.festival_ID = ff.festival_ID
        WHERE ff.name = festival_name
            AND e.year = award_year
            AND n.status = 'Won'
            AND (category_filter IS NULL OR ac.category_name LIKE CONCAT('%', category_filter, '%'))
        ORDER BY ac.level, ac.category_name;
    END IF;
END //

-- SP 2
DELIMITER ;

DELIMITER //

CREATE PROCEDURE Calculate_festival_statistics_with_cursor(
    IN festival_id INT
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE ed_year INT;
    DECLARE ed_venue VARCHAR(100);
    DECLARE nom_count INT;
    DECLARE win_count INT;
    
    -- declaring a cursor for festival editions
    DECLARE edition_cursor CURSOR FOR 
        SELECT e.year, e.venue 
        FROM edition e 
        WHERE e.festival_ID = festival_id 
        ORDER BY e.year DESC;
    
    -- declaring NOT FOUND handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- creating a temporary table for results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_festival_stats (
        year INT,
        venue VARCHAR(100),
        nominations INT,
        wins INT,
        win_rate DECIMAL(5,2)
    );
    
    OPEN edition_cursor;
    
    edition_loop: LOOP
        FETCH edition_cursor INTO ed_year, ed_venue;
        IF done THEN
            LEAVE edition_loop;
        END IF;
        
        -- counting the nominations and wins for this edition
        SELECT 
            COUNT(*),
            SUM(CASE WHEN status = 'Won' THEN 1 ELSE 0 END)
        INTO nom_count, win_count
        FROM nomination n
        WHERE n.edition_ID IN (
            SELECT edition_ID FROM edition 
            WHERE festival_ID = festival_id AND year = ed_year
        );
        
        -- calculating the win rate
        INSERT INTO temp_festival_stats 
        VALUES (ed_year, ed_venue, nom_count, win_count, 
               CASE WHEN nom_count > 0 THEN ROUND((win_count * 100.0 / nom_count), 2) ELSE 0 END);
        
    END LOOP edition_loop;
    
    CLOSE edition_cursor;
    
    -- displaying results
    SELECT * FROM temp_festival_stats;
    
    -- cleaning up
    DROP TEMPORARY TABLE temp_festival_stats;
    
END //

DELIMITER ;

-- Triggers
-- T1

DELIMITER //

CREATE TRIGGER prevent_future_editions
BEFORE INSERT ON edition
FOR EACH ROW
    BEGIN
        DECLARE current_year INT;
        SET current_year = YEAR(CURDATE());

        -- using IF statement to check future years
        IF NEW.year > current_year THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot add festival editions for future years because the max allowed year is the current year';
    END IF;

        -- validating the date realtionships
        IF NEW.start_date > CURDATE() OR NEW.end_date > CURDATE() THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'The starting date of the festival must be before the ending date';
        END IF;
    END//
DELIMITER ;

-- T2
DELIMITER //
CREATE TRIGGER set_award_category_level
BEFORE INSERT ON award_category
FOR EACH ROW
    BEGIN
        DECLARE category_level VARCHAR(20);

        -- using the CASE statement to determine the category level
        CASE
            WHEN NEW.category_name LIKE '%Best%' OR NEW.category_name LIKE '%Grand%' OR NEW.category_name = 'Palme d''Or' THEN
                SET category_level = 'Main';
            WHEN NEW.category_name LIKE '%Special%' OR NEW.category_name LIKE '%Jury%' THEN
                SET category_level = 'Special';
            ELSE 
                SET category_level = 'Secondary';
        END CASE;

        SET NEW.level = category_level;
        
        -- logging the category creation
        INSERT INTO category_audit (category_name, level_assigned, created_at, created_by)
        VALUES (NEW.category_name, category_level,  NOW(), USER());
END //
DELIMITER ;

-- a supporting table for the trigger
CREATE TABLE category_audit(
    audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100),
    level_assigned VARCHAR(20),
    created_at DATETIME,
    created_by VARCHAR(50)
);


-- Views
-- Complex View 1
CREATE VIEW festival_performance_overview AS 
SELECT 
    ff.festival_ID, 
    ff.name AS festival_name, 
    ff.country, 
    ff.festival_type, 
    ff.founding_year,
    
    -- using date funcs to calculate date
    YEAR(CURDATE()) - ff.founding_year AS years_active,
    MIN(e.year) AS first_edition_year,
    MAX(e.year) AS latest_edition_year,
    COUNT(DISTINCT e.edition_ID) AS total_editions,
    COUNT(n.nomination_ID) AS total_nominations,
    SUM(CASE WHEN n.status = 'Won' THEN 1 ELSE 0 END) AS total_wins,
    
    -- using conditional logic foe complex calculations
    ROUND((SUM(CASE WHEN n.status = 'Won' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*),0)), 2) AS overall_win_rate,
    COUNT(DISTINCT n.film_ID) AS unique_films_nominated,
    COUNT(DISTINCT n.person_ID) AS unique_people_nominated,
    COUNT(DISTINCT fp.country_code) AS countries_represented,

    -- string aggreggation
    GROUP_CONCAT(DISTINCT ac.category_name ORDER BY ac.level SEPARATOR '; ') AS  award_categories_offered
FROM film_festival ff
LEFT JOIN edition e ON ff.festival_ID = e.festival_ID
LEFT JOIN nomination n ON e.edition_ID = n.edition_ID
LEFT JOIN film f ON n.film_ID = f.film_ID
LEFT JOIN film_production fp ON f.film_ID = fp.film_ID
LEFT JOIN award_category ac ON n.category_ID = ac.category_ID
GROUP BY ff.festival_ID, ff.name, ff.country, ff.festival_type, ff.founding_year
HAVING COUNT(DISTINCT e.edition_ID) > 0;

-- Complex View 2
CREATE VIEW international_co_productions AS
SELECT 
    c1.country_name AS primary_country,
    c2.country_name AS partner_country,
    COUNT(DISTINCT fp1.film_ID) AS co_production_count,
    GROUP_CONCAT(DISTINCT f.title SEPARATOR ' | ') AS co_production_films,
    ROUND(AVG(f.duration), 1) AS avg_duration,
    MIN(f.release_year) AS first_co_production_year,
    MAX(f.release_year) AS latest_co_production_year
FROM film_production fp1
JOIN film_production fp2 ON fp1.film_ID = fp2.film_ID
    AND fp1.country_code < fp2.country_code
JOIN country c1 ON fp1.country_code = c1.country_code
JOIN country c2 ON fp2.country_code = c2.country_code
JOIN film f ON fp1.film_ID = f.film_ID
GROUP BY c1.country_name, c2.country_name
HAVING co_production_count >= 1
ORDER BY co_production_count DESC;

-- Indexes

-- single column indexes for frequently searched columns
CREATE INDEX idx_nomination_status ON nomination(status);
CREATE INDEX idx_nomination_person ON nomination(person_ID);
CREATE INDEX idx_nomination_film ON nomination(film_ID);
CREATE INDEX idx_nomination_edition ON nomination(edition_ID);
CREATE INDEX idx_edition_festival ON edition(festival_ID);
CREATE INDEX idx_edition_year ON edition(year);
CREATE INDEX idx_film_release_year ON film(release_year);
CREATE INDEX idx_person_profession ON person(profession);
CREATE INDEX idx_festival_country ON film_festival(country);
CREATE INDEX idx_festival_type ON film_festival(festival_type);
CREATE INDEX idx_film_crew_role ON film_crew(role);
CREATE INDEX idx_film_production_role ON film_production(production_role);

-- composite indexes for common query patterns and join operations
CREATE INDEX idx_nomination_composite ON nomination(edition_ID, status, category_ID);
CREATE INDEX idx_edition_composite ON edition(festival_ID, year, start_date);
CREATE INDEX idx_film_crew_composite ON film_crew(film_ID, role, person_ID);
CREATE INDEX idx_festival_search ON film_festival(name, country, festival_type);
CREATE INDEX idx_person_name_composite ON person(last_name, first_name, profession);

-- indexes for text search and pattern matching
CREATE INDEX idx_film_title ON film(title);
CREATE INDEX idx_category_name ON award_category(category_name);
CREATE INDEX idx_festival_name ON film_festival(name);

-- indexes for date-based queries
CREATE INDEX idx_edition_dates ON edition(start_date, end_date);
CREATE INDEX idx_person_dob ON person(dob);




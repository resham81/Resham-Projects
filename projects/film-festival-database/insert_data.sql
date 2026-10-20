-- Resham Furqan
-- Final Assignment
-- 02/11/2025
-- This file inserts data into all the tables

USE film_festival;

-- Deleting data if it already exists in reverse because of FK
DELETE FROM film_production;
DELETE FROM film_crew;
DELETE FROM nomination;
DELETE FROM edition;
DELETE FROM award_category;
DELETE FROM film;
DELETE FROM person;
DELETE FROM country;
DELETE FROM film_festival;

-- reseting auto-increment counters
ALTER TABLE film_festival AUTO_INCREMENT = 1;
ALTER TABLE person AUTO_INCREMENT = 1;
ALTER TABLE film AUTO_INCREMENT = 1;
ALTER TABLE award_category AUTO_INCREMENT = 1;
ALTER TABLE edition AUTO_INCREMENT = 1;
ALTER TABLE nomination AUTO_INCREMENT = 1;

-- data taken from https://en.wikipedia.org/wiki/Palme_d%27Or and 
-- https://www.kaggle.com/datasets/unanimad/the-oscar-award 

-- country table
 
INSERT INTO country (country_code, region, country_name) VALUES
('USA', 'North America', 'United States'),
('ITA', 'Europe', 'Italy'),
('FRA', 'Europe', 'France'),
('GBR', 'Europe', 'United Kingdom'),
('DEU', 'Europe', 'Germany'),
('JPN', 'Asia', 'Japan'),
('KOR', 'Asia', 'South Korea'),
('IND', 'Asia', 'India'),
('MEX', 'North America', 'Mexico'),
('BRA', 'South America', 'Brazil'),
('ESP', 'Europe', 'Spain'),
('SWE', 'Europe', 'Sweden'),
('DNK', 'Europe', 'Denmark'),
('BEL', 'Europe', 'Belgium'),
('POL', 'Europe', 'Poland'),
('AUT', 'Europe', 'Austria'),
('TUR', 'Asia', 'Turkey'),
('IRN', 'Asia', 'Iran'),
('THA', 'Asia', 'Thailand'),
('CHN', 'Asia', 'China'),
('AUS', 'Oceania', 'Australia'),
('NZL', 'Oceania', 'New Zealand'),
('GRC', 'Europe', 'Greece'),
('ROU', 'Europe', 'Romania'),
('LUX', 'Europe', 'Luxembourg');

-- person table

INSERT INTO person (first_name, last_name, dob, profession, nationality, gender) VALUES
-- Oscars 1927/28
('Emil', 'Jannings', '1884-07-23', 'Actor', 'German', 'M'),
('Janet', 'Gaynor', '1906-10-06', 'Actress', 'American', 'F'),
('Richard', 'Barthelmess', '1895-05-09', 'Actor', 'American', 'M'),
('Louise', 'Dresser', '1878-10-05', 'Actress', 'American', 'F'),
('Gloria', 'Swanson', '1899-03-27', 'Actress', 'American', 'F'),
('Rochus', 'Gliese', '1899-01-06', 'Art Director', 'German', 'M'),
('William', 'Menzies', '1896-07-29', 'Art Director', 'American', 'M'),
('Harry', 'Oliver', '1888-04-04', 'Art Director', 'American', 'M'),
('George', 'Barnes', '1892-10-16', 'Cinematographer', 'American', 'M'),
('Charles', 'Rosher', '1885-11-17', 'Cinematographer', 'British', 'M'),
('Karl', 'Struss', '1886-11-30', 'Cinematographer', 'American', 'M'),
('Lewis', 'Milestone', '1895-09-30', 'Director', 'American', 'M'),
('Ted', 'Wilde', '1889-12-16', 'Director', 'American', 'M'),
('Frank', 'Borzage', '1893-04-23', 'Director', 'American', 'M'),
('Herbert', 'Brenon', '1880-01-13', 'Director', 'British', 'M'),
('King', 'Vidor', '1894-02-08', 'Director', 'American', 'M'),
('Ralph', 'Hammeras', '1894-06-24', 'Visual Effects', 'American', 'M'),
('Roy', 'Pomeroy', '1896-06-20', 'Visual Effects', 'American', 'M'),
('Nugent', 'Slaughter', '1888-05-17', 'Visual Effects', 'American', 'M'),
('Alfred', 'Cohn', '1880-03-26', 'Screenwriter', 'American', 'M'),
('Anthony', 'Coldeway', '1887-08-01', 'Screenwriter', 'American', 'M'),
('Benjamin', 'Glazer', '1887-05-07', 'Screenwriter', 'American', 'M'),
('Lajos', 'Biro', '1880-08-22', 'Screenwriter', 'Hungarian', 'M'),
('Ben', 'Hecht', '1894-02-28', 'Screenwriter', 'American', 'M'),
('Gerald', 'Duffy', '1896-01-01', 'Screenwriter', 'American', 'M'),
('Joseph', 'Farnham', '1884-12-09', 'Title Writer', 'American', 'M'),
('George', 'Marion Jr.', '1899-01-01', 'Title Writer', 'American', 'M'),
-- Palme d'Or Directors
('Roberto', 'Rossellini', '1906-05-08', 'Director', 'Italian', 'M'),
('Bong', 'Joon-ho', '1969-09-14', 'Director', 'South Korean', 'M'),
('Sean', 'Baker', '1971-02-26', 'Director', 'American', 'M'),
('Jafar', 'Panahi', '1960-07-11', 'Director', 'Iranian', 'M'),
('Francis', 'Coppola', '1939-04-07', 'Director', 'American', 'M'),
('Martin', 'Scorsese', '1942-11-17', 'Director', 'American', 'M'),
('Steven', 'Spielberg', '1946-12-18', 'Director', 'American', 'M'),
('Quentin', 'Tarantino', '1963-03-27', 'Director', 'American', 'M'),
('Ken', 'Loach', '1936-06-17', 'Director', 'British', 'M'),
('Michael', 'Haneke', '1942-03-23', 'Director', 'Austrian', 'M'),
('Ruben', 'Östlund', '1974-04-13', 'Director', 'Swedish', 'M'),
('Jane', 'Campion', '1954-04-30', 'Director', 'New Zealander', 'F'),
('Julia', 'Ducournau', '1983-11-18', 'Director', 'French', 'F'),
('Justine', 'Triet', '1978-07-17', 'Director', 'French', 'F'),
-- Oscars 2024/25
('Christopher', 'Nolan', '1970-07-30', 'Director', 'British', 'M'),
('Greta', 'Gerwig', '1983-08-04', 'Director', 'American', 'F'),
('Cillian', 'Murphy', '1976-05-25', 'Actor', 'Irish', 'M'),
('Robert', 'Downey Jr.', '1965-04-04', 'Actor', 'American', 'M'),
('Emma', 'Stone', '1988-11-06', 'Actress', 'American', 'F'),
('Da\'Vine', 'Randolph', '1986-05-21', 'Actress', 'American', 'F'),
('Adrien', 'Brody', '1973-04-14', 'Actor', 'American', 'M'),
('Timothée', 'Chalamet', '1995-12-27', 'Actor', 'American', 'M'),
('Kieran', 'Culkin', '1982-09-30', 'Actor', 'American', 'M');

-- award_category table

INSERT INTO award_category (category_name, level, description) VALUES
('BEST PICTURE', 'Main', 'Outstanding Picture or Production'),
('ACTOR IN A LEADING ROLE', 'Secondary', 'Best Performance by an Actor'),
('ACTRESS IN A LEADING ROLE', 'Secondary', 'Best Performance by an Actress'),
('DIRECTING', 'Main', 'Best Achievement in Directing'),
('CINEMATOGRAPHY', 'Secondary', 'Best Achievement in Cinematography'),
('ART DIRECTION', 'Secondary', 'Best Achievement in Art Direction'),
('VISUAL EFFECTS', 'Secondary', 'Best Achievement in Visual Effects'),
('WRITING (Original Screenplay)', 'Secondary', 'Best Original Screenplay'),
('WRITING (Adapted Screenplay)', 'Secondary', 'Best Adapted Screenplay'),
('PALME D\'OR', 'Main', 'Highest Prize at Cannes Film Festival'),
('GRAND PRIX', 'Main', 'Second Highest Prize at Cannes'),
('BEST DIRECTOR', 'Secondary', 'Best Director Prize at Cannes'),
('BEST ACTOR', 'Secondary', 'Best Performance by an Actor at Cannes'),
('BEST ACTRESS', 'Secondary', 'Best Performance by an Actress at Cannes'),
('JURY PRIZE', 'Special', 'Special Jury Prize'),
('SPECIAL AWARD', 'Special', 'Honorary or Special Recognition'),
('HONORARY PALME D\'OR', 'Special', 'Lifetime Achievement'),
('UNANIMOUS WIN', 'Special', 'Award given unanimously');

-- film_festivals table

INSERT INTO film_festival (name, website, country, location, founding_year, festival_type) VALUES
('Academy Awards (Oscars)', 'oscars.org', 'USA', 'Los Angeles', 1929, 'International'),
('Cannes Film Festival', 'festival-cannes.com', 'FRA', 'Cannes', 1946, 'International');

-- edition table

INSERT INTO edition (festival_ID, venue, start_date, end_date, year) VALUES
(1, 'Hollywood Roosevelt Hotel', '1929-05-16', '1929-05-16', 1928),
(1, 'Ambassador Hotel', '1930-04-03', '1930-04-03', 1929),
(1, 'Biltmore Hotel', '1931-11-10', '1931-11-10', 1930),
(2, 'Palais des Festivals', '1946-09-20', '1946-10-05', 1946),
(2, 'Palais des Festivals', '1947-09-12', '1947-09-27', 1947),
(2, 'Palais des Festivals', '1949-09-02', '1949-09-17', 1949),
(2, 'Palais des Festivals', '1955-04-25', '1955-05-10', 1955),
(2, 'Palais des Festivals', '1974-05-09', '1974-05-24', 1974),
(2, 'Palais des Festivals', '1979-05-10', '1979-05-24', 1979),
(2, 'Palais des Festivals', '1993-05-13', '1993-05-24', 1993),
(2, 'Palais des Festivals', '1994-05-12', '1994-05-23', 1994),
(2, 'Palais des Festivals', '2006-05-17', '2006-05-28', 2006),
(2, 'Palais des Festivals', '2016-05-11', '2016-05-22', 2016),
(2, 'Palais des Festivals', '2017-05-17', '2017-05-28', 2017),
(2, 'Palais des Festivals', '2019-05-14', '2019-05-25', 2019),
(2, 'Palais des Festivals', '2021-07-06', '2021-07-17', 2021),
(2, 'Palais des Festivals', '2022-05-17', '2022-05-28', 2022),
(2, 'Palais des Festivals', '2023-05-16', '2023-05-27', 2023),
(2, 'Palais des Festivals', '2024-05-14', '2024-05-25', 2024),
(2, 'Palais des Festivals', '2025-05-13', '2025-05-24', 2025),
(1, 'Dolby Theatre', '2023-03-12', '2023-03-12', 2023),
(1, 'Dolby Theatre', '2024-03-10', '2024-03-10', 2024),
(1, 'Dolby Theatre', '2025-03-02', '2025-03-02', 2025),
(1, 'Dolby Theatre', '2022-03-27', '2022-03-27', 2022),
(1, 'Union Station', '2021-04-25', '2021-04-25', 2021);

-- film table

INSERT INTO film (title, release_year, language, original_title, duration) VALUES
('Wings', 1927, 'English', NULL, 144),
('Sunrise', 1927, 'English', 'Sunrise: A Song of Two Humans', 94),
('The Noose', 1928, 'English', NULL, 65),
('The Patent Leather Kid', 1927, 'English', NULL, 150),
('The Last Command', 1928, 'English', NULL, 88),
('The Way of All Flesh', 1927, 'English', NULL, 94),
('A Ship Comes In', 1928, 'English', NULL, 70),
('7th Heaven', 1927, 'English', NULL, 110),
('Street Angel', 1928, 'English', NULL, 102),
('Sadie Thompson', 1928, 'English', NULL, 97),
('Parasite', 2019, 'Korean', '기생충', 132),
('Anora', 2024, 'English', NULL, 139),
('It Was Just an Accident', 2025, 'Persian', 'یک تصادف ساده', 115),
('Rome, Open City', 1945, 'Italian', 'Roma, città aperta', 103),
('The Shawshank Redemption', 1994, 'English', NULL, 142),
('The Godfather', 1972, 'English', NULL, 175),
('The Godfather Part II', 1974, 'English', NULL, 202),
('Forrest Gump', 1994, 'English', NULL, 142),
('The Green Mile', 1999, 'English', NULL, 189),
('Joker', 2019, 'English', NULL, 122),
('Pulp Fiction', 1994, 'English', NULL, 154),
('Schindler''s List', 1993, 'English', NULL, 195),
('Inception', 2010, 'English', NULL, 148),
('Fight Club', 1999, 'English', NULL, 139),
('The Silence of the Lambs', 1991, 'English', NULL, 118),
('The Good, the Bad and the Ugly', 1966, 'Italian', 'Il buono, il brutto, il cattivo', 161),
('Goodfellas', 1990, 'English', NULL, 146),
('One Flew Over the Cuckoo''s Nest', 1975, 'English', NULL, 133),
('12 Angry Men', 1957, 'English', NULL, 96),
('Seven Samurai', 1954, 'Japanese', '七人の侍', 207),
('Casablanca', 1942, 'English', NULL, 102),
('City Lights', 1931, 'English', NULL, 87),
('Psycho', 1960, 'English', NULL, 109),
('The Wizard of Oz', 1939, 'English', NULL, 102),
('Rear Window', 1954, 'English', NULL, 112),
('Sunset Boulevard', 1950, 'English', NULL, 110),
('Rebecca', 1940, 'English', NULL, 130),
('Citizen Kane', 1941, 'English', NULL, 119),
('The Third Man', 1949, 'English', NULL, 93),
('The Wages of Fear', 1953, 'French', 'Le salaire de la peur', 131),
('On the Waterfront', 1954, 'English', NULL, 108),
('Rebel Without a Cause', 1955, 'English', NULL, 111),
('North by Northwest', 1959, 'English', NULL, 136),
('The Apartment', 1960, 'English', NULL, 125),
('Lawrence of Arabia', 1962, 'English', NULL, 218),
('To Kill a Mockingbird', 1962, 'English', NULL, 129),
('The Great Escape', 1963, 'English', NULL, 172),
('The Sound of Music', 1965, 'English', NULL, 172),
('Cool Hand Luke', 1967, 'English', NULL, 126),
('Butch Cassidy and the Sundance Kid', 1969, 'English', NULL, 110),
('A Clockwork Orange', 1971, 'English', NULL, 136),
('The Sting', 1973, 'English', NULL, 129),
('Chinatown', 1974, 'English', NULL, 130),
('Jaws', 1975, 'English', NULL, 124),
('Star Wars', 1977, 'English', NULL, 121),
('The Deer Hunter', 1978, 'English', NULL, 183),
('Alien', 1979, 'English', NULL, 117),
('The Empire Strikes Back', 1980, 'English', NULL, 124),
('Raiders of the Lost Ark', 1981, 'English', NULL, 115),
('Return of the Jedi', 1983, 'English', NULL, 131),
('Amadeus', 1984, 'English', NULL, 160),
('The Terminator', 1984, 'English', NULL, 107),
('Platoon', 1986, 'English', NULL, 120),
('Stand by Me', 1986, 'English', NULL, 89),
('Full Metal Jacket', 1987, 'English', NULL, 116),
('The Princess Bride', 1987, 'English', NULL, 98),
('Rain Man', 1988, 'English', NULL, 133),
('My Neighbor Totoro', 1988, 'Japanese', 'となりのトトロ', 86),
('Dead Poets Society', 1989, 'English', NULL, 128);

-- film_production table

INSERT INTO film_production (film_ID, country_code, production_role) VALUES
((SELECT film_ID FROM film WHERE title = 'Parasite'), 'KOR', 'Producer'),
((SELECT film_ID FROM film WHERE title = 'Parasite'), 'USA', 'Distributor'),
((SELECT film_ID FROM film WHERE title = 'Anora'), 'USA', 'Producer'),
((SELECT film_ID FROM film WHERE title = 'It Was Just an Accident'), 'IRN', 'Producer'),
((SELECT film_ID FROM film WHERE title = 'It Was Just an Accident'), 'FRA', 'Co-Producer'),
((SELECT film_ID FROM film WHERE title = 'Rome, Open City'), 'ITA', 'Producer'),
((SELECT film_ID FROM film WHERE title = 'Wings'), 'USA', 'Producer'),
((SELECT film_ID FROM film WHERE title = 'Sunrise'), 'USA', 'Producer'),
((SELECT film_ID FROM film WHERE title = 'The Shawshank Redemption'), 'USA', 'Producer'),
((SELECT film_ID FROM film WHERE title = 'The Godfather'), 'USA', 'Producer');

-- film_crew table

INSERT INTO film_crew (film_ID, person_ID, role) VALUES
((SELECT film_ID FROM film WHERE title = 'Parasite'), (SELECT person_ID FROM person WHERE first_name = 'Bong' AND last_name = 'Joon-ho'), 'Director'),
((SELECT film_ID FROM film WHERE title = 'Anora'), (SELECT person_ID FROM person WHERE first_name = 'Sean' AND last_name = 'Baker'), 'Director'),
((SELECT film_ID FROM film WHERE title = 'It Was Just an Accident'), (SELECT person_ID FROM person WHERE first_name = 'Jafar' AND last_name = 'Panahi'), 'Director'),
((SELECT film_ID FROM film WHERE title = 'Rome, Open City'), (SELECT person_ID FROM person WHERE first_name = 'Roberto' AND last_name = 'Rossellini'), 'Director'),
((SELECT film_ID FROM film WHERE title = 'The Godfather'), (SELECT person_ID FROM person WHERE first_name = 'Francis' AND last_name = 'Coppola'), 'Director'),
((SELECT film_ID FROM film WHERE title = 'Schindler''s List'), (SELECT person_ID FROM person WHERE first_name = 'Steven' AND last_name = 'Spielberg'), 'Director'),
((SELECT film_ID FROM film WHERE title = 'Pulp Fiction'), (SELECT person_ID FROM person WHERE first_name = 'Quentin' AND last_name = 'Tarantino'), 'Director'),
((SELECT film_ID FROM film WHERE title = 'Inception'), (SELECT person_ID FROM person WHERE first_name = 'Christopher' AND last_name = 'Nolan'), 'Director');

-- nomination table

-- getting the actual IDs that were auto-generated
-- then using subqueries to get the correct IDs

INSERT INTO nomination (film_ID, edition_ID, person_ID, category_ID, is_unanimous, status) VALUES
-- Film: Wings, Person: Emil Jannings
(1, 1, (SELECT person_ID FROM person WHERE first_name = 'Emil' AND last_name = 'Jannings'), 1, FALSE, 'Won'),
-- Film: 7th Heaven, Person: Janet Gaynor  
(8, 1, (SELECT person_ID FROM person WHERE first_name = 'Janet' AND last_name = 'Gaynor'), 3, TRUE, 'Won'),
-- Film: Rome, Open City, Person: Roberto Rossellini
(14, 4, (SELECT person_ID FROM person WHERE first_name = 'Roberto' AND last_name = 'Rossellini'), 10, TRUE, 'Won'),
-- Film: Parasite, Person: Bong Joon-ho
(11, 15, (SELECT person_ID FROM person WHERE first_name = 'Bong' AND last_name = 'Joon-ho'), 10, TRUE, 'Won'),
-- Film: Anora, Person: Sean Baker
(12, 19, (SELECT person_ID FROM person WHERE first_name = 'Sean' AND last_name = 'Baker'), 10, TRUE, 'Won'),
-- Film: It Was Just an Accident, Person: Jafar Panahi
(13, 20, (SELECT person_ID FROM person WHERE first_name = 'Jafar' AND last_name = 'Panahi'), 10, TRUE, 'Won'),
-- Film-only awards (person_ID is NULL)
(16, 21, NULL, 1, TRUE, 'Won'),  -- The Godfather
(15, 22, NULL, 1, TRUE, 'Won'),  -- The Shawshank Redemption  
(21, 23, NULL, 1, TRUE, 'Won'),  -- Pulp Fiction
(18, 24, NULL, 1, TRUE, 'Won'),  -- Forrest Gump
(23, 25, NULL, 1, TRUE, 'Won');  -- Inception


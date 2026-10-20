-- Resham Furqan
-- Final Assignment
-- 02/11/2025
-- this file creates all database tables with constraints

-- Creating the Database
DROP DATABASE IF EXISTS film_festival;
CREATE DATABASE IF NOT EXISTS film_festival;
USE film_festival;

-- Drop tables (if exists) in reverse order to handle the FK
DROP TABLE IF EXISTS film_production;
DROP TABLE IF EXISTS film_crew;
DROP TABLE IF EXISTS nomination;
DROP TABLE IF EXISTS edition;
DROP TABLE IF EXISTS award_category;
DROP TABLE IF EXISTS film;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS film_festival;

-- Creating the Tables
CREATE TABLE film_festival(
    festival_ID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    website VARCHAR(200),
    country VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    founding_year INT NOT NULL,
    festival_type VARCHAR(20) NOT NULL,
    CHECK (founding_year > 1900)
);

CREATE TABLE country(
    country_code CHAR(3) PRIMARY KEY,
    region VARCHAR(50),
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE person(
    person_ID INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE,
    profession VARCHAR(100),
    nationality VARCHAR(50),
    gender VARCHAR(10) NOT NULL
);

CREATE TABLE film(
    film_ID INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    release_year INT NOT NULL,
    language VARCHAR(50),
    original_title VARCHAR(200),
    duration INT,
    CHECK (release_year > 1900),
    CHECK (duration > 0)
);

CREATE TABLE award_category(
    category_ID INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    level VARCHAR(20) NOT NULL,
    description TEXT,
    CHECK (level IN('Main', 'Secondary', 'Special'))
);

CREATE TABLE edition(
    edition_ID INT PRIMARY KEY AUTO_INCREMENT,
    festival_ID INT NOT NULL,
    venue VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    year INT NOT NULL,
    FOREIGN KEY (festival_ID) REFERENCES film_festival(festival_ID),
    CHECK (year > 1900),
    CHECK (start_date <= end_date)
);

CREATE TABLE nomination(
    nomination_ID INT PRIMARY KEY AUTO_INCREMENT,
    film_ID INT NOT NULL,
    edition_ID INT NOT NULL,
    person_ID INT,
    category_ID INT NOT NULL,
    is_unanimous BOOLEAN DEFAULT FALSE,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (film_ID) REFERENCES film(film_ID),
    FOREIGN KEY (edition_ID) REFERENCES edition(edition_ID),
    FOREIGN KEY (person_ID) REFERENCES person(person_ID),
    FOREIGN KEY (category_ID) REFERENCES award_category(category_ID),
    CHECK (status IN('Nominated', 'Won'))
);

-- Tables to resolve M:N Relationships
CREATE TABLE film_crew(
    film_ID INT NOT NULL,
    person_ID INT NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (film_ID, person_ID, role),
    FOREIGN KEY (film_ID) REFERENCES film(film_ID),
    FOREIGN KEY (person_ID) REFERENCES person(person_ID)
);

CREATE TABLE film_production(
    film_ID INT NOT NULL,
    country_code CHAR(3) NOT NULL,
    production_role VARCHAR(50) NOT NULL,
    PRIMARY KEY (film_ID, country_code, production_role),
    FOREIGN KEY (film_ID) REFERENCES film(film_ID),
    FOREIGN KEY (country_code) REFERENCES country(country_code)
);



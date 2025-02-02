#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## INTRODUCTION TO SQL PART4 ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 7: IN - non-correlated subquery  ####
USE world;

-- Find all the countries that speak both English and Spanish.
SELECT DISTINCT countrycode FROM countrylanguage -- outer query attribute select
WHERE Language = 'English'                       -- outer query condition   
AND                                              -- combine outer and inner query using and
countrycode IN                                   -- check set membership using IN
(SELECT countrycode FROM countrylanguage         -- inner query attribute select      
WHERE Language = 'Spanish');                     -- inner query condition


#=================================================-
#### Slide 8: NOT IN - non-correlated subquery  ####

-- Find all the countries that speak English, but not Spanish.
SELECT DISTINCT countrycode FROM countrylanguage -- outer query attribute select
WHERE Language = 'English'                       -- outer query condition   
AND                                              -- combine outer and inner query using and
countrycode NOT IN                               -- check set membership using NOT IN
(SELECT countrycode FROM countrylanguage         -- inner query attribute select      
WHERE Language = 'Spanish');                     -- inner query condition


#=================================================-
#### Slide 10: ALL - non-correlated subquery  ####

-- Find the names of all cities whose population is greater than 
-- that of all cities of the USA.
SELECT name FROM city WHERE                              -- select attributes of outer query
population > ALL                                         -- comparison
(SELECT population FROM city WHERE countrycode = 'USA'); -- inner query selection


#================================================= -
#### Slide 11: SOME or ANY - non-correlated subquery  ####

-- Find the official languages of the country.
-- Use subquery approach to write the query.
SELECT Language, countrycode FROM countrylanguage               -- outer query
WHERE language = ANY                                            -- set comparison
(SELECT Language FROM countrylanguage WHERE IsOfficial = 'T');  -- inner query


#=================================================-
#### Slide 12: EXISTS - correlated subquery  ####

-- Find all the countries that speak both English and Spanish.
SELECT countrycode FROM countrylanguage AS A  -- select countrycode in outer query
WHERE language = 'English'                    -- where the language is English
AND EXISTS                                    -- correlate the subquery using exists
(SELECT * FROM countrylanguage AS B           -- inner query selects all attributes
WHERE language = 'Spanish' AND                -- where language is Spanish   
A.countrycode = B.countrycode);               -- combine using the join


#=================================================-
#### Slide 13: NOT EXISTS - correlated subquery  ####

-- Find all the countries that speak English, but not Spanish.
SELECT countrycode FROM countrylanguage AS A  -- select countrycode in outer query
WHERE language = 'English'                    -- where the language is English
AND NOT EXISTS                                -- correlate the subquery using not exist
(SELECT * FROM countrylanguage AS B           -- inner query selects all attributes
WHERE language = 'Spanish' AND                -- where language is Spanish   
A.countrycode = B.countrycode);               -- combine using the join


#=================================================-
#### Slide 14: Other types of correlated subquery  ####

-- Find all the countries that speak fewer than two languages.
SELECT c.name FROM country AS c WHERE                  -- outer query
(SELECT COUNT(cl.language) FROM countrylanguage AS cl  -- inner query
WHERE c.code = cl.countrycode) < 2;                    -- correlate the query using join


#=================================================-
#### Slide 15: Subquery in SELECT clause  ####

-- Find the difference in a city's population from the maximum populated city of the city table.
-- Arrange by the population difference.
SELECT Name, population,                          -- select attributes
((SELECT MAX(population) FROM city) - population) -- subquery in select clause
AS population_difference FROM city                -- column alias 
order by population_difference;                   -- order by population difference


#=================================================-
#### Slide 16: Subquery in FROM clause  ####

-- Find the number of languages spoken in each country.
SELECT c.code, c.name, cl.Number_of_languages        -- select attributes
FROM country AS c                                    -- outerquery table alias
INNER JOIN                                           -- join the tables
(SELECT countrycode, COUNT(*) AS Number_of_languages -- inner query
FROM countrylanguage                                 -- inner query table           
GROUP BY countrycode)                                -- group by countrycode
AS cl                                                -- inner query table alias for referencing
ON c.code = cl.countrycode;                          -- join on country code


#=================================================-
#### Slide 19: Exercise 1  ####




#=================================================-
#### Slide 22: CREATE OR REPLACE VIEW  ####

-- Create a view of country name, surface area, population, and official language. 
use world;
CREATE VIEW Independent_Country_Details(country_name, country_area, -- name the view
country_population,  country_official_language) AS                  -- select attributes
SELECT c.Name, c.surfaceArea, c.population, cl.language             -- select values from base table
FROM country AS c, countrylanguage AS cl                            -- base tables alias
WHERE cl.isOfficial = 'T' and cl.countrycode = c.code;              -- base table condition

-- Update the independent_country_details by removing surface area, and population.
-- Add a single column called population per area.

CREATE OR REPLACE VIEW Independent_Country_Details                         -- view name
(country_name, country_population_per_area, country_official_language) AS  -- view attributes
SELECT c.Name, (c.population/c.surfaceArea), cl.language                   -- select attributes
FROM country AS c, countrylanguage AS cl                                   -- base table alias   
WHERE cl.isOfficial = 'T' and cl.countrycode = c.code;                     -- base table condition


#=================================================-
#### Slide 23: SELECT - Display View Data  ####

-- Select from a view.
SELECT * FROM Independent_Country_Details;


#=================================================-
#### Slide 25: UPDATE & DROP  ####

-- Update the language of Albania to English/Albanian.

UPDATE Independent_Country_Details                    -- update the view
SET country_official_language =  'English/Albanian'   -- set the value
WHERE country_name = 'Albania';                       -- condition for set
-- Delete the view Independent_Country_Details.

DROP VIEW Independent_Country_Details;


#=================================================-
#### Slide 28: CREATE, SHOW, and DROP INDEX  ####

-- Add country name as an index to the country table.
ALTER TABLE country ADD INDEX country_name_idx(name); -- add an index
-- Display the index.
SHOW INDEX FROM country;  -- show the index
-- Drop the index on the country table.
ALTER TABLE country DROP INDEX country_name_idx; -- drop the index


#=================================================-
#### Slide 31: Transaction Control Example  ####

-- Start a transaction and update Latin as one of the languages in USA with 0.1%.
-- Update Greek as another language spoken with 0.02%.
-- Now we found that Greek language information is false, so rollback to the previous change.

SET AUTOCOMMIT = 0;                                           -- set the autocommit to 0
START TRANSACTION;                                            -- begin a transaction
SAVEPOINT my_savepoint;                                       -- check a savepoint
INSERT INTO countrylanguage VALUES('USA', 'Latin', 'F', 0.1); -- insert a row into countrylanguage
SAVEPOINT after_latin_addition_savepoint;                     -- check a savepoint
INSERT INTO countrylanguage VALUES('USA', 'Greek', 'F', 0.02);-- insert another row
ROLLBACK TO SAVEPOINT after_latin_addition_savepoint;         -- rollback to the previous savepoint
COMMIT;                                                       -- commit the work


#=================================================-
#### Slide 34: Exercise 2  ####




#=================================================-
#### Slide 37: SHOW DATABASES  ####

-- View all databases.
SHOW DATABASES;


#=================================================-
#### Slide 38: SHOW TABLES & COLUMNS  ####

-- Show tables from a specific database.
SHOW TABLES FROM world;
-- Show columns from a table.
SHOW COLUMNS FROM city;


#=================================================-
#### Slide 39: Information_schema Database  ####

-- Show tables from a database.
SHOW TABLES FROM INFORMATION_SCHEMA;
-- Show columns from a table.
SHOW COLUMNS FROM INFORMATION_SCHEMA.tables;


#=================================================-
#### Slide 40: Information_schema Database  ####

-- Show information about tables in world database.
SELECT table_name, table_type      -- select table name and type
FROM INFORMATION_SCHEMA.tables     -- from the `tables` table of information schema
WHERE table_schema = 'world';      -- from the world database


#=================================================-
#### Slide 45: Stored procedures  ####

-- Call newly created stored procedure.
CALL Show_US_city;


#=================================================-
#### Slide 48: Exercise 3  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################

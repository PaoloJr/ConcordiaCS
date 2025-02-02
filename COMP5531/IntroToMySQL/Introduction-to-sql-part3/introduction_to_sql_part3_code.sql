#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## INTRODUCTION TO SQL PART3 ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 1: Warm up   ####

SELECT * FROM users WHERE clue > 0
0 rows returned


#=================================================-
#### Slide 7: Create database and import data  ####

-- Create a new database transaction.
CREATE SCHEMA shipping;
-- Switch to shipping database.
USE shipping;


#=================================================-
#### Slide 8: INNER JOIN  ####

SELECT cu.customer_id AS customer_customer_id,             -- select customer_id from customer
cu.customer_name, cu.customer_city,                        -- select attributes from customer
o.customer_id AS orders_customer_id,                       -- select customer_id from orders
o.orders_id, o.item_id                                     -- select attributes from orders
FROM customer AS cu                                        -- alias customer as cu
INNER JOIN orders AS o ON cu.customer_id = o.customer_id;  -- perform inner join, alias orders, and 
                                                           -- specify joining attribute


#=================================================-
#### Slide 9: LEFT OUTER JOIN  ####

SELECT cu.customer_id AS customer_customer_id,           -- select customer_id from customer
cu.customer_name, cu.customer_city,                      -- select attributes from customer
o.customer_id AS orders_customer_id,                     -- select customer_id from orders
o.orders_id, o.item_id                                   -- select attributes from orders
FROM customer AS cu                                      -- alias customer as cu
LEFT JOIN orders AS o ON cu.customer_id = o.customer_id; -- perform left join alias orders and
                                                         -- define joining attribute


#=================================================-
#### Slide 10: RIGHT OUTER JOIN  ####

SELECT cu.customer_id AS customer_customer_id,             -- select customer_id from customer
cu.customer_name, cu.customer_city,                        -- select attributes from customer
o.customer_id AS orders_customer_id,                       -- select customer_id from orders
o.orders_id, o.item_id                                     -- select attributes from orders
FROM customer AS cu                                        -- alias customer as cu
RIGHT JOIN orders AS o ON cu.customer_id = o.customer_id;  -- perform right join, alias orders and
                                                           -- define joining attribute


#=================================================-
#### Slide 12: ANSI join syntax - cont'd  ####

-- Fetch the country name and the language spoken from the world database using right join.
-- We will use CountryCode in countrylanguage table
-- and Code in country table as the common joining attribute.
USE world;
SELECT cl.CountryCode, c.Name, cl.Language    -- refer the attributes using the alias name
FROM country AS c,                            -- country table is aliased as c
countrylanguage AS cl                         -- country language aliased as cl
WHERE cl.CountryCode = c.Code;                -- join on the country code


#=================================================-
#### Slide 13: Joining more than two tables  ####

-- Fetch the city name, country name and the language spoken in each city.
-- We will use country code as the common joining attribute.
SELECT ci.Name, co.Name, cl.Language          -- selecting attributes
FROM city AS ci, country AS co,               -- aliased tables
countrylanguage AS cl                         -- aliased tables
WHERE ci.CountryCode = co.Code                -- join countrycode of city and country
AND co.Code = cl.CountryCode;                 -- join countrycode of country and countrylanguage


#=================================================-
#### Slide 14: SELF JOIN  ####

-- Fetch two cities of the same country.
SELECT a.Name AS city_1,              -- select 1st city name
b.Name AS city_2,                     -- select 2nd city name
a.CountryCode                         -- select the country code
FROM city a, city b                   -- alias the table name
WHERE a.CountryCode = b.CountryCode;  -- join on countrycode


#=================================================-
#### Slide 15: Equi and non-equi join  ####

-- Select a list of two cities from two different countries.
SELECT c1.Name AS city_1, c1.CountryCode as country_1,   -- city 1 details
c2.Name as city_2, c2.CountryCode as country_2           -- city 2 details
FROM city c1 INNER JOIN city c2                          -- self join statement
ON c1.CountryCode != c2.CountryCode;                     -- non equi join using !=


#=================================================-
#### Slide 19: UNION  ####

-- Select the code from the country and countrycode from countrylanguage

SELECT code from country                    -- first dataset
UNION                                       -- union operation
SELECT CountryCode from countrylanguage;    -- second dataset


#=================================================-
#### Slide 21: Exercise 1  ####




#=================================================-
#### Slide 24: LENGTH & CONCAT  ####

-- Find the string length in language
-- from CountryLanuage table.
SELECT Language, LENGTH(Language) AS 
length_language FROM countrylanguage;
-- Concatenate Name and District as location from 
-- the city table with a separator '-'.
SELECT ID, CONCAT_WS("-", Name, District) AS 
location, countrycode FROM city;


#=================================================-
#### Slide 25: SUBSTR & LOCATE  ####

-- Select the first three letters of the region
-- as the region_code from the country table.
SELECT SUBSTR(region, 1, 3) 
AS region_code FROM country;
-- Locate the position of letter 'a' from 
-- the district column in the city table.
SELECT LOCATE('a', district) 
AS position_of_a, district FROM city;


#=================================================-
#### Slide 27: LIKE  ####

-- Select all the data from the city table 
-- where the District starts with 
-- letter 'K'.
SELECT * FROM city WHERE District LIKE 'K%';
-- Select all the data from the city table 
-- where the District has second letter as 
-- 'u' and end with the letter 't'.
SELECT * FROM city WHERE District LIKE '_u%t';


#=================================================-
#### Slide 29: MOD & POW  ####

-- Divide the population by 10 and fetch 
-- the remainder as population_rem_10.
SELECT MOD(population, 10) 
AS population_rem_10, population FROM city;
-- Find the cube of the surface area 
-- of the country as Surface_area_cube.
SELECT POW(SurfaceArea, 3) 
AS Surface_area_cube, SurfaceArea FROM country;


#=================================================-
#### Slide 30: TRUNCATE & ROUND  ####

-- Find gnp divided by 1000 and 
-- truncate to 2 decimal places.
SELECT TRUNCATE(GNP / 1000, 2), GNP from country;
-- Divide gnp by 1000 and round off 
-- to 2 decimal places.
SELECT ROUND(GNP / 1000, 2), GNP from country;


#=================================================-
#### Slide 33: CURDATE & ADDTIME  ####

-- Get current date and display
-- as Today_date.
SELECT CURDATE() AS Today_date;
-- Add 2 hours, 10 minutes and 20 seconds 
-- to the current time.
SELECT CURRENT_TIMESTAMP() 
AS time_now, 
ADDTIME(CURRENT_TIMESTAMP(), "2:10:20") 
AS new_time;


#=================================================-
#### Slide 34: DATEDIFF & LASTDAY  ####

-- Find number of days between September 12th 
-- 2018 and May 12th 2017.
SELECT DATEDIFF("2018-09-12", "2017-05-12") 
AS date_difference;
-- Extract the day part from 
-- '2018-05-11 22:12:29'.
SELECT EXTRACT(DAY FROM '2019-05-11 22:12:29') 
AS day;


#=================================================-
#### Slide 37: MIN & MAX  ####

-- Find the minimum life expectancy 
-- from the country table.
SELECT MIN(lifeexpectancy) 
AS least_life  FROM country;
-- Find the maximum life expectancy 
-- from the country table.
SELECT MAX(lifeexpectancy) 
AS max_life  FROM country;


#=================================================-
#### Slide 38: AVG & SUM  ####

-- Find the average life expectancy 
-- from the country table.
SELECT AVG(lifeexpectancy) 
AS average_life  FROM country;
-- Find the total population 
-- across all cities.
SELECT SUM(population) 
AS total_population FROM city;


#=================================================-
#### Slide 39: COUNT  ####

-- Find the number of countries who got their independence.
SELECT COUNT(indepyear) AS number_independent_countries FROM country;
-- Find  the distinct number of indepyear from the country table.
SELECT COUNT(DISTINCT indepyear) AS number_distinct_indepyear FROM country;


#=================================================-
#### Slide 40: Using expressions  ####

-- Find  the maximum difference between the gnpold and gnp in the country table.
SELECT MAX(GNPOld - GNP) from country;


#=================================================-
#### Slide 42: GROUP BY  ####

-- Find the least population of a city for each country.
SELECT MIN(population) AS least_population, countrycode FROM city -- select attributes
GROUP BY CountryCode;                                             -- group by countrycode


#=================================================-
#### Slide 43: GROUP BY - multi column grouping  ####

-- Find the number of cities in each district in each country.
SELECT CountryCode, District,     -- select the attributes
count(Name) FROM city             -- find the count                     
GROUP BY countrycode, district;   -- group by district and countrycode


#=================================================-
#### Slide 44: GROUP BY - ROLLUP  ####

SELECT CountryCode, District,                -- select the attributes
COUNT(Name) FROM city                        -- find count of cities
GROUP BY countrycode, district WITH ROLLUP;  -- use rollup to find grand total


#=================================================-
#### Slide 45: GROUP BY - expression  ####

-- Find the number of countries who have the same GNP difference.
SELECT (GNP-GNPOld) AS GNP_Diff,    -- gnp difference expression
COUNT(*) Total_number FROM country  -- count number of countries
GROUP BY (GNP-GNPOld);              -- group by gnp difference     


#=================================================-
#### Slide 46: GROUP BY & HAVING - filter groups  ####

-- Find the least populated city from each country;
-- ignore if the population is less than 30000
SELECT MIN(population), name, countrycode  -- select the attributes
FROM city GROUP BY countrycode, name       -- group by countrycode, name
HAVING MIN(population) > 30000;            -- filter out if population is less than 30000


#=================================================-
#### Slide 48: Example of a complex query  ####

-- Find the number of unofficial languages for each country and arrange them in descending order.
-- Remove the entry if the number of unofficial languages is one.
SELECT COUNT(language), countrycode  -- select count of the languages
FROM countrylanguage                 -- from the table countrylanguage
WHERE IsOfficial != 'T'              -- filter out if the language is official
GROUP BY countrycode                 -- group by country
HAVING COUNT(language) > 1           -- remove if number is just one
ORDER BY COUNT(language) DESC;       -- order by the count


#=================================================-
#### Slide 50: Exercise 2  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################

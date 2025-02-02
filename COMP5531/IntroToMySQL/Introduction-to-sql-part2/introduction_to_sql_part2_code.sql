#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## INTRODUCTION TO SQL PART2 ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 7: DESC  ####

DESC university.course;


#=================================================-
#### Slide 8: CREATE TABLE  ####

USE university;                                  -- define database to avoid referencing everytime

CREATE TABLE faculty                                   -- table name
(faculty_id INT(10),                                   -- column 1 - faculty id
faculty_name VARCHAR(20),                              -- column 2 - faculty_name
course_id INT(11),                                     -- column 3 - course_id 
CONSTRAINT pk_faculty PRIMARY KEY(faculty_id),         -- define primary key
CONSTRAINT fk_faculty_course_id FOREIGN KEY(course_id) -- define foreign key
REFERENCES course(course_id)                           -- referencing table
);

DESC faculty;


#=================================================-
#### Slide 9: INSERT  ####

INSERT INTO course       -- table name
(course_id, course_name) -- column/attributes name
VALUES (011, "DBMS"), (012, "Operating Systems"), (015, "Data Science");    -- values to the attributes


#=================================================-
#### Slide 10: SELECT  ####

SELECT * from course; -- * to view all the data in table


#=================================================-
#### Slide 13: UPDATE  ####

UPDATE course                                    -- update the table 
SET course_name = "Database Management Systems"  -- set new value
WHERE course_id = 011;                           -- condition to set the data


#=================================================-
#### Slide 15: ALTER TABLE - ADD  ####

ALTER TABLE faculty   -- table name
ADD dateofBirth DATE; -- add new column 'dateofBirth'
DESC faculty;


#=================================================-
#### Slide 16: ALTER TABLE - MODIFY & DROP  ####

ALTER TABLE faculty      -- table name
MODIFY dateofBirth YEAR; -- alter 'dateofBirth'
                         --  date to year type
DESC faculty;
ALTER TABLE faculty      -- table name
DROP COLUMN dateofBirth; -- delete column 
                         --   'dateofBirth'
DESC faculty;


#=================================================-
#### Slide 17: DELETE - data  ####

SELECT * from course;
DELETE FROM course WHERE course_id = 12;


#=================================================-
#### Slide 18: DELETE - table & column  ####

DELETE FROM course;
DROP TABLE faculty;  -- child table having course_id as foreign key
DROP TABLE course;   -- parent table


#=================================================-
#### Slide 21: Exercise 1  ####




#=================================================-
#### Slide 30: SELECT & FROM  ####

-- Switch to world database for convenience
USE world;

-- To select all data, use * operator
SELECT * FROM city;
-- To select specific columns.
SELECT Name, Population FROM city;


#=================================================-
#### Slide 31: SELECT & FROM  ####

SELECT ID,             -- select ID
'City_population',     -- add a new column with value City_population
Population/100,        -- divide the population column by 100
LOWER(CountryCode)     -- convert the country code column to lower case
FROM city;


#=================================================-
#### Slide 32: DISTINCT  ####

SELECT Language FROM countrylanguage;

-- Returns 984 rows
SELECT DISTINCT Language FROM countrylanguage;

-- Returns 457 rows


#=================================================-
#### Slide 33: AS  ####

SELECT ci.Name AS city_name,   -- alias column name as city_name
ci.District AS city_district   -- alias column district as city_district
FROM city AS ci;               -- alias table city as ci   


#=================================================-
#### Slide 35: WHERE  ####

-- Select all data from 'countrylanguage' table where the language is official to the country and 
-- the percentage spoken is greater than 70%.
SELECT * FROM countrylanguage -- table name
  WHERE                       -- WHERE clause to filter
  IsOfficial = 'T'            -- equality condition '='
  AND                         -- logical condition 'AND'
  Percentage > 70;            -- comparison condition '>'


#=================================================-
#### Slide 36: WHERE  ####

-- Select name and population of the cities where population is between 180000 and 190000.

SELECT Name, Population FROM city           
WHERE population BETWEEN 180000 AND 190000; 
-- Select all the data from countrylanguage of three countries USA, Australia, and India.

SELECT * FROM countrylanguage                 
WHERE CountryCode IN ('USA', 'AUS', 'IND'); 


#=================================================-
#### Slide 37: ORDER BY  ####

-- Select all data from the 'city' table order by population in ascending order.

SELECT * FROM city
  ORDER BY Population; 
-- Select all data from the 'city' table order by population in descending order.

SELECT * FROM city
  ORDER BY Population 
  DESC;              


#=================================================-
#### Slide 39: NULL  ####

-- Select Name and IndepYear from country 
-- where IndepYear is null.
SELECT Name, IndepYear FROM country 
WHERE IndepYear IS NULL;
-- Select Name and IndepYear from country 
-- where IndepYear is  not null.
SELECT Name, IndepYear FROM country 
WHERE IndepYear IS NOT NULL;


#=================================================-
#### Slide 41: Exercise 2  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################

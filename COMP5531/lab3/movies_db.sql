CREATE DATABASE IF NOT EXISTS movies;

USE movies;

CREATE TABLE IF NOT EXISTS actors (
    aid INT PRIMARY KEY,
    name VARCHAR(50),
    gender CHAR(1)
);

CREATE TABLE IF NOT EXISTS directors (
    did INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS movies (
    mid INT PRIMARY KEY,
    title VARCHAR(100),
    year INT,
    runtime INT,
    did INT, 
    FOREIGN KEY (did) REFERENCES directors(did)
);

CREATE TABLE IF NOT EXISTS casts (
    aid INT,
    mid INT,
    PRIMARY KEY (aid, mid),
    FOREIGN KEY (aid) REFERENCES actors(aid),
    FOREIGN KEY (mid) REFERENCES movies(mid)
);

INSERT INTO actors (aid, name, gender) VALUES (1, 'Marsh', 'M');
INSERT INTO actors (aid, name, gender) VALUES (2, 'Christen', 'F');
INSERT INTO actors (aid, name, gender) VALUES (3, 'Zara', 'F');
INSERT INTO actors (aid, name, gender) VALUES (4, 'Quintana', 'F');
INSERT INTO actors (aid, name, gender) VALUES (5, 'Randi', 'M');
INSERT INTO actors (aid, name, gender) VALUES (6, 'Roxanne', 'F');
INSERT INTO actors (aid, name, gender) VALUES (7, 'Humphrey Bogart', 'M');
INSERT INTO actors (aid, name, gender) VALUES (8, 'Anthiathia', 'F');
INSERT INTO actors (aid, name, gender) VALUES (9, 'Ernestus', 'M');

INSERT INTO directors (did, name) VALUES (1, 'Oralee');
INSERT INTO directors (did, name) VALUES (2, 'Billy Wilder');
INSERT INTO directors (did, name) VALUES (3, 'Erhard');
INSERT INTO directors (did, name) VALUES (4, 'Star');
INSERT INTO directors (did, name) VALUES (5, 'Cory');

INSERT INTO movies (mid, title, year, runtime, did) VALUES (1, 'Please Remove Your Shoes ', 1925, 93, 5);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (2, 'Corto Maltese', 1988, 99, 3);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (3, 'Tenderness', 2008, 125, 1);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (4, 'Anotherworld', 1975, 145, 5);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (5, 'Southland Tales', 1964, 98, 2);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (6, 'Lottery', 2008, 121, 3);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (7, 'Gladiator', 2006, 134, 1);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (8, 'Beverly Hills Chihuahua', 1939, 122, 2);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (9, 'Possessed', 1941, 135, 5);
INSERT INTO movies (mid, title, year, runtime, did) VALUES (10, 'Football Factory', 1945, 74, 2);

INSERT INTO casts (aid, mid) VALUES (7,1);
INSERT INTO casts (aid, mid) VALUES (7,2);
INSERT INTO casts (aid, mid) VALUES (7,3);
INSERT INTO casts (aid, mid) VALUES (1,2);
INSERT INTO casts (aid, mid) VALUES (2,2);
INSERT INTO casts (aid, mid) VALUES (3,3);
INSERT INTO casts (aid, mid) VALUES (4,3);
INSERT INTO casts (aid, mid) VALUES (5,4);
INSERT INTO casts (aid, mid) VALUES (6,5);
INSERT INTO casts (aid, mid) VALUES (8,5);
INSERT INTO casts (aid, mid) VALUES (9,6);


-- SELECT QUERIES 
-- find movies made during WWII (1939-1945)
SELECT *
FROM movies
WHERE year BETWEEN 1939 AND 1945;

-- find the average runtume of the movies
SELECT AVG(runtime) as 'Average Movie Runtime'
FROM movies;

-- find the longest movie before 1980
SELECT title, runtime
FROM movies
WHERE year < 1980 AND runtime = (SELECT MAX(runtime) FROM movies WHERE year < 1980);
-- or could do it differently
SELECT title, runtime 
FROM movies 
WHERE year < 1980 
ORDER BY runtime DESC LIMIT 1;

-- find movies which Humphrey Bogart acted in them
SELECT *
FROM movies
JOIN casts on movies.mid=casts.mid
JOIN actors on casts.aid=actors.aid
WHERE actors.name='Humphrey Bogart';

-- list movies along with their director names
SELECT title, year, runtime, movies.did, directors.name as 'director\'s name', directors.did as 'director\'s id'
FROM movies
JOIN directors ON movies.did=directors.did;

-- find movies directed by Billy Wilder
SELECT title, year, runtime, movies.did, directors.name as 'director\'s name', directors.did as 'director\'s id'
FROM movies
JOIN directors ON movies.did=directors.did
WHERE directors.name='Billy Wilder';


-- find the director of the earliest movie
SELECT title, year, runtime, movies.did, directors.name as 'director\'s name', directors.did as 'director\'s id'
FROM movies
JOIN directors ON movies.did=directors.did
WHERE year = (SELECT MIN(year) FROM movies);  
-- or could do it differently
SELECT directors.name 
FROM movies
JOIN directors ON movies.did = directors.did
ORDER BY year ASC LIMIT 1;


-- find movies with female actors (actresses)
SELECT title, year, runtime, actors.name, actors.gender
FROM movies
JOIN casts ON movies.mid=casts.mid
JOIN actors ON casts.aid=actors.aid
WHERE actors.gender='F';
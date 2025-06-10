-- tables created from lab1

-- find the director who directed the most movies
SELECT d.name, COUNT(m.mid) AS movie_count
FROM directors d
JOIN movies m ON d.did = m.did
GROUP BY d.name
ORDER BY movie_count DESC
LIMIT 1;

-- find the actor who acted in the most movies
SELECT a.name, COUNT(c.mid) AS movie_count
FROM actors a
JOIN casts c ON a.aid = c.aid
GROUP BY a.name
ORDER BY movie_count DESC
LIMIT 1;

-- rank movies by runtime using a window function
SELECT title, year, runtime,
RANK() OVER (ORDER BY runtime DESC) AS rank_runtime
FROM movies;

-- find movies where the lead actor is also the director
SELECT m.title, d.name AS director_actor
FROM movies m
JOIN directors d ON m.did = d.did
JOIN casts c ON m.mid = c.mid
JOIN actors a ON c.aid = a.aid
WHERE d.name = a.name;

-- find the top 3 longest movies per director using a window function
SELECT title, name AS director, runtime
FROM (
 SELECT m.title, d.name, m.runtime,
 RANK() OVER (PARTITION BY d.name ORDER BY m.runtime DESC) AS rnk
 FROM movies m
 JOIN directors d ON m.did = d.did
) ranked_movies
WHERE rnk <= 3;

-- find actors who have worked with more than one director
SELECT a.name, COUNT(DISTINCT m.did) AS director_count
FROM actors a
JOIN casts c ON a.aid = c.aid
JOIN movies m ON c.mid = m.mid
GROUP BY a.name
HAVING COUNT(DISTINCT m.did) > 1;

-- identify directors who have directed a movied featuring a female actor
SELECT DISTINCT d.name
FROM directors d
JOIN movies m ON d.did = m.did
JOIN casts c ON m.mid = c.mid
JOIN actors a ON c.aid = a.aid
WHERE a.gender = 'F';

-- find actors who starred in the earliest movie available
SELECT a.name
FROM actors a
JOIN casts c ON a.aid = c.aid
JOIN movies m ON c.mid = m.mid
WHERE m.year = (SELECT MIN(year) FROM movie);

-- find the average movie runtime for each decade
SELECT (year DIV 10) * 10 AS decade, AVG(runtime) AS avg_runtime
FROM movies
GROUP BY decade
ORDER BY decade;

-- find the most recent movie each actor has starred in
SELECT a.name, m.title, m.year
FROM actors a
JOIN casts c ON a.aid = c.aid
JOIN movies m ON c.mid = m.mid
WHERE m.year = (SELECT MAX(year) FROM movies);
/*The movies database we saw in lectures has the following schema:

movies(id, title, yr, score, votes, director)
actors(id, name)
castings(movieid, actorid)
  
Within the movies table, the yr attribute denotes the year the film was released
(as a DECIMAL value) and the score and votes attributes capture the average rating by viewers
(on a scale of zero to ten) and the number viewers who voted. Directors are identified by id number only.
(The DB is a cut-down version of a larger one. Several tables, including the one containing directors’ names
have been omitted.)

Each actor has an id number and a name. The castings table records which actors appeared in which films.
The DB contains information about two thousand (mostly Hollywood) films from the 1920s until 2000
and around six thousand actors who were active during that period.
Formulate queries for each of the following and record your answers in your report. */

/*1.	Determine how many films and how many actors are represented in the DB. */

SELECT COUNT(DISTINCT movieid), COUNT(DISTINCT actorid)
FROM castings;

/*2.	Determine how many films were released in 1975? */

SELECT COUNT(id)
FROM movies
WHERE yr = 1975;

/*3.	List the ids of all films in which Clint Eastwood appears. */

SELECT m.id
FROM movies AS m
JOIN castings AS c
JOIN actors AS a
ON m.id = c.movieid
AND c.actorid = a.id
WHERE a.name = 'Clint Eastwood';

/*4.	List the names and years of all films in which Clint Eastwood appears. Order the films chronologically. */

SELECT m.title, m.yr
FROM movies AS m
JOIN castings AS c
JOIN actors AS a
ON m.id = c.movieid
AND c.actorid = a.id
WHERE a.name = 'Clint Eastwood'
ORDER BY m.yr DESC;

/*5.	List all the actors who appeared in “Citizen Kane”. */

SELECT a.name
FROM movies AS m
JOIN castings AS c
JOIN actors AS a
ON m.id = c.movieid
AND c.actorid = a.id
WHERE m.title = 'Citizen Kane';

/*6.	List all the actors who appeared in either “Vertigo” or “Rear Window”. */

SELECT a.name
FROM movies AS m
JOIN castings AS c
JOIN actors AS a
ON m.id = c.movieid
AND c.actorid = a.id
WHERE m.title = 'Vertigo' OR m.title = 'Rear Window';

/*7.	List all the films made by the director with id number 28. */

SELECT m.title
FROM movies AS m
WHERE m.director = 28;

/*8.	List all the films made by the director of “Godfather, The”. */

SELECT m2.title
FROM movies AS m1
JOIN movies as m2
ON m1.director = m2.director
WHERE m1.title = 'Godfather, The';

/*9.	List all remakes, i.e. pairs of films with the same name; give the name and the year in each case. */

SELECT m1.title, m1.yr, m2.title, m2.yr
FROM movies AS m1
JOIN movies AS m2
ON m1.id < m2.id
WHERE m1.title = m2.title AND m1.yr != m2.yr;

/*10.	List the names all obvious sequels with names like “Superman II”
  ( Consider only the first four sequels i.e. II to V). */

SELECT m.title
FROM movies AS m
WHERE m.title LIKE '% II'
OR m.title LIKE '% III'
OR m.title LIKE '% IV'
OR m.title LIKE '% V';

/*11.	List all film-sequel pairs where the sequel has the same name of the original with
  the Roman numeral II appended. (Hint: the function CONCAT can be used to join strings together,
  so CONCAT(’Superman’, ’ II’) = ’Superman II’.) */

SELECT m1.title, m2.title
FROM movies AS m1
JOIN movies AS m2
ON m1.id < m2.id
WHERE m1.title = m1.title AND m2.title = CONCAT(m1.title, ' II');

/*12.	List all pairs of films by the same director where one film received a good score (> 8)
  and another a poor score (< 3). */

SELECT m1.title, m2.title
FROM movies AS m1
JOIN movies AS m2
ON m1.director = m2.director
AND m1.id < m2.id
WHERE m1.score > 8 AND m2.score < 3;

/*13.	List all the films in which both Clint Eastwood and Richard Burton appeared. */

SELECT DISTINCT m.title
FROM actors AS a1
JOIN actors AS a2
JOIN castings AS c1
JOIN castings AS c2
JOIN movies AS m
ON a1.id = c1.actorid
AND a2.id = c2.actorid
AND c1.movieid = m.id
WHERE a1.name = 'Clint Eastwood' AND a2.name = 'Richard Burton';

/*14.	List all the actors who have appeared in a film with Al Pacino. */

SELECT a2.name
FROM actors AS a1
JOIN castings AS c1
JOIN actors AS a2
JOIN castings as c2
ON a1.id = c1.actorid
AND a2.id = c2.actorid
AND a1.id < a2.id
AND c1.movieid = c2.movieid
WHERE a1.name = 'Al Pacino';

/*15.	List all the actors who appeared in both “Big Sleep, The” and “Casablanca”. */

SELECT a.name
FROM movies AS m1
JOIN movies AS m2
JOIN castings AS c
JOIN actors AS a
ON m1.id = c.movieid
AND m2.id = c.movieid
AND c.actorid = a.id
WHERE m1.title = 'Big Sleep, The' AND m2.title = 'Casablanca';

/*16.	List all the actors who made a film during the 1950s and also in the 1980s. */

SELECT a.name
FROM movies AS m
JOIN castings AS c ON m.id = c.movieid
JOIN actors AS a ON c.actorid = a.id
GROUP BY a.id, a.name
HAVING
    MAX(m.yr BETWEEN 1950 AND 1959) = 1
    AND MAX(m.yr BETWEEN 1980 AND 1989) = 1;

/*17.	For each year during the 1960s, list the number of films made, and the first and last
  (alphabetically by title). */

SELECT yr, COUNT(*), MIN(title), MAX(title)
FROM movies
WHERE yr BETWEEN 1960 AND 1969
GROUP BY yr;

/*18.	List all the actors who appeared in a least ten films together with the names of his/her films. */

SELECT a.name, COUNT(m.title)
FROM movies AS m
JOIN castings AS c
JOIN actors AS a
ON m.id = c.movieid
AND c.actorid = a.id
GROUP BY a.name
HAVING COUNT(m.title) > 10;
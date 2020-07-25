/*The objective of this lab is to develop our skills with SQL’s subquery features.
Try to solve each task below without using joins even if joins provide the most natural approach
to tacking the problem.
This lab will use the familiar movies database.*/

/*1.	List the ids of all actors who appeared in “Big Sleep, The”. */

(SELECT actorid
FROM castings
WHERE movieid =
    (SELECT id
    FROM movies
    WHERE title = 'Big Sleep, The')
);

/*2.	List chronologically the names of the films made by the director of “Citizen Kane”. */

(SELECT title
FROM movies
WHERE id IN
    (SELECT id
    FROM movies
    WHERE director =
        (SELECT director
        FROM movies
        WHERE title = 'Citizen Kane')
    )
    ORDER BY yr DESC);

/*3.	List the names of all actors who appeared in “Big Sleep, The”. */

(SELECT name
FROM actors
WHERE id IN
    (SELECT actorid
    FROM castings
    WHERE movieid =
        (SELECT id
        FROM movies
        WHERE title = 'Big Sleep, The')
    )
);

/*4.	List the ids of all films that were either made in the 1950s or had Elizabeth Taylor in them. */

(SELECT id
FROM movies
WHERE yr BETWEEN 1950 AND 1959)

UNION

(SELECT id
FROM movies
WHERE id IN
    (SELECT movieid
    FROM castings
    WHERE actorid =
        (SELECT id
        FROM actors
        WHERE name = 'Elizabeth Taylor')
    )
);

/*5.	List the name and scores of the film(s) with the best score. */

SELECT title, score
FROM movies
WHERE id IN
    (SELECT id
    FROM movies
    WHERE score IN
        (SELECT score
        FROM movies
        WHERE score =
            (SELECT MAX(score)
            FROM movies)
        )
);

/*6.	List the ids the actors with at least 10 films to their credit. */

SELECT actorid
FROM castings
GROUP BY actorid
HAVING COUNT(*) >= 10;

/*7.	List the names of the actors with at least 10 films to their credit. */

SELECT name
FROM actors
WHERE id IN
    (SELECT actorid
    FROM castings
    GROUP BY actorid
    HAVING COUNT(*) >= 10);

/*8.	List the name and scores of the film(s) with scores within 10% of the best score.  */

SELECT title, score
FROM movies
WHERE score IN
    (SELECT score
    FROM movies
    WHERE score > 0.9 *
        (SELECT MAX(score)
        FROM movies)
);

/*9.	List the names of all the actors that appeared in the most terrible films (those with scores below 3.0). */

SELECT name
FROM actors
WHERE id IN
    (SELECT actorid
    FROM castings
    WHERE movieid IN
        (SELECT id
        FROM movies
        WHERE score IN
            (SELECT score
            FROM movies
            WHERE score < 3)
        )
);

/*10.	List the names and scores of the films with the best and the worst scores. */

SELECT title, score
FROM movies
WHERE id IN
    (SELECT id
    FROM movies
    WHERE score IN
        (SELECT score
        FROM movies
        WHERE score =
            (SELECT MAX(score)
            FROM movies)
        )
)

UNION

SELECT title, score
FROM movies
WHERE id IN
    (SELECT id
    FROM movies
    WHERE score IN
        (SELECT score
        FROM movies
        WHERE score =
            (SELECT MIN(score)
            FROM movies)
        )
);

/*11.	List the years and films made before the first film made by the director of ’Citizen Kane’. */

SELECT title, yr
FROM movies
WHERE yr <
    (SELECT MIN(yr)
    FROM movies
    WHERE title IN
        (SELECT title
        FROM movies
        WHERE id IN
            (SELECT id
            FROM movies
            WHERE director =
                (SELECT director
                FROM movies
                WHERE title = 'Citizen Kane')
            )
        ORDER BY yr DESC)
);

/*12.	List the years and films made after the first film made by the director of ’Citizen Kane’. */

SELECT title, yr
FROM movies
WHERE yr >
    (SELECT MIN(yr)
    FROM movies
    WHERE title IN
        (SELECT title
        FROM movies
        WHERE id IN
            (SELECT id
            FROM movies
            WHERE director =
                (SELECT director
                FROM movies
                WHERE title = 'Citizen Kane')
            )
        ORDER BY yr DESC)
);


/*13.	List all the films with a score at least as good as the best film made in the 1940s. */

SELECT title
FROM movies
WHERE score >=
    (SELECT MAX(score)
    FROM movies
    WHERE score IN
        (SELECT score
        FROM movies
        WHERE yr BETWEEN 1940 AND 1949)
);

/*14.	What is the greatest number of films made by any director? */

SELECT MAX(num_films)
FROM
    (SELECT director, COUNT(id) AS 'num_films'
    FROM movies
    GROUP BY director)
AS films_directed;

/*15.	List the director id and the number of films of the director with the greatest number of films. */

SELECT director, COUNT(*)
FROM movies
GROUP BY director
HAVING COUNT(*) =
    (SELECT MAX(num_films)
    FROM
        (SELECT director, COUNT(id) AS 'num_films'
        FROM movies
        GROUP BY director)
    AS films_directed);

/*16.	List, in chronological order, all the films by the director with the greatest number of films. */

SELECT title
FROM movies
WHERE director =
    (SELECT director
    FROM movies
    GROUP BY director
    HAVING COUNT(*) =
        (SELECT MAX(num_films)
        FROM
            (SELECT director, COUNT(id) AS 'num_films'
            FROM movies
            GROUP BY director)
        AS films_directed))
ORDER BY yr DESC;

/*17.	List all the films starring Diane Keaton made by the director of “Bananas”. */

SELECT title
FROM movies
WHERE id IN
    (SELECT movieid FROM castings WHERE
    actorid =
        (SELECT id FROM actors
        WHERE name = 'Diane Keaton')

AND

movieid IN

    (SELECT id
    FROM movies
    WHERE director =
        (SELECT director
        FROM movies
        WHERE title = 'Bananas')
    )
);
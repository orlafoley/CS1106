/*These exercises are based on the friends database containing tables persons and likes
(previously known as favourite foods). The SQL files required to set this database up are in the
DBs section of the module webpage.
The following problems involve the use of SQL’s LIKE string matching feature.
You may wish to Google this to refresh your memory on how this works.*/

/*1.	List all the persons in the DB with first names beginning with the letter ’A’*/

SELECT first_name, last_name
FROM persons
WHERE first_name LIKE 'A%';

/*2.	List all the persons in the DB with first names that end with the letter ’A’*/

SELECT first_name, last_name
FROM persons
WHERE first_name LIKE '%a';

/*3.	List all the persons in the DB whose first names contain the letter ’A’*/

SELECT first_name, last_name
FROM persons
WHERE first_name LIKE '%a%';

/*4.	List all the persons in the DB whose first names contains exactly five letters*/

SELECT first_name, last_name
FROM persons
WHERE first_name LIKE '_____';

/*5.	List all the persons in the DB whose address contains the word “street”*/

SELECT first_name, last_name
FROM persons
WHERE street LIKE '%street%'
OR town LIKE '%street%'
OR county LIKE '%street%';

/*6.	List all the foods that contain a single space*/

SELECT food
FROM likes
WHERE food LIKE '% %';

/*7.	List all the foods that contain the pair of letters ‘te’*/

SELECT DISTINCT food
FROM likes
WHERE food LIKE '%te%';

/*The following problem involve the use of joins.*/

/*1.	List the complete cross join of the persons and favourite foods tables.*/

SELECT *
FROM persons AS p
JOIN likes AS l;

/*2.	Refine the above so that each row from persons appears adjacent only those rows
from favourite foods that relate to the same individual i.e. list each individual together
with all his/her favourite foods.*/

SELECT *
FROM persons AS p
JOIN likes AS l
	ON p.person_id = l.person_id;

/*3.	List Aoife Ahern’s favourite foods.*/

SELECT l.food
FROM persons AS p
	JOIN likes AS l
	ON p.person_id = l.person_id
WHERE p.first_name = 'Aoife'
	AND p.last_name = 'Ahern';

/*4.	List the names and favourite foods of all those from County Cork.*/

SELECT p.first_name, l.food
FROM persons AS p
	JOIN likes AS l
	ON p.person_id = l.person_id
WHERE p.county = 'Cork';

/*5.	List all the distinct foods favoured by females.*/

SELECT DISTINCT l.food
FROM persons AS p
	JOIN likes AS l
	ON p.person_id = l.person_id
WHERE p.gender = 'F';

/*6.	List the names of all individuals who like pizza.*/

SELECT p.first_name, p.last_name
FROM persons AS p
	JOIN likes AS l
	ON p.person_id = l.person_id
WHERE l.food = 'Pizza';

/*7.	List the (distinct) hometowns of those who like beer.*/

SELECT DISTINCT p.town
FROM persons AS p
	JOIN likes AS l
	ON p.person_id = l.person_id
WHERE l.food = 'Beer';

/*8.	List the complete cross join of the favourite foods table with itself.*/

SELECT *
FROM likes AS f
	JOIN likes AS l;

/*9.	Refine the above so that each row from favourite foods appears adjacent
only to other rows from favourite foods that relate to the same individual i.e. list food
  pairs favoured by some individual.*/

SELECT *
FROM likes AS f
	JOIN likes AS l
    ON f.person_id = l.person_id;

/*10.	List the id numbers of those who like both pizza and nutella.*/

SELECT DISTINCT f.person_id
FROM likes AS f
JOIN likes AS l
   	ON f.person_id = l.person_id
WHERE l.food = 'Pizza' AND l.food = 'Nutella';

/*11.	List the id numbers of those who like either pizza or nutella (or both).*/

SELECT DISTINCT f.person_id
FROM likes AS f
	JOIN likes AS l
    ON f.person_id = l.person_id
WHERE l.food = 'Pizza' OR l.food = 'Nutella';

/*12.	List the names of those who live in Cork and who like beer.*/

SELECT p.first_name, p.last_name
FROM persons AS p
	JOIN likes AS l
	ON p.person_id = l.person_id
WHERE p.town = 'Cork' AND l.food = 'Beer';

/*13.	List the names of those who like both pizza and nutella.*/

SELECT DISTINCT p.first_name, p.last_name
FROM persons AS p
	JOIN likes AS l
	ON p.person_id = l.person_id
WHERE p.town = 'Cork' AND l.food = 'Nutella';

/*14.	List the names of those who like either pizza or nutella (or both).*/

SELECT DISTINCT p.first_name, p.last_name
FROM persons AS p
	JOIN likes AS l
	ON p.person_id = l.person_id
WHERE p.town = 'Cork' OR l.food = 'Nutella';

/*15.	List the complete cross join of the persons table with itself.*/

SELECT *
FROM persons AS p1
	JOIN persons AS p2;

/*16.	Refine the above so that each person pair appears only once in the output.*/

SELECT *
FROM persons AS p1
	JOIN persons AS p2
    ON p1.person_id = p2.person_id;

/*17.	List the names of any individuals who share the same date of birth.*/

SELECT p1.first_name, p1.last_name
FROM persons AS p1
	JOIN persons AS p2
    ON p1.person_id = p2.person_id
WHERE p1.birth_date = p2.birth_date AND p1.person_id != p2.person_id;

/*18.	List the names of any individuals who share the same birthday.*/

SELECT p1.first_name, p1.last_name
FROM persons AS p1
	JOIN persons AS p2
   	ON p1.person_id = p2.person_id
WHERE MONTH(p1.birth_date) = MONTH(p2.birth_date)
AND DAY(p1.birth_date) = DAY(p2.birth_date)
   	AND p1.person_id != p2.person_id;

/*19.	List for each food the number of individuals who count that food among their favourites.*/

SELECT l.food, COUNT(l.food)
FROM persons AS p
JOIN likes AS l
	ON p.person_id = l.person_id
GROUP BY l.food;

/*20.	List the names of those who do not like beer. */

SELECT first_name, last_name
FROM persons
WHERE person_id NOT IN (
                        SELECT p.person_id
                        FROM persons AS p
                            JOIN likes AS l
                            ON p.person_id=l.person_id
                        WHERE l.food = 'Beer');

/*21.	List those that like at least two of pizza, beer, nutella.*/

SELECT p.first_name, p.last_name
FROM persons AS p
	JOIN likes AS l1
    JOIN likes AS l2
    ON p.person_id = l1.person_id
    AND l1.person_id = l2.person_id
WHERE l1.food = 'Pizza' AND l2.food = 'Beer'
	OR l1.food = 'Pizza' AND l2.food = 'Nutella'
    	OR l1.food = 'Beer' AND l2.food = 'Nutella';

/*22.	List all distinct pairs of individuals that have at least one food in common.*/

SELECT p1.first_name, p1.last_name, p2.first_name, p2.last_name
FROM persons AS p1
	JOIN persons AS p2
    JOIN likes AS l1
    JOIN likes AS l2
	ON p1.person_id = l1.person_id
    AND p2.person_id = l2.person_id
    AND p1.person_id < p2.person_id
 WHERE l1.food = l2.food;

/*23.	List for each county and each food the number of individuals in that county that like that food.*/

SELECT p.county, l.food, COUNT(*)
FROM persons AS p
    JOIN likes AS l
	ON p.person_id = l.person_id
GROUP BY p.county, l.food;

/*24.	List the number of beer lovers county by county in descending order of popularity.*/

SELECT p.county, l.food, COUNT(*)
FROM persons AS p
    JOIN likes AS l
	ON p.person_id = l.person_id
WHERE l.food = 'Beer'
GROUP BY p.county;

/*25.	List the name of the youngest person in the database.*/

SELECT p.first_name, p.last_name
FROM persons AS p
WHERE p.birth_date = (SELECT MIN(birth_date)
                   		         FROM persons);
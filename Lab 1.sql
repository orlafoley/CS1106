
CREATE TABLE IF NOT EXISTS students
(id_number 		INT(9),
first_name		VARCHAR(30)
last_name		VARCHAR(20)
date_of_birth	DATE,
hometown		VARCHAR(15),
course			CHAR(5),
points			INT(3)
PRIMARY KEY(id_number));


/*
id number	first name	last name	date of birth	hometown	course	points
112345678	Aoife		Ahern		1993-01-25		Cork		ck401	500
112467389	Barry		Barry		1980-06-30		Tralee		ck402	450
112356489	Ciara		Callaghan	1993-03-14		Limerick	ck401	425
112986347	Declan		Duffy		1993-11-03		Cork		ck407	550
112561728	Eimear		Early		1993-07-18		Thurles		ck406	475
112836467	Fionn		Fitzgerald	1994-06-13		Bandon		ck405	485
*/



/*1. List all the students in the table; 
 * include all the columns in the result.*/

SELECT * 
FROM students

/*2. List the names (first name, followed by last name) 
 * of all the students in the table.*/

SELECT first_name, last_name
FROM students;

/*3. List the names of all the students in the table; 
 * list these in increasing order of their points 
 * (lowest first, highest last).*/

SELECT first_name, last_name
FROM students
ORDER BY points;

/*4. List the names of all the students in the table; 
 * list them in decreasing order of their dates of birth 
 * (oldest first, youngest last).*/

SELECT first_name, last_name, date_of_birth
FROM students
ORDER BY date_of_birth ASC;

/*5. List all the distinct home-towns that appear in the table; 
 * note that each town should appear only once however often 
 * it features in the table.*/

SELECT DISTINCT hometown
FROM students;

/*6. List the names of all students with at least 450 points.*/


SELECT first_name, last_name
FROM students
WHERE points <= 450;

/*7. List the names of all students with exactly 525 points.*/

SELECT first_name, last_name
FROM students
WHERE points = 525;

/*8. List the names of all students who do not have exactly 525 points.*/

SELECT first_name, last_name
FROM students
WHERE NOT points = 525;

/*9. List the names of all students with between 400 and 500 points.*/

SELECT first_name, last_name
FROM students
WHERE points BETWEEN 400 AND 500

/*10. List the names of all the students who come from Cork.*/

SELECT first_name, last_name, points
FROM students
WHERE hometown = 'Cork';

/*11. List the names of all the students born on or before 1 January 1994.*/

SELECT first_name, last_name
FROM students
WHERE date_of_birth <= '1994-01-01';

/*12. List the names of all the students who were 
 * less than 20 years old on 1 October 2012.*/

SELECT first_name, last_name, date_of_birth
FROM students
WHERE date_of_birth > '1992-10-01';

/*13. List the names of all the students born on 25 December 1994.*/

SELECT first_name, last_name, date_of_birth
FROM students
WHERE date_of_birth = '1994-12-25';

/*14. List the details of all the students named Ciara.*/

SELECT *
FROM students
WHERE first_name = 'Ciara';

/*15. List the details of all the students named ciara.*/

SELECT *
FROM students
WHERE first_name = 'ciara';

/*16. List the details of all the students 
 * whose surname or first name is Barry.*/

SELECT *
FROM students
WHERE first_name = 'Barry' OR last_name = 'Barry';

/*17. List the details of all the students named O’Kelly.*/

SELECT *
FROM students
WHERE last_name = 'O\'Kelly';

/*18. List the names of all the students born in 1994.*/

SELECT first_name, last_name
FROM students
WHERE date_of_birth BETWEEN '1994-01-01' AND '1994-12-31';

/*19. List the names and home-towns of all female students.*/

SELECT first_name, last_name, hometown
FROM students
WHERE first_name = 'Aoife' OR first_name = 'Ciara' OR first_name = 'Eimear';

/*20. List the details of all students 
 * enrolled in either ck401 or ck402.*/

SELECT *
FROM students
WHERE course = 'ck401' OR course = 'ck402';

/*21. List the details of all students 
 * that have at least 450 points and are from Cork.*/

SELECT *
FROM students
WHERE hometown = 'Cork' AND points >= 450;

/*22. List the details of all students 
 * that have at least 450 points and are not from Cork.*/

SELECT *
FROM students
WHERE NOT hometown = 'Cork' AND points >= 450;

/*23. List the details of all students 
 * whose last name precedes Cuddihy alphabetically.*/

SELECT *
FROM students
WHERE last_name < 'Cuddihy';

/*24. List the details of all students whose 
 * name precedes Harry Callaghan alphabetically 
 * (under the convention that names are ordered 
 * by last name and then by first name).*/

SELECT *
FROM students
WHERE last_name < 'Callaghan' AND first_name < 'Harry';

/*25. List the details of all the students 
 * whose surname begins with the letter ‘H’.*/

SELECT *
FROM students
WHERE last_name LIKE 'H%';

/*26. List names and points of all students with at least 450 points; 
 * arrange the result in decreasing order by first name; 
 * label the columns of the result using Surname (for last name), 
 * Given Name(s) (for other name(s)) and CAO Points (for points).*/

 SELECT first_name AS 'Given Name(s)', last_name AS 'Surname', points AS 'CAO Points'
 FROM students
 WHERE points >= 450
 ORDER BY first_name DESC;




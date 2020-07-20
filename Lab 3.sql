/*This section is based on the countries that we encountered in Lecture 6.
The SQL to create and populate the DB are available from the module website.
You will recall that this single-table DB had the following schema:
              countries(name, region, area, population, gdp)*/

/*1.	What is the greatest area of any country?*/

SELECT area
FROM countries
WHERE area    =	(SELECT MAX(area)
                		FROM countries);

/*2.	What is the largest population of any country in Africa?*/

SELECT population
FROM countries
WHERE region = 'Africa' AND population = (SELECT MAX(population)
                                          FROM countries
                                          WHERE region = 'Africa');

/*3.	What is the total GDP of Europe?*/

SELECT SUM(gdp)
FROM countries
WHERE region = 'Europe';

/*4.	List the names and populations of all countries whose GDP is not known (NULL).*/

SELECT name, population
FROM countries
WHERE gdp IS NULL;

/*5.	List the names and GDPs of all countries for which a GDP is known.*/

SELECT name, gdp
FROM countries
WHERE NOT gdp = 'NULL';

/*6.	List the name and average GDP of each region.*/

SELECT region, AVG(gdp)
FROM countries
GROUP BY region;

/*7.	List all the countries whose name contains the region name as a substring.*/

SELECT name
FROM countries
WHERE name LIKE '%Africa%' OR '%South Asia%' OR '%Europe%'
OR '%Middle East%' OR '%Americas%' OR '%South America%'
OR '%Asia-Pacific%' OR '%North America%';

/*8.	List the minimum and maximum per capita GDP for each region.*/

SELECT region, MIN(gdp/population), MAX(gdp/population)
FROM countries
GROUP BY region;

/*9.	List the number of countries and total population for each of the following regions: Europe, Africa and the Middle East.*/

SELECT region, COUNT(name), SUM(population)
FROM countries
WHERE region = 'Africa' OR region = 'Europe' OR region = 'Middle East'
GROUP BY region;

/*10.	What is the total population, area and GDP of France, Germany and Spain (taken together)?*/

SELECT SUM(population), SUM(area), SUM(gdp)
FROM countries
WHERE name = 'France' OR name = 'Spain' OR name = 'Germany';

/*11.	List by region the number of countries in that region with a population greater than 100 million.*/

SELECT COUNT(name)
FROM countries
WHERE population > 100000000
GROUP BY region;

/*12.	For each letter of the alphabet, list the number countries whose names begin with that
letter and the first and last country (alphabetically). (Hint: The SUBSTRING function may prove useful here.
For a summary of MySQL’s functions, see dev.mysql.com/doc/refman/5.0/en/functions.html.)*/

SELECT name
FROM countries
WHERE SUBSTRING(name, 1,1) = SUBSTRING(name, -1,1);


/*13.	List all the countries in the world region by region (alphabetically) and by descending
order of population within each region.*/

SELECT name
FROM countries
ORDER BY region ASC, population DESC;

/*14.	List the number of countries and population density (area divided by population)
  in all regions with total population greater than one billion.*/

SELECT COUNT(name), SUM(area/population)
FROM countries
GROUP BY region
HAVING SUM(population) > 1000000000


/*15.	List the names of all the countries in the same region as Jordan.*/

SELECT name
FROM `countries`
WHERE region = (SELECT region
                FROM countries
                WHERE name = 'Jordan')
	         AND name != 'Jordan';


/*16.	How many countries are in the same region as Jordan?*/

SELECT COUNT(name)
FROM `countries`
WHERE region = (SELECT region
                FROM countries
                WHERE name = 'Jordan')
                AND name != 'Jordan';

/*17.	List those countries in the same region as Spain that have a greater area than Spain’s.*/

SELECT name
FROM countries
WHERE region = (SELECT region
                FROM countries
                WHERE name = 'Spain')
                AND name != 'Spain'
                AND area > (SELECT area
                            FROM countries
                            WHERE name = 'Spain');

/*18.	(Tricky!) List all the countries that have an area that is at least 10% of the
  total area of the region to which they belong. */
SELECT name
FROM countries AS c
WHERE area > (
   SELECT 0.1 * SUM(area)
   FROM countries AS co
   WHERE co.region = c.region
   GROUP BY co.region
   );

/*19.	List the countries in decreasing order of population band; for each band list the number of countries and the minimum and maximum area.
  We use 100 million as our bandwidth, i.e. the first band consists of countries with populations less than 100 million and so on. (Hint: you may find the SQL TRUNCATE function useful. )
 */

SELECT COUNT(name), MIN(area), MAX(area)
FROM countries
WHERE population < 100000000;

SELECT COUNT(name), MIN(area), MAX(area)
FROM countries
WHERE 100000000 < population AND population < 200000000;

SELECT COUNT(name), MIN(area), MAX(area)
FROM countries
WHERE 200000000 < population AND population < 300000000;

SELECT COUNT(name), MIN(area), MAX(area)
FROM countries
WHERE 300000000 < population AND population < 400000000;

/*You can keep going this way but I'm skipping Null results*/

SELECT COUNT(name), MIN(area), MAX(area)
FROM countries
WHERE 1000000000 < population;


/*20.	What is the minimum population of any country in the same region as China?*/

SELECT population
FROM countries
WHERE population = (SELECT MIN(population)
               		FROM countries
               		WHERE region = (SELECT region
                                   FROM countries
                                   WHERE name = 'China'));

/*21.	List all the countries whose per capita GDP is at least as great as China’s. The list should appear in descending order of per capita GDP.*/

SELECT name
FROM countries
WHERE gdp/population >= (SELECT gdp/population
                         FROM countries
                         WHERE name = 'China')
ORDER BY gdp/population DESC;


/*22.	(Tricky!) Determine the name of the country with the greatest population.*/

SELECT name
FROM countries
WHERE population = (SELECT MAX(population)
               			FROM countries);

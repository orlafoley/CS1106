/*The database for today’s lab has the following schema.
(The DB contents can be downloaded from Canvas; its name is world.)

cities(id, name, country_code, district, population)
countries (code, name, continent, region, surface_area, indep_year, population, life_expectancy,
    gnp, gnp_old, local_name, government_form, head_of_state, capital, code2)
country_languages(country_code, language, is_official, percentage)*/

/*1.	List the twenty most populous cities in the world. (MySQL’s LIMIT feature may prove handy here.)*/

SELECT c.name
FROM cities AS c
ORDER BY c.population DESC
LIMIT 20;

/*2.	List the countries that have at least five cities with a population of one million or more.
List the country’s name and the number of such cities.*/

SELECT co.name
FROM cities AS ci
JOIN countries AS co
ON ci.country_code = co.code
WHERE ci.population > 1000000
GROUP BY co.name
HAVING COUNT(*) >= 5;

/*3.	List all the countries which achieve independence since India did.*/

SELECT co.name
FROM countries AS co
WHERE indep_year >
(SELECT indep_year
FROM countries
WHERE name = 'India');

/*4.	List those language that are spoken by a significant proportion of the population of
at least six countries. (We take 25% or more to be “significant”.)*/

SELECT cl.language
FROM country_languages AS cl
WHERE cl.percentage >= 25
GROUP BY cl.language
HAVING COUNT(*) >= 6;

/*5.	List the names of all countries that are both among the twenty poorest (lowest GNP per capita)
and among the twenty with the lowest life expectancy.
Note: take care to filter out countries whose life expectancy, population or GNP is unknown.*/

SELECT name
FROM countries AS c
WHERE code IN
(SELECT c.code
FROM (
(SELECT co.name
FROM countries AS co
WHERE co.life_expectancy IS NOT NULL
AND co.gnp IS NOT NULL
AND co.population IS NOT NULL
ORDER BY co.gnp/population ASC
LIMIT 20)

UNION

(SELECT co.name
FROM countries AS co
WHERE co.life_expectancy IS NOT NULL
AND co.gnp IS NOT NULL
AND co.population IS NOT NULL
ORDER BY co.life_expectancy ASC
LIMIT 20)
)
AS c)
GROUP BY c.code;

/*6.	List all the countries that comprise a ”significant” portion (at least 10%) of the total surface
area of the continent to which they belong. As a warmup, first do this for a specific continent
    (say South America). You may find the notion of a correlated subquery useful here (look it up).*/

SELECT c1.name, c1.continent, c1.surface_area
FROM countries AS c1
WHERE c1.surface_area >= 0.1 *
(SELECT SUM(surface_area)
FROM countries AS c2
WHERE c1.continent = c2.continent);

/*7.	Calculate what proportion of the world’s total GNP is belongs to the 20 richest (by GNP) countries.*/
SELECT
(SELECT SUM(gnp)
FROM
(SELECT gnp
FROM countries
ORDER BY gnp DESC
LIMIT 20)
/*find the individual gnp of each of the 20 richest countries*/
AS richest_gnp_20)
/*add all 20 richest countries gnp's together*/
/
(SELECT SUM(gnp)
FROM countries)
AS gnp_percentage
/*divide by sum of all gnp of every single country*/
;

/*8.	Determine the head of state with the greatest amount of territory (by surface area).*/

SELECT head_of_state
FROM countries
WHERE surface_area =
(SELECT MAX(surface_area)
FROM countries);

/*9.	List for each continent, the name of the country with the greatest and smallest population.*/

SELECT c1.continent, c1.name, c3.smallest, c2.name, c3.largest
FROM countries AS c1
JOIN countries AS c2
JOIN
    (SELECT continent, MIN(population) AS 'smallest', MAX(population) AS 'largest'
    FROM countries
    GROUP BY continent)
AS c3
	ON c1.code = c2.code
       AND c1.continent = c3.continent
       AND c2.continent = c3.continent
WHERE c1.population = c3.smallest AND c2.population = c3.largest
GROUP BY c1.continent;

/*10.	For each country in Europe list the percentage of its population that live in its most populous city.*/

SELECT c1.name, c2.name, (c2.population / c1.population)
FROM countries AS c1
JOIN cities AS c2
ON c1.code = c2.country_code
    WHERE c1.code = c2.country_code
    AND c1.continent = 'Europe'
    AND c2.population IN
        (SELECT MAX(population)
        FROM cities
        WHERE c1.code = c2.country_code
        GROUP BY country_code);

/*11.	List in descending order of population all countries in which none of the following
languages are spoken by a significant proportion of the population:
English, Spanish, Chinese, Arabic or Hindi.*/

SELECT c.name, c.population
FROM countries AS c
WHERE c.code IN
(SELECT cl.country_code
FROM country_languages AS cl
WHERE cl.language NOT IN  ('English', 'Spanish', 'Chinese', 'Arabic', 'Hindi')
)
ORDER BY c.population DESC;

/*12.	List all the languages that are spoken by a majority of people in countries in at least two continents.*/

SELECT cl1.language, COUNT(*)
FROM country_languages AS cl1
JOIN countries AS c
WHERE cl1.country_code = c.code
AND cl1.country_code IN
    (SELECT cl.country_code
    FROM country_languages AS cl
    WHERE cl.percentage > 50)
GROUP BY cl1.language
HAVING COUNT(c.continent) >= 2;
/*Creating a Planetary Databases
We will create a simple database to house information 
about the solar system.*/
 
/*
1. Construct an SQL statement to create a table named 
planets to house the following information about 
each planet: name, diameter, mass, distance from 
the sun (minimum and maximum), date of discovery 
and brief description. Include the eight major 
planets not dwarf planets, asteroids or moons. 
Consider carefully the appropriate type for each 
column, bearing in mind the kind of data it is 
intended to hold.
 
2. Insert data into the table to make it as complete 
as possible, but omit the date and description for now. 
You will have to look up technical information relating 
to mass and so on. Make sure any data you use is consistent 
in respect of the units etc.

3. Use the update mechanism to enter the date of 
discovery for those planets for which it is relevant. 
Use NULL to indicate planets whose discovery date is not 
recorded.

4. Enter a brief description for one of the planets. 
You can make stuff up or consult Wikipedia etc. 
(If you borrow text from a source, don’t forget to 
include the source in the description.)

5. Suppose you wished to record the moons of the various 
planets. Re- engineer the database to incorporate this 
information. Bear in mind that some planets have 
several moons.
*/

DROP TABLE IF EXISTS planets;

CREATE TABLE planets
(
name				VARCHAR(10),
diameter			DECIMAL(6,0),
mass				VARCHAR(12),
min_dist_from_sun	VARCHAR(20),
max_dist_from_sun	VARCHAR(20),
date_of_descovery	INTEGER(4),
brief_description	VARCHAR(100),
PRIMARY KEY (name)
);

INSERT INTO planets VALUES
('Mercury', 4878, '3.3 x 10^23', '46 million km', 
'70 million km', NULL, 'Freddie'),
('Venus', 12104, '4.87 x 10^24', '107 million km',
'109 million km', NULL, 'Williams'),
('Earth', 12756, '5.98 x 10^24', '147 million km',
'152 million km', NULL, 'Terra'),
('Mars', 6794, '6.42 x 10^23', '205 million km',
'249 million km', NULL, 'God of War'),
('Jupiter', 142984, '1.90 x 10^27', '741 million km',
'817 million km', NULL, 'The Big One'),
('Saturn', 120536, '5.69 x 10^26', '1.35 billion km',
'1.51 billion km', NULL, 'If you like it then you 
should have put a ring on it'),
('Uranus', 51118, '8.68 x 10^25', '2.75 billion km',
'3.00 billion km', 1781, 'Say this one without laughing'),
('Neptune', 49532, '1.02 x 10^26', '4.45 billion km',
'4.55 billion km', 1846, 'The god of the sea himself')

UPDATE planets
SET brief_description = 'Liquid at room temp'
WHERE name = 'Mercury';


DROP TABLE IF EXISTS moons;

CREATE TABLE moons
(
planet	VARCHAR(10),
moon	VARCHAR(20),
PRIMARY KEY (moon)
);

INSERT INTO moons VALUES
('Earth', 'Luna'),
('Jupiter','Callisto'),
('Jupiter','Europa'),
('Jupiter','Ganymede'),
('Jupiter','Io'),
('Mars','Deimos'),
('Mars','Phobos'),
('Neptune','Nereid'),
('Neptune','Proteus'),
('Neptune','Triton'),
('Saturn','Dione'),
('Saturn','Enceladus'),
('Saturn','Hyperion'),
('Saturn','Iapetus'),
('Saturn','Mimas'),
('Saturn','Pheobe'),
('Saturn','Rhea'),
('Saturn','Tethys'),
('Saturn','Titan'),
('Uranus','Ariel'),
('Uranus','Miranda'),
('Uranus','Oberon'),
('Uranus','Puck'),
('Uranus','Titania')


/*A Simple Feedback Database
The Acme Widgets Company wishes to add a feature 
to its website to gather customer feedback. 

This feature will use a table with the following structure:

feedback(id, customer_name, customer_email, 
customer_height, feedback_text, fb_date)

The date relates to the day on which the feedback 
was received and the height is the customer’s height 
in metres, which the marketing department insists 
be collected for some reason.

Give an appropriate complete SQL statement to 
accomplish each of the tasks specified below.*/

/*
1. Create the feedback table. Make sure you indicate 
an appropriate type for each attribute and that you 
indicate the primary key.
 
 
2. Insert a single row into the table. You may invent 
suitable values for the customer’s details, feedback 
and so on, but the statement must respect SQL’s 
syntactic rules.
 
 
3. Delete all feedback from the customer(s) 
named ‘Tom’.

4. Update the height of any customer named 
‘Paddy’ to be 1.75.

5. Select all feedback for March 2014 from customers 
with ‘Harry’ in their names. Use the LIKE feature. 
Google it to see how it works.

6. Select all the feedback since the beginning 
of the year. Order the result first by date 
(most recent first) and for entries of the same 
date by customer height (shortest to tallest).
*/

DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback
(
id					INTEGER(5),
customer_name		VARCHAR(30),
customer_email		VARCHAR(40),
customer_height		DECIMAL(3,2),
feedback_text		VARCHAR(200),
fb_date				DATE,
PRIMARY KEY(id)
);

INSERT INTO feedback VALUES
(12345, 'Donald Trump', 'president@usa.com', 1.9,'Did not include a border wall!', '1946-06-14'),
(98765, 'Boris Johnson', 'prime_minister@uk.com', 1.75, 'We will get Brexit finished!','1964-06-19'),
(12121, 'Leo Varadkar', 'taoiseach@ireland.com', 1.93, 'Hey Trudeau! Have you seen my socks?', '1979-01-18'),
(23456, 'Prince Harry', 'harry@royal.com', 1.86, 'I needed a Harry in March 2014', '2014-03-24'),
(34567, 'Harry Potter', 'harry@hogwarts.com', 1.8, 'Voldemort tried to give me a second lightning scar','2013-04-01'),
(45678, 'St Paddy', 'paddy@vatican.com', 1.7, 'Dunno lad, just got sick of the snakes','2019-03-17'),
(56789, 'Eminem', 'eminem@rapper.com', 1.68, 'Moms spaghetti','2019-03-17'),
(67890, 'Anne', 'anne@college.com', 1.65, 'Social Science','2019-06-15');

DELETE
FROM feedback
WHERE customer_name = 'Tom';

UPDATE feedback
SET customer_height = 1.75
WHERE customer_name = 'Paddy';

SELECT *
FROM feedback
WHERE customer_name LIKE '%Harry%' AND fb_date BETWEEN 2014-03-01 AND 2014-03-31;

SELECT *
FROM feedback
WHERE fb_date BETWEEN 2019-01-01 AND 2019-12-31
ORDER BY fb_date DESC, customer_height ASC;










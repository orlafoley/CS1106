/*The database for today’s lab is a simplified hotels reservation database that has the following schema.

hotels(hotel_num, hotel_name, city)
rooms(room_num, hotel_num, room_type, price)
bookings(hotel_num, guest_num, arr_date, dep_date, room_num)
guests(guest_num, guest_name, guest_address)

The data in the DB is sparse.
In order to test your queries, you will need to add suitable
data to verify that your queries are correct.*/

/*1.	List full details of all hotels in Cork.*/

SELECT *
FROM hotels
WHERE city = 'Cork';

/*2.	List names and addresses of all guests living in Limerick ordered by name.*/

SELECT guest_name, guest_address
FROM guests
WHERE guest_address LIKE '%Limerick%'
ORDER BY guest_name ASC;

/*3.	List the ids of all double rooms priced lower than e 70.00, in ascending order of price.*/

SELECT hotel_num, room_num
FROM rooms
WHERE room_type = 'double' AND price < 70;

/*4.	List bookings for which no dep date has been specified.*/

SELECT *
FROM bookings
WHERE dep_date IS NULL;

/*5.	How many hotels are there in total?*/

SELECT COUNT(hotel_num)
FROM hotels;

/*6.	List the ids of each hotel with the number of rooms it has for less than e 70.00.*/

SELECT hotel_num, COUNT(*)
FROM rooms
WHERE price < 70
GROUP BY hotel_num;

/*7.	List the names of each hotels with the number of rooms it has for less than e 70.00.*/
SELECT h.hotel_name, COUNT(*)
FROM rooms AS r
JOIN hotels AS h
ON r.hotel_num = h.hotel_num
WHERE r.price < 70
GROUP BY r.hotel_num;

/*8.	How many hotels are there that have double rooms for under e 70.00?*/

SELECT COUNT(*)
FROM rooms
WHERE price < 70 AND room_type = 'double';

/*9.	What is the average price per room over all?*/

SELECT AVG(price)
FROM rooms;

/*10.	What is the average price per room in Cork?*/

SELECT AVG(r.price)
FROM rooms AS r
JOIN hotels AS h
ON r.hotel_num = h.hotel_num
WHERE h.city = 'Cork';

/*11.	What is the average price per double room in Cork?*/

SELECT AVG(r.price)
FROM rooms AS r
JOIN hotels AS h
ON r.hotel_num = h.hotel_num
WHERE h.city = 'Cork' AND r.room_type = 'double';

/*12.	How many bookings have been made for November for each hotel?
(Count a booking if the arrival date occurs within that month.)*/

SELECT COUNT(*)
FROM bookings
WHERE MONTH(arr_date) = 11;

/*13.	List the price and type of all rooms in the “Hotel Splendide”.*/

SELECT r.room_type, r.price
FROM hotels AS h
JOIN rooms AS r
ON h.hotel_num = r.hotel_num
WHERE h.hotel_name = 'Hotel Splendide'
GROUP BY r.room_type, r.price;

/*14.	List the names all the hotels in Galway together with the number of rooms in each.*/

SELECT h.hotel_name, COUNT(*)
FROM hotels AS h
    JOIN rooms AS r
        ON h.hotel_num = r.hotel_num
WHERE h.city = 'Galway'
GROUP BY r.hotel_num
HAVING COUNT(*) > 1;

/*15.	List all the guests with a booking at the “Hotel Splendide” for the month of January.*/

SELECT g.guest_name
FROM hotels AS h
    JOIN bookings AS b
    JOIN guests AS g
        ON h.hotel_num = b.hotel_num
        AND b.guest_num = g.guest_num
WHERE h.hotel_name = 'Hotel Splendide' AND MONTH(b.arr_date) = 01;

/*16.	List all pairs of (different) hotels that have the same name.*/

SELECT h1.hotel_name
FROM hotels AS h1
JOIN hotels AS h2
ON h1.hotel_name = h2.hotel_name
AND h1.hotel_num < h2.hotel_num;

/*17.	List the names of all the guests currently staying at the “Hotel California”,
ordered by checkout date. (Hint: look up the function CURDATE().)*/

SELECT g.guest_name
FROM guests AS g
    JOIN bookings AS b
    JOIN hotels AS h
        ON h.hotel_num = b.hotel_num
        AND b.guest_num = g.guest_num
WHERE h.hotel_name = 'Hotel California'
  AND CURDATE() BETWEEN b.arr_date AND b.dep_date
ORDER BY b.dep_date DESC;

/*18.	List all customers who have separate bookings for two
distinct hotels in two different cities for the same dates.*/

SELECT *
FROM bookings AS b1
    JOIN bookings AS b2
    JOIN hotels AS h1
    JOIN hotels AS h2
    JOIN guests AS g
        ON b1.guest_num = g.guest_num
        AND b2.guest_num = g.guest_num
        AND h1.hotel_num = b1.hotel_num
        AND h2.hotel_num = b2.hotel_num
        AND b1.hotel_num < b2.hotel_num
WHERE b1.hotel_num != b2.hotel_num
AND h1.city != h2.city
AND b1.arr_date = b2.arr_date
AND b1.dep_date = b2.dep_date;

/*19.	List by name all guests who have stayed at the “Hotel California” on more than three occasions.*/

SELECT g.guest_name
FROM hotels AS h
JOIN bookings AS b
JOIN guests AS g
ON h.hotel_num = b.hotel_num
AND b.guest_num = g.guest_num
WHERE h.hotel_name = 'Hotel California'
GROUP BY b.guest_num
HAVING COUNT(*) > 3;

/*20.	Determine the occupancy of the “Hotel California” for New Year’s Day.
(The occupancy is the ratio of the number of bookings to the total number of rooms.)*/

SELECT (COUNT(*) / COUNT(DISTINCT r.room_num))
FROM hotels AS h
JOIN rooms AS r
JOIN bookings AS b
ON h.hotel_num = r.hotel_num
AND b.hotel_num = h.hotel_num
AND b.room_num = r.room_num
WHERE h.hotel_name = 'Hotel California'
AND YEAR(arr_date) != YEAR(dep_date)
OR (01 = MONTH(b.arr_date) AND 01 = DAY(b.arr_date))
GROUP BY b.hotel_num

/*21.	Which guest has made the greatest number of bookings in 2012?*/

SELECT g.guest_name
FROM bookings AS b
JOIN guests AS g
ON b.guest_num = g.guest_num
WHERE YEAR(b.arr_date) = 2012
GROUP BY b.guest_num
LIMIT 1;

/*22.	Which hotel has had the greatest number of guests stay during 2012?*/

SELECT h.hotel_name
FROM bookings AS b
JOIN hotels AS h
ON b.hotel_num = h.hotel_num
WHERE YEAR(b.arr_date) = 2012
GROUP BY b.hotel_num
ORDER BY COUNT(*) DESC
LIMIT 1;

/*23.	Find all pairs of guests that share the same address.*/

SELECT g1.guest_name, g2.guest_name
FROM guests AS g1
JOIN guests AS g2
ON g1.guest_address = g2.guest_address
AND g1.guest_num < g2.guest_num;

/*24.	What day during 2012 saw the greatest number of guests arrive?*/

SELECT arr_date
FROM bookings
WHERE YEAR(arr_date) = 2012
GROUP BY arr_date
ORDER BY COUNT(*) DESC
LIMIT 1;

/*25.	What was the longest stay by any guest during 2012? (Hint: Look up the DATEDIFF() function.)*/

SELECT MAX(DateDiff)
FROM
    (SELECT DATEDIFF(dep_date, arr_date) AS DateDiff
    FROM bookings) AS stay_length;

/*26.	Find all the available rooms in Hotel Magnifique on 1 January 2014. List both the rooms and the prices.*/

SELECT r.room_num, r.room_type, r.price
FROM rooms AS r
WHERE r.hotel_num =
    (SELECT h.hotel_num
    FROM hotels AS h
    WHERE h.hotel_name = 'Hotel Magnifique')
AND r.room_num NOT IN
    (SELECT b.room_num
    FROM rooms AS r
    JOIN hotels AS h
    JOIN bookings AS b
    ON r.hotel_num = h.hotel_num
    AND h.hotel_num = b.hotel_num
    AND b.room_num = r.room_num
    WHERE ('2014-01-01' BETWEEN b.arr_date AND b.dep_date)
    AND h.hotel_name = 'Hotel Magnifique');
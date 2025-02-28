USE swiggy;

SELECT * FROM restaurants;

-- 1. Which restaurant of abohar is visied by least number of people?

SELECT MIN(rating_count) AS 'rating_count' FROM restaurants WHERE city = "Abohar";
SELECT * FROM restaurants WHERE rating_count = 20 AND city = "Abohar";

SELECT * FROM restaurants WHERE 
		city = 'Abohar' AND rating_count = (
					SELECT MIN(rating_count) 
					FROM restaurants 
				WHERE city = 'Abohar');

-- 2. Which restaurant has generated maximum revenue all over india?

SELECT MAX(rating_count * cost) FROM restaurants;

SELECT * FROM restaurants WHERE 
		rating_count * cost = (SELECT MAX(rating_count * cost) FROM restaurants);

-- 3. How many restaurants are having rating more than the average rating?
SELECT AVG(rating) FROM restaurants;

SELECT COUNT(*) AS "total_restaurants" FROM restaurants 
	WHERE rating >= (SELECT AVG(rating) FROM restaurants);

-- 4. Which restaurant of Delhi has generated most revenue

SELECT MAX(rating_count * cost) FROM restaurants;
SELECT * FROM restaurants WHERE rating_count * cost = 5000000;

SELECT * FROM restaurants WHERE 
	rating_count*cost = (SELECT MAX(rating_count*cost) FROM restaurants) 
				AND city = "Delhi";

SELECT * FROM restaurants WHERE 
	rating_count * cost = (SELECT MAX(rating_count * cost) FROM restaurants 
		WHERE city = 'Delhi');

SELECT * FROM restaurants WHERE 
	rating_count * cost = (SELECT MAX(rating_count * cost) FROM restaurants 
		WHERE city = 'Delhi') AND city = 'Delhi';

-- 5. Which restaurant of more than average cost of an restaurant in Delhi has generated most revenue

SELECT * FROM restaurants WHERE 
	rating_count * cost = (SELECT MAX(rating_count * cost) FROM restaurants WHERE city = 'Delhi' )
					AND
					 cost > (SELECT AVG(cost) FROM restaurants WHERE city = 'Delhi')
							AND city = 'Delhi';
                        

-- 6. Which restaurant of more than average cost of an restaurant in Delhi has generated most revenue

SELECT city , SUM(rating_count) FROM restaurants 
	GROUP BY city 
		ORDER BY SUM(rating_count) 
			DESC LIMIT 5;

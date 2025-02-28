SELECT * FROM swiggy.restaurants;

-- 1. Which restaurant of abohar is visied by least number of people?
SELECT * FROM restaurants WHERE city = 'Abohar' AND rating_count = (SELECT MIN(rating_count) FROM restaurants WHERE city = 'Abohar');

-- 2. Which restaurant has generated maximum revenue all over india?
SELECT * FROM restaurants WHERE cost*rating_count = (SELECT MAX(cost*rating_count) FROM restaurants);

-- 3. How many restaurants are having rating more than the average rating?
SELECT * FROM restaurants WHERE rating > (SELECT AVG(rating) FROM restaurants);

-- 4. Which restaurant of Delhi has generated most revenue?
SELECT * FROM restaurants WHERE city = 'Delhi' AND 
		cost*rating_count = (SELECT MAX(cost*rating_count) FROM restaurants WHERE city = 'Delhi');

-- 5. Which restaurant chain has maximum number of restaurants?
SELECT name , COUNT(name) AS 'no_of_chains' FROM restaurants
GROUP BY name ORDER BY COUNT(name) DESC LIMIT 10;

-- 6. Which restaurant chain has generated maximum revenue?
SELECT name , SUM(rating_count * cost) AS 'revenue' FROM restaurants
GROUP BY name ORDER BY SUM(rating_count*cost) DESC LIMIT 10;

-- 7. Which city has maximum number of restaurants?
SELECT city , COUNT(*) AS 'no_of_restaurants' FROM restaurants
GROUP BY city ORDER BY COUNT(*) DESC LIMIT 10;

-- 8. Which city has generated maximum revenue all over india?
SELECT city , SUM(rating_count * cost) AS 'revenue' FROM restaurants
GROUP BY city ORDER BY SUM(rating_count*cost) DESC LIMIT 10;

-- 9. List 10 least expensive cuisines?
SELECT cuisine ,  AVG(cost) AS 'avg_cost' FROM restaurants
GROUP BY cuisine 
ORDER BY avg_cost ASC LIMIT 10;

-- 10. List 10 most expensive cuisines?
SELECT cuisine ,  AVG(cost) AS 'avg_cost' FROM restaurants
GROUP BY cuisine 
ORDER BY avg_cost DESC LIMIT 10;

-- 11. What is the city is having Biryani as most popular cuisine
SELECT city, AVG(cost), COUNT(*) AS 'restaurants' FROM restaurants
WHERE cuisine = 'Biryani'
GROUP BY city
ORDER BY restaurants DESC;

-- 12. List top 10 unique restaurants with unique name only thorughout the dataset as per generate maximum revenue (Single restaurant with that name)
SELECT name, SUM(cost * rating_count) AS 'revenue' FROM restaurants 
GROUP BY name HAVING COUNT(name) = 1
ORDER BY revenue DESC LIMIT 10;

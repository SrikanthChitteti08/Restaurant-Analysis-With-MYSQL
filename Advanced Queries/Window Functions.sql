USE swiggy;
SELECT * FROM restaurants;

-- 1. Create new column containing average rating of restaurants throughout the dataset
SELECT *, ROUND(AVG(rating) OVER(), 2) AS 'avg_rating' FROM restaurants;

-- 2. Create new column containing average rating_count of restaurants throughout the dataset
SELECT *, ROUND(AVG(rating_count) OVER(), 0) AS 'avg_rating_count' FROM restaurants;

-- 3. Create new column containing average cost of restaurants throughout the dataset
SELECT *, ROUND(AVG(cost) OVER(), 0) AS 'avg_cost' FROM restaurants;

-- 4. Create column containing average, min, max of cost, rating, rating_count of restaurants throughout the dataset
SELECT id, name, city, cuisine, rating,
	ROUND(MAX(rating) OVER(), 2) AS 'max_rating',
    ROUND(AVG(rating) OVER(), 2) AS 'avg_rating',
    ROUND(MIN(rating) OVER(), 2) AS 'min_rating',
    
    ROUND(MAX(cost) OVER(), 2) AS 'max_cost',
    ROUND(AVG(cost) OVER(), 2) AS 'avg_cost',
    ROUND(MIN(cost) OVER(), 2) AS 'min_cost'
    
FROM restaurants;

-- 5. Create column containing average cost of the city where that specific restaurant is from
SELECT *, ROUND(AVG(cost) OVER(PARTITION BY city)) AS 'avg_cost' FROM restaurants;

-- 6. Create column containing average cost of the cuisine which that specific restaurant is serving
SELECT *, ROUND(AVG(cost) OVER(PARTITION BY cuisine)) AS 'avg_cost' FROM restaurants;

-- 7. Create both columns together
SELECT *, 
	ROUND(AVG(cost) OVER(PARTITION BY city)) AS 'avg_cost_city',
    ROUND(AVG(cost) OVER(PARTITION BY cuisine)) AS 'avg_cost_cuisine'
FROM restaurants;

-- 8. List the restaurants whose cost is more than the average cost of the restaurants
SELECT * FROM restaurants WHERE cost > (SELECT AVG(cost) FROM restaurants);
SELECT * FROM (SELECT *, AVG(cost) OVER() AS 'avg_cost' FROM restaurants) t WHERE t.cost > t.avg_cost; 

-- 10. List the restaurants whose cuisine cost is more than the average cost
SELECT * FROM (SELECT *, AVG(cost) OVER(PARTITION BY cuisine) AS 'avg_cost' FROM restaurants) t WHERE t.cost > t.avg_cost;

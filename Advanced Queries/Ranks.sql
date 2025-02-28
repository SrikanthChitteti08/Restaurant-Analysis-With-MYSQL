USE swiggy;

SELECT * FROM restaurants;

-- 1. Rank every restaurant from most expensive to least expensive
SELECT * ,RANK() OVER(ORDER BY cost DESC) AS 'rank' FROM restaurants;

-- 2. Rank every restaurant from most visited to least visited
SELECT * ,RANK() OVER(ORDER BY rating_count DESC) AS 'rank' FROM restaurants;

-- 3. Rank every restaurant from most expensive to least expensive as per their city
SELECT * ,RANK() OVER(PARTITION BY city ORDER BY cost DESC) AS 'rank' FROM restaurants;

-- 4. Dense-rank every restaurant from most expensive to least expensive as per their city
SELECT * ,
	RANK() OVER(ORDER BY cost DESC) AS 'rank' ,
	DENSE_RANK() OVER(ORDER BY cost DESC) AS 'dense_rank' 
FROM restaurants;

-- 5. Row-number every restaurant from most expensive to least expensive as per their city
SELECT * ,
	RANK() OVER(ORDER BY cost DESC) AS 'rank' ,
	DENSE_RANK() OVER(ORDER BY cost DESC) AS 'dense_rank',
    ROW_NUMBER() OVER(ORDER BY cost DESC) AS 'row_number' 
FROM restaurants;

-- 6. Rank every restaurant from most expensive to least expensive as per their city along with its city [Adilabad - 1, Adilabad - 2]
SELECT *, CONCAT(city,' - ' ,ROW_NUMBER() OVER(PARTITION BY city ORDER BY cost DESC)) AS 'rank' FROM restaurants;

-- 7. Find top 5 restaurants of every city as per their revenue
SELECT * FROM (SELECT *, 
				cost*rating_count AS 'revenue', 
				ROW_NUMBER() OVER(PARTITION BY city ORDER BY rating_count*cost DESC) AS 'rank' FROM restaurants) t
WHERE t.rank < 6;

-- 8. Find top 5 restaurants of every cuisine as per their revenue
SELECT * FROM (SELECT *, 
				cost*rating_count AS 'revenue', 
				ROW_NUMBER() OVER(PARTITION BY cuisine ORDER BY rating_count*cost DESC) AS 'rank' FROM restaurants) t
WHERE t.rank < 6;

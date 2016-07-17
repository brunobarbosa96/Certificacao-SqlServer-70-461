---- [EXERCISE 2] ---- 
SELECT custid, 
	   YEAR(orderdate)
	FROM Sales.Orders
	ORDER BY 1, 2;

-- Correct
SELECT DISTINCT 
		custid, 
		YEAR(orderdate) AS orderYear
	FROM Sales.Orders


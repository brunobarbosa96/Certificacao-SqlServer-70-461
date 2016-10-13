-- Exercise 1
SELECT	C.custid, 
		C.city,
		COUNT(*) AS numorders
	FROM Sales.Customers AS C
		INNER JOIN Sales.Orders AS O
			ON C.custid = O.custid
	WHERE C.country = N'Spain'
	GROUP BY C.custid, C.city;


-- Exercise 2

SELECT	C.custid, 
		C.city,
		COUNT(*) AS numorders
	FROM Sales.Customers AS C
		INNER JOIN Sales.Orders AS O
			ON C.custid = O.custid
	WHERE C.country = N'Spain'
	GROUP BY GROUPING SETS 
	( 
		(C.custid, C.city),
		()
	)
	ORDER BY GROUPING(C.Custid);

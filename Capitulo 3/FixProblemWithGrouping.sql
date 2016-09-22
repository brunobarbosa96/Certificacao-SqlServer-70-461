SELECT custid, MAX(orderid) AS maxOrderid
	FROM Sales.Orders
	GROUP BY custid;


	-----------------

SELECT shipperid, SUM(freight) AS totalfreight
	FROM Sales.Orders
	--WHERE freight > 20000.00
	GROUP BY shipperid
	HAVING SUM(freight) > 20000.00;
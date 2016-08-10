SELECT orderid, empid, shipperid, shippeddate
	FROM Sales.Orders
	WHERE custid = 77
	ORDER BY empid;

SELECT orderid, empid, shipperid, shippeddate
	FROM Sales.Orders
	WHERE custid = 77
	ORDER BY shipperid, orderid DESC, shippeddate;


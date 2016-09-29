-- Exercise

--1 EXCEPT
SELECT empid
	FROM Sales.Orders
	WHERE custid = 1

EXCEPT

SELECT empid
	FROM Sales.Orders
	WHERE custid = 2;

--2 INTERSECT
SELECT empid
	FROM Sales.Orders
	WHERE custid = 1

INTERSECT

SELECT empid
	FROM Sales.Orders
	WHERE custid = 2	

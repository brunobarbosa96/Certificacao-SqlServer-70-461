-- Exercicio
USE TSQL2012
--1)

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE shippeddate = NULL;

-- resposta
	SELECT orderid, 
		   orderdate,
		   custid, 
		   empid
		FROM [Sales].[Orders]
		WHERE shippeddate IS NULL;

--2)
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate BETWEEN '20080211' AND '20080212 23:59:59.999';

-- resposta 

SELECT orderid, 
	   orderdate, 
	   custid, 
	   empid
	FROM [Sales].[Orders]
	WHERE orderdate >= '20080211' AND orderdate < '20080213'
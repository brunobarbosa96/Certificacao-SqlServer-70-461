--SET STATISTICS IO ON;
--DBCC DROPCLEANBUFFERS;
--SELECT * FROM Sales.Customers;
--SELECT * FROM Sales.Orders;

--SELECT C.custid, C.companyname,
--O.orderid, O.orderdate
--FROM Sales.Customers AS C
--INNER JOIN Sales.Orders AS O
--ON C.custid = O.custid
--SELECT C.custid, C.companyname,
--O.orderid, O.orderdate
--FROM Sales.Customers AS C
--INNER JOIN Sales.Orders AS O
--ON C.custid = O.custid
--WHERE O.custid < 5

--SET SHOWPLAN_ALL OFF
--SET SHOWPLAN_TEXT ON
----SET STATISTICS PROFILE OFF
--SELECT C.custid, C.companyname,
--O.orderid, O.orderdate
--FROM Sales.Customers AS C
--INNER JOIN Sales.Orders AS O
--ON C.custid = O.custid;	

SET STATISTICS TIME ON
SELECT C.custid, MIN(C.companyname) AS companyname,
COUNT(*) AS numorders
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
ON C.custid = O.custid
WHERE O.custid < 5
GROUP BY C.custid
HAVING COUNT(*) > 6;
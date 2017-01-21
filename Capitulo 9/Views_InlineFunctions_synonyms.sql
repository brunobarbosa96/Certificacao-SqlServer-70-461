-- Criando views
USE TSQL2012;
GO
CREATE VIEW Sales.OrderTotalsByYear
WITH SCHEMABINDING
AS
SELECT
		YEAR(O.orderdate) AS orderyear,
		SUM(OD.qty) AS qty
	FROM Sales.Orders AS O
		JOIN Sales.OrderDetails AS OD
		ON OD.orderid = O.orderid
	GROUP BY YEAR(orderdate);
GO

-- Selecionando dados da view 
SELECT orderyear, qty
FROM Sales.OrderTotalsByYear;

-- alterando uma view 
ALTER VIEW Sales.OrderTotalsByYear
WITH SCHEMABINDING
AS
SELECT
O.shipregion,
YEAR(O.orderdate) AS orderyear,
SUM(OD.qty) AS qty
FROM Sales.Orders AS O
JOIN Sales.OrderDetails AS OD
ON OD.orderid = O.orderid
GROUP BY YEAR(orderdate), O.shipregion;
GO

-- apagando a view
DROP VIEW Sales.OrderTotalsByYear;

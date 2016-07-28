-- Exercícios Capítulo 2

SELECT empid,
	   CONCAT(firstname, ' ', lastname) AS fullname,
	   YEAR(birthdate) AS birthyear
	FROM HR.Employees;

SELECT EOMONTH(GETDATE()) LastDayOfCurrentMonth,
	   EOMONTH(CONCAT(YEAR(GETDATE()), '-12-01')) LastDayOfCurrentYear,
	   EOMONTH(DATEFROMPARTS(YEAR(GETDATE()), 12, 01)) AS OtherLastDayOfCurrentYear

SELECT TOP 1 productId,
	   FORMAT(productid, 'd10') AS stringProductId
	FROM Production.Products;

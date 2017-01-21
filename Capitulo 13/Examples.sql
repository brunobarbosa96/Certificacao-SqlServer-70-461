INSERT INTO Sales.MyOrders(custid, empid, orderdate)
OUTPUT inserted.orderid, inserted.custid, inserted.empid, inserted.orderdate, Orders.orderid
	SELECT custid, empid, orderdate
	FROM Sales.Orders
WHERE shipcountry = N'Norway';


IF OBJECT_ID('Sales.ListSampleResultsSets', 'P') IS NOT NULL
DROP PROC Sales.ListSampleResultsSets;
GO
CREATE PROC Sales.ListSampleResultsSets
AS
BEGIN
SELECT TOP (1) productid, productname, supplierid,
categoryid, unitprice, discontinued
FROM Production.Products;
SELECT TOP (1) orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails;
END
GO
EXEC Sales.ListSampleResultsSets

IF OBJECT_ID('Production.tr_ProductionCategories_categoryname', 'TR') IS NOT NULL
DROP TRIGGER Production.tr_ProductionCategories_categoryname;
GO
CREATE TRIGGER Production.tr_ProductionCategories_categoryname
ON Production.Categories
AFTER INSERT, UPDATE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT COUNT(*)
FROM Inserted AS I
JOIN Production.Categories AS C
ON I.categoryname = C.categoryname
GROUP BY I.categoryname
HAVING COUNT(*) > 1 )
BEGIN
THROW 50000, 'Duplicate category names not allowed', 0;
END;
END;
GO

INSERT INTO Production.Categories (categoryname,description)
VALUES ('TestCategory1', 'Test1 description v1');


-- Gerando XML na estrutura automática

WITH XMLNAMESPACES('TK461-CustomersOrders' AS co)
SELECT	[co:Customer].custid AS [co:custid],
		[co:Customer].companyname AS [co:companyname],
		[co:Order].orderid AS [co:orderid],
		[co:Order].orderdate AS [co:orderdate]
	FROM Sales.Customers AS [co:Customer]
		INNER JOIN Sales.Orders AS [co:Order]
			ON [co:Customer].custid = [co:Order].custid
	WHERE [co:Customer].custid <= 2
		AND [co:Order].orderid %2 = 0
	ORDER BY [co:Customer].custid, [co:Order].orderid
	FOR XML AUTO, ELEMENTS, ROOT('CustomersOrders');


-- Exemplo do XML AUTO
SELECT	[Customer].custid AS [custid],
		[Customer].companyname AS [companyname],
		[Order].orderid AS [orderid],
		[Order].orderdate AS [orderdate]
FROM Sales.Customers AS [Customer]
INNER JOIN Sales.Orders AS [Order]
ON [Customer].custid = [Order].custid
WHERE 1 = 2
FOR XML AUTO, ELEMENTS,
XMLSCHEMA('TK461-CustomersOrders');


-- Exemplo do XML PATH
SELECT Customer.custid AS [@custid],
		Customer.companyname AS [companyname]
	FROM Sales.Customers AS Customer
	WHERE Customer.custid <= 2
	ORDER BY Customer.custid
	FOR XML PATH ('Customer'), ROOT('Customers');

SELECT	[Customer].custid AS [custid],
		[Customer].companyname AS [companyname],
		[Order].orderid AS [orderid],
		[Order].orderdate AS [orderdate]
	FROM Sales.Customers AS [Customer]
		INNER JOIN Sales.Orders AS [Order]
			ON [Customer].custid = [Order].custid
	WHERE 1 = 2
	FOR XML AUTO, ELEMENTS,
	XMLSCHEMA('TK461-CustomersOrders');



ALTER TABLE Production.Products
ADD additionalattributes XML NULL;

-- Auxiliary tables
CREATE TABLE dbo.Beverages
(
	percentvitaminsRDA INT
);
CREATE TABLE dbo.Condiments
(
	shortdescription NVARCHAR(50)
);
GO
-- Store the Schemas in a Variable and Create the Collection
DECLARE @mySchema NVARCHAR(MAX);
SET @mySchema = N'';
SET @mySchema = @mySchema +
(SELECT *
	FROM Beverages
	FOR XML AUTO, ELEMENTS, XMLSCHEMA('Beverages'));
SET @mySchema = @mySchema +
(SELECT *
	FROM Condiments
	FOR XML AUTO, ELEMENTS, XMLSCHEMA('Condiments'));
SELECT CAST(@mySchema AS XML);
CREATE XML SCHEMA COLLECTION dbo.ProductsAdditionalAttributes AS @mySchema;
GO
-- Drop Auxiliary Tables
DROP TABLE dbo.Beverages, dbo.Condiments;
GO


ALTER TABLE Production.Products
ALTER COLUMN additionalattributes
XML(dbo.ProductsAdditionalAttributes);


-- Function to Retrieve the Namespace
CREATE FUNCTION dbo.GetNamespace(@chkcol XML)
RETURNS NVARCHAR(15)
AS
BEGIN
	RETURN @chkcol.value('namespace-uri((/*)[1])','NVARCHAR(15)')
END;
GO
-- Function to Retrieve the Category Name
CREATE FUNCTION dbo.GetCategoryName(@catid INT)
RETURNS NVARCHAR(15)
AS
	BEGIN
		RETURN
			(SELECT categoryname
				FROM Production.Categories
				WHERE categoryid = @catid)
	END;
GO
-- Add the Constraint
ALTER TABLE Production.Products ADD CONSTRAINT ck_Namespace
CHECK (dbo.GetNamespace(additionalattributes) =
dbo.GetCategoryName(categoryid));
GO
-- Valid XML
-- Beverage
UPDATE Production.Products
SET additionalattributes = N'
<Beverages xmlns="Beverages">
<percentvitaminsRDA>27</percentvitaminsRDA>
</Beverages>'
WHERE productid = 1;
-- Condiment
UPDATE Production.Products
SET additionalattributes = N'
<Condiments xmlns="Condiments">
<shortdescription>very sweet</shortdescription>
</Condiments>'
WHERE productid = 3;


-- Invalid XML
-- String instead of int
UPDATE Production.Products
SET additionalattributes = N'
<Beverages xmlns="Beverages">
<percentvitaminsRDA>twenty seven</percentvitaminsRDA>
</Beverages>'
WHERE productid = 1;
-- Wrong namespace
UPDATE Production.Products
SET additionalattributes = N'
<Condiments xmlns="Condiments">
<shortdescription>very sweet</shortdescription>
</Condiments>'
WHERE productid = 2;
-- Wrong element
UPDATE Production.Products
SET additionalattributes = N'
<Condiments xmlns="Condiments">
<unknownelement>very sweet</unknownelement>
</Condiments>'
WHERE productid = 3;



-- Cleaning the database
ALTER TABLE Production.Products
	DROP CONSTRAINT ck_Namespace;
ALTER TABLE Production.Products
	DROP COLUMN additionalattributes;
DROP XML SCHEMA COLLECTION dbo.ProductsAdditionalAttributes;
DROP FUNCTION dbo.GetNamespace;
DROP FUNCTION dbo.GetCategoryName;
GO



-- using the value() and exist() XML data type methods.

DECLARE @x AS XML;
SET @x = N'
<CustomersOrders>
<Customer custid="1">
<!-- Comment 111 -->
<companyname>Customer NRZBB</companyname>
<Order orderid="10692">
<orderdate>2007-10-03T00:00:00</orderdate>
</Order>
<Order orderid="10702">
<orderdate>2007-10-13T00:00:00</orderdate>
</Order>
<Order orderid="10952">
<orderdate>2008-03-16T00:00:00</orderdate>
</Order>
</Customer>
<Customer custid="2">
<!-- Comment 222 -->
<companyname>Customer MLTDN</companyname>
<Order orderid="10308">
<orderdate>2006-09-18T00:00:00</orderdate>
</Order>
<Order orderid="10952">
<orderdate>2008-03-04T00:00:00</orderdate>
</Order>
</Customer>
</CustomersOrders>';

SELECT @x.value('(/CustomersOrders/Customer/companyname)[1]',
'NVARCHAR(20)')
AS [First Customer Name];

SELECT @x.exist('(/CustomersOrders/Customer/companyname)')
AS [Company Name Exists],
@x.exist('(/CustomersOrders/Customer/address)')
AS [Address Exists];



--Using the query(), nodes(), and modify() Methods
DECLARE @x AS XML;
SET @x = N'
<CustomersOrders>
<Customer custid="1">
<!-- Comment 111 -->
<companyname>Customer NRZBB</companyname>
<Order orderid="10692">
<orderdate>2007-10-03T00:00:00</orderdate>
</Order>
<Order orderid="10702">
<orderdate>2007-10-13T00:00:00</orderdate>
</Order>
<Order orderid="10952">
<orderdate>2008-03-16T00:00:00</orderdate>
</Order>
</Customer>
<Customer custid="2">
<!-- Comment 222 -->
<companyname>Customer MLTDN</companyname>
<Order orderid="10308">
<orderdate>2006-09-18T00:00:00</orderdate>
</Order>
<Order orderid="10952">
<orderdate>2008-03-04T00:00:00</orderdate>
</Order>
</Customer>
</CustomersOrders>';

SELECT @x.query('//Customer[@custid=1]/Order')
AS [Customer 1 orders];

SELECT T.c.value('./@orderid[1]', 'INT') AS [Order Id],
T.c.value('./orderdate[1]', 'DATETIME') AS [Order Date]
FROM @x.nodes('//Customer[@custid=1]/Order')
AS T(c);

SET @x.modify('replace value of
/CustomersOrders[1]/Customer[1]/companyname[1]/text()[1]
with "New Company Name"');
SELECT @x.value('(/CustomersOrders/Customer/companyname)[1]',
'NVARCHAR(20)')
AS [First Customer New Name];
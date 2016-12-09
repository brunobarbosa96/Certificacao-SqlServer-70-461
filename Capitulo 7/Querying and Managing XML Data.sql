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
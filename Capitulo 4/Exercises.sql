-- unit 4 - exercise 1

WITH prod AS  
(
	SELECT categoryid,
		   MIN(unitprice) AS minUnitPrice
		FROM Production.Products
		GROUP BY categoryid
)
 SELECT pr.productid,
		pr.productname,
		pr.supplierid,
		pr.discontinued,
		pr.categoryid,
		pr.unitprice,
		p.minUnitPrice
	FROM prod p WITH(NOLOCK)
		INNER JOIN Production.Products pr WITH(NOLOCK)
			ON pr.categoryid = p.categoryid;


-- exercise 2

-- Função que traz a quantidade de menores preços informados no parâmetro
IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL DROP FUNCTION Production.GetTopProducts;
GO

CREATE FUNCTION Production.GetTopProducts(@supplierid AS INT, @n AS BIGINT) 

RETURNS TABLE
AS

	RETURN
		SELECT productid,
			   productname,
			   unitprice
			FROM Production.Products
			WHERE supplierid = @supplierid
			ORDER BY unitprice, productid
			OFFSET 0 ROWS FETCH FIRST @n ROWS ONLY;
		
GO

-- exemplo de como executar a função
SELECT * FROM Production.GetTopProducts(1, 2);

--exercise 3
-- Exemplo de select com cross apply na function criada	
SELECT S.supplierid, 
	   S.companyname AS supplier, 
	   A.*
	FROM Production.Suppliers AS S
		CROSS APPLY Production.GetTopProducts(S.supplierid, 2) AS A
	WHERE S.country = N'Japan';

-- exercise 4	
-- Exemplo de select com outer apply na function criada	
SELECT S.supplierid, 
	   S.companyname AS supplier, 
	   A.*
	FROM Production.Suppliers AS S
		OUTER APPLY Production.GetTopProducts(S.supplierid, 2) AS A
	WHERE S.country = N'Japan';


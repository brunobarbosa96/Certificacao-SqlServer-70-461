-- CROSS JOIN
-- É uma junção comparada a um produto cartesiano entre duas tabelas
-- onde é realizado uma multiplicação de todos os registros retornando todas as possibilidades
-- de combinações possíveis

-- no exemplo abaixo está combinando todas as possibilidade de dias de semana com os dias 1,2 e 3...
SELECT D.n AS theday,
	   S.n AS shiftno
	FROM [dbo].[Nums] AS D
		CROSS JOIN [dbo].[Nums] AS S
	WHERE D.n <= 7
		AND S.n <= 3
	ORDER BY theday, shiftno;

-- INNER JOIN 
-- Inner join é uma junção na qual trará todos os campos que tem na primeira tabela e tem na segunda,
-- geralmente usados para trazer a intersecção da tabela a esquerda ligando a chave primária com a
-- chave estrangeira da tabela à direita

-- no exemplo abaixo está trazendo todos os 
SELECT S.companyname AS supplier,
	   S.country, 
	   P.productId,
	   P.productName,
	   P.unitPrice
	FROM [Production].[Suppliers] AS S
		INNER JOIN [Production].[Products] AS P
			ON S.supplierid = P.supplierid
		WHERE S.country LIKE N'Japan';


-- Exemplo LEFT OUTER JOIN ou LEFT JOIN da forma simplificada
-- o left join tras todos os registros da tabela da esquerda independentemente se tem ou não na tabela da direita,
-- quando não encontra registro na segunda tabela o resultado retornado vem null
-- Exemplo

SELECT
	S.companyname AS supplier, S.country,
	P.productid, P.productname, P.unitprice
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN Production.Products AS P
			ON S.supplierid = P.supplierid
	WHERE S.country = N'Japan';


-- Multi join - é possível combinar múltiplos joins em uma mesma query, por exemplo:

SELECT
	S.companyname AS supplier, S.country,
	P.productid, P.productname, P.unitprice,
	C.categoryname
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN Production.Products AS P
			ON S.supplierid = P.supplierid
		INNER JOIN Production.Categories AS C
			ON C.categoryid = P.categoryid
	WHERE S.country = N'Japan';



	SELECT
		S.companyname AS supplier, S.country,
		P.productid, P.productname, P.unitprice,
		C.categoryname
	FROM Production.Suppliers AS S
		LEFT OUTER JOIN
			(Production.Products AS P
				INNER JOIN Production.Categories AS C
				ON C.categoryid = P.categoryid)
		ON S.supplierid = P.supplierid
	WHERE S.country = N'Japan';


-- Exercise
-- Join
SELECT C.CustId,
	   C.CompanyName,
	   O.OrderId,
	   O.Orderdate
	FROM [Sales].[Customers] C WITH(NOLOCK)
		INNER JOIN [Sales].[Orders] O WITH(NOLOCK)
			ON O.CustId = C.CustId

-- Outer Join
SELECT C.CustId,
	   C.CompanyName,
	   O.OrderId,
	   O.Orderdate
	FROM [Sales].[Customers] C WITH(NOLOCK)
		LEFT OUTER JOIN [Sales].[Orders] O WITH(NOLOCK)
			ON O.CustId = C.CustId

-- apenas os customers sem orders
SELECT C.CustId,
	   C.CompanyName,
	   O.OrderId,
	   O.Orderdate
	FROM [Sales].[Customers] C WITH(NOLOCK)
		LEFT OUTER JOIN [Sales].[Orders] O WITH(NOLOCK)
			ON O.CustId = C.CustId
	WHERE O.CustId IS NULL

-- Adicionando filtros
SELECT C.CustId,
	   C.CompanyName,
	   O.OrderId,
	   O.Orderdate
	FROM [Sales].[Customers] C WITH(NOLOCK)
		LEFT OUTER JOIN [Sales].[Orders] O WITH(NOLOCK)
			ON O.CustId = C.CustId
				AND O.OrderDate >= '20080201'
				AND O.OrderDate < '20080301'
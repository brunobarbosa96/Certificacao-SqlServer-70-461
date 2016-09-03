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
-- Row Number é uma função como outra qualquer que tem o obetivo de retornar o numero da linha da
-- query que está sendo escrita de acordo com o que passar no over, esta função será estudada na unidade 5
-- mas por enquanto, ela retorna o numero da linha e pode ser usada apenas no select e no order by

SELECT
	ROW_NUMBER() OVER(PARTITION BY categoryid
	ORDER BY unitprice, productid) AS rownum,
	categoryid, 
	productid, 
	productname, 
	unitprice
FROM Production.Products;


-- como então podemos filtrar alguma coluna de acordo com o rownum sendo que não pode colocá-lo no WHERE
-- Resposta: Table Expressions
-- São espécies de tabelas temporárias ou tabelas derivadas que surgem atravez de uma query relacional

-- Tabelas Derivadas (Derived Tables) 
-- Selecionando apenas quem tiver rownum menor ou igual a 2

SELECT rownum, categoryid, productid, productname, unitprice
FROM  (SELECT
			ROW_NUMBER() OVER(PARTITION BY categoryid
			ORDER BY unitprice, productid) AS rownum,
			categoryid, 
			productid, 
			productname, 
			unitprice
		FROM Production.Products) AS p
		WHERE rownum <= 2;


-- Commom Table Expressions - CTEs

-- CTE são um tipo de tabelas temporárias que assim comos as derived tables, apenas funcionam na seção em que está sendo utilizada
-- a principal regra de uma CTE é deve se executar o comando que utiliza os resultados da query imediatamente após a sua declaração

-- exemplo

WITH C AS 
(
	SELECT
		ROW_NUMBER() OVER(PARTITION BY categoryid
		ORDER BY unitprice, productid) AS rownum,
		categoryid, 
		productid, 
		productname, 
		unitprice
	FROM Production.Products	
), C1 AS
(
	SELECT rownum,
	   categoryid,
	   productid,
	   productname,
	   unitprice
	FROM C
	WHERE rownum <= 2
	UNION
	SELECT 200 AS rownum,
		categoryid,
	   productid,
	   productname,
	   unitprice
		FROM Production.Products
)
SELECT * 
	FROM C1;


-- Recursão com CTE
-- Geralmente na recursão é utilizado o UNION ALL

-- Exemplo
WITH EmpsCTE AS
(
	SELECT empid, mgrid, firstname, lastname, 0 AS distance
		FROM HR.Employees
		WHERE empid = 9 -- ponto de start da recursão. Esse será o primeiro registro da busca
	UNION ALL
	SELECT M.empid, M.mgrid, M.firstname, M.lastname, S.distance + 1 AS distance
		FROM EmpsCTE AS S --  da um select na propria CTE para que busque a partir do ponto inicial todas as filhas que ele possue
			JOIN HR.Employees AS M -- com esse inner join ele varre todas as filhas e suas filhas recursivamente 
				ON S.mgrid = M.empid --até que encontre campos nulos para todas as saídas
)
SELECT empid, mgrid, firstname, lastname, distance
FROM EmpsCTE;
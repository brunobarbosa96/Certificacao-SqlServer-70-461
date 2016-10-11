-- Agrupamentos são, como o próprio nome diz, agrupar dados de acordo com alguma referência
-- não é obrigatório em uma cláusula o uso do Group By para estar agrupado, pois pode estar agrupado também por funções de agregação

-- Exemplo de agrupamento usando funções de agregação:
SELECT COUNT(*) AS numorders
	FROM Sales.Orders;

-- na função de agregação acima, irá agrupar todos os dados em um único grupo, já que não foi especificado outro

-- para especificar o agrupamento em outros grupo, ou agrupar sem usar funções de agregação, podemos utilizar o 
-- GROUP BY, como por exemplo: 

SELECT	shipperid, 
		YEAR(shippeddate) AS shippedyear,
		COUNT(*) AS numorders
	FROM Sales.Orders
	GROUP BY shipperid, YEAR(shippeddate);

-- Neste caso retorna o resultado de acordo com o shipper id e o ano de shippeddate, retornando a quantidade de numorders para cada grupo
-- o group by pode se usar vários argumentos como no exemplo anterior, como também um só.

-- Para filtrar os grupos, tem um comando parecido com o WHERE, o HAVING, ele somente pode ser usado para filtrar agrupamentos

-- Exemplo:
-- filtrando todos os registros que possuem shippeddate e após filtra os grupos que possuem menos de 100 numorders então executa o SELECT

SELECT	shipperid, 
		YEAR(shippeddate) AS shippedyear,
		COUNT(*) AS numorders
	FROM Sales.Orders
	WHERE shippeddate IS NOT NULL
	GROUP BY shipperid, YEAR(shippeddate)
	HAVING COUNT(*) < 100;


-- o T-SQL suporta vários tipos de funções de agregação, como por exemplo: COUNT, MAX, MIN, AVG e SUM

-- Exemplo
SELECT	shipperid,
		COUNT(*) AS numorders,
		COUNT(shippeddate) AS shippedorders,
		MIN(shippeddate) AS firstshipdate,
		MAX(shippeddate) AS lastshipdate,
		SUM(val) AS totalvalue
	FROM Sales.OrderValues
	GROUP BY shipperid;

-- Geralmente, as funções de agregação suportam a cláusula DISTINCT para não contabilizar registros que se repetirem no processo
-- porém este comando é mais comumente usado no COUNT


-- Exemplo:

SELECT	shipperid, 
		COUNT(DISTINCT shippeddate) AS numshippingdates,
		COUNT(shippeddate) AS numshippingdatesWithoutDistinct
	FROM Sales.Orders
	GROUP BY shipperid;
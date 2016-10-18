-- Pivot and unpivot data

-- Pivot é uma maneira de organizar dados que precisam ser co-relacionados em 3 atributos 
-- ou seja, basicamente, é a partir de um assunto agrupado, trazer os resultados calculados para cada item referente a alguma coisa
-- como por exemplo... saber todas as vendas de determinados produtos em determinados meses
-- a grosso modo ele pega um referencial relacionado com algo e transforma as linhas em colunas

--WITH PivotData AS
--(
--	SELECT
--	< grouping column >,
--	< spreading column >,
--	< aggregation column >
--	FROM < source table >
--)
--	SELECT < select list >
--	FROM PivotData
--	PIVOT( < aggregate function >(< aggregation column >)
--	FOR < spreading column > IN (< distinct spreading values >) ) AS P;

WITH PivotData AS
(
	SELECT
	custid , -- grouping column
	shipperid, -- spreading column
	freight -- aggregation column
	FROM Sales.Orders
)
	SELECT custid, [1], [2], [3]
	FROM PivotData
	PIVOT(SUM(freight) FOR shipperid IN ([1],[2],[3]) ) AS P;

-- no exemplo acima foi-se usado a CTE para exemplificar que deve ser usado apenas 3 campos para fazer o PIVOT
-- no caso se o select precisasse de mais campos teria que transformá-lo nos 3
-- mas não é obrigatório o uso de CTE's caso esteja tudo correto já, como por exemplo no exemplo abaixo:

SELECT custid, [1], [2], [3]
	FROM Sales.Orders
	PIVOT(SUM(freight) FOR shipperid IN ([1],[2],[3]) ) AS P;

-- porém no exemplo abaixo o pivot assume como base para ordenação de maneira diferente do exemplo com a CTE 



-- Unpivoting é exatamente o contrário do PIVOT, pois irá pegar registros que estão "pivotados" e o T-SQL tenta voltar eles a como era antes
-- A grosso modo é transformar colunas em linhas novamente

-- Segue exemplo

-- Guardando registros PIVOT em uma temporária

USE TSQL2012;
IF OBJECT_ID('Sales.FreightTotals') IS NOT NULL DROP TABLE Sales.FreightTotals;
GO
WITH PivotData AS
(
	SELECT
	custid , -- grouping column
	shipperid, -- spreading column
	freight -- aggregation column
	FROM Sales.Orders
)
SELECT *
INTO Sales.FreightTotals
FROM PivotData
PIVOT( SUM(freight) FOR shipperid IN ([1],[2],[3]) ) AS P;

SELECT * FROM Sales.FreightTotals;

-- Unpivoting
SELECT custid, shipperid, freight
	FROM Sales.FreightTotals
	UNPIVOT( freight FOR shipperid IN([1],[2],[3]) ) AS U;
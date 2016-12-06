-- Window Aggregate Functions

-- Funções de agregação são funções proporcionadas pelo T-SQL e pelo SQL stantard, que permite 
-- agregar dados de alguma maneira.. São exemplos de funções de agregação: SUM, COUNT, AVG, MIN, e MAX
-- junto à estas funções podemos usar o OVER, que mais adiante será explicado melhor

-- Exemplo:
SELECT	custid, 
		orderid,
		val,
		SUM(val) OVER(PARTITION BY custid) AS custtotal,
		SUM(val) OVER() AS grandtotal
FROM Sales.OrderValues;
-- No exemplo acima, podemos perceber que sem o uso do over, as tuplas não agrupadas vão causar um erro
-- este erro não ocorre utilizando o over, pois o over serve para indicar que esse agrupamento irá funcionar de forma apartada
-- diferentemente de funções de agregações normais, que todas as colunas devem ser agrupadas de alguma forma para funcionar
-- no exemplo em que o over é combiando com o partition, é executado a agregação de acordo com o campo particionado
-- quando não se passa nada, faz-se uma somatória total de todos os registros


-- As funções de agregação podem ser usadas em conjunto também, como por exemplo:
SELECT	custid, 
		orderid,
		val,
		CAST(100.0 * val / SUM(val) OVER(PARTITION BY custid) AS NUMERIC(5, 2)) AS pctcust,
		CAST(100.0 * val / SUM(val) OVER() AS NUMERIC(5, 2)) AS pcttotal
FROM Sales.OrderValues;


-- As agregações também podem ser dinâmica usando linhas acima ou abaixo da linha atual de acordo com o que você desejar
-- Segue algumas definições conforme cita no livro da certificação:
-- -> UNBOUNDED PRECEDING or FOLLOWING, meaning the beginning or end of the partition, respectively
-- -> CURRENT ROW, obviously representing the current row
-- -> <n> ROWS PRECEDING or FOLLOWING, meaning n rows before or after the current, respectively
-- Exemplo:

SELECT custid, orderid, orderdate, val,
	SUM(val) OVER(PARTITION BY custid
	ORDER BY orderdate, orderid
	ROWS BETWEEN UNBOUNDED PRECEDING
	AND CURRENT ROW) AS runningtotal
FROM Sales.OrderValues;
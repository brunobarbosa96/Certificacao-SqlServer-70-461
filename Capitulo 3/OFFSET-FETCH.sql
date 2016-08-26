-- Exemplos TOP

-- Seleciona os 10 primeiros da execução do select
SELECT TOP 10 orderid, orderdate, custid, empid
	FROM Sales.Orders

-- seleciona os primeiros equivalente a porcentagem do total de registros da tabela arredondando pra cima
SELECT TOP 1 PERCENT orderid, orderdate, custid, empid
	FROM Sales.Orders

-- trás o top 1, porém se os registros que vierem na cláusula order by forem repetidos ele trás também
-- WITH TIES é obrigatório ser usado com o ORDER BY, ao contrário to TOP isoladamente
SELECT TOP 1 WITH TIES orderid, orderdate, custid, empid
	FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC



-- Exemplos OFFSET-FETCH

-- Ignora os primeiros 50 registros do select e traz os próximos 25
SELECT orderid, orderdate, custid, empid
	FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC
	OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;

-- Trazendo todos os registros com exceção dos 50 primeiros do retorno do select
SELECT orderid, orderdate, custid, empid
	FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC
	OFFSET 50 ROWS;


-- Exemplo de paginação com OFFSET-FETCH
DECLARE @pagesize AS BIGINT = 20, @pagenum AS BIGINT = 2;
SELECT orderid, 
	   orderdate, 
	   custid, 
	   empid
	FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC
	OFFSET (@pagesize - 1) * @pagesize ROWS FETCH NEXT @pagesize ROWS ONLY;



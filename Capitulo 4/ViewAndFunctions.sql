-- Views são uma espécie de tabela virtual, onde você define os dados que ela devem retornar
-- para reaproveitá-la de onde quiser, desde que tenha permissão para acessá-la, assim como tabelas normals
-- as Views são muito utilizadas para selects repetitivos com muitos joins na qual se utiliza com frequencia
-- as Views permite que você faça todas as operações normalmente como se fosse uma tabela, porém não permite a
-- passagem de parâmetros para sua execução;


-- Exemplo

IF OBJECT_ID('Sales.RankedProducts', 'V') IS NOT NULL DROP VIEW Sales.RankedProducts;
GO

CREATE VIEW Sales.RankedProducts
AS

	SELECT
		ROW_NUMBER() OVER(PARTITION BY categoryid ORDER BY unitprice, productid) AS rownum,
		categoryid, 
		productid, 
		productname, 
		unitprice
	FROM Production.Products;

GO

-- Selecionando os registros da View criada
SELECT *
	FROM  Sales.RankedProducts


-- Functions são como o próprio nome diz, funções que podemos criar do SQL para executar determinado bloco de código
-- No exemplo abaixo, mostra uma function que retorna uma tabela, e assim podemos utilizar esta tabela dinamicamente 
-- tendo a possibilidade de mandar parâmetros dinâmicos, diferentemente das views

-- Exemplo

IF OBJECT_ID('HR.GetManagers', 'IF') IS NOT NULL DROP FUNCTION HR.GetManagers;
GO

CREATE FUNCTION HR.GetManagers(@empid AS INT) RETURNS TABLE
AS

	RETURN	
		WITH EmpsCTE AS
		(
			SELECT empid, mgrid, firstname, lastname, 0 AS distance
				FROM HR.Employees
				WHERE empid = @empid
			UNION ALL
			SELECT M.empid, M.mgrid, M.firstname, M.lastname, S.distance + 1 AS distance
				FROM EmpsCTE AS S
					JOIN HR.Employees AS M
						ON S.mgrid = M.empid
		)
		SELECT empid, mgrid, firstname, lastname, distance
		FROM EmpsCTE;

GO


-- a função também pode ser usada de qualquer lugar independente da seção em que se encontra 
-- como o resultado da function é uma tabela, pode se fazer joins com este resultado normalmente
-- utilizando como uma tabela dinamica;

-- Exemplo
SELECT * 
	FROM HR.GetManagers(5) a 
		join HR.Employees e
			on e.empid = a.empid
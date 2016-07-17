 --Cláusula HAVING com GROUP BY – A cláusula HAVING determina uma condição de busca para um grupo ou um conjunto de registros,
 -- definindo critérios para limitar os resultados obtidos a partir do agrupamento de registros. É importante lembrar que essa 
 --cláusula só pode ser usada em parceria com GROUP BY.
 -- Dentro de cada um dos grupos, a cláusula HAVING pode ser usada para restringir apenas os registros que possuem numemployees
 -- superior a 1, por exemplo.
 --Obs: O HAVING é diferente do WHERE. O WHERE restringe os resultados obtidos sempre após o uso da cláusula FROM, 
 --ao passo que a cláusula HAVING filtra o retorno do agrupamento.


SELECT country, YEAR(hiredate) AS yearhired, COUNT(*) AS numemployees
	FROM HR.Employees
	WHERE hiredate >= '20000101'
	GROUP BY country, YEAR(hiredate)
	HAVING COUNT(*) > 1
	ORDER BY country , yearhired DESC;

--SEM USAR HAVING
SELECT country, yearhired, numemployees FROM (
	SELECT country, YEAR(hiredate) AS yearhired, COUNT(*) AS numemployees
		FROM HR.Employees
		WHERE hiredate >= '20000101'
		GROUP BY country, YEAR(hiredate)
		)x
	WHERE x.numemployees > 1
	ORDER BY x.country , x.yearhired DESC

	
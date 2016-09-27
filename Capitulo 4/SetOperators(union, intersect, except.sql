-- DICA: 
	--As operações descritas abaixo funcionam da mesma forma que as operções matemáticas.

	-- Para executar esses "set operators" é necessário que ambos os selects possuam a mesma quantidade de colunas e 
	-- o tipo delas sejam compatíveis

	-- Em uma query que usa mais de um desses operadores é importante saber que INTERSET tem prioridade sobre UNION e EXCEPT 
	-- enquanto EXCEPT e UNION tem a mesma prioridade
	-- porém você pode mudar isso forçando a prioridade com parênteses ();


-- Union é um operador que une os dois selects aplicando um distinct entre eles
-- ou seja, traz o resultado de ambos os selects unidos no mesmo resultado porém não traz nada duplicado

SELECT country,
	   region,
	   city
	FROM HR.Employees

UNION

SELECT country,
	   region,
	   city
	FROM Sales.Customers;


-- Union All é um operador que trabalha da mesmma forma que o union, porém ele traz todos os registros
-- das tabelas que retornadas nos selects independentemente se repete ou não.

SELECT country,
	   region,
	   city
	FROM HR.Employees

UNION ALL

SELECT country,
	   region,
	   city
	FROM Sales.Customers;

-- INTERSECT é um operador que trabalha com mais de um select, trazendo como retorno tudo que tem em comum entre ambos
-- ao contrário do union que traz tudo junto, este apenas trás quem tem em comum, exatamente como aprendemos na intersecção na matemática.


SELECT country,
	   region,
	   city
	FROM HR.Employees

INTERSECT

SELECT country,
	   region,
	   city
	FROM Sales.Customers;

-- EXCEPT - é um operador que traz tudo que está na primeira query exceto os registro da primeira que aparece na segunda
-- em outras palavras é uma exceção.. exemplo: traz pra mim todos os registros desse select que não esteja nesse outro.. 
--exemplo:

SELECT country,
	   region,
	   city
	FROM HR.Employees

EXCEPT

SELECT country,
	   region,
	   city
	FROM Sales.Customers;


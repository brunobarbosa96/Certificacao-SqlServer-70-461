--Case Scenario 1: Code Review

--1. R: Eu recomendaria que o cliente para que ele uilizasse mais as funções de "SET" como o UNION, EXCEPT e INTERSECT
-- por exemplo, para que diminuisse a complexidade dos subselects. Também recomendaria que usasse APPLY OPERATORS 
-- Table Functions e CTE's para os casos que precisam de repetição de código. Dessa forma acredito que já melhoraria muito
-- a complexidade do código e principalmente a performance das querys.

--2. R: Neste caso recomendaria que utilizasse VIEW para não precisar repetir a seleção dos dados que sempre será utilizados
-- e ao invés de cursor, usar operadores como CROSS APPLY E OUTER APPLY por exemplo.

--3. R: Neste caso recomendaria que criasse os índices nos campos mais utilizados para os JOINS, pois isto melhoraria muito a performance deles.



--Case Scenario 2: Explaining Set Operators

--1. R: Sugeria que indexasse a View para melhorar a performance das querys

--2. R: Os operadores como INTERSECT e EXCEPT além de deixar o código mais simples e legível
-- do que usar operadores como inner e outer joins propõe para nós também um ganho de performance
-- já que estes são específicos para executar esta tarefa


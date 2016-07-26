-- Caracter Functions

-- Exemplos Concatenação

-- concatenação utilizando o '+' porém, dessa forma quando há algum valor null toda a string se torna null também
SELECT empid, 
	   country, 
	   region, 
	   city,
	   country + N',' + region + N',' + city AS location
	FROM HR.Employees;

-- COALASCE serve para pegar o primeiro valor não nulo encontrado na expressão
SELECT empid, 
	   country, 
	   region, 
	   city,
	   country + COALESCE( N',' + region, N'') + N',' + city AS location
	FROM HR.Employees;


-- CONCAT ele já serve para concatenar a string toda já trocando valores nulos por vazio
SELECT empid, 
	   country, 
	   region, 
	   city,
	   CONCAT(country, N',' + region, N',' + city) AS location
	FROM HR.Employees;

-- Manipulação de strings

-- SUBSTRING primiero parâmetro: string, segundo parâmetro: onde vai começar a ler, terceiro parâmetro: quantas posições
-- LEFT OU RIGHT recebe a string como primeiro parâmetro e quantos posições ele vai percorrer, da esquerda pra direita ou da direita para a esquerda, respectivamente
-- CHARINDEX retorna o index da primeira aparição do caractere especificado no primeiro parâmetro 
-- PATINDEX funciona como o CHARINDEX porém assim como o LIKE o PARINDEX busca por um padrão especificado, por exemplo achar numeros entre uma string
-- LEN retorna a quantidade de caracteres contida na string
-- DATALENGTH retorna a quantidade de bytes que tem a string  

--Exemplo:

DECLARE @Nome varchar(20) = 'Bruno Barbosa'
SELECT SUBSTRING(@Nome, 1 , 5) AS "SUBSTRING",
	   
	   LEFT(@Nome, 5) AS "LEFT",
	   
	   RIGHT(@Nome, 7) AS "RIGHT",
	   
	   CHARINDEX(' ', @Nome) AS "CHARINDEX",
	   
	   LEFT(@nome, CHARINDEX(' ', @nome) -1) AS "LEFT CHARINDEX",
	   
	   PATINDEX('%[0-9]%', 'ASUASBUAB1234TESTE') AS "PATINDEX",

	   LEN(@nome) AS "LEN",
	   LEN(N'Bruno Barbosa') AS "LEN NVARCHAR",

	   DATALENGTH(@nome) AS "DATALENGTH",
	   DATALENGTH(N'Bruno Barbosa') AS "DATALENGTH NVARChAR"

-- REPLACE para trocar algum caracter por outro
-- REPLICATE replica algum caracter,
-- STUFF ele possui 4 argumentos, o primeiro é a string, o segundo é de onde ele vai começar a ler, o terceiro é o caracter que vai remover
--	e o quarto o caracter que ele vai inserir no lugar... alterando a string

-- Exemplo
SELECT REPLACE('0.1.2.3.4', '.', '/') AS "REPLACE",
	   REPLICATE('0', 10) AS "REPLICATE",
	   STUFF('.Brunoo Barbosa.', 1, 1, '') AS "STUFF"


-- Formatação de strings
--UPPER deixa string em caixa alta
--LOWER deixa string em caixa baixa
--LTRIM remove os brancos da esquerda
--RTRIM remove os brancos da direita
--FORMAT formata a string no padrão que mandar

-- Exemplo
SELECT UPPER('bruno barbosa') AS "UPPER",
	   LOWER('BRUNO BARBOSA') AS "LOWER",
	   LTRIM(' Bruno Barbosa ') AS "LTRIM",
	   RTRIM(' Bruno Barbosa ') AS "RTRIM",
	   FORMAT(123, '00000') AS "FORMAT"

-- CASE EXEMPLO -- o CASE retorna valores de acordo com a clausula WHEN
SELECT productid, 
	   productname, 
	   unitprice, 
	   discontinued,
	   CASE discontinued
			WHEN 0 THEN 'No'
			WHEN 1 THEN 'Yes'
			ELSE 'Unknown'
	   END AS discontinued_desc
	FROM Production.Products;

SELECT productid, 
	   productname, 
	   unitprice,
	   CASE
			WHEN unitprice < 20.00 THEN 'Low'
			WHEN unitprice < 40.00 THEN 'Medium'
			WHEN unitprice >= 40.00 THEN 'High'
			ELSE 'Unknown'
	   END AS pricerange
	FROM Production.Products;
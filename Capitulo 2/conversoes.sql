-- Exemplos conversoes

-- inplícitas
DECLARE @numero int = '1',
		@string char(10) = 123456,
		@data	date = '2016-07-22'

SELECT @numero AS numero,
	   @string AS string,
	   @data	   AS Date

-- explícitas

SELECT CAST(@numero AS INT) AS numero,
	   CAST(@string AS char(10)) AS string,
	   
	   TRY_CAST('abc' AS INT) AS "Conversao que retorna NULL"--,
	   --CAST ('abc' AS INT) AS "Erro conversao passível de erro"

-- Diferença entre CAST, CONVERT e PARSE

SELECT CAST('2016-07-22' AS DATE) AS conversaoDataComCAST
-- A conversão do cast não precisa passar mais nenhum parâmetro
-- a não ser o que eu quero converter e para qual tipo

SELECT CONVERT(DATETIME, '2016-07-22', 101) AS conversaoDataComCONVERT
-- A conversão com o convert deve ser feita, passando como primeiro argumento o
-- tipo do dado após a conversão, a expressão que deve ser convertida e como ultimo parâmetro
-- deve se passar o codigo do estilo que vai ser usado, 101 por exemplo representa
-- o pradrão dos EUA

SELECT PARSE('2016-07-22' AS DATE USING 'en-US') AS conversaoDataComPARSE
-- Para a conversão com o método parse, deve ser informado como primeiro parâmetro o valor 
-- da expressão que quero converter apelidando com o tipo e logo após o using para informar
-- qual a cultura que quero usar, lembrando que suporta algumas culturas contidas no .NET

SELECT 1 + 1,
	   1 + '1',
	   1 + '1' + '1',
	   '1' + '1',
	   '1' + '1' + '1' + 'TESTE'
	   --1 + '1' + 'TESTE' -- este irá falhar pois o SQL tentará fazer uma conversão implícita começando pelo menor tipo
							-- e quando chegar no tipo char de teste não conseguirá converter para int
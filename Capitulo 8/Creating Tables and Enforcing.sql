-- Criando tabelas no banco de dados

-- Exemplo:
CREATE TABLE Production.Categories(
	categoryid INT IDENTITY(1,1) NOT NULL,
	categoryname NVARCHAR(15) NOT NULL,
	description NVARCHAR(200) NOT NULL)
GO



-- Setando um valor padrão para ser inserido quando não for informado nada no campo
CREATE TABLE Production.Categories
(
categoryid INT NOT NULL IDENTITY,
categoryname NVARCHAR(15) NOT NULL,
description NVARCHAR(200) NOT NULL DEFAULT (''),
CONSTRAINT PK_Categories PRIMARY KEY(categoryid)
);


-- para ver todas as chaves primárias do sistema
SELECT *
FROM sys.key_constraints
WHERE type = 'PK';

-- para ver os indexes do banco 
SELECT *
FROM sys.indexes
WHERE object_id = OBJECT_ID('Production.Categories') AND name = 'PK_Categories';
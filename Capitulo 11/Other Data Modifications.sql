-- Criando tabela
IF OBJECT_ID('Sales.MyOrders') IS NOT NULL DROP TABLE Sales.MyOrders;
GO
CREATE TABLE Sales.MyOrders
(
orderid INT NOT NULL
CONSTRAINT PK_MyOrders_orderid PRIMARY KEY,
custid INT NOT NULL
CONSTRAINT CHK_MyOrders_custid CHECK(custid > 0),
empid INT NOT NULL
CONSTRAINT CHK_MyOrders_empid CHECK(empid > 0),
orderdate DATE NOT NULL
);

-- criando sequence
CREATE SEQUENCE Sales.SeqOrderIDs AS INT
MINVALUE 1
CYCLE;

-- Alteranod a tabela para ter o sequence como default constraint
ALTER TABLE Sales.MyOrders
ADD CONSTRAINT DFT_MyOrders_orderid
DEFAULT(NEXT VALUE FOR Sales.SeqOrderIDs) FOR orderid;


-- limpando tabela e zerando o sequence
TRUNCATE TABLE Sales.MyOrders;
ALTER SEQUENCE Sales.SeqOrderIDs RESTART WITH 1;

-- Declarando variáveis
--DECLARE
--@orderid AS INT = 1,
--@custid AS INT = 1,
--@empid AS INT = 2,
--@orderdate AS DATE = '20120620';
--SELECT *
--FROM (SELECT @orderid, @custid, @empid, @orderdate )
--AS SRC( orderid, custid, empid, orderdate );

-- Declarando variáveis com construtor
--DECLARE
--@orderid AS INT = 1,
--@custid AS INT = 1,
--@empid AS INT = 2,
--@orderdate AS DATE = '20120620';
--SELECT *
--FROM (VALUES(@orderid, @custid, @empid, @orderdate))
--AS SRC( orderid, custid, empid, orderdate);


DECLARE
	@orderid AS INT = 1,
	@custid AS INT = 1,
	@empid AS INT = 2,
	@orderdate AS DATE = '20120620';

MERGE INTO Sales.MyOrders WITH (HOLDLOCK) AS TGT
USING (VALUES(@orderid, @custid, @empid, @orderdate))
AS SRC( orderid, custid, empid, orderdate)
ON SRC.orderid = TGT.orderid
WHEN MATCHED THEN UPDATE
SET TGT.custid = SRC.custid,
TGT.empid = SRC.empid,
TGT.orderdate = SRC.orderdate
WHEN NOT MATCHED THEN INSERT
VALUES(SRC.orderid, SRC.custid, SRC.empid, SRC.orderdate);
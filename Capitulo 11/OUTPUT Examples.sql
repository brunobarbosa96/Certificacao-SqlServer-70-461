DECLARE @Orders AS TABLE
(
orderid INT NOT NULL PRIMARY KEY,
custid INT NOT NULL,
empid INT NOT NULL,
orderdate DATE NOT NULL
);
INSERT INTO @Orders(orderid, custid, empid, orderdate) VALUES
(2, 1, 3, '20120612'),
(3, 2, 2, '20120612'),
(4, 3, 5, '20120612');
MERGE INTO Sales.MyOrders AS TGT
USING @Orders AS SRC
ON SRC.orderid = TGT.orderid
WHEN MATCHED AND ( TGT.custid <> SRC.custid
OR TGT.empid <> SRC.empid
OR TGT.orderdate <> SRC.orderdate) THEN UPDATE
SET TGT.custid = SRC.custid,
TGT.empid = SRC.empid,
TGT.orderdate = SRC.orderdate
WHEN NOT MATCHED THEN INSERT
VALUES(SRC.orderid, SRC.custid, SRC.empid, SRC.orderdate)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;


select * from Sales.MyOrders

-------------------------------------------------------------------------

IF OBJECT_ID('Sales.MyOrders') IS NOT NULL DROP TABLE Sales.MyOrders;
IF OBJECT_ID('Sales.SeqOrderIDs') IS NOT NULL DROP SEQUENCE Sales.SeqOrderIDs;
CREATE SEQUENCE Sales.SeqOrderIDs AS INT
MINVALUE 1
CYCLE;
CREATE TABLE Sales.MyOrders
(
orderid INT NOT NULL
CONSTRAINT PK_MyOrders_orderid PRIMARY KEY
CONSTRAINT DFT_MyOrders_orderid
DEFAULT(NEXT VALUE FOR Sales.SeqOrderIDs),
custid INT NOT NULL
CONSTRAINT CHK_MyOrders_custid CHECK(custid > 0),
empid INT NOT NULL
CONSTRAINT CHK_MyOrders_empid CHECK(empid > 0),
orderdate DATE NOT NULL
);


INSERT INTO Sales.MyOrders(custid, empid, orderdate)
OUTPUT
	inserted.orderid, inserted.custid, inserted.empid, inserted.orderdate
SELECT custid, empid, orderdate
FROM Sales.Orders
WHERE shipcountry = N'Norway';

DELETE FROM Sales.MyOrders
OUTPUT deleted.orderid
WHERE empid = 1;

UPDATE Sales.MyOrders
SET orderdate = DATEADD(day, 1, orderdate)
OUTPUT
	inserted.orderid,
	deleted.orderdate AS old_orderdate,
	inserted.orderdate AS neworderdate
WHERE empid = 7;




DECLARE @InsertedOrders AS TABLE
(
orderid INT NOT NULL PRIMARY KEY,
custid INT NOT NULL,
empid INT NOT NULL,
orderdate DATE NOT NULL
);
INSERT INTO @InsertedOrders(orderid, custid, empid, orderdate)
SELECT orderid, custid, empid, orderdate
FROM (MERGE INTO Sales.MyOrders AS TGT
USING (VALUES(1, 70, 1, '20061218'),
(2, 70, 7, '20070429'),
(3, 70, 7, '20070820'),
(4, 70, 3, '20080114'),
(5, 70, 1, '20080226'),
(6, 70, 2, '20080410'))
AS SRC(orderid, custid, empid, orderdate )
ON SRC.orderid = TGT.orderid
WHEN MATCHED AND ( TGT.custid <> SRC.custid
OR TGT.empid <> SRC.empid
OR TGT.orderdate <> SRC.orderdate) THEN UPDATE
SET TGT.custid = SRC.custid,
TGT.empid = SRC.empid,
TGT.orderdate = SRC.orderdate
WHEN NOT MATCHED THEN INSERT
VALUES(SRC.orderid, SRC.custid, SRC.empid, SRC.orderdate)
WHEN NOT MATCHED BY SOURCE THEN
DELETE
OUTPUT
$action AS the_action, inserted.*) AS D
WHERE the_action = 'INSERT';
SELECT *
FROM @InsertedOrders;
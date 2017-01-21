USE TSQL2012;
BEGIN TRAN;

UPDATE HR.Employees
SET Region = N'10004'
WHERE empid = 1

UPDATE Production.Suppliers
SET Fax = N'555-1212'
WHERE supplierid = 1

COMMIT TRAN;
rollback
select * from HR.Employees
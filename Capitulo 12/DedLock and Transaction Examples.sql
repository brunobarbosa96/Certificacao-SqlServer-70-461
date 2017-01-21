USE TSQL2012;
BEGIN TRAN;

UPDATE HR.Employees
SET phone = N'555-9999'
WHERE empid = 1

UPDATE Production.Suppliers
SET Fax = N'555-1212'
WHERE supplierid = 1

COMMIT TRAN;
rollback
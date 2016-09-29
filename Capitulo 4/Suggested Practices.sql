-- Practice 1

SELECT *
 FROM Sales.Orders so WITH(NOLOCK)
	INNER JOIN Sales.Customers sc WITH(NOLOCK)
		ON sc.custid = so.custid
	INNER JOIN HR.Employees he WITH(NOLOCK)
		ON he.empid = so.empid
	INNER JOIN Sales.Shippers ss WITH(NOLOCK)
		ON ss.shipperid = so.shipperid

-- Practice 2

-- pegando os empid que não possuem orders em 12/02/2008
SELECT empid
	FROM HR.Employees WITH(NOLOCK)
EXCEPT
SELECT empid
	FROM Sales.Orders WITH(NOLOCK)
	WHERE orderdate = '2008-02-12'

-- exemplo com a query do exercício 1
SELECT *
 FROM Sales.Orders so WITH(NOLOCK)
	INNER JOIN Sales.Customers sc WITH(NOLOCK)
		ON sc.custid = so.custid
	INNER JOIN HR.Employees he WITH(NOLOCK)
		ON he.empid = so.empid
	INNER JOIN Sales.Shippers ss WITH(NOLOCK)
		ON ss.shipperid = so.shipperid
	WHERE so.empid IN (
						SELECT empid
							FROM HR.Employees WITH(NOLOCK)
						EXCEPT
						SELECT empid
							FROM Sales.Orders WITH(NOLOCK)
							WHERE orderdate = '2008-02-12'
						)

/*
REALIZAR LAS SIGUIENTES ASIGNACIONES

1 CREAR UNA VISTA CON LA SIGUIENTE INFORMACION DE LOS EMPLEADOS, ID, NOMBRE, TELEFONO Y E-MAIL

2-CREAR VISTA CON LA SIGIUENTE INFORMACIONDE LOS PRODUCTOS: ID, NOMBRE, PRECIO, SUBCATEGORIA Y CATEGORIA.

3- CREAR 2 STORED PROCEDURE  usando join, case, el primero sin parametros y el segundo con parametros. 

4-LISTAR LOS EMPLEADOS POR DEPARTAMENTO.

5- LISTAR LOS 10 PRODUCTOS MAS VENDIDOS

6-LISTAR LOS 10 PRODUCTOS MENOS VENDIDOS.

7-LISTAR LAS VENTAS POR TERRITORIO.

8-BUSCAR LOS DEPARTAMENTO QUE TENGAN MAYOR DE 5 EMPLEADOS

9-CLIENTES QUE HAYAN GENERADO MAS DE 3 ORDENES

10 CLIENTES QUE NO HAYAN GENERADO NINGUNA ORDEN

Saturday, 24 de July de 2021, 23:59
*/


use AdventureWorks2019;
go

USE AdventureWorks2019
GO
ALTER AUTHORIZATION ON DATABASE::AdventureWorks2019 TO [sa]
GO


--1 CREAR UNA VISTA CON LA SIGUIENTE INFORMACION DE LOS EMPLEADOS, ID, NOMBRE, TELEFONO Y E-MAIL
Drop view if EXISTS ViewInfoEmpleados;
go

Create view ViewInfoEmpleados as (
	select Person.Person.BusinessEntityID, Person.Person.FirstName, Person.Person.LastName, Person.EmailAddress.EmailAddress, Person.PersonPhone.PhoneNumber 
	from Person.Person 
	inner join Person.EmailAddress 
	on Person.Person.BusinessEntityID = Person.EmailAddress.BusinessEntityID
	inner join Person.PersonPhone
	on Person.Person.BusinessEntityID = Person.PersonPhone.BusinessEntityID
);
go

select * from ViewInfoEmpleados;

--2-CREAR VISTA CON LA SIGIUENTE INFORMACIONDE LOS PRODUCTOS: ID, NOMBRE, PRECIO, SUBCATEGORIA Y CATEGORIA.
Drop view if EXISTS ViewInfoProductos;
go

Create view ViewInfoProductos as (
	select 
	Production.Product.ProductID, Production.Product.Name, Production.Product.StandardCost, 
	Production.ProductSubcategory.Name as 'ProductSubcategory',  Production.ProductCategory.Name as 'ProductCategory'
	from Production.Product 
	inner join Production.ProductSubcategory
	on Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
	inner join Production.ProductCategory
	on Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID
);
go

select * from ViewInfoProductos;

--3- CREAR 2 STORED PROCEDURE  usando join, case, el primero sin parametros y el segundo con parametros.
Drop PROCEDURE if EXISTS ProcTest1;
go

CREATE PROCEDURE ProcTest1
AS
	BEGIN 
		select Person.Person.BusinessEntityID, Person.Person.PersonType, Person.Person.FirstName, Person.Person.LastName, 
		Person.EmailAddress.EmailAddress,
		CASE 
			WHEN Person.Person.PersonType = 'EM' THEN 'PersonType: EM'
			WHEN Person.Person.PersonType = 'VC' THEN 'PersonType: VC'
			ELSE 'PersonType: Otro!'
		END as 'PersonType'
		from Person.Person 
		inner join Person.EmailAddress 
		on Person.Person.BusinessEntityID = Person.EmailAddress.BusinessEntityID 
	END
GO


Drop PROCEDURE if EXISTS ProcTest2;
go

CREATE PROCEDURE ProcTest2 @PersonName varchar(255)
AS
	BEGIN 
		select Person.Person.BusinessEntityID, Person.Person.PersonType, Person.Person.FirstName, Person.Person.LastName, 
		Person.EmailAddress.EmailAddress,
		CASE 
			WHEN Person.Person.PersonType = 'EM' THEN 'PersonType: EM'
			WHEN Person.Person.PersonType = 'VC' THEN 'PersonType: VC'
			ELSE 'PersonType: Otro!'
		END as 'PersonType'
		from Person.Person 
		inner join Person.EmailAddress 
		on Person.Person.BusinessEntityID = Person.EmailAddress.BusinessEntityID
		where Person.Person.FirstName = @PersonName
	END
GO

exec ProcTest1;
exec ProcTest2 'Ken';


--4-LISTAR LOS EMPLEADOS POR DEPARTAMENTO.
select Person.Person.FirstName, Person.Person.LastName, HumanResources.Employee.JobTitle, HumanResources.Department.Name as 'Department'
from HumanResources.Employee
inner join Person.Person
on Person.Person.BusinessEntityID =HumanResources.Employee.BusinessEntityID
inner join HumanResources.EmployeeDepartmentHistory
on Person.Person.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
inner join HumanResources.Department
on HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
order by HumanResources.Department.Name;

--5- LISTAR LOS 10 PRODUCTOS MAS VENDIDOS
select top(10) COUNT(Sales.SalesOrderDetail.OrderQty) as 'Ventas', Production.Product.Name  as 'Product'
from Sales.SalesOrderDetail
inner join Production.Product 
on Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
group by Production.Product.Name 
order by Ventas desc; 

--6-LISTAR LOS 10 PRODUCTOS MENOS VENDIDOS.
select top(10) COUNT(Sales.SalesOrderDetail.OrderQty) as 'Ventas', Production.Product.Name  as 'Product'
from Sales.SalesOrderDetail
inner join Production.Product 
on Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
group by Production.Product.Name 
order by Ventas; 

--7-LISTAR LAS VENTAS POR TERRITORIO.
select Sales.SalesTerritory.Name as 'territorio', sum(so.OrderQty * so.UnitPrice) as 'ventas'
from Sales.SalesOrderHeader
inner join Sales.SalesOrderDetail so
on Sales.SalesOrderHeader.SalesOrderID = so.SalesOrderID
inner join Sales.SalesTerritory
on Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID
group by Sales.SalesTerritory.TerritoryID, Sales.SalesTerritory.Name
order by sum(so.OrderQty * so.UnitPrice) desc;


--8-BUSCAR LOS DEPARTAMENTO QUE TENGAN MAYOR DE 5 EMPLEADOS
drop view if exists ViewDepartmentM5;
go

create view ViewDepartmentM5 as (
	select HumanResources.Department.Name as 'Department', COUNT(HumanResources.EmployeeDepartmentHistory.BusinessEntityID) as 'Empleados'
	from HumanResources.EmployeeDepartmentHistory 
	inner join HumanResources.Department
	on HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
	group by HumanResources.Department.Name
);
go

select * from ViewDepartmentM5 where ViewDepartmentM5.Empleados > 5;



--9 CLIENTES QUE HAYAN GENERADO MAS DE 3 ORDENES
drop view if exists ViweOrdenesClientes;
go

create view ViweOrdenesClientes as (
	SELECT Person.Person.BusinessEntityID as 'cliente_id', 
	COUNT(Person.Person.BusinessEntityID) as 'ordenes'
	FROM Sales.Customer
	inner join Sales.SalesOrderHeader
	ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
	inner join Person.Person
	on Sales.Customer.PersonID = Person.Person.BusinessEntityID
	group by Person.Person.BusinessEntityID
);
go


select * from ViweOrdenesClientes  where ordenes > 3

--10 CLIENTES QUE NO HAYAN GENERADO NINGUNA ORDEN
select * from ViweOrdenesClientes  where ordenes = 0;




--tools:
select * from Sales.SalesPerson;
select * from Purchasing.Vendor;
select * from HumanResources.Employee;
select * from HumanResources.Department;
select * from Sales.SalesOrderHeader;
select * from Sales.Customer;
select * from Sales.Store;
select * from Sales.SalesPerson;
select * from Sales.SalesTerritoryHistory;
select * from Sales.SalesTerritory;
select * from Sales.SalesOrderDetail;
select * from HumanResources.Employee;
select * from HumanResources.EmployeeDepartmentHistory;
select * from HumanResources.Department;
select * from Production.Product;
select * from Production.ProductSubcategory;
select * from Production.ProductCategory;
select * from Production.ProductDescription;
select * from Production.ProductModel;
select * from Person.Person;
select * from Person.EmailAddress;
select * from Person.PersonPhone;
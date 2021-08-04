/*
Tarea 5
Después de visualizar los videos de la unidad e, instala y descargar la Bases de Datos AdventureWork, realizar las siguientes consultas
1.    Indicar el listado de los empleados del sexo femenino y que son solteros (HumanResources.Employee)
2.    Empleados cuyo apellido sea con la letra “S”, “A” o “N”
HumanResources.Employee Y Person.Person
3.    La suma de las ventas hechas por cada empleado, y agrupadas por año
4.    El producto menos vendido(id, nombre y precio)
5.    El producto más barato (id, nombre y precio)
6.    El producto más costoso(id, nombre y precio)
7.    El producto de costo medio (id, nombre y precio)
8.    Listar productos y su modelo validando que no sea null
9.    Inventario de productos(nombre y cantidad en existencia agrupado por producto)
10. Devolver el listado de personas organizado alfabéticamente por el apellido
11. Devolver el nombre de las personas y su respectivo número de teléfono
12. Devolver listado de productos y subcategoría, validando que no sea null
13. Devolver listado de personas que están en la tabla Person.Person y en la tabla sales.customer
14. Devolver listado de personas que no están en la tabla Person.Person y en la tabla sales.customer

Subir archivo en formato.sql
*/


--1. Indicar el listado de los empleados del sexo femenino y que son solteros (HumanResources.Employee)
select * from HumanResources.Employee where Gender = 'F' and MaritalStatus = 'S';

--2. Empleados cuyo apellido sea con la letra “S”, “A” o “N”
select Person.Person.LastName from HumanResources.Employee 
join Person.Person 
on HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID 
where 
Person.Person.LastName Like 'S%' or
Person.Person.LastName Like 'A%' or 
Person.Person.LastName Like 'N%';

--3. La suma de las ventas hechas por cada empleado, y agrupadas por año
select count(Sales.SalesPerson.BusinessEntityID) from Sales.SalesPerson GROUP BY Sales.SalesPerson.SalesLastYear;


--4. El producto menos vendido(id, nombre y precio)
select top(1) Production.Product.ProductID, Production.Product.Name, Production.Product.StandardCost, Production.Product.ReorderPoint 
from Production.Product order by Production.Product.ReorderPoint;

--5. El producto más barato (id, nombre y precio)
select top(1) Production.Product.ProductID, Production.Product.Name, Production.Product.StandardCost, Production.Product.ReorderPoint 
from Production.Product order by Production.Product.StandardCost desc;

--6. El producto más costoso (id, nombre y precio)
select top(1) Production.Product.ProductID, Production.Product.Name, Production.Product.StandardCost, Production.Product.ReorderPoint 
from Production.Product order by Production.Product.StandardCost;

--7. El producto de costo medio (id, nombre y precio)
select top(1) Production.Product.ProductID, Production.Product.Name, Production.Product.StandardCost, Production.Product.ReorderPoint 
from Production.Product
where Production.Product.StandardCost < (select AVG(ALL Production.Product.StandardCost) from Production.Product) 
order by Production.Product.StandardCost desc; 

--8. Listar productos y su modelo validando que no sea null
select Production.Product.Name as Producto, Production.ProductModel.Name as Model 
from Production.Product
inner join Production.ProductModel
on Production.Product.ProductModelID = Production.ProductModel.ProductModelID 
where Production.Product.ProductModelID is not null;

--9. Inventario de productos(nombre y cantidad en existencia agrupado por producto)
select count(Production.Product.ProductID) as Producto, Production.Product.Name, sum(Production.ProductInventory.Quantity) as Quantity
from Production.Product
inner join Production.ProductInventory
on Production.Product.ProductID = Production.ProductInventory.ProductID
where Production.Product.ProductID is not null
GROUP BY Production.Product.Name;

--10. Devolver el listado de personas organizado alfabéticamente por el apellido
select * from Person.Person order by Person.Person.LastName;

--11. Devolver el nombre de las personas y su respectivo número de teléfono
select Person.Person.FirstName, Person.Person.LastName, Person.PersonPhone.PhoneNumber 
from Person.Person 
inner join Person.PersonPhone 
on Person.Person.BusinessEntityID = Person.PersonPhone.BusinessEntityID;


--12. Devolver listado de productos y subcategoría, validando que no sea null
select * 
from Production.Product inner join Production.ProductCategory
on Production.Product.ProductSubcategoryID = Production.ProductCategory.ProductCategoryID;

--13. Devolver listado de personas que están en la tabla Person.Person y en la tabla sales.customer
select * 
from Person.Person inner join Sales.Customer
on Person.Person.BusinessEntityID = Sales.Customer.PersonID;

--14. Devolver listado de personas que no están en la tabla Person.Person y en la tabla sales.customer
select * 
from Person.Person left join Sales.Customer
on Person.Person.BusinessEntityID = Sales.Customer.PersonID where Sales.Customer.PersonID is not null;


--pruebas
select * from Production.ProductInventory;
select * from Production.ProductModel;
select * from Production.ProductCategory;
select * from Production.Product;
select * from Sales.SalesPerson;
select * from HumanResources.Employee;
select * from Person.Person;
select * from Person.BusinessEntityContact;
select * from Person.ContactType;
select * from Person.PersonPhone;


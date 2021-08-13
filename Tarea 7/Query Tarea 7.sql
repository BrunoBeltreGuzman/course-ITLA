/*
	REALIZAR LAS SIGUIENTES ACTIVIDADES EN LA BASE DE DATOS ADVENTURESWORKS

	1.CREAR TABLA PARA REGISTRA LA MODIFICACION DE LA BASE DE DATOS: DATOS QUE DEBE CONTENER 
	(IDTABLA, IDEMPLEADO, FECHA Y UNA NOTA)

	2.CREAR STORED PROCEDURE  QUE INSERTE UN NUEVO EMPLEADO EN LA BASES DE DATOS ADVENTURE WORKS, 
	TOMAR EN CUENTA LAS TABLAS (PERSON.BUSSINESSENTITYID, PERSON.PERSON, HUMANRESOURCES.EMPLOYEE, 
	Y HUMANRESOURCES.EMPLOYEEDEPARTMENT). E INSERTE INFORMACION EN LA TABLA MODIFICACION.

	3.CREAR DIAGRAMA RELACIONAL EN SQL SERVER CON LAS TABLAS A UTILIZAR PARA QUE VIZUALICEN 
	LA INFORMACION QUE NECESITAN PARA HACER LAS INSERCIONES.
	ENTREGAR QUERY DEL STORED Y CAPTURA DEL DIAGRAMA
*/


/*
	1.CREAR TABLA PARA REGISTRA LA MODIFICACION DE LA BASE DE DATOS: DATOS QUE DEBE CONTENER 
	(IDTABLA, IDEMPLEADO, FECHA Y UNA NOTA)
*/

drop table if exists LogUpdate;
go

create table LogUpdate(
id int identity(1, 1) primary key not null,
	Idempleado  int not null,
	Nota varchar(255),
	Fecha datetime not null default GETDATE()
);
go


/*
	2.CREAR STORED PROCEDURE  QUE INSERTE UN NUEVO EMPLEADO EN LA BASES DE DATOS ADVENTURE WORKS, 
	TOMAR EN CUENTA LAS TABLAS (PERSON.BUSSINESSENTITYID, PERSON.PERSON, HUMANRESOURCES.EMPLOYEE, 
	Y HUMANRESOURCES.EMPLOYEEDEPARTMENT). E INSERTE INFORMACION EN LA TABLA MODIFICACION.
*/


drop procedure if exists PorcNuevoEmpreado;
go


CREATE PROCEDURE PorcNuevoEmpreado 
@Nombres varchar(255), @Apellidos varchar(255), @PersonType nchar(2), @LoginID nvarchar(256),
@BirthDate date, @MaritalStatus nchar(1), @NationalIDNumber nvarchar(15), 
@JobTitle nvarchar(256), @Gender nchar(1) 
AS
	BEGIN
		--insert Person.BusinessEntity
		insert into Person.BusinessEntity (ModifiedDate) values (GETDATE());
	
		--Optener Ultimo Id Insertado BusinessEntity
		DECLARE @UltimoBusinessEntityIdInsertado int;
		set @UltimoBusinessEntityIdInsertado = SCOPE_IDENTITY();

		select @UltimoBusinessEntityIdInsertado as '@UltimoBusinessEntityIdInsertado';

		--insert Person.Person
		insert into 
		Person.Person 
		(BusinessEntityID, PersonType, FirstName, LastName) 
		Values 
		(@UltimoBusinessEntityIdInsertado, @PersonType, @Nombres, @Apellidos);
	
		--Optener Ultimo Id Insertado Person
		DECLARE @UltimoPersonIdInsertado int;
		set @UltimoPersonIdInsertado = SCOPE_IDENTITY();

		select @UltimoPersonIdInsertado as '@UltimoPersonIdInsertado';

		--insert HumanResources.Employee 
		insert into HumanResources.Employee 
		(BusinessEntityID, LoginID, BirthDate, MaritalStatus, HireDate, NationalIDNumber, JobTitle, Gender) 
		Values 
		(@UltimoPersonIdInsertado, @LoginID, @BirthDate, @MaritalStatus, GETDATE(), @NationalIDNumber, @JobTitle, @Gender);

		--Optener Ultimo Id Insertado Employee
		DECLARE @UltimoEmployeeIdInsertado int;
		set @UltimoEmployeeIdInsertado = SCOPE_IDENTITY();
	
		select @UltimoEmployeeIdInsertado as '@UltimoEmployeeIdInsertado';

		--insert HumanResources.EmployeeDepartmentHistory
		insert into HumanResources.EmployeeDepartmentHistory 
		(BusinessEntityID, DepartmentID, ShiftID, StartDate, ModifiedDate)
		values 
		(@UltimoEmployeeIdInsertado, 16, 1, GETDATE(), GETDATE());
	end
go


exec PorcNuevoEmpreado 'Nombres', 'Apellidos', 'EM', 'loginid123', '1969-01-29', 'S', 'NationalIDNumber1', 'JobTitle1', 'M';


drop procedure if exists PorcNuevoEmpreado2;
go


CREATE PROCEDURE PorcNuevoEmpreado2 
@Nombres varchar(255), @Apellidos varchar(255), @PersonType nchar(2), @LoginID nvarchar(256),
@BirthDate date, @MaritalStatus nchar(1), @NationalIDNumber nvarchar(15), 
@JobTitle nvarchar(256), @Gender nchar(1) 
AS
	BEGIN
		--insert Person.BusinessEntity
		insert into Person.BusinessEntity (ModifiedDate) values (GETDATE());
	
		--Optener Ultimo Id Insertado BusinessEntity
		DECLARE @UltimoBusinessEntityIdInsertado int;
		set @UltimoBusinessEntityIdInsertado = SCOPE_IDENTITY();

		select @UltimoBusinessEntityIdInsertado as '@UltimoBusinessEntityIdInsertado';

		--insert Person.Person
		insert into 
		Person.Person 
		(BusinessEntityID, PersonType, FirstName, LastName) 
		Values 
		(@UltimoBusinessEntityIdInsertado, @PersonType, @Nombres, @Apellidos);
	
		--Optener Ultimo Id Insertado Person
		DECLARE @UltimoPersonIdInsertado int;
		set @UltimoPersonIdInsertado = 
		(select top 1 BusinessEntityID from Person.Person order by BusinessEntityID desc)

		select @UltimoPersonIdInsertado as '@UltimoPersonIdInsertado';

		--insert HumanResources.Employee 
		insert into HumanResources.Employee 
		(BusinessEntityID, LoginID, BirthDate, MaritalStatus, HireDate, NationalIDNumber, JobTitle, Gender) 
		Values 
		(@UltimoPersonIdInsertado, @LoginID, @BirthDate, @MaritalStatus, GETDATE(), @NationalIDNumber, @JobTitle, @Gender);

		--Optener Ultimo Id Insertado Employee
		DECLARE @UltimoEmployeeIdInsertado int;
		set @UltimoEmployeeIdInsertado = 
		(select top 1 BusinessEntityID from HumanResources.Employee order by BusinessEntityID desc)
	
		select @UltimoEmployeeIdInsertado as '@UltimoEmployeeIdInsertado';

		--insert HumanResources.EmployeeDepartmentHistory
		insert into HumanResources.EmployeeDepartmentHistory 
		(BusinessEntityID, DepartmentID, ShiftID, StartDate, ModifiedDate)
		values 
		(@UltimoEmployeeIdInsertado, 16, 1, GETDATE(), GETDATE());
	end
go


exec PorcNuevoEmpreado2 'Nombres', 'Apellidos', 'EM', 'loginid123', '1969-01-29', 'S', 'NationalIDNumber1', 'JobTitle1', 'M';


--Tools
select * from Person.BusinessEntity;
select * from Person.Person;
select * from HumanResources.Employee;
select * from HumanResources.EmployeeDepartmentHistory
/*
ALTER TABLE Person.Person
DROP CONSTRAINT FK_Person_BusinessEntity_BusinessEntityID; 

ALTER TABLE Person.Person
add CONSTRAINT FK_Person_BusinessEntity_BusinessEntityID
FOREIGN KEY (BusinessEntityID)
REFERENCES Person.BusinessEntity(BusinessEntityID);


ALTER TABLE Person.Person
ALTER COLUMN BusinessEntityID int;
*/

/*
insert into HumanResources.Employee 
(BusinessEntityID, LoginID, BirthDate, MaritalStatus, HireDate, NationalIDNumber, JobTitle, Gender) 
Values 
(20780, 'asd', '1969-01-29', 'S', GETDATE(),'EM', 'sa','M');

insert into 
HumanResources.EmployeeDepartmentHistory 
(BusinessEntityID, DepartmentID, ShiftID, StartDate, ModifiedDate)
values 
(20790, 16, 1, GETDATE(), GETDATE());
*/

/*delete from HumanResources.EmployeeDepartmentHistory where BusinessEntityID = 20779;
delete from HumanResources.Employee where BusinessEntityID = 20779;
delete from Person.Person where BusinessEntityID = 20779;
delete from Person.BusinessEntity where BusinessEntityID = 20779;*/
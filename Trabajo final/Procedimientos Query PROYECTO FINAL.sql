/*
	4)	Query de creación de bases de datos, tablas, relaciones, vistas, procedimientos almacenados.
*/
--create database TecnoDigitalBD;

use TecnoDigitalBD;

--insert:
/*
	* TiposEmpleados
	* Departamentos
	* TiposProductos
*/
insert into TiposEmpleados 
(TipoEmpleado) 
Values
('TipoEmpleado1'),
('TipoEmpleado2'),
('TipoEmpleado3'),
('TipoEmpleado4'),
('TipoEmpleado5'),
('TipoEmpleado6'),
('TipoEmpleado7'),
('TipoEmpleado8'),
('TipoEmpleado9'),
('TipoEmpleado10');

insert into Departamentos
(Departamento)
Values 
('Departamento1'),
('Departamento2'),
('Departamento3'),
('Departamento4'),
('Departamento5'),
('Departamento6'),
('Departamento7'),
('Departamento8'),
('Departamento9'),
('Departamento10');


insert into TiposProductos
(TipoProducto)
Values 
('Leche y derivados'),
('Carnes pescados y huevos'),
('Legumbres, frutos secos y patatas'),
('Hortalizas. Alimentos reguladores'),
('Frutas. Alimentos reguladores'),
('Cereales. Alimentos energéticos'),
('Mantecas y aceites'),
('Leche y derivados2'),
('Carnes pescados y huevos2'),
('Legumbres, frutos secos y patatas2');

--Procedimientos:

/*
	* Insertar Empleado
*/
drop procedure if exists ProcInsertarEmpleado
go


CREATE PROCEDURE ProcInsertarEmpleado 
@Nombres varchar(50), @Apellidos varchar(50),
@Cedula varchar(50), @Pasaporte varchar(50),
@IdTipoEmpleado int, @IdDepartamento int, @Cargo varchar(50),
@Usuario varchar(50), @Password varchar(255)
AS
	BEGIN
		--Insertar Persona
		insert into Personas
		(Nombres, Apellidos, Cedula, Pasaporte)
		Values
		(@Nombres, @Apellidos, @Cedula, @Pasaporte);

		--Optener Ultimo Id Insertado de Personas
		DECLARE @UltimoIdPersona int;
		set @UltimoIdPersona = SCOPE_IDENTITY();

		--Insertar Empleado
		insert into Empleados
		(IdPersona, IdTipoEmpleado, IdDepartamento, Cargo, Usuario, Password)
		Values
		(@UltimoIdPersona, @IdTipoEmpleado, @IdDepartamento, @Cargo, @Usuario, @Password);

		--Optener Ultimo Id Insertado de Empleado
		DECLARE @UltimoIdEmpleado int;
		set @UltimoIdEmpleado = SCOPE_IDENTITY();

		Select @UltimoIdEmpleado as 'UltimoIdEmpleado', @UltimoIdPersona as 'UltimoIdPersona';
	end
go


exec ProcInsertarEmpleado 'Nombres1', 'Apellidos1', '402-4015107-1', null, 1, 1, 'Programador1', 'user1', '123';
exec ProcInsertarEmpleado 'Nombres2', 'Apellidos2', '402-4015107-2', null, 2, 2, 'Programador2', 'user2', '123';
exec ProcInsertarEmpleado 'Nombres3', 'Apellidos3', '402-4015107-3', null, 3, 3, 'Programador3', 'user3', '123';
exec ProcInsertarEmpleado 'Nombres4', 'Apellidos4', '402-4015107-4', null, 4, 4, 'Programador4', 'user4', '123';
exec ProcInsertarEmpleado 'Nombres5', 'Apellidos5', '402-4015107-5', null, 5, 5, 'Programador5', 'user5', '123';
exec ProcInsertarEmpleado 'Nombres6', 'Apellidos6', '402-4015107-6', null, 6, 6, 'Programador6', 'user6', '123';
exec ProcInsertarEmpleado 'Nombres7', 'Apellidos7', '402-4015107-7', null, 7, 7, 'Programador7', 'user7', '123';
exec ProcInsertarEmpleado 'Nombres8', 'Apellidos8', '402-4015107-8', null, 8, 8, 'Programador8', 'user8', '123';
exec ProcInsertarEmpleado 'Nombres9', 'Apellidos9', '402-4015107-9', null, 9, 9, 'Programador9', 'user9', '123';
exec ProcInsertarEmpleado 'Nombres10', 'Apellidos10', '402-4015107-10', null, 10, 10, 'Programador10', 'user10', '123';



/*
	* Insertar Cliente
*/
drop procedure if exists ProcInsertarCliente
go


CREATE PROCEDURE ProcInsertarCliente 
@Nombres varchar(50), @Apellidos varchar(50),
@Cedula varchar(50), @Pasaporte varchar(50),
@IdTiposClientes int, @Usuario varchar(50), @Password varchar(50)
AS
	BEGIN
		--Insertar Persona
		insert into Personas
		(Nombres, Apellidos, Cedula, Pasaporte)
		Values
		(@Nombres, @Apellidos, @Cedula, @Pasaporte);

		--Optener Ultimo Id Insertado de Personas
		DECLARE @UltimoIdPersona int;
		set @UltimoIdPersona = SCOPE_IDENTITY();

		--Insertar Cliente
		insert into Clientes
		(IdPersona, IdTiposClientes, Usuario, Password)
		Values
		(@UltimoIdPersona, @IdTiposClientes, @Usuario, @Password);

		--Optener Ultimo Id Insertado de Clientes
		DECLARE @UltimoIdClientes int;
		set @UltimoIdClientes = SCOPE_IDENTITY();

		Select @UltimoIdClientes as 'UltimoIdClientes', @UltimoIdPersona as 'UltimoIdPersona';
	end
go


exec ProcInsertarCliente 'Nombres1', 'Apellidos1', '402-4015107-11', null, 1, 'user1', '123';
exec ProcInsertarCliente 'Nombres2', 'Apellidos2', '402-4015107-12', null, 1, 'user2', '123';
exec ProcInsertarCliente 'Nombres3', 'Apellidos3', '402-4015107-13', null, 1, 'user3', '123';
exec ProcInsertarCliente 'Nombres4', 'Apellidos4', '402-4015107-14', null, 1, 'user4', '123';
exec ProcInsertarCliente 'Nombres5', 'Apellidos5', '402-4015107-15', null, 1, 'user5', '123';
exec ProcInsertarCliente 'Nombres6', 'Apellidos6', '402-4015107-16', null, 1, 'user6', '123';
exec ProcInsertarCliente 'Nombres7', 'Apellidos7', '402-4015107-17', null, 1, 'user7', '123';
exec ProcInsertarCliente 'Nombres8', 'Apellidos8', '402-4015107-18', null, 1, 'user8', '123';
exec ProcInsertarCliente 'Nombres9', 'Apellidos9', '402-4015107-19', null, 1, 'user9', '123';
exec ProcInsertarCliente 'Nombres10', 'Apellidos10', '402-4015107-20', null, 1, 'user10', '123';


/*
	* Insertar Productos
*/
drop procedure if exists ProcInsertarProductos
go

CREATE PROCEDURE ProcInsertarProductos
@IdTipoProducto int, @NombreProducto varchar(50),
@DescripcionProducto varchar(50), @Precio int
AS
	BEGIN
		--Insertar Productos
		insert into Productos
		(IdTipoProducto, NombreProducto, DescripcionProducto, Precio)
		Values
		(@IdTipoProducto, @NombreProducto, @DescripcionProducto, @Precio);

		--Optener Ultimo Id Insertado de Productos
		DECLARE @UltimoIdProductos int;
		set @UltimoIdProductos = SCOPE_IDENTITY();

		Select @UltimoIdProductos as 'UltimoIdProductos';
	end
go

exec ProcInsertarProductos 1, 'Producto1', 'Esta es la descripción del producto1', 500;
exec ProcInsertarProductos 2, 'Producto2', 'Esta es la descripción del producto2', 500;
exec ProcInsertarProductos 3, 'Producto3', 'Esta es la descripción del producto3', 500;
exec ProcInsertarProductos 4, 'Producto4', 'Esta es la descripción del producto4', 500;
exec ProcInsertarProductos 5, 'Producto5', 'Esta es la descripción del producto5', 500;
exec ProcInsertarProductos 6, 'Producto6', 'Esta es la descripción del producto6', 500;
exec ProcInsertarProductos 7, 'Producto7', 'Esta es la descripción del producto7', 500;
exec ProcInsertarProductos 8, 'Producto8', 'Esta es la descripción del producto8', 500;
exec ProcInsertarProductos 9, 'Producto9', 'Esta es la descripción del producto9', 500;
exec ProcInsertarProductos 10, 'Producto10', 'Esta es la descripción del producto10', 500;


/*
	* Insertar Ordenes
*/
drop procedure if exists ProcInsertarOrdenes
go

CREATE PROCEDURE ProcInsertarOrdenes
@Codigo varchar(255), @IdCliente int,
@IdEmpleado int, @IdProducto int,
@Cantidad int
AS
	BEGIN
		--Insertar Ordenes
		insert into Ordenes
		(Codigo, IdCliente, IdEmpleado, IdProducto, Cantidad)
		Values
		(@Codigo, @IdCliente, @IdEmpleado, @IdProducto, @Cantidad);

		--Optener Ultimo Id Insertado de Ordenes
		DECLARE @UltimoIdOrdenes int;
		set @UltimoIdOrdenes = SCOPE_IDENTITY();

		Select @UltimoIdOrdenes as 'UltimoIdOrdenes';
	end
go

declare @Codigo varchar(255);
set @Codigo =  CONVERT(varchar(255), NEWID());

exec ProcInsertarOrdenes @Codigo, 1, 1, 1, 1;
exec ProcInsertarOrdenes @Codigo, 1, 1, 2, 3;
exec ProcInsertarOrdenes @Codigo, 1, 1, 3, 2;
exec ProcInsertarOrdenes @Codigo, 1, 1, 4, 5;
exec ProcInsertarOrdenes @Codigo, 1, 1, 5, 6;
exec ProcInsertarOrdenes @Codigo, 1, 1, 6, 10;
exec ProcInsertarOrdenes @Codigo, 1, 1, 7, 1;
exec ProcInsertarOrdenes @Codigo, 1, 1, 8, 1;
exec ProcInsertarOrdenes @Codigo, 1, 1, 9, 2;
exec ProcInsertarOrdenes @Codigo, 1, 1, 10, 3;


/*
	* Insertar Ventas
*/
drop procedure if exists ProcInsertarVentas
go

CREATE PROCEDURE ProcInsertarVentas
	@CodigoOrdenes varchar(255),
	@IdCliente int,
	@IdEmpleado int,
	@Efectivo int
AS
	BEGIN

		--Optener Ultimo Id Insertado de Ordenes
		DECLARE @SubTotal float;
		set @SubTotal = (
			select sum(Productos.Precio * Ordenes.Cantidad) 
			from Ordenes 
			inner join Productos
			on Ordenes.IdProducto = Productos.IdProducto
			where Ordenes.Codigo = @CodigoOrdenes
		);

		Declare @ITBIS int;
		set @ITBIS = @SubTotal * 0.18;

		Declare @Total int;
		set @Total = @SubTotal + @ITBIS;

		--Insertar Ordenes
		insert into Ventas
		(CodigoOrdenes, IdCliente, IdEmpleado, SubTotal, ITBIS, Total, Efectivo)
		Values
		(@CodigoOrdenes, @IdCliente, @IdEmpleado, @SubTotal, @ITBIS, @Total, @Efectivo);

		--Optener Ultimo Id Insertado de Ordenes
		DECLARE @UltimoIdOrdenes int;
		set @UltimoIdOrdenes = SCOPE_IDENTITY();

		Select top(1) * from Ventas where CodigoOrdenes = @CodigoOrdenes order by CodigoOrdenes desc;
	end
go


exec ProcInsertarVentas '@CodigoOrdenes', 1, 1, 100000;

/*
	7)	Realizar las siguientes vistas:
		a)	Listar ordenes con su detalle
		b)	Informacion de clientes
		c)	Informacion de empleados(si aplica)
		d)	Clientes con más pedidos
*/


/*
	a)	Listar ordenes con su detalle
*/

Drop view if EXISTS VistaListaOrdenes;
go

create view VistaListaOrdenes as (
	Select
	Ordenes.Codigo,
	Ordenes.IdCliente,
	Ordenes.IdEmpleado,
	Ordenes.IdProducto,
	Ordenes.Cantidad,
	Ventas.SubTotal,
	Ventas.ITBIS,
	Ventas.Total,
	Ventas.Efectivo,
	Ventas.Cambio
	from Ventas 
	inner join Ordenes
	on Ventas.CodigoOrdenes = Ordenes.Codigo
);
go

select * from VistaListaOrdenes;

/*
	b)	Informacion de clientes
*/
Drop view if EXISTS VistaInfoClientes;
go

create view VistaInfoClientes as (
	Select
	Clientes.IdTiposClientes,
	Clientes.Usuario,
	Personas.Nombres, 
	Personas.Apellidos,
	Personas.Cedula,
	Personas.Pasaporte 
	from Clientes
	inner join Personas
	on Clientes.IdPersona = Personas.IdPersona
);
go

select * from VistaInfoClientes;

/*
	c)	Informacion de empleados(si aplica)
*/
Drop view if EXISTS VistaInfoEmpleados;
go

create view VistaInfoEmpleados as (
	Select
	Empleados.IdTipoEmpleado,
	Empleados.Usuario,
	Personas.Nombres, 
	Personas.Apellidos,
	Personas.Cedula,
	Personas.Pasaporte 
	from Empleados
	inner join Personas
	on Empleados.IdPersona = Personas.IdPersona
);
go

select * from VistaInfoEmpleados;



/*
	8)	Crear los siguientes procedimientos almacenados
		a)	Insertar registro de venta
		b)	Insertar empleado
		c)	Insertar producto 
		d)	Actualizar cantidad en existencia de un producto con registro en tabla modificaciones de quien fue que lo modifico.
		e)	Filtrar cliente por ciudad.
*/


--Tools:
select * from Personas;
select * from Clientes;
select * from Empleados;

select * from Ventas;
select * from Ordenes;



--Funciones
/*
	* ObtenerSubTotal()
*/
drop FUNCTION if exists ObtenerSubTotal;
go

CREATE FUNCTION ObtenerSubTotal (@CodigoOrdenes AS varchar(255))
RETURNS float
AS
BEGIN
return   (select sum(Productos.Precio) 
	 from Ordenes 
	 inner join Productos
	 on Ordenes.IdProducto = Productos.IdProducto
	 where Ordenes.Codigo = @CodigoOrdenes);
END;
go


drop procedure if exists ProcInsertarEmpleado
go

CREATE PROCEDURE ProcInsertarEmpleado 
@Nombres varchar(255), @Gender nchar(1) 
AS
	BEGIN
		BEGIN TRANSACTION 
		BEGIN TRY
			--Aqui

			--Cinfimacion de la TRANSACTION
			COMMIT TRANSACTION 
		END TRY

		BEGIN CATCH
			--Ocurrió un error, deshacemos los cambios 
			ROLLBACK TRANSACTION
			PRINT 'Ha ocurrido un error en ProcInsertarEmpleado!'
		END CATCH
	end
go

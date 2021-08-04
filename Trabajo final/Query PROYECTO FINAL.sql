/*
	4)	Query de creación de bases de datos, tablas, relaciones, vistas, procedimientos almacenados.
*/
--create database TecnoDigitalBD;

use TecnoDigitalBD;

/*
	Productos
*/
DROP TABLE if EXISTS Productos;

CREATE TABLE Productos (
	IdProducto int Identity(1, 1) primary key not null,
	IdTipoProducto int not null,
	NombreProducto varchar(50) not null ,
	DescripcionProducto varchar(50) default null,
	Precio float not null,
	UltimaActualizacion datetime not null default GETDATE()
);

/*
	TiposProductos
*/
DROP TABLE if EXISTS TiposProductos;

CREATE TABLE TiposProductos (
	IdTiposProductos int Identity(1, 1) primary key not null,
	TipoProducto varchar(50) not null ,
	UltimaActualizacion datetime not null default GETDATE()
);

/*
	Persona
*/
DROP TABLE if EXISTS Personas;

CREATE TABLE Personas (
	IdPersona int Identity(1, 1) primary key not null,
	Nombres varchar(50) not null, 
	Apellidos varchar(50) not null,
	Cedula varchar(50) not null ,
	Pasaporte varchar(50) default null, 
	UltimaActualizacion datetime not null default GETDATE()
);


/*
	Empleado
*/
DROP TABLE if EXISTS Empleados;

CREATE TABLE Empleados (
	IdPersona int not null,
	IdTipoEmpleado int not null,
	IdDepartamento int not null,
	Cargo varchar(50) not null,
	Usuario varchar(50) not null ,
	Password varchar(255) not null,
	UltimaActualizacion datetime not null default GETDATE()
);



/*
	TiposEmpleado
*/
DROP TABLE if EXISTS TiposEmpleados;

CREATE TABLE TiposEmpleados (
	IdTipoEmpleado int Identity(1, 1) primary key not null,
	TipoEmpleado varchar(50) not null ,
	UltimaActualizacion datetime not null default GETDATE()
);

/*
	Departamento
*/
DROP TABLE if EXISTS Departamentos;

CREATE TABLE Departamentos (
	IdDepartamento int Identity(1, 1) primary key not null,
	Departamento varchar(50) not null,
	UltimaActualizacion datetime not null default GETDATE()
);

/*
	Clientes
*/
DROP TABLE if EXISTS Clientes;

CREATE TABLE Clientes (
	IdPersona int not null,
	IdTiposClientes int not null,
	Usuario varchar(50) not null ,
	Password varchar(255) not null,
	Credito float default 0,
	UltimaActualizacion datetime not null default GETDATE()
);

/*
	TiposClientes
*/
DROP TABLE if EXISTS TiposClientes;

CREATE TABLE TiposClientes (
	IdTiposClientes int Identity(1, 1) primary key not null,
	TipoCliente varchar not null ,
	UltimaActualizacion datetime not null default GETDATE()
);

/*
	Ordenes
*/
DROP TABLE if EXISTS Ordenes;

CREATE TABLE Ordenes (
	IdOrden int Identity(1, 1) primary key not null,
	Codigo varchar(255) not null,
	IdCliente int not null,
	IdEmpleado int not null,
	IdProducto int not null,
	Cantidad int default 1,
	UltimaActualizacion datetime not null default GETDATE()
);


/*
	Ventas
*/
DROP TABLE if EXISTS Ventas;

CREATE TABLE Ventas (
	CodigoOrdenes varchar(255) primary key, 
	IdCliente int not null,
	IdEmpleado int not null,
	SubTotal float not null,
	ITBIS float not null,
	Total float not null,
	Efectivo float not null,
	Cambio as Efectivo - Total,
	UltimaActualizacion datetime not null default GETDATE()
);


/*
	Inventario
*/
DROP TABLE if EXISTS Inventario;

CREATE TABLE Inventario (
	IdInventario int Identity(1, 1) primary key not null,
	IdProducto int not null,
	Stock int not null,
	UltimaActualizacion datetime not null default GETDATE()
);
/*
	Logs
*/
DROP TABLE if EXISTS Logs;

CREATE TABLE Logs (
	IdLogs int Identity(1, 1) primary key not null,
	IdUsuario int not null,
	Log varchar(255) not null,
	Fecha datetime not null default GETDATE()
);

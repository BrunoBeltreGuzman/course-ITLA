/*
	4)	Query de creación de bases de datos, tablas, relaciones, vistas, procedimientos almacenados.
*/
--create database TecnoDigitalBD;

use TecnoDigitalBD;

--Relacion de Productos a TiposProductos
alter table Productos  
add FOREIGN KEY(IdTipoProducto) 
references TiposProductos(IdTiposProductos);

--Relacion de Empleados a TipoEmpleado
alter table Empleados
add FOREIGN KEY (IdTipoEmpleado)
references TiposEmpleados(IdTipoEmpleado);

--Relacion de Empleados a Departamento
alter table Empleados
add FOREIGN KEY (IdDepartamento)
references Departamentos(IdDepartamento);

--Relacion de Empleados a Persona
alter table Empleados
add FOREIGN KEY (IdPersona)
references Personas(IdPersona);

--Relacion de Clientes a Persona
alter table Clientes
add FOREIGN KEY (IdTiposClientes)
references TiposClientes(IdTiposClientes);

--Relacion de Ordenes a Ventas
alter table Ordenes
add FOREIGN KEY (Codigo)
references Ventas(CodigoOrdenes);

--Relacion de Ordenes a Clientes
alter table Ordenes
add FOREIGN KEY (IdCliente)
references Personas(IdPersona);

--Relacion de Ordenes a Empleados
alter table Ordenes
add FOREIGN KEY (IdEmpleado)
references Personas(IdPersona);

--Relacion de Ordenes a Productos
alter table Ordenes
add FOREIGN KEY (IdProducto)
references Productos(IdProducto);

--Relacion de Ventas a Clientes
alter table Ventas
add FOREIGN KEY (IdCliente)
references Personas(IdPersona);

--Relacion de Ventas a Empleado
alter table Ventas
add FOREIGN KEY (IdEmpleado)
references Personas(IdPersona);

--Relacion de Inventario a Productos
alter table Inventario 
add FOREIGN key(IdProducto)
references Productos(IdProducto);

--Relacion de Logs a Personas
alter table Logs 
add FOREIGN key(IdUsuario)
references Personas(IdPersona);



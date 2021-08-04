/*
	Tarea 4 
	persona (id-conductor nombre, dirección) 
	coche (matricula, año, modelo) 
	accidente (numero-informe, fecha, lugar) 
	es-dueño (id-conductor, matricula) 
	participo (id-conductor, coche, numero-informe, importe-daños) 

*/

create database tarea4;

use tarea4;

DROP TABLE if EXISTS coches_duenos;

DROP TABLE if EXISTS participios;

DROP TABLE if EXISTS personas;

DROP TABLE if EXISTS coches;

DROP TABLE if EXISTS accidentes;

CREATE TABLE personas (
	id_persona int Identity(1, 1) primary key not null,
	nombre varchar(255) not null,
	direccion varchar(255) not null,
	telefono varchar(255) not null,
	create_at datetime not null default GETDATE(),
	update_at datetime not null default GETDATE()
);

create table coches(
	id_coche int Identity(1, 1) primary key not null,
	matricula varchar(255) not null unique, 
	ano varchar(255) not null,
	modelo varchar(255) not null,
	create_at datetime not null default GETDATE(),
	update_at datetime not null default GETDATE()
);


create table coches_duenos (
	id_coche_dueno int identity(1, 1) primary key not null,
	id_persona int not null,
	matricula_coche varchar(255) not null,
	create_at datetime not null default GETDATE(),
	update_at datetime not null default GETDATE()
);

--Relacion de coche_dueno a persona
alter table coches_duenos  
add FOREIGN KEY(id_persona) references personas(id_persona); 

--Relacion de coche_dueno a coche
alter table coches_duenos  
add FOREIGN KEY(matricula_coche) references coches(matricula); 

create table accidentes (
	id_accidente int identity(1, 1) primary key not null,
	fecha datetime not null,
	lugar varchar(255) not null,
	create_at datetime not null default GETDATE(),
	update_at datetime not null default GETDATE()
);

create table participios  (
	id_participo int identity(1, 1) primary key not null,
	matricula_coche varchar(255) not null,
	id_persona int not null,
	id_accidente int not null,
	numero_informe varchar(255) not null unique,
	importe_danos varchar(255) not null,
	create_at datetime not null default GETDATE(),
	update_at datetime not null default GETDATE()
);

--Relacion de participios a coche
alter table participios  
add FOREIGN KEY(matricula_coche) references coches(matricula); 


--Relacion de participios a persona
alter table participios  
add FOREIGN KEY(id_persona) references personas(id_persona); 

--Relacion de participios a coche
alter table participios  
add FOREIGN KEY(id_accidente) references accidentes(id_accidente); 


--Insertar Personas
insert into personas (nombre, direccion, telefono) 
values
('Santos', 'Direcion persona1', '8096849684'),
('Persona2', 'Direcion persona2', '2342342344'),
('Persona3', 'Direcion persona3', '3242342344');


select * from personas;

--Insertar Coches
insert into coches (matricula, ano, modelo) 
Values 
('2002BCD', 2001, 'Mazda'),
('matricula002', 2002, 'Modelo2'),
('matricula003', 2003, 'Modelo3');

Select * from coches;

--Insert coches_duenos
insert into coches_duenos (id_persona, matricula_coche) 
Values
(1, '2002BCD'),
(2, 'matricula002'),
(3, 'matricula003');

select * from coches_duenos;

-- c)	Añadir un nuevo accidente a la base de datos; supóngase cualquier valor para los atributos necesarios. 
--Insert acidentes
insert into accidentes (fecha, lugar) 
values
('1989-07-07 11:14:43.490', 'Azua'),
('2021-06-06 11:14:43.490', 'Santo Domingo'),
('2021-05-05 11:14:43.490', 'Puerto Plata');

select * from accidentes;

--insert participios
insert into participios (matricula_coche, id_persona, id_accidente, numero_informe, importe_danos)
values
('2002BCD', 1, 1, 'AR2197', 'daños directos'),
('matricula002', 2, 2, 'numero002', 'daños patrimonial'),
('matricula003', 3, 3, 'numero003', 'daños extrapatrimonial');

select * from participios;


-- a)	Buscar el número total de las personas cuyos coches se han visto involucrados en un accidente en 1989. 
select count(fecha) as 'Total de accidente en 1989' from accidentes where fecha like '%1989%';

--b)	Buscar el número de accidentes en los cuales se ha visto involucrado un coche perteneciente a «Santos». 
select  count(id_accidente) as 'Total de numero de accidentes de Santos' from participios where id_persona = (select id_persona from personas where nombre = 'Santos');

--d)	Borrar el Mazda de «Santos».
delete from coches_duenos where matricula_coche = '2002BCD';
delete from participios where matricula_coche = '2002BCD';
delete from coches where modelo = 'Mazda';
select * from coches;


--e)	Actualizar el importe de daños del coche de matrícula «2002BCD» en el accidente con número de informe «AR2197» a 3.000 €.
update  participios set importe_danos = 'daños directos a 3.000 €.' where numero_informe = 'AR2197';
select * from participios;
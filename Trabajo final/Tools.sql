
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

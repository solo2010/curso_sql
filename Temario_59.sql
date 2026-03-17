if object_id ('empleados') is not null
  drop table empleados;
if object_id ('VP_sueldo') is not null
   drop default VP_sueldo;
if object_id ('VP_seccion') is not null
   drop default Vp_seccion;

create table empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  seccion varchar(20),
  sueldo decimal(6,2),
  primary key(documento)
);

go

-- Creamos un valor predeterminado para el campo "sueldo":
create default VP_sueldo
 as 500;

go

-- Asociamos el valor predeterminado creado anteriormente al campo "sueldo":
exec sp_bindefault VP_sueldo, 'empleados.sueldo';

go

-- Creamos un valor predeterminado para "seccion":
create default VP_seccion
 as 'Secretaria';

 go

-- Veamos todos los objetos de la base de datos activa:
exec sp_help;

-- Si agregamos al procedimiento almacenado "sp_help" el nombre
-- del valor predeterminado del cual queremos información:
exec sp_help VP_sueldo;

-- Para ver los valores predeterminados asociados a la tabla "empleados" tipeamos:
exec sp_helpconstraint empleados;

-- Asociamos el valor predeterminado a la tabla:
exec sp_bindefault VP_seccion, 'empleados.seccion';

exec sp_helpconstraint empleados;

exec sp_helptext VP_seccion;

-- Deshacemos la asociación del valor predeterminado "VP_sueldo" y lo eliminamos:
exec sp_unbindefault'empleados.sueldo'; 
drop default VP_sueldo;

exec sp_help VP_sueldo;

-- Vemos si el valor predeterminado "VP_seccion" existe consultando la tabla "sysobjects":
select * from sysobjects
  where xtype='D' and
  name like '%seccion%';
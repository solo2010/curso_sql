--Cláusula top

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(20),
  editorial varchar(20)
);

go

insert into libros values ('Uno','Richard Bach','Planeta');
insert into libros values ('El aleph','Borges','Emece');
insert into libros values ('Alicia en el pais...','Carroll','Planeta');
insert into libros values ('Aprenda PHP','Mario Molina','Siglo XXI');
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI');
insert into libros values ('Java desde cero','Mario Molina','Emece');
insert into libros values ('Ilusiones','Richard Bach','Planeta');

-- Obtenemos todos los datos de los primeros 2 libros de la tabla:
SELECT TOP 2 * FROM libros;

-- Mostramos los títulos y autores de los 3 primeros libros ordenados por autor:
SELECT TOP 3 titulo, autor FROM libros ORDER BY autor;

-- Realizamos la misma consulta anterior pero empleamos la cláusula "with ties", 
-- con lo cual incluiremos en la selección, todos los registros que tengan el
-- mismo autor que el último registro retornado, aunque pasemos de 3:
SELECT TOP 3 WITH TIES titulo, autor
    FROM libros ORDER BY autor;

-- El 50% de los registros de la tabla libros:
SELECT TOP 50 PERCENT * FROM libros;

--Ejercicio 1
 if object_id('empleados') is not null
  drop table empleados;

 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20)
 );

  insert into empleados
  values ('22222222','Alberto Lopez','c','Sistemas');
 insert into empleados
  values ('23333333','Beatriz Garcia','c','Administracion');
 insert into empleados
  values ('24444444','Carlos Fuentes','s','Administracion');
 insert into empleados
  values ('25555555','Daniel Garcia','s','Sistemas');
 insert into empleados
  values ('26666666','Ester Juarez','c','Sistemas');
 insert into empleados
  values ('27777777','Fabian Torres','s','Sistemas');
 insert into empleados
  values ('28888888','Gabriela Lopez',null,'Sistemas');
 insert into empleados
  values ('29999999','Hector Garcia',null,'Administracion');

--Muestre los 5 primeros registros (5 registros)
SELECT TOP 5 * FROM empleados;

--Muestre nombre y seccion de los 4 primeros registros ordenados por sección (4 registros)
SELECT TOP 4 nombre, seccion FROM empleados ORDER BY seccion;

--Realice la misma consulta anterior pero incluya todos los registros que tengan el mismo valor en 
--"seccion" que el último (8 registros)
 select top 4 with ties nombre,estadocivil,seccion
  from empleados
  order by estadocivil,seccion;


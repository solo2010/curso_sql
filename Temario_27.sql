--Funciones para el uso de fechas y horas
if object_id ('libros') is not null
  drop table libros;

create table libros(
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  edicion datetime,
  precio decimal(6,2)
);

go

set dateformat ymd;

insert into libros 
  values('El aleph','Borges','Emece','1980/10/10',25.33);
insert into libros 
  values('Java en 10 minutos','Mario Molina','Siglo XXI','2000/05/05',50.65);
insert into libros 
values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','2000/08/09',19.95);
insert into libros 
  values('Aprenda PHP','Mario Molina','Siglo XXI','2000/02/04',45);

-- Mostramos el título del libro y el año de edición:
SELECT titulo, DATEPART(YEAR, edicion) AS 'Año Edición' FROM libros;

-- Mostramos el título del libro y el nombre del mes de edición:
SELECT titulo, DATENAME(MONTH, edicion) FROM libros;

-- Mostramos el título del libro y los años que tienen de editados:
SELECT titulo, DATEDIFF(YEAR, edicion, GETDATE()) FROM libros;

-- Muestre los títulos de los libros que se editaron el día 9, de cualquier mes de cualquier año:
SELECT titulo FROM libros WHERE DATEPART(DAY, edicion) = 9;

--Ejercicio 1
DROP TABLE IF EXISTS empleados;

CREATE TABLE empleados(
  nombre VARCHAR(30) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  documento CHAR(8),
  fechanacimiento DATETIME,
  fechaingreso DATETIME,
  sueldo DECIMAL(6,2),
  PRIMARY KEY(documento)
);

 insert into empleados values('Ana','Acosta','22222222','1970/10/10','1995/05/05',228.50);
 insert into empleados values('Carlos','Caseres','25555555','1978/02/06','1998/05/05',309);
 insert into empleados values('Francisco','Garcia','26666666','1978/10/15','1998/10/02',250.68);
 insert into empleados values('Gabriela','Garcia','30000000','1985/10/25','2000/12/22',300.25);
 insert into empleados values('Luis','Lopez','31111111','1987/02/10','2000/08/21',350.98);

--Muestre nombre y apellido concatenados, con el apellido en letras mayúsculas, el documento 
--precedido por "DNI Nº " y el sueldo precedido por "$ ".
SELECT nombre + SPACE(1) + UPPER(apellido) AS Nombre,
  STUFF(documento,1,0, 'DNI N°') AS Documento,
  STUFF(sueldo,1,0,'$') AS Sueldo
  FROM empleados; --STUFF(cadena, inicio, longitud, texto_nuevo) sirve para eliminar una parte de un texto y reemplazarla por otra, en una posición específica.

--Muestre el documento y el sueldo redondeado hacia arriba y precedido por "$ ".
SELECT documento , STUFF(CEILING(sueldo),1,0,'$') FROM empleados;

--Muestre los nombres y apellidos de los empleados que cumplen años en el mes "october" (3 
--registros)
SELECT nombre, apellido FROM empleados WHERE DATENAME(MONTH, fechanacimiento) = 'October';

--Muestre los nombres y apellidos de los empleados que ingresaron en un determinado año (2 
--registros).
SELECT nombre, apellido FROM empleados WHERE DATEPART(YEAR,fechaingreso) = 2000;
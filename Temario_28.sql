--Ordenar registros (order by)
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20) DEFAULT 'Desconocido',
    editorial VARCHAR(20),
    precio DECIMAL(6,2),
    PRIMARY KEY(codigo)
);

GO

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25.33);
insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.65);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.95);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta',15);


SELECT * FROM libros;

-- Recuperamos los registros ordenados por el título:
SELECT * FROM libros ORDER BY titulo;

-- Ordenamos los registros por el campo "precio", referenciando el campo
-- por su posición en la lista de selección:
SELECT * FROM libros ORDER BY 5;

-- Los ordenamos por "editorial", de mayor a menor empleando "desc":
SELECT * FROM libros ORDER BY editorial DESC;

-- Ordenamos por dos campos:
SELECT * FROM libros ORDER BY titulo, editorial;

-- Ordenamos en distintos sentidos:
SELECT * FROM libros ORDER BY titulo ASC, editorial DESC;

-- Ordenamos por un campo que no se lista en la selección:
SELECT titulo, autor FROM libros ORDER BY precio;

-- Ordenamos por un valor calculado:
SELECT titulo, autor, editorial, precio - (precio * 0.1) AS 'precio con descuento'
  FROM libros ORDER BY 4;

--Ejercicio 1
IF OBJECT_ID('visitas') IS NOT NULL
  DROP TABLE visitas;

CREATE TABLE visitas(
  numero INT IDENTITY,
  nombre VARCHAR(30) default 'Anónimo',
  mail VARCHAR(50),
  pais VARCHAR(20),
  fecha DATETIME,
  PRIMARY KEY(numero)
);

 insert into visitas (nombre,mail,pais,fecha)
  values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:20');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');

SELECT * FROM visitas;

--Ordene los registros por fecha, en orden descendente.
SELECT * FROM visitas ORDER BY fecha DESC;

--Muestre el nombre del usuario, pais y el nombre del mes, ordenado por pais (ascendente) y nombre 
--del mes (descendente)

SELECT nombre, pais, DATENAME(MONTH, fecha) FROM visitas ORDER BY pais ASC, 3 DESC;

--Muestre el pais, el mes, el día y la hora y ordene las visitas por nombre del mes, del día y la 
--hora.

SELECT pais, DATENAME(MONTH, fecha), DATEPART(DAY, fecha), DATEPART(HOUR, fecha)
  FROM visitas ORDER BY 2, 3, 4;

--Muestre los mail, país, ordenado por país, de todos los que visitaron la página en octubre (4 
--registros)

SELECT mail, pais FROM visitas WHERE DATENAME(MONTH, fecha) = 'October' ORDER BY pais;
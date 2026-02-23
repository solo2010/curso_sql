--Funciones de agrupamiento (count - sum - min - max - avg)
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(30) DEFAULT 'Desconocido',
    editorial VARCHAR(15),
    precio DECIMAL(5,2),
    cantidad TINYINT,
    PRIMARY KEY(codigo)
);

GO

INSERT INTO libros VALUES('El aleph','Borges','Planeta',15,null);
INSERT INTO libros VALUES('Martin Fierro','Jose Hernandez','Emece',22.20,200);
INSERT INTO libros VALUES('Antologia poetica','J.L. Borges','Planeta',null,150);
INSERT INTO libros VALUES('Aprenda PHP','Mario Molina','Emece',18.20,null);
INSERT INTO libros VALUES('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100);
INSERT INTO libros VALUES('Manual de PHP', 'J.C. Paez', 'Siglo XXI',31.80,120);
INSERT INTO libros VALUES('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90);
INSERT INTO libros VALUES('Harry Potter y la camara secreta','J.K. Rowling','Emece',46.00,100);
INSERT INTO libros (titulo,autor,cantidad) VALUES('Alicia en el pais de las maravillas','Lewis Carroll',220);
INSERT INTO libros (titulo,autor,cantidad) VALUES('PHP de la A a la Z',default,0);

SELECT * FROM libros;

-- Cantidad total de libros, sumamos las cantidades de cada uno:
SELECT SUM(cantidad) FROM libros;

-- Para conocer cuántos libros tenemos de la editorial "Emece":
SELECT SUM(cantidad) FROM libros WHERE editorial = 'Emece';

-- Queremos saber cuál es el libro más costoso:
SELECT MAX(precio) FROM libros;

-- Para conocer el precio mínimo de los libros de "Rowling":
SELECT MIN(precio) FROM libros WHERE autor LIKE '%Rowling%';

 -- Queremos saber el promedio del precio de los libros referentes a "PHP":
 SELECT AVG(precio) FROM libros WHERE titulo LIKE '%PHP%';

 --Ejercicio
if object_id('empleados') is not null
   drop table empleados;

create table empleados(
   nombre varchar(30),
   documento char(8),
   domicilio varchar(30),
   seccion varchar(20),
   sueldo decimal(6,2),
   cantidadhijos tinyint,
   primary key(documento)
);

GO

insert into empleados
 values('Juan Perez','22333444','Colon 123','Gerencia',5000,2);
insert into empleados
 values('Ana Acosta','23444555','Caseros 987','Secretaria',2000,0);
insert into empleados
 values('Lucas Duarte','25666777','Sucre 235','Sistemas',4000,1);
insert into empleados
 values('Pamela Gonzalez','26777888','Sarmiento 873','Secretaria',2200,3);
insert into empleados
 values('Marcos Juarez','30000111','Rivadavia 801','Contaduria',3000,0);
insert into empleados
 values('Yolanda Perez','35111222','Colon 180','Administracion',3200,1);
insert into empleados
 values('Rodolfo Perez','35555888','Coronel Olmedo 588','Sistemas',4000,3);
insert into empleados
 values('Martina Rodriguez','30141414','Sarmiento 1234','Administracion',3800,4);
insert into empleados
 values('Andres Costa','28444555',default,'Secretaria',null,null);

--Muestre la cantidad de empleados usando "count" (9 empleados)
SELECT COUNT(*) FROM empleados;

--Muestre la cantidad de empleados con sueldo no nulo de la sección "Secretaria" (2 empleados)
SELECT COUNT(sueldo) FROM empleados WHERE seccion = 'Secretaria';

--Muestre el sueldo más alto y el más bajo colocando un alias (5000 y 2000)
SELECT MAX(sueldo) AS 'Sueldo mas alto', MIN(sueldo) AS 'Sueldo mas bajo' FROM empleados;

--Muestre el valor mayor de "cantidadhijos" de los empleados "Perez" (3 hijos)
SELECT MAX(cantidadhijos) FROM empleados WHERE nombre LIKE '%Perez%';

--Muestre el promedio de sueldos de todo los empleados (3400. Note que hay un sueldo nulo y no es 
--tenido en cuenta)
SELECT AVG(sueldo) FROM empleados;

--Muestre el promedio de sueldos de los empleados de la sección "Secretaría" (2100)
SELECT AVG(sueldo) FROM empleados WHERE seccion = 'Secretaria';

--Muestre el promedio de hijos de todos los empleados de "Sistemas" (2)
SELECT AVG(cantidadhijos) FROM empleados  WHERE seccion = 'Sistemas';
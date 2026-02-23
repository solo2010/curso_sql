--Búsqueda de patrones (like - not like)

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

INSERT INTO libros VALUES('El alehp', 'Borges', 'Emece', 15.90);
INSERT INTO libros(titulo, editorial, precio) VALUES('Cien años de Soledad', 'Emece', 16.96);
insert into libros VALUES('Antología poética','J. L. Borges','Planeta',null);
INSERT INTO libros VALUES('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
INSERT INTO libros VALUES('Matematica estas ahi','Paenza','Siglo XXI',15);
INSERT INTO libros VALUES('Martin Fierro','Jose Hernandez',default,40);
INSERT INTO libros VALUES('Aprenda PHP','Mario Molina','Nuevo siglo',56.50);

SELECT * FROM libros;

-- Recuperamos todos los libros que contengan en el campo "autor" la cadena "Borges":
SELECT * FROM libros WHERE autor LIKE '%Borges%';

-- Seleccionamos los libros cuyos títulos comienzan con la letra "M":
SELECT * FROM libros WHERE titulo LIKE 'M%';

-- Seleccionamos todos los títulos que NO comienzan con "M":
SELECT * FROM libros WHERE titulo NOT LIKE 'M%';

-- Si queremos ver los libros de "Lewis Carroll" pero no recordamos si se escribe 
-- "Carroll" o "Carrolt", podemos emplear el comodín "_" (guión bajo) y establecer
-- la siguiente condición:
SELECT * FROM libros WHERE autor LIKE '%Carrol_';

-- Buscamos los libros cuya editorial comienza con las letras entre la "P" y la "S":
SELECT * FROM libros WHERE editorial LIKE '[P,S]%';

-- Seleccionamos los libros cuya editorial NO comienza con las letras "P" ni "N":
SELECT * FROM libros WHERE editorial LIKE '[^PN]%';

-- Recuperamos todos los libros cuyo precio se encuentra entre 10.00 y 19.99:
SELECT * FROM libros WHERE precio LIKE '1_.%';

-- Recuperamos los libros que NO incluyen centavos en sus precios:
SELECT * FROM libros WHERE precio LIKE '%.00';

--Ejercicio 1
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    nombre VARCHAR(30),
    documento CHAR(8),
    domicilio VARCHAR(30),
    fechaingreso DATETIME,
    seccion VARCHAR(20),
    sueldo DECIMAL(6,2)
    PRIMARY KEY(documento)
);

GO

INSERT INTO empleados VALUES('Juan Perez','22333444','Colon 123','1990-10-08','Gerencia',900.50);
INSERT INTO empleados VALUES('Ana Acosta','23444555','Caseros 987','1995-12-18','Secretaria',590.30);
INSERT INTO empleados VALUES('Lucas Duarte','25666777','Sucre 235','2005-05-15','Sistemas',790);
INSERT INTO empleados VALUES('Pamela Gonzalez','26777888','Sarmiento 873','1999-02-12','Secretaria',550);
INSERT INTO empleados VALUES('Marcos Juarez','30000111','Rivadavia 801','2002-09-22','Contaduria',630.70);
INSERT INTO empleados VALUES('Yolanda Perez','35111222','Colon 180','1990-10-08','Administracion',400);
INSERT INTO empleados VALUES('Rodolfo Perez','35555888','Coronel Olmedo 588','1990-05-28','Sistemas',800);

--Muestre todos los empleados con apellido "Perez" empleando el operador "like" (3 registros)
SELECT * FROM empleados WHERE nombre LIKE '%Perez%';

--Muestre todos los empleados cuyo domicilio comience con "Co" y tengan un "8" (2 registros)
SELECT * FROM empleados WHERE domicilio LIKE 'Co%8%';

--Seleccione todos los empleados cuyo documento finalice en 0,2,4,6 u 8 (4 registros)
SELECT * FROM empleados WHERE documento LIKE '%[02468]';

--Seleccione todos los empleados cuyo documento NO comience con 1 ni 3 y cuyo nombre finalice en 
--"ez" (2 registros)
SELECT * FROM empleados WHERE documento LIKE '[^13]%' AND nombre LIKE '%ez';

--Recupere todos los nombres que tengan una "y" o una "j" en su nombre o apellido (3 registros)
SELECT * FROM empleados WHERE nombre LIKE '%[yj]%';

--Muestre los nombres y sección de los empleados que pertenecen a secciones que comiencen con "S" o 
--"G" y tengan 8 caracteres (3 registros)
SELECT nombre, seccion FROM empleados WHERE seccion LIKE  '[SG]_______';

--Muestre los nombres y sección de los empleados que pertenecen a secciones que NO comiencen con 
--"S" o "G" (2 registros)
SELECT nombre, seccion FROM empleados WHERE seccion LIKE '[^SG]%';

--Muestre todos los nombres y sueldos de los empleados cuyos sueldos incluyen centavos (3 
--registros)
SELECT nombre, sueldo FROM empleados WHERE sueldo NOT LIKE '%.00';

--Muestre los empleados que hayan ingresado en "1990" (3 registros)
SELECT * FROM empleados WHERE fechaingreso LIKE '1990%';


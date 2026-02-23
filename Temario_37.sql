--Agrupar registros (group by)
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio DECIMAL(5,2),
    cantidad TINYINT,
    PRIMARY KEY(codigo)
);

INSERT INTO libros VALUES('El aleph','Borges','Planeta',15,null);
INSERT INTO libros VALUES('Martin Fierro','Jose Hernandez','Emece',22.20,200);
INSERT INTO libros VALUES('Antologia poetica','J.L. Borges','Planeta',null,150);
INSERT INTO libros VALUES('Aprenda PHP','Mario Molina','Emece',18.20,null);
INSERT INTO libros VALUES('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100);
INSERT INTO libros VALUES('Manual de PHP', 'J.C. Paez', 'Siglo XXI',31.80,120);
INSERT INTO libros VALUES('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90);
INSERT INTO libros VALUES('Harry Potter y la camara secreta','J.K. Rowling','Emece',null,100);
INSERT INTO libros VALUES('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',22.50,200);
INSERT INTO libros VALUES('PHP de la A a la Z',null,null,null,0);

SELECT * FROM libros;

-- Cantidad de libros de cada editorial:
SELECT editorial, COUNT(*) FROM libros GROUP BY editorial;

-- Cantidad libros con precio no nulo de cada editorial:
SELECT editorial, COUNT(precio) FROM libros GROUP BY editorial;

-- Total en dinero de los libros agrupados por editorial:
SELECT editorial, SUM(precio) AS 'Total en dinero' FROM libros GROUP BY editorial;

-- Máximo y mínimo valor de los libros agrupados por editorial:
SELECT editorial, MAX(precio) AS 'Valor Maximo', MIN(precio) AS 'Valor Mínimo' 
    FROM libros GROUP BY editorial;

-- Promedio del valor de los libros agrupados por editorial:
SELECT editorial, AVG(precio) AS 'Promedio del Valor' FROM libros GROUP BY editorial;

-- Contar y agrupar por editorial considerando solamente los libros cuyo precio es menor a 30 pesos:
SELECT editorial, COUNT(*) FROM libros 
    WHERE precio < 30
    GROUP BY editorial;

-- Todos los valores de editorial, incluso los que devuelven cero o "null" en la columna de agregado,
--  debemos emplear la palabra clave "all" al lado de "group by":
SELECT editorial, COUNT(*) FROM libros
    GROUP BY ALL editorial;


--Ejercicio 1
IF OBJECT_ID('visitantes') IS NOT NULL
    DROP TABLE visitantes;

CREATE TABLE visitantes(
    nombre VARCHAR(30),
    edad TINYINT,
    sexo CHAR(1) DEFAULT 'f',
    domicilio VARCHAR(30),
    ciudad VARCHAR(20) DEFAULT 'Cordoba',
    telefono VARCHAR(11),
    mail VARCHAR(30) DEFAULT 'No tiene',
    montocompra DECIMAL(6,2)
);

GO

INSERT INTO visitantes
  VALUES ('Susana Molina',35,default,'Colon 123',default,null,null,59.80);
INSERT INTO visitantes
  VALUES ('Marcos Torres',29,'m',default,'Carlos Paz',default,'marcostorres@hotmail.com',150.50);
INSERT INTO visitantes
  VALUES ('Mariana Juarez',45,default,default,'Carlos Paz',null,default,23.90);
INSERT INTO visitantes (nombre, edad,sexo,telefono, mail)
  VALUES ('Fabian Perez',36,'m','4556677','fabianperez@xaxamail.com');
INSERT INTO visitantes (nombre, ciudad, montocompra)
  VALUES ('Alejandra Gonzalez','La Falda',280.50);
INSERT INTO visitantes (nombre, edad,sexo, ciudad, mail,montocompra)
  VALUES ('Gaston Perez',29,'m','Carlos Paz','gastonperez1@gmail.com',95.40);
INSERT INTO visitantes
  VALUES ('Liliana Torres',40,default,'Sarmiento 876',default,default,default,85);
INSERT INTO visitantes
  VALUES ('Gabriela Duarte',21,null,null,'Rio Tercero',default,'gabrielaltorres@hotmail.com',321.50);

SELECT * FROM visitantes;

--Queremos saber la cantidad de visitantes de cada ciudad utilizando la cláusula "group by" (4 filas devueltas)
SELECT ciudad, COUNT(*) AS 'Cantidad de visitantes' FROM visitantes GROUP BY ciudad;

--Queremos la cantidad visitantes con teléfono no nulo, de cada ciudad (4 filas devueltas)
SELECT ciudad, COUNT(telefono) AS 'Cantidad de visitantes' FROM visitantes GROUP by ciudad;

--Necesitamos el total del monto de las compras agrupadas por sexo (3 filas)
SELECT sexo, SUM(montocompra) AS 'Total Compras' FROM visitantes GROUP BY sexo;

--Se necesita saber el máximo y mínimo valor de compra agrupados por sexo y ciudad (6 filas)
SELECT sexo, ciudad, MAX(montocompra) AS 'Valor Máximo', MIN(montocompra) AS 'Valor Mínimo'
    FROM visitantes GROUP BY sexo, ciudad;

--Calcule el promedio del valor de compra agrupados por ciudad (4 filas)
SELECT ciudad, AVG(montocompra) AS 'Promedio Valor Compra' FROM visitantes
    GROUP BY ciudad;

--Cuente y agrupe por ciudad sin tener en cuenta los visitantes que no tienen mail (3 filas):
SELECT COUNT(*) AS 'Cantidad con mail' FROM visitantes
    WHERE mail IS NOT NULL AND mail <> 'no tiene'
    GROUP BY ciudad;

-- Ejercicio 2
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    nombre VARCHAR(30),
    documento CHAR(8),
    domicilio VARCHAR(30),
    seccion VARCHAR(20),
    sueldo DECIMAL(6,2),
    cantidadhijos TINYINT,
    fechaingreso DATETIME,
    PRIMARY KEY(documento)
);

GO

INSERT INTO empleados VALUES('Juan Perez','22333444','Colon 123','Gerencia',5000,2,'1980-05-10');
INSERT INTO empleados VALUES('Ana Acosta','23444555','Caseros 987','Secretaria',2000,0,'1980-10-12');
INSERT INTO empleados VALUES('Lucas Duarte','25666777','Sucre 235','Sistemas',4000,1,'1985-05-25');
INSERT INTO empleados VALUES('Pamela Gonzalez','26777888','Sarmiento 873','Secretaria',2200,3,'1990-06-25');
INSERT INTO empleados VALUES('Marcos Juarez','30000111','Rivadavia 801','Contaduria',3000,0,'1996-05-01');
INSERT INTO empleados VALUES('Yolanda Perez','35111222','Colon 180','Administracion',3200,1,'1996-05-01');
INSERT INTO empleados VALUES('Rodolfo Perez','35555888','Coronel Olmedo 588','Sistemas',4000,3,'1996-05-01');
INSERT INTO empleados VALUES('Martina Rodriguez','30141414','Sarmiento 1234','Administracion',3800,4,'2000-09-01');
INSERT INTO empleados VALUES('Andres Costa','28444555',default,'Secretaria',null,null,null);

SELECT * FROM empleados;

--Cuente la cantidad de empleados agrupados por sección (5 filas)
SELECT seccion, COUNT(*) FROM empleados GROUP BY seccion;

--Calcule el promedio de hijos por sección (5 filas):
SELECT seccion, AVG(cantidadhijos) AS 'Promedio Empleados'
    FROM empleados GROUP BY seccion;

--Cuente la cantidad de empleados agrupados por año de ingreso (6 filas)
SELECT YEAR(fechaingreso), COUNT(*) FROM empleados GROUP BY(YEAR(fechaingreso));

 select datepart(year,fechaingreso), count(*)
  from empleados
  group by datepart(year,fechaingreso);

--Calcule el promedio de sueldo por sección de los empleados con hijos (4 filas)
SELECT seccion, AVG(sueldo) FROM empleados
    WHERE cantidadhijos > 0 AND cantidadhijos IS NOT NULL
    GROUP BY seccion;

--Realice la misma consulta anterior pero esta vez incluya las secciones que devuelven cero o 
--"null" en la columna de agregado (5 filas)
 select seccion, avg(sueldo) as 'promedio de sueldo'
  from empleados
  where cantidadhijos>0 and
  cantidadhijos is not null
  group by all seccion;

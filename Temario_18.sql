-- Tipo de dato (numérico)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo SMALLINT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio SMALLMONEY,
    cantidad TINYINT
);

GO

SELECT * FROM libros;

-- Intentemos ingresar un valor fuera del rango definido, una cantidad 
-- que supera el rango del tipo "tinyint", el valor 260 (genera error):
--El limite de tinyint es hasta 255


INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Satanás', 'Mario Mendoza', 'Planeta', 25.6, 260);

SELECT * FROM libros;

-- Intentamos ingresar un precio que supera el rango del tipo "smallmoney",
-- el valor 250000 (genera error):
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Diario del fin del mundo', 'Mario Mendoza', 'Emece', 25000000, 14);

-- Intentamos ingresar una cadena que SQL Server no pueda convertir a valor 
-- numérico en el campo "precio" (genera error):
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('it', 'Stephen King', 'Emece', '45.4a', 100);

-- Ingresamos una cadena en el campo "cantidad" (lo convierte a valor numérico)
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('El resplandor', 'Stephen King', 'Emece', 45.4, '100');

SELECT * FROM libros;


--Ejercicio 1
IF OBJECT_ID('cuentas') IS NOT NULL
    DROP TABLE cuentas;

CREATE TABLE cuentas(
    numero INT,
    documento CHAR(8) NOT NULL,
    nombre VARCHAR(30),
    saldo MONEY
    PRIMARY KEY(numero)
);

GO

 insert into cuentas(numero,documento,nombre,saldo)
  values('1234','25666777','Pedro Perez',500000.60);
 insert into cuentas(numero,documento,nombre,saldo)
  values('2234','27888999','Juan Lopez',-250000);
 insert into cuentas(numero,documento,nombre,saldo)
  values('3344','27888999','Juan Lopez',4000.50);
 insert into cuentas(numero,documento,nombre,saldo)
  values('3346','32111222','Susana Molina',1000);

  
SELECT * FROM cuentas WHERE saldo > 4000;

SELECT numero, saldo FROM cuentas WHERE nombre = 'Juan Lopez';

SELECT * FROM cuentas WHERE saldo < 0;

SELECT * FROM cuentas WHERE numero >= 3000;

--Ejercicio 2
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(

    nombre VARCHAR(30),
    documento CHAR(8),
    sexo CHAR(1),
    domicilio VARCHAR(30),
    sueldobasico DECIMAL(7,2), --Maximo estimado 99999.99
    cantidadhijos TINYINT --No supera los 255
);

GO

 insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
  values ('Juan Perez','22333444','m','Sarmiento 123',500,2);
 insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
  values ('Ana Acosta','24555666','f','Colon 134',850,0);
 insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
  values ('Bartolome Barrios','27888999','m','Urquiza 479',10000.80,4);

SELECT * FROM  empleados;

--Ingresamos un valor de "sueldobasico" con más decimales que los definidos
--(redondea los decimales al valor más cercano 800.89):
INSERT INTO empleados(nombre, documento, sexo, domicilio, sueldobasico, cantidadhijos)
    VALUES('Daniel Lopez', '32525395', 'M', 'Barrio el Socorro', 800.8333,0);

SELECT * FROM empleados where documento = '32525395';

--Intente ingresar un sueldo que supere los 7 dígitos (no lo permite)
INSERT INTO empleados(nombre, documento, sexo, domicilio, sueldobasico, cantidadhijos)
    VALUES('Geny Vargas', '12345678', 'F', 'Felipe Echavarria', 9805456545123.3142, 0);

--Muestre todos los empleados cuyo sueldo no supere los 900 pesos:
SELECT * FROM empleados WHERE sueldobasico <= 900;

--Seleccione los nombres de los empleados que tengan hijos.
SELECT nombre FROM empleados WHERE cantidadhijos > 0;
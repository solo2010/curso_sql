--Omitir lista de campos y omitir campos especificos

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(30),
    editorial VARCHAR(15)
);

GO

-- Si ingresamos valores para todos los campos, podemos omitir la lista de campos:
INSERT INTO libros VALUES('Uno', 'Richard Bach', 'Planeta');

SELECT * FROM libros;

-- Podemos ingresar valores para algunos de los campos:
INSERT INTO libros(titulo, autor) VALUES('Satanás', 'Mario Mendoza');

SELECT * FROM libros;

-- No podemos omitir el valor para un campo declarado "not null",
-- como el campo "titulo" (genera error):
INSERT INTO libros(autor, editorial) VALUES('Stephen King', 'Debolsillo');

--Ejercicio 1
IF OBJECT_ID('cuentas') IS NOT NULL
    DROP TABLE cuentas;

CREATE TABLE cuentas(
    numero INT IDENTITY,
    documento CHAR(8) NOT NULL,
    nombre VARCHAR(30),
    saldo MONEY
);

--Ingrese un registro con valores para todos sus campos, inclusive el campo identity, omitiendo la 
--lista de campos (error, no se debe ingresar para el campo identity):
INSERT INTO cuentas VALUES(1,'32505456', 'Daniel Lopez', 4000000); 

--Ingrese un registro con valores para todos sus campos omitiendo la lista de campos (excepto el campo "identity"):
INSERT INTO cuentas VALUES('32525395', 'Flor Ceciclia Lopez', 2700000);

--Ingrese un registro omitiendo algún campo que admitan valores nulos.
INSERT INTO cuentas(documento, saldo) VALUES('12234556', 2500000);
select * FROM cuentas;


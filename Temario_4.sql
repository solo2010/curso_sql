IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(80),
    autor VARCHAR(40),
    editorial VARCHAR(30),
    precio FLOAT,
    cantidad INTEGER
);

EXEC sp_columns libros;

INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Misery', 'Stephen King', 'Planeta', 4000.0, 3);
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Satanás', 'Marioa Mendoza', 'Planeta', 5300.4, 1);
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('La verdad sobre caso de Harry Quebert', 'Planeta', 'Joel Dicker', 3000.50, 2);

SELECT * FROM libros;

INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Mi dulce Audrina', 'Virgina CV', 'Nose', 120000, 5);

SELECT * FROM libros;


/**EJERCICIOS**/

/********Ejercicio 1*********/
IF object_id('peliculas') is NOT NULL
    DROP TABLE peliculas;

CREATE TABLE peliculas(
    nombre VARCHAR(20),
    actor VARCHAR(20),
    duracion INTEGER,
    cantidad INTEGER
);

EXEC sp_columns peliculas;

INSERT INTO peliculas(nombre, actor, duracion, cantidad)
    VALUES('Mision Imposible', 'Tom Cruise', 128,3);
INSERT INTO peliculas(nombre, actor, duracion, cantidad)
    VALUES('Misión Imposible 2', 'Tom Cruise',130,2);
INSERT INTO peliculas(nombre, actor, duracion, cantidad)
    VALUES('Mujer Bonita', 'Julia Roberts', 118, 3);
INSERT INTO peliculas(nombre, actor, duracion, cantidad)
    VALUES('Elsa y Fred', 'China Zorrilla', 110, 2);

SELECT * FROM peliculas;

/*****Ejercicio 2******/
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    nombre VARCHAR(20),
    documento VARCHAR(8),
    sexo VARCHAR(1),
    domicilio VARCHAR(30),
    sueldo_basico FLOAT
);

EXEC sp_columns empleados;

INSERT INTO empleados(nombre, documento, sexo, domicilio, sueldo_basico)
    VALUES('Daniel Lopez Marin', '57896521', 'M', 'El Socorro 51', 4000000);
INSERT INTO empleados(nombre, documento, sexo, domicilio, sueldo_basico)
    VALUES('Flor Cecilia Lopez', '32525395', 'F', 'El Socorro 51', 1700000);
INSERT INTO empleados(nombre, documento, sexo, domicilio, sueldo_basico)
    VALUES('Geny Marcela Vargas', '32849765', 'F', 'Felipe Echavarria', 3500000);

SELECT * FROM empleados;
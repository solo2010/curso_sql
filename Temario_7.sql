IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(30),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio FLOAT
);

GO

INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('El aleph', 'Borges', 'Emcece', 24.50);
INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Martin Fierro', 'Jose Hernandez', 'Emece', 16.00);
INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Aprenda PHP', 'Mario Molina', 'Emece', 35.40);
INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Cervantes y el Quijote', 'Borges', 'Paidos', 50.90);

--Seleccionamos los registros cuyo autor sea diferente de Borges
SELECT * FROM libros WHERE autor <> 'Borges';

--Seleccionamos los registros cuyo precio supere los 20 pesos, solo el título y precio
SELECT * FROM libros WHERE precio > 20;

--Recuperamos los libros cuyo precio es menor o igual a 30
SELECT * FROM libros WHERE precio <= 30;

--EJERCICIOS--

--Ejercicio 1--

IF OBJECT_ID('articulos') IS NOT NULL
    DROP TABLE articulos;

CREATE TABLE articulos(
    codigo INTEGER,
    nombre VARCHAR(20),
    descripcion VARCHAR(30),
    precio FLOAT,
    cantidad INTEGER
);

GO

EXEC sp_columns ARTICULOS;

INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(1, 'Impresora', 'Epson Stylus C45', 400.80, 2);
INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(2, 'Impresora', 'Epson Stylus C85', 500, 30);
INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(3, 'Monitor', 'Samsung 14', 800, 10);
INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(4, 'Teclado', 'Ingles Biswal', 100, 50);
INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(5, 'Teclado', 'Español Biswal', 90, 50);

SELECT * FROM articulos WHERE nombre = 'Impresora';

SELECT * FROM articulos WHERE precio >= 400;

SELECT codigo, nombre FROM articulos WHERE cantidad < 30;

SELECT nombre, descripcion FROM articulos WHERE precio <> 100;


--Ejercicio 2--
IF OBJECT_ID('peliculas') IS NOT NULL
    DROP TABLE peliculas

CREATE TABLE peliculas(
    titulo VARCHAR(20),
    actor VARCHAR(20),
    duracion INTEGER,
    cantidad INTEGER
);

GO

INSERT INTO peliculas(titulo, actor, duracion, cantidad)
    VALUES('Mision imposible','Tom Cruise',120,3);
INSERT INTO peliculas(titulo, actor, duracion, cantidad)
    VALUES('Mision imposible 2','Tom Cruise',180,4);
INSERT INTO peliculas(titulo, actor, duracion, cantidad)
    VALUES('Mujer bonita','Julia R.',90,1);
INSERT INTO peliculas(titulo, actor, duracion, cantidad)
    VALUES('Elsa y Fred','China Zorrilla',80,2);

SELECT * FROM peliculas WHERE duracion <= 90;

SELECT titulo FROM peliculas WHERE actor = 'Tom Cruise';

SELECT titulo, actor, cantidad FROM peliculas WHERE cantidad > 2;

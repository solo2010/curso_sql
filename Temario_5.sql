IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(30),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio FLOAT,
    cantidad INTEGER
);

EXEC sp_columns libros;

INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('El Aleph', 'Borges', 'Emece', 25.30, 100);
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Cien años de soledad', 'Gabriel Garcia', 'Planeta', 30, 150);
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('22/11/63', 'Stephen King', 'Planeta', 25.50, 200);

SELECT * FROM libros;

-- recuperamos solo el titulo, autor y editorial de la tabla libros
SELECT titulo, autor, editorial FROM libros;

-- recuperamos el titulo y el precio
SELECT titulo, precio FROM libros;

-- recuperamos la editorial y la cantidad
SELECT editorial, cantidad FROM libros;

-- EJERCICIOS

-- Ejecicio 1 --

IF OBJECT_ID('peliculas') IS NOT NULL
    DROP TABLE peliculas;

CREATE TABLE peliculas(
    titulo VARCHAR(20),
    actor VARCHAR(20),
    duracion INTEGER,
    cantidad INTEGER
);

EXEC sp_columns peliculas;

INSERT INTO peliculas(titulo, actor, duracion, cantidad)
    VALUES('Mision Imposible', 'Tom Cruise', 130, 2);
INSERT INTO peliculas(titulo, actor, duracion, cantidad)
    VALUES('Titanic', 'Leonardo Dicaprio', 120, 3);
INSERT INTO peliculas(titulo, actor, duracion, cantidad)
    VALUES('Piratas del Caribe', 'Jhonny Deep', 120, 2);

SELECT * FROM peliculas;

SELECT titulo, actor FROM peliculas;

SELECT titulo, duracion FROM peliculas;

SELECT titulo, cantidad FROM peliculas;



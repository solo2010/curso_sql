USE cursosql;

IF OBJECT_ID('usuarios') IS NOT NULL
    DROP TABLE usuarios;

CREATE TABLE usuarios(
    nombre VARCHAR(20),
    clave VARCHAR(10),
    PRIMARY KEY(nombre)
);

GO

EXEC sp_columns usuarios

INSERT INTO usuarios(nombre, clave) VALUES('Juan Perez', 'Boca');
INSERT INTO usuarios(nombre, clave) VALUES('Raul Garcia', 'River');

SELECT * FROM usuarios;

-- Intentamos ingresar un valor de clave primaria existente (genera error):
INSERT INTO usuarios(nombre, clave) VALUES('Juan Perez', 'River');

--Intentamos ingresar un valor null en el campo clave primaria (genera error):
INSERT INTO usuarios(nombre, clave) VALUES(null, 'payaso');

--INtentamos actualizar el nombre usuario de uno de los campos con un usuario ya existente (genera error):
UPDATE usuarios SET nombre='Juan Perez' WHERE clave = 'River';

--EJERCICIOS--

--Ejercicio 1--

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INTEGER NOT NULL,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20),
    editorial varchar(15),
    PRIMARY KEY(codigo)
);

EXEC sp_columns libros;

INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(1, 'El aleph', 'Borges', 'Emece');
INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(2, 'Martin Fierro', 'Jose Hernandez', 'Planeta');
INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(3, 'Aprenda PHP', 'Mario Molina', 'Nuevo Siglo');

SELECT * FROM libros;

--Ingreso registro con código repetido (genera error)
INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(1, 'Cien años de soledad', 'Garcia Marquez', 'Planeta');

--Ingreso valor null en el campo código (genera error)
INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(NULL, 'Satanás', 'Mario Mendoza', 'Emece');

SELECT * FROM libros

--Intento actualizar el código del libro de Martin Fierro a 1 (genera error)
UPDATE libros SET codigo=1 WHERE titulo = 'Martin fierro';

--Ejercicio 2--


IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE alumnos(
    legajo VARCHAR(4) NOT NULL,
    documento VARCHAR(8),
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    PRIMARY KEY(documento),
)

EXEC sp_columns alumnos;

INSERT INTO alumnos(legajo, documento, nombre, domicilio)
    VALUES('A233', '22345345', 'Perez Mariana', 'Colon 234');
INSERT INTO alumnos(legajo, documento, nombre, domicilio)
    VALUES('A567', '23545345', 'Morales Marcos', 'Avellaneda 348');

SELECT * FROM alumnos;

--Intento ingresar número de documento existente
INSERT INTO alumnos(legajo, documento, nombre, domicilio)
    VALUES('A233', '22345345', 'Perez Mariana', 'Colon');

--Intento ingresar documento nulo
INSERT INTO alumnos(legajo, documento, nombre, domicilio)
    VALUES('A233', NULL, 'Daniel Lopez', 'Caldas');
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
    editorial VARCHAR(15),
    PRIMARY KEY(codigo)
);

GO

INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(1, 'El aleph', 'Borges', 'Emece');
INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(2, 'Martin Fierro', 'Jose Hernandez', 'Planeta');
INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(3, 'Aprenda PHP', 'Mario Molina', 'Nuevo Siglo');

SELECT * FROM libros;

--Esto va a generar error ya que no se puede repetir clave primaria
INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(1, 'Satanás', 'Mario Mendoza', 'Planeta');

--Esto va a generar error ya que no se puede tener run valor null en una llave primaria
INSERT INTO libros(codigo, titulo, autor, editorial)
    VALUES(NULL, 'La perra', 'Pilar Quintana', 'Emece');

UPDATE libros SET codigo = 1 WHERE titulo = 'Martin Fierro';

--Ejercicio 2

IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE alumnos(
    legajo VARCHAR(4) NOT NULL,
    documento VARCHAR(8),
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    PRIMARY KEY(documento)
);

EXEC sp_columns alumnos;

INSERT INTO alumnos(legajo, documento, nombre, domicilio)
    VALUES('A233', '22345345', 'Perez Mariana', 'Colon 234');
INSERT INTO alumnos(legajo, documento, nombre, domicilio)
    VALUES('A567', '23545345', 'Morales Marcos', 'Avellanada 348');

SELECT * FROM alumnos;

--Se ingresa documento existente, saca error ya que el documento es primary key
INSERT INTO alumnos(legajo, documento, nombre, domicilio)
    VALUES('A327', '22345345', 'Daniel Lopez', 'Barrio el Socorro');

--Ingreso alumno con documento NULL, saca error ya que el documento es primary key
INSERT INTO alumnos(Legajo, documento, nombre, domicilio)
    VALUES('A327', NULL, 'Daniel Lopez', 'Barrio el Socorro');
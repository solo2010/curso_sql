CREATE TABLE usuarios(
    nombre VARCHAR(30),
    clave VARCHAR(10)
);

INSERT INTO usuarios(nombre, clave) VALUES('Daniel', 'Solo');

SELECT * FROM usuarios;


IF object_id('usuarios') IS NOT NULL
    DROP table usuarios;

CREATE TABLE usuarios(
    nombre VARCHAR(30),
    clave VARCHAR(10)
);

INSERT INTO usuarios(nombre, clave) VALUES('Daniel', 'Solo');

SELECT * FROM usuarios;

INSERT INTO usuarios(clave,nombre) VALUES('Chila', 'Flor')

SELECT * FROM usuarios;

INSERT INTO usuarios(nombre,clave) VALUES('Edelmira', 'Mirita')

SELECT * FROM usuarios;

/*****EJERCICIOS*****/

/*****Ejercicio 1*****/
IF OBJECT_ID('agenda') IS NOT NULL
    DROP TABLE agenda;

CREATE TABLE agenda(
    apellido VARCHAR(30),
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    telefono VARCHAR(11)
);

EXEC sp_tables @table_owner='dbo' /*Observar todas las tablas que hay */

EXEC sp_columns agenda;

INSERT INTO agenda(apellido, nombre, domicilio, telefono) VALUES('Vargas Suarez', 'Geny Marcela', 'Santa Ines', '3045979161');
INSERT INTO agenda(nombre, apellido, domicilio, telefono) VALUES('Flor Cecilia', 'Lopez marin', 'Virgen del Socorro', '5045990047');

SELECT * FROM agenda;

DROP TABLE agenda;


/*****Ejercicio 2*****/

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(50),
    autor VARCHAR(30),
    editorial VARCHAR(15),
);

EXEC sp_tables @table_owner='dbo';

EXEC sp_columns libros;

INSERT INTO libros(titulo, autor, editorial) VALUES('El olvido que seremos', 'Hector Abad', 'No se');
INSERT INTO libros(titulo, autor, editorial) VALUES('IT', 'Stephen King', 'Planeta');
INSERT INTO libros(autor, editorial, titulo) VALUES('Mario Mendoza', 'Planeta', 'Satanás');

SELECT * FROM libros;
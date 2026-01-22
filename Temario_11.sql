IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(30) NOT NULL,
    autor VARCHAR(30) NOT NULL,
    editorial VARCHAR(15) NULL,
    precio FLOAT
);

GO

--Agregamos un registro a la tabla con valor nulo para el campo precio:
INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Cien años de soledad', 'Gabriel Garcia', 'Emece', NULL);

SELECT * FROM libros;

--Ingresamos otro registro, con valor nulo en el campo "Editorial"

INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Satanás', 'Mario Mendoza', NULL, 120000);

SELECT * FROM libros;

--Si intentamos ingresar el valor null en un campo que no lo permite se genera error
INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES(NULL, 'Gilberto Silva', 'Planeta', 2000);

EXEC sp_columns libros;

--Ingresamos campos con cadenas de texto vacias
INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Noche Negra', 'Pilar Quintana', '', 120000);

SELECT * FROM libros;

INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('', 'Stephen King', 'Planeta', 200000);

SELECT * FROM libros;

--Recuperamos los registros cuyo precio es nulll
SELECT * FROM libros WHERE precio IS NULL;

--Recuperaos los registros cuya editorial es null
SELECT * FROM libros WHERE editorial IS NULL;

--Ahora veamos los libros cuya editorial almacena una cadena vacia
SELECT * FROM libros WHERE editorial = '';

--Recuperar los registros cuyo precio no sea nulo
SELECT * FROM libros WHERE precio IS NOT NULL;

--EJERCICIOS--

--Ejercicio 1--

IF OBJECT_ID('medicamentos') IS NOT NULL
    DROP TABLE medicamentos;

CREATE TABLE medicamentos(
    codigo INTEGER NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    laboratorio VARCHAR(20),
    precio FLOAT,
    cantidad INTEGER NOT NULL 
);

GO

EXEC sp_columns medicamentos;

INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(1, 'Sertal Gotas', NULL, NULL, 100);
INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(2, 'Sertal Compuesto', NULL, 8.90, 150);
INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(3, 'Buscapina', 'Roche', NULL, 200);

SELECT * FROM medicamentos;

INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(4, 'Bayaspirina', '', 0,150);

INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(0, '', 'Bayern', 15.60, 0);

SELECT * FROM medicamentos;

INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(NULL, 'Acetaminofen', 'Bayern', 30,2);

SELECT * FROM medicamentos WHERE precio IS NULL;

SELECT * FROM medicamentos WHERE precio = 0;

SELECT * FROM medicamentos WHERE laboratorio <> '';

SELECT * FROM medicamentos WHERE laboratorio IS NOT NULL;

SELECT * FROM medicamentos WHERE precio <> 0;

SELECT * FROM medicamentos WHERE precio IS NOT NULL;

--Ejercicio 2

IF OBJECT_ID('peliculas') IS NOT NULL
    DROP TABLE peliculas;

CREATE TABLE peliculas(
    codigo INT NOT NULL,
    titulo VARCHAR(40) NOT NULL,
    actor VARCHAR(20),
    duracion INTEGER
);

EXEC sp_columns peliculas;

insert into peliculas (codigo,titulo,actor,duracion)
 values(1,'Mision imposible','Tom Cruise',120);
insert into peliculas (codigo,titulo,actor,duracion)
 values(2,'Harry Potter y la piedra filosofal',null,180);
insert into peliculas (codigo,titulo,actor,duracion)
 values(3,'Harry Potter y la camara secreta','Daniel R.',null);
insert into peliculas (codigo,titulo,actor,duracion)
 values(0,'Mision imposible 2','',150);
insert into peliculas (codigo,titulo,actor,duracion)
 values(4,'','L. Di Caprio',220);
insert into peliculas (codigo,titulo,actor,duracion)
 values(5,'Mujer bonita','R. Gere-J. Roberts',0);

SELECT * FROM peliculas;

INSERT INTO peliculas(codigo, titulo, actor, duracion)
    VALUES(null, 'Piratas del Caribe', 'Jhony Deep', 180);

SELECT * FROM peliculas WHERE actor IS NULL;

SELECT * FROM peliculas WHERE actor = '';

UPDATE peliculas SET duracion = 120 WHERE duracion IS NULL;

SELECT * FROM peliculas;

UPDATE peliculas SET actor = 'Desconocido' WHERE actor = '';

SELECT * FROM peliculas;

DELETE FROM peliculas WHERE titulo = '';

SELECT * FROM peliculas;
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio FLOAT
);

GO

INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('El aleph', 'Borges', 'Emece', 23);

SELECT * FROM libros;

INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Uno', 'Richard Bach', 'Planeta', 18);
INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Aprenda PHP', 'Mario Molina', 'Siglo XXI', 45.60);
INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Alicia en el pais de las maravillas', 'Lewis Carrol', 'Paidos', 15.50);

SELECT * FROM libros;

--Intentemos ingresar un valor para el campo "codigo" (genera error)
INSERT INTO libros(codigo, titulo, autor, editorial, precio)
    VALUES(5, 'Satanás', 'Mario Mendoza', 'Planeta', 50);

--Intentemos cambiar el valor código de algún registro (genera error)
UPDATE libros SET codigo = 2 WHERE titulo = 'El aleph';

DELETE FROM libros WHERE autor = 'Lewis Carrol';

SELECT * FROM libros;

INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('Satanás', 'Mario Mendoza', 'Planeta', 50);

SELECT * FROM libros;

--Ejercicio 1
IF OBJECT_ID('medicamentos') IS NOT NULL
    DROP TABLE medicamentos;

CREATE TABLE medicamentos(
    codigo INT IDENTITY,
    nombre VARCHAR(20),
    laboratorio VARCHAR(20),
    precio FLOAT,
    cantidad INT
);

EXEC sp_columns medicamentos;

INSERT INTO medicamentos(nombre, laboratorio, precio, cantidad)
    VALUES('Sertal', 'Roche', 5.2, 100);
INSERT INTO medicamentos(nombre, laboratorio, precio, cantidad)
    VALUES('Buscapina', 'Roche', 4.10, 200);
INSERT INTO medicamentos(nombre, laboratorio, precio, cantidad)
    VALUES('Amoxidal 500', 'Bayer', 15.60, 100);

SELECT * FROM medicamentos;

--Intentamos ingresar un registro con el campo código (genera error)
INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(4, 'acetaminofen', 'Bayer', 15, 20);

--Intentamos actualizar un valor de código (genera error)
UPDATE medicamentos SET codigo = 5 WHERE nombre = 'Buscapina';

SELECT * FROM medicamentos;

DELETE FROM medicamentos WHERE codigo = 3;

SELECT * FROM medicamentos;

--Ejercicio 2
IF OBJECT_ID('peliculas') IS NOT NULL
    DROP TABLE peliculas;

CREATE TABLE peliculas(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    actor VARCHAR(40),
    duracion INT,
    PRIMARY KEY(codigo)
);

GO

EXEC sp_columns peliculas;

 insert into peliculas (titulo,actor,duracion)
  values('Mision imposible','Tom Cruise',120);
 insert into peliculas (titulo,actor,duracion)
  values('Harry Potter y la piedra filosofal','Daniel R.',180);
 insert into peliculas (titulo,actor,duracion)
  values('Harry Potter y la camara secreta','Daniel R.',190);
 insert into peliculas (titulo,actor,duracion)
  values('Mision imposible 2','Tom Cruise',120);
 insert into peliculas (titulo,actor,duracion)
  values('La vida es bella','zzz',220);

SELECT * FROM peliculas;

--Intento actualizar el codigo de un registro (genera ERROR)
UPDATE peliculas SET codigo = 7 WHERE actor = 'zzz';

SELECT * FROM peliculas;

DELETE FROM peliculas WHERE codigo = 5;

INSERT INTO peliculas(titulo, actor, duracion)
    VALUES('Castlevania', 'Alucard', 120);

SELECT * FROM peliculas;



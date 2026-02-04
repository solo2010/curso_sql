IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY(100,2),
    titulo VARCHAR(20),
    autor VARCHAR(30),
    precio FLOAT
);

GO

INSERT INTO libros(titulo, autor, precio)
    VALUES('Satanás', 'Mario Mendoza', 50);
INSERT INTO libros(titulo, autor, precio)
    VALUES('La perra', 'Pilar Quintana', 50);
INSERT INTO libros(titulo, autor, precio)
    VALUES('Como perderlo todo', 'Silva Romero', 25);

SELECT * FROM libros;

SELECT IDENT_SEED('libros'); --El IDENT_SEED nos muestra el valor inicial del identitiy

-- Si intentamos ingresar un valor para el campo "codigo" (genera error):
INSERT INTO libros(codigo, titulo, autor, precio)
    VALUES(4, 'IT', 'Stephen King', 'DeBolsillo');

-- Para permitir ingresar un valor en un campo de identidad activamos la opción "identity_insert":
SET IDENTITY_INSERT libros ON;

-- Recordemos que si "identity_insert" está en ON, la instrucción "insert" DEBE explicitar un valor:
INSERT INTO libros(codigo, titulo, autor, precio)
    VALUES(100, 'IT', 'Stephen King', 50);

SELECT * FROM libros;

-- Note que ingresamos un valor de código que ya existe; esto está permitido porque
-- el atributo "identity" no implica unicidad.

INSERT INTO libros(codigo, titulo, autor, precio)
    VALUES(100, 'Misery', 'Stephen King', 45);

SELECT * FROM libros;

-- Para desactivar la opción "identity_insert" 
SET IDENTITY_INSERT libros OFF;

IF OBJECT_ID('medicamentos') IS NOT NULL
    DROP TABLE medicamentos;

CREATE TABLE medicamentos(
    codigo INT IDENTITY(10,1),
    nombre VARCHAR(20) NOT NULL,
    laboratorio VARCHAR(20),
    precio FLOAT,
    cantidad INT
);

insert into medicamentos (nombre, laboratorio,precio,cantidad)
  values('Sertal','Roche',5.2,100);
insert into medicamentos (nombre, laboratorio,precio,cantidad)
 values('Buscapina','Roche',4.10,200);
insert into medicamentos (nombre, laboratorio,precio,cantidad)
 values('Amoxidal 500','Bayer',15.60,100);

SELECT * FROM medicamentos

--Se intenta ingresar un registro con el valor código, genera error
INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(13, 'Dolex', 'Bayer 500', 15.60, 100);

-- Solo se puede tener un identity insert ON en una tabla no en varias, por eso se le quita a libros y se le pone a medicamentos
SET IDENTITY_INSERT libros OFF;
SET IDENTITY_INSERT medicamentos ON;

--Se intenta ingresar un nuevo registro sin el valor de código, saca error porque
--ya tenemos el identity insert en ON.
INSERT INTO medicamentos(nombre, laboratorio, precio, cantidad)
    VALUES('Dolex', 'Bayern 500', 15, 100);

INSERT INTO medicamentos(codigo, nombre, laboratorio, precio, cantidad)
    VALUES(12, 'Dolex', 'Bayern', 500, 50);

SELECT * FROM medicamentos;

SELECT IDENT_SEED('medicamentos');

SELECT IDENT_INCR('medicamentos');

--Ejercicio 2

IF OBJECT_ID('peliculas') IS NOT NULL
    DROP TABLE peliculas;

CREATE TABLE peliculas(
    codigo INT IDENTITY(50,3),
    titulo VARCHAR(40),
    actor varchar(20),
    duracion INT
);

insert into peliculas (titulo,actor,duracion)
 values('Mision imposible','Tom Cruise',120);
insert into peliculas (titulo,actor,duracion)
 values('Harry Potter y la piedra filosofal','Daniel R.',180);
insert into peliculas (titulo,actor,duracion)
 values('Harry Potter y la camara secreta','Daniel R.',190);

SELECT * FROM peliculas;

SET IDENTITY_INSERT medicamentos OFF;
SET IDENTITY_INSERT peliculas ON;

INSERT INTO peliculas(codigo, titulo, actor, duracion)
    VALUES(30, 'La la land', 'Ryan Gosling', 120);

SELECT * FROM peliculas;

SELECT IDENT_SEED('peliculas');
SELECT IDENT_INCR('peliculas');

SET IDENTITY_INSERT peliculas ON;

INSERT INTO peliculas(codigo, titulo, actor, duracion)
    VALUES(31, 'Piratas del Carible', 'Jhonny Deep', 120);

SELECT * FROM peliculas;

INSERT INTO peliculas(titulo, actor, duracion)
    VALUES('Mi pobre angelito', 'Nose', 120);

SET IDENTITY_INSERT peliculas OFF;

SELECT * FROM peliculas;

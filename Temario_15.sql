IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(30),
    autor VARCHAR(20),
    editorial VARCHAR(15),
    precio FLOAT
);

GO

insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',25.60);
insert into libros (titulo,autor,editorial,precio)
  values ('Uno','Richard Bach','Planeta',18);

SELECT * FROM libros;

--Truncamos la tabla
TRUNCATE TABLE libros;

-- Ingresamos nuevamente algunos registros:
insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',25.60);
insert into libros (titulo,autor,editorial,precio)
  values ('Uno','Richard Bach','Planeta',18);

--Si seleccionamos nuevamente los registros vemos que la secuencia del identity se reinicio a 1
SELECT * FROM libros;

--Eliminamos todos los registros con delete.
DELETE FROM libros;

-- Ingresamos nuevamente algunos registros:
insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',25.60);
insert into libros (titulo,autor,editorial,precio)
  values ('Uno','Richard Bach','Planeta',18);

--Nuevamente seleccionamos los registros y esta vez vemos que la secuencia del identity
--en donde iba
SELECT * FROM libros


--Ejercicio 1

IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE alumnos(
    lebajo INT IDENTITY,
    documento VARCHAR(8),
    nombre VARCHAR(30),
    domicilio VARCHAR(30)
);

GO

 insert into alumnos (documento,nombre,domicilio)
  values('22345345','Perez Mariana','Colon 234');
 insert into alumnos (documento,nombre,domicilio)
  values('23545345','Morales Marcos','Avellaneda 348');
 insert into alumnos (documento,nombre,domicilio)
  values('24356345','Gonzalez Analia','Caseros 444');
 insert into alumnos (documento,nombre,domicilio)
  values('25666777','Torres Ramiro','Dinamarca 209');

SELECT * FROM alumnos;

--Eliminamos los registros con DELETE

DELETE FROM alumnos;


--Ingresamos nuevamente alumnos
 insert into alumnos (documento,nombre,domicilio)
  values('22345345','Perez Mariana','Colon 234');
 insert into alumnos (documento,nombre,domicilio)
  values('23545345','Morales Marcos','Avellaneda 348');
 insert into alumnos (documento,nombre,domicilio)
  values('24356345','Gonzalez Analia','Caseros 444');
 insert into alumnos (documento,nombre,domicilio)
  values('25666777','Torres Ramiro','Dinamarca 209');
 select * from alumnos;

 --Eliminamos todos los registros con TRUNCATE 
 TRUNCATE TABLE alumnos;

--Ingresamos nuevamente los alumnos
  insert into alumnos (documento,nombre,domicilio)
  values('22345345','Perez Mariana','Colon 234');
 insert into alumnos (documento,nombre,domicilio)
  values('23545345','Morales Marcos','Avellaneda 348');
 insert into alumnos (documento,nombre,domicilio)
  values('24356345','Gonzalez Analia','Caseros 444');
 insert into alumnos (documento,nombre,domicilio)
  values('25666777','Torres Ramiro','Dinamarca 209');

 

 --Si miramos todos los registros observamos que se reinicia el identity
SELECT * FROM alumnos;


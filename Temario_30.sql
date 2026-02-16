--Otros operadores relacionales (is null)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20) DEFAULT 'Desconocido',
    editorial VARCHAR(20),
    precio DECIMAL(6,2)
);

GO

insert into libros
  values('El aleph','Borges','Emece',15.90);
insert into libros
  values('Cervantes y el quijote','Borges','Paidos',null);
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
insert into libros
  values('Martin Fierro','Jose Hernandez','Emece',25.90);
insert into libros (titulo,autor,precio)
  values('Antología poética','Borges',25.50);
insert into libros (titulo,autor,precio)
  values('Java en 10 minutos','Mario Molina',45.80);
insert into libros (titulo,autor)
  values('Martin Fierro','Jose Hernandez');
insert into libros (titulo,autor)
  values('Aprenda PHP','Mario Molina');

SELECT * FROM libros WHERE editorial IS NULL;
SELECT * FROM libros WHERE editorial IS NOT NULL;

--Ejercicio 1
IF OBJECT_ID('peliculas') IS NOT NULL
    DROP TABLE peliculas;

CREATE TABLE peliculas(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    actor VARCHAR(20),
    duracion TINYINT,
    PRIMARY KEY(codigo)
);

INSERT INTO peliculas VALUES('Mision Imposible', 'Tom Cruise', 120)
INSERT INTO peliculas VALUES('Harry Potter y la piedra filosofal', 'Daniel R.', NULL)
INSERT INTO peliculas VALUES('Harry Potter y la camara secreta', 'Daniel R.', 190);
INSERT INTO peliculas VALUES('Mision imposible 2','Tom Cruise',120);
INSERT INTO peliculas VALUES('Mujer bonita',null,120);
INSERT INTO peliculas VALUES('Tootsie','D. Hoffman',90);
INSERT INTO peliculas(titulo) VALUES('Un oso rojo');

SELECT * FROM peliculas;

--Recupere las películas cuyo actor sea nulo (2 registros)
SELECT * FROM peliculas WHERE actor IS NULL;

--Cambie la duración a 0, de las películas que tengan duración igual a "null" (2 registros)
UPDATE peliculas SET duracion = 0 WHERE duracion IS NULL;

--Borre todas las películas donde el actor sea "null" y cuya duración sea 0 (1 registro)
DELETE FROM peliculas WHERE actor IS NULL AND duracion = 0;

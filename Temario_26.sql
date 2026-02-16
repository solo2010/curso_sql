IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20) DEFAULT 'Desconocido',
    editorial VARCHAR(20),
    precio DECIMAL(6,2),
    PRIMARY KEY(codigo)
);

GO

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25.33);
insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.65);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.95);

SELECT * FROM libros;

SELECT titulo, autor, editorial, FLOOR(precio) AS 'Hacia abajo', CEILING(precio) AS 'Hacia arriba' FROM libros;
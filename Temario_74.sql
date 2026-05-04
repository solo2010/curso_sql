--Combinaciones con update y delete

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30) DEFAULT 'Desconocido',
    codigoeditorial TINYINT NOT NULL,
    precio DECIMAL(5,2)
);

CREATE TABLE editoriales(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(20),
    PRIMARY KEY (codigo)
);

GO

INSERT INTO editoriales VALUES('Planeta');
INSERT INTO editoriales VALUES('Emece');
INSERT INTO editoriales VALUES('Siglo XXI');

INSERT INTO libros VALUES('El aleph', 'Borges', 2, 20);
INSERT INTO libros VALUES('Martin Fierro', 'Jose Hernandez', 1, 30);
INSERT INTO libros VALUES('Aprenda PHP', 'Mario Molina', 3, 50);
INSERT INTO libros VALUES('Java en 10 minutos', DEFAULT, 3, 45);

--Aumentamos en un 10% los precios de los libros de editorial "Planeta":
UPDATE libros SET precio = precio + (precio * 0.1)
    FROM libros
    JOIN editoriales AS e
    ON codigoeditorial = e.codigo
    WHERE nombre = 'Planeta';

SELECT titulo, autor, e.nombre, precio
    FROM libros AS l
    JOIN editoriales AS e
    ON codigoeditorial = e.codigo

-- Eliminamos todos los libros de editorial "Emece":
DELETE libros FROM libros
    JOIN editoriales AS e
    ON codigoeditorial = e.codigo
    WHERE nombre = 'Emece';

SELECT titulo, autor, e.nombre, precio FROM libros AS l
    JOIN editoriales AS e
    ON codigoeditorial = e.codigo;



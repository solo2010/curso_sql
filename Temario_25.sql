--Funciones para el manejo de cadenas

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20) DEFAULT 'Desconocido',
    editorial VARCHAR(20),
    precio DECIMAL(6,2),
    cantidad TINYINT DEFAULT 0,
    PRIMARY KEY(codigo)
);

GO

INSERT INTO libros(titulo, autor, editorial, precio)
    VALUES('La melancolia de los feos', 'Mario Mendoza', 'Emece', 2000);
INSERT INTO libros VALUES('Desesperación', 'Stephen King', 'Planeta', 5000, 20);
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Como perderlo todo', DEFAULT,'Emece', 2500,25);

SELECT * FROM libros;

-- Mostramos sólo los 12 primeros caracteres de los títulos de los libros y
-- sus autores, empleando la función "substring()":
SELECT SUBSTRING(titulo, 1, 12) AS titulo FROM libros;

-- Mostramos sólo los 12 primeros caracteres de los títulos de los libros y
-- sus autores, ahora empleando la función "left()":
SELECT LEFT(titulo,12) AS titulo FROM libros;

-- Mostramos los títulos de los libros y sus precios convirtiendo este último a cadena
-- de caracteres con un solo decimal, empleando la función "str":
SELECT titulo, STR(precio,6,1) FROM libros;

-- Mostramos los títulos de los libros y sus precios convirtiendo este último a cadena
-- de caracteres especificando un solo argumento:
SELECT titulo, STR(precio) FROM libros;

-- Mostramos los títulos, autores y editoriales de todos libros, al último
-- campo lo queremos en mayúsculas:
SELECT titulo, autor, UPPER(editorial) FROM libros;
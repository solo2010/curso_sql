IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(80),
    autor VARCHAR(40),
    editorial VARCHAR(30),
    precio FLOAT,
    cantidad INTEGER
);

EXEC sp_columns libros;

INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Misery', 'Stephen King', 'Planeta', 4000.0, 3);
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Satanás', 'Marioa Mendoza', 'Planeta', 5300.4, 1);
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('La verdad sobre caso de Harry Quebert', 'Planeta', 'Joel Dicker', 3000.50, 2);

SELECT * FROM libros;

INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Mi dulce Audrina', 'Virgina CV', 'Nose', 120000, 5);

SELECT * FROM libros;
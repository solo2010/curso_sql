--Restricción primary key

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT NOT NULL,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    PRIMARY KEY (codigo)
);

GO

-- Veamos la restricción "primary key" que creó automáticamente SQL Server:
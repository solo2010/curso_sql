--Restricción default
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30) DEFAULT 'Default',
    editorial VARCHAR(15),
    precio DECIMAL(6,2)
);

GO

INSERT INTO libros(titulo, editorial) VALUES('Martin Fierro', 'Emece');
INSERT INTO libros(titulo, editorial) VALUES('Aprenda PHP', 'Emece');

-- Veamos que SQL Server creó automáticamente una restricción "default"
-- para el campo "autor":
EXEC sp_helpconstraint libros;

DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio DECIMAL(6,2)
);

GO

-- Agregamos una restricción "default" empleando "alter table" 
-- para que almacene el valor "Desconocido" en el campo "autor":
ALTER TABLE libros
    ADD CONSTRAINT DF_libros_autor
    DEFAULT 'Desconocido'
    FOR autor;

-- Veamos la restrición agregada anteriormente con el procedimiento 
-- almacenado "sp_helpcontraint":
EXEC sp_helpconstraint libros;

INSERT INTO libros(titulo, editorial) VALUES('Martin Fierro', 'Emece');
INSERT INTO libros DEFAULT values;

SELECT * FROM libros;

-- Agregamos otra restricción "default" para el campo "precio" 
-- para que almacene el valor 0 en dicho campo:
ALTER TABLE libros
    ADD CONSTRAINT DF_libros_precio
    DEFAULT 0
    FOR precio;

EXEC sp_helpconstraint libros;


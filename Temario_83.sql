--Agregar y eliminar campos ( alter table - add - drop)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(30),
    editorial VARCHAR(15),
    edicion DATETIME,
    precio DECIMAL(6,2)
);

GO

INSERT INTO libros(titulo, editorial, precio) VALUES('El aleph', 'Emece', 25.50);

-- Agregamos un campo "codigo" a la tabla "libros", de tipo int con el 
-- atributo "identity":
ALTER TABLE libros
    ADD codigo INT IDENTITY;

-- Intentamos agregar un campo llamado "autor" de tipo varchar(30) 
-- que NO acepte valores nulos (genera error):
ALTER TABLE libros
    ADD autor VARCHAR(30) NOT NULL;

-- Agregar un campo llamado "autor" de tipo varchar(20) pero con 
-- un valor por defecto: 
ALTER TABLE libros
    ADD autor VARCHAR(30) DEFAULT('Desconocido');

-- Eliminamos el campo "precio" de la tabla "libros":
ALTER TABLE libros
    DROP COLUMN precio;

EXEC sp_columns libros;

-- Intentamos eliminar un campo con restricciones (genera error) :  
ALTER TABLE libros
    DROP COLUMN autor;

-- Eliminamos varios campos en una sola sentencia:
ALTER TABLE libros
    DROP COLUMN editorial, edicion;

--Ejercicio
--Elimine la tabla, si existe, créela y cargue un registro:
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    apellido VARCHAR(20),
    nombre VARCHAR(20),
    domicilio VARCHAR(30),
    fechaingreso DATETIME
);

INSERT INTO empleados(apellido,nombre) VALUES('Rodriguez','Pablo');

--Agregue el campo "sueldo", de tipo decimal(5,2).
ALTER TABLE empleados
    ADD sueldo DECIMAL(5,2);

--Verifique que la estructura de la tabla ha cambiado.
EXEC sp_columns empleados;

--Agregue un campo "codigo", de tipo int con el atributo "identity".
ALTER TABLE empleados
    ADD codigo INT IDENTITY;

--Intente agregar un campo "documento" no nulo.
--No es posible, porque SQL Server no permite agregar campos "not null" a menos que se especifique un 
--valor por defecto.
ALTER TABLE empleados
    ADD documento CHAR(8) NOT NULL;

-- Agregue el campo del punto anterior especificando un valor por defecto:
 --alter table empleados
 ALTER TABLE empleados
    ADD documento CHAR(8) NOT NULL DEFAULT('00000000');

--Verifique que la estructura de la tabla ha cambiado.
EXEC sp_columns empleados;

--Elimine el campo "sueldo".
ALTER TABLE empleados
    DROP COLUMN sueldo;

ALTER TABLE empleados
    DROP COLUMN documento;

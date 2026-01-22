IF OBJECT_ID('usuarios') IS NOT NULL
    DROP TABLE usuarios;

CREATE TABLE usuarios(
    nombre VARCHAR(20),
    clave VARCHAR(10),
    PRIMARY KEY(nombre)
);

GO

EXEC sp_columns usuarios

INSERT INTO usuarios(nombre, clave) VALUES('Juan Perez', 'Boca');
INSERT INTO usuarios(nombre, clave) VALUES('Raul Garcia', 'River');

SELECT * FROM usuarios;

-- Intentamos ingresar un valor de clave primaria existente (genera error):
INSERT INTO usuarios(nombre, clave) VALUES('Juan Perez', 'River');

--Intentamos ingresar un valor null en el campo clave primaria (genera error):
INSERT INTO usuarios(nombre, clave) VALUES(null, 'payaso');

--INtentamos actualizar el nombre usuario de uno de los campos con un usuario ya existente (genera error):
UPDATE usuarios SET nombre='Juan Perez' WHERE clave = 'River';

--EJERCICIOS--

--Ejercicio 1--

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INTEGER NOT NULL,
    titulo VARCHAR(40) NOT NULL,
    
);
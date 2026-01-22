IF OBJECT_ID('usuarios') IS NOT NULL
    DROP TABLE usuarios;

CREATE TABLE usuarios(
    nombre VARCHAR(30),
    clave VARCHAR(10)
);

GO

EXEC sp_columns usuarios;

INSERT INTO usuarios(nombre,clave) VALUES('Daniel', 'Solo');
INSERT INTO usuarios(nombre, clave) VALUES('Geny', 'Yiyi');
INSERT INTO usuarios(nombre, clave) VALUES('Flor', 'Chila');
INSERT INTO usuarios(nombre, clave) VALUES('Edelmira', 'Mirita');


SELECT * FROM usuarios WHERE nombre = 'Daniel';
SELECT * FROM usuarios WHERE clave = 'Yiyi';
SELECT * FROM usuarios WHERE clave = 'Mirita';


--EJERCICIOS--

--Ejercicio 1--

IF OBJECT_ID('agenda') IS NOT NULL
    DROP TABLE agenda;

CREATE TABLE agenda(
    apellido VARCHAR(30),
    nombre VARCHAR(20),
    domicilio VARCHAR(30),
    telefono VARCHAR(11)
);

GO

EXEC sp_columns agenda;

INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Acosta', 'Ana', 'Colon 123', '4234567');
INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Bustamante', 'Betina', 'Avellanda 135', '4458787');
INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Lopez', 'Hector', 'Salta 545', '4887788');
INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Lopez', 'Luis', 'Urquiza 333', '4545454');
INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Lopez', 'Marisa', 'Urquiza 333', '4545454');

SELECT * FROM agenda;

SELECT * FROM agenda WHERE nombre = 'Marisa';

SELECT nombre, domicilio FROM agenda WHERE apellido = 'Lopez';

SELECT nombre FROM agenda WHERE telefono = '4545454';

--Ejercicio 2--
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(20),
    autor VARCHAR(30),
    editorial VARCHAR(15)
);

GO

EXEC sp_columns libros;

INSERT INTO libros(titulo, autor, editorial) VALUES('El aleph', 'Borges', 'Emece');
INSERT INTO libros(titulo, autor, editorial) VALUES('Martin Fierro', 'Jose Hernandez', 'Emece');
INSERT INTO libros(titulo, autor, editorial) VALUES('Martin Fierro', 'Jose Hernandez', 'Planeta');
INSERT INTO libros(titulo, autor, editorial) VALUES('Aprenda PHP', 'Mario Molina', 'Siglo XXI');

SELECT * FROM libros;

SELECT * FROM libros WHERE autor= 'Borges';

SELECT titulo FROM libros WHERE editorial = 'Emece';

SELECT editorial FROM libros WHERE titulo = 'Martin Fierro';




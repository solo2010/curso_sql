IF OBJECT_ID('usuarios') IS NOT NULL
    DROP TABLE usuarios;

CREATE TABLE usuarios(
    nombre VARCHAR(30),
    clave VARCHAR(10)
);

GO

INSERT INTO usuarios(nombre, clave) VALUES('Marcelo', 'River');
INSERT INTO usuarios(nombre, clave) VALUES('Susana', 'Chapita');
INSERT INTO usuarios(nombre, clave) VALUES('Carlos Fuente', 'Boca');
INSERT INTO usuarios(nombre, clave) VALUES('Fediro Lopez', 'Boca');

SELECT * FROM usuarios;

--Eliminamos el registro cuyo nombre de usuario es Marcelo
DELETE FROM usuarios WHERE nombre = 'Marcelo';

SELECT * FROM usuarios;

--Eliminamos todos los registros cuya clave el Boca
DELETE FROM usuarios WHERE clave = 'Boca';

SELECT * FROM usuarios;

DELETE FROM usuarios;

SELECT * FROM usuarios; 

--EJERCICIOS--

--Ejercicio 1--

IF OBJECT_ID('agenda') IS NOT NULL
    DROP TABLE agenda;

CREATE TABLE agenda(
    apellido VARCHAR(30),
    nombre VARCHAR(20),
    domicilio VARCHAR(30),
    telefono VARCHAR(11)
)

GO

INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Alvarez', 'Alberto', 'Colon 123', '4234567');
INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Juarez', 'Juan', 'Avellanada 135', '4458787');
INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Lopez', 'Maria', 'Urquiza 333', '4545454');
INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Lopez', 'Jose', 'Urquiza 333', '4545454');
INSERT INTO agenda(apellido, nombre, domicilio, telefono)
    VALUES('Salas', 'Susana', 'Gral. Paz 1234', '4123456');

SELECT * FROM agenda;

DELETE FROM agenda WHERE nombre = 'Juan';

SELECT * FROM agenda;

DELETE FROM agenda WHERE telefono = '4545454';

SELECT * FROM agenda;

DELETE FROM agenda;

SELECT * FROM agenda;

--Ejercicio 2--

IF OBJECT_ID('articulos') IS NOT NULL
    DROP TABLE articulos;

CREATE TABLE articulos(
    codigo INTEGER,
    nombre VARCHAR(20),
    descripcion VARCHAR(30),
    precio FLOAT,
    cantidad INTEGER
);

GO

INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(1, 'impresora', 'Epson Stylus C45', 400.80, 20);
INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(2, 'impresora', 'Epson Stylus C85', 500, 30);
INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(3, 'monitor', 'Samsung 14', 800, 10);
INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(4, 'teclado', 'Ingles Biswal', 100, 50);
INSERT INTO articulos(codigo, nombre, descripcion, precio, cantidad)
    VALUES(5, 'teclado', 'Español Biswal', 90, 50);

SELECT * FROM articulos;

DELETE from articulos WHERE precio >= 500;

SELECT * FROM articulos;

DELETE from articulos where nombre = 'impresora';

SELECT * FROM articulos;

DELETE FROM articulos WHERE codigo <> 4;

SELECT * FROM articulos;
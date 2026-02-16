-- Alias

IF OBJECT_ID('agenda') IS NOT NULL
    DROP TABLE agenda;

CREATE TABLE agenda(
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    telefono VARCHAR(11)
);

GO

INSERT INTO agenda VALUES('Juan Perez', 'Avellanada 908', '6542132');
INSERT INTO agenda VALUES('Daniel Lopez', 'Barrio el Socorro', '5590044');
INSERT INTO agenda VALUES('Geny Vargas', 'Barrio Felipe Echavarria', '6545456');

SELECT * FROM agenda;

SELECT nombre AS NombreYApellido, domicilio, telefono FROM agenda;

SELECT nombre AS 'Nombre y Apellido', domicilio, telefono FROM agenda;

--Ejercicio 1

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20) DEFAULT 'Desconocido',
    editorial VARCHAR(20),
    precio DECIMAL(6,2),
    cantidad TINYINT DEFAULT 0,
    PRIMARY KEY (codigo)
);

insert into libros (titulo,autor,editorial,precio)
 values('El aleph','Borges','Emece',25);
insert into libros
 values('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
 values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

SELECT * FROM libros;

--Muestre todos los campos de los libros y un campo extra, con el encabezado "monto total" en la 
--que calcule el monto total en dinero de cada libro (precio por cantidad)
SELECT *, precio*cantidad AS 'monto total' FROM libros;

/* Muestre el título, autor y precio de todos los libros de editorial "Emece" y agregue dos columnas 
extra en las cuales muestre el descuento de cada libro, con el encabezado "descuento" y el precio 
con un 10% de descuento con el encabezado "precio final". */
SELECT titulo, autor, precio, precio*0.10 AS descuento, precio - (precio*0.10) AS 'descuento total' FROM libros;

--Muestre una columna con el título y el autor concatenados con el encabezado "Título y autor"
SELECT titulo + '-' + autor AS 'Titulo y Autor' FROM libros;
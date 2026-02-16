--Columnas calculadas (operadores aritméticos y de concatenación)
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
    VALUES('El aleph', 'Borges', 'Emece', 25);
INSERT INTO libros VALUES('Java en 10 minutos', 'Mario Molina', 'Siglo XXI', 50.40,100);
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Alicia en el pais de las maravillas', 'Lewis Carroll', 'Emece', 15,50);

SELECT * FROM libros;

-- Queremos saber el monto total en dinero de cada libro:
SELECT titulo, precio, cantidad, precio*cantidad FROM libros;

-- Conocer el precio de cada libro con un 10% de descuento:
SELECT titulo, precio, precio - (precio*0.1) FROM libros;

-- Actualizar los precios con un 10% de descuento:
UPDATE libros SET precio = precio - (precio*0.1);

SELECT * FROM libros;

-- Queremos una columna con el título, el autor y la editorial de cada libro:
SELECT titulo + '-' + autor + '-' + editorial FROM libros;

--Ejercicio 1
IF OBJECT_ID('articulos') IS NOT NULL
    DROP TABLE articulos;

CREATE TABLE articulos(
    codigo INT IDENTITY,
    nombre VARCHAR(20),
    descripcion VARCHAR(30),
    precio SMALLMONEY,
    cantidad TINYINT DEFAULT 0,
    PRIMARY KEY(codigo)
);

GO

 insert into articulos (nombre, descripcion, precio,cantidad)
  values ('impresora','Epson Stylus C45',400.80,20);
 insert into articulos (nombre, descripcion, precio)
  values ('impresora','Epson Stylus C85',500);
 insert into articulos (nombre, descripcion, precio)
  values ('monitor','Samsung 14',800);
 insert into articulos (nombre, descripcion, precio,cantidad)
  values ('teclado','ingles Biswal',100,50);

  SELECT * FROM articulos;

--El comercio quiere aumentar los precios de todos sus artículos en un 15%. Actualice todos los 
--precios empleando operadores aritméticos.
UPDATE articulos SET precio = precio + (precio*0.15);
SELECT * FROM articulos;

--Muestre todos los artículos, concatenando el nombre y la descripción de cada uno de ellos 
SELECT nombre + ',' + descripcion FROM articulos;

--Reste a la cantidad de todos los teclados, el valor 5, empleando el operador aritmético menos ("-")
UPDATE articulos SET cantidad = cantidad - 5 WHERE nombre = 'teclado';
SELECT * FROM articulos;

--Ejercicio 2



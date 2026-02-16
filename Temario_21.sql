--Valores por defecto (default)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30) NOT NULL DEFAULT 'Desconocido',
    editorial VARCHAR(20),
    precio DECIMAL(5,2),
    cantidad TINYINT default 0
);

GO

-- Ingresamos un registro omitiendo los valores para el campo "autor" y "cantidad":
INSERT INTO libros(titulo, editorial, precio) VALUES('IT', 'Debolsillo', 50.5);

SELECT * FROM libros;

-- Si ingresamos un registro sin valor para el campo "precio", 
-- que admite valores nulos, se ingresará "null" en ese campo:
INSERT INTO libros(titulo, editorial) VALUES('Flores en el ático', 'Emece');
SELECT * FROM libros;

-- Visualicemos la estructura de la tabla:
EXEC sp_columns libros;

-- Podemos emplear "default" para dar el valor por defecto a algunos campos:
INSERT INTO libros(titulo, autor, editorial, precio, cantidad)
    VALUES('Mi dulce Audrina', DEFAULT, 'Planeta', 56.50, DEFAULT);

SELECT * FROM libros;

-- Como todos los campos de "libros" tienen valores predeterminados, podemos tipear:
INSERT INTO libros DEFAULT VALUES;

SELECT * FROM libros;

-- Podemos ingresar el valor "null" en el campo "cantidad":
INSERT INTO libros VALUES('Apocalipsis', 'Mario Mendoza', 'Emece', 56, NULL);

SELECT * FROM libros;

--Ejercicio 1

IF OBJECT_ID('visitantes') IS NOT NULL
    DROP TABLE visitantes;

CREATE TABLE visitantes(
    nombre VARCHAR(30),
    edad TINYINT,
    sexo CHAR(1) DEFAULT 'F',
    domicilio VARCHAR(30),
    ciudad VARCHAR(20) DEFAULT 'Cordoba',
    telefono VARCHAR(11),
    mail VARCHAR(30) DEFAULT 'No tiene',
    montocompra DECIMAL(6,2)
);

--Vea la información de las columnas "COLUMN_DEF" y "IS_NULLABLE":
EXEC sp_columns visitantes;

--Ingrese algunos registros sin especificar valores para algunos campos para ver cómo opera la 
--cláusula "default":
INSERT INTO visitantes(nombre, edad, domicilio, telefono, montocompra)
    VALUES('Daniel Lopez', '36', 'Barrio el Socorro', '5590047', 56.2);

SELECT * FROM visitantes;

--Use la palabra "default" para ingresar valores en un insert.
INSERT INTO visitantes VALUES('Geny Vargas', '32', DEFAULT, 'Felipe Echavarria', DEFAULT, '5223456', DEFAULT, 20.5);

SELECT * FROM visitantes;

--Ingrese un registro con "default values".
INSERT INTO libros DEFAULT VALUES;

SELECT * FROM libros;

--Ejercicio 2
IF OBJECT_ID('prestamos') IS NOT NULL
    DROP TABLE prestamos;

CREATE TABLE prestamos(
    titulo VARCHAR(40) NOT NULL,
    documento CHAR(8),
    fechaprestamo DATETIME NOT NULL,
    fechadevolucion DATETIME,
    devuelto CHAR(1) DEFAULT 'n'
);

--Ingrese algunos registros omitiendo el valor para los campos que lo admiten:
INSERT INTO prestamos(titulo, documento, fechaprestamo, fechadevolucion)
    VALUES('Alebra 1', '32525539', '2026-02-05', '2026-02-10');
INSERT INTO prestamos(titulo, documento, fechaprestamo)
    VALUES('Tecnología y Sociedad', '10255689', '2026-01-30');
INSERT INTO prestamos(titulo, fechaprestamo)
    VALUES('La culpa es de la vaca', '2026-02-15');

SELECT * FROM prestamos;

--Ingrese un registro colocando "default" en los campos que lo admiten y vea cómo se almacenó.
INSERT INTO prestamos VALUES('Filosofia I', DEFAULT, '2026-01-15', DEFAULT, DEFAULT);

SELECT * FROM prestamos;

--Intente ingresar un registro con "default values" y analice el mensaje de error (no se puede)
INSERT INTO prestamos DEFAULT VALUES;
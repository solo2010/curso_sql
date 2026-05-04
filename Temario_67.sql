--Combinación externa izquierda (left join)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30) DEFAULT 'Desconocido',
    codigoeditorial TINYINT NOT NULL,
    precio decimal(5,2)
);

CREATE TABLE editoriales(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(20),
    PRIMARY KEY(codigo)
);

GO

INSERT INTO editoriales VALUES('Planeta');
INSERT INTO editoriales VALUES('Emece');
INSERT INTO editoriales VALUES('Siglo XXI');

INSERT INTO libros VALUES('El aleph','Borges',1,20);
INSERT INTO libros VALUES('Martin Fierro','Jose Hernandez',1,30);
INSERT INTO libros VALUES('Aprenda PHP','Mario Molina',2,50);
INSERT INTO libros VALUES('Java en 10 minutos',default,4,45);

-- Combinación izquierda para obtener los datos de los libros, 
-- incluyendo el nombre de la editorial.
-- Las editoriales de las cuales no hay libros, es decir, cuyo código
-- de editorial no está presente en "libros" aparece en el resultado, 
-- pero con el valor "null" en el campo "titulo":
SELECT titulo, nombre FROM editoriales AS e
    LEFT JOIN libros AS l
    ON codigoeditorial = e.codigo;

-- Realizamos la misma consulta anterior pero cambiamos el orden de las tablas:
SELECT titulo, nombre
    FROM libros AS l
    LEFT JOIN editoriales AS e
    ON codigoeditorial = e.codigo;

-- Consulta considerando solamente los registros que encuentran coincidencia en la
-- tabla de la derecha, es decir, cuyo valor de código está presente en "libros":
SELECT titulo, nombre FROM editoriales AS e
    LEFT JOIN libros AS l
    ON e.codigo = codigoeditorial
    WHERE codigoeditorial IS NOT NULL;

-- Mostramos las editoriales que no están presentes en "libros", es decir,
-- que no encuentran coincidencia en la tabla de la derecha:
SELECT titulo, nombre
    FROM editoriales AS e
    LEFT JOIN libros AS l
    ON e.codigo = codigoeditorial
    WHERE codigoeditorial IS NULL;

--Ejercicio 1
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
    DROP TABLE provincias;

CREATE TABLE clientes(
    codigo INT IDENTITY,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    ciudad VARCHAR(20),
    codigoprovincia TINYINT NOT NULL,
    PRIMARY KEY(codigo)
);

CREATE TABLE provincias(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(20),
    PRIMARY KEY(codigo)
);

INSERT INTO provincias VALUES('Cordoba');
INSERT INTO provincias VALUES('Santa Fe');
INSERT INTO provincias VALUES('Corrientes');

INSERT INTO clientes VALUES ('Lopez Marcos','Colon 111','Córdoba',1);
INSERT INTO clientes VALUES ('Perez Ana','San Martin 222','Cruz del Eje',1);
INSERT INTO clientes VALUES ('Garcia Juan','Rivadavia 333','Villa Maria',1);
INSERT INTO clientes VALUES ('Perez Luis','Sarmiento 444','Rosario',2);
INSERT INTO clientes VALUES ('Gomez Ines','San Martin 666','Santa Fe',2);
INSERT INTO clientes VALUES ('Torres Fabiola','Alem 777','La Plata',4);
INSERT INTO clientes VALUES ('Garcia Luis','Sucre 475','Santa Rosa',5);

--Muestre todos los datos de los clientes, incluido el nombre de la provincia:
SELECT c.nombre, c.domicilio, c.ciudad, p.nombre FROM clientes AS c
    LEFT JOIN provincias AS p
    ON c.codigoprovincia = p.codigo;

--Realice la misma consulta anterior pero alterando el orden de las tablas:
SELECT p.nombre, c.nombre, c.domicilio, c.ciudad FROM provincias AS p
    LEFT JOIN clientes AS c
    ON c.codigoprovincia = p.codigo;

--Muestre solamente los clientes de las provincias que existen en "provincias" (5 registros):
SELECT c.nombre, domicilio, ciudad, p.nombre FROM clientes AS c
    LEFT JOIN provincias AS p
    ON c.codigoprovincia = p.codigo
    WHERE p.codigo IS NOT NULL;

--Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
--nombre del cliente (2 registros):
SELECT c.nombre, domicilio, ciudad, p.nombre FROM clientes AS c
    LEFT JOIN provincias AS p
    ON c.codigoprovincia = p.codigo
    WHERE p.codigo IS NULL
    ORDER BY c.nombre;

--Obtenga todos los datos de los clientes de "Cordoba" (3 registros):
SELECT c.codigo, c.nombre, c.domicilio, c.ciudad, p.nombre AS provincia FROM clientes AS c
    LEFT JOIN provincias AS p
    ON c.codigoprovincia = p.codigo
    WHERE p.nombre = 'Cordoba';


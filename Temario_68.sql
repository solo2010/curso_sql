--Combinación externa derecha (right join)
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30) DEFAULT 'Desconocido',
    codigoeditorial TINYINT NOT NULL,
    precio DECIMAL(5,2)
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

-- Solicitamos el título y nombre de la editorial de los libros
-- empleando un "right join":
SELECT l.titulo, e.nombre FROM libros AS l
    RIGHT JOIN editoriales AS e
    ON l.codigoeditorial = e.codigo;

-- Realizamos la misma consulta anterior agregando un "where" que restringa
-- el resultado considerando solamente los registros que encuentran
-- coincidencia en la tabla izquierda
SELECT l.titulo, e.nombre FROM libros AS l
 RIGHT JOIN editoriales AS e
 ON l.codigoeditorial = e.codigo
 WHERE l.codigoeditorial IS NOT NULL;

-- Mostramos las editoriales que no están presentes en "libros" 
-- (que no encuentran coincidencia en "editoriales"):
SELECT l.titulo, e.nombre FROM libros AS l
    RIGHT JOIN editoriales AS e
    ON l.codigoeditorial = e.codigo
    WHERE l.codigoeditorial IS NULL;


--Ejercicio
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
    DROP TABLE provincias;

CREATE TABLE clientes(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    ciudad VARCHAR(20),
    codigoprovincia TINYINT NOT NULL,
    PRIMARY KEY(codigo)
);

CREATE TABLE provincias(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(30),
    PRIMARY KEY(codigo)
);

INSERT INTO provincias (nombre) VALUES('Corrientes');
INSERT INTO provincias (nombre) VALUES('Cordoba');
INSERT INTO provincias (nombre) VALUES('Santa Fe');

INSERT INTO clientes VALUES('Lopez Marcos','Colon 111','Córdoba',1);
INSERT INTO clientes VALUES('Perez Ana','San Martin 222','Cruz del Eje',1);
INSERT INTO clientes VALUES('Garcia Juan','Rivadavia 333','Villa Maria',1);
INSERT INTO clientes VALUES('Perez Luis','Sarmiento 444','Rosario',2);
INSERT INTO clientes VALUES('Gomez Ines','San Martin 666','Santa Fe',2);
INSERT INTO clientes VALUES('Torres Fabiola','Alem 777','La Plata',4);
INSERT INTO clientes VALUES('Garcia Luis','Sucre 475','Santa Rosa',5);

--Muestre todos los datos de los clientes, incluido el nombre de la provincia empleando un "right 
--join".
SELECT c.nombre, c.domicilio, c.ciudad, p.nombre FROM provincias AS p
    RIGHT JOIN clientes AS c
    ON c.codigoprovincia = p.codigo;

--Obtenga la misma salida que la consulta anterior pero empleando un "left join".
SELECT c.nombre, c.domicilio, c.ciudad, p.nombre FROM provincias AS p
    LEFT JOIN clientes AS c
    ON c.codigoprovincia = p.codigo;

--Empleando un "right join", muestre solamente los clientes de las provincias que existen en 
--"provincias" (5 registros)
SELECT c.nombre, c.domicilio, c.ciudad, p.nombre FROM provincias AS p
    RIGHT JOIN clientes AS c
    ON c.codigoprovincia = p.codigo
    WHERE p.codigo IS NOT NULL;

--Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
--ciudad (2 registros)
SELECT c.nombre, c.domicilio, c.ciudad, p.nombre FROM provincias AS p
    RIGHT JOIN clientes AS c
    ON c.codigoprovincia = p.codigo
    WHERE p.codigo IS NULL
    ORDER BY c.ciudad;


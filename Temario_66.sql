--Combinación interna (inner join)

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

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Siglo XXI');

insert into libros values('El aleph','Borges',2,20);
insert into libros values('Martin Fierro','Jose Hernandez',1,30);
insert into libros values('Aprenda PHP','Mario Molina',3,50);
insert into libros values('Java en 10 minutos',default,3,45);


-- Recuperamos los datos de libros:
SELECT * FROM libros;

-- Realizamos un join para obtener datos de ambas tablas 
-- (titulo, autor y nombre de la editorial):
SELECT titulo, autor, nombre FROM libros
    JOIN editoriales ON codigoeditorial=editoriales.codigo;

-- Mostramos el código del libro, título, autor, nombre de la
-- editorial y el precio realizando un join y empleando alias:
SELECT l.codigo, titulo, autor, nombre, precio
    FROM libros AS l
    JOIN editoriales AS e
    ON codigoeditorial = e.codigo;

-- Realizamos la misma consulta anterior agregando un "where" 
-- para obtener solamente los libros de la editorial "Siglo XXI":
SELECT l.codigo, titulo, autor, nombre, precio FROM libros as l
    JOIN editoriales AS e
    ON codigoeditorial=e.codigo
    WHERE e.nombre='Siglo XXI';

-- Obtenemos título, autor y nombre de la editorial, 
-- esta vez ordenados por título:
SELECT titulo, autor, nombre
    FROM libros AS l
    JOIN editoriales AS e
    ON codigoeditorial=e.codigo
    ORDER BY titulo;

--Ejercicio 1
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
    DROP TABLE provinicas;

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

INSERT INTO provincias(nombre) VALUES('Cordoba');
INSERT INTO provincias(nombre) VALUES('Santa Fe');
INSERT INTO provincias(nombre) VALUES('Corrientes');

INSERT INTO clientes VALUES('Lopez Marcos', 'Colon 111', 'Cordoba', 1);
INSERT INTO clientes VALUES('Perez Ana', 'San Marin 222', 'Cruz del Eje', 1);
INSERT INTO clientes VALUES('Garcia Juan', 'Rivadavia 333', 'Villa Maria', 1);
INSERT INTO clientes VALUES('Perez Luis', 'Sarmiento 444', 'Rosario', 2);
INSERT INTO clientes VALUES('Pereyra Lucas','San Martin 555','Cruz del Eje',1);
INSERT INTO clientes VALUES('Gomez Ines','San Martin 666','Santa Fe',2);
INSERT INTO clientes VALUES('Torres Fabiola','Alem 777','Ibera',3);

--Obtenga los datos de ambas tablas, usando alias:
SELECT c.codigo, c.nombre, domicilio, ciudad, p.nombre AS nombre_provincia FROM clientes AS c
    JOIN provincias AS p
    ON p.codigo = c.codigoprovincia;

--Obtenga la misma información anterior pero ordenada por nombre de provincia.
SELECT c.codigo, c.nombre, domicilio, ciudad, p.nombre AS nombre_provincia FROM clientes AS c
    JOIN provincias AS p
    ON p.codigo = c.codigoprovincia
    ORDER BY p.nombre;    

--Recupere los clientes de la provincia "Santa Fe" (2 registros devueltos)
SELECT c.codigo, c.nombre, domicilio, ciudad, p.nombre AS nombre_provincia FROM clientes AS c
    JOIN provincias AS p
    ON p.codigo = c.codigoprovincia
    WHERE p.nombre = 'Santa Fe';


--Segundo problema:
IF OBJECT_ID('inscriptos') IS NOT NULL
    DROP TABLE inscriptos;

IF OBJECT_ID('inasistencias') IS NOT NULL
    DROP TABLE inasistencias;

CREATE TABLE inscriptos(
  nombre VARCHAR(30),
  documento CHAR(8),
  deporte VARCHAR(15),
  matricula CHAR(1), --'s'=paga 'n'=impaga
  PRIMARY KEY(documento, deporte)
 );

CREATE TABLE inasistencias(
 documento CHAR(8),
 deporte VARCHAR(15),
 fecha DATETIME
);


 INSERT INTO inscriptos VALUES('Juan Perez','22222222','tenis','s');
 INSERT INTO inscriptos VALUES('Maria Lopez','23333333','tenis','s');
 INSERT INTO inscriptos VALUES('Agustin Juarez','24444444','tenis','n');
 INSERT INTO inscriptos VALUES('Marta Garcia','25555555','natacion','s');
 INSERT INTO inscriptos VALUES('Juan Perez','22222222','natacion','s');
 INSERT INTO inscriptos VALUES('Maria Lopez','23333333','natacion','n');

 INSERT INTO inasistencias VALUES('22222222','tenis','2006-12-01');
 INSERT INTO inasistencias VALUES('22222222','tenis','2006-12-08');
 INSERT INTO inasistencias VALUES('23333333','tenis','2006-12-01');
 INSERT INTO inasistencias VALUES('24444444','tenis','2006-12-08');
 INSERT INTO inasistencias VALUES('22222222','natacion','2006-12-02');
 INSERT INTO inasistencias VALUES('23333333','natacion','2006-12-02');

--Muestre el nombre, el deporte y las fechas de inasistencias, ordenado por nombre y deporte.
--Note que la condición es compuesta porque para identificar los registros de la tabla "inasistencias" 
--necesitamos ambos campos.
SELECT ins.nombre, ins.deporte, ina.fecha FROM inscriptos AS ins
    INNER JOIN inasistencias AS ina
    ON ins.documento = ina.documento AND ins.deporte=ina.deporte
    ORDER BY ins.nombre, ins.deporte;

--Obtenga el nombre, deporte y las fechas de inasistencias de un determinado inscripto en un 
--determinado deporte (2 registros)
SELECT ins.nombre, ina.deporte, ina.fecha FROM inscriptos AS ins
    INNER JOIN inasistencias AS ina
    ON ins.documento = ina.documento AND ins.deporte = ina.deporte
    WHERE ins.documento = '22222222' AND ins.deporte = 'tenis';

--Obtenga el nombre, deporte y las fechas de inasistencias de todos los inscriptos que pagaron la 
--matrícula(4 registros)
SELECT ins.nombre, ina.deporte, ina.fecha FROM inscriptos AS ins
    INNER JOIN inasistencias AS ina
    ON ins.documento = ina.documento AND ins.deporte = ina.deporte
    WHERE ins.matricula = 's';
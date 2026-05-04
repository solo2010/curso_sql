--Combinación de más de dos tablas
/*
Podemos hacer un "join" con más de dos tablas.

Cada join combina 2 tablas. Se pueden emplear varios join para enlazar varias tablas. Cada resultado de un join es una tabla que puede combinarse con otro join.

La librería almacena los datos de sus libros en tres tablas: libros, editoriales y autores.
En la tabla "libros" un campo "codigoautor" hace referencia al autor y un campo "codigoeditorial" referencia la editorial.

Para recuperar todos los datos de los libros empleamos la siguiente consulta:
*/

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;
IF OBJECT_ID('autores') IS NOT NULL
    DROP TABLE autores;
IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    codigoautor INT NOT NULL,
    codigoeditorial TINYINT NOT NULL,
    precio DECIMAL(5,2),
    PRIMARY KEY(codigo)
);

CREATE TABLE autores(
    codigo INT IDENTITY,
    nombre VARCHAR(20),
    PRIMARY KEY(codigo)
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
INSERT INTO editoriales VALUES('Plaza');
 
INSERT INTO autores VALUES('Richard Bach');
INSERT INTO autores VALUES('Borges');
INSERT INTO autores VALUES('Jose Hernandez');
INSERT INTO autores VALUES('Mario Molina');
INSERT INTO autores VALUES('Paenza');
 
INSERT INTO libros VALUES('El aleph',2,2,20);
INSERT INTO libros VALUES('Martin Fierro',3,1,30);
INSERT INTO libros VALUES('Aprenda PHP',4,3,50);
INSERT INTO libros VALUES('Uno',1,1,15);
INSERT INTO libros VALUES('Java en 10 minutos',0,3,45);
INSERT INTO libros VALUES('Matematica estas ahi',0,0,15);
INSERT INTO libros VALUES('Java de la A a la Z',4,0,50);

-- Recuperamos todos los datos de los libros consultando las tres tablas:
SELECT l.titulo, a.nombre, e.nombre, l.precio FROM libros AS l
    INNER JOIN autores AS a ON l.codigoautor = a.codigo
    INNER JOIN editoriales AS e ON l.codigoeditorial = e.codigo;

-- Podemos combinar varios tipos de join en una misma sentencia:
SELECT l.titulo, a.nombre, e.nombre, l.precio FROM autores AS a
    RIGHT JOIN libros AS l ON l.codigoautor = a.codigo
    LEFT JOIN editoriales AS e ON l.codigoeditorial = e.codigo;

--Ejercicio

IF OBJECT_ID('socios') IS NOT NULL
    DROP TABLE socios;

IF OBJECT_ID('deportes') IS NOT NULL
    DROP TABLE deportes;

IF OBJECT_ID('inscriptos') IS NOT NULL
    DROP TABLE inscriptos;

CREATE TABLE socios(
    documento CHAR(8) NOT NULL,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    PRIMARY KEY(documento)
);

CREATE TABLE deportes(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(20),
    profesor VARCHAR(15),
    PRIMARY KEY(codigo)
);

CREATE TABLE inscriptos(
    documento CHAR(8) NOT NULL,
    codigodeporte TINYINT NOT NULL,
    anio CHAR(4),
    matricula CHAR(1) --s paga n nopaga
    PRIMARY KEY(documento, codigodeporte, anio)
);

INSERT INTO socios VALUES('22222222','Ana Acosta','Avellaneda 111');
INSERT INTO socios VALUES('23333333','Betina Bustos','Bulnes 222');
INSERT INTO socios VALUES('24444444','Carlos Castro','Caseros 333');
INSERT INTO socios VALUES('25555555','Daniel Duarte','Dinamarca 44');
INSERT INTO deportes VALUES('basquet','Juan Juarez');
INSERT INTO deportes VALUES('futbol','Pedro Perez');
INSERT INTO deportes VALUES('natacion','Marina Morales');
INSERT INTO deportes VALUES('tenis','Marina Morales');
INSERT INTO inscriptos VALUES('22222222',3,'2006','s');
INSERT INTO inscriptos VALUES('23333333',3,'2006','s');
INSERT INTO inscriptos VALUES('24444444',3,'2006','n');
INSERT INTO inscriptos VALUES('22222222',3,'2005','s');
INSERT INTO inscriptos VALUES('22222222',3,'2007','n');
INSERT INTO inscriptos VALUES('24444444',1,'2006','s');
INSERT INTO inscriptos VALUES('24444444',2,'2006','s');
INSERT INTO inscriptos VALUES('26666666',0,'2006','s');

--Muestre el nombre del socio, el nombre del deporte en que se inscribió y el año empleando 
--diferentes tipos de join.
SELECT s.nombre, d.nombre, i.anio FROM socios AS s
    RIGHT JOIN inscriptos AS i ON s.documento = i.documento
    LEFT JOIN deportes AS d ON d.codigo = i.codigodeporte;

--Muestre todos los datos de las inscripciones (excepto los códigos) incluyendo aquellas 
--inscripciones cuyo código de deporte no existe en "deportes" y cuyo documento de socio no se 
--encuentra en "socios".
SELECT s.documento, s.nombre, d.nombre, d.profesor, i.anio, i.matricula FROM socios AS s
    LEFT JOIN inscriptos AS i ON i.documento = s.documento
    RIGHT JOIN deportes AS d ON d.codigo = i.codigodeporte;

--Corrección de la anterior
 select s.nombre,d.nombre,anio,matricula
  from deportes as d
  full join inscriptos as i
  on codigodeporte=d.codigo
  full join socios as s
  on s.documento=i.documento;

 select s.nombre,d.nombre,anio,matricula
  from deportes as d
  join inscriptos as i
  on codigodeporte=d.codigo
  join socios as s
  on s.documento=i.documento
  where s.documento='22222222';

--Ejercicio

IF OBJECT_ID('socios') IS NOT NULL
    DROP TABLE socios;
IF OBJECT_ID('deportes') IS NOT NULL
    DROP TABLE deportes;
IF OBJECT_ID('inscriptos') IS NOT NULL
    DROP TABLE inscriptos;

CREATE TABLE socios(
    documento CHAR(8) NOT NULL,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    PRIMARY KEY(documento)
);


CREATE TABLE deportes(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(20),
    profesor VARCHAR(15),
    PRIMARY KEY(codigo)
);

CREATE TABLE inscriptos(
    documento CHAR(8) NOT NULL,
    codigodeporte TINYINT NOT NULL,
    anio CHAR(4),
    matricula CHAR(1), --s paga, n impaga
    PRIMARY KEY(documento,codigodeporte,anio)
);

insert into socios values('22222222','Ana Acosta','Avellaneda 111');
insert into socios values('23333333','Betina Bustos','Bulnes 222');
insert into socios values('24444444','Carlos Castro','Caseros 333');
insert into socios values('25555555','Daniel Duarte','Dinamarca 44');

insert into deportes values('basquet','Juan Juarez');
insert into deportes values('futbol','Pedro Perez');
insert into deportes values('natacion','Marina Morales');
insert into deportes values('tenis','Marina Morales');

insert into inscriptos values ('22222222',3,'2006','s');
insert into inscriptos values ('23333333',3,'2006','s');
insert into inscriptos values ('24444444',3,'2006','n');

 insert into inscriptos values ('24444444',1,'2006','s');
 insert into inscriptos values ('24444444',2,'2006','s');

--Ingrese una inscripción con un código de deporte inexistente y un documento de socio que no 
--exista en "socios":
INSERT INTO inscriptos VALUES('32525395', 7, '2006', 's');

--Muestre el nombre del socio, el nombre del deporte en que se inscribió y el año empleando 
--diferentes tipos de join.
 select s.nombre,d.nombre,anio
  from deportes as d
  right join inscriptos as i
  on codigodeporte=d.codigo
  left join socios as s
  on i.documento=s.documento;


--Muestre el nombre del socio, el nombre del deporte en que se inscribió y el año empleando 
--diferentes tipos de join.
 select s.nombre,d.nombre,anio,matricula
  from deportes as d
  full join inscriptos as i
  on codigodeporte=d.codigo
  full join socios as s
  on s.documento=i.documento;

--Muestre todos los datos de las inscripciones (excepto los códigos) incluyendo aquellas 
--inscripciones cuyo código de deporte no existe en "deportes" y cuyo documento de socio no se 
--encuentra en "socios".
 select s.nombre,d.nombre,anio,matricula
  from deportes as d
  join inscriptos as i
  on codigodeporte=d.codigo
  join socios as s
  on s.documento=i.documento
  where s.documento='22222222';
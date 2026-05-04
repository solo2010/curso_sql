--Combinaciones y funciones de agrupamiento

if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint not null,
  precio decimal(5,2)
);
create table editoriales(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Siglo XXI');

insert into libros values('El aleph','Borges',1,20);
insert into libros values('Martin Fierro','Jose Hernandez',1,30);
insert into libros values('Aprenda PHP','Mario Molina',3,50);
insert into libros values('Uno','Richard Bach',3,15);
insert into libros values('Java en 10 minutos',default,4,45);

-- Contamos la cantidad de libros de cada editorial consultando ambas tablas:
SELECT e.nombre AS Editorial, COUNT(*) FROM editoriales AS e
    INNER JOIN libros AS l
    ON e.codigo = l.codigoeditorial
    GROUP BY e.nombre;

-- Buscamos el libro más costoso de cada editorial con un "left join":
SELECT e.nombre AS Editorial, MAX(l.precio) FROM editoriales AS e
    LEFT JOIN libros AS l
    ON e.codigo = l.codigoeditorial
    GROUP BY e.nombre;

--Ejercicio
IF OBJECT_ID('visitantes') IS NOT NULL
    DROP TABLE visitantes;
IF OBJECT_ID('ciudades') IS NOT NULL
    DROP TABLE ciudades;

CREATE TABLE visitantes(
    nombre VARCHAR(30),
    edad TINYINT,
    sexo CHAR(1),
    domicilio VARCHAR(30),
    codigociudad TINYINT NOT NULL,
    mail VARCHAR(30),
    montocompra DECIMAL(6,2)
);

CREATE TABLE ciudades(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(20)
);

INSERT INTO ciudades VALUES('Cordoba');
INSERT INTO ciudades VALUES('Carlos Paz');
INSERT INTO ciudades VALUES('La Falda');
INSERT INTO ciudades VALUES('Cruz del Eje');

INSERT INTO visitantes VALUES 
   ('Susana Molina', 35,'f','Colon 123', 1, null,59.80);
INSERT INTO visitantes VALUES 
   ('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50);
INSERT INTO visitantes VALUES 
   ('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90);
INSERT INTO visitantes VALUES 
   ('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0);
INSERT INTO visitantes VALUES 
   ('Alejandra Garcia',28,'f',null,2,null,280.50);
INSERT INTO visitantes VALUES 
   ('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40);
 insert into visitantes values 
   ('Mariana Juarez',33,'f',null,2,null,90);

--Cuente la cantidad de visitas por ciudad mostrando el nombre de la ciudad (3 filas)
SELECT c.nombre, COUNT(*) FROM ciudades AS c
    INNER JOIN visitantes AS v
    ON c.codigo = v.codigociudad
    GROUP BY c.nombre;

--Muestre el promedio de gastos de las visitas agrupados por ciudad y sexo (4 filas)
SELECT c.nombre, v.sexo, AVG(v.montocompra) FROM ciudades AS c
    INNER JOIN visitantes AS v
    ON c.codigo = v.codigociudad
    GROUP BY c.nombre, v.sexo;

--Muestre la cantidad de visitantes con mail, agrupados por ciudad (3 filas)
SELECT c.nombre, COUNT(v.mail) FROM ciudades AS c
    INNER JOIN visitantes AS v
    ON c.codigo = v.codigociudad
    GROUP BY c.nombre;

--Obtenga el monto de compra más alto de cada ciudad (3 filas)
SELECT c.nombre, MAX(montocompra) FROM ciudades AS c
    INNER JOIN visitantes AS v
    ON c.codigo = v.codigociudad
    GROUP BY c.nombre;


--Registros duplicados (distinct)
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  primary key(codigo)
);

go

insert into libros
  values('El aleph','Borges','Planeta');
insert into libros
  values('Martin Fierro','Jose Hernandez','Emece');
insert into libros
  values('Martin Fierro','Jose Hernandez','Planeta');
insert into libros
  values('Antologia poetica','Borges','Planeta');
insert into libros
  values('Aprenda PHP','Mario Molina','Emece');
insert into libros
  values('Aprenda PHP','Lopez','Emece');
insert into libros
  values('Manual de PHP', 'J. Paez', null);
insert into libros
  values('Cervantes y el quijote',null,'Paidos');
insert into libros
  values('Harry Potter y la piedra filosofal','J.K. Rowling','Emece');
insert into libros
  values('Harry Potter y la camara secreta','J.K. Rowling','Emece');
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos');
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');
insert into libros
  values('PHP de la A a la Z',null,null);
insert into libros
  values('Uno','Richard Bach','Planeta');

SELECT * FROM libros;

-- Para obtener la lista de autores sin repetición
SELECT DISTINCT autor FROM libros;

-- Para obtener la lista de autores conocidos, es decir, no incluyendo "null" 
-- en la lista:
SELECT DISTINCT autor FROM libros WHERE autor IS NOT NULL;

-- Contamos los distintos autores
SELECT COUNT(DISTINCT autor) FROM libros;

-- Nombres de las editoriales sin repetir:
SELECT DISTINCT editorial FROM libros;

--  Cantidad de editoriales distintas:
SELECT COUNT(DISTINCT editorial) FROM libros;

-- Distintos autores de la editorial "Planeta":
SELECT DISTINCT autor FROM libros WHERE editorial = 'Planeta';

-- Distintos autores que tiene cada editorial empleando "group by":
SELECT editorial, COUNT(DISTINCT autor) FROM libros
    GROUP BY editorial;

-- Mostramos los títulos y editoriales de los libros sin repetir 
-- títulos ni editoriales:

SELECT DISTINCT titulo, editorial FROM libros ORDER BY titulo;

--Ejercicio 1
 if object_id('clientes') is not null
  drop table clientes;

 create table clientes (
  codigo int identity,
  nombre varchar(30) not null,
  domicilio varchar(30),
  ciudad varchar(20),
  provincia varchar (20),
  primary key(codigo)
);

GO

 insert into clientes
  values ('Lopez Marcos','Colon 111','Cordoba','Cordoba');
 insert into clientes
  values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');
 insert into clientes
  values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');
 insert into clientes
  values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe');
 insert into clientes
  values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');
 insert into clientes
  values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');
 insert into clientes
  values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');
 insert into clientes
  values ('Lopez Carlos',null,'Cruz del Eje','Cordoba');
 insert into clientes
  values ('Ramos Betina','San Martin 999','Cordoba','Cordoba');
 insert into clientes
  values ('Lopez Lucas','San Martin 1010','Posadas','Misiones');

--Obtenga las provincias sin repetir (3 registros)
SELECT DISTINCT provincia FROM clientes;

--Cuente las distintas provincias.
SELECT COUNT(DISTINCT provincia) FROM clientes;

--Se necesitan los nombres de las ciudades sin repetir (6 registros)
SELECT DISTINCT ciudad FROM clientes;

--Obtenga la cantidad de ciudades distintas.
SELECT COUNT(DISTINCT ciudad) FROM clientes;

--Combine con "where" para obtener las distintas ciudades de la provincia de Cordoba (3 registros)
SELECT DISTINCT ciudad FROM clientes WHERE provincia = 'Cordoba';

--Contamos las distintas ciudades de cada provincia empleando "group by" (3 registros)
SELECT provincia, COUNT(DISTINCT(ciudad)) FROM clientes
    GROUP BY provincia;

--Ejercicio 2
 if object_id('inmuebles') is not null
  drop table inmuebles;

 create table inmuebles (
  documento varchar(8) not null,
  apellido varchar(30),
  nombre varchar(30),
  domicilio varchar(20),
  barrio varchar(20),
  ciudad varchar(20),
  tipo char(1),--b=baldio, e: edificado
  superficie decimal (8,2)
 );

GO

  insert into inmuebles
  values ('11000000','Perez','Alberto','San Martin 800','Centro','Cordoba','e',100);
 insert into inmuebles
  values ('11000000','Perez','Alberto','Sarmiento 245','Gral. Paz','Cordoba','e',200);
 insert into inmuebles
  values ('12222222','Lopez','Maria','San Martin 202','Centro','Cordoba','e',250);
 insert into inmuebles
  values ('13333333','Garcia','Carlos','Paso 1234','Alberdi','Cordoba','b',200);
 insert into inmuebles
  values ('13333333','Garcia','Carlos','Guemes 876','Alberdi','Cordoba','b',300);
 insert into inmuebles
  values ('14444444','Perez','Mariana','Caseros 456','Flores','Cordoba','b',200);
 insert into inmuebles
  values ('15555555','Lopez','Luis','San Martin 321','Centro','Carlos Paz','e',500);
 insert into inmuebles
  values ('15555555','Lopez','Luis','Lopez y Planes 853','Flores','Carlos Paz','e',350);
 insert into inmuebles
  values ('16666666','Perez','Alberto','Sucre 1877','Flores','Cordoba','e',150);

--Muestre los distintos apellidos de los propietarios, sin repetir (3 registros)
SELECT DISTINCT(apellido) FROM inmuebles;

--Muestre los distintos documentos de los propietarios, sin repetir (6 registros)
SELECT DISTINCT(documento) FROM inmuebles;

--Cuente, sin repetir, la cantidad de propietarios de inmuebles de la ciudad de Cordoba (5)
SELECT COUNT(DISTINCT documento) FROM inmuebles WHERE ciudad = 'Cordoba';

--Cuente la cantidad de inmuebles con domicilio en 'San Martin', sin repetir la ciudad (2)
SELECT COUNT(DISTINCT ciudad) FROM inmuebles;

--Muestre los apellidos y nombres, sin repetir (5 registros)
--Note que hay 2 personas con igual nombre y apellido que aparece una sola vez.
SELECT DISTINCT apellido, nombre FROM inmuebles;

--Muestre la cantidad de inmuebles que tiene cada propietario agrupando por documento, sin repetir 
--barrio (6 registros)
SELECT documento, COUNT(DISTINCT barrio) FROM inmuebles
    GROUP BY documento;






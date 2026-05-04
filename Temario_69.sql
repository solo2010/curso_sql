--Combinación externa completa (full join)
if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
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
insert into libros values('Aprenda PHP','Mario Molina',2,50);
insert into libros values('Java en 10 minutos',default,4,45);

-- Combinación externa completa para obtener todos los registros de ambas tablas,
-- incluyendo los libros cuyo código de editorial no existe en la tabla "editoriales"
-- y las editoriales de las cuales no hay correspondencia en "libros":
SELECT titulo, nombre FROM editoriales AS e
    FULL JOIN libros AS l
    ON codigoeditorial = e.codigo;


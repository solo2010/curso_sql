--Restricción check

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  preciomin decimal(5,2),
  preciomay decimal(5,2)
);

insert into libros values ('Uno','Bach','Planeta',22,20);
insert into libros values ('El quijote','Cervantes','Emece',15,13);
insert into libros values ('Aprenda PHP','Mario Molina','Siglo XXI',48,53);
insert into libros values ('Java en 10 minutos','Garcia','Siglo XXI',35,40);

-- Agregamos una restricción "check" para asegurar que los valores de los campos
-- correspondientes a precios no puedan ser negativos:
ALTER TABLE libros
    ADD CONSTRAINT CK_libros_precio_positivo
    CHECK (preciomin > 0 AND preciomay > 0);

--Observamos la restricción que se generó
EXEC sp_helpconstraint libros;

--intentamos ingresar un precio negativo al precio de mayorista
UPDATE libros SET preciomay=-40 WHERE titulo = 'Aprenda PHP';

UPDATE libros SET preciomay=48 WHERE titulo = 'Aprenda PHP';

-- Agregamos la restricción "check" que impida que se ingresen valores 
-- para "preciomay" superiores a "preciomin":
ALTER TABLE libros
    ADD CONSTRAINT CK_libros_preciominmay
    CHECK (preciomay <= preciomin);

--Debido a que saca error porque Java en 10 minutos tiene el precio mayor al precio menor se actualiza este precio
--mayor por un valor menor
UPDATE libros SET preciomay = 34.50 WHERE titulo LIKE '%Java%';
SELECT * FROM libros;

--Ejecutamos de nuevo la consulta que agrega la restricción de preciomay <= preciomin
ALTER TABLE libros
    ADD CONSTRAINT CK_libros_preciominmay
    CHECK (preciomay <= preciomin);

EXEC sp_helpconstraint libros;
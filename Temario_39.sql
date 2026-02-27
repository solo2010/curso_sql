--Modificador del group by (with rollup)

IF OBJECT_ID('visitantes') IS NOT NULL
    DROP TABLE visitantes;

CREATE TABLE visitantes(
  nombre varchar(30),
  edad tinyint,
  sexo char(1),
  domicilio varchar(30),
  ciudad varchar(20),
  telefono varchar(11),
  montocompra decimal(6,2) not null
);

GO

insert into visitantes
  values ('Susana Molina',28,'f',null,'Cordoba',null,45.50); 
insert into visitantes
  values ('Marcela Mercado',36,'f','Avellaneda 345','Cordoba','4545454',22.40);
insert into visitantes
  values ('Alberto Garcia',35,'m','Gral. Paz 123','Alta Gracia','03547123456',25); 
insert into visitantes
  values ('Teresa Garcia',33,'f',default,'Alta Gracia','03547123456',120);
insert into visitantes
  values ('Roberto Perez',45,'m','Urquiza 335','Cordoba','4123456',33.20);
insert into visitantes
  values ('Marina Torres',22,'f','Colon 222','Villa Dolores','03544112233',95);
insert into visitantes
  values ('Julieta Gomez',24,'f','San Martin 333','Alta Gracia',null,53.50);
insert into visitantes
  values ('Roxana Lopez',20,'f','null','Alta Gracia',null,240);
insert into visitantes
  values ('Liliana Garcia',50,'f','Paso 999','Cordoba','4588778',48);
insert into visitantes
  values ('Juan Torres',43,'m','Sarmiento 876','Cordoba',null,15.30);

-- Cantidad de visitantes por ciudad y el total de visitantes
SELECT ciudad, COUNT(*) AS cantidad FROM visitantes
    GROUP BY ciudad WITH ROLLUP;

-- Filas de resumen cuando agrupamos por 2 campos, "ciudad" y "sexo":
SELECT ciudad, sexo, COUNT(*) AS cantidad FROM visitantes
    GROUP BY ciudad, sexo
    WITH ROLLUP;

-- Para conocer la cantidad de visitantes y la suma de sus compras agrupados
-- por ciudad y sexo,
SELECT ciudad, sexo, COUNT(*) AS 'Cantidad de Visitantes', SUM(montocompra) AS 'Total compras' FROM visitantes
    GROUP BY ciudad, sexo
    WITH ROLLUP;


--Ejercicio 1
 if object_id('clientes') is not null
  drop table clientes;

 create table clientes (
  codigo int identity,
  nombre varchar(30) not null,
  domicilio varchar(30),
  ciudad varchar(20),
  estado varchar (20),
  pais varchar(20),
  primary key(codigo)
 );

  insert into clientes
  values ('Lopez Marcos','Colon 111', 'Cordoba','Cordoba','Argentina');
 insert into clientes
  values ('Perez Ana','San Martin 222', 'Carlos Paz','Cordoba','Argentina');
 insert into clientes
  values ('Garcia Juan','Rivadavia 333', 'Carlos Paz','Cordoba','Argentina');
 insert into clientes
  values ('Perez Luis','Sarmiento 444', 'Rosario','Santa Fe','Argentina');
 insert into clientes
  values ('Gomez Ines','San Martin 987', 'Santa Fe','Santa Fe','Argentina');
 insert into clientes
  values ('Gomez Ines','San Martin 666', 'Santa Fe','Santa Fe','Argentina');
 insert into clientes
  values ('Lopez Carlos','Irigoyen 888', 'Cordoba','Cordoba','Argentina');
 insert into clientes
  values ('Ramos Betina','San Martin 999', 'Cordoba','Cordoba','Argentina');
 insert into clientes
  values ('Fernando Salas','Mariano Osorio 1234', 'Santiago','Region metropolitana','Chile');
 insert into clientes
  values ('German Rojas','Allende 345', 'Valparaiso','Region V','Chile');
 insert into clientes
  values ('Ricardo Jara','Pablo Neruda 146', 'Santiago','Region metropolitana','Chile');
 insert into clientes
  values ('Joaquin Robles','Diego Rivera 147', 'Guadalajara','Jalisco','Mexico');


--Necesitamos la cantidad de clientes por país y la cantidad total de clientes en una sola consulta 
SELECT pais, COUNT(*) FROM clientes
    GROUP BY pais
    WITH ROLLUP;

--Necesitamos la cantidad de clientes agrupados por pais y estado, incluyendo resultados paciales 
--(9 filas)
SELECT pais, estado, COUNT(*) AS 'Cantidad' FROM clientes
    GROUP BY pais, estado
    WITH ROLLUP;

--Necesitamos la cantidad de clientes agrupados por pais, estado y ciudad, empleando "rollup" (16 
--filas)
SELECT pais, estado, ciudad, COUNT(*) AS 'Cantidad' FROM clientes
    GROUP BY pais, estado, ciudad
    WITH ROLLUP;

-- Ejercicio 2
IF OBJECT_ID('notas') IS NOT NULL
    DROP TABLE notas;

CREATE TABLE notas(
    documento CHAR(8) NOT NULL,
    materia VARCHAR(30),
    nota DECIMAL(4,2)
);

GO

 INSERT INTO notas VALUES ('22333444','Programacion',8);
 INSERT INTO notas VALUES ('22333444','Programacion',9);
 INSERT INTO notas VALUES ('22333444','Ingles',8);
 INSERT INTO notas VALUES ('22333444','Ingles',7);
 INSERT INTO notas VALUES ('22333444','Ingles',6);
 INSERT INTO notas VALUES ('22333444','Sistemas de datos',10);
 INSERT INTO notas VALUES ('22333444','Sistemas de datos',9);

 INSERT INTO notas VALUES ('23444555','Programacion',5);
 INSERT INTO notas VALUES ('23444555','Programacion',4);
 INSERT INTO notas VALUES ('23444555','Programacion',3);
 INSERT INTO notas VALUES ('23444555','Ingles',9);
 INSERT INTO notas VALUES ('23444555','Ingles',7);
 INSERT INTO notas VALUES ('23444555','Sistemas de datos',9);

 INSERT INTO notas VALUES ('24555666','Programacion',1);
 INSERT INTO notas VALUES ('24555666','Programacion',3.5);
 INSERT INTO notas VALUES ('24555666','Ingles',4.5);
 INSERT INTO notas VALUES ('24555666','Sistemas de datos',6);

--Se necesita el promedio por alumno por materia y el promedio de cada alumno en todas las materias 
--cursadas hasta el momento (13 registros):
SELECT documento, materia, AVG(nota) AS promedio FROM notas
    GROUP BY documento, materia
    WITH ROLLUP

--Compruebe los resultados parciales de la consulta anterior realizando otra consulta mostrando el 
--promedio de todas las carreras de cada alumno (4 filas)
SELECT documento, AVG(nota) AS promedio FROM notas
    GROUP BY documento WITH ROLLUP;

--Muestre la cantidad de notas de cada alumno, por materia (9 filas)
SELECT documento, materia, COUNT(*) AS cantidad FROM notas
    GROUP BY documento, materia;

--Realice la misma consulta anterior con resultados parciales incluidos (13 filas)
SELECT documento, materia, COUNT(*) AS cantidad FROM notas
    GROUP BY documento, materia WITH ROLLUP;

--Muestre la nota menor y la mayor de cada alumno y la menor y mayor nota de todos (use "rollup") 
--(4 filas)
SELECT documento, MIN(nota) AS menor, MAX(nota) AS mayor FROM notas
    GROUP BY documento WITH ROLLUP;


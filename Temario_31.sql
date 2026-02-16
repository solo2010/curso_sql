--Otros operadores relacionales (between)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    CODIGO INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20) DEFAULT 'Desconocido',
    editorial VARCHAR(20),
    precio DECIMAL(6,2)
);

GO

insert into libros
  values('El aleph','Borges','Emece',15.90);
insert into libros
  values('Cervantes y el quijote','Borges','Paidos',null);
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
insert into libros
  values('Martin Fierro','Jose Hernandez','Emece',25.90);
insert into libros (titulo,autor,precio)
  values('Antología poética','Borges',32);
insert into libros (titulo,autor,precio)
  values('Java en 10 minutos','Mario Molina',45.80);
insert into libros (titulo,autor,precio)
  values('Martin Fierro','Jose Hernandez',40);
insert into libros (titulo,autor,precio)
  values('Aprenda PHP','Mario Molina',56.50);

-- Recuperamos los registros cuyo precio esté entre 20 y 40 empleando "between":
SELECT * FROM libros WHERE precio BETWEEN 20 AND 40;

-- Para seleccionar los libros cuyo precio NO esté entre un intervalo de valores
-- antecedemos "not" al "between":
SELECT * FROM libros WHERE NOT precio BETWEEN 20 AND 40;

--Ejercicio 1

IF OBJECT_ID('visitas') IS NOT NULL
    DROP TABLE visitas;

CREATE TABLE visitas(
    numero INT IDENTITY,
    nombre VARCHAR(30) default 'Anonimo',
    mail VARCHAR(50),
    pais VARCHAR(20),
    fechayhora DATETIME,
    PRIMARY KEY(numero)
);

GO

INSERT INTO visitas(nombre,mail,pais,fechayhora)
 VALUES('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10');
INSERT INTO visitas(nombre,mail,pais,fechayhora)
 VALUES('Gustavo Gonzalez','GustavoGGonzalez@gotmail.com','Chile','2006-10-10 21:30');
INSERT INTO visitas(nombre,mail,pais,fechayhora)
 VALUES('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45');
INSERT INTO visitas(nombre,mail,pais,fechayhora)
 VALUES('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15');
INSERT INTO visitas(nombre,mail,pais,fechayhora)
 VALUES('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45');
INSERT INTO visitas(nombre,mail,pais,fechayhora)
 VALUES('Juancito','JuanJosePerez@gmail.com','Argentina','2006-09-12 16:20');
INSERT INTO visitas(nombre,mail,pais,fechayhora)
 VALUES('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');
INSERT INTO visitas(nombre,mail,pais)
 VALUES('Federico1','federicogarcia@xaxamail.com','Argentina');

SELECT * FROM visitas;

--Seleccione los usuarios que visitaron la página entre el '2006-09-12' y '2006-10-11' (5 
--registros)
SELECT * FROM visitas WHERE fechayhora BETWEEN '2006-09-12' AND '2006-10-11';

--Recupere las visitas cuyo número se encuentra entre 2 y 5 (4 registros)
SELECT * FROM visitas WHERE numero BETWEEN 2 AND 5;


--Ejercicio 2

IF OBJECT_ID('autos') IS NOT NULL
    DROP TABLE autos;

CREATE TABLE autos(
    patente CHAR(6),
    marca VARCHAR(20),
    modelo CHAR(4),
    precio DECIMAL(8,2),
    PRIMARY KEY(patente)
);

GO

INSERT INTO autos VALUES('ACD123','Fiat 128','1970',15000);
INSERT INTO autos VALUES('ACG234','Renault 11','1980',40000);
INSERT INTO autos VALUES('BCD333','Peugeot 505','1990',80000);
INSERT INTO autos VALUES('GCD123','Renault Clio','1995',70000);
INSERT INTO autos VALUES('BCC333','Renault Megane','1998',95000);
INSERT INTO autos VALUES('BVF543','Fiat 128','1975',20000);

--Seleccione todos los autos cuyo modelo se encuentre entre '1970' y '1990' usando el operador 
--"between" y ordénelos por dicho campo(4 registros)
SELECT * FROM autos WHERE modelo BETWEEN 1970 AND 1990 ORDER BY modelo;

--Seleccione todos los autos cuyo precio esté entre 50000 y 100000.
SELECT * FROM autos WHERE precio BETWEEN 50000 AND 100000;
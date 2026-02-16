--Operadores lógicos ( and - or - not)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20) default 'Desconocido',
    editorial VARCHAR(20),
    precio DECIMAL(6,2)
);

GO

INSERT INTO libros values('El alpeh', 'Borges', 'Emece', 15.90);
insert into libros
  values('Antología poética','Borges','Planeta',39.50);
insert into libros
  values('Java en 10 minutos','Mario Molina','Planeta',50.50);
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90);
insert into libros
  values('Martin Fierro','Jose Hernandez','Emece',25.90);
insert into libros
  values('Martin Fierro','Jose Hernandez','Paidos',16.80);
insert into libros
  values('Aprenda PHP','Mario Molina','Emece',19.50);
insert into libros
  values('Cervantes y el quijote','Borges','Paidos',18.40);

SELECT * FROM libros;

-- Recuperamos los libros cuyo autor sea igual a "Borges" y 
-- cuyo precio no supere los 20 pesos:
SELECT * FROM libros WHERE autor = 'Borges' AND precio <=20;

-- Seleccionamos los libros cuyo autor es "Borges" y/o cuya editorial es "Planeta":
SELECT * FROM libros WHERE autor = 'Borges' OR editorial = 'Planeta';

-- Recuperamos los libros cuya editorial NO es "Planeta":
SELECT * FROM libros WHERE NOT editorial = 'Planeta';

-- Veamos cómo el uso de paréntesis hace que SQL Server evalúe en forma diferente
-- ciertas consultas aparentemente iguales:
SELECT * FROM libros WHERE (autor='Borges')  OR (editorial='Paidos' AND precio < 20);
SELECT * FROM libros WHERE (autor='Borges' OR editorial ='Paidos') AND (precio < 20);

--Ejercicio 1
IF OBJECT_ID('medicamentos') IS NOT NULL
    DROP TABLE medicamentos;

CREATE TABLE medicamentos(
    codigo INT IDENTITY,
    nombre VARCHAR(20),
    laboratorio VARCHAR(20),
    precio DECIMAL(5,2),
    cantidad TINYINT,
    PRIMARY KEY(codigo)
);

 insert into medicamentos
  values('Sertal','Roche',5.2,100);
 insert into medicamentos
  values('Buscapina','Roche',4.10,200);
 insert into medicamentos
  values('Amoxidal 500','Bayer',15.60,100);
 insert into medicamentos
  values('Paracetamol 500','Bago',1.90,200);
 insert into medicamentos
  values('Bayaspirina','Bayer',2.10,150); 
 insert into medicamentos
  values('Amoxidal jarabe','Bayer',5.10,250); 

--Recupere los códigos y nombres de los medicamentos cuyo laboratorio sea 'Roche' y cuyo precio sea 
--menor a 5 (1 registro cumple con ambas condiciones)
SELECT codigo, nombre FROM medicamentos WHERE laboratorio = 'Roche' AND precio < 5;

--Recupere los medicamentos cuyo laboratorio sea 'Roche' o cuyo precio sea menor a 5 (4 registros):
SELECT * FROM medicamentos WHERE laboratorio = 'Roche' OR precio < 5;

--Muestre todos los medicamentos cuyo laboratorio NO sea "Bayer" y cuya cantidad sea=100 (1 
--registro)
SELECT * FROM medicamentos WHERE NOT laboratorio = 'Bayer' AND cantidad=100;

--Muestre todos los medicamentos cuyo laboratorio sea "Bayer" y cuya cantidad NO sea=100 
--(2 registros):
SELECT * FROM medicamentos WHERE laboratorio = 'Bayer' AND NOT cantidad = 100;

--Elimine todos los registros cuyo laboratorio sea igual a "Bayer" y su precio sea mayor a 10 (1 
--registro eliminado)
DELETE FROM medicamentos WHERE laboratorio = 'Bayer' AND precio > 10;

--Cambie la cantidad por 200, a todos los medicamentos de "Roche" cuyo precio sea mayor a 5 (1 
--registro afectado)
UPDATE medicamentos SET cantidad = 200 WHERE laboratorio = 'Roche' AND precio > 5;
SELECT * FROM medicamentos;

--Borre los medicamentos cuyo laboratorio sea "Bayer" o cuyo precio sea menor a 3 (3 registros 
--borrados)
DELETE FROM medicamentos WHERE laboratorio = 'Bayer' OR precio < 3;
SELECT * FROM medicamentos;

--Ejercicio 2
IF OBJECT_ID('peliculas') IS NOT NULL
    DROP TABLE peliculas;

CREATE TABLE peliculas(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    actor VARCHAR(20),
    duracion TINYINT,
    PRIMARY KEY (codigo)
);

insert into peliculas
 values('Mision imposible','Tom Cruise',120);
insert into peliculas
 values('Harry Potter y la piedra filosofal','Daniel R.',180);
insert into peliculas
 values('Harry Potter y la camara secreta','Daniel R.',190);
insert into peliculas
 values('Mision imposible 2','Tom Cruise',120);
insert into peliculas
 values('Mujer bonita','Richard Gere',120);
insert into peliculas
 values('Tootsie','D. Hoffman',90);
insert into peliculas
 values('Un oso rojo','Julio Chavez',100);
insert into peliculas
 values('Elsa y Fred','China Zorrilla',110);

--Recupere los registros cuyo actor sea "Tom Cruise" or "Richard Gere" (3 registros)
SELECT * FROM peliculas WHERE actor = 'Tom Cruise' OR actor = 'Richard Gere';

--Recupere los registros cuyo actor sea "Tom Cruise" y duración menor a 100 (ninguno cumple ambas 
--condiciones)
SELECT * FROM peliculas WHERE actor = 'Tom Cruise' AND duracion < 100;

--Cambie la duración a 200, de las películas cuyo actor sea "Daniel R." y cuya duración sea 180 (1 
--registro afectado)
UPDATE peliculas SET duracion = 200 WHERE actor = 'Daniel R.' AND duracion = 180;
SELECT * FROM peliculas;

--Borre todas las películas donde el actor NO sea "Tom Cruise" y cuya duración sea mayor o igual a 
--100 (2 registros eliminados)
DELETE FROM peliculas WHERE NOT actor = 'Tom Cruise' AND duracion >= 100;
SELECT * FROM peliculas WHERE (NOT actor = 'Tom Cruise') AND duracion >= 100;
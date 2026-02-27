--Seleccionar grupos (having)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio DECIMAL(5,2),
    cantidad TINYINT,
    PRIMARY KEY(codigo)
);

GO

insert into libros
  values('El aleph','Borges','Planeta',35,null);
insert into libros
  values('Martin Fierro','Jose Hernandez','Emece',22.20,200);
insert into libros
  values('Martin Fierro','Jose Hernandez','Planeta',40,200);
insert into libros
  values('Antologia poetica','J.L. Borges','Planeta',null,150);
insert into libros
  values('Aprenda PHP','Mario Molina','Emece',18,null);
insert into libros
  values('Manual de PHP', 'J.C. Paez', 'Siglo XXI',56,120);
insert into libros
  values('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100);
insert into libros
  values('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90);
insert into libros
  values('Harry Potter y la camara secreta','J.K. Rowling','Emece',null,100);
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',42,80);
insert into libros
  values('PHP de la A a la Z',null,null,110,0);
insert into libros
  values('Uno','Richard Bach','Planeta',25,null);

--  Cantidad de libros agrupados por editorial pero considerando sólo algunos grupos, 
--  los que devuelvan un valor mayor a 2
SELECT editorial, COUNT(*) FROM libros
    GROUP BY editorial
    HAVING COUNT(*) > 2;

-- Promedio de los precios de los libros agrupados por editorial, pero solamente de 
-- aquellos grupos cuyo promedio supere los 25 pesos:
SELECT editorial, AVG(precio) FROM libros
    GROUP BY editorial
    HAVING AVG(precio) > 25;

-- Cantidad de libros, sin considerar los que tienen precio nulo (where), agrupados por 
-- editorial (group by), sin considerar la editorial "Planeta" (having):
SELECT editorial, COUNT(*) FROM libros
    WHERE precio IS NOT NULL
    GROUP BY editorial
    HAVING editorial <> 'Planeta';

-- Promedio de los precios agrupados por editorial, 
-- de aquellas editoriales que tienen más de 2 libros:
SELECT editorial, AVG(precio) FROM libros
    GROUP BY editorial
    HAVING COUNT(*) > 2;

-- Mayor valor de los libros agrupados y ordenados por editorial y seleccionamos las 
-- filas que tienen un valor menor a 100 y mayor a 30:
SELECT editorial, MAX(precio) FROM libros
    GROUP BY editorial
    HAVING MAX(precio) < 100 AND MAX(precio) > 30
    ORDER BY editorial;

--Ejercicio 1
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

CREATE TABLE clientes(
    codigo INT IDENTITY,
    nombre VARCHAR(30) NOT NULL,
    domicilio VARCHAR(30),
    ciudad VARCHAR(20),
    provincia VARCHAR(20),
    telefono VARCHAR(11),
    PRIMARY KEY(codigo)
);

GO

INSERT INTO clientes VALUES('Lopez Marcos','Colon 111','Cordoba','Cordoba','null');
INSERT INTO clientes VALUES('Perez Ana','San Martin 222','Cruz del Eje','Cordoba','4578585');
INSERT INTO clientes VALUES('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba','4578445');
INSERT INTO clientes VALUES('Perez Luis','Sarmiento 444','Rosario','Santa Fe',null);
INSERT INTO clientes VALUES('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba','4253685');
INSERT INTO clientes VALUES('Gomez Ines','San Martin 666','Santa Fe','Santa Fe','0345252525');
INSERT INTO clientes VALUES('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba','4554455');
INSERT INTO clientes VALUES('Lopez Carlos',null,'Cruz del Eje','Cordoba',null);
INSERT INTO clientes VALUES('Ramos Betina','San Martin 999','Cordoba','Cordoba','4223366');
INSERT INTO clientes VALUES('Lopez Lucas','San Martin 1010','Posadas','Misiones','0457858745');

--Obtenga el total de los registros agrupados por ciudad y provincia (6 filas)
SELECT ciudad, provincia, COUNT(*) FROM clientes
    GROUP BY ciudad, provincia;

--Obtenga el total de los registros agrupados por ciudad y provincia sin considerar los que tienen 
--menos de 2 clientes (3 filas)
SELECT ciudad, provincia, COUNT(*) FROM clientes
    GROUP BY ciudad, provincia
    HAVING COUNT(*) >= 2

--Obtenga el total de los clientes que viven en calle "San Martin" (where), agrupados por provincia 
--(group by), teniendo en cuenta todos los valores (all), de aquellas ciudades que tengan menos de 2 
--clientes (having) y omitiendo la fila correspondiente a la ciudad de "Cordoba" (having) (4 filas 
--devueltas)
 select ciudad, count(*)
  from clientes
  where domicilio like '%San Martin%'
  group by all ciudad
  having count(*)<2 and
  ciudad <> 'Cordoba';
--el ejercicio está mal planteado ya que dice por provincia no por ciudad


--Ejercicio 2
IF OBJECT_ID('visitantes') IS NOT NULL
    DROP TABLE visitantes;

CREATE TABLE visitantes(
    nombre VARCHAR(30),
    edad TINYINT,
    sexo CHAR(1),
    domicilio VARCHAR(30),
    ciudad VARCHAR(20),
    telefono VARCHAR(11),
    montocompra DECIMAL(6,2) NOT NULL
);

GO

 INSERT INTO visitantes VALUES('Susana Molina',28,'f',null,'Cordoba',null,45.50); 
 INSERT INTO visitantes VALUES('Marcela Mercado',36,'f','Avellaneda 345','Cordoba','4545454',22.40);
 INSERT INTO visitantes VALUES('Alberto Garcia',35,'m','Gral. Paz 123','Alta Gracia','03547123456',25); 
 INSERT INTO visitantes VALUES('Teresa Garcia',33,'f',default,'Alta Gracia','03547123456',120);
 INSERT INTO visitantes VALUES('Roberto Perez',45,'m','Urquiza 335','Cordoba','4123456',33.20);
 INSERT INTO visitantes VALUES('Marina Torres',22,'f','Colon 222','Villa Dolores','03544112233',95);
 INSERT INTO visitantes VALUES('Julieta Gomez',24,'f','San Martin 333','Alta Gracia',null,53.50);
 INSERT INTO visitantes VALUES('Roxana Lopez',20,'f','null','Alta Gracia',null,240);
 INSERT INTO visitantes VALUES('Liliana Garcia',50,'f','Paso 999','Cordoba','4588778',48);
 INSERT INTO visitantes VALUES('Juan Torres',43,'m','Sarmiento 876','Cordoba',null,15.30);

 --Obtenga el total de las compras agrupados por ciudad y sexo de aquellas filas que devuelvan un 
--valor superior a 50 (3 filas)
SELECT ciudad, sexo, SUM(montocompra) FROM visitantes
    GROUP BY ciudad, sexo
    HAVING SUM(montocompra) > 50;

--Obtenga el total de las compras agrupados por ciudad y sexo (group by), teniendo en cuenta todos 
--los valores (all), considerando sólo los montos de compra superiores a 50 (where), los visitantes 
--con teléfono (where), sin considerar la ciudad de "Cordoba" (having), ordenados por ciudad (order 
--by) (3 filas)
SELECT ciudad, sexo, SUM(montocompra) AS 'Suma total' FROM visitantes 
    WHERE montocompra > 50 AND telefono IS NOT NULL
    GROUP BY ALL ciudad, sexo
    HAVING ciudad <> 'Cordoba'
    ORDER BY ciudad;

--Muestre el monto mayor de compra agrupado por ciudad, siempre que dicho valor supere los 50 pesos 
--(having), considerando sólo los visitantes de sexo femenino y domicilio conocido (where) (2 filas)
SELECT ciudad, MAX(montocompra) FROM visitantes
    WHERE sexo = 'f' AND domicilio IS NOT NULL
    GROUP BY ciudad
    HAVING MAX(montocompra) > 50;

--Agrupe por ciudad y sexo, muestre para cada grupo el total de visitantes, la suma de sus compras 
--y el promedio de compras, ordenado por la suma total y considerando las filas con promedio superior 
--a 30 (3 filas)
SELECT ciudad, sexo, COUNT(*) AS total_visitantes, SUM(montocompra) AS suma_compras, AVG(montocompra) AS promedio_compras
    FROM visitantes
    GROUP BY ciudad, sexo
    HAVING AVG(montocompra) > 30
    ORDER BY suma_compras;



--Autocombinación

if object_id('comidas') is not null
  drop table comidas;

create table comidas(
  codigo int identity,
  nombre varchar(30),
  precio decimal(4,2),
  rubro char(6),-- 'plato'=plato principal', 'postre'=postre
  primary key(codigo)
);

go

insert into comidas values('ravioles',5,'plato');
insert into comidas values('tallarines',4,'plato');
insert into comidas values('milanesa',7,'plato');
insert into comidas values('cuarto de pollo',6,'plato');
insert into comidas values('flan',2.5,'postre');
insert into comidas values('porcion torta',3.5,'postre');

-- Realizamos un "cross join"
-- Note que aparecen filas duplicadas, por ejemplo, "ravioles" se
-- combina con "ravioles" y la combinación "ravioles- flan"
-- se repite como "flan- ravioles"
SELECT c1.nombre AS 'Plato Principal', c2.nombre AS 'Postre', c1.precio + c2.precio AS 'Precio Total'
    FROM comidas AS c1
    CROSS JOIN comidas AS c2;

-- Debemos especificar que combine el rubro "plato" con "postre":
SELECT c1.nombre AS 'Plato Principal', c2.nombre AS 'Postre', c1.precio + c2.precio AS 'Precio Total'
    FROM comidas AS c1
    CROSS JOIN comidas AS c2
    WHERE c1.rubro = 'plato' AND c2.rubro = 'postre';

-- También se puede realizar una autocombinación con "join":
SELECT c1.nombre AS 'Plato Principal', c2.nombre AS postre, c1.precio +c2.precio AS Total
    FROM comidas AS c1
    JOIN comidas AS c2
    ON c1.codigo <> c2.codigo
    WHERE c1.rubro='plato' AND c2.rubro = 'postre';

--Ejercicio 1
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

CREATE TABLE clientes(
    nombre VARCHAR(30),
    sexo CHAR(1), --'f'=femenino, 'm' =masculino
    edad INT,
    domicilio VARCHAR(30)
);

 INSERT INTO clientes VALUES('Maria Lopez','f',45,'Colon 123');
 INSERT INTO clientes VALUES('Liliana Garcia','f',35,'Sucre 456');
 INSERT INTO clientes VALUES('Susana Lopez','f',41,'Avellaneda 98');
 INSERT INTO clientes VALUES('Juan Torres','m',44,'Sarmiento 755');
 INSERT INTO clientes VALUES('Marcelo Oliva','m',56,'San Martin 874');
 INSERT INTO clientes VALUES('Federico Pereyra','m',38,'Colon 234');
 INSERT INTO clientes VALUES('Juan Garcia','m',50,'Peru 333');

--La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo 
--masculino. Use un  "cross join" (12 registros)
 SELECT c1.nombre, c2.nombre FROM clientes AS c1
    CROSS JOIN clientes AS c2
    WHERE c1.sexo = 'f' AND c2.sexo = 'm';

--Obtenga la misma salida enterior pero realizando un "join".
SELECT c1.nombre, c2.nombre FROM clientes AS c1
    JOIN clientes AS c2
    ON c1.sexo <> c2.sexo
    WHERE c1.sexo = 'f' AND c2.sexo = 'm';

--Realice la misma autocombinación que el punto 3 pero agregue la condición que las parejas no 
--tengan una diferencia superior a 5 años (5 registros)
SELECT c1.nombre, c2.nombre FROM clientes AS c1
    CROSS JOIN clientes AS c2
    WHERE (c1.sexo = 'm' AND c2.sexo = 'f')
    AND (c1.edad - c2.edad BETWEEN -5 AND 5);

--Ejercicio 2
IF OBJECT_ID('equipos') IS NOT NULL
    DROP TABLE equipos;

CREATE TABLE equipos(
    nombre VARCHAR(30),
    barrio VARCHAR(20),
    domicilio VARCHAR(30),
    entrenador VARCHAR(30)
);

 INSERT INTO equipos VALUES('Los tigres','Gral. Paz','Sarmiento 234','Juan Lopez');
 INSERT INTO equipos VALUES('Los leones','Centro','Colon 123','Gustavo Fuentes');
 INSERT INTO equipos VALUES('Campeones','Pueyrredon','Guemes 346','Carlos Moreno');
 INSERT INTO equipos VALUES('Cebollitas','Alberdi','Colon 1234','Luis Duarte');


--Cada equipo jugará con todos los demás 2 veces, una vez en cada sede. Realice un "cross join" 
--para combinar los equipos teniendo en cuenta que un equipo no juega consigo mismo (12 registros)
SELECT e1.nombre AS 'Local', e2.nombre AS 'Visitantes' FROM equipos AS e1
    CROSS JOIN equipos AS e2
    WHERE e1.nombre <> e2.nombre;

--Obtenga el mismo resultado empleando un "join".
SELECT e1.nombre AS 'Local', e2.nombre AS 'Visitantes' FROM equipos AS e1
    JOIN equipos AS e2
    ON e1.nombre <> e2.nombre;

--Realice un "cross join" para combinar los equipos para que cada equipo juegue con cada uno de los 
--otros una sola vez (6 registros)
SELECT e1.nombre AS 'Local', e2.nombre AS 'Visitantes' FROM equipos AS e1
    CROSS JOIN equipos AS e2
    WHERE e1.nombre <> e2.nombre;

--Realice un "cross join" para combinar los equipos para que cada equipo juegue con cada uno de los 
--otros una sola vez (6 registros)
select e1.nombre,e2.nombre,e1.barrio as 'sede'
  from equipos as e1
  cross join equipos as e2
  where e1.nombre>e2.nombre;
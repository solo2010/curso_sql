--Combinaciones cruzadas (cross join)

IF OBJECT_ID('comidas') IS NOT NULL
    DROP TABLE comidas;

IF OBJECT_ID('postres') IS NOT NULL
    DROP TABLE postres;

CREATE TABLE comidas(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(30),
    precio DECIMAL(4,2),
);

CREATE TABLE postres(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(30),
    precio DECIMAL(4,2)
);

GO

INSERT INTO comidas VALUES('ravioles', 5);
INSERT INTO comidas VALUES('tallarines', 4);
INSERT INTO comidas VALUES('milanesa', 7);
INSERT INTO comidas VALUES('cuarto de pollo', 6);

INSERT INTO postres VALUES('flan',2.5);
INSERT INTO postres VALUES('porcion torta',3.5);

-- Combinar los registros de ambas tablas para mostrar 
-- los distintos menúes que ofrece. Lo hacemos usando un "cross join":
SELECT c.nombre AS 'Plato Principal', p.nombre AS 'Postre', c.precio + p.precio AS 'Total' 
    FROM comidas AS c
    CROSS JOIN postres AS p;

--Primer Ejercicio
IF OBJECT_ID('mujeres') IS NOT NULL
    DROP TABLE mujeres;
IF OBJECT_ID('varones') IS NOT NULL
    DROP TABLE varones;

CREATE TABLE mujeres(
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    edad INT
);

CREATE TABLE varones(
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    edad INT
);

GO

INSERT INTO mujeres VALUES('Maria Lopez','Colon 123',45);
INSERT INTO mujeres VALUES('Liliana Garcia','Sucre 456',35);
INSERT INTO mujeres VALUES('Susana Lopez','Avellaneda 98',41);

INSERT INTO varones VALUES('Juan Torres','Sarmiento 755',44);
INSERT INTO varones VALUES('Marcelo Oliva','San Martin 874',56);
INSERT INTO varones VALUES('Federico Pereyra','Colon 234',38);
INSERT INTO varones VALUES('Juan Garcia','Peru 333',50);

--La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo 
--masculino. Use un "cross join" (12 registros)

SELECT m.nombre AS Mujer, v.nombre AS Hombre FROM mujeres AS m
    CROSS JOIN varones AS v;

--Realice la misma combinación pero considerando solamente las personas mayores de 40 años (6 
--registros)

SELECT m.nombre AS Mujer, v.nombre AS Hombre FROM mujeres AS m
    CROSS JOIN varones AS v
    WHERE m.edad > 40 AND v.edad > 40; 

--Forme las parejas pero teniendo en cuenta que no tengan una diferencia superior a 10 años (8 
--registros)
SELECT m.nombre AS Mujer, v.nombre AS Hombre FROM mujeres AS m
    CROSS JOIN varones AS v
    WHERE m.edad - v.edad > 10 OR v.edad - m.edad > 10;

--Ejercicio 2
IF OBJECT_ID('guardias') IS NOT NULL
    DROP TABLE guardias;
IF OBJECT_ID('tareas') IS NOT NULL
    DROP TABLE tareas;

CREATE TABLE guardias(
    documento CHAR(8),
    nombre VARCHAR(30),
    sexo CHAR(1),
    domicilio VARCHAR(30),
    PRIMARY KEY(documento)
);

CREATE TABLE tareas(
    codigo TINYINT IDENTITY,
    domicilio VARCHAR(30),
    descripcion VARCHAR(30),
    horario CHAR(2) --AM o PM
    PRIMARY KEY(codigo)
);

 INSERT INTO guardias VALUES('22333444','Juan Perez','m','Colon 123');
 INSERT INTO guardias VALUES('24333444','Alberto Torres','m','San Martin 567');
 INSERT INTO guardias VALUES('25333444','Luis Ferreyra','m','Chacabuco 235');
 INSERT INTO guardias VALUES('23333444','Lorena Viale','f','Sarmiento 988');
 INSERT INTO guardias VALUES('26333444','Irma Gonzalez','f','Mariano Moreno 111');

 INSERT INTO tareas VALUES('Colon 1111','vigilancia exterior','AM');
 INSERT INTO tareas VALUES('Urquiza 234','vigilancia exterior','PM');
 INSERT INTO tareas VALUES('Peru 345','vigilancia interior','AM');
 INSERT INTO tareas VALUES('Avellaneda 890','vigilancia interior','PM');

 SELECT g.documento, g.nombre, t.domicilio, t.descripcion, t.horario FROM guardias AS g
    CROSS JOIN tareas AS t;

 SELECT g.documento, g.nombre, t.domicilio, t.descripcion, t.horario FROM guardias AS g
    CROSS JOIN tareas AS t
    WHERE (g.sexo = 'f' AND t.descripcion = 'vigilancia interior') OR (g.sexo = 'm' AND t.descripcion = 'vigilancia exterior');
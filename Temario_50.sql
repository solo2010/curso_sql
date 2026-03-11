--Restricción primary key

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT NOT NULL,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    PRIMARY KEY (codigo)
);

GO

-- Veamos la restricción "primary key" que creó automáticamente SQL Server:
EXEC sp_helpconstraint libros;

-- Vamos a eliminar la tabla y la crearemos nuevamente, sin establecer la 
-- clave primaria:
DROP TABLE libros;

CREATE TABLE libros(
    codigo INT NOT NULL,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15)
);

GO

-- Definimos una restricción "primary key" para nuestra tabla "libros" 
-- para asegurarnos que cada libro tendrá un código diferente y único:
ALTER TABLE libros
    ADD CONSTRAINT PK_libros_codigo
    PRIMARY KEY(codigo);

-- Veamos la información respecto a ella:
EXEC sp_helpconstraint libros;

--Ejercicio 1
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    documento VARCHAR(8) NOT NULL,
    nombre VARCHAR(30),
    seccion VARCHAR(20)
);

GO

 INSERT INTO empleados VALUES('22222222','Alberto Lopez','Sistemas');
 INSERT INTO empleados VALUES('23333333','Beatriz Garcia','Administracion');
 INSERT INTO empleados VALUES('23333333','Carlos Fuentes','Administracion');

 --Intente establecer una restricción "primary key" para la tabla para que el documento no se repita 
--ni admita valores nulos. No lo permite porque la tabla contiene datos que no cumplen con la restricción
ALTER TABLE empleados
   ADD CONSTRAINT PK_empleados_documento
   PRIMARY KEY(documento);

--debemos eliminar (o modificar) el registro que tiene documento duplicado:
DELETE FROM empleados WHERE nombre = 'Carlos Fuentes';
SELECT * FROM empleados;

--Establecemos la restricción de primary key nuevamente
ALTER TABLE empleados
    ADD CONSTRAINT PK_empleados_documento
    PRIMARY KEY(documento);

--Intente actualizar un documento para que se repita.
UPDATE empleados SET documento = '23333333' WHERE nombre = 'Alberto Lopez';

--Intente establecer otra restricción "primary key" con el campo "nombre".
ALTER TABLE empleados
    ADD CONSTRAINT PK_empleados_nombre
    PRIMARY KEY(nombre);

--Intente ingresar un registro con valor nulo para el documento.
INSERT INTO empleados VALUES(NULL, 'Flor Lopez', 'Administracion');

--Establezca una restricción "default" para que almacene "00000000" en el documento en caso de 
--omitirlo en un "insert".
ALTER TABLE empleados
    ADD CONSTRAINT DF_empleados_documento
    DEFAULT '00000000'
    FOR documento;

--Ingrese un registro sin valor para el documento.
INSERT INTO empleados VALUES(DEFAULT, 'Flor Lopez', 'Administracion');

select * FROM empleados;

--Vea las restricciones de la tabla empleados (2 filas):
EXEC sp_helpconstraint empleados;

--Ejercicio 2
IF OBJECT_ID('remis') IS NOT NULL
    DROP TABLE remis;

CREATE TABLE remis(
    numero TINYINT IDENTITY,
    patente CHAR(6),
    marca VARCHAR(15),
    modelo CHAR(4)
);

INSERT INTO remis VALUES('ABC123','Renault 12','1990');
INSERT INTO remis VALUES('DEF456','Fiat Duna','1995');

--Intente definir una restricción "primary key" para el campo "patente". No lo permite porque el campo no fue definido "not null"
ALTER TABLE remis
    ADD CONSTRAINT PK_remis_patente
    PRIMARY KEY(patente);

--Establezca una restricción "primary key" para el campo "numero".
--Si bien "numero" no fue definido explícitamente "not null", no acepta valores nulos por ser 
--"identity".
ALTER TABLE remis
    ADD CONSTRAINT PK_remis_numero
    PRIMARY KEY(numero);

EXEC sp_helpconstraint remis;
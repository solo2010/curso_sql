--Eliminar restricciones (alter table - drop)
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT NOT NULL,
    titulo VARCHAR(30),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio DECIMAL(6,2)
);

GO

-- Definimos una restricción "primary key" para nuestra tabla "libros" para asegurarnos 
-- que cada libro tendrá un código diferente y único:
ALTER TABLE libros
    ADD CONSTRAINT PK_libros_codigo
    PRIMARY KEY(codigo);

-- Definimos una restricción "check" para asegurarnos que el precio no será negativo:
ALTER TABLE libros
    ADD CONSTRAINT CK_libros_precio_
    CHECK (precio >= 0);

-- Definimos una restricción "default" para el campo "autor" para que almacene "Desconocido":
ALTER TABLE libros
    ADD CONSTRAINT DF_libros_autor
    DEFAULT 'Desconocido'
    FOR autor;

-- Definimos una restricción "default" para el campo "precio" para que almacene 0:
ALTER TABLE libros
    ADD CONSTRAINT DF_libros_precio
    DEFAULT 0
    FOR precio;

-- Vemos las restricciones:
EXEC sp_helpconstraint libros;

-- Eliminamos la restricción "DF_libros_autor":
ALTER TABLE libros
    DROP DF_libros_autor;

-- Eliminamos la restricción "PK_libros_codigo":
ALTER TABLE libros
    DROP PK_libros_codigo;

EXEC sp_helpconstraint libros;

--Ejercicio
IF OBJECT_ID('vehiculos') IS NOT NULL
    DROP TABLE vehiculos;

CREATE TABLE vehiculos(
    patente CHAR(6) NOT NULL,
    tipo CHAR(1), --a=auto -m=moto
    horallegada DATETIME NOT NULL,
    horasalida DATETIME
);

--Establezca una restricción "check" que admita solamente los valores "a" y "m" para el campo 
--"tipo":
ALTER TABLE vehiculos
    ADD CONSTRAINT CK_vehiculos_tipo
    CHECK (tipo IN ('a', 'm'));

--Establezca una restricción "default" para el campo "tipo" que almacene el valor "a" en caso de no 
--ingresarse valor para dicho campo:
ALTER TABLE vehiculos
    ADD CONSTRAINT DF_vehiculos_tipo
    DEFAULT 'a'
    FOR tipo;

--Establezca una restricción "check" para el campo "patente" para que acepte 3 letras seguidas de 3 
--dígitos:
ALTER TABLE vehiculos
    ADD CONSTRAINT CK_vehiculos_patente
    CHECK (patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]');

--Agregue una restricción "primary key" que incluya los campos "patente" y "horallegada":
 ALTER TABLE vehiculos
    ADD CONSTRAINT PK_vehiculos_patente_horallegada
    PRIMARY KEY(patente, horallegada);

--Ingrese un vehículo:
INSERT INTO vehiculos VALUES('SDR456', 'a', '2005/10/10 10:10', NULL);

--Intente ingresar un registro repitiendo la clave primaria. No se permite.
INSERT INTO vehiculos VALUES('SDR456', 'm', '2005/10/10 10:10', NULL);

--Ingrese un registro repitiendo la patente pero no la hora de llegada:
INSERT INTO vehiculos VALUES('SDR456', 'a', '2005/10/10 14:00', NULL);

--Ingrese un registro repitiendo la hora de llegada pero no la patente:
INSERT INTO vehiculos VALUES('NAA613', 'm', '2005/10/10 10:10', NULL);

-- Vea todas las restricciones para la tabla "vehiculos":
EXEC sp_helpconstraint vehiculos;

--Elimine la restricción "default" del campo "tipo".
ALTER TABLE vehiculos
    DROP DF_vehiculos_tipo;

--Vea si se ha eliminado:
EXEC sp_helpconstraint vehiculos;

--Elimine la restricción "primary key" y "check".
ALTER TABLE vehiculos
    DROP ck_vehiculos_tipo, PK_vehiculos_patente_horallegada;

--Vea si se han eliminado
EXEC sp_helpconstraint vehiculos;
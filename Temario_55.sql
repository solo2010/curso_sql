IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

IF OBJECT_ID('RG_sueldo_100a1000') IS NOT NULL
    DROP RULE RG_sueldo_100a1000;

CREATE TABLE empleados(
    documento CHAR(8),
    nombre VARCHAR(30) NOT NULL,
    seccion VARCHAR(20),
    sueldo DECIMAL(6,2),
    PRIMARY KEY(documento)
);

GO

-- Creamos una regla para restringir los valores que se pueden ingresar
-- en un campo "sueldo":
CREATE RULE RG_sueldo_100a1000
    AS @sueldo BETWEEN 100 AND 1000;

GO

-- Asociamos la regla creada anteriormente al campo "sueldo":
EXEC sp_bindrule RG_sueldo_100a1000, 'empleados.sueldo';

-- Vemos si la regla está asociada a algún campo de "empleados":
EXEC sp_helpconstraint empleados;

-- Quitamos la asociación:
EXEC sp_unbindrule 'empleados.sueldo';

-- Ahora que hemos quitado la asociación, podemos ingresar el valor
-- "1200" en el campo "sueldo":
INSERT INTO empleados VALUES('32525395', 'Flor Cecilia Lopez', 'Sistemas', 1200);

-- Vemos si la regla está asociada a algún campo de "empleados":
EXEC sp_helpconstraint empleados;

-- Ejecutamos el procedimiento "sp_help" para verificar que la regla aún existe:
EXEC sp_help;

-- Ahora si podemos borrar la regla:
DROP RULE RG_sueldo_100a1000;

--Ejercicio
IF OBJECT_ID('vehiculos') IS NOT NULL
    DROP TABLE vehiculos;

IF OBJECT_ID('RG_patente_patron') IS NOT NULL
    DROP RULE RG_patente_patron;

IF OBJECT_ID('RG_vehiculos_tipo') IS NOT NULL
    DROP RULE RG_vehiculos_tipo;

IF OBJECT_ID('RG_vehiculos_tipo2') IS NOT NULL
    DROP RULE RG_vehiculos_tipo2;

CREATE TABLE vehiculos(
    patente CHAR(6) NOT NULL,
    tipo CHAR(1), --'a'=auto, 'm'=moto
    horallegada DATETIME NOT NULL,
    horasalida DATETIME
);

--Cree una regla para restringir los valores que se pueden ingresar en un campo "patente" (3 letras 
--seguidas de 3 dígitos):
GO

CREATE RULE RG_patente_patron
    AS @patente LIKE '[A-Z][A-Z][A-Z][1-9][1-9][1-9]';

GO

--Asocie la regla al campo "patente":
EXEC sp_bindrule RG_patente_patron, 'vehiculos.patente';

--Intente ingresar un registro con valor para el campo "patente" que no cumpla con la regla:
INSERT INTO vehiculos VALUES('NA2Q44', 'm', GETDATE(), NULL);

--Cree otra regla que controle los valores para el campo "tipo" para que solamente puedan 
--ingresarse los caracteres "a" y "m":

GO

CREATE RULE RG_vehiculos_tipo
    AS @tipo IN('m', 'a');

GO

--Asocie la regla al campo "tipo":
EXEC sp_bindrule RG_vehiculos_tipo, 'vehiculos.tipo';

--Intente ingresar un registro con el valor 'c' para "tipo":
INSERT INTO vehiculos VALUES('NAA612', 'c', GETDATE(), NULL);

-- Cree otra regla llamada "RG_vehiculos_tipo2" que controle los valores para el campo "tipo" para 
--que solamente puedan ingresarse los caracteres "a", "c" y "m":
GO
CREATE RULE RG_vehiculos_tipo2
    AS @tipo IN ('a', 'c', 'm');
GO

--Si la asociamos a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la 
--asociación anterior. Asocie la regla creada en el punto anterior al campo "tipo".
EXEC sp_bindrule RG_vehiculos_tipo2, 'vehiculos.tipo';

--Ingrese el registro que no pudo ingresar en el punto 9.
INSERT INTO vehiculos VALUES('NAA612', 'c', GETDATE(), NULL);

--Intente eliminar la regla "RG_vehiculos_tipo2". No es posible porque está asociada a un campo de "vehiculos".
DROP RULE RG_vehiculos_tipo2;

--Elimine la regla "RG_vehiculos_tipo". Es posible porque no está asociada a ningún campo.
DROP RULE RG_vehiculos_tipo;

--Intente eliminar la regla "RG_patente_patron". No es posible porque está asociada.
DROP RULE RG_patente_patron;

--Quite la asociación de la regla con el campo "patente" de "vehiculos".
EXEC sp_unbindrule 'vehiculos.patente';

--Vea si la regla "RG_patente_patron" está asociada a algún campo de "vehiculos".
--No lo está.
EXEC sp_helpconstraint vehiculos;

-- Verifique que la regla aún existe en la base de datos activa:
EXEC sp_help;

--Elimine la regla que no pudo eliminar en el punto 15.
DROP RULE RG_patente_patron;


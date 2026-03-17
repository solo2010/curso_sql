--Crear y asociar reglas (create rule - sp_bindrule)
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    documento VARCHAR(8) NOT NULL,
    nombre VARCHAR(30),
    seccion VARCHAR(20),
    fechaingreso DATETIME,
    fechanacimiento DATETIME,
    hijos TINYINT,
    sueldo DECIMAL(6,2)
);

GO

-- Recuerde que las reglas son objetos independientes de las tablas (no se eliminan al 
-- borrar la tabla), así que debemos eliminarlas con las siguientes intrucciones:
IF OBJECT_ID('RG_documento_patron') IS NOT NULL
    DROP RULE RG_documento_patron;
IF OBJECT_ID('RG_empleado_seccion') IS NOT NULL
    DROP RULE RG_empleado_seccion;
IF OBJECT_ID('RG_empleados_fechaingreso') IS NOT NULL
    DROP RULE RG_empleados_fechaingreso;
IF OBJECT_ID('RG_hijos') IS NOT NULL
    DROP RULE RG_hijos;
IF OBJECT_ID('RG_empleados_sueldo') IS NOT NULL
    DROP RULE RG_empleados_sueldo;
IF OBJECT_ID('RG_empleados_sueldo2') IS NOT NULL
    DROP RULE RG_empleados_sueldo2;

GO

INSERT INTO empleados VALUES('22222222','Ana Acosta','Contaduria','1990-10-10','1972-10-10',2,700);
INSERT INTO empleados VALUES('23333333','Carlos Costa','Contaduria','1990-12-10','1972-05-04',0,750);
INSERT INTO empleados VALUES('24444444','Daniel Duarte','Sistemas','1995-05-05','1975-10-06',1,880);
INSERT INTO empleados VALUES('25555555','Fabiola Fuentes','Secretaria','1998-02-11','1978-02-08',3,550);
INSERT INTO empleados VALUES('26666666','Gaston Garcia','Secretaria','1999-05-08','1981-01-01',3,670);
INSERT INTO empleados VALUES('27777777','Ines Irala','Gerencia','2000-04-10','1985-12-12',0,6000);

GO

-- Creamos una regla que establezca un patrón para el documento:
CREATE RULE RG_documento_patron
    AS @documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';

GO

-- Ejecutamos el procedimiento almacenado del sistema "sp_help" para 
-- ver si la regla creada anteriormente fue creada:
EXEC sp_help 'RG_documento_patron';

-- Ejecutamos el procedimiento almacenado del sistema "sp_helpconstraint" para ver si está asociada la regla
-- a algún campo de "empleados" (No aparece porque aún no la asociamos):
EXEC sp_helpconstraint empleados;

-- Si ingresamos un registro con un documento que no cumpla la regla, SQL Server lo acepta porque la regla
-- aún no está asociada al campo:
SELECT * FROM empleados;
INSERT INTO empleados VALUES('E2525E9G', 'Flor Cecilia', 'Sistemas', '2026-03-09', '2000-12-09', 2, 1000);

-- Asociamos la regla "RG_documento_patron" al campo "documento":
EXEC sp_bindrule RG_documento_patron, 'empleados.documento';

---- Volvemos a ejecutar "sp_helpconstraint" (aparece la regla):
EXEC sp_helpconstraint empleados;

GO

---- Creamos una regla para restringir los valores que se pueden ingresar en un campo "seccion":
CREATE RULE RG_empleados_seccion
    AS @seccion IN ('Secretaria', 'Contaduria', 'Sistemas', 'Gerencia');

GO

-- La asociamos al campo "seccion":
EXEC sp_bindrule RG_empleados_seccion, 'empleados.seccion';

GO

-- Creamos una regla para restringir los valores que se pueden ingresar en el campo "fechaingreso",
-- para que no sea posterior a la fecha actual:
CREATE RULE RG_empleados_fechaingreso
    AS @fecha <= getdate();

GO

-- Asociamos la regla anteriormente creada a los campos "fechaingreso" y "fechanacimiento":
EXEC sp_bindrule RG_empleados_fechaingreso, 'empleados.fechaingreso';
EXEC sp_bindrule RG_empleados_fechaingreso, 'empleados.fechanacimiento';

GO

-- Creamos una regla para restringir los valores que se pueden ingresar en el campo "hijos":
CREATE RULE RG_hijos
    AS @hijos BETWEEN 0 AND 20;

GO

-- La asociamos al campo "hijos":
EXEC sp_bindrule RG_hijos, 'empleados.hijos';

GO

-- Creamos una regla para restringir los valores que se pueden ingresar en un campo "sueldo":
CREATE RULE RG_sueldo
    AS @sueldo > 0 AND @sueldo <= 5000;

GO

-- La asociamos al campo "sueldo":
EXEC sp_bindrule RG_sueldo, 'empleados.sueldo';

GO

-- Creamos otra regla para restringir los valores que se pueden ingresar en un campo "sueldo":
CREATE RULE RG_empleados_sueldo2
    AS @sueldo > 0 AND @sueldo <= 7000;

GO

-- La asociamos al campo "sueldo" (la nueva regla reeemplaza la asociación anterior):
EXEC sp_bindrule RG_empleados_sueldo2, 'empleados.sueldo';

--Ejercicio
IF OBJECT_ID('vehiculos') IS NOT NULL
    DROP TABLE vehiculos;

IF OBJECT_ID('RG_patente_patron') IS NOT NULL
    DROP RULE RG_patente_patron;
IF OBJECT_ID('RG_horallegada') IS NOT NULL
    DROP RULE RG_horallegada;
IF OBJECT_ID('RG_vehiculos_tipo') IS NOT NULL
    DROP RULE RG_vehiculos_tipo;
IF OBJECT_ID('RG_vehiculos_tipo2') IS NOT NULL
    DROP RULE RG_vehiculos_tipo2;
IF OBJECT_ID('RG_menor_fechaactual') IS NOT NULL
    DROP RULE RG_menor_fechaactual;

CREATE TABLE vehiculos(
    patente CHAR(6) NOT NULL,
    tipo CHAR(1), --a=auto m=moto
    horallegada DATETIME NOT NULL,
    horasalida DATETIME
);

GO

INSERT INTO vehiculos VALUES ('AAA111','a','1990-02-01 08:10',null);
INSERT INTO vehiculos VALUES ('BCD222','m','1990-02-01 08:10','1990-02-01 10:10');
INSERT INTO vehiculos VALUES ('BCD222','m','1990-02-01 12:00',null);
INSERT INTO vehiculos VALUES ('CC1234','a','1990-02-01 12:00',null);

GO
--Cree una regla para restringir los valores que se pueden ingresar en un campo "patente" (3 letras 
--seguidas de 3 dígitos):
CREATE RULE RG_patente_patron 
    AS @patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]';

GO

EXEC sp_help;

--Ejecute el procedimiento almacenado del sistema "sp_helpconstraint" para ver que la regla creada 
--anteriormente no está asociada aún a ningún campo de la tabla "vehiculos".
EXEC sp_helpconstraint vehiculos;

--Asocie la regla al campo "patente":
--Note que hay una patente que no cumple la regla, SQL Server NO controla los datos existentes, pero 
--si controla las inserciones y actualizaciones:
EXEC sp_bindrule RG_patente_patron, 'vehiculos.patente';

--Intente ingresar un registro con valor para el campo "patente" que no cumpla con la regla.
--aparece un mensaje de error indicando que hay conflicto con la regla y la inserción no se realiza.
INSERT INTO vehiculos VALUES('A2D6F5', 'm', '2026-03-01 11:32', NULL);

--Cree otra regla que controle los valores para el campo "tipo" para que solamente puedan 
--ingresarse los caracteres "a" y "m".

GO 

CREATE RULE RG_vehiculos_tipo
    AS @vehiculo IN('m', 'a');

GO

-- Asocie la regla al campo "tipo".
EXEC sp_bindrule RG_vehiculos_tipo, 'vehiculos.tipo';

--Intente actualizar un registro cambiando el valor de "tipo" a un valor que no cumpla con la 
--regla anterior.
UPDATE vehiculos SET tipo = 'p' WHERE patente = 'AAA111';

--Cree otra regla llamada "RG_vehiculos_tipo2" que controle los valores para el campo "tipo" para 
--que solamente puedan ingresarse los caracteres "a", "c" y "m".
GO

CREATE RULE RG_vehiculos_tipo2
    AS @tipo IN ('a', 'c', 'm');

GO

--Si la asociamos a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la 
--asociación anterior. Asocie la regla creada en el punto anterior al campo "tipo".
EXEC sp_bindrule RG_vehiculos_tipo2, 'vehiculos.tipo';

--Actualice el registro que no pudo actualizar en el punto 12:
UPDATE vehiculos SET tipo = 'c' WHERE patente = 'AAA111';
SELECT * FROM vehiculos;

--Cree una regla que permita fechas menores o iguales a la actual.
GO

CREATE RULE RG_menor_fechaactual
    AS @fecha <= GETDATE();

GO

--Asocie la regla anterior a los campos "horallegada" y "horasalida":
EXEC sp_bindrule RG_menor_fechaactual, 'vehiculos.horallegada';
EXEC sp_bindrule RG_menor_fechaactual, 'vehiculos.horasalida';

--Ingrese un registro en el cual la hora de entrada sea posterior a la hora de salida:
INSERT INTO vehiculos VALUES('NAA613', 'm', '2026-03-13 07:40', '2026-03-13 07:00');
SELECT * FROM vehiculos;

--Intente establecer una restricción "check" que asegure que la fecha y hora de llegada a la playa
--No lo permite porque hay un registro que no cumple la restricción.
ALTER TABLE vehiculos
    ADD CONSTRAINT CK_vehiculos_llegada_salida
    CHECK (horasalida >= horallegada);

--Elimine dicho registro:
DELETE FROM vehiculos WHERE patente = 'NAA613';

--Establezca la restricción "check" que no pudo establecer en el punto 19:
ALTER TABLE vehiculos
    ADD CONSTRAINT CK_vehiculos_llegada_salida
    CHECK (horasalida >= horallegada);

--Cree una restricción "default" que almacene el valor "b" en el campo "tipo:
ALTER TABLE vehiculos
    ADD CONSTRAINT DF_vehiculo_tipo
    DEFAULT 'b'
    FOR tipo;
--Note que esta restricción va contra la regla asociada al campo "tipo" que solamente permite los 
--valores "a", "c" y "m". SQL Server no informa el conflicto hasta que no intenta ingresar el valor 
--por defecto.

--Intente ingresar un registro con el valor por defecto para el campo "tipo":
INSERT INTO vehiculos VALUES('YHI444', DEFAULT, GETDATE(), NULL);

--Vea las reglas asociadas a "vehiculos" y las restricciones aplicadas a la misma tabla ejecutando 
EXEC sp_helpconstraint vehiculos;
--Valores predeterminados (create default)

IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

IF OBJECT_ID('VP_cero') IS NOT NULL
    DROP DEFAULT VP_cero;

 IF OBJECT_ID('VP_100') IS NOT NULL
    DROP DEFAULT VP_100;

IF OBJECT_ID('VP_datodesconocido') IS NOT NULL
    DROP DEFAULT VP_datodesconocido;

IF OBJECT_ID('VP_telefono') IS NOT NULL
    DROP DEFAULT VP_telefono;

CREATE TABLE empleados(
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    barrio VARCHAR(15),
    telefono CHAR(14),
    sueldo DECIMAL(6,2)
);

GO

INSERT INTO empleados DEFAULT VALUES;

SELECT * FROM empleados;

GO

-- Creamos un valor predeterminado con el valor "Desconocido":
CREATE DEFAULT VP_datodesconocido AS 'Desconocido';

GO

-- Lo asociamos al campo "domicilio":
EXEC sp_bindefault VP_datodesconocido, 'empleados.domicilio';

-- Lo asociamos al campo "barrio":
EXEC sp_bindefault VP_datodesconocido, 'empleados.barrio';


INSERT INTO empleados DEFAULT VALUES;

SELECT * FROM empleados;

GO

-- Creamos un valor predeterminado que inserta el valor "0":
CREATE DEFAULT VP_cero
    AS 0;

GO

-- Lo asociamos al campo "sueldo":
EXEC sp_bindefault VP_cero, 'empleados.sueldo';

INSERT INTO empleados DEFAULT VALUES;

SELECT * FROM empleados;

GO
-- Creamos un valor predeterminado que inserta el valor "100":
CREATE DEFAULT VP_100
    AS 100;

GO

-- Lo asociamos al campo "sueldo"
-- Recuerde que si asociamos a un campo que ya tiene asociado un valor
-- predeterminado otro valor predeterminado, la nueva asociación reemplaza a la anterior 
EXEC sp_bindefault VP_100, 'empleados.sueldo';

INSERT INTO empleados DEFAULT VALUES;

SELECT * FROM empleados;

EXEC sp_helpconstraint empleados;

EXEC sp_help;

GO

-- Creamos un valor predeterminado que inserta ceros con el formato válido
-- para un campo número de teléfono:

CREATE DEFAULT VP_telefono
    AS '(0000)0-000000';

GO

-- La asociamos al campo "telefono" de la tabla "empleados":
EXEC sp_bindefault VP_telefono, 'empleados.telefono';

INSERT INTO empleados DEFAULT VALUES;

SELECT * FROM empleados;

EXEC sp_helpconstraint empleados;

--Ejercicio 1
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

IF OBJECT_ID('VP_legajo_patron') IS NOT NULL
    DROP DEFAULT VP_legajo_patron;

IF OBJECT_ID('RG_legajo_patron') IS NOT NULL
    DROP RULE RG_legajo_patron;

IF OBJECT_ID('RG_legajo') IS NOT NULL
    DROP RULE RG_legajo;

IF OBJECT_ID('VP_datodesconocido') IS NOT NULL
    DROP DEFAULT VP_datodesconocido;

IF OBJECT_ID('VP_fechaactual') IS NOT NULL
    DROP DEFAULT VP_fechaactual;

CREATE TABLE clientes(
    legajo CHAR(4),
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    ciudad VARCHAR(15),
    provincia VARCHAR(20) DEFAULT 'Cordoba',
    fechaingreso DATETIME
);

--Cree una regla para establecer un patrón para los valores que se ingresen en el campo "legajo" (2 
--letras seguido de 2 cifras) llamada "RG_legajo_patron":
GO
CREATE RULE RG_legajo_patron
    AS @legajo LIKE '[A-Z][A-Z][0-9][0-9]';
GO

--Asocie la regla al campo "legajo".
EXEC sp_bindrule RG_legajo_patron, 'clientes.legajo';

--Cree un valor predeterminado para el campo "legajo" ('AA00') llamado "VP_legajo_patron".
GO
CREATE DEFAULT VP_legajo_patron
    AS 'AA00';
GO

--Asócielo al campo "legajo".
EXEC sp_bindefault VP_legajo_patron, 'clientes.legajo';

--Cree un valor predeterminado con la cadena "??" llamado "VP_datodesconocido".
GO
CREATE DEFAULT VP_datodesconocido
    AS '??';
GO

--Asócielo al campo "domicilio".
EXEC sp_bindefault VP_datodesconocido, 'clientes.domicilio';

--Asócielo al campo "ciudad".
--Recuerde que un valor predeterminado puede asociarse a varios campos.
EXEC sp_bindefault VP_datodesconocido, 'clientes.ciudad';

--Ingrese un registro con valores por defecto para los campos "domicilio" y "ciudad" y vea qué 
--almacenaron.
INSERT INTO clientes DEFAULT VALUES;
SELECT * FROM clientes;

--Intente asociar el valor predeterminado "VP_datodesconocido" al campo "provincia".
--No se puede porque dicho campo tiene una restricción "default".
EXEC sp_bindefault VP_datodesconocido, 'clientes.provincia';

--Cree un valor predeterminado con la fecha actual llamado "VP_fechaactual".
GO
CREATE DEFAULT VP_fechaactual
    AS GETDATE();
GO

EXEC sp_bindefault VP_fechaactual, 'clientes.fechaingreso';

INSERT INTO clientes DEFAULT VALUES;

SELECT * FROM clientes;

--Asocie el valor predeterminado "VP_datodesconocido" al campo "fechaingreso".
--Note que se asoció un valor predeterminado de tipo caracter a un campo de tipo "datetime"; SQL 
--Server lo permite, pero al intentar ingresar el valor aparece un mensaje de error.
EXEC sp_bindefault VP_datodesconocido, 'clientes.fechaingreso';

-- Ingrese un registro con valores por defecto.
--No lo permite porque son de distintos tipos.
INSERT INTO clientes DEFAULT VALUES;

--Cree una regla que entre en conflicto con el valor predeterminado "VP_legajo_patron".
GO
CREATE RULE RG_legajo_patron2
    AS @legajo LIKE '[A-Z][0-9][A-Z][0-9]';
GO

--Asocie la regla al campo "legajo".
--Note que la regla especifica que el campo "legajo" debe comenzar con la letra "B", pero el valor 
--predeterminado tiene el valor "AA00"; SQL Server realiza la asociación, pero al intentar ingresar el 
--valor predeterminado, no puede hacerlo y muestra un mensaje de error.
EXEC sp_bindrule RG_legajo_patron2, 'clientes.legajo';

--Intente ingresar un registro con el valor "default" para el campo "legajo".
--No lo permite porque al intentar ingresar el valor por defecto establecido con el valor 
--predeterminado entra en conflicto con la regla "RG_legajo".
INSERT INTO clientes DEFAULT VALUES;



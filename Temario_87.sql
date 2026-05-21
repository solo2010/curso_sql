--Tipo de dato definido por el usuario (crear - informacion)
IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

IF EXISTS (SELECT * FROM systypes WHERE name = 'tipo_documento')
    EXEC sp_droptype tipo_documento;

EXEC sp_addtype tipo_documento, 'CHAR(8)', 'NULL';

EXEC sp_help tipo_documento;

CREATE TABLE alumnos(
    documento tipo_documento,
    nombre VARCHAR(30)
);

GO

INSERT INTO alumnos VALUES('12345678','Ana Acosta');

SELECT * FROM alumnos;

--Ejercicio
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

IF EXISTS (SELECT name FROM systypes
    WHERE name = 'tipo_legajo')
    EXEC sp_droptype tipo_legajo;

--Cree un tipo de dato definido por el usuario llamado "tipo_legajo" basado en el tipo "char" de 4 
--caracteres que no permita valores nulos.
EXEC sp_addtype tipo_legajo, 'CHAR(4)', 'NOT NULL';

--Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
--anteriormente para obtener información del mismo.
EXEC sp_help tipo_legajo;

--Cree la tabla "empleados" con 3 campos: legajo (tipo_legajo), documento (char de 8) y nombre (30 
--caracteres):
CREATE TABLE empleados(
    legajo tipo_legajo,
    document CHAR(8),
    nombre VARCHAR(30)
);

--Intente ingresar un registro con valores por defecto:
--No se puede porque el campo "tipo_legajo" no admite valores nulos y no tiene definido un valor por 
--defecto.
INSERT INTO empleados DEFAULT VALUES;

-- Ingrese un registro con valores válidos.
SELECT * FROM empleados;
INSERT INTO empleados VALUES(4, '80546578', 'Daniel Lopez');



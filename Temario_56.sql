--Información de reglas (sp_help - sp_helpconstraint)
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

IF OBJECT_ID('RG_sueldo') IS NOT NULL
    DROP RULE RG_sueldo;

IF OBJECT_ID('RG_seccion_lista') IS NOT NULL
    DROP RULE RG_seccion_lista;

CREATE TABLE empleados(
    documento CHAR(8) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    seccion VARCHAR(20),
    sueldo DECIMAL(6,2),
    PRIMARY KEY(documento)
);

GO

-- Creamos una regla para el campo "sueldo": 
CREATE RULE RG_sueldo
    AS @sueldo BETWEEN 100 AND 1000;

GO

-- Asociamos la regla creada anteriormente al campo "sueldo":
EXEC sp_bindrule RG_sueldo, 'empleados.sueldo';

GO

-- Creamos una regla con una lista de valores para "seccion":
CREATE RULE RG_seccion_lista
    AS @seccion IN ('Sistemas', 'Secretaria', 'Contaduria');

GO

EXEC sp_help RG_sueldo;

EXEC sp_helpconstraint empleados;

EXEC sp_bindrule RG_seccion_lista, 'empleados.seccion';

EXEC sp_helpconstraint empleados;

EXEC sp_helptext RG_seccion_lista;

-- Deshacemos la asociación de la regla "RG_sueldo" y la eliminamos:
EXEC sp_unbindrule 'empleados.sueldo';
DROP RULE RG_sueldo;

EXEC sp_help RG_sueldo;

SELECT * FROM sysobjects WHERE xtype = 'R' AND name LIKE '%seccion%';
SELECT * FROM sysobjects;
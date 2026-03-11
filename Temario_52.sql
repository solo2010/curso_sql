--Información de restricciones (sp_helpconstraint)
IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE alumnos(
    legajo CHAR(4) NOT NULL,
    apellido VARCHAR(20),
    nombre VARCHAR(20),
    documento CHAR(8),
    domicilio VARCHAR(30),
    ciudad VARCHAR(30),
    notafinal DECIMAL(4,2)
);

GO
-- Agregamos una restricción "primary" para el campo "legajo":
ALTER TABLE alumnos
    ADD CONSTRAINT PK_alumnos_legajo
    PRIMARY KEY(legajo);

-- Agregamos una restricción "unique" para el campo "documento"
ALTER TABLE alumnos
    ADD CONSTRAINT UQ_alumnos_documento
    UNIQUE (documento);

-- Agregamos una restricción "check" para que el campo "notafinal" 
-- admita solamente valores entre 0 y 10:
ALTER TABLE alumnos
    ADD CONSTRAINT CK_alumnos_notafinal
    CHECK (notafinal >=0 OR notafinal <= 10);


-- Agregamos una restricción "default" para el campo "ciudad":
ALTER TABLE alumnos
    ADD CONSTRAINT DF_aluumnos_ciudad
    DEFAULT 'Cordoba'
    FOR ciudad;
    
 -- Veamos las restricciones:
 EXEC sp_helpconstraint alumnos;

 -- Deshabilitamos la restricción "check":
 ALTER TABLE alumnos
    NOCHECK CONSTRAINT CK_alumnos_notafinal;

-- Veamos las restricciones:
EXEC sp_helpconstraint alumnos;
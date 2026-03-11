IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE alumnos(
    legajo CHAR(4) NOT NULL,
    apellido VARCHAR(20),
    nombre VARCHAR(20),
    documento CHAR(8)
);

GO

-- Agregamos una restricción "primary" para el campo "legajo":
ALTER TABLE alumnos
    ADD CONSTRAINT PK_alumnos_legajo
    PRIMARY KEY(legajo);


-- Agregamos una restricción "unique" para el campo "documento":
ALTER TABLE alumnos
    ADD CONSTRAINT UQ_alumnos_documento
    UNIQUE (documento);

INSERT INTO alumnos VALUES('A111','Lopez','Ana','22222222');
INSERT INTO alumnos VALUES('A123','Garcia','Maria','23333333');

SELECT * FROM alumnos;

--Ejercicio 1
IF OBJECT_ID('remis') IS NOT NULL
    DROP TABLE remis

CREATE TABLE remis(
    numero TINYINT IDENTITY,
    patente CHAR(6),
    marca VARCHAR(15),
    modelo CHAR(4)
);

GO

INSERT INTO remis VALUES('ABC123','Renault clio','1990');
INSERT INTO remis VALUES('DEF456','Peugeot 504','1995');
INSERT INTO remis VALUES('DEF456','Fiat Duna','1998');
INSERT INTO remis VALUES('GHI789','Fiat Duna','1995');
INSERT INTO remis VALUES(NULL,'Fiat Duna','1995');

--Intente agregar una restricción "unique" para asegurarse que la patente del remis no tomará 
--valores repetidos. No se puede porque hay valores duplicados.
ALTER TABLE remis
    ADD CONSTRAINT UQ_remis_patente
    UNIQUE (patente);

--Elimine el registro con patente duplicada y establezca la restricción.
--Note que hay 1 registro con valor nulo en "patente".
SELECT * FROM remis;

DELETE FROM remis WHERE numero = 3;

ALTER TABLE remis
    ADD CONSTRAINT UQ_remis_patente
    UNIQUE (patente);

--Intente ingresar un registro con patente repetida (no lo permite)
INSERT INTO remis VALUES('ABC123', 'Meteor 350', 2026);

--Intente ingresar un registro con valor nulo para el campo "patente"
INSERT INTO remis VALUES(NULL, 'Meteor 350', 2026);

--Muestre la información de las restricciones:
EXEC sp_helpconstraint remis;
--Clave primaria compuesta
IF OBJECT_ID('vehiculos') IS NOT NULL
    DROP TABLE vehiculos;

CREATE TABLE vehiculos(
    patente CHAR(6) NOT NULL,
    tipo CHAR(1), --a = autor, m = moto
    horallegada DATETIME,
    horasalida DATETIME,
    PRIMARY KEY(patente, horallegada)
);

GO

insert into vehiculos values('AIC124','a','8:05','12:30');
insert into vehiculos values('CAA258','a','8:05',null);
insert into vehiculos values('DSE367','m','8:30','18:00');
insert into vehiculos values('FGT458','a','9:00',null);
insert into vehiculos values('AIC124','a','16:00',null);
insert into vehiculos values('LOI587','m','18:05','19:55');

-- Si intentamos ingresar un registro con clave primaria repetida:
INSERT INTO vehiculos VALUES('L0I587', 'm', '18:05', NULL);

-- Si ingresamos un registro repitiendo el valor de uno de los campos
-- que forman parte de la clave, si lo acepta:
INSERT INTO vehiculos VALUES('NAA61F', 'm', '16:00', NULL);

-- Si intentamos actualizar un registro repitiendo la clave primaria
-- (se genera un error):
SELECT * FROM vehiculos;
UPDATE vehiculos SET horallegada = '08:05'
    WHERE patente = 'AIC124' AND horallegada = '16:00';

-- Recordemos que los campos que forman parte de la clave primaria no 
-- aceptan valores nulos, aunque no se haya aclarado en la definición 
-- de la tabla (genera un error):
INSERT INTO vehiculos VALUES(NULL, 'm', '19:00', '23:00');

EXEC sp_columns vehiculos;

--Ejercicio 1
IF OBJECT_ID('consultas') IS NOT NULL
    DROP TABLE consultas;

/*
  - La tabla contiene los siguientes datos:
  - fechayhora: datetime not null, fecha y hora de la consulta,
  - medico: varchar(30), not null, nombre del médico (Perez,Lopez,Duarte),
  - documento: char(8) not null, documento del paciente,
  - paciente: varchar(30), nombre del paciente,
  - obrasocial: varchar(30), nombre de la obra social (IPAM,PAMI, etc.).
*/

CREATE TABLE consultas(
    fechayhora DATETIME NOT NULL,
    medico VARCHAR(30) NOT NULL,
    documento CHAR(8) NOT NULL,
    paciente VARCHAR(30),
    obrasocial VARCHAR(30),
    PRIMARY KEY(fechayhora, medico)
);


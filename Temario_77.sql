--Restricciones foreign key en la misma tabla

IF OBJECT_ID('afiliados') IS NOT NULL
    DROP TABLE afiliados;

CREATE TABLE afiliados(
    numero INT IDENTITY NOT NULL,
    documento CHAR(8) NOT NULL,
    nombre VARCHAR(30),
    afiliadotitular INT,
    PRIMARY KEY(documento),
    UNIQUE (numero)
);

GO

ALTER TABLE afiliados
    ADD CONSTRAINT FK_afiliados_afiliadotitular
    FOREIGN KEY(afiliadotitular)
    REFERENCES afiliados(numero);

INSERT INTO afiliados VALUES('22222222','Perez Juan',NULL);
INSERT INTO afiliados VALUES('23333333','Garcia Maria',NULL);
INSERT INTO afiliados VALUES('24444444','Lopez Susana',NULL);
INSERT INTO afiliados VALUES('30000000','Perez Marcela',1);
INSERT INTO afiliados VALUES('31111111','Morales Luis',1);
INSERT INTO afiliados VALUES('32222222','Garcia Maria',2);

DELETE FROM afiliados WHERE numero = 5;
DELETE FROM afiliados WHERE numero = 1;

EXEC sp_helpconstraint afiliados;

--Ejercicio
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

CREATE TABLE clientes(
    codigo INT NOT NULL,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    ciudad VARCHAR(20),
    referenciadopor INT,
    PRIMARY KEY(codigo)
);

GO

 INSERT INTO clientes VALUES(50,'Juan Perez','Sucre 123','Cordoba',NULL);
 INSERT INTO clientes VALUES(90,'Marta Juarez','Colon 345','Carlos Paz',NULL);
 INSERT INTO clientes VALUES(110,'Fabian Torres','San Martin 987','Cordoba',50);
 INSERT INTO clientes VALUES(125,'Susana Garcia','Colon 122','Carlos Paz',90);
 INSERT INTO clientes VALUES(140,'Ana Herrero','Colon 890','Carlos Paz',9);


--Intente agregar una restricción "foreign key" para evitar que en el campo "referenciadopor" se 
--ingrese un valor de código de cliente que no exista.
--No se permite porque existe un registro que no cumple con la restricción que se intenta establecer.
ALTER TABLE clientes
    ADD CONSTRAINT FK_clientes_referenciadopor
    FOREIGN KEY (referenciadopor)
    REFERENCES clientes(codigo);

--Cambie el valor inválido de "referenciadopor" del registro que viola la restricción por uno 
--válido.
SELECT * FROM clientes;
UPDATE clientes SET referenciadopor = 110 WHERE codigo = 140;;

--Agregue la restricción "foreign key" que intentó agregar en el punto 3.
ALTER TABLE clientes
     ADD CONSTRAINT FK_clientes_referenciadopor
     FOREIGN KEY (referenciadopor)
     REFERENCES clientes(codigo);

--Vea la información referente a las restricciones de la tabla "clientes".
EXEC sp_helpconstraint clientes;

--Intente agregar un registro que infrinja la restricción.
--No lo permite.
SELECT * FROM clientes
INSERT INTO clientes VALUES(100, 'Daniel Lopez', 'Barrio el Socorro', 'Caldas', 200);

--Intente modificar el código de un cliente que está referenciado en "referenciadopor".
--No se puede
UPDATE clientes SET codigo = 20 WHERE codigo = 50;

--Intente eliminar un cliente que sea referenciado por otro en "referenciadopor".
--No se puede.
DELETE clientes WHERE codigo = 50;

--Cambie el valor de código de un cliente que no referenció a nadie.
UPDATE clientes SET codigo = 200 WHERE codigo = 125;
SELECT * FROM clientes;

--Elimine un cliente que no haya referenciado a otros.
DELETE clientes WHERE codigo = 140;


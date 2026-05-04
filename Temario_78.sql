--Restricciones foreign key (acciones)
/*
Sintetizando, si al agregar una restricción foreign key:

- no se especifica acción para eliminaciones (o se especifica "no action"), y se intenta eliminar un registro de la tabla referenciada (editoriales) cuyo valor de clave primaria (codigo) existe en la tabla principal (libros), la acción no se realiza.


- se especifica "cascade" para eliminaciones ("on delete cascade") y elimina un registro de la tabla referenciada (editoriales) cuyo valor de clave primaria (codigo) existe en la tabla principal(libros), la eliminación de la tabla referenciada (editoriales) se realiza y se eliminan de la tabla principal (libros) todos los registros cuyo valor coincide con el registro eliminado de la tabla referenciada (editoriales).

- no se especifica acción para actualizaciones (o se especifica "no action"), y se intenta modificar un valor de clave primaria (codigo) de la tabla referenciada (editoriales) que existe en el campo clave foránea (codigoeditorial) de la tabla principal (libros), la acción no se realiza.

- se especifica "cascade" para actualizaciones ("on update cascade") y se modifica un valor de clave primaria (codigo) de la tabla referenciada (editoriales) que existe en la tabla principal (libros), SQL Server actualiza el registro de la tabla referenciada (editoriales) y todos los registros coincidentes en la tabla principal (libros).*/

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

CREATE TABLE libros(
    codigo INT NOT NULL,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    codigoeditorial TINYINT,
    PRIMARY KEY(codigo)
);

CREATE TABLE editoriales(
    codigo TINYINT NOT NULL,
    nombre VARCHAR(20),
    PRIMARY KEY(codigo)
);

GO

insert into editoriales values(1,'Emece');
insert into editoriales values(2,'Planeta');
insert into editoriales values(3,'Siglo XXI');

insert into libros values(1,'El aleph','Borges',1);
insert into libros values(2,'Martin Fierro','Jose Hernandez',2);
insert into libros values(3,'Aprenda PHP','Mario Molina',2);

-- Establecemos una restricción "foreign key" para evitar que se ingrese en "libros"
-- un código de editorial inexistente en "editoriales" con la opción "on cascade" 
-- para actualizaciones y eliminaciones:
ALTER TABLE libros
    ADD CONSTRAINT FK_libros_codigoeditorial
    FOREIGN KEY(codigoeditorial)
    REFERENCES editoriales(codigo)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

-- Si actualizamos un valor de código de "editoriales", la modificación se extiende a 
-- todos los registros de la tabla "libros" que hacen referencia a ella en "codigoeditorial":
--update editoriales set codigo=10 where codigo=1;
SELECT * FROM libros;
UPDATE editoriales SET codigo = 10 WHERE codigo = 1;
SELECT * FROM libros;

-- Si eliminamos una editorial, se borra tal editorial de "editoriales" 
-- y todos los registros de "libros" de dicha editorial:
DELETE FROM editoriales WHERE codigo = 2;
SELECT * FROM libros;

--Ejercicio 1
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
    DROP TABLE provincias;

CREATE TABLE clientes(
    codigo INT IDENTITY,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    ciudad VARCHAR(20),
    codigoprovincia TINYINT,
    PRIMARY KEY(codigo)
);

CREATE TABLE provincias(
    codigo TINYINT,
    nombre VARCHAR(20),
    PRIMARY KEY(codigo)
);

GO

 INSERT INTO provincias VALUES(1,'Cordoba');
 INSERT INTO provincias VALUES(2,'Santa Fe');
 INSERT INTO provincias VALUES(3,'Misiones');
 INSERT INTO provincias VALUES(4,'Rio Negro');

 INSERT INTO clientes VALUES('Perez Juan','San Martin 123','Carlos Paz',1);
 INSERT INTO clientes VALUES('Moreno Marcos','Colon 234','Rosario',2);
 INSERT INTO clientes VALUES('Acosta Ana','Avellaneda 333','Posadas',3);


 --Establezca una restricción "foreign key" especificando la acción "en cascade" para 
--actualizaciones y "no action" para eliminaciones.
 ALTER TABLE clientes
    ADD CONSTRAINT FK_clientes_codigoprovincias
    FOREIGN KEY (codigoprovincia)
    REFERENCES provincias(codigo)
    ON UPDATE CASCADE
    ON DELETE NO ACTION;

--Intente eliminar el registro con código 3, de "provincias".
--No se puede porque hay registros en "clientes" al cual hace referencia y la opción para 
--eliminaciones se estableció como "no action".
DELETE FROM provincias WHERE codigo = 3;

-- Modifique el registro con código 3, de "provincias".
UPDATE provincias SET codigo = 10 WHERE codigo = 3;

--Verifique que el cambio se realizó en cascada, es decir, que se modificó en la tabla "provincias" 
--y en "clientes":
SELECT * FROM clientes;
SELECT * FROM provincias;

--Intente modificar la restricción "foreign key" para que permita eliminación en cascada.
--Mensaje de error, no se pueden modificar las restricciones.
ALTER TABLE clientes
    ADD CONSTRAINT FK_clientes_codigoprovincias
    FOREIGN KEY (codigoprovincia)
    REFERENCES provincias(codigo)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

--Intente eliminar la tabla "provincias".
--No se puede eliminar porque una restricción "foreign key" hace referencia a ella.
DROP TABLE provincias;

--Ejercicio 2
IF OBJECT_ID('inscripciones') IS NOT NULL
    DROP TABLE inscripciones;

IF OBJECT_ID('deportes') IS NOT NULL
    DROP TABLE deportes;

IF OBJECT_ID('socios') IS NOT NULL
    DROP TABLE socios;

CREATE TABLE deportes(
    codigo TINYINT,
    nombre VARCHAR(20),
    PRIMARY KEY (codigo)
);

CREATE TABLE socios(
    documento CHAR(8),
    nombre VARCHAR(30),
    PRIMARY KEY(DOCUMENTO)
);

CREATE TABLE inscripciones(
    documento CHAR(8),
    codigodeporte TINYINT,
    matricula CHAR(1),-- 's' si está paga, 'n' si no está paga
    PRIMARY KEY(documento, codigodeporte)
);

--Establezca una restricción "foreign key" para "inscripciones" que haga referencia al campo 
--"codigo" de "deportes" que permita la actualización en cascada:
ALTER TABLE inscripciones
    ADD CONSTRAINT FK_inscripciones_codigodeporte
    FOREIGN KEY (codigodeporte)
    REFERENCES deportes(codigo)
    ON UPDATE CASCADE;

--Establezca una restricción "foreign key" para "inscripciones" que haga referencia al campo 
--"documento" de "socios" que permita la eliminación en cascada (Recuerde que se pueden establecer 
--varias retricciones "foreign key" a una tabla):
ALTER TABLE inscripciones
    ADD CONSTRAINT FK_inscripciones_documento
    FOREIGN KEY (documento)
    REFERENCES socios(documento)
    ON DELETE CASCADE;

--Ingrese algunos registros en las tablas:
 INSERT INTO deportes VALUES(1,'basquet');
 INSERT INTO deportes VALUES(2,'futbol');
 INSERT INTO deportes VALUES(3,'natacion');
 INSERT INTO deportes VALUES(4,'tenis');

 INSERT INTO socios VALUES('30000111','Juan Lopez');
 INSERT INTO socios VALUES('31111222','Ana Garcia');
 INSERT INTO socios VALUES('32222333','Mario Molina');
 INSERT INTO socios VALUES('33333444','Julieta Herrero');

 INSERT INTO inscripciones VALUES('30000111',1,'s');
 INSERT INTO inscripciones VALUES('30000111',2,'s');
 INSERT INTO inscripciones VALUES('31111222',1,'s');
 INSERT INTO inscripciones VALUES('32222333',3,'n');

 --Intente ingresar una inscripción con un código de deporte inexistente:
 INSERT INTO inscripciones VALUES('30000111',6,'s');
--Mensaje de error.

--Intente ingresar una inscripción con un documento inexistente en "socios":
--Mensaje de error.
INSERT INTO inscripciones VALUES('32525395', 1, 's'); 

--Elimine un registro de "deportes" que no tenga inscriptos:
--Se elimina porque no hay inscriptos en dicho deporte.
SELECT * FROM deportes;
SELECT * FROM inscripciones;
DELETE FROM deportes WHERE codigo = 4;
SELECT * FROM deportes;

--Intente eliminar un deporte para los cuales haya inscriptos:
--No se puede porque al no especificarse acción para eliminaciones, por defecto es "no action" y hay 
--inscriptos en dicho deporte.
SELECT * FROM deportes;
SELECT * FROM inscripciones;
DELETE FROM deportes WHERE codigo = 1;

--Modifique el código de un deporte para los cuales haya inscriptos.
--La opción para actualizaciones se estableció en cascada, se modifica el código en "deportes" y en 
--"inscripciones".
UPDATE deportes SET codigo = 10 WHERE codigo = 1;
SELECT * FROM inscripciones;


--Elimine el socio que esté inscripto en algún deporte.
--Se elimina dicho socio de "socios" y la acción se extiende a la tabla "inscripciones".
SELECT * FROM socios;
SELECT * FROM inscripciones;
DELETE FROM socios WHERE documento = 33333444;

--Modifique el documento de un socio que esté inscripto.
--No se puede porque la acción es "no action" para actualizaciones.
UPDATE socios SET documento =32525395 WHERE documento = 31111222;

--Intente eliminar la tabla "deportes":
--No se puede porque una restricción "foreign key" hace referencia a ella.
DROP TABLE deportes;

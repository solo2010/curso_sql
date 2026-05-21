--Restricciones foreign key deshabilitar y eliminar (with check - nocheck)
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

CREATE TABLE libros(
    codigo INT NOT NULL,
    titulo VARCHAR(40),
    autor VARCHAR(40),
    codigoeditorial TINYINT,
    PRIMARY KEY(codigo)
);

CREATE TABLE editoriales(
    codigo TINYINT NOT NULL,
    nombre VARCHAR(20),
    PRIMARY KEY(codigo)
);

GO

INSERT INTO editoriales VALUES(1,'Planeta');
INSERT INTO editoriales VALUES(2,'Emece');
INSERT INTO editoriales VALUES(3,'Paidos');

INSERT INTO libros VALUES(1,'Uno','Richard Bach',1);
INSERT INTO libros VALUES(2,'El aleph','Borges',2);
INSERT INTO libros VALUES(3,'Aprenda PHP','Mario Molina',5);

-- Agregamos una restricción "foreign key" a la tabla "libros" para evitar que se ingresen 
-- códigos de editoriales inexistentes en "editoriales".
-- Incluimos la opción "with nocheck" para evitar la comprobación de la restricción en los
-- datos existentes (note que hay un libro que tiene un código de editorial inválido):
ALTER TABLE libros
    WITH NOCHECK
    ADD CONSTRAINT FK_libros_codigo_editorial
    FOREIGN KEY (codigoeditorial)
    REFERENCES editoriales(codigo);

-- Para poder ingresar, modificar o eliminar datos a una tabla sin que SQL Server 
-- compruebe la restricción debemos deshabilitarla:
ALTER TABLE libros
    NOCHECK CONSTRAINT FK_libros_codigo_editorial;

-- Veamos si la restricción está habilitada o no:
EXEC sp_helpconstraint libros;

-- Veamos las restricciones de "editoriales":
EXEC sp_helpconstraint editoriales;

-- Ahora podemos ingresar un registro en "libros" con código inválido:
SELECT * FROM editoriales;
SELECT * FROM libros;
INSERT INTO libros VALUES(4, 'El pistolero', 'Stephen King', 10);

-- También podemos modificar
UPDATE editoriales SET codigo = 20 WHERE codigo = 1;


-- También realizar eliminaciones:
DELETE editoriales WHERE codigo = 2;
SELECT * FROM editoriales;

-- Habilitamos la restricción:
ALTER TABLE libros
    CHECK CONSTRAINT FK_libros_codigo_editorial;

-- Veamos si la restricción está habilitada o no:
EXEC sp_helpconstraint libros;

-- Eliminamos la restricción:
ALTER TABLE libros
    DROP CONSTRAINT FK_libros_codigo_editorial;

EXEC sp_helpconstraint libros;
EXEC sp_helpconstraint editoriales;

--Ejercicio
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
 INSERT INTO clientes VALUES('Garcia Juan','Sucre 345','Cordoba',1);
 INSERT INTO clientes VALUES('Lopez Susana','Caseros 998','Posadas',3);
 INSERT INTO clientes VALUES('Marcelo Moreno','Peru 876','Viedma',4);
 INSERT INTO clientes VALUES('Lopez Sergio','Avellaneda 333','La Plata',5);

 --Intente agregar una restricción "foreign key" para que los códigos de provincia de "clientes" 
--existan en "provincias" con acción en cascada para actualizaciones y eliminaciones, sin especificar 
--la opción de comprobación de datos:
--No se puede porque al no especificar opción para la comprobación de datos, por defecto es "check" y 
--hay un registro que no cumple con la restricción.
ALTER TABLE clientes
    ADD CONSTRAINT FK_clientes_codigoprovincia
    FOREIGN KEY (codigoprovincia)
    REFERENCES provincias(codigo)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

--Agregue la restricción anterior pero deshabilitando la comprobación de datos existentes:
ALTER TABLE clientes
    WITH NOCHECK
    ADD CONSTRAINT FK_clientes_codigoprovincia
    FOREIGN KEY(codigoprovincia)
    REFERENCES provincias(codigo)
    ON UPDATE CASCADE
    ON DELETE CASCADE;


--Vea las restricciones de "clientes"
EXEC sp_helpconstraint clientes;

--Vea las restricciones de "provincias":
EXEC sp_helpconstraint provincias;
SELECT * FROM clientes;
SELECT * FROM provincias;

--Deshabilite la restricción "foreign key" de "clientes":
ALTER TABLE clientes
    NOCHECK CONSTRAINT FK_clientes_codigoprovincia;

--Agregue un registro que no cumpla la restricción "foreign key":
INSERT INTO clientes VALUES('Daniel Lopez Marin', 'Barrio el Socorro', 'Caldas', 25);

--Elimine una provincia de las cuales haya clientes:
SELECT * FROM clientes;
SELECT * FROM provincias;
DELETE clientes WHERE codigo = 1;

--Modifique un código de provincia de la cual haya clientes:
SELECT * FROM provincias;
UPDATE provincias SET codigo = 30 WHERE codigo = 1;

--Intente eliminar la tabla "provincias"
--No se puede porque la restricción "FK_clientes_codigoprovincia" la referencia, aunque esté deshabilitada.
DROP TABLE provincias;

-- Habilite la restricción "foreign key":
ALTER TABLE clientes
    CHECK CONSTRAINT FK_clientes_codigoprovincia;

--Intente agregar un cliente con código de provincia inexistente en "provincias". No se puede.
INSERT INTO clientes VALUES('Geny Marcela', 'La Santa Ines', 'Caldas', 25);

--Modifique un código de provincia al cual se haga referencia en "clientes": Actualización en cascada.
UPDATE provincias SET codigo = 100 WHERE codigo = 2;
SELECT * FROM clientes;

--Elimine una provincia de la cual haya referencia en "clientes": Acción en cascada.
DELETE provincias WHERE codigo = 100;

--Elimine la restriccion "foreign key":
ALTER TABLE clientes
    DROP CONSTRAINT FK_clientes_codigoprovincia;

--Vea las restriciones de la tabla "provincias":
EXEC sp_helpconstraint provincias;

--Elimine la tabla "provincias":
DROP TABLE provincias;
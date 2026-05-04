IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    codigoeditorial TINYINT
);

CREATE TABLE editoriales(
    codigo TINYINT,
    nombre VARCHAR(20),
    PRIMARY KEY (codigo)
);

GO

INSERT INTO editoriales VALUES(1, 'Emece');
INSERT INTO editoriales VALUES(2, 'Planeta');
INSERT INTO editoriales VALUES(3, 'Siglo XXI');

INSERT INTO libros VALUES('El aleph','Borges',1);
INSERT INTO libros VALUES('Martin Fierro','Jose Hernandez',2);
INSERT INTO libros VALUES('Aprenda PHP','Mario Molina',2);

-- Agregamos una restricción "foreign key" a la tabla "libros":
ALTER TABLE libros
    ADD CONSTRAINT FK_libros_codigoeditorial
    FOREIGN KEY (codigoeditorial)
    REFERENCES editoriales(codigo);

INSERT INTO libros DEFAULT VALUES;

SELECT * FROM libros;

EXEC sp_helpconstraint libros;

EXEC sp_helpconstraint editoriales;

--Ejercicio 1
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
    DROP TABLE provincias;

CREATE TABLE clientes(
    codigo INT IDENTITY,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    ciudad VARCHAR(30),
    codigoprovincia TINYINT,
    PRIMARY KEY (codigo)
);

CREATE TABLE provincias(
    codigo TINYINT NOT NULL,
    nombre VARCHAR(20),
    PRIMARY KEY(codigo)
);

INSERT INTO provincias VALUES(1,'Cordoba');
INSERT INTO provincias VALUES(2,'Santa Fe');
INSERT INTO provincias VALUES(3,'Misiones');
INSERT INTO provincias VALUES(4,'Rio Negro');

INSERT INTO clientes VALUES('Perez Juan','San Martin 123','Carlos Paz',1);
INSERT INTO clientes VALUES('Moreno Marcos','Colon 234','Rosario',2);
INSERT INTO clientes VALUES('Acosta Ana','Avellaneda 333','Posadas',3);
INSERT INTO clientes VALUES('Luisa Lopez','Juarez 555','La Plata',6);

--Intente agregar una restricción "foreign key" a la tabla "clientes" que haga referencia al campo 
--"codigo" de "provincias":
ALTER TABLE clientes
    ADD CONSTRAINT FK_clientes_codigoprovincia
    FOREIGN KEY (codigoprovincia)
    REFERENCES provincias(codigo);

--Elimine el registro de "clientes" que no cumple con la restricción y establezca la restricción 
--nuevamente:
SELECT * FROM clientes;
DELETE FROM clientes WHERE codigo = 4;

ALTER TABLE clientes
    ADD CONSTRAINT FK_clientes_codigoprovincia
    FOREIGN KEY(codigoprovincia)
    REFERENCES provincias(codigo);


--Intente agregar un cliente con un código de provincia inexistente en "provincias".
--No se puede.
EXEC sp_columns clientes;
INSERT INTO clientes VALUES('Daniel Lopez', 'Carrera 51 El Socorro', 'Caldas', 8);

--Intente eliminar el registro con código 3, de "provincias".
--No se puede porque hay registros en "clientes" al cual hace referencia.
DELETE provincias WHERE codigo = 3;

--Elimine el registro con código "4" de "provincias".
--Se permite porque en "clientes" ningún registro hace referencia a él.
DELETE provincias WHERE codigo = 4;

-- Intente modificar el registro con código 1, de "provincias".
--No se puede porque hay registros en "clientes" al cual hace referencia.
--Realmente si deja
UPDATE provincias SET nombre = 'Caldas' WHERE codigo = 1;
SELECT * FROM provincias;

EXEC sp_helpconstraint clientes;

EXEC sp_helpconstraint provincias;
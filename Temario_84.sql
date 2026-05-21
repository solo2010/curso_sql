--Alterar campos (alter table - alter)
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(30),
    autor VARCHAR(30),
    editorial VARCHAR(15),
    precio DECIMAL(6,2) NOT NULL DEFAULT 0
);

INSERT INTO libros VALUES('El aleph','Borges','Planeta',20);
INSERT INTO libros VALUES('Java en 10 minutos',null,'Siglo XXI',30);
INSERT INTO libros VALUES('Uno','Richard Bach','Planeta',15);
INSERT INTO libros VALUES('Martin Fierro','Jose Hernandez',null,30);
INSERT INTO libros VALUES('Aprenda PHP','Mario Molina','Emece',25);

-- Modificamos el campo "titulo" para que acepte una cadena más larga y 
-- no admita valores nulos:
ALTER TABLE libros
    ALTER COLUMN titulo VARCHAR(50) NOT NULL;


EXEC sp_columns libros;

-- Eliminamos registro que tienen en el campo autor el valor null
-- y realizamos la modificación del campo:
SELECT * FROM libros;
DELETE FROM libros WHERE autor IS NULL;
ALTER TABLE libros
    ALTER COLUMN autor VARCHAR(30) NOT NULL;

EXEC sp_columns libros;

-- Intentamos quitar el atributo "identity" del campo "codigo" y
-- lo redefinimos como "smallint" (no se produce el cambio):
ALTER TABLE libros
    ALTER COLUMN codigo SMALLINT;

EXEC sp_columns libros;

--Ejercicio
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    legajo INT NOT NULL,
    documento CHAR(7) NOT NULL,
    nombre VARCHAR(10),
    domicilio VARCHAR(30),
    ciudad VARCHAR(20) DEFAULT 'Buenos Aires',
    sueldo DECIMAL(6,2),
    cantidadhijos TINYINT DEFAULT 0,
    PRIMARY KEY(legajo)
);

--Modifique el campo "nombre" extendiendo su longitud.
ALTER TABLE empleados
    ALTER COLUMN nombre VARCHAR(30);

--Controle la modificación:
EXEC sp_columns empleados;

--Modifique el campo "sueldo" para que no admita valores nulos.
ALTER TABLE empleados
    ALTER COLUMN sueldo DECIMAL(6,2) NOT NULL;

--Modifique el campo "documento" ampliando su longitud a 8 caracteres.
ALTER TABLE empleados
    ALTER COLUMN documento CHAR(8) NOT NULL;

--Intente modificar el tipo de datos del campo "legajo" a "tinyint"
--No se puede porque tiene una restricción.
ALTER TABLE empleados
    ALTER COLUMN legajo TINYINT NOT NULL;

--Ingrese algunos registros, uno con "nombre" nulo:
 INSERT INTO empleados VALUES(1,'22222222','Juan Perez','Colon 123','Cordoba',500,3);
 INSERT INTO empleados VALUES(2,'30000000',null,'Sucre 456','Cordoba',600,2);

 --Intente modificar el campo "nombre" para que no acepte valores nulos:
 --No se puede porque hay registros con ese valor.
 ALTER TABLE empleados
    ALTER COLUMN nombre VARCHAR(30) NOT NULL;

--Elimine el registro con "nombre" nulo y realice la modificación del punto 7:
DELETE empleados WHERE nombre IS NULL;
ALTER TABLE empleados
    ALTER COLUMN nombre VARCHAR(30) NOT NULL;

--Modifique el campo "ciudad" a 10 caracteres.
ALTER TABLE empleados
    ALTER COLUMN ciudad VARCHAR(10);

--Intente agregar un registro con el valor por defecto para "ciudad":
--No se puede porque el campo acepta 10 caracteres y  el valor por defecto tiene 12 caracteres.
INSERT INTO empleados VALUES(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);

--Modifique el campo "ciudad" sin que afecte la restricción dándole una longitud de 15 caracteres.
ALTER TABLE empleados
    ALTER COLUMN ciudad VARCHAR(15);

--Agregue el registro que no pudo ingresar en el punto 10:
 INSERT INTO empleados VALUES(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);

 --Intente agregar el atributo identity de "legajo".
--No se puede agregar este atributo.
ALTER TABLE empleados
    ALTER COLUMN legajo INT IDENTITY;
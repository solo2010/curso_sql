--Creación de índices
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15)
);

GO

-- Creamos un índice agrupado único para el campo "codigo" de la tabla "libros":
CREATE UNIQUE CLUSTERED INDEX I_libros_codigo
    ON libros(codigo);

-- Creamos un índice no agrupado para el campo "titulo":
CREATE NONCLUSTERED INDEX I_libros_titulo
    ON libros(titulo);

-- Veamos los indices de "libros":
EXEC sp_helpindex libros;

-- Creamos una restricción "primary key" al campo "codigo" especificando
-- que cree un índice NO agrupado:
ALTER TABLE libros
    ADD CONSTRAINT PK_libros_codigo
    PRIMARY KEY NONCLUSTERED (codigo);


-- Verificamos que creó un índice automáticamente:
EXEC sp_helpindex libros;

-- Creamos un índice compuesto para el campo "autor" y "editorial":
CREATE INDEX I_libros_autoreditorial
 ON libros (autor, editorial);

-- Consultamos la tabla "sysindexes":
SELECT name from sysindexes;

-- Veamos los índices de la base de datos activa creados por nosotros
-- podemos tipear la siguiente consulta:
SELECT name FROM sysindexes WHERE name LIKE 'I_%';

--Ejercicio
IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE alumnos(
    legajo CHAR(5) NOT NULL,
    documento CHAR(8) NOT NULL,
    apellido VARCHAR(30),
    nombre VARCHAR(30),
    notfinal DECIMAL(4,2)
);

INSERT INTO alumnos VALUES ('A123','22222222','Perez','Patricia',5.50);
INSERT INTO alumnos VALUES ('A234','23333333','Lopez','Ana',9);
INSERT INTO alumnos VALUES ('A345','24444444','Garcia','Carlos',8.5);
INSERT INTO alumnos VALUES ('A348','25555555','Perez','Daniela',7.85);
INSERT INTO alumnos VALUES ('A457','26666666','Perez','Fabian',3.2);
INSERT INTO alumnos VALUES ('A589','27777777','Gomez','Gaston',6.90);

--Intente crear un índice agrupado único para el campo "apellido".
--No lo permite porque hay valores duplicados.
--CREATE UNIQUE CLUSTERED INDEX I_alumnos_apellido
--    ON alumnos(apellido);

--Cree un índice agrupado, no único, para el campo "apellido".
CREATE CLUSTERED INDEX I_alumnos_apellido
    ON alumnos(apellido);

--Intente establecer una restricción "primary key" al campo "legajo" especificando que cree un 
--índice agrupado.
--No lo permite porque ya existe un índice agrupado y solamente puede haber uno por tabla.
ALTER TABLE alumnos
    ADD CONSTRAINT PK_alumnos_legajo
    PRIMARY KEY CLUSTERED(legajo);

--Establezca la restricción "primary key" al campo "legajo" especificando que cree un índice NO 
--agrupado.
ALTER TABLE alumnos
    ADD CONSTRAINT PK_alumnos_legajo
    PRIMARY KEY NONCLUSTERED(legajo);

--Vea los índices de "alumnos":
EXEC sp_helpindex alumnos;

--Analice la información que muestra "sp_helpconstraint":
EXEC sp_helpconstraint alumnos;

--Cree un índice unique no agrupado para el campo "documento".
CREATE UNIQUE NONCLUSTERED INDEX I_alumnos_documento
    ON alumnos(documento);


-- Intente ingresar un alumno con documento duplicado.
--No lo permite.
SELECT * FROM alumnos;
INSERT INTO alumnos VALUES('A666', '27777777', 'Lopez', 'Flor Cecilia', 10);

--Veamos los indices de "alumnos".
EXEC sp_helpindex alumnos;

--Cree un índice compuesto para el campo "apellido" y "nombre".
--Se creará uno no agrupado porque no especificamos el tipo, además, ya existe uno agrupado y 
--solamente puede haber uno por tabla.
CREATE INDEX I_alumnos_apellidonombre
 ON alumnos(apellido,nombre);

--Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados para 
--"alumnos":
SELECT name FROM sysindexes
    WHERE name LIKE '%alumnos%';

--Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados por usted:
SELECT name FROM sysindexes WHERE name LIKE 'I_%';


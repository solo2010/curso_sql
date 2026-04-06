IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15)
);

GO

-- Creamos un índice para el campo "titulo":
CREATE INDEX I_libros_titulo
 ON libros(titulo);

 EXEC sp_helpindex libros;

 -- Eliminamos el índice "I_libros_titulo":
 DROP INDEX libros.I_libros_titulo;

 EXEC sp_helpindex libros;

 -- Solicitamos que se elimine el índice "I_libros_titulo" si existe:
 IF EXISTS (SELECT name FROM sysindexes WHERE name = 'I_libros_titulo')
    DROP INDEX libros.I_libros_titulo;

--Ejercicio
IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE alumnos(
    legajo CHAR(5) NOT NULL,
    documento CHAR(8) NOT NULL,
    apellido VARCHAR(30),
    nombre VARCHAR(30),
    notafinal DECIMAL(4,2)
);

--Cree un índice no agrupado para el campo "apellido".
CREATE NONCLUSTERED INDEX I_alumnos_apellido
    ON alumnos (apellido);

--Establezca una restricción "primary" para el campo "legajo" y especifique que cree un índice 
--"agrupado".
ALTER TABLE alumnos
    ADD CONSTRAINT PK_alumnos_legajo
    PRIMARY KEY CLUSTERED(legajo);

--Vea la información que muestra "sp_helpindex":
EXEC sp_helpindex alumnos;

--Intente eliminar el índice "PK_alumnos_legajo" con "drop index":
--No se puede.
DROP INDEX PK_alumnos_legajo;

--Intente eliminar el índice "I_alumnos_apellido" sin especificar el nombre de la tabla:
--Mensaje de error.
DROP INDEX I_alumnos_apellido;

--Elimine el índice "I_alumnos_apellido" especificando el nombre de la tabla.
DROP INDEX alumnos.I_alumnos_apellido;

--Verifique que se eliminó:
EXEC sp_helpindex alumnos;

--Solicite que se elimine el índice "I_alumnos_apellido" si existe:
IF EXISTS(SELECT name FROM sysindexes WHERE name='I_alumnos_apellido')
    DROP INDEX alumnos.I_alumnos_apellido;

--Elimine el índice "PK_alumnos_legajo" (quite la restricción).
ALTER TABLE alumnos
    DROP CONSTRAINT PK_alumnos_legajo;

--Verifique que el índice "PK_alumnos_legajo" ya no existe:
EXEC sp_helpindex alumnos;
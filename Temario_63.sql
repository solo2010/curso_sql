--Regenerar índices
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(15)
);

GO

-- Creamos un índice no agrupado para el campo "titulo":
CREATE NONCLUSTERED INDEX I_libros_titulo
    ON libros(titulo);

EXEC sp_helpindex libros;

-- Vamos a agregar el campo "autor" al índice "I_libros_titulo"
-- y vemos si se modificó:
CREATE INDEX I_libros_titulo
    ON libros(titulo, autor)
    WITH DROP_EXISTING;

EXEC sp_helpindex libros;

-- Lo convertimos en agrupado:
CREATE CLUSTERED INDEX I_libros_titulo
 ON libros(titulo, autor)
 WITH DROP_EXISTING;

EXEC sp_helpindex libros;

-- Quitamos un campo "autor"
CREATE CLUSTERED INDEX I_libros_titulo
    ON libros(titulo)
    WITH DROP_EXISTING;

EXEC sp_helpindex libros;

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
    ON alumnos(apellido);

--Vea la información de los índices de "alumnos".
EXEC sp_helpindex alumnos;

--Modifíquelo agregando el campo "nombre".
CREATE NONCLUSTERED INDEX I_alumnos_apellido
    ON alumnos(apellido,nombre)
    WITH DROP_EXISTING;

--Verifique que se modificó:
EXEC sp_helpindex alumnos;

--Establezca una restricción "unique" para el campo "documento".
ALTER TABLE alumnos
    ADD CONSTRAINT UQ_alumnos_documento
    UNIQUE NONCLUSTERED (documento);

--Vea la información que muestra "sp_helpindex":
EXEC sp_helpindex alumnos;

--Intente modificar con "drop_existing" alguna característica del índice que se creó 
--automáticamente al agregar la restricción "unique":
--No se puede emplear "drop_existing" con índices creados a partir de una restricción.
CREATE CLUSTERED INDEX UQ_alumnos_documento
    ON alumnos(documento)
    WITH DROP_EXISTING;

--Cree un índice no agrupado para el campo "legajo".
CREATE NONCLUSTERED INDEX I_alumnos_legajo
    ON alumnos(legajo);

--Muestre todos los índices:
EXEC sp_helpindex alumnos;

--Convierta el índice creado en el punto 9 a agrupado conservando las demás características.
CREATE CLUSTERED INDEX I_alumnos_legajo
    ON alumnos(legajo)
    WITH DROP_EXISTING;

--Verifique que se modificó:
EXEC sp_helpindex alumnos;

--Intente convertir el índice "I_alumnos_legajo" a no agrupado:
--No se puede convertir un índice agrupado en no agrupado.
CREATE NONCLUSTERED INDEX I_alumnos_legajo
    ON alumnos(legajo)
    WITH DROP_EXISTING;

--Modifique el índice "I_alumnos_apellido" quitándole el campo "nombre".
CREATE NONCLUSTERED INDEX I_alumnos_apellido
    ON alumnos(apellido)
    WITH DROP_EXISTING;

--Intente convertir el índice "I_alumnos_apellido" en agrupado:
--No lo permite porque ya existe un índice agrupado.
CREATE CLUSTERED INDEX I_alumnos_apellido
    ON alumnos(apellido)
    WITH DROP_EXISTING;

--Modifique el índice "I_alumnos_legajo" para que sea único y conserve todas las otras 
--características.
CREATE UNIQUE CLUSTERED INDEX I_alumnos_legajo
    ON alumnos(legajo)
    WITH DROP_EXISTING;

--Verifique la modificación:
EXEC sp_helpindex alumnos;

--Modifique nuevamente el índice "I_alumnos_legajo" para que no sea único y conserve las demás 
--características.
CREATE CLUSTERED INDEX I_alumnos_legajo
    ON alumnos(legajo)
    WITH DROP_EXISTING;

--Verifique la modificación:
EXEC sp_helpindex alumnos;
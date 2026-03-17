IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

IF OBJECT_ID('VP_cero') IS NOT NULL
    DROP DEFAULT VP_cero;

IF OBJECT_ID('VP_datodesconocido') IS NOT NULL
    DROP DEFAULT VP_datodesconocido;

CREATE TABLE empleados(
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    barrio VARCHAR(15),
    sueldo DECIMAL(6,2)
);

GO

-- Creamos un valor predeterminado que inserta el valor "0":
CREATE DEFAULT VP_cero
    AS 0;

GO

-- Lo asociamos al campo "sueldo":
EXEC sp_bindefault VP_cero, 'empleados.sueldo';

GO
-- Creamos un valor predeterminado con el valor "Desconocido":
CREATE DEFAULT VP_datodesconocido
    AS 'Desconocido';

GO

-- Lo asociamos al campo "domicilio" y al campo "barrio":
EXEC sp_bindefault VP_datodesconocido, 'empleados.domicilio';
EXEC sp_bindefault VP_datodesconocido, 'empleados.barrio';

-- Veamos los valores predeterminados asociados a los campos de la tabla "empleados":
EXEC sp_helpconstraint empleados;

-- Quitamos la asociación al campo "barrio":
EXEC sp_unbindefault 'empleados.barrio';

EXEC sp_helpconstraint empleados;

EXEC sp_help;

-- Aun no podemos eliminarlo porque está asociado al campo "domicilio",
-- quitamos la asociación y luego lo eliminamos:

EXEC sp_unbindefault 'empleados.domicilio';

DROP DEFAULT VP_datodesconocido;

--Ejercicio
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('VP_cero') IS NOT NULL
    DROP DEFAULT VP_cero;

IF OBJECT_ID('VP_desconocido') IS NOT NULL
    DROP DEFAULT VP_desconocido;

IF OBJECT_ID('RG_positivo') IS NOT NULL
    DROP RULE RG_positivo;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(30),
    editorial VARCHAR(20),
    precio DECIMAL(5,2),
    cantidad SMALLINT
);

 --Cree una regla para impedir que se ingresen valores negativos, llamada "RG_positivo".
 GO
CREATE RULE RG_positivo
    AS @valor >= 0;
GO

--Asocie la regla al campo "precio".
EXEC sp_bindrule RG_positivo, 'libros.precio';

--Asocie la regla al campo "cantidad".
EXEC sp_bindrule RG_positivo, 'libros.cantidad';

--Cree un valor predeterminado para que almacene el valor cero, llamado "VP_cero".
GO
CREATE DEFAULT VP_cero
    AS 0;
GO

--Asócielo al campo "precio".
EXEC sp_bindefault VP_cero, 'libros.precio';

--Asócielo al campo "cantidad".
EXEC sp_bindefault VP_cero, 'libros.cantidad';

-- Cree un valor predeterminado con la cadena "Desconocido" llamado "VP_desconocido".
GO
CREATE DEFAULT VP_desconocido
    AS 'Desconocido'
GO

--Asócielo al campo "autor".
EXEC sp_bindefault VP_desconocido, 'libros.autor';

--Asócielo al campo "editorial".
EXEC sp_bindefault VP_desconocido, 'libros.editorial';

--Vea las reglas y valores predeterminados con "sp_help":
EXEC sp_help;

EXEC sp_helpconstraint libros;

--Ingrese un registro con valores por defecto para todos los campos, excepto "titulo" y vea qué se 
--almacenó.
INSERT INTO libros VALUES('El Coronel no tiene quien le escriba', DEFAULT, DEFAULT, DEFAULT, DEFAULT);
SELECT * FROM libros;

--Quite la asociación del valor predeterminado "VP_cero" al campo "precio".
EXEC sp_unbindefault 'libros.precio'

--Ingrese otro registro con valor predeterminado para el campo "precio" y vea cómo se almacenó.
INSERT INTO libros VALUES('Satanas', DEFAULT, DEFAULT, DEFAULT, DEFAULT);

--Vea las reglas y valores predeterminados asociados a "libros".
EXEC sp_helpconstraint libros;

--Intente eliminar el valor predeterminado "VP_cero".
--No se puede porque está asociado al campo "cantidad".
DROP DEFAULT VP_cero;

--Quite la asociación del valor predeterminado "VP_cero" al campo "cantidad".
EXEC sp_unbindefault 'libros.cantidad';

--Verifique que ya no existe asociación de este valor predeterminado con la tabla "libros".
EXEC sp_helpconstraint libros;

--Verifique que el valor predeterminado "VP_cero" aun existe en la base de datos.
EXEC sp_help;

--Elimine el valor predeterminado "VP_cero".
DROP DEFAULT VP_cero;

--Verifique que ya no existe en la base de datos.
EXEC sp_help;
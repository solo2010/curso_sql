/* Crear tablas
CREATE TABLE usuarios(
    nombre VARCHAR(30),
    clave VARCHAR(10)
)

*/

/*Muestra los detalles de una tabla

EXEC sp_columns usuarios;

*/

/* Validar si la tabla existe antes de eliminarla

if OBJECT_ID('usuarios') is NOT NULL
    DROP TABLE usuarios;

*/

/********EJERCICIOS**********/

/****Ejercicio 1*******/
if OBJECT_ID('agenda') IS NOT NULL
    DROP TABLE agenda;

CREATE TABLE agenda(
    apellido VARCHAR(30),
    nombre VARCHAR(20),
    domicilio VARCHAR(30),
    telefono VARCHAR(11)
);

/* Visualizar las tablas de la base de datos existentes */
EXEC sp_tables @table_owner='dbo';

/* Visualizar estructura de la tabla */
EXEC sp_columns agenda;

DROP TABLE agenda;


/******Ejecririo 2 ******/
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;


EXEC sp_tables @table_owner='dbo' /*Validar que tablas hay en la DB */

CREATE TABLE libros(
    titulo VARCHAR(20),
    autor VARCHAR(30),
    editorial VARCHAR(15)
)

EXEC sp_columns libros; /*Validar que columnas tiene la tabla libros */

EXEC sp_tables @table_owner='dbo' /*Validar que tablas hay en la db? */

DROP TABLE libros;



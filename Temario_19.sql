--Tipo de dato (fecha y hora)
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    nombre VARCHAR(20),
    documento CHAR(8),
    fechaingreso DATETIME
);

GO

-- Seteamos el formato de la fecha para que guarde día, mes y año:
SET DATEFORMAT dmy;

INSERT INTO empleados VALUES('Ana Gomez', '22222222', '12-01-1989');
INSERT INTO empleados VALUES('Bernardo Huerta', '23333333', '15-03-81');
INSERT INTO empleados VALUES('Carla Juarez', '24444444', '20/05/1983');
INSERT INTO empleados VALUES('Daniel Lopez', '32525395', '9.12.1989');

-- Note que el formato de visualización es "y-m-d". Ya que así setiemos el dateformat sql muestra
-- este tipo de dato en el siguiente formato ymd

SELECT * FROM empleados;

-- Mostramos los datos de los empleados cuya fecha de ingreso es anterior a '01-01-1985':
SELECT * FROM empleados WHERE fechaingreso < '01-01-1985';

-- Actualizamos el nombre a "Maria Carla Juarez' 
-- del empleado cuya fecha de ingreso es igual a '20/05/1983':
UPDATE empleados SET nombre = 'Maria Carla Juarez' WHERE fechaingreso = '20/05/1983';
SELECT * FROM empleados;

-- Borramos los empleados cuya fecha de ingreso es distinta a '20.5.83':
DELETE FROM empleados WHERE fechaingreso = '20.5.83';

SELECT * FROM empleados;

--Ejercicio 1
IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE alumnos(
    apellido VARCHAR(30),
    nombre VARCHAR(30),
    documento CHAR(8),
    domicilio VARCHAR(30),
    fechaingreso DATETIME,
    fechanacimiento DATETIME
);

--Setee el formato para entrada de datos de tipo fecha para que acepte valores "día-mes-año": 
SET DATEFORMAT 'dmy';

--Ingrese un alumno empleando distintos separadores para las fechas:
INSERT INTO alumnos VALUES('Lopez', 'Daniel', '32525395', 'Barrio el Socorro', '02.02.2026', '09-12-89');

SELECT * FROM alumnos;

--Ingrese otro alumno empleando solamente un dígito para día y mes y 2 para el año:
INSERT INTO alumnos VALUES('Vargas', 'Geny', '12345678', 'Felipe Echavarria', '2.2.26', '10.2.94');

SELECT * FROM alumnos;

--Ingrese un alumnos empleando 2 dígitos para el año de la fecha de ingreso y "null" en 
--fechanacimiento
INSERT INTO alumnos VALUES('Sampedro', 'Julian', '87654321', 'Barrio el Jomaber', '31/01/26', NULL);

SELECT * FROM alumnos;

--Intente ingresar un alumno con fecha de ingreso correspondiente a "15 de marzo de 1990" pero en 
--orden incorrecto "03-15-90":
--aparece un mensaje de error porque lo lee con el formato día, mes y año y no reconoce el mes 15.
INSERT INTO alumnos VALUES('Lopez', 'Flor Cecilia', '54975632', 'La rivera', '03-15-90', NULL);

--Muestre todos los alumnos que ingresaron antes del '1-1-91'.
SELECT * FROM alumnos WHERE fechaingreso < '1-1-91';

--Muestre todos los alumnos que tienen "null" en "fechanacimiento":


SELECT * FROM alumnos WHERE fechanacimiento IS NULL;

--Intente ingresar una fecha de ingreso omitiendo los separadores: No lo acepta.
INSERT INTO alumnos VALUES('Marin', 'Edelmira', '45455656', 'Caldas', '03151990', NULL)

--Setee el formato de entrada de fechas para que acepte valores "mes-dia-año".
SET DATEFORMAT 'mdy'

--Ingrese el registro del punto 7.
--(Intente ingresar un alumno con fecha de ingreso correspondiente a "15 de marzo de 1990")
INSERT INTO alumnos VALUES('Sampedro', 'Julian', '98875465', 'Sabaneta', '15-03-1990', '04-04-1990');
--Deshabilitar restricciones (with check - nocheck)

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(5,2)
);

go

insert into libros values ('Uno','Bach','Planeta',22);
insert into libros values ('El quijote','Cervantes','Emece',15);
insert into libros values ('Aprenda PHP','Mario Molina','Siglo XXI',-40);

SELECT * FROM libros;
-- Agregamos una restricción "check" para asegurar que los precios no puedan ser 
-- negativos, pero como ya tenemos almacenado un precio que infringe la restricción,
-- vamos a especificar que no haya comprobación de datos existentes:
ALTER TABLE libros
    WITH NOCHECK
    ADD CONSTRAINT CK_libros_precio_positivo
    CHECK(precio >= 0);

-- Si intentamos ingresar un registro con precio negativo, no lo permite.
INSERT INTO libros VALUES('Satanas', 'Mario Mendoza', 'Planeta', -50);

-- Para que lo permita, debemos dehabilitar la comprobación:
ALTER TABLE libros
    NOCHECK CONSTRAINT CK_libros_precio_positivo;

INSERT INTO libros VALUES('Satanas', 'Mario Mendoza', 'Planeta', -50);

SELECT * FROM libros;

-- Veamos si la restricción está o no habilitada:
EXEC sp_helpconstraint libros;

-- Habilitamos la restricción.
ALTER TABLE libros
    CHECK CONSTRAINT CK_libros_precio_positivo;

EXEC sp_helpconstraint libros;

--Ejercicio 1
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    documento VARCHAR(8),
    nombre VARCHAR(30),
    seccion VARCHAR(20),
    sueldo DECIMAL(6,2)
);

GO

INSERT INTO empleados VALUES('22222222','Alberto Acosta','Sistemas',-10);
INSERT INTO empleados VALUES('33333333','Beatriz Benitez','Recursos',3000);
INSERT INTO empleados VALUES('34444444','Carlos Caseres','Contaduria',4000);

SELECT * FROM empleados;

-- Intente agregar una restricción "check" para asegurarse que no se ingresen valores negativos para 
--el sueldo. No se permite porque hay un valor negativo almacenado.
ALTER TABLE empleados
    ADD CONSTRAINT CK_empleados_sueldo_positivo
    CHECK(sueldo >= 0);

--Vuelva a intentarlo agregando la opción "with nocheck":
ALTER TABLE empleados
    WITH NOCHECK
    ADD CONSTRAINT CK_empleados_sueldo_positivo
    CHECK(sueldo >= 0);
    
--Intente ingresar un valor negativo para sueldo. No es posible a causa de la restricción.
INSERT INTO empleados VALUES('32525395', 'Flor Cecilia', 'Recursos', -70);

--Deshabilite la restricción e ingrese el registro anterior:
ALTER TABLE empleados
    NOCHECK CONSTRAINT CK_empleados_sueldo_positivo;

--Intentamos nuevamente ingrear un valor negativo para sueldo. Ya si da porque deshabilitamos la restricción.
INSERT INTO empleados VALUES('32525395', 'Flor Cecilia', 'Recursos', -70);

SELECT * FROM empleados;

--Establezca una restricción "check" para "seccion" que permita solamente los valores "Sistemas", 
--"Administracion" y "Contaduría". No lo permite porque existe un valor fuera de la lista.
ALTER TABLE empleados
    ADD CONSTRAINT CK_empleados_seccion
    CHECK(seccion IN ('Sistemas', 'Administracion', 'Contaduria'));

--Establezca la restricción anterior evitando que se controlen los datos existentes.
ALTER TABLE empleados
    WITH NOCHECK
    ADD CONSTRAINT CK_empleados_seccion
    CHECK(seccion IN ('Sistemas', 'Administracion', 'Contaduria'));

-- Vea si las restricciones de la tabla están o no habilitadas:
EXEC sp_helpconstraint empleados;

--Habilite la restricción deshabilitada.
ALTER TABLE empleados
    CHECK CONSTRAINT CK_empleados_sueldo_positivo;

EXEC sp_helpconstraint empleados;

--Intente modificar la sección del empleado "Carlos Caseres" a "Recursos". No lo permite.
SELECT * FROM empleados;
UPDATE empleados SET seccion = 'Recursos' WHERE nombre LIKE '%Carlos Caseres%';

--Deshabilite la restricción para poder realizar la actualización del punto precedente.
EXEC sp_helpconstraint empleados;

ALTER TABLE empleados
    NOCHECK CONSTRAINT CK_empleados_seccion;

UPDATE empleados SET seccion = 'Recursos' WHERE nombre LIKE '%Carlos Caseres%';

SELECT * FROM empleados;

--Campos calculados
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    documento CHAR(8),
    nombre VARCHAR(10),
    domicilio VARCHAR(30),
    sueldobasico DECIMAL(6,2),
    hijos TINYINT NOT NULL DEFAULT 0,
    sueldototal AS sueldobasico + (hijos*100)
);

GO

-- No puede ingresarse valor para el campo sueldototal:
INSERT INTO empleados VALUES('22222222','Juan Perez','Colon 123',300,2);
INSERT INTO empleados VALUES('23333333','Ana Lopez','Sucre 234',500,0);

SELECT * FROM empleados;

-- Actualizamos un registro:
update empleados set hijos=1 where documento='23333333';

SELECT * FROM empleados;

-- Agregamos un campo calculado:
ALTER TABLE empleados
    ADD salariofamiliar AS hijos*100;

EXEC sp_columns empleados;

SELECT * FROM empleados;

--Ejercicio
IF OBJECT_ID('articulos') IS NOT NULL
    DROP TABLE articulos;

CREATE TABLE articulos(
    codigo INT IDENTITY,
    descripcion VARCHAR(30),
    precio DECIMAL(5,2) NOT NULL,
    cantidad SMALLINT NOT NULL DEFAULT 0,
    montototal AS precio * cantidad
);

--Intente ingresar un registro con valor para el campo calculado:
--No lo permite.
INSERT INTO articulos VALUES('Barra Chocolate', 5000, 2, 10000);

--Ingrese algunos registros:
 INSERT INTO articulos VALUES('birome',1.5,100);
 INSERT INTO articulos VALUES('cuaderno 12 hojas',4.8,150);
 INSERT INTO articulos VALUES('lapices x 12',5,200);

 SELECT * FROM articulos;

 --Actualice un precio y recupere los registros:
 UPDATE articulos SET precio = 10 WHERE codigo = 1;
 SELECT * FROM articulos;

 --Actualice una cantidad y vea el resultado:
 UPDATE articulos SET cantidad = 500 WHERE codigo = 2;
 SELECT * FROM articulos;

 --Intente actualizar un campo calculado:
 --No lo permite.
 UPDATE articulos SET montototal = 400 WHERE codigo = 1;

 

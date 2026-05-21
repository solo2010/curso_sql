--Unión
IF OBJECT_ID('profesores') IS NOT NULL
    DROP TABLE profesores;
IF OBJECT_ID('alumnos') IS NOT NULL
    DROP TABLE alumnos;

CREATE TABLE profesores(
    documento VARCHAR(8) NOT NULL,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    PRIMARY KEY (documento)
);

CREATE TABLE alumnos(
    documento VARCHAR(8) NOT NULL,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    PRIMARY KEY (documento)
);

GO

INSERT INTO alumnos VALUES('30000000','Juan Perez','Colon 123');
INSERT INTO alumnos VALUES('30111111','Marta Morales','Caseros 222');
INSERT INTO alumnos VALUES('30222222','Laura Torres','San Martin 987');
INSERT INTO alumnos VALUES('30333333','Mariano Juarez','Avellaneda 34');
INSERT INTO alumnos VALUES('23333333','Federico Lopez','Colon 987');

INSERT INTO profesores VALUES('22222222','Susana Molina','Sucre 345');
INSERT INTO profesores VALUES('23333333','Federico Lopez','Colon 987');

-- Nombre y domicilio de profesores y alumnos
SELECT nombre, domicilio FROM alumnos
    UNION
        SELECT nombre, domicilio FROM profesores;

-- Mostrar las filas duplicadas de ambas tablas
-- (existe un profesor que también está presente en la tabla "alumnos")
SELECT nombre, domicilio FROM alumnos
    UNION ALL
        SELECT nombre, domicilio FROM profesores;


-- Ordenamos por domicilio:
SELECT nombre, domicilio FROM alumnos
    UNION
        SELECT nombre, domicilio FROM profesores
    ORDER BY domicilio;

-- agregar una columna extra a la consulta con el encabezado "condicion"
-- en la que aparezca el literal "profesor" o "alumno" según si la persona
-- es uno u otro:
SELECT nombre, domicilio, 'alumno' AS condicion FROM alumnos
    UNION 
        SELECT nombre, domicilio, 'profesor' AS profesor FROM profesores;

--Ejercicio
IF OBJECT_ID('clientes') IS NOT NULL
    DROP TABLE clientes
IF OBJECT_ID('proveedores') IS NOT NULL
    DROP TABLE proveedores;
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE proveedores(
    codigo INT IDENTITY,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    PRIMARY KEY(codigo)
);

CREATE TABLE clientes(
    codigo INT IDENTITY,
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    PRIMARY KEY(codigo)
);

CREATE TABLE empleados(
    documento CHAR(8) NOT NULL,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    domicilio VARCHAR(30),
    PRIMARY KEY(documento)
);

GO

 INSERT INTO proveedores VALUES('Bebida cola','Colon 123');
 INSERT INTO proveedores VALUES('Carnes Unica','Caseros 222');
 INSERT INTO proveedores VALUES('Lacteos Blanca','San Martin 987');
 INSERT INTO clientes VALUES('Supermercado Lopez','Avellaneda 34');
 INSERT INTO clientes VALUES('Almacen Anita','Colon 987');
 INSERT INTO clientes VALUES('Garcia Juan','Sucre 345');
 INSERT INTO empleados VALUES('23333333','Federico','Lopez','Colon 987');
 INSERT INTO empleados VALUES('28888888','Ana','Marquez','Sucre 333');
 INSERT INTO empleados VALUES('30111111','Luis','Perez','Caseros 956');

 SELECT nombre, domicilio, 'Proveedor' AS tipo FROM proveedores
    UNION
        SELECT nombre, domicilio, 'Cliente' AS tipo FROM clientes
    UNION
        SELECT nombre, domicilio, 'Empleado' AS tipo FROM empleados;
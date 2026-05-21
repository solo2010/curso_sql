IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    autor VARCHAR(30),
    editorial VARCHAR(15)
);

GO

-- Agregamos el campo "titulo" de tipo varchar(30) y una 
-- restricción "unique" con índice agrupado:
ALTER TABLE libros
    ADD titulo VARCHAR(30)
    CONSTRAINT UQ_libros_titulo UNIQUE CLUSTERED;

EXEC sp_columns libros;

-- Agregamos el campo "codigo" de tipo int identity not null
-- y en la misma sentencia una restricción "primary key" con índice no agrupado:
ALTER TABLE libros
    ADD codigo INT IDENTITY NOT NULL
    CONSTRAINT PK_libros_codigo PRIMARY KEY NONCLUSTERED;

-- Agregamos el campo "precio" de tipo decimal(6,2) y una restricción "check" 
-- que no permita valores negativos para dicho campo:
ALTER TABLE libros
    ADD precio DECIMAL(6,2)
    CONSTRAINT CK_libros_precio CHECK (precio >= 0);

EXEC sp_helpconstraint libros;

--Ejercicio
IF OBJECT_ID('empleados') IS NOT NULL
    DROP TABLE empleados;

CREATE TABLE empleados(
    documento CHAR(8) NOT NULL,
    nombre VARCHAR(10),
    domicilio VARCHAR(30),
    ciudad VARCHAR(20) DEFAULT 'Buenos aires'
);

--Agregue el campo "legajo" de tipo int identity y una restricción "primary key":
ALTER TABLE empleados
    ADD legajo INT IDENTITY
    CONSTRAINT PK_empleados_legajo
    PRIMARY KEY (legajo);

--Agregue el campo "hijos" de tipo tinyint y en la misma sentencia una restricción "check" que no 
--permita valores superiores a 30:
 alter table empleados
  add hijos tinyint
  constraint CK_empleados_hijos check (hijos<=30);


--Ingrese algunos registros:
 insert into empleados values('22222222','Juan Lopez','Colon 123','Cordoba',2);
 insert into empleados values('23333333','Ana Garcia','Sucre 435','Cordoba',3);

--Intente agregar el campo "sueldo" de tipo decimal(6,2) no nulo y una restricción "check" que no 
--permita valores negativos para dicho campo:
--No lo permite porque no damos un valor por defecto para dicho campo no nulo y los registros 
--existentes necesitan cargar un valor.
 alter table empleados
  add sueldo decimal(6,2) not null
  constraint CK_empleados_sueldo check (sueldo>=0);

--Agregue el campo "sueldo" de tipo decimal(6,2) no nulo, una restricción "check" que no permita 
--valores negativos para dicho campo y una restricción "default" que almacene el valor "0":
ALTER TABLE empleados
    ADD sueldo DECIMAL(6,2) NOT NULL
    CONSTRAINT CK_empleados_sueldo CHECK (sueldo >= 0)
    CONSTRAINT DF_empleados_sueldo DEFAULT (0);


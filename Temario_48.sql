--Restricción check

if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  preciomin decimal(5,2),
  preciomay decimal(5,2)
);

insert into libros values ('Uno','Bach','Planeta',22,20);
insert into libros values ('El quijote','Cervantes','Emece',15,13);
insert into libros values ('Aprenda PHP','Mario Molina','Siglo XXI',48,53);
insert into libros values ('Java en 10 minutos','Garcia','Siglo XXI',35,40);

-- Agregamos una restricción "check" para asegurar que los valores de los campos
-- correspondientes a precios no puedan ser negativos:
ALTER TABLE libros
    ADD CONSTRAINT CK_libros_precio_positivo
    CHECK (preciomin > 0 AND preciomay > 0);

--Observamos la restricción que se generó
EXEC sp_helpconstraint libros;

--intentamos ingresar un precio negativo al precio de mayorista
UPDATE libros SET preciomay=-40 WHERE titulo = 'Aprenda PHP';

UPDATE libros SET preciomay=48 WHERE titulo = 'Aprenda PHP';

-- Agregamos la restricción "check" que impida que se ingresen valores 
-- para "preciomay" superiores a "preciomin":
ALTER TABLE libros
    ADD CONSTRAINT CK_libros_preciominmay
    CHECK (preciomay <= preciomin);

--Debido a que saca error porque Java en 10 minutos tiene el precio mayor al precio menor se actualiza este precio
--mayor por un valor menor
UPDATE libros SET preciomay = 34.50 WHERE titulo LIKE '%Java%';
SELECT * FROM libros;

--Ejecutamos de nuevo la consulta que agrega la restricción de preciomay <= preciomin
ALTER TABLE libros
    ADD CONSTRAINT CK_libros_preciominmay
    CHECK (preciomay <= preciomin);

EXEC sp_helpconstraint libros;

INSERT INTO libros DEFAULT VALUES;

-- Genera un error si intentamos ingresar un preciomin negativo
INSERT INTO libros VALUES('Java Total', 'Martinez', 'Cuello', -1.40, DEFAULT);

--Ejercicio 1
IF OBJECT_ID('empleados') IS NOT NULL
  DROP TABLE empleados;

CREATE TABLE empleados(
  documento VARCHAR(8),
  nombre VARCHAR(30),
  fechanacimiento DATETIME,
  cantidadhijos TINYINT,
  seccion VARCHAR(20),
  sueldo DECIMAL(6,2)
);

ALTER TABLE empleados
  ADD CONSTRAINT CK_empleados_sueldo_positivo
  CHECK (sueldo > 0);

INSERT INTO empleados VALUES('82032154', 'Geny Marcela Vargas', '1994/08/07', 1, 'Gestion Humana', 2500.50);
INSERT INTO empleados VALUES('32525395', 'Flor Cecilia Lopez', '1957/12/08', 1, 'Gerencia', 1500.25);
INSERT INTO empleados VALUES('12234556', 'Daniel Lopez Marin', '1989/12/09', 1, 'TI', 3500);

--Intente agregar otra restricción "check" al campo sueldo para asegurar que ninguno supere el 
--valor 5000:
ALTER TABLE empleados
  ADD CONSTRAINT CK_empleados_tope_sueldo
    CHECK (sueldo <= 5000);

EXEC sp_helpconstraint empleados;

--Se genera errro ya que el sueldo supera el tope de la restricción check anterior.
INSERT INTO empleados VALUES('12235687', 'Edelmira Marin', '1927/09/19', 8, 'Gerencia', 6000);

--Establezca una restricción para controlar que la fecha de nacimiento que se ingresa no supere la 
--fecha actual:
ALTER TABLE empleados
  ADD CONSTRAINT CK_empleados_tope_fecha
  CHECK (fechanacimiento < GETDATE());

EXEC sp_helpconstraint empleados;

--Establezca una restricción "check" para "seccion" que permita solamente los valores "TI", 
--"Gerencia" y "Contaduría":
ALTER TABLE empleados
  ADD CONSTRAINT KC_empleados_seccion_lista
  CHECK(seccion IN('TI', 'Gerencia', 'Contaduria'));


UPDATE empleados SET seccion = 'Contaduria' WHERE documento = '82032154';

--Establezca una restricción "check" para "cantidadhijos" que permita solamente valores entre 0 y 15.
ALTER TABLE empleados
  ADD CONSTRAINT KC_empleados_cantidad_hijos
  CHECK(cantidadhijos >= 0 AND cantidadhijos <= 15);

EXEC sp_helpconstraint empleados;

--Intente agregar un registro que vaya contra alguna de las restricciones al campo "sueldo".
INSERT INTO empleados VALUES('32564578', 'Gilberto Lopez', '1960-11-02', 1, 'Contaduria', -1500);

--Intente agregar un registro con fecha de nacimiento futura.
INSERT INTO empleados VALUES('32564578', 'Gilberto Lopez', '2027-11-02', 1, 'Contaduria', 1500);

--Intente modificar un registro colocando en "cantidadhijos" el valor "21".
UPDATE empleados SET cantidadhijos = 21 WHERE nombre LIKE '%Geny%';

--Intente modificar el valor de algún registro en el campo "seccion" cambiándolo por uno que no 
--esté incluido en la lista de permitidos.
UPDATE empleados SET seccion = 'Cartera' WHERE documento = '32525395';

--Intente agregar una restricción al campo sección para aceptar solamente valores que comiencen 
--con la letra "B":
ALTER TABLE empleados
  ADD CONSTRAINT CK_seccion_B
  CHECK (seccion = 'B%');

--Ejercicio 2
IF OBJECT_ID('vehiculos') IS NOT NULL
  DROP TABLE vehiculos;

CREATE TABLE vehiculos(
  numero INT IDENTITY,
  patente CHAR(6),
  tipo CHAR(4),
  fechahoraentrada DATETIME,
  fechahorasalida DATETIME,
);

 INSERT INTO vehiculos VALUES('AIC124','auto','2007/01/17 8:05','2007/01/17 12:30');
 INSERT INTO vehiculos VALUES('CAA258','auto','2007/01/17 8:10',null);
 INSERT INTO vehiculos VALUES('DSE367','moto','2007/01/17 8:30','2007/01/17 18:00');

--Agregue una restricción "check" que especifique un patrón de 3 letras y 3 dígitos para "patente":
 ALTER TABLE vehiculos
  ADD CONSTRAINT CK_patente
  CHECK(patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]');

EXEC sp_helpconstraint vehiculos;

--Intente ingresar un registro con un valor inapropiado para "patente":
INSERT INTO vehiculos(patente, tipo, fechahoraentrada, fechahorasalida)
  VALUES('YHI44H','moto', '2026-03-02 10:52', '2026-03-02 12:00');

--Agregue una restricción "check" que especifique que el campo "tipo" acepte solamente los valores 
--"auto" y "moto":
ALTER TABLE vehiculos
  ADD CONSTRAINT CK_tipo_vehiculo
  CHECK (tipo IN ('auto', 'moto'));

EXEC sp_helpconstraint vehiculos;

--Intente modificar el valor del campo "tipo" ingresando un valor inexistente en la lista de 
--valores permitidos por la restricción establecida a dicho campo:
INSERT INTO vehiculos VALUES('NAA612', 'bici', DEFAULT, DEFAULT);

--Agregue una restricción "default" para el campo "tipo" que almacene el valor "bici":
 ALTER TABLE vehiculos
  ADD CONSTRAINT DF_tipo_vehiculo
  DEFAULT 'bici' FOR tipo;
  
  --Intente ingresar un registro sin valor para "tipo". 
  --No lo permite porque va contra la restricción "check" del campo.
INSERT INTO vehiculos VALUES('NAA612', DEFAULT, '2026-03-02 14:00', '2026-03-02 17:00');

--Agregue una restricción "check" para asegurarse que la fecha de entrada a la playa no sea 
--posterior a la fecha y hora actual:
ALTER TABLE vehiculos
  ADD CONSTRAINT fecha_posterior_actual
  CHECK (fechahoraentrada < GETDATE());

--Agregue otra restricción "check" al campo "fechahoraentrada" que establezca que sus valores no 
--sean posteriores a "fechahorasalida":
ALTER TABLE vehiculos
  ADD CONSTRAINT fecha_entrada_salida
  CHECK (fechahoraentrada < fechahorasalida);

EXEC sp_helpconstraint vehiculos;

--Intente ingresar un valor que no cumpla con la primera restricción establecida en el campo 
--"fechahoraentrada":
INSERT INTO vehiculos VALUES('YHI444', 'moto', '2026-03-04 14:00', '2026-03-04 15:00');

-- Intente modificar un registro para que la salida sea anterior a la entrada:
UPDATE vehiculos SET fechahorasalida = '2007-01-17 07:00' WHERE patente = 'CAA258';
SELECT * FROM vehiculos;

--Vea todas las restricciones para la tabla "vehiculos"
EXEC sp_helpconstraint vehiculos;

--Establezca una restricción "default" para el campo "fechahoraentrada" para que almacene la fecha 
--actual del sistema:
ALTER TABLE vehiculos
  ADD CONSTRAINT DF_fechaentrada
  DEFAULT GETDATE()
  FOR fechahoraentrada;

--Ingrese un registro sin valor para "fechahoraentrada":
INSERT INTO vehiculos VALUES('CAU666', 'moto', DEFAULT, DEFAULT);
SELECT * FROM vehiculos;
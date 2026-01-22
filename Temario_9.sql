IF OBJECT_ID('usuarios') IS NOT NULL
    DROP TABLE usuarios;

CREATE TABLE usuarios(
    nombre VARCHAR(20),
    clave VARCHAR(10)    
);

GO

INSERT INTO usuarios(nombre, clave) VALUES('Marcelo', 'River');
INSERT INTO usuarios(nombre, clave) VALUES('Susana', 'Chapita');
INSERT INTO usuarios(nombre, clave) VALUES('Carlos Fuentes', 'Boca');
INSERT INTO usuarios(nombre, clave) VALUES('Federico Lopez', 'Boca');

SELECT * FROM usuarios;

UPDATE usuarios SET clave = 'RealMadrid';

SELECT * FROM usuarios;

UPDATE usuarios SET clave = 'Boca' WHERE nombre = 'Federico Lopez';

SELECT * FROM usuarios;

UPDATE usuarios SET clave = 'payaso' WHERE nombre='Juana Juarez';

SELECT * FROM usuarios;

UPDATE usuarios SET nombre = 'Marcelo Duarte', clave = 'Marce'
    WHERE nombre = 'Marcelo';

SELECT * FROM usuarios;

--EJERCICIOS--

--Ejercicio 1

IF OBJECT_ID('agenda') IS NOT NULL
    DROP TABLE agenda;

CREATE TABLE agenda(
    apellido VARCHAR(30),
    nombre VARCHAR(20),
    domicilio VARCHAR(30),
    telefono VARCHAR(11)
);

GO

 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Acosta','Alberto','Colon 123','4234567');
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Juarez','Juan','Avellaneda 135','4458787');
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Lopez','Maria','Urquiza 333','4545454');
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Lopez','Jose','Urquiza 333','4545454');
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Suarez','Susana','Gral. Paz 1234','4123456');

  SELECT * FROM agenda;

  UPDATE agenda SET nombre = 'Juan Jose' WHERE nombre = 'Juan';

  SELECT * FROM agenda;

  UPDATE agenda SET telefono = '4445556' WHERE telefono ='4545454';

  SELECT * FROM agenda;

  --Ejercicio 2

IF OBJECT_ID('libros') IS NOT NULL
   DROP TABLE libros;

CREATE TABLE libros(
    titulo VARCHAR(30),
    autor VARCHAR(20),
    editorial VARCHAR(15),
    precio FLOAT
);

GO

 insert into libros (titulo, autor, editorial, precio)
  values ('El aleph','Borges','Emece',25.00);
 insert into libros (titulo, autor, editorial, precio)
  values ('Martin Fierro','Jose Hernandez','Planeta',35.50);
 insert into libros (titulo, autor, editorial, precio)
  values ('Aprenda PHP','Mario Molina','Emece',45.50);
 insert into libros (titulo, autor, editorial, precio)
  values ('Cervantes y el quijote','Borges','Emece',25);
 insert into libros (titulo, autor, editorial, precio)
  values ('Matematica estas ahi','Paenza','Siglo XXI',15);

SELECT * FROM libros;

UPDATE libros SET autor = 'Adrian Paenza' WHERE autor = 'Paenza';

SELECT * FROM libros;

UPDATE libros SET precio = 27 WHERE autor = 'Mario Molina';

SELECT * FROM libros;

UPDATE libros SET editorial = 'Emece S.A.' WHERE editorial = 'Emece';

SELECT * FROM libros;




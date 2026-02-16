--Otros operadores relacionales (in)
IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40) NOT NULL,
    autor VARCHAR(20),
    editorial VARCHAR(20),
    precio DECIMAL(6,2)
);

GO

INSERT INTO libros VALUES('El aleph','Borges','Emece',15.90);
INSERT INTO libros VALUES('Cervantes y el quijote','Borges','Paidos',null);
INSERT INTO libros VALUES('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
INSERT INTO libros VALUES('Matematica estas ahi','Paenza','Siglo XXI',15);
INSERT INTO libros (titulo,precio) VALUES('Antología poética',32);
INSERT INTO libros (titulo,autor,precio) VALUES('Martin Fierro','Jose Hernandez',40);
INSERT INTO libros (titulo,autor,precio) VALUES('Aprenda PHP','Mario Molina',56.50);

SELECT * FROM libros WHERE autor IN ('Borges', 'Paenza');
SELECT * FROM libros WHERE autor NOT IN ('Borges', 'Paenza');

--Ejercicio 1
IF OBJECT_ID('medicamentos') IS NOT NULL
    DROP TABLE medicamentos;

CREATE TABLE medicamentos(
    codigo INT IDENTITY,
    nombre VARCHAR(20),
    laboratorio VARCHAR(20),
    precio DECIMAL(6,2),
    cantidad TINYINT,
    fechavencimiento DATETIME NOT NULL,
    PRIMARY KEY(codigo)
);

GO

INSERT INTO medicamentos VALUES('Sertal','Roche',5.2,1,'2015-02-01');
INSERT INTO medicamentos VALUES('Buscapina','Roche',4.10,3,'2016-03-01');
INSERT INTO medicamentos VALUES('Amoxidal 500','Bayer',15.60,100,'2017-05-01');
INSERT INTO medicamentos VALUES('Paracetamol 500','Bago',1.90,20,'2018-02-01');
INSERT INTO medicamentos VALUES('Bayaspirina','Bayer',2.10,150,'2019-12-01'); 
INSERT INTO medicamentos VALUES('Amoxidal jarabe','Bayer',5.10,250,'2020-10-01'); 

--Recupere los nombres y precios de los medicamentos cuyo laboratorio sea "Bayer" o "Bago" 
--empleando el operador "in" (4 registros)
SELECT nombre, precio FROM medicamentos WHERE laboratorio IN ('Bayer', 'Bago');

--Seleccione los remedios cuya cantidad se encuentre entre 1 y 5 empleando el operador "between" y 
--luego el operador "in" (2 registros):
SELECT * FROM medicamentos WHERE cantidad BETWEEN 1 AND 5;
SELECT * FROM medicamentos WHERE cantidad IN (1, 2, 3, 4, 5);

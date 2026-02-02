--Tipo de dato (texto)

IF OBJECT_ID('visitantes') IS NOT NULL
    DROP TABLE visitantes;

/* Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" 
   algunos datos de las personas que visitan o compran en su stand para luego enviarle 
   publicidad de sus productos. */
CREATE TABLE visitantes(
    nombre VARCHAR(30), --Se usa varchar cuando las cadenas varian en su lungitud
    edad INT,
    sexo CHAR(1), -- Usamos char cuando la cadena de texto siempre es fija
    domicilio VARCHAR(30),
    ciudad VARCHAR(20),
    telefono VARCHAR(11)
);

GO

-- Intentamos ingresar una cadena de mayor longitud que la definida 
-- en el campo sexo (se genera un error):
INSERT INTO visitantes(nombre, edad, sexo, domicilio, ciudad, telefono)
    VALUES('Daniel Lopez', '36', 'Masculino', 'Carrera 51', 'Caldas', '5590047');

-- Ingresamos un número telefónico olvidando las comillas, es decir, 
-- como un valor numérico (lo transforma a cadena):
INSERT INTO visitantes(nombre, edad, sexo, domicilio, ciudad, telefono)
    VALUES('Daniel Lopez', '36', 'M', 'Carrera 51', 'Caldas', 5590047);

SELECT * FROM visitantes;

--Ejercicio 1
IF OBJECT_ID('autos') IS NOT NULL
    DROP TABLE autos;

CREATE TABLE autos(
    patente CHAR(6),
    marcar VARCHAR(20),
    modelo CHAR(4),
    precio FLOAT
    PRIMARY KEY(patente)
);

GO

 insert into autos
  values('ACD123','Fiat 128','1970',15000);
 insert into autos
  values('ACG234','Renault 11','1990',40000);
 insert into autos
  values('BCD333','Peugeot 505','1990',80000);
 insert into autos
  values('GCD123','Renault Clio','1990',70000);
 insert into autos
  values('BCC333','Renault Megane','1998',95000);
 insert into autos
  values('BVF543','Fiat 128','1975',20000);


SELECT * FROM autos

SELECT * FROM autos WHERE modelo = '1990';
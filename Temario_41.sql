--Función grouping
/*
La función "grouping" se emplea con los operadores "rollup" y "cube" para distinguir los 
valores de detalle y de resumen en el resultado. Es decir, permite diferenciar si los 
valores "null" que aparecen en el resultado son valores nulos de las tablas o si 
son una fila generada por los operadores "rollup" o "cube".

Con esta función aparece una nueva columna en la salida, una por cada "grouping"; retorna el 
valor 1 para indicar que la fila representa los valores de resumen de "rollup" o "cube" y el 
valor 0 para representar los valores de campo.
*/

IF OBJECT_ID('visitantes') IS NOT NULL
    DROP TABLE visitantes;

CREATE TABLE visitantes(
    nombre VARCHAR(30),
    sexo CHAR(1),
    ciudad VARCHAR(20)
);

GO

INSERT INTO visitantes VALUES('Susana Molina', 'f', 'Cordoba');
INSERT INTO visitantes(nombre, sexo, ciudad) VALUES('Marcela Mercado', 'f', 'Cordoba');
INSERT INTO visitantes VALUES('Roberto Perez', 'f', NULL);
INSERT INTO visitantes VALUES('Alberto Garcia', 'm', 'Cordoba');
INSERT INTO visitantes VALUES('Teresa Garcia', 'f', 'Alta Gracia');

SELECT * FROM visitantes;

-- Contamos la cantidad de visitantes agrupando por ciudad y empleando "rollup":
SELECT ciudad, COUNT(*) FROM visitantes
    GROUP BY ciudad WITH ROLLUP;

-- Contamos la cantidad de visitantes agrupando por ciudad y empleando "rollup"
-- empleando grouping:
SELECT ciudad, COUNT(*) AS cantidad, GROUPING(ciudad) AS resumen
    FROM visitantes
    GROUP BY ciudad
    WITH ROLLUP;

--Ejercicio 1
 if object_id('empleados') is not null
  drop table empleados;

 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  sexo char(1),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20),
  primary key (documento)
 );

GO

 insert into empleados
  values ('22222222','Alberto Lopez','m','c','Sistemas');
 insert into empleados
  values ('23333333','Beatriz Garcia','f','c','Administracion');
 insert into empleados
  values ('24444444','Carlos Fuentes','m','s','Administracion');
 insert into empleados
  values ('25555555','Daniel Garcia','m','s','Sistemas');
 insert into empleados
  values ('26666666','Ester Juarez',null,'c','Sistemas');
 insert into empleados
  values ('27777777','Fabian Torres',null,'s','Sistemas');
 insert into empleados
  values ('28888888','Gabriela Lopez','f',null,'Sistemas');
 insert into empleados
  values ('29999999','Hector Garcia','m',null,'Administracion');

--Cuente la cantidad de empleados agrupados por sexo y estado civil, empleando "rollup".
SELECT sexo, estadocivil, COUNT(*) FROM empleados
    GROUP BY sexo, estadocivil WITH ROLLUP;

--Realice la misma consulta anterior pero emplee la función "grouping" para los dos campos por los 
--que se agrupa para distinguir los valores de resumen y de detalle.
SELECT sexo, estadocivil, COUNT(*) AS cantidad, 
    GROUPING(sexo) AS resumen_sexo, GROUPING(estadocivil) AS resumen_estadocivil 
    FROM empleados
    GROUP BY sexo, estadocivil WITH ROLLUP;

--Realice la misma consulta anterior pero con "cube" en lugar de "rollup", distinguiendo los 
--valores de resumen y de detalle.
SELECT sexo, estadocivil, COUNT(*) AS cantidad,
    GROUPING(sexo) AS resumen_sexo, GROUPING(estadocivil) AS resumen_estadocivil
    FROM empleados
    GROUP BY sexo, estadocivil WITH CUBE;
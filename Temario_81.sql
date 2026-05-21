IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

IF OBJECT_ID('autores') IS NOT NULL
    DROP TABLE autores;

CREATE TABLE editoriales(
    codigo TINYINT NOT NULL,
    nombre VARCHAR(30),
    CONSTRAINT PK_editoriales PRIMARY KEY (codigo)
);

CREATE TABLE autores(
    codigo INT NOT NULL
        CONSTRAINT CK_autores_codigo CHECK (codigo >= 0),
    nombre VARCHAR(30) NOT NULL,
    CONSTRAINT PK_autores_codigo
        PRIMARY KEY(codigo),
    CONSTRAINT UQ_autores_nombre
        UNIQUE (nombre)
);

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    codigoautor INT NOT NULL,
    codigoeditorial TINYINT NOT NULL,
    precio DECIMAL(5,2)
        CONSTRAINT DF_libros_precio DEFAULT(0),
    CONSTRAINT PK_libros_codigo
        PRIMARY KEY CLUSTERED(codigo),
    CONSTRAINT UQ_libros_tituloautor
        UNIQUE (titulo,codigoautor),
    CONSTRAINT FK_libros_editorial
        FOREIGN KEY (codigoeditorial)
        REFERENCES editoriales(codigo)
        ON UPDATE CASCADE,
    CONSTRAINT FK_libros_autor
        FOREIGN KEY (codigoautor)
        REFERENCES autores(codigo)
        ON UPDATE CASCADE,
    CONSTRAINT CK_libros_precio_positivo CHECK (precio >= 0)
);

GO

EXEC sp_helpconstraint editoriales;

EXEC sp_helpconstraint autores;

EXEC sp_helpconstraint libros;

--Ejercicio
IF OBJECT_ID('inscriptos') IS NOT NULL
    DROP TABLE inscriptos;

IF OBJECT_ID('profesores') IS NOT NULL
    DROP TABLE profesores;

IF OBJECT_ID('socios') IS NOT NULL
    DROP TABLE socios;

IF OBJECT_ID('deportes') IS NOT NULL
    DROP TABLE deportes;

CREATE TABLE socios(
    numero TINYINT IDENTITY,
    documento CHAR(8),
    nombre VARCHAR(30),
    domicilio VARCHAR(30),
    CONSTRAINT UQ_socios_documento
        UNIQUE(documento),
    CONSTRAINT UQ_socios_numero
        UNIQUE(numero),
    CONSTRAINT CK_socios_documento
        CHECK (documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT PK_socios_documento
        PRIMARY KEY (documento) 
);

CREATE TABLE deportes(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(30),
    dia VARCHAR(15)
     CONSTRAINT DF_deportes_dia DEFAULT 'Sabado',
    doc_profesor CHAR(8),
    CONSTRAINT CK_deportes_dia
        CHECK (dia IN ('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo')),
    CONSTRAINT PK_deportes_codigo
        PRIMARY KEY(codigo)
);

CREATE TABLE profesores(
    documento CHAR(8),
    nombre VARCHAR(30),
    domicilio VARCHAR(50),
    CONSTRAINT PK_profesores_documento
        PRIMARY KEY(documento),
    CONSTRAINT CK_profesores_documento
        CHECK (documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);



CREATE TABLE inscriptos(
    numero_socio TINYINT,
    cod_deporte TINYINT,
    pago_matricula CHAR(1) --s o n
    CONSTRAINT FK_inscriptos_numero_socio
        FOREIGN KEY (numero_socio)
        REFERENCES socios(numero),
    CONSTRAINT FK_inscriptos_cod_deporte
        FOREIGN KEY (cod_deporte)
        REFERENCES deportes(codigo),
    CONSTRAINT UQ_inscriptos_socio_deporte
        UNIQUE (numero_socio, cod_deporte),
    CONSTRAINT PK_inscriptos_socio_deporte
        PRIMARY KEY (numero_socio, cod_deporte),
    CONSTRAINT CK_inscriptos_pago_matricula
        CHECK (pago_matricula in ('s', 'n'))
);

GO

INSERT INTO profesores VALUES('21111111','Andres Acosta','Avellaneda 111');
INSERT INTO profesores VALUES('22222222','Betina Bustos','Bulnes 222');
INSERT INTO profesores VALUES('23333333','Carlos Caseros','Colon 333');

INSERT INTO deportes VALUES('basquet','lunes',NULL);
INSERT INTO deportes VALUES('futbol','lunes','23333333');
INSERT INTO deportes VALUES('natacion', NULL,'22222222');
INSERT INTO deportes VALUES('padle', DEFAULT,'23333333');
INSERT INTO deportes (nombre,dia) VALUES('tenis','jueves');

INSERT INTO socios VALUES('30111111','Ana Acosta','America 111');
INSERT INTO socios VALUES('30222222','Bernardo Bueno','Bolivia 222');
INSERT INTO socios VALUES('30333333','Camila Conte','Caseros 333');
INSERT INTO socios VALUES('30444444','Daniel Duarte','Dinamarca 444');

 INSERT INTO inscriptos VALUES(1,3,'s');
 INSERT INTO inscriptos VALUES(1,5,'s');
 INSERT INTO inscriptos VALUES(2,1,'s');
 INSERT INTO inscriptos VALUES(4,1,'n');
 INSERT INTO inscriptos VALUES(4,4,'s');

/*
Realice un "join" (del tipo que sea necesario) para mostrar todos los datos del socio junto con 
el nombre de los deportes en los cuales está inscripto, el día que tiene que asistir y el nombre del 
profesor que lo instruirá.
5 registros.
*/
 SELECT s.nombre, d.nombre, d.dia, p.nombre FROM inscriptos AS i
    LEFT JOIN socios AS s
        ON s.numero = i.numero_socio
    LEFT JOIN deportes AS d
        ON d.codigo = i.cod_deporte
    LEFT JOIN profesores AS p
        ON p.documento = d.doc_profesor;

--Realice la misma consulta anterior pero incluya los socios que no están inscriptos en ningún 
--deporte.
---6 registros.
 SELECT s.nombre, d.nombre, d.dia, p.nombre FROM inscriptos AS i
    LEFT JOIN socios AS s
        ON s.numero = i.numero_socio
    RIGHT JOIN deportes AS d
        ON d.codigo = i.cod_deporte
    LEFT JOIN profesores AS p
        ON p.documento = d.doc_profesor;

---Muestre todos los datos de los profesores, incluido el deporte que dicta y el día, incluyendo 
---los profesores que no tienen asignado ningún deporte.
---4 registros.
SELECT * FROM profesores;
SELECT * FROM deportes;
SELECT p.nombre, d.nombre, d.dia FROM profesores AS p
    LEFT JOIN deportes AS d
    ON d.doc_profesor = p.documento;

--Muestre todos los deportes y la cantidad de inscriptos, incluyendo aquellos deportes para los 
--cuales no hay inscriptos.
--5 registros.
SELECT d.nombre, COUNT(i.numero_socio) AS #_inscriptos FROM deportes AS d
    LEFT JOIN inscriptos AS i
    ON i.cod_deporte = d.codigo
    GROUP BY d.nombre;




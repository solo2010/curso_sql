--Combinación externa izquierda (left join)

IF OBJECT_ID('libros') IS NOT NULL
    DROP TABLE libros;

IF OBJECT_ID('editoriales') IS NOT NULL
    DROP TABLE editoriales;

CREATE TABLE libros(
    codigo INT IDENTITY,
    titulo VARCHAR(40),
    autor VARCHAR(30) DEFAULT 'Desconocido',
    codigoeditorial TINYINT NOT NULL,
    precio decimal(5,2)
);

CREATE TABLE editoriales(
    codigo TINYINT IDENTITY,
    nombre VARCHAR(20),
    PRIMARY KEY(codigo)
);

GO

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Siglo XXI');

INSERT INTO libros VALUES('El aleph','Borges',1,20);
INSERT INTO libros VALUES('Martin Fierro','Jose Hernandez',1,30);
INSERT INTO libros VALUES('Aprenda PHP','Mario Molina',2,50);
INSERT INTO libros VALUES('Java en 10 minutos',default,4,45);
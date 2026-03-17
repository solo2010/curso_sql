/*
SQL Server accede a los datos de dos maneras:

recorriendo las tablas; comenzando el principio y extrayendo los registros que cumplen las condiciones de la consulta.
empleando índices; recorriendo la estructura de árbol del índice para localizar los registros y extrayendo los que cumplen las condiciones de la consulta.
Los índices se emplean para facilitar la obtención de información de una tabla. El indice de una tabla desempeña la misma función que el índice de un libro: permite encontrar datos rápidamente; en el caso de las tablas, localiza registros.

Una tabla se indexa por un campo (o varios).

Un índice posibilita el acceso directo y rápido haciendo más eficiente las búsquedas. Sin índice, SQL Server debe recorrer secuencialmente toda la tabla para encontrar un registro.

El objetivo de un indice es acelerar la recuperación de información. La indexación es una técnica que optimiza el acceso a los datos, mejora el rendimiento acelerando las consultas y otras operaciones. Es útil cuando la tabla contiene miles de registros, cuando se realizan operaciones de ordenamiento y agrupamiento y cuando se combinan varias tablas (tema que veremos más adelante).

La desventaja es que consume espacio en el disco y genera costo de mantenimiento (tiempo y recursos).

Los índices más adecuados son aquellos creados con campos que contienen valores únicos.

Es importante identificar el o los campos por los que sería útil crear un índice, aquellos campos por los cuales se realizan búsqueda con frecuencia: claves primarias, claves externas o campos que combinan tablas.

No se recomienda crear índices por campos que no se usan con frecuencia en consultas o no contienen valores únicos.

SQL Server permite crear dos tipos de índices: 1) agrupados y 2) no agrupados.
*/
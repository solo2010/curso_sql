/*
Dijimos que SQL Server permite crear dos tipos de índices: 1) agrupados (clustered) y 2) no agrupados (nonclustered).

1) Un INDICE AGRUPADO es similar a una guía telefónica, los registros con el mismo valor de campo se agrupan juntos. Un índice agrupado determina la secuencia de almacenamiento de los registros en una tabla.
Se utilizan para campos por los que se realizan busquedas con frecuencia o se accede siguiendo un orden.
Una tabla sólo puede tener UN índice agrupado.
El tamaño medio de un índice agrupado es aproximadamente el 5% del tamaño de la tabla.

2) Un INDICE NO AGRUPADO es como el índice de un libro, los datos se almacenan en un lugar diferente al del índice, los punteros indican el lugar de almacenamiento de los elementos indizados en la tabla.
Un índice no agrupado se emplea cuando se realizan distintos tipos de busquedas frecuentemente, con campos en los que los datos son únicos.
Una tabla puede tener hasta 249 índices no agrupados.

Si no se especifica un tipo de índice, de modo predeterminado será no agrupado.

Los campos de tipo text, ntext e image no se pueden indizar.

Es recomendable crear los índices agrupados antes que los no agrupados, porque los primeros modifican el orden físico de los registros, ordenándolos secuencialmente.

La diferencia básica entre índices agrupados y no agrupados es que los registros de un índice agrupado están ordenados y almacenados de forma secuencial en función de su clave.

SQL Server crea automaticamente índices cuando se crea una restricción "primary key" o "unique" en una tabla.
Es posible crear índices en las vistas.

Resumiendo, los índices facilitan la recuperación de datos, permitiendo el acceso directo y acelerando las búsquedas, consultas y otras operaciones que optimizan el rendimiento general.

*/
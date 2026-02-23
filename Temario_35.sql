--Contar registros (count_big)
/*
La diferencia más obvia es el "techo".

COUNT() devuelve un valor INT. Si tu tabla tiene más de 2.147 mil millones de filas y ejecutas un COUNT(*), SQL Server arrojará un error de desbordamiento (overflow).

COUNT_BIG() está diseñado para el "Big Data". Devuelve un BIGINT, por lo que es prácticamente imposible que te quedes sin espacio para contar, sin importar qué tan grande sea tu base de datos.
*/
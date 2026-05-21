/* 
El procedimiento almacenado "sp_helpconstraint" devuelve las siguientes columnas:

- constraint_type: tipo de restricción. Si es una restricción de campo (default o check) indica sobre qué campo fue establecida. Si es de tabla (primary key o unique) indica el tipo de índice creado. Si es una "foreign key" lo indica.

- constraint_name: nombre de la restricción.

- delete_action: solamente es aplicable para restricciones de tipo "foreign key". Indica si la acción de eliminación actúa, no actúa o es en cascada. Indica "n/a" en cualquier restricción para la que no se aplique; "No Action" si no actúa y "Cascade" si es en cascada.

- update_action: sólo es aplicable para restricciones de tipo "foreign key". Indica si la acción de actualización es: No Action, Cascade, or n/a. Indica "n/a" en cualquier restricción para la que no se aplique.

- status_enabled: solamente es aplicable para restricciones de tipo "check" y "foreign key". Indica si está habilitada (Enabled) o no (Disabled). Indica "n/a" en cualquier restricción para la que no se aplique.

- status_for_replication: solamente es aplicable para restricciones de tipo "check" y "foreign key". Indica "n/a" en cualquier restricción para la que no se aplique.

- constraint_keys: Si es una restricción "default" muestra la condición de chequeo; si es una restricción "default", el valor por defecto; si es una "primary key", "unique" o "foreign key" muestra el/ los campos a los que se aplicaron la restricción. En caso de valores predeterminados y reglas, el texto que lo define.

 
*/
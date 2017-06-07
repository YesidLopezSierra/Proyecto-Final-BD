Intenté hacerlo, pero no me sirvió y me rendí
Error
Orden de ejecucion:
En la carpeta job, secuencias, ddl y trigger:
1. tablas_proyecto_bd ó crearTablas (la diferencia es que el tablas proyecto inserta algunos datos y crea tablas, mientras que crear tablas sólo las crea) 
2. Secuencias.sql
De las otras carpetas
3.Ejecutar scripts de carpetas de nivel 1
4. Ejecutar scripts de carpetas de nivel 2
5. Ejecutar scripts de carpetas de nivel 3
En la carpeta job, secuencias, ddl y trigger:
6.Job.sql
Opcional:
si se desean los triggers ejecutar 
1.TablaTriggerDeleteActividades.sql
2.TriggerDeleteActividades.sql
3. TriggersProyecto.sql


NOTA: si hay problemas con el jar eliminarlo y volverlo a adicionar a la aplicación
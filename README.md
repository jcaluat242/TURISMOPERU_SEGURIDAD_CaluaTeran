# TURISMOPERU_SEGURIDAD_CaluaTeran

Proyecto de la tercera evaluación de Base de Datos II.

El proyecto comprende la administración de usuarios, roles y permisos,
la importación y exportación de datos, los respaldos y la elaboración
de un reporte en Power BI.

## Tecnologías
- SQL Server
- SQL Server Management Studio
- Power BI Desktop
- Visual Studio Code
- Git y GitHub

## Base de datos
- Nombre: TURISMOPERU_JECT
- Esquema: JECT

## Autor
Jhon Emerson Calua Teran

---------------------------------------
## Principio de mínimo privilegio

No se debe asignar db_owner al vendedor ni al analista porque
permite administrar toda la base de datos, modificar su estructura
y gestionar permisos. Estas funciones exceden sus responsabilidades.

El vendedor recibe únicamente los permisos necesarios para consultar
y registrar clientes y reservas. El analista recibe permisos de lectura,
con INSERT, UPDATE y DELETE denegados en el esquema JECT.

La prueba en 04_seguridad/pruebas_permisos.sql se ejecutó con un
usuario temporal perteneciente a rol_analista. Permitió consultar
53 clientes y rechazó DELETE por falta de permisos.
Los permisos efectivos fueron: SELECT=1, INSERT=0, UPDATE=0, DELETE=0.

El usuario temporal sin login permitió comprobar el rol.
La creación de los logins solicitados sigue pendiente de los
permisos del administrador del servidor.
# Exportación y recuperación con BACPAC

Base de origen: TURISMOPERU_JECT.

Archivo: TURISMOPERU_JECT_Full.bacpac.
Contiene la estructura y los datos exportados mediante SSMS:
Tareas > Exportar aplicación de capa de datos > Guardar en disco local.

Para recuperarlo:
1. Conectarse a SQL Server con una cuenta autorizada para crear bases.
2. Clic derecho en Bases de datos > Importar aplicación de capa de datos.
3. Seleccionar el archivo BACPAC.
4. Usar una base nueva, por ejemplo TURISMOPERU_JECT_Restaurada.
5. Finalizar y comprobar las tablas y cantidades de registros.

La recuperación debe probarse en una base nueva.
El BACPAC es una exportación lógica; los backups nativos completos
y diferenciales utilizan archivos BAK y se documentan aparte.

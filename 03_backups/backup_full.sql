-- Ejecutar en SSMS. El archivo se guarda en el servidor.
-- Usar un archivo nuevo para esta cadena de respaldos.
BACKUP DATABASE TURISMOPERU_JECT
TO DISK = N'/var/opt/mssql/data/JECT_eval_20261002_full.bak'
WITH NOINIT, CHECKSUM, STATS = 10;

-- Ejecutar por el administrador.
-- Restaurar en una base nueva; no reemplazar la original.
-- FILE = 1 supone archivos nuevos con un solo respaldo.
USE master;

IF DB_ID(N'TURISMOPERU_JECT_Recuperada') IS NOT NULL
    THROW 50001, 'La base destino ya existe. Elegir otro nombre.', 1;

RESTORE DATABASE TURISMOPERU_JECT_Recuperada
FROM DISK = N'/var/opt/mssql/data/JECT_eval_20261002_full.bak'
WITH FILE = 1,
MOVE N'TURISMOPERU_JECT'
TO N'/var/opt/mssql/data/TURISMOPERU_JECT_Recuperada.mdf',
MOVE N'TURISMOPERU_JECT_log'
TO N'/var/opt/mssql/data/TURISMOPERU_JECT_Recuperada_log.ldf',
NORECOVERY, CHECKSUM, STATS = 10;

RESTORE DATABASE TURISMOPERU_JECT_Recuperada
FROM DISK = N'/var/opt/mssql/data/JECT_eval_20261002_diff.bak'
WITH FILE = 1, RECOVERY, CHECKSUM, STATS = 10;

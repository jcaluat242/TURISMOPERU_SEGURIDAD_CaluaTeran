-- Ejecutar después del backup completo.
-- No realizar otro backup completo normal entre ambos.
BACKUP DATABASE TURISMOPERU_JECT
TO DISK = N'/var/opt/mssql/data/JECT_eval_20261002_diff.bak'
WITH DIFFERENTIAL, NOINIT, CHECKSUM, STATS = 10;

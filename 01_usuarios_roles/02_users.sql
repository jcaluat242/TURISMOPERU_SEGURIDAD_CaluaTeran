-- Ejecutar después de 01_logins.sql y 03_roles.sql.
-- Pendiente de ejecución hasta que el administrador cree los logins.
USE TURISMOPERU_JECT;
GO

IF DATABASE_PRINCIPAL_ID(N'vendedor_JECT') IS NULL
    CREATE USER vendedor_JECT FOR LOGIN vendedor_JECT
    WITH DEFAULT_SCHEMA = JECT;
GO

IF DATABASE_PRINCIPAL_ID(N'analista_JECT') IS NULL
    CREATE USER analista_JECT FOR LOGIN analista_JECT
    WITH DEFAULT_SCHEMA = JECT;
GO

ALTER ROLE rol_vendedor ADD MEMBER vendedor_JECT;
ALTER ROLE rol_analista ADD MEMBER analista_JECT;
GO

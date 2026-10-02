USE [TURISMOPERU_JECT];
GO

-- Crear el rol vendedor si todavía no existe.
IF DATABASE_PRINCIPAL_ID(N'rol_vendedor') IS NULL
BEGIN
    CREATE ROLE [rol_vendedor] AUTHORIZATION [dbo];
END;
GO

-- Crear el rol analista si todavía no existe.
IF DATABASE_PRINCIPAL_ID(N'rol_analista') IS NULL
BEGIN
    CREATE ROLE [rol_analista] AUTHORIZATION [dbo];
END;
GO

-- Comprobar los roles.
SELECT name AS Rol, type_desc AS Tipo
FROM sys.database_principals
WHERE name IN (N'rol_vendedor', N'rol_analista')
  AND type = 'R';
GO
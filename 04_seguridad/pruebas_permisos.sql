USE [TURISMOPERU_JECT];
GO

-- Usuario temporal para probar el rol.
-- No reemplaza los logins pendientes del profesor.
IF DATABASE_PRINCIPAL_ID(N'prueba_analista_JECT') IS NOT NULL
    THROW 50001, 'El usuario de prueba ya existe. Revisarlo antes de continuar.', 1;

CREATE USER [prueba_analista_JECT] WITHOUT LOGIN;
ALTER ROLE [rol_analista] ADD MEMBER [prueba_analista_JECT];

EXECUTE AS USER = N'prueba_analista_JECT';

BEGIN TRY
    SELECT USER_NAME() AS UsuarioPrueba;
    SELECT COUNT(*) AS TotalClientes FROM JECT.cliente;

    SELECT
        HAS_PERMS_BY_NAME(N'JECT.cliente', N'OBJECT', N'SELECT') AS PuedeConsultar,
        HAS_PERMS_BY_NAME(N'JECT.cliente', N'OBJECT', N'INSERT') AS PuedeInsertar,
        HAS_PERMS_BY_NAME(N'JECT.cliente', N'OBJECT', N'UPDATE') AS PuedeActualizar,
        HAS_PERMS_BY_NAME(N'JECT.cliente', N'OBJECT', N'DELETE') AS PuedeEliminar;

    -- WHERE 1=0 evita borrar datos incluso si hubiera un permiso incorrecto.
    BEGIN TRY
        DELETE FROM JECT.cliente WHERE 1 = 0;
        SELECT N'FALLO: DELETE fue permitido' AS Resultado;
    END TRY
    BEGIN CATCH
        SELECT
            CASE WHEN ERROR_NUMBER() = 229
                THEN N'CORRECTO: DELETE rechazado por permisos'
                ELSE N'REVISAR: otro error'
            END AS Resultado,
            ERROR_MESSAGE() AS Detalle;
    END CATCH;
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS Error, ERROR_MESSAGE() AS Detalle;
END CATCH;

REVERT;
DROP USER [prueba_analista_JECT];
GO
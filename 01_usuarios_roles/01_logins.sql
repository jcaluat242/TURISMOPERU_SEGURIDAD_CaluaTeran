-- Ejecutar por el administrador en modo SQLCMD.
-- Proporcionar ClaveVendedor y ClaveAnalista al ejecutar.
-- No guardar contraseñas reales en GitHub.
USE master;
GO
CREATE LOGIN vendedor_JECT
WITH PASSWORD = '$(ClaveVendedor)', CHECK_POLICY = ON;
GO
CREATE LOGIN analista_JECT
WITH PASSWORD = '$(ClaveAnalista)', CHECK_POLICY = ON;
GO

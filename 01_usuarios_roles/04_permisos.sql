USE [TURISMOPERU_JECT];
GO

-- VENDEDOR: consultar y registrar clientes y reservas.
GRANT SELECT, INSERT ON OBJECT::JECT.cliente
TO rol_vendedor;

GRANT SELECT, INSERT ON OBJECT::JECT.reserva
TO rol_vendedor;

-- Consultar alojamientos y habitaciones.
GRANT SELECT ON OBJECT::JECT.alojamiento
TO rol_vendedor;

GRANT SELECT ON OBJECT::JECT.habitacion
TO rol_vendedor;

-- Prohibir la eliminación de clientes y reservas.
DENY DELETE ON OBJECT::JECT.cliente
TO rol_vendedor;

DENY DELETE ON OBJECT::JECT.reserva
TO rol_vendedor;

-- Prohibir la administración de usuarios, roles y backups.
DENY CREATE USER, ALTER ANY USER,
     CREATE ROLE, ALTER ANY ROLE,
     BACKUP DATABASE, BACKUP LOG
TO rol_vendedor;
GO

-- ANALISTA: consultar las siete tablas solicitadas.
GRANT SELECT ON OBJECT::JECT.cliente TO rol_analista;
GRANT SELECT ON OBJECT::JECT.reserva TO rol_analista;
GRANT SELECT ON OBJECT::JECT.pago TO rol_analista;
GRANT SELECT ON OBJECT::JECT.alojamiento TO rol_analista;
GRANT SELECT ON OBJECT::JECT.habitacion TO rol_analista;
GRANT SELECT ON OBJECT::JECT.paquete TO rol_analista;
GRANT SELECT ON OBJECT::JECT.lugar_turistico TO rol_analista;

-- Prohibir modificaciones en las tablas del esquema JECT.
DENY INSERT, UPDATE, DELETE ON SCHEMA::JECT
TO rol_analista;
GO
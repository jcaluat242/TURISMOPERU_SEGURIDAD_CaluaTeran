USE TURISMOPERU_JECT;
GO

-- Indicadores generales, sin duplicar pagos mediante joins.
SELECT
    (SELECT COUNT(*) FROM JECT.reserva) AS TotalReservas,
    (SELECT COUNT(*) FROM JECT.cliente) AS TotalClientes,
    (SELECT SUM(monto) FROM JECT.pago) AS TotalIngresos,
    (SELECT SUM(monto) FROM JECT.pago) /
    NULLIF((SELECT COUNT(*) FROM JECT.reserva), 0) AS TicketPromedio;

-- Reservas por estado.
SELECT e.nombre, COUNT(*) AS TotalReservas
FROM JECT.reserva r
JOIN JECT.estado_reserva e ON e.id_estado_reserva = r.id_estado_reserva
GROUP BY e.nombre
ORDER BY TotalReservas DESC;

-- Ingresos por medio de pago.
SELECT m.nombre, SUM(p.monto) AS TotalIngresos
FROM JECT.pago p
JOIN JECT.medio_pago m ON m.id_medio_pago = p.id_medio_pago
GROUP BY m.nombre
ORDER BY TotalIngresos DESC;

-- Reservas por día.
SELECT CAST(fecha_reserva AS date) AS Fecha, COUNT(*) AS TotalReservas
FROM JECT.reserva
GROUP BY CAST(fecha_reserva AS date)
ORDER BY Fecha;

-- Diez clientes con más reservas; desempate por identificador.
SELECT TOP (10) c.id_persona, p.razon_social, COUNT(*) AS TotalReservas
FROM JECT.reserva r
JOIN JECT.cliente c ON c.id_persona = r.id_cliente
JOIN JECT.persona p ON p.id_persona = c.id_persona
GROUP BY c.id_persona, p.razon_social
ORDER BY TotalReservas DESC, c.id_persona;

-- Ingresos por cliente.
SELECT c.id_persona, pe.razon_social, SUM(pa.monto) AS TotalIngresos
FROM JECT.pago pa
JOIN JECT.reserva r ON r.id_reserva = pa.id_reserva
JOIN JECT.cliente c ON c.id_persona = r.id_cliente
JOIN JECT.persona pe ON pe.id_persona = c.id_persona
GROUP BY c.id_persona, pe.razon_social
ORDER BY TotalIngresos DESC;

# Informe Power BI
Archivo: TurismoPeru_JECT.pbix.
Origen: SQL Server, base TURISMOPERU_JECT, esquema JECT.
Modo de conexión: Importación. Las credenciales se configuran en Power BI.

## Modelo
Cliente relacionado con reserva; reserva relacionada con pago.
Estado de reserva y medio de pago permiten agrupar los resultados.

## Indicadores
- Total Reservas: DISTINCTCOUNT('JECT reserva'[id_reserva])
- Total Ingresos: SUM('JECT pago'[monto])
- Total Clientes: DISTINCTCOUNT('JECT cliente'[id_persona])
- Ticket Promedio: DIVIDE([Total Ingresos], [Total Reservas], 0)

## Visualizaciones
Reservas por estado, ingresos por medio de pago, reservas por fecha,
clientes por cantidad de reservas e ingresos por cliente.
Pendiente comprobar el filtro Top 10 de clientes.

## Conclusiones
1. El informe registra 102 reservas y 54 clientes.
2. Los pagos suman aproximadamente 353,78 mil según la tarjeta.
3. El ingreso por reserva es aproximadamente 3,47 mil; se calcula dividiendo los pagos entre las reservas.
4. Completada es el estado con mayor cantidad de reservas; Pendiente ocupa el segundo lugar.
5. Visa concentra el mayor ingreso, seguida de Mastercard; Plin registra el menor entre los medios mostrados.

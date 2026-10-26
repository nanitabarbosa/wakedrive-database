-- Datos de ejemplo de alertas (1 000 filas), cargados con COPY desde dml/data/alerts.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
-- trg_validate_alert queda activo: cada alerta se valida contra su vinculación al cargarse.
\copy public.alerts (alert_id, duration_seconds, detected_at, device_id, driver_id, event_type_id, vehicle_id, level, location) FROM 'dml/data/alerts.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.alerts', 'alert_id'), (SELECT max(alert_id) FROM public.alerts));

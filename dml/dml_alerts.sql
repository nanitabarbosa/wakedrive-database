-- Cargamos los datos de ejemplo de alertas (1 000 filas) con COPY desde dml/data/alerts.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
-- Dejamos activo trg_validate_alert: cada alerta se valida contra su vinculación al cargarla.
\copy wakedrive.alerts (alert_id, duration_seconds, detected_at, device_id, driver_id, event_type_id, vehicle_id, level, location) FROM 'dml/data/alerts.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.alerts', 'alert_id'), (SELECT max(alert_id) FROM wakedrive.alerts));

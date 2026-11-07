-- Cargamos los datos de ejemplo de notificaciones (1 000 filas) con COPY desde dml/data/notifications.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.notifications (notification_id, read, company_id, created_at, type, title, message) FROM 'dml/data/notifications.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.notifications', 'notification_id'), (SELECT max(notification_id) FROM wakedrive.notifications));

-- Datos de ejemplo de notificaciones (1 250 filas), cargados con COPY desde dml/data/notifications.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.notifications (notification_id, read, company_id, created_at, type, title, message) FROM 'dml/data/notifications.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.notifications', 'notification_id'), (SELECT max(notification_id) FROM public.notifications));

-- Datos de ejemplo de dispositivos (1 250 filas), cargados con COPY desde dml/data/devices.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.devices (device_id, company_id, created_at, last_connection, status, serial) FROM 'dml/data/devices.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.devices', 'device_id'), (SELECT max(device_id) FROM public.devices));

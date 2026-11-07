-- Cargamos los datos de ejemplo de dispositivos (50 filas) con COPY desde dml/data/devices.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.devices (device_id, company_id, created_at, last_connection, status, serial) FROM 'dml/data/devices.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.devices', 'device_id'), (SELECT max(device_id) FROM wakedrive.devices));

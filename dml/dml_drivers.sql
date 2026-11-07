-- Cargamos los datos de ejemplo de conductores (50 filas) con COPY desde dml/data/drivers.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.drivers (driver_id, company_id, created_at, document, phone, status, email, full_name) FROM 'dml/data/drivers.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.drivers', 'driver_id'), (SELECT max(driver_id) FROM wakedrive.drivers));

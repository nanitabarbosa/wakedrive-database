-- Datos de ejemplo de conductores (1 250 filas), cargados con COPY desde dml/data/drivers.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.drivers (driver_id, company_id, created_at, document, phone, status, email, full_name) FROM 'dml/data/drivers.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.drivers', 'driver_id'), (SELECT max(driver_id) FROM public.drivers));

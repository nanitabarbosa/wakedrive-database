-- Datos de ejemplo de vehículos (1 250 filas), cargados con COPY desde dml/data/vehicles.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.vehicles (vehicle_id, year, plate, brand_id, company_id, created_at, vehicle_type_id, status, model) FROM 'dml/data/vehicles.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.vehicles', 'vehicle_id'), (SELECT max(vehicle_id) FROM public.vehicles));

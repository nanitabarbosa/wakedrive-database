-- Cargamos los datos de ejemplo de vehículos (20 filas) con COPY desde dml/data/vehicles.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.vehicles (vehicle_id, year, plate, brand_id, company_id, created_at, vehicle_type_id, status, model) FROM 'dml/data/vehicles.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.vehicles', 'vehicle_id'), (SELECT max(vehicle_id) FROM wakedrive.vehicles));

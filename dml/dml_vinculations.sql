-- Cargamos los datos de ejemplo de vinculaciones (19 filas) con COPY desde dml/data/vinculations.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.vinculations (vinculation_id, device_id, driver_id, linked_at, vehicle_id) FROM 'dml/data/vinculations.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.vinculations', 'vinculation_id'), (SELECT max(vinculation_id) FROM wakedrive.vinculations));

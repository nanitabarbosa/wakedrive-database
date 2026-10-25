-- Datos de ejemplo de vinculaciones (1 249 filas), cargados con COPY desde dml/data/vinculations.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.vinculations (vinculation_id, device_id, driver_id, linked_at, vehicle_id) FROM 'dml/data/vinculations.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.vinculations', 'vinculation_id'), (SELECT max(vinculation_id) FROM public.vinculations));

-- Datos de ejemplo de solicitudes de acceso (60 filas), cargados con COPY desde dml/data/access_requests.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.access_requests (access_request_id, city_id, created_at, admin_phone, company_phone, nit, status, admin_email, admin_name, company_name, address) FROM 'dml/data/access_requests.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.access_requests', 'access_request_id'), (SELECT max(access_request_id) FROM public.access_requests));

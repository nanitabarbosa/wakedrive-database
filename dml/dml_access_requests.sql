-- Cargamos los datos de ejemplo de solicitudes de acceso (60 filas) con COPY desde dml/data/access_requests.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.access_requests (access_request_id, city_id, created_at, admin_phone, company_phone, nit, status, admin_email, admin_name, company_name, address) FROM 'dml/data/access_requests.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.access_requests', 'access_request_id'), (SELECT max(access_request_id) FROM wakedrive.access_requests));

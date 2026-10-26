-- Datos de ejemplo de tokens de sesión (1 000 filas), cargados con COPY desde dml/data/refresh_token.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.refresh_token (id, expires_at, user_id, token) FROM 'dml/data/refresh_token.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.refresh_token', 'id'), (SELECT max(id) FROM public.refresh_token));

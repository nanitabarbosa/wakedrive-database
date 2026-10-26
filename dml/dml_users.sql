-- Datos de ejemplo de usuarios (1 000 filas), cargados con COPY desde dml/data/users.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.users (user_id, must_change_password, company_id, reset_token_expiry, role_id, email, name, password, reset_token) FROM 'dml/data/users.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.users', 'user_id'), (SELECT max(user_id) FROM public.users));

-- Cargamos los datos de ejemplo de usuarios (1 000 filas) con COPY desde dml/data/users.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.users (user_id, must_change_password, company_id, reset_token_expiry, role_id, email, name, password, reset_token) FROM 'dml/data/users.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.users', 'user_id'), (SELECT max(user_id) FROM wakedrive.users));

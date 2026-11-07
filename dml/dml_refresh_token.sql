-- Cargamos los datos de ejemplo de tokens de sesión (1 000 filas) con COPY desde dml/data/refresh_token.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.refresh_token (id, expires_at, user_id, token) FROM 'dml/data/refresh_token.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.refresh_token', 'id'), (SELECT max(id) FROM wakedrive.refresh_token));

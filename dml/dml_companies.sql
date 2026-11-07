-- Cargamos los datos de ejemplo de empresas (50 filas) con COPY desde dml/data/companies.csv.
-- Lo ejecutamos desde la carpeta raíz del repositorio, porque la ruta del CSV es relativa.
\copy wakedrive.companies (company_id, alarm_duration_seconds, face_recognition_always, notify_device_shutdown, alarm_sound_size, logo_size, phone, nit, email, name, address, alarm_sound_name, alarm_sound_path, logo_name, logo_path, status, city_id) FROM 'dml/data/companies.csv' WITH (FORMAT csv, HEADER)

-- Cargamos las filas con su id y ajustamos la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('wakedrive.companies', 'company_id'), (SELECT max(company_id) FROM wakedrive.companies));

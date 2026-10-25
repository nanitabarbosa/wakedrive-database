-- Datos de ejemplo de empresas (1 250 filas), cargados con COPY desde dml/data/companies.csv.
-- Ejecutar desde la carpeta raíz del repositorio (la ruta del CSV es relativa).
\copy public.companies (company_id, alarm_duration_seconds, face_recognition_always, notify_device_shutdown, alarm_sound_size, logo_size, phone, nit, email, name, address, alarm_sound_name, alarm_sound_path, logo_name, logo_path, status, city_id, created_at, updated_at, created_by, updated_by) FROM 'dml/data/companies.csv' WITH (FORMAT csv, HEADER)

-- Las filas se cargan con su id: se ajusta la secuencia para que los nuevos registros continúen desde el último.
SELECT setval(pg_get_serial_sequence('public.companies', 'company_id'), (SELECT max(company_id) FROM public.companies));

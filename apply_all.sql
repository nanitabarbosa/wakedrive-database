-- Crea la base de datos completa de WakeDrive sobre el esquema public.
-- Ejecutar desde esta carpeta:  psql -U postgres -d wakedrive -v ON_ERROR_STOP=1 -f apply_all.sql

-- 1. Tablas principales
\i ddl/ddl_roles.sql
\i ddl/ddl_cities.sql
\i ddl/ddl_brands.sql
\i ddl/ddl_vehicle_types.sql
\i ddl/ddl_event_types.sql
\i ddl/ddl_companies.sql
\i ddl/ddl_users.sql
\i ddl/ddl_refresh_token.sql
\i ddl/ddl_access_requests.sql
\i ddl/ddl_vehicles.sql
\i ddl/ddl_devices.sql
\i ddl/ddl_drivers.sql
\i ddl/ddl_vinculations.sql
\i ddl/ddl_alerts.sql
\i ddl/ddl_notifications.sql
\i ddl/ddl_foreign_keys.sql

-- 2. Auditoría: una tabla audi_* por cada tabla maestra del negocio
\i audit/ddl/ddl_audi_users.sql
\i audit/ddl/ddl_audi_vinculations.sql
\i audit/ddl/ddl_audi_companies.sql

-- 3. Triggers de negocio y de auditoría
\i triggers/trg_validate_alert.sql
\i triggers/trg_validate_vinculation.sql
\i triggers/trg_protect_alerts.sql
\i audit/triggers/trg_audi_users.sql
\i audit/triggers/trg_audi_vinculations.sql
\i audit/triggers/trg_audi_companies.sql

-- 4. Datos de ejemplo (DML)
\i dml/dml_roles.sql
\i dml/dml_cities.sql
\i dml/dml_brands.sql
\i dml/dml_vehicle_types.sql
\i dml/dml_event_types.sql
\i dml/dml_companies.sql
\i dml/dml_users.sql
\i dml/dml_refresh_token.sql
\i dml/dml_access_requests.sql
\i dml/dml_vehicles.sql
\i dml/dml_devices.sql
\i dml/dml_drivers.sql
\i dml/dml_vinculations.sql
\i dml/dml_alerts.sql
\i dml/dml_notifications.sql

-- 5. Índices (al final, para acelerar la carga masiva)
\i indexes/idx_alerts.sql

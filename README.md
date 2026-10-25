# wakedrive-database

Scripts de la base de datos de **WakeDrive** (PostgreSQL), plataforma de monitoreo de somnolencia de conductores.

## Estructura

```
wakedrive-database/
├── audit/
│   ├── ddl/
│   │   ├── ddl_audi_companies.sql
│   │   ├── ddl_audi_users.sql
│   │   └── ddl_audi_vinculations.sql
│   └── triggers/
│       ├── trg_audi_companies.sql
│       ├── trg_audi_users.sql
│       └── trg_audi_vinculations.sql
├── ddl/
│   ├── ddl_access_requests.sql
│   ├── ddl_alerts.sql
│   ├── ddl_brands.sql
│   ├── ddl_cities.sql
│   ├── ddl_companies.sql
│   ├── ddl_devices.sql
│   ├── ddl_drivers.sql
│   ├── ddl_event_types.sql
│   ├── ddl_foreign_keys.sql
│   ├── ddl_notifications.sql
│   ├── ddl_refresh_token.sql
│   ├── ddl_roles.sql
│   ├── ddl_users.sql
│   ├── ddl_vehicle_types.sql
│   ├── ddl_vehicles.sql
│   └── ddl_vinculations.sql
├── dml/
│   ├── dml_access_requests.sql
│   ├── dml_alerts.sql
│   ├── dml_brands.sql
│   ├── dml_cities.sql
│   ├── dml_companies.sql
│   ├── dml_devices.sql
│   ├── dml_drivers.sql
│   ├── dml_event_types.sql
│   ├── dml_notifications.sql
│   ├── dml_refresh_token.sql
│   ├── dml_roles.sql
│   ├── dml_users.sql
│   ├── dml_vehicle_types.sql
│   ├── dml_vehicles.sql
│   └── dml_vinculations.sql
├── docs/
│   ├── c4_nivel1_contexto.png
│   ├── c4_nivel2_contenedores.png
│   ├── modelo_conceptual.png
│   ├── modelo_fisico.png
│   └── modelo_logico.png
├── indexes/
│   └── idx_alerts.sql
├── triggers/
│   ├── trg_protect_alerts.sql
│   ├── trg_validate_alert.sql
│   └── trg_validate_vinculation.sql
├── .gitignore
├── README.md
└── apply_all.sql
```

| Carpeta o archivo | Contenido |
|---|---|
| `ddl/` | Una tabla por archivo (15) y `ddl_foreign_keys.sql` con las claves foráneas. |
| `audit/` | Tablas de auditoría (`audi_users`, `audi_vinculations` y `audi_companies`) y sus triggers. |
| `triggers/` | Triggers de reglas de negocio (alertas y vinculaciones). |
| `dml/` | Datos de ejemplo. |
| `indexes/` | Índices de la tabla `alerts`. |
| `docs/` | Diagramas del modelo (conceptual, lógico y físico) y de arquitectura (C4). |
| `apply_all.sql` | Crea la base de datos completa ejecutando todos los scripts en orden. |

## Integrantes

- Mariana Barbosa Torrado
- Euder Julian Pacheco Ascanio
- Hannah Cabarico Salazar

Universidad Francisco de Paula Santander Ocaña · Bases de datos relacionales.

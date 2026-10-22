# wakedrive-database

Scripts y documentación de la base de datos de **WakeDrive** (PostgreSQL): plataforma de monitoreo de somnolencia de conductores. El documento completo del diseño está en el entregable *Documento de especificación del diseño e implementación de la Base de Datos*.

## Estructura del repositorio

```
wakedrive-database/
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
├── docs/
│   ├── c4_nivel1_contexto.png
│   ├── c4_nivel2_contenedores.png
│   ├── modelo_conceptual.png
│   ├── modelo_fisico.png
│   └── modelo_logico.png
├── .gitignore
└── README.md
```

| Contenido | Descripción |
|---|---|
| `docs/` | Diagramas del modelo (conceptual, lógico y físico) y de arquitectura (C4). |
| `ddl/` | Una tabla por archivo (15 tablas) y `ddl_foreign_keys.sql` con todas las claves foráneas. Reflejan el esquema que genera Hibernate en el backend. |

## Modelos

### Modelo conceptual
![Modelo conceptual](docs/modelo_conceptual.png)

### Modelo lógico
![Modelo lógico](docs/modelo_logico.png)

### Modelo físico
![Modelo físico](docs/modelo_fisico.png)

El diagrama físico corresponde a la cuarta versión del modelo (14 tablas).

### Arquitectura (modelo C4)
![C4 nivel 1: contexto del sistema](docs/c4_nivel1_contexto.png)

![C4 nivel 2: contenedores](docs/c4_nivel2_contenedores.png)

## Tablas principales

Convenciones: `pk` llave primaria, `uk` llave única, `fkN` llave foránea; opcionalidad `*` obligatorio y `o` opcional. Todas las claves foráneas impiden eliminar registros referenciados.

### Tabla 1. ROLES (RLS)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | role_id | BIGINT |  |  |
| uk | * | name | VARCHAR | 255 |  |

Script: [`ddl/ddl_roles.sql`](ddl/ddl_roles.sql)

### Tabla 2. CITIES (CTY)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | city_id | BIGINT |  |  |
| uk | * | name | VARCHAR | 255 |  |

Script: [`ddl/ddl_cities.sql`](ddl/ddl_cities.sql)

### Tabla 3. BRANDS (BRN)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | brand_id | BIGINT |  |  |
| uk | * | name | VARCHAR | 255 |  |

Script: [`ddl/ddl_brands.sql`](ddl/ddl_brands.sql)

### Tabla 4. VEHICLE_TYPES (VTP)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | vehicle_type_id | BIGINT |  |  |
| uk | * | name | VARCHAR | 255 |  |

Script: [`ddl/ddl_vehicle_types.sql`](ddl/ddl_vehicle_types.sql)

### Tabla 5. EVENT_TYPES (EVT)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | event_type_id | BIGINT |  |  |
| uk | * | name | VARCHAR | 255 |  |

Script: [`ddl/ddl_event_types.sql`](ddl/ddl_event_types.sql)

### Tabla 6. COMPANIES (CMP)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | company_id | BIGINT |  |  |
|  | * | alarm_duration_seconds | INTEGER |  |  |
|  | * | face_recognition_always | BOOLEAN |  |  |
|  | * | notify_device_shutdown | BOOLEAN |  |  |
|  | o | alarm_sound_size | BIGINT |  |  |
|  | o | logo_size | BIGINT |  |  |
|  | o | phone | VARCHAR | 20 |  |
| uk | * | nit | VARCHAR | 30 |  |
|  | o | address | VARCHAR | 150 |  |
|  | o | alarm_sound_name | VARCHAR | 255 |  |
|  | o | alarm_sound_path | VARCHAR | 255 |  |
|  | o | email | VARCHAR | 255 |  |
|  | o | logo_name | VARCHAR | 255 |  |
|  | o | logo_path | VARCHAR | 255 |  |
|  | * | name | VARCHAR | 255 |  |

Script: [`ddl/ddl_companies.sql`](ddl/ddl_companies.sql)

### Tabla 7. USERS (USR)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | user_id | BIGINT |  |  |
|  | o | must_change_password | BOOLEAN |  |  |
| fk1 | o | company_id | BIGINT |  | companies(company_id) |
|  | o | reset_token_expiry | TIMESTAMP |  |  |
| fk2 | * | role_id | BIGINT |  | roles(role_id) |
| uk | * | email | VARCHAR | 255 |  |
|  | * | name | VARCHAR | 255 |  |
|  | * | password | VARCHAR | 255 |  |
|  | o | reset_token | VARCHAR | 255 |  |

Script: [`ddl/ddl_users.sql`](ddl/ddl_users.sql)

### Tabla 8. REFRESH_TOKEN (RFT)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | id | BIGINT |  |  |
|  | * | expires_at | TIMESTAMP |  |  |
| fk1 | * | user_id | BIGINT |  | users(user_id) |
| uk | * | token | VARCHAR | 255 |  |

Script: [`ddl/ddl_refresh_token.sql`](ddl/ddl_refresh_token.sql)

### Tabla 9. ACCESS_REQUESTS (ARQ)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | access_request_id | BIGINT |  |  |
| fk1 | * | city_id | BIGINT |  | cities(city_id) |
|  | * | created_at | TIMESTAMP |  |  |
|  | * | nit | VARCHAR | 30 |  |
|  | * | address | VARCHAR | 255 |  |
|  | * | admin_email | VARCHAR | 255 |  |
|  | * | admin_name | VARCHAR | 255 |  |
|  | * | admin_phone | VARCHAR | 255 |  |
|  | * | company_name | VARCHAR | 255 |  |
|  | * | company_phone | VARCHAR | 255 |  |
|  | * | status | VARCHAR | 255 |  |

Script: [`ddl/ddl_access_requests.sql`](ddl/ddl_access_requests.sql)

### Tabla 10. VEHICLES (VHC)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | vehicle_id | BIGINT |  |  |
|  | * | year | INTEGER |  |  |
| fk1 | * | brand_id | BIGINT |  | brands(brand_id) |
| fk2 | * | company_id | BIGINT |  | companies(company_id) |
|  | * | created_at | TIMESTAMP |  |  |
| fk3 | * | vehicle_type_id | BIGINT |  | vehicle_types(vehicle_type_id) |
| uk | * | plate | VARCHAR | 15 |  |
|  | * | model | VARCHAR | 255 |  |
|  | * | status | VARCHAR | 255 |  |

Script: [`ddl/ddl_vehicles.sql`](ddl/ddl_vehicles.sql)

### Tabla 11. DEVICES (DVC)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | device_id | BIGINT |  |  |
| fk1 | * | company_id | BIGINT |  | companies(company_id) |
|  | * | created_at | TIMESTAMP |  |  |
|  | o | last_connection | TIMESTAMP |  |  |
| uk | * | serial | VARCHAR | 255 |  |
|  | * | status | VARCHAR | 255 |  |

Script: [`ddl/ddl_devices.sql`](ddl/ddl_devices.sql)

### Tabla 12. DRIVERS (DRV)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | driver_id | BIGINT |  |  |
| fk1 | * | company_id | BIGINT |  | companies(company_id) |
|  | * | created_at | TIMESTAMP |  |  |
| uk | * | document | VARCHAR | 255 |  |
|  | o | email | VARCHAR | 255 |  |
|  | * | full_name | VARCHAR | 255 |  |
|  | o | phone | VARCHAR | 255 |  |
|  | * | status | VARCHAR | 255 |  |

Script: [`ddl/ddl_drivers.sql`](ddl/ddl_drivers.sql)

### Tabla 13. VINCULATIONS (VNC)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | vinculation_id | BIGINT |  |  |
| uk, fk1 | * | device_id | BIGINT |  | devices(device_id) |
| uk, fk2 | * | driver_id | BIGINT |  | drivers(driver_id) |
|  | * | linked_at | TIMESTAMP |  |  |
| uk, fk3 | * | vehicle_id | BIGINT |  | vehicles(vehicle_id) |

Script: [`ddl/ddl_vinculations.sql`](ddl/ddl_vinculations.sql)

### Tabla 14. ALERTS (ALR)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | alert_id | BIGINT |  |  |
|  | * | duration_seconds | INTEGER |  |  |
|  | * | detected_at | TIMESTAMP |  |  |
| fk1 | * | device_id | BIGINT |  | devices(device_id) |
| fk2 | * | driver_id | BIGINT |  | drivers(driver_id) |
| fk3 | * | event_type_id | BIGINT |  | event_types(event_type_id) |
| fk4 | * | vehicle_id | BIGINT |  | vehicles(vehicle_id) |
|  | * | level | VARCHAR | 255 |  |
|  | * | location | VARCHAR | 255 |  |

Script: [`ddl/ddl_alerts.sql`](ddl/ddl_alerts.sql)

### Tabla 15. NOTIFICATIONS (NTF)

| Tipo de clave | Opcionalidad | Nombre de la columna | Tipo de dato | Tamaño | Referencia |
|---|---|---|---|---|---|
| pk | * | notification_id | BIGINT |  |  |
|  | * | read | BOOLEAN |  |  |
| fk1 | * | company_id | BIGINT |  | companies(company_id) |
|  | * | created_at | TIMESTAMP |  |  |
|  | * | message | VARCHAR | 255 |  |
|  | * | title | VARCHAR | 255 |  |
|  | * | type | VARCHAR | 255 |  |

Script: [`ddl/ddl_notifications.sql`](ddl/ddl_notifications.sql)

## Integrantes

Mariana Barbosa Torrado, Euder Julian Pacheco Ascanio y Hannah Cabarico Salazar. Universidad Francisco de Paula Santander Ocaña, Bases de datos relacionales.

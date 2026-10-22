# wakedrive-database

Scripts y documentación de la base de datos de **WakeDrive** (PostgreSQL): plataforma de monitoreo de somnolencia de conductores. El documento completo del diseño está en el entregable *Documento de especificación del diseño e implementación de la Base de Datos*.

## Estructura del repositorio

```
wakedrive-database/
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

## Integrantes

Mariana Barbosa Torrado, Euder Julian Pacheco Ascanio y Hannah Cabarico Salazar. Universidad Francisco de Paula Santander Ocaña, Bases de datos relacionales.

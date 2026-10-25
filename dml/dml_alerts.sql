-- Carga masiva de alertas históricas (500 000 filas) repartidas entre todas las vinculaciones.
-- El trigger de negocio se deshabilita durante la carga para no validar fila por fila.
ALTER TABLE public.alerts DISABLE TRIGGER trg_validate_alert;

INSERT INTO public.alerts (detected_at, driver_id, vehicle_id, device_id, location, event_type_id, duration_seconds, level)
WITH vs AS (
    SELECT driver_id, vehicle_id, device_id, row_number() OVER (ORDER BY vinculation_id) - 1 AS n FROM public.vinculations
), k AS (SELECT count(*) AS total FROM vs),
et AS (SELECT array_agg(event_type_id ORDER BY event_type_id) AS ids FROM public.event_types)
SELECT TIMESTAMP '2026-09-12 00:00:00' + (g * interval '5 seconds'),
       vs.driver_id, vs.vehicle_id, vs.device_id,
       (ARRAY['Ruta Ocaña-Cúcuta km 40', 'Ruta Cúcuta-Pamplona km 12', 'Ruta Bucaramanga-Ocaña km 88', 'Vía Ocaña-Aguachica km 15'])[1 + (g % 4)],
       et.ids[1 + (g % 4)],
       1 + (g % 9),
       (ARRAY['HIGH', 'MEDIUM', 'LOW', 'LOW', 'MEDIUM'])[1 + (g % 5)]
FROM generate_series(1, 500000) AS g
CROSS JOIN k CROSS JOIN et
JOIN vs ON vs.n = g % k.total;

ALTER TABLE public.alerts ENABLE TRIGGER trg_validate_alert;

-- Carga masiva de alertas históricas (500 000 filas) sobre las 4 vinculaciones activas.
-- El trigger de negocio se deshabilita durante la carga para no validar fila por fila.
ALTER TABLE public.alerts DISABLE TRIGGER trg_validate_alert;

INSERT INTO public.alerts (detected_at, driver_id, vehicle_id, device_id, location, event_type_id, duration_seconds, level)
SELECT TIMESTAMP '2026-09-12 00:00:00' + (g * interval '6 seconds'),
       v.driver_id, v.vehicle_id, v.device_id,
       (ARRAY['Ruta Ocaña-Cúcuta km 40', 'Ruta Cúcuta-Pamplona km 12', 'Ruta Bucaramanga-Ocaña km 88', 'Vía Ocaña-Aguachica km 15'])[1 + (g % 4)],
       (SELECT event_type_id FROM public.event_types ORDER BY event_type_id LIMIT 1 OFFSET (g % 4)),
       1 + (g % 9),
       (ARRAY['HIGH', 'MEDIUM', 'LOW', 'LOW', 'MEDIUM'])[1 + (g % 5)]
FROM generate_series(1, 500000) AS g
JOIN public.vinculations v ON v.vinculation_id = (SELECT min(vinculation_id) FROM public.vinculations) + (g % 4);

ALTER TABLE public.alerts ENABLE TRIGGER trg_validate_alert;

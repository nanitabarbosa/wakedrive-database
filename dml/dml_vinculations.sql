INSERT INTO public.vinculations (driver_id, vehicle_id, device_id, linked_at) VALUES
(1, 1, 1, '2026-09-11 08:00:00'),
(2, 2, 2, '2026-09-11 08:10:00'),
(3, 3, 3, '2026-09-13 07:30:00'),
(4, 4, 4, '2026-09-16 06:45:00');

-- Filas 5 a 1249: se vincula el conductor, el vehículo y el dispositivo de cada empresa (todos activos).
INSERT INTO public.vinculations (driver_id, vehicle_id, device_id, linked_at)
SELECT g, g, g, TIMESTAMP '2026-09-21 08:00:00' + (g * interval '7 minutes')
FROM generate_series(6, 1250) AS g;

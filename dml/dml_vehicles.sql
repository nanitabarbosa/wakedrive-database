INSERT INTO public.vehicles (plate, brand_id, model, year, vehicle_type_id, status, company_id, created_at) VALUES
('TSO123', (SELECT brand_id FROM public.brands ORDER BY brand_id LIMIT 1 OFFSET 0), 'Hilux',    2022, (SELECT vehicle_type_id FROM public.vehicle_types ORDER BY 1 LIMIT 1 OFFSET 0), 'ACTIVE',   1, '2026-09-10 10:00:00'),
('UBA456', (SELECT brand_id FROM public.brands ORDER BY brand_id LIMIT 1 OFFSET 1), 'FC 9',     2021, (SELECT vehicle_type_id FROM public.vehicle_types ORDER BY 1 LIMIT 1 OFFSET 1), 'ACTIVE',   1, '2026-09-10 10:05:00'),
('WXY789', (SELECT brand_id FROM public.brands ORDER BY brand_id LIMIT 1 OFFSET 2), 'T800',     2020, (SELECT vehicle_type_id FROM public.vehicle_types ORDER BY 1 LIMIT 1 OFFSET 2), 'ACTIVE',   2, '2026-09-12 09:00:00'),
('KLM321', (SELECT brand_id FROM public.brands ORDER BY brand_id LIMIT 1 OFFSET 3), 'Sprinter', 2023, (SELECT vehicle_type_id FROM public.vehicle_types ORDER BY 1 LIMIT 1 OFFSET 3), 'ACTIVE',   3, '2026-09-15 15:30:00'),
('PRQ654', (SELECT brand_id FROM public.brands ORDER BY brand_id LIMIT 1 OFFSET 4), 'FH 460',   2019, (SELECT vehicle_type_id FROM public.vehicle_types ORDER BY 1 LIMIT 1 OFFSET 0), 'INACTIVE', 4, '2026-09-18 08:45:00');

-- Filas 6 a 1250: un vehículo por empresa (placa única con 3 letras y 3 números).
INSERT INTO public.vehicles (plate, brand_id, model, year, vehicle_type_id, status, company_id, created_at)
SELECT chr(65 + (g / 676) % 26) || chr(65 + (g / 26) % 26) || chr(65 + g % 26) || lpad((g % 1000)::text, 3, '0'),
       (SELECT brand_id FROM public.brands ORDER BY brand_id LIMIT 1 OFFSET (g % 26)),
       (ARRAY['Hilux','FC 9','T800','Sprinter','FH 460','NPR','Actros','Daily'])[1 + (g % 8)],
       2015 + (g % 10),
       (SELECT vehicle_type_id FROM public.vehicle_types ORDER BY 1 LIMIT 1 OFFSET (g % 4)),
       'ACTIVE', g,
       TIMESTAMP '2026-09-20 08:00:00' + (g * interval '10 minutes')
FROM generate_series(6, 1250) AS g;

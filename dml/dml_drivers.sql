INSERT INTO public.drivers (full_name, document, email, phone, status, company_id, created_at) VALUES
('JUAN CAMILO TORRES',  '1091234567', 'juan.torres@ejemplo.com',    '3201112233', 'ACTIVE',   1, '2026-09-10 10:20:00'),
('PEDRO ALFONSO LEAL',  '1092345678', 'pedro.leal@ejemplo.com',     '3202223344', 'ACTIVE',   1, '2026-09-10 10:25:00'),
('MIGUEL ANGEL SOTO',   '1093456789', 'miguel.soto@ejemplo.com',    '3203334455', 'ACTIVE',   2, '2026-09-12 09:20:00'),
('RICARDO JOSE MENDEZ', '1094567890', 'ricardo.mendez@ejemplo.com', '3204445566', 'ACTIVE',   3, '2026-09-15 15:50:00'),
('FABIAN ENRIQUE DIAZ', '1095678901', NULL,                         '3205556677', 'INACTIVE', 4, '2026-09-18 09:00:00');

-- Filas 6 a 1250: un conductor por empresa (documento único de 10 dígitos).
INSERT INTO public.drivers (full_name, document, email, phone, status, company_id, created_at)
SELECT upper((ARRAY['Laura','Carlos','Marta','Andrés','Camila','Julián','Sofía','Daniel','Valentina','Miguel','Paula','Sergio','Natalia','Felipe','Diana','Jorge','Luisa','Mateo','Carolina','Esteban'])[1 + (g % 20)] || ' ' || (ARRAY['Gómez','Pérez','Rincón','Quintero','Torres','Soto','Leal','Méndez','Díaz','Ortiz','Castro','Vargas','Rojas','Mora','Pacheco','Navarro','Suárez','Jiménez','Peña','Cárdenas'])[1 + ((g / 20) % 20)] || ' ' || (ARRAY['Gómez','Pérez','Rincón','Quintero','Torres','Soto','Leal','Méndez','Díaz','Ortiz','Castro','Vargas','Rojas','Mora','Pacheco','Navarro','Suárez','Jiménez','Peña','Cárdenas'])[1 + ((g / 400) % 20)]),
       (1100000000 + g)::text,
       'conductor' || g || '@ejemplo.com',
       '32' || lpad(g::text, 8, '0'),
       'ACTIVE', g,
       TIMESTAMP '2026-09-20 08:00:00' + (g * interval '10 minutes')
FROM generate_series(6, 1250) AS g;

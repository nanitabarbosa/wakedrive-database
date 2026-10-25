-- Las contraseñas son un valor de ejemplo, no un hash real.
INSERT INTO public.users (name, email, password, role_id, company_id, must_change_password) VALUES
('Super Administrador', 'superadmin@ejemplo.com',        'HASH_DE_EJEMPLO_1', (SELECT role_id FROM public.roles WHERE name = 'SUPER_ADMIN'), NULL, FALSE),
('Laura Gómez',         'laura.gomez@ejemplo.com',       'HASH_DE_EJEMPLO_2', (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1), 1, FALSE),
('Carlos Pérez',        'carlos.perez@ejemplo.com',      'HASH_DE_EJEMPLO_3', (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1), 2, TRUE),
('Marta Rincón',        'marta.rincon@ejemplo.com',      'HASH_DE_EJEMPLO_4', (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1), 3, FALSE),
('Andrés Quintero',     'andres.quintero@ejemplo.com',   'HASH_DE_EJEMPLO_5', (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1), 4, TRUE);

-- Filas 6 a 1250: un usuario administrador por empresa.
INSERT INTO public.users (name, email, password, role_id, company_id, must_change_password)
SELECT (ARRAY['Laura','Carlos','Marta','Andrés','Camila','Julián','Sofía','Daniel','Valentina','Miguel','Paula','Sergio','Natalia','Felipe','Diana','Jorge','Luisa','Mateo','Carolina','Esteban'])[1 + (g % 20)] || ' ' || (ARRAY['Gómez','Pérez','Rincón','Quintero','Torres','Soto','Leal','Méndez','Díaz','Ortiz','Castro','Vargas','Rojas','Mora','Pacheco','Navarro','Suárez','Jiménez','Peña','Cárdenas'])[1 + ((g / 20) % 20)] || ' ' || (ARRAY['Gómez','Pérez','Rincón','Quintero','Torres','Soto','Leal','Méndez','Díaz','Ortiz','Castro','Vargas','Rojas','Mora','Pacheco','Navarro','Suárez','Jiménez','Peña','Cárdenas'])[1 + ((g / 400) % 20)],
       'usuario' || g || '@ejemplo.com',
       'HASH_DE_EJEMPLO_' || g,
       (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1),
       g - 1,
       (g % 4 = 0)
FROM generate_series(6, 1250) AS g;

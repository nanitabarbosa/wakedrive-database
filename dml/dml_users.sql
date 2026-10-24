-- Las contraseñas son un valor de ejemplo, no un hash real.
INSERT INTO public.users (name, email, password, role_id, company_id, must_change_password) VALUES
('Super Administrador', 'superadmin@ejemplo.com',        'HASH_DE_EJEMPLO_1', (SELECT role_id FROM public.roles WHERE name = 'SUPER_ADMIN'), NULL, FALSE),
('Laura Gómez',         'laura.gomez@ejemplo.com',       'HASH_DE_EJEMPLO_2', (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1), 1, FALSE),
('Carlos Pérez',        'carlos.perez@ejemplo.com',      'HASH_DE_EJEMPLO_3', (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1), 2, TRUE),
('Marta Rincón',        'marta.rincon@ejemplo.com',      'HASH_DE_EJEMPLO_4', (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1), 3, FALSE),
('Andrés Quintero',     'andres.quintero@ejemplo.com',   'HASH_DE_EJEMPLO_5', (SELECT role_id FROM public.roles WHERE name <> 'SUPER_ADMIN' LIMIT 1), 4, TRUE);

INSERT INTO public.notifications (company_id, type, title, message, read, created_at) VALUES
(1, 'USER_REGISTERED',     'Nuevo usuario registrado', 'Se registró el usuario Laura Gómez',                        TRUE,  '2026-09-10 10:30:00'),
(1, 'VINCULATION_CREATED', 'Vinculación creada',       'Conductor JUAN CAMILO TORRES vinculado al vehículo TSO123', TRUE,  '2026-09-11 08:00:00'),
(2, 'DEVICE_ONLINE',       'Dispositivo en línea',     'El dispositivo WD-0003-B1 se conectó',                      FALSE, '2026-10-19 22:10:00'),
(3, 'DEVICE_OFF',          'Dispositivo desconectado', 'El dispositivo WD-0004-C1 dejó de reportar',                FALSE, '2026-10-20 07:30:00'),
(1, 'DROWSINESS',          'Alerta de somnolencia',    'Conductor PEDRO ALFONSO LEAL en Ruta Ocaña-Cúcuta km 40',   FALSE, '2026-10-20 18:10:00');

-- Filas 6 a 1250: una notificación por empresa, con los 5 tipos del sistema.
INSERT INTO public.notifications (company_id, type, title, message, read, created_at)
SELECT g, t.type, t.title, t.message || ' (empresa ' || g || ')', (g % 2 = 0), TIMESTAMP '2026-10-01 08:00:00' + (g * interval '3 minutes')
FROM generate_series(6, 1250) AS g
JOIN (VALUES (0, 'USER_REGISTERED', 'Nuevo usuario registrado', 'Se registró un usuario'),
             (1, 'VINCULATION_CREATED', 'Vinculación creada', 'Se vinculó un conductor con un vehículo'),
             (2, 'DEVICE_ONLINE', 'Dispositivo en línea', 'Un dispositivo se conectó'),
             (3, 'DEVICE_OFF', 'Dispositivo desconectado', 'Un dispositivo dejó de reportar'),
             (4, 'DROWSINESS', 'Alerta de somnolencia', 'Se detectó somnolencia en un conductor')) AS t(k, type, title, message)
  ON t.k = g % 5;

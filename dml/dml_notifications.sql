INSERT INTO public.notifications (company_id, type, title, message, read, created_at) VALUES
(1, 'USER_REGISTERED',     'Nuevo usuario registrado', 'Se registró el usuario Laura Gómez',                        TRUE,  '2026-09-10 10:30:00'),
(1, 'VINCULATION_CREATED', 'Vinculación creada',       'Conductor JUAN CAMILO TORRES vinculado al vehículo TSO123', TRUE,  '2026-09-11 08:00:00'),
(2, 'DEVICE_ONLINE',       'Dispositivo en línea',     'El dispositivo WD-0003-B1 se conectó',                      FALSE, '2026-10-19 22:10:00'),
(3, 'DEVICE_OFF',          'Dispositivo desconectado', 'El dispositivo WD-0004-C1 dejó de reportar',                FALSE, '2026-10-20 07:30:00'),
(1, 'DROWSINESS',          'Alerta de somnolencia',    'Conductor PEDRO ALFONSO LEAL en Ruta Ocaña-Cúcuta km 40',   FALSE, '2026-10-20 18:10:00');

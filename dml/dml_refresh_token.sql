-- Tokens de ejemplo (los reales los genera la API al iniciar sesión).
INSERT INTO public.refresh_token (user_id, token, expires_at) VALUES
(1, 'token-ejemplo-0001', '2026-10-28 08:00:00'),
(2, 'token-ejemplo-0002', '2026-10-28 09:15:00'),
(3, 'token-ejemplo-0003', '2026-10-28 10:30:00'),
(4, 'token-ejemplo-0004', '2026-10-29 07:45:00'),
(5, 'token-ejemplo-0005', '2026-10-29 11:20:00');

-- Filas 6 a 1250: un token por usuario.
INSERT INTO public.refresh_token (user_id, token, expires_at)
SELECT g, 'token-ejemplo-' || lpad(g::text, 4, '0'), TIMESTAMP '2026-10-28 08:00:00' + (g * interval '5 minutes')
FROM generate_series(6, 1250) AS g;

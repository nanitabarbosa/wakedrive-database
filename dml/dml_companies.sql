INSERT INTO public.companies (nit, name, address, phone, email, face_recognition_always, notify_device_shutdown, alarm_duration_seconds) VALUES
('900123456-1', 'TRANSPORTES OCAÑA S.A.S.',      'CRA 12 # 8-40 OCAÑA',       '3001112233', 'contacto@transportesocana.com', TRUE,  TRUE,  5),
('901234567-2', 'FLOTA ANDINA LTDA',             'CALLE 10 # 5-22 CUCUTA',    '3014445566', 'info@flotaandina.com',          FALSE, TRUE,  8),
('800345678-3', 'CARGA SEGURA DEL NORTE S.A.',   'AV 3 # 15-80 BUCARAMANGA',  '3027778899', 'operaciones@cargasegura.com',   TRUE,  FALSE, 6),
('890456789-4', 'EXPRESO BOLIVARIANO DEL CESAR', 'CRA 9 # 14-10 VALLEDUPAR',  '3039990011', 'gerencia@expresocesar.com',     FALSE, FALSE, 10),
('900567890-5', 'LOGISTICA CARIBE S.A.S.',       'ZONA FRANCA BARRANQUILLA',  '3042223344', 'admin@logisticacaribe.com',     TRUE,  TRUE,  7);

-- Filas 6 a 1250 generadas con generate_series (NIT, correo y teléfono únicos).
INSERT INTO public.companies (nit, name, address, phone, email, face_recognition_always, notify_device_shutdown, alarm_duration_seconds)
SELECT (900000000 + g)::text || '-' || (g % 10),
       'EMPRESA DE TRANSPORTE ' || g,
       'CALLE ' || (1 + g % 90) || ' # ' || (1 + g % 40) || '-' || (10 + g % 80),
       '30' || lpad(g::text, 8, '0'),
       'empresa' || g || '@ejemplo.com',
       (g % 2 = 0), (g % 3 <> 0), 5 + (g % 6)
FROM generate_series(6, 1250) AS g;

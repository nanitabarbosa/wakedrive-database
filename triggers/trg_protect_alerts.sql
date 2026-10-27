-- Regla de negocio: las alertas registradas son un historial inmutable; no se pueden modificar ni eliminar.
-- Única excepción: una alerta PENDING (dispositivo apagado o sin señal) se resuelve una sola vez cuando el
-- dispositivo vuelve a conectarse, asignando su nivel definitivo y los segundos que estuvo desconectado.
CREATE OR REPLACE FUNCTION public.fn_protect_alerts() RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'UPDATE' AND OLD.level = 'PENDING' AND NEW.level <> 'PENDING'
       AND (NEW.alert_id, NEW.detected_at, NEW.device_id, NEW.driver_id, NEW.event_type_id, NEW.vehicle_id, NEW.location)
           IS NOT DISTINCT FROM
           (OLD.alert_id, OLD.detected_at, OLD.device_id, OLD.driver_id, OLD.event_type_id, OLD.vehicle_id, OLD.location) THEN
        RETURN NEW;
    END IF;
    RAISE EXCEPTION 'Las alertas registradas no se pueden %: el historial es inmutable',
        CASE TG_OP WHEN 'UPDATE' THEN 'modificar' ELSE 'eliminar' END
        USING ERRCODE = 'P0001';
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_protect_alerts ON public.alerts;
CREATE TRIGGER trg_protect_alerts BEFORE UPDATE OR DELETE ON public.alerts
    FOR EACH ROW EXECUTE FUNCTION public.fn_protect_alerts();

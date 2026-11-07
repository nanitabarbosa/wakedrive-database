-- Validamos que solo un dispositivo ACTIVO, vinculado al mismo conductor y vehículo, pueda registrar alertas.
CREATE OR REPLACE FUNCTION wakedrive.fn_validate_alert() RETURNS trigger AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM wakedrive.devices WHERE device_id = NEW.device_id AND status = 'ACTIVE') THEN
        RAISE EXCEPTION 'El dispositivo % no esta ACTIVO: no puede registrar alertas', NEW.device_id
            USING ERRCODE = 'P0001';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM wakedrive.vinculations
                   WHERE device_id = NEW.device_id AND driver_id = NEW.driver_id AND vehicle_id = NEW.vehicle_id) THEN
        RAISE EXCEPTION 'La alerta no coincide con una vinculacion conductor-vehiculo-dispositivo'
            USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_validate_alert ON wakedrive.alerts;
CREATE TRIGGER trg_validate_alert BEFORE INSERT ON wakedrive.alerts
    FOR EACH ROW EXECUTE FUNCTION wakedrive.fn_validate_alert();

-- Validamos que solo vinculemos un conductor, un vehículo y un dispositivo ACTIVOS
-- que pertenezcan a la misma empresa.
CREATE OR REPLACE FUNCTION wakedrive.fn_validate_vinculation() RETURNS trigger AS $$
DECLARE
    v_driver  RECORD;
    v_vehicle RECORD;
    v_device  RECORD;
BEGIN
    SELECT status, company_id INTO v_driver  FROM wakedrive.drivers  WHERE driver_id  = NEW.driver_id;
    SELECT status, company_id INTO v_vehicle FROM wakedrive.vehicles WHERE vehicle_id = NEW.vehicle_id;
    SELECT status, company_id INTO v_device  FROM wakedrive.devices  WHERE device_id  = NEW.device_id;

    IF v_driver.status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'El conductor % no esta ACTIVO: no se puede vincular', NEW.driver_id USING ERRCODE = 'P0001';
    END IF;
    IF v_vehicle.status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'El vehiculo % no esta ACTIVO: no se puede vincular', NEW.vehicle_id USING ERRCODE = 'P0001';
    END IF;
    IF v_device.status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'El dispositivo % no esta ACTIVO: no se puede vincular', NEW.device_id USING ERRCODE = 'P0001';
    END IF;
    IF v_driver.company_id <> v_vehicle.company_id OR v_driver.company_id <> v_device.company_id THEN
        RAISE EXCEPTION 'El conductor, el vehiculo y el dispositivo deben pertenecer a la misma empresa'
            USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_validate_vinculation ON wakedrive.vinculations;
CREATE TRIGGER trg_validate_vinculation BEFORE INSERT OR UPDATE OF driver_id, vehicle_id, device_id ON wakedrive.vinculations
    FOR EACH ROW EXECUTE FUNCTION wakedrive.fn_validate_vinculation();

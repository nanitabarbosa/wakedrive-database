-- Trigger que audita wakedrive.users y guarda en wakedrive.audi_users.
CREATE OR REPLACE FUNCTION wakedrive.fn_audi_users() RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO wakedrive.audi_users (operation, state, must_change_password, company_id, role_id, user_id, email, name)
        VALUES (TG_OP, 'NEW', NEW.must_change_password, NEW.company_id, NEW.role_id, NEW.user_id, NEW.email, NEW.name);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO wakedrive.audi_users (operation, state, must_change_password, company_id, role_id, user_id, email, name)
        VALUES (TG_OP, 'OLD', OLD.must_change_password, OLD.company_id, OLD.role_id, OLD.user_id, OLD.email, OLD.name);
        INSERT INTO wakedrive.audi_users (operation, state, must_change_password, company_id, role_id, user_id, email, name)
        VALUES (TG_OP, 'NEW', NEW.must_change_password, NEW.company_id, NEW.role_id, NEW.user_id, NEW.email, NEW.name);
        RETURN NEW;
    ELSE
        INSERT INTO wakedrive.audi_users (operation, state, must_change_password, company_id, role_id, user_id, email, name)
        VALUES (TG_OP, 'OLD', OLD.must_change_password, OLD.company_id, OLD.role_id, OLD.user_id, OLD.email, OLD.name);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_audi_users ON wakedrive.users;
CREATE TRIGGER trg_audi_users AFTER INSERT OR UPDATE OR DELETE ON wakedrive.users
    FOR EACH ROW EXECUTE FUNCTION wakedrive.fn_audi_users();

-- Trigger de auditoría de public.companies (guarda en public.audi_companies).
CREATE OR REPLACE FUNCTION public.fn_audi_companies() RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO public.audi_companies (operation, state, company_id, nit, name, address, phone, email, city_id, status)
        VALUES (TG_OP, 'NEW', NEW.company_id, NEW.nit, NEW.name, NEW.address, NEW.phone, NEW.email, NEW.city_id, NEW.status);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO public.audi_companies (operation, state, company_id, nit, name, address, phone, email, city_id, status)
        VALUES (TG_OP, 'OLD', OLD.company_id, OLD.nit, OLD.name, OLD.address, OLD.phone, OLD.email, OLD.city_id, OLD.status);
        INSERT INTO public.audi_companies (operation, state, company_id, nit, name, address, phone, email, city_id, status)
        VALUES (TG_OP, 'NEW', NEW.company_id, NEW.nit, NEW.name, NEW.address, NEW.phone, NEW.email, NEW.city_id, NEW.status);
        RETURN NEW;
    ELSE
        INSERT INTO public.audi_companies (operation, state, company_id, nit, name, address, phone, email, city_id, status)
        VALUES (TG_OP, 'OLD', OLD.company_id, OLD.nit, OLD.name, OLD.address, OLD.phone, OLD.email, OLD.city_id, OLD.status);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Los UPDATE solo se auditan si cambia algún dato auditado: guardar el logo o la alarma no genera filas.
DROP TRIGGER IF EXISTS trg_audi_companies ON public.companies;
CREATE TRIGGER trg_audi_companies AFTER INSERT OR DELETE ON public.companies
    FOR EACH ROW EXECUTE FUNCTION public.fn_audi_companies();

DROP TRIGGER IF EXISTS trg_audi_companies_update ON public.companies;
CREATE TRIGGER trg_audi_companies_update AFTER UPDATE ON public.companies
    FOR EACH ROW
    WHEN (OLD.nit IS DISTINCT FROM NEW.nit OR OLD.name IS DISTINCT FROM NEW.name
          OR OLD.address IS DISTINCT FROM NEW.address OR OLD.phone IS DISTINCT FROM NEW.phone
          OR OLD.email IS DISTINCT FROM NEW.email OR OLD.city_id IS DISTINCT FROM NEW.city_id
          OR OLD.status IS DISTINCT FROM NEW.status)
    EXECUTE FUNCTION public.fn_audi_companies();

-- Trigger de auditoría de public.access_requests (guarda en public.audi_access_requests).
-- Una solicitud pública (INSERT) no trae autor: queda el usuario de la base de datos.
CREATE OR REPLACE FUNCTION public.fn_audi_access_requests() RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO public.audi_access_requests (operation, state, changed_by, access_request_id, company_name, nit, status)
        VALUES (TG_OP, 'NEW', COALESCE(NEW.updated_by, current_user), NEW.access_request_id, NEW.company_name, NEW.nit, NEW.status);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO public.audi_access_requests (operation, state, changed_by, access_request_id, company_name, nit, status)
        VALUES (TG_OP, 'OLD', COALESCE(NEW.updated_by, current_user), OLD.access_request_id, OLD.company_name, OLD.nit, OLD.status);
        INSERT INTO public.audi_access_requests (operation, state, changed_by, access_request_id, company_name, nit, status)
        VALUES (TG_OP, 'NEW', COALESCE(NEW.updated_by, current_user), NEW.access_request_id, NEW.company_name, NEW.nit, NEW.status);
        RETURN NEW;
    ELSE
        INSERT INTO public.audi_access_requests (operation, state, changed_by, access_request_id, company_name, nit, status)
        VALUES (TG_OP, 'OLD', current_user, OLD.access_request_id, OLD.company_name, OLD.nit, OLD.status);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_audi_access_requests ON public.access_requests;
CREATE TRIGGER trg_audi_access_requests AFTER INSERT OR DELETE ON public.access_requests
    FOR EACH ROW EXECUTE FUNCTION public.fn_audi_access_requests();

DROP TRIGGER IF EXISTS trg_audi_access_requests_update ON public.access_requests;
CREATE TRIGGER trg_audi_access_requests_update AFTER UPDATE ON public.access_requests
    FOR EACH ROW WHEN (OLD.status IS DISTINCT FROM NEW.status)
    EXECUTE FUNCTION public.fn_audi_access_requests();

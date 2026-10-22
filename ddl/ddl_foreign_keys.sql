-- Claves foráneas de todas las tablas (se crean al final para no depender del orden de las tablas).
-- Todas usan la política por defecto NO ACTION, que impide borrar registros referenciados.

ALTER TABLE public.users ADD CONSTRAINT fkin8gn4o1hpiwe6qe4ey7ykwq7 FOREIGN KEY (company_id) REFERENCES companies(company_id);
ALTER TABLE public.users ADD CONSTRAINT fkp56c1712k691lhsyewcssf40f FOREIGN KEY (role_id) REFERENCES roles(role_id);
ALTER TABLE public.refresh_token ADD CONSTRAINT fkjtx87i0jvq2svedphegvdwcuy FOREIGN KEY (user_id) REFERENCES users(user_id);
ALTER TABLE public.access_requests ADD CONSTRAINT fkrmjpr2ufg4t9d26c0ft8tkp00 FOREIGN KEY (city_id) REFERENCES cities(city_id);
ALTER TABLE public.vehicles ADD CONSTRAINT fkk3cs3vldlan30kg1x6b57i4fe FOREIGN KEY (vehicle_type_id) REFERENCES vehicle_types(vehicle_type_id);
ALTER TABLE public.vehicles ADD CONSTRAINT fkwvkljwybf9jpcarv5iclh6yo FOREIGN KEY (company_id) REFERENCES companies(company_id);
ALTER TABLE public.vehicles ADD CONSTRAINT fkx0jx9pfbo7fwm4l2f90qktjd FOREIGN KEY (brand_id) REFERENCES brands(brand_id);
ALTER TABLE public.devices ADD CONSTRAINT fkgftgwq73nq3aymdfb88hagr1f FOREIGN KEY (company_id) REFERENCES companies(company_id);
ALTER TABLE public.drivers ADD CONSTRAINT fk55y0s3pkbobngmrj4efglbgjp FOREIGN KEY (company_id) REFERENCES companies(company_id);
ALTER TABLE public.vinculations ADD CONSTRAINT fk8570trfpupgxd5skwdatj544o FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id);
ALTER TABLE public.vinculations ADD CONSTRAINT fkev46yb82km6ygg9ft2knxf6ie FOREIGN KEY (device_id) REFERENCES devices(device_id);
ALTER TABLE public.vinculations ADD CONSTRAINT fklp0lqcfn84gw16r4dd29d3aan FOREIGN KEY (driver_id) REFERENCES drivers(driver_id);
ALTER TABLE public.alerts ADD CONSTRAINT fk41y5kitr6aogoe6l1dnpk36no FOREIGN KEY (driver_id) REFERENCES drivers(driver_id);
ALTER TABLE public.alerts ADD CONSTRAINT fkf6y42xr4y08qk04o13h6wwj47 FOREIGN KEY (device_id) REFERENCES devices(device_id);
ALTER TABLE public.alerts ADD CONSTRAINT fkhaom63hnn4d267hkk913jqpeh FOREIGN KEY (event_type_id) REFERENCES event_types(event_type_id);
ALTER TABLE public.alerts ADD CONSTRAINT fkna82xsregx7j8317e4957iaoo FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id);
ALTER TABLE public.notifications ADD CONSTRAINT fk4jibwyyblv04ovaf0uhcg2xe4 FOREIGN KEY (company_id) REFERENCES companies(company_id);

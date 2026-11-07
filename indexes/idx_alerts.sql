-- Creamos índices sobre alerts porque el dashboard filtra por rango de fechas, conductor y vehículo.
CREATE INDEX IF NOT EXISTS idx_alerts_detected_at ON wakedrive.alerts (detected_at);
CREATE INDEX IF NOT EXISTS idx_alerts_driver ON wakedrive.alerts (driver_id);
CREATE INDEX IF NOT EXISTS idx_alerts_vehicle ON wakedrive.alerts (vehicle_id);

-- ============================================================================
-- FABRİKA DEMİRBAŞ VE KALIP YÖNETİMİ: GIN İndeks Tanımları
-- ============================================================================

-- technical_specs JSONB alanı için GIN indeks (içerik aramaları ve @> operatörü için)
CREATE INDEX IF NOT EXISTS idx_factory_assets_specs_gin 
ON factory_assets USING gin (technical_specs);

-- maintenance_logs JSONB alanı için GIN indeks
CREATE INDEX IF NOT EXISTS idx_factory_assets_logs_gin 
ON factory_assets USING gin (maintenance_logs);
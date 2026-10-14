-- ============================================================================
-- FABRİKA DEMİRBAŞ VE KALIP YÖNETİMİ: Hibrit Şema Tanımı
-- ============================================================================

CREATE TABLE IF NOT EXISTS factory_assets (
    id SERIAL PRIMARY KEY,
    asset_code VARCHAR(64) UNIQUE NOT NULL,
    asset_name VARCHAR(128) NOT NULL,
    asset_type VARCHAR(32) NOT NULL, -- 'CNC', 'FORKLIFT', 'MOLD' vb.
    technical_specs JSONB NOT NULL,  -- Dinamik teknik özellikler (NoSQL esnekliği)
    maintenance_logs JSONB,          -- Bakım geçmişi ve logları
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
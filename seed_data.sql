-- ============================================================================
-- FABRİKA DEMİRBAŞ VE KALIP YÖNETİMİ: Test Verisi (30.000 Kayıt)
-- ============================================================================

TRUNCATE TABLE factory_assets RESTART IDENTITY CASCADE;

INSERT INTO factory_assets (asset_code, asset_name, asset_type, technical_specs, maintenance_logs)
SELECT 
    'AST-' || LPAD(i::text, 6, '0'),
    CASE (i % 3)
        WHEN 0 THEN 'CNC Milling Machine ' || i
        WHEN 1 THEN 'Electric Forklift ' || i
        ELSE 'Injection Mold ' || i
    END,
    CASE (i % 3)
        WHEN 0 THEN 'CNC'
        WHEN 1 THEN 'FORKLIFT'
        ELSE 'MOLD'
    END,
    CASE (i % 3)
        WHEN 0 THEN jsonb_build_object(
            'motor_kw', 15 + (i % 20), 
            'max_rpm', 8000 + ((i % 5) * 1000), 
            'controller', CASE WHEN i % 2 = 0 THEN 'Fanuc' ELSE 'Siemens' END, 
            'axes', 3 + (i % 3)
        )
        WHEN 1 THEN jsonb_build_object(
            'max_weight_kg', 1500 + ((i % 4) * 500), 
            'lift_height_m', 3.0 + ((i % 3) * 0.5), 
            'battery_voltage', 48 + ((i % 2) * 32)
        )
        ELSE jsonb_build_object(
            'mold_cavities', 1 + (i % 4), 
            'weight_kg', 500 + (i % 2000), 
            'compatible_press_ton', 400 + ((i % 6) * 100)
        )
    END,
    jsonb_build_array(
        jsonb_build_object('date', '2026-01-10', 'type', 'routine', 'technician', 'Personel-' || (i % 10))
    )
FROM generate_series(1, 30000) AS s(i);
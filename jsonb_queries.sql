-- ============================================================================
-- FABRİKA DEMİRBAŞ VE KALIP YÖNETİMİ: İleri Seviye JSONB Sorguları & EXPLAIN
-- ============================================================================

-- 1. Containment (@>) Operatörü ile Hızlı Arama (GIN İndeks Kullanır)
-- Kontrolör tipi 'Fanuc' olan tüm CNC makinelerini listele
SELECT asset_code, asset_name, technical_specs 
FROM factory_assets 
WHERE asset_type = 'CNC' 
  AND technical_specs @> '{"controller": "Fanuc"}';

-- 2. JSON Alanından Değer Çekme ve Filtreleme (->> operatörü ile metin kıyaslama)
-- Maksimum ağırlığı 2500 kg'dan büyük olan forkliftleri bul
SELECT asset_code, asset_name, technical_specs->>'max_weight_kg' AS max_weight
FROM factory_assets
WHERE asset_type = 'FORKLIFT'
  AND (technical_specs->>'max_weight_kg')::numeric > 2500;

-- 3. JSON Path Sorgusu (jsonb_path_query)
-- Uyumluluk tonajı 800 ton ve üzeri olan enjeksiyon kalıplarını sorgula
SELECT asset_code, asset_name, jsonb_path_query(technical_specs, '$.compatible_press_ton') AS press_ton
FROM factory_assets
WHERE asset_type = 'MOLD'
  AND jsonb_path_exists(technical_specs, '$.compatible_press_ton ? (@ >= 800)');

-- 4. GIN İndeks Performans Testi (EXPLAIN ANALYZE)
-- Bu sorguda GIN indeksin sequential scan yerine nasıl devreye girdiğini gözlemleyin
EXPLAIN ANALYZE
SELECT * 
FROM factory_assets 
WHERE technical_specs @> '{"controller": "Siemens"}';
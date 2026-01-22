-- ============================================================================
-- SUPABASE DUMMY DATA
-- Copy dan paste script ini di Supabase SQL Editor
-- URL: https://app.supabase.com/project/tkhvhlafdaccagodxqie/sql
-- ============================================================================
-- PASTIKAN supabase_setup.sql sudah dijalankan terlebih dahulu!
-- ============================================================================

-- ============================================================================
-- 1. INSERT LAUNDRIES (5 Laundry)
-- ============================================================================

INSERT INTO public.laundries (id, name, address, image, rating, review_count, distance, is_open, is_active, open_time, close_time, services, description, latitude, longitude, phone_number, email)
VALUES 
(
  'laundry_001',
  'Express Laundry',
  'Jl. Merdeka No. 123, Bandung',
  'https://images.unsplash.com/photo-1545173168-9f1947eebb7f?w=400',
  4.8,
  156,
  '1.2 km',
  true,
  true,
  '07:00',
  '22:00',
  ARRAY['Cuci Reguler', 'Cuci Express', 'Setrika', 'Dry Clean'],
  'Laundry express dengan layanan cepat dan berkualitas. Gratis antar jemput untuk area Bandung.',
  -6.9175,
  107.6191,
  '022-1234567',
  'express@laundry.com'
),
(
  'laundry_002',
  'Clean & Fresh Laundry',
  'Jl. Asia Afrika No. 45, Bandung',
  'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=400',
  4.5,
  89,
  '2.5 km',
  true,
  true,
  '08:00',
  '21:00',
  ARRAY['Cuci Reguler', 'Cuci Kiloan', 'Setrika'],
  'Laundry kiloan dengan harga terjangkau. Menggunakan deterjen premium anti bakteri.',
  -6.9214,
  107.6089,
  '022-2345678',
  'cleanfresh@laundry.com'
),
(
  'laundry_003',
  'Premium Wash',
  'Jl. Dago No. 78, Bandung',
  'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=400',
  4.9,
  234,
  '3.0 km',
  true,
  true,
  '06:00',
  '23:00',
  ARRAY['Dry Clean', 'Laundry Premium', 'Cuci Sepatu', 'Cuci Karpet'],
  'Layanan laundry premium untuk pakaian branded dan karpet. Garansi kualitas.',
  -6.8857,
  107.6138,
  '022-3456789',
  'premium@wash.com'
),
(
  'laundry_004',
  'Speedy Laundry 24H',
  'Jl. Pasteur No. 99, Bandung',
  'https://images.unsplash.com/photo-1604335399105-a0c585fd81a1?w=400',
  4.3,
  67,
  '1.8 km',
  true,
  true,
  '00:00',
  '23:59',
  ARRAY['Cuci Express 3 Jam', 'Cuci Reguler', 'Setrika Express'],
  'Laundry 24 jam nonstop. Layanan express 3 jam selesai!',
  -6.8944,
  107.5884,
  '022-4567890',
  'speedy24@laundry.com'
),
(
  'laundry_005',
  'Eco Green Laundry',
  'Jl. Setiabudi No. 55, Bandung',
  'https://images.unsplash.com/photo-1489274495757-95c7c837b101?w=400',
  4.6,
  112,
  '4.2 km',
  false,
  true,
  '08:00',
  '20:00',
  ARRAY['Cuci Organik', 'Cuci Reguler', 'Setrika'],
  'Laundry ramah lingkungan dengan deterjen organik. Aman untuk kulit sensitif.',
  -6.8735,
  107.6166,
  '022-5678901',
  'ecogreen@laundry.com'
);

-- ============================================================================
-- 2. INSERT SERVICES (Layanan untuk tiap laundry)
-- ============================================================================

-- Services untuk Express Laundry
INSERT INTO public.services (id, laundry_id, name, description, price, category, duration_hours, is_available)
VALUES 
('svc_001_001', 'laundry_001', 'Cuci Reguler', 'Cuci bersih dengan deterjen premium', 7000, 'wash', 24, true),
('svc_001_002', 'laundry_001', 'Cuci Express', 'Cuci kilat selesai 6 jam', 12000, 'wash', 6, true),
('svc_001_003', 'laundry_001', 'Setrika Saja', 'Setrika rapi dengan uap', 5000, 'iron', 12, true),
('svc_001_004', 'laundry_001', 'Cuci + Setrika', 'Paket lengkap cuci dan setrika', 10000, 'complete', 24, true),
('svc_001_005', 'laundry_001', 'Dry Clean', 'Untuk pakaian berbahan khusus', 25000, 'dry_clean', 48, true);

-- Services untuk Clean & Fresh
INSERT INTO public.services (id, laundry_id, name, description, price, category, duration_hours, is_available)
VALUES 
('svc_002_001', 'laundry_002', 'Cuci Kiloan', 'Cuci per kilogram', 6000, 'wash', 24, true),
('svc_002_002', 'laundry_002', 'Cuci Satuan', 'Cuci per potong', 8000, 'wash', 24, true),
('svc_002_003', 'laundry_002', 'Setrika Kiloan', 'Setrika per kilogram', 4000, 'iron', 12, true),
('svc_002_004', 'laundry_002', 'Paket Hemat', 'Cuci + setrika kiloan', 9000, 'complete', 24, true);

-- Services untuk Premium Wash
INSERT INTO public.services (id, laundry_id, name, description, price, category, duration_hours, is_available)
VALUES 
('svc_003_001', 'laundry_003', 'Premium Wash', 'Cuci dengan treatment khusus', 15000, 'wash', 24, true),
('svc_003_002', 'laundry_003', 'Dry Clean Premium', 'Dry clean untuk jas dan gaun', 50000, 'dry_clean', 72, true),
('svc_003_003', 'laundry_003', 'Cuci Sepatu', 'Cuci dan perawatan sepatu', 35000, 'shoes', 48, true),
('svc_003_004', 'laundry_003', 'Cuci Karpet', 'Cuci karpet per meter', 40000, 'carpet', 72, true),
('svc_003_005', 'laundry_003', 'Cuci Boneka', 'Cuci boneka besar', 30000, 'special', 48, true);

-- Services untuk Speedy 24H
INSERT INTO public.services (id, laundry_id, name, description, price, category, duration_hours, is_available)
VALUES 
('svc_004_001', 'laundry_004', 'Express 3 Jam', 'Super kilat 3 jam selesai', 20000, 'express', 3, true),
('svc_004_002', 'laundry_004', 'Express 6 Jam', 'Kilat 6 jam selesai', 15000, 'express', 6, true),
('svc_004_003', 'laundry_004', 'Reguler 24 Jam', 'Standar 24 jam', 8000, 'wash', 24, true),
('svc_004_004', 'laundry_004', 'Setrika Express', 'Setrika 2 jam selesai', 8000, 'iron', 2, true);

-- Services untuk Eco Green
INSERT INTO public.services (id, laundry_id, name, description, price, category, duration_hours, is_available)
VALUES 
('svc_005_001', 'laundry_005', 'Cuci Organik', 'Deterjen organik ramah lingkungan', 10000, 'wash', 24, true),
('svc_005_002', 'laundry_005', 'Cuci Baby', 'Khusus pakaian bayi, hypoallergenic', 12000, 'wash', 24, true),
('svc_005_003', 'laundry_005', 'Eco Package', 'Paket hemat ramah lingkungan', 15000, 'complete', 24, true);

-- ============================================================================
-- 3. INSERT OFFERS (Promo/Diskon)
-- ============================================================================

INSERT INTO public.offers (id, laundry_id, title, description, discount_percentage, discount_amount, min_order, start_date, end_date, is_active)
VALUES 
(
  'offer_001',
  'laundry_001',
  'Promo Weekend 20%',
  'Diskon 20% untuk semua layanan di hari Sabtu dan Minggu',
  20,
  NULL,
  25000,
  '2026-01-01 00:00:00+07',
  '2026-12-31 23:59:59+07',
  true
),
(
  'offer_002',
  'laundry_001',
  'Gratis Ongkir',
  'Gratis ongkos kirim untuk order minimal Rp 50.000',
  NULL,
  10000,
  50000,
  '2026-01-01 00:00:00+07',
  '2026-06-30 23:59:59+07',
  true
),
(
  'offer_003',
  'laundry_002',
  'Paket Hemat Bulanan',
  'Diskon 15% untuk member bulanan',
  15,
  NULL,
  100000,
  '2026-01-01 00:00:00+07',
  '2026-12-31 23:59:59+07',
  true
),
(
  'offer_004',
  'laundry_003',
  'First Time User',
  'Diskon Rp 25.000 untuk pengguna baru',
  NULL,
  25000,
  75000,
  '2026-01-01 00:00:00+07',
  '2026-12-31 23:59:59+07',
  true
),
(
  'offer_005',
  'laundry_004',
  'Flash Sale Express',
  'Diskon 30% untuk layanan Express 3 Jam',
  30,
  NULL,
  20000,
  '2026-01-15 00:00:00+07',
  '2026-02-15 23:59:59+07',
  true
),
(
  'offer_006',
  'laundry_005',
  'Go Green Discount',
  'Diskon 10% dengan membawa tas sendiri',
  10,
  NULL,
  0,
  '2026-01-01 00:00:00+07',
  '2026-12-31 23:59:59+07',
  true
);

-- ============================================================================
-- VERIFIKASI DATA
-- Jalankan query di bawah untuk memastikan data masuk
-- ============================================================================

-- Cek jumlah data per tabel
SELECT 'laundries' as table_name, COUNT(*) as total FROM public.laundries
UNION ALL
SELECT 'services' as table_name, COUNT(*) as total FROM public.services
UNION ALL
SELECT 'offers' as table_name, COUNT(*) as total FROM public.offers;

-- ============================================================================
-- HASIL YANG DIHARAPKAN:
-- laundries: 5 rows
-- services: 21 rows
-- offers: 6 rows
-- ============================================================================

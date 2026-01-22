# Supabase Setup Instructions

## Quick Setup

Untuk menjalankan aplikasi dengan Supabase, ikuti langkah-langkah berikut:

### 1. Create Tables di Supabase Dashboard

1. Buka https://app.supabase.com
2. Login ke project Anda
3. Buka **SQL Editor** (di sidebar kiri)
4. Klik **+ New Query**
5. Copy-paste isi file `supabase_setup.sql` ke editor
6. Klik **Run** button
7. Tables akan dibuat otomatis

### 2. Run Aplikasi

```bash
flutter run -d chrome
```

Aplikasi akan:
1. Inisialisasi Supabase connection
2. Verify database tables
3. Seed sample data (jika belum ada)
4. Redirect ke login screen

### 3. Test Authentication

- **Akun yang sudah ada:**
  - Email: `yud@gmail.com`
  - Password: (sesuai registrasi Anda)

- **Atau register akun baru** via Register screen

## Database Schema

### Tables yang dibuat:

1. **laundries** - Daftar laundry services
   - id, name, address, rating, etc.
   
2. **services** - Service yang ditawarkan oleh tiap laundry
   - id, laundry_id, name, price, etc.

3. **offers** - Promo dan diskon
   - id, laundry_id, title, discount, etc.

4. **orders** - Pesanan dari users
   - id, user_id, laundry_id, status, etc.

5. **reviews** - Review dari users
   - id, user_id, laundry_id, rating, etc.

6. **favorites** - Laundry favorit users
   - id, user_id, laundry_id

## Troubleshooting

### Error: "Could not find table 'public.users'"
- Run SQL script di Supabase Dashboard (ikuti langkah 1)
- Atau tunggu app auto-create tables (beberapa fitur mungkin tidak bekerja)

### Error: "Supabase not initialized"
- Pastikan internet connection aktif
- Restart app: `flutter clean` kemudian `flutter run`

### Login gagal
- Verifikasi credentials Supabase di `lib/main.dart`
- Pastikan project Supabase aktif

## Credentials

**Supabase Project Info:**
- URL: https://tkhvhlafdaccagodxqie.supabase.co
- Anon Key: sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK

> ⚠️ Jangan commit credentials ke git - ini hanya untuk development

<img width="531" height="819" alt="image" src="https://github.com/user-attachments/assets/f7caca32-b630-4cd4-84cf-637a9aa133f4" />  <img width="517" height="818" alt="Screenshot 2026-01-29 012859" src="https://github.com/user-attachments/assets/422849d8-476a-405d-866c-c33100b2796e" />     <img width="506" height="826" alt="Screenshot 2026-01-29 012926" src="https://github.com/user-attachments/assets/e62eea27-c5f4-4f74-88f8-b9737eba3f95" /> <img width="521" height="825" alt="Screenshot 2026-01-29 012944" src="https://github.com/user-attachments/assets/4744a2f3-8413-4a5a-893b-9ddd1b4ead33" /> <img width="528" height="806" alt="Screenshot 2026-01-29 013002" src="https://github.com/user-attachments/assets/a2abd574-dbf2-486d-9430-6d6736b633d2" /> <img width="520" height="815" alt="Screenshot 2026-01-29 013024" src="https://github.com/user-attachments/assets/06212e62-7d23-49e1-b128-bc42d0aafe05" /> <img width="520" height="886" alt="Screenshot 2026-01-29 013038" src="https://github.com/user-attachments/assets/2f46674c-9e9b-4865-9152-8f4d702da5c2" />

















# 🧺 Laundry Service Mobile Application

Platform mobile comprehensive untuk reservasi dan pemesanan layanan laundry. Aplikasi ini memungkinkan pengguna untuk menemukan, membandingkan, dan memesan layanan laundry dari berbagai penyedia dengan mudah dan cepat.

---

## 📋 Table of Contents

- [Fitur Utama](#fitur-utama)
- [Stack Teknologi](#stack-teknologi)
- [Struktur Proyek](#struktur-proyek)
- [Instalasi & Setup](#instalasi--setup)
- [Konfigurasi Awal](#konfigurasi-awal)
- [Panduan Penggunaan](#panduan-penggunaan)
- [API Documentation](#api-documentation)
- [Struktur Database](#struktur-database)
- [State Management](#state-management)
- [Troubleshooting](#troubleshooting)

---

## ✨ Fitur Utama

### 1. **Autentikasi & Akun Pengguna**
- ✅ Registrasi akun baru
- ✅ Login dengan email/password
- ✅ Logout dan session management
- ✅ Profil pengguna yang dapat diedit
- ✅ Simpan data pengguna dengan SharedPreferences

### 2. **Jelajahi Layanan Laundry**
- 🔍 Daftar lengkap laundry service
- 📍 Filter berdasarkan lokasi & jarak
- ⭐ Rating dan review dari pengguna lain
- 💬 Lihat detail review pelanggan
- 🏷️ Kategori layanan yang beragam

### 3. **Manajemen Pesanan**
- 📝 Booking laundry service dengan detail
- 🛒 Keranjang untuk multiple services
- 💳 Ringkasan harga dan total biaya
- 📅 Jadwal pickup dan delivery
- 🔄 Tracking status pesanan real-time

### 4. **Promo & Penawaran**
- 🎉 Lihat penawaran eksklusif
- 💰 Diskon khusus berdasarkan kategori
- 📢 Notifikasi promo terbaru

### 5. **Favorit & Wishlist**
- ❤️ Simpan laundry favorit
- 📌 Akses cepat ke layanan pilihan
- ✏️ Kelola daftar favorit

### 6. **Dukungan Bahasa**
- 🌐 Multi-language support
- 🇮🇩 Bahasa Indonesia
- 🇬🇧 English

### 7. **Tema & Preferensi**
- 🌙 Dark mode support
- 🎨 Customizable theme
- 💾 Preferensi tersimpan otomatis

---

## 🛠️ Stack Teknologi

### Frontend
| Teknologi | Versi | Fungsi |
|-----------|-------|--------|
| **Flutter** | 3.9.2+ | Framework UI cross-platform |
| **Dart** | Latest | Bahasa pemrograman |
| **Provider** | 6.1.2 | State management |
| **Supabase Flutter** | 1.6.0+ | Backend & Authentication |

### Backend & Database
| Teknologi | Fungsi |
|-----------|--------|
| **Supabase** | Backend-as-a-Service (BaaS) |
| **PostgreSQL** | Database relasional |
| **PostgREST** | Automatic REST API |
| **Supabase Auth** | Authentication service |

### UI & UX Libraries
| Package | Versi | Fungsi |
|---------|-------|--------|
| `cupertino_icons` | 1.0.8 | iOS-style icons |
| `flutter_animate` | 4.5.2 | Animation library |
| `smooth_page_indicator` | 1.2.0+3 | Page indicator |
| `cached_network_image` | 3.4.1 | Image caching |
| `shimmer` | 3.0.0 | Loading shimmer effect |
| `flutter_rating_bar` | 4.0.1 | Rating widget |
| `google_fonts` | 6.2.1 | Custom fonts |

### Utilities
| Package | Versi | Fungsi |
|---------|-------|--------|
| `http` | 1.2.2 | HTTP requests |
| `shared_preferences` | 2.3.4 | Local storage |
| `intl` | 0.20.2 | Internationalization |
| `url_launcher` | 6.2.4 | Open URLs |

---

## 📁 Struktur Proyek

```
flutter_application_1/
├── 📄 pubspec.yaml                    # Dependencies & project config
├── 📄 analysis_options.yaml           # Lint rules
├── 📄 README.md                       # Documentation (file ini)
├── 📄 COMPLETE_SETUP.md              # Setup guide lengkap
├── 📄 REST_API.md                    # API documentation
├── 📄 SUPABASE_SETUP.md              # Supabase configuration
├── 📄 POSTMAN_GUIDE.md               # API testing guide
│
├── 📁 lib/                           # Source code utama
│   ├── 📄 main.dart                  # Entry point aplikasi
│   ├── 📄 supabase_auto_setup.dart   # Supabase initialization
│   │
│   ├── 📁 config/                    # Konfigurasi global
│   │   ├── constants.dart            # App constants & API keys
│   │   └── theme.dart                # Theme configuration
│   │
│   ├── 📁 models/                    # Data models
│   │   ├── laundry_model.dart        # Model untuk Laundry
│   │   ├── service_model.dart        # Model untuk Services
│   │   ├── order_model.dart          # Model untuk Orders
│   │   ├── offer_model.dart          # Model untuk Offers
│   │   └── user_model.dart           # Model untuk User
│   │
│   ├── 📁 providers/                 # State Management (Provider)
│   │   ├── auth_provider.dart        # Authentication state
│   │   ├── supabase_auth_provider.dart
│   │   ├── laundry_provider.dart     # Laundry data state
│   │   ├── supabase_laundry_provider.dart
│   │   ├── order_provider.dart       # Order state
│   │   ├── supabase_order_provider.dart
│   │   ├── cart_provider.dart        # Shopping cart state
│   │   ├── language_provider.dart    # Language/i18n state
│   │   └── theme_provider.dart       # Theme state
│   │
│   ├── 📁 screens/                   # UI Screens
│   │   ├── auth/                     # Authentication screens
│   │   │   ├── onboarding_screen.dart
│   │   │   └── login_screen.dart
│   │   ├── home/                     # Home screen
│   │   │   └── main_screen.dart
│   │   ├── laundry/                  # Laundry detail & browse
│   │   │   └── laundry_detail_screen.dart
│   │   ├── bookings/                 # Booking & order screens
│   │   ├── cart/                     # Shopping cart
│   │   ├── offers/                   # Promotions & offers
│   │   └── profile/                  # User profile
│   │
│   ├── 📁 services/                  # Business logic & API calls
│   │   ├── api_service.dart          # API integration
│   │   ├── supabase_service.dart     # Supabase operations
│   │   └── ...
│   │
│   └── 📁 widgets/                   # Reusable UI components
│       ├── custom_app_bar.dart
│       ├── laundry_card.dart
│       └── ...
│
├── 📁 assets/                        # Media & resources
│   └── images/                       # Gambar aplikasi
│
├── 📁 android/                       # Android-specific code
│   └── app/src/...
│
├── 📁 ios/                           # iOS-specific code
│   └── Runner/...
│
├── 📁 web/                           # Web platform support
├── 📁 windows/                       # Windows platform support
├── 📁 linux/                         # Linux platform support
├── 📁 macos/                         # macOS platform support
│
└── 📁 test/                          # Unit & widget tests
    └── widget_test.dart
```

---

## 🚀 Instalasi & Setup

### 1. **Prerequisites**

Pastikan Anda memiliki:
- ✅ Flutter SDK v3.9.2 atau lebih tinggi
- ✅ Dart SDK (included dengan Flutter)
- ✅ Git
- ✅ Code Editor (VS Code / Android Studio recommended)
- ✅ Supabase Account (gratis)

### 2. **Instalasi Flutter**

```bash
# Download Flutter dari: https://flutter.dev/docs/get-started/install

# Verify instalasi
flutter doctor

# Tambahkan ke PATH jika belum
# Windows: C:\flutter\bin
# macOS/Linux: ~/flutter/bin
```

### 3. **Clone Repository**

```bash
cd d:\projekanwebdanmobile\projekanmobile\UAS_mobile
cd flutter_application_1
```

### 4. **Install Dependencies**

```bash
# Get pub packages
flutter pub get

# (Optional) Upgrade packages
flutter pub upgrade
```

### 5. **Konfigurasi Platform Target**

#### Android
```bash
flutter config --android-sdk=/path/to/android/sdk
# Buka android/app/build.gradle dan verifikasi SDK version
```

#### iOS (macOS only)
```bash
cd ios
pod install
cd ..
```

#### Web
```bash
flutter config --enable-web
```

---

## ⚙️ Konfigurasi Awal

### 1. **Supabase Project Setup**

#### Step 1: Buat Project di Supabase
1. Kunjungi https://app.supabase.com
2. Klik "New Project"
3. Isi form:
   - **Project Name**: Laundry Service
   - **Password**: (simpan dengan aman)
   - **Region**: pilih yang terdekat

#### Step 2: Dapatkan API Keys
- **Project URL**: Gunakan di `constants.dart`
- **Anon Key**: Gunakan di `constants.dart`

Lokasi di Supabase Dashboard:
```
Settings → API → Project API keys
```

### 2. **Update Konfigurasi di Aplikasi**

**File:** `lib/config/constants.dart`

```dart
class AppConstants {
  static const String baseUrl = 'https://[YOUR_PROJECT_ID].supabase.co';
  static const String anonKey = 'YOUR_ANON_KEY_HERE';
  // ... constants lainnya
}
```

**File:** `lib/main.dart`

```dart
await Supabase.initialize(
  url: 'https://[YOUR_PROJECT_ID].supabase.co',
  anonKey: 'YOUR_ANON_KEY_HERE',
);
```

### 3. **Setup Database**

Jalankan SQL script di Supabase SQL Editor:

```bash
# Buka file
supabase_setup.sql

# Copy semua content dan jalankan di Supabase SQL Editor
```

**Tables yang dibuat:**
- `laundries` - Daftar laundry service
- `services` - Detail layanan per laundry
- `orders` - Pesanan pengguna
- `offers` - Promosi & diskon
- `reviews` - Review & rating
- `favorites` - Laundry favorit pengguna

### 4. **RLS (Row Level Security) Configuration**

Setup security policies di Supabase:

```sql
-- Enable RLS pada tabel users
ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

-- Create policy untuk read laundries (public)
CREATE POLICY "Allow read laundries" ON laundries
  FOR SELECT USING (true);

-- Create policy untuk user orders
CREATE POLICY "Users can read own orders" ON orders
  FOR SELECT USING (auth.uid() = user_id);
```

---

## 📖 Panduan Penggunaan

### Running Aplikasi

#### Development Mode
```bash
# Run di Android emulator/device
flutter run -d android

# Run di iOS simulator (macOS only)
flutter run -d ios

# Run di web browser
flutter run -d chrome

# Run dengan verbose mode (untuk debugging)
flutter run -v
```

#### Build untuk Production

**Android APK:**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-app.apk
```

**Android App Bundle:**
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app.aab
```

**iOS:**
```bash
flutter build ios --release
# Gunakan Xcode untuk submit ke App Store
```

**Web:**
```bash
flutter build web --release
# Output: build/web/
```

### Menu & Navigasi Utama

#### 1. **Onboarding Screen**
- Ditampilkan pada first launch
- Penjelasan fitur aplikasi
- Tombol "Mulai" untuk ke login

#### 2. **Authentication**
- Login dengan email & password
- Registrasi akun baru
- Validasi input form
- Error handling untuk invalid credentials

#### 3. **Home Screen**
- Carousel dengan featured laundries
- Daftar laundry terdekat
- Search & filter functionality
- Quick access buttons untuk categories

#### 4. **Laundry Detail**
- Informasi lengkap laundry
- Daftar services & pricing
- Customer reviews & ratings
- Map location
- Call/Whatsapp buttons

#### 5. **Booking & Cart**
- Pilih services dari cart
- Set pickup date & time
- Lihat total harga dengan tax/shipping
- Confirm order

#### 6. **Order History**
- Daftar semua pesanan
- Status tracking real-time
- Riwayat pembayaran
- Download invoice

#### 7. **Profile**
- Edit informasi pengguna
- Alamat pengiriman
- Payment methods
- Preferences & settings

---

## 🔌 API Documentation

### Base URL
```
https://[PROJECT_ID].supabase.co/rest/v1
```

### Authentication Header
```
Authorization: Bearer [ANON_KEY]
Content-Type: application/json
```

### Laundries Endpoints

#### GET /laundries
Dapatkan daftar semua laundry

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/laundries" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

**Response:**
```json
[
  {
    "id": "laundry_1",
    "name": "Express Laundry",
    "address": "Jl. Merdeka No. 123",
    "image": "https://...",
    "rating": 4.8,
    "review_count": 156,
    "distance": "2.5 km",
    "is_open": true,
    "open_time": "07:00",
    "close_time": "21:00",
    "services": ["wash", "dry_clean", "iron"],
    "phone_number": "021-1234567"
  }
]
```

#### GET /laundries?id=eq.{id}
Dapatkan detail laundry tertentu

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/laundries?id=eq.laundry_1" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

### Services Endpoints

#### GET /services?laundry_id=eq.{laundry_id}
Dapatkan daftar services dari laundry tertentu

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/services?laundry_id=eq.laundry_1" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

**Response:**
```json
[
  {
    "id": "service_1",
    "laundry_id": "laundry_1",
    "name": "Wash Regular",
    "price": 5000,
    "description": "Cuci baju reguler standar",
    "category": "wash",
    "duration_hours": 2
  }
]
```

### Orders Endpoints

#### POST /orders
Buat pesanan baru

```bash
curl -X POST "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/orders" \
  -H "Authorization: Bearer [ANON_KEY]" \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": "user_123",
    "laundry_id": "laundry_1",
    "services": ["service_1", "service_2"],
    "total_price": 50000,
    "pickup_date": "2026-01-25",
    "delivery_date": "2026-01-27",
    "status": "pending"
  }'
```

#### GET /orders?user_id=eq.{user_id}
Dapatkan pesanan user tertentu

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/orders?user_id=eq.user_123" \
  -H "Authorization: Bearer [ANON_KEY]"
```

---

## 💾 Struktur Database

### Tabel: `laundries`
```sql
CREATE TABLE laundries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR NOT NULL,
  address VARCHAR NOT NULL,
  phone_number VARCHAR,
  email VARCHAR,
  image_url TEXT,
  rating DECIMAL(3,2) DEFAULT 0,
  review_count INTEGER DEFAULT 0,
  open_time TIME DEFAULT '08:00',
  close_time TIME DEFAULT '21:00',
  is_open BOOLEAN DEFAULT true,
  latitude DECIMAL(10,8),
  longitude DECIMAL(11,8),
  description TEXT,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);
```

### Tabel: `services`
```sql
CREATE TABLE services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  laundry_id UUID REFERENCES laundries(id),
  name VARCHAR NOT NULL,
  description TEXT,
  category VARCHAR,
  price DECIMAL(10,2) NOT NULL,
  duration_hours INTEGER,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT now()
);
```

### Tabel: `orders`
```sql
CREATE TABLE orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  laundry_id UUID REFERENCES laundries(id),
  service_ids TEXT[],
  total_price DECIMAL(10,2),
  status VARCHAR DEFAULT 'pending',
  pickup_date DATE,
  delivery_date DATE,
  notes TEXT,
  created_at TIMESTAMP DEFAULT now(),
  updated_at TIMESTAMP DEFAULT now()
);
```

### Tabel: `reviews`
```sql
CREATE TABLE reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  laundry_id UUID REFERENCES laundries(id),
  order_id UUID REFERENCES orders(id),
  rating DECIMAL(3,2),
  comment TEXT,
  created_at TIMESTAMP DEFAULT now()
);
```

### Tabel: `offers`
```sql
CREATE TABLE offers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR NOT NULL,
  description TEXT,
  discount_percentage DECIMAL(5,2),
  laundry_id UUID REFERENCES laundries(id),
  valid_from DATE,
  valid_until DATE,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT now()
);
```

### Tabel: `favorites`
```sql
CREATE TABLE favorites (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  laundry_id UUID REFERENCES laundries(id),
  created_at TIMESTAMP DEFAULT now()
);
```

---

## 🏗️ State Management

Aplikasi menggunakan **Provider** untuk state management. Berikut adalah structure:

### Auth Provider
**File:** `lib/providers/supabase_auth_provider.dart`

```dart
class SupabaseAuthProvider extends ChangeNotifier {
  // Properties
  bool get isLoggedIn => _currentUser != null;
  User? get currentUser => _currentUser;

  // Methods
  Future<void> login(String email, String password) async { ... }
  Future<void> signup(String email, String password) async { ... }
  Future<void> logout() async { ... }
}
```

### Laundry Provider
**File:** `lib/providers/supabase_laundry_provider.dart`

```dart
class SupabaseLaundryProvider extends ChangeNotifier {
  // Properties
  List<Laundry> get laundries => _laundries;
  Laundry? get selectedLaundry => _selectedLaundry;

  // Methods
  Future<void> fetchLaundries() async { ... }
  Future<void> searchLaundries(String query) async { ... }
  void selectLaundry(Laundry laundry) { ... }
}
```

### Order Provider
**File:** `lib/providers/supabase_order_provider.dart`

```dart
class SupabaseOrderProvider extends ChangeNotifier {
  // Properties
  List<Order> get orders => _orders;
  Order? get currentOrder => _currentOrder;

  // Methods
  Future<void> createOrder(Order order) async { ... }
  Future<void> fetchUserOrders(String userId) async { ... }
  Future<void> updateOrderStatus(String orderId, String status) async { ... }
}
```

### Cart Provider
**File:** `lib/providers/cart_provider.dart`

```dart
class CartProvider extends ChangeNotifier {
  // Properties
  List<CartItem> get items => _items;
  double get totalPrice => _totalPrice;

  // Methods
  void addToCart(CartItem item) { ... }
  void removeFromCart(String itemId) { ... }
  void clearCart() { ... }
  void calculateTotal() { ... }
}
```

### Usage dalam Widget
```dart
// Membaca data
final authProvider = Provider.of<SupabaseAuthProvider>(context);

// Dengan Consumer
Consumer<SupabaseLaundryProvider>(
  builder: (context, laundryProvider, child) {
    return ListView(
      children: laundryProvider.laundries.map((laundry) {
        return LaundryCard(laundry: laundry);
      }).toList(),
    );
  },
)

// Update state
button(
  onPressed: () {
    authProvider.login(email, password);
  },
)
```

---

## 🎨 Theme & Styling

### Custom Theme
**File:** `lib/config/theme.dart`

```dart
class AppTheme {
  // Colors
  static const primaryColor = Color(0xFF1E88E5);
  static const secondaryColor = Color(0xFFFFA500);
  static const accentColor = Color(0xFFFF6B6B);
  
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    // ... configuration
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    // ... configuration
  );
}
```

---

## 🌐 Internasionalisasi (i18n)

### Supported Languages
- 🇮🇩 Bahasa Indonesia (id)
- 🇬🇧 English (en)

### Language Provider
**File:** `lib/providers/language_provider.dart`

```dart
class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('id', 'ID');
  
  void changeLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
}
```

### Usage
```dart
// Dalam main.dart
localizationsDelegates: [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
],
supportedLocales: [
  const Locale('id', 'ID'),
  const Locale('en', 'US'),
],

// Dalam widget
String label = AppLocalizations.of(context)!.welcomeMessage;
```

---

## 🐛 Troubleshooting

### Masalah Umum & Solusi

#### 1. "pubspec.yaml dependency error"
```bash
# Solusi
flutter pub get
flutter pub upgrade

# Jika masih error
rm -rf pubspec.lock
rm -rf build/
flutter pub get
```

#### 2. "Supabase initialization failed"
- ✅ Cek internet connection
- ✅ Verify Project URL & Anon Key di constants.dart
- ✅ Pastikan Supabase project active
- ✅ Check firewall/proxy settings

```dart
// Debug
try {
  await Supabase.initialize(...);
  print('Supabase initialized successfully');
} catch (e) {
  print('Supabase error: $e');
}
```

#### 3. "Flutter SDK not found"
```bash
# Cek versi Flutter
flutter --version

# Update Flutter
flutter upgrade

# Config Android/iOS SDK
flutter config --android-sdk=/path/to/sdk
```

#### 4. "Hot reload tidak bekerja"
```bash
# Stop app dan jalankan ulang
flutter run -v

# Atau gunakan hot restart
# Di terminal: 'R'
```

#### 5. "HTTP request timeout"
```dart
// Increase timeout di constants.dart
static const Duration requestTimeout = Duration(seconds: 30);

// Atau setup retry logic di API service
```

#### 6. "Database connection refused"
- ✅ Verify internet connection
- ✅ Check Supabase dashboard status
- ✅ Verify RLS policies
- ✅ Test dengan Postman

### Debug Tips

#### Enable Logging
```dart
// Di main.dart
void main() {
  debugPrint = (String? message, {int? wrapWidth}) {
    print('[FLUTTER] $message');
  };
  runApp(const MyApp());
}
```

#### Network Debugging
```bash
# Monitor network traffic
flutter run -v

# Gunakan proxy debugger
# Charles Proxy, Fiddler, atau Wireshark
```

#### Database Debugging
```bash
# Gunakan Supabase Studio
# View logs: Settings → Logs

# Atau gunakan psql
psql -h db.tkhvhlafdaccagodxqie.supabase.co \
     -U postgres \
     -d postgres
```

---

## 📚 Resources & Documentation

### Official Documentation
- 🔗 [Flutter Documentation](https://flutter.dev/docs)
- 🔗 [Dart Documentation](https://dart.dev/guides)
- 🔗 [Supabase Documentation](https://supabase.com/docs)
- 🔗 [Provider Package](https://pub.dev/packages/provider)

### Setup Guides
- 📖 [COMPLETE_SETUP.md](COMPLETE_SETUP.md) - Setup lengkap
- 📖 [SUPABASE_SETUP.md](SUPABASE_SETUP.md) - Konfigurasi Supabase
- 📖 [REST_API.md](REST_API.md) - API documentation

### Testing & API
- 📖 [POSTMAN_GUIDE.md](POSTMAN_GUIDE.md) - Postman collection guide
- 📄 [supabase_setup.sql](supabase_setup.sql) - Database SQL script

---

## 📱 Platform Support

| Platform | Status | Requirements |
|----------|--------|--------------|
| **Android** | ✅ Supported | Android 5.0+ (API 21) |
| **iOS** | ✅ Supported | iOS 11.0+ |
| **Web** | ✅ Supported | Modern browsers |
| **Windows** | ✅ Supported | Windows 10+ |
| **macOS** | ✅ Supported | macOS 10.14+ |
| **Linux** | ✅ Supported | GTK 3.0+ |

---

## 📋 Development Checklist

- [ ] Flutter SDK installed & configured
- [ ] Supabase project created
- [ ] API keys updated in constants.dart
- [ ] Database tables setup via SQL script
- [ ] RLS policies configured
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Run app successfully (`flutter run`)
- [ ] Test authentication flow
- [ ] Test laundry browsing
- [ ] Test booking & cart
- [ ] Test API endpoints via Postman

---

## 🤝 Contributing

Untuk kontribusi ke project ini:

1. Fork repository
2. Buat branch feature (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

---

## 📄 License

Project ini available under the MIT License. Lihat LICENSE file untuk details.

---

## 👨‍💻 Support & Contact

Untuk pertanyaan atau issue:
- 📧 Email: support@laundryservice.com
- 💬 Discord: [Join Server]
- 📞 Whatsapp: [Contact Number]

---

## 🎯 Future Improvements

- [ ] Payment gateway integration (Stripe, GCash)
- [ ] Real-time chat dengan laundry
- [ ] Push notifications
- [ ] Loyalty/rewards program
- [ ] Advanced analytics dashboard
- [ ] Multi-language support (lebih banyak bahasa)
- [ ] Offline mode support
- [ ] Video tutorial in-app

---

**Last Updated:** January 2026
**Version:** 1.0.0
**Maintained by:** Development Team















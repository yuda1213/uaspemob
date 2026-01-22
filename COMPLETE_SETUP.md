# Laundry Service App - Complete Setup Guide

## Architecture Overview

Aplikasi menggunakan **Supabase + REST API** sebagai backend dengan Flutter sebagai frontend.

### Technology Stack
- **Frontend:** Flutter (Dart)
- **Backend:** Supabase (PostgreSQL + PostgREST API)
- **Authentication:** Supabase Auth
- **State Management:** Provider
- **Real-time:** Supabase Realtime (optional)

## Step-by-Step Setup

### Prerequisites
1. **Flutter SDK** installed (v3.9.2+)
2. **Supabase Account** (free tier available)
3. **Chrome Browser** (for web development)
4. **Code Editor** (VS Code recommended)

### 1. Project Initialization (Already Done)

```bash
flutter create flutter_application_1
cd flutter_application_1
```

### 2. Supabase Configuration

#### Create Supabase Project
1. Visit [app.supabase.com](https://app.supabase.com)
2. Click "New Project"
3. Fill in project details:
   - **Name:** Laundry App
   - **Password:** (Set secure password)
   - **Region:** Choose nearest region

#### Get Credentials
After project creation, you'll get:
- **Project URL:** `https://tkhvhlafdaccagodxqie.supabase.co`
- **Anon Key:** `sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK`

### 3. Database Setup

#### Create Tables (Using SQL Editor)

1. Open Supabase Dashboard
2. Go to **SQL Editor**
3. Click **+ New Query**
4. Copy-paste from `supabase_setup.sql`
5. Click **Run**

Tables created:
- `laundries` - Laundry services
- `services` - Individual services  
- `offers` - Promotions
- `orders` - User orders
- `reviews` - Customer reviews
- `favorites` - Bookmarked laundries

### 4. Flutter Dependencies

Already added in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^1.10.25
  provider: ^6.1.2
  shared_preferences: ^2.3.4
  google_fonts: ^6.3.3
  flutter_animate: ^4.2.1
```

Install dependencies:
```bash
flutter pub get
```

### 5. Environment Configuration

Update `lib/main.dart`:

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://tkhvhlafdaccagodxqie.supabase.co',
    anonKey: 'sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK',
  );
  runApp(const MyApp());
}
```

### 6. Run Application

#### Development Mode
```bash
# Hot reload enabled
flutter run -d chrome
```

#### Build for Web
```bash
flutter build web
```

#### Build for Android
```bash
flutter build apk
```

## File Structure

```
lib/
├── main.dart                          # App entry point
├── supabase_auto_setup.dart          # DB initialization
├── config/
│   ├── theme.dart                    # UI theme
│   └── constants.dart                # App constants
├── models/
│   ├── user_model.dart              # User data model
│   └── [other models]               # Domain models
├── providers/
│   ├── supabase_auth_provider.dart  # Auth state
│   ├── supabase_laundry_provider.dart # Laundry data
│   └── supabase_order_provider.dart  # Order data
├── services/
│   ├── supabase_service.dart         # Main service
│   ├── supabase_rest_api.dart       # REST endpoints
│   ├── seed_data.dart               # Sample data
│   └── database_setup.dart          # Table creation
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── forgot_password_screen.dart
│   ├── home/
│   │   └── main_screen.dart
│   ├── laundry/
│   │   ├── laundry_list_screen.dart
│   │   └── laundry_detail_screen.dart
│   ├── order/
│   │   ├── checkout_screen.dart
│   │   └── order_tracking_screen.dart
│   └── profile/
│       └── profile_screen.dart
└── assets/
    └── images/
```

## API Integration

### REST API Endpoints

All endpoints use Supabase PostgREST API:

```
Base URL: https://tkhvhlafdaccagodxqie.supabase.co/rest/v1
```

#### Main Endpoints

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/laundries` | List all laundries |
| GET | `/laundries?id=eq.{id}` | Get laundry detail |
| GET | `/services?laundry_id=eq.{id}` | Get services by laundry |
| GET | `/offers?is_active=eq.true` | Get active offers |
| POST | `/orders` | Create new order |
| GET | `/orders?user_id=eq.{id}` | Get user orders |
| POST | `/reviews` | Add review |
| POST | `/favorites` | Add favorite |

### Flutter REST API Client

Use `SupabaseRestApi` class:

```dart
import 'services/supabase_rest_api.dart';

final api = SupabaseRestApi();

// Example: Get all laundries
final laundries = await api.getAllLaundries();

// Example: Search laundries
final results = await api.searchLaundries('express');

// Example: Create order
await api.createOrder(
  id: 'order_123',
  userId: userId,
  laundryId: 'laundry_1',
  items: [
    {'service_id': 'service_1', 'quantity': 5, 'price': 5000}
  ],
  totalPrice: 25000,
);
```

See [REST_API.md](REST_API.md) for complete endpoint documentation.

## Data Models

### Laundry Model
```dart
{
  "id": "laundry_1",
  "name": "Express Laundry",
  "address": "Jl. Merdeka No. 123",
  "rating": 4.8,
  "review_count": 156,
  "distance": "2.5 km",
  "is_open": true,
  "services": ["wash", "dry_clean"],
  "phone_number": "021-1234567"
}
```

### Order Model
```dart
{
  "id": "order_1",
  "user_id": "user_uuid",
  "laundry_id": "laundry_1",
  "items": [
    {"service_id": "service_1", "quantity": 5, "price": 5000}
  ],
  "total_price": 25000,
  "status": "pending",
  "created_at": "2026-01-20T09:00:00Z"
}
```

## Authentication Flow

### Register
1. User enters email, password, name, phone
2. App calls `supabaseAuth.signUp()`
3. Supabase creates auth user
4. Data saved to `users` table (if available)
5. Redirect to home/login

### Login
1. User enters email, password
2. App calls `supabaseAuth.signInWithPassword()`
3. Session token received
4. Redirect to home screen
5. App remembers session in SharedPreferences

### Logout
1. User clicks logout
2. App calls `supabaseAuth.signOut()`
3. Session cleared
4. Redirect to login screen

### Password Reset
1. User enters email
2. App calls `supabaseAuth.resetPasswordForEmail()`
3. Reset email sent to user
4. User follows link to reset password

## State Management (Provider)

### Authentication State
```dart
Provider.of<SupabaseAuthProvider>(context)
  .login(email: 'user@example.com', password: 'pass123');
```

### Laundry Data State
```dart
Provider.of<SupabaseLaundryProvider>(context)
  .fetchLaundries();
```

### Order State
```dart
Provider.of<SupabaseOrderProvider>(context)
  .createOrder(...);
```

## Testing

### Test Login
1. Email: `yud@gmail.com`
2. Password: (use your registered password)
3. Or register new account

### Test API Calls
```dart
// In main.dart or any screen
final service = SupabaseService();
final laundries = await service.getLaundries();
print('Laundries: $laundries');
```

## Common Issues & Solutions

### Issue: "Could not find table 'public.users'"
**Solution:** Run SQL script from `supabase_setup.sql` in Supabase Dashboard

### Issue: "Supabase not initialized"
**Solution:** Ensure `Supabase.initialize()` is called in `main()` before app runs

### Issue: "Authentication failed"
**Solution:** Check credentials in `main.dart` or verify Supabase project is active

### Issue: "CORS error"
**Solution:** Supabase automatically handles CORS. If persists, check API key permissions

## Performance Optimization

1. **Pagination:** Use `limit` and `offset` parameters
```dart
?limit=10&offset=0
```

2. **Selective Columns:** Only fetch needed columns
```dart
?select=id,name,rating
```

3. **Indexing:** Database indexes on frequently queried fields (already done)

4. **Caching:** Use SharedPreferences for user preferences
```dart
final prefs = await SharedPreferences.getInstance();
prefs.setString('user_id', userId);
```

## Deployment

### Firebase Hosting (Optional)
```bash
# Build web
flutter build web

# Deploy to Firebase Hosting
firebase deploy
```

### APK for Android
```bash
flutter build apk --release
```

## Security Best Practices

1. **Never commit credentials** - Use `.env` file
2. **Enable RLS** - Row Level Security on all tables
3. **Validate inputs** - All user inputs must be validated
4. **Use HTTPS** - Always use secure connections
5. **Rotate keys** - Regenerate keys periodically

## Monitoring

### View Logs
1. Open Supabase Dashboard
2. Go to **Logs** → **API**
3. Monitor API requests and errors

### Check Database
1. Go to **Table Editor**
2. View table contents
3. Monitor data changes

## Useful Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Flutter Documentation](https://flutter.dev/docs)
- [PostgREST API Reference](https://postgrest.org/)
- [Provider Documentation](https://pub.dev/packages/provider)

## Support

For issues or questions:
1. Check [REST_API.md](REST_API.md) for endpoint docs
2. Check [SUPABASE_SETUP.md](SUPABASE_SETUP.md) for database setup
3. Review code comments in service files
4. Check official documentation links above

---

**Last Updated:** January 20, 2026  
**Version:** 1.0.0  
**Status:** Ready for Production Setup

# REST API Documentation - Supabase Integration

## Overview

Aplikasi menggunakan **Supabase PostgREST API** untuk semua operasi database. REST API ini automatically generated oleh Supabase berdasarkan struktur database.

## Base URL

```
https://tkhvhlafdaccagodxqie.supabase.co/rest/v1
```

## Authentication

Semua request memerlukan header:

```
Authorization: Bearer <ANON_KEY>
Content-Type: application/json
```

Anon Key:
```
sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK
```

## Available Endpoints

### 1. Laundries

#### GET /laundries
Retrieve all laundries

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
    "description": "Laundry service terpercaya...",
    "latitude": -6.2,
    "longitude": 106.8,
    "phone_number": "021-1234567",
    "email": "express@laundry.com",
    "created_at": "2026-01-20T09:00:00Z"
  }
]
```

#### GET /laundries?id=eq.{id}
Get specific laundry

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/laundries?id=eq.laundry_1" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

#### GET /laundries?name=ilike.%{query}%
Search laundries

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/laundries?name=ilike.%Express%" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

### 2. Services

#### GET /services?laundry_id=eq.{laundry_id}
Get services by laundry

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
    "description": "Cuci baju reguler",
    "category": "wash",
    "duration_hours": 2,
    "is_available": true,
    "created_at": "2026-01-20T09:00:00Z"
  }
]
```

### 3. Offers

#### GET /offers?laundry_id=eq.{laundry_id}&is_active=eq.true
Get active offers by laundry

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/offers?laundry_id=eq.laundry_1&is_active=eq.true" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

**Response:**
```json
[
  {
    "id": "offer_1",
    "laundry_id": "laundry_1",
    "title": "Diskon 20% untuk member baru",
    "description": "Hemat hingga 20% untuk transaksi pertama",
    "discount_percentage": 20,
    "discount_amount": null,
    "min_order": 50000,
    "start_date": "2026-01-20T00:00:00Z",
    "end_date": "2026-02-20T23:59:59Z",
    "is_active": true,
    "created_at": "2026-01-20T09:00:00Z"
  }
]
```

### 4. Orders

#### POST /orders
Create new order

```bash
curl -X POST "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/orders" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "order_1",
    "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
    "laundry_id": "laundry_1",
    "items": [
      {"service_id": "service_1", "quantity": 5, "price": 5000}
    ],
    "total_price": 25000,
    "status": "pending",
    "delivery_address": "Jl. Test No. 123"
  }'
```

#### GET /orders?user_id=eq.{user_id}
Get user orders

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/orders?user_id=eq.5e407e09-ece4-4e08-a193-985f851bff18" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

#### PATCH /orders?id=eq.{id}
Update order status

```bash
curl -X PATCH "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/orders?id=eq.order_1" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK" \
  -H "Content-Type: application/json" \
  -d '{"status": "confirmed"}'
```

### 5. Reviews

#### GET /reviews?laundry_id=eq.{laundry_id}
Get reviews by laundry

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/reviews?laundry_id=eq.laundry_1" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

#### POST /reviews
Create review

```bash
curl -X POST "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/reviews" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "review_1",
    "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
    "laundry_id": "laundry_1",
    "rating": 5,
    "comment": "Layanan sangat memuaskan!"
  }'
```

### 6. Favorites

#### GET /favorites?user_id=eq.{user_id}
Get user favorites

```bash
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/favorites?user_id=eq.5e407e09-ece4-4e08-a193-985f851bff18" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

#### POST /favorites
Add to favorites

```bash
curl -X POST "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/favorites" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "fav_1",
    "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
    "laundry_id": "laundry_1"
  }'
```

#### DELETE /favorites?user_id=eq.{user_id}&laundry_id=eq.{laundry_id}
Remove from favorites

```bash
curl -X DELETE "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/favorites?user_id=eq.5e407e09-ece4-4e08-a193-985f851bff18&laundry_id=eq.laundry_1" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK"
```

## Flutter Integration

### Using SupabaseRestApi Service

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/supabase_rest_api.dart';

final api = SupabaseRestApi();

// Get all laundries
final laundries = await api.getAllLaundries();

// Search laundries
final results = await api.searchLaundries('express');

// Get services for laundry
final services = await api.getServicesByLaundry('laundry_1');

// Create order
final order = await api.createOrder(
  id: 'order_123',
  userId: 'user_id',
  laundryId: 'laundry_1',
  items: [
    {'service_id': 'service_1', 'quantity': 5, 'price': 5000}
  ],
  totalPrice: 25000,
);

// Add review
await api.createReview(
  id: 'review_1',
  userId: 'user_id',
  laundryId: 'laundry_1',
  rating: 5,
  comment: 'Great service!',
);

// Manage favorites
await api.addToFavorites(
  id: 'fav_1',
  userId: 'user_id',
  laundryId: 'laundry_1',
);

final isFav = await api.isFavorite(
  userId: 'user_id',
  laundryId: 'laundry_1',
);

await api.removeFromFavorites(
  userId: 'user_id',
  laundryId: 'laundry_1',
);
```

## Query Parameters

### Filters
- `eq` - Equals
- `neq` - Not equals
- `gt` - Greater than
- `gte` - Greater than or equal
- `lt` - Less than
- `lte` - Less than or equal
- `like` - Pattern matching (case sensitive)
- `ilike` - Pattern matching (case insensitive)
- `in` - Match any value in array
- `contains` - Contains (JSONB)

### Ordering
```
?order=name.asc
?order=created_at.desc
```

### Pagination
```
?limit=10&offset=0
```

### Selection (Columns)
```
?select=id,name,rating
```

## Error Handling

All requests follow REST API standards:

- **200 OK** - Success
- **201 Created** - Created successfully
- **204 No Content** - Delete successful
- **400 Bad Request** - Invalid parameters
- **401 Unauthorized** - Missing auth header
- **404 Not Found** - Resource not found
- **409 Conflict** - Duplicate/unique constraint
- **500 Server Error** - Server error

## Real-time Subscriptions (Optional)

```dart
api.subscribeToLaundries((payload) {
  print('Laundry changed: ${payload.newRecord}');
});

api.subscribeToUserOrders('user_id', (payload) {
  print('Order changed: ${payload.newRecord}');
});
```

## Documentation Links

- [Supabase REST API Docs](https://supabase.com/docs/reference/dart/introduction)
- [PostgREST API Documentation](https://postgrest.org/en/stable/references/api/index.html)
- [Project URL](https://app.supabase.com/projects/tkhvhlafdaccagodxqie)

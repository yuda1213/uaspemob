# Testing Supabase REST API dengan Postman

## Step 1: Download & Install Postman

1. Buka [postman.com](https://www.postman.com/downloads/)
2. Download Postman (Windows/Mac/Linux)
3. Install dan buka aplikasi

## Step 2: Setup Environment di Postman

### Buat Environment Baru

1. Klik **Environments** (di sidebar kiri)
2. Klik **Create New Environment**
3. Beri nama: `Supabase Laundry App`
4. Tambah variables:

```
Variable Name: base_url
Initial Value: https://tkhvhlafdaccagodxqie.supabase.co/rest/v1
Current Value: https://tkhvhlafdaccagodxqie.supabase.co/rest/v1

Variable Name: anon_key
Initial Value: sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK
Current Value: sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK

Variable Name: user_id
Initial Value: 5e407e09-ece4-4e08-a193-985f851bff18
Current Value: 5e407e09-ece4-4e08-a193-985f851bff18
```

5. Klik **Save**

### Gunakan Environment

1. Klik dropdown di kanan atas (sebelah Send)
2. Pilih `Supabase Laundry App`

---

## Step 3: Test API Endpoints

### 1. GET - List All Laundries

**Setup Request:**

| Field | Value |
|-------|-------|
| Method | GET |
| URL | `{{base_url}}/laundries` |

**Headers:**

| Key | Value |
|-----|-------|
| Authorization | Bearer `{{anon_key}}` |
| Content-Type | application/json |

**Click Send** ✅

**Expected Response:**
```json
[
  {
    "id": "laundry_1",
    "name": "Express Laundry",
    "address": "Jl. Merdeka No. 123, Jakarta",
    "image": "https://...",
    "rating": 4.8,
    "review_count": 156,
    "distance": "2.5 km",
    "is_open": true,
    "phone_number": "021-1234567"
  }
]
```

---

### 2. GET - Search Laundries

**URL:**
```
{{base_url}}/laundries?name=ilike.%Express%
```

**Headers:** (Same as above)

**Response:** Filtered laundries with "Express" in name

---

### 3. GET - Get Single Laundry

**URL:**
```
{{base_url}}/laundries?id=eq.laundry_1
```

**Headers:** (Same as above)

**Response:** Single laundry object

---

### 4. GET - Get Services by Laundry

**URL:**
```
{{base_url}}/services?laundry_id=eq.laundry_1
```

**Headers:** (Same as above)

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
    "is_available": true
  }
]
```

---

### 5. GET - Get Offers

**URL:**
```
{{base_url}}/offers?laundry_id=eq.laundry_1&is_active=eq.true
```

**Headers:** (Same as above)

**Response:** Active offers untuk laundry

---

### 6. POST - Create New Order

**URL:**
```
{{base_url}}/orders
```

**Method:** POST

**Headers:**
```
Authorization: Bearer {{anon_key}}
Content-Type: application/json
```

**Body (JSON):**
```json
{
  "id": "order_123",
  "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
  "laundry_id": "laundry_1",
  "items": [
    {
      "service_id": "service_1",
      "quantity": 5,
      "price": 5000
    }
  ],
  "total_price": 25000,
  "status": "pending",
  "delivery_address": "Jl. Test No. 123"
}
```

**Click Send** ✅

**Response:**
```json
{
  "id": "order_123",
  "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
  "laundry_id": "laundry_1",
  "total_price": 25000,
  "status": "pending",
  "created_at": "2026-01-20T10:00:00Z"
}
```

---

### 7. GET - Get User Orders

**URL:**
```
{{base_url}}/orders?user_id=eq.{{user_id}}
```

**Headers:** (Same as GET requests)

**Response:** List semua orders user

---

### 8. PATCH - Update Order Status

**URL:**
```
{{base_url}}/orders?id=eq.order_123
```

**Method:** PATCH

**Headers:**
```
Authorization: Bearer {{anon_key}}
Content-Type: application/json
```

**Body:**
```json
{
  "status": "confirmed"
}
```

**Click Send** ✅

**Response:** Updated order object

---

### 9. POST - Create Review

**URL:**
```
{{base_url}}/reviews
```

**Method:** POST

**Headers:**
```
Authorization: Bearer {{anon_key}}
Content-Type: application/json
```

**Body:**
```json
{
  "id": "review_1",
  "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
  "laundry_id": "laundry_1",
  "rating": 5,
  "comment": "Layanan sangat memuaskan!"
}
```

**Click Send** ✅

---

### 10. GET - Get Reviews

**URL:**
```
{{base_url}}/reviews?laundry_id=eq.laundry_1
```

**Headers:** (Same as GET requests)

**Response:** List reviews untuk laundry

---

### 11. POST - Add to Favorites

**URL:**
```
{{base_url}}/favorites
```

**Method:** POST

**Headers:**
```
Authorization: Bearer {{anon_key}}
Content-Type: application/json
```

**Body:**
```json
{
  "id": "fav_1",
  "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
  "laundry_id": "laundry_1"
}
```

**Click Send** ✅

---

### 12. GET - Get Favorites

**URL:**
```
{{base_url}}/favorites?user_id=eq.{{user_id}}
```

**Headers:** (Same as GET requests)

**Response:**
```json
[
  {
    "id": "fav_1",
    "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
    "laundry_id": "laundry_1"
  }
]
```

---

### 13. DELETE - Remove from Favorites

**URL:**
```
{{base_url}}/favorites?user_id=eq.{{user_id}}&laundry_id=eq.laundry_1
```

**Method:** DELETE

**Headers:**
```
Authorization: Bearer {{anon_key}}
Content-Type: application/json
```

**Click Send** ✅

**Response:** 204 No Content (success)

---

## Query Parameters Reference

### Filter Examples

```
Equals:
?id=eq.laundry_1

Not Equals:
?status=neq.completed

Greater Than:
?rating=gt.4

Greater Than or Equal:
?price=gte.10000

Less Than:
?distance=lt.5

Less Than or Equal:
?price=lte.50000

Pattern Matching (case sensitive):
?name=like.%Express%

Pattern Matching (case insensitive):
?name=ilike.%express%

In Array:
?status=in.(pending,confirmed)
```

### Order By

```
Ascending:
?order=name.asc

Descending:
?order=created_at.desc
```

### Pagination

```
Limit Results:
?limit=10

Offset Results:
?offset=0

Combined:
?limit=10&offset=20
```

---

## Common Response Codes

| Code | Meaning | Example |
|------|---------|---------|
| 200 | OK - Request berhasil | GET, PATCH berhasil |
| 201 | Created - Data berhasil dibuat | POST berhasil |
| 204 | No Content - Berhasil (no body) | DELETE berhasil |
| 400 | Bad Request - Parameter salah | Missing required field |
| 401 | Unauthorized - API key salah | Wrong anon_key |
| 404 | Not Found - Resource tidak ada | ID tidak ditemukan |
| 409 | Conflict - Unique constraint | Duplicate entry |
| 500 | Server Error | Database error |

---

## Tips & Tricks

### 1. Save Requests sebagai Collection
- Klik **Save** setelah membuat request
- Beri nama dan pilih collection
- Bisa digunakan kembali nanti

### 2. Gunakan Tests untuk Validasi
Klik tab **Tests**, tambahkan:

```javascript
pm.test("Status is 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Response has id field", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('id');
});
```

### 3. Copy Response ke Variable
```javascript
var jsonData = pm.response.json();
pm.environment.set("order_id", jsonData[0].id);
```

Kemudian gunakan di request lain: `{{order_id}}`

### 4. Pre-request Script
Klik tab **Pre-request Script** untuk generate data:

```javascript
pm.environment.set("order_id", "order_" + Date.now());
```

---

## Troubleshooting

### Error: 401 Unauthorized
**Solusi:** Check anon_key di environment, pastikan Bearer token ada di header

### Error: 400 Bad Request
**Solusi:** Check JSON format di body, pastikan semua required fields ada

### Error: 409 Conflict
**Solusi:** ID sudah ada, gunakan ID yang berbeda

### No Response
**Solusi:** Check internet connection, pastikan Supabase project aktif

---

## Full Request Examples

### cURL Format

```bash
# GET Laundries
curl -X GET "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/laundries" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK" \
  -H "Content-Type: application/json"

# Create Order
curl -X POST "https://tkhvhlafdaccagodxqie.supabase.co/rest/v1/orders" \
  -H "Authorization: Bearer sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "order_123",
    "user_id": "5e407e09-ece4-4e08-a193-985f851bff18",
    "laundry_id": "laundry_1",
    "items": [{"service_id": "service_1", "quantity": 5}],
    "total_price": 25000,
    "status": "pending"
  }'
```

---

## Dokumentasi Lengkap

- [Postman Docs](https://learning.postman.com/)
- [Supabase REST API](https://supabase.com/docs/reference/rest/overview)
- [PostgREST API](https://postgrest.org/)

---

**Status:** ✅ Ready untuk Testing
**Last Updated:** January 20, 2026

import 'package:supabase_flutter/supabase_flutter.dart';

class SeedData {
  static final SupabaseClient _client = Supabase.instance.client;

  static Future<void> seedAllData() async {
    try {
      print('Starting to seed data...');

      // Check if data already exists
      try {
        final res = await _client.from('laundries').select('id').limit(1);
        if ((res as List).isNotEmpty) {
          print('Data already seeded. Skipping...');
          return;
        }
      } catch (e) {
        print('⚠️  Could not check existing data: $e');
        print('Attempting to seed data anyway...');
      }

      await seedLaundries();
      await seedOffers();
      print('Data seeding completed successfully!');
    } catch (e) {
      print('Error seeding data: $e');
      rethrow;
    }
  }

  static Future<void> seedLaundries() async {
    try {
      final laundries = [
      {
        'id': 'laundry_1',
        'name': 'Express Laundry',
        'address': 'Jl. Merdeka No. 123, Jakarta',
        'image':
            'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=500&h=500',
        'rating': 4.8,
        'reviewCount': 156,
        'distance': '2.5 km',
        'isOpen': true,
        'isActive': true,
        'openTime': '07:00',
        'closeTime': '21:00',
        'services': ['wash', 'dry_clean', 'iron', 'fold'],
        'description':
            'Layanan laundry terpercaya dengan pengalaman lebih dari 10 tahun. Kami menjamin kebersihan dan kecepatan layanan.',
        'latitude': -6.200000,
        'longitude': 106.816666,
        'phoneNumber': '021-1234567',
        'email': 'express@laundry.com',
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'laundry_2',
        'name': 'Premium Clean Service',
        'address': 'Jl. Sudirman No. 456, Jakarta',
        'image':
            'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=500&h=500',
        'rating': 4.6,
        'reviewCount': 132,
        'distance': '3.2 km',
        'isOpen': true,
        'isActive': true,
        'openTime': '08:00',
        'closeTime': '20:00',
        'services': ['wash', 'dry_clean', 'iron', 'fold', 'special_care'],
        'description':
            'Spesialis dalam perawatan pakaian premium dan bahan khusus. Tim profesional siap melayani Anda.',
        'latitude': -6.225448,
        'longitude': 106.799694,
        'phoneNumber': '021-2345678',
        'email': 'premium@laundry.com',
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'laundry_3',
        'name': 'Quick Wash Station',
        'address': 'Jl. Gatot Subroto No. 789, Jakarta',
        'image':
            'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=500&h=500',
        'rating': 4.5,
        'reviewCount': 98,
        'distance': '1.8 km',
        'isOpen': true,
        'isActive': true,
        'openTime': '06:00',
        'closeTime': '22:00',
        'services': ['wash', 'iron', 'fold'],
        'description':
            'Layanan cepat untuk kebutuhan laundry sehari-hari. Harga terjangkau dan hasil memuaskan.',
        'latitude': -6.220000,
        'longitude': 106.805000,
        'phoneNumber': '021-3456789',
        'email': 'quick@laundry.com',
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'laundry_4',
        'name': 'Eco Friendly Laundry',
        'address': 'Jl. Rasuna Said No. 321, Jakarta',
        'image':
            'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=500&h=500',
        'rating': 4.7,
        'reviewCount': 87,
        'distance': '4.1 km',
        'isOpen': true,
        'isActive': true,
        'openTime': '08:00',
        'closeTime': '20:00',
        'services': ['wash', 'dry_clean', 'fold'],
        'description':
            'Menggunakan bahan ramah lingkungan dan produk berkualitas tinggi. Peduli alam, peduli pakaian Anda.',
        'latitude': -6.215000,
        'longitude': 106.820000,
        'phoneNumber': '021-4567890',
        'email': 'eco@laundry.com',
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'laundry_5',
        'name': 'Royal Dry Cleaning',
        'address': 'Jl. Blok A No. 654, Jakarta',
        'image':
            'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=500&h=500',
        'rating': 4.9,
        'reviewCount': 203,
        'distance': '5.5 km',
        'isOpen': true,
        'isActive': true,
        'openTime': '07:00',
        'closeTime': '19:00',
        'services': ['wash', 'dry_clean', 'iron', 'fold', 'special_care'],
        'description':
            'Pusat dry cleaning premium untuk pakaian formal dan kasual. Hasil sempurna dijamin!',
        'latitude': -6.210000,
        'longitude': 106.825000,
        'phoneNumber': '021-5678901',
        'email': 'royal@laundry.com',
        'createdAt': DateTime.now().toIso8601String(),
      },
    ];

    // Add laundries
    for (var laundry in laundries) {
      final laundryId = laundry['id'] as String;

      final laundryData = Map<String, dynamic>.from(laundry);
      laundryData.remove('services');
      laundryData['created_at'] = DateTime.now().toIso8601String();

      await _client.from('laundries').insert(laundryData);

      // Add services for each laundry
      await _addServicesForLaundry(laundryId);
    }

    print('Laundries seeded successfully!');
    } catch (e) {
      print('Error seeding laundries: $e');
      rethrow;
    }
  }

  static Future<void> _addServicesForLaundry(String laundryId) async {
    final services = [
      {
        'id': 'service_wash',
        'name': 'Wash & Fold',
        'category': 'wash',
        'price': 15000.0,
        'unit': 'kg',
        'image':
            'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=300&h=300',
        'description': 'Pencucian regular dengan hasil rapi dan wangi segar.',
        'isActive': true,
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'service_dry_clean',
        'name': 'Dry Cleaning',
        'category': 'dry_clean',
        'price': 35000.0,
        'unit': 'piece',
        'image':
            'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=300&h=300',
        'description': 'Dry cleaning untuk pakaian formal dan bahan sensitif.',
        'isActive': true,
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'service_iron',
        'name': 'Iron & Press',
        'category': 'iron',
        'price': 8000.0,
        'unit': 'piece',
        'image':
            'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=300&h=300',
        'description': 'Setrika profesional dengan hasil halus dan rapi.',
        'isActive': true,
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'service_special',
        'name': 'Special Care',
        'category': 'special_care',
        'price': 50000.0,
        'unit': 'piece',
        'image':
            'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=300&h=300',
        'description': 'Perawatan khusus untuk pakaian premium dan bahan mahal.',
        'isActive': true,
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'service_express',
        'name': 'Express Service',
        'category': 'wash',
        'price': 20000.0,
        'unit': 'kg',
        'image':
            'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=300&h=300',
        'description': 'Layanan kilat, siap dalam 6 jam.',
        'isActive': true,
        'createdAt': DateTime.now().toIso8601String(),
      },
    ];

    for (var service in services) {
      final serviceId = service['id'] as String;
      final serviceData = Map<String, dynamic>.from(service);
      serviceData['laundry_id'] = laundryId;
      serviceData['created_at'] = DateTime.now().toIso8601String();
      await _client.from('services').insert(serviceData);
    }
  }

  static Future<void> seedOffers() async {
    final offers = [
      {
        'id': 'offer_1',
        'title': 'Diskon 20% untuk Member Baru',
        'description': 'Dapatkan potongan 20% untuk pemesanan pertama Anda!',
        'discountPercentage': 20,
        'minOrderAmount': 50000.0,
        'expiryDate': DateTime.now().add(Duration(days: 30)).toIso8601String(),
        'code': 'NEWMEMBER20',
        'isActive': true,
        'image':
            'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=500&h=500',
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'offer_2',
        'title': 'Gratis Ongkir untuk Pesanan Minimal',
        'description': 'Gratis ongkos kirim untuk pemesanan di atas Rp 150.000',
        'discountPercentage': 0,
        'minOrderAmount': 150000.0,
        'expiryDate': DateTime.now().add(Duration(days: 15)).toIso8601String(),
        'code': 'FREEONGKIR',
        'isActive': true,
        'image':
            'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=500&h=500',
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'offer_3',
        'title': 'Beli 2 Gratis 1 untuk Dry Cleaning',
        'description': 'Penawaran spesial untuk layanan dry cleaning premium',
        'discountPercentage': 33,
        'minOrderAmount': 100000.0,
        'expiryDate': DateTime.now().add(Duration(days: 20)).toIso8601String(),
        'code': 'BUY2GET1',
        'isActive': true,
        'image':
            'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=500&h=500',
        'createdAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'offer_4',
        'title': 'Cashback 15% untuk Pembayaran E-Wallet',
        'description': 'Dapatkan cashback langsung untuk setiap transaksi pakai e-wallet',
        'discountPercentage': 15,
        'minOrderAmount': 75000.0,
        'expiryDate': DateTime.now().add(Duration(days: 25)).toIso8601String(),
        'code': 'EWALLET15',
        'isActive': true,
        'image':
            'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=500&h=500',
        'createdAt': DateTime.now().toIso8601String(),
      },
    ];

    for (var offer in offers) {
      final offerData = Map<String, dynamic>.from(offer);
      offerData['created_at'] = DateTime.now().toIso8601String();
      await _client.from('offers').insert(offerData);
    }

    print('Offers seeded successfully!');
  }
}

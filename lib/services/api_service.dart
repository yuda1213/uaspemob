 import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/laundry_model.dart';
import '../models/service_model.dart';
import '../models/offer_model.dart';

class ApiService {
  // Mock data for laundries
  static List<Laundry> getMockLaundries() {
    return [
      Laundry(
        id: '1',
        name: 'Xpress Laundry Services',
        address: '145 Valencia St, San Francisco, CA 94103',
        image: 'https://images.unsplash.com/photo-1545173168-9f1947eebb7f?w=400',
        rating: 4.3,
        reviewCount: 90,
        distance: '0.2 km away',
        isOpen: true,
        openTime: '08:00 AM',
        closeTime: '10:00 PM',
        services: ['Wash & Fold', 'Wash & Iron', 'Dry Clean'],
        description: 'Xpress Laundry Services provides high-quality laundry and dry cleaning services. We use eco-friendly detergents and state-of-the-art equipment.',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      Laundry(
        id: '2',
        name: 'Sparkle Dry Cleaners',
        address: '890 Broadway, San Francisco, CA 94133',
        image: 'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=400',
        rating: 4.5,
        reviewCount: 120,
        distance: '0.4 km away',
        isOpen: true,
        openTime: '07:00 AM',
        closeTime: '09:00 PM',
        services: ['Dry Clean', 'Premium Wash', 'Leather Care'],
        description: 'Premium dry cleaning services with attention to detail. Specialized in delicate fabrics and formal wear.',
        latitude: 37.7849,
        longitude: -122.4094,
      ),
      Laundry(
        id: '3',
        name: 'Robin Wash & Fold',
        address: '567 Market St, San Francisco, CA 94105',
        image: 'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=400',
        rating: 4.2,
        reviewCount: 75,
        distance: '1.2 km away',
        isOpen: true,
        openTime: '06:00 AM',
        closeTime: '11:00 PM',
        services: ['Wash & Fold', 'Self Service', 'Express'],
        description: 'Affordable and reliable wash & fold services. Same-day service available.',
        latitude: 37.7649,
        longitude: -122.4294,
      ),
      Laundry(
        id: '4',
        name: 'Wash & Dry Laundry',
        address: '1051 3rd St, San Francisco, CA 94107',
        image: 'https://images.unsplash.com/photo-1521656693700-71d1f9f89e0e?w=400',
        rating: 4.4,
        reviewCount: 95,
        distance: '1.5 km away',
        isOpen: false,
        openTime: '08:00 AM',
        closeTime: '08:00 PM',
        services: ['Wash & Fold', 'Wash & Iron', 'Pickup & Delivery'],
        description: 'Full-service laundry with free pickup and delivery. Quality guaranteed.',
        latitude: 37.7549,
        longitude: -122.3994,
      ),
      Laundry(
        id: '5',
        name: 'Fiesta Laundromat',
        address: '2345 Mission St, San Francisco, CA 94110',
        image: 'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=400',
        rating: 4.0,
        reviewCount: 60,
        distance: '2.0 km away',
        isOpen: true,
        openTime: '07:00 AM',
        closeTime: '10:00 PM',
        services: ['Wash & Iron', 'Wash & Fold', 'Commercial'],
        description: 'Large capacity machines for all your laundry needs. Commercial services available.',
        latitude: 37.7449,
        longitude: -122.4394,
      ),
      Laundry(
        id: '6',
        name: 'My Laundry Hub',
        address: '77 Models Lane, San Francisco, CA 94102',
        image: 'https://images.unsplash.com/photo-1567113463300-102a7eb3cb26?w=400',
        rating: 4.3,
        reviewCount: 85,
        distance: '0.8 km away',
        isOpen: true,
        openTime: '09:00 AM',
        closeTime: '09:00 PM',
        services: ['Wash & Fold', 'Iron', 'Premium Wash'],
        description: 'Your neighborhood laundry hub with premium services and competitive prices.',
        latitude: 37.7799,
        longitude: -122.4144,
      ),
    ];
  }

  // Mock data for services
  static List<ServiceCategory> getMockServiceCategories() {
    return [
      ServiceCategory(
        id: '1',
        name: "Men's",
        icon: '👔',
        items: [
          ServiceItem(id: 'm1', name: 'T-Shirt', category: "Men's", price: 3.00, unit: 'piece', image: '', description: 'Regular t-shirt wash and fold'),
          ServiceItem(id: 'm2', name: 'Shirt', category: "Men's", price: 4.50, unit: 'piece', image: '', description: 'Dress shirt with ironing'),
          ServiceItem(id: 'm3', name: 'Trouser', category: "Men's", price: 5.00, unit: 'piece', image: '', description: 'Formal or casual trousers'),
          ServiceItem(id: 'm4', name: 'Jeans', category: "Men's", price: 5.50, unit: 'piece', image: '', description: 'Denim jeans wash'),
          ServiceItem(id: 'm5', name: 'Suit', category: "Men's", price: 15.00, unit: 'piece', image: '', description: 'Full suit dry cleaning'),
          ServiceItem(id: 'm6', name: 'Jacket', category: "Men's", price: 12.00, unit: 'piece', image: '', description: 'Jacket cleaning'),
        ],
      ),
      ServiceCategory(
        id: '2',
        name: "Women's",
        icon: '👗',
        items: [
          ServiceItem(id: 'w1', name: 'Blouse', category: "Women's", price: 4.00, unit: 'piece', image: '', description: 'Delicate blouse cleaning'),
          ServiceItem(id: 'w2', name: 'Dress', category: "Women's", price: 8.00, unit: 'piece', image: '', description: 'Dress cleaning and pressing'),
          ServiceItem(id: 'w3', name: 'Skirt', category: "Women's", price: 5.00, unit: 'piece', image: '', description: 'Skirt wash and iron'),
          ServiceItem(id: 'w4', name: 'Saree', category: "Women's", price: 10.00, unit: 'piece', image: '', description: 'Traditional saree cleaning'),
          ServiceItem(id: 'w5', name: 'Coat', category: "Women's", price: 14.00, unit: 'piece', image: '', description: 'Winter coat cleaning'),
        ],
      ),
      ServiceCategory(
        id: '3',
        name: 'Household',
        icon: '🏠',
        items: [
          ServiceItem(id: 'h1', name: 'Bedsheet (Single)', category: 'Household', price: 6.00, unit: 'piece', image: '', description: 'Single bedsheet wash'),
          ServiceItem(id: 'h2', name: 'Bedsheet (Double)', category: 'Household', price: 8.00, unit: 'piece', image: '', description: 'Double bedsheet wash'),
          ServiceItem(id: 'h3', name: 'Blanket', category: 'Household', price: 12.00, unit: 'piece', image: '', description: 'Blanket deep cleaning'),
          ServiceItem(id: 'h4', name: 'Curtain', category: 'Household', price: 15.00, unit: 'piece', image: '', description: 'Curtain cleaning'),
          ServiceItem(id: 'h5', name: 'Pillow Cover', category: 'Household', price: 3.00, unit: 'piece', image: '', description: 'Pillow cover wash'),
          ServiceItem(id: 'h6', name: 'Towel', category: 'Household', price: 3.00, unit: 'piece', image: '', description: 'Towel wash and sanitize'),
        ],
      ),
      ServiceCategory(
        id: '4',
        name: 'Bedding',
        icon: '🛏️',
        items: [
          ServiceItem(id: 'b1', name: 'Comforter', category: 'Bedding', price: 20.00, unit: 'piece', image: '', description: 'Comforter deep cleaning'),
          ServiceItem(id: 'b2', name: 'Duvet', category: 'Bedding', price: 18.00, unit: 'piece', image: '', description: 'Duvet cleaning'),
          ServiceItem(id: 'b3', name: 'Mattress Cover', category: 'Bedding', price: 10.00, unit: 'piece', image: '', description: 'Mattress cover wash'),
          ServiceItem(id: 'b4', name: 'Quilt', category: 'Bedding', price: 15.00, unit: 'piece', image: '', description: 'Quilt cleaning'),
        ],
      ),
    ];
  }

  // Mock data for offers
  static List<Offer> getMockOffers() {
    return [
      Offer(
        id: '1',
        title: 'Get 25% off',
        description: 'For a limited time only! Get 25% off on all dry clean services.',
        code: 'DRYCLEAN25',
        discountPercent: 25,
        maxDiscount: 50,
        minOrder: 100,
        validFrom: DateTime.now().subtract(const Duration(days: 7)),
        validUntil: DateTime.now().add(const Duration(days: 30)),
        image: 'https://images.unsplash.com/photo-1489274495757-95c7c837b101?w=400',
        isActive: true,
      ),
      Offer(
        id: '2',
        title: 'Flat 30% off on dry clean',
        description: 'Premium dry cleaning services at discounted rates.',
        code: 'LAUNDRY30OFF',
        discountPercent: 30,
        maxDiscount: 75,
        minOrder: 150,
        validFrom: DateTime.now().subtract(const Duration(days: 3)),
        validUntil: DateTime.now().add(const Duration(days: 45)),
        image: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
        isActive: true,
      ),
      Offer(
        id: '3',
        title: 'Flat 10% off on wash & fold',
        description: 'Save on your regular laundry with our wash & fold discount.',
        code: 'LAUNDRY10NOW',
        discountPercent: 10,
        maxDiscount: 30,
        minOrder: 50,
        validFrom: DateTime.now().subtract(const Duration(days: 1)),
        validUntil: DateTime.now().add(const Duration(days: 60)),
        image: 'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=400',
        isActive: true,
      ),
    ];
  }

  // Simulated API call to fetch laundries
  static Future<List<Laundry>> fetchLaundries() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return getMockLaundries();
  }

  // Simulated API call to fetch a single laundry by ID
  static Future<Laundry?> fetchLaundryById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final laundries = getMockLaundries();
    try {
      return laundries.firstWhere((l) => l.id == id);
    } catch (e) {
      return null;
    }
  }

  // Simulated API call to fetch services
  static Future<List<ServiceCategory>> fetchServices() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return getMockServiceCategories();
  }

  // Simulated API call to fetch offers
  static Future<List<Offer>> fetchOffers() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return getMockOffers();
  }

  // Simulated API call to search laundries
  static Future<List<Laundry>> searchLaundries(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final laundries = getMockLaundries();
    if (query.isEmpty) return laundries;
    return laundries.where((l) => 
      l.name.toLowerCase().contains(query.toLowerCase()) ||
      l.address.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Fetch data from real API (example with JSONPlaceholder)
  static Future<List<dynamic>> fetchFromApi(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/$endpoint'),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load data');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

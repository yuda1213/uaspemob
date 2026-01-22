import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import 'supabase_rest_api.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  static final SupabaseRestApi _restApi = SupabaseRestApi();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  // Lazy getter for SupabaseClient to ensure it's initialized
  SupabaseClient get _client {
    try {
      return Supabase.instance.client;
    } catch (e) {
      throw Exception('Supabase not initialized: $e');
    }
  }

  // Get REST API instance for direct access to endpoints
  SupabaseRestApi get restApi => _restApi;

  // Initialize (kept for compatibility)
  Future<void> initializeSupabase() async {
    // Supabase initialization is handled elsewhere (Supabase.initialize)
    return;
  }

  // Auth Methods
  Future<Map<String, dynamic>?> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final res = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'phone': phone,
        },
      );

      if (res.user != null) {
        // Try to insert user data to users table
        try {
          await _client.from('users').insert({
            'id': res.user!.id,
            'email': email,
            'name': name,
            'phone': phone,
            'created_at': DateTime.now().toIso8601String(),
          });
        } catch (e) {
          print('ℹ️  Could not insert to users table: $e');
          print('   (This is OK if table will be created later)');
        }

        return {
          'id': res.user!.id,
          'email': email,
          'name': name,
          'phone': phone,
        };
      }
      return null;
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }

  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user != null) {
        // Try to get user data from database
        try {
          final userData = await _client.from('users').select().eq('id', res.user!.id).single();
          return userData as Map<String, dynamic>;
        } catch (e) {
          print('ℹ️  Could not fetch from users table: $e');
          print('   (This is OK if table will be created later)');
        }

        // Return minimal user data from auth
        return {
          'id': res.user!.id,
          'email': res.user!.email,
        };
      }
      return null;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logoutUser() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final user = _client.auth.currentUser;
      if (user != null) {
        // Try to get user data from users table
        try {
          final userData = await _client.from('users').select().eq('id', user.id).single();
          return userData as Map<String, dynamic>;
        } catch (e) {
          print('ℹ️  Could not fetch from users table: $e');
        }

        // Return minimal user data from auth
        return {
          'id': user.id,
          'email': user.email,
        };
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final res = await _client.from('users').select().eq('id', userId).single();
      
      if (res.error == null && res.data != null) {
        return res.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Reset password failed: $e');
    }
  }

  // Laundry Methods - Using REST API
  Future<List<Map<String, dynamic>>> getLaundries() async {
    try {
      return await _restApi.getAllLaundries();
    } catch (e) {
      print('Error fetching laundries: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> searchLaundries(String query) async {
    try {
      return await _restApi.searchLaundries(query);
    } catch (e) {
      print('Error searching laundries: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getLaundryDetail(String laundryId) async {
    try {
      return await _restApi.getLaundryById(laundryId);
    } catch (e) {
      print('Error fetching laundry detail: $e');
      return null;
    }
  }

  // Service Methods - Using REST API
  Future<List<Map<String, dynamic>>> getServices(String laundryId) async {
    try {
      return await _restApi.getServicesByLaundry(laundryId);
    } catch (e) {
      print('Error fetching services: $e');
      return [];
    }
  }

  // Offer Methods - Using REST API
  Future<List<Map<String, dynamic>>> getActiveOffers() async {
    try {
      // Get all laundries first, then their offers
      final laundries = await _restApi.getAllLaundries();
      final allOffers = <Map<String, dynamic>>[];
      
      for (final laundry in laundries) {
        final offers = await _restApi.getOffersByLaundry(laundry['id']);
        allOffers.addAll(offers);
      }
      
      return allOffers;
    } catch (e) {
      print('Error fetching offers: $e');
      return [];
    }
  }

  // Order Methods - Using REST API
  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    try {
      return await _restApi.getUserOrders(userId);
    } catch (e) {
      print('Error fetching user orders: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getOrderDetail(String orderId) async {
    try {
      return await _restApi.getOrderById(orderId);
    } catch (e) {
      print('Error fetching order detail: $e');
      return null;
    }
  }

  // Create order
  Future<String> createOrder({
    required String laundryId,
    required String laundryName,
    required String userId,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
    required DateTime pickupDate,
    required String pickupTime,
    required String pickupAddress,
    required String paymentMethod,
  }) async {
    try {
      final orderId = DateTime.now().millisecondsSinceEpoch.toString();
      
      final orderData = {
        'id': orderId,
        'user_id': userId,
        'laundry_id': laundryId,
        'items': items,
        'total_price': totalAmount,
        'status': 'pending',
        'delivery_address': pickupAddress,
      };

      await _restApi.createOrder(
        id: orderId,
        userId: userId,
        laundryId: laundryId,
        items: items,
        totalPrice: totalAmount,
        deliveryAddress: pickupAddress,
      );

      return orderId;
    } catch (e) {
      throw Exception('Create order failed: $e');
    }
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      await _restApi.updateOrderStatus(orderId, status);
    } catch (e) {
      throw Exception('Update order status failed: $e');
    }
  }

  // Review Methods - Using REST API
  Future<void> addReview({
    required String laundryId,
    required String userId,
    required String userName,
    required int rating,
    required String review,
  }) async {
    try {
      final reviewId = DateTime.now().millisecondsSinceEpoch.toString();
      await _restApi.createReview(
        id: reviewId,
        userId: userId,
        laundryId: laundryId,
        rating: rating,
        comment: review,
      );
    } catch (e) {
      throw Exception('Add review failed: $e');
    }
  }

  // Favorite Methods - Using REST API
  Future<void> addFavorite({
    required String userId,
    required String laundryId,
  }) async {
    try {
      final favId = DateTime.now().millisecondsSinceEpoch.toString();
      await _restApi.addToFavorites(
        id: favId,
        userId: userId,
        laundryId: laundryId,
      );
    } catch (e) {
      throw Exception('Add favorite failed: $e');
    }
  }

  Future<void> removeFavorite({
    required String userId,
    required String laundryId,
  }) async {
    try {
      await _restApi.removeFromFavorites(
        userId: userId,
        laundryId: laundryId,
      );
    } catch (e) {
      throw Exception('Remove favorite failed: $e');
    }
  }

  Future<List<String>> getUserFavorites(String userId) async {
    try {
      final res = await _client
          .from('favorites')
          .select('laundry_id')
          .eq('user_id', userId)
          ;
      
      if (res.error == null && res.data != null) {
        return List<String>.from(
          (res.data as List).map((item) => item['laundry_id'] as String),
        );
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

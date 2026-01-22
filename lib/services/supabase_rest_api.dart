/// REST API Client untuk Supabase Database
/// 
/// Mengintegrasikan semua operasi CRUD dengan Supabase PostgREST API
/// Dokumentasi: https://supabase.com/docs/reference/dart/introduction

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRestApi {
  static final SupabaseRestApi _instance = SupabaseRestApi._internal();

  factory SupabaseRestApi() {
    return _instance;
  }

  SupabaseRestApi._internal();

  SupabaseClient get _client {
    try {
      return Supabase.instance.client;
    } catch (e) {
      throw Exception('Supabase not initialized: $e');
    }
  }

  // ============================================================================
  // LAUNDRIES ENDPOINTS
  // ============================================================================

  /// Get all laundries
  /// GET /rest/v1/laundries
  Future<List<Map<String, dynamic>>> getAllLaundries() async {
    try {
      final response = await _client
          .from('laundries')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to get laundries: $e');
    }
  }

  /// Get single laundry by ID
  /// GET /rest/v1/laundries?id=eq.{id}
  Future<Map<String, dynamic>?> getLaundryById(String id) async {
    try {
      final response = await _client
          .from('laundries')
          .select()
          .eq('id', id)
          .single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get laundry: $e');
    }
  }

  /// Search laundries by name
  /// GET /rest/v1/laundries?name=ilike.%{query}%
  Future<List<Map<String, dynamic>>> searchLaundries(String query) async {
    try {
      final response = await _client
          .from('laundries')
          .select()
          .ilike('name', '%$query%')
          .order('rating', ascending: false);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to search laundries: $e');
    }
  }

  /// Create new laundry (admin only)
  /// POST /rest/v1/laundries
  Future<Map<String, dynamic>> createLaundry({
    required String id,
    required String name,
    required String address,
    required String image,
    required double rating,
    required int reviewCount,
    String? distance,
    bool isOpen = true,
    bool isActive = true,
    String? openTime,
    String? closeTime,
    List<String>? services,
    String? description,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? email,
  }) async {
    try {
      final response = await _client.from('laundries').insert({
        'id': id,
        'name': name,
        'address': address,
        'image': image,
        'rating': rating,
        'review_count': reviewCount,
        'distance': distance,
        'is_open': isOpen,
        'is_active': isActive,
        'open_time': openTime,
        'close_time': closeTime,
        'services': services ?? [],
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'phone_number': phoneNumber,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
      }).select().single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create laundry: $e');
    }
  }

  /// Update laundry (admin only)
  /// PATCH /rest/v1/laundries?id=eq.{id}
  Future<Map<String, dynamic>> updateLaundry({
    required String id,
    Map<String, dynamic>? updates,
  }) async {
    try {
      final updateData = {...?(updates ?? {}), 'updated_at': DateTime.now().toIso8601String()};
      final response = await _client
          .from('laundries')
          .update(updateData)
          .eq('id', id)
          .select()
          .single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to update laundry: $e');
    }
  }

  /// Delete laundry (admin only)
  /// DELETE /rest/v1/laundries?id=eq.{id}
  Future<void> deleteLaundry(String id) async {
    try {
      await _client.from('laundries').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete laundry: $e');
    }
  }

  // ============================================================================
  // SERVICES ENDPOINTS
  // ============================================================================

  /// Get services by laundry
  /// GET /rest/v1/services?laundry_id=eq.{laundry_id}
  Future<List<Map<String, dynamic>>> getServicesByLaundry(String laundryId) async {
    try {
      final response = await _client
          .from('services')
          .select()
          .eq('laundry_id', laundryId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to get services: $e');
    }
  }

  /// Create service
  /// POST /rest/v1/services
  Future<Map<String, dynamic>> createService({
    required String id,
    required String laundryId,
    required String name,
    required double price,
    String? description,
    String? category,
    int? durationHours,
    bool isAvailable = true,
  }) async {
    try {
      final response = await _client.from('services').insert({
        'id': id,
        'laundry_id': laundryId,
        'name': name,
        'price': price,
        'description': description,
        'category': category,
        'duration_hours': durationHours,
        'is_available': isAvailable,
        'created_at': DateTime.now().toIso8601String(),
      }).select().single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create service: $e');
    }
  }

  /// Delete service
  /// DELETE /rest/v1/services?id=eq.{id}
  Future<void> deleteService(String id) async {
    try {
      await _client.from('services').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete service: $e');
    }
  }

  // ============================================================================
  // OFFERS ENDPOINTS
  // ============================================================================

  /// Get offers by laundry
  /// GET /rest/v1/offers?laundry_id=eq.{laundry_id}&is_active=eq.true
  Future<List<Map<String, dynamic>>> getOffersByLaundry(String laundryId) async {
    try {
      final response = await _client
          .from('offers')
          .select()
          .eq('laundry_id', laundryId)
          .eq('is_active', true)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to get offers: $e');
    }
  }

  /// Create offer
  /// POST /rest/v1/offers
  Future<Map<String, dynamic>> createOffer({
    required String id,
    required String laundryId,
    required String title,
    String? description,
    double? discountPercentage,
    double? discountAmount,
    double? minOrder,
    DateTime? startDate,
    DateTime? endDate,
    bool isActive = true,
  }) async {
    try {
      final response = await _client.from('offers').insert({
        'id': id,
        'laundry_id': laundryId,
        'title': title,
        'description': description,
        'discount_percentage': discountPercentage,
        'discount_amount': discountAmount,
        'min_order': minOrder,
        'start_date': startDate?.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'is_active': isActive,
        'created_at': DateTime.now().toIso8601String(),
      }).select().single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create offer: $e');
    }
  }

  // ============================================================================
  // ORDERS ENDPOINTS
  // ============================================================================

  /// Get user orders
  /// GET /rest/v1/orders?user_id=eq.{user_id}
  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    try {
      final response = await _client
          .from('orders')
          .select('*, laundries(name, address)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  /// Get order by ID
  /// GET /rest/v1/orders?id=eq.{id}
  Future<Map<String, dynamic>?> getOrderById(String orderId) async {
    try {
      final response = await _client
          .from('orders')
          .select('*, laundries(name, address, phone_number)')
          .eq('id', orderId)
          .single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  /// Create order
  /// POST /rest/v1/orders
  Future<Map<String, dynamic>> createOrder({
    required String id,
    required String userId,
    required String laundryId,
    required List<Map<String, dynamic>> items,
    required double totalPrice,
    String status = 'pending',
    String? deliveryAddress,
  }) async {
    try {
      final response = await _client.from('orders').insert({
        'id': id,
        'user_id': userId,
        'laundry_id': laundryId,
        'items': items,
        'total_price': totalPrice,
        'status': status,
        'delivery_address': deliveryAddress,
        'created_at': DateTime.now().toIso8601String(),
      }).select().single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  /// Update order status
  /// PATCH /rest/v1/orders?id=eq.{id}
  Future<Map<String, dynamic>> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await _client
          .from('orders')
          .update({
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId)
          .select()
          .single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to update order: $e');
    }
  }

  // ============================================================================
  // REVIEWS ENDPOINTS
  // ============================================================================

  /// Get reviews for laundry
  /// GET /rest/v1/reviews?laundry_id=eq.{laundry_id}
  Future<List<Map<String, dynamic>>> getReviewsByLaundry(String laundryId) async {
    try {
      final response = await _client
          .from('reviews')
          .select()
          .eq('laundry_id', laundryId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to get reviews: $e');
    }
  }

  /// Create review
  /// POST /rest/v1/reviews
  Future<Map<String, dynamic>> createReview({
    required String id,
    required String userId,
    required String laundryId,
    required int rating,
    String? comment,
  }) async {
    try {
      final response = await _client.from('reviews').insert({
        'id': id,
        'user_id': userId,
        'laundry_id': laundryId,
        'rating': rating,
        'comment': comment,
        'created_at': DateTime.now().toIso8601String(),
      }).select().single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create review: $e');
    }
  }

  // ============================================================================
  // FAVORITES ENDPOINTS
  // ============================================================================

  /// Get user favorites
  /// GET /rest/v1/favorites?user_id=eq.{user_id}
  Future<List<Map<String, dynamic>>> getUserFavorites(String userId) async {
    try {
      final response = await _client
          .from('favorites')
          .select('*, laundries(*)')
          .eq('user_id', userId);
      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }

  /// Add to favorites
  /// POST /rest/v1/favorites
  Future<Map<String, dynamic>> addToFavorites({
    required String id,
    required String userId,
    required String laundryId,
  }) async {
    try {
      final response = await _client.from('favorites').insert({
        'id': id,
        'user_id': userId,
        'laundry_id': laundryId,
        'created_at': DateTime.now().toIso8601String(),
      }).select().single();
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  /// Remove from favorites
  /// DELETE /rest/v1/favorites?user_id=eq.{user_id}&laundry_id=eq.{laundry_id}
  Future<void> removeFromFavorites({
    required String userId,
    required String laundryId,
  }) async {
    try {
      await _client
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('laundry_id', laundryId);
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  /// Check if laundry is favorite
  /// GET /rest/v1/favorites?user_id=eq.{user_id}&laundry_id=eq.{laundry_id}
  Future<bool> isFavorite({
    required String userId,
    required String laundryId,
  }) async {
    try {
      final response = await _client
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .eq('laundry_id', laundryId);
      return (response as List).isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check favorite: $e');
    }
  }

  // ============================================================================
  // REAL-TIME SUBSCRIPTIONS (Optional - Requires upgrade to Supabase v2)
  // ============================================================================

  /// Subscribe to laundries changes
  /// Note: This requires Supabase realtime subscriptions to be enabled
  /// Currently commented out for v1.x compatibility
  // Future<void> subscribeToLaundries(Function(dynamic) onData) async {
  //   try {
  //     _client
  //         .from('laundries')
  //         .on(RealtimeListenTypes.allEvents, (payload) {
  //       onData(payload);
  //     })
  //         .subscribe();
  //   } catch (e) {
  //     throw Exception('Failed to subscribe: $e');
  //   }
  // }

  /// Subscribe to order changes for user
  /// Note: This requires Supabase realtime subscriptions to be enabled
  /// Currently commented out for v1.x compatibility
  // Future<void> subscribeToUserOrders(String userId, Function(dynamic) onData) async {
  //   try {
  //     _client
  //         .from('orders')
  //         .on(RealtimeListenTypes.allEvents, (payload) {
  //       if (payload.newRecord['user_id'] == userId ||
  //           payload.oldRecord?['user_id'] == userId) {
  //         onData(payload);
  //       }
  //     })
  //         .eq('user_id', userId)
  //         .subscribe();
  //   } catch (e) {
  //     throw Exception('Failed to subscribe: $e');
  //   }
  // }
}

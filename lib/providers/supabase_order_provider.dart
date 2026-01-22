import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/service_model.dart';
import '../services/supabase_service.dart';

class SupabaseOrderProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  List<Order> _userOrders = [];
  List<ServiceItem> _cartItems = [];
  double _totalAmount = 0.0;

  bool _isLoading = false;
  String? _error;

  List<Order> get userOrders => _userOrders;
  List<ServiceItem> get cartItems => _cartItems;
  double get totalAmount => _totalAmount;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserOrders(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final ordersData = await _supabaseService.getUserOrders(userId);
      _userOrders = ordersData
          .map((data) {
            return Order.fromJson(data);
          })
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> createOrder({
    required String laundryId,
    required String laundryName,
    required String userId,
    required DateTime pickupDate,
    required String pickupTime,
    required String pickupAddress,
    required String paymentMethod,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      List<Map<String, dynamic>> itemsData =
          _cartItems.map((item) => item.toJson()).toList();

      String orderId = await _supabaseService.createOrder(
        laundryId: laundryId,
        laundryName: laundryName,
        userId: userId,
        items: itemsData,
        totalAmount: _totalAmount,
        pickupDate: pickupDate,
        pickupTime: pickupTime,
        pickupAddress: pickupAddress,
        paymentMethod: paymentMethod,
      );

      _isLoading = false;
      notifyListeners();
      return orderId;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      await _supabaseService.updateOrderStatus(
        orderId: orderId,
        status: status,
      );

      // Update local orders
      final orderIndex =
          _userOrders.indexWhere((order) => order.id == orderId);
      if (orderIndex != -1) {
        final updatedOrder = _userOrders[orderIndex];
        _userOrders[orderIndex] = Order(
          id: updatedOrder.id,
          laundryId: updatedOrder.laundryId,
          laundryName: updatedOrder.laundryName,
          userId: updatedOrder.userId,
          items: updatedOrder.items,
          totalAmount: updatedOrder.totalAmount,
          status: status,
          pickupDate: updatedOrder.pickupDate,
          pickupTime: updatedOrder.pickupTime,
          pickupAddress: updatedOrder.pickupAddress,
          deliveryDate: updatedOrder.deliveryDate,
          deliveryTime: updatedOrder.deliveryTime,
          createdAt: updatedOrder.createdAt,
          paymentMethod: updatedOrder.paymentMethod,
          paymentStatus: updatedOrder.paymentStatus,
        );
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void addToCart(ServiceItem item) {
    final existingIndex = _cartItems.indexWhere((i) => i.id == item.id);
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }
    _calculateTotal();
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    _calculateTotal();
    notifyListeners();
  }

  void updateCartItemQuantity(String itemId, int quantity) {
    final item = _cartItems.firstWhere((i) => i.id == itemId);
    item.quantity = quantity;
    if (item.quantity <= 0) {
      removeFromCart(itemId);
    } else {
      _calculateTotal();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _totalAmount = 0.0;
    notifyListeners();
  }

  void _calculateTotal() {
    _totalAmount = 0.0;
    for (var item in _cartItems) {
      _totalAmount += item.price * item.quantity;
    }
  }

  int get cartItemCount => _cartItems.length;
}

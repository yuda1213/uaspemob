import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../models/laundry_model.dart';

enum DeliveryMode { delivery, pickup }

class CartItem {
  final ServiceItem serviceItem;
  final String serviceType; // 'Wash & Fold', 'Wash & Iron', 'Dry Clean'
  final double adjustedPrice;
  int quantity;

  CartItem({
    required this.serviceItem,
    required this.serviceType,
    required this.adjustedPrice,
    this.quantity = 1,
  });

  // Unique key combining item id and service type
  String get uniqueKey => '${serviceItem.id}_$serviceType';

  CartItem copyWith({
    ServiceItem? serviceItem,
    String? serviceType,
    double? adjustedPrice,
    int? quantity,
  }) {
    return CartItem(
      serviceItem: serviceItem ?? this.serviceItem,
      serviceType: serviceType ?? this.serviceType,
      adjustedPrice: adjustedPrice ?? this.adjustedPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  Laundry? _selectedLaundry;
  String _pickupAddress = '';
  DateTime? _pickupDate;
  String _pickupTime = '';
  String _paymentMethod = 'Cash on Delivery';
  DeliveryMode _deliveryMode = DeliveryMode.delivery;

  List<CartItem> get items => _items;
  Laundry? get selectedLaundry => _selectedLaundry;
  String get pickupAddress => _pickupAddress;
  DateTime? get pickupDate => _pickupDate;
  String get pickupTime => _pickupTime;
  String get paymentMethod => _paymentMethod;
  DeliveryMode get deliveryMode => _deliveryMode;

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _items.fold(0, (sum, item) => sum + (item.adjustedPrice * item.quantity));
  
  // 10% discount for self pickup
  double get pickupDiscount => _deliveryMode == DeliveryMode.pickup ? subtotal * 0.10 : 0;
  
  // Free delivery for orders above $50, otherwise $5
  double get deliveryFee {
    if (_deliveryMode == DeliveryMode.pickup) return 0;
    return subtotal > 50 ? 0 : 5.00;
  }
  
  double get total => subtotal - pickupDiscount + deliveryFee;

  String get deliveryModeText => _deliveryMode == DeliveryMode.delivery ? 'Delivery' : 'Self Pickup';

  void setDeliveryMode(DeliveryMode mode) {
    _deliveryMode = mode;
    notifyListeners();
  }

  void setLaundry(Laundry laundry) {
    _selectedLaundry = laundry;
    notifyListeners();
  }

  void addItemWithServiceType(ServiceItem item, String serviceType, double adjustedPrice) {
    final uniqueKey = '${item.id}_$serviceType';
    final existingIndex = _items.indexWhere((i) => i.uniqueKey == uniqueKey);
    if (existingIndex >= 0) {
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      _items.add(CartItem(
        serviceItem: item,
        serviceType: serviceType,
        adjustedPrice: adjustedPrice,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  // Legacy method for backward compatibility
  void addItem(ServiceItem item) {
    addItemWithServiceType(item, 'Wash & Fold', item.price);
  }

  void removeItemWithServiceType(ServiceItem item, String serviceType) {
    final uniqueKey = '${item.id}_$serviceType';
    final existingIndex = _items.indexWhere((i) => i.uniqueKey == uniqueKey);
    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex] = _items[existingIndex].copyWith(
          quantity: _items[existingIndex].quantity - 1,
        );
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  // Legacy method for backward compatibility
  void removeItem(ServiceItem item) {
    removeItemWithServiceType(item, 'Wash & Fold');
  }

  void updateItemQuantity(ServiceItem item, int quantity, {String serviceType = 'Wash & Fold'}) {
    final uniqueKey = '${item.id}_$serviceType';
    final existingIndex = _items.indexWhere((i) => i.uniqueKey == uniqueKey);
    if (existingIndex >= 0) {
      if (quantity <= 0) {
        _items.removeAt(existingIndex);
      } else {
        _items[existingIndex] = _items[existingIndex].copyWith(quantity: quantity);
      }
      notifyListeners();
    }
  }

  void removeItemCompletely(CartItem item) {
    _items.removeWhere((i) => i.uniqueKey == item.uniqueKey);
    notifyListeners();
  }

  int getItemQuantity(String itemId, {String? serviceType}) {
    if (serviceType != null) {
      final uniqueKey = '${itemId}_$serviceType';
      final item = _items.where((i) => i.uniqueKey == uniqueKey).firstOrNull;
      return item?.quantity ?? 0;
    }
    // Return total quantity for this item across all service types
    return _items
        .where((i) => i.serviceItem.id == itemId)
        .fold(0, (sum, item) => sum + item.quantity);
  }

  int getItemQuantityByServiceType(String itemId, String serviceType) {
    final uniqueKey = '${itemId}_$serviceType';
    final item = _items.where((i) => i.uniqueKey == uniqueKey).firstOrNull;
    return item?.quantity ?? 0;
  }

  void setPickupAddress(String address) {
    _pickupAddress = address;
    notifyListeners();
  }

  void setPickupDate(DateTime date) {
    _pickupDate = date;
    notifyListeners();
  }

  void setPickupTime(String time) {
    _pickupTime = time;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    _paymentMethod = method;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _selectedLaundry = null;
    _pickupAddress = '';
    _pickupDate = null;
    _pickupTime = '';
    _paymentMethod = 'Cash on Delivery';
    notifyListeners();
  }

  bool get isCartValid {
    if (_items.isEmpty) return false;
    if (_selectedLaundry == null) return false;
    if (_deliveryMode == DeliveryMode.delivery && _pickupAddress.isEmpty) return false;
    if (_pickupDate == null) return false;
    if (_pickupTime.isEmpty) return false;
    return true;
  }
}

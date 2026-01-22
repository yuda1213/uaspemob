import 'service_model.dart';

class Order {
  final String id;
  final String laundryId;
  final String laundryName;
  final String userId;
  final List<ServiceItem> items;
  final double totalAmount;
  final String status;
  final DateTime pickupDate;
  final String pickupTime;
  final String pickupAddress;
  final DateTime? deliveryDate;
  final String? deliveryTime;
  final DateTime createdAt;
  final String paymentMethod;
  final String paymentStatus;

  Order({
    required this.id,
    required this.laundryId,
    required this.laundryName,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.pickupDate,
    required this.pickupTime,
    required this.pickupAddress,
    this.deliveryDate,
    this.deliveryTime,
    required this.createdAt,
    required this.paymentMethod,
    required this.paymentStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      laundryId: json['laundryId'] ?? '',
      laundryName: json['laundryName'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ServiceItem.fromJson(e))
              .toList() ??
          [],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      pickupDate: DateTime.parse(json['pickupDate'] ?? DateTime.now().toIso8601String()),
      pickupTime: json['pickupTime'] ?? '',
      pickupAddress: json['pickupAddress'] ?? '',
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      deliveryTime: json['deliveryTime'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      paymentMethod: json['paymentMethod'] ?? '',
      paymentStatus: json['paymentStatus'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'laundryId': laundryId,
      'laundryName': laundryName,
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'pickupDate': pickupDate.toIso8601String(),
      'pickupTime': pickupTime,
      'pickupAddress': pickupAddress,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'deliveryTime': deliveryTime,
      'createdAt': createdAt.toIso8601String(),
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
    };
  }
}

enum OrderStatus {
  pending,
  confirmed,
  pickedUp,
  inProgress,
  ready,
  outForDelivery,
  delivered,
  cancelled
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.pickedUp:
        return 'Picked Up';
      case OrderStatus.inProgress:
        return 'In Progress';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

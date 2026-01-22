class Offer {
  final String id;
  final String title;
  final String description;
  final String code;
  final double discountPercent;
  final double? maxDiscount;
  final double? minOrder;
  final DateTime validFrom;
  final DateTime validUntil;
  final String image;
  final bool isActive;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.code,
    required this.discountPercent,
    this.maxDiscount,
    this.minOrder,
    required this.validFrom,
    required this.validUntil,
    required this.image,
    required this.isActive,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      code: json['code'] ?? '',
      discountPercent: (json['discountPercent'] ?? 0).toDouble(),
      maxDiscount: json['maxDiscount']?.toDouble(),
      minOrder: json['minOrder']?.toDouble(),
      validFrom: DateTime.parse(json['validFrom'] ?? DateTime.now().toIso8601String()),
      validUntil: DateTime.parse(json['validUntil'] ?? DateTime.now().toIso8601String()),
      image: json['image'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'code': code,
      'discountPercent': discountPercent,
      'maxDiscount': maxDiscount,
      'minOrder': minOrder,
      'validFrom': validFrom.toIso8601String(),
      'validUntil': validUntil.toIso8601String(),
      'image': image,
      'isActive': isActive,
    };
  }

  bool get isValid {
    final now = DateTime.now();
    return isActive && now.isAfter(validFrom) && now.isBefore(validUntil);
  }
}

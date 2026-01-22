class ServiceItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final String unit;
  final String image;
  final String description;
  int quantity;

  ServiceItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.unit,
    required this.image,
    required this.description,
    this.quantity = 0,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      unit: json['unit'] ?? 'piece',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'unit': unit,
      'image': image,
      'description': description,
      'quantity': quantity,
    };
  }

  ServiceItem copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    String? unit,
    String? image,
    String? description,
    int? quantity,
  }) {
    return ServiceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      image: image ?? this.image,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ServiceCategory {
  final String id;
  final String name;
  final String icon;
  final List<ServiceItem> items;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.items,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ServiceItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

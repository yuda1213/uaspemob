class Laundry {
  final String id;
  final String name;
  final String address;
  final String image;
  final double rating;
  final int reviewCount;
  final String distance;
  final bool isOpen;
  final String openTime;
  final String closeTime;
  final List<String> services;
  final String description;
  final double latitude;
  final double longitude;

  Laundry({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
    required this.services,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory Laundry.fromJson(Map<String, dynamic> json) {
    return Laundry(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      distance: json['distance'] ?? '',
      isOpen: json['isOpen'] ?? true,
      openTime: json['openTime'] ?? '08:00 AM',
      closeTime: json['closeTime'] ?? '10:00 PM',
      services: List<String>.from(json['services'] ?? []),
      description: json['description'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'image': image,
      'rating': rating,
      'reviewCount': reviewCount,
      'distance': distance,
      'isOpen': isOpen,
      'openTime': openTime,
      'closeTime': closeTime,
      'services': services,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

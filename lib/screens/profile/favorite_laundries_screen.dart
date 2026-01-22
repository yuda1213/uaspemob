import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

// Mock favorite laundry model
class FavoriteLaundry {
  final String id;
  final String name;
  final String image;
  final double rating;
  final int reviews;
  final double distance;
  final double deliveryFee;
  final int deliveryTime;

  FavoriteLaundry({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.deliveryFee,
    required this.deliveryTime,
  });
}

class FavoriteLaundriesScreen extends StatefulWidget {
  const FavoriteLaundriesScreen({super.key});

  @override
  State<FavoriteLaundriesScreen> createState() =>
      _FavoriteLaundriesScreenState();
}

class _FavoriteLaundriesScreenState extends State<FavoriteLaundriesScreen> {
  List<FavoriteLaundry> _favorites = [
    FavoriteLaundry(
      id: '1',
      name: 'Xpress Laundry Services',
      image: 'assets/images/laundry1.jpg',
      rating: 4.8,
      reviews: 324,
      distance: 0.5,
      deliveryFee: 0.0,
      deliveryTime: 24,
    ),
    FavoriteLaundry(
      id: '2',
      name: 'Robin Wash & Fold',
      image: 'assets/images/laundry2.jpg',
      rating: 4.7,
      reviews: 256,
      distance: 1.2,
      deliveryFee: 3.0,
      deliveryTime: 48,
    ),
    FavoriteLaundry(
      id: '3',
      name: 'Sparkle Dry Cleaners',
      image: 'assets/images/laundry3.jpg',
      rating: 4.9,
      reviews: 412,
      distance: 0.8,
      deliveryFee: 2.0,
      deliveryTime: 24,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Favorite Laundries'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 64,
                    color: AppTheme.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favorite laundries yet',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final favorite = _favorites[index];
                return _buildFavoriteLaundryCard(favorite, index)
                    .animate()
                    .fadeIn(delay: (index * 100).ms)
                    .slideX(begin: -0.2, end: 0);
              },
            ),
    );
  }

  Widget _buildFavoriteLaundryCard(FavoriteLaundry laundry, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${laundry.name}'),
              backgroundColor: AppTheme.primaryColor,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder with gradient
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor.withOpacity(0.3), AppTheme.secondaryColor.withOpacity(0.3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.local_laundry_service,
                      size: 48,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _removeFavorite(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.close,
                          color: AppTheme.errorColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laundry.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${laundry.rating} (${laundry.reviews})',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${laundry.distance} km',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.delivery_dining,
                            size: 14,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            laundry.deliveryFee == 0
                                ? 'Free delivery'
                                : '\$${laundry.deliveryFee}',
                            style: TextStyle(
                              fontSize: 12,
                              color: laundry.deliveryFee == 0
                                  ? AppTheme.successColor
                                  : AppTheme.textSecondary,
                              fontWeight: laundry.deliveryFee == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${laundry.deliveryTime}h',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFavorite(int index) {
    setState(() {
      _favorites.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from favorites'),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }
}

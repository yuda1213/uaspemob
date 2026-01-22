import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/theme.dart';
import '../../providers/laundry_provider.dart';
import '../../providers/supabase_auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/language_provider.dart';
import '../../models/laundry_model.dart';
import '../laundry/laundry_detail_screen.dart';
import 'service_laundries_screen.dart';
import 'notifications_screen.dart';
import 'delivery_options_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LaundryProvider>().fetchAll();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<SupabaseAuthProvider>();
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<LaundryProvider>().fetchAll(),
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: _buildHeader(authProvider),
              ),
              
              // Search bar
              SliverToBoxAdapter(
                child: _buildSearchBar(),
              ),
              
              // Top Services
              SliverToBoxAdapter(
                child: _buildTopServices(),
              ),
              
              // Popular Laundries
              SliverToBoxAdapter(
                child: _buildPopularLaundries(),
              ),
              
              // Special Offers
              SliverToBoxAdapter(
                child: _buildSpecialOffers(),
              ),
              
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(SupabaseAuthProvider authProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${authProvider.userName ?? 'User'}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'San Francisco',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    icon: Badge(
                      smallSize: 8,
                      child: Icon(
                        Icons.notifications_outlined,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Consumer<CartProvider>(
                    builder: (context, cart, _) {
                      final isDelivery = cart.deliveryMode == DeliveryMode.delivery;
                      return GestureDetector(
                        onTap: () {
                          showDeliveryOptionsSheet(
                            context,
                            currentMode: isDelivery ? DeliveryMode.delivery : DeliveryMode.pickup,
                            onModeChanged: (mode) {
                              cart.setDeliveryMode(mode);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    mode == DeliveryMode.delivery
                                        ? 'Switched to Delivery mode'
                                        : 'Switched to Self Pickup mode (10% discount!)',
                                  ),
                                  backgroundColor: AppTheme.successColor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isDelivery ? Icons.delivery_dining : Icons.store,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isDelivery ? 'Delivery' : 'Pickup',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Consumer<LanguageProvider>(
          builder: (context, langProvider, _) => TextField(
            controller: _searchController,
            onChanged: (value) {
              context.read<LaundryProvider>().searchLaundries(value);
            },
            decoration: InputDecoration(
              hintText: langProvider.translate('search'),
              hintStyle: TextStyle(color: AppTheme.textSecondary),
              prefixIcon: Icon(Icons.search, color: AppTheme.textSecondary),
              suffixIcon: IconButton(
                icon: Icon(Icons.tune, color: AppTheme.primaryColor),
                onPressed: () {},
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTopServices() {
    final services = [
      {'name': 'Wash & Fold', 'icon': Icons.local_laundry_service},
      {'name': 'Wash & Iron', 'icon': Icons.iron},
      {'name': 'Dry Clean', 'icon': Icons.dry_cleaning},
      {'name': 'Premium Wash', 'icon': Icons.star},
    ];

    return Consumer<LanguageProvider>(
      builder: (context, langProvider, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              langProvider.translate('top_services'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: services.asMap().entries.map((entry) {
                final index = entry.key;
                final service = entry.value;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceLaundriesScreen(
                          serviceName: service['name'] as String,
                          serviceIcon: service['icon'] as IconData,
                        ),
                      ),
                    );
                  },
                  child: _buildServiceItem(
                    service['name'] as String,
                    service['icon'] as IconData,
                  ).animate(delay: (300 + index * 100).ms).fadeIn().scale(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String name, IconData icon) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPopularLaundries() {
    return Consumer<LaundryProvider>(
      builder: (context, provider, _) {
        return Consumer<LanguageProvider>(
          builder: (context, langProvider, _) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      langProvider.translate('popular_laundries'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Nearby tab by finding the parent state
                        try {
                          final homeState = context.findAncestorStateOfType<State>();
                          if (homeState != null && homeState.runtimeType.toString() == '_MainScreenState') {
                            (homeState as dynamic).setCurrentIndex(1);
                          }
                        } catch (e) {
                          // Fallback - just navigate
                        }
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (provider.isLoading)
                  _buildLoadingShimmer()
                else
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.popularLaundries.length,
                      itemBuilder: (context, index) {
                        final laundry = provider.popularLaundries[index];
                        return _buildLaundryCard(laundry, index);
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLaundryCard(Laundry laundry, int index) {
    return GestureDetector(
      onTap: () {
        context.read<LaundryProvider>().setSelectedLaundry(laundry);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LaundryDetailScreen(laundry: laundry),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 16, left: index == 0 ? 0 : 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                laundry.image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  child: Icon(
                    Icons.local_laundry_service,
                    size: 40,
                    color: AppTheme.primaryColor,
                  ),
                ),
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
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${laundry.rating}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        laundry.distance,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate(delay: (500 + index * 150).ms).fadeIn().slideX(begin: 0.2, end: 0),
    );
  }

  Widget _buildSpecialOffers() {
    return Consumer<LaundryProvider>(
      builder: (context, provider, _) {
        return Consumer<LanguageProvider>(
          builder: (context, langProvider, _) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      langProvider.translate('special_offers'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Offers tab
                        try {
                          final homeState = context.findAncestorStateOfType<State>();
                          if (homeState != null && homeState.runtimeType.toString() == '_MainScreenState') {
                            (homeState as dynamic).setCurrentIndex(3);
                          }
                        } catch (e) {
                          // Fallback - just navigate
                        }
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (provider.isLoading)
                  _buildLoadingShimmer()
                else
                  ...provider.offers.take(2).toList().asMap().entries.map((entry) {
                    final index = entry.key;
                    final offer = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.secondaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'For a limited time',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  offer.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  offer.description,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.local_offer,
                              color: AppTheme.primaryColor,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ).animate(delay: (800 + index * 200).ms).fadeIn().slideY(begin: 0.2, end: 0);
                  }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

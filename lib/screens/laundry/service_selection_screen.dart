import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../models/laundry_model.dart';
import '../../models/service_model.dart';
import '../../providers/cart_provider.dart';
import '../cart/cart_screen.dart';

// Service types with price multipliers
enum ServiceType {
  washAndFold,
  washAndIron,
  dryClean,
}

extension ServiceTypeExtension on ServiceType {
  String get name {
    switch (this) {
      case ServiceType.washAndFold:
        return 'Wash & Fold';
      case ServiceType.washAndIron:
        return 'Wash & Iron';
      case ServiceType.dryClean:
        return 'Dry Clean';
    }
  }

  IconData get icon {
    switch (this) {
      case ServiceType.washAndFold:
        return Icons.local_laundry_service;
      case ServiceType.washAndIron:
        return Icons.iron;
      case ServiceType.dryClean:
        return Icons.dry_cleaning;
    }
  }

  // Price multiplier for different service types
  double get priceMultiplier {
    switch (this) {
      case ServiceType.washAndFold:
        return 1.0; // Base price
      case ServiceType.washAndIron:
        return 1.5; // 50% more for ironing
      case ServiceType.dryClean:
        return 2.0; // Double price for dry cleaning
    }
  }
}

class ServiceSelectionScreen extends StatefulWidget {
  final Laundry laundry;
  final ServiceCategory category;

  const ServiceSelectionScreen({
    super.key,
    required this.laundry,
    required this.category,
  });

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  ServiceType _selectedServiceType = ServiceType.washAndFold;

  // Calculate price based on service type
  double _getAdjustedPrice(double basePrice) {
    return basePrice * _selectedServiceType.priceMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppTheme.errorColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cart.totalItems}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Service type tabs
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ServiceType.values.map((type) {
                return _buildServiceTypeChip(
                  type.name,
                  type.icon,
                  _selectedServiceType == type,
                  () {
                    setState(() {
                      _selectedServiceType = type;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          
          // Items list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.category.items.length,
              itemBuilder: (context, index) {
                final item = widget.category.items[index];
                return _buildItemCard(item, index);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildServiceTypeChip(String label, IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppTheme.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(ServiceItem item, int index) {
    final adjustedPrice = _getAdjustedPrice(item.price);
    final serviceTypeName = _selectedServiceType.name;
    
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        final quantity = cart.getItemQuantityByServiceType(item.id, serviceTypeName);
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              // Item icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.checkroom,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              
              // Item info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${adjustedPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Quantity controls
              if (quantity > 0)
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => cart.removeItemWithServiceType(item, serviceTypeName),
                        icon: const Icon(Icons.remove, size: 18),
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () => cart.addItemWithServiceType(item, serviceTypeName, adjustedPrice),
                        icon: const Icon(Icons.add, size: 18),
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                    ],
                  ),
                )
              else
                IconButton(
                  onPressed: () => cart.addItemWithServiceType(item, serviceTypeName, adjustedPrice),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
        ).animate(delay: (100 * index).ms).fadeIn().slideX(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildBottomBar() {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        if (cart.totalItems == 0) {
          return const SizedBox.shrink();
        }
        
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${cart.totalItems} items',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$${cart.subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child: const Text('View Bag'),
                ),
              ],
            ),
          ),
        ).animate().slideY(begin: 1, end: 0);
      },
    );
  }
}

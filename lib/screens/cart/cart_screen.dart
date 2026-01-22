import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/cart_provider.dart';
import '../../providers/language_provider.dart';
import 'schedule_pickup_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, langProvider, _) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(langProvider.translate('your_bag')),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<CartProvider>(
          builder: (context, cart, _) {
            if (cart.items.isEmpty) {
              return _buildEmptyCart();
            }

            return Column(
              children: [
                // Laundry info
                if (cart.selectedLaundry != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.local_laundry_service,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cart.selectedLaundry!.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                cart.selectedLaundry!.address,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(),
                const SizedBox(height: 8),
                // Items list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        item.serviceItem.category,
                                        style: TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          item.serviceType,
                                          style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.serviceItem.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${item.adjustedPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => cart.removeItemWithServiceType(item.serviceItem, item.serviceType),
                                  icon: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(Icons.remove, size: 16),
                                  ),
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => cart.addItemWithServiceType(item.serviceItem, item.serviceType, item.adjustedPrice),
                                  icon: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(Icons.add, size: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '\$${(item.adjustedPrice * item.quantity).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ).animate(delay: (100 * index).ms).fadeIn().slideX(begin: 0.1, end: 0);
                    },
                  ),
                ),
                // Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            cart.deliveryMode == DeliveryMode.pickup ? Icons.store : Icons.delivery_dining,
                            color: cart.deliveryMode == DeliveryMode.pickup ? AppTheme.successColor : AppTheme.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              cart.deliveryMode == DeliveryMode.pickup
                                  ? 'Self Pickup - 10% Discount Applied!'
                                  : 'Delivery to your address',
                              style: TextStyle(
                                color: cart.deliveryMode == DeliveryMode.pickup ? AppTheme.successColor : AppTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _buildSummaryRow(langProvider.translate('subtotal'), '\$${cart.subtotal.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      if (cart.deliveryMode == DeliveryMode.pickup && cart.pickupDiscount > 0) ...[
                        _buildSummaryRow(
                          'Pickup Discount (10%)',
                          '-\$${cart.pickupDiscount.toStringAsFixed(2)}',
                          isHighlighted: true,
                        ),
                        const SizedBox(height: 8),
                      ],
                      if (cart.deliveryMode == DeliveryMode.delivery)
                        _buildSummaryRow(
                          langProvider.translate('delivery_fee'),
                          cart.deliveryFee == 0 ? 'FREE' : '\$${cart.deliveryFee.toStringAsFixed(2)}',
                          isHighlighted: cart.deliveryFee == 0,
                        ),
                      const Divider(height: 24),
                      _buildSummaryRow(
                        langProvider.translate('total'),
                        '\$${cart.total.toStringAsFixed(2)}',
                        isBold: true,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SchedulePickupScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(langProvider.translate('proceed_checkout')),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 100,
            color: AppTheme.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your bag is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some items to get started',
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ).animate().fadeIn().scale(),
    );
  }

  static Widget _buildSummaryRow(String label, String value, {bool isBold = false, bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold ? AppTheme.textPrimary : AppTheme.textSecondary,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isHighlighted ? AppTheme.successColor : (isBold ? AppTheme.textPrimary : AppTheme.textSecondary),
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 18 : 14,
          ),
        ),
      ],
    );
  }
}

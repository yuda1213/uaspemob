import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/cart_provider.dart';
import '../home/main_screen.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success animation
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 100,
                  color: AppTheme.successColor,
                ),
              )
                  .animate(controller: _controller)
                  .scale(
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  ),
              
              const SizedBox(height: 32),
              
              // Title
              const Text(
                'Order Placed Successfully!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 16),
              
              // Order ID
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Order ID: #ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ).animate(delay: 600.ms).fadeIn(),
              
              const SizedBox(height: 24),
              
              // Description
              Consumer<CartProvider>(
                builder: (context, cart, _) {
                  final isDelivery = cart.deliveryMode == DeliveryMode.delivery;
                  return Text(
                    isDelivery
                        ? 'Your pickup has been scheduled. We will notify you once our delivery partner picks up your clothes.'
                        : 'Your order is confirmed! Please visit the store at your scheduled time to drop off your clothes.',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ).animate(delay: 800.ms).fadeIn();
                },
              ),
              
              const SizedBox(height: 48),
              
              // Order details card
              Consumer<CartProvider>(
                builder: (context, cart, _) {
                  final isDelivery = cart.deliveryMode == DeliveryMode.delivery;
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          'Service Type',
                          isDelivery ? 'Delivery' : 'Self Pickup',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          'Items',
                          '${cart.totalItems} items',
                        ),
                        const SizedBox(height: 12),
                        if (!isDelivery && cart.pickupDiscount > 0) ...[
                          _buildDetailRow(
                            'Pickup Discount',
                            '-\$${cart.pickupDiscount.toStringAsFixed(2)}',
                            isHighlighted: true,
                          ),
                          const SizedBox(height: 12),
                        ],
                        _buildDetailRow(
                          'Total Amount',
                          '\$${cart.total.toStringAsFixed(2)}',
                          isBold: true,
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          'Payment',
                          cart.paymentMethod,
                        ),
                      ],
                    ),
                  ).animate(delay: 1000.ms).fadeIn().slideY(begin: 0.2, end: 0);
                },
              ),
              
              const Spacer(),
              
              // Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartProvider>().clearCart();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const MainScreen()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('BACK TO HOME'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigate to order tracking
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('TRACK ORDER'),
                    ),
                  ),
                ],
              ).animate(delay: 1200.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false, bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isHighlighted 
                ? AppTheme.successColor 
                : (isBold ? AppTheme.primaryColor : AppTheme.textPrimary),
          ),
        ),
      ],
    );
  }
}

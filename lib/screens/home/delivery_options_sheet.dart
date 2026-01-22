import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';
import '../../providers/cart_provider.dart';

class DeliveryOptionsSheet extends StatefulWidget {
  final DeliveryMode currentMode;
  final Function(DeliveryMode) onModeChanged;

  const DeliveryOptionsSheet({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  State<DeliveryOptionsSheet> createState() => _DeliveryOptionsSheetState();
}

class _DeliveryOptionsSheetState extends State<DeliveryOptionsSheet> {
  late DeliveryMode _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.currentMode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          const Text(
            'Choose Service Type',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select how you want to get your laundry done',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // Delivery Option
          _buildOptionCard(
            mode: DeliveryMode.delivery,
            icon: Icons.delivery_dining,
            title: 'Delivery',
            subtitle: 'We pick up and deliver to your doorstep',
            features: [
              'Free pickup & delivery on orders above \$50',
              'Scheduled time slots available',
              'Real-time tracking',
            ],
            index: 0,
          ),

          const SizedBox(height: 16),

          // Pickup Option
          _buildOptionCard(
            mode: DeliveryMode.pickup,
            icon: Icons.store,
            title: 'Self Pickup',
            subtitle: 'Drop off and pick up at store',
            features: [
              '10% discount on all services',
              'Faster processing time',
              'Flexible pickup hours',
            ],
            index: 1,
          ),

          const SizedBox(height: 24),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onModeChanged(_selectedMode);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _selectedMode == DeliveryMode.delivery
                    ? 'Continue with Delivery'
                    : 'Continue with Pickup',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required DeliveryMode mode,
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> features,
    required int index,
  }) {
    final isSelected = _selectedMode == mode;

    return GestureDetector(
      onTap: () => setState(() => _selectedMode = mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : AppTheme.primaryColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Radio<DeliveryMode>(
                  value: mode,
                  groupValue: _selectedMode,
                  activeColor: AppTheme.primaryColor,
                  onChanged: (value) => setState(() => _selectedMode = value!),
                ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppTheme.successColor,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ).animate(delay: (100 * index).ms).fadeIn().slideX(begin: 0.1, end: 0),
    );
  }
}

// Helper function to show the delivery options bottom sheet
void showDeliveryOptionsSheet(
  BuildContext context, {
  required DeliveryMode currentMode,
  required Function(DeliveryMode) onModeChanged,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DeliveryOptionsSheet(
      currentMode: currentMode,
      onModeChanged: onModeChanged,
    ),
  );
}

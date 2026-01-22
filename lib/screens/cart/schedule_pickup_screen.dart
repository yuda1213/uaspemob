import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';
import '../../providers/cart_provider.dart';
import '../../providers/language_provider.dart';
import 'order_confirmation_screen.dart';

class SchedulePickupScreen extends StatefulWidget {
  const SchedulePickupScreen({super.key});

  @override
  State<SchedulePickupScreen> createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  int _currentStep = 0;
  final _addressController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedTime;
  String _selectedPayment = 'Cash on Delivery';

  final List<String> _timeSlots = [
    '08:00 AM - 10:00 AM',
    '10:00 AM - 12:00 PM',
    '12:00 PM - 02:00 PM',
    '02:00 PM - 04:00 PM',
    '04:00 PM - 06:00 PM',
    '06:00 PM - 08:00 PM',
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Cash on Delivery', 'icon': Icons.money},
    {'name': 'Credit Card', 'icon': Icons.credit_card},
    {'name': 'Debit Card', 'icon': Icons.credit_card_outlined},
    {'name': 'UPI', 'icon': Icons.phone_android},
    {'name': 'E-Wallet', 'icon': Icons.account_balance_wallet},
  ];

  bool get _isDeliveryMode => context.read<CartProvider>().deliveryMode == DeliveryMode.delivery;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _nextStep() {
    final maxStep = _isDeliveryMode ? 3 : 2;
    if (_currentStep < maxStep) {
      if (!_canProceed()) {
        _showValidationError();
        return;
      }
      setState(() => _currentStep++);
    } else {
      _completeOrder();
    }
  }

  void _showValidationError() {
    String message = '';
    if (_isDeliveryMode) {
      switch (_currentStep) {
        case 0:
          message = 'Please enter your delivery address';
          break;
        case 1:
          if (_selectedDate == null) {
            message = 'Please select a pickup date';
          } else if (_selectedTime == null) {
            message = 'Please select a time slot';
          }
          break;
        case 2:
          message = 'Please select a payment method';
          break;
      }
    } else {
      // Pickup mode - no address step
      switch (_currentStep) {
        case 0:
          if (_selectedDate == null) {
            message = 'Please select a date';
          } else if (_selectedTime == null) {
            message = 'Please select a time slot';
          }
          break;
        case 1:
          message = 'Please select a payment method';
          break;
      }
    }
    
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppTheme.errorColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _completeOrder() {
    final cart = context.read<CartProvider>();
    if (_isDeliveryMode) {
      cart.setPickupAddress(_addressController.text);
    } else {
      // For pickup mode, use store address
      cart.setPickupAddress(cart.selectedLaundry?.address ?? 'Store Pickup');
    }
    cart.setPickupDate(_selectedDate!);
    cart.setPickupTime(_selectedTime!);
    cart.setPaymentMethod(_selectedPayment);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OrderConfirmationScreen()),
    );
  }

  bool _canProceed() {
    if (_isDeliveryMode) {
      switch (_currentStep) {
        case 0:
          return _addressController.text.isNotEmpty;
        case 1:
          return _selectedDate != null && _selectedTime != null;
        case 2:
          return _selectedPayment.isNotEmpty;
        case 3:
          return true;
        default:
          return false;
      }
    } else {
      // Pickup mode - no address step
      switch (_currentStep) {
        case 0:
          return _selectedDate != null && _selectedTime != null;
        case 1:
          return _selectedPayment.isNotEmpty;
        case 2:
          return true;
        default:
          return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final isDelivery = cart.deliveryMode == DeliveryMode.delivery;
    
    return Consumer<LanguageProvider>(
      builder: (context, langProvider, _) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(isDelivery ? langProvider.translate('schedule_pickup') : langProvider.translate('schedule_store_visit')),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      body: Column(
        children: [
          // Mode indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: isDelivery ? AppTheme.primaryColor.withOpacity(0.1) : AppTheme.successColor.withOpacity(0.1),
            child: Row(
              children: [
                Icon(
                  isDelivery ? Icons.delivery_dining : Icons.store,
                  color: isDelivery ? AppTheme.primaryColor : AppTheme.successColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDelivery ? 'Delivery Mode' : 'Self Pickup Mode',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDelivery ? AppTheme.primaryColor : AppTheme.successColor,
                        ),
                      ),
                      Text(
                        isDelivery 
                            ? 'We will pick up and deliver to your address'
                            : 'Visit the store to drop off & pick up your laundry',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isDelivery)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '10% OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: isDelivery
                  ? [
                      _buildStepIndicator(0, 'Location'),
                      _buildStepConnector(0),
                      _buildStepIndicator(1, 'Date/Time'),
                      _buildStepConnector(1),
                      _buildStepIndicator(2, 'Payment'),
                      _buildStepConnector(2),
                      _buildStepIndicator(3, 'Complete'),
                    ]
                  : [
                      _buildStepIndicator(0, 'Date/Time'),
                      _buildStepConnector(0),
                      _buildStepIndicator(1, 'Payment'),
                      _buildStepConnector(1),
                      _buildStepIndicator(2, 'Complete'),
                    ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildCurrentStep(),
            ),
          ),

          // Bottom button
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
            child: SafeArea(
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _currentStep--),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Consumer<LanguageProvider>(
                        builder: (context, langProvider, _) => Text(_getButtonText()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  String _getButtonText() {
    final maxStep = _isDeliveryMode ? 3 : 2;
    if (_currentStep == maxStep) {
      return 'PLACE ORDER';
    }
    return 'CONTINUE';
  }

  Widget _buildStepIndicator(int step, String label) {
    final isCompleted = _currentStep > step;
    final isCurrent = _currentStep == step;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isCompleted || isCurrent
                  ? AppTheme.primaryColor
                  : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(
                      '${step + 1}',
                      style: TextStyle(
                        color: isCurrent ? Colors.white : AppTheme.textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isCurrent ? AppTheme.primaryColor : AppTheme.textSecondary,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(int step) {
    final isCompleted = _currentStep > step;
    return Container(
      width: 20,
      height: 2,
      color: isCompleted ? AppTheme.primaryColor : Colors.grey.shade300,
      margin: const EdgeInsets.only(bottom: 20),
    );
  }

  Widget _buildCurrentStep() {
    if (_isDeliveryMode) {
      switch (_currentStep) {
        case 0:
          return _buildLocationStep();
        case 1:
          return _buildDateTimeStep();
        case 2:
          return _buildPaymentStep();
        case 3:
          return _buildCompleteStep();
        default:
          return const SizedBox();
      }
    } else {
      // Pickup mode - no address step
      switch (_currentStep) {
        case 0:
          return _buildDateTimeStep();
        case 1:
          return _buildPaymentStep();
        case 2:
          return _buildCompleteStep();
        default:
          return const SizedBox();
      }
    }
  }

  Widget _buildLocationStep() {
    return Consumer<LanguageProvider>(
      builder: (context, langProvider, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Where should we deliver?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your pickup and delivery address',
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Address field
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.home, color: AppTheme.primaryColor),
                    const SizedBox(width: 12),
                    const Text(
                      'Home',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: langProvider.translate('delivery_address'),
                    fillColor: AppTheme.backgroundColor,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),

          const SizedBox(height: 16),

          // Add address button
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Address'),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select pickup date & time',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        // Date selection
        const Text(
          'Select Date',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected = _selectedDate?.day == date.day;
              
              return GestureDetector(
                onTap: () => setState(() => _selectedDate = date),
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE').format(date),
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        DateFormat('MMM').format(date),
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: (100 * index).ms).fadeIn().scale(),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // Time selection
        const Text(
          'Select Time Slot',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _timeSlots.asMap().entries.map((entry) {
            final index = entry.key;
            final time = entry.value;
            final isSelected = _selectedTime == time;
            
            return GestureDetector(
              onTap: () => setState(() => _selectedTime = time),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ).animate(delay: (100 * index).ms).fadeIn(),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPaymentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select payment method',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        ...List.generate(_paymentMethods.length, (index) {
          final method = _paymentMethods[index];
          final isSelected = _selectedPayment == method['name'];
          
          return GestureDetector(
            onTap: () => setState(() => _selectedPayment = method['name']),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      method['icon'],
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      method['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: AppTheme.primaryColor,
                    ),
                ],
              ),
            ).animate(delay: (100 * index).ms).fadeIn().slideX(begin: 0.1, end: 0),
          );
        }),
      ],
    );
  }

  Widget _buildCompleteStep() {
    final cart = context.watch<CartProvider>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        // Summary card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildSummaryItem(
                Icons.local_laundry_service,
                'Laundry',
                cart.selectedLaundry?.name ?? '',
              ),
              const Divider(),
              _buildSummaryItem(
                Icons.location_on,
                'Address',
                _addressController.text,
              ),
              const Divider(),
              _buildSummaryItem(
                Icons.calendar_today,
                'Date',
                _selectedDate != null
                    ? DateFormat('EEEE, MMM d, yyyy').format(_selectedDate!)
                    : '',
              ),
              const Divider(),
              _buildSummaryItem(
                Icons.access_time,
                'Time',
                _selectedTime ?? '',
              ),
              const Divider(),
              _buildSummaryItem(
                Icons.payment,
                'Payment',
                _selectedPayment,
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '\$${cart.total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn().scale(),
      ],
    );
  }

  Widget _buildSummaryItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock bookings data
  final List<Map<String, dynamic>> _activeBookings = [
    {
      'id': 'ORD123456',
      'laundry': 'Xpress Laundry Services',
      'status': 'In Progress',
      'items': 5,
      'total': 25.50,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'statusColor': Colors.orange,
    },
    {
      'id': 'ORD123457',
      'laundry': 'Sparkle Dry Cleaners',
      'status': 'Picked Up',
      'items': 3,
      'total': 18.00,
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'statusColor': AppTheme.primaryColor,
    },
  ];

  final List<Map<String, dynamic>> _completedBookings = [
    {
      'id': 'ORD123450',
      'laundry': 'Robin Wash & Fold',
      'status': 'Delivered',
      'items': 8,
      'total': 42.00,
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'statusColor': AppTheme.successColor,
    },
    {
      'id': 'ORD123445',
      'laundry': 'Xpress Laundry Services',
      'status': 'Delivered',
      'items': 4,
      'total': 22.00,
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'statusColor': AppTheme.successColor,
    },
    {
      'id': 'ORD123440',
      'laundry': 'My Laundry Hub',
      'status': 'Cancelled',
      'items': 2,
      'total': 12.00,
      'date': DateTime.now().subtract(const Duration(days: 15)),
      'statusColor': AppTheme.errorColor,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.primaryColor,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList(_activeBookings, isActive: true),
          _buildBookingsList(_completedBookings, isActive: false),
        ],
      ),
    );
  }

  Widget _buildBookingsList(List<Map<String, dynamic>> bookings, {required bool isActive}) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 80,
              color: AppTheme.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No ${isActive ? 'active' : 'completed'} bookings',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildBookingCard(booking, index);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking['id'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (booking['statusColor'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  booking['status'],
                  style: TextStyle(
                    color: booking['statusColor'],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Laundry name
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.local_laundry_service,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['laundry'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${booking['items']} items',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${booking['total'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          
          const Divider(height: 24),
          
          // Date and actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(booking['date']),
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (booking['status'] != 'Cancelled')
                    TextButton(
                      onPressed: () => _showOrderDetails(booking),
                      child: const Text('View Details'),
                    ),
                  if (booking['status'] == 'Delivered')
                    TextButton(
                      onPressed: () {},
                      child: const Text('Reorder'),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: (100 * index).ms).fadeIn().slideY(begin: 0.1, end: 0);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showOrderDetails(Map<String, dynamic> booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    'Order ${booking['id']}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Order timeline
                  _buildTimelineItem('Order Placed', true),
                  _buildTimelineItem('Picked Up', booking['status'] != 'Pending'),
                  _buildTimelineItem('In Progress', 
                      booking['status'] == 'In Progress' || booking['status'] == 'Delivered'),
                  _buildTimelineItem('Out for Delivery', booking['status'] == 'Delivered'),
                  _buildTimelineItem('Delivered', booking['status'] == 'Delivered', isLast: true),
                  
                  const SizedBox(height: 24),
                  
                  // Summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Items', style: TextStyle(color: AppTheme.textSecondary)),
                            Text('${booking['items']} items'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              '\$${booking['total'].toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTimelineItem(String title, bool isCompleted, {bool isLast = false}) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? AppTheme.successColor : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30,
                color: isCompleted ? AppTheme.successColor : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            color: isCompleted ? AppTheme.textPrimary : AppTheme.textSecondary,
            fontWeight: isCompleted ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

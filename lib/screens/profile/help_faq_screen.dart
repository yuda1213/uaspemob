import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'How does the laundry service work?',
      'answer':
          'Our laundry service is simple. Select your laundry items, schedule a pickup, and we\'ll handle the rest. We\'ll collect, clean, and deliver your clothes back to you.',
      'isExpanded': false,
    },
    {
      'question': 'What are the delivery charges?',
      'answer':
          'Delivery is free for orders above \$50. For orders below \$50, there\'s a flat delivery fee of \$5. Self-pickup orders get a 10% discount on the total.',
      'isExpanded': false,
    },
    {
      'question': 'How long does it take to deliver?',
      'answer':
          'Standard delivery takes 24-48 hours from the time of pickup. Express delivery (additional fee) is available for 24-hour turnaround.',
      'isExpanded': false,
    },
    {
      'question': 'Can I track my order?',
      'answer':
          'Yes! You can track your order in real-time through our app. Get updates from pickup to delivery.',
      'isExpanded': false,
    },
    {
      'question': 'What payment methods do you accept?',
      'answer':
          'We accept credit cards, debit cards, digital wallets, and cash on delivery.',
      'isExpanded': false,
    },
    {
      'question': 'What if I\'m not satisfied with the service?',
      'answer':
          'We offer a 100% satisfaction guarantee. If you\'re not happy with the service, contact our support team and we\'ll make it right.',
      'isExpanded': false,
    },
    {
      'question': 'How do I schedule a pickup?',
      'answer':
          'Go to the Bookings tab, select your laundry items and services, choose a pickup date and time, and confirm your order.',
      'isExpanded': false,
    },
    {
      'question': 'Can I cancel my order?',
      'answer':
          'You can cancel your order up to 2 hours before the scheduled pickup time. Visit your active orders and select cancel.',
      'isExpanded': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Help & FAQ'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Find answers to common questions below',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 24),
            Text(
              'Frequently Asked Questions',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _faqs.length,
              itemBuilder: (context, index) {
                return _buildFaqItem(index)
                    .animate()
                    .fadeIn(delay: (100 + index * 50).ms)
                    .slideX(begin: -0.1, end: 0);
              },
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Still have questions?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contact our support team. We\'re here to help!',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Redirecting to contact support'),
                            backgroundColor: AppTheme.primaryColor,
                          ),
                        );
                      },
                      icon: const Icon(Icons.support_agent),
                      label: const Text('Contact Support'),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(int index) {
    final faq = _faqs[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: ExpansionTile(
        initiallyExpanded: faq['isExpanded'],
        onExpansionChanged: (expanded) {
          setState(() {
            _faqs[index]['isExpanded'] = expanded;
          });
        },
        title: Text(
          faq['question'],
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              faq['answer'],
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

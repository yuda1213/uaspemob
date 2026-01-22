import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
            _buildSection(
              title: '1. Introduction',
              content:
                  'This Privacy Policy describes how Laundry Service ("Company", "we", "our", or "us") collects, uses, and shares information about you when you use our website and mobile application.',
              delayMs: 100,
            ),
            _buildSection(
              title: '2. Information We Collect',
              content:
                  'We collect information you provide directly to us, such as when you create an account, place an order, or contact us. This includes your name, email address, phone number, shipping address, and payment information.',
              delayMs: 150,
            ),
            _buildSection(
              title: '3. How We Use Information',
              content:
                  'We use the information we collect to: provide, maintain, and improve our services; process transactions; send transactional and promotional emails; respond to your inquiries; and comply with legal obligations.',
              delayMs: 200,
            ),
            _buildSection(
              title: '4. Information Sharing',
              content:
                  'We do not sell your personal information. We may share your information with third-party service providers who assist us in operating our website and conducting our business, subject to confidentiality agreements.',
              delayMs: 250,
            ),
            _buildSection(
              title: '5. Data Security',
              content:
                  'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
              delayMs: 300,
            ),
            _buildSection(
              title: '6. Your Rights',
              content:
                  'You have the right to access, correct, or delete your personal information. You can also opt out of receiving promotional communications from us at any time.',
              delayMs: 350,
            ),
            _buildSection(
              title: '7. Cookies and Tracking',
              content:
                  'We use cookies and similar tracking technologies to enhance your experience on our website and app, analyze usage patterns, and remember your preferences.',
              delayMs: 400,
            ),
            _buildSection(
              title: '8. Third-Party Links',
              content:
                  'Our website and app may contain links to third-party websites and applications. We are not responsible for the privacy practices of these third parties.',
              delayMs: 450,
            ),
            _buildSection(
              title: '9. Contact Us',
              content:
                  'If you have any questions about this Privacy Policy or our privacy practices, please contact us at privacy@laundry.com or call +1 (555) 123-4567.',
              delayMs: 500,
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Last Updated',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'December 2024',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 550.ms),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required int delayMs,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
      ],
    ).animate().fadeIn(delay: Duration(milliseconds: delayMs)).slideX(begin: -0.1, end: 0);
  }
}

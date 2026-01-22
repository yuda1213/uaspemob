import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/theme.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Terms of Service'),
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
              title: '1. Terms of Agreement',
              content:
                  'By accessing and using this website and mobile application, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.',
              delayMs: 100,
            ),
            _buildSection(
              title: '2. Use License',
              content:
                  'Permission is granted to temporarily download one copy of the materials (information or software) on our website for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.',
              delayMs: 150,
            ),
            _buildSection(
              title: '3. Disclaimer',
              content:
                  'The materials on our website and app are provided on an \'as is\' basis. We make no warranties, expressed or implied, and hereby disclaim and negate all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property.',
              delayMs: 200,
            ),
            _buildSection(
              title: '4. Limitations',
              content:
                  'In no event shall our company or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on our website.',
              delayMs: 250,
            ),
            _buildSection(
              title: '5. Accuracy of Materials',
              content:
                  'The materials appearing on our website could include technical, typographical, or photographic errors. We do not warrant that any of the materials on our website are accurate, complete, or current.',
              delayMs: 300,
            ),
            _buildSection(
              title: '6. Links',
              content:
                  'We have not reviewed all of the sites linked to our website and are not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by us of the site. Use of any such linked website is at the user\'s own risk.',
              delayMs: 350,
            ),
            _buildSection(
              title: '7. Modifications',
              content:
                  'We may revise these terms of service for our website and app at any time without notice. By using this website and app, you are agreeing to be bound by the then current version of these terms of service.',
              delayMs: 400,
            ),
            _buildSection(
              title: '8. Governing Law',
              content:
                  'These terms and conditions are governed by and construed in accordance with the laws of the jurisdiction in which the Company operates, and you irrevocably submit to the exclusive jurisdiction of the courts in that location.',
              delayMs: 450,
            ),
            _buildSection(
              title: '9. User Responsibilities',
              content:
                  'Users agree to use the service lawfully and not to use it for any illegal purposes or in violation of any laws or rights of third parties. Prohibited behavior includes harassment, obscenity, and false claims.',
              delayMs: 500,
            ),
            _buildSection(
              title: '10. Account Security',
              content:
                  'You are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer. You agree to accept responsibility for all activities that occur under your account.',
              delayMs: 550,
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
            ).animate().fadeIn(delay: 600.ms),
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

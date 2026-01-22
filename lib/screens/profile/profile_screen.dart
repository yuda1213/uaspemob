import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/supabase_auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../auth/login_screen.dart';
import 'edit_profile_screen.dart';
import 'saved_addresses_screen.dart';
import 'payment_methods_screen.dart';
import 'order_history_screen.dart';
import 'favorite_laundries_screen.dart';
import 'help_faq_screen.dart';
import 'contact_us_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_of_service_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool _notificationsEnabled;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<SupabaseAuthProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Profile header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Center(
                          child: Text(
                            (authProvider.userName ?? 'U')[0].toUpperCase(),
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        authProvider.userName ?? 'User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        authProvider.userEmail ?? 'user@example.com',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Profile options
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Account section
                  _buildSection('Account', [
                        _buildMenuItem(
                          Icons.person_outline,
                          'Edit Profile',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                          ),
                        ),
                        _buildMenuItem(
                          Icons.location_on_outlined,
                          'Saved Addresses',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SavedAddressesScreen()),
                          ),
                        ),
                        _buildMenuItem(
                          Icons.payment,
                          'Payment Methods',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
                          ),
                        ),
                      ])
                      .animate()
                      .fadeIn(delay: 100.ms)
                      .slideX(begin: -0.1, end: 0),

                  const SizedBox(height: 16),

                  // Orders section
                  _buildSection('Orders', [
                        _buildMenuItem(
                          Icons.history,
                          'Order History',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
                          ),
                        ),
                        _buildMenuItem(
                          Icons.favorite_outline,
                          'Favorite Laundries',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const FavoriteLaundriesScreen()),
                          ),
                        ),
                      ])
                      .animate()
                      .fadeIn(delay: 200.ms)
                      .slideX(begin: -0.1, end: 0),

                  const SizedBox(height: 16),

                  // Settings section
                  _buildSection('Settings', [
                        _buildMenuItem(
                          Icons.notifications_outlined,
                          'Notifications',
                          trailing: Switch(
                            value: _notificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _notificationsEnabled = value;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _notificationsEnabled
                                        ? 'Notifications enabled'
                                        : 'Notifications disabled',
                                  ),
                                  backgroundColor: AppTheme.primaryColor,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ),
                        Consumer<LanguageProvider>(
                          builder: (context, languageProvider, _) {
                            return _buildMenuItem(
                              Icons.language,
                              'Language',
                              subtitle: languageProvider.currentLanguage,
                              onTap: () => _showLanguageSelector(languageProvider),
                            );
                          },
                        ),
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, _) {
                            return _buildMenuItem(
                              Icons.dark_mode_outlined,
                              'Dark Mode',
                              trailing: Switch(
                                value: themeProvider.isDarkMode,
                                onChanged: (value) {
                                  themeProvider.setDarkMode(value);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        value
                                            ? 'Dark mode enabled'
                                            : 'Light mode enabled',
                                      ),
                                      backgroundColor: AppTheme.primaryColor,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                activeColor: AppTheme.primaryColor,
                              ),
                            );
                          },
                        ),
                      ])
                      .animate()
                      .fadeIn(delay: 300.ms)
                      .slideX(begin: -0.1, end: 0),

                  const SizedBox(height: 16),

                  // Support section
                  _buildSection('Support', [
                        _buildMenuItem(
                          Icons.help_outline,
                          'Help & FAQ',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const HelpFaqScreen()),
                          ),
                        ),
                        _buildMenuItem(
                          Icons.chat_bubble_outline,
                          'Contact Us',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                          ),
                        ),
                        _buildMenuItem(
                          Icons.info_outline,
                          'About',
                          onTap: () => _showAboutDialog(context),
                        ),
                        _buildMenuItem(
                          Icons.privacy_tip_outlined,
                          'Privacy Policy',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                          ),
                        ),
                        _buildMenuItem(
                          Icons.description_outlined,
                          'Terms of Service',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const TermsOfServiceScreen()),
                          ),
                        ),
                      ])
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slideX(begin: -0.1, end: 0),

                  const SizedBox(height: 24),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showLogoutDialog(context, authProvider),
                      icon: const Icon(
                        Icons.logout,
                        color: AppTheme.errorColor,
                      ),
                      label: const Text(
                        'Logout',
                        style: TextStyle(color: AppTheme.errorColor),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppTheme.errorColor),
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms),

                  const SizedBox(height: 24),

                  // App version
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector(LanguageProvider languageProvider) {
    final languages = languageProvider.availableLanguages;
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Language',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...languages.map((language) {
                      final isSelected = languageProvider.currentLanguage == language;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: () async {
                            await languageProvider.setLanguage(language);
                            if (mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Language changed to $language'),
                                  backgroundColor: AppTheme.primaryColor,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryColor.withOpacity(0.1)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  language,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppTheme.primaryColor,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppTheme.primaryColor, size: 20),
      ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
            )
          : null,
      trailing:
          trailing ??
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppTheme.textSecondary,
          ),
      onTap: onTap,
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_laundry_service,
                color: AppTheme.primaryColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Laundry Service'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your trusted laundry partner. We provide high-quality laundry and dry cleaning services with convenient pickup and delivery.',
            ),
            SizedBox(height: 16),
            Text(
              'Version 1.0.0',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, SupabaseAuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

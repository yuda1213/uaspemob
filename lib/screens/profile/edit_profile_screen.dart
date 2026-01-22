import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/supabase_auth_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<SupabaseAuthProvider>();
    _nameController = TextEditingController(text: authProvider.userName ?? '');
    _emailController = TextEditingController(text: authProvider.userEmail ?? '');
    _phoneController = TextEditingController(text: '+1 (555) 123-4567');
    _addressController = TextEditingController(text: '123 Main Street, New York, NY 10001');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
            // Profile picture section
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primaryColor,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppTheme.primaryColor,
                  size: 40,
                ),
              ),
            ).animate().fadeIn(delay: 100.ms).scale(),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Tap to change photo',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Form fields
            _buildTextField(
              label: 'Full Name',
              controller: _nameController,
              icon: Icons.person,
            ).animate().fadeIn(delay: 150.ms).slideX(begin: -0.2, end: 0),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2, end: 0),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Phone Number',
              controller: _phoneController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ).animate().fadeIn(delay: 250.ms).slideX(begin: -0.2, end: 0),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Address',
              controller: _addressController,
              icon: Icons.location_on_outlined,
              maxLines: 3,
            ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2, end: 0),
            const SizedBox(height: 32),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Changes'),
              ),
            ).animate().fadeIn(delay: 350.ms).scale(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: AppTheme.successColor,
      ),
    );
    Navigator.pop(context);
  }
}

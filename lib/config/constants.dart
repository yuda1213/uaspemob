class AppConstants {
  // API Base URL - Using JSONPlaceholder as mock API base
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  
  // Mock API URLs for laundry data
  static const String mockApiUrl = 'https://api.npoint.io';
  
  // App Info
  static const String appName = 'Laundry Service';
  static const String appVersion = '1.0.0';
  
  // Shared Preferences Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyUserName = 'user_name';
  static const String keyOnboardingComplete = 'onboarding_complete';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  
  // Padding & Margins
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
}

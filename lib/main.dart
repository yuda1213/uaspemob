 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/constants.dart';
import 'providers/auth_provider.dart';
import 'providers/supabase_auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/laundry_provider.dart';
import 'providers/supabase_laundry_provider.dart';
import 'providers/supabase_order_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';
import 'screens/auth/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  bool isOnboardingComplete = false;
  bool isLoggedIn = false;
  
  try {
    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://tkhvhlafdaccagodxqie.supabase.co',
      anonKey: 'sb_publishable_VUjBYs2PtryjSlS_AbZr9Q_sTNAMFVK',
    );
    print('Supabase initialized successfully');
  } catch (e) {
    print('Supabase initialization error: $e');
  }
  
  try {
    // Check onboarding and login status
    final prefs = await SharedPreferences.getInstance();
    isOnboardingComplete = prefs.getBool(AppConstants.keyOnboardingComplete) ?? false;
    isLoggedIn = prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
    print('SharedPreferences loaded: onboarding=$isOnboardingComplete, loggedIn=$isLoggedIn');
  } catch (e) {
    print('SharedPreferences error: $e');
  }
  
  runApp(MyApp(
    isOnboardingComplete: isOnboardingComplete,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isOnboardingComplete;
  final bool isLoggedIn;
  
  const MyApp({
    super.key,
    required this.isOnboardingComplete,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Supabase Providers
        ChangeNotifierProvider(create: (_) => SupabaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => SupabaseLaundryProvider()),
        ChangeNotifierProvider(create: (_) => SupabaseOrderProvider()),
        
        // Legacy Providers (untuk backward compatibility)
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LaundryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Laundry Service',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData,
            home: _getInitialScreen(),
          );
        },
      ),
    );
  }
  
  Widget _getInitialScreen() {
    if (!isOnboardingComplete) {
      return const OnboardingScreen();
    } else if (!isLoggedIn) {
      return const LoginScreen();
    } else {
      return const MainScreen();
    }
  }
}


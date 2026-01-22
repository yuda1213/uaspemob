import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';

/// Legacy Auth Provider - use SupabaseAuthProvider for new implementations
class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _userId;
  String? _userEmail;
  String? _userName;
  String? _error;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get error => _error;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
    if (_isLoggedIn) {
      _userId = prefs.getString(AppConstants.keyUserId);
      _userEmail = prefs.getString(AppConstants.keyUserEmail);
      _userName = prefs.getString(AppConstants.keyUserName);
    }
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    // Legacy method - use SupabaseAuthProvider instead
    _error = 'Please use SupabaseAuthProvider';
    notifyListeners();
    return false;
  }

  Future<bool> register(String email, String password, String name) async {
    // Legacy method - use SupabaseAuthProvider instead
    _error = 'Please use SupabaseAuthProvider';
    notifyListeners();
    return false;
  }

  Future<bool> sendPasswordReset(String email) async {
    // Legacy method - use SupabaseAuthProvider instead
    _error = 'Please use SupabaseAuthProvider';
    notifyListeners();
    return false;
  }

  Future<void> signOut() async {
    _isLoggedIn = false;
    _userId = null;
    _userEmail = null;
    _userName = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

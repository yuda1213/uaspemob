import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';
import '../services/supabase_service.dart';

class SupabaseAuthProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _userId;
  String? _userEmail;
  String? _userName;
  String? _error;
  dynamic _currentUser;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get error => _error;
  dynamic get currentUser => _currentUser;

  SupabaseAuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final user = await _supabaseService.getCurrentUser();
    _currentUser = user;
    if (user != null) {
      _isLoggedIn = true;
      _userId = user['id'] as String?;
      _userEmail = user['email'] as String?;
      _userName = user['name'] as String? ?? _userEmail?.split('@').first;
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final userMap = await _supabaseService.registerUser(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );

      if (userMap != null) {
        _isLoggedIn = true;
        _userId = userMap['id'] as String?;
        _userEmail = email;
        _userName = name;
        _currentUser = userMap;

        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(AppConstants.keyIsLoggedIn, true);
        if (_userId != null) await prefs.setString(AppConstants.keyUserId, _userId!);
        await prefs.setString(AppConstants.keyUserEmail, email);
        await prefs.setString(AppConstants.keyUserName, name);

        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final userMap = await _supabaseService.loginUser(
        email: email,
        password: password,
      );

      if (userMap != null) {
        _isLoggedIn = true;
        _userId = userMap['id'] as String?;
        _userEmail = email;
        _currentUser = userMap;

        // Get user data from DB
        final userData = await _supabaseService.getUserData(_userId!);
        _userName = userData?['name'] ?? email.split('@').first;

        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(AppConstants.keyIsLoggedIn, true);
        if (_userId != null) await prefs.setString(AppConstants.keyUserId, _userId!);
        await prefs.setString(AppConstants.keyUserEmail, email);
        if (_userName != null) await prefs.setString(AppConstants.keyUserName, _userName!);

        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _supabaseService.resetPassword(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _supabaseService.logoutUser();
      _isLoggedIn = false;
      _userId = null;
      _userEmail = null;
      _userName = null;
      _currentUser = null;

      // Clear local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.keyIsLoggedIn, false);

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Email sudah terdaftar';
      case 'weak-password':
        return 'Password terlalu lemah';
      case 'user-not-found':
        return 'Email tidak ditemukan';
      case 'wrong-password':
        return 'Password salah';
      case 'invalid-email':
        return 'Format email tidak valid';
      default:
        return 'Terjadi kesalahan: $code';
    }
  }
}

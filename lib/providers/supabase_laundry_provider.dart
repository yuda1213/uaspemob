import 'package:flutter/material.dart';
import '../models/laundry_model.dart';
import '../models/service_model.dart';
import '../models/offer_model.dart';
import '../services/supabase_service.dart';

class SupabaseLaundryProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  List<Laundry> _laundries = [];
  List<Laundry> _filteredLaundries = [];
  List<ServiceItem> _services = [];
  List<Map<String, dynamic>> _offers = [];
  Laundry? _selectedLaundry;
  List<String> _userFavorites = [];

  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<Laundry> get laundries =>
      _filteredLaundries.isEmpty && _searchQuery.isEmpty
          ? _laundries
          : _filteredLaundries;
  List<ServiceItem> get services => _services;
  List<Map<String, dynamic>> get offers => _offers;
  Laundry? get selectedLaundry => _selectedLaundry;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  List<String> get userFavorites => _userFavorites;

  List<Laundry> get popularLaundries =>
      _laundries.where((l) => l.rating >= 4.3).take(4).toList();

  List<Laundry> get nearbyLaundries =>
      _laundries.where((l) => l.isOpen).take(5).toList();

  Future<void> fetchLaundries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final laundryData = await _supabaseService.getLaundries();
      _laundries = laundryData
          .map((data) {
            data['id'] = data['id'] ?? '';
            data['reviewCount'] = data['reviewCount'] ?? 0;
            return Laundry.fromJson(data);
          })
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchServices(String laundryId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final servicesData = await _supabaseService.getServices(laundryId);
      _services = servicesData
          .map((data) {
            data['id'] = data['id'] ?? '';
            return ServiceItem.fromJson(data);
          })
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOffers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _offers = await _supabaseService.getActiveOffers();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectLaundry(String laundryId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final laundryData = await _supabaseService.getLaundryDetail(laundryId);
      if (laundryData != null) {
        laundryData['id'] = laundryId;
        _selectedLaundry = Laundry.fromJson(laundryData);
        await fetchServices(laundryId);
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchLaundries(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredLaundries = [];
    } else {
      _filteredLaundries = _laundries
          .where((laundry) =>
              laundry.name.toLowerCase().contains(query.toLowerCase()) ||
              laundry.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> addFavorite(String userId, String laundryId) async {
    try {
      await _supabaseService.addFavorite(userId: userId, laundryId: laundryId);
      if (!_userFavorites.contains(laundryId)) {
        _userFavorites.add(laundryId);
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String userId, String laundryId) async {
    try {
      await _supabaseService.removeFavorite(
        userId: userId,
        laundryId: laundryId,
      );
      _userFavorites.remove(laundryId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadUserFavorites(String userId) async {
    try {
      _userFavorites = await _supabaseService.getUserFavorites(userId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  bool isFavorite(String laundryId) {
    return _userFavorites.contains(laundryId);
  }

  Future<void> addReview({
    required String laundryId,
    required String userId,
    required String userName,
    required int rating,
    required String review,
  }) async {
    try {
      await _supabaseService.addReview(
        laundryId: laundryId,
        userId: userId,
        userName: userName,
        rating: rating,
        review: review,
      );
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}

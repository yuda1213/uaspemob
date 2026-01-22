import 'package:flutter/material.dart';
import '../models/laundry_model.dart';
import '../models/service_model.dart';
import '../models/offer_model.dart';
import '../services/api_service.dart';

class LaundryProvider extends ChangeNotifier {
  List<Laundry> _laundries = [];
  List<Laundry> _filteredLaundries = [];
  List<ServiceCategory> _serviceCategories = [];
  List<Offer> _offers = [];
  Laundry? _selectedLaundry;
  
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<Laundry> get laundries => _filteredLaundries.isEmpty && _searchQuery.isEmpty 
      ? _laundries 
      : _filteredLaundries;
  List<ServiceCategory> get serviceCategories => _serviceCategories;
  List<Offer> get offers => _offers;
  Laundry? get selectedLaundry => _selectedLaundry;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  List<Laundry> get popularLaundries => 
      _laundries.where((l) => l.rating >= 4.3).take(4).toList();

  List<Laundry> get nearbyLaundries => 
      _laundries.where((l) => l.isOpen).take(5).toList();

  Future<void> fetchLaundries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _laundries = await ApiService.fetchLaundries();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchServices() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _serviceCategories = await ApiService.fetchServices();
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
      _offers = await ApiService.fetchOffers();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAll() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        ApiService.fetchLaundries(),
        ApiService.fetchServices(),
        ApiService.fetchOffers(),
      ]);
      
      _laundries = results[0] as List<Laundry>;
      _serviceCategories = results[1] as List<ServiceCategory>;
      _offers = results[2] as List<Offer>;
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedLaundry(Laundry laundry) {
    _selectedLaundry = laundry;
    notifyListeners();
  }

  void searchLaundries(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredLaundries = [];
    } else {
      _filteredLaundries = _laundries.where((l) =>
        l.name.toLowerCase().contains(query.toLowerCase()) ||
        l.address.toLowerCase().contains(query.toLowerCase()) ||
        l.services.any((s) => s.toLowerCase().contains(query.toLowerCase()))
      ).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredLaundries = [];
    notifyListeners();
  }

  Laundry? getLaundryById(String id) {
    try {
      return _laundries.firstWhere((l) => l.id == id);
    } catch (e) {
      return null;
    }
  }
}

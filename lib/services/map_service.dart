import 'package:url_launcher/url_launcher.dart';

class MapService {
  /// Opens Google Maps directions to the specified coordinates
  static Future<bool> openDirections({
    required double latitude,
    required double longitude,
    String? destinationName,
  }) async {
    // Try Google Maps first
    final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving',
    );

    // Alternative: Open location in Google Maps
    final googleMapsSearchUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    try {
      // Try to launch Google Maps directions
      if (await canLaunchUrl(googleMapsUrl)) {
        return await launchUrl(
          googleMapsUrl,
          mode: LaunchMode.externalApplication,
        );
      }
      
      // Fallback to search URL
      if (await canLaunchUrl(googleMapsSearchUrl)) {
        return await launchUrl(
          googleMapsSearchUrl,
          mode: LaunchMode.externalApplication,
        );
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Opens Google Maps showing the location
  static Future<bool> openLocation({
    required double latitude,
    required double longitude,
    String? placeName,
  }) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    try {
      if (await canLaunchUrl(url)) {
        return await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Opens phone dialer with the specified number
  static Future<bool> makePhoneCall(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    
    try {
      if (await canLaunchUrl(url)) {
        return await launchUrl(url);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Opens sharing functionality
  static Future<bool> shareLocation({
    required double latitude,
    required double longitude,
    required String name,
    required String address,
  }) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    try {
      if (await canLaunchUrl(url)) {
        return await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

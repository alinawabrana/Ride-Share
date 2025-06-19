import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return Future.error('Location permissions are permanently denied.');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Future<String> getAddressFromPosition(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final Placemark place = placemarks.first;

      return '''
Street: ${place.street}
SubLocality: ${place.subLocality}
Locality (City): ${place.locality}
Postal Code: ${place.postalCode}
State: ${place.administrativeArea}
Country: ${place.country}
''';
    } else {
      return 'No address available';
    }
  }

  void locateUser() async {
    try {
      Position position = await getCurrentLocation();
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    } catch (e) {
      print("Error: $e");
    }
  }

  void getUserLocationDetails() async {
    try {
      Position position = await getCurrentLocation();
      String address = await getAddressFromPosition(position);
      print('Current Location:\n$address');
    } catch (e) {
      print('Error: $e');
    }
  }
}

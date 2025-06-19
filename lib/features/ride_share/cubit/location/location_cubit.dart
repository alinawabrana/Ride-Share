// location_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> fetchLocation() async {
    try {
      emit(LocationLoading());

      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationError('Location services are disabled.'));
        return;
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError('Location permissions are denied.'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          LocationError(
            'Location permissions are permanently denied. Please enable them from app settings.',
          ),
        );
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocode
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        emit(LocationError('Could not find address.'));
        return;
      }

      final place = placemarks.first;

      //       final fullAddress = '''
      // ${place.street}, ${place.subLocality}
      // ${place.locality}, ${place.administrativeArea}
      // ${place.postalCode}, ${place.country}
      // ''';
      print('place = $place');

      final fullAddress = place.street ?? 'Unknown street';

      emit(LocationSuccess(fullAddress, position.latitude, position.longitude));
    } catch (e) {
      emit(LocationError('Error fetching location: $e'));
    }
  }
}

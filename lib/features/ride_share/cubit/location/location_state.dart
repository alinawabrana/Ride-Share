part of 'location_cubit.dart';

sealed class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final String address;
  final double latitude;
  final double longitude;

  LocationSuccess(this.address, this.latitude, this.longitude);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}

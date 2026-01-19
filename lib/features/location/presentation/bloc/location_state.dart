import 'package:google_maps_flutter/google_maps_flutter.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationServiceDisabled extends LocationState {}

class LocationPermissionDenied extends LocationState {}

class LocationPermissionDeniedForever extends LocationState {}

class LocationReady extends LocationState {
  final double lat;
  final double lng;
  final Set<Marker> markers;

  LocationReady({required this.lat, required this.lng, this.markers = const {}});
}
class LocationError extends LocationState{
  final String error;
  LocationError({required this.error});
}

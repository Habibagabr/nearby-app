part of 'location_bloc.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationServiceDisabled extends LocationState {}

class LocationPermissionDenied extends LocationState {}

class LocationPermissionDeniedForever extends LocationState {}

class LocationReady extends LocationState {
  final double lat;
  final double lng;

  LocationReady({
    required this.lat,
    required this.lng,
  });
}

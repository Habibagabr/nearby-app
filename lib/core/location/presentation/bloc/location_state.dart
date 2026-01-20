import '../../domain/entities/user_location_entity.dart';

enum LocationStatus { initial, loading, tracking, permissionDenied, serviceDisabled, error }

class LocationState {
  final LocationStatus status;
  final UserLocationEntity? location;
  final String? errorMessage;

  LocationState({
    required this.status,
    this.location,
    this.errorMessage,
  });

  factory LocationState.initial() => LocationState(status: LocationStatus.initial);

  LocationState copyWith({
    LocationStatus? status,
    UserLocationEntity? location,
    String? errorMessage,
  }) {
    return LocationState(
      status: status ?? this.status,
      location: location ?? this.location,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

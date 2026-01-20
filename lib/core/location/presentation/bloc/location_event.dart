import '../../domain/entities/user_location_entity.dart';

abstract class LocationEvent {}

class RequestPermission extends LocationEvent {}

class StartTracking extends LocationEvent {}

class StopTracking extends LocationEvent {}

class UpdateLocation extends LocationEvent {
  final UserLocationEntity location;
  UpdateLocation(this.location);
}

class UpdateServiceStatus extends LocationEvent {
  final bool isEnabled;
  UpdateServiceStatus(this.isEnabled);
}

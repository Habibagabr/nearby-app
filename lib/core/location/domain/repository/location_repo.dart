import 'package:fpdart/fpdart.dart';
import '../entities/user_location_entity.dart';

abstract class LocationRepository {

  // Checks initial permission and requests if necessary
  Future<Either<String, bool>> permissionsHandling();

  // Gets current one-shot location
  Future<Either<String, UserLocationEntity>> getUserCurrentLocation();

  // Real-time location updates
  Stream<UserLocationEntity> watchUserLocation();

  // Real-time GPS Hardware status (Enabled/Disabled)
  Stream<bool> watchServiceStatus();

  Future<void> openLocationSettings();
}

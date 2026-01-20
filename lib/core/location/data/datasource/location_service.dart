import 'package:geolocator/geolocator.dart';
import '../../Location_permission_status.dart';

abstract class LocationService{
  Stream<Position> locationStream();
  Future<LocationPermissionStatus> handlePermissions();
  Future<Position> getCurrentLocation();
  Future<void> openAppSettings();
  Stream<ServiceStatus> serviceStatusStream();
}
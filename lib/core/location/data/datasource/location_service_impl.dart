import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../Location_permission_status.dart';
import 'location_service.dart';

@LazySingleton(as:LocationService)
class LocationServiceImpl implements LocationService {
  // Check if GPS is enabled and request permissions
  @override
  Future<LocationPermissionStatus> handlePermissions() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return LocationPermissionStatus.serviceDisabled;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // geolocator returns 'denied', 'deniedForever', 'whileInUse', or 'always'
      if (permission == LocationPermission.denied) {
        return LocationPermissionStatus.denied;
      }
      if (permission == LocationPermission.deniedForever) {
        return LocationPermissionStatus.deniedForever;
      }

      // If we reach here, it's either .whileInUse or .always
      return LocationPermissionStatus.granted;
    } catch (_) {
      return LocationPermissionStatus.serviceDisabled;
    }
  }

  // Continuous tracking with  background settings
  @override
  Stream<Position> locationStream() {
    LocationSettings settings;
    if (defaultTargetPlatform == TargetPlatform.android) {
      settings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationTitle: "NearBuy GPS",
          notificationText: "Checking for nearby deals...",
          enableWakeLock: true,
        ),
      );
    } else {
      settings = AppleSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
        showBackgroundLocationIndicator: true,
      );
    }
    return Geolocator.getPositionStream(locationSettings: settings);
  }

  // Listen to GPS Hardware Toggle (On/Off)
  // if user turn off the location from the screen inside the application
  @override
  Stream<ServiceStatus> serviceStatusStream() =>
      Geolocator.getServiceStatusStream();


  @override
  Future<Position> getCurrentLocation() async =>
      await Geolocator.getCurrentPosition();

  @override
  Future<void> openAppSettings() async => await Geolocator.openAppSettings();
}

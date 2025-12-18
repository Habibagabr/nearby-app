import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'location_permission_status.dart';


class LocationService {
  /// Check if GPS is enabled and request permissions
  static Future<LocationPermissionStatus> handlePermission() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return LocationPermissionStatus.serviceDisabled;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) return LocationPermissionStatus.denied;
      if (permission == LocationPermission.deniedForever) return LocationPermissionStatus.deniedForever;

      return LocationPermissionStatus.granted;
    } catch (_) {
      return LocationPermissionStatus.serviceDisabled;
    }
  }

  /// Listen to GPS Hardware Toggle (On/Off)
  static Stream<ServiceStatus> get serviceStatusStream => Geolocator.getServiceStatusStream();

  /// Continuous tracking with  background settings
  static Stream<Position> locationStream() {
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

  static Future<Position> getCurrentLocation() async => await Geolocator.getCurrentPosition();

  static Future<void> openAppSettings() async => await Geolocator.openAppSettings();
}

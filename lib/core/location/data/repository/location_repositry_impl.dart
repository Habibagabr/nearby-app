import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/widgets.dart'; // Required for WidgetsBinding

import 'data/datasource/location_service.dart';
import 'domain/entities/user_location_entity.dart';
import 'domain/repository/location_repo.dart';
import 'data/models/user_location.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends WidgetsBindingObserver implements LocationRepository {
  final LocationService locationService;

  // Controller to handle manual permission re-checks
  final StreamController<bool> _permissionStreamController = StreamController<bool>.broadcast();

  LocationRepositoryImpl(this.locationService) {
    // Register as observer to detect when user returns from settings
    WidgetsBinding.instance.addObserver(this);
    _checkInitialPermission();
  }

  // Detect app lifecycle changes to refresh permission status
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkInitialPermission();
    }
  }

  Future<void> _checkInitialPermission() async {
    final status = await Geolocator.checkPermission();
    final isGranted = status == LocationPermission.always || status == LocationPermission.whileInUse;
    _permissionStreamController.add(isGranted);
  }

  @override
  Stream<bool> watchPermissionStatus() => _permissionStreamController.stream;

  @override
  Stream<bool> watchServiceStatus() {
    return Geolocator.getServiceStatusStream().map(
          (status) => status == ServiceStatus.enabled,
    );
  }

  @override
  Future<Either<String, bool>> permissionsHandling() async {
    final status = await Geolocator.requestPermission();
    if (status == LocationPermission.always || status == LocationPermission.whileInUse) {
      _permissionStreamController.add(true);
      return const Right(true);
    }
    _permissionStreamController.add(false);
    return const Left("Location permission denied");
  }

  @override
  Future<Either<String, UserLocationEntity>> getUserCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return Right(UserLocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      ).toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<UserLocationEntity> watchUserLocation() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters to save battery
      ),
    ).map((position) => UserLocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
    ).toEntity());
  }

  @override
  Future<void> openLocationSettings() async {
    await Geolocator.openAppSettings();
  }

  // Cleanup
  @disposeMethod
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _permissionStreamController.close();
  }
}

import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import '../datasource/location_service.dart';
import '../../domain/entities/user_location_entity.dart';
import '../../domain/repository/location_repo.dart';
import '../../Location_permission_status.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationService locationService;

  LocationRepositoryImpl(this.locationService);

  @override
  Stream<bool> watchServiceStatus() {
    return locationService.serviceStatusStream().map(
          (status) => status == ServiceStatus.enabled,
    );
  }

  @override
  Future<Either<String, bool>> permissionsHandling() async {
    final status = await locationService.handlePermissions();
    if (status == LocationPermissionStatus.granted) {
      return const Right(true);
    }
    return Left(status.toString());
  }

  @override
  Future<Either<String, UserLocationEntity>> getUserCurrentLocation() async {
    try {
      final position = await locationService.getCurrentLocation();
      return Right(_mapToEntity(position));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<UserLocationEntity> watchUserLocation() {
    return locationService.locationStream().map(_mapToEntity);
  }

  // Helper method to remove mapping redundancy
  UserLocationEntity _mapToEntity(Position pos) => UserLocationEntity(
    latitude: pos.latitude,
    longitude: pos.longitude,
  );

  @override
  Future<void> openLocationSettings() => locationService.openAppSettings();

}

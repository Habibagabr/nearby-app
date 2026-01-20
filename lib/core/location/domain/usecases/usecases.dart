// import 'package:fpdart/fpdart.dart';
// import 'package:injectable/injectable.dart';
// import 'package:geolocator/geolocator.dart';
// import '../repository/location_repo.dart';
// import '../entities/user_location_entity.dart';
// import '../../Location_permission_status.dart';
//
// @lazySingleton
// class InitializeLocation {
//   final LocationRepository repository;
//   InitializeLocation(this.repository);
//
//   Future<Either<LocationPermissionStatus, bool>> call() async {
//     final serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return const Left(LocationPermissionStatus.serviceDisabled);
//
//     // permissionsHandling returns Either<String, bool>, we map Left to Status
//     final result = await repository.permissionsHandling();
//     return result.fold(
//           (error) => const Left(LocationPermissionStatus.denied),
//           (granted) => Right(granted),
//     );
//   }
// }
//
// @lazySingleton
// class WatchUserLocation {
//   final LocationRepository repository;
//   WatchUserLocation(this.repository);
//
//   Stream<UserLocationEntity> call() => repository.watchUserLocation();
// }
//
// @lazySingleton
// class WatchServiceStatus {
//   final LocationRepository repository;
//   WatchServiceStatus(this.repository);
//
//   Stream<bool> call() => repository.watchServiceStatus();
// }
//
// @lazySingleton
// class OpenLocationSettings {
//   final LocationRepository repository;
//   OpenLocationSettings(this.repository);
//
//   Future<void> call() => repository.openLocationSettings();
// }

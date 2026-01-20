import 'package:injectable/injectable.dart';
import '../entities/user_location_entity.dart';
import '../repository/location_repo.dart';


@lazySingleton
class WatchUserLocation {
  final LocationRepository repository;
  WatchUserLocation(this.repository);

  Stream<UserLocationEntity> call() {
    return repository.watchUserLocation();
  }
}

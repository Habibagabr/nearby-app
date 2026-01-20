import 'package:injectable/injectable.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/user_location_entity.dart';
import '../repository/location_repo.dart';

@lazySingleton
class GetCurrentLocation {
  final LocationRepository repository;
  GetCurrentLocation(this.repository);

  Future<Either<String, UserLocationEntity>> call() async {
    return await repository.getUserCurrentLocation();
  }
}

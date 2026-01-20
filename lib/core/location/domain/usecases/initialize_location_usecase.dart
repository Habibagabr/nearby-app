import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../repository/location_repo.dart';

@lazySingleton
class InitializeLocation {
  final LocationRepository repository;
  InitializeLocation(this.repository);

  Future<Either<String, bool>> call() async {
    return await repository.permissionsHandling();
  }
}

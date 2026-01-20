import 'package:injectable/injectable.dart';

import '../repository/location_repo.dart';

@lazySingleton
class WatchGpsStatus {
  final LocationRepository repository;
  WatchGpsStatus(this.repository);

  Stream<bool> call() {
    return repository.watchServiceStatus();
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/homeScreen/domain/repository/home_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/nearby_places_entity.dart';

@Injectable()
class GetPlacesInBoundsUseCase {
  final HomeRepository repository;

  GetPlacesInBoundsUseCase(this.repository);

  Future<Either<Failure, List<NearbyPlaceEntity>>> call({
    required double west,
    required double north,
    required double east,
    required double south,
  }) {
    return repository.getPlacesInBounds(
      west: west,
      north: north,
      east: east,
      south: south,
    );
  }
}

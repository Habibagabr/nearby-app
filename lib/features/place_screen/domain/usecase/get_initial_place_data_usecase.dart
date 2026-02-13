import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/placeEntity/place_category_entity.dart';
import '../repository/place_repository.dart';

@LazySingleton()
class LoadPlaceScreenUseCase {
  final PlaceRepository repository;

  LoadPlaceScreenUseCase(this.repository);

  Future<Either<String, PlaceCategoryEntity>> call(String placeId) {
    return repository.loadInitialPlaceData(placeId);
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';
import '../entities/placeEntity/place_category_entity.dart';
import '../repository/place_repository.dart';

@LazySingleton()
class LoadPlaceScreenUseCase {
  final PlaceRepository repository;

  LoadPlaceScreenUseCase(this.repository);

  Future<Either<AppFailure, PlaceCategoryEntity>> call(String placeId) {
    return repository.loadInitialPlaceData(placeId);
  }
}

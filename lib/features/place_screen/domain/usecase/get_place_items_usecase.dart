import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../entities/placeEntity/paginated_item_entity.dart';
import '../repository/place_repository.dart';

@LazySingleton()
class LoadPlaceItemsUseCase {
  final PlaceRepository repository;

  LoadPlaceItemsUseCase(this.repository);

  Future<Either<String, ItemsPaginatedEntity>> call({
    required String placeId,
    required int page,
    required int limit,
    String? categoryId,
  }) {
    return repository.loadMoreItems(
      placeId: placeId,
      page: page,
      limit: limit,
      categoryId: categoryId,
    );
  }
}

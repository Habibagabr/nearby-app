import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';

import '../entities/placeEntity/paginated_item_entity.dart';
import '../entities/placeEntity/place_category_entity.dart';

abstract class PlaceRepository {
  Future<Either<AppFailure, PlaceCategoryEntity>> loadInitialPlaceData(
      String placeId,
      );

  Future<Either<AppFailure, ItemsPaginatedEntity>> loadMoreItems({
    required String placeId,
    required int page,
    required int limit,
    String? categoryId,
  });

}

import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_buy_gp/features/searchScreen/data/models/autocomplete_response_model.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/auto_complete_entity.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/search_response_entity.dart';

import '../../../../core/error/app_failure.dart';

abstract class SearchRepository {
  Future<Either<AppFailure, List<SearchResponseEntity>>> getSearchResult({
    required query,
    required double userLat,
    required double userLng,
    double? minimumPrice,
    double? maxPrice,
    int? minimumRate,
    bool? isOpenNow
  });

  Future<Either<AppFailure, List<AutoCompleteResponseEntity>>> getAutoCompleteResult({required query});
}

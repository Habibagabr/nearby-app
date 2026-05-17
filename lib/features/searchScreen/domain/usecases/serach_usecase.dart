import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/search_response_entity.dart';
import 'package:near_buy_gp/features/searchScreen/domain/repository/search_repository.dart';

@LazySingleton()
class SearchUseCase {
  final SearchRepository searchRepository;

  SearchUseCase(this.searchRepository);

  Future<Either<AppFailure, List<SearchResponseEntity>>> call({
    required query,
    required double userLat,
    required double userLng,
    required double minimumPrice,
    required double maxPrice,
    int? minimumRate,
    bool? isOpenNow
  }) async {
    if(kDebugMode){
      print("PRINT: SEARCH USE CASE -> minimum rate is : $minimumRate");
    }
    return await searchRepository.getSearchResult(
      query: query,
      userLat: userLat,
      userLng: userLng,
      minimumPrice: minimumPrice,
      maxPrice: maxPrice,
      minimumRate: minimumRate,
      isOpenNow: isOpenNow
    );
  }
}

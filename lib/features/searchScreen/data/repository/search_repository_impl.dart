import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';
import 'package:near_buy_gp/core/error/exceptions_to_failure_handler.dart';
import 'package:near_buy_gp/features/searchScreen/data/datasource/search_remote_service.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/auto_complete_entity.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/search_response_entity.dart';
import 'package:near_buy_gp/features/searchScreen/domain/repository/search_repository.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteService searchRemoteService;

  SearchRepositoryImpl(this.searchRemoteService);

  @override
  Future<Either<AppFailure, List<SearchResponseEntity>>> getSearchResult({
    required query,
    required double userLat,
    required double userLng,
    double? minimumPrice,
    double? maxPrice,
    int? minimumRate,
    bool? isOpenNow,
  }) async {
    try {
      final result = await searchRemoteService.getSearchResponse(
        searchQuery: query,
        userLat: userLat,
        userLng: userLng,
        miniPrice: minimumPrice,
        maxPrice: maxPrice,
        miniRate: minimumRate,
        isOpenNow: isOpenNow,
      );
      return Right(result.map((result) => result.toEntity(result)).toList());
    } catch (e) {
      return Left(ExceptionsToFailureHandler.handler(e));
    }
  }

  @override
  Future<Either<AppFailure, List<AutoCompleteResponseEntity>>>
  getAutoCompleteResult({required query}) async {
    try {
      final result = await searchRemoteService.getAutoCompleteResponse(
        searchQuery: query,
      );
      return Right(
        result.map((response) => response.toEntity(response)).toList(),
      );
    } catch (e) {
      return Left(ExceptionsToFailureHandler.handler(e));
    }
  }
}

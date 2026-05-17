import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/searchScreen/data/datasource/search_remote_service.dart';
import 'package:near_buy_gp/features/searchScreen/data/models/autocomplete_response_model.dart';
import 'package:near_buy_gp/features/searchScreen/data/models/search_response_model.dart';

@LazySingleton(as: SearchRemoteService)
class SearchRemoteServiceImpl implements SearchRemoteService {
  final Dio dio;

  SearchRemoteServiceImpl(this.dio);

  @override
  Future<List<SearchResponseModel>> getSearchResponse({
    required String searchQuery,
    required double userLat,
    required double userLng,
    required double maxPrice,
    required double miniPrice,
    int? miniRate,
    bool? isOpenNow,
  }) async {
    final location = [userLat, userLng];
    final response = await dio.post(
      "/api/search",
      data: {
        "query": searchQuery,
        "userLocation": location,
         "priceMin": miniPrice,
         "priceMax": maxPrice,
        if (miniRate != null) "ratingMin": miniRate,
        if (isOpenNow != null) "openNow": isOpenNow,
      },
    );

    final List results = response.data;
    final searchModels = results
        .map((e) => SearchResponseModel.fromJson(e))
        .toList();

    return searchModels;
  }

  @override
  Future<List<AutocompleteResponseModel>> getAutoCompleteResponse({
    required String searchQuery,
  }) async {
    final response = await dio.get(
      "/api/search/autocomplete",
      queryParameters: {'q': searchQuery, 'limit': 10},
    );
    final List suggestionsList = response.data['suggestions'];

    return suggestionsList.map((item) {
      return AutocompleteResponseModel.fromJson(item);
    }).toList();
  }
}

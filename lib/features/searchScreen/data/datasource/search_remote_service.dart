import 'package:near_buy_gp/features/searchScreen/data/models/autocomplete_response_model.dart';
import 'package:near_buy_gp/features/searchScreen/data/models/search_response_model.dart';

abstract class SearchRemoteService {
  Future<List<SearchResponseModel>> getSearchResponse({
    required String searchQuery,
    required double userLat,
    required double userLng,
    required double maxPrice,
    required double miniPrice,
    int? miniRate,
    bool? isOpenNow,
  });

  Future<List<AutocompleteResponseModel>> getAutoCompleteResponse({
    required String searchQuery,
  });
}

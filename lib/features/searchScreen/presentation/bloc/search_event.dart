part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchEmpty extends SearchEvent {}

class AutoCompleteTriggered extends SearchEvent {
  final String? query;

  AutoCompleteTriggered({this.query});
}

class SearchTriggered extends SearchEvent {
  final String? searchQuery;
  final double? userLat;
  final double? userLng;
  final double? miniPrice;
  final double? maxPrice;
  final int? miniRate;
  final bool? isOpenedNow;

  SearchTriggered({
    this.searchQuery,
    this.userLat,
    this.userLng,
    this.maxPrice,
    this.miniRate,
    this.miniPrice,
    this.isOpenedNow,
  });
}

class AutoCompleteSuggestionPressed extends SearchEvent {
  final String query;
  final double? userLat;
  final double? userLng;
  final int? miniPrice;
  final double? maxPrice;
  final double? miniRate;

  AutoCompleteSuggestionPressed({
    required this.query,
    required this.userLat,
    required this.userLng,
    this.maxPrice,
    this.miniRate,
    this.miniPrice,
  });
}

class FilterValuePressed extends SearchEvent {
  final String? query;
  final double? userLat;
  final double? userLng;
  final int? minimumRate;
  final bool? isOpenedNow;

  FilterValuePressed({
    this.minimumRate,
    this.query,
    this.isOpenedNow,
    this.userLng,
    this.userLat,
  });
}

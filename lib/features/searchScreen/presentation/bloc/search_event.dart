// ============================ search_event.dart ============================

part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchTriggered extends SearchEvent {
  final String? searchQuery;
  final double? userLat;
  final double? userLng;

  final int? miniRate;
  final bool? isOpenedNow;

  final double? miniPrice;
  final double? maxPrice;

  SearchTriggered({
    this.searchQuery,
    this.userLat,
    this.userLng,
    this.miniRate,
    this.isOpenedNow,
    this.miniPrice,
    this.maxPrice,
  });
}

final class AutoCompleteTriggered extends SearchEvent {
  final String? query;

  AutoCompleteTriggered({
    required this.query,
  });
}

final class AutoCompleteSuggestionPressed extends SearchEvent {
  final String query;
  final double? userLat;
  final double? userLng;

  AutoCompleteSuggestionPressed({
    required this.query,
    required this.userLat,
    required this.userLng,
  });
}

final class SearchEmpty extends SearchEvent {}



// FILTERS EXCEPT PRICE
final class FilterValuePressed extends SearchEvent {
  final int? minimumRate;
  final bool? isOpenedNow;

  final String? query;

  final double? userLat;
  final double? userLng;

  FilterValuePressed({
    this.minimumRate,
    this.isOpenedNow,
    this.query,
    this.userLat,
    this.userLng,
  });
}



// PRICE EVENT SEPARATED
final class PriceRangeChanged extends SearchEvent {
  final double minPrice;
  final double maxPrice;

  final double? userLat;
  final double? userLng;

   PriceRangeChanged({
    required this.minPrice,
    required this.maxPrice,
    required this.userLat,
    required this.userLng,
  });
}
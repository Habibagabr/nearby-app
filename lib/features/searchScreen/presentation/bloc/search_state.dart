// ============================ search_state.dart ============================

part of 'search_bloc.dart';

@immutable
class SearchState {
  final int? miniRate;
  final bool? isOpenNow;
  final String? query;

  final double miniPrice;
  final double maxPrice;

  const SearchState({
    this.miniRate,
    this.isOpenNow,
    this.query,
    required this.miniPrice,
    required this.maxPrice,
  });

  static const _sentinel = Object();

  SearchState copyWith({
    Object? miniRate = _sentinel,
    Object? isOpenNow = _sentinel,
    Object? query = _sentinel,
    double? miniPrice,
    double? maxPrice,
  }) {
    return SearchState(
      miniRate:
      miniRate == _sentinel
          ? this.miniRate
          : miniRate as int?,

      isOpenNow:
      isOpenNow == _sentinel
          ? this.isOpenNow
          : isOpenNow as bool?,

      query:
      query == _sentinel
          ? this.query
          : query as String?,

      miniPrice: miniPrice ?? this.miniPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
}

final class SearchInitial extends SearchState {
  const SearchInitial({
    super.miniRate,
    super.isOpenNow,
    super.query,
    required super.miniPrice,
    required super.maxPrice,
  });
}

final class SearchLoading extends SearchState {
  const SearchLoading({
    super.miniRate,
    super.isOpenNow,
    super.query,
    required super.miniPrice,
    required super.maxPrice,
  });
}

final class SearchSuccess extends SearchState {
  final List<SearchResponseEntity>? searchResults;
  final String? resultEmpty;

  const SearchSuccess({
    this.resultEmpty,
    this.searchResults,
    super.miniRate,
    super.isOpenNow,
    super.query,
    required super.miniPrice,
    required super.maxPrice,
  });
}

final class SearchFailed extends SearchState {
  final String errorMsg;
  final AppFailure appFailure;

  const SearchFailed({
    required this.errorMsg,
    required this.appFailure,
    super.miniRate,
    super.isOpenNow,
    super.query,
    required super.miniPrice,
    required super.maxPrice,
  });
}

final class SearchAutoCompleteSuccess extends SearchState {
  final List<AutoCompleteResponseEntity>? autoCompleteResponse;

  const SearchAutoCompleteSuccess({
    this.autoCompleteResponse,
    super.miniRate,
    super.isOpenNow,
    super.query,
    required super.miniPrice,
    required super.maxPrice,
  });
}

final class SearchAutoCompleteLoading extends SearchState {
  const SearchAutoCompleteLoading({
    super.miniRate,
    super.isOpenNow,
    super.query,
    required super.miniPrice,
    required super.maxPrice,
  });
}
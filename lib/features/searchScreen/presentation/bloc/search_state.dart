part of 'search_bloc.dart';

@immutable
class SearchState {
  final int? miniRate;
  final bool? isOpenNow;
  final String? query;

  const SearchState({this.miniRate, this.isOpenNow, this.query});

  SearchState copyWith({int? miniRate, bool? isOpenNow, String? query}) {
    return SearchState(
      miniRate: miniRate,
      isOpenNow: isOpenNow,
      query: query ?? this.query,
    );
  }
}

final class SearchInitial extends SearchState {
  const SearchInitial({super.miniRate, super.isOpenNow, super.query});
}

final class SearchLoading extends SearchState {
  const SearchLoading({super.miniRate, super.isOpenNow, super.query});
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
  });
}

final class SearchAutoCompleteSuccess extends SearchState {
  final List<AutoCompleteResponseEntity>? autoCompleteResponse;

  const SearchAutoCompleteSuccess({
    this.autoCompleteResponse,
    super.miniRate,
    super.isOpenNow,
    super.query,
  });
}

final class SearchAutoCompleteLoading extends SearchState {
  const SearchAutoCompleteLoading({
    super.miniRate,
    super.isOpenNow,
    super.query,
  });
}

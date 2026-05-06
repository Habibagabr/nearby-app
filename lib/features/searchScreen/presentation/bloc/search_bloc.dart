import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/auto_complete_entity.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/search_response_entity.dart';
import 'package:near_buy_gp/features/searchScreen/domain/usecases/auto_complete_usecase.dart';
import 'package:near_buy_gp/features/searchScreen/domain/usecases/serach_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';

part 'search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  // flat map = the function which will be executed when the debounceTime passed
}

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;
  final AutoCompleteUseCase _autoCompleteUseCase;

  SearchBloc(this._searchUseCase, this._autoCompleteUseCase)
    : super(const SearchInitial()) {
    on<AutoCompleteSuggestionPressed>(_handleAutoCompleteSuggestionPressed);
    on<SearchTriggered>(_handleSearchTriggered);
    on<AutoCompleteTriggered>(
      _handleAutoCompleteTriggered,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<SearchEmpty>(
      (event, emit) => emit(
        SearchInitial(miniRate: state.miniRate, isOpenNow: state.isOpenNow),
      ),
    );
    on<FilterValuePressed>(
      _handleSearchByFilters,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _handleSearchByFilters(
    FilterValuePressed event,
    Emitter<SearchState> emit,
  ) async {
    // 1. Update local state
    if (kDebugMode) {
      print(
        "PRINT: FILTER PRESSED IS : ${event.minimumRate} , isOpenedFilter : ${state.isOpenNow}",
      );
    }
    final newState = state.copyWith(
      miniRate: event.minimumRate,
      isOpenNow: event.isOpenedNow,
    );

    // 2. Emit so UI shows the filter change
    emit(newState);

    // 3. Trigger search with the NEW values
    add(
      SearchTriggered(
        searchQuery: newState.query,
        userLat: event.userLat,
        userLng: event.userLng,
        miniRate: newState.miniRate,
        isOpenedNow: newState.isOpenNow,
      ),
    );
  }

  Future<void> _handleAutoCompleteSuggestionPressed(
    AutoCompleteSuggestionPressed event,
    Emitter<SearchState> emit,
  ) async {
    final newState = state.copyWith(query: event.query);
    emit(newState); // Save the query first

    add(
      SearchTriggered(
        searchQuery: event.query,
        userLat: event.userLat,
        userLng: event.userLng,
        miniRate: state.miniRate,
        isOpenedNow: state.isOpenNow,
      ),
    );
  }

  Future<void> _handleAutoCompleteTriggered(
    AutoCompleteTriggered event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query == null || event.query!.isEmpty) {
      emit(SearchInitial(miniRate: state.miniRate, isOpenNow: state.isOpenNow));
      return;
    }

    // Pass filters to the Autocomplete Loading state so they don't vanish while typing
    emit(
      SearchAutoCompleteLoading(
        miniRate: state.miniRate,
        isOpenNow: state.isOpenNow,
        query: event.query,
      ),
    );

    final result = await _autoCompleteUseCase(query: event.query!);

    result.fold(
      (failure) => emit(
        SearchInitial(
          miniRate: state.miniRate,
          isOpenNow: state.isOpenNow,
          query: event.query,
        ),
      ),
      (suggestions) => emit(
        SearchAutoCompleteSuccess(
          autoCompleteResponse: suggestions,
          miniRate: state.miniRate,
          isOpenNow: state.isOpenNow,
          query: event.query,
        ),
      ),
    );
  }

  Future<void> _handleSearchTriggered(
    SearchTriggered event,
    Emitter<SearchState> emit,
  ) async {
    if (kDebugMode) {
      print(
        "PRINT: SEARCH -> miniRate = ${state.miniRate} , query = ${state.query} , isOpened : ${state.isOpenNow}",
      );
    }
    // Merge event data with existing state data to prevent null overwrites
    final updatedState = state.copyWith(
      query: event.searchQuery,
      miniRate: event.miniRate,
      isOpenNow: event.isOpenedNow,
    );

    emit(updatedState);

    if (event.searchQuery == null ||
        event.userLat == null ||
        event.userLng == null) {
      emit(
        SearchFailed(
          errorMsg: "Error occurred",
          appFailure: GeneralFailure(generalFailureMessage: 'Error occurred'),
          miniRate: updatedState.miniRate,
          isOpenNow: updatedState.isOpenNow,
          query: updatedState.query,
        ),
      );
      return;
    }

    emit(
      SearchLoading(
        miniRate: updatedState.miniRate,
        isOpenNow: updatedState.isOpenNow,
        query: updatedState.query,
      ),
    );

    final result = await _searchUseCase(
      query: updatedState.query!,
      userLat: event.userLat!,
      userLng: event.userLng!,
      minimumRate: updatedState.miniRate,
      isOpenNow: updatedState.isOpenNow,
    );

    result.fold(
      (failure) => emit(
        SearchFailed(
          errorMsg: failure.failureMessage,
          appFailure: failure,
          miniRate: updatedState.miniRate,
          isOpenNow: updatedState.isOpenNow,
          query: updatedState.query,
        ),
      ),
      (results) {
        if (results.isEmpty) {
          emit(
            SearchSuccess(
              searchResults: results,
              miniRate: updatedState.miniRate,
              isOpenNow: updatedState.isOpenNow,
              query: updatedState.query,
              resultEmpty: "There is no result for this query , Change the filters or your search query "
            ),
          );
        } else {
          emit(
            SearchSuccess(
              searchResults: results,
              miniRate: updatedState.miniRate,
              isOpenNow: updatedState.isOpenNow,
              query: updatedState.query,
            ),
          );
        }
      },
    );
  }
}

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
}

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;
  final AutoCompleteUseCase _autoCompleteUseCase;

  SearchBloc(this._searchUseCase, this._autoCompleteUseCase)
    : super(const SearchInitial(miniPrice: 0.0, maxPrice: 1000.0)) {
    // ================= AUTOCOMPLETE SUGGESTION =================

    on<AutoCompleteSuggestionPressed>(_handleAutoCompleteSuggestionPressed);

    // ================= SEARCH =================

    on<SearchTriggered>(_handleSearchTriggered);

    // ================= AUTOCOMPLETE =================

    on<AutoCompleteTriggered>(
      _handleAutoCompleteTriggered,
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    // ================= SEARCH EMPTY =================

    on<SearchEmpty>(
      (event, emit) => emit(
        SearchInitial(
          miniRate: state.miniRate,
          isOpenNow: state.isOpenNow,
          query: state.query,
          miniPrice: state.miniPrice,
          maxPrice: state.maxPrice,
        ),
      ),
    );

    // ================= FILTERS =================

    on<FilterValuePressed>(
      _handleSearchByFilters,
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    // ================= PRICE RANGE =================

    on<PriceRangeChanged>(
      _handlePriceRangeChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  // ============================================================
  // PRICE RANGE
  // ============================================================

  Future<void> _handlePriceRangeChanged(
    PriceRangeChanged event,
    Emitter<SearchState> emit,
  ) async {
    final updatedState = state.copyWith(
      miniPrice: event.minPrice,
      maxPrice: event.maxPrice,
    );

    emit(updatedState);

    if (state.query != null) {
      add(
        SearchTriggered(
          searchQuery: updatedState.query,

          userLat: event.userLat,
          userLng: event.userLng,

          miniRate: updatedState.miniRate,
          isOpenedNow: updatedState.isOpenNow,

          miniPrice: updatedState.miniPrice,
          maxPrice: updatedState.maxPrice,
        ),
      );
    }
  }

  // ============================================================
  // FILTERS
  // ============================================================

  Future<void> _handleSearchByFilters(
    FilterValuePressed event,
    Emitter<SearchState> emit,
  ) async {
    final updatedState = state.copyWith(
      miniRate: event.minimumRate,
      isOpenNow: event.isOpenedNow,
      query: event.query,
    );

    emit(updatedState);

    if (state.query != null) {
      add(
        SearchTriggered(
          searchQuery: updatedState.query,

          userLat: event.userLat,
          userLng: event.userLng,

          miniRate: updatedState.miniRate,
          isOpenedNow: updatedState.isOpenNow,

          miniPrice: updatedState.miniPrice,
          maxPrice: updatedState.maxPrice,
        ),
      );
    }
  }

  // ============================================================
  // AUTOCOMPLETE PRESSED
  // ============================================================

  Future<void> _handleAutoCompleteSuggestionPressed(
    AutoCompleteSuggestionPressed event,
    Emitter<SearchState> emit,
  ) async {
    final updatedState = state.copyWith(query: event.query);

    emit(updatedState);

    add(
      SearchTriggered(
        searchQuery: event.query,

        userLat: event.userLat,
        userLng: event.userLng,

        miniRate: updatedState.miniRate,
        isOpenedNow: updatedState.isOpenNow,

        miniPrice: updatedState.miniPrice,
        maxPrice: updatedState.maxPrice,
      ),
    );
  }

  // ============================================================
  // AUTOCOMPLETE
  // ============================================================

  Future<void> _handleAutoCompleteTriggered(
    AutoCompleteTriggered event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query == null || event.query!.isEmpty) {
      emit(
        SearchInitial(
          miniRate: state.miniRate,
          isOpenNow: state.isOpenNow,

          miniPrice: state.miniPrice,
          maxPrice: state.maxPrice,
        ),
      );

      return;
    }

    emit(
      SearchAutoCompleteLoading(
        query: event.query,

        miniRate: state.miniRate,
        isOpenNow: state.isOpenNow,

        miniPrice: state.miniPrice,
        maxPrice: state.maxPrice,
      ),
    );

    final result = await _autoCompleteUseCase(query: event.query!);

    result.fold(
      (failure) => emit(
        SearchInitial(
          query: event.query,

          miniRate: state.miniRate,
          isOpenNow: state.isOpenNow,

          miniPrice: state.miniPrice,
          maxPrice: state.maxPrice,
        ),
      ),

      (suggestions) => emit(
        SearchAutoCompleteSuccess(
          autoCompleteResponse: suggestions,

          query: event.query,

          miniRate: state.miniRate,
          isOpenNow: state.isOpenNow,

          miniPrice: state.miniPrice,
          maxPrice: state.maxPrice,
        ),
      ),
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Future<void> _handleSearchTriggered(
    SearchTriggered event,
    Emitter<SearchState> emit,
  ) async {
    final updatedState = state.copyWith(
      query: event.searchQuery,

      miniRate: event.miniRate,
      isOpenNow: event.isOpenedNow,

      miniPrice: event.miniPrice,
      maxPrice: event.maxPrice,
    );

    emit(updatedState);

    if (kDebugMode) {
      print(
        "SEARCH => "
        "query: ${updatedState.query} | "
        "miniRate: ${updatedState.miniRate} | "
        "openNow: ${updatedState.isOpenNow} | "
        "minPrice: ${updatedState.miniPrice} | "
        "maxPrice: ${updatedState.maxPrice}",
      );
    }

    if (event.userLat == 0.0 || event.userLat == null || event.userLng == 0.0 || event.userLat == null) {
      emit(
        SearchFailed(
          errorMsg: "Sorry , we can't get nearest places to you , adjust location permissions first",

          appFailure: GeneralFailure(generalFailureMessage: 'Error occurred'),

          query: updatedState.query,

          miniRate: updatedState.miniRate,
          isOpenNow: updatedState.isOpenNow,

          miniPrice: updatedState.miniPrice,
          maxPrice: updatedState.maxPrice,
        ),
      );

      return;
    }

    emit(
      SearchLoading(
        query: updatedState.query,

        miniRate: updatedState.miniRate,
        isOpenNow: updatedState.isOpenNow,

        miniPrice: updatedState.miniPrice,
        maxPrice: updatedState.maxPrice,
      ),
    );

    final result = await _searchUseCase(
      query: updatedState.query!,

      userLat: event.userLat!,
      userLng: event.userLng!,

      minimumRate: updatedState.miniRate,
      isOpenNow: updatedState.isOpenNow,

      minimumPrice: updatedState.miniPrice,
      maxPrice: updatedState.maxPrice,
    );

    result.fold(
      // ================= FAILURE =================
      (failure) => emit(
        SearchFailed(
          errorMsg: failure.failureMessage,

          appFailure: failure,

          query: updatedState.query,

          miniRate: updatedState.miniRate,
          isOpenNow: updatedState.isOpenNow,

          miniPrice: updatedState.miniPrice,
          maxPrice: updatedState.maxPrice,
        ),
      ),

      // ================= SUCCESS =================
      (results) {
        emit(
          SearchSuccess(
            searchResults: results,

            query: updatedState.query,

            miniRate: updatedState.miniRate,
            isOpenNow: updatedState.isOpenNow,

            miniPrice: updatedState.miniPrice,
            maxPrice: updatedState.maxPrice,

            resultEmpty: results.isEmpty
                ? "There is no result for this query, change the filters or search query"
                : null,
          ),
        );
      },
    );
  }
}

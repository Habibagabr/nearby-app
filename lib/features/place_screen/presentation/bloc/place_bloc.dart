import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/place_screen/domain/usecase/check_user_register.dart';
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_event.dart';
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_state.dart';

import '../../domain/usecase/get_initial_place_data_usecase.dart';
import '../../domain/usecase/get_place_items_usecase.dart';

@injectable
class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final LoadPlaceScreenUseCase loadPlaceScreen;
  final LoadPlaceItemsUseCase loadPlaceItems;
  final CheckUserRegister checkUserRegister;

  String? _placeId;

  PlaceBloc({
    required this.loadPlaceScreen,
    required this.loadPlaceItems,
    required this.checkUserRegister,
  }) : super(const PlaceState()) {
    on<EnterPlaceScreen>(_onEnterPlaceScreen);
    on<LoadNextPage>(_onLoadNextPage);
    on<SelectCategory>(_onSelectCategory);
    on<SaveButtonPressed>(_onSaveButtonPressed);
  }

  Future<void> _onEnterPlaceScreen(
      EnterPlaceScreen event,
      Emitter<PlaceState> emit,
      ) async {
    _placeId = event.placeId;

    emit(state.copyWith(isLoading: true));

    final result = await loadPlaceScreen(event.placeId);

    result.fold(
          (error) => emit(state.copyWith(isLoading: false, error: error)),
          (data) {
        emit(
          state.copyWith(
            isLoading: false,
            data: data,
            items: data.place.itemsPaginated.items,
            page: 2,
            hasReachedEnd:
            data.place.itemsPaginated.items.length < 3,
            selectedCategoryId: "0",
          ),
        );
      },
    );
  }

  Future<void> _onSelectCategory(
      SelectCategory event,
      Emitter<PlaceState> emit,
      ) async {
    if (_placeId == null) return;

    emit(state.copyWith(
      selectedCategoryId: event.categoryId,
      items: [],
      page: 1,
      hasReachedEnd: false,
      isLoadingMore: true,
    ));

    final result = await loadPlaceItems(
      placeId: _placeId!,
      page: 1,
      limit: 3,
      categoryId:
      event.categoryId == "0" ? null : event.categoryId,
    );

    result.fold(
          (_) => emit(state.copyWith(isLoadingMore: false)),
          (paginated) {
        emit(state.copyWith(
          items: paginated.items,
          page: 2,
          hasReachedEnd: paginated.items.length < 3,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> _onLoadNextPage(
      LoadNextPage event,
      Emitter<PlaceState> emit,
      ) async {
    if (_placeId == null) return;
    if (state.isLoadingMore) return;
    if (state.hasReachedEnd) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await loadPlaceItems(
      placeId: _placeId!,
      page: state.page,
      limit: 3,
      categoryId:
      state.selectedCategoryId == "0"
          ? null
          : state.selectedCategoryId,
    );

    result.fold(
          (_) => emit(state.copyWith(isLoadingMore: false)),
          (paginated) {
        emit(state.copyWith(
          items: [...state.items, ...paginated.items],
          page: state.page + 1,
          hasReachedEnd: paginated.items.length < 3,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> _onSaveButtonPressed(
      SaveButtonPressed event,
      Emitter<PlaceState> emit,
      ) async {
    emit(state.copyWith(checkingUserRegistration: true));

    final isUserRegisterBefore = await checkUserRegister();

    emit(state.copyWith(
      checkingUserRegistration: false,
      isAlreadyRegister: isUserRegisterBefore,
    ));
  }
}
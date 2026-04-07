import '../../domain/entities/placeEntity/place_category_entity.dart';

class PlaceState {
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool isAlreadyRegister;
  final bool checkingUserRegistration;

  final PlaceCategoryEntity? data;
  final List<dynamic> items;

  final int page;
  final bool hasReachedEnd;
  final String? selectedCategoryId;

  const PlaceState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.data,
    this.items = const [],
    this.page = 1,
    this.hasReachedEnd = false,
    this.selectedCategoryId = "0", // 🔥 default All selected
    this.isAlreadyRegister = false,
    this.checkingUserRegistration = false,
  });

  PlaceState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    PlaceCategoryEntity? data,
    List<dynamic>? items,
    int? page,
    bool? hasReachedEnd,
    String? selectedCategoryId,
    bool? isAlreadyRegister,
    bool? checkingUserRegistration,
  }) {
    return PlaceState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
      data: data ?? this.data,
      items: items ?? this.items,
      page: page ?? this.page,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      selectedCategoryId:
      selectedCategoryId ?? this.selectedCategoryId,
      isAlreadyRegister:
      isAlreadyRegister ?? this.isAlreadyRegister,
      checkingUserRegistration:
      checkingUserRegistration ??
          this.checkingUserRegistration,
    );
  }
}
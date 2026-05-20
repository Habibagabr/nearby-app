import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_dimen.dart';
import '../../../../core/themes/app_text_style.dart';
import '../../../../shared/components/header_text_style.dart';
import '../../../../shared/widget/error_widget.dart';
import '../../../placeScreen/presentation/store/ui/store_skeleton_widget.dart';
import '../bloc/home_bloc.dart';
import '../components/nearby_place_card.dart';

class DraggableNearbyPlacesSheet extends StatelessWidget {
  const DraggableNearbyPlacesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    int lastRequestedPage = 1;

    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.1,
      maxChildSize: 0.88,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimens.radiusL),
            ),
          ),
          child: BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) =>
            previous.status != current.status &&
                current.status == HomeStatus.failure,
            listener: (context, state) {
              if (state.nearbyPlaces.isNotEmpty) {
                Fluttertoast.showToast(
                  msg: state.errorMsg ?? "Connection failed",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final int listLength = state.nearbyPlaces.length;

                if (state.pageNum >= lastRequestedPage) {
                  lastRequestedPage = state.pageNum;
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200 &&
                        state.status != HomeStatus.loading &&
                        !state.isMaxReached &&
                        !state.hasNetworkError) {

                      final nextPage = state.pageNum + 1;

                      if (nextPage > lastRequestedPage) {
                        lastRequestedPage = nextPage;

                        context.read<HomeBloc>().add(
                          FetchNearbyPlacesEvent(
                            lat: state.lat,
                            lng: state.lng,
                            pageNum: nextPage,
                            limit: 3,
                            businessCategory: state.businessCategory,
                          ),
                        );
                      }
                    }
                    return false;
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: listLength == 0 ? 3 : listLength + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildSheetHeader();
                      }

                      if (listLength == 0 && index == 1) {
                        if (state.status == HomeStatus.loading) {
                          return Center(
                            child: Column(
                              children: List.generate(
                                3,
                                    (index) => const ProductItemSkeleton(),
                              ),
                            ),
                          );
                        }

                        if (state.status == HomeStatus.success) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 100),
                            child: Center(
                              child: CustomErrorWidget(
                                errorImage: "assets/images/no_results.webp",
                                errorMessage: "No places are found for this category",
                                errorMessageStyle: AppTextStyles.errorText.copyWith(color: AppColors.white),
                              ),
                            ),
                          );
                        }

                        if (state.status == HomeStatus.failure) {
                          final String? errorImageUrl = switch (state.failureType) {
                            null => null,
                            FailureTypes.server => "assets/images/cloud_error.webp",
                            FailureTypes.network => "assets/images/network_error.webp",
                            FailureTypes.general => "assets/images/general_error.png",
                            FailureTypes.canceling => null,
                          };

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 100),
                            child: Center(
                              child: CustomErrorWidget(
                                errorImage: errorImageUrl,
                                errorMessage: state.errorMsg ?? "Unknown error occurred",
                                errorMessageStyle: AppTextStyles.errorText.copyWith(color: AppColors.white),
                              ),
                            ),
                          );
                        }
                      }

                      final int footerTargetIndex = listLength == 0 ? 2 : listLength + 1;
                      if (index == footerTargetIndex) {
                        if (listLength == 0 && state.status == HomeStatus.failure) {
                          return const SizedBox.shrink();
                        }
                        return _buildListFooter(state);
                      }

                      if (listLength == 0) return const SizedBox.shrink();

                      final place = state.nearbyPlaces[index - 1];

                      return GestureDetector(
                        onTap: () {
                          context.read<HomeBloc>().add(
                            PlaceSelected(
                              placeId: place.id,
                              businessCategory: place.category,
                            ),
                          );
                        },
                        child: NearbyPlaceCard(
                          name: place.name,
                          category: place.type,
                          description: place.description,
                          servicesProvided: place.servicesProvided,
                          address: place.address,
                          imageUrls: place.imageUrls,
                          rating: place.rating,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSheetHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Center(
          child: Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppDimens.paddingM),
          child: HeaderText("Nearby Places"),
        ),
      ],
    );
  }

  Widget _buildListFooter(HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingS),
      child: Builder(
          builder: (context) {
            // If max is reached, clean layout spacer box
            if (state.isMaxReached) {
              return const SizedBox(height: AppDimens.spacingM);
            }

            // If network failed with items visible, show an inline manual retry action row
            if (state.hasNetworkError) {
              return Center(
                child: TextButton.icon(
                  onPressed: () {
                    context.read<HomeBloc>().add(
                      FetchNearbyPlacesEvent(
                        lat: state.lat,
                        lng: state.lng,
                        pageNum: state.pageNum + 1,
                        limit: 3,
                        businessCategory: state.businessCategory,
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text(
                    "Retry Loading Places",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }

            // Default fallback skeleton display state while loading next pages smoothly
            return Center(
              child: Column(
                children: [const ProductItemSkeleton()],
              ),
            );
          }
      ),
    );
  }
}

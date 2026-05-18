import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final int listLength = state.nearbyPlaces.length;

              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200 &&
                      state.status != HomeStatus.loading &&
                      !state.isMaxReached &&
                      state.status != HomeStatus.failure) {
                    context.read<HomeBloc>().add(
                      FetchNearbyPlacesEvent(
                        lat: state.lat,
                        lng: state.lng,
                        pageNum: state.pageNum + 1,
                        limit: 10,
                        businessCategory: state.businessCategory,
                      ),
                    );
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: listLength == 0 ? 2 : listLength + 2,
                  itemBuilder: (context, index) {
                    //  Header
                    if (index == 0) {
                      return _buildSheetHeader();
                    }

                    //  Empty State
                    if (listLength == 0) {
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

                      if(state.status == HomeStatus.success){
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: Center(
                            child: CustomErrorWidget(
                              errorImage:"assets/images/no_results.webp" ,
                              errorMessage: "No places are found for this category",
                              errorMessageStyle: AppTextStyles.errorText
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        );
                      }

                      if (state.status == HomeStatus.failure) {
                        final String? errorImageUrl = switch(state.failureType){
                          null => throw UnimplementedError(),
                          FailureTypes.server => "assets/images/cloud_error.webp",
                          FailureTypes.network =>"assets/images/network_error.webp",
                          FailureTypes.general =>"assets/images/general_error.png",
                          FailureTypes.canceling => null,
                        };
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: Center(
                            child: CustomErrorWidget(
                              errorImage:errorImageUrl ,
                              errorMessage: state.errorMsg,
                              errorMessageStyle: AppTextStyles.errorText
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        );
                      }
                    }

                    //  Footer
                    if (index == listLength + 1) {
                      return _buildListFooter(state);
                    }

                    //  Real Items
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
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(AppDimens.paddingM),
          child: HeaderText("Nearby Places"),
        ),
      ],
    );
  }

  Widget _buildListFooter(HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingS),
      child: state.isMaxReached
          ? SizedBox(height: AppDimens.spacingM)
          : Center(
              child: Column(
                children: [ProductItemSkeleton()],
              ),
            ),
    );
  }
}

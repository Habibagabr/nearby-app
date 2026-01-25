import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/values/app_dimen.dart';
import '../../../../shared/components/header_text_style.dart';
import '../bloc/home_bloc.dart';
import 'nearby_place_card.dart';


class DraggableNearbyPlacesSheet extends StatelessWidget {
  const DraggableNearbyPlacesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.1,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final int listLength = state.nearbyPlaces.length;

              // Full screen loader only on the first page
              if (state.status == HomeStatus.loading && listLength == 0) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == HomeStatus.success && listLength == 0) {
                return const Center(child: Text("No nearby places found"));
              }
              if(state.status ==HomeStatus.failure){
                return const Center(child: Text("some thing wrong happened , please try again later "));

              }

              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  // Trigger next page when 200 pixels from the bottom
                  if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200 &&
                      state.status != HomeStatus.loading && // Don't trigger if already loading
                      !state.isMaxReached) {                // Don't trigger if no more data

                    context.read<HomeBloc>().add(FetchNearbyPlacesEvent(
                      lat: state.lat,
                      lng: state.lng,
                      pageNum: state.pageNum + 1, // Increment page
                      limit: 10,
                    ));
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: listLength + 2, // +1 for Header, +1 for Footer
                  itemBuilder: (context, index) {
                    if (index == 0) return _buildSheetHeader();

                    // List Footer Logic
                    if (index == listLength + 1) {
                      // Don't show footer if the list is empty
                      return listLength > 0
                          ? _buildListFooter(state)
                          : const SizedBox.shrink();
                    }

                    final place = state.nearbyPlaces[index - 1];
                    return NearbyPlaceCard(
                      name: place.name,
                      category: place.type,
                      description: place.description,
                      servicesProvided: place.servicesProvided,
                      address: place.address,
                      imageUrls: place.imageUrls,
                      rating: place.rating,
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: state.isMaxReached
            ? Text(
          "No more places to show",
          style: TextStyle(color: Colors.grey[500], fontSize: 13),
        )
            : const CircularProgressIndicator(strokeWidth: 2), // Mini loader for pagination
      ),
    );
  }
}


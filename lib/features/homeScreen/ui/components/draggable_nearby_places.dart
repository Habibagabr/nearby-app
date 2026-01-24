import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/values/app_dimen.dart';
import '../../../../shared/components/header_text_style.dart';
import '../../data/datasource/home_remote_service_impl.dart';
import 'nearby_place_card.dart';


// ================= DRAGGABLE SHEET =================

Widget buildDraggableSheet() {
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
        child: ListView.builder(
          controller: scrollController,
          itemCount: nearbyPlacesMock.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return buildSheetHeader();
            }

            final place = nearbyPlacesMock[index - 1];
            return NearbyPlaceCard(
              name: place.name,
              category: place.category,
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
  );
}

Widget buildSheetHeader() {
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


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/profileScreen/presentation/ui/components/saved_place_item.dart';

import '../../../../../shared/components/header_text_style.dart';

class SavedPlaces extends StatefulWidget {
  const SavedPlaces({super.key});

  @override
  SavedPlacesState createState() => SavedPlacesState();
}

class SavedPlacesState extends State<SavedPlaces> {
  bool isExpanded = false;

  final places = [

    SavedPlaceItem(
      placeImages: [
        'assets/images/mapbackground.webp',
        'assets/images/mapbackground.webp',
      ],
      placeName: "Mario's Italian",
      placeCategory: "Restaurant",
    ),

    SavedPlaceItem(
      placeImages: [
        'assets/images/mapbackground.webp',
      ],
      placeName: "Care Plus Clinic",
      placeCategory: "Clinic",
    ),

    SavedPlaceItem(
      placeImages: [
        'assets/images/mapbackground.webp',
        'assets/images/mapbackground.webp',
      ],
      placeName: "Fresh Market",
      placeCategory: "Supermarket",
    ),

    SavedPlaceItem(
      placeImages: [
        'assets/images/mapbackground.webp',
        'assets/images/mapbackground.webp',
      ],
      placeName: "Power Gym",
      placeCategory: "Gym",
    ),

    SavedPlaceItem(
      placeImages: [
        'assets/images/mapbackground.webp',
      ],
      placeName: "Urban Style",
      placeCategory: "Clothing Shop",
    ),

    SavedPlaceItem(
      placeImages: [
        'assets/images/mapbackground.webp',
      ],
      placeName: "Pizza Hub",
      placeCategory: "Restaurant",
    ),

    SavedPlaceItem(
      placeImages: [
        'assets/images/mapbackground.webp',
      ],
      placeName: "Fit Zone",
      placeCategory: "Gym",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderText("Saved Places", textColor: AppColors.darkGray),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                 isExpanded?"See Less":"See More",
                  style: TextStyle(
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.60,
            ),
            itemCount: isExpanded ? places.length : min(places.length, 3),
            itemBuilder: (context, index) => SavedPlaceItem(placeCategory: places[index].placeCategory,placeImages: places[index].placeImages,placeName: places[index].placeName),
          ),
        ],
      ),
    );
  }
}

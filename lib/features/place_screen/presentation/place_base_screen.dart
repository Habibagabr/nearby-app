import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/store_entity/store_entity.dart';
import 'package:near_buy_gp/shared/components/places_bar.dart';

class PlaceMainScreen extends StatelessWidget {
  // i have to path 
  // final StoreEntity store;

  const PlaceMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
              child: Positioned(top: 200, child: PlacesTopBar())),

        ],
      ),
    );
  }
}

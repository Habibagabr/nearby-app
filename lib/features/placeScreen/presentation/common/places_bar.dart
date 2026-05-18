import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/bloc/place_bloc.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/bloc/place_state.dart';
import 'package:near_buy_gp/features/placeScreen/presentation/utils/open_maps.dart';

import '../../../../core/common_widgets/popup_component.dart';
import '../../../../core/routing/app_routes.dart';
import '../bloc/place_event.dart';

class PlacesTopBar extends StatelessWidget {
  final double? lat;
  final double? lng;
  const PlacesTopBar({super.key , this.lat , this.lng});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceBloc, PlaceState>(
      listenWhen: (previous, current) =>
          previous.checkingUserRegistration &&
          !current.checkingUserRegistration,
      listener: (context, state) {
        if (state.isAlreadyRegister) {
          // user registered → call save api
        } else if (state.isAlreadyRegister == false) {
          appPopup(
            context: context,
            title: "You have to Register to save the Place",
            bodyContent: "if you want to save the place , please register first",
            icon: Icons.person,
            confirmActionTitle: 'register',
            dismissActionTitle: 'cancel',
            onConfirmPressed: () {
              context.go(LoginRoute().location);
            },
          );
        }
      },
      child: PlacesTopBarWidget(
        lat:lat,
        lng:lng
      ),
    );
  }
}

class PlacesTopBarWidget extends StatelessWidget {
  final double? lat;
  final double? lng;

  const PlacesTopBarWidget({super.key , this.lat, this.lng});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 10, right: 10, top: 40),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
            style: IconButton.styleFrom(
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.darkGray,
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // send the event of check the user Register
                  context.read<PlaceBloc>().add(SaveButtonPressed());
                },
                icon: Icon(Icons.bookmark),
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.darkGray,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(width: 4),
              IconButton(
                onPressed: (){openMaps(lat??0.0,lng??0.0);},
                icon: const Icon(Icons.directions),
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.darkGray,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

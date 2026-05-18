import 'package:flutter/material.dart';
import 'package:near_buy_gp/shared/util/screens_enum.dart';

import '../../../../core/themes/app_colors.dart';
import '../clinic/ui/clinic_skeleton_widget.dart';
import '../store/ui/store_skeleton_widget.dart';

Widget buildScreenSkeletonizerByType(ScreensType screenType) {
  switch (screenType) {
    case ScreensType.store:
      return StoreMainSkeleton();

    case ScreensType.clinic:
      return Scaffold(
        backgroundColor: AppColors.white,
        extendBodyBehindAppBar: true,
        body: ClinicMainSkeleton(),
      );

    case ScreensType.generic:
      return Scaffold(
        backgroundColor: AppColors.white,
        extendBodyBehindAppBar: true,
        body: Center(child: CircularProgressIndicator()),
      );

    case ScreensType.gym:
      return Scaffold(
        backgroundColor: AppColors.white,
        extendBodyBehindAppBar: true,
        body: Center(child: CircularProgressIndicator()),
      );
  }
}

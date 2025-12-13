import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/splashScreen/ui/components/splash_screen_content.dart';

import '../../shared/components/base_screen.dart';


class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: BaseScreen(
          child: SplashScreenContent(),
        )
    );
  }

}
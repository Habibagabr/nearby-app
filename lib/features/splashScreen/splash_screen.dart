import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/splashScreen/ui/components/splash_screen_content.dart';
import 'package:near_buy_gp/shared/components/auth_base_screen.dart';



class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: AuthBaseScreen(
          child: SplashScreenContent(),
        )
    );
  }

}
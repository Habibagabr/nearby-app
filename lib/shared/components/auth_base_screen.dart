import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';
import '../../core/themes/app_colors.dart';

class AuthBaseScreen extends StatelessWidget {
  final Widget child;

  const AuthBaseScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/mapbackground.webp"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.darkGray.withValues(alpha:0.9),
                  BlendMode.srcOver,
                )
            ),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.only(top:  AppDimens.paddingL),
            child:child,
          )
      ),
    );
  }
}

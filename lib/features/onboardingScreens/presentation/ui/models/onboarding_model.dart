import 'dart:ui';

import 'package:flutter/cupertino.dart';

class OnboardingModel {
  final String screenHeader;
  final String? screenSubHeader;
  final String screenDescription;
  final Widget bodyContent;
  final VoidCallback onNextClicked;
  final VoidCallback onBackClicked;

  OnboardingModel({
    required this.onBackClicked,
    required this.onNextClicked,
     required this.screenDescription,
    required this.screenHeader,
    required this.bodyContent,
     this.screenSubHeader,
  });
}

import "package:flutter/material.dart";

import "../../../../../core/themes/app_dimen.dart";
Widget buildHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppDimens.paddingM,
      vertical: AppDimens.paddingS,
    ),
    child: const Text(
      "Popular Search",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}



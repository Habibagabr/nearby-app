import 'package:flutter/material.dart';

import '../../../../shared/util/business_category.dart';

class CategoryIconResolver {
  static IconData resolve(String category) {
    return businessCategories.firstWhere(
          (element) => element.apiValue == category,
      orElse: () => businessCategories.last,
    ).icon;
  }
}

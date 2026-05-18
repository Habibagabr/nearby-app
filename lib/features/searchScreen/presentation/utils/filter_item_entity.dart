import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/searchScreen/presentation/utils/filter_value_type.dart';

// data class for the list

class FilterItemEntity {
  final Widget filterItem;
  final dynamic filterValue;
  final FilterValueType filterValueType;
  final int filterValueIndex;

  FilterItemEntity({
    required this.filterItem,
    required this.filterValue,
    required this.filterValueType,
    required this.filterValueIndex
  });
}

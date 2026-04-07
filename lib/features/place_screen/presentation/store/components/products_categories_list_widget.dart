import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_bloc.dart';
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_event.dart';
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_state.dart';

import '../../../domain/entities/placeEntity/category_entity.dart';

class ProductsCategoriesList extends StatelessWidget {
  final List<CategoryEntity> availableProductsCategories;

  const ProductsCategoriesList({
    super.key,
    required this.availableProductsCategories,
  });

  @override
  Widget build(BuildContext context) {
    final categoriesWithAll = [
      CategoryEntity(id: "0", name: "All"),
      ...availableProductsCategories,
    ];

    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
            const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categoriesWithAll.length,
            itemBuilder: (context, index) {
              final category = categoriesWithAll[index];

              final isSelected =
                  state.selectedCategoryId ==
                      category.id;

              return GestureDetector(
                onTap: () {
                  context.read<PlaceBloc>().add(
                    SelectCategory(category.id),
                  );
                },
                child: Container(
                  margin:
                  const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.black
                        : Colors.grey.shade200,
                    borderRadius:
                    BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Colors.black,
                        fontWeight:
                        FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

import 'components/products_categories_component.dart';

class ProductsCategoriesList extends StatefulWidget {
  final List<String> availableProductsCategories;
  const ProductsCategoriesList({super.key, required this.availableProductsCategories});

  @override
  State<ProductsCategoriesList> createState() =>
      _ProductsCategoriesListState();
}

class _ProductsCategoriesListState extends State<ProductsCategoriesList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.availableProductsCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ProductsComponent(
            productCategory: widget.availableProductsCategories[index],
            isSelected: selectedIndex == index,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}

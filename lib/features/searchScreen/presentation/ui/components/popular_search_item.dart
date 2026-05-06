import "package:flutter/material.dart";
final List<String> popularSearches = [
  "Nearby coffee shops",
  "Pharmacy open now",
  "Men clothing store",
  "Best burger restaurants",
  "Supermarket delivery",
  "Kids clothing sale",
  "Gym with monthly plans",
  "Electronics store near me",
  "Hair salon for women",
  "Breakfast places nearby",
  "Pizza and pasta restaurants",
  "Flower shop delivery",
  "Pet shop supplies",
  "Bookstore offers",
  "Bakery fresh bread",
];

Widget buildSearchItem(int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 4,
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // light background
        borderRadius: BorderRadius.circular(40), // pill shape
        border: Border.all(
          color: const Color(0xFFE5E7EB), // light grey border
          width: 1,
        ),
      ),
      child: Text(
        popularSearches[index],
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF374151), // dark grey text
        ),
      ),
    ),
  );
}

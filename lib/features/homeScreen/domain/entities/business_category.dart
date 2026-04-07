import 'package:flutter/material.dart';

class BusinessCategory {
  final String display;
  final String apiValue;
  final IconData icon;

  const BusinessCategory({
    required this.display,
    required this.apiValue,
    required this.icon,
  });
}

final List<BusinessCategory> businessCategories = [
  const BusinessCategory(display: "All", apiValue: "all", icon: Icons.grid_view),
  const BusinessCategory(display: "Electronics", apiValue: "electronics", icon: Icons.devices),
  const BusinessCategory(display: "Clothing", apiValue: "clothing", icon: Icons.checkroom),
  const BusinessCategory(display: "Supermarket", apiValue: "supermarket", icon: Icons.local_grocery_store),
  const BusinessCategory(display: "Pharmacy", apiValue: "pharmacy", icon: Icons.local_pharmacy),
  const BusinessCategory(display: "Fast Food", apiValue: "fast_food", icon: Icons.fastfood),
  const BusinessCategory(display: "Cafe", apiValue: "cafe", icon: Icons.coffee),
  const BusinessCategory(display: "Dessert", apiValue: "dessert", icon: Icons.cake),
  const BusinessCategory(display: "Seafood", apiValue: "seafood", icon: Icons.set_meal),
  const BusinessCategory(display: "Dentist", apiValue: "dentist", icon: Icons.medical_services),
  const BusinessCategory(display: "Dermatology", apiValue: "dermatology", icon: Icons.face),
  const BusinessCategory(display: "Pediatric", apiValue: "pediatric", icon: Icons.child_care),
  const BusinessCategory(display: "General Clinic", apiValue: "general_clinic", icon: Icons.local_hospital),
  const BusinessCategory(display: "Crossfit", apiValue: "crossfit", icon: Icons.fitness_center),
  const BusinessCategory(display: "Bodybuilding", apiValue: "bodybuilding", icon: Icons.high_quality),
  const BusinessCategory(display: "Pilates", apiValue: "pilates", icon: Icons.accessibility_new),
  const BusinessCategory(display: "Repair", apiValue: "repair", icon: Icons.build),
  const BusinessCategory(display: "Cleaning", apiValue: "cleaning", icon: Icons.cleaning_services),
  const BusinessCategory(display: "Beauty", apiValue: "beauty", icon: Icons.brush),
  const BusinessCategory(display: "Consulting", apiValue: "consulting", icon: Icons.psychology),
  const BusinessCategory(display: "Fashion", apiValue: "fashion", icon: Icons.shopping_bag),
  const BusinessCategory(display: "Grocery", apiValue: "grocery", icon: Icons.shopping_cart),
  const BusinessCategory(display: "Health", apiValue: "health", icon: Icons.monitor_heart),
  const BusinessCategory(display: "Sports", apiValue: "sports", icon: Icons.sports_basketball),
  const BusinessCategory(display: "Home", apiValue: "home", icon: Icons.home),
  const BusinessCategory(display: "Toys", apiValue: "toys", icon: Icons.smart_toy),
  const BusinessCategory(display: "Medical", apiValue: "medical", icon: Icons.emergency),
  const BusinessCategory(display: "Salon", apiValue: "salon", icon: Icons.content_cut),
  const BusinessCategory(display: "Fitness", apiValue: "fitness", icon: Icons.monitor_weight),
  const BusinessCategory(display: "Education", apiValue: "education", icon: Icons.school),
  const BusinessCategory(display: "Automotive", apiValue: "automotive", icon: Icons.directions_car),
  const BusinessCategory(display: "Food & Beverage", apiValue: "food_beverage", icon: Icons.restaurant),
  const BusinessCategory(display: "Entertainment", apiValue: "entertainment", icon: Icons.theater_comedy),
  const BusinessCategory(display: "Travel", apiValue: "travel", icon: Icons.flight),
  const BusinessCategory(display: "Other", apiValue: "other", icon: Icons.more_horiz),
];

import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/values/app_dimen.dart';
import 'package:near_buy_gp/features/map/map_utils.dart';
import 'package:near_buy_gp/shared/components/app_logo.dart';

import '../../../shared/components/header_text_style.dart';
import '../domain/entities/nearby_places_entity.dart';
import 'components/nearby_place_card.dart';

const List<NearbyPlaceEntity> nearbyPlacesMock = [
  NearbyPlaceEntity(
    id: '1',
    name: 'Costa Coffee',
    category: 'Cafe',
    description:
        'International coffee shop offering premium coffee and desserts.',
    address: 'Mall of Egypt, 6th of October',
    rating: 4.5,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Coffee', 'Desserts', 'Wi-Fi', 'Takeaway'],
  ),

  NearbyPlaceEntity(
    id: '2',
    name: 'McDonald’s',
    category: 'Fast Food',
    description: 'Popular fast food restaurant serving burgers and fries.',
    address: 'Sheikh Zayed, Giza',
    rating: 4.2,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Burgers', 'Delivery', 'Kids Meals'],
  ),

  NearbyPlaceEntity(
    id: '3',
    name: 'City Pharmacy',
    category: 'Pharmacy',
    description: '24/7 pharmacy providing medicines and health products.',
    address: 'Haram Street, Giza',
    rating: 4.6,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Medicines', 'Medical Supplies', 'Home Delivery'],
  ),

  NearbyPlaceEntity(
    id: '4',
    name: 'Gold’s Gym',
    category: 'Gym',
    description: 'Fully equipped gym with professional trainers.',
    address: 'October Plaza, 6th of October',
    rating: 4.7,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: [
      'Personal Training',
      'Fitness Classes',
      'Nutrition Advice',
    ],
  ),

  NearbyPlaceEntity(
    id: '5',
    name: 'Pizza Hut',
    category: 'Restaurant',
    description: 'Pizza restaurant offering dine-in and delivery options.',
    address: 'Faisal Street, Giza',
    rating: 4.1,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Pizza', 'Delivery', 'Dine-in'],
  ),

  NearbyPlaceEntity(
    id: '6',
    name: 'Orange Mobile Store',
    category: 'Electronics',
    description: 'Official Orange store for mobile services and devices.',
    address: 'Mall of Arabia, Giza',
    rating: 4.3,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['SIM Cards', 'Mobile Phones', 'Customer Support'],
  ),

  NearbyPlaceEntity(
    id: '7',
    name: 'Royal Beauty Salon',
    category: 'Beauty',
    description: 'Professional beauty salon for hair and skincare.',
    address: 'Dokki, Giza',
    rating: 4.8,
    imageUrls: ['https://example.com/salon1.jpg'],
    servicesProvided: ['Hair Styling', 'Makeup', 'Skin Care'],
  ),

  NearbyPlaceEntity(
    id: '8',
    name: 'Car Care Center',
    category: 'Automotive',
    description: 'Car wash and maintenance services.',
    address: 'Ring Road, Giza',
    rating: 4.0,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Car Wash', 'Oil Change', 'Tire Services'],
  ),

  NearbyPlaceEntity(
    id: '9',
    name: 'Alpha Medical Lab',
    category: 'Medical',
    description: 'Medical laboratory providing diagnostic tests.',
    address: 'Mohandessin, Giza',
    rating: 4.9,
    imageUrls: ['https://example.com/lab1.jpg'],
    servicesProvided: ['Blood Tests', 'PCR Tests', 'Home Visit'],
  ),

  NearbyPlaceEntity(
    id: '10',
    name: 'Spinneys Market',
    category: 'Supermarket',
    description: 'Supermarket offering fresh food and groceries.',
    address: 'Sheikh Zayed, Giza',
    rating: 4.4,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Groceries', 'Fresh Produce', 'Online Ordering'],
  ),
];


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppLogo(AppColors.darkGray),
      ),
      body: Stack( // Use a Stack to layer widgets
        children: [
          // The Map
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: getMap(),
          ),

          // The Draggable Panel (Foreground)
          DraggableScrollableSheet(
            initialChildSize: 0.75, // Starts at 35% of the screen
            minChildSize: 0.1,    // Can collapse to 15%
            maxChildSize: 1,     // Can expand to 90%
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                // Add decoration for rounded top corners and background color
                decoration: const BoxDecoration(
                  color: Colors.white, // Must set a background color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: ListView.builder(
                  controller: scrollController, // links scrolling behavior
                  itemCount: nearbyPlacesMock.length + 1, // +1 for the header section
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // The "Nearby places" header and drag handle area
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center( // Optional drag indicator (handle)
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(AppDimens.paddingM),
                            child: HeaderText("Nearby places"),
                          ),
                        ],
                      );
                    }
                    // The actual list items
                    final place = nearbyPlacesMock[index - 1];
                    return NearbyPlaceCard(
                      name: place.name,
                      category: place.category,
                      description: place.description,
                      servicesProvided: place.servicesProvided,
                      address: place.address,
                      imageUrls: place.imageUrls,
                      rating: place.rating,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

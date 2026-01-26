import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/place_screen/presentation/storeWidgets/store_main_widget.dart';
import 'package:near_buy_gp/shared/components/places_bar.dart';

import '../domain/entities/store_entity/social_entity.dart';
import '../domain/entities/store_entity/store_entity.dart';
import '../domain/entities/store_entity/store_product.dart';


final StoreEntity demoStore = StoreEntity(
  storeId: 'store_001',
  storeImages: [
    'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38',
  ],
  storeName: 'Italiano Restaurant',
  storeDescription:
  'Delicious handmade pizzas with fresh toppings, fast service, and cozy dine-in experience. Family-friendly atmosphere with authentic Italian recipes.',
  availableProductsCategories: [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Desserts',
  ],
  storeProducts: [
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1525755662778-989d0524087e',
      ],
      productName: 'Margherita Pizza',
      productDescription:
      'Classic Italian pizza with fresh mozzarella, basil, and tomato sauce.',
      productPrice: '120',
      productCurrency: 'EGP',
      productCategory: 'Dinner',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1525755662778-989d0524087e',
      ],
      productName: 'Pasta Alfredo',
      productDescription:
      'Creamy Alfredo pasta with grilled chicken and parmesan cheese.',
      productPrice: '150',
      productCurrency: 'EGP',
      productCategory: 'Lunch',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1525755662778-989d0524087e',
      ],
      productName: 'Tiramisu',
      productDescription:
      'Traditional Italian dessert with mascarpone, coffee, and cocoa.',
      productPrice: '80',
      productCurrency: 'EGP',
      productCategory: 'Desserts',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1525755662778-989d0524087e',
      ],
      productName: 'Margherita Pizza',
      productDescription:
      'Classic Italian pizza with fresh mozzarella, basil, and tomato sauce.',
      productPrice: '120',
      productCurrency: 'EGP',
      productCategory: 'Dinner',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1525755662778-989d0524087e',
      ],
      productName: 'Margherita Pizza',
      productDescription:
      'Classic Italian pizza with fresh mozzarella, basil, and tomato sauce.',
      productPrice: '120',
      productCurrency: 'EGP',
      productCategory: 'Dinner',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1525755662778-989d0524087e',
      ],
      productName: 'Margherita Pizza',
      productDescription:
      'Classic Italian pizza with fresh mozzarella, basil, and tomato sauce.',
      productPrice: '120',
      productCurrency: 'EGP',
      productCategory: 'Dinner',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1525755662778-989d0524087e',
      ],
      productName: 'Margherita Pizza',
      productDescription:
      'Classic Italian pizza with fresh mozzarella, basil, and tomato sauce.',
      productPrice: '120',
      productCurrency: 'EGP',
      productCategory: 'Dinner',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1525755662778-989d0524087e',
      ],
      productName: 'Margherita Pizza',
      productDescription:
      'Classic Italian pizza with fresh mozzarella, basil, and tomato sauce.',
      productPrice: '120',
      productCurrency: 'EGP',
      productCategory: 'Dinner',
    ),

  ],
  socialMediaLinks: [
    SocialData(
      facebookLink: 'https://facebook.com/italiano.restaurant',
      instagramLink: 'https://instagram.com/italiano.restaurant',
      tiktokLink: 'https://tiktok.com/@italiano.restaurant',
      twitterLink: 'https://twitter.com/italiano_rest',
      linkedinLink: 'https://linkedin.com/company/italiano-restaurant',
      whatsappNumber: '+201012345678',
    ),
  ],
  address: '12 Tahrir Street, Downtown, Cairo, Egypt',
  lat: 30.0444,
  lng: 31.2357,
  phoneNumber: '+201098765432',
  openingHours: "9:00 AM",
  closingHours: "10:00 PM",
  reviewsCount: 127,
  placeStatus: true,
  storeType: "Restaurant",
  rate: 2.5,

);

class PlaceBaseScreen extends StatelessWidget {
  // I have to path object from enum and check over the enum if it x so render y
  // all of them have the same top bar + the same top photos carousel

  // final StoreEntity store;

  const PlaceBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // for now i will test the store only
          StoreMainWidget(
            storeEntity:demoStore ,
          ),

          SizedBox(
            width: double.infinity,
            child: Positioned(top: 200, child: PlacesTopBar()),
          ),
        ],
      ),
    );
  }
}

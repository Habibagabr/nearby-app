import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/place_screen/presentation/store/ui/store_main_widget.dart';
import 'package:near_buy_gp/shared/components/places_bar.dart';

import '../domain/entities/clinicEntity/clinic_available_time.dart';
import '../domain/entities/clinicEntity/clinic_entity.dart';
import '../domain/entities/clinicEntity/clinic_service.dart';
import '../domain/entities/commonEntities/social_entity.dart';
import '../domain/entities/commonEntities/social_media_enum.dart';
import '../domain/entities/genericEntities/amenities_enum.dart';
import '../domain/entities/genericEntities/generic_entity.dart';
import '../domain/entities/genericEntities/opening_day_hour_entity.dart';
import '../domain/entities/storeEntity/store_entity.dart';
import '../domain/entities/storeEntity/store_product.dart';

final StoreEntity demoPharmacyStore = StoreEntity(
  storeId: 'pharmacy_001',
  storeImages: [
    'https://images.unsplash.com/photo-1580281658629-0f9f2a0c49d5',
    'https://images.unsplash.com/photo-1587854692152-cbe660dbde88',
    'https://images.unsplash.com/photo-1615461066841-6116e61058f4',
  ],
  storeName: 'LifeCare Pharmacy',
  storeDescription:
  'A trusted pharmacy providing prescription medicines, over-the-counter drugs, medical supplies, vitamins, and personal care products. Professional pharmacists available for consultation.',
  availableProductsCategories: [
    'All',
    'Medicines',
    'Vitamins & Supplements',
    'Medical Supplies',
    'Baby Care',
    'Personal Care',
    'First Aid',
  ],
  storeProducts: [
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1587854692152-cbe660dbde88',
      ],
      productName: 'Panadol Extra',
      productDescription:
      'Pain relief tablets effective for headaches and fever.',
      productPrice: '30',
      productCurrency: 'EGP',
      productCategory: 'Medicines',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1615461066841-6116e61058f4',
      ],
      productName: 'Vitamin C 1000mg',
      productDescription:
      'High-potency vitamin C tablets to boost immunity.',
      productPrice: '95',
      productCurrency: 'EGP',
      productCategory: 'Vitamins & Supplements',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1580281658629-0f9f2a0c49d5',
      ],
      productName: 'Digital Blood Pressure Monitor',
      productDescription:
      'Accurate digital blood pressure monitor for home use.',
      productPrice: '950',
      productCurrency: 'EGP',
      productCategory: 'Medical Supplies',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1598970434795-0c54fe7c0642',
      ],
      productName: 'Baby Diapers Size 4',
      productDescription:
      'Soft and comfortable diapers with long-lasting protection.',
      productPrice: '260',
      productCurrency: 'EGP',
      productCategory: 'Baby Care',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1600180758890-6b94519a8ba6',
      ],
      productName: 'Antibacterial Hand Sanitizer',
      productDescription:
      'Kills 99.9% of germs and keeps hands clean and safe.',
      productPrice: '45',
      productCurrency: 'EGP',
      productCategory: 'Personal Care',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1588776814546-1f7c33a66f45',
      ],
      productName: 'First Aid Kit',
      productDescription:
      'Complete first aid kit for home, car, or travel use.',
      productPrice: '180',
      productCurrency: 'EGP',
      productCategory: 'First Aid',
    ),
  ],
  socialMediaLinks: socialDataExample,
  address: 'Nasr City, Abbas El Akkad Street, Cairo, Egypt',
  lat: 30.0561,
  lng: 31.3444,
  phoneNumber: '+201066778899',
  openingHours: "8:00 AM",
  closingHours: "12:00 AM",
  reviewsCount: 912,
  placeStatus: true,
  storeType: "Pharmacy",
  rate: 4.6,
);

final StoreEntity demoClothingStore = StoreEntity(
  storeId: 'fashion_001',
  storeImages: [
    'https://images.unsplash.com/photo-1521335629791-ce4aec67dd47',
    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
    'https://images.unsplash.com/photo-1555529771-35a38f1b9f6c',
  ],
  storeName: 'Urban Style Fashion',
  storeDescription:
      'Trendy fashion destination offering a wide range of men’s, women’s, and kids’ clothing. High-quality fabrics, modern designs, and seasonal collections at affordable prices.',
  availableProductsCategories: [
    'All',
    'Men',
    'Women',
    'Kids',
    'Shoes',
    'Accessories',
  ],
  storeProducts: [
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1521336575822-6da63fb45455',
      ],
      productName: 'Men Classic Denim Jacket',
      productDescription: 'Stylish blue denim jacket with a modern slim fit.',
      productPrice: '850',
      productCurrency: 'EGP',
      productCategory: 'Men',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2',
      ],
      productName: 'Women Summer Dress',
      productDescription:
          'Lightweight floral dress perfect for summer outings.',
      productPrice: '720',
      productCurrency: 'EGP',
      productCategory: 'Women',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1519744792095-2f2205e87b6f',
      ],
      productName: 'Kids Cotton T-Shirt',
      productDescription: 'Soft and comfortable cotton t-shirt for kids.',
      productPrice: '180',
      productCurrency: 'EGP',
      productCategory: 'Kids',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1528701800489-20be3c5b6e12',
      ],
      productName: 'Leather Sneakers',
      productDescription:
          'Premium leather sneakers suitable for everyday wear.',
      productPrice: '1100',
      productCurrency: 'EGP',
      productCategory: 'Shoes',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1520975922071-a3bfc1cdbf39',
      ],
      productName: 'Women Handbag',
      productDescription: 'Elegant handbag with spacious compartments.',
      productPrice: '950',
      productCurrency: 'EGP',
      productCategory: 'Accessories',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
      ],
      productName: 'Men Casual Shirt',
      productDescription: 'Comfortable casual shirt suitable for daily wear.',
      productPrice: '420',
      productCurrency: 'EGP',
      productCategory: 'Men',
    ),
  ],
  socialMediaLinks: socialDataExample,
  address: 'City Stars Mall, Nasr City, Cairo, Egypt',
  lat: 30.0730,
  lng: 31.3460,
  phoneNumber: '+201122334455',
  openingHours: "10:00 AM",
  closingHours: "11:00 PM",
  reviewsCount: 564,
  placeStatus: true,
  storeType: "Clothing Store",
  rate: 4.3,
);

final StoreEntity demoSuperMarket = StoreEntity(
  storeId: 'market_001',
  storeImages: [
    'https://images.unsplash.com/photo-1580910051074-7a1f8b2c2a7c',
    'https://images.unsplash.com/photo-1542838132-92c53300491e',
    'https://images.unsplash.com/photo-1604719312566-8912e9227c6a',
  ],
  storeName: 'FreshMart Hyper Market',
  storeDescription:
      'A one-stop destination for all your daily needs. Fresh groceries, vegetables, fruits, dairy products, household essentials, and imported goods at competitive prices.',
  availableProductsCategories: [
    'All',
    'Groceries',
    'Fruits & Vegetables',
    'Dairy',
    'Bakery',
    'Beverages',
    'Household',
  ],
  storeProducts: [
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1542838132-92c53300491e',
      ],
      productName: 'Fresh Apples (1 Kg)',
      productDescription:
          'High-quality fresh red apples sourced from local farms.',
      productPrice: '35',
      productCurrency: 'EGP',
      productCategory: 'Fruits & Vegetables',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1580910051074-7a1f8b2c2a7c',
      ],
      productName: 'Organic Milk 1L',
      productDescription: 'Pure organic milk, rich in calcium and vitamins.',
      productPrice: '28',
      productCurrency: 'EGP',
      productCategory: 'Dairy',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1604719312566-8912e9227c6a',
      ],
      productName: 'Whole Wheat Bread',
      productDescription: 'Freshly baked whole wheat bread, soft and healthy.',
      productPrice: '12',
      productCurrency: 'EGP',
      productCategory: 'Bakery',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1585238342028-6e0f7b4b30d7',
      ],
      productName: 'Orange Juice 1L',
      productDescription: 'Freshly squeezed orange juice with no added sugar.',
      productPrice: '25',
      productCurrency: 'EGP',
      productCategory: 'Beverages',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1581579186989-6c7a93b5d0b4',
      ],
      productName: 'Laundry Detergent 2.5Kg',
      productDescription:
          'Powerful detergent for deep cleaning and fresh scent.',
      productPrice: '110',
      productCurrency: 'EGP',
      productCategory: 'Household',
    ),
    StoreProductEntity(
      productImages: [
        'https://images.unsplash.com/photo-1580910051074-7a1f8b2c2a7c',
      ],
      productName: 'Cheddar Cheese 200g',
      productDescription:
          'Rich and creamy cheddar cheese, perfect for sandwiches.',
      productPrice: '45',
      productCurrency: 'EGP',
      productCategory: 'Dairy',
    ),
  ],
  socialMediaLinks: socialDataExample,
  address: 'Mall of Egypt, 6th of October City, Giza, Egypt',
  lat: 29.9730,
  lng: 30.9466,
  phoneNumber: '+201155443322',
  openingHours: "8:00 AM",
  closingHours: "12:00 AM",
  reviewsCount: 842,
  placeStatus: true,
  storeType: "Supermarket",
  rate: 4.4,
);

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
  socialMediaLinks: socialDataExample,
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

final ClinicEntity clinicExample = ClinicEntity(
  availableSlots: clinicAvailableTimes,
  clinicType: "skin care",
  clinicId: "clinic_001",
  clinicName: "Skin Care Clinic",
  clinicImages: [
    "https://images.unsplash.com/photo-1588776814546-1ffcf47267a5",
    "https://images.unsplash.com/photo-1579154204601-01588f351e67",
    "https://images.unsplash.com/photo-1580281657521-8e7b2f8b5b99",
  ],
  rate: 4.3,
  reviewsCount: 128,
  clinicDescription:
      "Specialized clinic offering advanced skin care and cosmetic treatments using the latest medical technologies.",
  socialMediaLinks: socialDataExample,
  address: "15 Zamalek Street, Cairo, Egypt",
  lat: 29.9482089,
  lng: 31.0241436,
  phoneNumber: "+20 102 345 6789",
  openingHours: "09:00 AM",
  closingHours: "10:00 PM",
  placeStatus: true,
  clinicServices: clinicServicesExample,
);
final List<ClinicService> clinicServicesExample = [
  ClinicService(
    serviceName: "Laser Hair Removal",
    serviceDescription:
        "Advanced laser technology for safe and long-lasting hair removal suitable for all skin types.",
    serviceTime: "45 minutes",
    servicePrice: 500.0,
  ),
  ClinicService(
    serviceName: "Skin Deep Cleaning",
    serviceDescription:
        "Professional facial cleansing to remove impurities, blackheads, and improve skin texture.",
    serviceTime: "30 minutes",
    servicePrice: 300.0,
  ),
  ClinicService(
    serviceName: "Acne Treatment",
    serviceDescription:
        "Medical treatment plan to reduce acne, inflammation, and prevent future breakouts.",
    serviceTime: "40 minutes",
    servicePrice: 400.0,
  ),
  ClinicService(
    serviceName: "Chemical Peeling",
    serviceDescription:
        "Chemical exfoliation procedure to rejuvenate skin, reduce pigmentation, and improve glow.",
    serviceTime: "35 minutes",
    servicePrice: 450.0,
  ),
];
final List<SocialData> socialDataExample = [
  SocialData(
    socialMedia: SocialMedia.facebook,
    link: "https://instagram.com/skincareclinic",
  ),
  SocialData(
    socialMedia: SocialMedia.instagram,
    link: "https://instagram.com/skincareclinic",
  ),
  SocialData(
    socialMedia: SocialMedia.tiktok,
    link: "https://instagram.com/skincareclinic",
  ),
  SocialData(
    socialMedia: SocialMedia.linkedin,
    link: "https://instagram.com/skincareclinic",
  ),
];

final List<ClinicAvailableTime> clinicAvailableTimes = [
  ClinicAvailableTime(time: "09:00", amPm: "AM", isAvailable: false),
  ClinicAvailableTime(time: "09:30", amPm: "AM", isAvailable: false),
  ClinicAvailableTime(time: "10:00", amPm: "AM", isAvailable: true),
  ClinicAvailableTime(time: "10:30", amPm: "AM", isAvailable: true),
  ClinicAvailableTime(time: "11:00", amPm: "AM", isAvailable: false),
  ClinicAvailableTime(time: "11:30", amPm: "AM", isAvailable: true),
  ClinicAvailableTime(time: "12:00", amPm: "PM", isAvailable: true),
  ClinicAvailableTime(time: "12:30", amPm: "PM", isAvailable: false),
  ClinicAvailableTime(time: "01:00", amPm: "PM", isAvailable: true),
  ClinicAvailableTime(time: "01:30", amPm: "PM", isAvailable: true),
];

final GenericEntity barberShopExample = GenericEntity(
  genericPlaceId: "barber_001",
  genericPlaceName: "Kings Barber Shop",
  genericPlaceType: "Barbershop",
  genericPlaceImages: [
    "https://images.unsplash.com/photo-1503951914875-452162b0f3f1",
    "https://images.unsplash.com/photo-1593702282069-90b2e2c1c6b7",
    "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9",
  ],
  rate: 4.7,
  reviewsCount: 342,
  genericPlaceDescription:
      "Kings Barber Shop offers premium grooming services including haircuts, beard styling, and hot towel shaves. Our professional barbers provide a modern experience in a classic atmosphere.",
  socialMediaLinks: [
    SocialData(
      socialMedia: SocialMedia.facebook,
      link: "https://www.facebook.com/kingsbarbershop",
    ),
    SocialData(
      socialMedia: SocialMedia.instagram,
      link: "https://www.instagram.com/kingsbarbershop",
    ),
    SocialData(
      socialMedia: SocialMedia.tiktok,
      link: "https://www.tiktok.com/@kingsbarbershop",
    ),
  ],
  address: "25 El Batal Ahmed Abdel Aziz St, Mohandessin, Giza, Egypt",
  lat: 30.047998,
  lng: 31.200742,
  phoneNumber: "+20 101 234 5678",
  placeStatus: true, // open
  amenityList: [
    Amenity.freeWifi,
    Amenity.airConditioned,
    Amenity.waitingArea,
    Amenity.acceptsCards,
    Amenity.parking,
    Amenity.onlineBooking,
  ],
  openingDayHourList: [
    OpeningDayHour(
      dayName: "Saturday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Sunday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Monday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Tuesday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Wednesday",
      opensAt: "10:00 AM",
      closedAt: "11:00 PM",
    ),
    OpeningDayHour(
      dayName: "Thursday",
      opensAt: "10:00 AM",
      closedAt: "12:00 AM",
    ),
    OpeningDayHour(
      dayName: "Friday",
      opensAt: "02:00 PM",
      closedAt: "12:00 AM",
    ),
  ],
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
          StoreMainWidget(storeEntity: demoPharmacyStore),
          // GenericMainWidget(genericEntity:barberShopExample ),
          SizedBox(
            width: double.infinity,
            child: Positioned(top: 200, child: PlacesTopBar()),
          ),
        ],
      ),
    );
  }
}

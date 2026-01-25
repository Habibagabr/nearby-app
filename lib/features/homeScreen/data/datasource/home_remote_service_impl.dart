import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/homeScreen/data/datasource/home_remote_service.dart';
import 'package:near_buy_gp/features/homeScreen/data/models/nearby_places_model.dart';
import 'package:dio/dio.dart';

const List<NearbyPlaceModel> nearbyPlacesMock = [
  NearbyPlaceModel(
    mainImage: "",
    id: '1',
    name: 'Costa Coffee',
    category: 'cafe',
    description:
        'International coffee shop offering premium coffee and desserts.',
    address: 'Mall of Egypt, 6th of October',
    rating: 4.5,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Coffee', 'Desserts', 'Wi-Fi', 'Takeaway'],
    lat: 29.932848523370154,
    lng:  31.02229750250379, status: 'opened',
    type: '',
  ),

  NearbyPlaceModel(
      mainImage: "",
      status: 'opened',
    id: '2',
    name: 'McDonald’s',
    category: 'cafe',
    description: 'Popular fast food restaurant serving burgers and fries.',
    address: 'Sheikh Zayed, Giza',
    rating: 4.2,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Burgers', 'Delivery', 'Kids Meals'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
      type: ''
  ),

  NearbyPlaceModel(
      mainImage: "",
      status: 'opened',
    id: '3',
    name: 'City Pharmacy',
    category: 'cafe',
    description: '24/7 pharmacy providing medicines and health products.',
    address: 'Haram Street, Giza',
    rating: 4.6,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Medicines', 'Medical Supplies', 'Home Delivery'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
      type: ''
  ),

  NearbyPlaceModel(
      mainImage: "",
      status: 'opened',
    id: '4',
    name: 'Gold’s Gym',
    category: 'cafe',
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
    lat: 29.96280478624338,
    lng: 31.048943534109487,
      type: ''
  ),

  NearbyPlaceModel(
      mainImage: "",
      status: 'opened',
    id: '5',
    name: 'Pizza Hut',
    category: 'cafe',
    description: 'Pizza restaurant offering dine-in and delivery options.',
    address: 'Faisal Street, Giza',
    rating: 4.1,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Pizza', 'Delivery', 'Dine-in'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
      type: ''
  ),

  NearbyPlaceModel(
      mainImage: "",

      status: 'opened',
    id: '6',
    name: 'Orange Mobile Store',
    category: 'cafe',
    description: 'Official Orange store for mobile services and devices.',
    address: 'Mall of Arabia, Giza',
    rating: 4.3,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['SIM Cards', 'Mobile Phones', 'Customer Support'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
      type: ''
  ),

  NearbyPlaceModel(
      mainImage: "",
      status: 'opened',
    id: '7',
    name: 'Royal Beauty Salon',
    category: 'cafe',
    description: 'Professional beauty salon for hair and skincare.',
    address: 'Dokki, Giza',
    rating: 4.8,
    imageUrls: ['https://example.com/salon1.jpg'],
    servicesProvided: ['Hair Styling', 'Makeup', 'Skin Care'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
      type: ''
  ),

  NearbyPlaceModel(
      mainImage: "",
      status: 'opened',
    id: '8',
    name: 'Car Care Center',
    category: 'cafe',
    description: 'Car wash and maintenance services.',
    address: 'Ring Road, Giza',
    rating: 4.0,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Car Wash', 'Oil Change', 'Tire Services'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
      type: ''
  ),

  NearbyPlaceModel(
      mainImage: "",
      status: 'opened',
    id: '9',
    name: 'Alpha Medical Lab',
    category: 'cafe',
    description: 'Medical laboratory providing diagnostic tests.',
    address: 'Mohandessin, Giza',
    rating: 4.9,
    imageUrls: ['https://example.com/lab1.jpg'],
    servicesProvided: ['Blood Tests', 'PCR Tests', 'Home Visit'],
    lat: 29.96280478624338,
    lng: 31.048943534109487,
      type: ''
  ),

  NearbyPlaceModel(
      mainImage: "",
      status: 'opened',
    id: '10',
    name: 'Spinneys Market',
    category: 'cafe',
    description: 'Supermarket offering fresh food and groceries.',
    address: 'Sheikh Zayed, Giza',
    rating: 4.4,
    imageUrls: [
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
      'https://res.cloudinary.com/da7zzomwl/image/upload/v1768605857/images_yyarid.jpg',
    ],
    servicesProvided: ['Groceries', 'Fresh Produce', 'Online Ordering'],
    lat: 29.961281408621428,
    lng: 31.04866114616476,
      type: ''
  ),
];

@LazySingleton(as: HomeRemoteService)
class HomeRemoteServiceImpl implements HomeRemoteService {
  final Dio dio ;
  HomeRemoteServiceImpl(this.dio);

  @override
  Future<Either<Exception, List<NearbyPlaceModel>>> getPlacesInBounds(
      double west,
      double north,
      double east,
      double south,
      ) async {
    try {
      return Right(nearbyPlacesMock);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<NearbyPlaceModel>>> getNearbyPlaces(
      {required double lat, required double lng , required int pageNum , required int limit}) async {
    try {
      final result = await dio.get(
        "/api/business/nearby",
        queryParameters: {
          'lat': lat,
          'lng': lng,
          'page':pageNum,
          'limit':limit
        },
        options: Options(extra: {'requiresToken': false}),
      );

      final Map<String, dynamic> responseBody = result.data;

      final List<dynamic> businessList = responseBody['businesses'];



      final List<NearbyPlaceModel> places = businessList
          .map((json) => NearbyPlaceModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(places);
    } on DioException catch (e) {
      return Left(Exception(e.message ?? "Connection Error"));
    } catch (e) {
      return Left(Exception("Unexpected Error: ${e.toString()}"));
    }
  }
}

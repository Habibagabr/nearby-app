// pre information " once app installed all thing in assets go to the internal phone memory " disk "
// MarkerIconsCache Purpose :
// to change from assets resource which is located on the internal memory of the phone to the RAM
// once the screen is loaded we will call the loadIcons function which will get from internal to RAM
// if user move , we won't access the disk again to get the asset we will get to the RAM


import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:near_buy_gp/features/location/domain/entities/place_category.dart';

class MarkerIconsCache{

  // singleton ? -> to keep just a one cache place
  MarkerIconsCache._();

  static final MarkerIconsCache instance = MarkerIconsCache._();
  final Map<String, BitmapDescriptor> _cachedIcons  = {};

  Future<void> loadIcons() async{
    if (_cachedIcons.isNotEmpty) return;
    for(var category in PlaceCategory.values){
      _cachedIcons[category.label] = await BitmapDescriptor.asset(
        const ImageConfiguration(
          size: Size(100,100)
        ),
        'assets/images/markers/${category.label}.png',
      );
    }
  }

  BitmapDescriptor getIcon(String category) {
    return _cachedIcons[category] ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
  }


}
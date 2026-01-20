import 'package:near_buy_gp/core/location/domain/entities/user_location_entity.dart';

class UserLocationModel {
  final double latitude;
  final double longitude;
  UserLocationModel({required this.latitude, required this.longitude});

  UserLocationEntity toEntity(){
    return UserLocationEntity(latitude: latitude, longitude: longitude);
  }


}

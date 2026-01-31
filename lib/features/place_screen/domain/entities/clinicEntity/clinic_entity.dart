import 'package:near_buy_gp/features/place_screen/domain/entities/clinicEntity/clinic_available_time.dart';

import '../commonEntities/social_entity.dart';
import 'clinic_service.dart';

class ClinicEntity {
  final String clinicId;
  final List<String> clinicImages;
  final String clinicName;
  final String clinicType;
  final int reviewsCount;
  final double rate;
  final String clinicDescription;
  final List<SocialData> socialMediaLinks;
  final String address;
  final double lat;
  final double lng;
  final String phoneNumber;
  final String openingHours;
  final String closingHours;
  final bool placeStatus;
  final List<ClinicService> clinicServices;
  final List<ClinicAvailableTime> availableSlots;

  ClinicEntity({
    required this.rate,
    required this.clinicId,
    required this.clinicImages,
    required this.clinicName,
    required this.clinicDescription,
    required this.socialMediaLinks,
    required this.address,
    required this.lat,
    required this.lng,
    required this.phoneNumber,
    required this.reviewsCount,
    required this.openingHours,
    required this.closingHours,
    required this.placeStatus,
    required this.clinicServices,
    required this.clinicType,
    required this.availableSlots
  });
}

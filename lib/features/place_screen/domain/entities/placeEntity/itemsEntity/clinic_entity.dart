import '../item_attribute_entity.dart';

class ClinicServiceEntity extends ItemAttributesEntity {
  final String doctorName;
  final String? doctorSpecialization;
  final String? waitingPeriod;

  const ClinicServiceEntity({
    required this.doctorName,
    this.doctorSpecialization,
    this.waitingPeriod,
  });
}

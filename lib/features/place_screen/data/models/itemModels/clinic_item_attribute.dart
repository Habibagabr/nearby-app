import '../item_attribute_model.dart';

class ClinicServiceAttributes extends ItemAttributesModel {
  final String doctorName;
  final String? doctorSpecialization;
  final String? waitingPeriod;

  const ClinicServiceAttributes({
    required this.doctorName,
    this.doctorSpecialization,
    this.waitingPeriod,
  });

  factory ClinicServiceAttributes.fromJson(Map<String, dynamic> json) {
    return ClinicServiceAttributes(
      doctorName: json['doctorName'],
      doctorSpecialization: json['doctorSpecialization'],
      waitingPeriod: json['waitingPeriod'],
    );
  }
}

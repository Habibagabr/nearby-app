import '../../../domain/entities/placeEntity/itemsEntity/clinic_entity.dart';
import '../../models/attributeModels/clinic_item_attribute.dart';

extension ClinicServiceMapper on ClinicServiceAttributes {
  ClinicServiceEntity toEntity() {
    return ClinicServiceEntity(
      doctorName: doctorName,
      doctorSpecialization: doctorSpecialization,
      waitingPeriod: waitingPeriod,
    );
  }
}

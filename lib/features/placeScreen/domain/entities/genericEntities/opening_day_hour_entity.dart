import 'package:near_buy_gp/features/placeScreen/domain/entities/placeEntity/working_hour_entity.dart';

class OpeningDayHour {
  final String dayName;
  final String opensAt;
  final String closedAt;

  OpeningDayHour({
    required this.dayName,
    required this.opensAt,
    required this.closedAt,
  });

  /// Converts a list of WorkingHourEntity into a list of OpeningDayHour
  static List<OpeningDayHour> fromWorkingHourToOpeningDayHour(
      List<WorkingHourEntity> workingHourEntities) {
    return workingHourEntities.map((entity) {
      return OpeningDayHour(
        dayName: entity.day ?? "-",
        opensAt: entity.from ?? "-",
        closedAt: entity.to ?? "-",
      );
    }).toList();
  }
}

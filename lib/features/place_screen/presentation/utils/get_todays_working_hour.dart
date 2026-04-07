import 'package:intl/intl.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/working_hour_entity.dart';

String getTodayWorkingHours(List<WorkingHourEntity> workingHours) {
  final today = DateFormat('EEEE').format(DateTime.now());
  print("today is : $today");

  final todayHours = workingHours.firstWhere(
        (e) => (e.day?.trim().toLowerCase() ?? '') == today.toLowerCase(),
    orElse: () => const WorkingHourEntity(isClosed: false),
  );

  if (todayHours.from == null ||
      todayHours.to == null ||
      todayHours.isClosed == true) {
    return "Closed";
  }

  DateTime parseTime(String time) {
    final parts = time.split(":");
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return DateTime(0, 1, 1, hour, minute);
  }

  final fromTime = parseTime(todayHours.from!);
  final toTime = parseTime(todayHours.to!);

  final timeFormat = DateFormat.jm();
  return "${timeFormat.format(fromTime)} : ${timeFormat.format(toTime)}";
}

import 'package:intl/intl.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/working_hour_entity.dart';

String getTodayWorkingHours(List<WorkingHourEntity> workingHours) {
  // Get today's full weekday name, e.g., "Monday"
  final today = DateFormat('EEEE').format(DateTime.now());

  // Find the WorkingHourEntity for today
  final todayHours = workingHours.firstWhere(
        (e) => e.day?.toLowerCase() == today.toLowerCase(),
    orElse: () => const WorkingHourEntity(isOpened: false),
  );

  // If there is no opening time or is closed
  if (todayHours.from == null ||
      todayHours.to == null ||
      todayHours.isOpened == false) {
    return "Closed";
  }

  // Parse the 24-hour time strings
  DateTime parseTime(String time) {
    final parts = time.split(":");
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return DateTime(0, 1, 1, hour, minute);
  }

  final fromTime = parseTime(todayHours.from!);
  final toTime = parseTime(todayHours.to!);

  // Format as 12-hour AM/PM
  final timeFormat = DateFormat.jm(); // e.g., 3:00 PM
  final fromStr = timeFormat.format(fromTime);
  final toStr = timeFormat.format(toTime);

  return "$fromStr to $toStr";
}

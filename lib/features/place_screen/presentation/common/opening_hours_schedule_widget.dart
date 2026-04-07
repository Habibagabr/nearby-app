import 'package:flutter/material.dart';

import '../../domain/entities/genericEntities/opening_day_hour_entity.dart';

import 'package:intl/intl.dart';

class OpeningHoursSchedule extends StatelessWidget {
  final List<OpeningDayHour> openingHours;

  const OpeningHoursSchedule({super.key, required this.openingHours});

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat(
      'EEEE',
    ).format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10),
          ],
        ),
        child: Column(
          children: openingHours.map((day) {
            final bool isToday = day.dayName == today;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Day name
                  Row(
                    children: [
                      Text(
                        day.dayName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isToday
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isToday
                              ? Colors.black
                              : const Color(0xFF6B7280),
                        ),
                      ),
                      if (isToday) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Today",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Time
                  Text(
                    "${day.opensAt} - ${day.closedAt}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isToday ? FontWeight.w600 : FontWeight.w500,
                      color: isToday ? Colors.black : const Color(0xFF6B7280) ,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

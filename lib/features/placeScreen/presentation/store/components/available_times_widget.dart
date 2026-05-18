import 'package:flutter/material.dart';

class ClinicAvailableTime {
  final String time;
  final String amPm;
  final bool isAvailable;

  ClinicAvailableTime({
    required this.time,
    required this.amPm,
    required this.isAvailable,
  });
}

class AvailableTimesWidget extends StatelessWidget {
  final List<ClinicAvailableTime> availableTimesList;
  const AvailableTimesWidget({super.key , required this.availableTimesList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.directional(start: 12 , top: 12),
      child : Wrap(
        spacing: 18,
      runSpacing: 10,
      children: List.generate(availableTimesList.length, (index) {
        final item = availableTimesList[index];
        final isSelected = item.isAvailable;
        return Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: _backgroundColor(item, isSelected),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: _borderColor(item, isSelected),
                width: 2,
              ),
            ),
            child: Text(
              "${item.time} ${item.amPm}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _textColor(item, isSelected),
              ),
            ),
        );
      })
      ),
    );
  }

  //  Helpers for colors
  Color _backgroundColor(ClinicAvailableTime item, bool isSelected) {
    if (!item.isAvailable) return Colors.grey.shade200;
    if (isSelected) return Colors.black;
    return Colors.white;
  }

  Color _borderColor(ClinicAvailableTime item, bool isSelected) {
    if (!item.isAvailable) return Colors.transparent;
    if (isSelected) return Colors.black;
    return Colors.grey.shade300;
  }

  Color _textColor(ClinicAvailableTime item, bool isSelected) {
    if (!item.isAvailable) return Colors.grey;
    if (isSelected) return Colors.white;
    return Colors.black;
  }
}

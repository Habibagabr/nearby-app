import 'package:flutter/material.dart';

/// Returns a contrasting text/icon color based on the background
Color getStatusTextColor(String status) {
  switch (status.toLowerCase()) {
    case "open":
      return Colors.green[800]!;
    case "closed":
      return Colors.red[800]!;
    default:
      return Colors.orange[800]!;
  }
}

/// Returns a background color based on the status
Color getStatusBackgroundColor(String status) {
  switch (status.toLowerCase()) {
    case "open":
      return const Color(0xFFDFF7E8);
    case "closed":
      return const Color(0xFFFDE2E2);
    default:
      return const Color(0xFFDFF7E8);
  }
}


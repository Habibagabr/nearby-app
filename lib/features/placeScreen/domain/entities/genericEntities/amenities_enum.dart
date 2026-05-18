import 'package:flutter/material.dart';

enum Amenity {
  freeWifi(
    label: "Free Wi-Fi",
    icon: Icons.wifi,
  ),
  accessibility(
    label: "Accessible",
    icon: Icons.accessible,
  ),
  parking(
    label: "Parking Available",
    icon: Icons.local_parking,
  ),
  airConditioned(
    label: "Air Conditioned",
    icon: Icons.ac_unit,
  ),
  waitingArea(
    label: "Waiting Area",
    icon: Icons.chair,
  ),
  kidsFriendly(
    label: "Kids Friendly",
    icon: Icons.child_friendly,
  ),
  onlineBooking(
    label: "Online Booking",
    icon: Icons.calendar_month,
  ),
  acceptsCards(
    label: "Cards Accepted",
    icon: Icons.credit_card,
  ),
  security(
    label: "24/7 Security",
    icon: Icons.security,
  ),
  elevator(
    label: "Elevator",
    icon: Icons.elevator,
  ),
  restroom(
    label: "Restroom",
    icon: Icons.wc,
  ),
  wheelchairAccess(
    label: "Wheelchair Access",
    icon: Icons.accessible_forward,
  );

  final String label;
  final IconData icon;

  const Amenity({
    required this.label,
    required this.icon,
  });
}

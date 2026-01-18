import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// map must takes the user lat and lng to open the camera
// by default " no location permission granted " --> cairo
Widget getMap({double? lat, double? lng}) {
  return GoogleMap(
    initialCameraPosition: CameraPosition(
      target: LatLng(lat ?? 30.04625080064965, lng ?? 31.233872391418398),
    ),
    mapType: MapType.normal,
    mapToolbarEnabled: true,
    myLocationEnabled: true,
  );
}

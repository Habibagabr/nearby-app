
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// map must takes the user lat and lng to open the camera
// by default " no location permission granted " --> cairo

// so no thing using controller " no logic need it " will give error
// as all of the other logical functions waits for the complete signal which is fires after the map creation

late final Completer<GoogleMapController> _controller;

Widget getMap({double? lat, double? lng}) {
  return GoogleMap(
    initialCameraPosition: CameraPosition(
      target: LatLng(lat ?? 30.04625080064965, lng ?? 31.233872391418398),
    ),
    mapType: MapType.normal,
    mapToolbarEnabled: true,
    myLocationEnabled: true,
    onMapCreated: (GoogleMapController controller){
      _controller.complete(controller);
    },
  );
}

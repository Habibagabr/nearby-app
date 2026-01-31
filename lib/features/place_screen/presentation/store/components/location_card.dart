import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapCard extends StatelessWidget {
  final double lat;
  final double lng;
  final String address;

  const LocationMapCard({
    super.key,
    required this.lat,
    required this.lng,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
      child:Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity/2,
        child:Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: SizedBox(
              height: 160,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("clinic"),
                    position: LatLng(lat, lng),
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                liteModeEnabled: true,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    address,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    )
    );
  }
}

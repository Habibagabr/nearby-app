import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/place_screen/presentation/common/place_services_header.dart';
import 'package:readmore/readmore.dart';

import '../utils/building_rates_starts.dart';
import '../utils/get_status_color.dart';
import '../utils/open_dialer.dart';
import '../utils/open_maps.dart';
import 'communication_icon.dart';

class PlaceDescriptionWidget extends StatelessWidget {
  final String placeName;
  final String placeDescription;
  final String placeStatus;
  final String placeType;
  final String workingHours;
  final double rate;
  final String phoneNumber;
  final double lat;
  final double lng;

  const PlaceDescriptionWidget({
    super.key,
    required this.placeName,
    required this.placeDescription,
    required this.placeStatus,
    required this.placeType,
    required this.rate,
    required this.workingHours,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Place name
        ServicesHeader(headerText: placeName),
        const SizedBox(height: 12),

        // Place type
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            placeType,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Place description
        ReadMoreText(
          placeDescription,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show more',
          trimExpandedText: ' Show less',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: AppColors.darkGray.withOpacity(0.6),
          ),
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGray,
          ),
          lessStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 12),

        // Place rate
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRatingStars(rate),
            const SizedBox(width: 4),
            Text(
              rate.toStringAsFixed(1),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.darkGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: getStatusBackgroundColor(placeStatus),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 18,
                    color: getStatusTextColor(placeStatus),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    placeStatus,
                    style: TextStyle(
                      color: getStatusTextColor(placeStatus),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              workingHours,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: AppColors.darkGray.withOpacity(0.9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Communication icons
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       CommunicationIcon(
        //         iconImage: const Icon(Icons.phone),
        //         onIconPressed: () {
        //           openDialer(phoneNumber);
        //         },
        //         iconName: "call",
        //       ),
        //       CommunicationIcon(
        //         iconImage: const Icon(Icons.directions),
        //         onIconPressed: () {
        //           openMaps(lat, lng);
        //         },
        //         iconName: "direction",
        //       ),
        //       CommunicationIcon(
        //         iconImage: const Icon(Icons.share),
        //         onIconPressed: () {},
        //         iconName: "share",
        //       ),
        //       CommunicationIcon(
        //         iconImage: const Icon(Icons.bookmark),
        //         onIconPressed: () {},
        //         iconName: "save",
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

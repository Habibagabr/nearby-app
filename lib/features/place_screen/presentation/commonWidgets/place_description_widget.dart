import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:readmore/readmore.dart';

import 'communication_icon.dart';

class PlaceDescriptionWidget extends StatelessWidget {
  final String storeName;
  final int reviewsCount;
  final String storeDescription;
  final bool placeStatus;
  final String storeType;
  final String openingHours;
  final String closingHours;
  final double rate;
  //
  const PlaceDescriptionWidget({
    super.key,
    required this.storeName,
    required this.openingHours,
    required this.reviewsCount,
    required this.placeStatus,
    required this.storeDescription,
    required this.closingHours,
    required this.storeType,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // place name
        Text(
          storeName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: AppColors.darkGray,
          ),
        ),
        SizedBox(height: 6),
        // place type
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            storeType,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
        ),
        SizedBox(height: 6),
        //place description
        ReadMoreText(
          storeDescription,
          trimLines: 2,
          // This mode ensures it cuts based on line count, not character count
          trimMode: TrimMode.Line,
          // This adds the '...' automatically
          trimCollapsedText: ' Show more',
          trimExpandedText: ' Show less',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: AppColors.darkGray.withAlpha(150),
          ),
          // Style the clickable 'Show more' text differently so users know it's a link
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGray, // Or your app's main color
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGray,
          ),
        ),
        SizedBox(height: 6),
        // place rate and reviews count
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildRatingStars(rate),
            SizedBox(width: 4),
            Text(
              rate.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.darkGray,
              ),
            ),
            SizedBox(width: 4),
            Text(
              "($reviewsCount reviews)",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: AppColors.darkGray.withAlpha(225),
              ),
            ),
          ],
        ),
        // the place time
        SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color:  (placeStatus) ? Color(0xFFDFF7E8) : Color(0xFFFDE2E2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Icon(
                    Icons.access_time,
                    size: 18,
                    color:  (placeStatus) ?  Color(0xFF1B8E3E) : Color(0xFFD32F2F),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    (placeStatus) ? "Open Now" : "Closed Now",
                    style:  TextStyle(
                      color:  (placeStatus) ?  Color(0xFF1B8E3E) : Color(0xFFD32F2F),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Text(
              "$openingHours - $closingHours",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: AppColors.darkGray.withAlpha(225),
              ),

            )

          ],
        ),
        SizedBox(height: 12),
        Padding(
    padding: EdgeInsetsGeometry.only(left: 20,right: 20),
    child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommunicationIcon(iconImage: Icon(Icons.phone), onIconPressed: (){}, iconName: "call"),
            CommunicationIcon(iconImage: Icon(Icons.directions), onIconPressed: (){}, iconName: "direction"),
            CommunicationIcon(iconImage: Icon(Icons.share), onIconPressed: (){}, iconName: "share"),
            CommunicationIcon(iconImage: Icon(Icons.bookmark), onIconPressed: (){}, iconName: "save"),
          ],
        )
        )
      ],
    );
  }
}

Widget buildRatingStars(double rate, {double iconSize = 20}) {
  List<Widget> stars = [];

  // Loop through 5 stars
  for (int i = 1; i <= 5; i++) {
    if (rate >= i) {
      // Full star
      stars.add(Icon(Icons.star, color: Colors.amber, size: iconSize));
    } else if (rate > i - 1 && rate < i) {
      // Half star
      stars.add(Icon(Icons.star_half, color: Colors.amber, size: iconSize));
    } else {
      // Empty star
      stars.add(Icon(Icons.star_border, color: Colors.amber, size: iconSize));
    }
  }

  return Row(mainAxisSize: MainAxisSize.min, children: stars);
}

import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/place_screen/presentation/common/place_services_header.dart';
import 'package:readmore/readmore.dart';

import 'communication_icon.dart';

class PlaceDescriptionWidget extends StatelessWidget {
  final String placeName;
  final int reviewsCount;
  final String placeDescription;
  final bool placeStatus;
  final String placeType;
  final String ? openingHours;
  final String ? closingHours;
  final double rate;
  //
  const PlaceDescriptionWidget({
    super.key,
    required this.placeName,
     this.openingHours,
    required this.reviewsCount,
    required this.placeStatus,
    required this.placeDescription,
     this.closingHours,
    required this.placeType,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // place name
        ServicesHeader(
          headerText: placeName,
        ),
        // place type
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            placeType,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
        ),
        //place description
        ReadMoreText(
          placeDescription,
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
        if(openingHours != null && closingHours !=null)
          Row(
          spacing: 10,
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

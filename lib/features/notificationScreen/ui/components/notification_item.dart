import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/notificationScreen/domain/entities/notification_entity.dart';

import '../../../../core/themes/app_colors.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity? notification;

  const NotificationItem({super.key, this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsetsGeometry.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                notification!.productImage,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            // Right Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Pushes the text to the top and the footer row to the bottom
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 1. Top Content (RichText)
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          color: AppColors.darkGray,
                          fontSize: 16,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: notification?.productName ?? "This product",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: " from"),
                           TextSpan(
                            text: " ${notification?.placeLocation ?? "this store"} ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                           TextSpan(text: notification?.notificationTitle ?? "this news"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // 2. Bottom Footer (Location + Time)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Location Left
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                            const SizedBox(width: 4),
                            Text(
                              notification?.placeLocation ?? "This place",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Time Right
                         Text(
                          notification?.notificationTime ?? "This time",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

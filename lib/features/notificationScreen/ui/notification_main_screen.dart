import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/routing/app_routes.dart';
import 'package:near_buy_gp/features/notificationScreen/domain/entities/notification_entity.dart';
import '../../../core/themes/app_colors.dart';
import 'components/notification_sheet_period.dart';

class NotificationMainScreen extends StatelessWidget {
  NotificationMainScreen({super.key});

  final List<Map<String, List<NotificationEntity>>> notificationExamples = [
    {
      "Today": [
        NotificationEntity(
          productName: "Green Army Jacket",
          placeLocation: "LoLo",
          productImage:
              'https://res.cloudinary.com/da7zzomwl/image/upload/v1773533274/Screenshot_2026-03-15_020635_p4vp8h.png',

          notificationTime: "2h",
          notificationTitle: "is Restored Again , Get it before any one Else",
        ),
        NotificationEntity(
          productName: "Green Army Jacket",
          placeLocation: "H&M",
          productImage:
              'https://res.cloudinary.com/da7zzomwl/image/upload/v1773533274/Screenshot_2026-03-15_020635_p4vp8h.png',
          notificationTime: "2h",
          notificationTitle: "is Restored Again , Get it before any one Else",
        ),
      ],
    },
    {
      "Yesterday": [
        NotificationEntity(
          productName: "Green Army Jacket",
          placeLocation: "KOKO",
          productImage:
              'https://res.cloudinary.com/da7zzomwl/image/upload/v1773533274/Screenshot_2026-03-15_020635_p4vp8h.png',
          notificationTime: "2h",
          notificationTitle: "is Restored Again , Get it before any one Else",
        ),
      ],
    },
    {
      "This Week": [
        NotificationEntity(
          productName: "Green Army Jacket",
          placeLocation: "H&M",
          productImage:
              'https://res.cloudinary.com/da7zzomwl/image/upload/v1773533274/Screenshot_2026-03-15_020635_p4vp8h.png',
          notificationTime: "2h",
          notificationTitle: "is Restored Again , Get it before any one Else",
        ),
        NotificationEntity(
          productName: "Green Army Jacket",
          placeLocation: "H&M",
          productImage:
              'https://res.cloudinary.com/da7zzomwl/image/upload/v1773533274/Screenshot_2026-03-15_020635_p4vp8h.png',
          notificationTime: "2h",
          notificationTitle: "is Restored Again , Get it before any one Else",
        ),

        NotificationEntity(
          productName: "Green Army Jacket",
          placeLocation: "H&M",
          productImage:
              'https://res.cloudinary.com/da7zzomwl/image/upload/v1773533274/Screenshot_2026-03-15_020635_p4vp8h.png',
          notificationTime: "2h",
          notificationTitle: "is Restored Again , Get it before any one Else",
        ),

        NotificationEntity(
          productName: "Green Army Jacket",
          placeLocation: "H&M",
          productImage:
              'https://res.cloudinary.com/da7zzomwl/image/upload/v1773533274/Screenshot_2026-03-15_020635_p4vp8h.png',
          notificationTime: "2h",
          notificationTitle: "is Restored Again , Get it before any one Else",
        ),
        NotificationEntity(
          productName: "Green Army Jacket",
          placeLocation: "H&M",
          productImage:
              'https://res.cloudinary.com/da7zzomwl/image/upload/v1773533274/Screenshot_2026-03-15_020635_p4vp8h.png',
          notificationTime: "2h",
          notificationTitle: "is Restored Again , Get it before any one Else",
        ),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            iconSize: 26,
            onPressed: () {},
            color: AppColors.white,
          ),
          const SizedBox(width: 8),
        ],

        titleSpacing: 10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            MainShellRoute().go(context);
          },
          iconSize: 26,
          color: AppColors.white,
        ),
        title: Text("Notifications"),
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColors.darkGray,
      ),
      body: ListView.builder(
        itemCount: notificationExamples.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // 1. The Red Dot
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(width: 12), // Space between dot and text
                  // 2. The Styled Text
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54, // Subtle color for normal text
                        ),
                        children: [
                          TextSpan(text: "You have "),
                          TextSpan(
                            text: "1 New Notification ", // Bolded count
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(text: "for "),
                          TextSpan(
                            text: "Today", // Bolded timeframe
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return NotificationSheet(
              periodTitle: notificationExamples[index - 1].keys.first,
              notifications: notificationExamples[index - 1].values.first,
            );
          }
        },
      ),
    );
  }
}

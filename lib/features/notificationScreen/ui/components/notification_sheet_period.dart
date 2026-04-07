import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/features/notificationScreen/domain/entities/notification_entity.dart';
import 'package:near_buy_gp/features/notificationScreen/ui/components/notification_item.dart';
import 'package:near_buy_gp/shared/components/header_text_style.dart';

class NotificationSheet extends StatelessWidget {
  final String periodTitle;
  final List<NotificationEntity> notifications;

  const NotificationSheet({
    super.key,
    required this.periodTitle,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        children: [
          HeaderText(periodTitle, textColor: AppColors.darkGray),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationItem(notification: notifications[index]);
            },
          ),
        ],
      ),
    );
  }
}

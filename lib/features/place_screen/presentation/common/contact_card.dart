import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

import '../../domain/entities/commonEntities/social_entity.dart';

class ContactCard extends StatelessWidget {
  final SocialData socialData;

  const ContactCard({
    super.key,
    required this.socialData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),

        child:GestureDetector(
      onTap: () => {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
              Image.asset(
                  "assets/images/${socialData.socialMedia.iconName}.png",
                  width: 32,
                  height: 32,
                ),
            const SizedBox(width: 16),

            // Texts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  socialData.socialMedia.iconName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 275,
                  child:Text(
                  socialData.link,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.darkGray,
                  ),
                ),
                )
              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}

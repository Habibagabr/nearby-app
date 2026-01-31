import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/clinicEntity/clinic_service.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/themes/app_colors.dart';

class ServiceWidget extends StatelessWidget {
  final ClinicService clinicService;
  const ServiceWidget({super.key, required this.clinicService});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //service name
          Text(
            clinicService.serviceName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkGray,
            ),
          ),
          // service description
          ReadMoreText(
            clinicService.serviceDescription,
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

          // service time + price
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18,
                      color: AppColors.darkGray,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      clinicService.serviceTime,
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              Text(
                "${clinicService.servicePrice} EGP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.darkGray.withAlpha(225),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

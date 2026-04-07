import 'package:flutter/material.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/place_entity.dart';
import 'package:near_buy_gp/features/place_screen/domain/entities/placeEntity/product_entity.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../domain/entities/clinicEntity/clinic_service.dart';
import '../../../domain/entities/placeEntity/itemsEntity/clinic_entity.dart';

class ServiceWidget extends StatelessWidget {
  final ProductEntity clinicService;

  const ServiceWidget({super.key, required this.clinicService});

  @override
  Widget build(BuildContext context) {
    final attributes = clinicService.attributes as ClinicServiceEntity;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(20),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///  Service Name + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  clinicService.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${clinicService.price} EGP",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Doctor Info
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.lightGray,
                child: Icon(Icons.person, color: Colors.orange, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attributes.doctorName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      attributes.doctorSpecialization ?? "",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Description
          ReadMoreText(
            clinicService.description,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Show more',
            trimExpandedText: ' Show less',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
            moreStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.orange,
            ),
            lessStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.orange,
            ),
          ),

          const SizedBox(height: 14),

          ///  Waiting Time Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.access_time,
                    size: 18, color: Colors.orange),
                const SizedBox(width: 6),
                Text(
                  "Waiting: ${attributes.waitingPeriod}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
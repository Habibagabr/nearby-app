import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:near_buy_gp/core/themes/app_dimen.dart';
import 'package:near_buy_gp/core/themes/app_text_style.dart';
import 'package:near_buy_gp/features/searchScreen/domain/entities/search_response_entity.dart';
import 'package:near_buy_gp/shared/util/screens_enum.dart';

import '../../../../../core/routing/app_routes.dart';

class SearchResultItem extends StatelessWidget {
  final SearchResponseEntity searchResponseEntity;

  const SearchResultItem({super.key, required this.searchResponseEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScreensType screensType = getScreenType(searchResponseEntity.category);
        PlaceDetailsRoute(
          placeId: searchResponseEntity.id,
          screensType: screensType,
        ).push(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.lightGray.withAlpha(112)),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGray.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimens.radiusM),
            topRight: Radius.circular(AppDimens.radiusM),
            bottomRight: Radius.circular(AppDimens.radiusM),
            bottomLeft: Radius.circular(AppDimens.radiusM),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          spacing: AppDimens.spacingS,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                searchResponseEntity.images,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Image.asset(
                  "assets/images/mapbackground.webp",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: AppDimens.paddingM,
                vertical: AppDimens.paddingS
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          searchResponseEntity.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 35,
                        decoration: BoxDecoration(
                          color: searchResponseEntity.isOpenNow
                              ? AppColors.success
                              : AppColors.error,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppDimens.radiusM),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            searchResponseEntity.isOpenNow ? "Open" : "Closed",
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      searchResponseEntity.category,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.darkGray,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: AppDimens.spacingXS,
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.yellow,
                        size: AppDimens.iconExtraSmall,
                      ),
                      Text(
                        (searchResponseEntity.rate == 0.0)
                            ? "0.0"
                            : searchResponseEntity.rate.toString(),
                        style: AppTextStyles.labelMedium,
                      ),
                      SizedBox(width: AppDimens.spacingM),
                      Icon(
                        Icons.directions,
                        color: AppColors.darkGray,
                        size: AppDimens.iconExtraSmall,
                      ),
                      Text(
                        (searchResponseEntity.distance == 0.0)
                            ? "0.0 km"
                            : "${searchResponseEntity.rate.toString()} km",
                        style: AppTextStyles.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NearbyPlaceCard extends StatefulWidget {
  final String name;
  final String category;
  final String description;
  final String address;
  final double rating;
  final List<String> imageUrls;
  final List<String>? servicesProvided;

  const NearbyPlaceCard({
    super.key,
    required this.name,
    required this.category,
    required this.description,
    required this.servicesProvided,
    required this.address,
    required this.imageUrls,
    required this.rating,
  });

  @override
  State<NearbyPlaceCard> createState() => _NearbyPlaceCardState();
}

class _NearbyPlaceCardState extends State<NearbyPlaceCard> {
  int _currentIndex = 0; // State to track current page

  @override
  Widget build(BuildContext context) {
    int starsNumber = widget.rating.toInt();
    bool halfStar = starsNumber.toDouble() != widget.rating;

    return Card(
      surfaceTintColor: AppColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // LEFT SIDE: Image Gallery with Dots
            SizedBox(
              height: 200,
              width: 150,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                    itemCount: widget.imageUrls.length,
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return CachedNetworkImage(
                        imageUrl: widget.imageUrls[index],
                        height: 200,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                      );
                    },
                  ),
                  // DOT INDICATOR
                  if (widget.imageUrls.length >= 1)
                    Positioned(
                      bottom: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.imageUrls.asMap().entries.map((entry) {
                          return Container(
                            width: 6.0,
                            height: 6.0,
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == entry.key
                                  ? AppColors.orange                // Active Dot
                                  : AppColors.white.withAlpha(150), // Inactive Dot (semi-transparent)
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),

            // RIGHT SIDE: Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 0; i < starsNumber; i++)
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                            if (halfStar)
                              const Icon(Icons.star_half, color: Colors.amber, size: 16),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.category,
                      style: TextStyle(color: AppColors.orange, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: TextStyle(color: AppColors.darkGray, fontSize: 12),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red, size: 14),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.address,
                            style: const TextStyle(fontSize: 11, color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.servicesProvided != null && widget.servicesProvided!.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.servicesProvided!.map((service) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.darkGray,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            service,
                            style: const TextStyle(fontSize: 10, color: AppColors.white),
                          ),
                        )).toList(),
                      ),
                    const SizedBox(height: 8),
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

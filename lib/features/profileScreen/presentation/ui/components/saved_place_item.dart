import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:near_buy_gp/core/themes/app_colors.dart';

class SavedPlaceItem extends StatefulWidget {
  final List<String> placeImages;
  final String placeName;
  final String placeCategory;
  const SavedPlaceItem({super.key , required this.placeCategory , required this.placeName , required this.placeImages});

  @override
  State<SavedPlaceItem> createState() => _SavedPlaceItemState();
}

class _SavedPlaceItemState extends State<SavedPlaceItem> {

  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.grey.withAlpha(50),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// Carousel
          Stack(
            children: [
              CarouselSlider.builder(
                itemCount: widget.placeImages.length,
                itemBuilder: (context, index, realIndex) {
                  return SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.placeImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 100,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),

              /// Indicators
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.placeImages.asMap().entries.map((entry) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentIndex == entry.key ? 6 : 4,
                      height: _currentIndex == entry.key ? 6 : 4,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == entry.key
                            ? AppColors.darkGray
                            : AppColors.white.withOpacity(0.6),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Title
          Text(
            widget.placeName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),

          const SizedBox(height: 4),

          /// Subtitle
          Text(
            widget.placeCategory,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

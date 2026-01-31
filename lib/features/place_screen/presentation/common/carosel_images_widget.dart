import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/themes/app_colors.dart';


class CarouselSliderWidget extends StatefulWidget {
  final List<String> images;
  final double height;

  const CarouselSliderWidget({super.key, required this.images , required this.height});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return widget.images.isNotEmpty
        ? Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            return SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: widget.images[index],
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? AppColors.darkGray
                        : AppColors.white.withAlpha(150),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    )
        : SizedBox(
      height: 300,
      child: Image.asset(
        'assets/images/mapbackground.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import 'places_bar.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<String> images;
  final double? height;

  const CarouselSliderWidget({
    super.key,
    required this.images,
    this.height,
  });

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Check if there is exactly one image to disable interaction
    final bool isSingleImage = widget.images.length == 1;

    return widget.images.isNotEmpty
        ? Stack(
            children: [
              // Carousel slider first
              widget.height != null

              // FIXED HEIGHT VERSION
                  ? CarouselSlider.builder(

                itemCount: widget.images.length,

                itemBuilder:
                    (context, index, realIndex) {

                  return SizedBox(
                    width: double.infinity,

                    child: CachedNetworkImage(
                      imageUrl: widget.images[index],

                      fit: BoxFit.cover,

                      placeholder: (context, url) =>
                      const Center(
                        child:
                        CircularProgressIndicator(),
                      ),

                      errorWidget:
                          (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  );
                },

                options: CarouselOptions(
                  height: widget.height,

                  viewportFraction: 1,

                  enableInfiniteScroll:
                  !isSingleImage,

                  scrollPhysics: isSingleImage
                      ? const NeverScrollableScrollPhysics()
                      : const ClampingScrollPhysics(),

                  onPageChanged: (index, reason) {

                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              )

              // DYNAMIC HEIGHT VERSION
                  : SizedBox.expand(
                child: CarouselSlider.builder(

                  itemCount: widget.images.length,

                  itemBuilder:
                      (context, index, realIndex) {

                    return SizedBox.expand(
                      child: CachedNetworkImage(

                        imageUrl:
                        widget.images[index],

                        fit: BoxFit.fill,

                        placeholder:
                            (context, url) =>
                        const Center(
                          child:
                          CircularProgressIndicator(),
                        ),

                        errorWidget:
                            (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    );
                  },

                  options: CarouselOptions(

                    viewportFraction: 1,

                    enableInfiniteScroll:
                    !isSingleImage,

                    scrollPhysics: isSingleImage
                        ? const NeverScrollableScrollPhysics()
                        : const ClampingScrollPhysics(),

                    onPageChanged:
                        (index, reason) {

                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
              // Bottom indicators - Only visible if there are multiple images
              if (!isSingleImage)
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.images.asMap().entries.map((entry) {
                      return Container(
                        width: 6.0,
                        height: 6.0,
                        margin: const EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? AppColors.orange
                              : AppColors.white.withOpacity(0.6),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          )
        : SizedBox(
            height: 300,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/mapbackground.webp',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                // Top bar above carousel
                Positioned(top: 0, left: 0, right: 0, child: PlacesTopBar()),
              ],
            ),
          );
  }
}

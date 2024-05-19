import 'package:app/shared/constant/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarouselSliderView extends StatefulWidget {
  final List<String> images;
  final Function(ImageProvider) onImageTap;

  const ImageCarouselSliderView({
    required this.images,
    required this.onImageTap,
    super.key,
  });

  @override
  State<ImageCarouselSliderView> createState() => _ImageCarouselSliderViewState();
}

class _ImageCarouselSliderViewState extends State<ImageCarouselSliderView> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.images
              .map(
                (image) => InkWell(
                  onTap: () => widget.onImageTap(NetworkImage(image)),
                  child: Image.network(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: AppStyle.publicationDetailsImageCarouselHeight,
            viewportFraction: 1,
            initialPage: _currentImageIndex,
            onPageChanged: (index, _) => _onImageChanged(index),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding16,
              vertical: AppStyle.verticalPadding12,
            ),
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: _currentImageIndex,
                count: widget.images.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppStyle.contrastColor1,
                  dotColor: AppStyle.textColor,
                  dotHeight: AppStyle.horizontalPadding8,
                  dotWidth: AppStyle.horizontalPadding8,
                  spacing: AppStyle.horizontalPadding8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onImageChanged(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }
}

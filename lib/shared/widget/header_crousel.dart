import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const CustomCarousel({
    super.key,
    required this.imageUrls,
  });

  @override
  CustomCarouselState createState() => CustomCarouselState();
}

class CustomCarouselState extends State<CustomCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: widget.imageUrls.map((url) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Handle image tap paths later
                      debugPrint('OK! Image tapped: $url');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200.0,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.imageUrls.map((url) {
                  int index = widget.imageUrls.indexOf(url);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 11.0,
                    height: 11.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? const Color.fromARGB(255, 247, 247, 243)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

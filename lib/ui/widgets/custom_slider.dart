import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomImagesSlider extends StatefulWidget {
  final List<String> images;
   CustomImagesSlider({required this.images,Key? key}) : super(key: key);

  @override
  _CustomImagesSliderState createState() => _CustomImagesSliderState();
}

class _CustomImagesSliderState extends State<CustomImagesSlider> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          options: CarouselOptions(
              height: 220,
              aspectRatio: 2.0,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          itemBuilder: (ctx, index, _) {
            return Container(
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/place_holder_image.png',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                  image: 'image.com',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                      'assets/images/place_holder_image.png',
                      width: size.width,
                      height: size.height,
                      fit: BoxFit.cover),
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.map((b) {
                int index = widget.images.indexOf(b);
                return Container(
                  width: _current == index ? 12 : 8.0,
                  height: _current == index ? 12 : 8.0,
                  //margin: const EdgeInsets.only(top: 10, bottom: 2.0, right: 2, left: 2),
                  margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        /* ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),*/
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Positioned(
            top: 35.0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/Left Arrow.png',
                    width: 15.0,
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/Share Icon.png',
                        width: 21.0,
                        height: 23.0,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Image.asset(
                        'assets/images/Save Icon.png',
                        width: 24.0,
                        height: 22.0,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

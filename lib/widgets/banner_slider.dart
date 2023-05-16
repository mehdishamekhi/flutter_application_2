import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/colors.dart';
import '../data/model/banner.dart';
import 'cahed_image.dart';

class BannerSlider extends StatelessWidget {
  final List<BannersList> bannlist;
  const BannerSlider(this.bannlist, {super.key});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(
      viewportFraction: 0.9,
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
              controller: controller,
              itemCount: bannlist.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: CachedImage(
                    imageurl: bannlist[index].thumbnail,
                    radius: 15,
                  ),
                );
              }),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 4,
              activeDotColor: CustomColor.blue,
              dotColor: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

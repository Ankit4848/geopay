import 'package:carousel_slider/carousel_slider.dart';
import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/home/controller/home_controller.dart';
import 'package:geopay/features/home/data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    CommonController commonController = Get.find();
    return commonController.common.value==null || commonController.common.value!.banners==null?Container():Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {

        if(commonController.common.value!.banners==null)
          {
            return SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 135,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: (commonController.common.value!.banners!.length > 1),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {
                  homeController.changeBannerIndex(index);
                },
                scrollDirection: Axis.horizontal,
              ),
              items: commonController.common.value!.banners!.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          i.image!,
                          height: 117,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
          );},
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            commonController.common.value!.banners!.length,
            (index) {
              return Obx(
                () => Visibility(
                  visible: commonController.common.value!.banners!.length > 1,
                  child: Container(
                    height: homeController.bannerCurrentIndex.value == index
                        ? 6
                        : 6,
                    width: homeController.bannerCurrentIndex.value == index
                        ? 6
                        : 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.bannerCurrentIndex.value == index
                          ? VariableUtilities.theme.primaryColor
                          : const Color(0xFFD9D9D9),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

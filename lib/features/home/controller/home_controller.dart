import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt bannerCurrentIndex = 0.obs;

  void changeBannerIndex(int index) {
    bannerCurrentIndex.value = index;
  }
}

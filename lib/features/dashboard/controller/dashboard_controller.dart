import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  void changeBottomIndex(int index) {
    currentIndex.value = index;
  }

  onBackTap() {
    if (currentIndex.value == 0) {
      SystemNavigator.pop();
    } else {
      currentIndex.value = 0;
    }
    update();
  }
}

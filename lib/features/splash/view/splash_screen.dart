import 'package:fintech/core/core.dart';
import 'package:fintech/features/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/controller/common_controller.dart';

CommonController commonController = Get.find();

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (splashController) {
          return const Offstage();
        },
      ),
    );
  }
}

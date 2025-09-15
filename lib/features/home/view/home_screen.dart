import 'package:fintech/features/common/controller/common_controller.dart';
import 'package:fintech/features/home/widgets/banner_widget.dart';
import 'package:fintech/features/home/widgets/payout_service_card.dart';
import 'package:fintech/features/home/widgets/wallet_service_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CommonController commonController = Get.find();
    commonController.getCountryList(Get.context!);
    commonController.getUserInfo();

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: FadeSlideTransition(
              seconds: 1,
              child: Obx((){
                return DashboardAppbar(
                  imageURl: commonController.userModel.value?.profileImage,
                  name:
                  "${commonController.userModel.value?.firstName ?? 'Jack Sparrow'} ${commonController.userModel.value?.lastName ?? ''}",
                );
              }

              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  FadeSlideTransition(
                    child: Text(
                      'Available Balance',
                      style: FontUtilities.style(
                        fontSize: 15,
                        fontWeight: FWT.regular,
                        fontColor: const Color(0xFF7C7D81),
                      ),
                    ),
                  ),
                  FadeSlideTransition(
                    child: GetBuilder<CommonController>(
                        builder: (commonController) {
                      return Text(
                        '\$${double.parse(commonController.userModel.value?.balance?.toString() ?? '0.0').toStringAsFixed(2)}',
                        style: FontUtilities.style(
                          fontSize: 35,
                          fontWeight: FWT.bold,
                          fontColor: const Color(0xFF1C1E28),
                        ),
                      );
                    }),
                  ),
                  const FadeSlideTransition(child: WalletServiceCard()),
                  const FadeSlideTransition(child: PayoutServiceCard()),
                  FadeSlideTransition(
                    child: GetBuilder<CommonController>(
                        builder: (commonController) {
                          return BannerWidget();
                        }),
                  )
                  ,
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}

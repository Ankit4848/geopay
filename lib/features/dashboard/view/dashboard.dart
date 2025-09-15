import 'package:fintech/core/core.dart';
import 'package:fintech/features/common/controller/common_controller.dart';
import 'package:fintech/features/dashboard/controller/dashboard_controller.dart';
import 'package:fintech/features/home/view/home_screen.dart';
import 'package:fintech/features/profile/view/profile_screen.dart';
import 'package:fintech/features/transaction_history/view/transaction_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.find();
    return WillPopScope(
      onWillPop: () async {
        dashboardController.onBackTap();
        return false;
      },
      child: Scaffold(
        backgroundColor: VariableUtilities.theme.whiteColor,
        bottomNavigationBar: Obx(
          () => FadeSlideTransition(
            seconds: 1,
            child: BottomBarContainer(
              currentIndex: dashboardController.currentIndex.value,
              onTap: (index) {
                dashboardController.changeBottomIndex(index);
              },
            ),
          ),
        ),
        body: Obx(
              () => dashboardController.currentIndex.value == 0
                  ? const HomeScreen()
                  : const TransactionHistoryScreen(),
        ),

      ),
    );
  }
}

import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/dashboard/controller/dashboard_controller.dart';
import 'package:geopay/features/profile/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';

class ProfileController extends GetxController {
  ProfileRepo profileRepo = ProfileRepo();
  CommonController commonController = Get.find();
  DashboardController dashboardController = Get.find();
  void onFAQSearch(String value) {}

  // LogOutUser
  Future<void> logOutUser(BuildContext context,bool isLogout) async {
    try {
      EasyLoading.show();
      FocusScope.of(context).requestFocus(FocusNode());

      dynamic logOutAPI = await profileRepo.logOutUser(context,isLogout);
      print("LogOut API :: ${logOutAPI}");

      if (logOutAPI != null) {
        commonController.userModel.value = null;
        update();

        SharedPref.setUserToken('');

        // ⚠️ DO NOT use preferences.clear()
        // Instead remove only necessary keys
        VariableUtilities.preferences.remove('user_token');
        VariableUtilities.preferences.remove('user_id');

        SharedPref.setUserFirstTimeStatus();

        dashboardController.changeBottomIndex(0);
        commonController.update();

        Get.offAllNamed(RouteUtilities.loginScreen);
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }

    update();
  }

}

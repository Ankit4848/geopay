import 'package:fintech/config/config.dart';
import 'package:fintech/features/authentication/pages/register/controller/register_controller.dart';
import 'package:fintech/features/common/controller/common_controller.dart';
import 'package:fintech/features/home/model/CommonModel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../authentication/repo/authentication_repo.dart';
import '../../common/model/user_model.dart';

class SplashController extends GetxController {
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  CommonController commonController = Get.find();
  RegisterController registerController = Get.find();
  @override
  void onInit() async {
    bool isFirstTime = await SharedPref.isUserFirstTime();
    //  Get.offAllNamed(RouteUtilities.dashboard);
    getCommonData();
    if (isFirstTime) {
      Get.offAllNamed(RouteUtilities.onBoardingScreen);
    } else {
      String token = await SharedPref.getUserToken() ?? '';
      if (token.isNotEmpty) {
        getUserInfo();
      } else {
        Get.offAllNamed(
          RouteUtilities.loginScreen,
        );
      }
      super.onInit();
    }
  }

  // Get UserInfo
  Future<void> getUserInfo() async {
    try {
      EasyLoading.show();
      UserModel? userModelAPI = await authenticationRepo.getUserInfo(
        Get.context!,
      );
      if (userModelAPI != null) {


        commonController.userModel.value = userModelAPI;
        commonController.update();
        if (commonController.userModel.value!.isKycVerify == 1) {
          print("--------------------------11111111111111111");
          Get.offAllNamed(
            RouteUtilities.dashboard,
          );
        }
        else if (commonController.userModel.value!.isKycVerify != 1 &&
            commonController.userModel.value!.isUploadDocument != 1 &&
            commonController.userModel.value!.isCompany!) {
          print("--------------------------222222222");
          Get.offAllNamed(RouteUtilities.kycScreen);
        }
        else if (commonController.userModel.value!.isKycVerify != 1 &&
            commonController.userModel.value!.isUploadDocument == 1 &&
            commonController.userModel.value!.isCompany!) {
          print("--------------------------333333333333333");
          Get.dialog(
            barrierDismissible: false,
            ResultDialog(
                title: "KYC Processing",
                positiveButtonText: "Close",
                showCloseButton: false,
                onPositveTap: (){
                  SharedPref.setUserToken('');
                  Get.offAllNamed(
                    RouteUtilities.loginScreen,
                  );

                },
                description:
                'Your documents are under review to ensure they meet our verification requirements. we will notify you once the process is completed'),
          );
        }
        else if (commonController.userModel.value!.isKycVerify != 1&&
            commonController.userModel.value!.isCompany==false) {
          print("--------------------------444444444");
          SharedPref.setUserToken('');
          Get.offAllNamed(
            RouteUtilities.loginScreen,
          );
        }
        else {
          print("--------------------------5555555555");
          Get.offAllNamed(
            RouteUtilities.dashboard,
          );
        }

      } else {
        print("--------------------------666666666666");
        Get.offAllNamed(
          RouteUtilities.loginScreen,
        );
      }








    } catch (e) {
      SharedPref.setUserToken('');
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }
  // Get UserInfo
  Future<void> getCommonData() async {
    try {
      EasyLoading.show();
       await commonController.getCommonDetails(
        Get.context!,
      );

    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }
}

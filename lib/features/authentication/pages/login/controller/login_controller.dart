import 'dart:async';
import 'dart:convert';

import 'package:fintech/features/authentication/repo/authentication_repo.dart';
import 'package:fintech/features/profile/controller/profile_controller.dart';
import 'package:fintech/features/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:metamap_plugin_flutter/metamap_plugin_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../common/model/user_model.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  /// 💾 Load saved login info
  Future<void> loadRememberedLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print("sjadkasdkjaskjd");
    final isRemembered = prefs.getBool('remember_me') ?? false;

    print("sjadkasdkjaskjd $isRemembered");
    print("sjadkasdkjaskjd ${prefs.getBool('remember_me')}");
    if (isRemembered) {
      print("sjadkasdkjaskjd");
      print(userNameCtrl.text);
      print(passwordCtrl.text);
      rememberMe.value = true;
      userNameCtrl.text = prefs.getString('email') ?? '';
      passwordCtrl.text = prefs.getString('password') ?? '';
    }
    update();
  }

  var rememberMe = false.obs;

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  RxBool isOccured = true.obs;
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  RxList<String> passwordErrors = <String>[].obs;

  void togglePasswordOccured() {
    isOccured.value = !isOccured.value;

    update();
  }

  //dinesh.softieons@gmail.com

  /// 🔒 Save login info if RememberMe is on
  Future<void> saveRememberedLogin() async {
    final prefs = await SharedPreferences.getInstance();

    print("sjadkasdkjaskjd");

    if (rememberMe.value) {
      print("sjadkasdkjaskjd");
      print(userNameCtrl.text);
      print(passwordCtrl.text);
      await prefs.setBool('remember_me', true);
      await prefs.setString('email', userNameCtrl.text);
      await prefs.setString('password', passwordCtrl.text);
    } else {
      print("sjadkasdkjaskjd");
      await prefs.setBool('remember_me', false);
      await prefs.remove('email');
      await prefs.remove('password');
    }
    update();
  }

  // Login With email and password
  Future<void> loginWithUserNameAndPassword(BuildContext context) async {
    try {
      EasyLoading.show();
      FocusScope.of(context).requestFocus(FocusNode());

      Map<String, dynamic> params = {
        'email': userNameCtrl.text.trim(),
        'password': passwordCtrl.text.trim(),
      };
      UserModel? userModelAPI = await authenticationRepo.loginWithEmailPass(
        context,
        params,
      );
      print("UserModel API :: ${userModelAPI?.toJson()}");
      if (userModelAPI != null) {
        commonController.userModel.value = userModelAPI;
        update();
        SharedPref.setUserToken(commonController.userModel.value?.token ?? '');
        userNameCtrl.clear();
        passwordCtrl.clear();
        commonController.update();
        print("Is Compnay ? : ${commonController.userModel.value!.isCompany}");
        if (commonController.userModel.value!.isCompany == false) {
          if (commonController.userModel.value!.isKycVerify == 1) {
            getCommonData();
            Get.offAllNamed(
              RouteUtilities.dashboard,
            );
          } else if (commonController.userModel.value!.isKycVerify == 0 &&
              (commonController.userModel.value!.metamapStatus ==
                      "reviewNeeded" ||
                  commonController.userModel.value!.metamapStatus ==
                      "verified")) {
            Get.dialog(
                barrierDismissible: false,
                ResultDialog(
                  title: "Thank You For Meta KYC",
                  positiveButtonText: "Close",
                  showCloseButton: false,
                  onPositveTap: () {
                    SharedPref.setUserToken('');
                    Get.offAllNamed(
                      RouteUtilities.loginScreen,
                    );
                  },
                  descriptionWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You’re documents are still under review, If you think the process is taking longer than expected, please reach out to us on the following:",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),),

                      SizedBox(height: 10,),
                      GestureDetector(
                        child: Text("Email : support@geopayments.co",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        child: Text("What\'s app support only:",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                      ),


                    ],
                  ), description: '',
                ));
          } else if (commonController.userModel.value!.isKycVerify == 0 &&
              !(commonController.userModel.value!.metamapStatus ==
                      "reviewNeeded" ||
                  commonController.userModel.value!.metamapStatus ==
                      "verified")) {
            showMetaMapFlow();
          } else {
            getCommonData();
            Get.offAllNamed(
              RouteUtilities.dashboard,
            );
          }
        } else {
          if (commonController.userModel.value!.isKycVerify == 0 &&
              commonController.userModel.value!.isUploadDocument == 0) {
            Get.offAllNamed(
              RouteUtilities.kycScreen,
            );
          } else if (commonController.userModel.value!.isKycVerify == 0 &&
              commonController.userModel.value!.isUploadDocument == 1) {
            ProfileController profileController = Get.find();
            Get.dialog(
              barrierDismissible: false,
              ResultDialog(
                  title: "KYC Processing",
                  positiveButtonText: "Close",
                  showCloseButton: false,
                  onPositveTap: () {
                    SharedPref.setUserToken('');
                    Get.offAllNamed(
                      RouteUtilities.loginScreen,
                    );
                  },
                  description:
                      'Your documents are under review to ensure they meet our verification requirements. we will notify you once the process is completed'),
            );
          } else {
            getCommonData();
            Get.offAllNamed(
              RouteUtilities.dashboard,
            );
          }
        }
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  void showMetaMapFlow() {
    MetaMapFlutter.showMetaMapFlow(
        clientId: "652d932270a904001cdf04c9",
        flowId: "66cc66d6e27531001c7339c6",
        metadata: {
          "user_id": commonController.userModel.value!.id,
          "user_email": commonController.userModel.value!.email
        });
    MetaMapFlutter.resultCompleter.future.then((result) {
      print("result");
      print(result);
      print(result);
      print(result);
      print(result);
      print("result");
      //   if (result != null) {
      Get.dialog(
        barrierDismissible: false,
        ResultDialog(
            title: "KYC Processing",
            positiveButtonText: "Close",
            showCloseButton: false,
            onPositveTap: () {
              SharedPref.setUserToken('');
              Get.offAllNamed(
                RouteUtilities.loginScreen,
              );
            },
            description:
                'Your documents are under review to ensure they meet our verification requirements. we will notify you once the process is completed'),
      );
    });
  }

  void clearData() {
    userNameCtrl.clear();
    passwordCtrl.clear();
  }

  void validatePasswordNew(String value) {
    String emptyPasswordError = 'Please enter Valid password';

    passwordErrors.clear();
    if (value.isEmpty) {
      if (!passwordErrors.contains(emptyPasswordError)) {
        passwordErrors.add(emptyPasswordError);
      } else {
        passwordErrors.remove(emptyPasswordError);
      }
    }
  }

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

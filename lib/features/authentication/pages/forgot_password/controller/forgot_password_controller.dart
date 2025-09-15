import 'dart:async';

import 'package:fintech/features/authentication/repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();
  RxBool isPassObscure = true.obs;
  TextEditingController otpCtrl = TextEditingController();
  StreamController<ErrorAnimationType>? otpVerification;
  RxBool isConfirmPassObscure = true.obs;
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyCreateNewPass = GlobalKey<FormState>();
  void togglePassObscure() {
    isPassObscure.value = !isPassObscure.value;
    update();
  }

  Timer? timer;
  RxInt start = 30.obs;

  // Start Time
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value--;
        }
        update();
      },
    );
  }

  @override
  void onInit() {
    emailCtrl.clear();
    super.onInit();
  }

  void toggleConfirmPassObscure() {
    isConfirmPassObscure.value = !isConfirmPassObscure.value;
    update();
  }

  // Forgot Password
  Future<void> forgotPassword(BuildContext context,
      {bool isResend = false}) async {
    try {
      EasyLoading.show();
      FocusScope.of(context).requestFocus(FocusNode());

      Map<String, dynamic> params = {
        'email': emailCtrl.text.trim(),
      };
      dynamic forgotPasswordAPI = isResend
          ? await authenticationRepo.forgotPasswordResendOTP(context, params)
          : await authenticationRepo.forgotPassword(context, params);
      if (forgotPasswordAPI != null) {
        if (isResend) {
          start.value = 30;
          startTimer();
        } else {
          Get.toNamed(RouteUtilities.otpVerification);
        }


        Get.dialog(
            barrierDismissible: false,
            ResultDialog(
              title: "",
              positiveButtonText: "Dismiss",
              showCloseButton: false,
              onPositveTap: () async {
                Get.back(); // close dialog
              },
              descriptionWidget: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  GestureDetector(
                    child:  Text(forgotPasswordAPI['message'],
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                      ),),
                  ),
                ],
              ), description: '',
            ));


      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  /// Verify Forgot Email
  Future<void> verifyForgotEmail(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (otpCtrl.text.trim().length == 6) {
      try {
        EasyLoading.show();

        Map<String, dynamic> params = {
          'email': emailCtrl.text.trim(),
          'otp': otpCtrl.text.trim(),
        };
        Map<String, dynamic>? apiResponse =
            await authenticationRepo.verifyForgotEmail(context, params);

        if (apiResponse != null) {
          Get.toNamed(RouteUtilities.createPassword);
          update();




          Get.dialog(
              barrierDismissible: false,
              ResultDialog(
                title: "",
                positiveButtonText: "Dismiss",
                showCloseButton: false,
                onPositveTap: () async {
                  Get.back(); // close dialog
                },
                descriptionWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    GestureDetector(
                      child:  Text( apiResponse['message'],
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),),
                    ),
                  ],
                ), description: '',
              ));








        }
      } catch (e) {
        print("Error: ${e}");
      } finally {
        EasyLoading.dismiss();
      }
    } else {

      Get.dialog(
          barrierDismissible: false,
          ResultDialog(
            title: "Error",
            positiveButtonText: "Dismiss",
            showCloseButton: false,
            onPositveTap: () async {
              Get.back(); // close dialog
            },
            descriptionWidget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                GestureDetector(
                  child:  Text( "Please Enter Valid OTP",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),),
                ),
              ],
            ), description: '',
          ));
    }
    update();
  }

  /// Reset Password
  Future<void> resetPassword(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKeyCreateNewPass.currentState!.validate()) {
      try {
        EasyLoading.show();
        Map<String, dynamic> params = {
          'email': emailCtrl.text.trim(),
          'password': passwordCtrl.text.trim(),
          'password_confirmation': confirmPassCtrl.text.trim(),
        };
        Map<String, dynamic>? apiResponse =
            await authenticationRepo.resetPassword(context, params);

        if (apiResponse != null) {
          Get.offAllNamed(RouteUtilities.loginScreen);
          update();


          Get.dialog(
              barrierDismissible: false,
              ResultDialog(
                title: "",
                positiveButtonText: "Dismiss",
                showCloseButton: false,
                onPositveTap: () async {
                  Get.back(); // close dialog
                },
                descriptionWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    GestureDetector(
                      child:  Text( apiResponse['message'],
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),),
                    ),
                  ],
                ), description: '',
              ));





        }
      } catch (e) {
        print("Error: $e");
      } finally {
        EasyLoading.dismiss();
      }
      update();
    }
  }
}

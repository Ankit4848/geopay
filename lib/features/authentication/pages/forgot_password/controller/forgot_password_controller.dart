import 'dart:async';

import 'package:geopay/features/authentication/repo/authentication_repo.dart';
import 'package:geopay/features/home/view/pages/repo/home_repo.dart';
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
      ApiResponse? forgotPasswordAPI = isResend
          ? await authenticationRepo.forgotPasswordResendOTP(context, params)
          : await authenticationRepo.forgotPassword(context, params);
      if (forgotPasswordAPI != null && forgotPasswordAPI.success==true) {
        if (isResend) {
          start.value = 30;
          startTimer();
        } else {
          Get.toNamed(RouteUtilities.otpVerification);
        }


        DialogUtilities.showDialog(
          message: forgotPasswordAPI!.message!,
        );


      }else
        {

          DialogUtilities.showDialog(
            title: "Error",
            message: forgotPasswordAPI!.message!,
          );


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
        ApiResponse? apiResponse =
            await authenticationRepo.verifyForgotEmail(context, params);

        if (apiResponse != null && apiResponse.success == true) {
          Get.toNamed(RouteUtilities.createPassword);
          update();



          DialogUtilities.showDialog(
            message: apiResponse!.message!,
          );



        }else
          {

            DialogUtilities.showDialog(
              title: "Error",
              message: apiResponse!.message!,
            );

          }
      } catch (e) {
        print("Error: ${e}");
      } finally {
        EasyLoading.dismiss();
      }
    } else {

      DialogUtilities.showDialog(
        title: "Error",
        message:    "Please Enter Valid OTP",
      );


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
        ApiResponse? apiResponse =
            await authenticationRepo.resetPassword(context, params);

        if (apiResponse != null && apiResponse.success==true) {
          Get.offAllNamed(RouteUtilities.loginScreen);
          update();

          DialogUtilities.showDialog(
            title: "Error",
            message: apiResponse!.message!,
          );


        }else
        {

          DialogUtilities.showDialog(
            title: "Error",
            message: apiResponse!.message!,
          );

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

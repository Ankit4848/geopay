import 'package:fintech/core/widgets/dialogs/result_dialog.dart';
import 'package:fintech/core/widgets/fancy_snackbar/fancy_snackbar.dart';
import 'package:fintech/features/authentication/repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();
  RxBool isPassObscure = true.obs;
  RxBool isOldPassObscure = true.obs;
  RxBool isConfirmPassObscure = true.obs;
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void togglePassObscure() {
    isPassObscure.value = !isPassObscure.value;
    update();
  }

  void toggleOldPassObscure() {
    isOldPassObscure.value = !isOldPassObscure.value;
    update();
  }

  void toggleConfirmPassObscure() {
    isConfirmPassObscure.value = !isConfirmPassObscure.value;
    update();
  }

  ///Use Reset Password
  Future<void> userResetPassword(BuildContext context) async {



    isPassObscure = true.obs;
    isOldPassObscure = true.obs;
    isConfirmPassObscure = true.obs;




    FocusScope.of(context).requestFocus(FocusNode());
    print("form key validation${formKey.currentState!.validate()}");
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        Map<String, dynamic> params = {
          "old_password": oldPasswordCtrl.text.trim(),
          "password": passwordCtrl.text.trim(),
          "password_confirmation": confirmPassCtrl.text.trim(),
        };

        Map<String, dynamic>? apiResponse =
            await authenticationRepo.profileResetPassword(context, params);

        print("apiResponse");
        print("apiResponse");
        print(apiResponse);
        print(apiResponse);
        print("apiResponse");
        print("apiResponse");


        if (apiResponse!['success'] == true) {
          //Get.back();
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
                      child:  Text(  apiResponse['message'],
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),),
                    ),
                  ],
                ), description: '',
              ));


        }else
          {
            final String allErrors = getAllErrorsAsSingleText(apiResponse);


            ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(
                content:  Text(
                 allErrors,
                  style: const TextStyle(color: Colors.white), // white font
                ),
                backgroundColor: Colors.red, // red background
                duration: const Duration(seconds: 5), // show for 3 seconds
                behavior: SnackBarBehavior.floating, // optional: floating snackbar
              ),
            );

            /*Get.dialog(
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
                        child:  Text(  allErrors,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                      ),
                    ],
                  ), description: '',
                ));*/
          }

      } catch (e) {
        print("Error: $e");
      } finally {
        EasyLoading.dismiss();
      }
      update();
    }
  }
  String getAllErrorsAsSingleText(Map<String, dynamic> apiResponse) {
    final errors = apiResponse['errors'];
    String errorText = '';

    if (errors != null && errors is Map<String, dynamic>) {
      errors.forEach((field, messages) {
        if (messages is List) {
          for (var msg in messages) {
            errorText += "$msg\n";
          }
        }
      });
    }

    return errorText.trim(); // to remove last \n
  }
}

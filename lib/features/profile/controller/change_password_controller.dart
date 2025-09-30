import 'package:geopay/core/widgets/dialogs/dialog_utilities.dart';
import 'package:geopay/core/widgets/dialogs/result_dialog.dart';
import 'package:geopay/core/widgets/fancy_snackbar/fancy_snackbar.dart';
import 'package:geopay/features/authentication/repo/authentication_repo.dart';
import 'package:geopay/features/home/view/pages/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../core/settings/variable_utilities.dart';

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

        ApiResponse? apiResponse =
            await authenticationRepo.profileResetPassword(context, params);

        print("apiResponse");
        print("apiResponse");
        print(apiResponse);
        print(apiResponse);
        print("apiResponse");
        print("apiResponse");


        if (apiResponse!=null && apiResponse.success == true) {
          //Get.back();
          update();

          DialogUtilities.showDialog(

            message:  apiResponse!.message!,
          );




        }else
          {
            final String allErrors = getAllErrorsAsSingleText(apiResponse!.data!);

            DialogUtilities.showDialog(
              title: allErrors,
              message:  "Please select Country code",
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

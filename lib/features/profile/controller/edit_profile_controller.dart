import 'dart:io';

import 'package:geopay/config/config.dart';
import 'package:geopay/core/settings/variable_utilities.dart';
import 'package:geopay/core/widgets/dialogs/dialog_utilities.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/profile/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/model/user_model.dart';

class EditProfileController extends GetxController {
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController dailyWithdrawalCtrl = TextEditingController();
  Rxn<File> profileImage = Rxn();
  Rxn<File> encryptProfileImage = Rxn();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileRepo profileRepo = ProfileRepo();
  CommonController commonController = Get.find();
  pickImage(ImageSource source) async {
    // Use one-time permission access approach
    final ImagePicker picker = ImagePicker();
    try {
      // This will use the system's file picker which doesn't require persistent permissions
      final XFile? image = await picker.pickImage(
        source: source,
        // Ensure we're not requesting storage permissions
        requestFullMetadata: false,
      );
      if (image != null) {
        profileImage.value = File(image.path);
        update();
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Edit Profile
  Future<void> editProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        FocusScope.of(context).requestFocus(FocusNode());

        Map<String, dynamic> params = {
          'first_name': firstNameCtrl.text.trim(),
          'last_name': lastNameCtrl.text.trim(),
        };
        // if (profileImage.value != null) {
        //   params.addAll({
        //     "profile_image":  profileImage.value
        //   });
        //   update();
        // }
        List<File> files = [];
        if (profileImage.value != null) {
          files.add(profileImage.value!);
        }
        UserModel? apiResponse = await profileRepo.editProfile(context, params,
            files: profileImage.value != null ? files : null);
        print("UserModel API :: ${apiResponse?.toJson()}");
        if (apiResponse != null) {
          commonController.userModel.value = apiResponse;
          commonController.update();






          DialogUtilities.showDialog(

            message:   "Your profile has been updated successfully.",
          );

          update();
          EasyLoading.dismiss();

        }
      } catch (e) {
        print("Error: ${e}");
      } finally {
        EasyLoading.dismiss();
      }
    }
    update();
  }
}

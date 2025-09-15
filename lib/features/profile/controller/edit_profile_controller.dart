import 'dart:io';

import 'package:fintech/config/config.dart';
import 'package:fintech/features/common/controller/common_controller.dart';
import 'package:fintech/features/profile/repo/profile_repo.dart';
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
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      profileImage.value = File(image.path);
      update();
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
          update();
          EasyLoading.dismiss();
          Get.back();
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

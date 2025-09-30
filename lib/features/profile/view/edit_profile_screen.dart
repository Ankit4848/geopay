import 'dart:io';

import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/profile/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileController editProfileController =
      Get.find<EditProfileController>();
  CommonController commonController = Get.find();

  @override
  void initState() {
    editProfileController.firstNameCtrl.text =
        commonController.userModel.value?.firstName ?? '';
    editProfileController.lastNameCtrl.text =
        commonController.userModel.value?.lastName ?? '';
    editProfileController.profileImage.value = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: GetBuilder<CommonController>(builder: (commonController) {
        return Column(
          children: [
            CustomAppBar(title: 'My Profile'),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: editProfileController.formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          bottomSheetForSelectImage(context);
                        },
                        child: SizedBox(
                          height: 103,
                          width: 116,
                          child: Obx(
                            () => Stack(
                              children: [
                                Container(
                                  height: 103,
                                  width: 103,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: VariableUtilities
                                          .theme.secondaryColor,
                                      width: 4,
                                    ),
                                  ),
                                  child: editProfileController
                                              .profileImage.value !=
                                          null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(editProfileController
                                                .profileImage.value!.path),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : commonController.userModel.value
                                                  ?.profileImage !=
                                              null
                                          ? ClipOval(
                                              child: CachedNetworkImageView(
                                                imageUrl: commonController
                                                    .userModel
                                                    .value!
                                                    .profileImage!,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : SvgPicture.asset(AssetUtilities
                                              .profilePlaceHolder),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    margin: const EdgeInsets.only(
                                        bottom: 8, right: 8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: VariableUtilities.theme.whiteColor,
                                      border: Border.all(
                                        color: VariableUtilities
                                            .theme.secondaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AssetUtilities.camera,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        controller: editProfileController.firstNameCtrl,
                        labelText: 'First Name',
                        hintText: '',
                        validator: (value) {
                          if (!Validator.isNotNullOrEmpty(value)) {
                            return "First name can't be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: editProfileController.lastNameCtrl,
                        labelText: 'Last Name',
                        validator: (value) {
                          if (!Validator.isNotNullOrEmpty(value)) {
                            return "Last name can't be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: CustomTextField(
                          initialValue:
                              commonController.userModel.value?.email ??
                                  'priiteshsalla@gmail.com',
                          onTap: () {},
                          labelText: 'Email Address',
                          isVerified:
                              commonController.userModel.value?.isEmailVerify ==
                                  1,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: CustomTextField(
                          initialValue: 'KYC Doc Verification',
                          onTap: () {},
                          labelText: 'KYC',
                          isVerified:
                              commonController.userModel.value?.isKycVerify ==
                                  1,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: CustomTextField(
                          initialValue:
                              commonController.userModel.value?.mobileNumber,
                          onTap: () {},
                          labelText: 'Mobile No.',
                          isVerified: commonController
                                  .userModel.value?.isMobileVerify ==
                              1,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: CustomFlatButton(
                onPressed: () {
                  editProfileController.editProfile(context);
                },
                backColor: VariableUtilities.theme.secondaryColor,
                title: "SAVE",
              ),
            ),
          ],
        );
      }),
    );
  }

  void bottomSheetForSelectImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Camera'),
                onTap: () => {
                  Get.back(),
                  editProfileController.pickImage(ImageSource.camera),
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () => {
                  Get.back(),
                  editProfileController.pickImage(ImageSource.gallery),
                },
              ),
            ],
          );
        });
  }
}

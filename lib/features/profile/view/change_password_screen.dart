import 'package:geopay/core/core.dart';
import 'package:geopay/features/profile/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordController changePasswordController = Get.find();
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Form(
        key: changePasswordController.formKey,
        child: Column(
          children: [
            CustomAppBar(
              title: 'Change Password',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    Obx(
                      () => CustomTextField(
                        controller: changePasswordController.oldPasswordCtrl,
                        isObscureText:
                            changePasswordController.isOldPassObscure.value,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Old Password can't be empty";
                          }
                          if (value.trim().length < 8) {
                            return "Password must be at least 8 characters long";
                          }
                          return null;
                        },
                        suffixIcon: InkwellWithRippleEffect(
                          onTap: () {
                            changePasswordController.toggleOldPassObscure();
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                              !changePasswordController.isOldPassObscure.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                        ),
                        hintText: 'Old Password',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => CustomTextField(
                        controller: changePasswordController.passwordCtrl,
                        isObscureText:
                            changePasswordController.isPassObscure.value,
                        validator: (value) {
                          return Validator.validatePassword(value ?? "");
                        },
                        suffixIcon: InkwellWithRippleEffect(
                          onTap: () {
                            changePasswordController.togglePassObscure();
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                              !changePasswordController.isPassObscure.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                        ),
                        hintText: 'New Password',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => CustomTextField(
                        controller: changePasswordController.confirmPassCtrl,
                        isObscureText:
                            changePasswordController.isConfirmPassObscure.value,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Confirm Password can't be empty";
                          }
                          if (value.trim() !=
                              changePasswordController.passwordCtrl.text
                                  .trim()) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        suffixIcon: InkwellWithRippleEffect(
                          onTap: () {
                            changePasswordController.toggleConfirmPassObscure();
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(!changePasswordController
                                  .isConfirmPassObscure.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ),
                        hintText: 'Re-Password ',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteUtilities.forgotPassword);
                          },
                          child: Text(
                            'Forgot password',
                            style: FontUtilities.style(
                                fontSize: 12,
                                fontWeight: FWT.medium,
                                fontColor: VariableUtilities.theme.blackColor),
                          ),
                        )
                      ],
                    ),
                  ],
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
                  changePasswordController.userResetPassword(context);
                },
                backColor: VariableUtilities.theme.secondaryColor,
                title: "SUBMIT",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

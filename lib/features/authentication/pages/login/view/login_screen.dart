// ignore_for_file: unused_local_variable

import 'package:fintech/config/config.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/authentication/pages/login/controller/login_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    loginController.loadRememberedLogin();
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (loginController) {
          return BgContainer(
            child: SafeArea(
              child: Stack(alignment: Alignment.bottomCenter, children: [
                const SizedBox.expand(),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FadeSlideTransition(
                        seconds: 1,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24)),
                            color: VariableUtilities.theme.whiteColor,
                          ),
                          child: Form(
                            key: loginController.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const IndicatorWidget(),
                                const SizedBox(height: 12),
                                FadeSlideTransition(
                                  child: Text(
                                    'Login',
                                    style: FontUtilities.style(
                                        fontSize: 26,
                                        fontColor:
                                        VariableUtilities.theme.thirdColor,
                                        fontWeight: FWT.bold),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                FadeSlideTransition(
                                  child: Text(
                                    'Email',
                                    style: FontUtilities.style(
                                        fontSize: 14,
                                        fontColor:
                                        VariableUtilities.theme.thirdColor,
                                        fontWeight: FWT.semiBold),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                FadeSlideTransition(
                                  child: CustomTextField(
                                    controller: loginController.userNameCtrl,
                                    hintText: 'Please enter your Email',
                                    validator: (value) {
                                      return Validator.validateEmail(context,
                                          email: value ?? '',
                                          showSnack: false);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                FadeSlideTransition(
                                  child: Text(
                                    'Password',
                                    style: FontUtilities.style(
                                        fontSize: 14,
                                        fontColor:
                                        VariableUtilities.theme.thirdColor,
                                        fontWeight: FWT.semiBold),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Obx(
                                      () => FadeSlideTransition(
                                    child: CustomTextField(
                                      controller: loginController.passwordCtrl,
                                      isObscureText:
                                      loginController.isOccured.value,
                                      onChange: (value) {
                                        loginController.validatePasswordNew(
                                            value ??
                                                loginController
                                                    .passwordCtrl.text);
                                      },
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          loginController
                                              .togglePasswordOccured();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Icon(!loginController
                                              .isOccured.value
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined),
                                        ),
                                      ),
                                      validator: (value) {
                                        loginController.validatePasswordNew(
                                            value ??
                                                loginController
                                                    .passwordCtrl.text);
                                        return null;
                                      },
                                      hintText: 'Password',
                                      errorWidget: Obx(
                                            () => loginController
                                            .passwordErrors.isEmpty
                                            ? SizedBox.shrink()
                                            : Column(
                                          children: [
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              itemCount: loginController
                                                  .passwordErrors.length,
                                              itemBuilder:
                                                  (context, index) {
                                                return Text(
                                                  loginController
                                                      .passwordErrors[
                                                  index],
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                    VariableUtilities
                                                        .theme
                                                        .redColor,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),
                                FadeSlideTransition(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              RouteUtilities.forgotPassword);
                                        },
                                        child: Text(
                                          'Forgot password',
                                          style: FontUtilities.style(
                                            fontSize: 12,
                                            fontWeight: FWT.medium,
                                            fontColor: VariableUtilities
                                                .theme.blackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // -- Remember Me Checkbox Here --
                                FadeSlideTransition(
                                  child: Obx(
                                        () => Row(
                                      children: [
                                        Checkbox(
                                          value: loginController.rememberMe.value,
                                          onChanged: (value) {
                                            loginController.toggleRememberMe();
                                          },
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            loginController.toggleRememberMe();
                                          },
                                          child: Text(
                                            'Remember Me',
                                            style: FontUtilities.style(
                                              fontSize: 12,
                                              fontWeight: FWT.medium,
                                              fontColor: VariableUtilities
                                                  .theme.blackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // -- End Remember Me Checkbox --

                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: FadeSlideTransition(
                                    child: CustomFlatButton(
                                      width: MediaQuery.of(context).size.width,
                                      onPressed: () {
                                        if (loginController
                                            .formKey.currentState!
                                            .validate() &&
                                            loginController
                                                .passwordErrors.isEmpty) {
                                          loginController
                                              .isOccured.value=true;
                                          loginController.saveRememberedLogin();
                                          loginController
                                              .loginWithUserNameAndPassword(
                                              context,
                                          );
                                        }
                                      },
                                      backColor: VariableUtilities
                                          .theme.secondaryColor,
                                      title: 'Login',
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Don't have an account? ",
                                        style: FontUtilities.style(
                                            fontSize: 12,
                                            fontWeight: FWT.semiBold),
                                        children: [
                                          TextSpan(
                                            text: "SignUp",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.toNamed(RouteUtilities
                                                    .registerScreen);
                                              },
                                            style: FontUtilities.style(
                                                fontSize: 12,
                                                decoration: TextDecoration
                                                    .underline,
                                                fontColor: VariableUtilities
                                                    .theme.secondaryColor,
                                                fontWeight: FWT.bold)
                                                .copyWith(
                                                decorationColor:
                                                VariableUtilities.theme
                                                    .secondaryColor),
                                          )
                                        ]),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}


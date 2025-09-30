import 'package:geopay/core/core.dart';
import 'package:geopay/features/authentication/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordController forgotPasswordController =
      Get.find<ForgotPasswordController>();

  @override
  void initState() {
    forgotPasswordController.emailCtrl.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BgContainer(
        child: SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox.expand(),
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
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      color: VariableUtilities.theme.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const IndicatorWidget(),
                        const SizedBox(
                          height: 12,
                        ),
                        FadeSlideTransition(
                          child: Text(
                            'Forgot Password',
                            style: FontUtilities.style(
                                fontSize: 26,
                                fontColor: VariableUtilities.theme.thirdColor,
                                fontWeight: FWT.bold,
                                fontFamily: FontFamily.dmSans),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeSlideTransition(
                          child: Text(
                            'It is a long established fact that a reader will be distracted by the readable content.',
                            style: FontUtilities.style(
                              fontSize: 12,
                              fontColor: VariableUtilities.theme.thirdColor,
                              fontWeight: FWT.regular,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        FadeSlideTransition(
                          child: Text(
                            'Email',
                            style: FontUtilities.style(
                                fontSize: 14,
                                fontColor: VariableUtilities.theme.thirdColor,
                                fontWeight: FWT.semiBold),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Form(
                          key: forgotPasswordController.formKey,
                          child: FadeSlideTransition(
                            child: CustomTextField(
                              controller: forgotPasswordController.emailCtrl,
                              hintText: 'Please enter your email ID',
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                return Validator.validateEmail(context,
                                    email: value ?? "", showSnack: false);
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: FadeSlideTransition(
                            child: CustomFlatButton(
                              width: MediaQuery.of(context).size.width,
                              onPressed: () {
                                if (forgotPasswordController
                                    .formKey.currentState!
                                    .validate()) {
                                  forgotPasswordController
                                      .forgotPassword(context);
                                }
                              },
                              backColor: VariableUtilities.theme.primaryColor,
                              title: 'Send',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

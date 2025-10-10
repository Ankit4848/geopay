import 'package:geopay/core/core.dart';
import 'package:geopay/features/authentication/pages/register/widgets/register_company_form.dart';
import 'package:geopay/features/authentication/pages/register/widgets/register_individual_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/navigation/app_route.dart';
import '../controller/register_controller.dart';
import '../widgets/register_both_page_two.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.find();

  @override
  void initState() {
    registerController.clearData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BgContainer(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox.expand(),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  width: size.width,
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.9,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                    color: VariableUtilities.theme.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const IndicatorWidget(),
                      const SizedBox(height: 12),
                      FadeSlideTransition(
                        child: Text(
                          'Register',
                          style: FontUtilities.style(
                            fontSize: 26,
                            fontColor: VariableUtilities.theme.thirdColor,
                            fontWeight: FWT.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Image.asset(AssetUtilities.line),
                      const SizedBox(height: 12),
                      Form(
                        key: registerController.formKey,
                        child: Obx(() {
                          // ✅ Removed Expanded — directly return widget
                          if (registerController.selectedIndex.value == 0) {
                            if (registerController.registerStep.value == 0) {
                              return const RegisterIndividualForm();
                            } else {
                              return const RegisterBothPageForm();
                            }
                          } else {
                            if (registerController.registerStep.value == 0) {
                              return const RegisterCompanyForm();
                            } else {
                              return const RegisterBothPageForm();
                            }
                          }
                        }),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                        child: FadeSlideTransition(
                          child: Visibility(
                            visible:
                            registerController.selectedIndex.value == 0,
                            child: CustomFlatButton(
                              width: size.width,
                              onPressed: () {
                                if (registerController
                                    .registerStep.value ==
                                    0) {
                                  if (registerController
                                      .formKey.currentState!
                                      .validate()) {
                                    if (!registerController
                                        .isEmailVerify.value) {
                                      DialogUtilities.showDialog(
                                        title: "Error",
                                        message:
                                        "Please Verify Your Email",
                                      );
                                    } else if (!registerController
                                        .isPhoneVerify.value) {
                                      DialogUtilities.showDialog(
                                        title: "Error",
                                        message:
                                        "Please Verify Your Phone",
                                      );
                                    } else {
                                      registerController
                                          .registerStep.value = 1;
                                    }
                                  }
                                } else {
                                  if (registerController
                                      .registerStep.value ==
                                      1) {
                                    if (registerController
                                        .formKey.currentState!
                                        .validate()) {
                                      registerController
                                          .registerUser(context);
                                    }
                                  }
                                }
                              },
                              backColor: VariableUtilities
                                  .theme.primaryColor,
                              title: 'REGISTER',
                            ),
                          ),
                        ),
                      )),
                      const SizedBox(height: 20),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "You have an already account? ",
                            style: FontUtilities.style(
                              fontSize: 12,
                              fontWeight: FWT.semiBold,
                            ),
                            children: [
                              TextSpan(
                                text: "SignIn",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
                                style: FontUtilities.style(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  fontColor: VariableUtilities
                                      .theme.secondaryColor,
                                  fontWeight: FWT.bold,
                                ).copyWith(
                                  decorationColor: VariableUtilities
                                      .theme.secondaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

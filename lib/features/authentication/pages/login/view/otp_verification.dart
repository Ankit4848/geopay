import 'package:geopay/core/core.dart';
import 'package:geopay/features/authentication/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  // LoginController loginController = Get.find();
  ForgotPasswordController forgotPasswordController = Get.find();
  @override
  void initState() {
    forgotPasswordController.start.value = 30;
    forgotPasswordController.startTimer();
    forgotPasswordController.otpCtrl.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FadeSlideTransition(
              seconds: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        'Verification',
                        style: FontUtilities.style(
                            fontSize: 26,
                            fontColor: VariableUtilities.theme.thirdColor,
                            fontWeight: FWT.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    FadeSlideTransition(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              'We have send the OTP on ${forgotPasswordController.emailCtrl.text.trim()}',
                              style: FontUtilities.style(
                                fontSize: 12,
                                fontColor: VariableUtilities.theme.thirdColor,
                                fontWeight: FWT.regular,
                                fontFamily: FontFamily.poppins,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: SvgPicture.asset(
                              AssetUtilities.edit,
                              height: 13,
                              width: 13,
                              color: VariableUtilities.theme.secondaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    FadeSlideTransition(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: PinCodeTextField(
                          length: 6,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 45,
                            fieldWidth: 45,
                            borderWidth: 0,
                            activeFillColor:
                                VariableUtilities.theme.textFieldFilledColor,
                            inactiveColor:
                                VariableUtilities.theme.textFieldFilledColor,
                            inactiveFillColor:
                                VariableUtilities.theme.textFieldFilledColor,
                            activeColor:
                                VariableUtilities.theme.textFieldFilledColor,
                            selectedFillColor:
                                VariableUtilities.theme.textFieldFilledColor,
                            selectedColor:
                                VariableUtilities.theme.textFieldFilledColor,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController:
                              forgotPasswordController.otpVerification,
                          textStyle: FontUtilities.style(
                              fontSize: 16,
                              fontColor: VariableUtilities.theme.blackColor,
                              fontWeight: FWT.bold),
                          controller: forgotPasswordController.otpCtrl,
                          onCompleted: (v) {
                            forgotPasswordController.verifyForgotEmail(context);
                          },
                          onChanged: (value) async {
                            forgotPasswordController.otpCtrl.text = value;
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                          appContext: context,
                          cursorColor: VariableUtilities.theme.blackColor,
                          autoDisposeControllers: false,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                    Obx(
                      () => forgotPasswordController.start.value != 0
                          ? Center(
                              child: Text(
                                "Resend OTP in ${forgotPasswordController.start.value.toString()} seconds",
                                style: FontUtilities.style(
                                  fontSize: 12,
                                  fontWeight: FWT.medium,
                                  fontFamily: FontFamily.poppins,
                                ),
                              ),
                            )
                          : Center(
                              child: FadeSlideTransition(
                                child: RichText(
                                  text: TextSpan(
                                    text: "If you didn't receive A code ",
                                    style: FontUtilities.style(
                                      fontSize: 12,
                                      fontWeight: FWT.regular,
                                      fontFamily: FontFamily.poppins,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "resend",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            forgotPasswordController
                                                .forgotPassword(context,
                                                    isResend: true);
                                          },
                                        style: FontUtilities.style(
                                          fontSize: 12,
                                          fontWeight: FWT.regular,
                                          fontColor: const Color(0xFF81A8C7),
                                          fontFamily: FontFamily.poppins,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                            forgotPasswordController.verifyForgotEmail(context);
                            // Get.toNamed(RouteUtilities.createPassword);
                          },
                          backColor: VariableUtilities.theme.primaryColor,
                          title: 'Verify',
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
    );
  }
}

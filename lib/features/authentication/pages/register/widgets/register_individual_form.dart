import 'package:bounce/bounce.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/authentication/pages/register/controller/register_controller.dart';
import 'package:fintech/features/authentication/pages/register/widgets/select_country_dialog.dart';
import 'package:fintech/features/common/controller/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterIndividualForm extends StatelessWidget {
  const RegisterIndividualForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (registerController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Register As',
                style: FontUtilities.style(
                  fontSize: 14,
                  fontWeight: FWT.semiBold,
                  fontFamily: FontFamily.poppins,
                  fontColor: VariableUtilities.theme.primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: FadeSlideTransition(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Offstage(),
                      Bounce(
                        onTap: () {
                          registerController.registerType.value = 0;

                          registerController.update();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 24,
                              width: 24,
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF5F4F4),
                              ),
                              child: registerController.registerType.value == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: VariableUtilities
                                            .theme.secondaryColor,
                                      ),
                                    )
                                  : const Offstage(),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Text(
                                'Individual',
                                style: FontUtilities.style(
                                    fontSize: 12,
                                    fontWeight: FWT.medium,
                                    fontColor:
                                        VariableUtilities.theme.primaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      Bounce(
                        onTap: () {
                          registerController.registerType.value = 1;
                          registerController.update();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 24,
                              width: 24,
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF5F4F4),
                              ),
                              child: registerController.registerType.value == 1
                                  ? Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: VariableUtilities
                                            .theme.secondaryColor,
                                      ),
                                    )
                                  : const Offstage(),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Text(
                                'Company',
                                style: FontUtilities.style(
                                    fontSize: 12,
                                    fontWeight: FWT.medium,
                                    fontColor:
                                        VariableUtilities.theme.primaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Offstage(),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FadeSlideTransition(
                      child: CustomTextField(
                        labelText: 'First Name',
                        controller: registerController.firstNameCtrl,
                        validator: (value) {
                          if (!Validator.isNotNullOrEmpty(value)) {
                            return "First name Can't be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: FadeSlideTransition(
                      child: CustomTextField(
                        labelText: 'Middle Name (Optional)',
                        controller: registerController.middleNameCtrl,

                      ),
                    ),
                  ),
                ],
              ),
             // const SizedBox(height: 16),
              FadeSlideTransition(
                child: CustomTextField(
                  labelText: 'Last Name',
                  controller: registerController.lastNameCtrl,
                  validator: (value) {
                    if (!Validator.isNotNullOrEmpty(value)) {
                      return "Last name Can't be empty";
                    }
                    return null;
                  },
                ),
              ),
              if (registerController.registerType.value == 1)
                Column(
                  children: [
                    //const SizedBox(height: 16),
                    FadeSlideTransition(
                      child: CustomTextField(
                        labelText: 'Company Name',
                        controller: registerController.comanyNameCtrl,
                        validator: (value) {
                          if (!Validator.isNotNullOrEmpty(value)) {
                            return "Company Name Can't be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
             // const SizedBox(height: 16),
              FadeSlideTransition(
                child: CustomTextField(
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  controller: registerController.emailCtrl,
                  onTap: registerController.isEmailVerify.value ? () {} : null,
                  onChange: (value) {
                    if (registerController.isEmailError.value) {
                      registerController.isEmailError.value = false;
                      registerController.update();
                    }
                  },
                  validator: (value) {
                    return Validator.validateEmail(context,
                        email: value ?? '', showSnack: false);
                  },
                  suffixIcon: registerController.isEmailVerify.value
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(
                            Icons.verified_sharp,
                            color: Colors.green,
                          ),
                        )
                      : registerController.isEmailError.value
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (Validator.validateEmail(context,
                                        email:
                                            registerController.emailCtrl.text,
                                        showSnack: false) ==
                                    null) {
                                  registerController
                                      .sendVerificationEmail(context);
                                } else {
                                  Validator.validateEmail(context,
                                      email: registerController.emailCtrl.text,
                                      showSnack: true);
                                }
                              },
                              child:  Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text("Send OTP",style: TextStyle(fontWeight: FontWeight.bold,),),
                              ),
                            ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: registerController.isEmailOTPShow.value &&
                      !registerController.isEmailVerify.value,
                  child: FadeSlideTransition(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                          ),
                          child: PinCodeTextField(
                            readOnly: registerController.isEmailVerify.value,
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
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController:
                                registerController.otpVerification,
                            textStyle: FontUtilities.style(
                                fontSize: 16,
                                fontColor: VariableUtilities.theme.blackColor,
                                fontWeight: FWT.bold),
                            controller: registerController.emailOTPCtrl,
                            onCompleted: (v) {
                              registerController.verifyEmail(context);
                            },
                            onChanged: (value) async {
                              registerController.emailOTPCtrl.text = value;
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                            cursorColor: VariableUtilities.theme.blackColor,
                            autoDisposeControllers: false,
                          ),
                        ).paddingOnly(top: 12),
                        Obx(() => GestureDetector(
                              onTap: () {
                                if (registerController
                                    .isEmailResendEnabled.value) {
                                  registerController.sendVerificationEmail(
                                      context,
                                      isResend: true);
                                }
                              },
                              child: Text(
                                registerController.isEmailResendEnabled.value
                                    ? "Resend OTP"
                                    : "Resend OTP in ${registerController.emailTimerSeconds.value} sec",
                                style: TextStyle(
                                  color: registerController
                                          .isEmailResendEnabled.value
                                      ? VariableUtilities.theme.secondaryColor
                                      : VariableUtilities.theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
             // const SizedBox(height: 20,),
              //Mobile No.
              FadeSlideTransition(
                child: Text(
                  'Mobile No.',
                  style: FontUtilities.style(
                    fontSize: 14,
                    fontWeight: FWT.semiBold,
                    fontFamily: FontFamily.poppins,
                    fontColor: VariableUtilities.theme.primaryColor,
                  ),
                ),
              ),
             // const SizedBox(height: 8,),
              FadeSlideTransition(
                child: Row(
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        // EdgeInsets.only(
                        //     bottom:
                        //         registerController.isPhoneError.value ? 18 : 0),
                        child: GestureDetector(
                          onTap: registerController.isPhoneVerify.value
                              ? null
                              : () {
                                  registerController.searchController.value
                                      .clear();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    useSafeArea: true,
                                    builder: (context) {
                                      return Obx(
                                        () => SelectCountryDialog(
                                          searchController: registerController
                                              .searchController.value,
                                          onClose: () {
                                            registerController
                                                .searchController.value
                                                .clear();
                                          },
                                          onChange: (value) {
                                            registerController
                                                .onCountrySearch(value ?? '');
                                          },
                                          onCountrySelect: (countryModel) {
                                            registerController.selectedCountry
                                                .value = countryModel;
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                          child: Container(
                            height: 46,
                            width: 100,
                            decoration: BoxDecoration(
                              color:
                                  VariableUtilities.theme.textFieldFilledColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (registerController.selectedCountry.value !=
                                    null) ...{
                                  CachedNetworkImageView(
                                    imageUrl: registerController.selectedCountry
                                            .value?.countryFlag ??
                                        '',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Text(registerController
                                            .selectedCountry.value?.isdcode ??
                                        ''),
                                  )
                                }
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: registerController.phoneNumberCtrl,
                        textInputType: TextInputType.phone,
                        onTap: registerController.isPhoneVerify.value
                            ? () {}
                            : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (registerController.selectedCountry.value ==
                              null) {
                            registerController.isPhoneError.value = true;
                            return "Please select country code";
                          }
                          if (value == null || value.trim().isEmpty) {
                            registerController.isPhoneError.value = true;
                            return "Phone number can't be empty";
                          }
                          registerController.isPhoneError.value = false;
                          return null;
                        },
                        onChange: (value) {
                          if (registerController.isPhoneVerifyError.value) {
                            registerController.isPhoneVerifyError.value = false;
                            registerController.update();
                          }
                        },
                        suffixIcon: registerController.isPhoneVerify.value
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                  Icons.verified_sharp,
                                  color: Colors.green,
                                ),
                              )
                            : registerController.isPhoneVerifyError.value
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (registerController
                                              .selectedCountry.value ==
                                          null) {





                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content:  Text(
                                              "Please select Country code",
                                              style: const TextStyle(color: Colors.white), // white font
                                            ),
                                            backgroundColor: Colors.red, // red background
                                            duration: const Duration(seconds: 5), // show for 3 seconds
                                            behavior: SnackBarBehavior.floating, // optional: floating snackbar
                                          ),
                                        );





                                      } else if (registerController
                                          .phoneNumberCtrl.text
                                          .trim()
                                          .isNotEmpty) {
                                        registerController
                                            .sendPhoneVerificationOTP(context);
                                      } else {

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content:  Text(
                                                'Please enter valid mobile number',
                                              style: const TextStyle(color: Colors.white), // white font
                                            ),
                                            backgroundColor: Colors.red, // red background
                                            duration: const Duration(seconds: 5), // show for 3 seconds
                                            behavior: SnackBarBehavior.floating, // optional: floating snackbar
                                          ),
                                        );

                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Text("Send OTP",style: TextStyle(fontWeight: FontWeight.bold,),),
                                    ),
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: registerController.isPhoneOTPShow.value &&
                      !registerController.isPhoneVerify.value,
                  child: FadeSlideTransition(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: PinCodeTextField(
                            readOnly: registerController.isPhoneVerify.value,
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
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController:
                                registerController.otpVerification,
                            textStyle: FontUtilities.style(
                                fontSize: 16,
                                fontColor: VariableUtilities.theme.blackColor,
                                fontWeight: FWT.bold),
                            controller: registerController.phoneOTPCtrl,
                            onCompleted: (v) {
                              registerController.verifyPhone(context);
                            },
                            onChanged: (value) async {
                              registerController.phoneOTPCtrl.text = value;
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                            appContext: context,
                            cursorColor: VariableUtilities.theme.blackColor,
                            autoDisposeControllers: false,
                          ),
                        ).paddingOnly(top: 12),
                        Obx(() => GestureDetector(
                              onTap: () {
                                if (registerController
                                    .isMobileResendEnabled.value) {
                                  registerController.sendPhoneVerificationOTP(
                                      context,
                                      isResend: true);
                                }
                              },
                              child: Text(
                                registerController.isMobileResendEnabled.value
                                    ? "Resend OTP"
                                    : "Resend OTP in ${registerController.mobileTimerSeconds.value} sec",
                                style: TextStyle(
                                  color: registerController
                                          .isMobileResendEnabled.value
                                      ? VariableUtilities.theme.secondaryColor
                                      : VariableUtilities.theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            //  const SizedBox(height: 16),
              Obx(
                () => FadeSlideTransition(
                  child: CustomTextField(
                    controller: registerController.passwordCtrl,
                    isObscureText: registerController.isPassObscure.value,
                    suffixIcon: InkwellWithRippleEffect(
                      onTap: () {
                        registerController.togglePassObscure();
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(!registerController.isPassObscure.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    validator: (value) {
                      return Validator.validatePassword(value ?? '');
                    },
                    labelText: 'Password',
                  ),
                ),
              ),




            Padding(
              padding: const EdgeInsets.only(bottom: 10.0,left: 10,right: 10),
              child: Text("should contain at least one upper case\nshould contain at least one digit\nshould contain at least one Special character\nMust be at least 8 characters in length",
              style: TextStyle(
                fontSize: 10,
                color: Colors.black.withValues(alpha: 0.7)
              ),),
            ),



            //  const SizedBox(height: 16),
              Obx(
                () => FadeSlideTransition(
                  child: CustomTextField(
                    controller: registerController.confirmPasswordCtrl,
                    isObscureText:
                        registerController.isConfirmPassObscure.value,
                    suffixIcon: InkwellWithRippleEffect(
                      onTap: () {
                        registerController.toggleConfirmPassObscure();
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(!registerController.isConfirmPassObscure.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    validator: (value) {
                      return Validator.validateConfirmPassword(context,
                          password: registerController.passwordCtrl.text,
                          confirmPassword: value ?? '',
                          showSnack: false);
                    },
                    labelText: 'Confirm Password',
                  ),
                ),
              ),

             /* FadeSlideTransition(
                child: CustomTextField(
                  labelText: 'Refferal Code',
                  controller: registerController.refferalCodeCtrl,
                ),
              ),*/

              FadeSlideTransition(
                child: Visibility(
                  visible: registerController.selectedIndex.value == 0,
                  child: Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          checkColor: VariableUtilities.theme.whiteColor,
                          activeColor: VariableUtilities.theme.primaryColor,
                          side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide(
                              width: 1.5,
                              color: VariableUtilities.theme.primaryColor,
                            ),
                          ),
                          value: registerController.isTermAccepted.value,
                          onChanged: (value) {
                            registerController.toggleTermAndCondition();
                          },
                        ),
                      ),
                      Expanded(
                          child: Wrap(
                        children: [
                          Text(
                            'I have read the',
                            style: FontUtilities.style(
                              fontSize: 11,
                              fontWeight: FWT.medium,
                              fontColor: VariableUtilities.theme.blackColor,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Bounce(
                            onTap: () {
                              launchUrl(
                                Uri.parse('https://www.softieons.com/'),
                              );
                            },
                            child: Text(
                              'User agreement',
                              style: FontUtilities.style(
                                fontSize: 11,
                                fontWeight: FWT.medium,
                                decoration: TextDecoration.underline,
                                fontColor:
                                    VariableUtilities.theme.secondaryColor,
                              ).copyWith(
                                decorationColor:
                                    VariableUtilities.theme.secondaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'And I accept it',
                            style: FontUtilities.style(
                                fontSize: 11,
                                fontWeight: FWT.medium,
                                fontColor: VariableUtilities.theme.blackColor),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            ],
          );
        },
      ),
    );
  }
}

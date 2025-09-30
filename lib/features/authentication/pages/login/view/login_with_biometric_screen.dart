import 'package:geopay/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginWithBiometricScreen extends StatelessWidget {
  const LoginWithBiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FadeSlideTransition(
            seconds: 1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                color: VariableUtilities.theme.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeSlideTransition(
                      child: SvgPicture.asset(AssetUtilities.fingerprint)),
                  const SizedBox(
                    height: 32,
                  ),
                  FadeSlideTransition(
                    child: Text(
                      'Login With Biometric',
                      style: FontUtilities.style(
                        fontSize: 20,
                        fontWeight: FWT.semiBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FadeSlideTransition(
                      child: Text(
                        'Use your Touch ID for faster, easier access to your account.',
                        textAlign: TextAlign.center,
                        style: FontUtilities.style(
                          fontSize: 14,
                          fontWeight: FWT.regular,
                          fontColor: VariableUtilities.theme.thirdColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: FadeSlideTransition(
                      child: CustomFlatButton(
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          Get.back();
                        },
                        backColor: VariableUtilities.theme.thirdColor,
                        title: 'Login with Username & Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  FadeSlideTransition(
                    child: Image.asset(AssetUtilities.line),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:bounce/bounce.dart';
import 'package:fintech/config/config.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/onboarding/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboaringScreen extends StatelessWidget {
  const OnboaringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<OnboardingController>();
    return BgContainer(
      isVisible: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset(
                AssetUtilities.appLogoImage,
                height: 180,
                width: 180,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: VariableUtilities.theme.thirdColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const IndicatorWidget(),
                const SizedBox(
                  height: 24,
                ),
                FadeSlideTransition(
                  child: Text(
                    'Take control of your finances just your phone',
                    style: FontUtilities.style(
                        fontSize: 26,
                        fontWeight: FWT.bold,
                        fontColor: VariableUtilities.theme.whiteColor),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FadeSlideTransition(
                  child: Text(
                    'Convenience to control and manage your finances in one place to save your time.',
                    style: FontUtilities.style(
                      fontSize: 16,
                      fontWeight: FWT.regular,
                      fontColor: VariableUtilities.theme.offBlueTextColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                FadeSlideTransition(
                  child: Bounce(
                    onTap: () async {
                      await SharedPref.setUserFirstTimeStatus();
                      Get.offAllNamed(RouteUtilities.loginScreen);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: VariableUtilities.theme.offBlueTextColor,
                      ),
                      child: Center(
                        child: Text(
                          'Get started',
                          style: FontUtilities.style(
                              fontSize: 16,
                              fontWeight: FWT.bold,
                              fontColor: VariableUtilities.theme.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fintech/features/kyc/controller/kyc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';

class CompanyStepperWidget extends StatelessWidget {
  final int currentIndex;
  const CompanyStepperWidget({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    KycController kycController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          return Row(
            children: [
              GestureDetector(
                onTap: currentIndex > index
                    ? () {
                        kycController.currentStepIndex.value = index;
                        kycController.update();
                      }
                    : null,
                child: Container(
                  padding: EdgeInsets.all(
                      currentIndex > index || currentIndex == 2 ? 5 : 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex > index || currentIndex == 2
                        ? VariableUtilities.theme.primaryColor
                        : VariableUtilities.theme.whiteColor,
                    border: currentIndex > index || currentIndex == 2
                        ? null
                        : Border.all(
                            color: currentIndex == index
                                ? VariableUtilities.theme.primaryColor
                                : const Color(0xFFD1D5DB),
                            width: 2),
                  ),
                  child: currentIndex > index || currentIndex == 2
                      ? Icon(
                          Icons.check,
                          color: VariableUtilities.theme.whiteColor,
                          size: 18,
                        )
                      : Container(
                          height: 9,
                          width: 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex == index
                                ? VariableUtilities.theme.primaryColor
                                : VariableUtilities.theme.transparent,
                          ),
                        ),
                ),
              ),
              Visibility(
                visible: index != 2,
                child: Container(
                  height: 2,
                  width: Get.width * 0.1,
                  decoration: BoxDecoration(
                    color: currentIndex == index || currentIndex > index
                        ? VariableUtilities.theme.primaryColor
                        : const Color(0xFFD1D5DB),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

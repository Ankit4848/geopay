import 'package:geopay/core/core.dart';
import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/authentication/pages/register/widgets/bank_detail_form.dart';
import 'package:geopay/features/authentication/pages/register/widgets/company_detail_form.dart';
import 'package:geopay/features/authentication/pages/register/widgets/company_stepper_widget.dart';
import 'package:geopay/features/authentication/pages/register/widgets/register_individual_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCompanyForm extends StatelessWidget {
  const RegisterCompanyForm({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterController registerController = Get.find();
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Obx(
              () => FadeSlideTransition(
                child: CompanyStepperWidget(
                  currentIndex: registerController.currentStepIndex.value,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Obx(
              () => FadeSlideTransition(
                child: Text(
                  registerController.currentStepIndex.value == 0
                      ? "Personal Detail"
                      : registerController.currentStepIndex.value == 1
                          ? "Company Detail"
                          : "Bank Detail",
                  style: FontUtilities.style(
                    fontSize: 14,
                    fontColor: VariableUtilities.theme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () {
                if (registerController.currentStepIndex.value == 0) {
                  return const RegisterIndividualForm();
                } else if (registerController.currentStepIndex.value == 1) {
                  return const CompanyDetailForm();
                } else if (registerController.currentStepIndex.value == 2) {
                  return const BankDetailForm();
                }
                return const Offstage();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FadeSlideTransition(
                child: Obx(
                  () => CustomFlatButton(
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      registerController.changeCurrentStep();
                    },
                    backColor: VariableUtilities.theme.primaryColor,
                    title: registerController.currentStepIndex.value == 2
                        ? 'REGISTER'
                        : 'NEXT',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

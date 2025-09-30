import 'package:bounce/bounce.dart';
import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/kyc/controller/kyc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/core.dart';

class BankDetailForm extends StatelessWidget {
  const BankDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterController registerController = Get.find();
    KycController kycController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Obx(() {
          return   FadeSlideTransition(
          child: CustomTextField(
            labelText: 'Bank Name *',
            errorWidget: kycController.fieldErrors['bank_name'] != null?Text(
              kycController.fieldErrors['bank_name']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ):Container(),
            controller: registerController.bankNameCtrl,
            isRequired: true,
            validator: (value) {
              if (!Validator.isNotNullOrEmpty(value)) {
                return "Bank name Can't be empty";
              }
              return null;
            },
          ),
        );}),

        Obx(() {
          return  FadeSlideTransition(
          child: CustomTextField(
            labelText: 'Account NUmber *',
            errorWidget: kycController.fieldErrors['account_number'] != null?Text(
              kycController.fieldErrors['account_number']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ):Container(),
            controller: registerController.accountNoCtrl,
            textInputType:  TextInputType.numberWithOptions(decimal: true),
            isRequired: true,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),],
            validator: (value) {
              if (!Validator.isNotNullOrEmpty(value)) {
                return "Account No. Can't be empty";
              } else if (value!.isNotEmpty) {
                if ((int.parse(value) < 11) || (int.parse(value) > 16)) {
                  return "Please enter valid number";
                }
              }
              return null;
            },
          ),
        );}),

        Obx(() {
          return  FadeSlideTransition(
          child: CustomTextField(
            labelText: 'Bank Code *',
            isRequired: true,
            errorWidget: kycController.fieldErrors['bank_code'] != null?Text(
              kycController.fieldErrors['bank_code']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ):Container(),
            controller: registerController.bankCodeCtrl,
            validator: (value) {
              if (!Validator.isNotNullOrEmpty(value)) {
                return "Bank code Can't be empty";
              }
              return null;
            },
          ),
        );}),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }
}

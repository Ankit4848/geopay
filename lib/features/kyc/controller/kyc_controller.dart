import 'package:geopay/core/validator/validator.dart';
import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/common/repo/common_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';

class KycController extends GetxController {
  RxInt currentStepIndex = 0.obs;
  CommonRepo commonRepo = CommonRepo();
  RegisterController registerController = Get.find();

  changeCurrentStep() async {
    if (currentStepIndex.value < 2) {
      if (currentStepIndex.value == 0) {
        _submitForm();
      }
      if (currentStepIndex.value == 1) {
        _submitForm2();
      }
    } else {
      await registerController.uploadAllFilesToServer().then(
        (value) {
          if (value) {
            currentStepIndex.value = 0;
          }
        },
      );
      // Get.offAllNamed(RouteUtilities.dashboard);
    }
  }

  Future<void> _submitForm() async {
    RegisterController registerController = Get.find();
    if (registerController.selectedBusiness.value == null) {
      return;
    }
    // Build API data
    Map<String, dynamic> requestData = {
      "business_type_id": registerController.selectedBusiness.value == null
          ? ""
          : registerController.selectedBusiness.value!.id.toString(),
      "no_of_director": registerController.numberOfDirectorCntrl.text,
      "business_licence": registerController.comanyNameCtrl.text,
      "postcode": registerController.businessLicenceCtrl.text,
      "company_address": registerController.tinCtrl.text,
      "director_name": registerController.directorNameControllers
          .map((controller) => controller.text)
          .toList(),
      if(registerController.companyDisplayDataModel.value!.companyDetail!=null &&
          registerController.companyDisplayDataModel.value!.companyDetail!.companyDirectors!=null&&
          registerController.companyDisplayDataModel.value!.companyDetail!.companyDirectors!.isNotEmpty)
      "director_id": List.generate(
          registerController.companyDisplayDataModel.value!.companyDetail!.companyDirectors!.length, (index) => registerController.companyDisplayDataModel.value!.companyDetail!.companyDirectors![index].id),
    };




    print("requestData");
    print(requestData);
    print("======================================================");


    final response =
        await commonRepo.getCompanyKycStep1(Get.context!, requestData);

    if (response != null && response!.success == false) {
      if (response.data['errors'] != null) {
        setFieldErrors(response.data['errors']);
      }
    }
    else {
      await registerController.getCompanyKycDetails(Get.context!);
      currentStepIndex.value++;
    }
  }

  Future<void> _submitForm2() async {
    // Build API data
    Map<String, dynamic> requestData = {
      "bank_name": registerController.bankNameCtrl.text,
      "bank_code": registerController.bankCodeCtrl.text,
      "account_number": registerController.accountNoCtrl.text
    };

    print("Final Payload: $requestData");

    final response =
        await commonRepo.getCompanyKycStep2(Get.context!, requestData);

    print("Final response: $response");

    if (response != null && response!.success == false) {
      if (response.data['errors'] != null) {
        setFieldErrors(response.data['errors']);
      }
    } else {
      await registerController.getCompanyKycDetails(Get.context!);
      currentStepIndex.value++;
    }

    // TODO: Call your API here using Dio or http
    // Example: registerController.submitCompanyDetails(requestData);
  }

  var fieldErrors = <String, String>{}.obs;

  void setFieldErrors(Map<String, dynamic> errors) {
    fieldErrors.clear();
    errors.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        fieldErrors[key] = value[0];
      }
    });
  }
}

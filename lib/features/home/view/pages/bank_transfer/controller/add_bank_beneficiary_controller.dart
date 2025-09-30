import 'package:geopay/core/widgets/dialogs/dialog_utilities.dart';
import 'package:geopay/core/widgets/dialogs/result_dialog.dart';
import 'package:geopay/core/widgets/fancy_snackbar/fancy_snackbar.dart';
import 'package:geopay/features/common/repo/common_repo.dart';
import 'package:geopay/features/home/model/drop_down_model.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBBankModel.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBBeneModel.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBCountryModel.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBFieldModel.dart';
import 'package:geopay/features/home/view/pages/momo_transfer/model/MTMCountryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'bank_transfer_controller.dart';

class AddBankBeneficiaryController extends GetxController {
  final selectedCountry = Rxn<TTBCountryModel>();

  RxList<DropDownModel> countryList = <DropDownModel>[].obs;

  final selectedChannel = Rxn<Channels>();

  final selectedBank = Rxn<TTBBankModel>();


  RxList<TTBCountryModel> countryCollectionList = <TTBCountryModel>[].obs;
  RxList<TTBBankModel> bankList = <TTBBankModel>[].obs;

  RxList<DynamicFormField> mobileBeneficiaryList = <DynamicFormField>[].obs;
  CommonRepo commonRepo = CommonRepo();

  final fieldControllers = <String, TextEditingController>{}.obs;
  final Map<String, RxString> dropdownValues = {};

  void createControllersFromFields() {
    for (var field in mobileBeneficiaryList) {
      if (field.inputType == 'text' || field.inputType == 'date') {
        fieldControllers[field.fieldName] = TextEditingController();
      } else if (field.inputType == 'select') {
        dropdownValues[field.fieldName] = ''.obs;
      }
    }
  }

  Future<void> updateControllersFromFields(TTBBeneModel mtmBeneficiaryModel) async {
    final List<String> dataKeys = getMTMDataKeys(mtmBeneficiaryModel);

    for (var country in countryCollectionList) {

      if (country.label.toString() ==
          mtmBeneficiaryModel.data["payoutCountryName"]) {
        selectedCountry.value = country;
      }
    }

    await getTTBBankList();

    for (var country in  bankList) {
      if (country.locationId.toString() ==
          mtmBeneficiaryModel.data["bankId"]) {
        selectedBank.value = country;

      }
    }
    await changeSelectedChannel(selectedBank.value!);
    for (var field in mobileBeneficiaryList) {
      if (dataKeys.contains(field.fieldName)) {
        // match found — update or pre-fill the controller
        fieldControllers[field.fieldName]?.text =
            mtmBeneficiaryModel.data[field.fieldName]?.toString() ??
                '';
        if (field.inputType == "select") {
          dropdownValues[field.fieldName]?.value  =  mtmBeneficiaryModel.data[field.fieldName]?.toString() ??
              '';
        }
      }
    }
    update();
  }

  Future<void> changeSelectedCountry(TTBCountryModel? country) async {
    selectedCountry.value = country;
    await getTTBBankList();
    selectedChannel.value = null;
    selectedBank.value = null;
    update();
  }

  Future<void> changeSelectedChannel(TTBBankModel channel) async {
    selectedBank.value = channel;
    await getTmtoMFieldsViewBaene();
    update();
  }

  var fieldErrors = <String, String>{}.obs;

  Map<String, dynamic> buildFieldParams() {
    final Map<String, dynamic> params = {};
    fieldErrors.clear(); // Clear previous errors

    for (var field in mobileBeneficiaryList) {
      final key = field.fieldName!;
      final value = fieldControllers[key]?.text.trim() ?? '';

      if (field.inputType == "select") {
        final value = dropdownValues[field.fieldName]?.value.trim() ?? '';

        if (field.required == true && value.isEmpty) {
          fieldErrors[key] = '${field.fieldLabel} is required';

          print(fieldErrors[key]);
          print("${field.fieldLabel} is required");
        }
      } else {
        if (field.required == true && value.isEmpty) {
          fieldErrors[key] = '${field.fieldLabel} is required';

          print(fieldErrors[key]);
          print("${field.fieldLabel} is required");
        } else {
          fieldErrors[key] = ""; // No error
          params[key] = value;
        }
      }
    }

    return params;
  }

  Future<void> getCountryList() async {
   // try {
    EasyLoading.show(dismissOnTap: false);
      List<TTBCountryModel>? countryListAPI =
          await commonRepo.getTTBCountryList(Get.context!,false);
      print("UserModel API :: ${countryListAPI}");
      if (countryListAPI != null && countryListAPI.isNotEmpty) {
        countryCollectionList.value = countryListAPI;
        update();
      }
    EasyLoading.dismiss();
   // } catch (e) {
   //   print("Error: ${e}");
  //  } finally {}
    update();
  }

  List<String> getMTMDataKeys(TTBBeneModel model) {
    return model.toDataJson().keys.toList() ?? [];
  }



  Future<void> getTTBBankList() async {
    try {
      EasyLoading.show();
      Map<String, dynamic> params = {
        "payoutCountry": selectedCountry.value!.data,
        "serviceName": selectedCountry.value!.serviceName,
        "payoutIso": selectedCountry.value!.iso,
      };

      print(params);

      final response = await commonRepo.getTTBBankList(
        Get.context!,
        params,
      );

      print("response");
      print(response);

      if (response != null && response.isNotEmpty) {
        bankList.value = response;
        createControllersFromFields();

        update();
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  Future<void> getTmtoMFieldsViewBaene() async {
    try{

      EasyLoading.show();
    Map<String, dynamic> params = {
      "payoutCountry": selectedCountry.value!.data,
      "payoutCurrency": selectedCountry.value!.value,
      "serviceName": selectedCountry.value!.serviceName,
      "locationId": selectedBank.value!.locationId
    };

    print(params);

    final response = await commonRepo.getTTBFieldsViewBene(
      Get.context!,
      params,
    );

    print("response");
    print(response);

    if (response != null && response.isNotEmpty) {
      mobileBeneficiaryList.value = response;
      bankTransferController.selectedBene.value=null;
      createControllersFromFields();

      update();
    }
    }catch(e){}finally{EasyLoading.dismiss();}
    update();
  }

  Future<void> getStoreTransaction() async {
    try{

      EasyLoading.show();

    final Map<String, dynamic> paramss = {};
    for (var field in mobileBeneficiaryList) {
      final key = field.fieldName!;

      String? value = "";
      if (field.inputType == "select") {
        value = dropdownValues[field.fieldName]?.value;
      } else {
        value = fieldControllers[key]?.text ?? '';
      }

      paramss[key] = value;

      if (key.toLowerCase().contains("recipient_mobile")) {
        const keys = "mobile_code";
        final  countryCode= selectedCountry.value != null
            ? "+${selectedCountry.value!.iso}"
            : "";
        paramss[keys] = countryCode; // Combine country code with mobile number

      }
    }

    Map<String, dynamic> params = {
      "category_name": "transfer to bank",
      "payoutCountryName": selectedCountry.value!.label,
      "payoutCountry": selectedCountry.value!.data,
      "payoutCurrency": selectedCountry.value!.value,
      "service_name": selectedCountry.value!.serviceName,
      "bankId": selectedBank.value!.locationId,
      "bankName": selectedBank.value!.locationName,
      "payoutIso": selectedCountry.value!.iso,
    };


    params.addAll(paramss);
    print(params);
    print(params);

    final response = await commonRepo.getTTBFieldsViewBaeneStore(
      Get.context!,
      params,
    );

    print("response");
    print(response);

    if (response != null && response!.success == true) {
      fieldErrors.value.remove("mobile_no");
      EasyLoading.dismiss();
      Get.back();

      Get.dialog(
          barrierDismissible: false,
          ResultDialog(
            title: "Success",
            positiveButtonText: "Dismiss",
            showCloseButton: false,
            onPositveTap: () async {
              Get.back(); // close dialog
            },
            descriptionWidget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                GestureDetector(
                  child:  Text( response!.message!,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),),
                ),
              ],
            ), description: '',
          ));



    } else {






    }
    }catch(e){}
    finally{
      EasyLoading.dismiss();
      isbtnClick.value=false;
    }
    update();
  }
  RxBool isbtnClick=false.obs;
  BankTransferController bankTransferController = Get.find();

  Future<void> getTMtoMBeneUpdateStore(String id) async {
    try {
      EasyLoading.show();
      final Map<String, dynamic> paramss = {};

      for (var field in mobileBeneficiaryList) {
        final key = field.fieldName!;

        String? value = "";
        if (field.inputType == "select") {
          value = dropdownValues[field.fieldName]?.value;
        } else {
          value = fieldControllers[key]?.text ?? '';
        }


        paramss[key] = value;


        if (key.toLowerCase().contains("recipient_mobile")) {
          const keys = "mobile_code";
          final  countryCode= selectedCountry.value != null
              ? "+${selectedCountry.value!.iso}"
              : "";
          paramss[keys] = countryCode; // Combine country code with mobile number

        }







      }

      Map<String, dynamic> params = {
        "category_name": "transfer to bank",
        "payoutCountryName": selectedCountry.value!.label,
        "payoutCountry": selectedCountry.value!.data,
        "payoutCurrency": selectedCountry.value!.value,
        "service_name": selectedCountry.value!.serviceName,
        "bankId": selectedBank.value!.locationId,
        "bankName": selectedBank.value!.locationName,
        "payoutIso": selectedCountry.value!.iso,
      };

      params.addAll(paramss);


      print(params);

      final response =
          await commonRepo.getTTBBeneUpdateStore(Get.context!, params, id);

      print("response");
      print(response);

      if (response != null ) {

        print("response");   print("response");   print("response");


        Get.back();
        await bankTransferController.getTMtoMBeneListStore();

        EasyLoading.dismiss();
      }else
        {

        }
    } catch (e) {
      print("response");   print("response");   print("response");
    } finally {
      EasyLoading.dismiss();
      isbtnClick.value=false;
    }
    update();
  }

  void clearAllFields() {
    selectedCountry.value = null;
    selectedChannel.value = null;
    fieldControllers.clear();
    mobileBeneficiaryList.clear();

    // Also reset any extra values like breakdown info, etc.
  }
}

import 'package:fintech/features/home/model/MobileBeneficiaryModel.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/model/MTMCountryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../../core/widgets/dialogs/result_dialog.dart';
import '../../../../../../core/widgets/fancy_snackbar/fancy_snackbar.dart';
import '../../../../../common/model/CountryCollectionModel.dart';
import '../../../../../common/repo/common_repo.dart';
import '../../../../model/MTMFiledsModel.dart';
import '../../../../model/drop_down_model.dart';
import '../model/MTMBeneficiaryModel.dart';
import 'momo_transfer_controller.dart';

class AddMobileBeneficiaryController extends GetxController {
  final selectedCountry = Rxn<MTMCountryModel>();

  RxList<DropDownModel> countryList = <DropDownModel>[].obs;

  final selectedChannel = Rxn<Channels>();

  MTMBeneficiaryModel? existingModel; // <-- Add this if editing an existing one

  RxList<MTMCountryModel> countryCollectionList = <MTMCountryModel>[].obs;

  RxList<MTMFiledsModel> mobileBeneficiaryList = <MTMFiledsModel>[].obs;
  CommonRepo commonRepo = CommonRepo();

  final fieldControllers = <String, TextEditingController>{}.obs;

  void createControllersFromFields() {
    for (var field in mobileBeneficiaryList) {
      fieldControllers[field.fieldName!] = TextEditingController();
    }
  }

  void updateControllersFromFields(MTMBeneficiaryModel mtmBeneficiaryModel) {
    final List<String> dataKeys = getMTMDataKeys(mtmBeneficiaryModel);


    for (var country in countryCollectionList) {


      if (country.id.toString() ==
          mtmBeneficiaryModel.data!.recipientCountry!) {
        selectedCountry.value = country;
        for (var channel in country.channels!) {
          if (channel.id.toString() == mtmBeneficiaryModel.data!.channelId!) {
            selectedChannel.value = channel;
          }
        }
      }
    }

    for (var field in mobileBeneficiaryList) {
      if (dataKeys.contains(field.fieldName)) {
        // match found — update or pre-fill the controller
        fieldControllers[field.fieldName]?.text =
            mtmBeneficiaryModel.data?.toJson()[field.fieldName]?.toString() ??
                '';
      }
    }
    update();
  }

  void changeSelectedCountry(MTMCountryModel? country) {
    selectedCountry.value = country;
    selectedChannel.value = null;
    print(country?.iso);
    print(country?.iso);
    print(country?.iso);
    print(country?.iso);
    print(country?.iso);
    update();
  }

  void changeSelectedChannel(Channels channel) {
    selectedChannel.value = channel;
    update();
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

  Map<String, dynamic> buildFieldParams() {
    final Map<String, dynamic> params = {};
    fieldErrors.clear(); // Clear previous errors

    for (var field in mobileBeneficiaryList) {
      final key = field.fieldName!;
      final value = fieldControllers[key]?.text.trim() ?? '';

      if (field.required == true && value.isEmpty) {
        fieldErrors[key] = '${field.fieldLabel} is required';


        print( fieldErrors[key] );
        print("${field.fieldLabel} is required");

      } else {
        fieldErrors[key] = ""; // No error
        params[key] = value;
      }
    }


    return params;
  }

  Future<void> getCountryList() async {
    try {
      EasyLoading.show(dismissOnTap: false);
      List<MTMCountryModel>? countryListAPI =
          await commonRepo.getMTMCountryList(Get.context!,false);
      print("UserModel API :: ${countryListAPI}");
      if (countryListAPI != null && countryListAPI.isNotEmpty) {
        countryCollectionList.value = countryListAPI;
        update();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  List<String> getMTMDataKeys(MTMBeneficiaryModel model) {
    return model.data?.toJson().keys.toList() ?? [];
  }

  Future<void> getStoreTransaction() async {
    try {
      EasyLoading.show();
      final Map<String, dynamic> paramss = {};
      for (var field in mobileBeneficiaryList) {
        final key = field.fieldName!;
        final value = fieldControllers[key]?.text ?? '';
        paramss[key] = value;
        if (key.toLowerCase().contains("recipient_mobile") && value.isNotEmpty) {
          final keys = "mobile_code";
          final  countryCode= selectedCountry.value != null
          ? "+${selectedCountry.value!.isdcode}"
         : "";
          paramss[keys] = countryCode; // Combine country code with mobile number

        }

      }

      Map<String, dynamic> params = {
        "recipient_country": selectedCountry.value!.id,
        "channel_id": selectedChannel.value!.id,
        "category_name": "transfer to mobile",
        "service_name": "onafric",
        "recipient_country_code": selectedCountry.value!.iso,
        "recipient_country_name": selectedCountry.value!.name,
        "channel_name": selectedChannel.value!.channel
      };

      params.addAll(paramss);

      print(params);

      final response = await commonRepo.getTmtoMFieldsViewBaeneStore(
        Get.context!,
        params,
      );

      print("response");
      print(response);

      if (response != null && response!.success == true) {
        fieldErrors.value.remove("mobile_no");

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
                    child:  Text(  response.message!,
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
        fieldErrors.value.addAll({"mobile_no": response!.message!});


        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content:  Text(
              response.message!,
              style: const TextStyle(color: Colors.white), // white font
            ),
            backgroundColor: Colors.red, // red background
            duration: const Duration(seconds: 5), // show for 3 seconds
            behavior: SnackBarBehavior.floating, // optional: floating snackbar
          ),
        );
      }
    }catch(e){}
    finally {
      EasyLoading.dismiss();
      isbtnClick.value=false;
    }
    update();
  }

  Future<void> getTmtoMFieldsViewBaene() async {
    try {
      EasyLoading.show();
      Map<String, dynamic> params = {};

      print(params);

      final response = await commonRepo.getTmtoMFieldsViewBaene(
        Get.context!,
        params,
      );

      print("response");
      print(response);

      if (response != null && response.isNotEmpty) {
        mobileBeneficiaryList.value = response;
        createControllersFromFields();
        update();
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }
  RxBool isbtnClick=false.obs;
  MomoTransferController momoTransferController = Get.find();
  Future<void> getTMtoMBeneUpdateStore(String id) async {
    try {
      EasyLoading.show(dismissOnTap: false);
      final Map<String, dynamic> paramss = {};
      for (var field in mobileBeneficiaryList) {
        final key = field.fieldName!;
        final value = fieldControllers[key]?.text ?? '';
        paramss[key] = value;
      }

      Map<String, dynamic> params = {
        "recipient_country": selectedCountry.value!.id,
        "channel_id": selectedChannel.value!.id,
        "category_name": "transfer to mobile",
        "service_name": "onafric",
        "recipient_country_code": selectedCountry.value!.iso,
        "recipient_country_name": selectedCountry.value!.name,
        "channel_name": selectedChannel.value!.channel
      };

      params.addAll(paramss);
    /*  Map<String, dynamic> params = {
        "recipient_country": "23",
        "channel_id": "5",
        "recipient_mobile": "2250505220372",
        "recipient_name": "Ronak",
        "recipient_surname": "ahuja",
        "recipient_address": "",
        "recipient_city": "",
        "recipient_state": "",
        "recipient_postalcode": "",
        "recipient_dateofbirth": "",
        "sender_placeofbirth": "1995-05-10",
        "purposeOfTransfer": "Education",
        "sourceOfFunds": "investment",
        "category_name": "transfer to mobile",
        "service_name": "onafric",
        "recipient_country_code": "BJ",
        "recipient_country_name": "BENIN",
        "channel_name": "MTN"
      };*/

      print(params);

      final response = await commonRepo.getTMtoMBeneUpdateStore(
        Get.context!,
        params,
        id
      );

      print("response");
      print("response");
      print("response");
      print("response");
      print("response");
      print(response);

      if (response != null && response.success==true) {
        print("response");
        print("response");
        print("response");
        print("response");

        await momoTransferController.changeSelectedCountry(momoTransferController.selectedCountry.value);
        momoTransferController.update();
        momoTransferController.selectedBene.value=null;
        update();
        Get.back();
      }
    } catch (e) {
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
  }
}

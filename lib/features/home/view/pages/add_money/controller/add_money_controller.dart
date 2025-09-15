import 'package:fintech/core/widgets/dialogs/result_dialog.dart';
import 'package:fintech/core/widgets/fancy_snackbar/fancy_snackbar.dart';
import 'package:fintech/features/home/data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../../config/navigation/app_route.dart';
import '../../../../../authentication/repo/authentication_repo.dart';
import '../../../../../common/controller/common_controller.dart';
import '../../../../../common/model/CountryCollectionModel.dart';
import '../../../../../common/model/country_model.dart';
import '../../../../../common/model/user_model.dart';
import '../../../../../common/repo/common_repo.dart';
import '../../../../model/CommissionModel.dart';
import '../../../../model/drop_down_model.dart';

class AddMoneyController extends GetxController {
  RxInt selectedMethodOptionIndex = 0.obs;

  TextEditingController amountCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController beneficiaryNameCtrl = TextEditingController();
  TextEditingController accountDescriptionCtrl = TextEditingController();

  RxList<DropDownModel> countryList = <DropDownModel>[].obs;

  RxList<CountryCollectionModel> countryCollectionList =
      <CountryCollectionModel>[].obs;

  final commissionModel = Rxn<CommissionModel>();

  CommonRepo commonRepo = CommonRepo();
  final selectedCountry = Rxn<CountryCollectionModel>();

  final selectedChannel = RxnString();

  // Get Country List
  Future<void> getCountryList() async {
    try {
      List<CountryCollectionModel>? countryListAPI =
          await commonRepo.getCountryCollectionModelList(Get.context!);
      print("UserModel API :: ${countryListAPI}");
      if (countryListAPI != null && countryListAPI.isNotEmpty) {
        countryCollectionList.value = countryListAPI;
        update();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {}
    update();
  }

  Future<void> fetchAmountBreakdown() async {
    try {
      Map<String, dynamic> params = {
        "txnAmount": amountCtrl.text,
        "recipient_country": selectedCountry.value!.id,
        "service_name": "onafric mobile collection"
      };

      CommissionModel? commissionModels =
          await commonRepo.getCommissionData(Get.context!, params);
      print("commissionModels API :: ${commissionModels}");
      if (commissionModels != null) {
        commissionModel.value = commissionModels;
        update();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {}
    update();
  }
  RxBool isbtnClick=false.obs;
  Future<void> getCommissionStore() async {
    try {
      EasyLoading.show(dismissOnTap: false,);
      Map<String, dynamic> params = {
        "country_code": selectedCountry.value != null
            ? selectedCountry.value!.id
            : "", // "242",
        "channel": selectedChannel.value ?? "",
        "mobile_code": selectedCountry.value != null
            ? "+${selectedCountry.value!.isdcode}"
            : "", // "+800",
        "mobile_no": mobileCtrl.text ?? "",
        "txnAmount": amountCtrl.text ?? "",
        "beneficiary_name": beneficiaryNameCtrl.text ?? "",
        "beneficiary_email": "",
        "notes": accountDescriptionCtrl.text ?? "",
        "sendFee": commissionModel.value != null
            ? "${commissionModel.value!.sendFee}"
            : "",
        "netAmount": commissionModel.value != null
            ? "${commissionModel.value!.netAmount ?? ""}"
            : "",
        "exchangeRate": commissionModel.value != null
            ? commissionModel.value!.exchangeRate ?? ""
            : "",
        "aggregatorRate": commissionModel.value != null
            ? commissionModel.value!.aggregatorRate ?? ""
            : "",
        "totalCharges": commissionModel.value != null
            ? "${commissionModel.value!.totalCharges ?? ""}"
            : "",
        "platformCharge": commissionModel.value != null
            ? commissionModel.value!.platformCharge ?? ""
            : "",
        "serviceCharge": commissionModel.value != null
            ? "${commissionModel.value!.serviceCharge ?? ""}"
            : "",
        "payoutCurrencyAmount": commissionModel.value != null
            ? "${commissionModel.value!.payoutCurrencyAmount!.toStringAsFixed(2) ?? ""}"
            : "",
        "aggregatorCurrencyAmount": commissionModel.value != null
            ? "${commissionModel.value!.aggregatorCurrencyAmount!.toStringAsFixed(2) ?? ""}"
            : "",
        "payoutCurrency": commissionModel.value != null
            ? commissionModel.value!.payoutCurrency ?? ""
            : "",
        "category_name": "add money",
        "service_name": "onafric mobile collection"
      };

      final response =
          await commonRepo.getCommissionStore(Get.context!, params);

      if (response != null && response!.success == false) {
        if (response.data['errors'] != null) {
          setFieldErrors(response.data['errors']);
        } else {


          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content:  Text(
                response!.data["message"],
                style: const TextStyle(color: Colors.white), // white font
              ),
              backgroundColor: Colors.red, // red background
              duration: const Duration(seconds: 5), // show for 3 seconds
              behavior: SnackBarBehavior.floating, // optional: floating snackbar
            ),
          );

        /*  Get.dialog(
              barrierDismissible: false,
              ResultDialog(
                title: "Failed",
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
                      child:  Text(  response!.data["message"],
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        ),),
                    ),
                  ],
                ), description: '',
              ));*/















        }
      } else {
       await getUserInfo();
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
      isbtnClick.value=false;
    }
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

  void changeSelectedCountry(CountryCollectionModel country) {
    selectedCountry.value = country;
    selectedChannel.value = null;
    update();
  }

  void changeSelectedChannel(String channel) {
    selectedChannel.value = channel;
    update();
  }

  @override
  void onInit() {
    countryList.assignAll(HomeData.countryList);
    getCountryList();

    super.onInit();
  }

  void changeSelectedMethod(int index) {
    selectedMethodOptionIndex.value = index;
  }

  onCountrySearch(String value) {
    if (value.trim().isNotEmpty) {
      countryList.value = countryList.where(
        (p0) {
          return (p0.title.toLowerCase().contains(value.toLowerCase()) ||
              (p0.count?.toLowerCase().contains(value.toLowerCase()) ?? false));
        },
      ).toList();
    } else {
      countryList.value = HomeData.countryList;
    }
    update();
  }

  void clearAllFields() {
    mobileCtrl.clear();
    amountCtrl.clear();
    fieldErrors.clear();
    beneficiaryNameCtrl.clear();
    accountDescriptionCtrl.clear();
    selectedCountry.value = null;
    selectedChannel.value = null;
    commissionModel.value = null;
    // Also reset any extra values like breakdown info, etc.
  }

  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  CommonController commonController = Get.find();

  Future<void> getUserInfo() async {
    try {
      EasyLoading.show();
      UserModel? userModelAPI = await authenticationRepo.getUserInfo(
        Get.context!,
      );

      if (userModelAPI != null) {
        commonController.userModel.value = userModelAPI;
        commonController.update();
        if (commonController.userModel.value!.isKycVerify == 1) {
          Get.offAllNamed(
            RouteUtilities.dashboard,
          );
        } else if (commonController.userModel.value!.isKycVerify != 1 &&
            commonController.userModel.value!.isCompany!) {
          Get.offAllNamed(RouteUtilities.kycScreen);
        } else {
          Get.offAllNamed(
            RouteUtilities.dashboard,
          );
        }
      } else {}
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }
}

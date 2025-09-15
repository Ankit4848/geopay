import 'package:fintech/config/navigation/app_route.dart';
import 'package:fintech/features/authentication/repo/authentication_repo.dart';
import 'package:fintech/features/common/controller/common_controller.dart';
import 'package:fintech/features/common/model/user_model.dart';
import 'package:fintech/features/common/repo/common_repo.dart';
import 'package:fintech/features/home/model/CommissionModel.dart';
import 'package:fintech/features/home/view/pages/bank_transfer/model/TTBBeneModel.dart';
import 'package:fintech/features/home/view/pages/bank_transfer/model/TTBCountryModel.dart';
import 'package:fintech/features/home/view/pages/momo_transfer/model/MTMBeneficiaryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../../core/widgets/dialogs/result_dialog.dart';


class   BankTransferController extends GetxController {
  RxnString selectedCountryFlag = RxnString();
  final selectedCountry = Rxn<TTBCountryModel>();
  final selectedBene = Rxn<TTBBeneModel>();
  RxnString selectedBeneficiary = RxnString();
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController accountDescriptionCtrl = TextEditingController();

  var countryError = ''.obs;
  var beneError = ''.obs;
  var amountError = ''.obs;


  RxList<TTBBeneModel> mobileBeneficiaryList =
      <TTBBeneModel>[].obs;
  RxList<TTBBeneModel> mobileBeneficiaryRecentList =
      <TTBBeneModel>[].obs;

  CommonRepo commonRepo = CommonRepo();

  RxList<TTBCountryModel> countryCollectionList = <TTBCountryModel>[].obs;
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  CommonController commonController = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    getCountryList();


    super.onInit();
  }
  // New method to set both country and beneficiary from recent recipient
  void selectFromRecentRecipient(Map<String, dynamic> recentData) async {
    // Find and set country
    var country = countryCollectionList
        .where((c) => c.data == recentData["payoutCountry"])
        .firstOrNull;

    if (country != null) {
      selectedCountry.value = country;

      // Load beneficiary list for this country
      await getTMtoMBeneListStore();

      // Find and set beneficiary
      var beneficiary = mobileBeneficiaryList
          .where((b) => b.data["bankaccountnumber"] == recentData["bankaccountnumber"])
          .firstOrNull;

      if (beneficiary != null) {
        selectedBene.value = beneficiary;
        update();
      }
    }
  }
  Future<void> getCountryList() async {
      List<TTBCountryModel>? countryListAPI =
          await commonRepo.getTTBCountryList(Get.context!,true);
      print("UserModel API :: ${countryListAPI}");
      if (countryListAPI != null && countryListAPI.isNotEmpty) {
        countryCollectionList.value = countryListAPI;
        update();
      }
    update();
      getRecentRecipent();
  }
  Future<void> getRecentRecipent() async {
    EasyLoading.show();
    final response =
          await commonRepo.getRecentRecipent(Get.context!,true);
      print("UserModel API :: ${response}");
      if (response != null && response.isNotEmpty) {
        mobileBeneficiaryRecentList.value = response;
        update();
      }
    EasyLoading.dismiss();
    update();
  }


  Future<bool> getPassword(String password) async {
    EasyLoading.show();
    Map<String, dynamic> params = {
      "password": password,};

    print(params);
    mobileBeneficiaryList.value.clear();
    bool? response = await commonRepo.getPassword(
      Get.context!,
      params,
    );
    print(response);
    EasyLoading.dismiss();
    update();
    return response!;
  }

  Future<void> getTMtoMBeneListStore() async {
     try {
     EasyLoading.show();
    Map<String, dynamic> params = {
    "payoutCurrency": selectedCountry.value!.value,
    "payoutCountry":  selectedCountry.value!.data,
    "serviceName": selectedCountry.value!.serviceName,
    "categoryName": "transfer to bank"
    };

    print(params);
     mobileBeneficiaryList.value.clear();
    final response = await commonRepo.getTTBBeneListStore(
      Get.context!,
      params,
    );

    print("responseresponseresponseresponseresponseresponse");
    print(response);

    if (response != null && response.isNotEmpty) {
      mobileBeneficiaryList.value = response;
      EasyLoading.dismiss();
      update();
    }
     EasyLoading.dismiss();
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
     EasyLoading.dismiss();
    update();
  }

  Future<void> getTMtoMBeneDeleteStore(String id) async {
     try {
     EasyLoading.show();
    Map<String, dynamic> params = {};

    print(params);

    final response =
        await commonRepo.getTTBBeneDeleteStore(Get.context!, params, id);

    print("responseresponseresponseresponseresponseresponse");
    print(response);

    if (response != null && response.success == true) {
      selectedBene.value=null;
      getTMtoMBeneListStore();

    } else {

    }
     } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  void changeSelectedCountry(TTBCountryModel? country) {
    selectedCountry.value = country;
    selectedBene.value=null;
    getTMtoMBeneListStore();
    update();
  }
  void changeSelectedBene(TTBBeneModel? bene) {
    selectedBene.value = bene;

    update();
  }


  final commissionModel = Rxn<CommissionModel>();
  Future<void> fetchAmountBreakdown() async {
 try {
      Map<String, dynamic> params = {
        "txnAmount": amountCtrl.text,
        "beneficiaryId": selectedBene.value!.id,

      };

      CommissionModel? commissionModels =
      await commonRepo.getTTBMCommissionData(Get.context!, params);
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

  Future<void> getTMtoMStore() async {
    try {

      EasyLoading.show(dismissOnTap: false);
      Map<String, dynamic> params =  {
        "country_code": selectedCountry.value!.value,
        "beneficiaryId": selectedBene.value!.id,
        "txnAmount": commissionModel.value!.txnAmount,
        "notes": accountDescriptionCtrl.text,
        "sendFee": commissionModel.value!.sendFee,
        "netAmount": commissionModel.value!.netAmount,
        "exchangeRate": commissionModel.value!.exchangeRate,
        "aggregatorRate": commissionModel.value!.aggregatorRate,
        "totalCharges": commissionModel.value!.totalCharges,
        "platformCharge": commissionModel.value!.platformCharge,
        "serviceCharge": commissionModel.value!.serviceCharge,
        "payoutCurrencyAmount": commissionModel.value!.payoutCurrencyAmount,
        "aggregatorCurrencyAmount": commissionModel.value!.aggregatorCurrencyAmount,
        "category_name": "transfer to bank",
        "service_name":selectedCountry.value!.serviceName,
        "payoutCountry": selectedCountry.value!.data,
        "payoutCountryName": selectedCountry.value!.label
      };

      final response = await commonRepo.getTTBStore(Get.context!, params);

      if (response!=null && response!.success == false ) {
       // setFieldErrors(response.data['errors']);
      } else {
        await getUserInfo(); // call after dialog close
        Get.dialog(
            barrierDismissible: false,
            ResultDialog(
              title: "Transaction Sent",


              positiveButtonText: "FAQS",
              onCloseTap: (){
                Get.back(); // close dialog
                // await getUserInfo();

              },
              showCloseButton: true,
              onPositveTap: () async {
                Get.back(); // close dialog
                Get.toNamed(RouteUtilities.faqScreen);
                // await getUserInfo(); // call after dialog close
              },
              descriptionWidget: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10,),
                  GestureDetector(
                    child:  Text(  response!.data["message"].toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                      ),),
                  ),

                ],
              ), description: '',
            ));
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
      isbtnClick.value=false;
    }
    update();
  }
  RxBool isbtnClick=false.obs;


  // Get UserInfo
  Future<void> getUserInfo() async {
    try {
      EasyLoading.show();
      UserModel? userModelAPI = await authenticationRepo.getUserInfo(
        Get.context!,
      );





      if (userModelAPI != null) {
        commonController.userModel.value = userModelAPI;
        commonController.update();

          Get.offAllNamed(
            RouteUtilities.dashboard,
          );

      } else {

      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }



  void clearAllFields() {

    amountCtrl.clear();
    accountDescriptionCtrl.clear();
    countryError.value = '';
    beneError.value = '';
    amountError.value = '';
    selectedCountry.value = null;
    selectedBene.value = null;

    commissionModel.value = null;
    // Also reset any extra values like breakdown info, etc.
  }



}

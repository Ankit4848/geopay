import 'package:geopay/features/home/view/pages/momo_transfer/model/MTMBeneficiaryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../../config/navigation/app_route.dart';
import '../../../../../../core/widgets/dialogs/result_dialog.dart';
import '../../../../../authentication/repo/authentication_repo.dart';
import '../../../../../common/controller/common_controller.dart';
import '../../../../../common/model/user_model.dart';
import '../../../../../common/repo/common_repo.dart';
import '../../../../model/CommissionModel.dart';
import '../model/MTMCountryModel.dart';

class MomoTransferController extends GetxController {
  RxnString selectedCountryFlag = RxnString();
  final selectedCountry = Rxn<MTMCountryModel>();
  final selectedBene = Rxn<MTMBeneficiaryModel>();
  RxnString selectedBeneficiary = RxnString();
  
  // Flag to track if beneficiary is confirmed
  RxBool isBeneficiaryConfirmed = false.obs;
  
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController accountDescriptionCtrl = TextEditingController();

  RxList<MTMBeneficiaryModel> mobileBeneficiaryList =
      <MTMBeneficiaryModel>[].obs;
  RxList<MTMBeneficiaryModel> mobileBeneficiaryRecentList =
      <MTMBeneficiaryModel>[].obs;
  CommonRepo commonRepo = CommonRepo();

  RxList<MTMCountryModel> countryCollectionList = <MTMCountryModel>[].obs;
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  CommonController commonController = Get.find();



  var countryError = ''.obs;
  var beneError = ''.obs;
  var amountError = ''.obs;


  @override
  void onInit() {
    // TODO: implement onInit

    countryError.value = '';
    beneError.value = '';
    amountError.value = '';
    isBeneficiaryConfirmed.value = false; // Initialize confirmation flag

    super.onInit();
  }

  Future<void> getCountryList() async {
    try {
      EasyLoading.show();
      List<MTMCountryModel>? countryListAPI =
          await commonRepo.getMTMCountryList(Get.context!,true);
      print("UserModel API :: ${countryListAPI}");
      if (countryListAPI != null && countryListAPI.isNotEmpty) {
        countryCollectionList.value = countryListAPI;
        update();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
      getRecentRecipent();
    }
    update();
  }

  Future<void> getRecentRecipent() async {
    EasyLoading.show();
    final response =
    await commonRepo.getMTMRecentRecipent(Get.context!,true);
    print("UserModel API :: ${response}");
    if (response != null && response.isNotEmpty) {
      mobileBeneficiaryRecentList.value = response;
      update();
    }
    EasyLoading.dismiss();
    update();
  }

  /*Future<void> getTMtoMBeneListStore() async {
     try {
     EasyLoading.show();
    Map<String, dynamic> params = {
      "recipient_country": selectedCountry.value!.id,
      "serviceName": "onafric",
      "categoryName": "transfer to mobile"
    };

    print(params);
     mobileBeneficiaryList.value.clear();
    final response = await commonRepo.getTMtoMBeneListStore(
      Get.context!,
      params,
    );



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
    update();
  }*/
  Future<void> getTMtoMBeneListStore() async {
     try {
     EasyLoading.show();
    Map<String, dynamic> params = {
      "type": "transfer to mobile"
    };

    print(params);
     mobileBeneficiaryList.value.clear();
    final response = await commonRepo.getTMtoMBeneListStore(
      Get.context!,
      params,
    );



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

  Future<void> getTMtoMBeneDeleteStore(String id) async {
     try {
     EasyLoading.show();
    Map<String, dynamic> params = {};

    print(params);

    final response =
        await commonRepo.getTMtoMBeneDeleteStore(Get.context!, params, id);

    print("responseresponseresponseresponseresponseresponse");
    print(response);

    if (response != null && response.success == true) {

      selectedBene.value=null;
      await getTMtoMBeneListStore();
    } else {

    }
     } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  Future<void> changeSelectedCountry(MTMCountryModel? country) async {
    selectedCountry.value = country;
    selectedBene.value = null;
    isBeneficiaryConfirmed.value = false; // Reset confirmation flag
    await getTMtoMBeneListStore();
    update();
  }
  void changeSelectedBene(MTMBeneficiaryModel? bene) {
    selectedBene.value = bene;
    isBeneficiaryConfirmed.value = true; // Set confirmation flag
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
      await commonRepo.getTMtoMCommissionData(Get.context!, params);
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
  Future<void> getTMtoMStore() async {
    try {
      EasyLoading.show(dismissOnTap: false,);
      Map<String, dynamic> params =  {
        "country_code": selectedCountry.value!.currencyCode,
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
        "category_name": "transfer to mobile",
        "service_name": "onafric"
      };

      final response = await commonRepo.getTMtoMStore(Get.context!, params,);

      if (response!=null && response!.success == false ) {
       // setFieldErrors(response.data['errors']);
      } else {
        print(response);


       // call after dialog close
        Get.dialog(
            barrierDismissible: false,
            ResultDialog(
              title: "Transaction Sent",

              positiveButtonText: "FAQS",
              onCloseTap: () async {
                Get.back(); // close dialog
                Get.back(); // close dialog
                await getUserInfo();
                // await getUserInfo();

              },
              showCloseButton: true,
              onPositveTap: () async {
                Get.back(); // close dialog
                clearAllFields();
              //  await getUserInfo();
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
      isbtnClick.value=false;
      EasyLoading.dismiss();
    }
    update();
  }



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

    try {
      amountCtrl.clear();

      countryError.value = '';
      beneError.value = '';
      amountError.value = '';
      accountDescriptionCtrl.clear();

      selectedCountry.value = null;
      selectedBene.value = null;
      isBeneficiaryConfirmed.value = false; // Reset confirmation flag

      commissionModel.value = null;
    }catch(e){}
    // Also reset any extra values like breakdown info, etc.
  }



}

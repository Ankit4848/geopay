import 'package:geopay/features/dashboard/view/dashboard.dart';
import 'package:geopay/features/home/view/pages/repo/home_repo.dart';
import 'package:geopay/features/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../../config/navigation/app_route.dart';
import '../../../../../../core/widgets/dialogs/result_dialog.dart';
import '../../../../../authentication/repo/authentication_repo.dart';
import '../../../../../common/controller/common_controller.dart';
import '../../../../../common/model/country_model.dart';
import '../../../../../common/model/user_model.dart';
import '../../../../../common/repo/common_repo.dart';
import '../../../../model/ApiErrorModel.dart';

class PayToWalletController extends GetxController {
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController beneficiaryNameCtrl = TextEditingController();
  TextEditingController accountDescriptionCtrl = TextEditingController();
  Rx<TextEditingController> searchController = TextEditingController().obs;
  HomeRepo homeRepo = HomeRepo();
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  CommonController commonController = Get.find();
  CommonRepo commonRepo = CommonRepo();

  RxList<CountryModel> searchCountryList = <CountryModel>[].obs;
  Rxn<CountryModel> selectedCountry = Rxn<CountryModel>();

  var mobileError = ''.obs;
  var amountError = ''.obs;
  var countryError = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    commonController.getCountryList(Get.context!);
    clearErrors();
  }

  void setErrors(ApiErrorModel errorModel) {
    mobileError.value = errorModel.errors['mobile_number']?.first ?? '';
    amountError.value = errorModel.errors['amount']?.first ?? '';
  }

  void clearErrors() {
    mobileError.value = '';
    amountError.value = '';
    countryError.value = '';
  }

  void onCountrySearch(String value) {
    searchCountryList.value = commonController.countryList;
    if (value.trim().isNotEmpty) {
      searchCountryList.value = commonController.countryList.where(
        (element) {
          return element.isdcode!
                  .toLowerCase()
                  .contains(value.toLowerCase().trim()) ||
              element.name!.toLowerCase().contains(value.trim().toLowerCase());
        },
      ).toList();
    }
    commonController.update();
    update();
  }

  void selectCountry(int countryId) {
    for (var field in commonController.countryList) {
      if (field.id == countryId) {
        selectedCountry.value = field;
      }
    }
    update();
  }
  
  RxBool isbtnClick=false.obs;
  
  // Password verification method
  Future<bool> getPassword(String password) async {
    EasyLoading.show();
    Map<String, dynamic> params = {
      "password": password,
    };

    print(params);
    bool? response = await commonRepo.getPassword(
      Get.context!,
      params,
    );
    print(response);
    EasyLoading.dismiss();
    update();
    return response ?? false;
  }
  // Register User
  Future<void> payWithoutQr(BuildContext context) async {
    try {
      clearErrors();

      EasyLoading.show(dismissOnTap: false);
      FocusScope.of(context).requestFocus(FocusNode());
      Map<String, dynamic> params = {
        'country_id': selectedCountry.value!.id,
        'mobile_number': mobileCtrl.text.trim(),
        "mobile_code": selectedCountry.value != null
            ? "+${selectedCountry.value!.isdcode}"
            : "", // "+800",
        'amount': amountCtrl.text.trim(),
        "notes": accountDescriptionCtrl.text.trim(),
      };

      final response = await homeRepo.payWithoutQrMoney(context, params);
      //  print("UserModel API :: ${response.toJson()}");
      print("response");
      print(response!.success);
      if (!response.success) {
        final errorModel = ApiErrorModel.fromJson(response.data);
        setErrors(errorModel);
      } else {


        Get.dialog(
            barrierDismissible: false,
            ResultDialog(
              title: "Transaction Sent",
              positiveButtonText: "FAQS",
              onCloseTap: () async {
                Get.back(); // close dialog
                await getUserInfo();
                // await getUserInfo();

              },
              showCloseButton: true,
              onPositveTap: () async {
                Get.back(); // close dialog
                await getUserInfo();
                Get.toNamed(RouteUtilities.faqScreen);
              // call after dialog close
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

        //Get.to(Dashboard());
        // Handle success (e.g., show snackbar, clear form, etc.)
        // Get.snackbar("Success", "Payment completed successfully.");

      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
      isbtnClick.value=false;
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

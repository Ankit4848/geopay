import 'package:geopay/core/widgets/dialogs/result_dialog.dart';
import 'package:geopay/features/home/model/productsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../../config/navigation/app_route.dart';
import '../../../../../authentication/repo/authentication_repo.dart';
import '../../../../../common/controller/common_controller.dart';
import '../../../../../common/model/country_model.dart';
import '../../../../../common/model/user_model.dart';
import '../../../../../common/repo/common_repo.dart';
import '../../../../model/OpratorModel.dart';

class AirtimeController extends GetxController {
  TextEditingController beneficiaryNameCtrl = TextEditingController();
  TextEditingController mobileNumberCtrl = TextEditingController();
  TextEditingController accountDescriptionCtrl = TextEditingController();

  RxnString selectedCountryFlag = RxnString();
  RxList<CountryModel> searchCountryList = <CountryModel>[].obs;

  RxList<OpratorModel> opratorList = <OpratorModel>[].obs;
  RxList<ProductsModel> productList = <ProductsModel>[].obs;

  RxList<OpratorModel> searchOpratorList = <OpratorModel>[].obs;
  RxList<ProductsModel> searchProductList = <ProductsModel>[].obs;

  Rxn<CountryModel> selectedCountry = Rxn<CountryModel>();
  Rxn<OpratorModel> selectedOprator = Rxn<OpratorModel>();
  Rxn<ProductsModel> selectedProduct = Rxn<ProductsModel>();

  var fieldErrors = <String, String>{}.obs;

  CommonRepo commonRepo = CommonRepo();
  RxnString countryCode = RxnString();
  late TabController tabController;

  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> searchOpratorController =
      TextEditingController().obs;
  Rx<TextEditingController> searchProductController =
      TextEditingController().obs;
  CommonController commonController = Get.find();






  // Error messages
  var countryError = ''.obs;
  var mobileError = ''.obs;
  var operatorError = ''.obs;
  var productError = ''.obs;






  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    commonController.getCountryList(Get.context!);
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

  void onOpratorSearch(String value) {
    searchOpratorList.value = opratorList;
    if (value.trim().isNotEmpty) {
      searchOpratorList.value = opratorList.where(
        (element) {
          return element.name!
                  .toLowerCase()
                  .contains(value.toLowerCase().trim()) ||
              element.name!.toLowerCase().contains(value.trim().toLowerCase());
        },
      ).toList();
    }

    update();
  }

  Future<void> getOperator() async {
    EasyLoading.show();
    try {
      Map<String, dynamic> params = {
        "country_code": selectedCountry.value != null
            ? selectedCountry.value!.iso3
            : "", // "242",
      };

      final response = await commonRepo.getInternationalAirtimeOperator(
        Get.context!,
        params,
      );

      print("response");
      print(response);

      if (response != null && response.isNotEmpty) {
        opratorList.value = response;
        searchOpratorList.value = opratorList;
        update();
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  void onProductSearch(String value) {
    searchProductList.value = productList;
    if (value.trim().isNotEmpty) {
      searchProductList.value = productList.where(
        (element) {
          return element.name!
                  .toLowerCase()
                  .contains(value.toLowerCase().trim()) ||
              element.name!.toLowerCase().contains(value.trim().toLowerCase());
        },
      ).toList();
    }

    update();
  }

  Future<void> getProduct() async {
    try {
      EasyLoading.show();
      Map<String, dynamic> params = {
        "country_code": selectedCountry.value != null
            ? selectedCountry.value!.iso3
            : "", // "242",
        "operator_id":
            selectedOprator.value != null ? selectedOprator.value!.id : ""
      };

      print(params);

      final response = await commonRepo.getInternationalAirtimeProduct(
        Get.context!,
        params,
      );

      print("response");
      print(response);

      if (response != null && response.isNotEmpty) {
        productList.value = response;
        searchProductList.value = productList;
        update();
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  Future<void> getValidationMobile() async {
    Map<String, dynamic> params = {
      "mobile_number": mobileNumberCtrl.text ?? "",
    "mobile_code": selectedCountry.value != null
    ? "+${selectedCountry.value!.isdcode}"
        : "",
      "operator_id":
          selectedOprator.value != null ? selectedOprator.value!.id : ""
    };

    print(params);

    final response = await commonRepo.getInternationalAirtimeMobileValidation(
      Get.context!,
      params,
    );

    print("response");
    print("response");
    print("response");
    print("response");
    print(response);

    if (response != null && response!.success == true) {
      fieldErrors.value.remove("mobile_no");

      update();
    } else {
      fieldErrors.value.addAll({"mobile_no": response!.message!});
    }

    update();
  }
  RxBool isbtnClick=false.obs;
  Future<void> getStoreTransaction() async {

    try {
      EasyLoading.show(dismissOnTap: false);
      Map<String, dynamic> params = {
        "mobile_number": mobileNumberCtrl.text ?? "",
        "operator_id":
        selectedOprator.value != null ? selectedOprator.value!.id : "",

        "country_code": selectedCountry.value!.iso3,
        "mobile_code": selectedCountry.value != null
         ? "+${selectedCountry.value!.isdcode}"
          : "",
        "product_id": selectedProduct.value!.id,
        "notes": accountDescriptionCtrl.text,
        "is_operator_match": "1",
        "product_name": selectedProduct.value!.name,
        "retail_unit_currency": selectedProduct.value!.retailUnitCurrency,
        "wholesale_unit_currency": selectedProduct.value!.wholesaleUnitCurrency,
        "retail_unit_amount": selectedProduct.value!.retailUnitAmount,
        "wholesale_unit_amount": selectedProduct.value!.wholesaleUnitAmount,
        "retail_rates": selectedProduct.value!.retailRates,
        "wholesale_rates": selectedProduct.value!.wholesaleRates,
        "destination_rates": selectedProduct.value!.destinationRates,
        "platform_fees": selectedProduct.value!.platformFees,
        "destination_currency": selectedProduct.value!.destinationCurrency
      };

      print(params);

      final response = await commonRepo.getStoreTransaction(
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
                await getUserInfo();
              },
              descriptionWidget: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  GestureDetector(
                    child:  Text(
                      response.message!,
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
      }
    }catch(e)
    {}
    finally{
      EasyLoading.dismiss();
      isbtnClick.value=false;
    }
    update();
  }


  void clearAllFields() {
    mobileNumberCtrl.clear();


    countryError.value = '';
    mobileError.value = '';
    operatorError.value = '';
    productError.value = '';


    fieldErrors.clear();
    beneficiaryNameCtrl.clear();
    accountDescriptionCtrl.clear();
    selectedCountry.value = null;
    selectedProduct.value = null;
    selectedOprator.value = null;
    selectedCountryFlag.value = null;
    opratorList.clear();
    productList.clear();
    // Also reset any extra values like breakdown info, etc.
  }







  AuthenticationRepo authenticationRepo = AuthenticationRepo();


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

import 'package:fintech/features/authentication/pages/register/model/CompanyDisplayDataModel.dart';
import 'package:fintech/features/common/model/country_model.dart';
import 'package:fintech/features/common/repo/common_repo.dart';
import 'package:fintech/features/home/model/CommonModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../authentication/repo/authentication_repo.dart';
import '../model/user_model.dart';

class CommonController extends GetxController {
  Rxn<UserModel> userModel = Rxn();
  RxList<CountryModel> countryList = <CountryModel>[].obs;
  Rxn<CommonModel> common = Rxn<CommonModel>();
  Rxn<CompanyDisplayDataModel> companyDisplayDataModel =
      Rxn<CompanyDisplayDataModel>();
  CommonRepo commonRepo = CommonRepo();
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  // Get Country List
  Future<void> getCountryList(BuildContext context) async {
    try {
      List<CountryModel>? countryListAPI =
          await commonRepo.getCountryList(context);
      print("UserModel API :: ${countryListAPI}");
      if (countryListAPI != null && countryListAPI.isNotEmpty) {
        countryList.value = countryListAPI;
        update();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {}
    update();
  }

  Future<void> getUserInfo() async {
    try {
      EasyLoading.show();
      UserModel? userModelAPI = await authenticationRepo.getUserInfo(
        Get.context!,
      );

      if (userModelAPI != null) {
        userModel.value = userModelAPI;
        update();
      } else {}
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  // Get Country List
  Future<void> getCommonDetails(BuildContext context) async {
    try {
      CommonModel? commonModel = await commonRepo.getCommonDetails(context);
      print("UserModel API :: ${commonModel}");
      if (commonModel != null) {
        common.value = commonModel;
        update();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {}
    update();
  }
}

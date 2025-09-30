import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:geopay/features/authentication/pages/register/model/CompanyDisplayDataModel.dart';
import 'package:geopay/features/common/model/country_model.dart';
import 'package:geopay/features/home/model/CommonModel.dart';
import 'package:geopay/features/home/view/pages/add_money/widgets/balance_card.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBBankModel.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBBeneModel.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBCountryModel.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/model/TTBFieldModel.dart';
import 'package:geopay/features/notification_history/model/NotificationModel.dart';
import 'package:geopay/features/transaction_history/model/TranscationModel.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../home/model/CommissionModel.dart';
import '../../home/model/MTMFiledsModel.dart';
import '../../home/model/MobileBeneficiaryModel.dart';
import '../../home/model/MobileValidationResponse.dart';
import '../../home/model/OpratorModel.dart';
import '../../home/model/productsModel.dart';
import '../../home/view/pages/momo_transfer/model/MTMBeneficiaryModel.dart';
import '../../home/view/pages/momo_transfer/model/MTMCountryModel.dart';
import '../../home/view/pages/repo/home_repo.dart';
import '../model/CountryCollectionModel.dart';
import '../model/user_model.dart';

class CommonRepo {
  Future<CommonModel?> getCommonDetails(BuildContext context) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet, url: APIUtilities.getCommonDetails);
      if (response.isRight) {
        return CommonModel.fromJson(json.decode(response.right));
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }
  Future<List<CountryModel>?> getCountryList(BuildContext context) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet, url: APIUtilities.getCountryList);
      if (response.isRight) {
        List countryList = json.decode(response.right);
        return countryList.map((e) => CountryModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }
  Future<CompanyDisplayDataModel?> getCompanyKycDetails(BuildContext context) async {
   // try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet, url: APIUtilities.getCompanyKycDetails);
      if (response.isRight) {

        return  CompanyDisplayDataModel.fromJson(json.decode(response.right));
      }

    return null;
  }

  Future<List<CountryCollectionModel>?> getCountryCollectionModelList(
      BuildContext context) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet, url: APIUtilities.getCountryCollectionModelList);
      if (response.isRight) {
        List countryList = json.decode(response.right);
        return countryList
            .map((e) => CountryCollectionModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  Future<CommissionModel?> getCommissionData(
      BuildContext context, Map<String, dynamic> params) async {
  //  try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost, body: params, url: APIUtilities.getCommission);
      if (response.isRight) {
        final countryList = json.decode(response.right);
        return CommissionModel.fromJson(countryList);
      }
   /* } catch (e) {
      print("Error :: ${e}");
    }*/
    return null;
  }

  Future<ApiResponse?> getCommissionStore(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI2(context,
          type: APIType.tPost,
          body: params,
          showSuccessMessage: false,
          url: APIUtilities.getCommissionStore);

      if (response.isRight) {
        print("response.right");
        print(response.right);

        final data = response.right;
        return ApiResponse(success: data['success'] ?? true,message:  data['message'], data: data);
        //return UserModel.fromJson(jsonDecode(response.right));
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }


  Future<ApiResponse?> getCompanyKycStep1(
      BuildContext context, Map<String, dynamic> params) async {
   // try {
      Either<Exception, dynamic> response = await API.callAPI2(context,
          type: APIType.tPost,
          body: params,
          showSuccessMessage: true,
          url: APIUtilities.getCompanyKycStep1);

      if (response.isRight) {
        print("response.right");
        print(response.right);

        final data = response.right;
        return ApiResponse(success: data['success'] ?? true, data: data);
        //return UserModel.fromJson(jsonDecode(response.right));
      }
  //  } catch (e) {
   //   print("Error :: ${e}");
   // }
    return null;
  }
  Future<ApiResponse?> getCompanyKycStep2(
      BuildContext context, Map<String, dynamic> params) async {
   // try {
      Either<Exception, dynamic> response = await API.callAPI2(context,
          type: APIType.tPost,
          body: params,
          showSuccessMessage: true,
          url: APIUtilities.getCompanyKycStep2);

      if (response.isRight) {
        print("response.right");
        print(response.right);

        final data = response.right;
        return ApiResponse(success: data['success'] ?? true, data: data);
        //return UserModel.fromJson(jsonDecode(response.right));
      }
  //  } catch (e) {
   //   print("Error :: ${e}");
   // }
    return null;
  }

  Future<List<OpratorModel>?> getInternationalAirtimeOperator(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          body: params,
          showSuccessMessage: false,
          url: APIUtilities.getAirtimeOperator);

      if (response.isRight) {
        print("response.right");
        print(response.right);

        final data = response.right;

        if (response.isRight) {
          List countryList = json.decode(response.right);
          return countryList.map((e) => OpratorModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  Future<List<ProductsModel>?> getInternationalAirtimeProduct(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        url: APIUtilities.getAirtimeProduct);

    if (response.isRight) {
      print("response.right");
      print(response.right);

      final data = response.right;

      if (response.isRight) {
        List productList = json.decode(response.right);
        return productList.map((e) => ProductsModel.fromJson(e)).toList();
      }
    }

    return null;
  }

  Future<MobileValidationResponse?> getInternationalAirtimeMobileValidation(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI2(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        url: APIUtilities.getValidateMobile);

    if (response.isRight) {
      print("response.right");
      print(response.right);

      final data = response.right;

      if (response.isRight) {
        return MobileValidationResponse.fromJson(response.right);
      }
    }

    return null;
  }

  Future<MobileValidationResponse?> getStoreTransaction(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI2(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        showErrorMessage: true,
        url: APIUtilities.getStoreTransaction);

    if (response.isRight) {
      print("response.right");
      print(response.right);

      final data = response.right;

      if (response.isRight) {
        return MobileValidationResponse.fromJson(response.right);
      }
    }

    return null;
  }

  Future<MobileValidationResponse?> getTmtoMFieldsViewBaeneStore(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI2(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        showErrorMessage: false,
        url: APIUtilities.getTmtoMFieldsViewBaeneStore);

    if (response.isRight) {
      print("response.right");
      print(response.right);

      final data = response.right;

      if (response.isRight) {
        return MobileValidationResponse.fromJson(response.right);
      }
    }

    return null;
  }

  Future<MobileValidationResponse?> getTTBFieldsViewBaeneStore(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI2(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        showErrorMessage: true,
        url: APIUtilities.getTTBFieldsViewBeneStore);

    if (response.isRight) {
      print("response.right");
      print(response.right);
      final data = response.right;
      if (response.isRight) {
        return MobileValidationResponse.fromJson(response.right);
      }
    }

    return null;
  }

  Future<List<MTMCountryModel>?> getMTMCountryList(BuildContext context,bool isAll) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet, url: isAll?"${APIUtilities.getMTMCountryList}?is_all=true":APIUtilities.getMTMCountryList);
      if (response.isRight) {
        List countryList = json.decode(response.right);
        return countryList.map((e) => MTMCountryModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  Future<List<TTBCountryModel>?> getTTBCountryList(BuildContext context,bool isAll) async {
   // try {



      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet, url: isAll?"${APIUtilities.getTTBCountryList}?is_all=true":APIUtilities.getTTBCountryList);



      if (response.isRight) {
        List countryList = json.decode(response.right);
        return countryList.map((e) => TTBCountryModel.fromJson(e)).toList();
      }
   // } catch (e) {
   //   print("Error :: ${e}");
  //  }
    return null;
  }
  /// Get User Info
  Future<bool?> getPassword(BuildContext context, Map<String, dynamic> params) async {

      Either<Exception, dynamic> response = await API.callAPI3(
          context,
          type: APIType.tPost,
          url: APIUtilities.postPassword,
          body: params,
          showSuccessMessage: false,
          showErrorMessage: false
      );
      if (response.isRight) {
        print(response.right);
        print(response.right);
        print(response.right);
        print(response.right);
        print(response.right);

        return response.right["message"]=="verified";
      }

    return null;
  }
  Future<List<TTBBeneModel>?> getRecentRecipent(BuildContext context,bool isAll) async {
   // try {



      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet, url: APIUtilities.getTTBRecentList);



      if (response.isRight) {
        List countryList = json.decode(response.right);
        return countryList.map((e) => TTBBeneModel.fromJson(e)).toList();
      }
   // } catch (e) {
   //   print("Error :: ${e}");
  //  }
    return null;
  }
  Future<List<MTMBeneficiaryModel>?> getMTMRecentRecipent(BuildContext context,bool isAll) async {
   // try {

      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet, url: APIUtilities.getMTMRecentList);

      if (response.isRight) {
        List countryList = json.decode(response.right);
        return countryList.map((e) => MTMBeneficiaryModel.fromJson(e)).toList();
      }
   // } catch (e) {
   //   print("Error :: ${e}");
  //  }
    return null;
  }

  Future<MainTranscationModel?> getTranList(BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tPost,
          body: params,
          showSuccessMessage: false,
          url: APIUtilities.getTransactionList);
      if (response.isRight) {

        return MainTranscationModel.fromJson(json.decode(response.right));
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  Future<List<NotificationModel>?> getNotificationList(BuildContext context) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI(context,
          type: APIType.tGet,
          showSuccessMessage: false,
          url: APIUtilities.getNotificationList);
      if (response.isRight) {
        List productList = json.decode(response.right);
        print("response.right");
        print(response.right);
        return productList.map((e) => NotificationModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  Future<List<TTBBankModel>?> getTTBBankList(BuildContext context, Map<String, dynamic> params) async {
   // try {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        url: APIUtilities.getTTBBankList);

    if (response.isRight) {
      final data = response.right;
      if (response.isRight) {
        List productList = json.decode(response.right);
        print("response.right");
        print(response.right);
        return productList.map((e) => TTBBankModel.fromJson(e)).toList();
      }
    }
   // } catch (e) {
   //   print("Error :: ${e}");
  //  }
    return null;
  }

  Future<List<MTMFiledsModel>?> getTmtoMFieldsViewBaene(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        url: APIUtilities.getTmtoMFieldsViewBaene);
    if (response.isRight) {
      final data = response.right;
      if (response.isRight) {
        List productList = json.decode(response.right);
        print("response.right");
        print(response.right);
        return productList.map((e) => MTMFiledsModel.fromJson(e)).toList();
      }
    }
    return null;
  }

  Future<List<DynamicFormField>?> getTTBFieldsViewBene(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        url: APIUtilities.getTTBFieldsViewBene);

    if (response.isRight) {
      final data = response.right;
      if (response.isRight) {
        List productList = json.decode(response.right);
        print("response.right");
        print(response.right);
        return productList.map((e) => DynamicFormField.fromJson(e)).toList();
      }
    }

    return null;
  }

  Future<List<MTMBeneficiaryModel>?> getTMtoMBeneListStore(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        showErrorMessage: false,
        url: APIUtilities.getBeneListStore);
    if (response.isRight) {
      final data = response.right;
      if (response.isRight) {
        List productList = json.decode(response.right);
        print("response.right response.right");
        print(response.right);
        return productList.map((e) => MTMBeneficiaryModel.fromJson(e)).toList();
      }
    }

    return null;
  }


  Future<List<TTBBeneModel>?> getTTBBeneListStore(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        showErrorMessage: true,
        url: APIUtilities.getTTBBeneListStore);
    if (response.isRight) {
      final data = response.right;
      if (response.isRight) {
        List productList = json.decode(response.right);
        print("response.right response.right");
        print(response.right);
        return productList.map((e) => TTBBeneModel.fromJson(e)).toList();
      }
    }

    return null;
  }
  Future<List<TTBBeneModel>?> getBeneListStore(
      BuildContext context, Map<String, dynamic> params) async {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        showErrorMessage: true,
        url: APIUtilities.getBeneListStore);
    if (response.isRight) {
      final data = response.right;
      if (response.isRight) {
        List productList = json.decode(response.right);
        print("response.right response.right");
        print(response.right);
        return productList.map((e) => TTBBeneModel.fromJson(e)).toList();
      }
    }

    return null;
  }

  Future<MobileValidationResponse?> getTMtoMBeneDeleteStore(
        BuildContext context, Map<String, dynamic> params, String id) async {
        Either<Exception, dynamic> response = await API.callAPI2(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: true,
        showErrorMessage: true,
        url: "${APIUtilities.getTMtoMBeneDeleteStore}$id");

    if (response.isRight) {

      print("response.right response.right");
      print(response.right);
      return MobileValidationResponse.fromJson(response.right);
    }

    return null;
  }




  Future<MobileValidationResponse?> getTTBBeneDeleteStore(
        BuildContext context, Map<String, dynamic> params, String id) async {
        Either<Exception, dynamic> response = await API.callAPI2(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: true,
        showErrorMessage: true,
        url: "${APIUtilities.getTTBBeneDeleteStore}$id");

    if (response.isRight) {

      print("response.right response.right");
      print(response.right);
      return MobileValidationResponse.fromJson(response.right);
    }

    return null;
  }

  Future<MobileValidationResponse?> getTMtoMBeneUpdateStore(
      BuildContext context, Map<String, dynamic> params, String id) async {
    Either<Exception, dynamic> response = await API.callAPI2(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: false,
        showErrorMessage: true,
        url: "${APIUtilities.getTMtoMBeneUpdateStore}$id");
    if (response.isRight) {
      final data = response.right;
      if (response.isRight) {
        print("response.right response.right");
        print(response.right);
        return MobileValidationResponse.fromJson(response.right);
      }
    }

    return null;
  }
  Future<MobileValidationResponse?> getTTBBeneUpdateStore(
      BuildContext context, Map<String, dynamic> params, String id) async {
    Either<Exception, dynamic> response = await API.callAPI2(context,
        type: APIType.tPost,
        body: params,
        showSuccessMessage: true,
        showErrorMessage: true,
        url: "${APIUtilities.getTTBBeneUpdateStore}$id");
    if (response.isRight) {
      final data = response.right;
      if (response.isRight) {
        print("response.right response.right");
        print(response.right);
        return MobileValidationResponse.fromJson(response.right);
      }
    }

    return null;
  }

  Future<CommissionModel?> getTMtoMCommissionData(
      BuildContext context, Map<String, dynamic> params) async {
    //  try {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,
        url: APIUtilities.getTMtoMCommissionStore);
    if (response.isRight) {
      final countryList = json.decode(response.right);
      return CommissionModel.fromJson(countryList);
    }
    // } catch (e) {
    //   print("Error :: ${e}");
    //  }
    return null;
  }
  Future<CommissionModel?> getTTBMCommissionData(
      BuildContext context, Map<String, dynamic> params) async {
    //  try {
    Either<Exception, dynamic> response = await API.callAPI(context,
        type: APIType.tPost,
        body: params,

        url: APIUtilities.getTTBCommissionStore);
    if (response.isRight) {
      final countryList = json.decode(response.right);
      return CommissionModel.fromJson(countryList);
    }
    // } catch (e) {
    //   print("Error :: ${e}");
    //  }
    return null;
  }
//0707011181



  Future<ApiResponse?> getTMtoMStore(
      BuildContext context, Map<String, dynamic> params) async {
   // try {
      Either<Exception, dynamic> response = await API.callAPI1(context,
          type: APIType.tPost,
          body: params,
          showSuccessMessage: false,
          showErrorMessage: true,
          url: APIUtilities.getTMtoMStore);

      if (response.isRight) {
        print("response.right");
        print(response.right);

        final data = response.right;
        return ApiResponse(success: data['success'] ?? true, data: data);
        //return UserModel.fromJson(jsonDecode(response.right));
      }

    //} catch (e) {
    //  print("Errorsssss :: ${e}");
   // }
    return null;
  }

  Future<ApiResponse?> getTTBStore(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI1(context,
          type: APIType.tPost,
          body: params,
          showSuccessMessage: false,
          showErrorMessage: true,
          url: APIUtilities.getTTBStore);

      if (response.isRight) {

        print("response.right");
        print(response.right);

        final data = response.right;
        return ApiResponse(success: data['success'] ?? true, data: data);
        //return UserModel.fromJson(jsonDecode(response.right));
      }
    } catch (e) {
      print("Error :: ${e}");
    }
    return null;
  }

  // Card Payment Processing Method
  Future<ApiResponse?> processCardPayment(
      BuildContext context, Map<String, dynamic> params) async {
    try {
      Either<Exception, dynamic> response = await API.callAPI2(context,
          type: APIType.tPost,
          body: params,
          showSuccessMessage: false,
          showErrorMessage: true,
          url: APIUtilities.processCardPayment); // You'll need to add this URL

      if (response.isRight) {
        print("Card Payment Response: ${response.right}");
        final data = response.right;
        return ApiResponse(
          success: data['success'] ?? true,
          message: data['message'] ?? 'Payment processed successfully',
          data: data
        );
      }
    } catch (e) {
      print("Card Payment Error :: ${e}");
    }
    return null;
  }

 /* // Card Payment Processing Method
  Future<ApiResponse?> processCardPayment(
      BuildContext context, Map<String, dynamic> params) async
  {

    print(params);


    final url = Uri.parse("https://ggapi.ibanera.com/v1/payment/deposit");


    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(params),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("✅ ============== $data");
    } else {
      print("❌ Error: ${response.statusCode}");
      print("Body: ${response.body}");
    }

  }*/

}

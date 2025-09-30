import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:geopay/features/authentication/pages/register/model/CompanyDisplayDataModel.dart';
import 'package:geopay/features/authentication/repo/authentication_repo.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/common/repo/common_repo.dart';
import 'package:geopay/features/home/view/pages/repo/home_repo.dart';
import 'package:geopay/features/kyc/controller/kyc_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:metamap_plugin_flutter/metamap_plugin_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../common/model/country_model.dart';
import '../../../../common/model/user_model.dart';

class RegisterController extends GetxController {
  RxInt selectedIndex = 0.obs;
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController middleNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController refferalCodeCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController comanyNameCtrl = TextEditingController();
  TextEditingController businessLicenceCtrl = TextEditingController();
  TextEditingController tinCtrl = TextEditingController();
  TextEditingController vatCtrl = TextEditingController();
  TextEditingController bankNameCtrl = TextEditingController();
  TextEditingController accountNoCtrl = TextEditingController();
  TextEditingController bankCodeCtrl = TextEditingController();
  TextEditingController directerctrl = TextEditingController();

  TextEditingController idNumberCtrl = TextEditingController();
  TextEditingController idIssueDateCtrl = TextEditingController();
  TextEditingController idExpiryDateCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController fullAdressCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController zipCtrl = TextEditingController();

  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxBool isPhoneError = false.obs;
  RxBool isPassObscure = true.obs;
  RxBool isConfirmPassObscure = true.obs;
  RxBool isTermAccepted = false.obs;
  RxInt currentStepIndex = 0.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CommonController commonController = Get.find();
  Rxn<CountryModel> selectedCountry = Rxn();
  Rxn<BusinessTypes> selectedBusiness = Rxn();
  RxList<CountryModel> searchCountryList = <CountryModel>[].obs;
  RxList<BusinessTypes> businessTypeList = <BusinessTypes>[].obs;
  AuthenticationRepo authenticationRepo = AuthenticationRepo();
  RxInt registerType = 0.obs;
  RxBool isPhoneOTPShow = false.obs;
  RxBool isEmailOTPShow = false.obs;
  RxBool isEmailVerify = false.obs;
  RxBool isPhoneVerify = false.obs;
  RxBool isEmailError = false.obs;
  RxBool isPhoneVerifyError = false.obs;
  var isEmailResendEnabled = false.obs;
  var isMobileResendEnabled = false.obs;

  var emailTimerSeconds = 60.obs;
  var mobileTimerSeconds = 60.obs;
  Timer? _emailTimer;
  Timer? _mobileTimer;
  TextEditingController emailOTPCtrl = TextEditingController();
  TextEditingController phoneOTPCtrl = TextEditingController();
  final numberOfDirectorCntrl = TextEditingController(); // Number of Directors
  final directorCount = 0.obs;
  final List<TextEditingController> directorNameControllers = [];
  Rxn<CompanyDisplayDataModel> companyDisplayDataModel =
      Rxn<CompanyDisplayDataModel>();
  CommonRepo commonRepo = CommonRepo();

// Add this property to your RegisterController class
  RxString selectedGender = ''.obs;

// Update your clearData() method to include:
  RxString selectedIdType = ''.obs;
  RxString selectedBusinessOccupation = ''.obs;
  RxString selectedSourceOfFund = ''.obs;
  RxInt registerStep = 0.obs;
  var isPasswordFocused = false.obs;
  final passwordFocus=FocusNode();

  void updateDirectorCount(String value) {
    int count = int.tryParse(value) ?? 0;
    directorCount.value = count;

    // Maintain controller list
    directorNameControllers.clear();
    for (int i = 0; i < count; i++) {
      directorNameControllers.add(TextEditingController());
    }
  }

  @override
  Future<void> onInit() async {
    if (Get.context != null) {
      clearData();

      commonController.getCountryList(Get.context!);
    }
    super.onInit();
    passwordFocus.addListener(() {
      isPasswordFocused.value=passwordFocus.hasFocus;
    },);
  }

  // Get Country List
  Future<void> getCompanyKycDetails(BuildContext context) async {
    try {
      EasyLoading.show();
      CompanyDisplayDataModel? countryListAPI =
          await commonRepo.getCompanyKycDetails(context);
      print("companyDisplayDataModel API :: ${countryListAPI}");
      if (countryListAPI != null) {
        companyDisplayDataModel.value = null;
        companyDisplayDataModel.value = countryListAPI;
        businessTypeList.value = companyDisplayDataModel.value!.businessTypes!;

        if (companyDisplayDataModel.value!.companyDetail != null &&
            companyDisplayDataModel.value!.companyDetail!.noOfDirector! > 0) {
          selectedDirector = companyDisplayDataModel
              .value!.companyDetail!.companyDirectors![0];
          directerctrl.text = selectedDirector!.name!;

          updateDirectorCount(companyDisplayDataModel
              .value!.companyDetail!.noOfDirector!
              .toString());
          selectedBusiness.value = businessTypeList.value.firstWhere(
              (element) =>
                  element.id ==
                  companyDisplayDataModel.value!.companyDetail!.businessTypeId);

          for (int i = 0;
              i <
                  companyDisplayDataModel
                      .value!.companyDetail!.companyDirectors!.length;
              i++) {
            directorNameControllers[i].text = companyDisplayDataModel
                .value!.companyDetail!.companyDirectors![i].name!;
          }
          numberOfDirectorCntrl.text = companyDisplayDataModel
              .value!.companyDetail!.noOfDirector!
              .toString();
          comanyNameCtrl.text = companyDisplayDataModel
              .value!.companyDetail!.businessLicence!
              .toString();
          businessLicenceCtrl.text = companyDisplayDataModel
              .value!.companyDetail!.postcode!
              .toString();
          tinCtrl.text = companyDisplayDataModel
              .value!.companyDetail!.companyAddress!
              .toString();

          bankNameCtrl.text =
              companyDisplayDataModel.value!.companyDetail!.bankName! ?? "";
          accountNoCtrl.text =
              companyDisplayDataModel.value!.companyDetail!.accountNumber! ??
                  "";
          bankCodeCtrl.text =
              companyDisplayDataModel.value!.companyDetail!.bankCode! ?? "";
        }

        update();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }

  void changeSelectedCountry(BusinessTypes country) {
    selectedBusiness.value = country;

    update();
  }

  void togglePassObscure() {
    isPassObscure.value = !isPassObscure.value;
  }

  void toggleConfirmPassObscure() {
    isConfirmPassObscure.value = !isConfirmPassObscure.value;
  }

  void toggleTermAndCondition() {
    isTermAccepted.value = !isTermAccepted.value;
  }

  void toggleSelectedIndex(int index) {
    clearData();
    selectedIndex.value = index;
  }

  changeCurrentStep() {
    if (currentStepIndex.value < 2) {
      currentStepIndex.value++;
    } else {
      Get.offAllNamed(RouteUtilities.dashboard);
    }
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

  void showMetaMapFlow() {
    MetaMapFlutter.showMetaMapFlow(
        clientId: "652d932270a904001cdf04c9",
        flowId: "66cc66d6e27531001c7339c6",
        metadata: {
          "user_id": commonController.userModel.value!.id,
          "user_email": commonController.userModel.value!.email
        });
    MetaMapFlutter.resultCompleter.future.then((result) {
      Get.dialog(
          barrierDismissible: false,
          ResultDialog(
            title: "Thank You For Meta KYC",
            positiveButtonText: "Close",
            showCloseButton: false,
            onPositveTap: () {
              KycController kycController = Get.find();
              kycController.currentStepIndex.value = 0;
              kycController.update();
              clearData();
              SharedPref.setUserToken('');
              Get.offAllNamed(RouteUtilities.loginScreen);
            },
            descriptionWidget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You’re documents are still under review, If you think the process is taking longer than expected, please reach out to us on the following:",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                  ),),

                SizedBox(height: 10,),
                GestureDetector(
                  child: Text("Email : support@geopayments.co",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  child: Text("What\'s app support only:",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),),
                ),


              ],
            ), description: '',
          ));

    });
  }

  void clearData() {
    emailOTPCtrl.clear();
    phoneOTPCtrl.clear();
    registerStep.value = 0;
    isPhoneOTPShow.value = false;
    isEmailOTPShow.value = false;
    isEmailVerify.value = false;
    isPhoneVerify.value = false;
    isEmailError.value = false;
    isPhoneVerifyError.value = false;
    registerType.value = 0;
    isPassObscure.value = true;
    isConfirmPassObscure.value = true;
    isPhoneError.value = false;
    selectedCountry.value = null;
    selectedIndex.value = 0;
    firstNameCtrl.clear();
    middleNameCtrl.clear();
    numberOfDirectorCntrl.clear();
    bankNameCtrl.clear();
    lastNameCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
    selectedGender.value = '';
    selectedIdType.value = '';
    selectedBusinessOccupation.value = '';
    selectedSourceOfFund.value = '';

    idNumberCtrl.clear();
    idIssueDateCtrl.clear();
    idExpiryDateCtrl.clear();
    dateOfBirthCtrl.clear();
    fullAdressCtrl.clear();
    cityCtrl.clear();
    stateCtrl.clear();
    zipCtrl.clear();

    confirmPasswordCtrl.clear();
    phoneNumberCtrl.clear();
    refferalCodeCtrl.clear();
    isTermAccepted.value = false;
    currentStepIndex.value = 0;
    comanyNameCtrl.clear();
    businessLicenceCtrl.clear();
    updateDirectorCount("0");
    tinCtrl.clear();
    vatCtrl.clear();
    bankCodeCtrl.clear();
    accountNoCtrl.clear();
    bankCodeCtrl.clear();

    documentStatus = {};
    uploadedFiles = {};
    selectedDirector = null;
    selectedDocument = null;

    update();
  }

  StreamController<ErrorAnimationType>? otpVerification;

  // Start Email OTP Timer
  void startEmailOTPTimer() {
    isEmailResendEnabled.value = false;
    emailTimerSeconds.value = 60;

    _emailTimer?.cancel();
    _emailTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (emailTimerSeconds.value > 0) {
        emailTimerSeconds.value--;
      } else {
        isEmailResendEnabled.value = true;
        _emailTimer?.cancel();
      }
    });
  }

  // Start Mobile OTP Timer
  void startMobileOTPTimer() {
    isMobileResendEnabled.value = false;
    mobileTimerSeconds.value = 60;
    _mobileTimer?.cancel();
    _mobileTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mobileTimerSeconds.value > 0) {
        mobileTimerSeconds.value--;
      } else {
        isMobileResendEnabled.value = true;
        _mobileTimer?.cancel();
      }
    });
  }

  /// Send VerificationEmail
  Future<void> sendVerificationEmail(BuildContext context,
      {bool isResend = false}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    try {
     EasyLoading.show();
      FocusScope.of(context).requestFocus(FocusNode());
      Map<String, dynamic> params = {
        'email': emailCtrl.text.trim(),
      };
    ApiResponse? verifyModelAPI= await authenticationRepo
          .sendVerificationEmail(context, params, isResend: isResend);

      print("verifyModelAPI[]");
      print(verifyModelAPI);
      print(verifyModelAPI);
      print("verifyModelAPI");

    try {
        if (verifyModelAPI!.success != false) {
          isEmailOTPShow.value = true;



          DialogUtilities.showDialog(
            message: verifyModelAPI.message!,
          );


          update();
        } else {
          isEmailOTPShow.value = false;
        }
      } catch (e) {
        if (verifyModelAPI != null) {
          isEmailOTPShow.value = true;
          update();
        }
        else {
          isEmailOTPShow.value = false;
        }
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    startEmailOTPTimer();
    update();
  }

  /// Verify Email
  Future<void> verifyEmail(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
  //  try {
   //   EasyLoading.show();
      FocusScope.of(context).requestFocus(FocusNode());
      Map<String, dynamic> params = {
        'email': emailCtrl.text.trim(),
        'otp': emailOTPCtrl.text.trim(),
      };
      ApiResponse? verifyModelAPI =
          await authenticationRepo.verifyEmail(context, params);

      if (verifyModelAPI != null && verifyModelAPI.success==true) {
        isEmailError.value = false;
        isEmailVerify.value = true;
        update();


        DialogUtilities.showDialog(
          message: verifyModelAPI!.message!,
        );

      } else {
        isEmailError.value = true;
        isEmailVerify.value = false;


        DialogUtilities.showDialog(
          title: "Error",
          message: verifyModelAPI!.message!,
        );


        emailOTPCtrl.clear();
      }
   // } catch (e) {
  //    print("Error: ${e}");
  //  } finally {
   //   EasyLoading.dismiss();
   // }
    update();
  }

  /// Send Phone Verification OTP
  Future<void> sendPhoneVerificationOTP(BuildContext context,
      {bool isResend = false}) async
  {
    try {
      EasyLoading.show();
      FocusScope.of(context).requestFocus(FocusNode());
      Map<String, dynamic> params = {
        'mobile_number': phoneNumberCtrl.text.trim(),
        'country_id': selectedCountry.value!.id ?? ""
      };
      ApiResponse? verifyModelAPI = await authenticationRepo
          .sendOTPOnPhone(context, params, isResend: isResend);

      if (verifyModelAPI!.success == true) {
        update();



        DialogUtilities.showDialog(
          message: verifyModelAPI!.message!,
        );



        isPhoneOTPShow.value = true;
      } else {
        print(verifyModelAPI.message);
        DialogUtilities.showDialog(
          title: "Error",
          message: verifyModelAPI!.message!,
        );
        isPhoneOTPShow.value = false;
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    startMobileOTPTimer();
    update();
  }

  /// Verify Phone
  Future<void> verifyPhone(BuildContext context) async
  {
    try {
      EasyLoading.show();
      FocusScope.of(context).requestFocus(FocusNode());
      Map<String, dynamic> params = {
        'mobile_number':
            "${selectedCountry.value!.isdcode!.replaceAll('+', '')}${phoneNumberCtrl.text.trim()}",
        'otp': phoneOTPCtrl.text.trim(),
      };
      Map<String, dynamic>? verifyModelAPI =
          await authenticationRepo.verifyPhoneOTP(context, params);

      if (verifyModelAPI != null) {
        isPhoneVerifyError.value = false;
        isPhoneVerify.value = true;
        update();



        DialogUtilities.showDialog(

          message:    verifyModelAPI['message'],
        );

      } else {
        isPhoneVerifyError.value = true;
        isPhoneVerify.value = false;
        phoneOTPCtrl.clear();
      }
    } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }
    update();
  }




  // Register User
  Future<void> editBasicInfo(BuildContext context) async {
    // try {


      try {
        EasyLoading.show();
        FocusScope.of(context).requestFocus(FocusNode());
        Map<String, dynamic> params = {
          "id_type": selectedIdType.value,
         'first_name': firstNameCtrl.text,
         'middle_name': middleNameCtrl.text,
         'last_name':  lastNameCtrl.text,
          "id_number": idNumberCtrl.text,
          "expiry_id_date": idExpiryDateCtrl.text,
          "issue_id_date": idIssueDateCtrl.text,
          "city": cityCtrl.text,
          "state": stateCtrl.text,
          "zip_code": zipCtrl.text,
          "date_of_birth": dateOfBirthCtrl.text,
          "gender": selectedGender.value.toString().capitalizeFirst,
          "address": fullAdressCtrl.text,
          "business_activity_occupation": selectedBusinessOccupation.value,
          "source_of_fund": selectedSourceOfFund.value,
        };
        UserModel? apiResponse = await authenticationRepo.editBasicInfo(context,params);
        print("UserModel API :: ${apiResponse?.toJson()}");
        if (apiResponse != null) {
          commonController.userModel.value = apiResponse;
          commonController.update();
          update();
          EasyLoading.dismiss();

        }
      } catch (e) {
        print("Error: ${e}");
      } finally {
        EasyLoading.dismiss();

    }
  }

























  // Register User
  Future<void> registerUser(BuildContext context) async {
   // try {
      if (isTermAccepted.value) {
        if (isPhoneVerify.value && isEmailVerify.value) {
          EasyLoading.show();
          FocusScope.of(context).requestFocus(FocusNode());
          Map<String, dynamic> params = {
            'first_name': firstNameCtrl.text.trim(),
            'middle_name': middleNameCtrl.text.trim(),
            'last_name': lastNameCtrl.text.trim(),
            if (registerType.value == 1)
            "company_name": comanyNameCtrl.text.trim(),
            'email': emailCtrl.text.trim(),
            'is_email_verify': isEmailVerify.value ? 1 : 0,
            'password': passwordCtrl.text.trim(),
            'password_confirmation': confirmPasswordCtrl.text.trim(),
            'country_id': selectedCountry.value?.id,
          'mobile_number': phoneNumberCtrl.text.trim(),

            'is_mobile_verify': isPhoneVerify.value ? 1 : 0,
            'referalcode': refferalCodeCtrl.text.trim(),
            "id_type": selectedIdType.value,

            "id_number": idNumberCtrl.text,
            "expiry_id_date": idExpiryDateCtrl.text,
            "issue_id_date": idIssueDateCtrl.text,
            "city": cityCtrl.text,
            "state": stateCtrl.text,
            "zip_code": zipCtrl.text,
            "date_of_birth": dateOfBirthCtrl.text,
            "gender": selectedGender.value.toString().capitalizeFirst,
            "address": fullAdressCtrl.text,
            "business_activity_occupation": selectedBusinessOccupation.value,
            "source_of_fund": selectedSourceOfFund.value,
            'terms': 1
          };
          ApiResponse? response = await authenticationRepo.registerUser(
              context, params,
              isCompany: (registerType.value == 1));
          print("UserModel API :: ${response}");

          UserModel? userModelAPI;

          if (response != null && response!.success == false) {
            if (response.data['errors'] != null) {
              setFieldErrors(response.data['errors']);
            }
          }else
          {
            if (response != null) {
              userModelAPI= UserModel.fromJson(jsonDecode(response!.data));
            }

          }




          if (userModelAPI != null) {
            commonController.userModel.value = userModelAPI;

            SharedPref.setUserToken(
                commonController.userModel.value?.token ?? '');
            commonController.update();

            if (registerType.value == 0) {
              if (commonController.userModel.value!.isKycVerify == 1) {
                Get.offAllNamed(
                  RouteUtilities.dashboard,
                );
              } else if (commonController.userModel.value!.isKycVerify != 1 &&
                  registerType.value == 0) {
                showMetaMapFlow();
                // Get.toNamed(RouteUtilities.kycScreen);
              } else {
                Get.offAllNamed(
                  RouteUtilities.dashboard,
                );
              }
            } else {
              Get.toNamed(RouteUtilities.kycScreen);
            }
            // Get.offAllNamed(RouteUtilities.dashboard);

            clearData();
          }

          update();
        } else {
          if (!isEmailVerify.value) {




            DialogUtilities.showDialog(
              title: "Error",
              message:    "Please Verify Your email",
            );



          } else if (!isPhoneVerify.value) {


            DialogUtilities.showDialog(
              title: "Error",
              message:  "Please Verify Your Phone",
            );

          }
        }
      } else {

        DialogUtilities.showDialog(
          title: "Error",
          message:  "Please accept term & condition first",
        );


      }
   /* } catch (e) {
      print("Error: ${e}");
    } finally {
      EasyLoading.dismiss();
    }*/
      EasyLoading.dismiss();
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
  Map<String, Map<String, String>> documentStatus = {};
  Map<String, Map<String, List<PlatformFile>>> uploadedFiles = {};
  CompanyDirectors? selectedDirector;
  DocumentTypes? selectedDocument;

  Future<bool> uploadAllFilesToServer() async {
    int pendingCount = 0;

    for (var director
        in companyDisplayDataModel!.value!.companyDetail!.companyDirectors!) {
      print("pendingCount");
      print(director.name);
      print(documentStatus.length);
      if (documentStatus[director.name] != null) {
        pendingCount +=
            companyDisplayDataModel!.value!.documentTypes!.where((doc) {
          print("pendingCount");

          final docLabel = doc.label!;
          final status = documentStatus[director.name]![docLabel] ?? 'Pending';

          print("status");
          print(status != 'Done');
          print("selectedDocument?.label == docLabel");
          print(selectedDocument?.label);
          print(docLabel);
          print(selectedDocument?.label == docLabel);
          print(status != 'Done' || selectedDocument?.label == docLabel);

          return status != 'Done' || selectedDocument?.label == docLabel;
        }).length;
      }

      if (companyDisplayDataModel!
              .value!.companyDetail!.companyDirectors!.length !=
          documentStatus.length) {
        pendingCount += 1;
      }
    }

    print("pendingCount");
    print(pendingCount);

    if (pendingCount > 0) {

      DialogUtilities.showDialog(
        title: "Error",
        message:  'Please Upload All Files',
      );


      return false;
    }

    List<File> files = [];
    List<String> filesKeys = [];

    uploadedFiles.forEach((directorName, docMap) {
      final director = companyDisplayDataModel!
          .value!.companyDetail!.companyDirectors!
          .firstWhere((e) => e.name == directorName);

      int directorId = director.id!;

      docMap.forEach((docLabel, fileList) {
        for (var docType in companyDisplayDataModel.value!.documentTypes!) {
          if (docType.label == docLabel) {
            int docId = docType.id!;
            filesKeys.add("company_director_id[$directorId][$docId][]");
            files.add(File(fileList[0].path!));
          }
        }
      });
    });

    Map<String, dynamic> params = {
      'company_details_id': companyDisplayDataModel.value!.companyDetail!.id
    };

    var apiResponse = await authenticationRepo.addKycData(
      Get.context!,
      params,
      files: files,
      filesKeys: filesKeys,
    );

    if (apiResponse?.success == true) {
      Get.dialog(
        barrierDismissible: false,
        ResultDialog(
          title: "KYC Processing",
          positiveButtonText: "Close",
          showCloseButton: false,
          onPositveTap: () {
            KycController kycController = Get.find();
            kycController.currentStepIndex.value = 0;
            kycController.update();
            clearData();
            SharedPref.setUserToken('');
            Get.offAllNamed(RouteUtilities.loginScreen);
          },
          description:
              'Your documents are under review to ensure they meet our verification requirements. we will notify you once the process is completed',
        ),
      );
      return true;
    } else {
      print(apiResponse);
      return false;
    }
  }

  logout() {
    KycController kycController = Get.find();
    kycController.currentStepIndex.value = 0;
    kycController.update();
    clearData();
    SharedPref.setUserToken('');
    Get.offAllNamed(RouteUtilities.loginScreen);
  }

  @override
  void onClose() {
    _emailTimer?.cancel();
    _mobileTimer?.cancel();
    super.onClose();
  }
}

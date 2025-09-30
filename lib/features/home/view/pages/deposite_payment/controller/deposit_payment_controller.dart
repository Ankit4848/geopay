import 'dart:convert';
import 'dart:io';

import 'package:device_user_agent/device_user_agent.dart';
import 'package:geopay/core/widgets/dialogs/result_dialog.dart';
import 'package:geopay/core/widgets/dialogs/dialog_utilities.dart';
import 'package:geopay/features/home/data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../repo/home_repo.dart';
import '../view/payment_webview_screen.dart';
import '../../../../../../config/navigation/app_route.dart';
import '../../../../../authentication/repo/authentication_repo.dart';
import '../../../../../common/controller/common_controller.dart';
import '../../../../../common/model/CountryCollectionModel.dart';
import '../../../../../common/model/user_model.dart';
import '../../../../../common/repo/common_repo.dart';
import '../../../../model/drop_down_model.dart';
import 'package:crypto/crypto.dart';

class DepositPaymentController extends GetxController {
  RxInt selectedMethodOptionIndex = 0.obs;

  // Original fields
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController beneficiaryNameCtrl = TextEditingController();
  TextEditingController accountDescriptionCtrl = TextEditingController();

  // New Card Payment fields
  TextEditingController cardHolderNameCtrl = TextEditingController();
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController cvvCtrl = TextEditingController();

  // Expiry Date dropdowns
  RxnString selectedExpiryMonth = RxnString();
  RxnString selectedExpiryYear = RxnString();
  RxnString processingFee  = RxnString();
  RxnString netAmount = RxnString();

  // Card type tracking
  RxString detectedCardType = 'Unknown'.obs;

  RxList<DropDownModel> countryList = <DropDownModel>[].obs;

  RxList<CountryCollectionModel> countryCollectionList =
      <CountryCollectionModel>[].obs;


  CommonRepo commonRepo = CommonRepo();
  final selectedCountry = Rxn<CountryCollectionModel>();

  final selectedChannel = RxnString();

  // Get Country List
  Future<void> getCountryList() async {
    try {
      List<CountryCollectionModel>? countryListAPI = await commonRepo.getCountryCollectionModelList(Get.context!);
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
      // Parse the amount entered by user
      double amount = double.tryParse(amountCtrl.text) ?? 0.0;
      // Get commission values with default 0 if null
      String commissionType = commonController.userModel.value?.cardCommissionType ?? "flat";
      double commissionCharge = double.tryParse(commonController.userModel.value?.cardCommissionCharge ?? "0") ?? 0.0;
      double processingFeeAmount = 0.0;
      double netAmountValue = amount;
      
      print("Amount: $amount");
      print("Commission Type: $commissionType");
      print("Commission Charge: $commissionCharge");
      
      if (amount > 0) {
        if (commissionType == "flat") {
          // Flat fee calculation
          processingFeeAmount = commissionCharge;
          netAmountValue = amount + processingFeeAmount;
          
          print("Flat fee calculation:");
          print("Processing Fee: $processingFeeAmount");
          print("Net Amount: $netAmountValue");
          
        } else if (commissionType == "percentage") {
          // Percentage fee calculation
          processingFeeAmount = (amount * commissionCharge) / 100;
          netAmountValue = amount + processingFeeAmount;
          
          print("Percentage fee calculation:");
          print("Processing Fee: $processingFeeAmount (${commissionCharge}% of $amount)");
          print("Net Amount: $netAmountValue");
          
        } else {
          // Default case - treat as flat fee
          processingFeeAmount = commissionCharge;
          netAmountValue = amount + processingFeeAmount;
          
          print("Default (flat) fee calculation:");
          print("Processing Fee: $processingFeeAmount");
          print("Net Amount: $netAmountValue");
        }
      }
      
      // Update the reactive variables
      processingFee.value = processingFeeAmount.toStringAsFixed(2);
      netAmount.value = netAmountValue.toStringAsFixed(2);
      
      print("Final values:");
      print("Processing Fee: ${processingFee.value}");
      print("Net Amount: ${netAmount.value}");
      
    } catch (e) {
      print("Error in fetchAmountBreakdown: $e");
      // Set default values in case of error
      processingFee.value = "0.00";
      netAmount.value = amountCtrl.text.isNotEmpty ? amountCtrl.text : "0.00";
    } finally {
      update();
    }
  }

  RxBool isbtnClick = false.obs;

  // Card Details Validation
  bool validateCardDetails() {
    fieldErrors.clear();
    bool isValid = true;

    // Validate Cardholder Name
    if (cardHolderNameCtrl.text.trim().isEmpty) {
      fieldErrors['cardholder_name'] = 'Cardholder name is required';
      isValid = false;
    }

    // Validate Card Number
    String cardNumber = cardNumberCtrl.text.replaceAll(' ', '');
    if (cardNumber.isEmpty) {
      fieldErrors['card_number'] = 'Card number is required';
      isValid = false;
    } else if (cardNumber.length < 13) {
      fieldErrors['card_number'] = 'Card number must be at least 13 digits';
      isValid = false;
    } else if (cardNumber.length > 16) {
      fieldErrors['card_number'] = 'Card number cannot exceed 16 digits';
      isValid = false;
    } else if (!_isValidCardNumber(cardNumber)) {
      fieldErrors['card_number'] = 'Invalid card number';
      isValid = false;
    }

    // Validate Expiry Month
    if (selectedExpiryMonth.value == null || selectedExpiryMonth.value!.isEmpty) {
      fieldErrors['expiry_month'] = 'Expiry month is required';
      isValid = false;
    }

    // Validate Expiry Year
    if (selectedExpiryYear.value == null || selectedExpiryYear.value!.isEmpty) {
      fieldErrors['expiry_year'] = 'Expiry year is required';
      isValid = false;
    } else if (selectedExpiryMonth.value != null && selectedExpiryMonth.value!.isNotEmpty) {
      // Check if card is not expired
      DateTime now = DateTime.now();
      int month = int.parse(selectedExpiryMonth.value!);
      int year = int.parse(selectedExpiryYear.value!);
      DateTime expiryDate = DateTime(year, month + 1, 0); // Last day of expiry month
      
      if (expiryDate.isBefore(now)) {
        fieldErrors['expiry_year'] = 'Card has expired';
        isValid = false;
      }
    }

    // Validate CVV
    if (cvvCtrl.text.trim().isEmpty) {
      fieldErrors['cvv'] = 'CVV is required';
      isValid = false;
    } else if (cvvCtrl.text.length < 3 || cvvCtrl.text.length > 4) {
      fieldErrors['cvv'] = 'Invalid CVV';
      isValid = false;
    }

    // Validate Amount
    if (amountCtrl.text.trim().isEmpty) {
      fieldErrors['amount'] = 'Amount is required';
      isValid = false;
    } else {
      double? amount = double.tryParse(amountCtrl.text);
      if (amount == null || amount <= 0) {
        fieldErrors['amount'] = 'Please enter a valid amount';
        isValid = false;
      } else if (amount < 1) {
        fieldErrors['amount'] = 'Minimum amount is \$1';
        isValid = false;
      } else if (amount > 10000) {
        fieldErrors['amount'] = 'Maximum amount is \$10,000';
        isValid = false;
      }
    }

    update();
    return isValid;
  }

  // Luhn Algorithm for card validation
  bool _isValidCardNumber(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);
      
      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }
      
      sum += digit;
      alternate = !alternate;
    }
    
    return sum % 10 == 0;
  }

  // WebView Payment Processing
  Future<void> processCardPaymentWithWebView() async {

    print('netAmount::: ${netAmount.value}');
    print('Processing Fee::: $processingFee');
    try {
      EasyLoading.show(dismissOnTap: false);
      // Auto-detect card type from card number
      String detectedCardType = getCardTypeFromNumber(getRawCardNumber());
      Map<String, dynamic> params = {
        "cardtype": detectedCardType.toLowerCase(),
        "cardname": cardHolderNameCtrl.text.trim(),
        "cardnumber": getRawCardNumber(), // Use helper method for raw digits
        "month": selectedExpiryMonth.value,
        "year": selectedExpiryYear.value,
        "cvv": cvvCtrl.text.trim(),
        "amount": amountCtrl.text.trim(),
        "netAmount":netAmount.value,
        "platformCharge":processingFee.value
      };
      print("Card Payment Params: $params");

      // TODO: Replace with your actual API call to get payment link
      ApiResponse? paymentUrl = await commonRepo.processCardPayment(Get.context!, params);

      // Using your example URL for demo
      //String paymentUrl = "https://ggapi.ibanera.com/secure/start?hash=1smADUTI8vCL74XQlBceLk73nDbUV57QB1F8%2FM4T5OO9S5azEYTnVDhNdmmAiv20";

    //  print("Card Payment Params: ${paymentUrl!.message!}");
   //   print("Card Payment Params: ${paymentUrl!.data["response"]["payment_link"]}");
      EasyLoading.dismiss();
      if(paymentUrl!=null && paymentUrl.success==true) {
        // Open WebView with payment URL
        final result = await Get.to(() => PaymentWebViewScreen(
              paymentUrl: paymentUrl!.data["response"]["payment_link"],
              onPaymentComplete: (isSuccess, message) {
                print(
                    'Payment completed: Success=$isSuccess, Message=$message');
              },
            ));
        // Handle WebView result
        if (result != null) {
          bool isSuccess = result['success'] ?? false;
          String message = result['message'] ?? '';
          if (isSuccess) {
            // Payment successful
            Get.dialog(
              barrierDismissible: false,
              ResultDialog(
                title: "Success",
                positiveButtonText: "Continue",
                showCloseButton: false,
                onPositveTap: () async {
                  Get.back();
                  clearAllFields();
                  await getUserInfo();
                },
                descriptionWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
                description: '',
              ),
            );
          } else
          {
            // Payment failed - Use Dialog instead of SnackBar
            DialogUtilities.showError(
              message.isNotEmpty ? message : "Payment failed. Please try again.",
              title: "Payment Failed",
            );
          }
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      // Payment error - Use Dialog instead of SnackBar
      DialogUtilities.showError(
        "Payment error: ${e.toString()}",
        title: "Payment Error",
      );
    } finally {
      isbtnClick.value = false;
      update();
    }
  }




  /*Future<void> processCardPaymentWithWebView() async {
    // try {
    //    EasyLoading.show(dismissOnTap: false);


    final result = await HttpClient()
        .getUrl(Uri.parse("https://api.ipify.org"))
        .then((req) => req.close());

    final ip = await result.transform(SystemEncoding().decoder).join();

    // Auto-detect card type from card number
    String detectedCardType = getCardTypeFromNumber(getRawCardNumber());

    // Current timestamp in seconds
    int timestampSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Current timestamp in milliseconds
    int timestampMilliseconds = DateTime.now().millisecondsSinceEpoch;


    String siteKey = "geo-payments-3d-29-j63moxoq";
    String secret = "79644ad8403668ec5d9f626fa467d5dca08e10f7560fcf8b64649cf334b7ed45";
    int timestamp = timestampSeconds;
    String amount = netAmount.value ?? amountCtrl.text.trim();
    String currency = "USD";
    // Concatenate data


    String dataToHash = "$siteKey|$timestamp|$amount|$currency|$secret";
    print(dataToHash);
    // Generate SHA-256 hash
    var bytes = utf8.encode(dataToHash);
    var digest = sha256.convert(bytes);

    String serverHash = digest.toString();

    final userAgent = await DeviceUserAgent.instance.build();

    var a=  commonController.countryList.firstWhere((element) {

      return element.id==commonController.userModel.value!.countryId;

    },);

    print(a.name);
    print(a.iso);
    print(a.iso3);

    String code = generateCode(commonController.userModel.value!.id!);

    Map<String, dynamic> params = {
      "cardtype": detectedCardType.toLowerCase(),
      "cardname": cardHolderNameCtrl.text.trim(),
      "cardnumber": getRawCardNumber(), // Use helper method for raw digits
      "month": selectedExpiryMonth.value,
      "year": selectedExpiryYear.value,
      "cvv": cvvCtrl.text.trim(),
      "amount": double.parse(netAmount.value??amountCtrl.text),
      "merchant_site_key": "geo-payments-3d-29-j63moxoq",
      "securehash": serverHash,
      "first_name":commonController.userModel.value!.firstName??"",
      "last_name": commonController.userModel.value!.lastName??"",
      "email": commonController.userModel.value!.email??"",
      "phone": commonController.userModel.value!.mobileNumber??"",
      "address": commonController.userModel.value!.address??"",
      "city": commonController.userModel.value!.city??"",
      "state": commonController.userModel.value!.state??"",
      "postalcode": commonController.userModel.value!.zipCode??"",
      "country": a.iso??"",
      "timestamp": timestamp,
      "currency": "USD",
      "merchant_orderid": code??"",
      "redirecturl": "https://geo.travelieons.com/deposit/payment", // e.g https://order_success.com
      "ipaddress": ip??"",
      "browseragent": userAgent
    };
    print("Card Payment Params: ${jsonEncode(params)}");







    // TODO: Replace with your actual API call to get payment link
    ApiResponse? paymentUrl = await commonRepo.processCardPayment(Get.context!, params);
    print("Card Payment Params: ${paymentUrl!.data!}");

    isbtnClick.value = false;
    update();
    // Using your example URL for demo
    //String paymentUrl = "https://ggapi.ibanera.com/secure/start?hash=1smADUTI8vCL74XQlBceLk73nDbUV57QB1F8%2FM4T5OO9S5azEYTnVDhNdmmAiv20";

    //  print("Card Payment Params: ${paymentUrl!.message!}");
    //   print("Card Payment Params: ${paymentUrl!.data["response"]["payment_link"]}");
    *//*  EasyLoading.dismiss();
      if(paymentUrl!=null && paymentUrl.success==true) {
        // Open WebView with payment URL
        final result = await Get.to(() => PaymentWebViewScreen(
              paymentUrl: paymentUrl!.data["response"]["payment_link"],
              onPaymentComplete: (isSuccess, message) {
                print(
                    'Payment completed: Success=$isSuccess, Message=$message');
              },
            ));
        // Handle WebView result
        if (result != null) {
          bool isSuccess = result['success'] ?? false;
          String message = result['message'] ?? '';
          if (isSuccess) {
            // Payment successful
            Get.dialog(
              barrierDismissible: false,
              ResultDialog(
                title: "Success",
                positiveButtonText: "Continue",
                showCloseButton: false,
                onPositveTap: () async {
                  Get.back();
                  clearAllFields();
                  await getUserInfo();
                },
                descriptionWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
                description: '',
              ),
            );
          } else
          {
            // Payment failed - Use Dialog instead of SnackBar
            DialogUtilities.showError(
              message.isNotEmpty ? message : "Payment failed. Please try again.",
              title: "Payment Failed",
            );
          }
        }
      }*//*
    *//* } catch (e) {
      EasyLoading.dismiss();
      // Payment error - Use Dialog instead of SnackBar
      DialogUtilities.showError(
        "Payment error: ${e.toString()}",
        title: "Payment Error",
      );
    } finally {
      isbtnClick.value = false;
      update();
    }*//*
  }*/




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

  // New methods for card expiry
  void changeExpiryMonth(String month) {
    selectedExpiryMonth.value = month;
    fieldErrors.remove('expiry_month');
    update();
  }

  void changeExpiryYear(String year) {
    selectedExpiryYear.value = year;
    fieldErrors.remove('expiry_year');
    update();
  }

  // Method to format card number with spaces and limit to 16 digits
  void formatCardNumber(String value) {
    // Remove all non-digit characters
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Limit to 16 digits maximum
    if (digitsOnly.length > 16) {
      digitsOnly = digitsOnly.substring(0, 16);
    }
    
    // Add spaces every 4 digits
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }
    
    // Update the controller without triggering listener recursively
    if (cardNumberCtrl.text != formatted) {
      cardNumberCtrl.value = cardNumberCtrl.value.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
      
      // Update card type detection
      updateCardType(digitsOnly);
      
      // Clear card number error if exists
      fieldErrors.remove('card_number');
      update();
    }
  }
  
  // Method to format CVV and limit to 4 digits
  void formatCVV(String value) {
    // Remove all non-digit characters and limit to 4 digits
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > 4) {
      digitsOnly = digitsOnly.substring(0, 4);
    }
    
    // Update the controller
    if (cvvCtrl.text != digitsOnly) {
      cvvCtrl.value = cvvCtrl.value.copyWith(
        text: digitsOnly,
        selection: TextSelection.collapsed(offset: digitsOnly.length),
      );
      
      // Clear CVV error if exists
      fieldErrors.remove('cvv');
      update();
    }
  }
  
  // Update card type detection
  void updateCardType(String cardNumber) {
    detectedCardType.value = getCardTypeFromNumber(cardNumber);
    print("Detected card type: ${detectedCardType.value} for number: $cardNumber");
    update();
  }

  // Get card type from card number
  String getCardTypeFromNumber(String cardNumber) {
    cardNumber = cardNumber.replaceAll(' ', '');
    
    if (cardNumber.isEmpty) return 'Unknown';
    
    if (cardNumber.startsWith('4')) {
      return 'Visa';
    } else if (cardNumber.startsWith('5') || 
               (cardNumber.length >= 4 && 
                int.tryParse(cardNumber.substring(0, 4)) != null &&
                int.parse(cardNumber.substring(0, 4)) >= 2221 && 
                int.parse(cardNumber.substring(0, 4)) <= 2720)) {
      return 'Mastercard';
    } else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
      return 'American Express';
    } else if (cardNumber.startsWith('6011') || 
               cardNumber.startsWith('65') ||
               (cardNumber.length >= 6 && 
                int.tryParse(cardNumber.substring(0, 6)) != null &&
                int.parse(cardNumber.substring(0, 6)) >= 622126 && 
                int.parse(cardNumber.substring(0, 6)) <= 622925)) {
      return 'Discover';
    } else if (cardNumber.startsWith('30') || 
               cardNumber.startsWith('36') || 
               cardNumber.startsWith('38')) {
      return 'Diners Club';
    } else if (cardNumber.startsWith('35')) {
      return 'JCB';
    } else if (cardNumber.startsWith('62')) {
      return 'Union Pay';
    } else {
      return 'Unknown';
    }
  }

  // Helper method to format currency
  String formatCurrency(String? value) {
    if (value == null || value.isEmpty) return "0.00";
    double amount = double.tryParse(value) ?? 0.0;
    return amount.toStringAsFixed(2);
  }
  
  // Helper method to get processing fee display text
  String getProcessingFeeText() {
    if (processingFee.value == null) return "0.00";
    return formatCurrency(processingFee.value);
  }
  
  // Helper method to get net amount display text
  String getNetAmountText() {
    if (netAmount.value == null) return amountCtrl.text.isNotEmpty ? amountCtrl.text : "0.00";
    return formatCurrency(netAmount.value);
  }
  
  // Method to manually trigger amount breakdown calculation
  void calculateAmountBreakdown() {
    fetchAmountBreakdown();
  }
  
  // Helper method to get raw card number (digits only) for API calls
  String getRawCardNumber() {
    return cardNumberCtrl.text.replaceAll(' ', '');
  }
  
  // Helper method to check if card number is complete (16 digits)
  bool isCardNumberComplete() {
    String rawNumber = getRawCardNumber();
    return rawNumber.length == 16;
  }
  
  // Helper method to get formatted card number for display
  String getFormattedCardNumber() {
    return cardNumberCtrl.text;
  }

  @override
  void onInit() {
    countryList.assignAll(HomeData.countryList);
    getCountryList();
    
    // Add listener to amount field to auto-calculate fees
    amountCtrl.addListener(() {
      if (amountCtrl.text.isNotEmpty) {
        fetchAmountBreakdown();
      } else {
        // Clear values when amount is empty
        processingFee.value = null;
        netAmount.value = null;
        update();
      }
    });
    
    // Add listener to card number field for auto-formatting
    cardNumberCtrl.addListener(() {
      if (cardNumberCtrl.text.isNotEmpty) {
        // Only format if the text doesn't already have proper formatting
        String currentText = cardNumberCtrl.text;
        String digitsOnly = currentText.replaceAll(RegExp(r'\D'), '');
        
        // Format only if it's not already properly formatted
        if (digitsOnly.length <= 16) {
          String expectedFormat = '';
          for (int i = 0; i < digitsOnly.length; i++) {
            if (i > 0 && i % 4 == 0) {
              expectedFormat += ' ';
            }
            expectedFormat += digitsOnly[i];
          }
          
          if (currentText != expectedFormat) {
            formatCardNumber(currentText);
          }
        }
      }
    });
    
    // Add listener to CVV field for digit-only input
    cvvCtrl.addListener(() {
      if (cvvCtrl.text.isNotEmpty) {
        String currentText = cvvCtrl.text;
        String digitsOnly = currentText.replaceAll(RegExp(r'\D'), '');
        
        if (currentText != digitsOnly || digitsOnly.length > 4) {
          formatCVV(currentText);
        }
      }
    });
    
    super.onInit();
  }


  
  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    amountCtrl.dispose();
    mobileCtrl.dispose();
    beneficiaryNameCtrl.dispose();
    accountDescriptionCtrl.dispose();
    cardHolderNameCtrl.dispose();
    cardNumberCtrl.dispose();
    cvvCtrl.dispose();
    super.onClose();
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
    // Original fields
    mobileCtrl.clear();
    amountCtrl.clear();
    beneficiaryNameCtrl.clear();
    accountDescriptionCtrl.clear();
    
    // Card payment fields
    cardHolderNameCtrl.clear();
    cardNumberCtrl.clear();
    cvvCtrl.clear();
    selectedExpiryMonth.value = null;
    selectedExpiryYear.value = null;
    
    // Clear errors and other values
    fieldErrors.clear();
    selectedCountry.value = null;
    selectedChannel.value = null;

    isbtnClick.value = false;
    update();
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

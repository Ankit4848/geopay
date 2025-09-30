part of 'api.dart';

/// This is the class to manage all endpoints used in the application for APIs.
class APIUtilities {
  /// this is the base URL or host URL.
  // static const String _baseUrl = 'http://194.238.16.24/api/';
  static const String _baseUrl = 'https://geo.travelieons.com/api/';

  // static const String imagePrefix = 'http://194.238.16.24/';
  static const String imagePrefix = 'https://geo.travelieons.com/';







  /// login
  static const String walletWithoutQR = '${_baseUrl}wallet-to-wallet';

  /// login
  static const String loginUrl = '${_baseUrl}login';


  /// logOut
  static const String logOutUrl = '${_baseUrl}logout';

  /// Edit Profile
  static const String editProfile = '${_baseUrl}user-profile-update';
  static const String companyKycDocumentStore = '${_baseUrl}company-kyc-document-store';

  /// Get Country List
  static const String getCountryList = '${_baseUrl}country-list';


  static const String getCompanyKycDetails = '${_baseUrl}company-kyc-details';
  static const String getCompanyKycStep1 = '${_baseUrl}company-kyc/step/1';
  static const String getCompanyKycStep2 = '${_baseUrl}company-kyc/step/2';

  static const String getCommonDetails = '${_baseUrl}common-details';

  static const String getCountryCollectionModelList = '${_baseUrl}collection/country-list';

  static const String getMTMCountryList = '${_baseUrl}transfer-mobile-money/country-list';
  static const String getTTBCountryList = '${_baseUrl}transfer-bank/country-list';


  static const String getMTMRecentList = '${_baseUrl}transfer-mobile-money/recent-beneficiary';
  static const String getTTBRecentList = '${_baseUrl}transfer-bank/recent-beneficiary';

  static const String getCommission= '${_baseUrl}collection/commission';

  static const String getCommissionStore= '${_baseUrl}collection/store';

  static const String getAirtimeOperator= '${_baseUrl}international-airtime/operator';
  static const String getAirtimeProduct= '${_baseUrl}international-airtime/products';
  static const String getValidateMobile= '${_baseUrl}international-airtime/mobile-validate';
  static const String getStoreTransaction= '${_baseUrl}international-airtime/store-transaction';

  static const String getTmtoMFieldsViewBaene= '${_baseUrl}transfer-mobile-money/fields-view';
  static const String getTTBFieldsViewBene= '${_baseUrl}transfer-bank/get-fields-by-bank';

  static const String getTmtoMFieldsViewBaeneStore= '${_baseUrl}transfer-mobile-money/beneficiary-store';
  static const String getTTBFieldsViewBeneStore= '${_baseUrl}transfer-bank/beneficiary-store';

  static const String getTMtoMBeneListStore= '${_baseUrl}transfer-mobile-money/beneficiary-list';
  static const String getTTBBeneListStore= '${_baseUrl}transfer-bank/beneficiary-list';
  static const String getBeneListStore= '${_baseUrl}beneficiery-list';

  static const String getTMtoMBeneDeleteStore= '${_baseUrl}transfer-mobile-money/beneficiary-delete/';
  static const String getTTBBeneDeleteStore= '${_baseUrl}transfer-bank/beneficiary-delete/';

  static const String getTMtoMBeneUpdateStore= '${_baseUrl}transfer-mobile-money/beneficiary-update/';
  static const String getTTBBeneUpdateStore= '${_baseUrl}transfer-bank/beneficiary-update/';

  static const String getTMtoMCommissionStore= '${_baseUrl}transfer-mobile-money/commission/';
  static const String getTTBCommissionStore= '${_baseUrl}transfer-bank/commission/';

  static const String getTMtoMStore= '${_baseUrl}transfer-mobile-money/store-transaction';
  static const String getTTBStore= '${_baseUrl}transfer-bank/store-transaction';

  static const String getTTBBankList= '${_baseUrl}transfer-bank/bank-list';

  static const String getTransactionList= '${_baseUrl}transaction-list';
  static const String getNotificationList= '${_baseUrl}notification-list';

  /// Get UserInfo
  static const String getUserInfo = '${_baseUrl}user-details';

  /// Get UserInfo
  static const String postPassword = '${_baseUrl}verify-password';

  /// Get Update Profile
  static const String updateProfile = '${_baseUrl}update-profile';

  /// Register induvidual
  static const String registerUrl = '${_baseUrl}individual-register';

  /// Register comapany
  static const String registerWithCompanyUrl = '${_baseUrl}company-register';

  /// Send Verification Email
  static const String sendVerificationEmail = '${_baseUrl}email/send';

  /// Re send Verification Email
  static const String reSendVerificationEmail = '${_baseUrl}email/resend';

  /// Verify Email
  static const String verifyEmail = '${_baseUrl}email/verify-otp';

  /// Send Phone OTP
  static const String sendPhoneOTP = '${_baseUrl}mobile/send';

  /// Re send Phone OTP
  static const String reSendPhoneOTP = '${_baseUrl}mobile/resend';

  /// Verify Email
  static const String verifyMobile = '${_baseUrl}mobile/verify-otp';

  /// Forgot Password
  static const String forgotPassword = '${_baseUrl}forgot-password';

  /// Forgot Password Resend OTP
  static const String forgotPasswordResendOTP = '${_baseUrl}forgot-resend-otp';

  /// Verify Forgot password Email
  static const String verifyForgotEmail = '${_baseUrl}verify-email-otp';

  /// Reset Password
  static const String resetPassword = '${_baseUrl}reset-password';

  ///User Reset Password
  static const String userResetPassword = '${_baseUrl}user-reset-password';

  /// Card Payment Processing
  static const String processCardPayment = '${_baseUrl}deposit/payment-link';
}

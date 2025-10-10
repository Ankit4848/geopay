import 'package:geopay/features/authentication/pages/forgot_password/view/create_password.dart';
import 'package:geopay/features/authentication/pages/forgot_password/view/forgot_password_screen.dart';
import 'package:geopay/features/authentication/pages/login/view/login_screen.dart';
import 'package:geopay/features/authentication/pages/login/view/login_with_biometric_screen.dart';
import 'package:geopay/features/authentication/pages/login/view/otp_verification.dart';
import 'package:geopay/features/authentication/pages/register/view/register_screen.dart';
import 'package:geopay/features/dashboard/view/dashboard.dart';
import 'package:geopay/features/home/view/pages/add_money/view/add_money_screen.dart';
import 'package:geopay/features/home/view/pages/airtime/view/airtime_screen.dart';
import 'package:geopay/features/home/view/pages/airtime/view/select_operator_screen.dart';
import 'package:geopay/features/home/view/pages/airtime/view/select_recharge_plan_screen.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/view/bank_transfer_screen.dart';
import 'package:geopay/features/home/view/pages/deposite_payment/view/deposit_payment_screen.dart';
import 'package:geopay/features/home/view/pages/momo_transfer/view/momo_transfer_screen.dart';
import 'package:geopay/features/home/view/pages/pay_to_wallet/view/pay_to_walllet_screen.dart';
import 'package:geopay/features/home/view/pages/pay_to_wallet/view/pay_without_qr_screen.dart';
import 'package:geopay/features/home/view/pages/scan_me/view/qr_screen.dart';
import 'package:geopay/features/kyc/view/kyc_screen.dart';
import 'package:geopay/features/profile/view/about_us_screen.dart';
import 'package:geopay/features/profile/view/change_password_screen.dart';
import 'package:geopay/features/profile/view/contact_us_screen.dart';
import 'package:geopay/features/profile/view/edit_profile_screen.dart';
import 'package:geopay/features/profile/view/faq_screen.dart';
import 'package:flutter/material.dart';

import '../../features/home/view/pages/airtime/view/recharge_invoice_screen.dart';
import '../../features/home/view/pages/bank_transfer/view/bank_transfer_select_screen.dart';
import '../../features/home/view/pages/momo_transfer/view/momo_transfer_select_screen.dart';
import '../../features/onboarding/view/onboaring_screen.dart';
import '../../features/profile/view/basic_info_screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../../features/splash/view/splash_screen.dart';

class RouteUtilities {
  /// first screen to open in the application.
  static const String root = '/';

  /// splash screen.
  static const String splashScreen = '/splashScreen';

  /// On boarding Screen
  static const String onBoardingScreen = '/onBoardingScreen';

  ///Authentication
  //Login
  static const String loginScreen = '/loginScreen';
  static const String otpVerification = '/OTPVerification';
  static const String loginWithBioMetricScreen = '/loginWithBioMetricScreen';
  static const String registerScreen = '/registerScreen';

  static const String kycScreen = '/kycScreen';

  // Forgot Password
  static const String forgotPassword = '/forgotPassword';
  static const String createPassword = '/createPassword';

  /// Dashboard
  static const String dashboard = '/dashboard';

  /// Home
  static const String addMoneyScreen = '/addMoneyScreen';
  static const String payToWalletScreen = '/payToWalletScreen';
  static const String payWithoutQRScreen = '/payWithoutQRScreen';
  static const String qrScreen = '/qrScreen';
  static const String momoTransfer = '/momoTransfer';
  static const String momoTransferSelect = '/momoTransferSelect';
  static const String bankTransfer = '/bankTransfer';
  static const String bankTransferselect = '/bankTransferselect';
  static const String addMobileBenefiaryScreen = '/addMobileBenefiaryScreen';
  static const String airtimeScreen = '/airtimeScreen';
  static const String selectOperatorScreen = '/selectOperatorScreen';
  static const String selectRechargePlanScreen = '/selectRechargePlanScreen';
  static const String rechargeInvoiceScreen = '/rechargeInvoiceScreen';

  ///Profile
  static const String editProfileScreen = '/editProfileScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String basicInfoScreen = '/basicInfoScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String faqScreen = '/faqScreen';
  static const String profileScreen = '/profileScreen';
  static const String depositPaymentScreen = '/depositPaymentScreen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name ?? RouteUtilities.root;

    switch (routeName) {
      case RouteUtilities.root:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SplashScreen(),
          transitionsBuilder: transitionsBuilder,
        );

      case RouteUtilities.splashScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SplashScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.onBoardingScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboaringScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.loginScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder: transitionsBuilder);
      case RouteUtilities.loginWithBioMetricScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginWithBiometricScreen(),
            transitionsBuilder: transitionsBuilder);
      case RouteUtilities.forgotPassword:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ForgotPasswordScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.otpVerification:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OTPVerification(),
            transitionsBuilder: transitionsBuilder);
      case RouteUtilities.profileScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProfileScreen(),
            transitionsBuilder: transitionsBuilder);



      case RouteUtilities.createPassword:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CreatePassword(),
            transitionsBuilder: transitionsBuilder);
      case RouteUtilities.registerScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const RegisterScreen(),
            transitionsBuilder: transitionsBuilder);
      case RouteUtilities.dashboard:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Dashboard(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.addMoneyScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AddMoneyScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.depositPaymentScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const DepositPaymentScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.payToWalletScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PayToWallletScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.payWithoutQRScreen:
        final args = settings.arguments as Map<String, String?>?;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PayWithoutQrScreen(
                countryId: args?['countryId'],
                mobileNumber: args?['mobileNumber'],
              ),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.qrScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
               QrScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.momoTransfer:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MomoTransferScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.momoTransferSelect:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MomoTransferSelectScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.bankTransfer:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const BankTransferScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.basicInfoScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
               const BasicInfoScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.bankTransferselect:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const BankTransferSelectScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.airtimeScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AirtimeScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.selectOperatorScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SelectOperatorScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.selectRechargePlanScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SelectRechargePlanScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.rechargeInvoiceScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const RechargeInvoiceScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.editProfileScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const EditProfileScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.changePasswordScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ChangePasswordScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.aboutUsScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AboutUsScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.contactUsScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ContactUsScreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.faqScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
               FAQSCreen(),
          transitionsBuilder: transitionsBuilder,
        );
      case RouteUtilities.kycScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const KycScreen(),
          transitionsBuilder: transitionsBuilder,
        );
    }
    return null;
  }

  static Widget transitionsBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    var begin = const Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.easeIn;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

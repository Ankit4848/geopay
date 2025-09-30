import 'package:geopay/features/authentication/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:geopay/features/authentication/pages/login/controller/login_controller.dart';
import 'package:geopay/features/authentication/pages/register/controller/register_controller.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:geopay/features/dashboard/controller/dashboard_controller.dart';
import 'package:geopay/features/home/controller/home_controller.dart';
import 'package:geopay/features/home/view/pages/add_money/controller/add_money_controller.dart';
import 'package:geopay/features/home/view/pages/airtime/controller/airtime_controller.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/controller/add_bank_beneficiary_controller.dart';
import 'package:geopay/features/home/view/pages/bank_transfer/controller/bank_transfer_controller.dart';
import 'package:geopay/features/home/view/pages/deposite_payment/controller/deposit_payment_controller.dart';
import 'package:geopay/features/home/view/pages/momo_transfer/controller/momo_transfer_controller.dart';
import 'package:geopay/features/notification_history/controller/notification_history_controller.dart';
import 'package:geopay/features/profile/controller/profile_controller.dart';
import 'package:geopay/features/transaction_history/controller/transaction_history_controller.dart';
import 'package:get/get.dart';

import '../../features/home/view/pages/momo_transfer/controller/add_mobile_beneficiary_controller.dart';
import '../../features/home/view/pages/pay_to_wallet/controller/pay_to_wallet_controller.dart';
import '../../features/kyc/controller/kyc_controller.dart';
import '../../features/onboarding/controller/onboarding_controller.dart';
import '../../features/profile/controller/change_password_controller.dart';
import '../../features/profile/controller/edit_profile_controller.dart';
import '../../features/splash/controller/splash_controller.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<TransactionHistoryController>(
      () => TransactionHistoryController(),
    );
    Get.lazyPut<NotificationHistoryController>(
      () => NotificationHistoryController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AddMoneyController>(
      () => AddMoneyController(),
    );
    Get.lazyPut<DepositPaymentController>(
      () => DepositPaymentController(),
    );
    Get.lazyPut<PayToWalletController>(
      () => PayToWalletController(),
    );
    Get.lazyPut<MomoTransferController>(
      () => MomoTransferController(),
    );
    Get.lazyPut<AddMobileBeneficiaryController>(
      () => AddMobileBeneficiaryController(),
    );
    Get.lazyPut<AirtimeController>(
      () => AirtimeController(),
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(),
    );
    Get.lazyPut<CommonController>(
      () => CommonController(),
    );
    Get.lazyPut<KycController>(
      () => KycController(),
    );
    Get.lazyPut<BankTransferController>(
      () => BankTransferController(),
    );
    Get.lazyPut<AddBankBeneficiaryController>(
      () => AddBankBeneficiaryController(),
    );
  }
}

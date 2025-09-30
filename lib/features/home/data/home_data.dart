import 'package:geopay/config/config.dart';
import 'package:geopay/core/app_assets/asset_images.dart';
import 'package:geopay/core/core.dart';
import 'package:get/get.dart';

import '../model/drop_down_model.dart';
import '../model/home_model.dart';

class HomeData {
  static List<ServiceModel> walletService = [
    ServiceModel(
      gifPath: AssetUtilities.addMoneyGIF,
      title: 'Mobile Money',
      onTap: () {
        Get.toNamed(RouteUtilities.addMoneyScreen);
      },
    ),

    ServiceModel(
      gifPath: AssetUtilities.addMoneyGIF,
      title: 'Deposit Payment',
      onTap: () {
        Get.toNamed(RouteUtilities.depositPaymentScreen);
      },
    ),

    ServiceModel(
      gifPath: AssetUtilities.scanMeGIF,
      title: 'Scan Me',
      onTap: () {
        Get.toNamed(RouteUtilities.qrScreen);
      },
    ),
  ];
  static List<ServiceModel> payOutService = [
    ServiceModel(
      gifPath: AssetUtilities.momoTransaferGIF,
      title: "Mobile\nTransfer's",
      onTap: () {
        Get.toNamed(RouteUtilities.momoTransferSelect);
      },
    ),

    ServiceModel(
      gifPath: AssetUtilities.payToWalletGIF,
      title: 'Geopay to Geopay',
      onTap: () {
        Get.toNamed(RouteUtilities.payToWalletScreen);
      },
    ),

    ServiceModel(
      gifPath: AssetUtilities.airtimeGIF,
      title: 'Airtime',
      onTap: () {
        Get.toNamed(RouteUtilities.airtimeScreen);
      },
    ),
    ServiceModel(
      gifPath: AssetUtilities.bankTransferGIF,
      title: "Bank\nTransfer's",
      onTap: () {
        Get.toNamed(RouteUtilities.bankTransferselect);
      },
    ),
  ];

  static List<String> bannerList = [
    AssetUtilities.banner,
    AssetUtilities.banner,
    AssetUtilities.banner,
    AssetUtilities.banner,
  ];

  static List<String> addMoneyOption = [
    "Visa/Master AMEX Card USD",
    "Mobile Money",
    "Nigeria - Bank Debit"
  ];

  static List<DropDownModel> countryList = [
    DropDownModel(
      icon: AssetUtilities.ivory,
      title: 'Ivory Coast (CI)',
      count: '5',
    ),
    DropDownModel(
      icon: AssetUtilities.senegal,
      title: 'Senegal (SN)',
      count: '2',
    ),
  ];
  static List<DropDownModel> beneficiaryList = [
    DropDownModel(
      icon: AssetUtilities.ivory,
      title: 'Ivory Coast (CI) - Orange - Pritesh Salla',
    ),
    DropDownModel(
      icon: AssetUtilities.senegal,
      title: 'Ivory Coast (CI) - Orange - Pritesh Salla',
    ),
    DropDownModel(
      icon: AssetUtilities.senegal,
      title: 'Ivory Coast (CI) - Orange - Pritesh Salla',
    ),
  ];

  static List<String> operatorList = ['Airtel India', 'Jio India', 'VI India'];
}

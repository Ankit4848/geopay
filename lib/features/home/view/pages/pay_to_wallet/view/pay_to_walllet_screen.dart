import 'package:bounce/bounce.dart';
import 'package:fintech/config/config.dart';
import 'package:fintech/features/home/view/pages/pay_to_wallet/view/QRScanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../core/core.dart';
import '../../add_money/widgets/balance_card.dart';

class PayToWallletScreen extends StatelessWidget {
  const PayToWallletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Geopay to Geopay',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: BalanceCard(),
                  ),
                  Bounce(
                    onTap: () {
                      Get.toNamed(RouteUtilities.payWithoutQRScreen);


                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: VariableUtilities.theme.textFieldFilledColor,
                      ),
                      child: Text(
                        'Without QR-Code',
                        style: FontUtilities.style(
                            fontSize: 12,
                            fontColor: VariableUtilities.theme.blackColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Image.asset(
                      AssetUtilities.redLine,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Bounce(
                    onTap: () async {
                      final status = await Permission.camera.request();
                      if (status.isGranted) {
                        Get.to(() => const QRScanScreen());
                      } else {
                        openAppSettings(); // optional: direct to app settings
                      }


                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AssetUtilities.scanner,
                          height: 150,
                          width: 150,
                        ),
                        SizedBox(height: 15,),
                        Text(
                          'Tap To Scan QR-Code',
                          style: FontUtilities.style(
                              fontSize: 15,
                              fontWeight:FWT.bold,
                              fontColor: VariableUtilities.theme.blackColor),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
